# Setup

## Description

Setup Extension to communicate with DB.

## Usage

```sqf
Arguments:
	0: STRING - Name host (default: "localhost")
	1: SCALAR - Port of host (default: 6379)
	2: STRING - Password of host (default: "xyz123")

Examples:
	["localhost", 6379, "xyz123"] call dragonfly_db_fnc_setup (Server or Singleplayer Only)
	["localhost", 6379, "xyz123"] remoteExecCall ["dragonfly_db_fnc_setup", 2, false] (Multiplayer Only)
```

## Links

[Add Task](main/addTask.md) |
[Handler](main/handler.md) |
[Init](main/init.md) |
[Process Queue](main/processQueue.md) |
[Scheduler](main/scheduler.md) |
[Setup](main/setup.md)
