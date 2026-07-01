import rt

fn wp_ajax_nopriv_heartbeat() {
	mut var_response := rt.new_array()
	if !(!rt.is_true(rt.get_superglobal('_POST').array_get('screen_id'))) {
		mut var_screen_id := rt.call_function('sanitize_key', [rt.get_superglobal('_POST').array_get('screen_id')])
	} else {
		var_screen_id = rt.new_string(rt.new_string('front'))
	}
	if !(!rt.is_true(rt.get_superglobal('_POST').array_get('data'))) {
		mut var_data := rt.call_function('wp_unslash', [rt.cast_array(rt.get_superglobal('_POST').array_get('data'))])
		var_response = rt.call_function('apply_filters', [rt.new_string('heartbeat_nopriv_received'), var_response.dup(), var_data.dup(), var_screen_id.dup()])
	}
	var_response = rt.call_function('apply_filters', [rt.new_string('heartbeat_nopriv_send'), var_response.dup(), var_screen_id.dup()])
	rt.call_function('do_action', [rt.new_string('heartbeat_nopriv_tick'), var_response.dup(), var_screen_id.dup()])
	var_response.array_set('server_time', rt.call_function('time', []rt.PhpVal{}))
	rt.call_function('wp_send_json', [var_response.dup()])
}

fn wp_ajax_fetch_list() {
	mut var_list_class := rt.get_superglobal('_GET').array_get('list_args').array_get('class')
	rt.call_function('check_ajax_referer', [rt.new_string("fetch-list-${var_list_class.to_string()}"), rt.new_string('_ajax_fetch_list_nonce')])
	mut var_wp_list_table := rt.call_function('_get_list_table', [var_list_class.dup(), rt.create_array([rt.ArrayItem{ key: 'screen', val: rt.get_superglobal('_GET').array_get('list_args').array_get('screen').array_get('id') }])])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_wp_list_table)))) {
		rt.call_function('wp_die', [rt.new_int(0)])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_wp_list_table, 'ajax_user_can', []rt.PhpVal{}))))) {
		rt.call_function('wp_die', [// unsupported expression: Expr_UnaryMinus])
	}
	rt.call_method(var_wp_list_table, 'ajax_response', []rt.PhpVal{})
	rt.call_function('wp_die', [rt.new_int(0)])
}

fn wp_ajax_ajax_tag_search() {
	if !(rt.get_superglobal('_GET').array_isset(rt.new_string('tax'))) {
		rt.call_function('wp_die', [rt.new_int(0)])
	}
	mut var_taxonomy := rt.call_function('sanitize_key', [rt.get_superglobal('_GET').array_get('tax')])
	mut var_taxonomy_object := rt.call_function('get_taxonomy', [var_taxonomy.dup()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_taxonomy_object)))) {
		rt.call_function('wp_die', [rt.new_int(0)])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.get_property(rt.get_property(var_taxonomy_object, 'cap'), 'assign_terms')]))))) {
		rt.call_function('wp_die', [// unsupported expression: Expr_UnaryMinus])
	}
	mut var_search := rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get('q')])
	mut var_comma := rt.call_function('_x', [rt.new_string(','), rt.new_string('tag delimiter')])
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		var_search = rt.call_function('str_replace', [var_comma.dup(), rt.new_string(','), var_search.dup()])
	}
	if rt.is_true(rt.call_function('str_contains', [var_search.dup(), rt.new_string(',')])) {
		var_search = rt.call_function('explode', [rt.new_string(','), var_search.dup()])
		var_search = var_search.array_get(var_search.dup().array_count() - 1)
	}
	var_search = rt.new_string(rt.new_string(var_search.dup().to_string().trim_space()))
	mut var_term_search_min_chars := // unsupported expression: Expr_Cast_Int
	if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_int(0), var_term_search_min_chars)) || rt.is_true(rt.less(rt.new_int(var_search.dup().to_string().len), var_term_search_min_chars)))) {
		rt.call_function('wp_die', []rt.PhpVal{})
	}
	mut var_results := rt.call_function('get_terms', [rt.create_array([rt.ArrayItem{ key: 'taxonomy', val: var_taxonomy }, rt.ArrayItem{ key: 'name__like', val: var_search }, rt.ArrayItem{ key: 'fields', val: 'names' }, rt.ArrayItem{ key: 'hide_empty', val: false }, rt.ArrayItem{ key: 'number', val: if rt.get_superglobal('_GET').array_isset(rt.new_string('number')) { // unsupported expression: Expr_Cast_Int } else { rt.new_int(0) } }])])
	var_results = rt.call_function('apply_filters', [rt.new_string('ajax_term_search_results'), var_results.dup(), var_taxonomy_object.dup(), var_search.dup()])
	rt.echo_val(rt.call_function('implode', [rt.new_string('\n'), var_results.dup()]))
	rt.call_function('wp_die', []rt.PhpVal{})
}

fn wp_ajax_wp_compression_test() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('manage_options')]))))) {
		rt.call_function('wp_die', [// unsupported expression: Expr_UnaryMinus])
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('ini_get', [rt.new_string('zlib.output_compression')])) || rt.is_true(rt.identical(rt.new_string('ob_gzhandler'), rt.call_function('ini_get', [rt.new_string('output_handler')]))))) {
		if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) {
			rt.call_function('update_site_option', [rt.new_string('can_compress_scripts'), rt.new_int(0)])
		} else {
			rt.call_function('update_option', [rt.new_string('can_compress_scripts'), rt.new_int(0), rt.new_bool(true)])
		}
		rt.call_function('wp_die', [rt.new_int(0)])
	}
	if rt.get_superglobal('_GET').array_isset(rt.new_string('test')) {
		rt.call_function('header', [rt.new_string('Expires: Wed, 11 Jan 1984 05:00:00 GMT')])
		rt.call_function('header', ['Last-Modified: ' + (rt.call_function('gmdate', [rt.new_string('D, d M Y H:i:s')])).str() + ' GMT'])
		rt.call_function('header', [rt.new_string('Cache-Control: no-cache, must-revalidate, max-age=0')])
		rt.call_function('header', [rt.new_string('Content-Type: application/javascript; charset=UTF-8')])
		mut var_force_gzip := rt.is_true(rt.call_function('defined', [rt.new_string('ENFORCE_GZIP')])) && rt.is_true(rt.get_constant('ENFORCE_GZIP'))
		mut var_test_str := '"wpCompressionTest Lorem ipsum dolor sit amet consectetuer mollis sapien urna ut a. Eu nonummy condimentum fringilla tempor pretium platea vel nibh netus Maecenas. Hac molestie amet justo quis pellentesque est ultrices interdum nibh Morbi. Cras mattis pretium Phasellus ante ipsum ipsum ut sociis Suspendisse Lorem. Ante et non molestie. Porta urna Vestibulum egestas id congue nibh eu risus gravida sit. Ac augue auctor Ut et non a elit massa id sodales. Elit eu Nulla at nibh adipiscing mattis lacus mauris at tempus. Netus nibh quis suscipit nec feugiat eget sed lorem et urna. Pellentesque lacus at ut massa consectetuer ligula ut auctor semper Pellentesque. Ut metus massa nibh quam Curabitur molestie nec mauris congue. Volutpat molestie elit justo facilisis neque ac risus Ut nascetur tristique. Vitae sit lorem tellus et quis Phasellus lacus tincidunt nunc Fusce. Pharetra wisi Suspendisse mus sagittis libero lacinia Integer consequat ac Phasellus. Et urna ac cursus tortor aliquam Aliquam amet tellus volutpat Vestibulum. Justo interdum condimentum In augue congue tellus sollicitudin Quisque quis nibh."'
		if rt.is_true(rt.identical(rt.new_string('1'), rt.get_superglobal('_GET').array_get('test'))) {
			print(var_test_str)
			rt.call_function('wp_die', []rt.PhpVal{})
		} else if rt.is_true(rt.identical(rt.new_string('2'), rt.get_superglobal('_GET').array_get('test'))) {
			if !(rt.get_superglobal('_SERVER').array_isset(rt.new_string('HTTP_ACCEPT_ENCODING'))) {
				rt.call_function('wp_die', [// unsupported expression: Expr_UnaryMinus])
			}
			if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) && rt.is_true(rt.call_function('function_exists', [rt.new_string('gzdeflate')])))) && !(var_force_gzip))) {
				rt.call_function('header', [rt.new_string('Content-Encoding: deflate')])
				mut var_output := rt.call_function('gzdeflate', [rt.new_string(var_test_str).dup(), rt.new_int(1)])
			} else if rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) && rt.is_true(rt.call_function('function_exists', [rt.new_string('gzencode')])))) {
				rt.call_function('header', [rt.new_string('Content-Encoding: gzip')])
				var_output = rt.call_function('gzencode', [rt.new_string(var_test_str).dup(), rt.new_int(1)])
			} else {
				rt.call_function('wp_die', [// unsupported expression: Expr_UnaryMinus])
			}
			rt.echo_val(var_output)
			rt.call_function('wp_die', []rt.PhpVal{})
		} else if rt.is_true(rt.identical(rt.new_string('no'), rt.get_superglobal('_GET').array_get('test'))) {
			rt.call_function('check_ajax_referer', [rt.new_string('update_can_compress_scripts')])
			if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) {
				rt.call_function('update_site_option', [rt.new_string('can_compress_scripts'), rt.new_int(0)])
			} else {
				rt.call_function('update_option', [rt.new_string('can_compress_scripts'), rt.new_int(0), rt.new_bool(true)])
			}
		} else if rt.is_true(rt.identical(rt.new_string('yes'), rt.get_superglobal('_GET').array_get('test'))) {
			rt.call_function('check_ajax_referer', [rt.new_string('update_can_compress_scripts')])
			if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) {
				rt.call_function('update_site_option', [rt.new_string('can_compress_scripts'), rt.new_int(1)])
			} else {
				rt.call_function('update_option', [rt.new_string('can_compress_scripts'), rt.new_int(1), rt.new_bool(true)])
			}
		}
	}
	rt.call_function('wp_die', [rt.new_int(0)])
}

