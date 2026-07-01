import rt

fn render_block_core_comments_pagination_previous(var_attributes rt.PhpVal, var_content rt.PhpVal, var_block rt.PhpVal) string {
	mut var_default_label := rt.call_function('__', [rt.new_string('Older Comments')])
	mut var_label := if var_attributes.array_isset(rt.new_string('label'))
		&& !(!rt.is_true(var_attributes.array_get('label'))) {
		var_attributes.array_get('label')
	} else {
		var_default_label
	}
	mut var_pagination_arrow := rt.call_function('get_comments_pagination_arrow', [
		var_block.dup(),
		rt.new_string('previous'),
	])
	if rt.is_true(var_pagination_arrow) {
		var_label = rt.new_string(rt.concat(var_pagination_arrow, var_label))
	}
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		return (rt.call_function('get_block_wrapper_attributes', []rt.PhpVal{})).str()
	}
	mut var_filter_link_attributes := rt.new_closure(closure_1_fn)
	rt.call_function('add_filter', [rt.new_string('previous_comments_link_attributes'),
		var_filter_link_attributes.dup()])
	mut var_comment_vars := rt.call_function('build_comment_query_vars_from_block', [
		var_block.dup(),
	])
	mut var_previous_comments_link := rt.call_function('get_previous_comments_link', [
		var_label.dup(),
		if !(var_comment_vars.array_get('paged')).is_null() {
			var_comment_vars.array_get('paged')
		} else {
			rt.new_null()
		},
	])
	rt.call_function('remove_filter', [
		rt.new_string('previous_comments_link_attributes'),
		var_filter_link_attributes.dup(),
	])
	if !(!var_previous_comments_link.is_null()) {
		return ''
	}
	return var_previous_comments_link.str()
}

fn register_block_core_comments_pagination_previous() {
	rt.call_function('register_block_type_from_metadata', [
		@DIR + '/comments-pagination-previous',
		rt.create_array([
			rt.ArrayItem{
				key: 'render_callback'
				val: 'render_block_core_comments_pagination_previous'
			},
		]),
	])
}

pub fn init_wp_includes_blocks_comments_pagination_previous_php() {
	rt.call_function('add_action', [rt.new_string('init'),
		rt.new_string('register_block_core_comments_pagination_previous')])
}
