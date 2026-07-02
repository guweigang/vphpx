import rt

fn render_block_core_comments_pagination_numbers(var_attributes rt.PhpVal, var_content_arg rt.PhpVal, var_block rt.PhpVal) string {
	mut var_content := var_content_arg
	mut var_comment_vars := rt.new_null()
	mut var_total := rt.new_null()
	mut var_current := rt.new_null()
	mut var_wrapper_attributes := rt.new_null()
	if !rt.is_true(rt.get_property(var_block, 'context').array_get(rt.new_string('postId'))) {
		return ''
	}
	var_comment_vars = rt.call_function('build_comment_query_vars_from_block', [
		var_block.clone(),
	])
	var_total = rt.get_property(create_wp_comment_query(var_comment_vars.clone()), 'max_num_pages')
	var_current = if !(!rt.is_true(var_comment_vars.array_get(rt.new_string('paged')))) {
		var_comment_vars.array_get(rt.new_string('paged'))
	} else {
		rt.new_null()
	}
	var_content = rt.call_function('paginate_comments_links', [
		rt.create_array([rt.ArrayItem{ key: 'total', val: var_total },
			rt.ArrayItem{ key: 'current', val: var_current },
			rt.ArrayItem{ key: 'prev_next', val: false }, rt.ArrayItem{ key: 'echo', val: false }]),
	])
	if !rt.is_true(var_content) {
		return ''
	}
	var_wrapper_attributes = rt.call_function('get_block_wrapper_attributes', []rt.PhpVal{})
	return (rt.call_function('sprintf', [rt.new_string('<div %1$s>%2$s</div>'),
		var_wrapper_attributes.clone(), var_content.clone()])).str()
}

fn register_block_core_comments_pagination_numbers() {
	rt.call_function('register_block_type_from_metadata', [
		rt.new_string(@DIR + '/comments-pagination-numbers'),
		rt.create_array([
			rt.ArrayItem{
				key: 'render_callback'
				val: 'render_block_core_comments_pagination_numbers'
			},
		]),
	])
}

struct Class_WP_Comment_Query {
	rt.PhpObjectBase
}

fn create_wp_comment_query(_args ...rt.PhpVal) &Class_WP_Comment_Query {
	mut obj := &Class_WP_Comment_Query{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Comment_Query) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Comment_Query) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Comment_Query) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.call_function('add_action', [rt.new_string('init'),
		rt.new_string('register_block_core_comments_pagination_numbers')])
}
