//// --- No evento de Draw (ou Draw GUI) onde for aplicar o shader ---
//shader_set(sh_lighting);

//// Define a cor da sombra (Ex: Um azul escuro noturno)
//shader_set_uniform_f(uni_shadow_color, colour_get_red(global_shadow_color)/255, colour_get_green(global_shadow_color)/255, colour_get_blue(global_shadow_color)/255);

//var _cam = view_camera[0];
//var _cx = camera_get_view_x(_cam);
//var _cy = camera_get_view_y(_cam);
//var _cw = camera_get_view_width(_cam);
//var _ch = camera_get_view_height(_cam);

//// Envia o aspect ratio para as luzes ficarem perfeitamente redondas
//shader_set_uniform_f(uni_aspect, _cw / _ch);

//var _pos_array = [];
//var _rad_array = [];
//var _count = 0;

//// Passa por todos os objetos de luz no mapa
//with (obj_light) {
//    if (_count < 8) { // Respeita o limite do MAX_LIGHTS do shader
//        // Converte o X e Y do mundo para UV da tela
//        var _uv_x = (x - _cx) / _cw;
//        var _uv_y = (y - _cy) / _ch;
        
//        array_push(_pos_array, _uv_x, _uv_y);
        
//        // Define o raio (dividido pela largura da câmera para manter escala UV)
//        array_push(_rad_array, light_radious / _cw);
        
//        _count++;
//    }
//}

//// Envia as quantidades e os arrays preenchidos para o Shader
//shader_set_uniform_i(uni_light_count, _count);
//if (_count > 0) {
//    shader_set_uniform_f_array(uni_light_pos, _pos_array);
//    shader_set_uniform_f_array(uni_light_radii, _rad_array);
//}

//// Desenha a surface na posição 0,0 da tela inteira (pois estamos no Post-Draw)
//draw_surface(application_surface, 0, 0); 

//shader_reset();