class bg_loadout_define 
{
	class faction // superclass
	{
		class type
		{
			uniform = "U_B_CombatUniform_mcam";
			helmet = "";
			vest = "";
			pack = "";
			facewear = "";
			goggles = "";
			binos = "";
			map = "ItemMap";
			terminal = "ItemGPS";
			radio = "ItemRadio";
			compass = "ItemCompass";
			watch = "ItemWatch";
			
			meditems[] = {{"FirstAidKit",1}};
			packmags[] = {{"",0}};
			packitems[] = {{"",0}};
			items[] = {{"",0}};
			
			primary = "";
			primarymags[] = {{"",0}};
			primaryattach[] = {""};
			
			handgun = "";
			handgunmags[] = {{"",0}};
			handgunattach[] = {""};
			
			secondary = "";
			secondarymags[] = {{"",0}};
			secondaryattach[] = {""};
		};
	}; // define subclasses below
	
	class blu_f : faction
	{
		class base : type
		{
			helmet = "H_HelmetB";
			vest = "V_PlateCarrier1_rgr";
			pack = "B_AssaultPack_mcamo";
			primary = "arifle_MX_F";
			primarymags[] = {{"30Rnd_65x39_caseless_mag",7}, {"30Rnd_65x39_caseless_mag_Tracer",1}};
			
		};
		
		class r : base {};
		
		class rat : r
		{
			secondary = "rhs_weap_rpg7";
			secondaryattach[] = {"rhs_acc_pgo7v"};
			packmags[] = {{"rhs_rpg7_PG7VL_mag",2}};
			terminal = "";
		};
		
		class aar : r
		{
			primary = "arifle_MX_pointer_F";
			packmags[] = {{"100Rnd_65x39_caseless_mag",3},{"100Rnd_65x39_caseless_mag_Tracer",1}};
			primaryattach[] = {"optic_Aco"};
			packitems[] = {{"Binocular",1}};
		};
	};
	
	class opf_f : faction
	{
		class base : type
		{
			uniform = "U_O_CombatUniform_ocamo";
			helmet = "H_HelmetO_ocamo";
			primary = "arifle_Katiba_F";
			vest = "V_HarnessO_brn";
			primarymags[] = {{"30Rnd_65x39_caseless_green",7}, {"30Rnd_65x39_caseless_green_mag_Tracer",1}};
		};
		
		class r : base
		{
			pack = "B_Carryall_ocamo";
			packmags[] = {{"30Rnd_65x39_caseless_green",10}};
			primaryattach[] = {"optic_ACO_grn_smg"};
		};
	};
};
