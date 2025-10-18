depth = -99999;

w_box = 180;
h_box = 15// altura do menu


options = ["DADOS", "ITENS", "OPÇÕES"];

opt_count = array_length(options);
item_types = ["consumiveis", "equipáveis", "especiais"];
item_types_count = array_length(item_types);
sin_t = 0
opt_size = w_box/opt_count

i_options[0] = "Usar"
i_options[1] = "Descartar"
selected_item = undefined;
highlight_color = #FFD44C;


selected_item_action = undefined;
player_hud_width = 80;
player_hud_height = 15;

slide_default_value = sprite_get_height(spr_player_hud_inventory);
slide_move = slide_default_value;

full_h_menu = 120;
tiny_h_menu = 15;
small_h_menu = 25;
padding_opt_boxes = 1;
cam_w = camera_get_view_width(view_camera[0]);
cam_h = camera_get_view_height(view_camera[0]);

sub_menu_height = 10;
sub_menu_width = 60;

opt = 0;
opt_height = 20;
selected_item_type = 0;

selec_box_index = 0;
selec_box_speed = 1;

draw_item_actions = false;
item_substate = ITEM_SUBSTATES.selecting

medium_alpha = 0.5;
high_alpha = 0.8;
max_alpha = 1;


// player mini hud

player_hud_height = sprite_get_height(spr_player_hud_inventory);
player_hud_width = sprite_get_width(spr_player_hud_inventory);
portrait_width = sprite_get_width(spr_player_portrait);


can_use = false;
can_choose = false;

enum MENU_STATES {
	closed,
	main_menu,
	stats_menu,
	item_types_menu,
	item_menu,
	options_menu
}
enum ITEM_SUBSTATES {
	selecting,
	confirming,
	executing
}

state = MENU_STATES.main_menu;

function open_opt_menu(_opt, _submenu = undefined){
	if (_submenu == "item_submenu"){
		selected_item_type = _opt;
		
		switch (_opt){
			
		case 0:
			state = MENU_STATES.item_menu;
			opt = 0;
		break;
		
		}
	} else { 
		switch (_opt){
		
		case 0:
			state = MENU_STATES.stats_menu;
			opt = 0;
		break;
		case 1:
			state = MENU_STATES.item_types_menu;
			selec_box_index = 0;
			opt = 0;
		break;
		case 2:
			state = MENU_STATES.options_menu;
			opt = 0;
		break;
		
		
		}
	}
}


function draw_options(_current_opt, _state){
		var dist = 0;
		var padd = -1; // nesse caso o padd que é a variavel que pega o padding, ele começa em -1 pra deixar as 3 opcoes centralizadas = -1(esq) 0(meio) 1(direita).
		var margin_txt = 5;
		
		var cam_x = obj_camera.x;
		var cam_y = obj_camera.y;
		
		draw_set_font(fnt_main);
		draw_set_valign(fa_middle);
		draw_set_halign(fa_left);
		
		for (var o = 0; o < opt_count; o++){
			
			var s_padd_w_size = (string_width(options[o]))/(opt_count*3);
			var s_h_size = (string_height(options[o]))
			
			var option_x = cam_x - w_box/2 + dist + padd;
			var option_y = cam_y - h_box/2 - opt_height/2;
			
			var c = c_white;
			var a = 1;
			
			//desenhar o fundo das opções
			draw_sprite_stretched(spr_box, 0, option_x, option_y, opt_size, opt_height);
			
			
			if _state == MENU_STATES.main_menu{
				if _current_opt == o{
					c = #FFD44C;
					selec_box_index = scr_animar_sprite(selec_box_index, selec_box_speed, spr_seta_txt);
					draw_main_menu_selector(option_x, option_y, opt_size, opt_height);	
				}	
			} else
			if _state == MENU_STATES.item_menu || MENU_STATES.item_types_menu{
				a = medium_alpha;
				if 1 == o{
					a = high_alpha;
				}
			}
			
			var correction_font_alignment = 1
			draw_options_text(option_x + correction_font_alignment + margin_txt, option_y + s_h_size, options[o], opt_size, padd, c, a)
			
			dist += opt_size;
			padd += padding_opt_boxes
		}
		
		draw_set_valign(fa_top);
}


function draw_main_menu_selector(_x, _y, _w, _h){
	var bigger = 4; //quao maior o seletor vai ser do que as opcoes
	draw_sprite_stretched(spr_seta_txt, selec_box_index, _x, _y - bigger/2, _w, _h + bigger);
}

function draw_options_text(_x, _y, _string, _box_opt_size, _padding, _c, _a){
	var base_size = (1/string_width(_string))
	var margin = 5;
	
	
	var w_calc = (base_size * _box_opt_size) - (base_size * margin*2) - (base_size * _padding)
	
	draw_text_transformed_colour(_x, //LOCAL X
								 _y, //LOCAL Y
								 _string, 
								 w_calc, //TAMANHO 1(padrao da fonte) DIV PELO TAMANHO DO TEXTO(assim conseguimos o valor unitário da fonte) multiplicando pelo tamanho que queremos. depois eu fiz implementação do padding pra ficar mais centralizado
								 1, 0, _c, _c, _c, _c, _a)
}



