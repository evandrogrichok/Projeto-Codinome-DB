

global.BLEND_COLOR_PLAYER = make_colour_rgb(global.BLEND_COLOR_PLAYER_R, global.BLEND_COLOR_PLAYER_G, global.BLEND_COLOR_PLAYER_B);
depth = -y

if keyboard_check_pressed(ord("Y")){
debug_mode_aa = !debug_mode_aa
}

tecla_confirmar = keyboard_check_pressed(vk_enter) || keyboard_check_pressed(ord("Z"));


//if object_exists(obj_batalhaturno_manager){
	
//	var inst = obj_batalhaturno_manager;
	
	
//	switch (inst.state){
//		case BATTLE_STATES.enemy_turn:
		
//		break;
//	}
	
	

	
//}




mask_index = spr_player_hope_box;





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


	moving = false;
	
	if global.ACCEPT_KEY{
		if (dash_timer <= 0) && state == PLAYER_STATES.hope{
			var dash_time = 20;
			var per_step_dist = 3
			
			dashing = true;
			dash_timer = 20;
			
			dash_x = lengthdir_x(per_step_dist, degrees_directon)
			dash_y = lengthdir_y(per_step_dist, degrees_directon)
			dash_x_coll = lengthdir_x(per_step_dist + 2, degrees_directon)
			dash_y_coll = lengthdir_y(per_step_dist + 2, degrees_directon)
			
			hope_sprite_scale_add = -1
			hope_sprite_scale_fast_increase = 1.5;
			values.cooldown = 5
			

			part_emitter_region(part_sys_hope, part_emitter, x-2, x+2, (y-10)-2, (y-10)+2, ps_shape_rectangle, ps_distr_linear);
			part_type_speed(part_type_hope, .2, 1.5, 0, 0);
			part_type_direction(part_type_hope, degrees_directon -20 -180, degrees_directon +20 - 180, 0, 0);
			part_emitter_relative(part_sys_hope, part_emitter, false);
			part_emitter_burst(part_sys_hope, part_emitter, part_type_hope, 10)

		}
	}

	var mx = 0;
	var my = 0;
	if !(dashing){
	if global.RIGHT_KEY_HOLD{
		mx = 1;
		facing_x = 1;
		facing_y = 0;
		interact_dir = 0;
		sprite_index = spr_player_d;
		}
	if global.UP_KEY_HOLD {
		my = -1;
		facing_x = 0;
		facing_y = -1;
		interact_dir = 90;
		sprite_index = spr_player_w;
		}
	if global.LEFT_KEY_HOLD{
		mx = -1;
		facing_x = -1;
		facing_y = 0;
		interact_dir = 180;
		sprite_index = spr_player_a;
		}
	if global.DOWN_KEY_HOLD{
		my = 1;
		facing_x = 0;
		facing_y = 1;
		interact_dir = 270;
		sprite_index = spr_player_s;
		}
	}
	
	vel_colisao = vel_player + 2
	
	var coll_check_x = x + mx * vel_colisao 
	var coll_check_y = y + my * vel_colisao 
	
	
	
	if (mx != 0 or my != 0){
	    var len = point_distance(0, 0, mx, my);
		
	    mx /= len;
	    my /= len;
		
		degrees_directon = point_direction(0, 0, mx, my);
		degrees_directon = round(degrees_directon / 45) * 45;
		
		if (place_free(coll_check_x, coll_check_y)) {
	        x += mx * vel_player;
	        y += my * vel_player;
	        moving = true;
	    }
	}
	
	if (dashing){
		
		coll_check_x = x + dash_x_coll;
		coll_check_y = y + dash_y_coll;
		
		if (place_free(coll_check_x, coll_check_y)) {
		x += dash_x
		y += dash_y
	    }

	}



	


if !moving{
	if facing_y == 1 {
		
		//baixo
		sprite_index = spr_player;
		image_index = 1

	}
	if facing_y == -1 {
		//cima
		sprite_index = spr_player;
		image_index = 2

	}
	if facing_x == 1 {
		//direita
		sprite_index = spr_player;
		image_index = 0

	}
	if facing_x == -1 {
		//esquerda
		sprite_index = spr_player;
		image_index = 3

	}
}


if instance_exists(obj_batalhaturno_manager){
	
	switch(obj_batalhaturno_manager.state){
		
	case BATTLE_STATES.enemy_turn:
	sin_t += 0.05;
	
	
	state = PLAYER_STATES.hope;
	
	if global.UP_KEY or global.LEFT_KEY or global.DOWN_KEY or global.RIGHT_KEY{
		hope_sprite_scale_add = -.2
		hope_sprite_scale_fast_increase = .5;

		
	} 
	if global.UP_KEY_HOLD or global.LEFT_KEY_HOLD or global.DOWN_KEY_HOLD or global.RIGHT_KEY_HOLD{
		
		part_emitter_relative(part_sys_hope, part_emitter, true);
		part_emitter_burst(part_sys_hope, part_emitter, part_type_hope, 1000)
		part_type_speed(part_type_hope, .2, .5, 0, 0);
		part_emitter_region(part_sys_hope, part_emitter, x-2, x+2, (y-10)-2, (y-10)+2, ps_shape_rectangle, ps_distr_linear);
		part_type_direction(part_type_hope, degrees_directon -10 -180, degrees_directon +10-180, 0, 0);
	} 
	
	if hope_sprite_scale_add != 0 {
		hope_sprite_scale_add = lerp(hope_sprite_scale_add, 0, 0.2);
	}
	
	if hope_sprite_scale_fast_increase != 0 {
		hope_sprite_scale_fast_increase = lerp(hope_sprite_scale_fast_increase, 0, 0.2);
	}
	



	
	
	var diff = angle_difference(degrees_directon, hope_dir)
	 
	hope_dir += diff * 0.2
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
	

	
	break;
	default:
	state = PLAYER_STATES.normal;
	break;
	}
	
	
} else {
	state = PLAYER_STATES.normal;
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


if values.cooldown > 0 {
	values.sin_t_flash_dmg += 0.8
	values.cooldown -= 0.5
	


} else {

}

//if fog_timer > 0 {
//	fog_timer -= 0.1
//}


//if shake_level > 0 {
//	shake_level -= 0.1
//}

	




if dash_timer > 0{
	if dash_timer < 15{
	dash_x = 0;
	dash_y = 0;
	dashing = false;
	}
	dash_timer --;
} else {
	
	dash_x = 0;
	dash_y = 0;
}


