setup = false;
item_id = "item_nao_adicionado";

function ativarinteracao(){
	var inst_manager = obj_game_manager;
	add_item_returned = inst_manager.add_item(item);
	if add_item_returned > 0{
		scr_open_textbox("item_space_available", string(name));
		instance_destroy();
	} else {
		scr_open_textbox("item_space_full", string(name));
	}

}