#include "script_component.hpp"

/*
 * Function: dragonfly_db_fnc_saveDB
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
 * Save DB to disc.
 *
 * Arguments:
 * N/A
 *
 * Return Value:
 * N/A
 *
 * Examples:
 * [] call dragonfly_db_fnc_saveDB (Server or Singleplayer Only)
 * [] remoteExecCall ["dragonfly_db_fnc_saveDB", 2, false] (Multiplayer Only)
 *
 * Public: Yes
 */

"ArmaDragonflyClient" callExtension ["saveDB", []];