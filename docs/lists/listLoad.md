# List Load

## Description

Get all elements of list stored at `key` from DragonflyDB.

## Usage

```sqf
Arguments:
	0: STRING - Name of stored key (default: "")
	1: STRING - Name of function to return data (default: "")
	2: BOOLEAN - Unscheduled environment (default: false)
	3: STRING - NetID of target to return data from function (default: nil)

Examples:
	["events", "dragonfly_db_fnc_test"] call dragonfly_db_fnc_listLoad (Server or Singleplayer Only)
	["events", "dragonfly_db_fnc_test", false, netId player] remoteExecCall ["dragonfly_db_fnc_listLoad", 2, false] (Multiplayer Only)
```

## Links

[List Add](lists/listAdd.md) |
[List Get](lists/listGet.md) |
[List Load](lists/listLoad.md) |
[List Remove](lists/listRemove.md) |
[List Set](lists/listSet.md)
