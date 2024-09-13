#include "script_component.hpp"

/*
 * Function: dragonfly_db_fnc_hashSet
 * Author: Creedcoder, J.Schmidt
 * Edit: 07.15.2024
 * Copyright © 2024 Creedcoder, J.Schmidt, All rights reserved
 *
 * Do not edit without permission!
 *
 * This work is licensed under the Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License.
 * To view a copy of this license, vist https://creativecommons.org/licenses/by-nc-sa/4.0/ or send a letter to Creative Commons,
 * PO Box 1866, Mountain View, CA 94042
 *
 * [Description]
 * Set value of field in hash stored at key from DB.
 *
 * Arguments:
 * 0: Name of stored field in hash <STRING> (default: "")
 * 1: Value to store in hash field [<ARRAY|STRING|NUMBER|BOOL>] (default: [])
 *
 * Return Value:
 * N/A
 *
 * Examples:
 * ["loadout", [getUnitLoadout player]] call dragonfly_db_fnc_hashSet (Server or Singleplayer Only)
 * ["loadout", [getUnitLoadout player]] remoteExecCall ["dragonfly_db_fnc_hashSet", 2, false] (Multiplayer Only)
 *
 * Public: Yes
 */

params [["_keyField", "", [""]], ["_data", [], [[]]]];

if (_keyField == "" || count _data == 0) exitWith { diag_log text format ["ArmaDragonflyClient: 'dragonfly_db_fnc_hashSet' Invalid Input for KeyField '%1' or Data '%2'", _keyField, _data]; };

"ArmaDragonflyClient" callExtension ["hset", [_keyField, _data]];