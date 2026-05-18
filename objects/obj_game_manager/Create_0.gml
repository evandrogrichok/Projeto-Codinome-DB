global.DELTA_TIME = delta_time/16666
global.LANG = "pt"
gpu_set_tex_filter(false);



enum DEPTH {
    BG_FARTHEST   = 300000,
    BG_FAR        = 280000,
    BG_NEAR       = 260000,
    BG_NEAREST    = 240000,

    WORLD_BASE    = 220000,
	
    FX_BEHIND     = 180000, 
    ENTITY_BASE   = 150000,
    ENTITY_TOP    = 140000,
    FX_FRONT      = 100000,
	


	WORLD_TOP     =  75000,
	
	LOGIC_BEHIND  =  46000,
	LOGIC_OBJECTS =  45000,
	LOGIC_TOP     =  44000,
	
	
    UI_BASE       =  10000,
    UI_TOP        =   5000,
    DEBUG         =   1000
}


global.areas_properties = {
	GREAT_ENTRANCE : {
		name_pt: "A Grande Entrada",
		name_en: "The Great Entrance",
		ui_primary_colors: [ #28aeff, #28ffa0],
		ui_secondary_colors: [ #ff2887, #ff7928]
	}
}

global.current_area = "GREAT_ENTRANCE";


//SETUP INICIAL

setup_objects = [
	[obj_player, "player"],
	[obj_camera, "camera"],
	[obj_game_menu, "menu"],
	[obj_game_manager, "manager"],
];

global.instances = {
    player: noone,
    camera: noone,
    menu: noone,
    manager: noone
};



for (var i = 0; i < array_length(setup_objects); i++){
	var obj = setup_objects[i][0];
	var name = setup_objects[i][1];
	show_debug_message("oia o nome: ", name);
	show_debug_message("oia o obj: ", obj);
	
	
	if !instance_exists(obj){
		global.instances[$ name] = instance_create_layer(819, 157, "Instances", obj);
		show_debug_message("eita q nao achei, mas criei ")
	} else {
		global.instances[$ name] = instance_find(obj, 0);
		show_debug_message("eita q achei, é o ", instance_find(obj, 0))
	}
	
	show_debug_message("OBJ: " + string(obj));
show_debug_message("COUNT: " + string(instance_number(obj)));
show_debug_message("FIND: " + string(instance_find(obj, 0)));
}

show_debug_message("coisas", global.instances)


//TECLAS
global.ACCEPT_KEY = keyboard_check_pressed(vk_enter) or keyboard_check_pressed(ord("Z"));
global.BACK_KEY = keyboard_check_pressed(vk_shift) or keyboard_check_pressed(ord("X"));
global.MENU_KEY = keyboard_check_pressed(vk_escape) or keyboard_check_pressed(ord("C"));
global.UP_KEY = keyboard_check_pressed(vk_up) or keyboard_check_pressed(ord("W"));
global.DOWN_KEY = keyboard_check_pressed(vk_down) or keyboard_check_pressed(ord("S"));
global.LEFT_KEY = keyboard_check_pressed(vk_left) or keyboard_check_pressed(ord("A"));
global.RIGHT_KEY = keyboard_check_pressed(vk_right) or keyboard_check_pressed(ord("D"));

global.ACCEPT_KEY_HOLD = keyboard_check(vk_enter) or keyboard_check(ord("Z"));
global.BACK_KEY_HOLD = keyboard_check(vk_shift) or keyboard_check(ord("X"));
global.MENU_KEY_HOLD = keyboard_check(vk_escape) or keyboard_check(ord("C"));
global.UP_KEY_HOLD = keyboard_check(vk_up) or keyboard_check(ord("W"));
global.DOWN_KEY_HOLD = keyboard_check(vk_down) or keyboard_check(ord("S"));
global.LEFT_KEY_HOLD = keyboard_check(vk_left) or keyboard_check(ord("A"));
global.RIGHT_KEY_HOLD = keyboard_check(vk_right) or keyboard_check(ord("D"));



//CONFIGURAÇÕES
game_set_speed(60, gamespeed_fps);
gpu_set_texfilter(false);
window_set_fullscreen(false);

random_set_seed(current_time);

//level tiers [0] == xp necessário

level_tiers = {
	level_1: 0,
	level_2: 20,
	level_3: 40,
}



if !object_exists(obj_game_menu){
	instance_create_depth(0,0, 16000, obj_game_menu);
}


//player_val = global.instances.player.values;
// =============   ITENS ===============
//TYPE 0 = COMESTIVEL
//TYPE 1 = EQUIPÁVEL
//TYPE 2 = ITENS CHAVE

enum ITEM_TYPES {
	edible,
	equippable,
	key
}

show_debug_message("CRIOU MANAGER");
global.ITEMS_DATA = {};

global.ITEMS_DATA.item_001 = {
	name : "Banana",
	sprite : "spr_item_banana",
	type : ITEM_TYPES.edible,
	hp_restore : 10,
	info : "Uma banana. Um lanche rápido para a aventura.",
	properties_description : "Cura 10 de hp."
}
global.ITEMS_DATA.item_002 = {
	name : "Banana2",
	sprite : "spr_item_banana",
	type : ITEM_TYPES.edible,
	hp_restore : 10,
	info : "Uma banana. Um lanche rápido para a aventura.",
	properties_description : "Cura 10 de hp."
}



// ============= INVENTARIO =============

inventory = [];

inventory_size = 8;

equip_inventory = [];
key_inventory = [];



function add_item(item_id){
	if (array_length(inventory) < inventory_size){
		array_push(inventory, item_id);
		return true;	
	}
	
	return false;
}

function remove_item(item_index){
	if item_index <= inventory_size-1{
		array_delete(inventory, item_index, 1);
		return true;
	}
	return false;
}

function use_item(item_id, item_index){
	show_debug_message("entrou")
	type = item_id.type;
	
	switch(type){
		case 0:
		show_debug_message("USOU")
			var restore_hp_calc = clamp(item_id.hp_restore + obj_player.values.hp, 0, obj_player.values.max_hp)
			show_debug_message(restore_hp_calc)
			obj_player.values.hp = restore_hp_calc;
			show_debug_message(obj_player.values.hp)
			array_delete(inventory, item_index, 1);
		break;
		case 1:
		//to be construido
		break;
	
	}
	
	return false;
}

add_item(global.ITEMS_DATA.item_001)
add_item(global.ITEMS_DATA.item_002)
add_item(global.ITEMS_DATA.item_001)
add_item(global.ITEMS_DATA.item_002)
add_item(global.ITEMS_DATA.item_001)
add_item(global.ITEMS_DATA.item_002)
add_item(global.ITEMS_DATA.item_001)
add_item(global.ITEMS_DATA.item_002)


enum POWER_TYPES {
	heal,
	attack
}

global.DANCE_POWERS_DATA = {};

global.DANCE_POWERS_DATA.heal_prayer = {
	name_pt : "Prece de Cura",
	type: POWER_TYPES.heal,
	dp_cost : 50,
	heal_amount : 24,
	target_type : "single",
	info_pt : function() {
        return "Peça ajuda para o universo. Cura " + string(heal_amount) + " de HP";
    }
}

global.DANCE_POWERS_DATA.tap_dance = {
	name_pt: "Sapateado",
	type: POWER_TYPES.attack,
	dp_cost : 50,
	dmg: 65,
	target_type : "single",
	info_pt : function() {
        return "Um golpe poderoso que atordoa o inimigo, causando " + string(self.dmg) + " de dano.";
    }
}


global.DANCE_POWERS_DATA.waltz_spin = {
	name_pt : "Giro de Valsa",
	type: POWER_TYPES.attack,
	dp_cost : 40,
	dmg: 20,
	target_type : "neighbors",
	info_pt : function() {
        return "Gire, Gire!.";
    },
}

unlocked_powers = [];



function add_power(power_id){
	if !array_contains(unlocked_powers, power_id){
		array_push(unlocked_powers, power_id);
		return true;	
	}
	
	return false;	
}


 add_power(global.DANCE_POWERS_DATA.tap_dance);
 add_power(global.DANCE_POWERS_DATA.heal_prayer);
 add_power(global.DANCE_POWERS_DATA.waltz_spin);

global.GAME_SPRITES = {
	spr_point_tiny,
	spr_point_big,
	spr_point_breakable,
	spr_lamp_downes_lawn_halo
}

