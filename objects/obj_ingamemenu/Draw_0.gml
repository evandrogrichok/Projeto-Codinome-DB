//declaração de variáveis úteis e configs
tecla_menu = keyboard_check_pressed(vk_escape);
quant_opcoes =  array_length(opcoes);
quant_itens =  array_length(itens);
quant_config = array_length(config);
y_offset = obj_player.y-25
x_player = obj_player.x;

draw_set_font(fnt_main)

// toggle menu (quando botao apertado, menu ativado)
if (tecla_menu){
	global.menu_ativo = !global.menu_ativo
}
//se o menu for ativado:	
if global.menu_ativo{
	draw_sprite_ext(spr_textbox,0,obj_player.x + 15, y_offset-5, 10, 4.1,0,c_white,1);
	
	//desenhar opções na tela
	for (var _op = 0; _op < quant_opcoes; _op++){
		//desenhando sprite de c
		
		draw_text(obj_player.x + 20, y_offset, opcoes[_op]);
		//distancia de uma opcao pra outra
		y_offset += 10
	}

	//variavel que recebe onde a opcao está, com clamp pra delimitar até onde ele pode ir
	option_pos += keyboard_check_pressed(vk_down) - keyboard_check_pressed(vk_up)
	option_pos = clamp(option_pos, 0, quant_opcoes-1)

	//resetando a variavel de distancia das opcoes
	y_offset = obj_player.y-25; // reseta variavel

	//quanto a seta tem que andar em cada opcao
	arrow_y_offset = y_offset + 10*option_pos;
	draw_sprite(spr_seta_txt, 0, obj_player.x - 10, arrow_y_offset); // desenha sprite


	if keyboard_check_pressed(vk_enter){
	scr_menuopt(option_pos)
	}
} 

if global.itens_menu = true{
	//corrigindo delay para consumo de itens
	if keyboard_check_released(vk_enter){
		can_consume = true
		}
	//desenhando fundo das opcoes
	draw_sprite_ext(spr_textbox,0,obj_player.x + 15, y_offset-5, 10, 9.2,0,c_white,1);
	
		if tecla_menu{
		global.itens_menu = false
		}
		
	//desenhando os itens na tela
	for(var _item_id = 0; _item_id < array_length(itens); _item_id++){
		draw_text(obj_player.x+20, y_offset, itens[_item_id])
		y_offset += 10;
		}
		
	//variavel que recebe onde a opcao está, com clamp pra delimitar até onde ele pode ir
	option_pos += keyboard_check_pressed(vk_down) - keyboard_check_pressed(vk_up)
	option_pos = clamp(option_pos, 0, quant_itens-1)

	//resetando a variavel de distancia das opcoes
	y_offset = obj_player.y-25;

	//quanto a seta tem que andar em cada opcao
	arrow_y_offset = y_offset + 10*option_pos;
	draw_sprite(spr_seta_txt, 0, obj_player.x - 10, arrow_y_offset); // desenha sprite
	
	if keyboard_check_pressed(vk_enter) && can_consume == true{
	scr_useitem(itens[option_pos])	
	itens[option_pos] = "- - -"
	}

}

if global.config_menu = true{
	
	if tecla_menu{
	global.config_menu = false
	}
	
	if keyboard_check_released(vk_enter){
	can_change = true
	}
	//desenhando fundo das opcoes
	draw_sprite_ext(spr_textbox,0,obj_player.x + 15, y_offset-5, 10, 9.2,0,c_white,1);
	
	
	
	for(var _config_id = 0; _config_id < array_length(config); _config_id++){
		draw_text(obj_player.x+20, y_offset, config[_config_id])
		y_offset += 10;
	}

	//variavel que recebe onde a opcao está, com clamp pra delimitar até onde ele pode ir
	option_pos += keyboard_check_pressed(vk_down) - keyboard_check_pressed(vk_up)
	option_pos = clamp(option_pos, 0, quant_config-1)
	


	//resetando a variavel de distancia das opcoes
	y_offset = obj_player.y-25;
	
	//desenhando o sprite de ativo ou nao ativo e colocano o codigo de fullscreen
	if can_change = true{
		if option_pos == 0 && keyboard_check_pressed(vk_enter){
			tela_cheia = !tela_cheia;
		}
	}
	if tela_cheia{
		window_set_fullscreen(true);
	} else {
		window_center();
		window_set_fullscreen(false);
	}
	
	draw_sprite_ext(spr_bool_opt, tela_cheia, x_player + 100, y_offset, 1, 1, 0, c_white, 1);
	//quanto a seta tem que andar em cada opcaoz
	arrow_y_offset = y_offset + 10*option_pos;
	draw_sprite(spr_seta_txt, 0, obj_player.x - 10, arrow_y_offset); // desenha sprite
	
	
}
