#include "script_component.hpp"

/*
 * Function: dragonfly_db_fnc_processQueue
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
 * Process queue of tasks.
 *
 * Arguments:
 * N/A
 *
 * Return Value:
 * N/A
 *
 * Examples:
 * [] spawn dragonfly_db_fnc_processQueue (Server or Singleplayer Only)
 * [] remoteExec ["dragonfly_db_fnc_processQueue", 2, false] (Multiplayer Only)
 *
 * Public: Yes
 */

GVAR(isProcessing) = true;

while { count GVAR(taskQueue) > 0} do {
	private _task = GVAR(taskQueue) deleteAt 0;
	private _taskType = _task select 0;
	private _key = _task select 1;
	private _keyField = _task select 2;
	private _index = _task select 3;
	private _value = _task select 4;
	private _function = _task select 5;
	private _call = _task select 6;
	private _netId = _task select 7;

	diag_log text format ["Initializing Task: %1", _task];

	switch (_taskType) do {
		case "get": { diag_log text format ["ArmaDragonflyClient: 'dragonfly_db_fnc_processQueue' Processing Task '%1'", _taskType]; [_key, _function, _call, _netId] call FUNC(get); };
		case "set": { diag_log text format ["ArmaDragonflyClient: 'dragonfly_db_fnc_processQueue' Processing Task '%1'", _taskType]; [_key, _value] call FUNC(set); };
		case "del": { diag_log text format ["ArmaDragonflyClient: 'dragonfly_db_fnc_processQueue' Processing Task '%1'", _taskType]; [_key] call FUNC(delete); };
		case "hget": { diag_log text format ["ArmaDragonflyClient: 'dragonfly_db_fnc_processQueue' Processing Task '%1'", _taskType]; [_keyField, _function, _call, _netId] call FUNC(hashGet); };
		case "hgetid": { diag_log text format ["ArmaDragonflyClient: 'dragonfly_db_fnc_processQueue' Processing Task '%1'", _taskType]; [_key, _keyField, _function, _call, _netId] call FUNC(hashGetId); };
		case "hgetall": { diag_log text format ["ArmaDragonflyClient: 'dragonfly_db_fnc_processQueue' Processing Task '%1'", _taskType]; [_function, _call, _netId] call FUNC(hashGetAll); };
		case "hgetallid": { diag_log text format ["ArmaDragonflyClient: 'dragonfly_db_fnc_processQueue' Processing Task '%1'", _taskType]; [_key, _function, _call, _netId] call FUNC(hashGetAllId); };
		case "hset": { diag_log text format ["ArmaDragonflyClient: 'dragonfly_db_fnc_processQueue' Processing Task '%1'", _taskType]; [_keyField, _value] call FUNC(hashSet); };
		case "hsetbulk": { diag_log text format ["ArmaDragonflyClient: 'dragonfly_db_fnc_processQueue' Processing Task '%1'", _taskType]; [_value] call FUNC(hashSetBulk); };
		case "hsetid": { diag_log text format ["ArmaDragonflyClient: 'dragonfly_db_fnc_processQueue' Processing Task '%1'", _taskType]; [_key, _keyField, _value] call FUNC(hashSetId); };
		case "hsetidbulk": { diag_log text format ["ArmaDragonflyClient: 'dragonfly_db_fnc_processQueue' Processing Task '%1'", _taskType]; [_value] call FUNC(hashSetIdBulk); };
		case "listadd": { diag_log text format ["ArmaDragonflyClient: 'dragonfly_db_fnc_processQueue' Processing Task '%1'", _taskType]; [_key, _value] call FUNC(listAdd); };
		case "listidx": { diag_log text format ["ArmaDragonflyClient: 'dragonfly_db_fnc_processQueue' Processing Task '%1'", _taskType]; [_key, _index, _function, _call, _netId] call FUNC(listGet); };
		case "listrng": { diag_log text format ["ArmaDragonflyClient: 'dragonfly_db_fnc_processQueue' Processing Task '%1'", _taskType]; [_key, _function, _call, _netId] call FUNC(listLoad); };
		case "listrem": { diag_log text format ["ArmaDragonflyClient: 'dragonfly_db_fnc_processQueue' Processing Task '%1'", _taskType]; [_key, _index] call FUNC(listRemove); };
		case "listset": { diag_log text format ["ArmaDragonflyClient: 'dragonfly_db_fnc_processQueue' Processing Task '%1'", _taskType]; [_key, _index, _value] call FUNC(listSet); };
	};

	sleep 1;

};

GVAR(isProcessing) = false;