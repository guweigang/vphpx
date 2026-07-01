import rt

fn _wp_translate_postdata(update bool, var_post_data rt.PhpVal) rt.PhpVal {
	if !rt.is_true(var_post_data) {
		// unsupported expression: Expr_AssignRef
	}
	if var_update {
		var_post_data.array_set('ID', // unsupported expression: Expr_Cast_Int)
	}
	mut var_ptype := rt.call_function('get_post_type_object', [var_post_data.array_get('post_type')])
	if rt.is_true(rt.new_bool(var_update && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_post'), var_post_data.array_get('ID')]))))))) {
		if rt.is_true(rt.identical(rt.new_string('page'), var_post_data.array_get('post_type'))) {
			return create_wp_error(rt.new_string('edit_others_pages'), rt.call_function('__', [rt.new_string('Sorry, you are not allowed to edit pages as this user.')]))
		} else {
			return create_wp_error(rt.new_string('edit_others_posts'), rt.call_function('__', [rt.new_string('Sorry, you are not allowed to edit posts as this user.')]))
		}
	} else if rt.is_true(rt.new_bool(!(var_update) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.get_property(rt.get_property(var_ptype, 'cap'), 'create_posts')]))))))) {
		if rt.is_true(rt.identical(rt.new_string('page'), var_post_data.array_get('post_type'))) {
			return create_wp_error(rt.new_string('edit_others_pages'), rt.call_function('__', [rt.new_string('Sorry, you are not allowed to create pages as this user.')]))
		} else {
			return create_wp_error(rt.new_string('edit_others_posts'), rt.call_function('__', [rt.new_string('Sorry, you are not allowed to create posts as this user.')]))
		}
	}
	if var_post_data.array_isset(rt.new_string('content')) {
		var_post_data.array_set('post_content', var_post_data.array_get('content'))
	}
	if var_post_data.array_isset(rt.new_string('excerpt')) {
		var_post_data.array_set('post_excerpt', var_post_data.array_get('excerpt'))
	}
	if var_post_data.array_isset(rt.new_string('parent_id')) {
		var_post_data.array_set('post_parent', // unsupported expression: Expr_Cast_Int)
	}
	if var_post_data.array_isset(rt.new_string('trackback_url')) {
		var_post_data.array_set('to_ping', var_post_data.array_get('trackback_url'))
	}
	var_post_data.array_set('user_ID', rt.call_function('get_current_user_id', []rt.PhpVal{}))
	if !(!rt.is_true(var_post_data.array_get('post_author_override'))) {
		var_post_data.array_set('post_author', // unsupported expression: Expr_Cast_Int)
	} else {
		if !(!rt.is_true(var_post_data.array_get('post_author'))) {
			var_post_data.array_set('post_author', // unsupported expression: Expr_Cast_Int)
		} else {
			var_post_data.array_set('post_author', // unsupported expression: Expr_Cast_Int)
		}
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_post_data.array_isset(rt.new_string('user_ID')) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.get_property(rt.get_property(var_ptype, 'cap'), 'edit_others_posts')]))))))) {
		if var_update {
			if rt.is_true(rt.identical(rt.new_string('page'), var_post_data.array_get('post_type'))) {
				return create_wp_error(rt.new_string('edit_others_pages'), rt.call_function('__', [rt.new_string('Sorry, you are not allowed to edit pages as this user.')]))
			} else {
				return create_wp_error(rt.new_string('edit_others_posts'), rt.call_function('__', [rt.new_string('Sorry, you are not allowed to edit posts as this user.')]))
			}
		} else {
			if rt.is_true(rt.identical(rt.new_string('page'), var_post_data.array_get('post_type'))) {
				return create_wp_error(rt.new_string('edit_others_pages'), rt.call_function('__', [rt.new_string('Sorry, you are not allowed to create pages as this user.')]))
			} else {
				return create_wp_error(rt.new_string('edit_others_posts'), rt.call_function('__', [rt.new_string('Sorry, you are not allowed to create posts as this user.')]))
			}
		}
	}
	if !(!rt.is_true(var_post_data.array_get('post_status'))) {
		var_post_data.array_set('post_status', rt.call_function('sanitize_key', [var_post_data.array_get('post_status')]))
		if rt.is_true(rt.identical(rt.new_string('auto-draft'), var_post_data.array_get('post_status'))) {
			var_post_data.array_set('post_status', 'draft')
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('get_post_status_object', [var_post_data.array_get('post_status')]))))) {
			var_post_data.array_unset(rt.new_string('post_status'))
		}
	}
	if rt.is_true(rt.new_bool(var_post_data.array_isset(rt.new_string('saveasdraft')) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		var_post_data.array_set('post_status', 'draft')
	}
	if rt.is_true(rt.new_bool(var_post_data.array_isset(rt.new_string('saveasprivate')) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		var_post_data.array_set('post_status', 'private')
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_post_data.array_isset(rt.new_string('publish')) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) && rt.is_true(rt.new_bool(!(var_post_data.array_isset(rt.new_string('post_status'))) || rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))))) {
		var_post_data.array_set('post_status', 'publish')
	}
	if rt.is_true(rt.new_bool(var_post_data.array_isset(rt.new_string('advanced')) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		var_post_data.array_set('post_status', 'draft')
	}
	if rt.is_true(rt.new_bool(var_post_data.array_isset(rt.new_string('pending')) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		var_post_data.array_set('post_status', 'pending')
	}
	mut var_post_id := if !(var_post_data.array_get('ID')).is_null() { var_post_data.array_get('ID') } else { rt.new_bool(false) }
	mut var_previous_status := if rt.is_true(var_post_id) { rt.call_function('get_post_field', [rt.new_string('post_status'), var_post_id.dup()]) } else { rt.new_bool(false) }
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_post_data.array_isset(rt.new_string('post_status')) && rt.is_true(rt.identical(rt.new_string('private'), var_post_data.array_get('post_status'))))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.get_property(rt.get_property(var_ptype, 'cap'), 'publish_posts')]))))))) {
		var_post_data.array_set('post_status', if rt.is_true(var_previous_status) { var_previous_status } else { rt.new_string('pending') })
	}
	mut var_published_statuses := ['publish', 'future']
	if rt.is_true(rt.new_bool(var_post_data.array_isset(rt.new_string('post_status')) && rt.is_true(rt.new_bool(rt.is_true(rt.call_function('in_array', [var_post_data.array_get('post_status'), var_published_statuses.dup(), rt.new_bool(true)])) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.get_property(rt.get_property(var_ptype, 'cap'), 'publish_posts')]))))))))) {
		if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_previous_status.dup(), var_published_statuses.dup(), rt.new_bool(true)]))))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_post'), var_post_id.dup()]))))))) {
			var_post_data.array_set('post_status', 'pending')
		}
	}
	if !(var_post_data.array_isset(rt.new_string('post_status'))) {
		var_post_data.array_set('post_status', if rt.is_true(rt.identical(rt.new_string('auto-draft'), var_previous_status)) { rt.new_string('draft') } else { var_previous_status })
	}
	if rt.is_true(rt.new_bool(var_post_data.array_isset(rt.new_string('post_password')) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.get_property(rt.get_property(var_ptype, 'cap'), 'publish_posts')]))))))) {
		var_post_data.array_unset(rt.new_string('post_password'))
	}
	if !(var_post_data.array_isset(rt.new_string('comment_status'))) {
		var_post_data.array_set('comment_status', 'closed')
	}
	if !(var_post_data.array_isset(rt.new_string('ping_status'))) {
		var_post_data.array_set('ping_status', 'closed')
	}
	{
		mut iter_1 := rt.create_array([rt.ArrayItem{ key: none, val: 'aa' }, rt.ArrayItem{ key: none, val: 'mm' }, rt.ArrayItem{ key: none, val: 'jj' }, rt.ArrayItem{ key: none, val: 'hh' }, rt.ArrayItem{ key: none, val: 'mn' }]).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_timeunit := item_1.val
			if rt.is_true(rt.new_bool(!(!rt.is_true(var_post_data.array_get('hidden_' + (var_timeunit).str()))) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
				var_post_data.array_set('edit_date', '1')
				break
			}
		}
	}
	if !(!rt.is_true(var_post_data.array_get('edit_date'))) {
		mut var_aa := var_post_data.array_get('aa')
		mut var_mm := var_post_data.array_get('mm')
		mut var_jj := var_post_data.array_get('jj')
		mut var_hh := var_post_data.array_get('hh')
		mut var_mn := var_post_data.array_get('mn')
		mut var_ss := var_post_data.array_get('ss')
		var_aa = if rt.is_true(rt.less_equal(var_aa, rt.new_int(0))) { rt.call_function('gmdate', [rt.new_string('Y')]) } else { var_aa }
		var_mm = if rt.is_true(rt.less_equal(var_mm, rt.new_int(0))) { rt.call_function('gmdate', [rt.new_string('n')]) } else { var_mm }
		var_jj = if rt.is_true(rt.greater(var_jj, rt.new_int(31))) { rt.new_int(31) } else { var_jj }
		var_jj = if rt.is_true(rt.less_equal(var_jj, rt.new_int(0))) { rt.call_function('gmdate', [rt.new_string('j')]) } else { var_jj }
		var_hh = if rt.is_true(rt.greater(var_hh, rt.new_int(23))) { rt.sub(var_hh, rt.new_int(24)) } else { var_hh }
		var_mn = if rt.is_true(rt.greater(var_mn, rt.new_int(59))) { rt.sub(var_mn, rt.new_int(60)) } else { var_mn }
		var_ss = if rt.is_true(rt.greater(var_ss, rt.new_int(59))) { rt.sub(var_ss, rt.new_int(60)) } else { var_ss }
		var_post_data.array_set('post_date', rt.call_function('sprintf', [rt.new_string('%04d-%02d-%02d %02d:%02d:%02d'), var_aa.dup(), var_mm.dup(), var_jj.dup(), var_hh.dup(), var_mn.dup(), var_ss.dup()]))
		mut var_valid_date := rt.call_function('wp_checkdate', [var_mm.dup(), var_jj.dup(), var_aa.dup(), var_post_data.array_get('post_date')])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_valid_date)))) {
			return create_wp_error(rt.new_string('invalid_date'), rt.call_function('__', [rt.new_string('Invalid date.')]))
		}
		mut var_previous_date := if rt.is_true(var_post_id) { rt.call_function('get_post_field', [rt.new_string('post_date'), var_post_id.dup()]) } else { rt.new_bool(false) }
		if rt.is_true(rt.new_bool(rt.is_true(var_previous_date) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
			var_post_data.array_set('edit_date', true)
			var_post_data.array_set('post_date_gmt', rt.call_function('get_gmt_from_date', [var_post_data.array_get('post_date')]))
		} else {
			var_post_data.array_set('edit_date', false)
			var_post_data.array_unset(rt.new_string('post_date'))
			var_post_data.array_unset(rt.new_string('post_date_gmt'))
		}
	}
	if var_post_data.array_isset(rt.new_string('post_category')) {
		mut var_category_object := rt.call_function('get_taxonomy', [rt.new_string('category')])
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.get_property(rt.get_property(var_category_object, 'cap'), 'assign_terms')]))))) {
			var_post_data.array_unset(rt.new_string('post_category'))
		}
	}
	return var_post_data.dup()
}

