var inst_player = obj_player

show_debug_message("oi")

var offset = 0; 
var quant = 20;
var range = 60

for (var i = 0; i < quant; i++){
	var trail_offset = 0.02;
	var trail_alpha =0.5;
	for (var j = 0; j < 3; j++){
		draw_sprite_ext(spr_circle,0,x + (range *sin(sin_t_1-trail_offset + offset)),y + (range *sin(sin_t_2 - trail_offset + offset)),1,1,0,c_white,trail_alpha)
		trail_offset -= 0.02;
		trail_alpha -= 0.15;
	}
	draw_sprite(spr_circle,0,x + (range *sin(sin_t_1 + offset)),y + (range *sin(sin_t_2+ offset)))
	
	offset += quant/range

}


//draw_circle(x, y, 60, true)