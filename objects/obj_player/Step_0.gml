



depth = -y

if keyboard_check_pressed(ord("Y")){
debug_mode_aa = !debug_mode_aa
}

tecla_confirmar = keyboard_check_pressed(vk_enter) || keyboard_check_pressed(ord("Z"));




if cutscene_char{
	switch(acao){
		case "walk_w":
			sprite_index = spr_player_w
			break;
		case "walk_a":
			sprite_index = spr_player_a
			break;
		case "walk_s":
			sprite_index = spr_player_s
			break;
		case "walk_d":
			sprite_index = spr_player_d
			break;
	}
	
	if cutscene_player_x_dest > x{
		x += cutscene_x_vel_player;
		facing_x = 1;
	} else
	if cutscene_player_x_dest < x{
		x -= cutscene_x_vel_player;
		facing_x = 0;
	}
	
	if cutscene_player_x_dest == x{
		cutscene_char = false;
	}
	
	if cutscene_player_y_dest > y{
		y += cutscene_y_vel_player
		facing_y = 1;
	} else
	if cutscene_player_y_dest < y{
		y -= cutscene_y_vel_player
		facing_y = 0;
	}	
}




// permissao de andar
//if
//	(instance_exists(obj_textbox) or
//	instance_exists(obj_textboxx) or
//	global.menu_ativo or
//	global.itens_menu or
//	global.config_menu or
//	cutscene_char or
//	obj_room_manager.transition_alpha != 0)
	
//{
//	global.can_move = false
//	moving = false;
//} else {
//	global.can_move = true
//}





// sistema para identificar objeto interativo ou atacavel:
if tecla_confirmar{
	scr_interact();
}


//if processo_atacar && (image_index > 4 && image_index < 8) && inst_atacar != noone{
//scr_attack(self, inst_atacar, values.attack_dmg);

//processo_atacar = false;
//inst_atacar = noone;
//}








if global.can_move > 0{
	
	//scr_checagem_interacao();



	if (keyboard_check(vk_shift)){vel_player = 1.5} 
	else {vel_player = 1}
	
	moving = false;

	for (var i = 0; i < array_length(direcoes); i++ ){
		
		var p = direcoes[i];
	
		if ((keyboard_check(p[0]) or (keyboard_check(p[1]))) ){
			var coll_checker_x = x + p[2] * vel_colisao
			var coll_checker_y = y+ p[3] * vel_colisao 
			facing_x = p[6];
			facing_y = p[7];

			
			//if !ativar_ataque && !descansar_espada{
			//image_xscale = 1;
			//}
			
			if place_free(coll_checker_x, coll_checker_y){
				sprite_index = p[4];
				
				moving = true;
				coll_dir = p[5];
				x += p[2] * vel_player 
				y += p[3] * vel_player 
				//descanso_contador = 0
				//descansar_espada = false;
			}
			
					

		} 
	}
	
	
	

// ===================================================================
// GERENCIADOR DE ESTADO (ATAQUE E DESCANSO)
// ===================================================================

//// SE ESTIVER ATACANDO...
//if (ativar_ataque) {
//    // Detecta o FIM da animação de ataque
//    // (image_number - 1) é o último frame da animação
//	    if (facing_x == 0) {
//        image_xscale = -1;
//    } else {
//        image_xscale = 1;
//    }
	
//    if (sprite_index == spr_player_attack_horizontal && image_index >= image_number - 1) {
        
//        // 1. Termina o estado de ataque
//        ativar_ataque = false;
//        processo_atacar = false;
        
//        // 2. Inicia o estado de DESCANSO COM ESPADA
//        descansar_espada = true;
//        descanso_contador = 3; // Queremos que a animação toque 3 vezes
        
//        // 3. Define a animação de descanso
//        sprite_index = spr_player_idle_battle; // <<< MUDE AQUI para o nome do seu sprite!
//        image_index = 0; // Começa a animação do início
//    }
//}

// SE ESTIVER NO MODO DESCANSO COM ESPADA...
//else if (descansar_espada) {
//    // Mantém o personagem virado para o lado certo
//    if (facing_x == 0) {
//        image_xscale = -1;
//    } else {
//        image_xscale = 1;
//    }
    
//    // Detecta o FIM da animação de descanso
//    if (image_index >= image_number - 1) {
//        descanso_contador -= 1; // Diminui o nosso contador
        
//		//caso contador menor que zero, acaba a animacao, se nao, repete
//        if (descanso_contador > 0) {
//            image_index = 0;
//        } else {
//        descansar_espada = false;
//        }
//    }
//}

if instance_exists(obj_batalhaturno_manager) && obj_batalhaturno_manager.state == BATTLE_STATES.enemy_turn{
	
var inst_manager = obj_batalhaturno_manager;
var caixas_valores = inst_manager.caixa_valores
var caixa_atual_valores = caixas_valores.default_box
var largura_caixa = caixa_atual_valores.caixa_tamanho 
var altura_caixa = caixa_atual_valores.caixa_altura
var x_caixa = caixa_atual_valores.caixa_posicao_x
var y_caixa = caixa_atual_valores.caixa_posicao_y
var w_bbox_p = sprite_get_bbox_right(sprite_index)  - sprite_get_bbox_left(sprite_index);
var h_bbox_p = sprite_get_bbox_bottom(sprite_index) -  sprite_get_bbox_top(sprite_index);
		
x = clamp(x, x_caixa - largura_caixa/2 + w_bbox_p, x_caixa + largura_caixa/2 - w_bbox_p)
y = clamp(y, y_caixa - altura_caixa/2 + h_bbox_p, y_caixa + altura_caixa/2 - h_bbox_p)
}

if (moving == false && !cutscene_char /*&& !ativar_ataque && !descansar_espada*/){
	// para quando ele parar de andar ele nao ficar entre os pixels, pq a vel dele é um decimal
	//x = round(x);
	//y = round(y);
	//if !descansar_espada && !ativar_ataque {
	//image_xscale = 1
	//}
	
	//escolher sprite do ultimo botao
	if facing_y = 1 {
		
		//baixo
		sprite_index = spr_player;
		image_index = 1
		coll_dir = 270;
	}
	if facing_y = 0 {
		//cima
		sprite_index = spr_player;
		image_index = 2
		coll_dir = 90
	}
	if facing_x = 1 {
		//direita
		sprite_index = spr_player;
		image_index = 0
		coll_dir = 0
	}
	if facing_x = 0 {
		//esquerda
		sprite_index = spr_player;
		image_index = 3
		coll_dir = 180
	}
}


}


//if knockback_timer > 0 {
//	if knockback_vel > 0{
//		knockback_vel -= 0.05
//	}

//	x =  x + lengthdir_x(knockback_vel, relative_direction)
//	y =  y + lengthdir_y(knockback_vel, relative_direction)

//	knockback_timer -= .5
//}


if cooldown > 0 {
	cooldown -= 0.5
}

//if fog_timer > 0 {
//	fog_timer -= 0.1
//}


//if shake_level > 0 {
//	shake_level -= 0.1
//}









