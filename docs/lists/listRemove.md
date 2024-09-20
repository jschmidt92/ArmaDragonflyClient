# List Remove

## Description

Remove element of list stored at `key` from DragonflyDB.

## Usage

```sqf
Arguments:
	0: STRING - Name of stored key (default: "")
	1: SCALAR - Index of stored value in list (default: -1)

Examples:
	["events", 0] call dragonfly_db_fnc_listRemove (Server or Singleplayer Only)
	["events", 0] remoteExecCall ["dragonfly_db_fnc_listRemove", 2, false] (Multiplayer Only)
```

## Links

[List Add](lists/listAdd.md) |
[List Get](lists/listGet.md) |
[List Load](lists/listLoad.md) |
[List Remove](lists/listRemove.md) |
[List Set](lists/listSet.md)
