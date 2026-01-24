with(obj_battle_manager){
draw_sprite_ext(spr_vignette, 0, camera_get_view_x(view_camera[0]), camera_get_view_y(view_camera[0]), 1, 1, 0, c_white, alpha_vignette);
draw_sprite_stretched_ext(spr_black, 0, camera_get_view_x(view_camera[0]), camera_get_view_y(view_camera[0]), cam_w, cam_h, c_white, black_bg_color_alpha);
}