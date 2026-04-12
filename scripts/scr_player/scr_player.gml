global.can_move = 1;


function scr_can_move_tweaker(_param){
	global.can_move = global.can_move + _param;
}

function scr_desenhar_player(_color_blend = c_white, _alpha = 1, _rot = 0){
	var _inst_player = obj_player;
	var x_scale = 0
	if facing_x == -1 {
		x_scale = -1;
	} else {
		x_scale = 1;
	}
	draw_sprite_ext(_inst_player.sprite_index, _inst_player.image_index, _inst_player.x, _inst_player.y, x_scale, 1, _rot, _color_blend, _alpha);
}

function scr_update_player_blend_color(_blend_r, _blend_g, _blend_b){
	global.BLEND_COLOR_PLAYER_R = _blend_r;
	global.BLEND_COLOR_PLAYER_G = _blend_g;
	global.BLEND_COLOR_PLAYER_B = _blend_b;
}

function scr_player_dmg(_amount, _cooldown_time, _cam_shake_intensity, _cam_shake_time){
	obj_player.values.take_dmg(_amount, _cooldown_time, _cam_shake_intensity, _cam_shake_time);
}