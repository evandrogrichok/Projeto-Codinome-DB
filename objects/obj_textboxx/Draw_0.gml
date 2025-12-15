draw_set_font(fnt_main);
draw_set_valign(fa_top);
draw_set_halign(fa_left);
var portrait_x_offset = 0;

//draw_text(obj_player.x, obj_player.y, string(textbox_heigth))


if !runned_every_page{
	setup_page_variables();
}

//show_debug_message(current_sound)
//show_debug_message(current_textbox)
//show_debug_message(current_location)
//show_debug_message(current_color)
//show_debug_message(current_speaker)


var tecla_confirmar = keyboard_check_pressed(vk_enter) || keyboard_check_pressed(ord("Z"));


//pegando os breaks de cada linha e guardando em um subarray de array



if textbox_heigth < textbox_heigth_lim[page]{
	textbox_heigth = textbox_heigth+2
} else if textbox_heigth > textbox_heigth_lim[page]{
	textbox_heigth = textbox_heigth-2;
}

if !interpreter_setted_up{
	text_interpreter();
}
//show_debug_message(current_text[page])
//show_debug_message(char_effects[page])


if (draw_char < string_length(current_text[page])){
	var check_char = (string_char_at(current_text[page], draw_char));
	
	if (text_pause_timer > 0){
		text_pause_timer--
	}
	
	if (text_pause_timer <= 0){
		draw_char += vel_escrita;
     	
		play_text_sound(current_sound);
				
		if  (check_pause(check_char) && text_pause_timer <= 0){
		text_pause_timer = text_pause_time;
		
		}
	}
	
	if tecla_confirmar && runned_once{
		draw_char = string_length(current_text[page])
		text_pause_timer = 0; // garante que não vai ficar travado
	} 
	
} else 
if (draw_char >= string_length(current_text[page]) && tecla_confirmar){
	if current_type == "chat"{
		page++;
		draw_char = 0;
		runned_every_page = false;
	}
	
	if current_type == "decision"{
		instance_destroy();
		//show_debug_message(string(option_link_id[option_pos]))
		scr_open_textbox(string(option_link_id[option_pos]))		
	}
}

if page >= array_length(dialogo){
	ds_map_destroy(colors);
	instance_destroy();
	exit;
	
}

if (!linebreaks_setted_up){
carregar_line_breaks();
}



var x_textbox = camera_get_view_x(view_camera[0]);
var y_textbox = camera_get_view_y(view_camera[0]);
var w_cam = camera_get_view_width(view_camera[0]);
var h_cam = camera_get_view_height(view_camera[0]);

var padding_x_text = 7;
var padding_y_text = 5;

if current_type == "battle"{
	padding_x_text = 0;
	padding_y_text = textbox_heigth/3;
}

var x_text = x_textbox + padding_x_text;
var y_text = y_textbox + padding_y_text;

var left_offset = 56;
var option_offset = 40;
var top_offset = find_offset_by_location(current_location);

var x_options = x_textbox + left_offset + portrait_x_offset;
var three_options_y_offset = 0;
var three_option_selection_y_offset = 0;
var y_options = y_textbox + top_offset + option_offset;


if (current_speaker != "noone"){
	portrait_x_offset = 74;
	left_offset = 18;

	draw_sprite_stretched_ext(asset_get_index(current_textbox), 0, x_textbox + left_offset, y_textbox + top_offset, portraitbox_size, portraitbox_size, c_white,1)
	draw_sprite_stretched_ext(asset_get_index(current_speaker), 0, x_textbox + left_offset, y_textbox + top_offset, portraitbox_size, portraitbox_size, c_white,1)
}

//desenhandoc caixa de texto

var c_textbox = asset_get_index(current_textbox)
draw_sprite_stretched_ext(asset_get_index(current_textbox), 0, x_textbox + w_cam/2 - textbox_width/2, y_textbox + top_offset, textbox_width, textbox_heigth, c_white, 1);

