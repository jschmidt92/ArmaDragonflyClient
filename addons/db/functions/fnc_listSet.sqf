#include "script_component.hpp"

/*
 * Function: dragonfly_db_fnc_listSet
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
 * Set element of list stored at key from DB.
 *
 * Arguments:
 * 0: Name of stored key <STRING> (default: "")
 * 1: Index of stored value in list <NUMBER> (default: -1)
 * 2: Value to set for index [<ARRAY|STRING|NUMBER|BOOL>] (default: [])
 *
 * Return Value:
 * N/A
 *
 * Examples:
 * ["events", 0, "Hello World!"] call dragonfly_db_fnc_listSet (Server or Singleplayer Only)
 * ["events", 0, "Hello World!"] remoteExecCall ["dragonfly_db_fnc_listSet", 2, false] (Multiplayer Only)
 *
 * Public: Yes
 */

params [["_key", "", [""]], ["_index", -1, [0]], ["_data", [], [[]]]];

if (_key == "" || count _data == 0) exitWith { diag_log text format ["ArmaDragonflyClient: 'dragonfly_db_fnc_listSet' Invalid Input for Key '%1' or Data '%2'", _key, _data]; };

"ArmaDragonflyClient" callExtension ["listset", [_key, _index, _data]];