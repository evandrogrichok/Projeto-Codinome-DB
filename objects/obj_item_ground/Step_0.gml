if instance_exists(obj_game_manager) && setup == false{
	data = global.ITEMS_DATA
	
	if item_id == "item_nao_adicionado"{
		var str = "ITEM NAO ADICIONADO NO CONTAINER. DEFINA 'ITEM_ID' NA VARIAVEL DE CRIACAO DA INSTANCIA."
		show_error(str, false)
	}
	if variable_struct_get(data, item_id) == undefined{
		var str = "ITEM "+ string(item_id) +"NÃO ENCONTRADO."
		show_error(str, false)
	}
	
	item = variable_struct_get(data, item_id);
	sprite = item.sprite
	name = item.name
	
	sprite_index = asset_get_index(sprite);
	
	setup = true;
}

