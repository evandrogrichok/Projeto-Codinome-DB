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
	draw_sprite_ext(_inst_player.sprite_index, _inst_player.image_index, _inst_player.x, _inst_player.y, x_scale * x_scale_blob, 1 * y_scale_blob, _rot, _color_blend, _alpha);
}

function scr_update_player_blend_color(_blend_r, _blend_g, _blend_b){
	global.BLEND_COLOR_PLAYER_R = _blend_r;
	global.BLEND_COLOR_PLAYER_G = _blend_g;
	global.BLEND_COLOR_PLAYER_B = _blend_b;
}

function scr_update_player_blend_color_lerp(_blend_r, _blend_g, _blend_b, _speed = 0.1)
{
	global.BLEND_COLOR_PLAYER_R = lerp(global.BLEND_COLOR_PLAYER_R, _blend_r, _speed);
	global.BLEND_COLOR_PLAYER_G = lerp(global.BLEND_COLOR_PLAYER_G, _blend_g, _speed);
	global.BLEND_COLOR_PLAYER_B = lerp(global.BLEND_COLOR_PLAYER_B, _blend_b, _speed);
}
function scr_player_dmg(_amount, _cooldown_time, _cam_shake_intensity, _cam_shake_time){
	obj_player.values.take_dmg(_amount, _cooldown_time, _cam_shake_intensity, _cam_shake_time);
}

function scr_lerp_player_paint_color(_r, _g, _b, _a, _speed){
    global.r_paint = lerp(global.r_paint, _r, _speed);
    global.g_paint = lerp(global.g_paint, _g, _speed);
    global.b_paint = lerp(global.b_paint, _b, _speed);
    global.a_paint = lerp(global.a_paint, _a, _speed);
}
function scr_player_paint_color(_r, _g, _b, _a){
    global.r_paint = _r;
    global.g_paint = _g;
    global.b_paint = _b;
    global.a_paint = _a;
}