var _cam = view_camera[0];
var _cx = camera_get_view_x(_cam);
var _cy = camera_get_view_y(_cam);
var _cw = camera_get_view_width(_cam);
var _ch = camera_get_view_height(_cam);

// 1. Garante que a nossa surface customizada existe (Surfaces na memória podem sumir do nada)
if (!surface_exists(sombra_surface)) {
    sombra_surface = surface_create(_cw, _ch);
}

// 2. Limpa a nossa surface deixando ela totalmente branca (100% de luz antes do shader agir)
surface_set_target(sombra_surface);
draw_clear(c_white);
surface_reset_target();

// 3. Ativa o seu shader com o código intacto
shader_set(sh_lighting);

// Envia a cor da sombra (seu código original de conversão)
shader_set_uniform_f(uni_shadow_color, colour_get_red(global_shadow_color)/255, colour_get_green(global_shadow_color)/255, colour_get_blue(global_shadow_color)/255);
shader_set_uniform_f(uni_aspect, _cw / _ch);

var _pos_array = [];
var _rad_array = [];
var _count = 0;

with (obj_light) {
    if (_count < 8) {
        var _uv_x = (x - _cx) / _cw;
        var _uv_y = (y - _cy) / _ch;
        
        array_push(_pos_array, _uv_x, _uv_y);
        array_push(_rad_array, light_radious / _cw);
        
        _count++;
    }
}

shader_set_uniform_i(uni_light_count, _count);
if (_count > 0) {
    shader_set_uniform_f_array(uni_light_pos, _pos_array);
    shader_set_uniform_f_array(uni_light_radii, _rad_array);
}

// 4. ATENÇÃO: Ativamos o modo MULTIPLY da GPU para a nossa folha de sombra
// se misturar com o cenário que já foi desenhado no chão
gpu_set_blendmode_ext(bm_dest_color, bm_zero);

// Desenha a nossa surface de sombra cobrindo a visão da câmera
draw_surface(sombra_surface, _cx, _cy);

// 5. Reseta tudo para o normal do GameMaker
gpu_set_blendmode(bm_normal);
shader_reset();