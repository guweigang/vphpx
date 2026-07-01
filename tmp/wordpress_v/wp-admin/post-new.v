import rt


fn main() {
	defer {
		rt.shutdown()
	}

	mut var__registered_pages := rt.new_null()
	rt.include_file(@DIR + '/admin.php', '4')
	// unsupported statement: Stmt_Global
	if !(rt.get_superglobal('_GET').array_isset(rt.new_string('post_type'))) {
		mut var_post_type := rt.new_string(rt.new_string('post'))
	} else if rt.is_true(rt.call_function('in_array', [rt.get_superglobal('_GET').array_get('post_type'), rt.call_function('get_post_types', [rt.create_array([rt.ArrayItem{ key: 'show_ui', val: true }])]), rt.new_bool(true)])) {
		var_post_type = rt.get_superglobal('_GET').array_get('post_type')
	} else {
		rt.call_function('wp_die', [rt.call_function('__', [rt.new_string('Invalid post type.')])])
	}
	mut var_post_type_object := rt.call_function('get_post_type_object', [var_post_type.dup()])
	if rt.is_true(rt.identical(rt.new_string('post'), var_post_type)) {
		mut var_parent_file := rt.new_string(rt.new_string('edit.php'))
		mut var_submenu_file := rt.new_string(rt.new_string('post-new.php'))
	} else if rt.is_true(rt.identical(rt.new_string('attachment'), var_post_type)) {
		if rt.is_true(rt.call_function('wp_redirect', [rt.call_function('admin_url', [rt.new_string('media-new.php')])])) {
			// unsupported expression: Expr_Exit
		}
	} else {
		var_submenu_file = rt.new_string(rt.new_string("post-new.php?post_type=${var_post_type.to_string()}"))
		if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(var_post_type_object).is_null() && rt.is_true(rt.get_property(var_post_type_object, 'show_in_menu')))) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
			var_parent_file = rt.get_property(var_post_type_object, 'show_in_menu')
			if !(var__registered_pages.array_isset(rt.call_function('get_plugin_page_hookname', [rt.new_string("post-new.php?post_type=${var_post_type.to_string()}"), rt.get_property(var_post_type_object, 'show_in_menu')]))) {
				if var__registered_pages.array_isset(rt.call_function('get_plugin_page_hookname', [rt.new_string("edit.php?post_type=${var_post_type.to_string()}"), rt.get_property(var_post_type_object, 'show_in_menu')])) {
					var_submenu_file = rt.new_string(rt.new_string("edit.php?post_type=${var_post_type.to_string()}"))
				} else {
					var_submenu_file = var_parent_file.dup()
				}
			}
		} else {
			var_parent_file = rt.new_string(rt.new_string("edit.php?post_type=${var_post_type.to_string()}"))
		}
	}
	mut var_title := rt.get_property(rt.get_property(var_post_type_object, 'labels'), 'add_new_item')
	mut var_editing := true
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.get_property(rt.get_property(var_post_type_object, 'cap'), 'edit_posts')]))))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.get_property(rt.get_property(var_post_type_object, 'cap'), 'create_posts')]))))))) {
		rt.call_function('wp_die', ['<h1>' + (rt.call_function('__', [rt.new_string('You need a higher level of permission.')])).str() + '</h1>' + '<p>' + (rt.call_function('__', [rt.new_string('Sorry, you are not allowed to create posts as this user.')])).str() + '</p>', rt.new_int(403)])
	}
	mut var_post := rt.call_function('get_default_post_to_edit', [var_post_type.dup(), rt.new_bool(true)])
	mut var_post_ID := rt.get_property(var_post, 'ID')
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		if rt.is_true(rt.call_function('use_block_editor_for_post', [var_post.dup()])) {
			rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/edit-form-blocks.php', '3')
		} else {
			rt.call_function('wp_enqueue_script', [rt.new_string('autosave')])
			rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/edit-form-advanced.php', '3')
		}
	} else {
		mut var_current_screen := rt.call_function('get_current_screen', []rt.PhpVal{})
		rt.call_method(var_current_screen, 'is_block_editor', [rt.new_bool(false)])
	}
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-footer.php', '4')
}
