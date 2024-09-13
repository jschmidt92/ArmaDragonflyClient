# Hash Set ID

## Description

Set value of field in hash stored at key from DB.

## Usage

```sqf
Arguments:
	0: STRING - Name of stored key with hash (default: "")
	1: STRING - Name of stored field in hash (default: "")
	2: [ARRAY|STRING|NUMBER|BOOL] - Value to store in hash field (default: [])

Examples:
	[getPlayerUID player, "loadout", [getUnitLoadout player]] call dragonfly_db_fnc_hashSetId (Server or Singleplayer Only)
	[getPlayerUID player, "loadout", [getUnitLoadout player]] remoteExecCall ["dragonfly_db_fnc_hashSetId", 2, false] (Multiplayer Only)
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
