# List Get

## Description

Get element of list stored at key from DB.

## Usage

```sqf
Arguments:
	0: STRING - Name of stored key (default: "")
	1: SCALAR - Index of stored value in list (default: -1)
	2: STRING - Name of function to return data (default: "")
	3: BOOLEAN - Unscheduled environment (default: false)
	4: STRING - NetID of target to return data from function (default: nil)

Examples:
	["events", 0, "dragonfly_db_fnc_test"] call dragonfly_db_fnc_listGet (Server or Singleplayer Only)
	["events", 0, "dragonfly_db_fnc_test", false, netId player] remoteExecCall ["dragonfly_db_fnc_listGet", 2, false] (Multiplayer Only)
```

## Links

[List Add](lists/listAdd.md) |
[List Get](lists/listGet.md) |
[List Load](lists/listLoad.md) |
[List Remove](lists/listRemove.md) |
[List Set](lists/listSet.md)
