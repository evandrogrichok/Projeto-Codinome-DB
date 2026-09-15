if instance_exists(obj_battle_manager){



with(obj_battle_manager){
	
var _inst_player = inst_player;



//tamanho do visor da camera
//var cam_w = camera_get_view_width(view_camera[0]);
//var cam_h = camera_get_view_height(view_camera[0]);
//localizacao do obj cam
var cam_x = inst_camera.x
var cam_y = inst_camera.y
//tamanho dos sprites dos botoes, para calculos de distancia e tudo

//tamanho do hudzinho de vida



//parte >>ESQUERDA<< do alvo setas
var arrow_target_x = cam_x;
var increase_target_size = 0;
//desenhando setas

var arrow_x_distance = 0; 
//var arrows_alpha = 1;

	
		if (state == BATTLE_STATES.arrow_pattern){
				var quant_setas = array_length(arrow_pat)
				var start = arrow_to_draw_from
				
	
				for (var i = 0; i < quant_setas; i++){
		

					// se o i for igual ao arrow to draw from dai ele atribui o cloosest
				
				
				
	
				if arrow_to_draw_from <= i{
					var current_song_time = audio_sound_get_track_position(mus); // pega a posição atual da musica
					var diff = (individual_arrow_time[i] - current_song_time); // no array de tempos das setas, subtrai o tempo atual da musica pegando a diferença
					var dist = diff * vel_setas; // a distancia é calculada multiplicada pela velocidade das setas
					var arrow_pop_effect_mult = 3;
										
					show_debug_message(dist)
					

					if i == arrow_to_draw_from && blink_arrow_effect_timer > 0 && dist < arrow_max_distance{
						scr_shader_paint(255, 255, 255, 1);		
					}
					

					var spd_effect_multiplier = 10;
					var spd_effect = arrow_speed_effect[i] * spd_effect_multiplier;
					
					var arrow_stretch = arrow_stretch_effect[i]
					var arrow_stretch_transform = 2;
					var final_stretch_effect = arrow_stretch * arrow_stretch_transform;
					

		
					switch arrow_pat[i]{
		
						case "right":
						
							draw_sprite_ext(asset_get_index($"spr_seta_{arrow_pat[i]}"), 0, (cam_x) + dist + spd_effect, cam_y, 1 + final_stretch_effect, 1, 0, c_white, arrows_alpha[i]);
							
							if arrow_shine_effect[i] == false{
									draw_sprite_ext(asset_get_index($"spr_arrow_shine_{arrow_pat[i]}"), arrow_shine_index[i], (cam_x) + dist + spd_effect, cam_y, 1 + final_stretch_effect, 1, 0, c_white, arrows_alpha[i]);
								}
								if arrow_to_draw_from == i{
									determine_closest_arrow_xy_pos(cam_x, cam_y, dist, 0);
								}
						break;
						case "left":
							draw_sprite_ext(asset_get_index($"spr_seta_{arrow_pat[i]}"), 0, (cam_x) - dist - spd_effect, cam_y, 1 + final_stretch_effect, 1, 0, c_white, arrows_alpha[i]);
							if arrow_shine_effect[i] == false{
								draw_sprite_ext(asset_get_index($"spr_arrow_shine_{arrow_pat[i]}"), arrow_shine_index[i], (cam_x) - dist - spd_effect, cam_y, 1 + final_stretch_effect, 1, 0, c_white, arrows_alpha[i]);
							}
							
							if arrow_to_draw_from == i{
									determine_closest_arrow_xy_pos(cam_x, cam_y, -dist, 0);
								}
						break;
			
						case "up":
							draw_sprite_ext(asset_get_index($"spr_seta_{arrow_pat[i]}"), 0, cam_x, cam_y - dist - spd_effect, 1, 1+ final_stretch_effect, 0, c_white, arrows_alpha[i]);
								
															if arrow_shine_effect[i] == false{
								draw_sprite_ext(asset_get_index($"spr_arrow_shine_{arrow_pat[i]}"), arrow_shine_index[i], cam_x, cam_y - dist - spd_effect, 1, 1+ final_stretch_effect, 0, c_white, arrows_alpha[i]);
							}
								
								if arrow_to_draw_from == i{
									determine_closest_arrow_xy_pos(cam_x, cam_y, 0, -dist);
								}
			
						break;
			
						case "down":
							draw_sprite_ext(asset_get_index($"spr_seta_{arrow_pat[i]}"), 0, cam_x, cam_y + dist + spd_effect, 1, 1+ final_stretch_effect, 0, c_white, arrows_alpha[i]);
							
																						if arrow_shine_effect[i] == false{
								draw_sprite_ext(asset_get_index($"spr_arrow_shine_{arrow_pat[i]}"), arrow_shine_index[i], cam_x, cam_y + dist + spd_effect, 1, 1+ final_stretch_effect, 0, c_white, arrows_alpha[i]);
							}
							
							if arrow_to_draw_from == i{
									determine_closest_arrow_xy_pos(cam_x, cam_y, 0, +dist);
							}
						break;
			
					}
					shader_reset();		
					//arrows_alpha -= 1/quant_setas;
					}
					//arrow_x_distance += sprite_get_width(spr_seta_up) + padding_between_arrows;	
					//individual_arrow_distance[i] -= vel_setas * global.DELTA_TIME;	

				}
				
				var current_song_time = audio_sound_get_track_position(mus);
				var diff = individual_arrow_time[arrow_to_draw_from] - current_song_time; // a diferenca do tempo da seta menos o tempo atual
				local_seta_mais_proxima = diff * vel_setas;
				//draw_rectangle(closest_arrow_x,closest_arrow_y,closest_arrow_x+2, closest_arrow_y+2, false)
		}
	
	
		var _padding = 0
		var _margin = 2
	
		var portrait_x = (cam_x - cam_w/2 + _margin) + 3
		var portrait_y = (cam_y + cam_h/2 - sprite_player_hud_height - 5) + 3
		var tam_hud = sprite_get_width(spr_player_hud)

		var lifebar_x = (cam_x - cam_w/2 + _margin) + 22
		var lifebar_y = (cam_y + cam_h/2 - sprite_player_hud_height - 5) + 11



		draw_set_valign(fa_middle);
		draw_set_halign(fa_left);
		draw_set_font(fnt_tiny);
		
		//var cam_x = obj_camera.x;
		//var cam_y = obj_camera.y;		
	
		var player_hud_x = cam_x - cam_w/2 + _margin;
		var player_hud_y = cam_y + cam_h/2 - player_hud_height - _margin - height_textbox_battle;
				
		var hud_padding = 3;
		var hud_margin_y = 3;
				
		var hp_x_offset = 16;
		var hp_count_x_offset = hp_x_offset - 10;
		var portrait_offset = 3;
				
		var hp_bar_size = 43;
		var hp_bar_height = 5;
				
		var hp_bar_y_offset = 13
		var hp_bar_x_correction = 1;
			
				

		
		draw_sprite_ext(spr_player_hud, 0, player_hud_x, player_hud_y, 1, 1, 0, c_white, alpha_ui_player);
		draw_sprite_ext(spr_player_portrait, myimage_index, player_hud_x + portrait_offset, player_hud_y + portrait_offset, 1, 1, 0, c_white, alpha_ui_player);
				
				
		draw_text(player_hud_x + portrait_offset + portrait_width + hud_padding, player_hud_y + portrait_offset + hud_margin_y, "Drio");
		draw_text_color(player_hud_x - portrait_offset + player_hud_width - hp_x_offset, player_hud_y + portrait_offset + hud_margin_y, "hp:", c_white, c_white, c_white, c_white, clamp(alpha_ui_player, 0, medium_alpha));
		var color_hp = (area_properties.ui_primary_colors[0])
		draw_text_color(player_hud_x - portrait_offset + player_hud_width - hp_count_x_offset, player_hud_y + portrait_offset + hud_margin_y, string(inst_player.values.hp),color_hp,color_hp,color_hp,color_hp, 1);
			color_hp = merge_color(area_properties.ui_primary_colors[0], area_properties.ui_primary_colors[1], alpha_ui_player)	
		draw_sprite_stretched_ext(spr_dancepoints_bar, 0, player_hud_x + portrait_width + portrait_offset + hud_padding + hp_bar_x_correction, player_hud_y + hp_bar_y_offset,(inst_player.values.hp / inst_player.values.max_hp)*hp_bar_size, hp_bar_height, area_properties.ui_primary_colors[0], 1)
				
		draw_set_valign(fa_top);
		draw_set_font(fnt_main);
		

//var hp_bar_size = 43;
//var hp_bar_height = 7;

//draw_sprite_ext(spr_player_hud, b_subimage[0], cam_x - cam_w/2 + _margin, cam_y + cam_h/2 - sprite_player_hud_height - 5,1,1,0,c_white,1)
//draw_sprite(spr_player_portrait,myimage_index,portrait_x,portrait_y)
//draw_sprite_stretched(spr_healthbar,0,lifebar_x,lifebar_y, (_inst_player.values.hp / max_health)*hp_bar_size, hp_bar_height)

//draw_set_font(fnt_tiny)
//draw_text(portrait_x + 18, portrait_y-3,"Cael")
//draw_text_colour(portrait_x + sprite_get_width(spr_player_hud) - 23, portrait_y-3,"hp:",c_white,c_white,c_white,c_white,.5)
//draw_text_colour(portrait_x + sprite_get_width(spr_player_hud) - 13, portrait_y-3,string(_inst_player.values.hp),c_yellow,c_yellow,c_yellow,c_yellow,1)
//draw_set_font(fnt_main)





if (state == BATTLE_STATES.item_menu || state == BATTLE_STATES.hope_menu || state == BATTLE_STATES.main_menu || state == BATTLE_STATES.power_menu ){
	
		
	for(var i = 0; i < option_count; i++){
			var option = options[i]
			draw_sprite_ext(option[1], b_subimage[i], cam_x + _padding - tam_hud/2 - _margin, cam_y + cam_h/2 - height_textbox_battle - arrow_sprite_height - _margin,1,1,0,c_white, alpha_options[i])
			_padding += 2 + sprite_get_width(option[1]);
	}
	
}






var alt_hud = sprite_get_height(spr_player_hud);
draw_set_font(fnt_tiny);
var width_texto_dp = string_width("DP");
var x_base_info = cam_x - cam_w / 2 + _margin;
var y_base_info = cam_y - cam_h/2 + _margin;
var color_dp = merge_color(area_properties.ui_primary_colors[0], area_properties.ui_primary_colors[1], 0.5);
var correction_width = 1;
var correction_text = 1;

draw_text_color(x_base_info, y_base_info - correction_text*2, "DP:", color_dp, color_dp, color_dp, color_dp, 1);

draw_rectangle_colour(x_base_info + width_texto_dp + padding_hud, y_base_info, x_base_info + width_texto_dp + padding_hud + tam_hud - width_texto_dp - padding_hud,  y_base_info + height_focus_points_hud, #000F38, #000F38, #000F38, #000F38, false);
draw_sprite_stretched_ext(spr_dancepoints_bar, 0, x_base_info + width_texto_dp + padding_hud, y_base_info, (focus_points_draw / max_focus_points) * (tam_hud - width_texto_dp - padding_hud), height_focus_points_hud, area_properties.ui_primary_colors[1], 1);
draw_sprite_stretched(spr_layout_dance_points, 0, x_base_info + width_texto_dp + padding_hud-1, y_base_info, tam_hud - width_texto_dp - padding_hud + correction_width, height_focus_points_hud);


if (state == BATTLE_STATES.power_menu){
	
	//power_menu_width = 100;
	//power_menu_height = 100;
	
	var color = highlight_color;

	
	var _x =  obj_camera.x - power_menu_width/2 + tam_hud/2;
	var _y =  obj_camera.y - power_menu_height/2 - height_textbox_battle/2 - opt_height/2;
	var spacing = 3;
	
	draw_sprite_stretched(spr_box, 0, _x, _y, power_menu_width, power_menu_height);
	_x += spacing
	_y += spacing
	var padding_height_text = string_height("A");
	
	
	heading_menu_height = 11;
	draw_sprite_stretched(spr_box, 0, _x, _y, power_menu_width - spacing * 2 , heading_menu_height);
	
	draw_text_color(_x + spacing, _y + 1, "Nome", color, color,color, color, 1)
	var _string_width = string_width("Custo ");
	draw_text_color(_x  + (power_menu_width - spacing * 2) - _string_width, _y + 1, "Custo", color,color,color,color,1);
	
	
	var inst_mg = get_instance("manager");
	var powers_array = inst_mg.unlocked_powers
	
	
	description_menu_height = heading_menu_height *3
	
	draw_sprite_stretched(spr_box, 0, _x, _y + power_menu_height - spacing * 2 - description_menu_height, power_menu_width - spacing * 2 , description_menu_height);
	
	for (var i = 0; i < array_length(powers_array); i++){
		var alpha = .4;
		color = c_white;
		
		if (i == opt){
			color = highlight_color;
			alpha = 1
			
			if (focus_points < powers_array[opt].dp_cost){
				color = c_white;
				alpha = .4;
			}
			
			
			draw_sprite_stretched_ext(spr_seta_txt, 0, _x,
				  _y + spacing/2 + heading_menu_height + padding_height_text * i, power_menu_width - spacing*2, padding_height_text + spacing, c_white, 1);
		} 
		
		//desenhando nome
		draw_text_color(_x + spacing,
				  _y + spacing + heading_menu_height + padding_height_text * i,
				  powers_array[i].name_pt,
				  color,color,color,color,alpha)
		
		//desenhando custo
		draw_text_color(_x + (power_menu_width - spacing * 2) - _string_width,
						_y + spacing + heading_menu_height + padding_height_text * i,
						string( powers_array[i].dp_cost) + " DP",
						color,color,color,color,alpha)
						
		//desenhando desc
		draw_text_ext_color(_x + spacing,
				  _y + power_menu_height - spacing - description_menu_height,
				  powers_array[opt].info_pt(), padding_height_text,
				  power_menu_width - spacing * 4,
				  c_white, c_white, c_white, c_white, 1)
	
	}
	
	

}

//	var range = 10;
	
//	part_emitter_region(part_system_hope, part_emitter_hope, _inst_player.x-10 - range, _inst_player.x-10 + range, _inst_player.y - range, _inst_player.y + range, ps_shape_rectangle, ps_distr_linear);
//	if global.UP_KEY or global.DOWN_KEY or global.LEFT_KEY or global.RIGHT_KEY
//	part_emitter_burst(part_system_hope, part_emitter_hope, 0, 220);
	
//	var padd = 0;
//draw_text_transformed(cam_x - cam_w/2, cam_y -cam_h/2 + 5*padd, "hoepdir: " + string(inst_player.hope_dir), 0.5, 0.5, 0)


draw_sprite_ext(spr_vignette_color, 0, cam_x - cam_w/2, cam_y-cam_h/2, 1, 1, 0, color_vignette_beat, alpha_vignette_beat)
}

}