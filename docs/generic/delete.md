# Delete Key

## Description

Delete stored key from DB.

## Usage

```sqf
Arguments:
	0: STRING - Name of stored key from DB.

Examples:
	["test"] call dragonfly_db_fnc_delete (Server or Singleplayer Only)
	["test"] remoteExecCall ["dragonfly_db_fnc_delete", 2, false] (Multiplayer Only)
```

## Links

[Delete Key](generic/delete.md) |
[Get Key](generic/get.md) |
[Set Key](generic/set.md)
