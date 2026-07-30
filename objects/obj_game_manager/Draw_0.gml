var inventory_length = array_length(inventory);
var cam_x = obj_camera.x;
var cam_y = obj_camera.y;
var padding = 0


//for (var i = 0; i < inventory_length; i++){
//	draw_sprite_stretched(asset_get_index(global.ITEMS_DATA.item_001.sprite), 0, cam_x- 50 + padding, cam_y+50, 16, 16);
//	draw_text_transformed(cam_x - 50 + padding, cam_y+50 + 20,string(global.ITEMS_DATA.item_001.name),0.5,0.5,1);
//	padding += 16;
//}


//// 1. Pega as dimensões da câmera atual
//var _cam = view_camera[0];
//var _cx = camera_get_view_x(_cam);
//var _cy = camera_get_view_y(_cam);
//var _cw = camera_get_view_width(_cam);
//var _ch = camera_get_view_height(_cam);

//// 2. Muda o modo de mistura da GPU para "Multiply"
//// Isso diz para a GPU: "Multiplique a cor que vou desenhar pela cor que já está na tela"
//gpu_set_blendmode_ext(bm_dest_color, bm_zero);

//// 3. Define a cor do filtro (Ex: Um tom alaranjado para pôr do sol
//draw_set_color(#ad88f7); // Ou c_red, c_blue, etc.

//// 4. Desenha o retângulo cobrindo a câmera
//draw_rectangle(_cx, _cy, _cx + _cw, _cy + _ch, false);

//// 5. Volta a GPU para o normal para não bugar o resto do jogo!
//gpu_set_blendmode(bm_normal);
//draw_set_color(c_white);