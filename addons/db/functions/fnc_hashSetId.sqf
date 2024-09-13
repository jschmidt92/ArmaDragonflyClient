#include "script_component.hpp"

/*
 * Function: dragonfly_db_fnc_hashSetId
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
 * 0: Name of stored key with hash <STRING> (default: "")
 * 1: Name of stored hash key field <STRING> (default: "")
 * 2: Value to store in hash field [<ARRAY|STRING|NUMBER|BOOL>] (default: [])
 *
 * Return Value:
 * N/A
 *
 * Examples:
 * [getPlayerUID player, "loadout", []] call dragonfly_db_fnc_hashSetId (Server or Singleplayer Only)
 * [getPlayerUID player, "loadout", []] remoteExecCall ["dragonfly_db_fnc_hashSetId", 2, false] (Multiplayer Only)
 *
 * Public: Yes
 */

params [["_key", "", [""]], ["_keyField", "", [""]], ["_data", [], [[]]]];

if (_key == "" || _keyField == "" || count _data == 0) exitWith { diag_log text format ["ArmaDragonflyClient: 'dragonfly_db_fnc_hashSetId' Invalid Input for Key '%1', KeyField '%2' or Data '%3'", _key, _keyField, _data]; };

"ArmaDragonflyClient" callExtension ["hsetid", [_key, _keyField, _data]];