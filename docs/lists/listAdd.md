# List Add

## Description

Add element to list stored at key from DB.

## Usage

```sqf
Arguments:
	0: STRING - Name of stored key (default: "")
	1: [ARRAY|STRING|NUMBER|BOOL] - Value to insert into key (default: [])

Examples:
	["events", ["Server state saved to DB 071620241600"]] call dragonfly_db_fnc_listAdd (Server or Singleplayer Only)
	["events", ["Server state saved to DB 071620241600"]] remoteExecCall ["dragonfly_db_fnc_listAdd", 2, false] (Multiplayer Only)
```

## Links

[List Add](lists/listAdd.md) |
[List Get](lists/listGet.md) |
[List Load](lists/listLoad.md) |
[List Remove](lists/listRemove.md) |
[List Set](lists/listSet.md)
