#include "script_component.hpp"

/*
 * Function: dragonfly_db_fnc_hashGet
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
 * Get value of field in hash stored in key from DB.
 *
 * Arguments:
 * 0: Name of stored field in hash <STRING> (default: "")
 * 1: Name of function to return data <STRING> (default: "")
 * 2: Unscheduled environment <BOOL> (default: false)
 * 3: NetID of target to return data from function <STRING> (default: nil)
 *
 * Return Value:
 * N/A
 *
 * Examples:
 * ["loadout", "dragonfly_db_fnc_test", false] call dragonfly_db_fnc_hashGet (Server or Singleplayer Only)
 * ["loadout", "dragonfly_db_fnc_test", false, netId player] remoteExecCall ["dragonfly_db_fnc_hashGet", 2, false] (Multiplayer Only)
 *
 * Public: Yes
 */

params [["_keyField", "", [""]], ["_function", "", [""]], ["_call", false, [false]], ["_netId", nil, [""]]];

if (_keyField == "" || _function == "") exitWith { diag_log text format ["ArmaDragonflyClient: 'dragonfly_db_fnc_hashGet' Invalid Input for KeyField '%1' or Function '%2'", _keyField, _function]; };

if (!isNil "_netId" and _netId isNotEqualTo "") then {
	if (_call) then {
		_return = "ArmaDragonflyClient" callExtension ["hget", [_keyField, _function, _netId, _call]];
		[(_return select 0)] call FUNC(scheduler);
	} else {
		_return = "ArmaDragonflyClient" callExtension ["hget", [_keyField, _function, _netId]];
		[(_return select 0)] call FUNC(scheduler);
	};
} else {
	_return = "ArmaDragonflyClient" callExtension ["hget", [_keyField, _function]];
	[(_return select 0)] call FUNC(scheduler);
};