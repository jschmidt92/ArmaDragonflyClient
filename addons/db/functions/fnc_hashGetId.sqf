#include "script_component.hpp"

/*
 * Function: dragonfly_db_fnc_hashGetId
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
 * Get value of field in hash stored at key from DB.
 *
 * Arguments:
 * 0: Name of stored key with hash <STRING> (default: "")
 * 1: Name of stored field in hash <STRING> (default: "")
 * 2: Name of function to return data <STRING> (default: "")
 * 3: Unscheduled environment <BOOL> (default: false)
 * 4: NetID of target to return data from function <STRING> (default: nil)
 *
 * Return Value:
 * N/A
 *
 * Examples:
 * [getPlayerUID player, "loadout", "dragonfly_db_fnc_test", false] call dragonfly_db_fnc_hashGetId (Server or Singleplayer Only)
 * [getPlayerUID player, "loadout", "dragonfly_db_fnc_test", false, netId player] remoteExecCall ["dragonfly_db_fnc_hashGetId", 2, false] (Multiplayer Only)
 *
 * Public: Yes
 */

params [["_key", "", [""]], ["_keyField", "", [""]], ["_function", "", [""]], ["_call", false, [false]], ["_netId", nil, [""]]];

if (_key == "" || _keyField == "" || _function == "") exitWith { diag_log text format ["ArmaDragonflyClient: 'dragonfly_db_fnc_hashGetId' Invalid Input for Key '%1', KeyField '%2' or Function '%3'", _key, _keyField, _function]; };

if (!isNil "_netId" and _netId isNotEqualTo "") then {
	if (_call) then {
		_return = "ArmaDragonflyClient" callExtension ["hgetid", [_key, _keyField, _function, _netId, _call]];
		[(_return select 0)] call FUNC(scheduler);
	} else {
		_return = "ArmaDragonflyClient" callExtension ["hgetid", [_key, _keyField, _function, _netId]];
		[(_return select 0)] call FUNC(scheduler);
	};
} else {
	_return = "ArmaDragonflyClient" callExtension ["hgetid", [_key, _keyField, _function]];
	[(_return select 0)] call FUNC(scheduler);
};