import rt

fn comment_exists(var_comment_author rt.PhpVal, var_comment_date rt.PhpVal, timezone string) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var_date_field := 'comment_date'
	if rt.is_true(rt.identical(rt.new_string('gmt'), rt.new_string(timezone))) {
		var_date_field = 'comment_date_gmt'
	}
	return rt.call_method(var_wpdb, 'get_var', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('SELECT comment_post_ID FROM '), rt.get_property(var_wpdb, 'comments')), rt.new_string('\n\t\t\tWHERE comment_author = %s AND ')), rt.new_string(var_date_field)), rt.new_string(' = %s')), rt.call_function('stripslashes', [var_comment_author.dup()]), rt.call_function('stripslashes', [var_comment_date.dup()])])])
}

fn edit_comment() rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_comment'), // unsupported expression: Expr_Cast_Int]))))) {
		rt.call_function('wp_die', [rt.call_function('__', [rt.new_string('Sorry, you are not allowed to edit comments on this post.')])])
	}
	if rt.get_superglobal('_POST').array_isset(rt.new_string('newcomment_author')) {
		rt.get_superglobal('_POST').array_set('comment_author', rt.get_superglobal('_POST').array_get('newcomment_author'))
	}
	if rt.get_superglobal('_POST').array_isset(rt.new_string('newcomment_author_email')) {
		rt.get_superglobal('_POST').array_set('comment_author_email', rt.get_superglobal('_POST').array_get('newcomment_author_email'))
	}
	if rt.get_superglobal('_POST').array_isset(rt.new_string('newcomment_author_url')) {
		rt.get_superglobal('_POST').array_set('comment_author_url', rt.get_superglobal('_POST').array_get('newcomment_author_url'))
	}
	if rt.get_superglobal('_POST').array_isset(rt.new_string('comment_status')) {
		rt.get_superglobal('_POST').array_set('comment_approved', rt.get_superglobal('_POST').array_get('comment_status'))
	}
	if rt.get_superglobal('_POST').array_isset(rt.new_string('content')) {
		rt.get_superglobal('_POST').array_set('comment_content', rt.get_superglobal('_POST').array_get('content'))
	}
	if rt.get_superglobal('_POST').array_isset(rt.new_string('comment_ID')) {
		rt.get_superglobal('_POST').array_set('comment_ID', // unsupported expression: Expr_Cast_Int)
	}
	{
		mut iter_1 := rt.create_array([rt.ArrayItem{ key: none, val: 'aa' }, rt.ArrayItem{ key: none, val: 'mm' }, rt.ArrayItem{ key: none, val: 'jj' }, rt.ArrayItem{ key: none, val: 'hh' }, rt.ArrayItem{ key: none, val: 'mn' }]).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_timeunit := item_1.val
			if rt.is_true(rt.new_bool(!(!rt.is_true(rt.get_superglobal('_POST').array_get('hidden_' + (var_timeunit).str()))) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
				rt.get_superglobal('_POST').array_set('edit_date', '1')
				break
			}
		}
	}
	if !(!rt.is_true(rt.get_superglobal('_POST').array_get('edit_date'))) {
		mut var_aa := rt.get_superglobal('_POST').array_get('aa')
		mut var_mm := rt.get_superglobal('_POST').array_get('mm')
		mut var_jj := rt.get_superglobal('_POST').array_get('jj')
		mut var_hh := rt.get_superglobal('_POST').array_get('hh')
		mut var_mn := rt.get_superglobal('_POST').array_get('mn')
		mut var_ss := rt.get_superglobal('_POST').array_get('ss')
		var_jj = if rt.is_true(rt.greater(var_jj, rt.new_int(31))) { rt.new_int(31) } else { var_jj }
		var_hh = if rt.is_true(rt.greater(var_hh, rt.new_int(23))) { rt.sub(var_hh, rt.new_int(24)) } else { var_hh }
		var_mn = if rt.is_true(rt.greater(var_mn, rt.new_int(59))) { rt.sub(var_mn, rt.new_int(60)) } else { var_mn }
		var_ss = if rt.is_true(rt.greater(var_ss, rt.new_int(59))) { rt.sub(var_ss, rt.new_int(60)) } else { var_ss }
		rt.get_superglobal('_POST').array_set('comment_date', "${var_aa.to_string()}-${var_mm.to_string()}-${var_jj.to_string()} ${var_hh.to_string()}:${var_mn.to_string()}:${var_ss.to_string()}")
	}
	return rt.call_function('wp_update_comment', [rt.get_superglobal('_POST').dup(), rt.new_bool(true)])
}

