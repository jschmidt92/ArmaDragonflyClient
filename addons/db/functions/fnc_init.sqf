#include "script_component.hpp"

/*
 * Function: dragonfly_db_fnc_init
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
 * Initial Extension settings.
 *
 * Arguments:
 * N/A
 *
 * Return Value:
 * N/A
 *
 * Examples:
 * N/A
 *
 * Public: Yes
 */

dragonfly_db_buffer = 10240;

private _dll = "ArmaDragonflyClient" callExtension ["version", []];

diag_log text (format["ArmaDragonflyClient: DLL Version %1 found", _dll]);
diag_log text "ArmaDragonflyClient: Functions loaded and Initializtion completed!";
diag_log text (format["ArmaDragonflyClient: Buffer size set to %1 Bytes", dragonfly_db_buffer]);
diag_log text "ArmaDragonflyClient: Ready for use!";