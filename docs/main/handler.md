# Handler

## Description

Handle data from DB.

## Usage

```sqf
Arguments:
	0: STRING - Name of function to return data (default: "")
	1: BOOLEAN - Unscheduled environment (default: false)
	2: [ARRAY|STRING|NUMBER|BOOL] - Value to store in key (default: [])
	3: STRING - NetID of target to return data from function (default: nil)

Examples:
	["dragonfly_db_fnc_test", false, ["Hello World!"]] call dragonfly_db_fnc_handler (Server or Singleplayer Only)
	["dragonfly_db_fnc_test", false, ["Hello World!"], netId player] remoteExecCall ["dragonfly_db_fnc_handler", 2, false] (Multiplayer Only)
```

## Links

[Add Task](main/addTask.md) |
[Handler](main/handler.md) |
[Init](main/init.md) |
[Process Queue](main/processQueue.md) |
[Scheduler](main/scheduler.md) |
[Setup](main/setup.md)
