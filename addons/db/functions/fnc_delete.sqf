#include "script_component.hpp"

/*
 * Function: dragonfly_db_fnc_delete
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
 * Delete stored key from DB.
 *
 * Arguments:
 * 0: Name of stored key <STRING> (default: "")
 *
 * Return Value:
 * N/A
 *
 * Examples:
 * [getPlayerUID player] call dragonfly_db_fnc_delete (Server or Singleplayer Only)
 * [getPlayerUID player] remoteExecCall ["dragonfly_db_fnc_delete", 2, false] (Multiplayer Only)
 *
 * Public: Yes
 */

params [["_key", "", [""]]];

if (_key == "") exitWith { diag_log text format ["ArmaDragonflyClient: 'dragonfly_db_fnc_delete' Invalid Input for Key '%1'", _key]; };

"ArmaDragonflyClient" callExtension ["del", [_key]];