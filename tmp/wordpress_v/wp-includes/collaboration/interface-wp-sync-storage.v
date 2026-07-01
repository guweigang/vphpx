import rt

interface WP_Sync_Storage {
	add_update(rt.PhpVal, rt.PhpVal) rt.PhpVal
	get_awareness_state(rt.PhpVal) rt.PhpVal
	get_cursor(rt.PhpVal) rt.PhpVal
	get_update_count(rt.PhpVal) rt.PhpVal
	get_updates_after_cursor(rt.PhpVal, rt.PhpVal) rt.PhpVal
	remove_updates_before_cursor(rt.PhpVal, rt.PhpVal) rt.PhpVal
	set_awareness_state(rt.PhpVal, rt.PhpVal) rt.PhpVal
}

pub fn init_wp_includes_collaboration_interface_wp_sync_storage_php() {
	mut var_room := rt.new_null()
	mut var_update := rt.new_null()
	mut var_cursor := rt.new_null()
	mut var_awareness := rt.new_null()
}
