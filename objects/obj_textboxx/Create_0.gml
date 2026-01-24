depth = DEPTH.UI_BASE;
var file = file_text_open_read("dialogos.json");
var json_string = "";
while (!file_text_eof(file)) {
    json_string += file_text_read_string(file);
    file_text_readln(file);
}
file_text_close(file);

var data = json_parse(json_string);



dialogo = variable_struct_get(data, dialogo_id); 



show_debug_message("oi");
options = [""];
option_pos = 0;


for (var p = 0; p < array_length(dialogo); p++){
	if dialogo[p].type == "decision"{
		option_link_id = array_create(array_length(options), 0)
		array_copy(option_link_id, 0, dialogo[p].linkoption, 0, array_length(dialogo[p].linkoption))
	}
	if p == 4{
	show_debug_message(option_link_id)
	}
}




textbox_width = 206 //largura
textbox_heigth = 70 //altura
textbox_heigth_lim = array_create(array_length(dialogo), 0); //altura
runned_once = false;



//CONFIGURAÇÃO DE TAMANHO DE CAIXA DE DIÁLOGO
for (var p = 0; p < array_length(dialogo); p++){
	switch dialogo[p].type{
		case "chat":
		textbox_heigth_lim[p] = 70;
		break;
		case "battle":
		textbox_heigth_lim[p] = 45;
		textbox_heigth = 45
		textbox_width = 320;
		break;
		case "decision":
		textbox_heigth_lim[p] = 80;
		break;
	}
	//show_debug_message(textbox_heigth_lim[p])
}

portraitbox_size = 70 //altura

line_sep = 12; //separação da linha
border = 7;
line_width = textbox_width - border * 2;// onde quebrar
line_breaks = [];
linebreaks_setted_up = false;
interpreter_setted_up = false;
break_char = undefined;
text_x_offset = 0;
my_color = undefined


text_pause_timer = 0;
text_pause_time = 15;

sound_delay_amount = 5;
sound_delay = 0;

draw_char = 0;
vel_escrita = 1;
page = 0;


current_location = 0;
current_sound = "snd_text_default";
current_textbox = "spr_textbox";
current_speaker = "noone";
current_color = "c_white";
current_page = 0;
current_type = "text";



defaults = {
	current_location : 0,
	current_sound : "snd_text_default",
	current_textbox : "spr_textbox",
	current_speaker : "noone",
	current_color : "c_white"
}
runned_every_page = false;

colors = ds_map_create();
colors[? "c_red"] = c_red;
colors[? "c_yellow"] = c_yellow;
colors[? "c_blue"] = c_blue;
colors[? "c_black"] = c_black;
colors[? "c_white"] = c_white;
colors[? "c_yellow_main"] = #FFD44C;

function check_pause(_char) {
    var pontos = [".", ",", "!"];
    return array_contains(pontos, _char);
}

function find_offset_by_location(_location){
	switch (_location){
		case 3:
			return 135;
		case 2:
			return 10;
		case 1: 
			return 40;
		case 0:
			return 100;
	}
}


function play_text_sound(_snd){
	_snd = asset_get_index(_snd)
	
	if (sound_delay <= 0){
		audio_play_sound(_snd, 3, 0)
		sound_delay = sound_delay_amount;
	} else {
		sound_delay--;
	}
}


function setup_page_variables(){
	current_page = dialogo[page];
	current_type = current_page.type;
	
	var properties_to_check = ["sound", "textbox", "location", "color", "speaker"];
	
	
	for(var i = 0; i < array_length(properties_to_check); i++){
		var key = properties_to_check[i];
		var value = undefined;
		if (variable_struct_exists(current_page, key)){
			value = variable_struct_get(current_page, key);
		} else {
			value = variable_struct_get(defaults, "current_" + key);
		}
		
		switch(key){
			case "sound":
				if asset_get_index(value) == -1{
					value = variable_struct_get(defaults, "current_" + key);
				}
				current_sound = value;
			break;
			case "textbox":
				if asset_get_index(value) == -1{
					value = variable_struct_get(defaults, "current_" + key);
				}
				current_textbox = value;
			break;
			case "location":
				current_location = value;
			break;
			case "color":
				current_color = value;
			break;
			case "speaker":
				if value != "noone"{
					if asset_get_index(value) == -1{
						value = variable_struct_get(defaults, "current_" + key);
					}
				}
				current_speaker = value;
			break;
		}
	}
	runned_every_page = true;
}


