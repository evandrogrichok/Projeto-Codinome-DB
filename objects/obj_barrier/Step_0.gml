if image_angle == 90{
	x = obj_playerhope_hb.x
} else{
	y = obj_playerhope_hb.y
}

var dist = point_distance(obj_playerhope_hb.x,obj_playerhope_hb.y,x,y);
dist = 100 - dist
 
dist = clamp(dist,1,50)

image_alpha = 0.02 * dist
