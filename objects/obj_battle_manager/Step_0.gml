if keyboard_check(vk_f10){
room_goto(rm_downes_lawn_01);
inst_camera.fixated_camera = false;
scr_can_move_tweaker(+1);
audio_stop_sound(mus);
audio_play_sound(snd_something_started_to_change, 5, true);
inst_player.mask_index = inst_player.sprite_index;
}



var l_keys = global.LEFT_KEY
var r_keys = global.RIGHT_KEY;
var u_keys = global.UP_KEY;
var d_keys = global.DOWN_KEY;
var accept_key = global.ACCEPT_KEY;
var deny_key = global.BACK_KEY;
var opt_changer =  (r_keys) - (l_keys);
var vertical_opt_changer = (d_keys) - (u_keys) ;

arrow_target_x = inst_camera.x;
arrow_target_y = inst_camera.y;

//show_debug_message("HP: " + string(get_instance("player").values[$ "hp"]));

if focus_points_draw != focus_points {
	focus_points_draw = lerp(focus_points_draw, focus_points, spd_fp_draw);
}

if height_textbox_battle != dest_height_textbox_battle{
	var lerp_speed = 0.2
	
	height_textbox_battle = lerp(height_textbox_battle, dest_height_textbox_battle, lerp_speed)
}
if enemy_name_appear_effect != 0{
	var lerp_speed = 0.2
	enemy_name_appear_effect = lerp(enemy_name_appear_effect, 0, lerp_speed)
}


if (instance_exists(obj_game_manager) && setted_up_lang = false){
setup_lang();
setted_up_lang = true;
}

pattern_start_time = audio_sound_get_track_position(mus);

var last_beat = beat;
beat = floor(audio_sound_get_track_position(mus)/bpm_seconds);
beat_time = floor(audio_sound_get_track_position(mus)/bpm_seconds) * bpm_seconds;

if (last_beat != beat){
	screen_effects();
	can_run_attack_script = true;
}

if (alpha_barra_ini > 0){
	lower_alpha_enemy_bar();
}


if (alpha_ui_player != alpha_ui_player_target){
	alpha_ui_player = lerp(alpha_ui_player, alpha_ui_player_target, 0.1);
}

if shake_level > 0 {
	shake_level -= 0.1
	shaking = true;
}else{
	shaking = false;
}

//show_debug_message(focus_points_draw);

//localizacao do obj cam
var cam_x = inst_camera.x
var cam_y = inst_camera.y;



//inimigos
var enemy_count = array_length(enemies_combo);
var enemy_count_alive = array_length(inimigos_vivos);

//show_debug_message(global.can_move)

if alpha_options != [1, 1, 1, 1] && state != BATTLE_STATES.item_menu{
	alpha_options = array_create(option_count, 1);
}


