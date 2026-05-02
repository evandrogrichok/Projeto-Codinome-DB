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



//SETUP INICIAL

setup_objects = [
	obj_player,
	obj_camera,
	obj_game_menu,
]


for (var i = 0; i < array_length(setup_objects); i++){
	var inst = setup_objects[i]
	if !instance_exists(inst){
		instance_create_layer(819, 157, "Instances", inst)
	}
}


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

level_tiers = [
	[0],
	[20],
	[40],
]



if !object_exists(obj_game_menu){
	instance_create_depth(0,0, 16000, obj_game_menu);
}


player_val = obj_player.values;
// =============   ITENS ===============
//TYPE 0 = COMESTIVEL
//TYPE 1 = EQUIPÁVEL
//TYPE 2 = ITENS CHAVE

show_debug_message("CRIOU MANAGER");
global.ITEMS_DATA = {};

global.ITEMS_DATA.item_001 = {
	name : "Banana",
	sprite : "spr_item_banana",
	type : 0,
	hp_restore : 10,
	info : "Uma banana. Um lanche rápido para a aventura.",
	properties_description : "Cura 10 de hp."
}
global.ITEMS_DATA.item_002 = {
	name : "Banana2",
	sprite : "spr_item_banana",
	type : 0,
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
//add_item(global.ITEMS_DATA.item_001)
//add_item(global.ITEMS_DATA.item_001)

global.GAME_SPRITES = {
	spr_point_tiny,
	spr_point_big,
	spr_point_breakable,
	spr_lamp_downes_lawn_halo
}