if (current_type == "decision"){
	
	options = current_page.options;
	var options_quant = array_length(options);
	var op_border = 20;
	var op_spacing = 2;
	var y_spacing = 0;
	var area_options = textbox_width;
	var center = area_options/2 + x_textbox + left_offset; 
	var positions = array_create(options_quant);
	
	
	if (options_quant == 3){
	
		var text_width_op0 = string_width(options[0]);
		var text_width_op1 = string_width(options[1]);
		var text_width_op2 = string_width(options[2]);
		
		var top_width = text_width_op0 + text_width_op2;
		y_spacing = 15;
		
		positions[0] = [center - top_width/2 + text_width_op0/2 - op_spacing, y_options] ;
		positions[1] = [center + top_width/2 - text_width_op2/2 + op_spacing, y_options];
		positions[2] = [center, y_options + y_spacing];
	} else {
		for (var op = 0; op < options_quant; op++){
			var text_width_op = string_width(options[op])
			if (op % 2 != 0 ){
				text_width_op *= -1;
				op_spacing *= -1;
			} else {
				op_spacing = 7;
			}
			if (op >= 2){
				y_spacing = 15;
			}
			positions[op] = [center - text_width_op/2 - op_spacing, y_options + y_spacing];
		}
}

	

	if draw_char == string_length(current_text[page]){
	
	//selecionar as opcoes
	option_pos += keyboard_check_pressed(vk_right) - keyboard_check_pressed(vk_left);
	option_pos = clamp(option_pos, 0, options_quant - 1);
	
	
	draw_sprite_stretched(spr_seta_txt, 0, positions[option_pos][0] - string_width(options[option_pos])/2 , positions[option_pos][1] - 2, string_width(options[option_pos]) + 3, 16);
	
			draw_set_halign(fa_center);
for (var op = 0; op < options_quant; op++){
	
		//show_debug_message("DESENHOU");
		var pos = positions[op];
		var text = options[op];
		draw_text(pos[0], pos[1], text);


	}
	
	draw_text_color(positions[option_pos][0], positions[option_pos][1], options[option_pos], #FFD44C,#FFD44C,#FFD44C,#FFD44C,1);
	draw_set_halign(fa_left);
	
}


}

var text_y_offset = 0;
var start_char = 1;
var page_breaks = line_breaks[page];



for (var i = 0; i < array_length(page_breaks); i++){
	

	
    var break_char = page_breaks[i];
    if (break_char > draw_char) break_char = draw_char;

    var text_x_offset = 0; // acumulador da linha
	
	if current_type == "decision"{
		x_text = x_textbox + textbox_width/2 - string_width(string_copy(current_text[page],start_char, break_char - start_char))/2;
	} else
	if current_type == "battle"{
		x_text = x_textbox + textbox_width/2 - string_width(string_copy(current_text[page],start_char, break_char - start_char))/2;
	}
	
	
    for (var c = start_char; c <= break_char; c++){
	
        var ch = string_char_at(current_text[page], c);
		
        var x_off = 0;
		var y_off = text_y_offset;
		var wave_y = 0;
		var my_color = "c_white";
        if (array_contains(char_effects[page][c-1], "shake")){ // shake
			
            x_off += random_range(-0.5,0.5);
            y_off += random_range(-0.5,0.5);
        }
		
        if (array_contains(char_effects[page][c-1], "wave")){ // wave
			wave_dir[c-1] += -10
			wave_y = dsin(wave_dir[c-1]);

        }
		
        if (array_contains(char_effects[page][c-1], "color")){ // wave
			my_color = current_color;
        }
		
        if (array_contains(char_effects[page][c-1], "item")){ 
			my_color = "c_yellow_main";
        }
		
        draw_text_color(x_text + portrait_x_offset + text_x_offset + x_off,
                  y_text + top_offset + y_off + wave_y,
                  ch,  colors[? my_color], colors[? my_color], colors[? my_color], colors[? my_color], 1);

        text_x_offset += string_width(ch); // aqui você avança a posição horizontal
	

    }

    start_char = break_char + 1;
    text_y_offset += line_sep; // desce pra próxima linha
	
}

if !runned_once{
runned_once = true

}


