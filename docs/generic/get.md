# Get Key

## Description

Get the value of stored `key` from DragonflyDB.

## Usage

```sqf
Arguments:
	0: STRING - Name of stored Key
	1: STRING - Name of function to return data (default: "")
	2: BOOLEAN - Unscheduled environment (default: false)
	3: STRING - NetID of target to return data from function (default: nil)

Examples:
	["test", "dragonfly_db_fnc_test"] call dragonfly_db_fnc_get (Server or Singleplayer Only)
	["test", "dragonfly_db_fnc_test", false, netId player] remoteExecCall ["dragonfly_db_fnc_get", 2, false] (Multiplayer Only)
```

## Links

[Delete Key](generic/delete.md) |
[Get Key](generic/get.md) |
[Set Key](generic/set.md)
