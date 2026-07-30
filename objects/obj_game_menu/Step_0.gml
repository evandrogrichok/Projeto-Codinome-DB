var accept_key =  keyboard_check_pressed(vk_enter) || keyboard_check_pressed(ord("Z"));
var menu_key =   keyboard_check_pressed(vk_escape) || keyboard_check_pressed(ord("C"));
var back_key =    keyboard_check_pressed(vk_shift) || keyboard_check_pressed(ord("X"));

var l_keys = keyboard_check_pressed(vk_right) or keyboard_check_pressed(ord("D"));
var r_keys = keyboard_check_pressed(vk_left) or keyboard_check_pressed(ord("A"));
var u_keys = keyboard_check_pressed(vk_up) or keyboard_check_pressed(ord("W"));
var d_keys = keyboard_check_pressed(vk_down) or keyboard_check_pressed(ord("S"));

var inst_gm =					  	    obj_game_manager;
var inventory =					   	   inst_gm.inventory;
var i_act_length = array_length(i_options)

_opt_changer =  (global.RIGHT_KEY) - (global.LEFT_KEY);
_opt_changer_v =  (global.DOWN_KEY) - (global.UP_KEY);


if (menu_key && !instance_exists(obj_battle_manager)){
	
	if state == MENU_STATES.closed{
		state = MENU_STATES.main_menu
		scr_can_move_tweaker(-1);
	} else {
	    state = MENU_STATES.closed
		opt = 0;
		h_box = tiny_h_menu;
		item_substate = ITEM_SUBSTATES.selecting;
		slide_move = slide_default_value;
		scr_can_move_tweaker(+1);
		exit;
	}
}

can_use = true;
can_choose = true;
state_has_changed = true;

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
		
		option_changer(opt_count, _opt_changer);
		
	
		if accept_key{
			open_opt_menu(opt);
		}
		
	break;
	
	case MENU_STATES.item_types_menu:
	
		slide_box_height(small_h_menu);
		slide_player_hud(0);
		selec_box_index = scr_animar_sprite(selec_box_index, selec_box_speed, spr_seta_txt);
		
		option_changer(item_types_count, _opt_changer);
		
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
				
				selecting_item();
				if (back_key){
					opt = selected_item_type; // para voltar pro campo do tipo do item escolhido
					state = MENU_STATES.item_types_menu;
				}

			break;
			case ITEM_SUBSTATES.confirming:
				option_changer(i_act_length, _opt_changer_v);
				confirming_usage();
				
			break;
			case ITEM_SUBSTATES.executing:

				executing_usage();

			break;
		}
		
	break;
	
	case MENU_STATES.item_menu_battle:
	depth = DEPTH.LOGIC_TOP;
	slide_box_height(battle_h_menu);
	
	switch(item_substate){
		
			case ITEM_SUBSTATES.selecting:
				
					selecting_item();
					if (back_key){
						state = MENU_STATES.closed;
						item_substate = ITEM_SUBSTATES.selecting;
						h_box = tiny_h_menu;
						obj_battle_manager.state = BATTLE_STATES.main_menu;
						obj_battle_manager.opt = 2;
						obj_battle_manager.alpha_options = array_create(obj_battle_manager.option_count, 1);
						global.TEXTBOX_ALPHA = 1;
						
						
					}

			break;
			case ITEM_SUBSTATES.confirming:
				option_changer(i_act_length, _opt_changer_v);
				confirming_usage();
				
			break;
			case ITEM_SUBSTATES.executing:	
				var item = inst_gm.inventory[selected_item];
				obj_battle_manager.finish_item_selection(item);
						
				
				state = MENU_STATES.closed;
						
				executing_usage()
						

			break;
		}
	break;
	}
}