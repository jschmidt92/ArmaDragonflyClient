# Add Task

## Description

Add task to queue.

## Usage

```sqf
Arguments:
	0: STRING - Type of task
	1: STRING - Name of stored key (default: "")
	2: STRING - Name of stored hash key field (default: "")
	3: SCALAR - Index of stored value in list (default: -1)
	4: [ARRAY|STRING|NUMBER|BOOL] - Value to store in key (default: [])
	5: STRING - Name of function to return data (default: "")
	6: BOOLEAN - Unscheduled environment (default: false)
	7: STRING - NetID of target to return data from function (default: "")

Examples:
	["hgetall", "", "", -1, [], "dragonfly_db_fnc_test"] call dragonfly_db_fnc_addTask (Server or Singleplayer Only)
	["hgetallid", getPlayerUID player, "", -1, [], "dragonfly_db_fnc_test", false, netId player] remoteExecCall ["dragonfly_db_fnc_addTask", 2, false] (Multiplayer Only)
```

## Links

[Add Task](main/addTask.md) |
[Handler](main/handler.md) |
[Init](main/init.md) |
[Process Queue](main/processQueue.md) |
[Scheduler](main/scheduler.md) |
[Setup](main/setup.md)
