import rt

fn render_block_core_comments_pagination_next(var_attributes rt.PhpVal, var_content rt.PhpVal, var_block rt.PhpVal) string {
	mut var_comment_vars := rt.new_null()
	mut var_max_page := rt.new_null()
	mut var_default_label := rt.new_null()
	mut var_label := rt.new_null()
	mut var_pagination_arrow := rt.new_null()
	mut var_filter_link_attributes := rt.new_null()
	mut var_next_comments_link := rt.new_null()
	if !rt.is_true(rt.get_property(var_block, 'context').array_get(rt.new_string('postId'))) {
		return ''
	}
	var_comment_vars = rt.call_function('build_comment_query_vars_from_block', [
		var_block.clone(),
	])
	var_max_page = rt.get_property(create_wp_comment_query(var_comment_vars.clone()),
		'max_num_pages')
	var_default_label = rt.call_function('__', [rt.new_string('Newer Comments')])
	var_label = if var_attributes.array_isset(rt.new_string('label'))
		&& !(!rt.is_true(var_attributes.array_get(rt.new_string('label')))) {
		var_attributes.array_get(rt.new_string('label'))
	} else {
		var_default_label
	}
	var_pagination_arrow = rt.call_function('get_comments_pagination_arrow', [
		var_block.clone(), rt.new_string('next')])
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		return (rt.call_function('get_block_wrapper_attributes', []rt.PhpVal{})).str()
	}
	var_filter_link_attributes = rt.new_closure(closure_1_fn)
	rt.call_function('add_filter', [rt.new_string('next_comments_link_attributes'),
		var_filter_link_attributes.clone()])
	if rt.is_true(var_pagination_arrow) {
		var_label = rt.concat(var_label, var_pagination_arrow)
	}
	var_next_comments_link = rt.call_function('get_next_comments_link', [
		var_label.clone(), var_max_page.clone(), if !(var_comment_vars.array_get(rt.new_string('paged'))).is_null() {
			var_comment_vars.array_get(rt.new_string('paged'))
		} else {
			rt.new_null()
		}])
	rt.call_function('remove_filter', [rt.new_string('next_posts_link_attributes'),
		var_filter_link_attributes.clone()])
	if !(!var_next_comments_link.is_null()) {
		return ''
	}
	return var_next_comments_link.str()
}

fn register_block_core_comments_pagination_next() {
	rt.call_function('register_block_type_from_metadata', [
		rt.new_string(@DIR + '/comments-pagination-next'),
		rt.create_array([
			rt.ArrayItem{ key: 'render_callback', val: 'render_block_core_comments_pagination_next' },
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
		rt.new_string('register_block_core_comments_pagination_next')])
}
