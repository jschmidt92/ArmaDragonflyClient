#include "script_component.hpp"

/*
 * Function: dragonfly_db_fnc_setup
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
 * Setup Extension to communicate with DB.
 *
 * Arguments:
 * 0: Name of host <STRING> (default: "localhost")
 * 1: Port of host <NUMBER> (default: 6379)
 * 2: Password of host <STRING> (default: "xyz123")
 *
 * Return Value:
 * N/A
 *
 * Examples:
 * ["localhost", 6379, "xyz123"] call dragonfly_db_fnc_setup (Server or Singleplayer Only)
 * ["localhost", 6379, "xyz123"] remoteExecCall ["dragonfly_db_fnc_setup", 2, false] (Multiplayer Only)
 *
 * Public: Yes
 */

params [["_host", "localhost", [""]], ["_port", 6379, [0]], ["_password", "xyz123", [""]]];

// To be implemented...
"ArmaDragonflyClient" callExtension ["setup",  [_host, _port, _password]];