#include "script_component.hpp"

/*
 * Function: dragonfly_db_fnc_hashGetAllId
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
 * Get all fields and values of hash stored in key from DB.
 *
 * Arguments:
 * 0: Name of stored key with hash <STRING> (default: "")
 * 1: Name of function to return data <STRING> (default: "")
 * 2: Unscheduled environment <BOOL> (default: false)
 * 3: NetID of target to return data from function <STRING> (default: nil)
 *
 * Return Value:
 * N/A
 *
 * Examples:
 * [getPlayerUID player, "dragonfly_db_fnc_test", false] call dragonfly_db_fnc_hashGetAllId (Server or Singleplayer Only)
 * [getPlayerUID player, "dragonfly_db_fnc_test", false, netId player] remoteExecCall ["dragonfly_db_fnc_hashGetAllId", 2, false] (Multiplayer Only)
 *
 * Public: Yes
 */

params [["_key", "", [""]], ["_function", "", [""]], ["_call", false, [false]], ["_netId", nil, [""]]];

if (_key == "" || _function == "") exitWith { diag_log text format ["ArmaDragonflyClient: 'dragonfly_db_fnc_hashGetAllId' Invalid Input for Key '%1' or Function '%2'", _key, _function]; };

if (!isNil "_netId" and _netId isNotEqualTo "") then {
	if (_call) then {
		_return = "ArmaDragonflyClient" callExtension ["hgetallid", [_key, _function, _netId, _call]];
		[(_return select 0)] call FUNC(scheduler);
	} else {
		_return = "ArmaDragonflyClient" callExtension ["hgetallid", [_key, _function, _netId]];
		[(_return select 0)] call FUNC(scheduler);
	};
} else {
	_return = "ArmaDragonflyClient" callExtension ["hgetallid", [_key, _function]];
	[(_return select 0)] call FUNC(scheduler);
};