if text_to_draw[0] != ""{

	switch (text_to_draw[1]){
	case TXT_TYPES.arrow_accuracy:
	rot_text = lerp(rot_text, rot_text_dest, 0.2);
	size_text = lerp(size_text, size_text_big, 0.2);
	if alpha_txt_to_draw > 0{
		alpha_txt_to_draw -= 0.01;
		text_initial_x_position = text_initial_x_position  + (text_final_x_position - text_initial_x_position) * 0.1;
	} else {
		reset_text_to_draw(TXT_TYPES.arrow_accuracy);
	}

	break;
	case TXT_TYPES.on_beat:
	rot_text = lerp(rot_text, rot_text_dest, 0.2);
	size_text = lerp(size_text, size_text_big, 0.2);
	
	if alpha_txt_to_draw > 0{
		if (state != BATTLE_STATES.enemy_turn){
			alpha_txt_to_draw = 0;
			reset_text_to_draw(TXT_TYPES.on_beat);
		} else {
		alpha_txt_to_draw -= 0.02;		
		}
	} else {
		reset_text_to_draw(TXT_TYPES.on_beat);
	}

	break;
	
	case TXT_TYPES.enemy_damage:
	if alpha_txt_to_draw > 0{
		if (index_dmg < string_length(text_to_draw[0])){
			dmg_char_timer++;

			if (dmg_char_timer >= dmg_char_delay){
			    dmg_char_timer = 0;

			    index_dmg++;

			    scale_pop_effect[index_dmg - 1] = -size_text;
			}
		}
		
		var dmg_count = min(index_dmg, array_length(scale_pop_effect));
		
		for (var i = 0; i < dmg_count; i++){
			if scale_pop_effect[i] != 0{
				scale_pop_effect[i] = lerp(scale_pop_effect[i], 0, 0.5)
			}
			
			if (blink_dmg[i]){
			    dmg_blink_timer[i]++;

			    if (dmg_blink_timer[i] >= dmg_blink_delay){
			        blink_dmg[i] = false;
			    }
			} else {
			sat_attack_text[0] = dest_attack_text_hsv[0][1];
			sat_attack_text[1] = dest_attack_text_hsv[1][1];
			}
		}
		
		dmg_copy_string = string_copy(text_to_draw[0], 1, index_dmg);

		if (!can_lower_dmg_txt_alpha){
			dmg_alpha_timer++;

		    if (dmg_alpha_timer >= dmg_alpha_delay){
		        can_lower_dmg_txt_alpha = true;
		    }
		} else {
			alpha_txt_to_draw -= 0.1
		}
		
		text_initial_x_position = text_initial_x_position  + (text_final_x_position - text_initial_x_position) * 0.1;
		size_text = lerp(size_text, size_text_big, 0.2);
	
		hue_attack_text[0] = lerp(hue_attack_text[0], dest_attack_text_hsv[0][0], .1)
		hue_attack_text[1] = lerp(hue_attack_text[1], dest_attack_text_hsv[1][0], .2)
	}
	
	if (alpha_txt_to_draw <= 0) {
		reset_text_to_draw(TXT_TYPES.enemy_damage)
	}
	
	break;
	}
}

sin_t += 0.05

if alpha_vignette_beat > 0 {
alpha_vignette_beat = lerp(alpha_vignette_beat, .6, 0.2);
}

if target_rot_effect != 0 {
	target_rot_effect = lerp(target_rot_effect, 0, 0.3);
}

//if (keyboard_check_pressed(vk_space))
//{
//    screen_save("screenshot.png");
//}



for(var i = 0; i < enemy_count; i++){
	if state != BATTLE_STATES.enemy_turn{
		enemies_index[i] = scr_animar_sprite(enemies_index[i], enemies_speed[i], enemies_data[i].sprite_ini);
	} else {
		enemies_index[i] = scr_animar_sprite(enemies_index[i], enemies_speed[i], enemies_data[i].sprite_ini_atk);
	}
	
	if (enemies_data[i].current_hp <= 0 && enemies_draw_defeat_state[i] == ENEMIES_DRAW_STATES.cursed){	
		draw_away[i] = lerp(draw_away[i], 20, 0.01);
		fade_away[i] += -0.05;
		update_percentage_enemy_text_width(i)
		if fade_away[i] <= 0{
			enemies_draw_defeat_state[i] = ENEMIES_DRAW_STATES.purified;
			draw_away[i] = 0;
			fade_away[i] = 3;
		}
	} 
	
	
	
	if (state == BATTLE_STATES.attacking){	
		pct_enemy_purify[i] = clamp(round(((enemies_data[i].hp_max - enemies_data[i].current_hp) / enemies_data[i].hp_max) * 100), 0, 100);
		percentage_text_enemy[i] = (string(pct_enemy_purify[i]) + "%");
		
		update_percentage_enemy_text_width(i);
	}	
}


can_use = true;





