import rt

fn add_link() rt.PhpVal {
	return edit_link(0)
}

fn edit_link(link_id i64) rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('manage_links')]))))) {
		rt.call_function('wp_die', ['<h1>' + (rt.call_function('__', [rt.new_string('You need a higher level of permission.')])).str() + '</h1>' + '<p>' + (rt.call_function('__', [rt.new_string('Sorry, you are not allowed to edit the links for this site.')])).str() + '</p>', rt.new_int(403)])
	}
	rt.get_superglobal('_POST').array_set('link_url', rt.call_function('esc_url', [rt.get_superglobal('_POST').array_get('link_url')]))
	rt.get_superglobal('_POST').array_set('link_name', rt.call_function('esc_html', [rt.get_superglobal('_POST').array_get('link_name')]))
	rt.get_superglobal('_POST').array_set('link_image', rt.call_function('esc_html', [rt.get_superglobal('_POST').array_get('link_image')]))
	rt.get_superglobal('_POST').array_set('link_rss', rt.call_function('esc_url', [rt.get_superglobal('_POST').array_get('link_rss')]))
	if rt.is_true(rt.new_bool(!(rt.get_superglobal('_POST').array_isset(rt.new_string('link_visible'))) || rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		rt.get_superglobal('_POST').array_set('link_visible', 'Y')
	}
	if !(link_id == 0) {
		rt.get_superglobal('_POST').array_set('link_id', link_id)
		return rt.new_int(wp_update_link(rt.get_superglobal('_POST').dup()))
	} else {
		return rt.new_int(wp_insert_link(rt.get_superglobal('_POST').dup()))
	}
	return rt.new_null()
}

fn get_default_link_to_edit() rt.PhpVal {
	mut var_link := create_stdclass()
	if rt.get_superglobal('_GET').array_isset(rt.new_string('linkurl')) {
		rt.set_property(var_link, 'link_url', rt.call_function('esc_url', [rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get('linkurl')])]))
	} else {
		rt.set_property(var_link, 'link_url', rt.new_string(''))
	}
	if rt.get_superglobal('_GET').array_isset(rt.new_string('name')) {
		rt.set_property(var_link, 'link_name', rt.call_function('esc_attr', [rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get('name')])]))
	} else {
		rt.set_property(var_link, 'link_name', rt.new_string(''))
	}
	rt.set_property(var_link, 'link_visible', rt.new_string('Y'))
	return var_link.dup()
}

fn wp_delete_link(var_link_id rt.PhpVal) bool {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	rt.call_function('do_action', [rt.new_string('delete_link'), var_link_id.dup()])
	rt.call_function('wp_delete_object_term_relationships', [var_link_id.dup(), rt.new_string('link_category')])
	rt.call_method(var_wpdb, 'delete', [rt.get_property(var_wpdb, 'links'), rt.create_array([rt.ArrayItem{ key: 'link_id', val: var_link_id }])])
	rt.call_function('do_action', [rt.new_string('deleted_link'), var_link_id.dup()])
	rt.call_function('clean_bookmark_cache', [var_link_id.dup()])
	return true
}

fn wp_get_link_cats(link_id i64) rt.PhpVal {
	mut var_cats := rt.call_function('wp_get_object_terms', [rt.new_int(link_id), rt.new_string('link_category'), rt.create_array([rt.ArrayItem{ key: 'fields', val: 'ids' }])])
	return rt.call_function('array_unique', [var_cats.dup()])
}

fn get_link_to_edit(var_link rt.PhpVal) rt.PhpVal {
	return rt.call_function('get_bookmark', [var_link.dup(), rt.get_constant('OBJECT'), rt.new_string('edit')])
}

