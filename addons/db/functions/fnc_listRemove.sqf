#include "script_component.hpp"

/*
 * Function: dragonfly_db_fnc_listRemove
 * Author: Creedcoder, J.Schmidt
 * Edit: 07.15.2024
 * Copyright © 2024 Creedcoder, J.Schmidt, All rights reserved
 *
 * Do not edit without permission!
 *
 * This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivative 4.0 International License.
 * To view a copy of this license, vist https://creativecommons.org/licenses/by-nc-nd/4.0/ or send a letter to Creative Commons,
 * PO Box 1866, Mountain View, CA 94042
 *
 * [Description]
 * Remove element of list stored at key from DB.
 *
 * Arguments:
 * 0: Name of stored key <STRING> (default: "")
 * 1: Index of stored value in list <NUMBER> (default: -1)
 *
 * Return Value:
 * N/A
 *
 * Examples:
 * ["events", 0] call dragonfly_db_fnc_listRemove (Server or Singleplayer Only)
 * ["events", 0] remoteExecCall ["dragonfly_db_fnc_listRemove", 2, false] (Multiplayer Only)
 *
 * Public: Yes
 */

params [["_key", "", [""]], ["_index", -1, [0]]];

if (_key == "") exitWith { diag_log text format ["ArmaDragonflyClient: 'dragonfly_db_fnc_listRemove' Invalid Input for Key '%1'", _key]; };

"ArmaDragonflyClient" callExtension ["listrem", [_key, _index]];