fn wp_ajax_imgedit_preview() {
	mut var_post_id := // unsupported expression: Expr_Cast_Int
	if rt.is_true(rt.new_bool(!rt.is_true(var_post_id) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_post'), var_post_id.dup()]))))))) {
		rt.call_function('wp_die', [// unsupported expression: Expr_UnaryMinus])
	}
	rt.call_function('check_ajax_referer', [rt.new_string("image_editor-${var_post_id.to_string()}")])
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/image-edit.php', '4')
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('stream_preview_image', [var_post_id.dup()]))))) {
		rt.call_function('wp_die', [// unsupported expression: Expr_UnaryMinus])
	}
	rt.call_function('wp_die', []rt.PhpVal{})
}

fn wp_ajax_oembed_cache() {
	mut var_GLOBALS := rt.new_null()
	rt.call_method(var_GLOBALS.array_get('wp_embed'), 'cache_oembed', [rt.get_superglobal('_GET').array_get('post')])
	rt.call_function('wp_die', [rt.new_int(0)])
}

fn wp_ajax_autocomplete_user() {
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{}))))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('promote_users')]))))))) || rt.is_true(rt.call_function('wp_is_large_network', [rt.new_string('users')])))) {
		rt.call_function('wp_die', [// unsupported expression: Expr_UnaryMinus])
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('manage_network_users')]))))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('apply_filters', [rt.new_string('autocomplete_users_for_site_admins'), rt.new_bool(false)]))))))) {
		rt.call_function('wp_die', [// unsupported expression: Expr_UnaryMinus])
	}
	mut var_return := rt.new_array()
	if rt.is_true(rt.new_bool(rt.get_superglobal('_REQUEST').array_isset(rt.new_string('autocomplete_type')) && rt.is_true(rt.identical(rt.new_string('search'), rt.get_superglobal('_REQUEST').array_get('autocomplete_type'))))) {
		mut var_type := rt.get_superglobal('_REQUEST').array_get('autocomplete_type')
	} else {
		var_type = rt.new_string(rt.new_string('add'))
	}
	if rt.is_true(rt.new_bool(rt.get_superglobal('_REQUEST').array_isset(rt.new_string('autocomplete_field')) && rt.is_true(rt.identical(rt.new_string('user_email'), rt.get_superglobal('_REQUEST').array_get('autocomplete_field'))))) {
		mut var_field := rt.get_superglobal('_REQUEST').array_get('autocomplete_field')
	} else {
		var_field = rt.new_string(rt.new_string('user_login'))
	}
	if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('site_id')) {
		mut var_id := rt.call_function('absint', [rt.get_superglobal('_REQUEST').array_get('site_id')])
	} else {
		var_id = rt.call_function('get_current_blog_id', []rt.PhpVal{})
	}
	mut var_include_blog_users := if rt.is_true(rt.identical(rt.new_string('search'), var_type)) { rt.call_function('get_users', [rt.create_array([rt.ArrayItem{ key: 'blog_id', val: var_id }, rt.ArrayItem{ key: 'fields', val: 'ID' }])]) } else { rt.new_array() }
	mut var_exclude_blog_users := if rt.is_true(rt.identical(rt.new_string('add'), var_type)) { rt.call_function('get_users', [rt.create_array([rt.ArrayItem{ key: 'blog_id', val: var_id }, rt.ArrayItem{ key: 'fields', val: 'ID' }])]) } else { rt.new_array() }
	mut var_users := rt.call_function('get_users', [rt.create_array([rt.ArrayItem{ key: 'blog_id', val: false }, rt.ArrayItem{ key: 'search', val: '*' + (rt.get_superglobal('_REQUEST').array_get('term')).str() + '*' }, rt.ArrayItem{ key: 'include', val: var_include_blog_users }, rt.ArrayItem{ key: 'exclude', val: var_exclude_blog_users }, rt.ArrayItem{ key: 'search_columns', val: rt.create_array([rt.ArrayItem{ key: none, val: 'user_login' }, rt.ArrayItem{ key: none, val: 'user_nicename' }, rt.ArrayItem{ key: none, val: 'user_email' }]) }])])
	{
		mut iter_1 := var_users.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_user := item_1.val
			var_return.array_push(rt.create_array([rt.ArrayItem{ key: 'label', val: rt.call_function('sprintf', [rt.call_function('_x', [rt.new_string('%1$s (%2$s)'), rt.new_string('user autocomplete result')]), rt.get_property(var_user, 'user_login'), rt.get_property(var_user, 'user_email')]) }, rt.ArrayItem{ key: 'value', val: rt.get_property(var_user, '{"nodeType":"Expr_Variable","line":356,"name":"field"}') }]))
		}
	}
	rt.call_function('wp_die', [rt.call_function('wp_json_encode', [var_return.dup()])])
}

