# Hash Set Bulk ID

## Description

Set the specified fields to their respective values in the hash stored at `key` from DragonflyDB.

## Usage

```sqf
Arguments:
	0: [ARRAY|STRING|NUMBER|BOOL] - Fields and Values to store in hash (default: [])

Examples:
	[getPlayerUID player, "loadout", [getUnitLoadout player], "position", [getPosASLVisual player]] call dragonfly_db_fnc_hashSetBulk (Server or Singleplayer Only)
	[getPlayerUID player, "loadout", [getUnitLoadout player], "position", [getPosASLVisual player]] remoteExecCall ["dragonfly_db_fnc_hashSetBulk", 2, false] (Multiplayer Only)
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
