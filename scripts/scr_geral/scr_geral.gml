function scr_animar_sprite(_image_index_var, _image_speed_var, _sprite){
	return (_image_index_var + _image_speed_var / (game_get_speed(gamespeed_fps) / sprite_get_speed(_sprite))) % sprite_get_number(_sprite);
}


/// @function load_json_file(filename)
/// @description Abre um arquivo, lê o conteúdo e retorna como Struct/Array
function load_json_file(_filename) {
    if (!file_exists(_filename)) {
        show_debug_message(" Erro: Arquivo " + _filename + " não encontrado!");
        return undefined;
    }

    var _buffer = buffer_load(_filename);
    var _json_string = buffer_read(_buffer, buffer_string);
    buffer_delete(_buffer);


    try {
        var _data = json_parse(_json_string);
        return _data;
    } catch (_error) {
        show_debug_message(" Erro ao parsear JSON em " + _filename + ": " + _error.message);
        return undefined;
    }
}


function get_char_by_name(_name_target) {
    var _inst = noone; // Começa assumindo que não achou ninguém
    
    // O with() vai percorrer TODOS os objetos que são "obj_characters" na sala
    with (obj_character) {
        if (name == _name_target) {
            _inst = id; // Achou! Salva o ID exato dessa instância
            break;      // Para a busca para economizar processamento
        }
    }
    
    return _inst; // Retorna o ID (ou noone se o personagem não estiver na sala)
}


function return_longest_word(_string){
var current_word = "";
var longest_word = "";
var longest_word_length = 0;
var current_word_length = 0;
	for (var i = 0; i < string_length(_string); i++){
		var char = string_copy(_string, i+1, 1);
		if char == " "{
			if current_word_length > longest_word_length{
				longest_word = current_word;
				longest_word_length = current_word_length;
			}
			current_word = "";
			current_word_length = 0;
			continue;
		}
		
			current_word += char;
			current_word_length ++;
			
	}
	
	
			if current_word_length > longest_word_length{

				longest_word = current_word;
				longest_word_length = current_word_length;
			}
	return longest_word;
}


function draw_angled_text(string_to_draw, x_pos, y_pos, max_width, c1, c2, c3, c4, alpha, x_scale= 1, y_scale = 1, sin_mult = 0, char_y_offset = -1, line_break_height = 10){
	if (max_width <= 0){
		max_width = default_max_width_angled_text;
	}
	
	var draw_width_sum = 0;
	var line_break = 0;
	var char_y_offset_sum = 0;
	
	for (var i = 0; i < string_length(string_to_draw); i++){
		var char = string_copy(string_to_draw, i+1, 1);
		draw_text_transformed_colour(x_pos + draw_width_sum, y_pos + char_y_offset_sum + line_break * line_break_height + sin(sin_t)*sin_mult, char, x_scale, y_scale, 0, c1, c2, c3, c4, alpha);
		draw_width_sum += string_width(char) * x_scale;
		
		if (draw_width_sum > max_width && char == " "){
			draw_width_sum = 0;
			char_y_offset_sum = 0;
			line_break++;
			continue;
		}
		
		char_y_offset_sum += char_y_offset;
	}
}

/// @param {String} name Nome da instancia (player, camera, menu, manager, graphics.)
function get_instance(name){
	return global.instances[$ name];
}

function lerp_snap(value, target, spd){
	var result = lerp(value, target, spd);
	
	if abs(result - target) < 0.01{
		return target;
	}
	
	return result;
}