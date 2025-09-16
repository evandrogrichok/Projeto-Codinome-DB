function scr_menuopt(_opt){
	switch(_opt){
		case 0:
			for(var i = 0; i < array_length(itens) -1; i++){
				for(var j = i+1; j < array_length(itens); j++){
					if itens[i] == "- - -" && itens[j] != "- - -"{
						var aux = itens[i]
						itens[i] = itens[j]
						itens[j] = aux
					}
				}
			}
			
		global.menu_ativo = false
		global.itens_menu = true
		can_consume = false
		break;
		
		case 1:
		can_change = false
		global.menu_ativo = false
		global.config_menu = true
		break;
		
		case 2:
		game_end()
		break;
		}		
}
/*

	if _opt == 2{
		game_end()
	} else
	if _opt == 0{
		
		for(var i = 0; i < array_length(itens) -1; i++){
				for(var j = i+1; j < array_length(itens); j++){
					if itens[i] == "- - -" && itens[j] != "- - -"{
						var aux = itens[i]
						itens[i] = itens[j]
						itens[j] = aux
					}
			}
		}
		
		
		global.menu_ativo = false
		global.itens_menu = true
		can_consume = false
} else if _opt == 1{
		global.menu_ativo = false
		global.config_menu = true
}
}
*/
function scr_useitem(_item_id){
	switch (_item_id){
		case "baladecanela":
			show_message("usado");
	}
}