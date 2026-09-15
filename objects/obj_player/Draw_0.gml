//if shake_level >= 0{
//	var shake_x = 0
//	var shake_y = 0
//	var shake_dir = irandom(360)

//	shake_x = x + lengthdir_x(shake_level, shake_dir);
//	shake_y = y + lengthdir_y(shake_level, shake_dir);
		
//	draw_sprite(sprite_index, image_index, shake_x, shake_y);
	
//	if fog_timer > 0{
//		var _sprite_atual = sprite_index
//		gpu_set_fog(true,c_white,0,0);
//		draw_sprite_ext(_sprite_atual, image_index, shake_x, shake_y, 1, 1, 0, c_white, 1);
//		gpu_set_fog(false,c_white,0,0);
//		draw_sprite_ext(_sprite_atual, image_index, shake_x, shake_y, 1, 1, 0, c_white, 1);
//		gpu_set_fog(false,c_white,0,0);
//	}	 
	
//} else {
	//if !instance_exists(obj_batalhaturno_manager) or obj_batalhaturno_manager.state != BATTLE_STATES.enemy_turn{

	//		draw_self();

	//} else {
		
	//}
//}

draw_rectangle(mouse_x,mouse_y,mouse_x,mouse_y,false)
shader_set(sh_upwards_lightning);
shader_set_uniform_f(global.sh_upwards_lighting_color_blend_pointer, 191/255, 255/255, 240/255, .3);
var texture = sprite_get_texture(sprite_index, image_index);
var t_w = texture_get_texel_width(texture);
var t_h = texture_get_texel_height(texture);



scr_desenhar_player(global.BLEND_COLOR_PLAYER, global.ALPHA_PLAYER);
shader_reset();



if instance_exists(obj_battle_manager){
	
	
	switch(obj_battle_manager.state){
		
	case BATTLE_STATES.enemy_turn:

	draw_hope_light_fx(0.08, 0.03, c_white);
	
	hope_index = scr_animar_sprite(hope_index, hope_spd, spr_hope);
	scr_shader_outline(spr_hope_white, hope_index, 255, 255, 255, global.ALPHA_HOPE_BORDER)
	
	 if dashing{
		draw_sprite_ext(spr_hope_white, hope_index, x, y-10, hope_scale_x, hope_scale_y, hope_dir, c_white, 1);
	}
	else if values.cooldown>0 && dash_timer <= 0{
		draw_sprite_ext(spr_hope, hope_index, x, y-10, hope_scale_x, hope_scale_y, hope_dir, c_white, 1);
		draw_sprite_ext(spr_hope_white, hope_index, x, y-10, hope_scale_x, hope_scale_y, hope_dir, c_white, round(sin(values.sin_t_flash_dmg)));
	
	} else {
		draw_sprite_ext(spr_hope, hope_index, x, y-10, hope_scale_x, hope_scale_y, hope_dir, c_white, 1);
		
	}
	

	
	shader_reset();
	
	break;
	
	default:
	scr_shader_outline(sprite_index, image_index, 255, 255, 255, global.ALPHA_PLAYER_BORDER)
	scr_desenhar_player(global.BLEND_COLOR_PLAYER, global.ALPHA_PLAYER);
	shader_reset();
	
	scr_shader_paint(global.r_paint, global.g_paint, global.b_paint, global.a_paint);
	scr_desenhar_player(global.BLEND_COLOR_PLAYER, global.ALPHA_PLAYER);
	shader_reset();
	break;
	
	}
	
	
}

//draw_text_transformed(x-25, y-10, global.can_move,1,1,0);
//draw_text_transformed(x-25, y, mx,1,1,0);
//draw_text_transformed(x-25, y+10, my,1,1,0);
//draw_text_transformed(x-25, y+20, lengthdir_x(20, degrees_directon),1,1,0);
//draw_text_transformed(x-25, y+30, lengthdir_y(20, degrees_directon),1,1,0);
//draw_text_transformed(x-25, y+40, interact_dir,1,1,0);
//draw_text_transformed(x-25, y+50, vel_player,1,1,0);
//draw_text_transformed(x-25, y+60, obj_camera.spd_camera,1,1,0);
//draw_text_transformed(x, y-40, "cooldown:" + string(values.cooldown), 0.3, 0.3, 0)

if debug_mode_aa {

    var _range = 4;
    var _distance = 12;
    var _vx = x + lengthdir_x(_distance, interact_dir);
    var _vy = y + lengthdir_y(_distance, interact_dir);

    if interact_dir == 0 {
        draw_rectangle(x+2, y - _range-1, _vx+2, _vy + _range, true);
    } 

    if interact_dir == 90 {
        draw_rectangle(x - _range, y - 1, _vx + _range, _vy - 3, true);
    }
	
	if interact_dir == 180 {
        draw_rectangle(x - 1, y - _range-1, _vx - 3, _vy + _range, true);
    }

    if interact_dir == 270 {
        draw_rectangle(x - _range, y, _vx + _range, _vy, true);
    }
	
	//draw_text_transformed(x, y-50, "vida:" + string(values.hp), 0.3, 0.3, 0)
	//draw_text_transformed(x, y-30, "spr index:" + string(sprite_index), 0.3, 0.3, 0)
	
	//draw_text_transformed(x, y-60, "facing x:" + string(facing_x), 0.3, 0.3, 0)
	//draw_text_transformed(x, y-70, "facing y:" + string(facing_y), 0.3, 0.3, 0)

}


	//draw_text_transformed(x, y-60, "x: " + string(x), 0.3, 0.3, 0)
	//draw_text_transformed(x, y-65, "y: " + string(y), 0.3, 0.3, 0)



