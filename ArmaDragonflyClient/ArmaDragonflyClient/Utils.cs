using System;
using System.Collections.Generic;
using System.Text;

namespace ArmaDragonflyClient
{
    internal class Utils
    {
        public static string Base64Decode(string encodedString)
        {
            byte[] data = Convert.FromBase64String(encodedString);
            return Encoding.UTF8.GetString(data);
        }

        public static string Base64Encode(string plainText)
        {
            byte[] data = Encoding.UTF8.GetBytes(plainText);
            return Convert.ToBase64String(data);
        }

        public static string BuildArray(string text)
        {
            string str = $"[\"{text}\"]";
            return str;
        }

        public static List<string> SplitIntoChunks(string data, int chunkSize)
        {
            int chunksNeeded = (int)Math.Ceiling((double)data.Length / chunkSize);
            List<string> chunks = new List<string>();

            for (int i = 0; i < chunksNeeded; i++)
            {
                int start = i * chunkSize;
                int end = Math.Min(data.Length, start + chunkSize);
                chunks.Add(data.Substring(start, end - start));
            }

            return chunks;
        }

        public static long GetUniqueId()
        {
            return DateTimeOffset.Now.ToUnixTimeMilliseconds();
        }

        public static void CheckByteCount(string uniqueId, string data, string function, string entity, bool call, int bufferSize)
        {
            if (Encoding.UTF8.GetByteCount(data) <= bufferSize)
            {
                if (!data.StartsWith("["))
                    data = BuildArray(data);
                DllEntry.Log($"{data}", "debug");

                if (entity == null)
                {
                    string dataAsString = $"[\"{uniqueId}\",\"{function}\",{call},{data}]";
                    DllEntry.Log($"{dataAsString}", "debug");
                    DllEntry.callback("ArmaDragonflyClient", "dragonfly_db_fnc_handler", dataAsString);
                }
                else
                {
                    string dataAsString = $"[\"{uniqueId}\",\"{function}\",{call},{data},\"{entity}\"]";
                    DllEntry.Log($"{dataAsString}", "debug");
                    DllEntry.callback("ArmaDragonflyClient", "dragonfly_db_fnc_handler", dataAsString);
                };
            }
            else
            {
                if (!data.StartsWith("["))
                    data = BuildArray(data);
                DllEntry.Log($"{data}", "debug");
                var chunks = SplitIntoChunks(data, bufferSize);
                int totalChunks = chunks.Count;

                foreach (string chunk in chunks)
                {
                    string chunkAsString = $"[{uniqueId},{function},{chunks.IndexOf(chunk)},{totalChunks},\"{chunk}\"]";
                    DllEntry.callback("ArmaDragonflyClient", "dragonfly_db_fnc_fetch", chunkAsString);
                }
            }
        }
    }
}