fn wp_insert_link(var_linkdata rt.PhpVal, wp_error bool) i64 {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var_defaults := { 'link_id': rt.new_int(0), 'link_name': rt.new_string(''), 'link_url': rt.new_string(''), 'link_rating': rt.new_int(0) }
	mut var_parsed_args := rt.call_function('wp_parse_args', [var_linkdata.dup(), var_defaults.dup()])
	var_parsed_args = rt.call_function('wp_unslash', [rt.call_function('sanitize_bookmark', [var_parsed_args.dup(), rt.new_string('db')])])
	mut var_link_id := var_parsed_args.array_get('link_id')
	mut var_link_name := var_parsed_args.array_get('link_name')
	mut var_link_url := var_parsed_args.array_get('link_url')
	mut var_update := false
	if !(!rt.is_true(var_link_id)) {
		var_update = true
	}
	if rt.is_true(rt.identical(rt.new_string(''), rt.new_string(var_link_name.dup().to_string().trim_space()))) {
		if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
			var_link_name = var_link_url.dup()
		} else {
			return 0
		}
	}
	if rt.is_true(rt.identical(rt.new_string(''), rt.new_string(var_link_url.dup().to_string().trim_space()))) {
		return 0
	}
	mut var_link_rating := if !(!rt.is_true(var_parsed_args.array_get('link_rating'))) { var_parsed_args.array_get('link_rating') } else { rt.new_int(0) }
	mut var_link_image := if !(!rt.is_true(var_parsed_args.array_get('link_image'))) { var_parsed_args.array_get('link_image') } else { rt.new_string('') }
	mut var_link_target := if !(!rt.is_true(var_parsed_args.array_get('link_target'))) { var_parsed_args.array_get('link_target') } else { rt.new_string('') }
	mut var_link_visible := if !(!rt.is_true(var_parsed_args.array_get('link_visible'))) { var_parsed_args.array_get('link_visible') } else { rt.new_string('Y') }
	mut var_link_owner := if !(!rt.is_true(var_parsed_args.array_get('link_owner'))) { var_parsed_args.array_get('link_owner') } else { rt.call_function('get_current_user_id', []rt.PhpVal{}) }
	mut var_link_notes := if !(!rt.is_true(var_parsed_args.array_get('link_notes'))) { var_parsed_args.array_get('link_notes') } else { rt.new_string('') }
	mut var_link_description := if !(!rt.is_true(var_parsed_args.array_get('link_description'))) { var_parsed_args.array_get('link_description') } else { rt.new_string('') }
	mut var_link_rss := if !(!rt.is_true(var_parsed_args.array_get('link_rss'))) { var_parsed_args.array_get('link_rss') } else { rt.new_string('') }
	mut var_link_rel := if !(!rt.is_true(var_parsed_args.array_get('link_rel'))) { var_parsed_args.array_get('link_rel') } else { rt.new_string('') }
	mut var_link_category := if !(!rt.is_true(var_parsed_args.array_get('link_category'))) { var_parsed_args.array_get('link_category') } else { rt.new_array() }
	mut var_link_updated := rt.call_function('gmdate', [rt.new_string('Y-m-d H:i:s'), rt.call_function('current_time', [rt.new_string('timestamp'), rt.new_int(0)])])
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_link_category.dup().is_array()))))) || 0 == var_link_category.dup().array_count())) {
		var_link_category = rt.create_array([rt.ArrayItem{ key: none, val: rt.call_function('get_option', [rt.new_string('default_link_category')]) }])
	}
	if var_update {
		if rt.is_true(rt.identical(rt.new_bool(false), rt.call_method(var_wpdb, 'update', [rt.get_property(var_wpdb, 'links'), rt.call_function('compact', [rt.new_string('link_url'), rt.new_string('link_name'), rt.new_string('link_image'), rt.new_string('link_target'), rt.new_string('link_description'), rt.new_string('link_visible'), rt.new_string('link_owner'), rt.new_string('link_rating'), rt.new_string('link_rel'), rt.new_string('link_notes'), rt.new_string('link_rss'), rt.new_string('link_updated')]), rt.call_function('compact', [rt.new_string('link_id')])]))) {
			if var_wp_error {
				return (create_wp_error(rt.new_string('db_update_error'), rt.call_function('__', [rt.new_string('Could not update link in the database.')]), rt.get_property(var_wpdb, 'last_error'))).to_i64()
			} else {
				return 0
			}
		}
	} else {
		if rt.is_true(rt.identical(rt.new_bool(false), rt.call_method(var_wpdb, 'insert', [rt.get_property(var_wpdb, 'links'), rt.call_function('compact', [rt.new_string('link_url'), rt.new_string('link_name'), rt.new_string('link_image'), rt.new_string('link_target'), rt.new_string('link_description'), rt.new_string('link_visible'), rt.new_string('link_owner'), rt.new_string('link_rating'), rt.new_string('link_rel'), rt.new_string('link_notes'), rt.new_string('link_rss'), rt.new_string('link_updated')])]))) {
			if var_wp_error {
				return (create_wp_error(rt.new_string('db_insert_error'), rt.call_function('__', [rt.new_string('Could not insert link into the database.')]), rt.get_property(var_wpdb, 'last_error'))).to_i64()
			} else {
				return 0
			}
		}
		var_link_id = // unsupported expression: Expr_Cast_Int
	}
	wp_set_link_cats(var_link_id.dup(), var_link_category.dup())
	if var_update {
		rt.call_function('do_action', [rt.new_string('edit_link'), var_link_id.dup()])
	} else {
		rt.call_function('do_action', [rt.new_string('add_link'), var_link_id.dup()])
	}
	rt.call_function('clean_bookmark_cache', [var_link_id.dup()])
	return (var_link_id).to_i64()
}

