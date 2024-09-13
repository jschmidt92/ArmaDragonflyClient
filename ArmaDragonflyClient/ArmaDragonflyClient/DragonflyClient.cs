using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net.Sockets;
using System.Text;
using System.Threading.Tasks;

namespace ArmaDragonflyClient
{
    internal class DragonflyClient
    {
        private readonly TcpClient _client = new TcpClient();
        private StreamReader _reader;
        private StreamWriter _writer;

        private readonly string _host;
        private readonly int _port;
        private readonly string _password;

        public DragonflyClient(string host, int port, string password)
        {
            _host = host;
            _port = port;
            _password = password;
        }

        public async Task ConnectAsync()
        {
            if (!_client.Connected)
            {
                await _client.ConnectAsync(_host, _port);
                _reader = new StreamReader(_client.GetStream(), Encoding.ASCII);
                _writer = new StreamWriter(_client.GetStream(), Encoding.ASCII) { AutoFlush = true };

                if (!string.IsNullOrEmpty(_password))
                {
                    if (await SendCommandAsync($"AUTH {_password}") != "OK")
                        throw new InvalidOperationException("Invalid password provided.");
                }

                DllEntry.Log("Connected to DragonflyDB.", "debug");
            }
        }

        public async Task<string> SendCommandAsync(string command, bool convertFromBase64 = false)
        {
            if (_client == null || !_client.Connected)
                await ConnectAsync();

            await _writer.WriteLineAsync(command);
            return ParseResponse(await _reader.ReadLineAsync(), _reader, convertFromBase64);
        }

        private string ParseResponse(string response, StreamReader reader, bool convertFromBase64 = false)
        {
            switch (response[0])
            {
                case '$':
                    int count = int.Parse(response.Substring(1));
                    if (count == -1)
                        return null;

                    char[] buffer = new char[count];
                    reader.Read(buffer, 0, count);
                    reader.ReadLine();
                    return new string(buffer);

                case '*':
                    int arrayLength = int.Parse(response.Substring(1));
                    if (arrayLength == -1) return null;

                    var elements = new List<string>();
                    for (int i = 0; i < arrayLength; i++)
                    {
                        string element = ParseResponse(reader.ReadLine(), reader, convertFromBase64);

                        if (convertFromBase64)
                        {
                            byte[] data = Convert.FromBase64String(element);
                            string originalString = Encoding.UTF8.GetString(data);
                            elements.Add(originalString);
                        }
                        else
                        {
                            elements.Add(element);
                        }
                    }

                    var output = elements.Count > 0
                        ? $"[{string.Join(",", elements.Select(e => e.StartsWith("[") ? e : $"\"{e}\""))}]"
                        : "";
                    return output;

                case '+':
                case '-':
                    return response.Substring(1);

                case ':':
                    return response.Substring(1).Trim();

                default:
                    throw new NotSupportedException($"Unsupported response type: {response}");
            }
        }

        public void Disconnect()
        {
            _writer.Close();
            _writer.Dispose();
            _reader.Close();
            _reader.Dispose();
            _client.Close();
            _client.Dispose();

            DllEntry.Log("Disconnected from DragonflyDB.", "debug");
        }
    }
}