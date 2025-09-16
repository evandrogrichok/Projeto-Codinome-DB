event_inherited();

x = x + lengthdir_x(1,point_direction(x,y, obj_playerhope_hb.x, obj_playerhope_hb.y));
y = y + lengthdir_y(1,point_direction(x,y, obj_playerhope_hb.x, obj_playerhope_hb.y));

image_angle = point_direction(x,y, obj_playerhope_hb.x, obj_playerhope_hb.y)

timer --;

if timer <= 0 {
	instance_destroy()
}

if image_yscale<1{
	image_yscale += vel_imagescaling
}