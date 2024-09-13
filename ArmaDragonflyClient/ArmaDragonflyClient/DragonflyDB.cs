using System;
using System.Threading.Tasks;

namespace ArmaDragonflyClient
{
    internal class DragonflyDB
    {
        private readonly static DragonflyClient _client = new DragonflyClient(DllEntry.ADC_Host, DllEntry.ADC_Port, DllEntry.ADC_Password);

        public static async Task<string> DragonflyRaw(string key, string keyValue, string function = null)
        {
            await _client.ConnectAsync();
            await _client.SendCommandAsync($"SET {key} {keyValue}");
            string response = await _client.SendCommandAsync($"GET {key}");
            if (!string.IsNullOrEmpty(function))
                DllEntry.callback("ArmaDragonflyClient", function, response);
            return response;
        }

        public static async Task DragonflyGetAsync(string key, string function, string uniqueID, string entity = null, string call = "false", int bufferSize = DllEntry.ADC_BufferSize)
        {
            if (string.IsNullOrEmpty(key) || string.IsNullOrEmpty(function))
            {
                DllEntry.callback("ArmaDragonflyClient", "BIS_fnc_guiMessage", $"[\"key or function cannot be empty\",\"ERROR\"]");
            }

            await _client.ConnectAsync();

            string data = await _client.SendCommandAsync($"GET {key}");

            Utils.CheckByteCount(uniqueID, data, function, entity, Convert.ToBoolean(call), bufferSize);
        }

        public static async Task DragonflySetAsync(string key, string keyValue)
        {
            await _client.ConnectAsync();
            await _client.SendCommandAsync($"SET {key} {keyValue}");
        }

        public static async Task DragonflyDeleteAsync(string key)
        {
            await _client.ConnectAsync();
            await _client.SendCommandAsync($"DEL {key}");
        }

        public static async Task DragonflyListAddAsync(string key, string keyValue)
        {
            await _client.ConnectAsync();
            await _client.SendCommandAsync($"RPUSH {key} {Utils.Base64Encode(keyValue)}");
        }

        public static async Task DragonflyListIndexAsync(string key, string keyIndex, string function, string uniqueID, string entity = null, string call = "false", int bufferSize = DllEntry.ADC_BufferSize)
        {
            if (string.IsNullOrEmpty(key) || string.IsNullOrEmpty(keyIndex) || string.IsNullOrEmpty(function))
            {
                DllEntry.callback("ArmaDragonflyClient", "BIS_fnc_guiMessage", $"[\"key, keyIndex or function cannot be empty\",\"ERROR\"]");
            }

            await _client.ConnectAsync();

            string data = await _client.SendCommandAsync($"LINDEX {key} {keyIndex}", true);
            string decodedData = Utils.Base64Decode(data);

            Utils.CheckByteCount(uniqueID, decodedData, function, entity, Convert.ToBoolean(call), bufferSize);
        }

        public static async Task DragonflyListLengthAsync(string key, string function, string uniqueID, string entity = null, string call = "false", int bufferSize = DllEntry.ADC_BufferSize)
        {
            if (string.IsNullOrEmpty(key) || string.IsNullOrEmpty(function))
            {
                DllEntry.callback("ArmaDragonflyClient", "BIS_fnc_guiMessage", $"[\"key or function cannot be empty\",\"ERROR\"]");
                return;
            }

            await _client.ConnectAsync();

            string data = await _client.SendCommandAsync($"LLEN {key}");

            Utils.CheckByteCount(uniqueID, data, function, entity, Convert.ToBoolean(call), bufferSize);
        }

        public static async Task DragonflyListRangeAsync(string key, string keyStart, string keyStop, string function, string uniqueID, string entity = null, string call = "false", int bufferSize = DllEntry.ADC_BufferSize)
        {
            if (string.IsNullOrEmpty(key) || string.IsNullOrEmpty(keyStart) || string.IsNullOrEmpty(keyStop) || string.IsNullOrEmpty(function))
            {
                DllEntry.callback("ArmaDragonflyClient", "BIS_fnc_guiMessage", $"[\"key, keyStart, keyStop or function cannot be empty\",\"ERROR\"]");
            }

            await _client.ConnectAsync();

            string data = await _client.SendCommandAsync($"LRANGE {key} {keyStart} {keyStop}", true);

            Utils.CheckByteCount(uniqueID, data, function, entity, Convert.ToBoolean(call), bufferSize);
        }

        public static async Task DragonflyListRemoveAsync(string key, string keyIndex)
        {
            await _client.ConnectAsync();
            await _client.SendCommandAsync($"LSET {key} {keyIndex} DRAGONFLYREMOVE");
            await _client.SendCommandAsync($"LREM {key} 0 DRAGONFLYREMOVE");
        }

        public static async Task DragonflyListSetAsync(string key, string keyIndex, string keyValue)
        {
            await _client.ConnectAsync();
            await _client.SendCommandAsync($"LSET {key} {keyIndex} {Utils.Base64Encode(keyValue)}");
        }

        public static async Task DragonflyHashSetAsync(string key, string keyField, string keyValue)
        {
            await _client.ConnectAsync();
            await _client.SendCommandAsync($"HSET {key} {keyField} {keyValue}");
        }

        public static async Task DragonflyHashGetAsync(string key, string keyField, string function, string uniqueID, string entity = null, string call = "false", int bufferSize = DllEntry.ADC_BufferSize)
        {
            if (string.IsNullOrEmpty(key) || string.IsNullOrEmpty(keyField) || string.IsNullOrEmpty(function))
            {
                DllEntry.callback("ArmaDragonflyClient", "BIS_fnc_guiMessage", $"[\"key, keyField or function cannot be empty\",\"ERROR\"]");
            }

            await _client.ConnectAsync();

            string data = await _client.SendCommandAsync($"HGET {key} {keyField}");

            Utils.CheckByteCount(uniqueID, data, function, entity, Convert.ToBoolean(call), bufferSize);
        }

        public static async Task DragonflyHashGetAllAsync(string key, string function, string uniqueID, string entity = null, string call = "false", int bufferSize = DllEntry.ADC_BufferSize)
        {
            if (string.IsNullOrEmpty(key) || string.IsNullOrEmpty(function))
            {
                DllEntry.callback("ArmaDragonflyClient", "BIS_fnc_guiMessage", $"[\"key, keyField or function cannot be empty\", \"ERROR\"]");
            }

            await _client.ConnectAsync();

            string data = await _client.SendCommandAsync($"HGETALL {key}");

            Utils.CheckByteCount(uniqueID, data, function, entity, Convert.ToBoolean(call), bufferSize);
        }

        public static async Task DragonflyHashDeleteAsync(string key, string keyField)
        {
            await _client.ConnectAsync();
            await _client.SendCommandAsync($"HDEL {key} {keyField}");
        }

        public static async Task DragonflyFetchAsync(string key, string keyType, string function, string entity = null, string call = "false", int bufferSize = DllEntry.ADC_BufferSize)
        {
            if (string.IsNullOrEmpty(key) || string.IsNullOrEmpty(keyType) || string.IsNullOrEmpty(function))
            {
                DllEntry.callback("ArmaDragonflyClient", "BIS_fnc_guiMessage", $"[\"key, keyField or function cannot be empty\", \"ERROR\"]");
                return;
            }

            await _client.ConnectAsync();

            string data = await _client.SendCommandAsync($"GET {key}");
            string uniqueId = Utils.GetUniqueId().ToString();

            Utils.CheckByteCount(uniqueId, data, function, entity, Convert.ToBoolean(call), bufferSize);
        }
    }
}
