var l_keys = keyboard_check_pressed(vk_right) or keyboard_check_pressed(ord("D"));
var r_keys = keyboard_check_pressed(vk_left) or keyboard_check_pressed(ord("A"));
var u_keys = keyboard_check_pressed(vk_up) or keyboard_check_pressed(ord("W"));
var d_keys = keyboard_check_pressed(vk_down) or keyboard_check_pressed(ord("S"));
var accept_key = keyboard_check_pressed(vk_enter) or keyboard_check_pressed(ord("Z"));
var inst_player = obj_player;
var _opt_changer =  (l_keys) - (r_keys);
var _opt_changer_v = (d_keys) - (u_keys) ;
var _quant_opc = array_length(options);

var _inst_player = obj_player;


//tamanho do visor da camera
var _cam_w = camera_get_view_width(view_camera[0]);
var _cam_h = camera_get_view_height(view_camera[0]);
//localizacao do obj cam
var _cam_x = obj_camera.x;
var _cam_y = obj_camera.y;

var tam_alvo = 20;
var x_alvo_setas = (_cam_x-20)-tam_alvo;
var x_dist = 10;
var aumentar_alvo = 0;

//inimigos
var quant_inimigos = array_length(inimigos_combo);

//show_debug_message(global.can_move)



switch (state){
	case (BATTLE_STATES.main_menu):
	
	
		//===== CONTROLADOR DE OPÇÕES
		opt += _opt_changer;

		opt = (opt + _quant_opc) mod _quant_opc;
		// linha de codigo fodar^^^^

		b_subimage = array_create(_quant_opc, 0)
		b_subimage[opt] = 1;
		
		if accept_key{
		//ENVIAR OPCAO
		run_command(opt)
		opt = 0;
		}
	
		//CONTROLAR LOCAL DO JOGADOR
		if !inst_player_tweak{
			inst_player.x = position_player[0][0]
			inst_player.y = position_player[0][1]
			
			inst_player_tweak = true;
		}
	break;
	
	case (BATTLE_STATES.select_enemy):
		opt += _opt_changer_v;
		opt = (opt + quant_inimigos) mod quant_inimigos;
	
		if accept_key{
		next_enemy_to_attack = opt;
		state = BATTLE_STATES.arrow_pattern;
		}
	
	break;
	
	case (BATTLE_STATES.arrow_pattern):
	can_draw_texto_acerto = true
	var quant_setas = array_length(arrow_pat);
	var quant_erros = 0;
	var dist_alvo = dist_seta_alvo;
	

	for(var k = 0; k < array_length(keys); k++){
		var key = keys[k]
		var range_text = 5;
		
		if keyboard_check_pressed(key[0]){
			array_push(player_arrow_pat, [key[1], dist_alvo])


		if (key[1] == arrow_pat[arrow_to_draw_from]){
			arrow_feedback_draw = [arrow_pat[arrow_to_draw_from], dist_alvo, local_seta_mais_proxima]
			alpha_feedback = 1
			
			//sempre verificando todos menos o ultimo index do array param_acertar
			for(var i = 0; i < array_length(param_acertar)-1; i++){
				var params = param_acertar[i];
				
				if dist_alvo < params[0]{
					cor_texto_acerto = params[1];
					text_to_draw[0] = params[2]
					text_to_draw[1] = "qualidade_acerto";
					x_texto_acerto = x_alvo_setas + range_text + tam_alvo/2;
					dest_x_texto_acerto = x_alvo_setas - range_text + tam_alvo/2;
					alpha_txt_acerto = 1
					break;
				}
			}
			
		} else {
			//var params sempre recebe a ultima linha do array pra pegar os parametros de erro, só por organizacao!
			var ultimo = array_length(param_acertar)-1
			var params = param_acertar[ultimo];
			
			arrow_feedback_draw = [arrow_pat[arrow_to_draw_from], dist_alvo, local_seta_mais_proxima]
			alpha_feedback = 1
			
			cor_texto_acerto = params[1];
			text_to_draw[0] = params[2]
			text_to_draw[1] = "qualidade_acerto";
			x_texto_acerto = x_alvo_setas + range_text + tam_alvo/2;
			dest_x_texto_acerto = x_alvo_setas - range_text + tam_alvo/2;
			alpha_txt_acerto = 1
		}
		
		arrow_to_draw_from ++
		
		}
		
		
	}

	
	if local_seta_mais_proxima < x_lim_setas{
		arrow_to_draw_from ++;
		array_push(player_arrow_pat, "")
		
	}
	
	if quant_setas == array_length(player_arrow_pat){
		
		var max_dmg_porc = max_dmg/100;
		var dano_base = max_dmg
		var total_distance = 0;
		var valor_erro_permitido = 5
		for (var i = 0; i < quant_setas; i++){
			
			if player_arrow_pat[i][0] != arrow_pat[i]{
				quant_erros++;
				
			} 
			if player_arrow_pat[i][1] > valor_erro_permitido{
				total_distance += player_arrow_pat[i][1];
			}
		}
		
		
		total_distance = clamp(total_distance, 0, max_dmg_porc*30)
		dmg =  round(dano_base - total_distance - max_dmg_porc * 10 * quant_erros) 
		show_debug_message(dmg);
		state = BATTLE_STATES.attacking
		array_delete(player_arrow_pat,0,quant_setas);
		spawn_setas = obj_camera.x +80;
		arrow_to_draw_from = 0;
	}
//	show_debug_message(player_arrow_pat)
	flag_atacando = true
	break;
	
	case BATTLE_STATES.attacking:
	alpha_barra_ini = 1;
		if flag_atacando{
			inst_player.sprite_index = spr_player_attack_horizontal;
			inst_player.image_index = 0;
			flag_atacando = false;
		}
		
		if inst_player.image_index >= inst_player.image_number-1 {
			var range_text = 10;
			hp_inimigos[opt] -= dmg;
			text_to_draw = [string(dmg),"dano_no_inimigo",""]
			x_texto_acerto = x_inimigo[opt] + range_text;
			dest_x_texto_acerto = x_inimigo[opt] - range_text;
			shake_level = 3
			wait_timer = 120;
			sin_t = 0;
			state = BATTLE_STATES.wait_time;
			next_state = BATTLE_STATES.enemy_turn;
			inst_player.sprite_index = spr_player_idle_battle
			
			//ATUALIZANDO ARRAY DE INIMIGOS VIVOS
		
			//deleta os inimigos que tinha antes
			array_delete(inimigos_vivos,0,array_length(inimigos_vivos));
			//percorre adicionando os inimigos se eles estiverem com mais que 0 de vida
			for (var e = 0; e < quant_inimigos; e++){
				if hp_inimigos[e] > 0{
					array_push(inimigos_vivos, inimigos_combo[e])
				}
			}
			//array recebe ele mesmo, mas ordenado por script bubble sort;
			inimigos_vivos = scr_ordenar_alf_array(inimigos_vivos);
			
			
			var string_array_ini_vivos = "";
			
			for (var i = 0; i < array_length(inimigos_vivos); i++){
				string_array_ini_vivos += inimigos_vivos[i];
				if (i != array_length(inimigos_vivos) -1){
					string_array_ini_vivos += "_";
				}
			}
			
			//guardamos numa chave o nome dos inimigos ordenados separados por "_" SEMPRE em lowercase.
			atqs_chave = string_lower(string_array_ini_vivos);
			show_debug_message(atqs_chave);
		}

	break;
	
	case BATTLE_STATES.wait_time:
	
	if (next_state == BATTLE_STATES.enemy_turn){
		if wait_timer > 0{
			wait_timer --;
			mostrar_limites_de_movimentacao = true;
		} else {
			state = next_state
			global.can_move += 1;
			inst_player.facing_x = 1
			fade_in_alpha = 0;
			load_enemy_attack(atqs_chave);
			battle_timer = irandom_range(60*14, 60*20)
		}
	} else
	if (next_state == BATTLE_STATES.main_menu){
		if wait_timer <= 0{
			state = next_state
			inst_player_tweak = false;
		} else {
			wait_timer--;
			inst_player.move_player_towards_point(position_player[0][0], position_player[0][1], 0.5);
		}
	}
	
	break;
	
	case BATTLE_STATES.enemy_turn:
	if battle_timer > 0{
		inimigo1_inimigo2();
		battle_timer --;
	} else {
		wait_timer = 60;
		state = BATTLE_STATES.wait_time;
		next_state = BATTLE_STATES.main_menu;
		mostrar_limites_de_movimentacao = false
		global.can_move -=1;
		inst_player.sprite_index = spr_player_idle_battle;
	}
	
	
	
	break;
	
	
}