fn wp_set_link_cats(link_id i64, var_link_categories rt.PhpVal) {
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_link_categories.dup().is_array()))))) || 0 == var_link_categories.dup().array_count())) {
		var_link_categories = rt.create_array([rt.ArrayItem{ key: none, val: rt.call_function('get_option', [rt.new_string('default_link_category')]) }])
	}
	var_link_categories = rt.call_function('array_map', [rt.new_string('intval'), var_link_categories.dup()])
	var_link_categories = rt.call_function('array_unique', [var_link_categories.dup()])
	rt.call_function('wp_set_object_terms', [rt.new_int(link_id), var_link_categories.dup(), rt.new_string('link_category')])
	rt.call_function('clean_bookmark_cache', [rt.new_int(link_id)])
}

fn wp_update_link(var_linkdata rt.PhpVal) i64 {
	mut var_link_id := // unsupported expression: Expr_Cast_Int
	mut var_link := rt.call_function('get_bookmark', [var_link_id.dup(), rt.get_constant('ARRAY_A')])
	var_link = rt.call_function('wp_slash', [var_link.dup()])
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_linkdata.array_isset(rt.new_string('link_category')) && rt.is_true(rt.new_bool(var_linkdata.array_get('link_category').is_array())))) && var_linkdata.array_get('link_category').array_count() > 0)) {
		mut var_link_cats := var_linkdata.array_get('link_category')
	} else {
		var_link_cats = var_link.array_get('link_category')
	}
	var_linkdata = rt.call_function('array_merge', [var_link.dup(), var_linkdata.dup()])
	var_linkdata.array_set('link_category', var_link_cats.dup())
	return wp_insert_link(var_linkdata.dup())
}

fn wp_link_manager_disabled_message() {
	mut var_pagenow := rt.new_null()
	// unsupported statement: Stmt_Global
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_pagenow.dup(), rt.create_array([rt.ArrayItem{ key: none, val: 'link-manager.php' }, rt.ArrayItem{ key: none, val: 'link-add.php' }, rt.ArrayItem{ key: none, val: 'link.php' }]), rt.new_bool(true)]))))) {
		return rt.new_null()
	}
	rt.call_function('add_filter', [rt.new_string('pre_option_link_manager_enabled'), rt.new_string('__return_true'), rt.new_int(100)])
	mut var_really_can_manage_links := rt.call_function('current_user_can', [rt.new_string('manage_links')])
	rt.call_function('remove_filter', [rt.new_string('pre_option_link_manager_enabled'), rt.new_string('__return_true'), rt.new_int(100)])
	if rt.is_true(var_really_can_manage_links) {
		mut var_plugins := rt.call_function('get_plugins', []rt.PhpVal{})
		if !rt.is_true(var_plugins.array_get('link-manager/link-manager.php')) {
			if rt.is_true(rt.call_function('current_user_can', [rt.new_string('install_plugins')])) {
				mut var_install_url := rt.call_function('wp_nonce_url', [rt.call_function('self_admin_url', [rt.new_string('update.php?action=install-plugin&plugin=link-manager')]), rt.new_string('install-plugin_link-manager')])
				rt.call_function('wp_die', [rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('If you are looking to use the link manager, please install the <a href="%s">Link Manager plugin</a>.')]), rt.call_function('esc_url', [var_install_url.dup()])])])
			}
		} else if rt.is_true(rt.call_function('is_plugin_inactive', [rt.new_string('link-manager/link-manager.php')])) {
			if rt.is_true(rt.call_function('current_user_can', [rt.new_string('activate_plugins')])) {
				mut var_activate_url := rt.call_function('wp_nonce_url', [rt.call_function('self_admin_url', [rt.new_string('plugins.php?action=activate&plugin=link-manager/link-manager.php')]), rt.new_string('activate-plugin_link-manager/link-manager.php')])
				rt.call_function('wp_die', [rt.call_function('sprintf', [rt.call_function('__', []), rt.call_function('esc_url', [.dup()])])])
			}
		}
	}
	rt.call_function('wp_die', [rt.call_function('__', [rt.new_string('Sorry, you are not allowed to edit the links for this site.')])])
}

struct Class_stdClass {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

fn create_stdclass() &Class_stdClass {
	mut obj := &Class_stdClass{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_error() &Class_WP_Error {
	mut obj := &Class_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_stdClass) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_stdClass) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_stdClass) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
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




pub fn init_wp_admin_includes_bookmark_php() {
}
