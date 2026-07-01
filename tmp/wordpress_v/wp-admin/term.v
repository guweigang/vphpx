import rt


fn main() {
	defer {
		rt.shutdown()
	}

	mut var_taxnow := rt.new_null()
	rt.include_file(@DIR + '/admin.php', '4')
	if !rt.is_true(rt.get_superglobal('_REQUEST').array_get('tag_ID')) {
		mut var_sendback := rt.call_function('admin_url', [rt.new_string('edit-tags.php')])
		if !(!rt.is_true(var_taxnow)) {
			var_sendback = rt.call_function('add_query_arg', [rt.create_array([rt.ArrayItem{ key: 'taxonomy', val: var_taxnow }]), var_sendback.dup()])
		}
		if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
			var_sendback = rt.call_function('add_query_arg', [rt.new_string('post_type'), rt.get_property(rt.call_function('get_current_screen', []rt.PhpVal{}), 'post_type'), var_sendback.dup()])
		}
		rt.call_function('wp_redirect', [rt.call_function('sanitize_url', [var_sendback.dup()])])
		// unsupported expression: Expr_Exit
	}
	mut var_tag_ID := rt.call_function('absint', [rt.get_superglobal('_REQUEST').array_get('tag_ID')])
	mut var_tag := rt.call_function('get_term', [var_tag_ID.dup(), var_taxnow.dup(), rt.get_constant('OBJECT'), rt.new_string('edit')])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_tag, 'WP_Term')))))) {
		rt.call_function('wp_die', [rt.call_function('__', [rt.new_string('You attempted to edit an item that does not exist. Perhaps it was deleted?')])])
	}
	mut var_tax := rt.call_function('get_taxonomy', [rt.get_property(var_tag, 'taxonomy')])
	mut var_taxonomy := rt.get_property(var_tax, 'name')
	mut var_title := rt.get_property(rt.get_property(var_tax, 'labels'), 'edit_item')
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_taxonomy.dup(), rt.call_function('get_taxonomies', [rt.create_array([rt.ArrayItem{ key: 'show_ui', val: true }])]), rt.new_bool(true)]))))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_term'), rt.get_property(var_tag, 'term_id')]))))))) {
		rt.call_function('wp_die', ['<h1>' + (rt.call_function('__', [rt.new_string('You need a higher level of permission.')])).str() + '</h1>' + '<p>' + (rt.call_function('__', [rt.new_string('Sorry, you are not allowed to edit this item.')])).str() + '</p>', rt.new_int(403)])
	}
	mut var_post_type := rt.get_property(rt.call_function('get_current_screen', []rt.PhpVal{}), 'post_type')
	if !rt.is_true(var_post_type) {
		var_post_type = rt.call_function('reset', [rt.get_property(var_tax, 'object_type')])
	}
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		mut var_parent_file := if rt.is_true(rt.identical(rt.new_string('attachment'), var_post_type)) { 'upload.php' } else { "edit.php?post_type=${var_post_type.to_string()}" }
		mut var_submenu_file := "edit-tags.php?taxonomy=${var_taxonomy.to_string()}&amp;post_type=${var_post_type.to_string()}"
	} else if rt.is_true(rt.identical(rt.new_string('link_category'), var_taxonomy)) {
		var_parent_file = 'link-manager.php'
		var_submenu_file = 'edit-tags.php?taxonomy=link_category'
	} else {
		var_parent_file = 'edit.php'
		var_submenu_file = "edit-tags.php?taxonomy=${var_taxonomy.to_string()}"
	}
	rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'set_screen_reader_content', [rt.create_array([rt.ArrayItem{ key: 'heading_pagination', val: rt.get_property(rt.get_property(var_tax, 'labels'), 'items_list_navigation') }, rt.ArrayItem{ key: 'heading_list', val: rt.get_property(rt.get_property(var_tax, 'labels'), 'items_list') }])])
	rt.call_function('wp_enqueue_script', [rt.new_string('admin-tags')])
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-header.php', '4')
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/edit-tag-form.php', '3')
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-footer.php', '4')
}
