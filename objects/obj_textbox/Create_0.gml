depth = DEPTH.UI_TOP;

//if (custom_message == false){
data = load_json_file("dialogos.json")
//dialogo = variable_struct_get(data, dialogo_id); 

//if dialogo == undefined {
//	show_error("DIÁLOGO NAO ENCONTRADO/NÃO FORMATADO CORRETAMENTE. VERIFIQUE SE O USO DE NEW _MSG FUNCITION ESTÁ CORRETO OU SE O ID EXISTE NO ARQUIVO DE DIÁLOGOS.", true);
//}


//show_debug_message(dialogo)
//}


function resolve_dialog(dialogs){
	var resolved = []
	
	for (var i = 0; i < array_length(dialogs); i++){
		
		
		var dialog = dialogs[i];
		show_debug_message(dialog);
		if is_string(dialog){
			var retrieved_dialog = variable_struct_get(data, dialog); 
			show_debug_message(retrieved_dialog);
			if (retrieved_dialog == undefined) {
				    show_error("Diálogo '" + dialog + "' não encontrado.", true);
			}
			
			if (is_array(retrieved_dialog)){
				show_debug_message("vo concatena")
				show_debug_message(resolved)
				
			     resolved = array_concat(resolved, retrieved_dialog);
				show_debug_message("concatenei")
				show_debug_message(resolved) 
			} else {
			    array_push(resolved, retrieved_dialog);
			}


			
		} else
		if is_struct(dialog){
			array_push(resolved, dialog);
		} else {
			show_error("DIÁLOGO NAO ENCONTRADO/NÃO FORMATADO CORRETAMENTE. VERIFIQUE SE O USO DE NEW _MSG FUNCITION ESTÁ CORRETO OU SE O ID EXISTE NO ARQUIVO DE DIÁLOGOS.", true);
		}
	}
	
	return resolved;
}

dialogo = resolve_dialog(dialog_array);



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

if dialogo[0].type != "battle"
scr_can_move_tweaker(-1);

textbox_width = 220 //largura
textbox_heigth = 60 //altura
textbox_heigth_lim = array_create(array_length(dialogo), 0); //altura
runned_once = false;
padding_btwn_emotion_txtbox = 5;
x_padding = (camera_get_view_width(view_camera[0]) - textbox_width)/2;




current_location = 0;
current_sound = "snd_text_default";
current_textbox = "spr_textbox";
current_target = "noone";
current_emotion = "noone";
current_color = "c_white";
current_page = undefined;
current_type = "text";
current_flip_page = true;



defaults = {
	current_location : 0,
	current_sound : "snd_text_default",
	current_target : "noone",
	current_textbox : "spr_textbox",
	current_emotion : "noone",
	current_color : "c_white",
	current_flip_page : true
}
page = 0;
current_page = dialogo[page];
current_type = current_page.type;


//CONFIGURAÇÃO INICIAL DE TAMANHO DE CAIXA DE DIÁLOGO
function determine_textbox_size_by_type(){
	if (current_type == "battle" || current_type == "battle_event") {
    if (current_emotion != "noone") {
        textbox_width = 260
    } else {

        textbox_width = 310; 
    }
    textbox_heigth = 49;
	} else if (current_type == "decision") {
	    textbox_width = 220; // O seu padrão
	    textbox_heigth = 80;
	} else {
	    // Chat normal
	    textbox_width = 220;
	    textbox_heigth = 60;
	   
	}
	textbox_heigth_lim[page] = textbox_heigth;
}

determine_textbox_size_by_type();



line_sep = 12; //separação da linha
border = 7;

padding_x_text = 7;
padding_y_text = 5;


line_width = textbox_width - border * 2 - padding_x_text;// onde quebrar
line_breaks = [];
linebreaks_setted_up = false;
interpreter_setted_up = false;
break_char = undefined;
text_x_offset = 0;
my_color = undefined


text_pause_timer = 0;
text_pause_time = 12;

sound_delay_amount = 5;
sound_delay = 0;

draw_char = 0;
vel_escrita = 1;




runned_every_page = false;

colors = ds_map_create();
colors[? "c_red"] = c_red;
colors[? "c_yellow"] = c_yellow;
colors[? "c_blue"] = c_blue;
colors[? "c_purple"] = c_fuchsia;
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
			return 130;
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
	var p = choose(1, 1.122, 1.26);
	
	if (sound_delay <= 0){
		audio_play_sound(_snd, 3, 0,1,0, p);
		sound_delay = sound_delay_amount;
	} else {
		sound_delay--;
	}
}


function setup_page_variables(){
	current_page = dialogo[page];
	current_type = current_page.type;
	
	if current_type == "battle"{
		padding_x_text = 0;
		padding_y_text = textbox_heigth/3;
	}

	
	var properties_to_check = [ "textbox", "location", "color",  "target", "sound", "emotion",  "flip_page"];
	
	
	for(var i = 0; i < array_length(properties_to_check); i++){
		var key = properties_to_check[i];
		var value = undefined;
		
		if (variable_struct_exists(current_page, key)){
			value = variable_struct_get(current_page, key);
		} else {
			value = variable_struct_get(defaults, "current_" + key);
		}
		

		switch(key){
			case "textbox":
				if asset_get_index(value) == -1{
					value = variable_struct_get(defaults, "current_" + key);
				}
				current_textbox = value;
			break;
			case "location":
				current_location = value;
			break;
			case "flip_page":
				current_flip_page = value;
			break;
			case "color":
				current_color = value;
			break;
			case "target":
				var _try_value = get_char_by_name(value);
				current_target = _try_value;
				show_debug_message("target")
				show_debug_message(current_target)
			break;
			
			case "sound":
				
			
				if (current_target != noone) {
				        // Se o filho não mudou nada, 'value' será o som do pai (snd_default).
				        // Se o filho mudou, 'value' será o som novo (ex: snd_glint).
				        value = current_target.voice_sound;
				    } 
					
					if (is_string(value)) {
				        value = asset_get_index(value);
				    }

				    // Checagem de segurança: Se o valor for inválido ou não existir no objeto
				    if (is_undefined(value) || value == -1) {
				        value = variable_struct_get(defaults, "current_" + key);
				    }
    
				    // Converte para ID caso o valor final ainda seja uma string (do struct defaults)
				    if (is_string(value)) {
				        value = asset_get_index(value);
				    }
				
				current_sound = value;
				
			break;
			case "emotion":
				if current_target != noone{ //primeiro checa se tem speaker definido
					if value != "noone"{//primeiro checa se tem emotion definido
					var _sprite = current_target.my_portraits[$ value] ?? -1;// procura se existe o sprite/instancia	
						//se tiver emotion
						if _sprite == -1{// checa se existe a emotion e instancia
							value = defaults[$ "current_" + key]; //pega a default se não
						} else {
							value = _sprite;//pega o sprite que achou se sim
						}
					}
				} else {// se nao tiver emotion/speaker
					value = defaults[$ "current_" + key];
				}
				current_emotion = value;
			break;
		}
	}
	
	determine_textbox_size_by_type();
	
	line_width = textbox_width - border * 2 - padding_x_text
	show_debug_message("CURRENT FLIP PAGE = " + string (current_flip_page))
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
	
	//if page_type == "decision"{
	//	line_width = 150;
	//}
	
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


function next_page(){
		if current_type == "battle"
		return;
		
		if current_type == "decision"
		return;
		
		page++;
		draw_char = 0;
		runned_every_page = false;
}

portraitbox_size = textbox_heigth;

show_debug_message("abab")
show_debug_message(portraitbox_size)