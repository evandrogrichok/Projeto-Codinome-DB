// para que a caixa sempre apareça em cima de tudo
depth = -99999;

//parametros de tamanho
textbox_width = 206 //largura
textbox_heigth = 70 //altura

border = 8; //borda do texto
line_sep = 12; //separação da linha
line_width = textbox_width - border*2; // quanto a linha pode andar antes de quebrar

txtb_img = 0; //controle dos sprites
txtb_img_spd =  0; //animacao dos sprites

// texto
page = 0; //pagina do texto
page_number = 0; //numero da pagina
text[0] = ""; //texto em si
text_length[0] = string_length(text[0]); //largura do txto em chars


//controle individual dos caracteres
char[0, 0] = "";
char_x[0, 0] = 0
char_y[0, 0] = 0


draw_char = 0;
text_speed = 1;

// opcoes

option[0] = "";
option_link_id[0] = -1;
option_pos = 0;
option_number = 0;

setup = false;

// som
snd_delay = 5;
snd_count = snd_delay

// efeitos
scr_set_defaults_for_text()
last_free_space = 0;
text_pause_timer = 0;
text_pause_time = 16;

