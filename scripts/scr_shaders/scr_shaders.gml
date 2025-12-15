/// @desc Desenha uma borda ao redor do sprite desejado.
/// @param _sprite_index O sprite desejado.
/// @param _image_index O frame desejado.
/// @param _color_R A quantidade de vermelho desejado de 0 até 255.
/// @param _color_G A quantidade de verde desejado de 0 até 255.
/// @param _color_B A quantidade de azul desejado de 0 até 255.
/// @param _alpha A quantidade de alpha desejado de 0 até 255.

function scr_shader_outline(_sprite_index, _image_index, _color_R, _color_G, _color_B, _alpha){
			
	
		shader_set(sh_outline);
	
		var texture = sprite_get_texture(_sprite_index, _image_index);
		var t_w = texture_get_texel_width(texture);
		var t_h = texture_get_texel_height(texture);

		shader_set_uniform_f(global.sh_outline_texel_pointer, t_w, t_h);
		shader_set_uniform_f(global.sh_outline_color_pointer, _color_R/255, _color_G/255, _color_B/255, _alpha);

}