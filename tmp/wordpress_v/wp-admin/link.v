import rt


fn main() {
	defer {
		rt.shutdown()
	}

	rt.include_file(@DIR + '/admin.php', '4')
	mut var_action := if !(!rt.is_true(rt.get_superglobal('_REQUEST').array_get('action'))) { rt.call_function('sanitize_text_field', [rt.get_superglobal('_REQUEST').array_get('action')]) } else { rt.new_string('') }
	mut var_cat_id := if !(!rt.is_true(rt.get_superglobal('_REQUEST').array_get('cat_id'))) { rt.call_function('absint', [rt.get_superglobal('_REQUEST').array_get('cat_id')]) } else { rt.new_int(0) }
	mut var_link_id := if !(!rt.is_true(rt.get_superglobal('_REQUEST').array_get('link_id'))) { rt.call_function('absint', [rt.get_superglobal('_REQUEST').array_get('link_id')]) } else { rt.new_int(0) }
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('manage_links')]))))) {
		rt.call_function('wp_link_manager_disabled_message', []rt.PhpVal{})
	}
	if !(!rt.is_true(rt.get_superglobal('_POST').array_get('deletebookmarks'))) {
		var_action = rt.new_string(rt.new_string('deletebookmarks'))
	}
	if !(!rt.is_true(rt.get_superglobal('_POST').array_get('move'))) {
		var_action = rt.new_string(rt.new_string('move'))
	}
	if !(!rt.is_true(rt.get_superglobal('_POST').array_get('linkcheck'))) {
		mut var_linkcheck := rt.get_superglobal('_POST').array_get('linkcheck')
	}
	mut var_this_file := rt.call_function('admin_url', [rt.new_string('link-manager.php')])
	mut switch_val_1 := var_action
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('deletebookmarks'))) {
		rt.call_function('check_admin_referer', [rt.new_string('bulk-bookmarks')])
		if var_linkcheck.dup().array_count() == 0 {
			rt.call_function('wp_redirect', [var_this_file.dup()])
			// unsupported expression: Expr_Exit
		}
		mut var_deleted := 0
		{
			mut iter_1 := var_linkcheck.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_link_id_shadow := item_1.val
				var_link_id_shadow = // unsupported expression: Expr_Cast_Int
				if rt.is_true(rt.call_function('wp_delete_link', [var_link_id_shadow.dup()])) {
					var_deleted += 1
				}
			}
		}
		rt.call_function('wp_redirect', [rt.new_string("${var_this_file.to_string()}?deleted=${var_deleted.str()}")])
		// unsupported expression: Expr_Exit
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('move'))) {
		rt.call_function('check_admin_referer', [rt.new_string('bulk-bookmarks')])
		if var_linkcheck.dup().array_count() == 0 {
			rt.call_function('wp_redirect', [var_this_file.dup()])
			// unsupported expression: Expr_Exit
		}
		mut var_all_links := rt.call_function('implode', [rt.new_string(','), var_linkcheck.dup()])
		rt.call_function('wp_redirect', [var_this_file.dup()])
		// unsupported expression: Expr_Exit
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('add'))) {
		rt.call_function('check_admin_referer', [rt.new_string('add-bookmark')])
		mut var_redir := rt.call_function('wp_get_referer', []rt.PhpVal{})
		if rt.is_true(rt.call_function('add_link', []rt.PhpVal{})) {
			var_redir = rt.call_function('add_query_arg', [rt.new_string('added'), rt.new_string('true'), var_redir.dup()])
		}
		rt.call_function('wp_redirect', [var_redir.dup()])
		// unsupported expression: Expr_Exit
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('save'))) {
		var_link_id = // unsupported expression: Expr_Cast_Int
		rt.call_function('check_admin_referer', ['update-bookmark_' + (var_link_id).str()])
		rt.call_function('edit_link', [var_link_id.dup()])
		rt.call_function('wp_redirect', [var_this_file.dup()])
		// unsupported expression: Expr_Exit
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('delete'))) {
		var_link_id = // unsupported expression: Expr_Cast_Int
		rt.call_function('check_admin_referer', ['delete-bookmark_' + (var_link_id).str()])
		rt.call_function('wp_delete_link', [var_link_id.dup()])
		rt.call_function('wp_redirect', [var_this_file.dup()])
		// unsupported expression: Expr_Exit
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('edit'))) {
		rt.call_function('wp_enqueue_script', [rt.new_string('link')])
		rt.call_function('wp_enqueue_script', [rt.new_string('xfn')])
		if rt.is_true(rt.call_function('wp_is_mobile', []rt.PhpVal{})) {
			rt.call_function('wp_enqueue_script', [rt.new_string('jquery-touch-punch')])
		}
		mut var_parent_file := 'link-manager.php'
		mut var_submenu_file := 'link-manager.php'
		mut var_title := rt.call_function('__', [rt.new_string('Edit Link')])
		var_link_id = // unsupported expression: Expr_Cast_Int
		mut var_link := rt.call_function('get_link_to_edit', [var_link_id.dup()])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_link)))) {
			rt.call_function('wp_die', [rt.call_function('__', [rt.new_string('Link not found.')])])
		}
		rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/edit-link-form.php', '3')
		rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-footer.php', '4')
	} else {
	}
}
