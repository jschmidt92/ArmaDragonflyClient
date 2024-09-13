# Set Key

## Description

Set value of stored key from DB.

## Usage

```sqf
Arguments:
	0: STRING - Name of stored Key
	1: [ARRAY|STRING|NUMBER|BOOL] - Value to store in key (default: [])

Examples:
	["test", ["Hello World!"]] call dragonfly_db_fnc_set (Server or Singleplayer Only)
	["test", ["Hello World!"]] remoteExecCall ["dragonfly_db_fnc_set", 2, false] (Multiplayer Only)
```

## Links

[Delete Key](generic/delete.md) |
[Get Key](generic/get.md) |
[Set Key](generic/set.md)
