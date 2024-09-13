#include "script_component.hpp"

/*
	@file Title: ArmaDragonflyClient Framework by Creedcoder, J.Schmidt
	@file Version: 0.1
	@file Name: fnc_fetch.sqf
	@file Author: Creedcoder, J.Schmidt
	@file edit: 03.25.2024
	Copyright © 2024 Creedcoder, J.Schmidt, All rights reserved

	Do not edit without permission!

	This work is licensed under the Creative Commons Attribution-NonCommercial-ShareAlikes 4.0 International License.
	To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/4.0/ or send a letter to Creative Commons,
	444 Castro Street, Suite 900, Mountain View, California, 94041, USA.

	Fetch from DB:
    dragonfly_db_fetch_array

    ["uniqueID", "function", "index", "indextotal", "datachunk"]
*/

diag_log _this;

params ["_uniqueID", "_function", "_index", "_total", "_datachunk"];
private _datastring = "";
private _index_array = [];
private _count_total = -1;

// _uniqueID = parseNumber _uniqueID;
// _function
// _index = parseNumber _index;
// _total = parseNumber _total;
// _datachunk

dragonfly_db_fetch_array pushBackUnique [_uniqueID, _function, _index, _total, _datachunk];

_count_total = {
    if (_uniqueID == _x select 0) then {
        _index_array pushBackUnique [_x select 2, _x select 4];
        true
    } else {
        false
    }
} count dragonfly_db_fetch_array;

if (_count_total == _total) then {
    _index_array sort true;
    for "_i" from 0 to (_total - 1) do {
        _datastring = _datastring + ((_index_array select _i) select 1);
    };

    diag_log _datastring;

    (parseSimpleArray _datastring) call (missionNamespace getVariable [_function, {
        hint "Function does not exist!";
    }]);

    // cleanup
    dragonfly_db_fetch_array = dragonfly_db_fetch_array select {!((_x select 0) in [_uniqueID])};
};