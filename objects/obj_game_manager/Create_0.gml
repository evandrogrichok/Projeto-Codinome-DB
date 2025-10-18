
//CONFIGURAÇÕES
game_set_speed(60, gamespeed_fps);
gpu_set_texfilter(false);
window_set_fullscreen(false);

//level tiers [0] == xp necessário

level_tiers = [
	[0],
	[20],
	[40],
]


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
	
	type = item_id.type;
	
	switch(type){
		case 0:
			var restore_hp_calc = clamp(item_id.hp_restore + player_val.hp, 0, player_val.max_hp)
			player_val.hp = restore_hp_calc;
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