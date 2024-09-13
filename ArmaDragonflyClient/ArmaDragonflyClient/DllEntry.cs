using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Runtime.InteropServices;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Linq;

namespace ArmaDragonflyClient
{
    public class DllEntry
    {
        private const string ADC_Version = "1.0.0";
        public static string ADC_Host = "127.0.0.1";
        public static int ADC_Port = 6379;
        public static string ADC_Password = "xyz123";
        public const int ADC_BufferSize = 1024;
        public static string ADC_LogFolder = "\\@ArmaDragonflyClient\\logs";
        public static bool ADC_Debug = false;
        public static bool ADC_InitCheck = false;
        public static string SteamID = "";
        public static ExtensionCallback callback;
        public delegate int ExtensionCallback(string name, string function, string data);
        public static bool ADC_ContextLog = false;
        public static IntPtr ADC_Context;

        public static void ADC_Init()
        {
            char[] separator = new char[] { '=' };
            string[] commandLineArgs = Environment.GetCommandLineArgs();
            string str = "";

            for (int index = 0; index < commandLineArgs.Length; index++)
            {
                string[] strArray = commandLineArgs[index].Split(separator, StringSplitOptions.RemoveEmptyEntries);
                if (strArray[0].ToLower() == "-adc")
                {
                    str = strArray[1];
                    break;
                }
            }

            if (str == "")
                str = "@ArmaDragonflyClient\\config.xml";

            if (File.Exists(Environment.CurrentDirectory + "\\" + str))
            {
                List<string> strList = new List<string>();
                List<string> list = XElement.Load(Environment.CurrentDirectory + "\\" + str).Elements().Select<XElement, string>((Func<XElement, string>)(eintrag => (string)eintrag)).ToList<string>();
                ADC_Host = list[0];
                ADC_Port = Convert.ToInt32(list[1]);
                ADC_Password = list[2];
                if (bool.TryParse(list[3], out bool res1))
                    ADC_ContextLog = res1;
                if (bool.TryParse(list[4], out bool res2))
                    ADC_Debug = res2;

                Log(string.Format("Config file found! Context Mode: {3}! Debug Mode: {4}! Changed Server Settings to: {0}:{1}:{2}!", (object)ADC_Host, (object)ADC_Port, (object)ADC_Password, (object)ADC_ContextLog, (object)ADC_Debug), "action");
            }
            else
            {
                Log("Config file not found! Default Settings Loaded.", "action");
            }

            ADC_InitCheck = true;
        }

        public static void Log(string msg, string logType)
        {
            if (!ADC_Debug)
                return;
            string logFileName = logType + ".log";
            string path = Environment.CurrentDirectory + ADC_LogFolder;
            if (!Directory.Exists(path))
            {
                Directory.CreateDirectory(path);
            }

            using (StreamWriter streamWriter = new StreamWriter(Path.Combine(path, logFileName), true))
            {
                streamWriter.WriteLine(DateTime.Now.ToString() + " >> " + msg);
            };
        }

        [DllExport("RVExtensionRegisterCallback", CallingConvention = CallingConvention.Winapi)]
        public static void RvExtensionRegisterCallback(ExtensionCallback func)
        {
            callback = func;
        }

        [DllExport("RVExtensionVersion", CallingConvention = CallingConvention.Winapi)]
        public static void RvExtensionVersion(StringBuilder output, int outputSize)
        {
            output.Append(ADC_Version, 0, Math.Min(ADC_Version.Length, outputSize));
        }

        [DllExport("RVExtensionContext", CallingConvention = CallingConvention.Winapi)]
        public static void RVExtensionContext(IntPtr args, int argsCnt)
        {
            if (!ADC_ContextLog || !(ADC_Context != args))
                return;
            ADC_Context = args;
            string[] strArray = new string[argsCnt];
            int size = IntPtr.Size;
            for (int index = 0; index < argsCnt; ++index)
                strArray[index] = Marshal.PtrToStringAnsi(Marshal.ReadIntPtr(args, index * size));
            SteamID = strArray[0].ToString();
            Log($"SteamID: {strArray[0]}", "context");
            Log($"MissionName: {strArray[2]}", "context");
            Log($"ServerName: {strArray[3]}", "context");
        }

