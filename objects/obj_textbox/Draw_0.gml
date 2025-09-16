
tecla_confirmar = keyboard_check_pressed(vk_enter) || keyboard_check_pressed(ord("Z"));

//local da textbox na camera
textbox_x = camera_get_view_x(view_camera[0]);
textbox_y = camera_get_view_y(view_camera[0]) + 100;

// setup pra ter certeza de que a caixa se iniciou

if setup == false {
	
	
	setup = true
	draw_set_font(fnt_main)
	draw_set_valign(fa_top);
	draw_set_halign(fa_left)
	
	//loop pelas paginas
	for(var p = 0; p < page_number; p++){
		text_length[p] = string_length(text[p])
		// achar a localização que a caixa de texto vai ficar no eixo x

		
		//16 97 16 232
		//quando houver personagens falando na esquerda
		text_x_offset[p] = 97;
		portrait_x_offset[p] = 16;
		//quando houver personagens falando na direita
		if speaker_side[p] == -1{
			text_x_offset[p] = 16;
			portrait_x_offset[p] = 232;
		}
			
		// quando nao houver personagens falando (centralizar)
		if speaker_sprite[p] == noone{
		text_x_offset[p] = 56;
		}
		
		// setando caracteres individualmente e encontrando onde as linhas de texto tem que quebrar
		for (var c = 0; c < text_length[p]; c++){
			
			var _char_pos = c+1;
			// armazenar caracteres individuais no "char" array
			char[c, p] = string_char_at(text[p], _char_pos);
			
			// adquirir comprimento da linha de texto
			var _txt_up_to_char = string_copy(text[p], 1, _char_pos);
			var _current_txt_w = string_width(_txt_up_to_char) - string_width(char[c, p]);
			
			// saber qual o ultimo espaço disponivel antes de quebrar
			if char[c, p] == " " {
				last_free_space = _char_pos + 1
			}
			//quebras de linha
			if _current_txt_w - line_break_offset[p] > line_width{
			    line_break_pos[line_break_num[p] , p] = last_free_space;
			    line_break_num[p]++;
			    var _txt_up_to_last_space = string_copy( text[p], 1, last_free_space );
			    var _last_free_space_string = string_char_at(text[p], last_free_space );
			    line_break_offset[p] = string_width( _txt_up_to_last_space ) - string_width( _last_free_space_string );
			}
			
		}
		// coordenadas pra cada caractere
	
		for (var c = 0; c < text_length[p]; c++){
			var _char_pos = c+1;
			var _txt_x = textbox_x + text_x_offset[p] + border;
			var _txt_y = textbox_y + border;
			// adquirir comprimento da linha de texto
			var _txt_up_to_char = string_copy(text[p], 1, _char_pos);
			var _current_txt_w = string_width(_txt_up_to_char) - string_width(char[c, p]);
			var _txt_line = 0;
			
			for (var lb = 0; lb< line_break_num[p]; lb++){
				
				if _char_pos >= line_break_pos[lb, p]{
			    var _str_copy = string_copy( text[p], line_break_pos[lb, p], _char_pos-line_break_pos[lb, p] );
			    _current_txt_w = string_width( _str_copy );

			    //record the "line" this character should be on
			    _txt_line = lb+1; //+1 since lb starts at 0
				}
			}
		
			char_x[c, p] = _txt_x + _current_txt_w;
			char_y[c, p] = _txt_y + _txt_line*line_sep;
		
		}
		
		
	}
	
}
	


// escrevendo o texto
if text_pause_timer<= 0{
if draw_char < text_length[page]{
	draw_char += text_speed;
	draw_char = clamp(draw_char, 0, text_length[page]);
	var _check_char = string_char_at(text[page], draw_char);
	if _check_char == "."{
		text_pause_timer = text_pause_time;
		if !audio_is_playing(snd[page]){
		audio_play_sound(snd[page], 8, false)
		}
	} else{
		// som de fala
		if snd_count < snd_delay {
			snd_count++;
			
		} else{
			snd_count = 0;
			audio_play_sound(snd[page], 8, false)
		}
	}
	
}	
} else {
	text_pause_timer--;
}

