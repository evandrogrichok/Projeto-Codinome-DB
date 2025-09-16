function iniciar_hopebattle(_indexname){
	obj_player.persistent = false;
	obj_camera.persistent = false;
	obj_ingamemenu.persistent = false;
	obj_room_manager.persistent = false;
	room_goto(rm_hopebattle);
	
	show_debug_message("ROOM:" + string(room))
	instance_create_layer(x,y,"Instances",obj_hopebattle_manager);
	show_debug_message("criou manager")
	
	var _inst = obj_hopebattle_manager;
	
		
	_inst.character_hope_battle = _indexname
	_inst.character_csv = load_csv(_indexname+".csv")
	show_debug_message("carregou csv")

}

function create_objects_hb(_indexname){
	show_debug_message("ROOM:" + string(room))
	
	switch(_indexname){
		default:
		
			instance_create_layer(480,2624,"Instances",obj_barrier)
			with (instance_create_layer(864,2624,"Instances",obj_barrier)){
				image_angle += 180
			}
			with (instance_create_layer(672,2720,"Instances",obj_barrier)){
				image_angle += 90
			break;
		}
	}
	instance_create_layer(683,2656,"Instances",obj_playerhope_hb);
	show_debug_message("criou ph")
	instance_create_layer(683,2656,"Instances",obj_camera_hpbattle);
	show_debug_message("criou camera")
	objects_created = true;


}

// ------------------------------------------------------------------------------

//BATTLE BULLET PATTERNS

function side_bullets(_side){
	if instance_exists(obj_playerhope_hb){
	var xplayer = obj_playerhope_hb.x
	var yplayer = obj_playerhope_hb.y
	var y_offset = 0;
	
	for (var i = 0; i < 3; i++){

		instance_create_depth(xplayer + random_range(60,70) * _side, yplayer + y_offset, -1000, obj_followingarrows)
		y_offset += 30;
	}
	}
}

function ice_spikes(){
	
	var xplayer = obj_playerhope_hb.x;
	var yplayer = obj_playerhope_hb.y;

	instance_create_depth(irandom_range(xplayer - 150, xplayer+150), yplayer -200, -1000, obj_spikes);
}

