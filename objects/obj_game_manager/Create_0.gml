// =============   ITENS ===============
//TYPE 0 = COMESTIVEL
//TYPE 1 = EQUIPÁVEL

show_debug_message("CRIOU MANAGER");
global.ITEMS_DATA = {};

global.ITEMS_DATA.item_001 = {
	name : "banana",
	sprite : "spr_item_banana",
	type : 0,
	hp_restore : 10,
	info : "Uma banana."
}

// ============= INVENTARIO =============

inventory = [];
inventory_size = 8;




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