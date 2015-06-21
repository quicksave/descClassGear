diag_log str _this;

// Depending on locality the script decides if it should run
private ["_unit"];
_unit = (_this select 1);

if !(local _unit) exitWith {};

//init vars
private
[
	"_faction","_typeofUnit",
	"_uniform", "_helmet", "_vest", "_pack", "_facewear", "_goggles", "_binos", "_map", "_terminal", "_radio", "_compass", "_watch",
	"_meditems", "_items", "_packitems", "_packmags",
	"_primary", "_primarymags", "_primaryattach", "_secondary", "_secondarymags", "_secondaryattach", "_handgun", "_handgunmags", "_handgunattach",
	"_gearvalue", "_gearname"
];

_typeofUnit = toLower (_this select 0);
_faction = toLower (faction _unit);

// optional third argument to set faction
if(count _this > 2) then
{
	_faction = toLower (_this select 2);
};

// A public variable is set on the unit, indicating their type. This is mostly relevant for the F3 respawn component
_unit setVariable ["f_var_assignGear",_typeofUnit,true];

// This variable simply tracks the progress of the gear assignation process, for other scripts to reference.
_unit setVariable ["f_var_assignGear_done",false,true];

// Prevent BIS Randomisation System
_unit setVariable ["BIS_enableRandomization", false];


//vars
_gearvalue = "";
_gearname = "";

// generates vars from description.ext, slower than f3 e.g. 31.3416 ms
for "_x" from 0 to (count (missionconfigfile >> "bg_loadout_define" >> "faction" >> "type") - 1) do
{
	_gearname = configname ((missionconfigfile >> "bg_loadout_define" >> "faction" >> "type") select _x);
	
	if (istext (missionconfigfile >> "bg_loadout_define" >> _faction >> _typeofunit >> _gearname)) then
	{
		_gearValue = str (gettext (missionconfigfile >> "bg_loadout_define" >> _faction >> _typeofunit >> _gearname));
	}
	else
	{
		_gearValue = str (getarray (missionconfigfile >> "bg_loadout_define" >> _faction >> _typeofunit >> _gearname));
	};
	
	_code = format ["_%1 = %2", _gearName, _gearValue];
	diag_log format ["_unit = %1, _code: %2, _faction = %3, _typeofunit = %4", _unit, _code, _faction, _typeofunit];
	call compile _code;
};

//commands

//clear unit
removeBackpack _unit;
removeAllWeapons _unit;
removeAllItemsWithMagazines _unit;
removeAllAssignedItems _unit;
removeUniform _unit;
removeHeadgear _unit;
removeVest _unit;

//add containers
_unit forceadduniform _uniform;
_unit addheadgear _helmet;
_unit addvest _vest;
_unit addgoggles _facewear;
_unit addbackpack _pack;
clearMagazineCargoGlobal (unitBackpack _unit);

//linkables
{_unit linkitem _x} foreach [_map, _compass, _watch, _radio, _terminal, _goggles];

//mags in backpack
{
	(unitBackpack _unit) addMagazineCargoGlobal _x;
} foreach _packmags;

//items in backpack
{
	(unitBackpack _unit) addItemCargoGlobal _x;
} foreach _packitems;

//medical items
{
	for "_i" from 1 to (_x select 1) do
	{
		_unit additem (_x select 0);
	};
} foreach _meditems;

//general items
{
	for "_i" from 1 to (_x select 1) do
	{
		_unit additem (_x select 0);
	};
} foreach _items;

//primary weapon mags
{
	_unit addmagazines _x;
} foreach _primarymags;

//launcher mags
{
	_unit addmagazines _x;
} foreach _secondarymags;

//handgun mags
{
	_unit addmagazines _x;
} foreach _handgunmags;

//weapons
{
	_unit addweapon _x;
} foreach [_primary, _secondary, _handgun, _binos];

//attachments
{
	_unit addPrimaryWeaponItem _x;
} foreach _primaryattach;

{
	_unit addHandgunItem _x;
} foreach _handgunattach;

{
	_unit addsecondaryWeaponItem _x;
} foreach _secondaryattach;


// This variable simply tracks the progress of the gear assignation process, for other scripts to reference.
_unit setVariable ["f_var_assignGear_done",true,true];
