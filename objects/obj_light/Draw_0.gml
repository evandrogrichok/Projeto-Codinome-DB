gpu_set_blendmode(bm_add);

if (enable_light_source){
draw_sprite_stretched_ext(spr_radial, 0, x - light_sprite_radious/2, y - light_sprite_radious/2, light_sprite_radious, light_sprite_radious, light_color, light_alpha);
}
if (enable_second_light_source){
draw_sprite_stretched_ext(spr_radial, 0, x - secondary_light_radious/2, y - secondary_light_radious/2, secondary_light_radious, secondary_light_radious, light_color, secondary_light_alpha);
}

gpu_set_blendmode(bm_normal);