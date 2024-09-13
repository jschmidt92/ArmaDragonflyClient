#include "script_component.hpp"

/*
 * Function: dragonfly_db_fnc_addTask
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
 * Add task to queue.
 *
 * Arguments:
 * 0: Type of task <STRING>
 * 1: Name of stored key <STRING> (default: "")
 * 2: Name of stored hash key field <STRING> (default: "")
 * 3: Index of stored value in list <STRING> (default: -1)
 * 4: Value to store in key [<ARRAY|STRING|NUMBER|BOOL>] (default: [])
 * 5: Name of function to return data <STRING> (default: "")
 * 6: Unscheduled environment <BOOL> (default: false)
 * 7: NetID of target to return data from function <STRING> (default: "")
 *
 * Return Value:
 * N/A
 *
 * Examples:
 * ["hgetall", "", "", -1, [], "dragonfly_db_fnc_test", false] call dragonfly_db_fnc_addTask (Server or Singleplayer Only)
 * ["hgetallid", getPlayerUID player, "", -1, [], "dragonfly_db_fnc_test", false, netId player] remoteExecCall ["dragonfly_db_fnc_addTask", 2, false] (Multiplayer Only)
 *
 * Public: Yes
 */

params [["_taskType", "", [""]], ["_key", "", [""]], ["_keyField", "", [""]], ["_index", -1, [0]], ["_value", [], [[], "", 0, true]], ["_function", "", [""]], ["_call", false, [false]], ["_netId", "", [""]]];

private _task = [_taskType, _key, _keyField, _index, _value, _function, _call, _netId];

diag_log text format ["ArmaDragonflyClient: 'dragonfly_db_fnc_addTask' Added Task '%1' to Queue", _task];

GVAR(taskQueue) pushBack _task;
diag_log text format ["ArmaDragonflyClient: 'dragonfly_db_fnc_addTask' Queue: %1", GVAR(taskQueue)];
diag_log text format ["ArmaDragonflyClient: 'dragonfly_db_fnc_addTask' Queue Size: %1", count GVAR(taskQueue)];

if !(GVAR(isProcessing)) then { [] spawn FUNC(processQueue); };