//function return_valid_index(_value, _key){
//	var val = asset_get_index(_value);
	
//	if key = 

//}



for (var i = 0; i < 150; i++){
	wave_dir[i] = i*20
}

function text_interpreter(){
 
var effect_flag = [] 

for (var p = 0; p < array_length(dialogo); p++){
	raw_text[p] = dialogo[p].text;
	current_text[p] = "";
	char_effects[p] = [];
	effect_flag = [];

	
	for (var i = 1; i <= string_length(raw_text[p]); i++){
	    var c = string_char_at(raw_text[p], i);
	
	
		if (string_copy(raw_text[p], i, 7) == "</wave>"){
			var pos = array_get_index(effect_flag, "wave");
			//show_debug_message(pos)
			array_delete(effect_flag, pos, 1);
		    i += 6;
			continue;
	    }
		
		if (string_copy(raw_text[p], i, 6) == "<wave>"){
			array_push(effect_flag, "wave");
			i += 5; 
			continue;
		}
		
		if (string_copy(raw_text[p], i, 8) == "</shake>"){
			var pos = array_get_index(effect_flag, "shake");
		//	show_debug_message(pos)
			array_delete(effect_flag, pos, 1);
		    i += 7;
			continue;
	    }
		
		if (string_copy(raw_text[p], i, 7) == "<shake>"){
			array_push(effect_flag, "shake");
			i += 6; 
			continue;
		}
		
		if (string_copy(raw_text[p], i, 8) == "</color>"){
			var pos = array_get_index(effect_flag, "color");
	//		show_debug_message(pos)
			array_delete(effect_flag, pos, 1);
		    i += 7;
			continue;
	    }
		
		if (string_copy(raw_text[p], i, 7) == "<color>"){
			array_push(effect_flag, "color");
			i += 6; 
			continue;
		}

		if (string_copy(raw_text[p], i, 6) == "<item>"){
			i += 5;
			current_text[p] += string(item);
			for (var d = 0; d < string_length(item); d++){
			array_push(char_effects[p], ["item"])
			}
			continue;
		}
		
		

		//show_debug_message("Letra: " + string(c) + "PAGINA: " + string(p) + string(effect_flag))


	    // adicionar caractere ao texto final
	    current_text[p] += c;

	    // salvar efeito para esse caractere
		var _effect_copy = []; 
		array_copy(_effect_copy, 0, effect_flag, 0, array_length(effect_flag));
	    array_push(char_effects[p], _effect_copy);
		
	    interpreter_setted_up = true;
		
		}
		//show_debug_message("PAGINA NUMERO: " + string(p) + string(char_effects[p]))
	}
}

function carregar_line_breaks(){

for (var p = 0; p < array_length(dialogo); p++){//percorrer as paginas
	
	
	line_breaks[p] = [];// inicializa o subarray da pagina
	var last_empty_char = 0; //inicializa o ultimo espaco 
	var start_char = 1; //inicializa o comeco da contagem
	var page_type = dialogo[p].type;
	
	if page_type == "decision"{
		line_width = 150;
	}
	
	for(var c = 1; c < string_length(current_text[p]); c++){// percorre os caracteres do texto da pag
		
		var next_char = c+1; // variavel de facil acesso ao proximo char da contagem
		
		if string_char_at(current_text[p], c) == " " { //se o char do texto dessa pagina for um espaco...
		   last_empty_char = c; //ele guarda esse local em uma variavel
		   
		}
		
		//tamanho atual da string, em pixels, desde o ultimo espaço vazio (ou comeco da string!!! :D)
		var current_width = string_width(string_copy(current_text[p], start_char, c - start_char + 1));
		
		// se tamanho atual for maior que a largura permitida pras linhas, 
		if (current_width > line_width){
			
			if (last_empty_char > start_char){
			array_push(line_breaks[p], last_empty_char); // adiciona o ultimo caractere vazio para o array de breaks
			start_char = last_empty_char + 1;// e inicializa de volta o começo do calculo com o ultimo espaço
			} else {
			array_push(line_breaks[p], c);
			start_char = c + 1;// e inicializa de volta o começo do calculo com o ultimo espaço
			}
		}
	}
	
	array_push(line_breaks[p], string_length(current_text[p]));
	
//show_debug_message("QUEBRAS DA PAG " + string(p) + " SAO: " + string(line_breaks[p]))
}
linebreaks_setted_up = true;


}

show_debug_message(" criei")