// passar pelas paginas 

if tecla_confirmar{
	if draw_char == text_length[page]{
		// proxima pagina
		if page < page_number-1{
			page++;
			draw_char = 0;
		} else {
			// linkar o texto
			if option_number > 0 {
				create_textbox(option_link_id[option_pos])
			}
			instance_destroy();
		}
	}
}
	if draw_char < text_length[page] && (keyboard_check_pressed(vk_shift) || keyboard_check_pressed(ord("X"))){
			draw_char = text_length[page];
	
	}






// desenhando a caixa de texto
var _txtb_x =  textbox_x + text_x_offset[page];
var _txtb_y =  textbox_y;
txtb_img += txtb_img_spd;
txtb_spr_w = sprite_get_width(txtb_spr[page]);
txtb_spr_h = sprite_get_height(txtb_spr[page]);

//desenhar caixa de retrato do personagem
if speaker_sprite[page] != noone{
	sprite_index = speaker_sprite[page];
	if draw_char == text_length[page]{
		image_index = 0
	}
	var _speaker_x = textbox_x + portrait_x_offset[page];
	if speaker_side[page] == -1 {
		_speaker_x += sprite_width
	}
	//desenhar o personagem
	draw_sprite_ext(txtb_spr[page], txtb_img, textbox_x + portrait_x_offset[page], textbox_y, sprite_width/txtb_spr_w, sprite_height/txtb_spr_h, 0, c_white, 1);
	draw_sprite_ext(sprite_index, image_index, _speaker_x, textbox_y, speaker_side[page], 1, 0, c_white, 1);
	
}


// fundo da caixa de texto
draw_sprite_ext(txtb_spr[page], txtb_img, _txtb_x, _txtb_y, textbox_width/txtb_spr_w, textbox_heigth/txtb_spr_h, 0, c_white, 1);



// opcoes

if draw_char == text_length[page] && page == page_number -1{
	
	//selecionar as opcoes
	option_pos += keyboard_check_pressed(vk_down) - keyboard_check_pressed(vk_up);
	option_pos = clamp(option_pos, 0, option_number - 1);
	myimage_index = (myimage_index + myimage_speed / (game_get_speed(gamespeed_fps) / sprite_get_speed(spr_player_portrait))) % sprite_get_number(spr_player_portrait);
	
	
	var _op_space = 15;
	var _op_bord = 4;
	for (var op = 0; op < option_number; op++){
		// caixas de opcao
		var _o_w = string_width(option[op]) + _op_bord *2;
		draw_sprite_ext(txtb_spr[page], txtb_img, _txtb_x + 16, _txtb_y - _op_space * option_number + _op_space*op, _o_w/txtb_spr_w,(_op_space-1)/txtb_spr_h, 0, c_white, 1);
		
		// seta
		if option_pos == op{
		draw_sprite(spr_seta_txt, 0, _txtb_x, _txtb_y - _op_space * option_number + _op_space*op)
		}
		
		//texto das opcoes
		draw_text(_txtb_x + 16 + _op_bord, _txtb_y - _op_space * option_number + _op_space*op + 2, option[op])
	}
}


// desenhar o texto
for(var c = 0; c< draw_char; c++){
	// ------------- coisas especiais ---------------- \\
	
	//floating text
	var _float_y = 0
	if float_text[c, page] == true{
		float_dir[c, page] += -6;
		_float_y =  dsin(float_dir[c, page])
	}
	//shake text
	var _shake_x = 0;
	var _shake_y = 0;
	
	if shake_text[c, page] == true{
		shake_timer[c, page]--;
		if shake_timer[c, page] <= 2 {
			shake_timer[c, page] = irandom_range(4,8);
			shake_dir[c, page] = irandom(360)
			_shake_x = lengthdir_x(1, shake_dir[c,page])
			_shake_y = lengthdir_y(1, shake_dir[c,page])
		}

	}
	
	draw_text_color(char_x[c, page] + _shake_x, char_y[c, page] + _shake_y + _float_y, char[c, page], col_1[c, page], col_2[c, page], col_3[c, page], col_4[c, page], 1);
	
}










