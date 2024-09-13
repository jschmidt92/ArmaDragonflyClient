#include "script_component.hpp"

/*
 * Function: dragonfly_db_fnc_hashSetIdBulk
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
 * Set fields and values in hash stored at key from DB.
 *
 * Arguments:
 * 0: Fields and Values to store in hash [<ARRAY|STRING|NUMBER|BOOL>] (default: [])
 *
 * Return Value:
 * N/A
 *
 * Examples:
 * [getPlayerUID player, "loadout", [getUnitLoadout player], "position", [getPosASLVisual player]] call dragonfly_db_fnc_hashSetIdBulk (Server or Singleplayer Only)
 * [getPlayerUID player, "loadout", [getUnitLoadout player], "position", [getPosASLVisual player]] remoteExecCall ["dragonfly_db_fnc_hashSetIdBulk", 2, false] (Multiplayer Only)
 *
 * Public: Yes
 */

params [["_data", [], [[]]]];

if (count _data == 0) exitWith { diag_log text format ["ArmaDragonflyClient: 'dragonfly_db_fnc_hashSetIdBulk' Invalid Input for Data '%1'", _data]; };

"ArmaDragonflyClient" callExtension ["hsetid", _data];