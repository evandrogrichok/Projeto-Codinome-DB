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
//	}	 
	
//} else {
	//if !instance_exists(obj_batalhaturno_manager) or obj_batalhaturno_manager.state != BATTLE_STATES.enemy_turn{

	//		draw_self();

	//} else {
		
	//}
//}


scr_shader_outline(sprite_index, image_index, 255, 255, 255, 1.0)

scr_desenhar_player();

shader_reset();


draw_text_transformed(x-25, y, depth,0.3,0.3,0);

if debug_mode_aa {

    var _range = 15;
    var _distance = 25;
    var _vx = x + lengthdir_x(_distance, coll_dir);
    var _vy = y + lengthdir_y(_distance, coll_dir);

    if coll_dir == 0 {
        draw_rectangle(x, y - _range, _vx, _vy + _range, true);
    } 

    if coll_dir == 180 {
        draw_rectangle(x - 1, y - _range, _vx - 2, _vy + _range, true);
    }

    if coll_dir == 90 {
        draw_rectangle(x - _range, y - 1, _vx + _range, _vy - 2, true);
    }

    if coll_dir == 270 {
        draw_rectangle(x - _range, y, _vx + _range, _vy, true);
    }
	
	draw_text_transformed(x, y-50, "vida:" + string(values.hp), 0.3, 0.3, 0)
	draw_text_transformed(x, y-30, "spr index:" + string(sprite_index), 0.3, 0.3, 0)
	draw_text_transformed(x, y-40, "cooldown:" + string(cooldown), 0.3, 0.3, 0)
	draw_text_transformed(x, y-60, "facing x:" + string(facing_x), 0.3, 0.3, 0)
	draw_text_transformed(x, y-70, "facing y:" + string(facing_y), 0.3, 0.3, 0)

}

	draw_text_transformed(x, y-60, "x: " + string(x), 0.3, 0.3, 0)
	draw_text_transformed(x, y-65, "y: " + string(y), 0.3, 0.3, 0)


