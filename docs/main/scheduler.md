# Scheduler

## Description

Scheduled Environment for extension.

## Usage

```sqf
Arguments:
	0: STRING - Task ID from extension (default: "")

Examples:
	["071620241600_get"] call dragonfly_db_fnc_scheduler (Server or Singleplayer Only)
	["071620241600_get"] remoteExecCall ["dragonfly_db_fnc_scheduler", 2, false] (Multiplayer Only)
```

## Links

[Add Task](main/addTask.md) |
[Handler](main/handler.md) |
[Init](main/init.md) |
[Process Queue](main/processQueue.md) |
[Scheduler](main/scheduler.md) |
[Setup](main/setup.md)