function draw_item_types_submenu(_opt, _state){
	var cam_x = obj_camera.x;
	var cam_y = obj_camera.y;
	var background_y =  cam_y - h_box/2;
	
	var sub_menus_x = cam_x - sub_menu_width/2;
	var sub_menus_y = background_y + opt_height/2 + (small_h_menu/2 - opt_height/2);
	
	var alpha = 1;
	
	
	draw_set_font(fnt_tiny);
	draw_set_halign(fa_center);
	
	var submenu_padding = sub_menu_width + 1// o "+1" é de fato o padding. o resto é pra alinhanmento dinamico.
	var sm_p = -submenu_padding// porque aqui ele inverte e vai adicionando. ficando: "-1, 0, +1" (funciona apenas para 3 submenus. CONSIDERAR REVER.)
	
	for (var i = 0; i < item_types_count; i++){
		var text_color = c_white;
		draw_sprite_stretched_ext(spr_box, 0, sub_menus_x + sm_p, sub_menus_y, sub_menu_width, sub_menu_height, c_white, 1);
		
		
		if _state == MENU_STATES.item_types_menu{
			if (_opt == i){
			var bigger = 4;
			text_color = highlight_color;
			draw_sprite_stretched_ext(spr_seta_txt, selec_box_index, sub_menus_x + sm_p, sub_menus_y - bigger/2, sub_menu_width, sub_menu_height + bigger, c_white, 1);
			}
		} else
		if _state == MENU_STATES.item_menu{
			alpha = medium_alpha
			if (_opt == i){
				alpha = high_alpha
			}
		}
		
		
		var padding_icon_text = 2;
		var icon_adjust_y = .5
		var icon_width = sprite_get_width(spr_menu_icons_item_types);
		var icon_height = sprite_get_height(spr_menu_icons_item_types);
		var available_space = sub_menu_width - string_width(item_types[i]) - padding_icon_text - icon_width;
		
		draw_sprite_ext(spr_menu_icons_item_types, i, sub_menus_x + sm_p + available_space/2, sub_menus_y + icon_height - icon_adjust_y, 1, 1, 0, text_color, alpha);
		draw_text_color(sub_menus_x + sub_menu_width/2 + sm_p + icon_width, sub_menus_y, item_types[i], text_color, text_color, text_color, text_color, alpha);
		
		sm_p += submenu_padding;
	}
	draw_set_halign(fa_left);
	draw_set_font(fnt_main);
}

function execute_action_item(_option){
	var inst_gm = obj_game_manager;
	var inventory = inst_gm.inventory;
	var type = inventory[selected_item].type;
	
	
	switch _option{
		case 0:
		inst_gm.use_item(inventory[selected_item], selected_item, type);
		break;
		case 1:
		inst_gm.remove_item(selected_item);
		break;
	}
}

function draw_player_hud(){
		
		draw_set_valign(fa_middle);
		draw_set_halign(fa_left);
		draw_set_font(fnt_tiny);
		
		var cam_x = obj_camera.x;
		var cam_y = obj_camera.y;		
	
		var player_hud_x = cam_x - player_hud_width/2;
		var player_hud_y = cam_y + cam_h/2 - player_hud_height + slide_move;
				
		var hud_padding = 3;
		var hud_margin_y = 2;
				
		var hp_x_offset = 16;
		var hp_count_x_offset = hp_x_offset - 10;
		var portrait_offset = 3;
				
		var hp_bar_size = 43;
		var hp_bar_height = 7;
				
		var hp_bar_y_offset = 11
		var hp_bar_x_correction = 1;
			
				

		
		draw_sprite(spr_player_hud_inventory, 0, player_hud_x, player_hud_y);
		draw_sprite(spr_player_portrait, 0, player_hud_x + portrait_offset, player_hud_y + portrait_offset);
				
				
		draw_text(player_hud_x + portrait_offset + portrait_width + hud_padding, player_hud_y + portrait_offset + hud_margin_y, "Cael");
		draw_text_color(player_hud_x - portrait_offset + player_hud_width - hp_x_offset, player_hud_y + portrait_offset + hud_margin_y, "hp:", c_white, c_white, c_white, c_white, medium_alpha);
		draw_text_color(player_hud_x - portrait_offset + player_hud_width - hp_count_x_offset, player_hud_y + portrait_offset + hud_margin_y, string(obj_player.values.hp), highlight_color, highlight_color, highlight_color, highlight_color, 1);
				
		draw_sprite_stretched(spr_healthbar, 0, player_hud_x + portrait_width + portrait_offset + hud_padding + hp_bar_x_correction, player_hud_y + hp_bar_y_offset,(obj_player.values.hp / obj_player.values.max_hp)*hp_bar_size, hp_bar_height)
				
		draw_set_valign(fa_top);
		draw_set_font(fnt_main);
}

function slide_player_hud(_action){
		
		var spd_slide = 0.2;
		var target = 0;
		
		if _action == 0{
			target = slide_default_value;
		} 
		
		if slide_move != target{
			slide_move = lerp(slide_move, target, spd_slide) 
			
		}

}
function slide_box_height(_target){
		
		var spd_slide = 0.2;
		
		if h_box != _target{
			h_box = lerp(h_box, _target, spd_slide);
		}

}


