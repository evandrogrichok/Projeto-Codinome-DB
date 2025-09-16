function scr_animar_sprite(_image_index_var, _image_speed_var, _sprite){
	return (_image_index_var + _image_speed_var / (game_get_speed(gamespeed_fps) / sprite_get_speed(_sprite))) % sprite_get_number(_sprite);
}
function scr_desenhar_player(){
	var _inst_player = obj_player;
	draw_sprite(_inst_player.sprite_index, _inst_player.image_index, _inst_player.x, _inst_player.y)
}