//draw_self()


if (draw_shadow){
draw_sprite_ext(spr_shadow, 0, x, final_y, 1, 1, 0, c_white, (y - initial_y)/(final_y - initial_y))
}

draw_sprite_ext(sprite_index, image_index, x, y, width, 1, 0, c_white, 1)

//draw_text_transformed(x-25, y, initial_y/final_y - initial_y,0.3,0.3,0);