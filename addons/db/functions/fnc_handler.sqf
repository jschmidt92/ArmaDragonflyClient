#include "script_component.hpp"

/*
 * Function: dragonfly_db_fnc_handler
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
 * Handle data from DB.
 *
 * Arguments:
 * 0: UniqueID for data chunk <STRING> (default: "")
 * 1: Name of function to return data <STRING> (default: "")
 * 2: Unscheduled environment <BOOL> (default: false)
 * 3: Data from key <ARRAY|STRING|NUMBER|BOOL> (default: [])
 * 4: NetID of target to return data from function <STRING> (default: nil)
 *
 * Return Value:
 * [uniqueID, function, call, data, object] <ARRAY>
 *
 * Examples:
 * ["0123456789", "dragonfly_db_fnc_test", false, ["Hello World!"]] call dragonfly_db_fnc_handler (Server or Singleplayer Only)
 * ["0123456789", "dragonfly_db_fnc_test", false, ["Hello World!"], netId player] remoteExecCall ["dragonfly_db_fnc_handler", 2, false] (Multiplayer Only)
 *
 * Public: Yes
 */

params [["_uniqueID", "", [""]], ["_function", "", [""]], ["_call", false, [false]], ["_data", [], [[], "", 0, true]], ["_netId", nil, [""]]];

if (_function == "" || count _data == 0) exitWith { diag_log text format ["ArmaDragonflyClient: 'dragonfly_db_fnc_handler' Invalid Input for Function '%1' or Data '%2'", _function, _data]; };

private _func = call compile format ["%1", _function];

if (!isNil "_netId") then {
	private _target = objectFromNetId _netId;

	if (_call) then { _data remoteExecCall [_function, _target, false]; } else { _data remoteExec [_function, _target, false]; };
} else {
	if (_call) then { _data call _func; } else { _data spawn _func; };
};