# Hash Get All ID

## Description

Get all fields and values from hash stored at key from DB.

## Usage

```sqf
Arguments:
	0: STRING - Name of stored key with hash (default: "")
	1: STRING - Name of function to return data (default: "")
	2: BOOLEAN - Unscheduled environment (default: false)
	3: STRING - NetID of target to return data from function (default: nil)

Examples:
	[getPlayerUID player, "dragonfly_db_fnc_test"] call dragonfly_db_fnc_hashGetAllId (Server or Singleplayer Only)
	[getPlayerUID player, "dragonfly_db_fnc_test", false, netId player] remoteExecCall ["dragonfly_db_fnc_hashGetAllId", 2, false] (Multiplayer Only)
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
