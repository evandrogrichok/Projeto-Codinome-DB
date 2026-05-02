if instance_exists(obj_battle_manager){



with(obj_battle_manager){
	
var _inst_player = obj_player;



//tamanho do visor da camera
//var cam_w = camera_get_view_width(view_camera[0]);
//var cam_h = camera_get_view_height(view_camera[0]);
//localizacao do obj cam
var cam_x = obj_camera.x
var cam_y = obj_camera.y
//tamanho dos sprites dos botoes, para calculos de distancia e tudo

//tamanho do hudzinho de vida



//parte >>ESQUERDA<< do alvo setas
var arrow_target_x = cam_x;
var increase_target_size = 0;
//desenhando setas

var arrow_x_distance = 0; 
var arrows_alpha = 1;

	
		if (state == BATTLE_STATES.arrow_pattern){
				var quant_setas = array_length(arrow_pat)
				var start = arrow_to_draw_from
	
				for (var i = 0; i < quant_setas; i++){
		
		
					// se o i for igual ao arrow to draw from dai ele atribui o cloosest
		
	
				if arrow_to_draw_from <= i{
					var current_song_time = audio_sound_get_track_position(mus); // pega a posição atual da musica
					var diff = (individual_arrow_time[i] - current_song_time); // no array de tempos das setas, subtrai o tempo atual da musica pegando a diferença
					var dist = diff * vel_setas; // a distancia é calculada multiplicada pela velocidade das setas 
		
					switch arrow_pat[i]{
		
						case "right":
							draw_sprite_ext(asset_get_index($"spr_seta_{arrow_pat[i]}"), 0, (cam_x) + dist, cam_y, 1, 1, 0, c_white, arrows_alpha);
								if arrow_to_draw_from == i{
									determine_closest_arrow_xy_pos(cam_x, cam_y, dist, 0);
								}
						break;
						case "left":
							draw_sprite_ext(asset_get_index($"spr_seta_{arrow_pat[i]}"), 0, (cam_x) - dist, cam_y, 1, 1, 0, c_white, arrows_alpha);
								if arrow_to_draw_from == i{
									determine_closest_arrow_xy_pos(cam_x, cam_y, -dist, 0);
								}
						break;
			
						case "up":
							draw_sprite_ext(asset_get_index($"spr_seta_{arrow_pat[i]}"), 0, cam_x, cam_y - dist, 1, 1, 0, c_white, arrows_alpha);
								if arrow_to_draw_from == i{
									determine_closest_arrow_xy_pos(cam_x, cam_y, 0, -dist);
								}
			
						break;
			
						case "down":
							draw_sprite_ext(asset_get_index($"spr_seta_{arrow_pat[i]}"), 0, cam_x, cam_y + dist, 1, 1, 0, c_white, arrows_alpha);
							if arrow_to_draw_from == i{
									determine_closest_arrow_xy_pos(cam_x, cam_y, 0, +dist);
							}
						break;
			
					}
		
					arrows_alpha -= 1/quant_setas;
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
		var _margin = 5
	
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
			
				

		
		draw_sprite(spr_player_hud, 0, player_hud_x, player_hud_y);
		draw_sprite(spr_player_portrait, myimage_index, player_hud_x + portrait_offset, player_hud_y + portrait_offset);
				
				
		draw_text(player_hud_x + portrait_offset + portrait_width + hud_padding, player_hud_y + portrait_offset + hud_margin_y, "Cael");
		draw_text_color(player_hud_x - portrait_offset + player_hud_width - hp_x_offset, player_hud_y + portrait_offset + hud_margin_y, "hp:", c_white, c_white, c_white, c_white, medium_alpha);
		draw_text_color(player_hud_x - portrait_offset + player_hud_width - hp_count_x_offset, player_hud_y + portrait_offset + hud_margin_y, string(obj_player.values.hp), highlight_color, highlight_color, highlight_color, highlight_color, 1);
				
		draw_sprite_stretched(spr_healthbar, 0, player_hud_x + portrait_width + portrait_offset + hud_padding + hp_bar_x_correction, player_hud_y + hp_bar_y_offset,(obj_player.values.hp / obj_player.values.max_hp)*hp_bar_size, hp_bar_height)
				
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





if (state == BATTLE_STATES.item_menu || state == BATTLE_STATES.hope_menu || state == BATTLE_STATES.main_menu ){
	
	
	
	
	for(var i = 0; i < option_count; i++){
			var option = options[i]
			draw_sprite_ext(option[1], b_subimage[i], cam_x + _padding - tam_hud/2 - _margin, cam_y + cam_h/2 - height_textbox_battle - arrow_sprite_height - _margin,1,1,0,c_white, alpha_options[i])
			_padding += 2 + sprite_get_width(option[1]);
	}
	
	

	
}

var alt_focus_points = 6;
var padding_hud = 5;
var alt_hud = sprite_get_height(spr_player_hud);
draw_set_font(fnt_tiny);
var width_texto_dp = string_width("DP");
var x_base_info = cam_x - cam_w / 2 + _margin;
var y_base_info = cam_y + cam_h/2 - alt_hud - padding_hud - _margin - height_textbox_battle;

draw_text( x_base_info, y_base_info - string_height("A")/2, "DP:");

draw_rectangle_colour(x_base_info + width_texto_dp + padding_hud, y_base_info - alt_focus_points/2, x_base_info + width_texto_dp + padding_hud + tam_hud - width_texto_dp - padding_hud,  y_base_info - alt_focus_points/2 + alt_focus_points, #000F38, #000F38, #000F38, #000F38, false);
draw_sprite_stretched(spr_hopebar, 0, x_base_info + width_texto_dp + padding_hud, y_base_info - alt_focus_points/2, (focus_points_draw / max_focus_points) * (tam_hud - width_texto_dp - padding_hud), alt_focus_points);
draw_sprite_stretched(spr_layout_dance_points, 0, x_base_info + width_texto_dp + padding_hud-1, y_base_info - alt_focus_points/2, tam_hud - width_texto_dp - padding_hud+2, alt_focus_points);


//	var range = 10;
	
//	part_emitter_region(part_system_hope, part_emitter_hope, _inst_player.x-10 - range, _inst_player.x-10 + range, _inst_player.y - range, _inst_player.y + range, ps_shape_rectangle, ps_distr_linear);
//	if global.UP_KEY or global.DOWN_KEY or global.LEFT_KEY or global.RIGHT_KEY
//	part_emitter_burst(part_system_hope, part_emitter_hope, 0, 220);
	
//	var padd = 0;
//draw_text_transformed(cam_x - cam_w/2, cam_y -cam_h/2 + 5*padd, "hoepdir: " + string(obj_player.hope_dir), 0.5, 0.5, 0)


draw_sprite_ext(spr_vignette_color, 0, cam_x - cam_w/2, cam_y-cam_h/2, 1, 1, 0, color_vignette_beat, alpha_vignette_beat)
}

}