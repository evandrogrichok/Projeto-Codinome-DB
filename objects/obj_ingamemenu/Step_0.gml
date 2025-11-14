var accept_key =  keyboard_check_pressed(vk_enter) || keyboard_check_pressed(ord("Z"));
var menu_key =   keyboard_check_pressed(vk_escape) || keyboard_check_pressed(ord("C"));
var back_key =    keyboard_check_pressed(vk_shift) || keyboard_check_pressed(ord("X"));

var l_keys = keyboard_check_pressed(vk_right) or keyboard_check_pressed(ord("D"));
var r_keys = keyboard_check_pressed(vk_left) or keyboard_check_pressed(ord("A"));
var u_keys = keyboard_check_pressed(vk_up) or keyboard_check_pressed(ord("W"));
var d_keys = keyboard_check_pressed(vk_down) or keyboard_check_pressed(ord("S"));

var inst_gm =					  	    obj_game_manager;
var inventory_length =   array_length(inst_gm.inventory);
var inventory =					   	   inst_gm.inventory;
var i_act_length = array_length(i_options)

var _opt_changer =  (r_keys) - (l_keys);
var _opt_changer_v = (d_keys) - (u_keys) ;


if (menu_key){
	
	if state == MENU_STATES.closed{
		state = MENU_STATES.main_menu
	} else {
	    state = MENU_STATES.closed
		opt = 0;
		h_box = tiny_h_menu;
		item_substate = ITEM_SUBSTATES.selecting;
		slide_move = slide_default_value;
		exit;
	}
}

can_use = true;
can_choose = true;
var state_has_changed = true;

while(state_has_changed){
	
	state_has_changed = false;
	
	switch(state){
	case MENU_STATES.main_menu:
	
		if (back_key){
			h_box = tiny_h_menu;
			opt = 0;
			state = MENU_STATES.closed;
		}
		
		
	
		
		slide_box_height(tiny_h_menu);
		
		opt += _opt_changer
		opt = (opt + opt_count) mod opt_count;
	
		if _opt_changer != 0 
		selec_box_index = 0; 
	
		if accept_key{
			open_opt_menu(opt);
		}
		
	break;
	
	case MENU_STATES.item_types_menu:
	
		slide_box_height(small_h_menu);
		slide_player_hud(0);
		selec_box_index = scr_animar_sprite(selec_box_index, selec_box_speed, spr_seta_txt);
		
		if _opt_changer != 0 
		selec_box_index = 0; 		
		
		opt += _opt_changer
		opt = (opt + item_types_count) mod item_types_count;
		
		if accept_key{
			open_opt_menu(opt, "item_submenu");
		}
		
		if (back_key){
			opt = 1; // para voltar pro campo item 
			state = MENU_STATES.main_menu;
			slide_move = slide_default_value;
		}
		
	break;
	
	case MENU_STATES.item_menu:
	
	slide_box_height(full_h_menu);
	slide_player_hud(1);
	
	switch(item_substate){
		
			case ITEM_SUBSTATES.selecting:
				
				if inventory_length > 0{
					opt += _opt_changer_v
					opt = (opt + inventory_length) mod inventory_length;
					if accept_key && can_choose{
						selected_item = opt
						opt = 0;
						item_substate = ITEM_SUBSTATES.confirming
						draw_item_actions = true;
						can_use = false;
						state_has_changed = true;
					}
					

				}
				
				if (back_key){
					opt = selected_item_type; // para voltar pro campo do tipo do item escolhido
					state = MENU_STATES.item_types_menu;
				}
			break;
			case ITEM_SUBSTATES.confirming:
				
				opt += _opt_changer_v
				opt = (opt + i_act_length) mod i_act_length;
				
				if (back_key){
					opt = selected_item
					item_substate = ITEM_SUBSTATES.selecting;
				}
				
				if accept_key && can_use{
					selected_item_action = opt;
					item_substate = ITEM_SUBSTATES.executing
					state_has_changed = true;
				}
			break;
			case ITEM_SUBSTATES.executing:
					item_substate = ITEM_SUBSTATES.selecting
					execute_action_item(selected_item_action);
					inventory_length = array_length(inventory)
					can_choose = false;
					state_has_changed = true
				
			break;
		}
		
	break;
	}
}