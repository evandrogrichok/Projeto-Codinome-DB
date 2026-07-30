if moving
array_push(walk_history, [x, y]);

if array_length(walk_history) > 300 {
	array_delete(walk_history, 0, 1);
}