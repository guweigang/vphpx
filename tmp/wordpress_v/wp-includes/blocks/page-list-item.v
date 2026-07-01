import rt

fn register_block_core_page_list_item() {
	rt.call_function('register_block_type_from_metadata', [@DIR + '/page-list-item'])
}

pub fn init_wp_includes_blocks_page_list_item_php() {
	rt.call_function('add_action', [rt.new_string('init'),
		rt.new_string('register_block_core_page_list_item')])
}
