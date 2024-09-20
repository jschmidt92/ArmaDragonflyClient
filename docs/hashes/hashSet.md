# Hash Set

## Description

Set the specified field to the respective value in the hash stored at `key` from DragonflyDB.

## Usage

```sqf
Arguments:
	0: STRING - Name of stored field in hash (default: "")
	1: [ARRAY|STRING|NUMBER|BOOL] - Value to store in hash field (default: [])

Examples:
	["loadout", [getUnitLoadout player]] call dragonfly_db_fnc_hashSet (Server or Singleplayer Only)
	["loadout", [getUnitLoadout player]] remoteExecCall ["dragonfly_db_fnc_hashSet", 2, false] (Multiplayer Only)
```

## Links

[Hash Get](hashes/hashGet.md) |
[Hash Get ID](hashes/hashGetId.md) |
[Hash Get All](hashes/hashGetAll.md) |
[Hash Get All ID](hashes/hashGetAllId.md) |
[Hash Set](hashes/hashSet.md) |
[Hash Set ID](hashes/hashSetId.md) |
[Hash Set Bulk](hashes/hashSetBulk.md) |
[Hash Set Bulk ID](hashes/hashSetBulkId.md)