fn wp_ajax_get_community_events() {
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/class-wp-community-events.php', '4')
	rt.call_function('check_ajax_referer', [rt.new_string('community_events')])
	mut var_search := if rt.get_superglobal('_POST').array_isset(rt.new_string('location')) { rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get('location')]) } else { rt.new_string('') }
	mut var_timezone := if rt.get_superglobal('_POST').array_isset(rt.new_string('timezone')) { rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get('timezone')]) } else { rt.new_string('') }
	mut var_user_id := rt.call_function('get_current_user_id', []rt.PhpVal{})
	mut var_saved_location := rt.call_function('get_user_option', [rt.new_string('community-events-location'), var_user_id.dup()])
	mut var_events_client := create_wp_community_events(.dup(), .dup())
	mut var_events := 
	
}

struct Class_WP_Community_Events {
	rt.PhpObjectBase
}

fn create_wp_community_events() &Class_WP_Community_Events {
	mut obj := &Class_WP_Community_Events{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Community_Events) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Community_Events) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Community_Events) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn init_registry() {
	rt.register_func('wp_ajax_nopriv_heartbeat', fn(args []rt.PhpVal) rt.PhpVal {
		return wp_ajax_nopriv_heartbeat()
	})
	rt.register_func('wp_ajax_fetch_list', fn(args []rt.PhpVal) rt.PhpVal {
		return wp_ajax_fetch_list()
	})
	rt.register_func('wp_ajax_ajax_tag_search', fn(args []rt.PhpVal) rt.PhpVal {
		return wp_ajax_ajax_tag_search()
	})
	rt.register_func('wp_ajax_wp_compression_test', fn(args []rt.PhpVal) rt.PhpVal {
		return wp_ajax_wp_compression_test()
	})
	rt.register_func('wp_ajax_imgedit_preview', fn(args []rt.PhpVal) rt.PhpVal {
		return wp_ajax_imgedit_preview()
	})
	rt.register_func('wp_ajax_oembed_cache', fn(args []rt.PhpVal) rt.PhpVal {
		return wp_ajax_oembed_cache()
	})
	rt.register_func('wp_ajax_autocomplete_user', fn(args []rt.PhpVal) rt.PhpVal {
		return wp_ajax_autocomplete_user()
	})
	rt.register_func('wp_ajax_get_community_events', fn(args []rt.PhpVal) rt.PhpVal {
		return wp_ajax_get_community_events()
	})
	rt.register_func('wp_ajax_dashboard_widgets', fn(args []rt.PhpVal) rt.PhpVal {
		return wp_ajax_dashboard_widgets()
	})
	rt.register_func('wp_ajax_logged_in', fn(args []rt.PhpVal) rt.PhpVal {
		return wp_ajax_logged_in()
	})
	rt.register_func('_wp_ajax_delete_comment_response', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		return _wp_ajax_delete_comment_response(arg_0, arg_1)
	})
	rt.register_func('_wp_ajax_add_hierarchical_term', fn(args []rt.PhpVal) rt.PhpVal {
		return _wp_ajax_add_hierarchical_term()
	})
	rt.register_func('wp_ajax_delete_comment', fn(args []rt.PhpVal) rt.PhpVal {
		return wp_ajax_delete_comment()
	})
	rt.register_func('wp_ajax_delete_tag', fn(args []rt.PhpVal) rt.PhpVal {
		return wp_ajax_delete_tag()
	})
	rt.register_func('wp_ajax_delete_link', fn(args []rt.PhpVal) rt.PhpVal {
		return wp_ajax_delete_link()
	})
	rt.register_func('wp_ajax_delete_meta', fn(args []rt.PhpVal) rt.PhpVal {
		return wp_ajax_delete_meta()
	})
	rt.register_func('wp_ajax_delete_post', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return wp_ajax_delete_post(arg_0)
	})
	rt.register_func('wp_ajax_trash_post', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return wp_ajax_trash_post(arg_0)
	})
	rt.register_func('wp_ajax_untrash_post', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return wp_ajax_untrash_post(arg_0)
	})
	rt.register_func('wp_ajax_delete_page', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return wp_ajax_delete_page(arg_0)
	})
	rt.register_func('wp_ajax_dim_comment', fn(args []rt.PhpVal) rt.PhpVal {
		return wp_ajax_dim_comment()
	})
	rt.register_func('wp_ajax_add_link_category', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return wp_ajax_add_link_category(arg_0)
	})
	rt.register_func('wp_ajax_add_tag', fn(args []rt.PhpVal) rt.PhpVal {
		return wp_ajax_add_tag()
	})
	rt.register_func('wp_ajax_get_tagcloud', fn(args []rt.PhpVal) rt.PhpVal {
		return wp_ajax_get_tagcloud()
	})
	rt.register_func('wp_ajax_get_comments', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return wp_ajax_get_comments(arg_0)
	})
	rt.register_func('wp_ajax_replyto_comment', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return wp_ajax_replyto_comment(arg_0)
	})
	rt.register_func('wp_ajax_edit_comment', fn(args []rt.PhpVal) rt.PhpVal {
		return wp_ajax_edit_comment()
	})
	rt.register_func('wp_ajax_add_menu_item', fn(args []rt.PhpVal) rt.PhpVal {
		return wp_ajax_add_menu_item()
	})
	rt.register_func('wp_ajax_add_meta', fn(args []rt.PhpVal) rt.PhpVal {
		return wp_ajax_add_meta()
	})
	rt.register_func('wp_ajax_add_user', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return wp_ajax_add_user(arg_0)
	})
	rt.register_func('wp_ajax_closed_postboxes', fn(args []rt.PhpVal) rt.PhpVal {
		return wp_ajax_closed_postboxes()
	})
	rt.register_func('wp_ajax_hidden_columns', fn(args []rt.PhpVal) rt.PhpVal {
		return wp_ajax_hidden_columns()
	})
	rt.register_func('wp_ajax_update_welcome_panel', fn(args []rt.PhpVal) rt.PhpVal {
		return wp_ajax_update_welcome_panel()
	})
	rt.register_func('wp_ajax_menu_get_metabox', fn(args []rt.PhpVal) rt.PhpVal {
		return wp_ajax_menu_get_metabox()
	})
	rt.register_func('wp_ajax_wp_link_ajax', fn(args []rt.PhpVal) rt.PhpVal {
		return wp_ajax_wp_link_ajax()
	})
	rt.register_func('wp_ajax_menu_locations_save', fn(args []rt.PhpVal) rt.PhpVal {
		return wp_ajax_menu_locations_save()
	})
	rt.register_func('wp_ajax_meta_box_order', fn(args []rt.PhpVal) rt.PhpVal {
		return wp_ajax_meta_box_order()
	})
	rt.register_func('wp_ajax_menu_quick_search', fn(args []rt.PhpVal) rt.PhpVal {
		return wp_ajax_menu_quick_search()
	})
	rt.register_func('wp_ajax_get_permalink', fn(args []rt.PhpVal) rt.PhpVal {
		return wp_ajax_get_permalink()
	})
	rt.register_func('wp_ajax_sample_permalink', fn(args []rt.PhpVal) rt.PhpVal {
		return wp_ajax_sample_permalink()
	})
	rt.register_func('wp_ajax_inline_save', fn(args []rt.PhpVal) rt.PhpVal {
		return wp_ajax_inline_save()
	})
	rt.register_func('wp_ajax_inline_save_tax', fn(args []rt.PhpVal) rt.PhpVal {
		return wp_ajax_inline_save_tax()
	})
	rt.register_func('wp_ajax_find_posts', fn(args []rt.PhpVal) rt.PhpVal {
		return wp_ajax_find_posts()
	})
	rt.register_func('wp_ajax_widgets_order', fn(args []rt.PhpVal) rt.PhpVal {
		return wp_ajax_widgets_order()
	})
	rt.register_func('wp_ajax_save_widget', fn(args []rt.PhpVal) rt.PhpVal {
		return wp_ajax_save_widget()
	})
	rt.register_func('wp_ajax_update_widget', fn(args []rt.PhpVal) rt.PhpVal {
		return wp_ajax_update_widget()
	})
	rt.register_func('wp_ajax_delete_inactive_widgets', fn(args []rt.PhpVal) rt.PhpVal {
		return wp_ajax_delete_inactive_widgets()
	})
	rt.register_func('wp_ajax_media_create_image_subsizes', fn(args []rt.PhpVal) rt.PhpVal {
		return wp_ajax_media_create_image_subsizes()
	})
	rt.register_func('wp_ajax_upload_attachment', fn(args []rt.PhpVal) rt.PhpVal {
		return wp_ajax_upload_attachment()
	})
	rt.register_func('wp_ajax_image_editor', fn(args []rt.PhpVal) rt.PhpVal {
		return wp_ajax_image_editor()
	})
	rt.register_func('wp_ajax_set_post_thumbnail', fn(args []rt.PhpVal) rt.PhpVal {
		return wp_ajax_set_post_thumbnail()
	})
	rt.register_func('wp_ajax_get_post_thumbnail_html', fn(args []rt.PhpVal) rt.PhpVal {
		return wp_ajax_get_post_thumbnail_html()
	})
	rt.register_func('wp_ajax_set_attachment_thumbnail', fn(args []rt.PhpVal) rt.PhpVal {
		return wp_ajax_set_attachment_thumbnail()
	})
	rt.register_func('wp_ajax_date_format', fn(args []rt.PhpVal) rt.PhpVal {
		return wp_ajax_date_format()
	})
	rt.register_func('wp_ajax_time_format', fn(args []rt.PhpVal) rt.PhpVal {
		return wp_ajax_time_format()
	})
	rt.register_func('wp_ajax_wp_fullscreen_save_post', fn(args []rt.PhpVal) rt.PhpVal {
		return wp_ajax_wp_fullscreen_save_post()
	})
	rt.register_func('wp_ajax_wp_remove_post_lock', fn(args []rt.PhpVal) rt.PhpVal {
		return wp_ajax_wp_remove_post_lock()
	})
	rt.register_func('wp_ajax_dismiss_wp_pointer', fn(args []rt.PhpVal) rt.PhpVal {
		return wp_ajax_dismiss_wp_pointer()
	})
	rt.register_func('wp_ajax_get_attachment', fn(args []rt.PhpVal) rt.PhpVal {
		return wp_ajax_get_attachment()
	})
	rt.register_func('wp_ajax_query_attachments', fn(args []rt.PhpVal) rt.PhpVal {
		return wp_ajax_query_attachments()
	})
	rt.register_func('wp_ajax_save_attachment', fn(args []rt.PhpVal) rt.PhpVal {
		return wp_ajax_save_attachment()
	})
	rt.register_func('wp_ajax_save_attachment_compat', fn(args []rt.PhpVal) rt.PhpVal {
		return wp_ajax_save_attachment_compat()
	})
	rt.register_func('wp_ajax_save_attachment_order', fn(args []rt.PhpVal) rt.PhpVal {
		return wp_ajax_save_attachment_order()
	})
	rt.register_func('wp_ajax_send_attachment_to_editor', fn(args []rt.PhpVal) rt.PhpVal {
		return wp_ajax_send_attachment_to_editor()
	})
	rt.register_func('wp_ajax_send_link_to_editor', fn(args []rt.PhpVal) rt.PhpVal {
		return wp_ajax_send_link_to_editor()
	})
	rt.register_func('wp_ajax_heartbeat', fn(args []rt.PhpVal) rt.PhpVal {
		return wp_ajax_heartbeat()
	})
	rt.register_func('wp_ajax_get_revision_diffs', fn(args []rt.PhpVal) rt.PhpVal {
		return wp_ajax_get_revision_diffs()
	})
	rt.register_func('wp_ajax_save_user_color_scheme', fn(args []rt.PhpVal) rt.PhpVal {
		return wp_ajax_save_user_color_scheme()
	})
	rt.register_func('wp_ajax_query_themes', fn(args []rt.PhpVal) rt.PhpVal {
		return wp_ajax_query_themes()
	})
	rt.register_func('wp_ajax_parse_embed', fn(args []rt.PhpVal) rt.PhpVal {
		return wp_ajax_parse_embed()
	})
	rt.register_func('wp_ajax_parse_media_shortcode', fn(args []rt.PhpVal) rt.PhpVal {
		return wp_ajax_parse_media_shortcode()
	})
	rt.register_func('wp_ajax_destroy_sessions', fn(args []rt.PhpVal) rt.PhpVal {
		return wp_ajax_destroy_sessions()
	})
	rt.register_func('wp_ajax_crop_image', fn(args []rt.PhpVal) rt.PhpVal {
		return wp_ajax_crop_image()
	})
	rt.register_func('wp_ajax_generate_password', fn(args []rt.PhpVal) rt.PhpVal {
		return wp_ajax_generate_password()
	})
	rt.register_func('wp_ajax_nopriv_generate_password', fn(args []rt.PhpVal) rt.PhpVal {
		return wp_ajax_nopriv_generate_password()
	})
	rt.register_func('wp_ajax_save_wporg_username', fn(args []rt.PhpVal) rt.PhpVal {
		return wp_ajax_save_wporg_username()
	})
	rt.register_func('wp_ajax_install_theme', fn(args []rt.PhpVal) rt.PhpVal {
		return wp_ajax_install_theme()
	})
	rt.register_func('wp_ajax_update_theme', fn(args []rt.PhpVal) rt.PhpVal {
		return wp_ajax_update_theme()
	})
	rt.register_func('wp_ajax_delete_theme', fn(args []rt.PhpVal) rt.PhpVal {
		return wp_ajax_delete_theme()
	})
	rt.register_func('wp_ajax_install_plugin', fn(args []rt.PhpVal) rt.PhpVal {
		return wp_ajax_install_plugin()
	})
	rt.register_func('wp_ajax_activate_plugin', fn(args []rt.PhpVal) rt.PhpVal {
		return wp_ajax_activate_plugin()
	})
	rt.register_func('wp_ajax_update_plugin', fn(args []rt.PhpVal) rt.PhpVal {
		return wp_ajax_update_plugin()
	})
	rt.register_func('wp_ajax_delete_plugin', fn(args []rt.PhpVal) rt.PhpVal {
		return wp_ajax_delete_plugin()
	})
	rt.register_func('wp_ajax_search_plugins', fn(args []rt.PhpVal) rt.PhpVal {
		return wp_ajax_search_plugins()
	})
	rt.register_func('wp_ajax_search_install_plugins', fn(args []rt.PhpVal) rt.PhpVal {
		return wp_ajax_search_install_plugins()
	})
	rt.register_func('wp_ajax_edit_theme_plugin_file', fn(args []rt.PhpVal) rt.PhpVal {
		return wp_ajax_edit_theme_plugin_file()
	})
	rt.register_func('wp_ajax_wp_privacy_export_personal_data', fn(args []rt.PhpVal) rt.PhpVal {
		return wp_ajax_wp_privacy_export_personal_data()
	})
	rt.register_func('wp_ajax_wp_privacy_erase_personal_data', fn(args []rt.PhpVal) rt.PhpVal {
		return wp_ajax_wp_privacy_erase_personal_data()
	})
	rt.register_func('wp_ajax_health_check_dotorg_communication', fn(args []rt.PhpVal) rt.PhpVal {
		return wp_ajax_health_check_dotorg_communication()
	})
	rt.register_func('wp_ajax_health_check_background_updates', fn(args []rt.PhpVal) rt.PhpVal {
		return wp_ajax_health_check_background_updates()
	})
	rt.register_func('wp_ajax_health_check_loopback_requests', fn(args []rt.PhpVal) rt.PhpVal {
		return wp_ajax_health_check_loopback_requests()
	})
	rt.register_func('wp_ajax_health_check_site_status_result', fn(args []rt.PhpVal) rt.PhpVal {
		return wp_ajax_health_check_site_status_result()
	})
	rt.register_func('wp_ajax_health_check_get_sizes', fn(args []rt.PhpVal) rt.PhpVal {
		return wp_ajax_health_check_get_sizes()
	})
	rt.register_func('wp_ajax_rest_nonce', fn(args []rt.PhpVal) rt.PhpVal {
		return wp_ajax_rest_nonce()
	})
	rt.register_func('wp_ajax_toggle_auto_updates', fn(args []rt.PhpVal) rt.PhpVal {
		return wp_ajax_toggle_auto_updates()
	})
	rt.register_func('wp_ajax_send_password_reset', fn(args []rt.PhpVal) rt.PhpVal {
		return wp_ajax_send_password_reset()
	})
	rt.register_class_factory('WP_Community_Events', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wp_community_events()
		return rt.new_object('WP_Community_Events', []string{}, obj)
	})
}

fn init() {
	init_registry()
}



pub fn init_wp_admin_includes_ajax_actions_php() {
}
