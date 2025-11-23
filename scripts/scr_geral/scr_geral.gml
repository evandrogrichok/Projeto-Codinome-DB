function scr_animar_sprite(_image_index_var, _image_speed_var, _sprite){
	return (_image_index_var + _image_speed_var / (game_get_speed(gamespeed_fps) / sprite_get_speed(_sprite))) % sprite_get_number(_sprite);
}
function scr_desenhar_player(_color_blend = c_white, _alpha = 1, _rot = 0){
	var _inst_player = obj_player;
	draw_sprite_ext(_inst_player.sprite_index, _inst_player.image_index, _inst_player.x, _inst_player.y, 1, 1, _rot, _color_blend, _alpha);
}

function scr_change_canmove(_number){
	global.can_move = global.can_move + _number;
}

function scr_update_player_blend_color(_blend_r, _blend_g, _blend_b){
	global.BLEND_COLOR_PLAYER_R = _blend_r;
	global.BLEND_COLOR_PLAYER_G = _blend_g;
	global.BLEND_COLOR_PLAYER_B = _blend_b;
}