switch (state){
	case (BATTLE_STATES.main_menu):
	alpha_vignette = lerp(alpha_vignette, alpha_vignette_low, 0.1);
	state_main_menu(opt_changer, l_keys, r_keys, accept_key, deny_key);
	break;
	
	case (BATTLE_STATES.item_menu):
	alpha_vignette = lerp(alpha_vignette, alpha_vignette_high, 0.1);
	break;
	case (BATTLE_STATES.power_menu):
		opt += vertical_opt_changer;
		var u_powers = get_instance("manager").unlocked_powers;
		var option_number = array_length(u_powers);
		opt = (opt + option_number) mod option_number;
	
		if vertical_opt_changer != 0{
			audio_play_sound(snd_key, 3, false);
		}
		
		if accept_key{
			
			if (focus_points >= u_powers[opt].dp_cost){
			cast_power(u_powers[opt]);
			} else {
				
			}
		}
		
		if deny_key{
			state = BATTLE_STATES.main_menu;
			opt = 1;
		}
		
	break;
	
	case (BATTLE_STATES.select_enemy):
	alpha_vignette = lerp(alpha_vignette, alpha_vignette_high, 0.1);
	state_select_enemy(accept_key, deny_key, u_keys, d_keys);
	break;
	
	case (BATTLE_STATES.execute_actions):
	
	//aqui ele vai passar para cada coiso os parametros necessários, eles vao passar pelo ciclo natural deles e vão voltar pra cá
	//se terminou, eles vao pro turno inimigo
	
	if (current_action < array_length(battle_actions)){
		execute_action(battle_actions[current_action]);
		current_action ++; 
	} else {
		state = BATTLE_STATES.textbox_event;
		show_debug_message("queue")
		show_debug_message(textbox_queue)
		id_textbox_queue = scr_open_textbox(textbox_queue);
	}
	
	
	
	break;
	
	case (BATTLE_STATES.arrow_pattern):
	
	alpha_vignette = lerp(alpha_vignette, alpha_vignette_high, 0.1);
	dist_seta_alvo = point_distance(arrow_target_x, cam_y, closest_arrow_x, closest_arrow_y);	
	
	var quant_setas = array_length(arrow_pat);
	var dist_alvo = dist_seta_alvo;
	var is_last_arrow = bool(quant_setas == (array_length(player_arrow_pat)+1));

	for(var k = 0; k < array_length(keys); k++){
		var key = keys[k]
		var range_text = 5;
		
		if (keyboard_check_pressed(key[0]) && array_length(player_arrow_pat) < quant_setas){
		var params = undefined;
		
		target_rot_effect = choose(20, -20);

			if (key[1] == arrow_pat[arrow_to_draw_from]){
			
			
			if (!is_last_arrow){
			var new_sprite = random_dance_sprite;

			while (new_sprite == random_dance_sprite){
				new_sprite = irandom(array_length(player_dance_sprites)-1);
			}

			random_dance_sprite = new_sprite;

			inst_player.sprite_index = player_dance_sprites[random_dance_sprite];
			inst_player.blob_effect(0.8, 1.3);
			}
						
			draw_arrow_feedback(dist_alvo);
			params = search_for_param_accuracy(dist_alvo);
			setup_text_draw(params[2],TXT_TYPES.arrow_accuracy,params[1]);
			play_arrow_sfx(true, params[0]);
			emmit_arrow_particles();
			//procurando o parametro certo para desenhar
		} else {
			//var params sempre recebe a ultima linha do array pra pegar os parametros de erro, só por organizacao
			if (!is_last_arrow){
				inst_player.sprite_index = spr_player_ploft;
				inst_player.blob_effect(0.8, 1.3);
			}
			
			
			draw_arrow_feedback(dist_alvo);
			params = search_for_param_accuracy(dist_alvo, true);
			
			setup_text_draw(params[2],TXT_TYPES.arrow_accuracy, params[1])
			audio_play_sound(snd_arrow_miss, 2, false, 2, 0, .5)
			
		}
		array_push(player_arrow_pat, [key[1], dist_alvo, params[ARRAY_PARAM_INDEXES.dmg_value_mult]])
		arrow_to_draw_from ++
		
		}
	}

	
	if ((local_seta_mais_proxima < x_lim_setas) && array_length(player_arrow_pat) < quant_setas){
		draw_arrow_feedback(max_distance_arrow);
		var params = search_for_param_accuracy(max_distance_arrow, true);
		setup_text_draw(params[2],params[1], TXT_TYPES.arrow_accuracy)
		arrow_to_draw_from ++;
		array_push(player_arrow_pat, ["miss", max_distance_arrow, params[ARRAY_PARAM_INDEXES.dmg_value_mult]]);
	}
	
	if (quant_setas == array_length(player_arrow_pat)){
		
		dmg = calculate_damage(quant_setas)
		reset_arrow_pattern_vars(quant_setas);
		
		state = BATTLE_STATES.attacking
		
		if !(textbox_num >= array_length(encounter_dialogue)){
		add_message_to_queue(encounter_dialogue[textbox_num]);
		}
		flag_atacando = true;
	}
	
	break;
	
	case BATTLE_STATES.attacking:
	
	
		if flag_atacando{
			inst_player.sprite_index = spr_player_attack_horizontal;
			inst_player.image_index = 0;
			inst_player.blob_effect(0.8, 1.3);
			flag_atacando = false;
		}
		
		if inst_player.image_index >= inst_player.image_number-1 {
			
			inst_player.sprite_index = spr_player_idle_battle;
			
			//if (textbox_queue != undefined){
			//	show_debug_message(textbox_queue)
			//	//id_textbox_queue = scr_open_textbox(textbox_queue[textbox_index]);
			//}
			
			state = BATTLE_STATES.execute_actions;
			//dest_height_textbox_battle = default_height_textbox_battle;
			//mudança
			
			//ATUALIZANDO ARRAY DE INIMIGOS VIVOS
		
			//deleta os inimigos que tinha antes
			reload_alive_enemies_array()

		} else if (inst_player.image_index == 5) {
					
			if (enemies_data[opt].current_hp - dmg <= 0){
				audio_play_sound(snd_glitter, 3, false);
			}
			
			enemies_data[opt].current_hp -= dmg;
			
			
			setup_text_draw(dmg, TXT_TYPES.enemy_damage)
			
			
			if enemies_data[opt].current_hp > 0{
				shake_level = 3
			}
			
		}
	break;
	
	case BATTLE_STATES.attacking_power:
			if (power_to_cast == global.DANCE_POWERS_DATA.tap_dance){
				last_index = bang_index;
				bang_index = scr_animar_sprite(bang_index, bang_speed, spr_bang);
				if (bang_index < last_index){
					random_pos_x = irandom_range(-range_bang_pos, range_bang_pos);
					random_pos_y = irandom_range(-range_bang_pos, range_bang_pos);
					inst_camera.cam_shake(1, 3)
					count_tap_dance++;
					shake_level = 3;
				}
				
				if (count_tap_dance >= 3){
					state = BATTLE_STATES.attacking;
					flag_atacando = true;
					
					casting_power = false;
					count_tap_dance = 0;
					
					dmg = power_to_cast.dmg
					last_index = 0;
		
					if !(textbox_num >= array_length(encounter_dialogue)){
					add_message_to_queue(encounter_dialogue[textbox_num]);
					}
				}
			}
			if (power_to_cast == global.DANCE_POWERS_DATA.heal_prayer){
				last_index = hp_index
				hp_index = scr_animar_sprite(hp_index, hp_speed, spr_hp_recover);
				scr_lerp_player_paint_color(87, 255, 167, 0, .1);
				
				if (hp_index < last_index){
					scr_player_paint_color(255, 255, 255, 0);
					casting_power = false;
					
					state_transition(BATTLE_STATES.transition_enemy_turn)
					
				}
			}
			
	break;
	
	case BATTLE_STATES.transition_main_menu:
	
	
	
		if wait_time_over() {
			global.sin_t_points = 0;
			state = BATTLE_STATES.main_menu;
			inst_player_tweak = false;
			tempo_inicio = 0;
			duracao = 0;
			opt = 0;
			create_environmental_textbox();
		} else {
			var t = clamp((wait_time - wait_timer) / wait_time, 0, 1);
			inst_player.move_to(player_initial_position[0], player_initial_position[1], "abs", t);
			
			black_player_col_enemy_turn = lerp(black_player_col_enemy_turn, 255, t);	
			black_bg_color_alpha = lerp(black_bg_color_alpha, 0, t);
			
			scr_update_player_blend_color(black_player_col_enemy_turn, black_player_col_enemy_turn, black_player_col_enemy_turn);
			
			global.ALPHA_PLAYER = lerp(global.ALPHA_PLAYER, 1, t);
			global.ALPHA_PLAYER_BORDER = lerp(global.ALPHA_PLAYER_BORDER, 1, t);
			global.RADIUS_HOPE_LIGHT =  lerp(global.RADIUS_HOPE_LIGHT, 0, t);
		}
	

	break;
	
	case BATTLE_STATES.transition_enemy_turn:
	
		alpha_vignette = lerp(alpha_vignette, alpha_vignette_low, 0.1);
		
		if wait_time_over() {
			alpha_ui_player_target = alpha_ui_player_low;
			state = BATTLE_STATES.enemy_turn;
			global.can_move += 1;
			inst_player.facing_x = 1;
			fade_in_alpha = 0;
			sin_t = 0;
			
			
		} else {
			caixa_valores.default_box.caixa_posicao_x = inst_camera.x - 30;
			caixa_valores.default_box.caixa_posicao_y = inst_camera.y + 10;
			mostrar_limites_de_movimentacao = true;
			
		}
		
	break;
	
	case BATTLE_STATES.transition_battle_won:
		if wait_time_over(){
			state = BATTLE_STATES.battle_won;
			scr_open_textbox([new _msg("<wave> Você venceu!</wave> Você ganhou <wave>" + string(run_xp(inst_player)) + "</wave> XP e <wave>" + string(run_gold(inst_player)) + "</wave> gold!", "battle_event","spr_textbox_battle",,,,,,3)])
			
		} else {
			inst_player.sprite_index = spr_player_finish;
		}
	break;
	
	case BATTLE_STATES.textbox_event:
	
		
	
		if !instance_exists(id_textbox_queue){
			textbox_queue = undefined;
			
			dest_height_textbox_battle = 0;
			if (array_length(inimigos_vivos) > 0){
				state_transition(BATTLE_STATES.transition_enemy_turn);
				load_enemy_attack();
				//state = BATTLE_STATES.wait_time;
				inst_player.sprite_index = spr_player_idle_battle;
			} else {
				state_transition(BATTLE_STATES.transition_battle_won);
				dest_height_textbox_battle = default_height_textbox_battle;
				inst_player.sprite_index = spr_player_finish;
			}
		} else {
		
			if dest_height_textbox_battle != default_height_textbox_battle{
				dest_height_textbox_battle = default_height_textbox_battle
			}
		
		}
	break;
	case BATTLE_STATES.enemy_turn:

		if black_player_col_enemy_turn != 0{
		var lerp_amnt = 0.1;
		black_player_col_enemy_turn = lerp(black_player_col_enemy_turn, 0, lerp_amnt);	
		black_bg_color_alpha = lerp(black_bg_color_alpha, 1, lerp_amnt);
		global.ALPHA_PLAYER = lerp(global.ALPHA_PLAYER, .2, lerp_amnt);
		global.ALPHA_PLAYER_BORDER = lerp(global.ALPHA_PLAYER_BORDER, 0, lerp_amnt);
		
		global.RADIUS_HOPE_LIGHT =  lerp(global.RADIUS_HOPE_LIGHT, global.RADIUS_HOPE_LIGHT_MINIMUM, lerp_amnt);
		
		scr_update_player_blend_color(black_player_col_enemy_turn, black_player_col_enemy_turn, black_player_col_enemy_turn);
		
		}
	
		if !setup_enemy_turn {
			setup_enemy_turn_settings();
			
		}

		if instance_exists(obj_points){
			global.sin_t_points ++;
		}
		
		if (enemy_attack_type == "time-repeat"){
			var attack_scr = current_attack.attack_script;
			
			script_execute(circle_and_falling_ice);

			
			if (enemy_attack_duration <= 0){
				enemy_attack_finished = true;
			} else {
				enemy_attack_duration--;
			}
		}
	
	
	if enemy_attack_finished{
		state_transition(BATTLE_STATES.transition_main_menu);
		scr_can_move_tweaker(-1);
		inst_player.sprite_index = spr_player_idle_battle;
		enemy_attack_finished = false;
		setup_enemy_turn = false;
		mostrar_limites_de_movimentacao = false
		next_environment_sentence();
		tempo_inicio = current_time;
		duracao = 500;
		alpha_ui_player_target = alpha_ui_player_default;
		
		if inst_player.facing_x != 1{
			inst_player.facing_x = 1;
		}
		
	}
	
	
	
	break;
	
	case BATTLE_STATES.battle_won:
		
		
	break;
	
}
can_select = true;
can_run_attack_script = false;