fn get_comment_to_edit(var_id rt.PhpVal) bool {
	mut var_comment := rt.call_function('get_comment', [var_id.dup()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_comment)))) {
		return false
	}
	rt.set_property(var_comment, 'comment_ID', // unsupported expression: Expr_Cast_Int)
	rt.set_property(var_comment, 'comment_post_ID', // unsupported expression: Expr_Cast_Int)
	rt.set_property(var_comment, 'comment_content', rt.call_function('format_to_edit', [rt.get_property(var_comment, 'comment_content')]))
	rt.set_property(var_comment, 'comment_content', rt.call_function('apply_filters', [rt.new_string('comment_edit_pre'), rt.get_property(var_comment, 'comment_content')]))
	rt.set_property(var_comment, 'comment_author', rt.call_function('format_to_edit', [rt.get_property(var_comment, 'comment_author')]))
	rt.set_property(var_comment, 'comment_author_email', rt.call_function('format_to_edit', [rt.get_property(var_comment, 'comment_author_email')]))
	rt.set_property(var_comment, 'comment_author_url', rt.call_function('format_to_edit', [rt.get_property(var_comment, 'comment_author_url')]))
	rt.set_property(var_comment, 'comment_author_url', rt.call_function('esc_url', [rt.get_property(var_comment, 'comment_author_url')]))
	return (var_comment).to_bool()
}

fn get_pending_comments_num(var_post_id rt.PhpVal) i64 {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var_single := false
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_post_id.dup().is_array()))))) {
		mut var_post_id_array := rt.cast_array(var_post_id)
		var_single = true
	} else {
		var_post_id_array = var_post_id
	}
	var_post_id_array = rt.call_function('array_map', [rt.new_string('intval'), var_post_id_array.dup()])
	mut var_post_id_in := rt.new_string('\'' + (rt.call_function('implode', [rt.new_string('\', \''), var_post_id_array.dup()])).str() + '\'')
	mut var_pending := rt.call_method(var_wpdb, 'get_results', [rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('SELECT comment_post_ID, COUNT(comment_ID) as num_comments FROM '), rt.get_property(var_wpdb, 'comments')), rt.new_string(' WHERE comment_post_ID IN ( ')), var_post_id_in), rt.new_string(' ) AND comment_approved = \'0\' AND comment_type != \'note\' GROUP BY comment_post_ID')), rt.get_constant('ARRAY_A')])
	if var_single {
		if !rt.is_true(var_pending) {
			return 0
		} else {
			return (rt.call_function('absint', [var_pending.array_get(0).array_get('num_comments')])).to_i64()
		}
	}
	mut var_pending_keyed := rt.new_array()
	{
		mut iter_1 := var_post_id_array.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_id := item_1.val
			var_pending_keyed.array_set(var_id, 0)
		}
	}
	if !(!rt.is_true(var_pending)) {
		{
			mut iter_1 := var_pending.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_pend := item_1.val
				var_pending_keyed.array_set(var_pend.array_get('comment_post_ID'), rt.call_function('absint', [var_pend.array_get('num_comments')]))
			}
		}
	}
	return (var_pending_keyed).to_i64()
}

fn floated_admin_avatar(var_name rt.PhpVal) string {
	mut var_avatar := rt.call_function('get_avatar', [rt.call_function('get_comment', []rt.PhpVal{}), rt.new_int(32), rt.new_string('mystery')])
	return "${var_avatar.to_string()} ${var_name.to_string()}"
}

fn enqueue_comment_hotkeys_js() {
	if rt.is_true(rt.identical(rt.new_string('true'), rt.call_function('get_user_option', [rt.new_string('comment_shortcuts')]))) {
		rt.call_function('wp_enqueue_script', [rt.new_string('jquery-table-hotkeys')])
	}
}

fn comment_footer_die(var_msg rt.PhpVal) {
	print("<div class='wrap'><p>${var_msg.to_string()}</p></div>")
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-footer.php', '4')
	// unsupported expression: Expr_Exit
}



pub fn init_wp_admin_includes_comment_php() {
}
