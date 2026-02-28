function fx_pickup(){
		if self.fx_pickup_index < sprite_get_number(spr_point_fx_pickup) -1{
			self.fx_pickup_index = scr_animar_sprite(fx_pickup_index, fx_pickup_speed, spr_point_fx_pickup);
			draw_sprite_ext(spr_point_fx_pickup, self.fx_pickup_index, x, y, 1, 1, 0, global.point_part_colors[1], 1);
		}
}
function fx_particle(values_array){
		var inner_min_spd = values_array[0]
		var inner_max_spd = values_array[1]
		var min_spd = values_array[2]
		var max_spd = values_array[3]
		var center_correction = .5;
		part_type_colour1(global.part_type_points, global.point_part_colors[1]);
		part_emitter_region(global.part_sys_points, global.part_emitter_points, x+center_correction, x+center_correction , y-center_correction, y-center_correction, ps_shape_rectangle, ps_distr_linear);
		part_type_speed(global.part_type_points, min_spd, max_spd, 0, 0);
		part_emitter_burst(global.part_sys_points, global.part_emitter_points, global.part_type_points, 15);
		part_type_colour1(global.part_type_points, global.point_part_colors[2]);
		part_type_speed(global.part_type_points, inner_min_spd, inner_max_spd, 0, 0);
		part_emitter_burst(global.part_sys_points, global.part_emitter_points, global.part_type_points, 5);
}