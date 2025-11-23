//draw_self()


if (draw_shadow){
draw_sprite_ext(spr_shadow, 0, x, final_y, 1, 1, 0, c_white, y/final_y)
}

if y <= final_y-10{
	draw_sprite_ext(sprite_index, image_index, x, y, 1, 1, 0, c_white, .7)
} else {
	draw_sprite_ext(sprite_index, image_index, x, y, 1, 1, 0, c_white, 1)
}

draw_text_transformed(x-25, y, depth,0.3,0.3,0);