#include "script_component.hpp"

/*
 * Function: dragonfly_db_fnc_scheduler
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
 * Scheduled Environment for extension.
 *
 * Arguments:
 * 0: Task ID from extension <STRING> (default: "")
 *
 * Return Value:
 * N/A
 *
 * Examples:
 * ["071620241600_get"] call dragonfly_db_fnc_scheduler (Server or Singleplayer Only)
 * ["071620241600_get"] remoteExecCall ["dragonfly_db_fnc_scheduler", 2, false] (Multiplayer Only)
 *
 * Public: Yes
 */

private _params = call compile format ["%1", (_this select 0)];
private _taskID = _params select 0;
private _function = _params select 1;
private _array = _taskID splitString "_";
private _id = _array select 0;
private _taskType = _array select 1;
private _addTaskIDToMap = {
    params ["_taskType", "_taskID"];

    private _varName = format ["dragonfly_db_%1_map", _taskType];
    private _taskMap = missionNamespace getVariable [_varName, createHashMap];
    _taskMap set [_taskID, _function];

    missionNamespace setVariable [_varName, _taskMap];
    _myHashMap = missionNamespace getVariable [_varName, createHashMap];
};

[_taskType, _taskID] call _addTaskIDToMap;