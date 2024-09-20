# Getting Started

Read through [Getting Started](https://www.dragonflydb.io/docs/getting-started) Guide from DragonflyDB to get Dragonfly up and running on your machine or use the provided binaries within the `dragonfly` folder.

## OS Compatibility

ArmaDragonflyClient is currently only compatible with Windows. Linux is planned for a future release.

## Usage

1. Download the latest release from the [Releases](https://github.com/ArmaDragonflyClient/ArmaDragonflyClient/releases) page.
2. Extract the zip file to your Arma 3 directory.
3. Create the init.sqf file in your mission folder and add the following code:

```sqf
addMissionEventHandler ["ExtensionCallback", {
	params ["_name", "_function", "_data"];
	diag_log _this;
	if (_name isEqualTo "ArmaDragonflyClient") then {
		parseSimpleArray _data call (missionNamespace getVariable [_function, {
			hint "Function does not exist!"
		}]);
	};
}];
```

4. Create the initServer.sqf file in your mission folder and add the following code:

```sqf
if (isServer || isDedicated) then {
	true spawn dragonfly_db_fnc_init;
};
```

5. Implement data persistence using DragonflyDB:

   - To enable saving and loading data from DragonflyDB, you need to create the necessary functions.
   - Refer to the [Add Task](https://jschmidt92.github.io/ArmaDragonflyClient/#/main/addTask) wiki page for detailed information on how to create tasks in DragonflyDB.
   - Utilize the `dragonfly_db_fnc_addTask` function to add tasks to the DragonflyDB queue for saving and loading data.
   - Here's an example of how you can create a task to save data:
       > <span style="color:cyan">**_IMPORTANT:_**</span> All data must be encapsulated by brackets

     ```sqf
     ["hsetid", getPlayerUID player, "loadout", -1, getUnitLoadout player] call dragonfly_db_fnc_addTask;
     ```

     This example adds a task to set the value of the field "loadout" in the hash player UID to the player's loadout.

   - To load data, you can create a task using the appropriate task type, such as "hgetall" or "hget":
     ```sqf
     ["hgetallid", getPlayerUID player, "", -1, [], "myCallback", false, netId player] call dragonfly_db_fnc_addTask;
     ```

     This example adds a task to retrieve all values from the hash player UID and pass the retrieved data to the "myCallback" function for further processing.

   - Ensure that you provide the correct task type, key names, field names, and callback functions based on your specific data requirements. Please refer to the Task Types section below for more information on available task types and their corresponding data types.
   - Properly handle the retrieved data in the callback functions to utilize it effectively in your project.
       - I.e. implement public variables and `waitUntil` checks before proceeding onto the next task(s).
       ```sqf
       // First Script or Function to execute `dragonfly_db_fnc_addTask`
       value_ExampleDone = false;
       publicVariable "value_ExampleDone";
       ...

       // Callback function to process the retrieved data
       ...
       value_ExampleDone = true;
       publicVariable "value_ExampleDone";

       // Next Script or Function to execute `dragonfly_db_fnc_addTask`
       waitUntil {value_ExampleDone};
       ...
       ```

By following these steps and leveraging the `dragonfly_db_fnc_addTask` function, you can implement robust data persistence functionality using DragonflyDB in your Arma 3 project.

### Task Types

| Task Type  | Data Type                                                                                                |
| ---------- | -------------------------------------------------------------------------------------------------------- |
| get        | [Get Data Type](https://jschmidt92.github.io/ArmaDragonflyClient/#/generic/get)                          |
| set        | [Set Data Type](https://jschmidt92.github.io/ArmaDragonflyClient/#/generic/set)                          |
| del        | [Delete Data Type](https://jschmidt92.github.io/ArmaDragonflyClient/#/generic/delete)                    |
| hget       | [Hash Get Data Type](https://jschmidt92.github.io/ArmaDragonflyClient/#/hashes/hashGet)                  |
| hgetid     | [Hash Get by ID Data Type](https://jschmidt92.github.io/ArmaDragonflyClient/#/hashes/hashGetId)          |
| hgetall    | [Hash Get All Data Type](https://jschmidt92.github.io/ArmaDragonflyClient/#/hashes/hashGetAll)           |
| hgetallid  | [Hash Get All by ID Data Type](https://jschmidt92.github.io/ArmaDragonflyClient/#/hashes/hashGetAllId)   |
| hset       | [Hash Set Data Type](https://jschmidt92.github.io/ArmaDragonflyClient/#/hashes/hashSet)                  |
| hsetbulk   | [Hash Set Bulk Data Type](https://jschmidt92.github.io/ArmaDragonflyClient/#/hashes/hashSetBulk)         |
| hsetid     | [Hash Set by ID Data Type](https://jschmidt92.github.io/ArmaDragonflyClient/#/hashes/hashSetId)          |
| hsetidbulk | [Hash Set Bulk by ID Data Type](https://jschmidt92.github.io/ArmaDragonflyClient/#/hashes/hashSetBulkId) |
| listadd    | [List Add Data Type](https://jschmidt92.github.io/ArmaDragonflyClient/#/lists/listAdd)                   |
| listidx    | [List Index Data Type](https://jschmidt92.github.io/ArmaDragonflyClient/#/lists/listGet)                 |
| listrng    | [List Range Data Type](https://jschmidt92.github.io/ArmaDragonflyClient/#/lists/listLoad)                |
| listrem    | [List Remove Data Type](https://jschmidt92.github.io/ArmaDragonflyClient/#/lists/listRemove)             |
| listset    | [List Set Data Type](https://jschmidt92.github.io/ArmaDragonflyClient/#/lists/listSet)                   |
