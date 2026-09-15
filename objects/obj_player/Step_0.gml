event_inherited();
var is_cutscene = false;
if (instance_exists(obj_cutscene_manager)){
	is_cutscene = global.cutscene_active
}

if (x_scale_blob != 1){
	x_scale_blob = lerp(x_scale_blob, 1, 0.2);
}

if (y_scale_blob != 1){
	y_scale_blob = lerp(y_scale_blob, 1, 0.2);
}


global.BLEND_COLOR_PLAYER = make_colour_rgb(global.BLEND_COLOR_PLAYER_R, global.BLEND_COLOR_PLAYER_G, global.BLEND_COLOR_PLAYER_B);

if instance_exists(obj_battle_manager){
	depth = DEPTH.LOGIC_OBJECTS

} else {
    depth = DEPTH.ENTITY_BASE -y;
}


tecla_confirmar = keyboard_check_pressed(vk_enter) || keyboard_check_pressed(ord("Z"));


if tecla_confirmar{
	scr_interact();
}


if global.can_move >= 0 && !is_cutscene{
	
	moving = false;
	
	if (dash_timer <= 0 && state == PLAYER_STATES.hope && global.ACCEPT_KEY){
		setup_hope_dash(20, 3);
		emmit_hope_particles_dash();
			
		with (obj_battle_manager){
			if (check_if_on_beat()){on_beat_feedback()}				
		}
	}


	mx = 0;
	my = 0;
	if !(dashing){
	if global.RIGHT_KEY_HOLD{
		mx = 1;
		facing_x = 1;
		facing_y = 0;
		interact_dir = 0;
		sprite_index = spr_player_h;

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
		sprite_index = spr_player_h;

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
		
		if (place_free(coll_check_x, y)) {
	        x += mx * vel_player;
	        moving = true;
	    }
		
		if (place_free(x, coll_check_y)) {
	        y += my * vel_player;
	        moving = true;
	    }
	}
	
	if (dashing){
		
		coll_check_x = x + dash_x_coll;
		coll_check_y = y + dash_y_coll;
		
		if (place_free(coll_check_x, y)) {
		x += dash_x
	    }

		if (place_free(x, coll_check_y)) {
		y += dash_y
	    }

	}



	


if !moving{
	if facing_y == 1 {
		
		//baixo
		sprite_index = spr_player_s_idle;


	}
	if facing_y == -1 {
		//cima
		sprite_index = spr_player_w_idle;


	}
	if facing_x == 1 {
		//direita
		sprite_index = spr_player_h_idle;


	}
	if facing_x == -1 {
		//esquerda
		sprite_index = spr_player_h_idle;


	}
}




if instance_exists(obj_battle_manager){
	
switch(obj_battle_manager.state){
		
	case BATTLE_STATES.enemy_turn:
	state = PLAYER_STATES.hope;
	sin_t += 0.05;
	mask_index = spr_hope;

	if global.UP_KEY_HOLD or global.LEFT_KEY_HOLD or global.DOWN_KEY_HOLD or global.RIGHT_KEY_HOLD{
		emmit_hope_particles()
	} 
	
	blob_control();
	blob_dir_controller(0.2);
	battle_border_clamper();
	break;
	default:
	state = PLAYER_STATES.normal;
	break;
}
} else {
	state = PLAYER_STATES.normal;
}
}

if values.cooldown > 0 {
	values.sin_t_flash_dmg += 0.8
	values.cooldown -= 0.5
	


} else {

}


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
