function scr_animar_sprite(_image_index_var, _image_speed_var, _sprite){
	return (_image_index_var + _image_speed_var / (game_get_speed(gamespeed_fps) / sprite_get_speed(_sprite))) % sprite_get_number(_sprite);
}
