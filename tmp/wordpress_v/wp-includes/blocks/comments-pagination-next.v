import rt

fn render_block_core_comments_pagination_next(var_attributes rt.PhpVal, var_content rt.PhpVal, var_block rt.PhpVal) string {
	if !rt.is_true(rt.get_property(var_block, 'context').array_get('postId')) {
		return ''
	}
	mut var_comment_vars := rt.call_function('build_comment_query_vars_from_block', [
		var_block.dup(),
	])
	mut var_max_page := rt.get_property(create_wp_comment_query(var_comment_vars.dup()),
		'max_num_pages')
	mut var_default_label := rt.call_function('__', [rt.new_string('Newer Comments')])
	mut var_label := if var_attributes.array_isset(rt.new_string('label'))
		&& !(!rt.is_true(var_attributes.array_get('label'))) {
		var_attributes.array_get('label')
	} else {
		var_default_label
	}
	mut var_pagination_arrow := rt.call_function('get_comments_pagination_arrow', [
		var_block.dup(),
		rt.new_string('next'),
	])
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		return (rt.call_function('get_block_wrapper_attributes', []rt.PhpVal{})).str()
	}
	mut var_filter_link_attributes := rt.new_closure(closure_1_fn)
	rt.call_function('add_filter', [rt.new_string('next_comments_link_attributes'),
		var_filter_link_attributes.dup()])
	if rt.is_true(var_pagination_arrow) {
		// unsupported expression: Expr_AssignOp_Concat
	}
	mut var_next_comments_link := rt.call_function('get_next_comments_link', [
		var_label.dup(), var_max_page.dup(), if !(var_comment_vars.array_get('paged')).is_null() {
			var_comment_vars.array_get('paged')
		} else {
			rt.new_null()
		}])
	rt.call_function('remove_filter', [rt.new_string('next_posts_link_attributes'),
		var_filter_link_attributes.dup()])
	if !(!var_next_comments_link.is_null()) {
		return ''
	}
	return var_next_comments_link.str()
}

fn register_block_core_comments_pagination_next() {
	rt.call_function('register_block_type_from_metadata', [
		@DIR + '/comments-pagination-next',
		rt.create_array([
			rt.ArrayItem{ key: 'render_callback', val: 'render_block_core_comments_pagination_next' },
		]),
	])
}

struct Class_WP_Comment_Query {
	rt.PhpObjectBase
}

fn create_wp_comment_query() &Class_WP_Comment_Query {
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

pub fn init_wp_includes_blocks_comments_pagination_next_php() {
	rt.call_function('add_action', [rt.new_string('init'),
		rt.new_string('register_block_core_comments_pagination_next')])
}
