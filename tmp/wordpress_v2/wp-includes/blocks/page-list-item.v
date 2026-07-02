import rt

fn register_block_core_page_list_item() {
	rt.call_function('register_block_type_from_metadata', [
		rt.new_string(@DIR + '/page-list-item'),
	])
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.call_function('add_action', [rt.new_string('init'),
		rt.new_string('register_block_core_page_list_item')])
}