        [DllExport("RVExtension", CallingConvention = CallingConvention.Winapi)]
        public static void RvExtension(StringBuilder output, int outputSize, string function)
        {
            if (!ADC_InitCheck)
                ADC_Init();

            switch (function.ToLower())
            {
                case "time":
                    DateTime timeNow = DateTime.Now;
                    int day = timeNow.Day;
                    int month = timeNow.Month;
                    int year = timeNow.Year;
                    int hour = timeNow.Hour;
                    int minute = timeNow.Minute;
                    int second = timeNow.Second;
                    output.Append(day.ToString() + ":" + month.ToString() + ":" + year.ToString() + ":" + hour.ToString() + ":" + minute.ToString() + ":" + second.ToString());
                    break;
                default:
                    output.Append(function);
                    break;
            }
        }

        [DllExport("RVExtensionArgs", CallingConvention = CallingConvention.Winapi)]
        public static int RVExtensionArgs(StringBuilder output, int outputSize, string function, IntPtr args, int argsCnt)
        {
            string[] argsArr = new string[argsCnt];
            int argsSize = IntPtr.Size;
            long _id = Utils.GetUniqueId();

            for (int index = 0; index < argsCnt; ++index)
            {
                argsArr[index] = Marshal.PtrToStringAnsi(Marshal.ReadIntPtr(args, index * argsSize));
            }

            if (!ADC_InitCheck)
                ADC_Init();

            switch (function)
            {
                case "fnc1":
                    List<string> list1 = argsArr.ToList();
                    var array1 = list1.Any()
                        ? $"[{string.Join(",", list1.Select(e => e.StartsWith("[") ? e : $"\"{e}\""))}]"
                        : "";
                    output.Append(array1.ToString());
                    return 100;
                case "fnc2":
                    Task.Run(async () =>
                    {
                        await DragonflyDB.DragonflyRaw(argsArr[0].Trim('"'), argsArr[1].Trim('"'), argsArr[2].Trim('"'));
                    });
                    return 200;
                case "fnc3":
                    List<string> list2 = argsArr.ToList();
                    var array2 = list2.Any()
                        ? $"[{string.Join(",", list2.Select(e => e.StartsWith("[") ? e : $"\"{e}\""))}]"
                        : "";
                    output.Append("Async");
                    callback("ArmaDragonflyClient", function, array2.ToString());
                    return 100;
                case "fetch":
                    output.Append("Async");
                    Task.Run(async () =>
                    {
                        await DragonflyDB.DragonflyFetchAsync(SteamID, argsArr[0].Trim('"'), argsArr[1].Trim('"'));
                    });
                    return 200;
                case "fetchid":
                    output.Append("Async");
                    Task.Run(async () =>
                    {
                        await DragonflyDB.DragonflyFetchAsync(argsArr[0].Trim('"'), argsArr[1].Trim('"'), argsArr[2].Trim('"'));
                    });
                    return 200;
                case "get":
                    Task.Run(async () =>
                    {
                        string _uniqueID = $"{_id}_get";
                        if (argsCnt == 2)
                            await DragonflyDB.DragonflyGetAsync(argsArr[0].Trim('"'), argsArr[1].Trim('"'), _uniqueID);
                        if (argsCnt == 3)
                            await DragonflyDB.DragonflyGetAsync(argsArr[0].Trim('"'), argsArr[1].Trim('"'), _uniqueID, argsArr[2].Trim('"'));
                        if (argsCnt == 4)
                            await DragonflyDB.DragonflyGetAsync(argsArr[0].Trim('"'), argsArr[1].Trim('"'), _uniqueID, argsArr[2].Trim('"'), argsArr[3].Trim('"'));
                    });
                    output.Append($"[\"{_id}_get\",{argsArr[1]}]");
                    return 100;
                case "set":
                    output.Append("Async");
                    Task.Run(async () =>
                    {
                        await DragonflyDB.DragonflySetAsync(argsArr[0].Trim('"'), argsArr[1]);
                    });
                    return 200;
                case "del":
                    output.Append("Async");
                    Task.Run(async () =>
                    {
                        await DragonflyDB.DragonflyDeleteAsync(argsArr[0].Trim('"'));
                    });
                    return 200;
                case "listadd":
                    output.Append("Async");
                    Task.Run(async () =>
                    {
                        if (argsCnt > 2)
                        {
                            for (var i = 0; i < argsCnt; i++)
                            {
                                await DragonflyDB.DragonflyListAddAsync(argsArr[0].Trim('"'), argsArr[i]);
                            }
                        }
                        else
                        {
                            await DragonflyDB.DragonflyListAddAsync(argsArr[0].Trim('"'), argsArr[1]);
                        }
                    });
                    return 200;
                case "listidx":
                    Task.Run(async () =>
                    {
                        string _uniqueID = $"{_id}_listidx";
                        if (argsCnt == 3)
                            await DragonflyDB.DragonflyListIndexAsync(argsArr[0].Trim('"'), argsArr[1].Trim('"'), argsArr[2].Trim('"'), _uniqueID);
                        if (argsCnt == 4)
                            await DragonflyDB.DragonflyListIndexAsync(argsArr[0].Trim('"'), argsArr[1].Trim('"'), argsArr[2].Trim('"'), _uniqueID, argsArr[3].Trim('"'));
                        if (argsCnt == 5)
                            await DragonflyDB.DragonflyListIndexAsync(argsArr[0].Trim('"'), argsArr[1].Trim('"'), argsArr[2].Trim('"'), _uniqueID, argsArr[3].Trim('"'), argsArr[4].Trim('"'));
                    });
                    output.Append($"[\"{_id}_listidx\",{argsArr[2]}]");
                    return 100;
                case "listlen":
                    Task.Run(async () =>
                    {
                        string _uniqueID = $"{_id}_listlen";
                        await DragonflyDB.DragonflyListLengthAsync(argsArr[0].Trim('"'), argsArr[1].Trim('"'), _uniqueID);
                    });
                    output.Append("Async");
                    return 100;
                case "listrng":
                    Task.Run(async () =>
                    {
                        string _uniqueID = $"{_id}_listrng";
                        if (argsCnt == 4)
                            await DragonflyDB.DragonflyListRangeAsync(argsArr[0].Trim('"'), argsArr[1].Trim('"'), argsArr[2].Trim('"'), argsArr[3].Trim('"'), _uniqueID);
                        if (argsCnt == 5)
                            await DragonflyDB.DragonflyListRangeAsync(argsArr[0].Trim('"'), argsArr[1].Trim('"'), argsArr[2].Trim('"'), argsArr[3].Trim('"'), _uniqueID, argsArr[4].Trim('"'));
                        if (argsCnt == 6)
                            await DragonflyDB.DragonflyListRangeAsync(argsArr[0].Trim('"'), argsArr[1].Trim('"'), argsArr[2].Trim('"'), argsArr[3].Trim('"'), _uniqueID, argsArr[4].Trim('"'), argsArr[5].Trim('"'));
                    });
                    output.Append($"[\"{_id}_listrng\",{argsArr[3]}]");
                    return 100;
                case "listrem":
                    output.Append("Async");
                    Task.Run(async () =>
                    {
                        await DragonflyDB.DragonflyListRemoveAsync(argsArr[0].Trim('"'), argsArr[1].Trim('"'));
                    });
                    return 200;
                case "listset":
                    output.Append("Async");
                    Task.Run(async () =>
                    {
                        await DragonflyDB.DragonflyListSetAsync(argsArr[0].Trim('"'), argsArr[1].Trim('"'), argsArr[2]);
                    });
                    return 200;
                case "hset":
                    output.Append("Async");
                    Task.Run(async () =>
                    {
                        if (argsCnt > 2)
                        {
                            for (var i = 0; i < argsCnt; i += 2)
                            {
                                await DragonflyDB.DragonflyHashSetAsync(SteamID, argsArr[i].Trim('"'), argsArr[i + 1]);
                            }
                        }
                        else
                        {
                            await DragonflyDB.DragonflyHashSetAsync(SteamID, argsArr[0].Trim('"'), argsArr[1]);
                        }
                    });
                    return 200;
                case "hsetid":
                    output.Append("Async");
                    Task.Run(async () =>
                    {
                        if (argsCnt > 4)
                        {
                            for (var i = 1; i < argsCnt; i += 2)
                            {
                                await DragonflyDB.DragonflyHashSetAsync(argsArr[0].Trim('"'), argsArr[i].Trim('"'), argsArr[i + 1]);
                            }
                        }
                        else
                        {
                            await DragonflyDB.DragonflyHashSetAsync(argsArr[0].Trim('"'), argsArr[1].Trim('"'), argsArr[2]);
                        }
                    });
                    return 200;
                case "hget":
                    Task.Run(async () =>
                    {
                        string _uniqueID = $"{_id}_hget";
                        if (argsCnt == 2)
                            await DragonflyDB.DragonflyHashGetAsync(SteamID, argsArr[0].Trim('"'), argsArr[1].Trim('"'), _uniqueID);
                        if (argsCnt == 3)
                            await DragonflyDB.DragonflyHashGetAsync(SteamID, argsArr[0].Trim('"'), argsArr[1].Trim('"'), _uniqueID, argsArr[2].Trim('"'));
                        if (argsCnt == 4)
                            await DragonflyDB.DragonflyHashGetAsync(SteamID, argsArr[0].Trim('"'), argsArr[1].Trim('"'), _uniqueID, argsArr[2].Trim('"'), argsArr[3].Trim('"'));
                    });
                    output.Append($"[\"{_id}_hget\",{argsArr[1]}]");
                    return 100;
                case "hgetid":
                    Task.Run(async () =>
                    {
                        string _uniqueID = $"{_id}_hgetid";
                        if (argsCnt == 3)
                            await DragonflyDB.DragonflyHashGetAsync(argsArr[0].Trim('"'), argsArr[1].Trim('"'), argsArr[2].Trim('"'), _uniqueID);
                        if (argsCnt == 4)
                            await DragonflyDB.DragonflyHashGetAsync(argsArr[0].Trim('"'), argsArr[1].Trim('"'), argsArr[2].Trim('"'), _uniqueID, argsArr[3].Trim('"'));
                        if (argsCnt == 5)
                            await DragonflyDB.DragonflyHashGetAsync(argsArr[0].Trim('"'), argsArr[1].Trim('"'), argsArr[2].Trim('"'), _uniqueID, argsArr[3].Trim('"'), argsArr[4].Trim('"'));
                    });
                    output.Append($"[\"{_id}_hgetid\",{argsArr[2]}]");
                    return 100;
                case "hgetall":
                    Task.Run(async () =>
                    {
                        string _uniqueID = $"{_id}_hgetall";
                        if (argsCnt == 1)
                            await DragonflyDB.DragonflyHashGetAllAsync(SteamID, argsArr[0].Trim('"'), _uniqueID);
                        if (argsCnt == 2)
                            await DragonflyDB.DragonflyHashGetAllAsync(SteamID, argsArr[0].Trim('"'), _uniqueID, argsArr[1].Trim('"'));
                        if (argsCnt == 3)
                            await DragonflyDB.DragonflyHashGetAllAsync(SteamID, argsArr[0].Trim('"'), _uniqueID, argsArr[1].Trim('"'), argsArr[2].Trim('"'));
                    });
                    output.Append($"[\"{_id}_hgetall\",{argsArr[0]}]");
                    return 100;
                case "hgetallid":
                    Task.Run(async () =>
                    {
                        string _uniqueID = $"{_id}_hgetallid";
                        if (argsCnt == 2)
                            await DragonflyDB.DragonflyHashGetAllAsync(argsArr[0].Trim('"'), argsArr[1].Trim('"'), _uniqueID);
                        if (argsCnt == 3)
                            await DragonflyDB.DragonflyHashGetAllAsync(argsArr[0].Trim('"'), argsArr[1].Trim('"'), _uniqueID, argsArr[2].Trim('"'));
                        if (argsCnt == 4)
                            await DragonflyDB.DragonflyHashGetAllAsync(argsArr[0].Trim('"'), argsArr[1].Trim('"'), _uniqueID, argsArr[2].Trim('"'), argsArr[3].Trim('"'));
                    });
                    output.Append($"[\"{_id}_hgetallid\",{argsArr[1]}]");
                    return 100;
                case "hdel":
                    output.Append("Async");
                    Task.Run(async () =>
                    {
                        await DragonflyDB.DragonflyHashDeleteAsync(SteamID, argsArr[0].Trim('"'));
                    });
                    return 200;
                case "hdelid":
                    output.Append("Async");
                    Task.Run(async () =>
                    {
                        await DragonflyDB.DragonflyHashDeleteAsync(argsArr[0].Trim('"'), argsArr[1].Trim('"'));
                    });
                    return 200;
                case "version":
                    output.Append(ADC_Version);
                    return 100;
                default:
                    output.Append("Available Functions: fnc1, fnc2, fnc3, fetch, get, set, del, listadd, listidx, listrem, listrng, hset, hsetid, hget, hgetid, hgetall, hgetallid, hdel, hdelid, save, version");
                    return -1;
            }
        }
    }
}