fn _wp_get_allowed_postdata(var_post_data rt.PhpVal) rt.PhpVal {
	if !rt.is_true(var_post_data) {
		var_post_data = rt.get_superglobal('_POST').dup()
	}
	if rt.is_true(rt.call_function('is_wp_error', [var_post_data.dup()])) {
		return var_post_data.dup()
	}
	return rt.call_function('array_diff_key', [var_post_data.dup(), rt.call_function('array_flip', [rt.create_array([rt.ArrayItem{ key: none, val: 'meta_input' }, rt.ArrayItem{ key: none, val: 'file' }, rt.ArrayItem{ key: none, val: 'guid' }])])])
}

fn edit_post(var_post_data rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	if !rt.is_true(var_post_data) {
		// unsupported expression: Expr_AssignRef
	}
	var_post_data.array_unset(rt.new_string('filter'))
	mut var_post_id := // unsupported expression: Expr_Cast_Int
	mut var_post := rt.call_function('get_post', [var_post_id.dup()])
	var_post_data.array_set('post_type', rt.get_property(var_post, 'post_type'))
	var_post_data.array_set('post_mime_type', rt.get_property(var_post, 'post_mime_type'))
	if !(!rt.is_true(var_post_data.array_get('post_status'))) {
		var_post_data.array_set('post_status', rt.call_function('sanitize_key', [var_post_data.array_get('post_status')]))
		if rt.is_true(rt.identical(rt.new_string('inherit'), var_post_data.array_get('post_status'))) {
			var_post_data.array_unset(rt.new_string('post_status'))
		}
	}
	mut var_ptype := rt.call_function('get_post_type_object', [var_post_data.array_get('post_type')])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_post'), var_post_id.dup()]))))) {
		if rt.is_true(rt.identical(rt.new_string('page'), var_post_data.array_get('post_type'))) {
			rt.call_function('wp_die', [rt.call_function('__', [rt.new_string('Sorry, you are not allowed to edit this page.')])])
		} else {
			rt.call_function('wp_die', [rt.call_function('__', [rt.new_string('Sorry, you are not allowed to edit this post.')])])
		}
	}
	if rt.is_true(rt.call_function('post_type_supports', [rt.get_property(var_ptype, 'name'), rt.new_string('revisions')])) {
		mut var_revisions := rt.call_function('wp_get_post_revisions', [var_post_id.dup(), rt.create_array([rt.ArrayItem{ key: 'order', val: 'ASC' }, rt.ArrayItem{ key: 'posts_per_page', val: 1 }])])
		mut var_revision := rt.call_function('current', [var_revisions.dup()])
		if rt.is_true(rt.new_bool(rt.is_true(var_revisions) && rt.is_true(rt.less(rt.call_function('_wp_get_post_revision_version', [var_revision.dup()]), rt.new_int(1))))) {
			rt.call_function('_wp_upgrade_revisions_of_post', [var_post.dup(), rt.call_function('wp_get_post_revisions', [var_post_id.dup()])])
		}
	}
	if var_post_data.array_isset(rt.new_string('visibility')) {
		mut switch_val_1 := var_post_data.array_get('visibility')
		if rt.is_true(rt.equal(switch_val_1, rt.new_string('public'))) {
			var_post_data.array_set('post_password', '')
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('password'))) {
			var_post_data.array_unset(rt.new_string('sticky'))
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('private'))) {
			var_post_data.array_set('post_status', 'private')
			var_post_data.array_set('post_password', '')
			var_post_data.array_unset(rt.new_string('sticky'))
		}
	}
	var_post_data = _wp_translate_postdata(true, var_post_data.dup())
	if rt.is_true(rt.call_function('is_wp_error', [var_post_data.dup()])) {
		rt.call_function('wp_die', [rt.call_method(var_post_data, 'get_error_message', []rt.PhpVal{})])
	}
	mut var_translated := _wp_get_allowed_postdata(var_post_data.dup())
	if var_post_data.array_isset(rt.new_string('post_format')) {
		rt.call_function('set_post_format', [var_post_id.dup(), var_post_data.array_get('post_format')])
	}
	mut var_format_meta_urls := ['url', 'link_url', 'quote_source_url']
	for var_format_meta_url in var_format_meta_urls {
		mut var_keyed := rt.new_string( + )
		if var_post_data.array_isset(var_keyed) {
			
		}
	}
	
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

fn create_wp_error() &Class_WP_Error {
	mut obj := &Class_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Error) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Error) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Error) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_admin_includes_post_php() {
}
