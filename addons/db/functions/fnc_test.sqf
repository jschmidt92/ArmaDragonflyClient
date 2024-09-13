#include "script_component.hpp"

/*
 * Function: dragonfly_db_fnc_test
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
 * Test function.
 *
 * Arguments:
 * 0: Value <ARRAY|STRING|NUMBER|BOOL>
 *
 * Return Value:
 * <ARRAY|STRING|NUMBER|BOOL> Value
 *
 * Examples:
 * ["Hello World!"] spawn dragonfly_db_fnc_test (Server or Singleplayer Only)
 * ["Hello World!"] remoteExec ["dragonfly_db_fnc_test", 2, false] (Multiplayer Only)
 *
 * Public: Yes
 */

_res = _this;
dragonfly_db_test = _res;

hint format ["%1", _res];