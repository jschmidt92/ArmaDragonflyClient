# List Set

## Description

Set element of list stored at `key` from DragonflyDB.

## Usage

```sqf
Arguments:
	0: STRING - Name of stored key (default: "")
	1: SCALAR - Index of stored value in list (default: -1)
	2: [ARRAY|STRING|NUMBER|BOOL] - Value to set for index (default: [])

Examples:
	["events", 0, ["Hello World!"]] call dragonfly_db_fnc_listSet (Server or Singleplayer Only)
	["events", 0, ["Hello World!"]] remoteExecCall ["dragonfly_db_fnc_listSet", 2, false] (Multiplayer Only)
```

## Links

[List Add](lists/listAdd.md) |
[List Get](lists/listGet.md) |
[List Load](lists/listLoad.md) |
[List Remove](lists/listRemove.md) |
[List Set](lists/listSet.md)
