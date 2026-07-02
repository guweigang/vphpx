import rt

fn wp_ajax_nopriv_heartbeat() {
	mut var_response := rt.new_null()
	mut var_screen_id := rt.new_null()
	mut var_data := rt.new_null()
	var_response = rt.new_array()
	if !(!rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('screen_id')))) {
		var_screen_id = rt.call_function('sanitize_key', [
			rt.get_superglobal('_POST').array_get(rt.new_string('screen_id')),
		])
	} else {
		var_screen_id = rt.new_string('front')
	}
	if !(!rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('data')))) {
		var_data = rt.call_function('wp_unslash', [
			rt.cast_array(rt.get_superglobal('_POST').array_get(rt.new_string('data'))),
		])
		var_response = rt.call_function('apply_filters', [
			rt.new_string('heartbeat_nopriv_received'),
			var_response.clone(),
			var_data.clone(),
			var_screen_id.clone(),
		])
	}
	var_response = rt.call_function('apply_filters', [
		rt.new_string('heartbeat_nopriv_send'),
		var_response.clone(),
		var_screen_id.clone(),
	])
	rt.call_function('do_action', [rt.new_string('heartbeat_nopriv_tick'),
		var_response.clone(), var_screen_id.clone()])
	var_response.array_set('server_time', rt.call_function('time', []rt.PhpVal{}))
	rt.call_function('wp_send_json', [var_response.clone()])
}

fn wp_ajax_fetch_list() {
	mut var_list_class := rt.new_null()
	mut var_wp_list_table := rt.new_null()
	var_list_class =
		rt.get_superglobal('_GET').array_get(rt.new_string('list_args')).array_get(rt.new_string('class'))
	rt.call_function('check_ajax_referer', [
		rt.new_string('fetch-list-${var_list_class.to_string()}'),
		rt.new_string('_ajax_fetch_list_nonce'),
	])
	var_wp_list_table = rt.call_function('_get_list_table', [
		var_list_class.clone(),
		rt.create_array([
			rt.ArrayItem{
				key: 'screen'
				val: rt.get_superglobal('_GET').array_get(rt.new_string('list_args')).array_get(rt.new_string('screen')).array_get(rt.new_string('id'))
			},
		])])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_wp_list_table)))) {
		rt.call_function('wp_die', [rt.new_int(0)])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_wp_list_table, 'ajax_user_can',
		[]rt.PhpVal{})))))
	{
		rt.call_function('wp_die', [rt.new_int(-1)])
	}
	rt.call_method(var_wp_list_table, 'ajax_response', []rt.PhpVal{})
	rt.call_function('wp_die', [rt.new_int(0)])
}

fn wp_ajax_ajax_tag_search() {
	mut var_taxonomy := rt.new_null()
	mut var_taxonomy_object := rt.new_null()
	mut var_search := rt.new_null()
	mut var_comma := rt.new_null()
	mut var_term_search_min_chars := rt.new_null()
	mut var_results := rt.new_null()
	if !(rt.get_superglobal('_GET').array_isset(rt.new_string('tax'))) {
		rt.call_function('wp_die', [rt.new_int(0)])
	}
	var_taxonomy = rt.call_function('sanitize_key',
		[rt.get_superglobal('_GET').array_get(rt.new_string('tax'))])
	var_taxonomy_object = rt.call_function('get_taxonomy', [var_taxonomy.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_taxonomy_object)))) {
		rt.call_function('wp_die', [rt.new_int(0)])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.get_property(rt.get_property(var_taxonomy_object, 'cap'), 'assign_terms'),
	])))))
	{
		rt.call_function('wp_die', [rt.new_int(-1)])
	}
	var_search = rt.call_function('wp_unslash',
		[rt.get_superglobal('_GET').array_get(rt.new_string('q'))])
	var_comma = rt.call_function('_x', [rt.new_string(','), rt.new_string('tag delimiter')])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(','), var_comma)))) {
		var_search = rt.call_function('str_replace', [var_comma.clone(),
			rt.new_string(','), var_search.clone()])
	}
	if rt.is_true(rt.call_function('str_contains', [var_search.clone(),
		rt.new_string(',')]))
	{
		var_search = rt.call_function('explode', [rt.new_string(','),
			var_search.clone()])
		var_search = var_search.array_get(rt.new_int(var_search.clone().array_count() - 1))
	}
	var_search = rt.new_string(var_search.clone().to_string().trim_space())
	var_term_search_min_chars = rt.new_int((rt.call_function('apply_filters', [
		rt.new_string('term_search_min_chars'),
		rt.new_int(2),
		var_taxonomy_object.clone(),
		var_search.clone(),
	])).to_i64())
	if rt.is_true(rt.identical(rt.new_int(0), var_term_search_min_chars))
		|| rt.is_true(rt.less(rt.new_int(var_search.clone().to_string().len), var_term_search_min_chars)) {
		rt.call_function('wp_die', []rt.PhpVal{})
	}
	var_results = rt.call_function('get_terms', [
		rt.create_array([rt.ArrayItem{ key: 'taxonomy', val: var_taxonomy },
			rt.ArrayItem{ key: 'name__like', val: var_search },
			rt.ArrayItem{ key: 'fields', val: 'names' }, rt.ArrayItem{ key: 'hide_empty', val: false },
			rt.ArrayItem{
				key: 'number'
				val: if rt.get_superglobal('_GET').array_isset(rt.new_string('number')) {
					rt.new_int((rt.get_superglobal('_GET').array_get(rt.new_string('number'))).to_i64())
				} else {
					0
				}
			}]),
	])
	var_results = rt.call_function('apply_filters', [
		rt.new_string('ajax_term_search_results'),
		var_results.clone(),
		var_taxonomy_object.clone(),
		var_search.clone(),
	])
	rt.echo_val(rt.call_function('implode', [rt.new_string('\n'),
		var_results.clone()]))
	rt.call_function('wp_die', []rt.PhpVal{})
}

fn wp_ajax_wp_compression_test() {
	mut var_force_gzip := false
	mut var_test_str := ''
	mut var_output := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('manage_options'),
	])))))
	{
		rt.call_function('wp_die', [rt.new_int(-1)])
	}
	if rt.is_true(rt.call_function('ini_get', [rt.new_string('zlib.output_compression')]))
		|| rt.is_true(rt.identical(rt.new_string('ob_gzhandler'), rt.call_function('ini_get', [rt.new_string('output_handler')]))) {
		if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) {
			rt.call_function('update_site_option', [
				rt.new_string('can_compress_scripts'),
				rt.new_int(0),
			])
		} else {
			rt.call_function('update_option', [rt.new_string('can_compress_scripts'),
				rt.new_int(0), rt.new_bool(true)])
		}
		rt.call_function('wp_die', [rt.new_int(0)])
	}
	if rt.get_superglobal('_GET').array_isset(rt.new_string('test')) {
		rt.call_function('header', [
			rt.new_string('Expires: Wed, 11 Jan 1984 05:00:00 GMT'),
		])
		rt.call_function('header', [
			rt.new_string('Last-Modified: ' +
				(rt.call_function('gmdate', [rt.new_string('D, d M Y H:i:s')])).str() + ' GMT'),
		])
		rt.call_function('header', [
			rt.new_string('Cache-Control: no-cache, must-revalidate, max-age=0'),
		])
		rt.call_function('header', [
			rt.new_string('Content-Type: application/javascript; charset=UTF-8'),
		])
		var_force_gzip = rt.is_true(rt.call_function('defined', [rt.new_string('ENFORCE_GZIP')]))
			&& rt.is_true(rt.get_constant('ENFORCE_GZIP'))
		var_test_str = '"wpCompressionTest Lorem ipsum dolor sit amet consectetuer mollis sapien urna ut a. Eu nonummy condimentum fringilla tempor pretium platea vel nibh netus Maecenas. Hac molestie amet justo quis pellentesque est ultrices interdum nibh Morbi. Cras mattis pretium Phasellus ante ipsum ipsum ut sociis Suspendisse Lorem. Ante et non molestie. Porta urna Vestibulum egestas id congue nibh eu risus gravida sit. Ac augue auctor Ut et non a elit massa id sodales. Elit eu Nulla at nibh adipiscing mattis lacus mauris at tempus. Netus nibh quis suscipit nec feugiat eget sed lorem et urna. Pellentesque lacus at ut massa consectetuer ligula ut auctor semper Pellentesque. Ut metus massa nibh quam Curabitur molestie nec mauris congue. Volutpat molestie elit justo facilisis neque ac risus Ut nascetur tristique. Vitae sit lorem tellus et quis Phasellus lacus tincidunt nunc Fusce. Pharetra wisi Suspendisse mus sagittis libero lacinia Integer consequat ac Phasellus. Et urna ac cursus tortor aliquam Aliquam amet tellus volutpat Vestibulum. Justo interdum condimentum In augue congue tellus sollicitudin Quisque quis nibh."'
		if rt.is_true(rt.identical(rt.new_string('1'),
			rt.get_superglobal('_GET').array_get(rt.new_string('test'))))
		{
			print(var_test_str)
			rt.call_function('wp_die', []rt.PhpVal{})
		} else if rt.is_true(rt.identical(rt.new_string('2'),
			rt.get_superglobal('_GET').array_get(rt.new_string('test'))))
		{
			if !(rt.get_superglobal('_SERVER').array_isset(rt.new_string('HTTP_ACCEPT_ENCODING'))) {
				rt.call_function('wp_die', [rt.new_int(-1)])
			}
			if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('stripos', [rt.get_superglobal('_SERVER').array_get(rt.new_string('HTTP_ACCEPT_ENCODING')), rt.new_string('deflate')])))))
				&& rt.is_true(rt.call_function('function_exists', [rt.new_string('gzdeflate')]))
				&& !var_force_gzip {
				rt.call_function('header', [rt.new_string('Content-Encoding: deflate')])
				var_output = rt.call_function('gzdeflate', [rt.new_string(var_test_str.str()).clone(),
					rt.new_int(1)])
			} else if
				rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('stripos', [rt.get_superglobal('_SERVER').array_get(rt.new_string('HTTP_ACCEPT_ENCODING')), rt.new_string('gzip')])))))
				&& rt.is_true(rt.call_function('function_exists', [rt.new_string('gzencode')])) {
				rt.call_function('header', [rt.new_string('Content-Encoding: gzip')])
				var_output = rt.call_function('gzencode', [rt.new_string(var_test_str.str()).clone(),
					rt.new_int(1)])
			} else {
				rt.call_function('wp_die', [rt.new_int(-1)])
			}
			rt.echo_val(var_output)
			rt.call_function('wp_die', []rt.PhpVal{})
		} else if rt.is_true(rt.identical(rt.new_string('no'),
			rt.get_superglobal('_GET').array_get(rt.new_string('test'))))
		{
			rt.call_function('check_ajax_referer', [
				rt.new_string('update_can_compress_scripts'),
			])
			if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) {
				rt.call_function('update_site_option', [
					rt.new_string('can_compress_scripts'),
					rt.new_int(0),
				])
			} else {
				rt.call_function('update_option', [rt.new_string('can_compress_scripts'),
					rt.new_int(0), rt.new_bool(true)])
			}
		} else if rt.is_true(rt.identical(rt.new_string('yes'),
			rt.get_superglobal('_GET').array_get(rt.new_string('test'))))
		{
			rt.call_function('check_ajax_referer', [
				rt.new_string('update_can_compress_scripts'),
			])
			if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) {
				rt.call_function('update_site_option', [
					rt.new_string('can_compress_scripts'),
					rt.new_int(1),
				])
			} else {
				rt.call_function('update_option', [rt.new_string('can_compress_scripts'),
					rt.new_int(1), rt.new_bool(true)])
			}
		}
	}
	rt.call_function('wp_die', [rt.new_int(0)])
}

fn wp_ajax_imgedit_preview() {
	mut var_post_id := rt.new_null()
	var_post_id =
		rt.new_int((rt.get_superglobal('_GET').array_get(rt.new_string('postid'))).to_i64())
	if !rt.is_true(var_post_id)
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_post'), var_post_id.clone()]))))) {
		rt.call_function('wp_die', [rt.new_int(-1)])
	}
	rt.call_function('check_ajax_referer', [
		rt.new_string('image_editor-${var_post_id.to_string()}'),
	])
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/image-edit.php', '4')
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('stream_preview_image', [
		var_post_id.clone(),
	])))))
	{
		rt.call_function('wp_die', [rt.new_int(-1)])
	}
	rt.call_function('wp_die', []rt.PhpVal{})
}

fn wp_ajax_oembed_cache() {
	mut var_GLOBALS := rt.new_null()
	rt.call_method(var_GLOBALS.array_get(rt.new_string('wp_embed')), 'cache_oembed', [
		rt.get_superglobal('_GET').array_get(rt.new_string('post')),
	])
	rt.call_function('wp_die', [rt.new_int(0)])
}

fn wp_ajax_autocomplete_user() {
	mut var_return := rt.new_null()
	mut var_type := rt.new_null()
	mut var_field := rt.new_null()
	mut var_id := rt.new_null()
	mut var_include_blog_users := rt.new_null()
	mut var_exclude_blog_users := rt.new_null()
	mut var_users := rt.new_null()
	mut var_user := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('promote_users')])))))
		|| rt.is_true(rt.call_function('wp_is_large_network', [rt.new_string('users')])) {
		rt.call_function('wp_die', [rt.new_int(-1)])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('manage_network_users')])))))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('apply_filters', [rt.new_string('autocomplete_users_for_site_admins'), rt.new_bool(false)]))))) {
		rt.call_function('wp_die', [rt.new_int(-1)])
	}
	var_return = rt.new_array()
	if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('autocomplete_type'))
		&& rt.is_true(rt.identical(rt.new_string('search'), rt.get_superglobal('_REQUEST').array_get(rt.new_string('autocomplete_type')))) {
		var_type = rt.get_superglobal('_REQUEST').array_get(rt.new_string('autocomplete_type'))
	} else {
		var_type = rt.new_string('add')
	}
	if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('autocomplete_field'))
		&& rt.is_true(rt.identical(rt.new_string('user_email'), rt.get_superglobal('_REQUEST').array_get(rt.new_string('autocomplete_field')))) {
		var_field = rt.get_superglobal('_REQUEST').array_get(rt.new_string('autocomplete_field'))
	} else {
		var_field = rt.new_string('user_login')
	}
	if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('site_id')) {
		var_id = rt.call_function('absint',
			[rt.get_superglobal('_REQUEST').array_get(rt.new_string('site_id'))])
	} else {
		var_id = rt.call_function('get_current_blog_id', []rt.PhpVal{})
	}
	var_include_blog_users = if rt.is_true(rt.identical(rt.new_string('search'), var_type)) { rt.call_function('get_users', [
			rt.create_array([rt.ArrayItem{ key: 'blog_id', val: var_id },
				rt.ArrayItem{ key: 'fields', val: 'ID' }]),
		]) } else { rt.new_array() }
	var_exclude_blog_users = if rt.is_true(rt.identical(rt.new_string('add'), var_type)) { rt.call_function('get_users', [
			rt.create_array([rt.ArrayItem{ key: 'blog_id', val: var_id },
				rt.ArrayItem{ key: 'fields', val: 'ID' }]),
		]) } else { rt.new_array() }
	var_users = rt.call_function('get_users', [
		rt.create_array([rt.ArrayItem{ key: 'blog_id', val: false },
			rt.ArrayItem{ key: 'search', val: '*' +
				(rt.get_superglobal('_REQUEST').array_get(rt.new_string('term'))).str() + '*' },
			rt.ArrayItem{ key: 'include', val: var_include_blog_users },
			rt.ArrayItem{ key: 'exclude', val: var_exclude_blog_users },
			rt.ArrayItem{ key: 'search_columns', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'user_login' },
				rt.ArrayItem{ key: none, val: 'user_nicename' },
				rt.ArrayItem{ key: none, val: 'user_email' },
			]) }]),
	])
	mut iter_1 := var_users.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_user_shadow := item_1.val
		var_return.array_push(rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('sprintf', [
				rt.call_function('_x', [rt.new_string('%1$s (%2$s)'),
					rt.new_string('user autocomplete result')]),
				rt.get_property(var_user_shadow, 'user_login'),
				rt.get_property(var_user_shadow, 'user_email'),
			]) },
			rt.ArrayItem{ key: 'value', val: rt.get_property(var_user_shadow,
				'{"nodeType":"Expr_Variable","line":356,"name":"field"}') },
		]))
	}
	rt.call_function('wp_die', [rt.call_function('wp_json_encode', [
		var_return.clone()])])
}

fn wp_ajax_get_community_events() {
	mut var_search := rt.new_null()
	mut var_timezone := rt.new_null()
	mut var_user_id := rt.new_null()
	mut var_saved_location := rt.new_null()
	mut var_events_client := rt.new_null()
	mut var_events := rt.new_null()
	mut var_ip_changed := false
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/class-wp-community-events.php', '4')
	rt.call_function('check_ajax_referer', [rt.new_string('community_events')])
	var_search = if rt.get_superglobal('_POST').array_isset(rt.new_string('location')) { rt.call_function('wp_unslash', [
			rt.get_superglobal('_POST').array_get(rt.new_string('location')),
		]) } else { rt.new_string('') }
	var_timezone = if rt.get_superglobal('_POST').array_isset(rt.new_string('timezone')) { rt.call_function('wp_unslash', [
			rt.get_superglobal('_POST').array_get(rt.new_string('timezone')),
		]) } else { rt.new_string('') }
	var_user_id = rt.call_function('get_current_user_id', []rt.PhpVal{})
	var_saved_location = rt.call_function('get_user_option', [
		rt.new_string('community-events-location'),
		var_user_id.clone(),
	])
	var_events_client = create_wp_community_events(var_user_id.clone(), var_saved_location.clone())
	var_events = var_events_client.get_events(var_search.clone(), var_timezone.clone())
	var_ip_changed = false
	if rt.is_true(rt.call_function('is_wp_error', [var_events.clone()])) {
		rt.call_function('wp_send_json_error', [
			rt.create_array([
				rt.ArrayItem{ key: 'error', val: rt.call_method(var_events, 'get_error_message',
					[]rt.PhpVal{}) },
			]),
		])
	} else {
		if !rt.is_true(var_saved_location.array_get(rt.new_string('ip')))
			&& !(!rt.is_true(var_events.array_get(rt.new_string('location')).array_get(rt.new_string('ip')))) {
			var_ip_changed = true
		} else if var_saved_location.array_isset(rt.new_string('ip'))
			&& !(!rt.is_true(var_events.array_get(rt.new_string('location')).array_get(rt.new_string('ip'))))
			&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_saved_location.array_get(rt.new_string('ip')), var_events.array_get(rt.new_string('location')).array_get(rt.new_string('ip')))))) {
			var_ip_changed = true
		}
		if var_ip_changed || rt.is_true(var_search) {
			rt.call_function('update_user_meta', [var_user_id.clone(),
				rt.new_string('community-events-location'), var_events.array_get(rt.new_string('location'))])
		}
		rt.call_function('wp_send_json_success', [var_events.clone()])
	}
}

fn wp_ajax_dashboard_widgets() {
	mut var_pagenow := rt.new_null()
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/dashboard.php', '4')
	var_pagenow = rt.get_superglobal('_GET').array_get(rt.new_string('pagenow'))
	if rt.is_true(rt.identical(rt.new_string('dashboard-user'), var_pagenow))
		|| rt.is_true(rt.identical(rt.new_string('dashboard-network'), var_pagenow))
		|| rt.is_true(rt.identical(rt.new_string('dashboard'), var_pagenow)) {
		rt.call_function('set_current_screen', [var_pagenow.clone()])
	}
	mut switch_val_1 := rt.get_superglobal('_GET').array_get(rt.new_string('widget'))
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('dashboard_primary'))) {
		rt.call_function('wp_dashboard_primary', []rt.PhpVal{})
	}
	rt.call_function('wp_die', []rt.PhpVal{})
}

fn wp_ajax_logged_in() {
	rt.call_function('wp_die', [rt.new_int(1)])
}

fn _wp_ajax_delete_comment_response(var_comment_id rt.PhpVal, var_delta rt.PhpVal) {
	mut var_query_vars := map[string]rt.PhpVal{}
	mut var_total := rt.new_null()
	mut var_per_page := rt.new_null()
	mut var_page := rt.new_null()
	mut var_url := rt.new_null()
	mut var_time := rt.new_null()
	mut var_comment := rt.new_null()
	mut var_comment_status := rt.new_null()
	mut var_comment_link := rt.new_null()
	mut var_counts := rt.new_null()
	mut var_response := rt.new_null()
	mut var_post_id := rt.new_null()
	mut var_status := rt.new_null()
	mut var_parsed := rt.new_null()
	mut var_type := rt.new_null()
	mut var_comment_count := rt.new_null()
	var_total = rt.new_int(if rt.get_superglobal('_POST').array_isset(rt.new_string('_total')) {
		rt.new_int((rt.get_superglobal('_POST').array_get(rt.new_string('_total'))).to_i64())
	} else {
		0
	})
	var_per_page = rt.new_int(if rt.get_superglobal('_POST').array_isset(rt.new_string('_per_page')) {
		rt.new_int((rt.get_superglobal('_POST').array_get(rt.new_string('_per_page'))).to_i64())
	} else {
		0
	})
	var_page = rt.new_int(if rt.get_superglobal('_POST').array_isset(rt.new_string('_page')) {
		rt.new_int((rt.get_superglobal('_POST').array_get(rt.new_string('_page'))).to_i64())
	} else {
		0
	})
	var_url = if rt.get_superglobal('_POST').array_isset(rt.new_string('_url')) { rt.call_function('sanitize_url', [
			rt.get_superglobal('_POST').array_get(rt.new_string('_url')),
		]) } else { rt.new_string('') }
	if rt.is_true(rt.new_bool(!(rt.is_true(var_total))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(var_per_page))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(var_page))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(var_url)))) {
		var_time = rt.call_function('time', []rt.PhpVal{})
		var_comment = rt.call_function('get_comment', [var_comment_id.clone()])
		var_comment_status = rt.new_string('')
		var_comment_link = rt.new_string('')
		if rt.is_true(var_comment) {
			var_comment_status = rt.get_property(var_comment, 'comment_approved')
		}
		if 1 == rt.new_int(var_comment_status.to_i64()) {
			var_comment_link = rt.call_function('get_comment_link', [
				var_comment.clone()])
		}
		var_counts = rt.call_function('wp_count_comments', []rt.PhpVal{})
		var_response = create_wp_ajax_response(rt.create_array([
			rt.ArrayItem{ key: 'what', val: 'comment' },
			rt.ArrayItem{ key: 'id', val: var_comment_id },
			rt.ArrayItem{ key: 'supplemental', val: rt.create_array([
				rt.ArrayItem{ key: 'status', val: var_comment_status },
				rt.ArrayItem{
					key: 'postId'
					val: if rt.is_true(var_comment) {
						rt.get_property(var_comment, 'comment_post_ID')
					} else {
						rt.new_string('')
					}
				},
				rt.ArrayItem{ key: 'time', val: var_time },
				rt.ArrayItem{ key: 'in_moderation', val: rt.get_property(var_counts, 'moderated') },
				rt.ArrayItem{ key: 'i18n_comments_text', val: rt.call_function('sprintf', [
					rt.call_function('_n', [rt.new_string('%s Comment'),
						rt.new_string('%s Comments'), rt.get_property(var_counts, 'approved')]),
					rt.call_function('number_format_i18n',
						[rt.get_property(var_counts, 'approved')]),
				]) },
				rt.ArrayItem{ key: 'i18n_moderation_text', val: rt.call_function('sprintf', [
					rt.call_function('_n', [rt.new_string('%s Comment in moderation'),
						rt.new_string('%s Comments in moderation'),
						rt.get_property(var_counts, 'moderated')]),
					rt.call_function('number_format_i18n',
						[rt.get_property(var_counts, 'moderated')]),
				]) },
				rt.ArrayItem{ key: 'comment_link', val: var_comment_link },
			]) },
		]))
		rt.call_method(var_response, 'send', []rt.PhpVal{})
	}
	var_total = rt.add(var_total, var_delta)
	if rt.is_true(rt.less(var_total, rt.new_int(0))) {
		var_total = rt.new_int(0)
	}
	if rt.is_true(rt.identical(rt.new_int(0), rt.mod_(var_total, var_per_page)))
		|| rt.is_true(rt.identical(rt.new_int(1), rt.call_function('mt_rand', [rt.new_int(1), var_per_page.clone()]))) {
		var_post_id = rt.new_int(0)
		var_status = rt.new_string('all')
		var_parsed = rt.call_function('parse_url', [var_url.clone()])
		if var_parsed.array_isset(rt.new_string('query')) {
			rt.call_function('parse_str', [var_parsed.array_get(rt.new_string('query')),
				rt.create_array_from_native_map(var_query_vars)])
			if !(!rt.is_true(var_query_vars['comment_status'])) {
				var_status = var_query_vars['comment_status']
			}
			if !(!rt.is_true(var_query_vars['p'])) {
				var_post_id = rt.new_int((var_query_vars['p']).to_i64())
			}
			if !(!rt.is_true(var_query_vars['comment_type'])) {
				var_type = var_query_vars['comment_type']
			}
		}
		if !rt.is_true(var_type) {
			var_comment_count = rt.call_function('wp_count_comments', [
				var_post_id.clone()])
			if !(rt.get_property(var_comment_count,
				'{"nodeType":"Expr_Variable","line":543,"name":"status"}')).is_null() {
				var_total = rt.get_property(var_comment_count,
					'{"nodeType":"Expr_Variable","line":544,"name":"status"}')
			}
		}
	}
	var_time = rt.call_function('time', []rt.PhpVal{})
	var_comment = rt.call_function('get_comment', [var_comment_id.clone()])
	var_counts = rt.call_function('wp_count_comments', []rt.PhpVal{})
	var_response = create_wp_ajax_response(rt.create_array([
		rt.ArrayItem{ key: 'what', val: 'comment' },
		rt.ArrayItem{ key: 'id', val: var_comment_id },
		rt.ArrayItem{ key: 'supplemental', val: rt.create_array([
			rt.ArrayItem{
				key: 'status'
				val: if rt.is_true(var_comment) {
					rt.get_property(var_comment, 'comment_approved')
				} else {
					rt.new_string('')
				}
			},
			rt.ArrayItem{
				key: 'postId'
				val: if rt.is_true(var_comment) {
					rt.get_property(var_comment, 'comment_post_ID')
				} else {
					rt.new_string('')
				}
			},
			rt.ArrayItem{ key: 'total_items_i18n', val: rt.call_function('sprintf', [
				rt.call_function('_n', [rt.new_string('%s item'),
					rt.new_string('%s items'), var_total.clone()]),
				rt.call_function('number_format_i18n', [var_total.clone()]),
			]) },
			rt.ArrayItem{ key: 'total_pages', val: rt.new_int((rt.call_function('ceil', [
				rt.div(var_total, var_per_page),
			])).to_i64()) },
			rt.ArrayItem{ key: 'total_pages_i18n', val: rt.call_function('number_format_i18n', [
				rt.new_int((rt.call_function('ceil', [rt.div(var_total, var_per_page)])).to_i64()),
			]) },
			rt.ArrayItem{ key: 'total', val: var_total },
			rt.ArrayItem{ key: 'time', val: var_time },
			rt.ArrayItem{ key: 'in_moderation', val: rt.get_property(var_counts, 'moderated') },
			rt.ArrayItem{ key: 'i18n_moderation_text', val: rt.call_function('sprintf', [
				rt.call_function('_n', [rt.new_string('%s Comment in moderation'),
					rt.new_string('%s Comments in moderation'),
					rt.get_property(var_counts, 'moderated')]),
				rt.call_function('number_format_i18n', [rt.get_property(var_counts, 'moderated')]),
			]) },
		]) },
	]))
	rt.call_method(var_response, 'send', []rt.PhpVal{})
}

fn _wp_ajax_add_hierarchical_term() {
	mut var_action := rt.new_null()
	mut var_taxonomy := rt.new_null()
	mut var_names := rt.new_null()
	mut var_parent := rt.new_null()
	mut var_post_category := rt.new_null()
	mut var_checked_categories := rt.new_null()
	mut var_popular_ids := rt.new_null()
	mut var_category_name := ''
	mut var_category_nicename := rt.new_null()
	mut var_category_id := rt.new_null()
	mut var_data := rt.new_null()
	mut var_add := map[string]rt.PhpVal{}
	mut var_term_id := rt.new_null()
	mut var_parent_dropdown_args := rt.new_null()
	mut var_supplemental := rt.new_null()
	mut var_response := rt.new_null()
	var_action = rt.get_superglobal('_POST').array_get(rt.new_string('action'))
	var_taxonomy = rt.call_function('get_taxonomy', [
		rt.call_function('substr', [var_action.clone(), rt.new_int(4)]),
	])
	rt.call_function('check_ajax_referer', [var_action.clone(),
		rt.new_string('_ajax_nonce-add-' + (rt.get_property(var_taxonomy, 'name')).str())])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.get_property(rt.get_property(var_taxonomy, 'cap'), 'edit_terms'),
	])))))
	{
		rt.call_function('wp_die', [rt.new_int(-1)])
	}
	var_names = rt.call_function('explode', [rt.new_string(','),
		rt.get_superglobal('_POST').array_get(rt.new_string('new' +
			(rt.get_property(var_taxonomy, 'name')).str()))])
	var_parent = rt.new_int(if rt.get_superglobal('_POST').array_isset('new' +
		(rt.get_property(var_taxonomy, 'name')).str() + '_parent')
	{
		rt.new_int((rt.get_superglobal('_POST').array_get(rt.new_string('new' +
			(rt.get_property(var_taxonomy, 'name')).str() + '_parent'))).to_i64())
	} else {
		0
	})
	if rt.is_true(rt.greater(rt.new_int(0), var_parent)) {
		var_parent = rt.new_int(0)
	}
	if rt.is_true(rt.identical(rt.new_string('category'), rt.get_property(var_taxonomy, 'name'))) {
		var_post_category = if rt.get_superglobal('_POST').array_isset(rt.new_string('post_category')) {
			rt.cast_array(rt.get_superglobal('_POST').array_get(rt.new_string('post_category')))
		} else {
			rt.new_array()
		}
	} else {
		var_post_category = if rt.get_superglobal('_POST').array_isset(rt.new_string('tax_input'))
			&& rt.get_superglobal('_POST').array_get(rt.new_string('tax_input')).array_isset(rt.get_property(var_taxonomy, 'name')) {
			rt.cast_array(rt.get_superglobal('_POST').array_get(rt.new_string('tax_input')).array_get(rt.get_property(var_taxonomy,
				'name')))
		} else {
			rt.new_array()
		}
	}
	var_checked_categories = rt.call_function('array_map', [rt.new_string('absint'),
		rt.cast_array(var_post_category)])
	var_popular_ids = rt.call_function('wp_popular_terms_checklist', [
		rt.get_property(var_taxonomy, 'name'),
		rt.new_int(0),
		rt.new_int(10),
		rt.new_bool(false),
	])
	mut iter_2 := var_names.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_category_name_shadow := item_2.val
		var_category_name_shadow = rt.new_string(var_category_name_shadow.trim_space())
		var_category_nicename = rt.call_function('sanitize_title', [
			rt.new_string(var_category_name_shadow.str()),
		])
		if rt.is_true(rt.identical(rt.new_string(''), var_category_nicename)) {
			continue
		}
		var_category_id = rt.call_function('wp_insert_term', [
			rt.new_string(var_category_name_shadow.str()),
			rt.get_property(var_taxonomy, 'name'),
			rt.create_array([rt.ArrayItem{ key: 'parent', val: var_parent }]),
		])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_category_id))))
			|| rt.is_true(rt.call_function('is_wp_error', [var_category_id.clone()])) {
			continue
		} else {
			var_category_id = var_category_id.array_get(rt.new_string('term_id'))
		}
		var_checked_categories.array_push(var_category_id.clone())
		if rt.is_true(var_parent) {
			continue
		}
		rt.call_function('ob_start', []rt.PhpVal{})
		rt.call_function('wp_terms_checklist', [rt.new_int(0),
			rt.create_array([
				rt.ArrayItem{ key: 'taxonomy', val: rt.get_property(var_taxonomy, 'name') },
				rt.ArrayItem{ key: 'descendants_and_self', val: var_category_id },
				rt.ArrayItem{ key: 'selected_cats', val: var_checked_categories },
				rt.ArrayItem{ key: 'popular_cats', val: var_popular_ids },
			])])
		var_data = rt.call_function('ob_get_clean', []rt.PhpVal{})
		var_add = {
			'what':     rt.get_property(var_taxonomy, 'name')
			'id':       var_category_id
			'data':     rt.call_function('str_replace', [map[string]rt.PhpVal{},
				rt.new_string(''), var_data.clone()])
			'position': -1
		}
	}
	if rt.is_true(var_parent) {
		var_parent = rt.call_function('get_term', [var_parent.clone(),
			rt.get_property(var_taxonomy, 'name')])
		var_term_id = rt.get_property(var_parent, 'term_id')
		for rt.is_true(rt.get_property(var_parent, 'parent')) {
			var_parent = rt.call_function('get_term', [
				rt.get_property(var_parent, 'parent'),
				rt.get_property(var_taxonomy, 'name'),
			])
			if rt.is_true(rt.call_function('is_wp_error', [var_parent.clone()])) {
				break
			}
			var_term_id = rt.get_property(var_parent, 'term_id')
		}
		rt.call_function('ob_start', []rt.PhpVal{})
		rt.call_function('wp_terms_checklist', [rt.new_int(0),
			rt.create_array([
				rt.ArrayItem{ key: 'taxonomy', val: rt.get_property(var_taxonomy, 'name') },
				rt.ArrayItem{ key: 'descendants_and_self', val: var_term_id },
				rt.ArrayItem{ key: 'selected_cats', val: var_checked_categories },
				rt.ArrayItem{ key: 'popular_cats', val: var_popular_ids },
			])])
		var_data = rt.call_function('ob_get_clean', []rt.PhpVal{})
		var_add = {
			'what':     rt.get_property(var_taxonomy, 'name')
			'id':       var_term_id
			'data':     rt.call_function('str_replace', [map[string]rt.PhpVal{},
				rt.new_string(''), var_data.clone()])
			'position': -1
		}
	}
	var_parent_dropdown_args = rt.create_array([
		rt.ArrayItem{ key: 'taxonomy', val: rt.get_property(var_taxonomy, 'name') },
		rt.ArrayItem{ key: 'hide_empty', val: 0 },
		rt.ArrayItem{ key: 'name', val: 'new' + (rt.get_property(var_taxonomy, 'name')).str() +
			'_parent' },
		rt.ArrayItem{ key: 'orderby', val: 'name' },
		rt.ArrayItem{ key: 'hierarchical', val: 1 },
		rt.ArrayItem{ key: 'show_option_none', val: '&mdash; ' +
			(rt.get_property(rt.get_property(var_taxonomy, 'labels'), 'parent_item')).str() +
			' &mdash;' },
	])
	var_parent_dropdown_args = rt.call_function('apply_filters', [
		rt.new_string('post_edit_category_parent_dropdown_args'),
		var_parent_dropdown_args.clone(),
	])
	rt.call_function('ob_start', []rt.PhpVal{})
	rt.call_function('wp_dropdown_categories', [var_parent_dropdown_args.clone()])
	var_supplemental = rt.call_function('ob_get_clean', []rt.PhpVal{})
	var_add['supplemental'] = rt.create_array([
		rt.ArrayItem{ key: 'newcat_parent', val: var_supplemental },
	])
	var_response = create_wp_ajax_response(var_add.clone())
	rt.call_method(var_response, 'send', []rt.PhpVal{})
}

fn wp_ajax_delete_comment() {
	mut var_id := rt.new_null()
	mut var_comment := rt.new_null()
	mut var_status := rt.new_null()
	mut var_delta := rt.new_null()
	mut var_result := rt.new_null()
	var_id = rt.new_int(if rt.get_superglobal('_POST').array_isset(rt.new_string('id')) {
		rt.new_int((rt.get_superglobal('_POST').array_get(rt.new_string('id'))).to_i64())
	} else {
		0
	})
	var_comment = rt.call_function('get_comment', [var_id.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_comment)))) {
		rt.call_function('wp_die', [rt.call_function('time', []rt.PhpVal{})])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('edit_comment'),
		rt.get_property(var_comment, 'comment_ID'),
	])))))
	{
		rt.call_function('wp_die', [rt.new_int(-1)])
	}
	rt.call_function('check_ajax_referer', [
		rt.new_string('delete-comment_${var_id.to_string()}'),
	])
	var_status = rt.call_function('wp_get_comment_status', [var_comment.clone()])
	var_delta = rt.new_int(-1)
	if rt.get_superglobal('_POST').array_isset(rt.new_string('trash'))
		&& rt.is_true(rt.identical(rt.new_string('1'), rt.get_superglobal('_POST').array_get(rt.new_string('trash')))) {
		if rt.is_true(rt.identical(rt.new_string('trash'), var_status)) {
			rt.call_function('wp_die', [rt.call_function('time', []rt.PhpVal{})])
		}
		var_result = rt.call_function('wp_trash_comment', [var_comment.clone()])
	} else if rt.get_superglobal('_POST').array_isset(rt.new_string('untrash'))
		&& rt.is_true(rt.identical(rt.new_string('1'), rt.get_superglobal('_POST').array_get(rt.new_string('untrash')))) {
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('trash'), var_status)))) {
			rt.call_function('wp_die', [rt.call_function('time', []rt.PhpVal{})])
		}
		var_result = rt.call_function('wp_untrash_comment', [
			var_comment.clone()])
		if !(rt.get_superglobal('_POST').array_isset(rt.new_string('comment_status')))
			|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('trash'), rt.get_superglobal('_POST').array_get(rt.new_string('comment_status')))))) {
			var_delta = rt.new_int(1)
		}
	} else if rt.get_superglobal('_POST').array_isset(rt.new_string('spam'))
		&& rt.is_true(rt.identical(rt.new_string('1'), rt.get_superglobal('_POST').array_get(rt.new_string('spam')))) {
		if rt.is_true(rt.identical(rt.new_string('spam'), var_status)) {
			rt.call_function('wp_die', [rt.call_function('time', []rt.PhpVal{})])
		}
		var_result = rt.call_function('wp_spam_comment', [var_comment.clone()])
	} else if rt.get_superglobal('_POST').array_isset(rt.new_string('unspam'))
		&& rt.is_true(rt.identical(rt.new_string('1'), rt.get_superglobal('_POST').array_get(rt.new_string('unspam')))) {
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('spam'), var_status)))) {
			rt.call_function('wp_die', [rt.call_function('time', []rt.PhpVal{})])
		}
		var_result = rt.call_function('wp_unspam_comment', [var_comment.clone()])
		if !(rt.get_superglobal('_POST').array_isset(rt.new_string('comment_status')))
			|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('spam'), rt.get_superglobal('_POST').array_get(rt.new_string('comment_status')))))) {
			var_delta = rt.new_int(1)
		}
	} else if rt.get_superglobal('_POST').array_isset(rt.new_string('delete'))
		&& rt.is_true(rt.identical(rt.new_string('1'), rt.get_superglobal('_POST').array_get(rt.new_string('delete')))) {
		var_result = rt.call_function('wp_delete_comment', [var_comment.clone()])
	} else {
		rt.call_function('wp_die', [rt.new_int(-1)])
	}
	if rt.is_true(var_result) {
		_wp_ajax_delete_comment_response(rt.get_property(var_comment, 'comment_ID'),
			var_delta.clone())
	}
	rt.call_function('wp_die', [rt.new_int(0)])
}

fn wp_ajax_delete_tag() {
	mut var_tag_id := rt.new_null()
	mut var_taxonomy := rt.new_null()
	mut var_tag := rt.new_null()
	var_tag_id =
		rt.new_int((rt.get_superglobal('_POST').array_get(rt.new_string('tag_ID'))).to_i64())
	rt.call_function('check_ajax_referer', [
		rt.new_string('delete-tag_${var_tag_id.to_string()}'),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('delete_term'),
		var_tag_id.clone(),
	])))))
	{
		rt.call_function('wp_die', [rt.new_int(-1)])
	}
	var_taxonomy = if !(!rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('taxonomy')))) {
		rt.get_superglobal('_POST').array_get(rt.new_string('taxonomy'))
	} else {
		rt.new_string('post_tag')
	}
	var_tag = rt.call_function('get_term', [var_tag_id.clone(),
		var_taxonomy.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_tag))))
		|| rt.is_true(rt.call_function('is_wp_error', [var_tag.clone()])) {
		rt.call_function('wp_die', [rt.new_int(1)])
	}
	if rt.is_true(rt.call_function('wp_delete_term', [var_tag_id.clone(),
		var_taxonomy.clone()]))
	{
		rt.call_function('wp_die', [rt.new_int(1)])
	} else {
		rt.call_function('wp_die', [rt.new_int(0)])
	}
}

fn wp_ajax_delete_link() {
	mut var_id := rt.new_null()
	mut var_link := rt.new_null()
	var_id = rt.new_int(if rt.get_superglobal('_POST').array_isset(rt.new_string('id')) {
		rt.new_int((rt.get_superglobal('_POST').array_get(rt.new_string('id'))).to_i64())
	} else {
		0
	})
	rt.call_function('check_ajax_referer', [
		rt.new_string('delete-bookmark_${var_id.to_string()}'),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('manage_links'),
	])))))
	{
		rt.call_function('wp_die', [rt.new_int(-1)])
	}
	var_link = rt.call_function('get_bookmark', [var_id.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_link))))
		|| rt.is_true(rt.call_function('is_wp_error', [var_link.clone()])) {
		rt.call_function('wp_die', [rt.new_int(1)])
	}
	if rt.is_true(rt.call_function('wp_delete_link', [var_id.clone()])) {
		rt.call_function('wp_die', [rt.new_int(1)])
	} else {
		rt.call_function('wp_die', [rt.new_int(0)])
	}
}

fn wp_ajax_delete_meta() {
	mut var_id := rt.new_null()
	mut var_meta := rt.new_null()
	var_id = rt.new_int(if rt.get_superglobal('_POST').array_isset(rt.new_string('id')) {
		rt.new_int((rt.get_superglobal('_POST').array_get(rt.new_string('id'))).to_i64())
	} else {
		0
	})
	rt.call_function('check_ajax_referer', [
		rt.new_string('delete-meta_${var_id.to_string()}'),
	])
	var_meta = rt.call_function('get_metadata_by_mid', [rt.new_string('post'),
		var_id.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_meta)))) {
		rt.call_function('wp_die', [rt.new_int(1)])
	}
	if rt.is_true(rt.call_function('is_protected_meta', [rt.get_property(var_meta, 'meta_key'), rt.new_string('post')]))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('delete_post_meta'), rt.get_property(var_meta, 'post_id'), rt.get_property(var_meta, 'meta_key')]))))) {
		rt.call_function('wp_die', [rt.new_int(-1)])
	}
	if rt.is_true(rt.call_function('delete_meta', [rt.get_property(var_meta, 'meta_id')])) {
		rt.call_function('wp_die', [rt.new_int(1)])
	}
	rt.call_function('wp_die', [rt.new_int(0)])
}

fn wp_ajax_delete_post(var_action_arg rt.PhpVal) {
	mut var_action := var_action_arg
	mut var_id := rt.new_null()
	if var_action == '' {
		var_action = 'delete-post'
	}
	var_id = rt.new_int(if rt.get_superglobal('_POST').array_isset(rt.new_string('id')) {
		rt.new_int((rt.get_superglobal('_POST').array_get(rt.new_string('id'))).to_i64())
	} else {
		0
	})
	rt.call_function('check_ajax_referer', [
		rt.new_string('${var_action}_${var_id.to_string()}'),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('delete_post'),
		var_id.clone(),
	])))))
	{
		rt.call_function('wp_die', [rt.new_int(-1)])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('get_post', [
		var_id.clone()])))))
	{
		rt.call_function('wp_die', [rt.new_int(1)])
	}
	if rt.is_true(rt.call_function('wp_delete_post', [var_id.clone()])) {
		rt.call_function('wp_die', [rt.new_int(1)])
	} else {
		rt.call_function('wp_die', [rt.new_int(0)])
	}
}

fn wp_ajax_trash_post(var_action_arg rt.PhpVal) {
	mut var_action := var_action_arg
	mut var_id := rt.new_null()
	mut var_done := rt.new_null()
	if var_action == '' {
		var_action = 'trash-post'
	}
	var_id = rt.new_int(if rt.get_superglobal('_POST').array_isset(rt.new_string('id')) {
		rt.new_int((rt.get_superglobal('_POST').array_get(rt.new_string('id'))).to_i64())
	} else {
		0
	})
	rt.call_function('check_ajax_referer', [
		rt.new_string('${var_action}_${var_id.to_string()}'),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('delete_post'),
		var_id.clone(),
	])))))
	{
		rt.call_function('wp_die', [rt.new_int(-1)])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('get_post', [
		var_id.clone()])))))
	{
		rt.call_function('wp_die', [rt.new_int(1)])
	}
	if rt.is_true(rt.identical(rt.new_string('trash-post'), rt.new_string(var_action.str()))) {
		var_done = rt.call_function('wp_trash_post', [var_id.clone()])
	} else {
		var_done = rt.call_function('wp_untrash_post', [var_id.clone()])
	}
	if rt.is_true(var_done) {
		rt.call_function('wp_die', [rt.new_int(1)])
	}
	rt.call_function('wp_die', [rt.new_int(0)])
}

fn wp_ajax_untrash_post(var_action_arg rt.PhpVal) {
	mut var_action := var_action_arg
	if var_action == '' {
		var_action = 'untrash-post'
	}
	wp_ajax_trash_post(rt.new_string(var_action.str()).clone())
}

fn wp_ajax_delete_page(var_action_arg rt.PhpVal) {
	mut var_action := var_action_arg
	mut var_id := rt.new_null()
	if var_action == '' {
		var_action = 'delete-page'
	}
	var_id = rt.new_int(if rt.get_superglobal('_POST').array_isset(rt.new_string('id')) {
		rt.new_int((rt.get_superglobal('_POST').array_get(rt.new_string('id'))).to_i64())
	} else {
		0
	})
	rt.call_function('check_ajax_referer', [
		rt.new_string('${var_action}_${var_id.to_string()}'),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('delete_page'),
		var_id.clone(),
	])))))
	{
		rt.call_function('wp_die', [rt.new_int(-1)])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('get_post', [
		var_id.clone()])))))
	{
		rt.call_function('wp_die', [rt.new_int(1)])
	}
	if rt.is_true(rt.call_function('wp_delete_post', [var_id.clone()])) {
		rt.call_function('wp_die', [rt.new_int(1)])
	} else {
		rt.call_function('wp_die', [rt.new_int(0)])
	}
}

fn wp_ajax_dim_comment() {
	mut var_id := rt.new_null()
	mut var_comment := rt.new_null()
	mut var_response := rt.new_null()
	mut var_current := rt.new_null()
	mut var_result := rt.new_null()
	var_id = rt.new_int(if rt.get_superglobal('_POST').array_isset(rt.new_string('id')) {
		rt.new_int((rt.get_superglobal('_POST').array_get(rt.new_string('id'))).to_i64())
	} else {
		0
	})
	var_comment = rt.call_function('get_comment', [var_id.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_comment)))) {
		var_response = create_wp_ajax_response(rt.create_array([
			rt.ArrayItem{ key: 'what', val: 'comment' },
			rt.ArrayItem{ key: 'id', val: create_wp_error(rt.new_string('invalid_comment'), rt.call_function('sprintf', [
				rt.call_function('__', [rt.new_string('Comment %d does not exist')]),
				var_id.clone(),
			])) },
		]))
		rt.call_method(var_response, 'send', []rt.PhpVal{})
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_comment'), rt.get_property(var_comment, 'comment_ID')])))))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('moderate_comments')]))))) {
		rt.call_function('wp_die', [rt.new_int(-1)])
	}
	var_current = rt.call_function('wp_get_comment_status', [
		var_comment.clone()])
	if rt.get_superglobal('_POST').array_isset(rt.new_string('new'))
		&& rt.is_true(rt.identical(rt.get_superglobal('_POST').array_get(rt.new_string('new')), var_current)) {
		rt.call_function('wp_die', [rt.call_function('time', []rt.PhpVal{})])
	}
	rt.call_function('check_ajax_referer', [
		rt.new_string('approve-comment_${var_id.to_string()}'),
	])
	if rt.is_true(rt.call_function('in_array', [var_current.clone(),
		rt.create_array([rt.ArrayItem{ key: none, val: 'unapproved' },
			rt.ArrayItem{ key: none, val: 'spam' }]),
		rt.new_bool(true)]))
	{
		var_result = rt.call_function('wp_set_comment_status', [
			var_comment.clone(), rt.new_string('approve'), rt.new_bool(true)])
	} else {
		var_result = rt.call_function('wp_set_comment_status', [
			var_comment.clone(), rt.new_string('hold'), rt.new_bool(true)])
	}
	if rt.is_true(rt.call_function('is_wp_error', [var_result.clone()])) {
		var_response = create_wp_ajax_response(rt.create_array([
			rt.ArrayItem{ key: 'what', val: 'comment' },
			rt.ArrayItem{ key: 'id', val: var_result },
		]))
		rt.call_method(var_response, 'send', []rt.PhpVal{})
	}
	_wp_ajax_delete_comment_response(rt.get_property(var_comment, 'comment_ID'), rt.new_null())
	rt.call_function('wp_die', [rt.new_int(0)])
}

fn wp_ajax_add_link_category(var_action_arg rt.PhpVal) {
	mut var_action := var_action_arg
	mut var_taxonomy_object := rt.new_null()
	mut var_names := rt.new_null()
	mut var_response := rt.new_null()
	mut var_category_name := rt.new_null()
	mut var_slug := rt.new_null()
	mut var_category_id := rt.new_null()
	if var_action == '' {
		var_action = 'add-link-category'
	}
	rt.call_function('check_ajax_referer', [rt.new_string(var_action.str()).clone()])
	var_taxonomy_object = rt.call_function('get_taxonomy', [
		rt.new_string('link_category'),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.get_property(rt.get_property(var_taxonomy_object, 'cap'), 'manage_terms'),
	])))))
	{
		rt.call_function('wp_die', [rt.new_int(-1)])
	}
	var_names = rt.call_function('explode', [rt.new_string(','),
		rt.call_function('wp_unslash',
			[rt.get_superglobal('_POST').array_get(rt.new_string('newcat'))])])
	var_response = create_wp_ajax_response()
	mut iter_3 := var_names.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_category_name_shadow := item_3.val
		var_category_name_shadow =
			rt.new_string(var_category_name_shadow.clone().to_string().trim_space())
		var_slug = rt.call_function('sanitize_title', [var_category_name_shadow.clone()])
		if rt.is_true(rt.identical(rt.new_string(''), var_slug)) {
			continue
		}
		var_category_id = rt.call_function('wp_insert_term', [
			var_category_name_shadow.clone(), rt.new_string('link_category')])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_category_id))))
			|| rt.is_true(rt.call_function('is_wp_error', [var_category_id.clone()])) {
			continue
		} else {
			var_category_id = var_category_id.array_get(rt.new_string('term_id'))
		}
		var_category_name_shadow = rt.call_function('esc_html', [
			var_category_name_shadow.clone()])
		rt.call_method(var_response, 'add', [
			rt.create_array([rt.ArrayItem{ key: 'what', val: 'link-category' },
				rt.ArrayItem{ key: 'id', val: var_category_id },
				rt.ArrayItem{
					key: 'data'
					val:
						"<li id='link-category-${var_category_id.to_string()}'><label for='in-link-category-${var_category_id.to_string()}' class='selectit'><input value='" +
						(rt.call_function('esc_attr', [var_category_id.clone()])).str() +
						"' type='checkbox' checked='checked' name='link_category[]' id='in-link-category-${var_category_id.to_string()}'/> ${var_category_name.to_string()}</label></li>"
				}, rt.ArrayItem{ key: 'position', val: -1 }]),
		])
	}
	rt.call_method(var_response, 'send', []rt.PhpVal{})
}

fn wp_ajax_add_tag() {
	mut var_messages := rt.new_null()
	mut var_taxonomy := rt.new_null()
	mut var_taxonomy_object := rt.new_null()
	mut var_response := rt.new_null()
	mut var_tag := rt.new_null()
	mut var_message := rt.new_null()
	mut var_error_code := rt.new_null()
	mut var_wp_list_table := rt.new_null()
	mut var_level := i64(0)
	mut var_no_parents := rt.new_null()
	mut var_parents := rt.new_null()
	rt.call_function('check_ajax_referer', [rt.new_string('add-tag'),
		rt.new_string('_wpnonce_add-tag')])
	var_taxonomy = if !(!rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('taxonomy')))) {
		rt.get_superglobal('_POST').array_get(rt.new_string('taxonomy'))
	} else {
		rt.new_string('post_tag')
	}
	var_taxonomy_object = rt.call_function('get_taxonomy', [var_taxonomy.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.get_property(rt.get_property(var_taxonomy_object, 'cap'), 'edit_terms'),
	])))))
	{
		rt.call_function('wp_die', [rt.new_int(-1)])
	}
	var_response = create_wp_ajax_response()
	var_tag = rt.call_function('wp_insert_term', [
		rt.get_superglobal('_POST').array_get(rt.new_string('tag-name')),
		var_taxonomy.clone(),
		rt.get_superglobal('_POST').clone(),
	])
	if rt.is_true(var_tag)
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_tag.clone()]))))) {
		var_tag = rt.call_function('get_term', [var_tag.array_get(rt.new_string('term_id')),
			var_taxonomy.clone()])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_tag))))
		|| rt.is_true(rt.call_function('is_wp_error', [var_tag.clone()])) {
		var_message = rt.call_function('__', [
			rt.new_string('An error has occurred. Please reload the page and try again.'),
		])
		var_error_code = rt.new_string('error')
		if rt.is_true(rt.call_function('is_wp_error', [var_tag.clone()]))
			&& rt.is_true(rt.call_method(var_tag, 'get_error_message', []rt.PhpVal{})) {
			var_message = rt.call_method(var_tag, 'get_error_message', []rt.PhpVal{})
		}
		if rt.is_true(rt.call_function('is_wp_error', [var_tag.clone()]))
			&& rt.is_true(rt.call_method(var_tag, 'get_error_code', []rt.PhpVal{})) {
			var_error_code = rt.call_method(var_tag, 'get_error_code', []rt.PhpVal{})
		}
		rt.call_method(var_response, 'add', [
			rt.create_array([rt.ArrayItem{ key: 'what', val: 'taxonomy' },
				rt.ArrayItem{ key: 'data', val: create_wp_error(var_error_code.clone(),
					var_message.clone()) }]),
		])
		rt.call_method(var_response, 'send', []rt.PhpVal{})
	}
	var_wp_list_table = rt.call_function('_get_list_table', [
		rt.new_string('WP_Terms_List_Table'),
		rt.create_array([
			rt.ArrayItem{
				key: 'screen'
				val: rt.get_superglobal('_POST').array_get(rt.new_string('screen'))
			},
		]),
	])
	var_level = 0
	var_no_parents = rt.new_string('')
	if rt.is_true(rt.call_function('is_taxonomy_hierarchical', [
		var_taxonomy.clone()]))
	{
		var_level = rt.call_function('get_ancestors', [
			rt.get_property(var_tag, 'term_id'),
			var_taxonomy.clone(),
			rt.new_string('taxonomy'),
		]).array_count()
		rt.call_function('ob_start', []rt.PhpVal{})
		rt.call_method(var_wp_list_table, 'single_row', [var_tag.clone(),
			rt.new_int(var_level).clone()])
		var_no_parents = rt.call_function('ob_get_clean', []rt.PhpVal{})
	}
	rt.call_function('ob_start', []rt.PhpVal{})
	rt.call_method(var_wp_list_table, 'single_row', [var_tag.clone()])
	var_parents = rt.call_function('ob_get_clean', []rt.PhpVal{})
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/edit-tag-messages.php',
		'3')
	var_message = rt.new_string('')
	if var_messages.array_get(rt.get_property(var_taxonomy_object, 'name')).array_isset(rt.new_int(1)) {
		var_message =
			var_messages.array_get(rt.get_property(var_taxonomy_object, 'name')).array_get(rt.new_int(1))
	} else if var_messages.array_get(rt.new_string('_item')).array_isset(rt.new_int(1)) {
		var_message = var_messages.array_get(rt.new_string('_item')).array_get(rt.new_int(1))
	}
	rt.call_method(var_response, 'add', [
		rt.create_array([rt.ArrayItem{ key: 'what', val: 'taxonomy' },
			rt.ArrayItem{ key: 'data', val: var_message }, rt.ArrayItem{ key: 'supplemental', val: rt.create_array([
				rt.ArrayItem{ key: 'parents', val: var_parents },
				rt.ArrayItem{ key: 'noparents', val: var_no_parents },
				rt.ArrayItem{ key: 'notice', val: var_message },
			]) }]),
	])
	rt.call_method(var_response, 'add', [
		rt.create_array([rt.ArrayItem{ key: 'what', val: 'term' },
			rt.ArrayItem{ key: 'position', val: var_level }, rt.ArrayItem{
				key: 'supplemental'
				val: rt.cast_array(var_tag)
			}]),
	])
	rt.call_method(var_response, 'send', []rt.PhpVal{})
}

fn wp_ajax_get_tagcloud() {
	mut var_taxonomy := rt.new_null()
	mut var_taxonomy_object := rt.new_null()
	mut var_tags := rt.new_null()
	mut var_tag := rt.new_null()
	mut var_key := rt.new_null()
	mut var_return := rt.new_null()
	if !(rt.get_superglobal('_POST').array_isset(rt.new_string('tax'))) {
		rt.call_function('wp_die', [rt.new_int(0)])
	}
	var_taxonomy = rt.call_function('sanitize_key',
		[rt.get_superglobal('_POST').array_get(rt.new_string('tax'))])
	var_taxonomy_object = rt.call_function('get_taxonomy', [var_taxonomy.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_taxonomy_object)))) {
		rt.call_function('wp_die', [rt.new_int(0)])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.get_property(rt.get_property(var_taxonomy_object, 'cap'), 'assign_terms'),
	])))))
	{
		rt.call_function('wp_die', [rt.new_int(-1)])
	}
	var_tags = rt.call_function('get_terms', [
		rt.create_array([rt.ArrayItem{ key: 'taxonomy', val: var_taxonomy },
			rt.ArrayItem{ key: 'number', val: 45 }, rt.ArrayItem{ key: 'orderby', val: 'count' },
			rt.ArrayItem{ key: 'order', val: 'DESC' }]),
	])
	if !rt.is_true(var_tags) {
		rt.call_function('wp_die', [
			rt.get_property(rt.get_property(var_taxonomy_object, 'labels'), 'not_found'),
		])
	}
	if rt.is_true(rt.call_function('is_wp_error', [var_tags.clone()])) {
		rt.call_function('wp_die', [
			rt.call_method(var_tags, 'get_error_message', []rt.PhpVal{}),
		])
	}
	mut iter_4 := var_tags.iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_tag_shadow := item_4.val
		mut var_key_shadow := item_4.key
		rt.set_property(var_tags.array_get(var_key_shadow), 'link', rt.new_string('#'))
		rt.set_property(var_tags.array_get(var_key_shadow), 'id', rt.get_property(var_tag_shadow,
			'term_id'))
	}
	var_return = rt.call_function('wp_generate_tag_cloud', [var_tags.clone(),
		rt.create_array([rt.ArrayItem{ key: 'filter', val: 0 },
			rt.ArrayItem{ key: 'format', val: 'list' }])])
	if !rt.is_true(var_return) {
		rt.call_function('wp_die', [rt.new_int(0)])
	}
	rt.echo_val(var_return)
	rt.call_function('wp_die', []rt.PhpVal{})
}

fn wp_ajax_get_comments(var_action_arg rt.PhpVal) {
	mut var_action := var_action_arg
	mut var_id := rt.new_null()
	mut var_post_id := rt.new_null()
	mut var_wp_list_table := rt.new_null()
	mut var_response := rt.new_null()
	mut var_comment := rt.new_null()
	mut var_comment_list_item := rt.new_null()
	if var_action == '' {
		var_action = 'get-comments'
	}
	rt.call_function('check_ajax_referer', [rt.new_string(var_action.str()).clone()])
	if !rt.is_true(var_post_id)
		&& !(!rt.is_true(rt.get_superglobal('_REQUEST').array_get(rt.new_string('p')))) {
		var_id = rt.call_function('absint',
			[rt.get_superglobal('_REQUEST').array_get(rt.new_string('p'))])
		if !(!rt.is_true(var_id)) {
			var_post_id = var_id.clone()
		}
	}
	if !rt.is_true(var_post_id) {
		rt.call_function('wp_die', [rt.new_int(-1)])
	}
	var_wp_list_table = rt.call_function('_get_list_table', [
		rt.new_string('WP_Post_Comments_List_Table'),
		rt.create_array([rt.ArrayItem{ key: 'screen', val: 'edit-comments' }]),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('edit_post'),
		var_post_id.clone(),
	])))))
	{
		rt.call_function('wp_die', [rt.new_int(-1)])
	}
	rt.call_method(var_wp_list_table, 'prepare_items', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_wp_list_table, 'has_items',
		[]rt.PhpVal{})))))
	{
		rt.call_function('wp_die', [rt.new_int(1)])
	}
	var_response = create_wp_ajax_response()
	rt.call_function('ob_start', []rt.PhpVal{})
	mut iter_5 := rt.get_property(var_wp_list_table, 'items').iterator()
	for {
		item_5 := iter_5.next() or { break }
		mut var_comment_shadow := item_5.val
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_comment'), rt.get_property(var_comment_shadow, 'comment_ID')])))))
			&& rt.is_true(rt.identical(rt.new_int(0), rt.get_property(var_comment_shadow, 'comment_approved'))) {
			continue
		}
		rt.call_function('get_comment', [var_comment_shadow.clone()])
		rt.call_method(var_wp_list_table, 'single_row', [var_comment_shadow.clone()])
	}
	var_comment_list_item = rt.call_function('ob_get_clean', []rt.PhpVal{})
	rt.call_method(var_response, 'add', [
		rt.create_array([rt.ArrayItem{ key: 'what', val: 'comments' },
			rt.ArrayItem{ key: 'data', val: var_comment_list_item }]),
	])
	rt.call_method(var_response, 'send', []rt.PhpVal{})
}

fn wp_ajax_replyto_comment(var_action_arg rt.PhpVal) {
	mut var_action := var_action_arg
	mut var_comment_post_id := rt.new_null()
	mut var_post := rt.new_null()
	mut var_user := rt.new_null()
	mut var_comment_author := rt.new_null()
	mut var_comment_author_email := rt.new_null()
	mut var_comment_author_url := rt.new_null()
	mut var_user_id := rt.new_null()
	mut var_comment_content := ''
	mut var_comment_type := ''
	mut var_comment_parent := rt.new_null()
	mut var_comment_auto_approved := false
	mut var_commentdata := map[string]rt.PhpVal{}
	mut var_parent := rt.new_null()
	mut var_comment_id := rt.new_null()
	mut var_comment := rt.new_null()
	mut var_position := rt.new_null()
	mut var_wp_list_table := rt.new_null()
	mut var_comment_list_item := rt.new_null()
	mut var_response_data := map[string]rt.PhpVal{}
	mut var_counts := rt.new_null()
	mut var_response := rt.new_null()
	if var_action == '' {
		var_action = 'replyto-comment'
	}
	rt.call_function('check_ajax_referer', [rt.new_string(var_action.str()).clone(),
		rt.new_string('_ajax_nonce-replyto-comment')])
	var_comment_post_id =
		rt.new_int((rt.get_superglobal('_POST').array_get(rt.new_string('comment_post_ID'))).to_i64())
	var_post = rt.call_function('get_post', [var_comment_post_id.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_post)))) {
		rt.call_function('wp_die', [rt.new_int(-1)])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('edit_post'),
		var_comment_post_id.clone(),
	])))))
	{
		rt.call_function('wp_die', [rt.new_int(-1)])
	}
	if !rt.is_true(rt.get_property(var_post, 'post_status')) {
		rt.call_function('wp_die', [rt.new_int(1)])
	} else if rt.is_true(rt.call_function('in_array', [
		rt.get_property(var_post, 'post_status'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'draft' },
			rt.ArrayItem{ key: none, val: 'pending' }, rt.ArrayItem{ key: none, val: 'trash' }]),
		rt.new_bool(true),
	]))
	{
		rt.call_function('wp_die', [
			rt.call_function('__', [
				rt.new_string('You cannot reply to a comment on a draft post.'),
			]),
		])
	}
	var_user = rt.call_function('wp_get_current_user', []rt.PhpVal{})
	if rt.is_true(rt.call_method(var_user, 'exists', []rt.PhpVal{})) {
		var_comment_author = rt.call_function('wp_slash', [
			rt.get_property(var_user, 'display_name'),
		])
		var_comment_author_email = rt.call_function('wp_slash', [
			rt.get_property(var_user, 'user_email'),
		])
		var_comment_author_url = rt.call_function('wp_slash', [
			rt.get_property(var_user, 'user_url'),
		])
		var_user_id = rt.get_property(var_user, 'ID')
		if rt.is_true(rt.call_function('current_user_can', [
			rt.new_string('unfiltered_html'),
		]))
		{
			if !(rt.get_superglobal('_POST').array_isset(rt.new_string('_wp_unfiltered_html_comment'))) {
				rt.get_superglobal('_POST').array_set('_wp_unfiltered_html_comment', '')
			}
			if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('wp_create_nonce', [
				rt.new_string('unfiltered-html-comment'),
			]), rt.get_superglobal('_POST').array_get(rt.new_string('_wp_unfiltered_html_comment'))))))
			{
				rt.call_function('kses_remove_filters', []rt.PhpVal{})
				rt.call_function('kses_init_filters', []rt.PhpVal{})
				rt.call_function('remove_filter', [rt.new_string('pre_comment_content'),
					rt.new_string('wp_filter_post_kses')])
				rt.call_function('add_filter', [rt.new_string('pre_comment_content'),
					rt.new_string('wp_filter_kses')])
			}
		}
	} else {
		rt.call_function('wp_die', [
			rt.call_function('__', [
				rt.new_string('Sorry, you must be logged in to reply to a comment.'),
			]),
		])
	}
	var_comment_content =
		rt.get_superglobal('_POST').array_get(rt.new_string('content')).to_string().trim_space()
	if rt.is_true(rt.identical(rt.new_string(''), rt.new_string(var_comment_content.str()))) {
		rt.call_function('wp_die', [
			rt.call_function('__', [rt.new_string('Please type your comment text.')]),
		])
	}
	var_comment_type = if rt.get_superglobal('_POST').array_isset(rt.new_string('comment_type')) {
		rt.get_superglobal('_POST').array_get(rt.new_string('comment_type')).to_string().trim_space()
	} else {
		'comment'
	}
	var_comment_parent = rt.new_int(0)
	if rt.get_superglobal('_POST').array_isset(rt.new_string('comment_ID')) {
		var_comment_parent = rt.call_function('absint', [
			rt.get_superglobal('_POST').array_get(rt.new_string('comment_ID')),
		])
	}
	var_comment_auto_approved = false
	var_commentdata = {
		'comment_post_ID': var_comment_post_id
	}
	var_commentdata = rt.add(var_commentdata, rt.call_function('compact', [
		rt.new_string('comment_author'),
		rt.new_string('comment_author_email'),
		rt.new_string('comment_author_url'),
		rt.new_string('comment_content'),
		rt.new_string('comment_type'),
		rt.new_string('comment_parent'),
		rt.new_string('user_id'),
	]))
	if !(!rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('approve_parent')))) {
		var_parent = rt.call_function('get_comment', [var_comment_parent.clone()])
		if rt.is_true(var_parent)
			&& rt.is_true(rt.identical(rt.new_string('0'), rt.get_property(var_parent, 'comment_approved')))
			&& rt.is_true(rt.identical(rt.new_int((rt.get_property(var_parent, 'comment_post_ID')).to_i64()), var_comment_post_id)) {
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
				rt.new_string('edit_comment'),
				rt.get_property(var_parent, 'comment_ID'),
			])))))
			{
				rt.call_function('wp_die', [rt.new_int(-1)])
			}
			if rt.is_true(rt.call_function('wp_set_comment_status', [
				var_parent.clone(), rt.new_string('approve')]))
			{
				var_comment_auto_approved = true
			}
		}
	}
	var_comment_id = rt.call_function('wp_new_comment', [
		rt.create_array_from_native_map(var_commentdata),
	])
	if rt.is_true(rt.call_function('is_wp_error', [var_comment_id.clone()])) {
		rt.call_function('wp_die', [
			rt.call_method(var_comment_id, 'get_error_message', []rt.PhpVal{}),
		])
	}
	var_comment = rt.call_function('get_comment', [var_comment_id.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_comment)))) {
		rt.call_function('wp_die', [rt.new_int(1)])
	}
	var_position = if rt.get_superglobal('_POST').array_isset(rt.new_string('position'))
		&& rt.is_true(rt.new_int((rt.get_superglobal('_POST').array_get(rt.new_string('position'))).to_i64())) {
		rt.new_int((rt.get_superglobal('_POST').array_get(rt.new_string('position'))).to_i64())
	} else {
		rt.new_string('-1')
	}
	rt.call_function('ob_start', []rt.PhpVal{})
	if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('mode'))
		&& rt.is_true(rt.identical(rt.new_string('dashboard'), rt.get_superglobal('_REQUEST').array_get(rt.new_string('mode')))) {
		rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/dashboard.php', '4')
		rt.call_function('_wp_dashboard_recent_comments_row', [
			var_comment.clone()])
	} else {
		if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('mode'))
			&& rt.is_true(rt.identical(rt.new_string('single'), rt.get_superglobal('_REQUEST').array_get(rt.new_string('mode')))) {
			var_wp_list_table = rt.call_function('_get_list_table', [
				rt.new_string('WP_Post_Comments_List_Table'),
				rt.create_array([rt.ArrayItem{ key: 'screen', val: 'edit-comments' }]),
			])
		} else {
			var_wp_list_table = rt.call_function('_get_list_table', [
				rt.new_string('WP_Comments_List_Table'),
				rt.create_array([rt.ArrayItem{ key: 'screen', val: 'edit-comments' }]),
			])
		}
		rt.call_method(var_wp_list_table, 'single_row', [var_comment.clone()])
	}
	var_comment_list_item = rt.call_function('ob_get_clean', []rt.PhpVal{})
	var_response_data = {
		'what':     rt.new_string('comment')
		'id':       rt.get_property(var_comment, 'comment_ID')
		'data':     var_comment_list_item
		'position': var_position
	}
	var_counts = rt.call_function('wp_count_comments', []rt.PhpVal{})
	var_response_data['supplemental'] = rt.create_array([
		rt.ArrayItem{ key: 'in_moderation', val: rt.get_property(var_counts, 'moderated') },
		rt.ArrayItem{ key: 'i18n_comments_text', val: rt.call_function('sprintf', [
			rt.call_function('_n', [rt.new_string('%s Comment'),
				rt.new_string('%s Comments'), rt.get_property(var_counts, 'approved')]),
			rt.call_function('number_format_i18n', [rt.get_property(var_counts, 'approved')]),
		]) },
		rt.ArrayItem{ key: 'i18n_moderation_text', val: rt.call_function('sprintf', [
			rt.call_function('_n', [rt.new_string('%s Comment in moderation'),
				rt.new_string('%s Comments in moderation'), rt.get_property(var_counts, 'moderated')]),
			rt.call_function('number_format_i18n', [rt.get_property(var_counts, 'moderated')]),
		]) },
	])
	if var_comment_auto_approved {
		var_response_data.array_get_mut('supplemental').array_set('parent_approved', rt.get_property(var_parent,
			'comment_ID'))
		var_response_data.array_get_mut('supplemental').array_set('parent_post_id', rt.get_property(var_parent,
			'comment_post_ID'))
	}
	var_response = create_wp_ajax_response()
	rt.call_method(var_response, 'add', [
		rt.create_array_from_native_map(var_response_data),
	])
	rt.call_method(var_response, 'send', []rt.PhpVal{})
}

fn wp_ajax_edit_comment() {
	mut var_comment_id := rt.new_null()
	mut var_updated := rt.new_null()
	mut var_position := rt.new_null()
	mut var_checkbox := i64(0)
	mut var_wp_list_table := rt.new_null()
	mut var_comment := rt.new_null()
	mut var_comment_list_item := rt.new_null()
	mut var_response := rt.new_null()
	rt.call_function('check_ajax_referer', [rt.new_string('replyto-comment'),
		rt.new_string('_ajax_nonce-replyto-comment')])
	var_comment_id =
		rt.new_int((rt.get_superglobal('_POST').array_get(rt.new_string('comment_ID'))).to_i64())
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('edit_comment'),
		var_comment_id.clone(),
	])))))
	{
		rt.call_function('wp_die', [rt.new_int(-1)])
	}
	if rt.is_true(rt.identical(rt.new_string(''),
		rt.get_superglobal('_POST').array_get(rt.new_string('content'))))
	{
		rt.call_function('wp_die', [
			rt.call_function('__', [rt.new_string('Please type your comment text.')]),
		])
	}
	if rt.get_superglobal('_POST').array_isset(rt.new_string('status')) {
		rt.get_superglobal('_POST').array_set('comment_status',
			rt.get_superglobal('_POST').array_get(rt.new_string('status')))
	}
	var_updated = rt.call_function('edit_comment', []rt.PhpVal{})
	if rt.is_true(rt.call_function('is_wp_error', [var_updated.clone()])) {
		rt.call_function('wp_die', [
			rt.call_method(var_updated, 'get_error_message', []rt.PhpVal{}),
		])
	}
	var_position = if rt.get_superglobal('_POST').array_isset(rt.new_string('position'))
		&& rt.is_true(rt.new_int((rt.get_superglobal('_POST').array_get(rt.new_string('position'))).to_i64())) {
		rt.new_int((rt.get_superglobal('_POST').array_get(rt.new_string('position'))).to_i64())
	} else {
		rt.new_string('-1')
	}
	var_checkbox = if rt.get_superglobal('_POST').array_isset(rt.new_string('checkbox'))
		&& rt.is_true(rt.identical(rt.new_string('1'), rt.get_superglobal('_POST').array_get(rt.new_string('checkbox')))) {
		1
	} else {
		0
	}
	var_wp_list_table = rt.call_function('_get_list_table', [
		rt.new_string((if var_checkbox != 0 {
			'WP_Comments_List_Table'
		} else {
			'WP_Post_Comments_List_Table'
		}).str()),
		rt.create_array([rt.ArrayItem{ key: 'screen', val: 'edit-comments' }]),
	])
	var_comment = rt.call_function('get_comment', [var_comment_id.clone()])
	if !rt.is_true(rt.get_property(var_comment, 'comment_ID')) {
		rt.call_function('wp_die', [rt.new_int(-1)])
	}
	rt.call_function('ob_start', []rt.PhpVal{})
	rt.call_method(var_wp_list_table, 'single_row', [var_comment.clone()])
	var_comment_list_item = rt.call_function('ob_get_clean', []rt.PhpVal{})
	var_response = create_wp_ajax_response()
	rt.call_method(var_response, 'add', [
		rt.create_array([rt.ArrayItem{ key: 'what', val: 'edit_comment' },
			rt.ArrayItem{ key: 'id', val: rt.get_property(var_comment, 'comment_ID') },
			rt.ArrayItem{ key: 'data', val: var_comment_list_item },
			rt.ArrayItem{ key: 'position', val: var_position }]),
	])
	rt.call_method(var_response, 'send', []rt.PhpVal{})
}

fn wp_ajax_add_menu_item() {
	mut var_menu_items_data := []rt.PhpVal{}
	mut var_menu_item_data := map[string]rt.PhpVal{}
	mut var__object := rt.new_null()
	mut var__menu_items := rt.new_null()
	mut var__menu_item := rt.new_null()
	mut var_item_ids := rt.new_null()
	mut var_menu_items := []rt.PhpVal{}
	mut var_menu_item_id := rt.new_null()
	mut var_menu_object := rt.new_null()
	mut var_walker_class_name := rt.new_null()
	mut var_args := rt.new_null()
	rt.call_function('check_ajax_referer', [rt.new_string('add-menu_item'),
		rt.new_string('menu-settings-column-nonce')])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('edit_theme_options'),
	])))))
	{
		rt.call_function('wp_die', [rt.new_int(-1)])
	}
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/nav-menu.php', '4')
	var_menu_items_data = rt.new_array()
	mut iter_6 :=
		rt.cast_array(rt.get_superglobal('_POST').array_get(rt.new_string('menu-item'))).iterator()
	for {
		item_6 := iter_6.next() or { break }
		mut var_menu_item_data_shadow := item_6.val
		if !(!rt.is_true(var_menu_item_data_shadow['menu-item-type']))
			&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('custom'), var_menu_item_data_shadow['menu-item-type']))))
			&& !(!rt.is_true(var_menu_item_data_shadow['menu-item-object-id'])) {
			mut switch_val_2 := var_menu_item_data_shadow['menu-item-type']
			if rt.is_true(rt.equal(switch_val_2, rt.new_string('post_type'))) {
				var__object = rt.call_function('get_post',
					[var_menu_item_data_shadow['menu-item-object-id']])
			} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('post_type_archive'))) {
				var__object = rt.call_function('get_post_type_object', [
					var_menu_item_data_shadow['menu-item-object'],
				])
			} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('taxonomy'))) {
				var__object = rt.call_function('get_term', [var_menu_item_data_shadow['menu-item-object-id'],
					var_menu_item_data_shadow['menu-item-object']])
			}
			var__menu_items = rt.call_function('array_map', [
				rt.new_string('wp_setup_nav_menu_item'),
				rt.create_array([rt.ArrayItem{ key: none, val: var__object }]),
			])
			var__menu_item = rt.call_function('reset', [var__menu_items.clone()])
			var_menu_item_data_shadow['menu-item-description'] = rt.get_property(var__menu_item,
				'description')
		}
		var_menu_items_data << var_menu_item_data_shadow.clone()
	}
	var_item_ids = rt.call_function('wp_save_nav_menu_items', [
		rt.new_int(0), rt.create_array_from_list(var_menu_items_data)])
	if rt.is_true(rt.call_function('is_wp_error', [var_item_ids.clone()])) {
		rt.call_function('wp_die', [rt.new_int(0)])
	}
	var_menu_items = rt.new_array()
	mut iter_7 := rt.cast_array(var_item_ids).iterator()
	for {
		item_7 := iter_7.next() or { break }
		mut var_menu_item_id_shadow := item_7.val
		var_menu_object = rt.call_function('get_post', [var_menu_item_id_shadow.clone()])
		if !(!rt.is_true(rt.get_property(var_menu_object, 'ID'))) {
			var_menu_object = rt.call_function('wp_setup_nav_menu_item', [
				var_menu_object.clone()])
			rt.set_property(var_menu_object, 'title', if !rt.is_true(rt.get_property(var_menu_object, 'title')) { rt.call_function('__', [
					rt.new_string('Menu Item'),
				]) } else { rt.get_property(var_menu_object, 'title') })
			rt.set_property(var_menu_object, 'label', rt.get_property(var_menu_object, 'title'))
			var_menu_items << var_menu_object.clone()
		}
	}
	var_walker_class_name = rt.call_function('apply_filters', [
		rt.new_string('wp_edit_nav_menu_walker'),
		rt.new_string('Walker_Nav_Menu_Edit'),
		rt.get_superglobal('_POST').array_get(rt.new_string('menu')),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [
		var_walker_class_name.clone()])))))
	{
		rt.call_function('wp_die', [rt.new_int(0)])
	}
	if !(!rt.is_true(var_menu_items)) {
		var_args = rt.create_array([rt.ArrayItem{ key: 'after', val: '' },
			rt.ArrayItem{ key: 'before', val: '' }, rt.ArrayItem{ key: 'link_after', val: '' },
			rt.ArrayItem{ key: 'link_before', val: '' }, rt.ArrayItem{ key: 'walker', val: rt.create_object_dynamically(var_walker_class_name,
				[]rt.PhpVal{}) }])
		rt.echo_val(rt.call_function('walk_nav_menu_tree', [
			rt.create_array_from_list(var_menu_items),
			rt.new_int(0),
			rt.array_to_object(var_args),
		]))
	}
	rt.call_function('wp_die', []rt.PhpVal{})
}

fn wp_ajax_add_meta() {
	mut var_c := rt.new_null()
	mut var_count := i64(0)
	mut var_post_id := rt.new_null()
	mut var_post := rt.new_null()
	mut var_post_data := rt.new_null()
	mut var_now := rt.new_null()
	mut var_response := rt.new_null()
	mut var_meta_id := rt.new_null()
	mut var_meta := rt.new_null()
	mut var_key := rt.new_null()
	mut var_value := rt.new_null()
	mut var_update_result := rt.new_null()
	rt.call_function('check_ajax_referer', [rt.new_string('add-meta'),
		rt.new_string('_ajax_nonce-add-meta')])
	var_count = 0
	var_post_id =
		rt.new_int((rt.get_superglobal('_POST').array_get(rt.new_string('post_id'))).to_i64())
	var_post = rt.call_function('get_post', [var_post_id.clone()])
	if rt.get_superglobal('_POST').array_isset(rt.new_string('metakeyselect'))
		|| rt.get_superglobal('_POST').array_isset(rt.new_string('metakeyinput')) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
			rt.new_string('edit_post'),
			var_post_id.clone(),
		])))))
		{
			rt.call_function('wp_die', [rt.new_int(-1)])
		}
		if rt.get_superglobal('_POST').array_isset(rt.new_string('metakeyselect'))
			&& rt.is_true(rt.identical(rt.new_string('#NONE#'), rt.get_superglobal('_POST').array_get(rt.new_string('metakeyselect'))))
			&& !rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('metakeyinput'))) {
			rt.call_function('wp_die', [rt.new_int(1)])
		}
		if rt.is_true(rt.identical(rt.new_string('auto-draft'), rt.get_property(var_post,
			'post_status')))
		{
			var_post_data = rt.new_array()
			var_post_data.array_set('action', 'draft')
			var_post_data.array_set('post_ID', var_post_id.clone())
			var_post_data.array_set('post_type', rt.get_property(var_post, 'post_type'))
			var_post_data.array_set('post_status', 'draft')
			var_now = rt.call_function('time', []rt.PhpVal{})
			var_post_data.array_set('post_title', rt.call_function('sprintf', [
				rt.call_function('__', [rt.new_string('Draft created on %1$s at %2$s')]),
				rt.call_function('gmdate', [rt.call_function('__', [
					rt.new_string('F j, Y'),
				]),
					var_now.clone()]),
				rt.call_function('gmdate', [rt.call_function('__', [
					rt.new_string('g:i a'),
				]),
					var_now.clone()]),
			]))
			var_post_id = rt.call_function('edit_post', [var_post_data.clone()])
			if rt.is_true(var_post_id) {
				if rt.is_true(rt.call_function('is_wp_error', [
					var_post_id.clone()]))
				{
					var_response = create_wp_ajax_response(rt.create_array([
						rt.ArrayItem{ key: 'what', val: 'meta' },
						rt.ArrayItem{ key: 'data', val: var_post_id },
					]))
					rt.call_method(var_response, 'send', []rt.PhpVal{})
				}
				var_meta_id = rt.call_function('add_meta', [var_post_id.clone()])
				if rt.is_true(rt.new_bool(!(rt.is_true(var_meta_id)))) {
					rt.call_function('wp_die', [
						rt.call_function('__', [
							rt.new_string('Please provide a custom field value.'),
						]),
					])
				}
			} else {
				rt.call_function('wp_die', [rt.new_int(0)])
			}
		} else {
			var_meta_id = rt.call_function('add_meta', [var_post_id.clone()])
			if rt.is_true(rt.new_bool(!(rt.is_true(var_meta_id)))) {
				rt.call_function('wp_die', [
					rt.call_function('__', [
						rt.new_string('Please provide a custom field value.'),
					]),
				])
			}
		}
		var_meta = rt.call_function('get_metadata_by_mid', [rt.new_string('post'),
			var_meta_id.clone()])
		var_post_id = rt.new_int((rt.get_property(var_meta, 'post_id')).to_i64())
		var_meta = rt.call_function('get_object_vars', [var_meta.clone()])
		var_response = create_wp_ajax_response(rt.create_array([
			rt.ArrayItem{ key: 'what', val: 'meta' },
			rt.ArrayItem{ key: 'id', val: var_meta_id },
			rt.ArrayItem{ key: 'data', val: rt.call_function('_list_meta_row', [
				var_meta.clone(),
				rt.new_int(var_count).clone(),
			]) },
			rt.ArrayItem{ key: 'position', val: 1 },
			rt.ArrayItem{ key: 'supplemental', val: rt.create_array([
				rt.ArrayItem{ key: 'postid', val: var_post_id },
			]) },
		]))
	} else {
		var_meta_id = rt.new_int((rt.call_function('key', [
			rt.get_superglobal('_POST').array_get(rt.new_string('meta')),
		])).to_i64())
		var_key = rt.call_function('wp_unslash',
			[rt.get_superglobal('_POST').array_get(rt.new_string('meta')).array_get(var_meta_id).array_get(rt.new_string('key'))])
		var_value = rt.call_function('wp_unslash',
			[rt.get_superglobal('_POST').array_get(rt.new_string('meta')).array_get(var_meta_id).array_get(rt.new_string('value'))])
		if rt.is_true(rt.identical(rt.new_string(''),
			rt.new_string(var_key.clone().to_string().trim_space())))
		{
			rt.call_function('wp_die', [
				rt.call_function('__', [
					rt.new_string('Please provide a custom field name.'),
				]),
			])
		}
		var_meta = rt.call_function('get_metadata_by_mid', [rt.new_string('post'),
			var_meta_id.clone()])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_meta)))) {
			rt.call_function('wp_die', [rt.new_int(0)])
		}
		if rt.is_true(rt.call_function('is_protected_meta', [rt.get_property(var_meta, 'meta_key'), rt.new_string('post')]))
			|| rt.is_true(rt.call_function('is_protected_meta', [var_key.clone(), rt.new_string('post')]))
			|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_post_meta'), rt.get_property(var_meta, 'post_id'), rt.get_property(var_meta, 'meta_key')])))))
			|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_post_meta'), rt.get_property(var_meta, 'post_id'), var_key.clone()]))))) {
			rt.call_function('wp_die', [rt.new_int(-1)])
		}
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.get_property(var_meta, 'meta_value'), var_value))))
			|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.get_property(var_meta, 'meta_key'), var_key)))) {
			var_update_result = rt.call_function('update_metadata_by_mid', [
				rt.new_string('post'),
				var_meta_id.clone(),
				var_value.clone(),
				var_key.clone(),
			])
			if rt.is_true(rt.new_bool(!(rt.is_true(var_update_result)))) {
				rt.call_function('wp_die', [rt.new_int(0)])
			}
		}
		var_response = create_wp_ajax_response(rt.create_array([
			rt.ArrayItem{ key: 'what', val: 'meta' },
			rt.ArrayItem{ key: 'id', val: var_meta_id },
			rt.ArrayItem{ key: 'old_id', val: var_meta_id },
			rt.ArrayItem{ key: 'data', val: rt.call_function('_list_meta_row', [
				rt.create_array([rt.ArrayItem{ key: 'meta_key', val: var_key },
					rt.ArrayItem{ key: 'meta_value', val: var_value },
					rt.ArrayItem{ key: 'meta_id', val: var_meta_id }]),
				var_c.clone(),
			]) },
			rt.ArrayItem{ key: 'position', val: 0 },
			rt.ArrayItem{ key: 'supplemental', val: rt.create_array([
				rt.ArrayItem{ key: 'postid', val: rt.get_property(var_meta, 'post_id') },
			]) },
		]))
	}
	rt.call_method(var_response, 'send', []rt.PhpVal{})
}

fn wp_ajax_add_user(var_action_arg rt.PhpVal) {
	mut var_action := var_action_arg
	mut var_user_id := rt.new_null()
	mut var_response := rt.new_null()
	mut var_user_object := rt.new_null()
	mut var_wp_list_table := rt.new_null()
	mut var_role := rt.new_null()
	if var_action == '' {
		var_action = 'add-user'
	}
	rt.call_function('check_ajax_referer', [rt.new_string(var_action.str()).clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('create_users'),
	])))))
	{
		rt.call_function('wp_die', [rt.new_int(-1)])
	}
	var_user_id = rt.call_function('edit_user', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(var_user_id)))) {
		rt.call_function('wp_die', [rt.new_int(0)])
	} else if rt.is_true(rt.call_function('is_wp_error', [var_user_id.clone()])) {
		var_response = create_wp_ajax_response(rt.create_array([
			rt.ArrayItem{ key: 'what', val: 'user' },
			rt.ArrayItem{ key: 'id', val: var_user_id },
		]))
		rt.call_method(var_response, 'send', []rt.PhpVal{})
	}
	var_user_object = rt.call_function('get_userdata', [var_user_id.clone()])
	var_wp_list_table = rt.call_function('_get_list_table', [
		rt.new_string('WP_Users_List_Table'),
	])
	var_role = rt.call_function('current', [rt.get_property(var_user_object, 'roles')])
	var_response = create_wp_ajax_response(rt.create_array([
		rt.ArrayItem{ key: 'what', val: 'user' },
		rt.ArrayItem{ key: 'id', val: var_user_id },
		rt.ArrayItem{ key: 'data', val: rt.call_method(var_wp_list_table, 'single_row', [
			var_user_object.clone(),
			rt.new_string(''),
			var_role.clone(),
		]) },
		rt.ArrayItem{ key: 'supplemental', val: rt.create_array([
			rt.ArrayItem{ key: 'show-link', val: rt.call_function('sprintf', [
				rt.call_function('__', [rt.new_string('User %s added')]),
				rt.new_string('<a href="#user-' + var_user_id.str() + '">' +
					(rt.get_property(var_user_object, 'user_login')).str() + '</a>'),
			]) },
			rt.ArrayItem{ key: 'role', val: var_role },
		]) },
	]))
	rt.call_method(var_response, 'send', []rt.PhpVal{})
}

fn wp_ajax_closed_postboxes() {
	mut var_closed := rt.new_null()
	mut var_hidden := rt.new_null()
	mut var_page := rt.new_null()
	mut var_user := rt.new_null()
	rt.call_function('check_ajax_referer', [rt.new_string('closedpostboxes'),
		rt.new_string('closedpostboxesnonce')])
	var_closed = if rt.get_superglobal('_POST').array_isset(rt.new_string('closed')) { rt.call_function('explode', [
			rt.new_string(','),
			rt.get_superglobal('_POST').array_get(rt.new_string('closed')),
		]) } else { rt.new_array() }
	var_closed = rt.call_function('array_filter', [var_closed.clone()])
	var_hidden = if rt.get_superglobal('_POST').array_isset(rt.new_string('hidden')) { rt.call_function('explode', [
			rt.new_string(','),
			rt.get_superglobal('_POST').array_get(rt.new_string('hidden')),
		]) } else { rt.new_array() }
	var_hidden = rt.call_function('array_filter', [var_hidden.clone()])
	var_page = if !(rt.get_superglobal('_POST').array_get(rt.new_string('page'))).is_null() {
		rt.get_superglobal('_POST').array_get(rt.new_string('page'))
	} else {
		rt.new_string('')
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('sanitize_key', [
		var_page.clone(),
	]), var_page))))
	{
		rt.call_function('wp_die', [rt.new_int(0)])
	}
	var_user = rt.call_function('wp_get_current_user', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(var_user)))) {
		rt.call_function('wp_die', [rt.new_int(-1)])
	}
	if rt.is_true(rt.new_bool(var_closed.clone().is_array())) {
		rt.call_function('update_user_meta', [rt.get_property(var_user, 'ID'),
			rt.new_string('closedpostboxes_${var_page.to_string()}'),
			var_closed.clone()])
	}
	if rt.is_true(rt.new_bool(var_hidden.clone().is_array())) {
		var_hidden = rt.call_function('array_diff', [var_hidden.clone(),
			rt.create_array([rt.ArrayItem{ key: none, val: 'submitdiv' },
				rt.ArrayItem{ key: none, val: 'linksubmitdiv' },
				rt.ArrayItem{ key: none, val: 'manage-menu' },
				rt.ArrayItem{ key: none, val: 'create-menu' }])])
		rt.call_function('update_user_meta', [rt.get_property(var_user, 'ID'),
			rt.new_string('metaboxhidden_${var_page.to_string()}'),
			var_hidden.clone()])
	}
	rt.call_function('wp_die', [rt.new_int(1)])
}

fn wp_ajax_hidden_columns() {
	mut var_page := rt.new_null()
	mut var_user := rt.new_null()
	mut var_hidden := rt.new_null()
	rt.call_function('check_ajax_referer', [rt.new_string('screen-options-nonce'),
		rt.new_string('screenoptionnonce')])
	var_page = if !(rt.get_superglobal('_POST').array_get(rt.new_string('page'))).is_null() {
		rt.get_superglobal('_POST').array_get(rt.new_string('page'))
	} else {
		rt.new_string('')
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('sanitize_key', [
		var_page.clone(),
	]), var_page))))
	{
		rt.call_function('wp_die', [rt.new_int(0)])
	}
	var_user = rt.call_function('wp_get_current_user', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(var_user)))) {
		rt.call_function('wp_die', [rt.new_int(-1)])
	}
	var_hidden = if !(!rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('hidden')))) { rt.call_function('explode', [
			rt.new_string(','),
			rt.get_superglobal('_POST').array_get(rt.new_string('hidden')),
		]) } else { rt.new_array() }
	rt.call_function('update_user_meta', [rt.get_property(var_user, 'ID'),
		rt.new_string('manage${var_page.to_string()}columnshidden'),
		var_hidden.clone()])
	rt.call_function('wp_die', [rt.new_int(1)])
}

fn wp_ajax_update_welcome_panel() {
	rt.call_function('check_ajax_referer', [rt.new_string('welcome-panel-nonce'),
		rt.new_string('welcomepanelnonce')])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('edit_theme_options'),
	])))))
	{
		rt.call_function('wp_die', [rt.new_int(-1)])
	}
	rt.call_function('update_user_meta', [
		rt.call_function('get_current_user_id', []rt.PhpVal{}),
		rt.new_string('show_welcome_panel'),
		rt.new_int(if !rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('visible'))) {
			0
		} else {
			1
		}),
	])
	rt.call_function('wp_die', [rt.new_int(1)])
}

fn wp_ajax_menu_get_metabox() {
	mut var_type := ''
	mut var_callback := ''
	mut var_items := rt.new_null()
	mut var_menus_meta_box_object := rt.new_null()
	mut var_item := rt.new_null()
	mut var_box_args := map[string]rt.PhpVal{}
	mut var_markup := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('edit_theme_options'),
	])))))
	{
		rt.call_function('wp_die', [rt.new_int(-1)])
	}
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/nav-menu.php', '4')
	if rt.get_superglobal('_POST').array_isset(rt.new_string('item-type'))
		&& rt.is_true(rt.identical(rt.new_string('post_type'), rt.get_superglobal('_POST').array_get(rt.new_string('item-type')))) {
		var_type = 'posttype'
		var_callback = 'wp_nav_menu_item_post_type_meta_box'
		var_items = rt.cast_array(rt.call_function('get_post_types', [
			rt.create_array([rt.ArrayItem{ key: 'show_in_nav_menus', val: true }]),
			rt.new_string('object'),
		]))
	} else if rt.get_superglobal('_POST').array_isset(rt.new_string('item-type'))
		&& rt.is_true(rt.identical(rt.new_string('taxonomy'), rt.get_superglobal('_POST').array_get(rt.new_string('item-type')))) {
		var_type = 'taxonomy'
		var_callback = 'wp_nav_menu_item_taxonomy_meta_box'
		var_items = rt.cast_array(rt.call_function('get_taxonomies', [
			rt.create_array([rt.ArrayItem{ key: 'show_ui', val: true }]),
			rt.new_string('object'),
		]))
	}
	if !(!rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('item-object'))))
		&& var_items.array_isset(rt.get_superglobal('_POST').array_get(rt.new_string('item-object'))) {
		var_menus_meta_box_object =
			var_items.array_get(rt.get_superglobal('_POST').array_get(rt.new_string('item-object')))
		var_item = rt.call_function('apply_filters', [
			rt.new_string('nav_menu_meta_box_object'),
			var_menus_meta_box_object.clone(),
		])
		var_box_args = {
			'id':       'add-' + (rt.get_property(var_item, 'name')).str()
			'title':    rt.get_property(rt.get_property(var_item, 'labels'), 'name')
			'callback': rt.new_string(var_callback.str())
			'args':     var_item
		}
		rt.call_function('ob_start', []rt.PhpVal{})
		rt.call_callable(rt.new_string(var_callback.str()), [
			rt.new_null(), rt.create_array_from_native_map(var_box_args)])
		var_markup = rt.call_function('ob_get_clean', []rt.PhpVal{})
		rt.echo_val(rt.call_function('wp_json_encode', [
			rt.create_array([
				rt.ArrayItem{ key: 'replace-id', val: var_type + '-' +
					(rt.get_property(var_item, 'name')).str() },
				rt.ArrayItem{ key: 'markup', val: var_markup },
			]),
		]))
	}
	rt.call_function('wp_die', []rt.PhpVal{})
}

fn wp_ajax_wp_link_ajax() {
	mut var_args := rt.new_null()
	mut var_results := rt.new_null()
	rt.call_function('check_ajax_referer', [rt.new_string('internal-linking'),
		rt.new_string('_ajax_linking_nonce')])
	var_args = rt.new_array()
	if rt.get_superglobal('_POST').array_isset(rt.new_string('search')) {
		var_args.array_set('s', rt.call_function('wp_unslash', [
			rt.get_superglobal('_POST').array_get(rt.new_string('search')),
		]))
	}
	if rt.get_superglobal('_POST').array_isset(rt.new_string('term')) {
		var_args.array_set('s', rt.call_function('wp_unslash', [
			rt.get_superglobal('_POST').array_get(rt.new_string('term')),
		]))
	}
	var_args.array_set('pagenum', if !(!rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('page')))) { rt.call_function('absint', [
			rt.get_superglobal('_POST').array_get(rt.new_string('page')),
		]) } else { rt.new_int(1) })
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [
		rt.new_string('_WP_Editors'),
		rt.new_bool(false),
	])))))
	{
		rt.include_file(
			(rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/class-wp-editor.php',
			'3')
	}
	mut iife_temp_0 := Class__WP_Editors{}
	mut iife_result_0 := iife_temp_0.wp_link_query(var_args.clone())
	var_results = iife_result_0
	if !(!var_results.is_null()) {
		rt.call_function('wp_die', [rt.new_int(0)])
	}
	rt.echo_val(rt.call_function('wp_json_encode', [var_results.clone()]))
	print('\n')
	rt.call_function('wp_die', []rt.PhpVal{})
}

fn wp_ajax_menu_locations_save() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('edit_theme_options'),
	])))))
	{
		rt.call_function('wp_die', [rt.new_int(-1)])
	}
	rt.call_function('check_ajax_referer', [rt.new_string('add-menu_item'),
		rt.new_string('menu-settings-column-nonce')])
	if !(rt.get_superglobal('_POST').array_isset(rt.new_string('menu-locations'))) {
		rt.call_function('wp_die', [rt.new_int(0)])
	}
	rt.call_function('set_theme_mod', [rt.new_string('nav_menu_locations'),
		rt.call_function('array_map', [rt.new_string('absint'),
			rt.get_superglobal('_POST').array_get(rt.new_string('menu-locations'))])])
	rt.call_function('wp_die', [rt.new_int(1)])
}

fn wp_ajax_meta_box_order() {
	mut var_order := rt.new_null()
	mut var_page_columns := rt.new_null()
	mut var_page := rt.new_null()
	mut var_user := rt.new_null()
	rt.call_function('check_ajax_referer', [rt.new_string('meta-box-order')])
	var_order = if rt.get_superglobal('_POST').array_isset(rt.new_string('order')) {
		rt.cast_array(rt.get_superglobal('_POST').array_get(rt.new_string('order')))
	} else {
		rt.new_bool(false)
	}
	var_page_columns = if !(rt.get_superglobal('_POST').array_get(rt.new_string('page_columns'))).is_null() {
		rt.get_superglobal('_POST').array_get(rt.new_string('page_columns'))
	} else {
		rt.new_string('auto')
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('auto'), var_page_columns)))) {
		var_page_columns = rt.new_int(var_page_columns.to_i64())
	}
	var_page = if !(rt.get_superglobal('_POST').array_get(rt.new_string('page'))).is_null() {
		rt.get_superglobal('_POST').array_get(rt.new_string('page'))
	} else {
		rt.new_string('')
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('sanitize_key', [
		var_page.clone(),
	]), var_page))))
	{
		rt.call_function('wp_die', [rt.new_int(0)])
	}
	var_user = rt.call_function('wp_get_current_user', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(var_user)))) {
		rt.call_function('wp_die', [rt.new_int(-1)])
	}
	if rt.is_true(var_order) {
		rt.call_function('update_user_meta', [rt.get_property(var_user, 'ID'),
			rt.new_string('meta-box-order_${var_page.to_string()}'),
			var_order.clone()])
	}
	if rt.is_true(var_page_columns) {
		rt.call_function('update_user_meta', [rt.get_property(var_user, 'ID'),
			rt.new_string('screen_layout_${var_page.to_string()}'),
			var_page_columns.clone()])
	}
	rt.call_function('wp_send_json_success', []rt.PhpVal{})
}

fn wp_ajax_menu_quick_search() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('edit_theme_options'),
	])))))
	{
		rt.call_function('wp_die', [rt.new_int(-1)])
	}
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/nav-menu.php', '4')
	rt.call_function('_wp_ajax_menu_quick_search', [rt.get_superglobal('_POST').clone()])
	rt.call_function('wp_die', []rt.PhpVal{})
}

fn wp_ajax_get_permalink() {
	mut var_post_id := rt.new_null()
	rt.call_function('check_ajax_referer', [rt.new_string('getpermalink'),
		rt.new_string('getpermalinknonce')])
	var_post_id = rt.new_int(if rt.get_superglobal('_POST').array_isset(rt.new_string('post_id')) {
		rt.new_int((rt.get_superglobal('_POST').array_get(rt.new_string('post_id'))).to_i64())
	} else {
		0
	})
	rt.call_function('wp_die', [
		rt.call_function('get_preview_post_link', [var_post_id.clone()]),
	])
}

fn wp_ajax_sample_permalink() {
	mut var_post_id := rt.new_null()
	mut var_title := rt.new_null()
	mut var_slug := rt.new_null()
	rt.call_function('check_ajax_referer', [rt.new_string('samplepermalink'),
		rt.new_string('samplepermalinknonce')])
	var_post_id = rt.new_int(if rt.get_superglobal('_POST').array_isset(rt.new_string('post_id')) {
		rt.new_int((rt.get_superglobal('_POST').array_get(rt.new_string('post_id'))).to_i64())
	} else {
		0
	})
	var_title = if !(rt.get_superglobal('_POST').array_get(rt.new_string('new_title'))).is_null() {
		rt.get_superglobal('_POST').array_get(rt.new_string('new_title'))
	} else {
		rt.new_string('')
	}
	var_slug = if !(rt.get_superglobal('_POST').array_get(rt.new_string('new_slug'))).is_null() {
		rt.get_superglobal('_POST').array_get(rt.new_string('new_slug'))
	} else {
		rt.new_null()
	}
	rt.call_function('wp_die', [
		rt.call_function('get_sample_permalink_html', [var_post_id.clone(),
			var_title.clone(), var_slug.clone()]),
	])
}

fn wp_ajax_inline_save() {
	mut var_data := rt.new_null()
	mut var_post_id := rt.new_null()
	mut var_last := rt.new_null()
	mut var_last_user := rt.new_null()
	mut var_last_user_name := rt.new_null()
	mut var_msg_template := rt.new_null()
	mut var_post := rt.new_null()
	mut var_terms := rt.new_null()
	mut var_taxonomy := rt.new_null()
	mut var_tax_object := rt.new_null()
	mut var_wp_list_table := rt.new_null()
	mut var_mode := ''
	mut var_level := i64(0)
	mut var_request_post := []rt.PhpVal{}
	mut var_parent := rt.new_null()
	mut var_parent_post := rt.new_null()
	rt.call_function('check_ajax_referer', [rt.new_string('inlineeditnonce'),
		rt.new_string('_inline_edit')])
	if !(rt.get_superglobal('_POST').array_isset(rt.new_string('post_ID')))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.new_int((rt.get_superglobal('_POST').array_get(rt.new_string('post_ID'))).to_i64()))))) {
		rt.call_function('wp_die', []rt.PhpVal{})
	}
	var_post_id =
		rt.new_int((rt.get_superglobal('_POST').array_get(rt.new_string('post_ID'))).to_i64())
	if rt.is_true(rt.identical(rt.new_string('page'),
		rt.get_superglobal('_POST').array_get(rt.new_string('post_type'))))
	{
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
			rt.new_string('edit_page'),
			var_post_id.clone(),
		])))))
		{
			rt.call_function('wp_die', [
				rt.call_function('__', [
					rt.new_string('Sorry, you are not allowed to edit this page.'),
				]),
			])
		}
	} else {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
			rt.new_string('edit_post'),
			var_post_id.clone(),
		])))))
		{
			rt.call_function('wp_die', [
				rt.call_function('__', [
					rt.new_string('Sorry, you are not allowed to edit this post.'),
				]),
			])
		}
	}
	var_last = rt.call_function('wp_check_post_lock', [var_post_id.clone()])
	if rt.is_true(var_last) {
		var_last_user = rt.call_function('get_userdata', [var_last.clone()])
		var_last_user_name = if rt.is_true(var_last_user) { rt.get_property(var_last_user, 'display_name') } else { rt.call_function('__', [
				rt.new_string('Someone'),
			]) }
		var_msg_template = rt.call_function('__', [
			rt.new_string('Saving is disabled: %s is currently editing this post.'),
		])
		if rt.is_true(rt.identical(rt.new_string('page'),
			rt.get_superglobal('_POST').array_get(rt.new_string('post_type'))))
		{
			var_msg_template = rt.call_function('__', [
				rt.new_string('Saving is disabled: %s is currently editing this page.'),
			])
		}
		rt.call_function('printf', [var_msg_template.clone(),
			rt.call_function('esc_html', [var_last_user_name.clone()])])
		rt.call_function('wp_die', []rt.PhpVal{})
	}
	var_data = rt.get_superglobal('_POST')
	var_post = rt.call_function('get_post', [var_post_id.clone(),
		rt.get_constant('ARRAY_A')])
	var_post = rt.call_function('wp_slash', [var_post.clone()])
	var_data.array_set('content', var_post.array_get(rt.new_string('post_content')))
	var_data.array_set('excerpt', var_post.array_get(rt.new_string('post_excerpt')))
	var_data.array_set('user_ID', rt.call_function('get_current_user_id', []rt.PhpVal{}))
	if var_data.array_isset(rt.new_string('post_parent')) {
		var_data.array_set('parent_id', var_data.array_get(rt.new_string('post_parent')))
	}
	if var_data.array_isset(rt.new_string('keep_private'))
		&& rt.is_true(rt.identical(rt.new_string('private'), var_data.array_get(rt.new_string('keep_private')))) {
		var_data.array_set('visibility', 'private')
		var_data.array_set('post_status', 'private')
	} else if var_data.array_isset(rt.new_string('_status')) {
		var_data.array_set('post_status', var_data.array_get(rt.new_string('_status')))
	}
	if !rt.is_true(var_data.array_get(rt.new_string('comment_status'))) {
		var_data.array_set('comment_status', 'closed')
	}
	if !rt.is_true(var_data.array_get(rt.new_string('ping_status'))) {
		var_data.array_set('ping_status', 'closed')
	}
	if !(!rt.is_true(var_data.array_get(rt.new_string('tax_input')))) {
		mut iter_8 := var_data.array_get(rt.new_string('tax_input')).iterator()
		for {
			item_8 := iter_8.next() or { break }
			mut var_terms_shadow := item_8.val
			mut var_taxonomy_shadow := item_8.key
			var_tax_object = rt.call_function('get_taxonomy', [
				var_taxonomy_shadow.clone()])
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('apply_filters', [
				rt.new_string('quick_edit_show_taxonomy'),
				rt.get_property(var_tax_object, 'show_in_quick_edit'),
				var_taxonomy_shadow.clone(),
				var_post.array_get(rt.new_string('post_type')),
			])))))
			{
				var_data.array_get(rt.new_string('tax_input')).array_unset(var_taxonomy_shadow)
			}
		}
	}
	if !(!rt.is_true(var_data.array_get(rt.new_string('post_name'))))
		&& rt.is_true(rt.call_function('in_array', [var_post.array_get(rt.new_string('post_status')), rt.create_array([rt.ArrayItem{
		key: none
		val: 'draft'
	}, rt.ArrayItem{ key: none, val: 'pending' }]), rt.new_bool(true)])) {
		var_post.array_set('post_status', 'publish')
		var_data.array_set('post_name', rt.call_function('wp_unique_post_slug', [
			var_data.array_get(rt.new_string('post_name')),
			var_post.array_get(rt.new_string('ID')),
			var_post.array_get(rt.new_string('post_status')),
			var_post.array_get(rt.new_string('post_type')),
			var_post.array_get(rt.new_string('post_parent')),
		]))
	}
	rt.call_function('edit_post', []rt.PhpVal{})
	var_wp_list_table = rt.call_function('_get_list_table', [
		rt.new_string('WP_Posts_List_Table'),
		rt.create_array([
			rt.ArrayItem{
				key: 'screen'
				val: rt.get_superglobal('_POST').array_get(rt.new_string('screen'))
			},
		]),
	])
	var_mode = if rt.is_true(rt.identical(rt.new_string('excerpt'),
		rt.get_superglobal('_POST').array_get(rt.new_string('post_view'))))
	{
		'excerpt'
	} else {
		'list'
	}
	var_level = 0
	if rt.is_true(rt.call_function('is_post_type_hierarchical', [
		rt.get_property(rt.get_property(var_wp_list_table, 'screen'), 'post_type'),
	]))
	{
		var_request_post = [
			rt.call_function('get_post',
				[rt.get_superglobal('_POST').array_get(rt.new_string('post_ID'))]),
		]
		var_parent = rt.get_property(var_request_post[0], 'post_parent')
		for rt.is_true(rt.greater(var_parent, rt.new_int(0))) {
			var_parent_post = rt.call_function('get_post', [var_parent.clone()])
			var_parent = rt.get_property(var_parent_post, 'post_parent')
			var_level += 1
		}
	}
	rt.call_method(var_wp_list_table, 'display_rows', [
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.call_function('get_post', [
				rt.get_superglobal('_POST').array_get(rt.new_string('post_ID')),
			]) },
		]),
		rt.new_int(var_level).clone(),
	])
	rt.call_function('wp_die', []rt.PhpVal{})
}

fn wp_ajax_inline_save_tax() {
	mut var_taxonomy := rt.new_null()
	mut var_taxonomy_object := rt.new_null()
	mut var_id := rt.new_null()
	mut var_wp_list_table := rt.new_null()
	mut var_tag := rt.new_null()
	mut var_updated := rt.new_null()
	mut var_level := i64(0)
	mut var_parent := rt.new_null()
	mut var_parent_tag := rt.new_null()
	rt.call_function('check_ajax_referer', [rt.new_string('taxinlineeditnonce'),
		rt.new_string('_inline_edit')])
	var_taxonomy = rt.call_function('sanitize_key', [
		rt.get_superglobal('_POST').array_get(rt.new_string('taxonomy')),
	])
	var_taxonomy_object = rt.call_function('get_taxonomy', [var_taxonomy.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_taxonomy_object)))) {
		rt.call_function('wp_die', [rt.new_int(0)])
	}
	if !(rt.get_superglobal('_POST').array_isset(rt.new_string('tax_ID')))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.new_int((rt.get_superglobal('_POST').array_get(rt.new_string('tax_ID'))).to_i64()))))) {
		rt.call_function('wp_die', [rt.new_int(-1)])
	}
	var_id = rt.new_int((rt.get_superglobal('_POST').array_get(rt.new_string('tax_ID'))).to_i64())
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('edit_term'),
		var_id.clone(),
	])))))
	{
		rt.call_function('wp_die', [rt.new_int(-1)])
	}
	var_wp_list_table = rt.call_function('_get_list_table', [
		rt.new_string('WP_Terms_List_Table'),
		rt.create_array([
			rt.ArrayItem{ key: 'screen', val: 'edit-' + var_taxonomy.str() },
		]),
	])
	var_tag = rt.call_function('get_term', [var_id.clone(), var_taxonomy.clone()])
	rt.get_superglobal('_POST').array_set('description', rt.get_property(var_tag, 'description'))
	var_updated = rt.call_function('wp_update_term', [var_id.clone(),
		var_taxonomy.clone(), rt.get_superglobal('_POST').clone()])
	if rt.is_true(var_updated)
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_updated.clone()]))))) {
		var_tag = rt.call_function('get_term', [var_updated.array_get(rt.new_string('term_id')),
			var_taxonomy.clone()])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_tag))))
			|| rt.is_true(rt.call_function('is_wp_error', [var_tag.clone()])) {
			if rt.is_true(rt.call_function('is_wp_error', [var_tag.clone()]))
				&& rt.is_true(rt.call_method(var_tag, 'get_error_message', []rt.PhpVal{})) {
				rt.call_function('wp_die', [
					rt.call_method(var_tag, 'get_error_message', []rt.PhpVal{}),
				])
			}
			rt.call_function('wp_die', [
				rt.call_function('__', [rt.new_string('Item not updated.')]),
			])
		}
	} else {
		if rt.is_true(rt.call_function('is_wp_error', [var_updated.clone()]))
			&& rt.is_true(rt.call_method(var_updated, 'get_error_message', []rt.PhpVal{})) {
			rt.call_function('wp_die', [
				rt.call_method(var_updated, 'get_error_message', []rt.PhpVal{}),
			])
		}
		rt.call_function('wp_die', [
			rt.call_function('__', [rt.new_string('Item not updated.')]),
		])
	}
	var_level = 0
	var_parent = rt.get_property(var_tag, 'parent')
	for rt.is_true(rt.greater(var_parent, rt.new_int(0))) {
		var_parent_tag = rt.call_function('get_term', [var_parent.clone(),
			var_taxonomy.clone()])
		var_parent = rt.get_property(var_parent_tag, 'parent')
		var_level += 1
	}
	rt.call_method(var_wp_list_table, 'single_row', [var_tag.clone(),
		rt.new_int(var_level).clone()])
	rt.call_function('wp_die', []rt.PhpVal{})
}

fn wp_ajax_find_posts() {
	mut var_post_types := rt.new_null()
	mut var_args := rt.new_null()
	mut var_search := rt.new_null()
	mut var_posts := rt.new_null()
	mut var_html := rt.new_null()
	mut var_alternate := ''
	mut var_post := rt.new_null()
	mut var_title := rt.new_null()
	mut var_stat := rt.new_null()
	mut var_time := rt.new_null()
	rt.call_function('check_ajax_referer', [rt.new_string('find-posts')])
	var_post_types = rt.call_function('get_post_types', [
		rt.create_array([rt.ArrayItem{ key: 'public', val: true }]),
		rt.new_string('objects'),
	])
	var_post_types.array_unset(rt.new_string('attachment'))
	var_args = rt.create_array([
		rt.ArrayItem{ key: 'post_type', val: rt.func_array_keys(var_post_types.clone()) },
		rt.ArrayItem{ key: 'post_status', val: 'any' },
		rt.ArrayItem{ key: 'posts_per_page', val: 50 },
	])
	var_search = rt.call_function('wp_unslash',
		[rt.get_superglobal('_POST').array_get(rt.new_string('ps'))])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), var_search)))) {
		var_args.array_set('s', var_search.clone())
	}
	var_posts = rt.call_function('get_posts', [var_args.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_posts)))) {
		rt.call_function('wp_send_json_error', [
			rt.call_function('__', [rt.new_string('No items found.')]),
		])
	}
	var_html = rt.new_string(
		'<table class="widefat"><thead><tr><th class="found-radio"><br /></th><th>' +
		(rt.call_function('__', [rt.new_string('Title')])).str() + '</th><th class="no-break">' +
		(rt.call_function('__', [rt.new_string('Type')])).str() + '</th><th class="no-break">' +
		(rt.call_function('__', [rt.new_string('Date')])).str() + '</th><th class="no-break">' +
		(rt.call_function('__', [rt.new_string('Status')])).str() + '</th></tr></thead><tbody>')
	var_alternate = ''
	mut iter_9 := var_posts.iterator()
	for {
		item_9 := iter_9.next() or { break }
		mut var_post_shadow := item_9.val
		var_title = if rt.is_true(rt.new_string(rt.get_property(var_post_shadow, 'post_title').to_string().trim_space())) { rt.get_property(var_post_shadow, 'post_title') } else { rt.call_function('__', [
				rt.new_string('(no title)'),
			]) }
		var_alternate = if rt.is_true(rt.identical(rt.new_string('alternate'),
			rt.new_string(var_alternate.str())))
		{
			''
		} else {
			'alternate'
		}
		mut switch_val_3 := rt.get_property(var_post_shadow, 'post_status')
		if rt.is_true(rt.equal(switch_val_3, rt.new_string('publish')))
			|| rt.is_true(rt.equal(switch_val_3, rt.new_string('private'))) {
			var_stat = rt.call_function('__', [rt.new_string('Published')])
		} else if rt.is_true(rt.equal(switch_val_3, rt.new_string('future'))) {
			var_stat = rt.call_function('__', [rt.new_string('Scheduled')])
		} else if rt.is_true(rt.equal(switch_val_3, rt.new_string('pending'))) {
			var_stat = rt.call_function('__', [rt.new_string('Pending Review')])
		} else if rt.is_true(rt.equal(switch_val_3, rt.new_string('draft'))) {
			var_stat = rt.call_function('__', [rt.new_string('Draft')])
		}
		if rt.is_true(rt.identical(rt.new_string('0000-00-00 00:00:00'), rt.get_property(var_post_shadow,
			'post_date')))
		{
			var_time = rt.new_string('')
		} else {
			var_time = rt.call_function('mysql2date', [
				rt.call_function('__', [rt.new_string('Y/m/d')]),
				rt.get_property(var_post_shadow, 'post_date'),
			])
		}
		var_html = rt.concat(var_html, rt.new_string('<tr class="' + 'found-posts ' +
			var_alternate.trim_space() +
			'"><td class="found-radio"><input type="radio" id="found-' +
			(rt.get_property(var_post_shadow, 'ID')).str() + '" name="found_post_id" value="' +
			(rt.call_function('esc_attr', [rt.get_property(var_post_shadow, 'ID')])).str() +
			'"></td>'))
		var_html = rt.concat(var_html, rt.new_string('<td><label for="found-' +
			(rt.get_property(var_post_shadow, 'ID')).str() + '">' +
			(rt.call_function('esc_html', [var_title.clone()])).str() +
			'</label></td><td class="no-break">' +
			(rt.call_function('esc_html', [rt.get_property(rt.get_property(var_post_types.array_get(rt.get_property(var_post_shadow, 'post_type')), 'labels'), 'singular_name')])).str() +
			'</td><td class="no-break">' +
			(rt.call_function('esc_html', [var_time.clone()])).str() +
			'</td><td class="no-break">' +
			(rt.call_function('esc_html', [var_stat.clone()])).str() + ' </td></tr>' + '\n\n'))
	}
	var_html = rt.concat(var_html, rt.new_string('</tbody></table>'))
	rt.call_function('wp_send_json_success', [var_html.clone()])
}

fn wp_ajax_widgets_order() {
	mut var_sidebars := rt.new_null()
	mut var_val := rt.new_null()
	mut var_key := rt.new_null()
	mut var_sidebar := rt.new_null()
	mut var_v := rt.new_null()
	mut var_k := rt.new_null()
	rt.call_function('check_ajax_referer', [rt.new_string('save-sidebar-widgets'),
		rt.new_string('savewidgets')])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('edit_theme_options'),
	])))))
	{
		rt.call_function('wp_die', [rt.new_int(-1)])
	}
	rt.get_superglobal('_POST').array_unset(rt.new_string('savewidgets'))
	rt.get_superglobal('_POST').array_unset(rt.new_string('action'))
	if rt.is_true(rt.new_bool(rt.get_superglobal('_POST').array_get(rt.new_string('sidebars')).is_array())) {
		var_sidebars = rt.new_array()
		mut iter_10 := rt.call_function('wp_unslash', [
			rt.get_superglobal('_POST').array_get(rt.new_string('sidebars')),
		]).iterator()
		for {
			item_10 := iter_10.next() or { break }
			mut var_val_shadow := item_10.val
			mut var_key_shadow := item_10.key
			var_sidebar = rt.new_array()
			if !(!rt.is_true(var_val_shadow)) {
				var_val_shadow = rt.call_function('explode', [
					rt.new_string(','), var_val_shadow.clone()])
				mut iter_11 := var_val_shadow.iterator()
				for {
					item_11 := iter_11.next() or { break }
					mut var_v_shadow := item_11.val
					mut var_k_shadow := item_11.key
					if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('str_contains', [
						var_v_shadow.clone(),
						rt.new_string('widget-'),
					])))))
					{
						continue
					}
					var_sidebar.array_set(var_k_shadow, rt.call_function('substr', [
						var_v_shadow.clone(),
						rt.add(rt.call_function('strpos', [var_v_shadow.clone(),
							rt.new_string('_')]), rt.new_int(1)),
					]))
				}
			}
			var_sidebars.array_set(var_key_shadow, var_sidebar.clone())
		}
		rt.call_function('wp_set_sidebars_widgets', [var_sidebars.clone()])
		rt.call_function('wp_die', [rt.new_int(1)])
	}
	rt.call_function('wp_die', [rt.new_int(-1)])
}

fn wp_ajax_save_widget() {
	mut var_wp_registered_widgets := rt.new_null()
	mut var_wp_registered_widget_controls := rt.new_null()
	mut var_wp_registered_widget_updates := rt.new_null()
	mut var_id_base := rt.new_null()
	mut var_widget_id := rt.new_null()
	mut var_sidebar_id := rt.new_null()
	mut var_multi_number := rt.new_null()
	mut var_settings := rt.new_null()
	mut var_error := rt.new_null()
	mut var_sidebars := rt.new_null()
	mut var_sidebar := rt.new_null()
	mut var__POST := rt.new_null()
	mut var_control := map[string]rt.PhpVal{}
	mut var_name := rt.new_null()
	mut var_form := rt.new_null()
	rt.call_function('check_ajax_referer', [rt.new_string('save-sidebar-widgets'),
		rt.new_string('savewidgets')])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_theme_options')])))))
		|| !(rt.get_superglobal('_POST').array_isset(rt.new_string('id_base'))) {
		rt.call_function('wp_die', [rt.new_int(-1)])
	}
	rt.get_superglobal('_POST').array_unset(rt.new_string('savewidgets'))
	rt.get_superglobal('_POST').array_unset(rt.new_string('action'))
	rt.call_function('do_action', [rt.new_string('load-widgets.php')])
	rt.call_function('do_action', [rt.new_string('widgets.php')])
	rt.call_function('do_action', [rt.new_string('sidebar_admin_setup')])
	var_id_base = rt.call_function('wp_unslash',
		[rt.get_superglobal('_POST').array_get(rt.new_string('id_base'))])
	var_widget_id = rt.call_function('wp_unslash', [
		rt.get_superglobal('_POST').array_get(rt.new_string('widget-id')),
	])
	var_sidebar_id = rt.get_superglobal('_POST').array_get(rt.new_string('sidebar'))
	var_multi_number = rt.new_int(if !(!rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('multi_number')))) {
		rt.new_int((rt.get_superglobal('_POST').array_get(rt.new_string('multi_number'))).to_i64())
	} else {
		0
	})
	var_settings = if rt.get_superglobal('_POST').array_isset('widget-' + var_id_base.str())
		&& rt.get_superglobal('_POST').array_get(rt.new_string('widget-' + var_id_base.str())).is_array() {
		rt.get_superglobal('_POST').array_get(rt.new_string('widget-' + var_id_base.str()))
	} else {
		rt.new_bool(false)
	}
	var_error = rt.new_string('<p>' +
		(rt.call_function('__', [rt.new_string('An error has occurred. Please reload the page and try again.')])).str() +
		'</p>')
	var_sidebars = rt.call_function('wp_get_sidebars_widgets', []rt.PhpVal{})
	var_sidebar = if !(var_sidebars.array_get(var_sidebar_id)).is_null() {
		var_sidebars.array_get(var_sidebar_id)
	} else {
		rt.new_array()
	}
	if rt.get_superglobal('_POST').array_isset(rt.new_string('delete_widget'))
		&& rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('delete_widget'))) {
		if !(var_wp_registered_widgets.array_isset(var_widget_id)) {
			rt.call_function('wp_die', [var_error.clone()])
		}
		var_sidebar = rt.call_function('array_diff', [var_sidebar.clone(),
			rt.create_array([rt.ArrayItem{ key: none, val: var_widget_id }])])
		var__POST = rt.create_array([rt.ArrayItem{ key: 'sidebar', val: var_sidebar_id },
			rt.ArrayItem{ key: 'widget-' + var_id_base.str(), val: rt.new_array() },
			rt.ArrayItem{ key: 'the-widget-id', val: var_widget_id },
			rt.ArrayItem{ key: 'delete_widget', val: '1' }])
		rt.call_function('do_action', [rt.new_string('delete_widget'),
			var_widget_id.clone(), var_sidebar_id.clone(), var_id_base.clone()])
	} else if rt.is_true(var_settings)
		&& rt.is_true(rt.call_function('preg_match', [rt.new_string('/__i__|%i%/'), rt.call_function('key', [var_settings.clone()])])) {
		if rt.is_true(rt.new_bool(!(rt.is_true(var_multi_number)))) {
			rt.call_function('wp_die', [var_error.clone()])
		}
		rt.get_superglobal('_POST').array_set('widget-' + var_id_base.str(), rt.create_array([
			rt.ArrayItem{ key: var_multi_number, val: rt.call_function('reset', [
				var_settings.clone(),
			]) },
		]))
		var_widget_id = rt.new_string(var_id_base.str() + '-' + var_multi_number.str())
		var_sidebar.array_push(var_widget_id.clone())
	}
	rt.get_superglobal('_POST').array_set('widget-id', var_sidebar.clone())
	mut iter_12 := rt.cast_array(var_wp_registered_widget_updates).iterator()
	for {
		item_12 := iter_12.next() or { break }
		mut var_control_shadow := item_12.val
		mut var_name_shadow := item_12.key
		if rt.is_true(rt.identical(var_name_shadow, var_id_base)) {
			if !(rt.call_function('is_callable', [var_control_shadow['callback']])) {
				continue
			}
			rt.call_function('ob_start', []rt.PhpVal{})
			rt.call_function('call_user_func_array',
				[var_control_shadow['callback'], var_control_shadow['params']])
			rt.call_function('ob_end_clean', []rt.PhpVal{})
			break
		}
	}
	if rt.get_superglobal('_POST').array_isset(rt.new_string('delete_widget'))
		&& rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('delete_widget'))) {
		var_sidebars.array_set(var_sidebar_id, var_sidebar.clone())
		rt.call_function('wp_set_sidebars_widgets', [var_sidebars.clone()])
		print('deleted:${var_widget_id.to_string()}')
		rt.call_function('wp_die', []rt.PhpVal{})
	}
	if !(!rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('add_new')))) {
		rt.call_function('wp_die', []rt.PhpVal{})
	}
	var_form = var_wp_registered_widget_controls.array_get(var_widget_id)
	if rt.is_true(var_form) {
		rt.call_function('call_user_func_array', [
			var_form.array_get(rt.new_string('callback')),
			var_form.array_get(rt.new_string('params')),
		])
	}
	rt.call_function('wp_die', []rt.PhpVal{})
}

fn wp_ajax_update_widget() {
	mut var_wp_customize := rt.new_null()
	rt.call_method(rt.get_property(var_wp_customize, 'widgets'), 'wp_ajax_update_widget',
		[]rt.PhpVal{})
}

fn wp_ajax_delete_inactive_widgets() {
	mut var_sidebars_widgets := rt.new_null()
	mut var_widget_id := rt.new_null()
	mut var_key := rt.new_null()
	mut var_pieces := rt.new_null()
	mut var_multi_number := rt.new_null()
	mut var_id_base := rt.new_null()
	mut var_widget := rt.new_null()
	rt.call_function('check_ajax_referer', [rt.new_string('remove-inactive-widgets'),
		rt.new_string('removeinactivewidgets')])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('edit_theme_options'),
	])))))
	{
		rt.call_function('wp_die', [rt.new_int(-1)])
	}
	rt.get_superglobal('_POST').array_unset(rt.new_string('removeinactivewidgets'))
	rt.get_superglobal('_POST').array_unset(rt.new_string('action'))
	rt.call_function('do_action', [rt.new_string('load-widgets.php')])
	rt.call_function('do_action', [rt.new_string('widgets.php')])
	rt.call_function('do_action', [rt.new_string('sidebar_admin_setup')])
	var_sidebars_widgets = rt.call_function('wp_get_sidebars_widgets', []rt.PhpVal{})
	mut iter_13 := var_sidebars_widgets.array_get(rt.new_string('wp_inactive_widgets')).iterator()
	for {
		item_13 := iter_13.next() or { break }
		mut var_widget_id_shadow := item_13.val
		mut var_key_shadow := item_13.key
		var_pieces = rt.call_function('explode', [rt.new_string('-'),
			var_widget_id_shadow.clone()])
		var_multi_number = rt.call_function('array_pop', [var_pieces.clone()])
		var_id_base = rt.call_function('implode', [rt.new_string('-'),
			var_pieces.clone()])
		var_widget = rt.call_function('get_option', [
			rt.new_string('widget_' + var_id_base.str()),
		])
		var_widget.array_unset(var_multi_number)
		rt.call_function('update_option', [
			rt.new_string('widget_' + var_id_base.str()),
			var_widget.clone(),
		])
		var_sidebars_widgets.array_get(rt.new_string('wp_inactive_widgets')).array_unset(var_key_shadow)
	}
	rt.call_function('wp_set_sidebars_widgets', [var_sidebars_widgets.clone()])
	rt.call_function('wp_die', []rt.PhpVal{})
}

fn wp_ajax_media_create_image_subsizes() {
	mut var_attachment_id := rt.new_null()
	mut var_attachment := rt.new_null()
	mut var_response := rt.new_null()
	rt.call_function('check_ajax_referer', [rt.new_string('media-form')])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('upload_files'),
	])))))
	{
		rt.call_function('wp_send_json_error', [
			rt.create_array([
				rt.ArrayItem{ key: 'message', val: rt.call_function('__', [
					rt.new_string('Sorry, you are not allowed to upload files.'),
				]) },
			]),
		])
	}
	if !rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('attachment_id'))) {
		rt.call_function('wp_send_json_error', [
			rt.create_array([
				rt.ArrayItem{ key: 'message', val: rt.call_function('__', [
					rt.new_string('Upload failed. Please reload and try again.'),
				]) },
			]),
		])
	}
	var_attachment_id =
		rt.new_int((rt.get_superglobal('_POST').array_get(rt.new_string('attachment_id'))).to_i64())
	if !(!rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('_wp_upload_failed_cleanup')))) {
		if rt.is_true(rt.call_function('wp_attachment_is_image', [var_attachment_id.clone()]))
			&& rt.is_true(rt.call_function('current_user_can', [rt.new_string('delete_post'), var_attachment_id.clone()])) {
			var_attachment = rt.call_function('get_post', [var_attachment_id.clone()])
			if rt.is_true(var_attachment)
				&& rt.is_true(rt.less(rt.sub(rt.call_function('time', []rt.PhpVal{}), rt.call_function('strtotime', [rt.get_property(var_attachment, 'post_date_gmt')])), rt.new_int(600))) {
				rt.call_function('wp_delete_attachment', [var_attachment_id.clone(),
					rt.new_bool(true)])
				rt.call_function('wp_send_json_success', []rt.PhpVal{})
			}
		}
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('headers_sent', []rt.PhpVal{}))))) {
		rt.call_function('header', [
			rt.new_string('X-WP-Upload-Attachment-ID: ' + var_attachment_id.str()),
		])
	}
	rt.call_function('wp_update_image_subsizes', [var_attachment_id.clone()])
	if !(!rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('_legacy_support')))) {
		var_response = rt.create_array([
			rt.ArrayItem{ key: 'id', val: var_attachment_id },
		])
	} else {
		var_response = rt.call_function('wp_prepare_attachment_for_js', [
			var_attachment_id.clone()])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_response)))) {
			rt.call_function('wp_send_json_error', [
				rt.create_array([
					rt.ArrayItem{ key: 'message', val: rt.call_function('__', [
						rt.new_string('Upload failed.'),
					]) },
				]),
			])
		}
	}
	rt.call_function('wp_send_json_success', [var_response.clone()])
}

fn wp_ajax_upload_attachment() {
	mut var__FILES := rt.new_null()
	mut var_post_id := rt.new_null()
	mut var_post_data := rt.new_null()
	mut var_wp_filetype := rt.new_null()
	mut var_attachment_id := rt.new_null()
	mut var_attachment := rt.new_null()
	rt.call_function('check_ajax_referer', [rt.new_string('media-form')])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('upload_files'),
	])))))
	{
		rt.echo_val(rt.call_function('wp_json_encode', [
			rt.create_array([rt.ArrayItem{ key: 'success', val: false },
				rt.ArrayItem{ key: 'data', val: rt.create_array([
					rt.ArrayItem{ key: 'message', val: rt.call_function('__', [
						rt.new_string('Sorry, you are not allowed to upload files.'),
					]) },
					rt.ArrayItem{ key: 'filename', val: rt.call_function('esc_html', [
						var__FILES.array_get(rt.new_string('async-upload')).array_get(rt.new_string('name')),
					]) },
				]) }]),
		]))
		rt.call_function('wp_die', []rt.PhpVal{})
	}
	if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('post_id')) {
		var_post_id = rt.get_superglobal('_REQUEST').array_get(rt.new_string('post_id'))
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
			rt.new_string('edit_post'),
			var_post_id.clone(),
		])))))
		{
			rt.echo_val(rt.call_function('wp_json_encode', [
				rt.create_array([rt.ArrayItem{ key: 'success', val: false },
					rt.ArrayItem{ key: 'data', val: rt.create_array([
						rt.ArrayItem{ key: 'message', val: rt.call_function('__', [
							rt.new_string('Sorry, you are not allowed to attach files to this post.'),
						]) },
						rt.ArrayItem{ key: 'filename', val: rt.call_function('esc_html', [
							var__FILES.array_get(rt.new_string('async-upload')).array_get(rt.new_string('name')),
						]) },
					]) }]),
			]))
			rt.call_function('wp_die', []rt.PhpVal{})
		}
	} else {
		var_post_id = rt.new_null()
	}
	var_post_data = if !(!rt.is_true(rt.get_superglobal('_REQUEST').array_get(rt.new_string('post_data')))) { rt.call_function('_wp_get_allowed_postdata', [
			rt.call_function('_wp_translate_postdata', [rt.new_bool(false),
				rt.cast_array(rt.get_superglobal('_REQUEST').array_get(rt.new_string('post_data')))]),
		]) } else { rt.new_array() }
	if rt.is_true(rt.call_function('is_wp_error', [var_post_data.clone()])) {
		rt.call_function('wp_die', [
			rt.call_method(var_post_data, 'get_error_message', []rt.PhpVal{}),
		])
	}
	if var_post_data.array_isset(rt.new_string('context'))
		&& rt.is_true(rt.call_function('in_array', [var_post_data.array_get(rt.new_string('context')), rt.create_array([rt.ArrayItem{
		key: none
		val: 'custom-header'
	}, rt.ArrayItem{ key: none, val: 'custom-background' }]), rt.new_bool(true)])) {
		var_wp_filetype = rt.call_function('wp_check_filetype_and_ext', [
			var__FILES.array_get(rt.new_string('async-upload')).array_get(rt.new_string('tmp_name')),
			var__FILES.array_get(rt.new_string('async-upload')).array_get(rt.new_string('name')),
		])
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_match_mime_types', [
			rt.new_string('image'),
			var_wp_filetype.array_get(rt.new_string('type')),
		])))))
		{
			rt.echo_val(rt.call_function('wp_json_encode', [
				rt.create_array([rt.ArrayItem{ key: 'success', val: false },
					rt.ArrayItem{ key: 'data', val: rt.create_array([
						rt.ArrayItem{ key: 'message', val: rt.call_function('__', [
							rt.new_string('The uploaded file is not a valid image. Please try again.'),
						]) },
						rt.ArrayItem{ key: 'filename', val: rt.call_function('esc_html', [
							var__FILES.array_get(rt.new_string('async-upload')).array_get(rt.new_string('name')),
						]) },
					]) }]),
			]))
			rt.call_function('wp_die', []rt.PhpVal{})
		}
	}
	var_attachment_id = rt.call_function('media_handle_upload', [
		rt.new_string('async-upload'),
		var_post_id.clone(),
		var_post_data.clone(),
	])
	if rt.is_true(rt.call_function('is_wp_error', [var_attachment_id.clone()])) {
		rt.echo_val(rt.call_function('wp_json_encode', [
			rt.create_array([rt.ArrayItem{ key: 'success', val: false },
				rt.ArrayItem{ key: 'data', val: rt.create_array([
					rt.ArrayItem{ key: 'message', val: rt.call_method(var_attachment_id,
						'get_error_message', []rt.PhpVal{}) },
					rt.ArrayItem{ key: 'filename', val: rt.call_function('esc_html', [
						var__FILES.array_get(rt.new_string('async-upload')).array_get(rt.new_string('name')),
					]) },
				]) }]),
		]))
		rt.call_function('wp_die', []rt.PhpVal{})
	}
	if var_post_data.array_isset(rt.new_string('context'))
		&& var_post_data.array_isset(rt.new_string('theme')) {
		if rt.is_true(rt.identical(rt.new_string('custom-background'),
			var_post_data.array_get(rt.new_string('context'))))
		{
			rt.call_function('update_post_meta', [var_attachment_id.clone(),
				rt.new_string('_wp_attachment_is_custom_background'),
				var_post_data.array_get(rt.new_string('theme'))])
		}
		if rt.is_true(rt.identical(rt.new_string('custom-header'),
			var_post_data.array_get(rt.new_string('context'))))
		{
			rt.call_function('update_post_meta', [var_attachment_id.clone(),
				rt.new_string('_wp_attachment_is_custom_header'),
				var_post_data.array_get(rt.new_string('theme'))])
		}
	}
	var_attachment = rt.call_function('wp_prepare_attachment_for_js', [
		var_attachment_id.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_attachment)))) {
		rt.call_function('wp_die', []rt.PhpVal{})
	}
	rt.echo_val(rt.call_function('wp_json_encode', [
		rt.create_array([rt.ArrayItem{ key: 'success', val: true },
			rt.ArrayItem{ key: 'data', val: var_attachment }]),
	]))
	rt.call_function('wp_die', []rt.PhpVal{})
}

fn wp_ajax_image_editor() {
	mut var_attachment_id := rt.new_null()
	mut var_message := false
	mut var_html := rt.new_null()
	var_attachment_id =
		rt.new_int((rt.get_superglobal('_POST').array_get(rt.new_string('postid'))).to_i64())
	if !rt.is_true(var_attachment_id)
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_post'), var_attachment_id.clone()]))))) {
		rt.call_function('wp_die', [rt.new_int(-1)])
	}
	rt.call_function('check_ajax_referer', [
		rt.new_string('image_editor-${var_attachment_id.to_string()}'),
	])
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/image-edit.php', '4')
	var_message = false
	mut switch_val_4 := rt.get_superglobal('_POST').array_get(rt.new_string('do'))
	if rt.is_true(rt.equal(switch_val_4, rt.new_string('save'))) {
		var_message = (rt.call_function('wp_save_image', [var_attachment_id.clone()])).to_bool()
		if !(!rt.is_true(rt.get_property(rt.new_bool(var_message), 'error'))) {
			rt.call_function('wp_send_json_error', [rt.new_bool(var_message).clone()])
		}
		rt.call_function('wp_send_json_success', [rt.new_bool(var_message).clone()])
	} else if rt.is_true(rt.equal(switch_val_4, rt.new_string('scale'))) {
		var_message = (rt.call_function('wp_save_image', [var_attachment_id.clone()])).to_bool()
	} else if rt.is_true(rt.equal(switch_val_4, rt.new_string('restore'))) {
		var_message = (rt.call_function('wp_restore_image', [
			var_attachment_id.clone()])).to_bool()
	}
	rt.call_function('ob_start', []rt.PhpVal{})
	rt.call_function('wp_image_editor', [var_attachment_id.clone(),
		rt.new_bool(var_message).clone()])
	var_html = rt.call_function('ob_get_clean', []rt.PhpVal{})
	if !(!rt.is_true(rt.get_property(rt.new_bool(var_message), 'error'))) {
		rt.call_function('wp_send_json_error', [
			rt.create_array([rt.ArrayItem{ key: 'message', val: var_message },
				rt.ArrayItem{ key: 'html', val: var_html }]),
		])
	}
	rt.call_function('wp_send_json_success', [
		rt.create_array([rt.ArrayItem{ key: 'message', val: var_message },
			rt.ArrayItem{ key: 'html', val: var_html }]),
	])
}

fn wp_ajax_set_post_thumbnail() {
	mut var_json := false
	mut var_post_id := rt.new_null()
	mut var_thumbnail_id := rt.new_null()
	mut var_return := rt.new_null()
	var_json = !(!rt.is_true(rt.get_superglobal('_REQUEST').array_get(rt.new_string('json'))))
	var_post_id =
		rt.new_int((rt.get_superglobal('_POST').array_get(rt.new_string('post_id'))).to_i64())
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('edit_post'),
		var_post_id.clone(),
	])))))
	{
		rt.call_function('wp_die', [rt.new_int(-1)])
	}
	var_thumbnail_id =
		rt.new_int((rt.get_superglobal('_POST').array_get(rt.new_string('thumbnail_id'))).to_i64())
	if var_json {
		rt.call_function('check_ajax_referer', [
			rt.new_string('update-post_${var_post_id.to_string()}'),
		])
	} else {
		rt.call_function('check_ajax_referer', [
			rt.new_string('set_post_thumbnail-${var_post_id.to_string()}'),
		])
	}
	if rt.is_true(rt.identical(-1, var_thumbnail_id)) {
		if rt.is_true(rt.call_function('delete_post_thumbnail', [
			var_post_id.clone()]))
		{
			var_return = rt.call_function('_wp_post_thumbnail_html', [
				rt.new_null(), var_post_id.clone()])
			if var_json {
				rt.call_function('wp_send_json_success', [var_return.clone()])
			} else {
				rt.call_function('wp_die', [var_return.clone()])
			}
		} else {
			rt.call_function('wp_die', [rt.new_int(0)])
		}
	}
	if rt.is_true(rt.call_function('set_post_thumbnail', [var_post_id.clone(),
		var_thumbnail_id.clone()]))
	{
		var_return = rt.call_function('_wp_post_thumbnail_html', [
			var_thumbnail_id.clone(), var_post_id.clone()])
		if var_json {
			rt.call_function('wp_send_json_success', [var_return.clone()])
		} else {
			rt.call_function('wp_die', [var_return.clone()])
		}
	}
	rt.call_function('wp_die', [rt.new_int(0)])
}

fn wp_ajax_get_post_thumbnail_html() {
	mut var_post_id := rt.new_null()
	mut var_thumbnail_id := rt.new_null()
	mut var_return := rt.new_null()
	var_post_id =
		rt.new_int((rt.get_superglobal('_POST').array_get(rt.new_string('post_id'))).to_i64())
	rt.call_function('check_ajax_referer', [
		rt.new_string('update-post_${var_post_id.to_string()}'),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('edit_post'),
		var_post_id.clone(),
	])))))
	{
		rt.call_function('wp_die', [rt.new_int(-1)])
	}
	var_thumbnail_id =
		rt.new_int((rt.get_superglobal('_POST').array_get(rt.new_string('thumbnail_id'))).to_i64())
	if rt.is_true(rt.identical(-1, var_thumbnail_id)) {
		var_thumbnail_id = rt.new_null()
	}
	var_return = rt.call_function('_wp_post_thumbnail_html', [
		var_thumbnail_id.clone(), var_post_id.clone()])
	rt.call_function('wp_send_json_success', [var_return.clone()])
}

fn wp_ajax_set_attachment_thumbnail() {
	mut var_thumbnail_id := rt.new_null()
	mut var_post_ids := []rt.PhpVal{}
	mut var_url := rt.new_null()
	mut var_post_id := rt.new_null()
	mut var_success := i64(0)
	if !rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('urls')))
		|| !(rt.get_superglobal('_POST').array_get(rt.new_string('urls')).is_array()) {
		rt.call_function('wp_send_json_error', []rt.PhpVal{})
	}
	var_thumbnail_id =
		rt.new_int((rt.get_superglobal('_POST').array_get(rt.new_string('thumbnail_id'))).to_i64())
	if !rt.is_true(var_thumbnail_id) {
		rt.call_function('wp_send_json_error', []rt.PhpVal{})
	}
	if rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('check_ajax_referer', [
		rt.new_string('set-attachment-thumbnail'),
		rt.new_string('_ajax_nonce'),
		rt.new_bool(false),
	])))
	{
		rt.call_function('wp_send_json_error', []rt.PhpVal{})
	}
	var_post_ids = rt.new_array()
	mut iter_14 := rt.get_superglobal('_POST').array_get(rt.new_string('urls')).iterator()
	for {
		item_14 := iter_14.next() or { break }
		mut var_url_shadow := item_14.val
		var_post_id = rt.call_function('attachment_url_to_postid', [
			var_url_shadow.clone()])
		if !(!rt.is_true(var_post_id)) {
			var_post_ids << var_post_id.clone()
		}
	}
	if !rt.is_true(var_post_ids) {
		rt.call_function('wp_send_json_error', []rt.PhpVal{})
	}
	var_success = 0
	for var_post_id_shadow in var_post_ids {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
			rt.new_string('edit_post'),
			var_post_id_shadow.clone(),
		])))))
		{
			continue
		}
		if rt.is_true(rt.call_function('set_post_thumbnail', [
			var_post_id_shadow.clone(), var_thumbnail_id.clone()]))
		{
			var_success += 1
		}
	}
	if 0 == var_success {
		rt.call_function('wp_send_json_error', []rt.PhpVal{})
	} else {
		rt.call_function('wp_send_json_success', []rt.PhpVal{})
	}
	rt.call_function('wp_send_json_error', []rt.PhpVal{})
}

fn wp_ajax_date_format() {
	rt.call_function('wp_die', [
		rt.call_function('date_i18n', [
			rt.call_function('sanitize_option', [rt.new_string('date_format'),
				rt.call_function('wp_unslash',
					[rt.get_superglobal('_POST').array_get(rt.new_string('date'))])]),
		]),
	])
}

fn wp_ajax_time_format() {
	rt.call_function('wp_die', [
		rt.call_function('date_i18n', [
			rt.call_function('sanitize_option', [rt.new_string('time_format'),
				rt.call_function('wp_unslash',
					[rt.get_superglobal('_POST').array_get(rt.new_string('date'))])]),
		]),
	])
}

fn wp_ajax_wp_fullscreen_save_post() {
	mut var_post_id := rt.new_null()
	mut var_post := rt.new_null()
	mut var_last_date := rt.new_null()
	mut var_last_time := rt.new_null()
	mut var_last_id := rt.new_null()
	mut var_last_user := rt.new_null()
	mut var_last_edited := rt.new_null()
	var_post_id = rt.new_int(if rt.get_superglobal('_POST').array_isset(rt.new_string('post_ID')) {
		rt.new_int((rt.get_superglobal('_POST').array_get(rt.new_string('post_ID'))).to_i64())
	} else {
		0
	})
	var_post = rt.new_null()
	if rt.is_true(var_post_id) {
		var_post = rt.call_function('get_post', [var_post_id.clone()])
	}
	rt.call_function('check_ajax_referer', [
		rt.new_string('update-post_' + var_post_id.str()),
		rt.new_string('_wpnonce'),
	])
	var_post_id = rt.call_function('edit_post', []rt.PhpVal{})
	if rt.is_true(rt.call_function('is_wp_error', [var_post_id.clone()])) {
		rt.call_function('wp_send_json_error', []rt.PhpVal{})
	}
	if rt.is_true(var_post) {
		var_last_date = rt.call_function('mysql2date', [
			rt.call_function('__', [rt.new_string('F j, Y')]),
			rt.get_property(var_post, 'post_modified'),
		])
		var_last_time = rt.call_function('mysql2date', [
			rt.call_function('__', [rt.new_string('g:i a')]),
			rt.get_property(var_post, 'post_modified'),
		])
	} else {
		var_last_date = rt.call_function('date_i18n', [
			rt.call_function('__', [rt.new_string('F j, Y')]),
		])
		var_last_time = rt.call_function('date_i18n', [
			rt.call_function('__', [rt.new_string('g:i a')]),
		])
	}
	var_last_id = rt.call_function('get_post_meta', [var_post_id.clone(),
		rt.new_string('_edit_last'), rt.new_bool(true)])
	if rt.is_true(var_last_id) {
		var_last_user = rt.call_function('get_userdata', [var_last_id.clone()])
		var_last_edited = rt.call_function('sprintf', [
			rt.call_function('__', [rt.new_string('Last edited by %1$s on %2$s at %3$s')]),
			rt.call_function('esc_html', [rt.get_property(var_last_user, 'display_name')]),
			var_last_date.clone(),
			var_last_time.clone(),
		])
	} else {
		var_last_edited = rt.call_function('sprintf', [
			rt.call_function('__', [rt.new_string('Last edited on %1$s at %2$s')]),
			var_last_date.clone(),
			var_last_time.clone(),
		])
	}
	rt.call_function('wp_send_json_success', [
		rt.create_array([rt.ArrayItem{ key: 'last_edited', val: var_last_edited }]),
	])
}

fn wp_ajax_wp_remove_post_lock() {
	mut var_post_id := rt.new_null()
	mut var_post := rt.new_null()
	mut var_active_lock := rt.new_null()
	mut var_new_lock := rt.new_null()
	if !rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('post_ID')))
		|| !rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('active_post_lock'))) {
		rt.call_function('wp_die', [rt.new_int(0)])
	}
	var_post_id =
		rt.new_int((rt.get_superglobal('_POST').array_get(rt.new_string('post_ID'))).to_i64())
	var_post = rt.call_function('get_post', [var_post_id.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_post)))) {
		rt.call_function('wp_die', [rt.new_int(0)])
	}
	rt.call_function('check_ajax_referer', [
		rt.new_string('update-post_' + var_post_id.str()),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('edit_post'),
		var_post_id.clone(),
	])))))
	{
		rt.call_function('wp_die', [rt.new_int(-1)])
	}
	var_active_lock = rt.call_function('array_map', [rt.new_string('absint'),
		rt.call_function('explode',
			[rt.new_string(':'), rt.get_superglobal('_POST').array_get(rt.new_string('active_post_lock'))])])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('get_current_user_id',
		[]rt.PhpVal{}), var_active_lock.array_get(rt.new_int(1))))))
	{
		rt.call_function('wp_die', [rt.new_int(0)])
	}
	var_new_lock = rt.new_string(
		(rt.add(rt.sub(rt.call_function('time', []rt.PhpVal{}), rt.call_function('apply_filters', [rt.new_string('wp_check_post_lock_window'), rt.new_int(150)])), rt.new_int(5))).str() +
		':' + (var_active_lock.array_get(rt.new_int(1))).str())
	rt.call_function('update_post_meta', [var_post_id.clone(),
		rt.new_string('_edit_lock'), var_new_lock.clone(),
		rt.call_function('implode', [
			rt.new_string(':'),
			var_active_lock.clone(),
		])])
	rt.call_function('wp_die', [rt.new_int(1)])
}

fn wp_ajax_dismiss_wp_pointer() {
	mut var_pointer := rt.new_null()
	mut var_dismissed := rt.new_null()
	var_pointer = rt.get_superglobal('_POST').array_get(rt.new_string('pointer'))
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('sanitize_key', [
		var_pointer.clone(),
	]), var_pointer))))
	{
		rt.call_function('wp_die', [rt.new_int(0)])
	}
	var_dismissed = rt.call_function('array_filter', [
		rt.call_function('explode', [rt.new_string(','),
			rt.new_string((rt.call_function('get_user_meta', [
				rt.call_function('get_current_user_id', []rt.PhpVal{}),
				rt.new_string('dismissed_wp_pointers'),
				rt.new_bool(true),
			])).str())]),
	])
	if rt.is_true(rt.call_function('in_array', [var_pointer.clone(),
		var_dismissed.clone(), rt.new_bool(true)]))
	{
		rt.call_function('wp_die', [rt.new_int(0)])
	}
	var_dismissed.array_push(var_pointer.clone())
	var_dismissed = rt.call_function('implode', [rt.new_string(','),
		var_dismissed.clone()])
	rt.call_function('update_user_meta', [
		rt.call_function('get_current_user_id', []rt.PhpVal{}),
		rt.new_string('dismissed_wp_pointers'),
		var_dismissed.clone(),
	])
	rt.call_function('wp_die', [rt.new_int(1)])
}

fn wp_ajax_get_attachment() {
	mut var_id := rt.new_null()
	mut var_post := rt.new_null()
	mut var_attachment := rt.new_null()
	if !(rt.get_superglobal('_REQUEST').array_isset(rt.new_string('id'))) {
		rt.call_function('wp_send_json_error', []rt.PhpVal{})
	}
	var_id = rt.call_function('absint',
		[rt.get_superglobal('_REQUEST').array_get(rt.new_string('id'))])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_id)))) {
		rt.call_function('wp_send_json_error', []rt.PhpVal{})
	}
	var_post = rt.call_function('get_post', [var_id.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_post)))) {
		rt.call_function('wp_send_json_error', []rt.PhpVal{})
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('attachment'), rt.get_property(var_post,
		'post_type')))))
	{
		rt.call_function('wp_send_json_error', []rt.PhpVal{})
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('upload_files'),
	])))))
	{
		rt.call_function('wp_send_json_error', []rt.PhpVal{})
	}
	var_attachment = rt.call_function('wp_prepare_attachment_for_js', [
		var_id.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_attachment)))) {
		rt.call_function('wp_send_json_error', []rt.PhpVal{})
	}
	rt.call_function('wp_send_json_success', [var_attachment.clone()])
}

fn wp_ajax_query_attachments() {
	mut var_query := rt.new_null()
	mut var_keys := []rt.PhpVal{}
	mut var_taxonomy := rt.new_null()
	mut var_attachments_query := rt.new_null()
	mut var_posts := rt.new_null()
	mut var_total_posts := rt.new_null()
	mut var_count_query := rt.new_null()
	mut var_posts_per_page := rt.new_null()
	mut var_max_pages := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('upload_files'),
	])))))
	{
		rt.call_function('wp_send_json_error', []rt.PhpVal{})
	}
	var_query = if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('query')) {
		rt.cast_array(rt.get_superglobal('_REQUEST').array_get(rt.new_string('query')))
	} else {
		rt.new_array()
	}
	var_keys = [rt.new_string('s'), rt.new_string('order'), rt.new_string('orderby'),
		rt.new_string('posts_per_page'), rt.new_string('paged'),
		rt.new_string('post_mime_type'), rt.new_string('post_parent'),
		rt.new_string('author'), rt.new_string('post__in'), rt.new_string('post__not_in'),
		rt.new_string('year'), rt.new_string('monthnum')]
	mut iter_15 := rt.call_function('get_taxonomies_for_attachments', [
		rt.new_string('objects'),
	]).iterator()
	for {
		item_15 := iter_15.next() or { break }
		mut var_taxonomy_shadow := item_15.val
		if rt.is_true(rt.get_property(var_taxonomy_shadow, 'query_var'))
			&& var_query.array_isset(rt.get_property(var_taxonomy_shadow, 'query_var')) {
			var_keys << rt.get_property(var_taxonomy_shadow, 'query_var')
		}
	}
	var_query = rt.call_function('array_intersect_key', [var_query.clone(),
		rt.call_function('array_flip', [rt.create_array_from_list(var_keys)])])
	var_query.array_set('post_type', 'attachment')
	if rt.is_true(rt.get_constant('MEDIA_TRASH'))
		&& !(!rt.is_true(rt.get_superglobal('_REQUEST').array_get(rt.new_string('query')).array_get(rt.new_string('post_status'))))
		&& rt.is_true(rt.identical(rt.new_string('trash'), rt.get_superglobal('_REQUEST').array_get(rt.new_string('query')).array_get(rt.new_string('post_status')))) {
		var_query.array_set('post_status', 'trash')
	} else {
		var_query.array_set('post_status', 'inherit')
	}
	if rt.is_true(rt.call_function('current_user_can', [
		rt.get_property(rt.get_property(rt.call_function('get_post_type_object', [
			rt.new_string('attachment'),
		]), 'cap'), 'read_private_posts'),
	]))
	{
		var_query.array_get(rt.new_string('post_status')) = rt.concat(var_query.array_get(rt.new_string('post_status')),
			rt.new_string(',private'))
	}
	if var_query.array_isset(rt.new_string('s')) {
		rt.call_function('add_filter', [
			rt.new_string('wp_allow_query_attachment_by_filename'),
			rt.new_string('__return_true'),
		])
	}
	var_query = rt.call_function('apply_filters', [
		rt.new_string('ajax_query_attachments_args'),
		var_query.clone(),
	])
	var_attachments_query = create_wp_query(var_query.clone())
	rt.call_function('update_post_parent_caches', [
		rt.get_property(var_attachments_query, 'posts'),
	])
	var_posts = rt.call_function('array_map', [
		rt.new_string('wp_prepare_attachment_for_js'),
		rt.get_property(var_attachments_query, 'posts'),
	])
	var_posts = rt.call_function('array_filter', [var_posts.clone()])
	var_total_posts = rt.get_property(var_attachments_query, 'found_posts')
	if rt.is_true(rt.less(var_total_posts, rt.new_int(1))) {
		var_query.array_unset(rt.new_string('paged'))
		var_count_query = create_wp_query()
		var_count_query.query(var_query.clone())
		var_total_posts = rt.get_property(var_count_query, 'found_posts')
	}
	var_posts_per_page =
		rt.new_int((var_attachments_query.get(rt.new_string('posts_per_page'))).to_i64())
	var_max_pages = rt.new_int(if rt.is_true(var_posts_per_page) { rt.new_int((rt.call_function('ceil', [
			rt.div(var_total_posts, var_posts_per_page),
		])).to_i64()) } else { 0 })
	rt.call_function('header', [
		rt.new_string('X-WP-Total: ' + rt.new_int(var_total_posts.to_i64()).str()),
	])
	rt.call_function('header', [
		rt.new_string('X-WP-TotalPages: ' + var_max_pages.str()),
	])
	rt.call_function('wp_send_json_success', [var_posts.clone()])
}

fn wp_ajax_save_attachment() {
	mut var_id := rt.new_null()
	mut var_changes := rt.new_null()
	mut var_post := rt.new_null()
	mut var_alt := rt.new_null()
	mut var_changed := false
	mut var_id3_data := rt.new_null()
	mut var_label := rt.new_null()
	mut var_key := rt.new_null()
	if !(rt.get_superglobal('_REQUEST').array_isset(rt.new_string('id')))
		|| !(rt.get_superglobal('_REQUEST').array_isset(rt.new_string('changes'))) {
		rt.call_function('wp_send_json_error', []rt.PhpVal{})
	}
	var_id = rt.call_function('absint',
		[rt.get_superglobal('_REQUEST').array_get(rt.new_string('id'))])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_id)))) {
		rt.call_function('wp_send_json_error', []rt.PhpVal{})
	}
	rt.call_function('check_ajax_referer', [
		rt.new_string('update-post_' + var_id.str()),
		rt.new_string('nonce'),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('edit_post'),
		var_id.clone(),
	])))))
	{
		rt.call_function('wp_send_json_error', []rt.PhpVal{})
	}
	var_changes = rt.get_superglobal('_REQUEST').array_get(rt.new_string('changes'))
	var_post = rt.call_function('get_post', [var_id.clone(), rt.get_constant('ARRAY_A')])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('attachment'),
		var_post.array_get(rt.new_string('post_type'))))))
	{
		rt.call_function('wp_send_json_error', []rt.PhpVal{})
	}
	if var_changes.array_isset(rt.new_string('parent')) {
		var_post.array_set('post_parent', var_changes.array_get(rt.new_string('parent')))
	}
	if var_changes.array_isset(rt.new_string('title')) {
		var_post.array_set('post_title', var_changes.array_get(rt.new_string('title')))
	}
	if var_changes.array_isset(rt.new_string('caption')) {
		var_post.array_set('post_excerpt', var_changes.array_get(rt.new_string('caption')))
	}
	if var_changes.array_isset(rt.new_string('description')) {
		var_post.array_set('post_content', var_changes.array_get(rt.new_string('description')))
	}
	if rt.is_true(rt.get_constant('MEDIA_TRASH'))
		&& var_changes.array_isset(rt.new_string('status')) {
		var_post.array_set('post_status', var_changes.array_get(rt.new_string('status')))
	}
	if var_changes.array_isset(rt.new_string('alt')) {
		var_alt = rt.call_function('wp_unslash', [var_changes.array_get(rt.new_string('alt'))])
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('get_post_meta', [
			var_id.clone(),
			rt.new_string('_wp_attachment_image_alt'),
			rt.new_bool(true),
		]), var_alt))))
		{
			var_alt = rt.call_function('wp_strip_all_tags', [
				var_alt.clone(), rt.new_bool(true)])
			rt.call_function('update_post_meta', [var_id.clone(),
				rt.new_string('_wp_attachment_image_alt'),
				rt.call_function('wp_slash', [
					var_alt.clone(),
				])])
		}
	}
	if rt.is_true(rt.call_function('wp_attachment_is', [rt.new_string('audio'),
		var_post.array_get(rt.new_string('ID'))]))
	{
		var_changed = false
		var_id3_data = rt.call_function('wp_get_attachment_metadata', [
			var_post.array_get(rt.new_string('ID')),
		])
		if !(var_id3_data.clone().is_array()) {
			var_changed = true
			var_id3_data = rt.new_array()
		}
		mut iter_16 := rt.call_function('wp_get_attachment_id3_keys', [
			rt.array_to_object(var_post),
			rt.new_string('edit'),
		]).iterator()
		for {
			item_16 := iter_16.next() or { break }
			mut var_label_shadow := item_16.val
			mut var_key_shadow := item_16.key
			if var_changes.array_isset(var_key_shadow) {
				var_changed = true
				var_id3_data.array_set(var_key_shadow, rt.call_function('sanitize_text_field', [
					rt.call_function('wp_unslash', [var_changes.array_get(var_key_shadow)]),
				]))
			}
		}
		if var_changed {
			rt.call_function('wp_update_attachment_metadata', [
				var_id.clone(), var_id3_data.clone()])
		}
	}
	if rt.is_true(rt.get_constant('MEDIA_TRASH'))
		&& var_changes.array_isset(rt.new_string('status'))
		&& rt.is_true(rt.identical(rt.new_string('trash'), var_changes.array_get(rt.new_string('status')))) {
		rt.call_function('wp_delete_post', [var_id.clone()])
	} else {
		rt.call_function('wp_update_post', [var_post.clone()])
	}
	rt.call_function('wp_send_json_success', []rt.PhpVal{})
}

fn wp_ajax_save_attachment_compat() {
	mut var_id := rt.new_null()
	mut var_attachment_data := rt.new_null()
	mut var_post := rt.new_null()
	mut var_errors := rt.new_null()
	mut var_taxonomy := rt.new_null()
	mut var_attachment := rt.new_null()
	if !(rt.get_superglobal('_REQUEST').array_isset(rt.new_string('id'))) {
		rt.call_function('wp_send_json_error', []rt.PhpVal{})
	}
	var_id = rt.call_function('absint',
		[rt.get_superglobal('_REQUEST').array_get(rt.new_string('id'))])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_id)))) {
		rt.call_function('wp_send_json_error', []rt.PhpVal{})
	}
	if !rt.is_true(rt.get_superglobal('_REQUEST').array_get(rt.new_string('attachments')))
		|| !rt.is_true(rt.get_superglobal('_REQUEST').array_get(rt.new_string('attachments')).array_get(var_id)) {
		rt.call_function('wp_send_json_error', []rt.PhpVal{})
	}
	var_attachment_data =
		rt.get_superglobal('_REQUEST').array_get(rt.new_string('attachments')).array_get(var_id)
	rt.call_function('check_ajax_referer', [
		rt.new_string('update-post_' + var_id.str()),
		rt.new_string('nonce'),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('edit_post'),
		var_id.clone(),
	])))))
	{
		rt.call_function('wp_send_json_error', []rt.PhpVal{})
	}
	var_post = rt.call_function('get_post', [var_id.clone(), rt.get_constant('ARRAY_A')])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('attachment'),
		var_post.array_get(rt.new_string('post_type'))))))
	{
		rt.call_function('wp_send_json_error', []rt.PhpVal{})
	}
	var_post = rt.call_function('apply_filters', [
		rt.new_string('attachment_fields_to_save'),
		var_post.clone(),
		var_attachment_data.clone(),
	])
	if var_post.array_isset(rt.new_string('errors')) {
		var_errors = var_post.array_get(rt.new_string('errors'))
		var_post.array_unset(rt.new_string('errors'))
	}
	rt.call_function('wp_update_post', [var_post.clone()])
	mut iter_17 := rt.call_function('get_attachment_taxonomies', [
		var_post.clone()]).iterator()
	for {
		item_17 := iter_17.next() or { break }
		mut var_taxonomy_shadow := item_17.val
		if var_attachment_data.array_isset(var_taxonomy_shadow) {
			rt.call_function('wp_set_object_terms', [var_id.clone(),
				rt.call_function('array_map', [rt.new_string('trim'),
					rt.call_function('preg_split', [rt.new_string('/,+/'),
						var_attachment_data.array_get(var_taxonomy_shadow)])]),
				var_taxonomy_shadow.clone(), rt.new_bool(false)])
		}
	}
	var_attachment = rt.call_function('wp_prepare_attachment_for_js', [
		var_id.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_attachment)))) {
		rt.call_function('wp_send_json_error', []rt.PhpVal{})
	}
	rt.call_function('wp_send_json_success', [var_attachment.clone()])
}

fn wp_ajax_save_attachment_order() {
	mut var_post_id := rt.new_null()
	mut var_attachments := rt.new_null()
	mut var_menu_order := rt.new_null()
	mut var_attachment_id := rt.new_null()
	mut var_attachment := rt.new_null()
	if !(rt.get_superglobal('_REQUEST').array_isset(rt.new_string('post_id'))) {
		rt.call_function('wp_send_json_error', []rt.PhpVal{})
	}
	var_post_id = rt.call_function('absint',
		[rt.get_superglobal('_REQUEST').array_get(rt.new_string('post_id'))])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_post_id)))) {
		rt.call_function('wp_send_json_error', []rt.PhpVal{})
	}
	if !rt.is_true(rt.get_superglobal('_REQUEST').array_get(rt.new_string('attachments'))) {
		rt.call_function('wp_send_json_error', []rt.PhpVal{})
	}
	rt.call_function('check_ajax_referer', [
		rt.new_string('update-post_' + var_post_id.str()),
		rt.new_string('nonce'),
	])
	var_attachments = rt.get_superglobal('_REQUEST').array_get(rt.new_string('attachments'))
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('edit_post'),
		var_post_id.clone(),
	])))))
	{
		rt.call_function('wp_send_json_error', []rt.PhpVal{})
	}
	mut iter_18 := var_attachments.iterator()
	for {
		item_18 := iter_18.next() or { break }
		mut var_menu_order_shadow := item_18.val
		mut var_attachment_id_shadow := item_18.key
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
			rt.new_string('edit_post'),
			var_attachment_id_shadow.clone(),
		])))))
		{
			continue
		}
		var_attachment = rt.call_function('get_post', [var_attachment_id_shadow.clone()])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_attachment)))) {
			continue
		}
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('attachment'), rt.get_property(var_attachment,
			'post_type')))))
		{
			continue
		}
		rt.call_function('wp_update_post', [
			rt.create_array([rt.ArrayItem{ key: 'ID', val: var_attachment_id_shadow },
				rt.ArrayItem{ key: 'menu_order', val: var_menu_order_shadow }]),
		])
	}
	rt.call_function('wp_send_json_success', []rt.PhpVal{})
}

fn wp_ajax_send_attachment_to_editor() {
	mut var_attachment := rt.new_null()
	mut var_id := rt.new_null()
	mut var_post := rt.new_null()
	mut var_insert_into_post_id := rt.new_null()
	mut var_url := rt.new_null()
	mut var_rel := rt.new_null()
	mut var_align := rt.new_null()
	mut var_size := rt.new_null()
	mut var_alt := rt.new_null()
	mut var_caption := rt.new_null()
	mut var_title := ''
	mut var_html := rt.new_null()
	rt.call_function('check_ajax_referer', [rt.new_string('media-send-to-editor'),
		rt.new_string('nonce')])
	var_attachment = rt.call_function('wp_unslash', [
		rt.get_superglobal('_POST').array_get(rt.new_string('attachment')),
	])
	var_id = rt.new_int((var_attachment.array_get(rt.new_string('id'))).to_i64())
	var_post = rt.call_function('get_post', [var_id.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_post)))) {
		rt.call_function('wp_send_json_error', []rt.PhpVal{})
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('attachment'), rt.get_property(var_post,
		'post_type')))))
	{
		rt.call_function('wp_send_json_error', []rt.PhpVal{})
	}
	if rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_post'),
		var_id.clone()]))
	{
		var_insert_into_post_id =
			rt.new_int((rt.get_superglobal('_POST').array_get(rt.new_string('post_id'))).to_i64())
		if rt.is_true(rt.identical(rt.new_int(0), rt.get_property(var_post, 'post_parent')))
			&& rt.is_true(var_insert_into_post_id) {
			rt.call_function('wp_update_post', [
				rt.create_array([rt.ArrayItem{ key: 'ID', val: var_id },
					rt.ArrayItem{ key: 'post_parent', val: var_insert_into_post_id }]),
			])
		}
	}
	var_url = if !rt.is_true(var_attachment.array_get(rt.new_string('url'))) {
		rt.new_string('')
	} else {
		var_attachment.array_get(rt.new_string('url'))
	}
	var_rel = rt.new_bool(
		rt.is_true(rt.call_function('str_contains', [var_url.clone(), rt.new_string('attachment_id')]))
		|| rt.is_true(rt.identical(rt.call_function('get_attachment_link', [var_id.clone()]), var_url)))
	rt.call_function('remove_filter', [rt.new_string('media_send_to_editor'),
		rt.new_string('image_media_send_to_editor')])
	if rt.is_true(rt.call_function('str_starts_with', [
		rt.get_property(var_post, 'post_mime_type'),
		rt.new_string('image'),
	]))
	{
		var_align = if !(var_attachment.array_get(rt.new_string('align'))).is_null() {
			var_attachment.array_get(rt.new_string('align'))
		} else {
			rt.new_string('none')
		}
		var_size = if !(var_attachment.array_get(rt.new_string('image-size'))).is_null() {
			var_attachment.array_get(rt.new_string('image-size'))
		} else {
			rt.new_string('medium')
		}
		var_alt = if !(var_attachment.array_get(rt.new_string('image_alt'))).is_null() {
			var_attachment.array_get(rt.new_string('image_alt'))
		} else {
			rt.new_string('')
		}
		var_caption = if !(var_attachment.array_get(rt.new_string('post_excerpt'))).is_null() {
			var_attachment.array_get(rt.new_string('post_excerpt'))
		} else {
			rt.new_string('')
		}
		if rt.is_true(rt.identical(rt.new_string(''),
			rt.new_string(var_caption.clone().to_string().trim_space())))
		{
			var_caption = rt.new_string('')
		}
		var_title = ''
		var_html = rt.call_function('get_image_send_to_editor', [
			var_id.clone(), var_caption.clone(), rt.new_string(var_title.str()).clone(),
			var_align.clone(), var_url.clone(), var_rel.clone(),
			var_size.clone(), var_alt.clone()])
	} else if
		rt.is_true(rt.call_function('wp_attachment_is', [rt.new_string('video'), var_post.clone()]))
		|| rt.is_true(rt.call_function('wp_attachment_is', [rt.new_string('audio'), var_post.clone()])) {
		var_html = rt.call_function('stripslashes_deep', [
			rt.get_superglobal('_POST').array_get(rt.new_string('html')),
		])
	} else {
		var_html = if !(var_attachment.array_get(rt.new_string('post_title'))).is_null() {
			var_attachment.array_get(rt.new_string('post_title'))
		} else {
			rt.new_string('')
		}
		var_rel = rt.new_string((if rt.is_true(var_rel) {
			' rel="attachment wp-att-' + var_id.str() + '"'
		} else {
			''
		}).str())
		if !(!rt.is_true(var_url)) {
			var_html = rt.new_string('<a href="' +
				(rt.call_function('esc_url', [var_url.clone()])).str() + '"' + var_rel.str() + '>' +
				var_html.str() + '</a>')
		}
	}
	var_html = rt.call_function('apply_filters', [rt.new_string('media_send_to_editor'),
		var_html.clone(), var_id.clone(), var_attachment.clone()])
	rt.call_function('wp_send_json_success', [var_html.clone()])
}

fn wp_ajax_send_link_to_editor() {
	mut var_wp_embed := rt.new_null()
	mut var_src := rt.new_null()
	mut var_link_text := rt.new_null()
	mut var_post := rt.new_null()
	mut var_check_embed := rt.new_null()
	mut var_fallback := rt.new_null()
	mut var_html := rt.new_null()
	mut var_type := rt.new_null()
	mut var_extension := rt.new_null()
	mut var_extension_type := rt.new_null()
	rt.call_function('check_ajax_referer', [rt.new_string('media-send-to-editor'),
		rt.new_string('nonce')])
	var_src = rt.call_function('wp_unslash',
		[rt.get_superglobal('_POST').array_get(rt.new_string('src'))])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_src)))) {
		rt.call_function('wp_send_json_error', []rt.PhpVal{})
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('strpos', [
		var_src.clone(), rt.new_string('://')])))))
	{
		var_src = rt.new_string('http://' + var_src.str())
	}
	var_src = rt.call_function('sanitize_url', [var_src.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_src)))) {
		rt.call_function('wp_send_json_error', []rt.PhpVal{})
	}
	var_link_text = rt.new_string(rt.call_function('wp_unslash', [
		rt.get_superglobal('_POST').array_get(rt.new_string('link_text')),
	]).to_string().trim_space())
	if rt.is_true(rt.new_bool(!(rt.is_true(var_link_text)))) {
		var_link_text = rt.call_function('wp_basename', [var_src.clone()])
	}
	var_post = rt.call_function('get_post', [if !(rt.get_superglobal('_POST').array_get(rt.new_string('post_id'))).is_null() {
		rt.get_superglobal('_POST').array_get(rt.new_string('post_id'))
	} else {
		rt.new_int(0)
	}])
	var_check_embed = rt.call_method(var_wp_embed, 'run_shortcode', [
		rt.new_string('[embed]' + var_src.str() + '[/embed]'),
	])
	var_fallback = rt.call_method(var_wp_embed, 'maybe_make_link', [
		var_src.clone()])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_check_embed, var_fallback)))) {
		var_html = rt.new_string('[embed]' + var_src.str() + '[/embed]')
	} else if rt.is_true(var_link_text) {
		var_html = rt.new_string('<a href="' +
			(rt.call_function('esc_url', [var_src.clone()])).str() + '">' + var_link_text.str() +
			'</a>')
	} else {
		var_html = rt.new_string('')
	}
	var_type = rt.new_string('file')
	var_extension = rt.call_function('preg_replace', [rt.new_string('/^.+?\\.([^.]+)$/'),
		rt.new_string('$1'), var_src.clone()])
	if rt.is_true(var_extension) {
		var_extension_type = rt.call_function('wp_ext2type', [
			var_extension.clone()])
		if rt.is_true(rt.identical(rt.new_string('audio'), var_extension_type))
			|| rt.is_true(rt.identical(rt.new_string('video'), var_extension_type)) {
			var_type = var_extension_type.clone()
		}
	}
	var_html = rt.call_function('apply_filters', [
		rt.new_string('${var_type.to_string()}_send_to_editor_url'),
		var_html.clone(),
		var_src.clone(),
		var_link_text.clone(),
	])
	rt.call_function('wp_send_json_success', [var_html.clone()])
}

fn wp_ajax_heartbeat() {
	mut var_response := rt.new_null()
	mut var_data := rt.new_null()
	mut var_nonce_state := rt.new_null()
	mut var_screen_id := rt.new_null()
	if !rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('_nonce'))) {
		rt.call_function('wp_send_json_error', []rt.PhpVal{})
	}
	var_response = rt.new_array()
	var_data = rt.new_array()
	var_nonce_state = rt.call_function('wp_verify_nonce', [
		rt.get_superglobal('_POST').array_get(rt.new_string('_nonce')),
		rt.new_string('heartbeat-nonce'),
	])
	if !(!rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('screen_id')))) {
		var_screen_id = rt.call_function('sanitize_key', [
			rt.get_superglobal('_POST').array_get(rt.new_string('screen_id')),
		])
	} else {
		var_screen_id = rt.new_string('front')
	}
	if !(!rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('data')))) {
		var_data = rt.call_function('wp_unslash', [
			rt.cast_array(rt.get_superglobal('_POST').array_get(rt.new_string('data'))),
		])
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int(1), var_nonce_state)))) {
		var_response = rt.call_function('apply_filters', [
			rt.new_string('wp_refresh_nonces'),
			var_response.clone(),
			var_data.clone(),
			var_screen_id.clone(),
		])
		if rt.is_true(rt.identical(rt.new_bool(false), var_nonce_state)) {
			var_response.array_set('nonces_expired', true)
			rt.call_function('wp_send_json', [var_response.clone()])
		}
	}
	if !(!rt.is_true(var_data)) {
		var_response = rt.call_function('apply_filters', [
			rt.new_string('heartbeat_received'),
			var_response.clone(),
			var_data.clone(),
			var_screen_id.clone(),
		])
	}
	var_response = rt.call_function('apply_filters', [rt.new_string('heartbeat_send'),
		var_response.clone(), var_screen_id.clone()])
	rt.call_function('do_action', [rt.new_string('heartbeat_tick'),
		var_response.clone(), var_screen_id.clone()])
	var_response.array_set('server_time', rt.call_function('time', []rt.PhpVal{}))
	rt.call_function('wp_send_json', [var_response.clone()])
}

fn wp_ajax_get_revision_diffs() {
	mut var_compare_from := rt.new_null()
	mut var_compare_to := rt.new_null()
	mut var_post := rt.new_null()
	mut var_revisions := rt.new_null()
	mut var_return := rt.new_null()
	mut var_compare_key := rt.new_null()
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/revision.php', '3')
	var_post = rt.call_function('get_post', [
		rt.new_int((rt.get_superglobal('_REQUEST').array_get(rt.new_string('post_id'))).to_i64()),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_post)))) {
		rt.call_function('wp_send_json_error', []rt.PhpVal{})
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('edit_post'),
		rt.get_property(var_post, 'ID'),
	])))))
	{
		rt.call_function('wp_send_json_error', []rt.PhpVal{})
	}
	var_revisions = rt.call_function('wp_get_post_revisions', [
		rt.get_property(var_post, 'ID'),
		rt.create_array([rt.ArrayItem{ key: 'check_enabled', val: false }]),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_revisions)))) {
		rt.call_function('wp_send_json_error', []rt.PhpVal{})
	}
	var_return = rt.new_array()
	if rt.is_true(rt.call_function('function_exists', [rt.new_string('set_time_limit')])) {
		rt.call_function('set_time_limit', [
			rt.mul(rt.new_int(5), rt.get_constant('MINUTE_IN_SECONDS')),
		])
	}
	mut iter_19 := rt.get_superglobal('_REQUEST').array_get(rt.new_string('compare')).iterator()
	for {
		item_19 := iter_19.next() or { break }
		mut var_compare_key_shadow := item_19.val
		mut list_tmp_1 := rt.call_function('explode', [rt.new_string(':'),
			var_compare_key_shadow.clone()])
		var_compare_from = list_tmp_1.array_get(0)
		var_compare_to = list_tmp_1.array_get(1)
		var_return.array_push(rt.create_array([
			rt.ArrayItem{ key: 'id', val: var_compare_key_shadow },
			rt.ArrayItem{ key: 'fields', val: rt.call_function('wp_get_revision_ui_diff', [
				var_post.clone(),
				var_compare_from.clone(),
				var_compare_to.clone(),
			]) },
		]))
	}
	rt.call_function('wp_send_json_success', [var_return.clone()])
}

fn wp_ajax_save_user_color_scheme() {
	mut var__wp_admin_css_colors := rt.new_null()
	mut var_color_scheme := rt.new_null()
	mut var_previous_color_scheme := rt.new_null()
	rt.call_function('check_ajax_referer', [rt.new_string('save-color-scheme'),
		rt.new_string('nonce')])
	var_color_scheme = rt.call_function('sanitize_key', [
		rt.get_superglobal('_POST').array_get(rt.new_string('color_scheme')),
	])
	if !(var__wp_admin_css_colors.array_isset(var_color_scheme)) {
		rt.call_function('wp_send_json_error', []rt.PhpVal{})
	}
	var_previous_color_scheme = rt.call_function('get_user_meta', [
		rt.call_function('get_current_user_id', []rt.PhpVal{}),
		rt.new_string('admin_color'),
		rt.new_bool(true),
	])
	rt.call_function('update_user_meta', [
		rt.call_function('get_current_user_id', []rt.PhpVal{}),
		rt.new_string('admin_color'),
		var_color_scheme.clone(),
	])
	rt.call_function('wp_send_json_success', [
		rt.create_array([
			rt.ArrayItem{ key: 'previousScheme', val: 'admin-color-' +
				var_previous_color_scheme.str() },
			rt.ArrayItem{ key: 'currentScheme', val: 'admin-color-' + var_color_scheme.str() },
		]),
	])
}

fn wp_ajax_query_themes() {
	mut var_themes_allowedtags := rt.new_null()
	mut var_theme_field_defaults := rt.new_null()
	mut var_args := rt.new_null()
	mut var_user := rt.new_null()
	mut var_old_filter := rt.new_null()
	mut var_api := rt.new_null()
	mut var_update_php := rt.new_null()
	mut var_installed_themes := rt.new_null()
	mut var_theme_data := rt.new_null()
	mut var_theme_slug := rt.new_null()
	mut var_theme := rt.new_null()
	mut var_is_theme_installed := false
	mut var_customize_url := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('install_themes'),
	])))))
	{
		rt.call_function('wp_send_json_error', []rt.PhpVal{})
	}
	var_args = rt.call_function('wp_parse_args', [
		rt.call_function('wp_unslash',
			[rt.get_superglobal('_REQUEST').array_get(rt.new_string('request'))]),
		rt.create_array([rt.ArrayItem{ key: 'per_page', val: 20 },
			rt.ArrayItem{ key: 'fields', val: rt.call_function('array_merge', [
				rt.cast_array(var_theme_field_defaults),
				rt.create_array([rt.ArrayItem{ key: 'reviews_url', val: true }]),
			]) }]),
	])
	if var_args.array_isset(rt.new_string('browse'))
		&& rt.is_true(rt.identical(rt.new_string('favorites'), var_args.array_get(rt.new_string('browse'))))
		&& !(var_args.array_isset(rt.new_string('user'))) {
		var_user = rt.call_function('get_user_option', [rt.new_string('wporg_favorites')])
		if rt.is_true(var_user) {
			var_args.array_set('user', var_user.clone())
		}
	}
	var_old_filter = if !(var_args.array_get(rt.new_string('browse'))).is_null() {
		var_args.array_get(rt.new_string('browse'))
	} else {
		rt.new_string('search')
	}
	var_args = rt.call_function('apply_filters', [
		rt.new_string('install_themes_table_api_args_' + var_old_filter.str()),
		var_args.clone(),
	])
	var_api = rt.call_function('themes_api', [rt.new_string('query_themes'),
		var_args.clone()])
	if rt.is_true(rt.call_function('is_wp_error', [var_api.clone()])) {
		rt.call_function('wp_send_json_error', []rt.PhpVal{})
	}
	var_update_php = rt.call_function('network_admin_url', [
		rt.new_string('update.php?action=install-theme'),
	])
	var_installed_themes = rt.call_function('search_theme_directories', []rt.PhpVal{})
	if rt.is_true(rt.identical(rt.new_bool(false), var_installed_themes)) {
		var_installed_themes = rt.new_array()
	}
	mut iter_20 := var_installed_themes.iterator()
	for {
		item_20 := iter_20.next() or { break }
		mut var_theme_data_shadow := item_20.val
		mut var_theme_slug_shadow := item_20.key
		if rt.is_true(rt.call_function('str_contains', [var_theme_slug_shadow.clone(),
			rt.new_string('/')]))
		{
			var_installed_themes.array_unset(var_theme_slug_shadow)
		}
	}
	mut iter_21 := rt.get_property(var_api, 'themes').iterator()
	for {
		item_21 := iter_21.next() or { break }
		mut var_theme_shadow := item_21.val
		rt.set_property(var_theme_shadow, 'install_url', rt.call_function('add_query_arg', [
			rt.create_array([
				rt.ArrayItem{ key: 'theme', val: rt.get_property(var_theme_shadow, 'slug') },
				rt.ArrayItem{ key: '_wpnonce', val: rt.call_function('wp_create_nonce', [
					rt.new_string('install-theme_' +
						(rt.get_property(var_theme_shadow, 'slug')).str()),
				]) },
			]),
			var_update_php.clone(),
		]))
		if rt.is_true(rt.call_function('current_user_can', [
			rt.new_string('switch_themes'),
		]))
		{
			if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) {
				rt.set_property(var_theme_shadow, 'activate_url', rt.call_function('add_query_arg', [
					rt.create_array([rt.ArrayItem{ key: 'action', val: 'enable' },
						rt.ArrayItem{ key: '_wpnonce', val: rt.call_function('wp_create_nonce', [
							rt.new_string('enable-theme_' +
								(rt.get_property(var_theme_shadow, 'slug')).str()),
						]) }, rt.ArrayItem{ key: 'theme', val: rt.get_property(var_theme_shadow,
							'slug') }]),
					rt.call_function('network_admin_url', [rt.new_string('themes.php')]),
				]))
			} else {
				rt.set_property(var_theme_shadow, 'activate_url', rt.call_function('add_query_arg', [
					rt.create_array([rt.ArrayItem{ key: 'action', val: 'activate' },
						rt.ArrayItem{ key: '_wpnonce', val: rt.call_function('wp_create_nonce', [
							rt.new_string('switch-theme_' +
								(rt.get_property(var_theme_shadow, 'slug')).str()),
						]) }, rt.ArrayItem{ key: 'stylesheet', val: rt.get_property(var_theme_shadow,
							'slug') }]),
					rt.call_function('admin_url', [rt.new_string('themes.php')]),
				]))
			}
		}
		var_is_theme_installed = var_installed_themes.clone().array_isset(rt.get_property(var_theme_shadow,
			'slug'))
		rt.set_property(var_theme_shadow, 'block_theme', rt.new_bool(var_is_theme_installed
			&& rt.is_true(rt.call_method(rt.call_function('wp_get_theme', [rt.get_property(var_theme_shadow, 'slug')]), 'is_block_theme', []rt.PhpVal{}))))
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})))))
			&& rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_theme_options')]))
			&& rt.is_true(rt.call_function('current_user_can', [rt.new_string('customize')])) {
			var_customize_url = if rt.is_true(rt.get_property(var_theme_shadow, 'block_theme')) { rt.call_function('admin_url', [
					rt.new_string('site-editor.php'),
				]) } else { rt.call_function('wp_customize_url', [
					rt.get_property(var_theme_shadow, 'slug'),
				]) }
			rt.set_property(var_theme_shadow, 'customize_url', rt.call_function('add_query_arg', [
				rt.create_array([
					rt.ArrayItem{ key: 'return', val: rt.call_function('urlencode', [
						rt.call_function('network_admin_url', [
							rt.new_string('theme-install.php'),
							rt.new_string('relative'),
						]),
					]) },
				]),
				var_customize_url.clone(),
			]))
		}
		rt.set_property(var_theme_shadow, 'name', rt.call_function('wp_kses', [
			rt.get_property(var_theme_shadow, 'name'),
			var_themes_allowedtags.clone(),
		]))
		rt.set_property(var_theme_shadow, 'author', rt.call_function('wp_kses', [
			rt.get_property(var_theme_shadow, 'author').array_get(rt.new_string('display_name')),
			var_themes_allowedtags.clone(),
		]))
		rt.set_property(var_theme_shadow, 'version', rt.call_function('wp_kses', [
			rt.get_property(var_theme_shadow, 'version'),
			var_themes_allowedtags.clone(),
		]))
		rt.set_property(var_theme_shadow, 'description', rt.call_function('wp_kses', [
			rt.get_property(var_theme_shadow, 'description'),
			var_themes_allowedtags.clone(),
		]))
		rt.set_property(var_theme_shadow, 'stars', rt.call_function('wp_star_rating', [
			rt.create_array([
				rt.ArrayItem{ key: 'rating', val: rt.get_property(var_theme_shadow, 'rating') },
				rt.ArrayItem{ key: 'type', val: 'percent' },
				rt.ArrayItem{ key: 'number', val: rt.get_property(var_theme_shadow, 'num_ratings') },
				rt.ArrayItem{ key: 'echo', val: false },
			]),
		]))
		rt.set_property(var_theme_shadow, 'num_ratings', rt.call_function('number_format_i18n', [
			rt.get_property(var_theme_shadow, 'num_ratings'),
		]))
		rt.set_property(var_theme_shadow, 'preview_url', rt.call_function('set_url_scheme', [
			rt.get_property(var_theme_shadow, 'preview_url'),
		]))
		rt.set_property(var_theme_shadow, 'compatible_wp', rt.call_function('is_wp_version_compatible', [
			rt.get_property(var_theme_shadow, 'requires'),
		]))
		rt.set_property(var_theme_shadow, 'compatible_php', rt.call_function('is_php_version_compatible', [
			rt.get_property(var_theme_shadow, 'requires_php'),
		]))
	}
	rt.call_function('wp_send_json_success', [var_api.clone()])
}

fn wp_ajax_parse_embed() {
	mut var_wp_embed := rt.new_null()
	mut var_matches := []rt.PhpVal{}
	mut var_wp_scripts := rt.new_null()
	mut var_post_id := rt.new_null()
	mut var_post := rt.new_null()
	mut var_shortcode := rt.new_null()
	mut var_atts := rt.new_null()
	mut var_url := rt.new_null()
	mut var_parsed := rt.new_null()
	mut var_ssl_shortcode := rt.new_null()
	mut var_no_ssl_support := false
	mut var_content_width := rt.new_null()
	mut var_styles := ''
	mut var_mce_styles := rt.new_null()
	mut var_style := rt.new_null()
	mut var_html := rt.new_null()
	mut var_scripts := rt.new_null()
	mut var_return := rt.new_null()
	mut var_script_src := rt.new_null()
	if !rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('shortcode'))) {
		rt.call_function('wp_send_json_error', []rt.PhpVal{})
	}
	var_post_id = rt.new_int(if rt.get_superglobal('_POST').array_isset(rt.new_string('post_ID')) {
		rt.new_int((rt.get_superglobal('_POST').array_get(rt.new_string('post_ID'))).to_i64())
	} else {
		0
	})
	if rt.is_true(rt.greater(var_post_id, rt.new_int(0))) {
		var_post = rt.call_function('get_post', [var_post_id.clone()])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_post))))
			|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_post'), rt.get_property(var_post, 'ID')]))))) {
			rt.call_function('wp_send_json_error', []rt.PhpVal{})
		}
		rt.call_function('setup_postdata', [var_post.clone()])
	} else if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('edit_posts'),
	])))))
	{
		rt.call_function('wp_send_json_error', []rt.PhpVal{})
	}
	var_shortcode = rt.call_function('wp_unslash', [
		rt.get_superglobal('_POST').array_get(rt.new_string('shortcode')),
	])
	rt.call_function('preg_match', [
		rt.new_string('/' + (rt.call_function('get_shortcode_regex', []rt.PhpVal{})).str() + '/s'),
		var_shortcode.clone(),
		rt.create_array_from_list(var_matches),
	])
	var_atts = rt.call_function('shortcode_parse_atts', [var_matches[3]])
	if !(!rt.is_true(var_matches[5])) {
		var_url = var_matches[5]
	} else if !(!rt.is_true(var_atts.array_get(rt.new_string('src')))) {
		var_url = var_atts.array_get(rt.new_string('src'))
	} else {
		var_url = rt.new_string('')
	}
	var_parsed = rt.new_bool(false)
	rt.set_property(var_wp_embed, 'return_false_on_fail', rt.new_bool(true))
	if rt.is_true(rt.identical(rt.new_int(0), var_post_id)) {
		rt.set_property(var_wp_embed, 'usecache', rt.new_bool(false))
	}
	if rt.is_true(rt.call_function('is_ssl', []rt.PhpVal{}))
		&& rt.is_true(rt.call_function('str_starts_with', [var_url.clone(), rt.new_string('http://')])) {
		var_ssl_shortcode = rt.call_function('preg_replace', [
			rt.new_string('%^(\\[embed[^\\]]*\\])http://%i'),
			rt.new_string('$1https://'),
			var_shortcode.clone(),
		])
		var_parsed = rt.call_method(var_wp_embed, 'run_shortcode', [
			var_ssl_shortcode.clone()])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_parsed)))) {
			var_no_ssl_support = true
		}
	}
	if rt.get_superglobal('_POST').array_isset(rt.new_string('maxwidth'))
		&& rt.get_superglobal('_POST').array_get(rt.new_string('maxwidth')).is_long()
		|| rt.get_superglobal('_POST').array_get(rt.new_string('maxwidth')).is_double()
		&& rt.is_true(rt.greater(rt.get_superglobal('_POST').array_get(rt.new_string('maxwidth')), rt.new_int(0))) {
		if !(!var_content_width.is_null()) {
			var_content_width =
				rt.new_int((rt.get_superglobal('_POST').array_get(rt.new_string('maxwidth'))).to_i64())
		} else {
			var_content_width = rt.call_function('min', [var_content_width.clone(),
				rt.new_int((rt.get_superglobal('_POST').array_get(rt.new_string('maxwidth'))).to_i64())])
		}
	}
	if rt.is_true(var_url) && rt.is_true(rt.new_bool(!(rt.is_true(var_parsed)))) {
		var_parsed = rt.call_method(var_wp_embed, 'run_shortcode', [
			var_shortcode.clone()])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_parsed)))) {
		rt.call_function('wp_send_json_error', [
			rt.create_array([rt.ArrayItem{ key: 'type', val: 'not-embeddable' },
				rt.ArrayItem{ key: 'message', val: rt.call_function('sprintf', [
					rt.call_function('__', [rt.new_string('%s failed to embed.')]),
					rt.new_string('<code>' +
						(rt.call_function('esc_html', [var_url.clone()])).str() + '</code>'),
				]) }]),
		])
	}
	if rt.is_true(rt.call_function('has_shortcode', [var_parsed.clone(), rt.new_string('audio')]))
		|| rt.is_true(rt.call_function('has_shortcode', [var_parsed.clone(), rt.new_string('video')])) {
		var_styles = ''
		var_mce_styles = rt.call_function('wpview_media_sandbox_styles', []rt.PhpVal{})
		mut iter_22 := var_mce_styles.iterator()
		for {
			item_22 := iter_22.next() or { break }
			mut var_style_shadow := item_22.val
			var_styles = var_styles +(rt.call_function('sprintf', [rt.new_string('<link rel="stylesheet" href="%s" />'), var_style_shadow.clone()])).str()
		}
		var_html = rt.call_function('do_shortcode', [var_parsed.clone()])
		if !(!rt.is_true(var_wp_scripts)) {
			rt.set_property(var_wp_scripts, 'done', rt.new_array())
		}
		rt.call_function('ob_start', []rt.PhpVal{})
		rt.call_function('wp_print_scripts', [
			rt.create_array([rt.ArrayItem{ key: none, val: 'mediaelement-vimeo' },
				rt.ArrayItem{ key: none, val: 'wp-mediaelement' }]),
		])
		var_scripts = rt.call_function('ob_get_clean', []rt.PhpVal{})
		var_parsed = rt.new_string((var_styles + var_html.str() + var_scripts.str()).str())
	}
	if !(!var_no_ssl_support)
		|| (rt.is_true(rt.call_function('is_ssl', []rt.PhpVal{}))
		&& rt.is_true(rt.call_function('preg_match', [rt.new_string('%<(iframe|script|embed) [^>]*src="http://%'), var_parsed.clone()]))
		|| rt.is_true(rt.call_function('preg_match', [rt.new_string('%<link [^>]*href="http://%'), var_parsed.clone()]))) {
		rt.call_function('wp_send_json_error', [
			rt.create_array([rt.ArrayItem{ key: 'type', val: 'not-ssl' },
				rt.ArrayItem{ key: 'message', val: rt.call_function('__', [
					rt.new_string('This preview is unavailable in the editor.'),
				]) }]),
		])
	}
	var_return = rt.create_array([rt.ArrayItem{ key: 'body', val: var_parsed },
		rt.ArrayItem{ key: 'attr', val: rt.get_property(var_wp_embed, 'last_attr') }])
	if rt.is_true(rt.call_function('str_contains', [var_parsed.clone(),
		rt.new_string('class="wp-embedded-content')]))
	{
		if rt.is_true(rt.call_function('defined', [rt.new_string('SCRIPT_DEBUG')]))
			&& rt.is_true(rt.get_constant('SCRIPT_DEBUG')) {
			var_script_src = rt.call_function('includes_url', [
				rt.new_string('js/wp-embed.js'),
			])
		} else {
			var_script_src = rt.call_function('includes_url', [
				rt.new_string('js/wp-embed.min.js'),
			])
		}
		var_return.array_set('head', '<script src="' + var_script_src.str() + '"></script>')
		var_return.array_set('sandbox', true)
	}
	rt.call_function('wp_send_json_success', [var_return.clone()])
}

fn wp_ajax_parse_media_shortcode() {
	mut var_wp_scripts := rt.new_null()
	mut var_shortcode := rt.new_null()
	mut var_found_shortcodes := rt.new_null()
	mut var_media_shortcodes := []rt.PhpVal{}
	mut var_other_shortcodes := rt.new_null()
	mut var_post := rt.new_null()
	mut var_parsed := rt.new_null()
	mut var_head := ''
	mut var_styles := rt.new_null()
	mut var_style := rt.new_null()
	if !rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('shortcode'))) {
		rt.call_function('wp_send_json_error', []rt.PhpVal{})
	}
	var_shortcode = rt.call_function('wp_unslash', [
		rt.get_superglobal('_POST').array_get(rt.new_string('shortcode')),
	])
	var_found_shortcodes = rt.call_function('get_shortcode_tags_in_content', [
		var_shortcode.clone()])
	var_media_shortcodes = ['audio', 'embed', 'playlist', 'video', 'gallery']
	var_other_shortcodes = rt.call_function('array_diff', [var_found_shortcodes.clone(),
		rt.create_array_from_list(var_media_shortcodes)])
	if !(!rt.is_true(var_other_shortcodes)) {
		rt.call_function('wp_send_json_error', []rt.PhpVal{})
	}
	if !(!rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('post_ID')))) {
		var_post = rt.call_function('get_post', [
			rt.new_int((rt.get_superglobal('_POST').array_get(rt.new_string('post_ID'))).to_i64()),
		])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_post))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_post'), rt.get_property(var_post, 'ID')]))))) {
		if rt.is_true(rt.call_function('in_array', [rt.new_string('embed'),
			var_found_shortcodes.clone(), rt.new_bool(true)]))
		{
			rt.call_function('wp_send_json_error', []rt.PhpVal{})
		}
	} else {
		rt.call_function('setup_postdata', [var_post.clone()])
	}
	var_parsed = rt.call_function('do_shortcode', [var_shortcode.clone()])
	if !rt.is_true(var_parsed) {
		rt.call_function('wp_send_json_error', [
			rt.create_array([rt.ArrayItem{ key: 'type', val: 'no-items' },
				rt.ArrayItem{ key: 'message', val: rt.call_function('__', [
					rt.new_string('No items found.'),
				]) }]),
		])
	}
	var_head = ''
	var_styles = rt.call_function('wpview_media_sandbox_styles', []rt.PhpVal{})
	mut iter_23 := var_styles.iterator()
	for {
		item_23 := iter_23.next() or { break }
		mut var_style_shadow := item_23.val
		var_head = var_head + '<link rel="stylesheet" href="' + var_style_shadow.str() + '">'
	}
	if !(!rt.is_true(var_wp_scripts)) {
		rt.set_property(var_wp_scripts, 'done', rt.new_array())
	}
	rt.call_function('ob_start', []rt.PhpVal{})
	rt.echo_val(var_parsed)
	if rt.is_true(rt.identical(rt.new_string('playlist'),
		rt.get_superglobal('_REQUEST').array_get(rt.new_string('type'))))
	{
		rt.call_function('wp_underscore_playlist_templates', []rt.PhpVal{})
		rt.call_function('wp_print_scripts', [rt.new_string('wp-playlist')])
	} else {
		rt.call_function('wp_print_scripts', [
			rt.create_array([rt.ArrayItem{ key: none, val: 'mediaelement-vimeo' },
				rt.ArrayItem{ key: none, val: 'wp-mediaelement' }]),
		])
	}
	rt.call_function('wp_send_json_success', [
		rt.create_array([rt.ArrayItem{ key: 'head', val: var_head },
			rt.ArrayItem{ key: 'body', val: rt.call_function('ob_get_clean', []rt.PhpVal{}) }]),
	])
}

fn wp_ajax_destroy_sessions() {
	mut var_user := rt.new_null()
	mut var_sessions := rt.new_null()
	mut var_message := rt.new_null()
	var_user = rt.call_function('get_userdata', [
		rt.new_int((rt.get_superglobal('_POST').array_get(rt.new_string('user_id'))).to_i64()),
	])
	if rt.is_true(var_user) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
			rt.new_string('edit_user'),
			rt.get_property(var_user, 'ID'),
		])))))
		{
			var_user = rt.new_bool(false)
		} else if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_verify_nonce', [
			rt.get_superglobal('_POST').array_get(rt.new_string('nonce')),
			rt.new_string('update-user_' + (rt.get_property(var_user, 'ID')).str()),
		])))))
		{
			var_user = rt.new_bool(false)
		}
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_user)))) {
		rt.call_function('wp_send_json_error', [
			rt.create_array([
				rt.ArrayItem{ key: 'message', val: rt.call_function('__', [
					rt.new_string('Could not log out user sessions. Please try again.'),
				]) },
			]),
		])
	}
	mut iife_temp_1 := Class_WP_Session_Tokens{}
	mut iife_result_1 := iife_temp_1.get_instance(rt.get_property(var_user, 'ID'))
	var_sessions = iife_result_1
	if rt.is_true(rt.identical(rt.call_function('get_current_user_id', []rt.PhpVal{}), rt.get_property(var_user,
		'ID')))
	{
		rt.call_method(var_sessions, 'destroy_others', [
			rt.call_function('wp_get_session_token', []rt.PhpVal{}),
		])
		var_message = rt.call_function('__', [
			rt.new_string('You are now logged out everywhere else.'),
		])
	} else {
		rt.call_method(var_sessions, 'destroy_all', []rt.PhpVal{})
		var_message = rt.call_function('sprintf', [
			rt.call_function('__', [rt.new_string('%s has been logged out.')]),
			rt.get_property(var_user, 'display_name'),
		])
	}
	rt.call_function('wp_send_json_success', [
		rt.create_array([rt.ArrayItem{ key: 'message', val: var_message }]),
	])
}

fn wp_ajax_crop_image() {
	mut var_attachment_id := rt.new_null()
	mut var_context := rt.new_null()
	mut var_data := rt.new_null()
	mut var_cropped := rt.new_null()
	mut var_wp_site_icon := rt.new_null()
	mut var_attachment := rt.new_null()
	mut var_metadata := rt.new_null()
	var_attachment_id = rt.call_function('absint',
		[rt.get_superglobal('_POST').array_get(rt.new_string('id'))])
	rt.call_function('check_ajax_referer', [
		rt.new_string('image_editor-' + var_attachment_id.str()),
		rt.new_string('nonce'),
	])
	if !rt.is_true(var_attachment_id)
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_post'), var_attachment_id.clone()]))))) {
		rt.call_function('wp_send_json_error', []rt.PhpVal{})
	}
	var_context = rt.call_function('str_replace', [rt.new_string('_'),
		rt.new_string('-'), rt.get_superglobal('_POST').array_get(rt.new_string('context'))])
	var_data = rt.call_function('array_map', [rt.new_string('absint'),
		rt.get_superglobal('_POST').array_get(rt.new_string('cropDetails'))])
	var_cropped = rt.call_function('wp_crop_image', [var_attachment_id.clone(),
		var_data.array_get(rt.new_string('x1')), var_data.array_get(rt.new_string('y1')),
		var_data.array_get(rt.new_string('width')), var_data.array_get(rt.new_string('height')),
		var_data.array_get(rt.new_string('dst_width')), var_data.array_get(rt.new_string('dst_height'))])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_cropped))))
		|| rt.is_true(rt.call_function('is_wp_error', [var_cropped.clone()])) {
		rt.call_function('wp_send_json_error', [
			rt.create_array([
				rt.ArrayItem{ key: 'message', val: rt.call_function('__', [
					rt.new_string('Image could not be processed.'),
				]) },
			]),
		])
	}
	mut switch_val_5 := var_context
	if rt.is_true(rt.equal(switch_val_5, rt.new_string('site-icon'))) {
		rt.include_file(
			(rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/class-wp-site-icon.php', '4')
		var_wp_site_icon = create_wp_site_icon()
		if rt.is_true(rt.identical(rt.call_function('get_post_meta', [
			var_attachment_id.clone(), rt.new_string('_wp_attachment_context'),
			rt.new_bool(true)]), var_context))
		{
			rt.call_function('wp_delete_file', [var_cropped.clone()])
			rt.call_function('add_filter', [rt.new_string('image_size_names_choose'),
				rt.create_array([rt.ArrayItem{ key: none, val: var_wp_site_icon },
					rt.ArrayItem{ key: none, val: 'additional_sizes' }])])
		}
		var_cropped = rt.call_function('apply_filters', [
			rt.new_string('wp_create_file_in_uploads'),
			var_cropped.clone(),
			var_attachment_id.clone(),
		])
		var_attachment = rt.call_function('wp_copy_parent_attachment_properties', [
			var_cropped.clone(),
			var_attachment_id.clone(),
			var_context.clone(),
		])
		rt.call_function('add_filter', [
			rt.new_string('intermediate_image_sizes_advanced'),
			rt.create_array([rt.ArrayItem{ key: none, val: var_wp_site_icon },
				rt.ArrayItem{ key: none, val: 'additional_sizes' }]),
		])
		var_attachment_id = var_wp_site_icon.insert_attachment(var_attachment.clone(),
			var_cropped.clone())
		rt.call_function('remove_filter', [
			rt.new_string('intermediate_image_sizes_advanced'),
			rt.create_array([rt.ArrayItem{ key: none, val: var_wp_site_icon },
				rt.ArrayItem{ key: none, val: 'additional_sizes' }]),
		])
		rt.call_function('add_filter', [rt.new_string('image_size_names_choose'),
			rt.create_array([rt.ArrayItem{ key: none, val: var_wp_site_icon },
				rt.ArrayItem{ key: none, val: 'additional_sizes' }])])
	} else {
		rt.call_function('do_action', [rt.new_string('wp_ajax_crop_image_pre_save'),
			var_context.clone(), var_attachment_id.clone(), var_cropped.clone()])
		var_cropped = rt.call_function('apply_filters', [
			rt.new_string('wp_create_file_in_uploads'),
			var_cropped.clone(),
			var_attachment_id.clone(),
		])
		var_attachment = rt.call_function('wp_copy_parent_attachment_properties', [
			var_cropped.clone(),
			var_attachment_id.clone(),
			var_context.clone(),
		])
		var_attachment_id = rt.call_function('wp_insert_attachment', [
			var_attachment.clone(), var_cropped.clone()])
		var_metadata = rt.call_function('wp_generate_attachment_metadata', [
			var_attachment_id.clone(), var_cropped.clone()])
		var_metadata = rt.call_function('apply_filters', [
			rt.new_string('wp_ajax_cropped_attachment_metadata'),
			var_metadata.clone(),
		])
		rt.call_function('wp_update_attachment_metadata', [var_attachment_id.clone(),
			var_metadata.clone()])
		var_attachment_id = rt.call_function('apply_filters', [
			rt.new_string('wp_ajax_cropped_attachment_id'),
			var_attachment_id.clone(),
			var_context.clone(),
		])
	}
	rt.call_function('wp_send_json_success', [
		rt.call_function('wp_prepare_attachment_for_js', [var_attachment_id.clone()]),
	])
}

fn wp_ajax_generate_password() {
	rt.call_function('wp_send_json_success', [
		rt.call_function('wp_generate_password', [rt.new_int(24)]),
	])
}

fn wp_ajax_nopriv_generate_password() {
	rt.call_function('wp_send_json_success', [
		rt.call_function('wp_generate_password', [rt.new_int(24)]),
	])
}

fn wp_ajax_save_wporg_username() {
	mut var_username := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('install_themes')])))))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('install_plugins')]))))) {
		rt.call_function('wp_send_json_error', []rt.PhpVal{})
	}
	rt.call_function('check_ajax_referer', [
		rt.new_string('save_wporg_username_' +
			(rt.call_function('get_current_user_id', []rt.PhpVal{})).str()),
	])
	var_username = if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('username')) { rt.call_function('wp_unslash', [
			rt.get_superglobal('_REQUEST').array_get(rt.new_string('username')),
		]) } else { rt.new_bool(false) }
	if rt.is_true(rt.new_bool(!(rt.is_true(var_username)))) {
		rt.call_function('wp_send_json_error', []rt.PhpVal{})
	}
	rt.call_function('wp_send_json_success', [
		rt.call_function('update_user_meta', [
			rt.call_function('get_current_user_id', []rt.PhpVal{}),
			rt.new_string('wporg_favorites'),
			var_username.clone(),
		]),
	])
}

fn wp_ajax_install_theme() {
	mut var_wp_filesystem := rt.new_null()
	mut var_slug := rt.new_null()
	mut var_status := rt.new_null()
	mut var_api := rt.new_null()
	mut var_skin := rt.new_null()
	mut var_upgrader := rt.new_null()
	mut var_result := rt.new_null()
	mut var_theme := rt.new_null()
	rt.call_function('check_ajax_referer', [rt.new_string('updates')])
	if !rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('slug'))) {
		rt.call_function('wp_send_json_error', [
			rt.create_array([rt.ArrayItem{ key: 'slug', val: '' },
				rt.ArrayItem{ key: 'errorCode', val: 'no_theme_specified' },
				rt.ArrayItem{ key: 'errorMessage', val: rt.call_function('__', [
					rt.new_string('No theme specified.'),
				]) }]),
		])
	}
	var_slug = rt.call_function('sanitize_key', [
		rt.call_function('wp_unslash',
			[rt.get_superglobal('_POST').array_get(rt.new_string('slug'))]),
	])
	var_status = rt.create_array([rt.ArrayItem{ key: 'install', val: 'theme' },
		rt.ArrayItem{ key: 'slug', val: var_slug }])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('install_themes'),
	])))))
	{
		var_status.array_set('errorMessage', rt.call_function('__', [
			rt.new_string('Sorry, you are not allowed to install themes on this site.'),
		]))
		rt.call_function('wp_send_json_error', [var_status.clone()])
	}
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/class-wp-upgrader.php',
		'4')
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/theme.php', '4')
	var_api = rt.call_function('themes_api', [rt.new_string('theme_information'),
		rt.create_array([rt.ArrayItem{ key: 'slug', val: var_slug },
			rt.ArrayItem{ key: 'fields', val: rt.create_array([
				rt.ArrayItem{ key: 'sections', val: false },
			]) }])])
	if rt.is_true(rt.call_function('is_wp_error', [var_api.clone()])) {
		var_status.array_set('errorMessage', rt.call_method(var_api, 'get_error_message',
			[]rt.PhpVal{}))
		rt.call_function('wp_send_json_error', [var_status.clone()])
	}
	var_skin = create_wp_ajax_upgrader_skin()
	var_upgrader = create_theme_upgrader(var_skin)
	var_result = rt.call_method(var_upgrader, 'install', [
		rt.get_property(var_api, 'download_link'),
	])
	if rt.is_true(rt.call_function('defined', [rt.new_string('WP_DEBUG')]))
		&& rt.is_true(rt.get_constant('WP_DEBUG')) {
		var_status.array_set('debug', var_skin.get_upgrade_messages())
	}
	if rt.is_true(rt.call_function('is_wp_error', [var_result.clone()])) {
		var_status.array_set('errorCode', rt.call_method(var_result, 'get_error_code',
			[]rt.PhpVal{}))
		var_status.array_set('errorMessage', rt.call_method(var_result, 'get_error_message',
			[]rt.PhpVal{}))
		rt.call_function('wp_send_json_error', [var_status.clone()])
	} else if rt.is_true(rt.call_function('is_wp_error', [
		rt.get_property(var_skin, 'result'),
	]))
	{
		var_status.array_set('errorCode', rt.call_method(rt.get_property(var_skin, 'result'),
			'get_error_code', []rt.PhpVal{}))
		var_status.array_set('errorMessage', rt.call_method(rt.get_property(var_skin, 'result'),
			'get_error_message', []rt.PhpVal{}))
		rt.call_function('wp_send_json_error', [var_status.clone()])
	} else if rt.is_true(rt.call_method(var_skin.get_errors(), 'has_errors', []rt.PhpVal{})) {
		var_status.array_set('errorMessage', var_skin.get_error_messages())
		rt.call_function('wp_send_json_error', [var_status.clone()])
	} else if rt.is_true(rt.new_bool(var_result.clone().is_null())) {
		var_status.array_set('errorCode', 'unable_to_connect_to_filesystem')
		var_status.array_set('errorMessage', rt.call_function('__', [
			rt.new_string('Unable to connect to the filesystem. Please confirm your credentials.'),
		]))
		if rt.is_true(rt.new_bool(rt.instance_of(var_wp_filesystem, 'WP_Filesystem_Base')))
			&& rt.is_true(rt.call_function('is_wp_error', [rt.get_property(var_wp_filesystem, 'errors')]))
			&& rt.is_true(rt.call_method(rt.get_property(var_wp_filesystem, 'errors'), 'has_errors', []rt.PhpVal{})) {
			var_status.array_set('errorMessage', rt.call_function('esc_html', [
				rt.call_method(rt.get_property(var_wp_filesystem, 'errors'), 'get_error_message',
					[]rt.PhpVal{}),
			]))
		}
		rt.call_function('wp_send_json_error', [var_status.clone()])
	}
	var_status.array_set('themeName', rt.call_method(rt.call_function('wp_get_theme', [
		var_slug.clone(),
	]), 'get', [rt.new_string('Name')]))
	if rt.is_true(rt.call_function('current_user_can', [rt.new_string('switch_themes')])) {
		if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) {
			var_status.array_set('activateUrl', rt.call_function('add_query_arg', [
				rt.create_array([rt.ArrayItem{ key: 'action', val: 'enable' },
					rt.ArrayItem{ key: '_wpnonce', val: rt.call_function('wp_create_nonce', [
						rt.new_string('enable-theme_' + var_slug.str()),
					]) }, rt.ArrayItem{ key: 'theme', val: var_slug }]),
				rt.call_function('network_admin_url', [rt.new_string('themes.php')]),
			]))
		} else {
			var_status.array_set('activateUrl', rt.call_function('add_query_arg', [
				rt.create_array([rt.ArrayItem{ key: 'action', val: 'activate' },
					rt.ArrayItem{ key: '_wpnonce', val: rt.call_function('wp_create_nonce', [
						rt.new_string('switch-theme_' + var_slug.str()),
					]) }, rt.ArrayItem{ key: 'stylesheet', val: var_slug }]),
				rt.call_function('admin_url', [rt.new_string('themes.php')]),
			]))
		}
	}
	var_theme = rt.call_function('wp_get_theme', [var_slug.clone()])
	var_status.array_set('blockTheme', rt.call_method(var_theme, 'is_block_theme', []rt.PhpVal{}))
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})))))
		&& rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_theme_options')]))
		&& rt.is_true(rt.call_function('current_user_can', [rt.new_string('customize')])) {
		var_status.array_set('customizeUrl', rt.call_function('add_query_arg', [
			rt.create_array([
				rt.ArrayItem{ key: 'return', val: rt.call_function('urlencode', [
					rt.call_function('network_admin_url', [
						rt.new_string('theme-install.php'),
						rt.new_string('relative'),
					]),
				]) },
			]),
			rt.call_function('wp_customize_url', [
				var_slug.clone(),
			]),
		]))
	}
	rt.call_function('wp_send_json_success', [var_status.clone()])
}

fn wp_ajax_update_theme() {
	mut var_wp_filesystem := rt.new_null()
	mut var_stylesheet := rt.new_null()
	mut var_status := rt.new_null()
	mut var_theme := rt.new_null()
	mut var_current := rt.new_null()
	mut var_skin := rt.new_null()
	mut var_upgrader := rt.new_null()
	mut var_result := rt.new_null()
	rt.call_function('check_ajax_referer', [rt.new_string('updates')])
	if !rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('slug'))) {
		rt.call_function('wp_send_json_error', [
			rt.create_array([rt.ArrayItem{ key: 'slug', val: '' },
				rt.ArrayItem{ key: 'errorCode', val: 'no_theme_specified' },
				rt.ArrayItem{ key: 'errorMessage', val: rt.call_function('__', [
					rt.new_string('No theme specified.'),
				]) }]),
		])
	}
	var_stylesheet = rt.call_function('preg_replace', [rt.new_string('/[^A-z0-9_\\-]/'),
		rt.new_string(''),
		rt.call_function('wp_unslash', [
			rt.get_superglobal('_POST').array_get(rt.new_string('slug')),
		])])
	var_status = rt.create_array([rt.ArrayItem{ key: 'update', val: 'theme' },
		rt.ArrayItem{ key: 'slug', val: var_stylesheet }, rt.ArrayItem{ key: 'oldVersion', val: '' },
		rt.ArrayItem{ key: 'newVersion', val: '' }])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('update_themes'),
	])))))
	{
		var_status.array_set('errorMessage', rt.call_function('__', [
			rt.new_string('Sorry, you are not allowed to update themes for this site.'),
		]))
		rt.call_function('wp_send_json_error', [var_status.clone()])
	}
	var_theme = rt.call_function('wp_get_theme', [var_stylesheet.clone()])
	if rt.is_true(rt.call_method(var_theme, 'exists', []rt.PhpVal{})) {
		var_status.array_set('oldVersion', rt.call_method(var_theme, 'get', [
			rt.new_string('Version'),
		]))
	}
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/class-wp-upgrader.php',
		'4')
	var_current = rt.call_function('get_site_transient', [rt.new_string('update_themes')])
	if !rt.is_true(var_current) {
		rt.call_function('wp_update_themes', []rt.PhpVal{})
	}
	var_skin = create_wp_ajax_upgrader_skin()
	var_upgrader = create_theme_upgrader(var_skin)
	var_result = rt.call_method(var_upgrader, 'bulk_upgrade', [
		rt.create_array([rt.ArrayItem{ key: none, val: var_stylesheet }]),
	])
	if rt.is_true(rt.call_function('defined', [rt.new_string('WP_DEBUG')]))
		&& rt.is_true(rt.get_constant('WP_DEBUG')) {
		var_status.array_set('debug', var_skin.get_upgrade_messages())
	}
	if rt.is_true(rt.call_function('is_wp_error', [rt.get_property(var_skin, 'result')])) {
		var_status.array_set('errorCode', rt.call_method(rt.get_property(var_skin, 'result'),
			'get_error_code', []rt.PhpVal{}))
		var_status.array_set('errorMessage', rt.call_method(rt.get_property(var_skin, 'result'),
			'get_error_message', []rt.PhpVal{}))
		rt.call_function('wp_send_json_error', [var_status.clone()])
	} else if rt.is_true(rt.call_method(var_skin.get_errors(), 'has_errors', []rt.PhpVal{})) {
		var_status.array_set('errorMessage', var_skin.get_error_messages())
		rt.call_function('wp_send_json_error', [var_status.clone()])
	} else if var_result.clone().is_array() && !(!rt.is_true(var_result.array_get(var_stylesheet))) {
		if rt.is_true(rt.identical(rt.new_bool(true), var_result.array_get(var_stylesheet))) {
			var_status.array_set('errorMessage',
				rt.get_property(var_upgrader, 'strings').array_get(rt.new_string('up_to_date')))
			rt.call_function('wp_send_json_error', [var_status.clone()])
		}
		var_theme = rt.call_function('wp_get_theme', [var_stylesheet.clone()])
		if rt.is_true(rt.call_method(var_theme, 'exists', []rt.PhpVal{})) {
			var_status.array_set('newVersion', rt.call_method(var_theme, 'get', [
				rt.new_string('Version'),
			]))
		}
		rt.call_function('wp_send_json_success', [var_status.clone()])
	} else if rt.is_true(rt.identical(rt.new_bool(false), var_result)) {
		var_status.array_set('errorCode', 'unable_to_connect_to_filesystem')
		var_status.array_set('errorMessage', rt.call_function('__', [
			rt.new_string('Unable to connect to the filesystem. Please confirm your credentials.'),
		]))
		if rt.is_true(rt.new_bool(rt.instance_of(var_wp_filesystem, 'WP_Filesystem_Base')))
			&& rt.is_true(rt.call_function('is_wp_error', [rt.get_property(var_wp_filesystem, 'errors')]))
			&& rt.is_true(rt.call_method(rt.get_property(var_wp_filesystem, 'errors'), 'has_errors', []rt.PhpVal{})) {
			var_status.array_set('errorMessage', rt.call_function('esc_html', [
				rt.call_method(rt.get_property(var_wp_filesystem, 'errors'), 'get_error_message',
					[]rt.PhpVal{}),
			]))
		}
		rt.call_function('wp_send_json_error', [var_status.clone()])
	}
	var_status.array_set('errorMessage', rt.call_function('__', [
		rt.new_string('Theme update failed.'),
	]))
	rt.call_function('wp_send_json_error', [var_status.clone()])
}

fn wp_ajax_delete_theme() {
	mut var_wp_filesystem := rt.new_null()
	mut var_stylesheet := rt.new_null()
	mut var_status := rt.new_null()
	mut var_url := rt.new_null()
	mut var_credentials := rt.new_null()
	mut var_result := rt.new_null()
	rt.call_function('check_ajax_referer', [rt.new_string('updates')])
	if !rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('slug'))) {
		rt.call_function('wp_send_json_error', [
			rt.create_array([rt.ArrayItem{ key: 'slug', val: '' },
				rt.ArrayItem{ key: 'errorCode', val: 'no_theme_specified' },
				rt.ArrayItem{ key: 'errorMessage', val: rt.call_function('__', [
					rt.new_string('No theme specified.'),
				]) }]),
		])
	}
	var_stylesheet = rt.call_function('preg_replace', [rt.new_string('/[^A-z0-9_\\-]/'),
		rt.new_string(''),
		rt.call_function('wp_unslash', [
			rt.get_superglobal('_POST').array_get(rt.new_string('slug')),
		])])
	var_status = rt.create_array([rt.ArrayItem{ key: 'delete', val: 'theme' },
		rt.ArrayItem{ key: 'slug', val: var_stylesheet }])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('delete_themes'),
	])))))
	{
		var_status.array_set('errorMessage', rt.call_function('__', [
			rt.new_string('Sorry, you are not allowed to delete themes on this site.'),
		]))
		rt.call_function('wp_send_json_error', [var_status.clone()])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(rt.call_function('wp_get_theme', [
		var_stylesheet.clone(),
	]), 'exists', []rt.PhpVal{})))))
	{
		var_status.array_set('errorMessage', rt.call_function('__', [
			rt.new_string('The requested theme does not exist.'),
		]))
		rt.call_function('wp_send_json_error', [var_status.clone()])
	}
	var_url = rt.call_function('wp_nonce_url', [
		rt.new_string('themes.php?action=delete&stylesheet=' +
			(rt.call_function('urlencode', [var_stylesheet.clone()])).str()),
		rt.new_string('delete-theme_' + var_stylesheet.str()),
	])
	rt.call_function('ob_start', []rt.PhpVal{})
	var_credentials = rt.call_function('request_filesystem_credentials', [
		var_url.clone()])
	rt.call_function('ob_end_clean', []rt.PhpVal{})
	if rt.is_true(rt.identical(rt.new_bool(false), var_credentials))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('WP_Filesystem', [var_credentials.clone()]))))) {
		var_status.array_set('errorCode', 'unable_to_connect_to_filesystem')
		var_status.array_set('errorMessage', rt.call_function('__', [
			rt.new_string('Unable to connect to the filesystem. Please confirm your credentials.'),
		]))
		if rt.is_true(rt.new_bool(rt.instance_of(var_wp_filesystem, 'WP_Filesystem_Base')))
			&& rt.is_true(rt.call_function('is_wp_error', [rt.get_property(var_wp_filesystem, 'errors')]))
			&& rt.is_true(rt.call_method(rt.get_property(var_wp_filesystem, 'errors'), 'has_errors', []rt.PhpVal{})) {
			var_status.array_set('errorMessage', rt.call_function('esc_html', [
				rt.call_method(rt.get_property(var_wp_filesystem, 'errors'), 'get_error_message',
					[]rt.PhpVal{}),
			]))
		}
		rt.call_function('wp_send_json_error', [var_status.clone()])
	}
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/theme.php', '4')
	var_result = rt.call_function('delete_theme', [var_stylesheet.clone()])
	if rt.is_true(rt.call_function('is_wp_error', [var_result.clone()])) {
		var_status.array_set('errorMessage', rt.call_method(var_result, 'get_error_message',
			[]rt.PhpVal{}))
		rt.call_function('wp_send_json_error', [var_status.clone()])
	} else if rt.is_true(rt.identical(rt.new_bool(false), var_result)) {
		var_status.array_set('errorMessage', rt.call_function('__', [
			rt.new_string('Theme could not be deleted.'),
		]))
		rt.call_function('wp_send_json_error', [var_status.clone()])
	}
	rt.call_function('wp_send_json_success', [var_status.clone()])
}

fn wp_ajax_install_plugin() {
	mut var_wp_filesystem := rt.new_null()
	mut var_status := rt.new_null()
	mut var_api := rt.new_null()
	mut var_skin := rt.new_null()
	mut var_upgrader := rt.new_null()
	mut var_result := rt.new_null()
	mut var_install_status := rt.new_null()
	mut var_pagenow := rt.new_null()
	mut var_plugins_url := rt.new_null()
	rt.call_function('check_ajax_referer', [rt.new_string('updates')])
	if !rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('slug'))) {
		rt.call_function('wp_send_json_error', [
			rt.create_array([rt.ArrayItem{ key: 'slug', val: '' },
				rt.ArrayItem{ key: 'errorCode', val: 'no_plugin_specified' },
				rt.ArrayItem{ key: 'errorMessage', val: rt.call_function('__', [
					rt.new_string('No plugin specified.'),
				]) }]),
		])
	}
	var_status = rt.create_array([rt.ArrayItem{ key: 'install', val: 'plugin' },
		rt.ArrayItem{ key: 'slug', val: rt.call_function('sanitize_key', [
			rt.call_function('wp_unslash',
				[rt.get_superglobal('_POST').array_get(rt.new_string('slug'))]),
		]) }])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('install_plugins'),
	])))))
	{
		var_status.array_set('errorMessage', rt.call_function('__', [
			rt.new_string('Sorry, you are not allowed to install plugins on this site.'),
		]))
		rt.call_function('wp_send_json_error', [var_status.clone()])
	}
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/class-wp-upgrader.php',
		'4')
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/plugin-install.php',
		'4')
	var_api = rt.call_function('plugins_api', [rt.new_string('plugin_information'),
		rt.create_array([
			rt.ArrayItem{ key: 'slug', val: rt.call_function('sanitize_key', [
				rt.call_function('wp_unslash',
					[rt.get_superglobal('_POST').array_get(rt.new_string('slug'))]),
			]) },
			rt.ArrayItem{ key: 'fields', val: rt.create_array([
				rt.ArrayItem{ key: 'sections', val: false },
			]) },
		])])
	if rt.is_true(rt.call_function('is_wp_error', [var_api.clone()])) {
		var_status.array_set('errorMessage', rt.call_method(var_api, 'get_error_message',
			[]rt.PhpVal{}))
		rt.call_function('wp_send_json_error', [var_status.clone()])
	}
	var_status.array_set('pluginName', rt.get_property(var_api, 'name'))
	var_skin = create_wp_ajax_upgrader_skin()
	var_upgrader = create_plugin_upgrader(var_skin)
	var_result = rt.call_method(var_upgrader, 'install', [
		rt.get_property(var_api, 'download_link'),
	])
	if rt.is_true(rt.call_function('defined', [rt.new_string('WP_DEBUG')]))
		&& rt.is_true(rt.get_constant('WP_DEBUG')) {
		var_status.array_set('debug', var_skin.get_upgrade_messages())
	}
	if rt.is_true(rt.call_function('is_wp_error', [var_result.clone()])) {
		var_status.array_set('errorCode', rt.call_method(var_result, 'get_error_code',
			[]rt.PhpVal{}))
		var_status.array_set('errorMessage', rt.call_method(var_result, 'get_error_message',
			[]rt.PhpVal{}))
		rt.call_function('wp_send_json_error', [var_status.clone()])
	} else if rt.is_true(rt.call_function('is_wp_error', [
		rt.get_property(var_skin, 'result'),
	]))
	{
		var_status.array_set('errorCode', rt.call_method(rt.get_property(var_skin, 'result'),
			'get_error_code', []rt.PhpVal{}))
		var_status.array_set('errorMessage', rt.call_method(rt.get_property(var_skin, 'result'),
			'get_error_message', []rt.PhpVal{}))
		rt.call_function('wp_send_json_error', [var_status.clone()])
	} else if rt.is_true(rt.call_method(var_skin.get_errors(), 'has_errors', []rt.PhpVal{})) {
		var_status.array_set('errorMessage', var_skin.get_error_messages())
		rt.call_function('wp_send_json_error', [var_status.clone()])
	} else if rt.is_true(rt.new_bool(var_result.clone().is_null())) {
		var_status.array_set('errorCode', 'unable_to_connect_to_filesystem')
		var_status.array_set('errorMessage', rt.call_function('__', [
			rt.new_string('Unable to connect to the filesystem. Please confirm your credentials.'),
		]))
		if rt.is_true(rt.new_bool(rt.instance_of(var_wp_filesystem, 'WP_Filesystem_Base')))
			&& rt.is_true(rt.call_function('is_wp_error', [rt.get_property(var_wp_filesystem, 'errors')]))
			&& rt.is_true(rt.call_method(rt.get_property(var_wp_filesystem, 'errors'), 'has_errors', []rt.PhpVal{})) {
			var_status.array_set('errorMessage', rt.call_function('esc_html', [
				rt.call_method(rt.get_property(var_wp_filesystem, 'errors'), 'get_error_message',
					[]rt.PhpVal{}),
			]))
		}
		rt.call_function('wp_send_json_error', [var_status.clone()])
	}
	var_install_status = rt.call_function('install_plugin_install_status', [
		var_api.clone()])
	var_pagenow = if rt.get_superglobal('_POST').array_isset(rt.new_string('pagenow')) { rt.call_function('sanitize_key', [
			rt.get_superglobal('_POST').array_get(rt.new_string('pagenow')),
		]) } else { rt.new_string('') }
	var_plugins_url = if rt.is_true(rt.identical(rt.new_string('import'), var_pagenow)) { rt.call_function('admin_url', [
			rt.new_string('plugins.php'),
		]) } else { rt.call_function('network_admin_url', [rt.new_string('plugins.php')]) }
	if rt.is_true(rt.call_function('current_user_can', [rt.new_string('activate_plugin'), var_install_status.array_get(rt.new_string('file'))]))
		&& rt.is_true(rt.call_function('is_plugin_inactive', [var_install_status.array_get(rt.new_string('file'))])) {
		var_status.array_set('activateUrl', rt.call_function('add_query_arg', [
			rt.create_array([
				rt.ArrayItem{ key: '_wpnonce', val: rt.call_function('wp_create_nonce', [
					rt.new_string('activate-plugin_' +
						(var_install_status.array_get(rt.new_string('file'))).str()),
				]) },
				rt.ArrayItem{ key: 'action', val: 'activate' },
				rt.ArrayItem{
					key: 'plugin'
					val: var_install_status.array_get(rt.new_string('file'))
				},
			]),
			var_plugins_url.clone(),
		]))
	}
	if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{}))
		&& rt.is_true(rt.call_function('current_user_can', [rt.new_string('manage_network_plugins')]))
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('import'), var_pagenow)))) {
		var_status.array_set('activateUrl', rt.call_function('add_query_arg', [
			rt.create_array([rt.ArrayItem{ key: 'networkwide', val: 1 }]),
			var_status.array_get(rt.new_string('activateUrl')),
		]))
	}
	rt.call_function('wp_send_json_success', [var_status.clone()])
}

fn wp_ajax_activate_plugin() {
	mut var_status := rt.new_null()
	mut var_activated := rt.new_null()
	rt.call_function('check_ajax_referer', [rt.new_string('updates')])
	if !rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('name')))
		|| !rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('slug')))
		|| !rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('plugin'))) {
		rt.call_function('wp_send_json_error', [
			rt.create_array([rt.ArrayItem{ key: 'slug', val: '' },
				rt.ArrayItem{ key: 'pluginName', val: '' }, rt.ArrayItem{ key: 'plugin', val: '' },
				rt.ArrayItem{ key: 'errorCode', val: 'no_plugin_specified' },
				rt.ArrayItem{ key: 'errorMessage', val: rt.call_function('__', [
					rt.new_string('No plugin specified.'),
				]) }]),
		])
	}
	var_status = rt.create_array([rt.ArrayItem{ key: 'activate', val: 'plugin' },
		rt.ArrayItem{ key: 'slug', val: rt.call_function('wp_unslash', [
			rt.get_superglobal('_POST').array_get(rt.new_string('slug')),
		]) }, rt.ArrayItem{ key: 'pluginName', val: rt.call_function('wp_unslash', [
			rt.get_superglobal('_POST').array_get(rt.new_string('name')),
		]) }, rt.ArrayItem{ key: 'plugin', val: rt.call_function('wp_unslash', [
			rt.get_superglobal('_POST').array_get(rt.new_string('plugin')),
		]) }])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('activate_plugin'),
		var_status.array_get(rt.new_string('plugin')),
	])))))
	{
		var_status.array_set('errorMessage', rt.call_function('__', [
			rt.new_string('Sorry, you are not allowed to activate plugins on this site.'),
		]))
		rt.call_function('wp_send_json_error', [var_status.clone()])
	}
	if rt.is_true(rt.call_function('is_plugin_active', [
		var_status.array_get(rt.new_string('plugin')),
	]))
	{
		var_status.array_set('errorMessage', rt.call_function('sprintf', [
			rt.call_function('__', [rt.new_string('%s is already active.')]),
			var_status.array_get(rt.new_string('pluginName')),
		]))
	}
	var_activated = rt.call_function('activate_plugin', [
		var_status.array_get(rt.new_string('plugin')),
	])
	if rt.is_true(rt.call_function('is_wp_error', [var_activated.clone()])) {
		var_status.array_set('errorMessage', rt.call_method(var_activated, 'get_error_message',
			[]rt.PhpVal{}))
		rt.call_function('wp_send_json_error', [var_status.clone()])
	}
	rt.call_function('wp_send_json_success', [var_status.clone()])
}

fn wp_ajax_update_plugin() {
	mut var_wp_filesystem := rt.new_null()
	mut var_plugin := rt.new_null()
	mut var_status := rt.new_null()
	mut var_plugin_data := rt.new_null()
	mut var_skin := rt.new_null()
	mut var_upgrader := rt.new_null()
	mut var_result := rt.new_null()
	rt.call_function('check_ajax_referer', [rt.new_string('updates')])
	if !rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('plugin')))
		|| !rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('slug'))) {
		rt.call_function('wp_send_json_error', [
			rt.create_array([rt.ArrayItem{ key: 'slug', val: '' },
				rt.ArrayItem{ key: 'errorCode', val: 'no_plugin_specified' },
				rt.ArrayItem{ key: 'errorMessage', val: rt.call_function('__', [
					rt.new_string('No plugin specified.'),
				]) }]),
		])
	}
	var_plugin = rt.call_function('plugin_basename', [
		rt.call_function('sanitize_text_field', [
			rt.call_function('wp_unslash',
				[rt.get_superglobal('_POST').array_get(rt.new_string('plugin'))]),
		]),
	])
	var_status = rt.create_array([rt.ArrayItem{ key: 'update', val: 'plugin' },
		rt.ArrayItem{ key: 'slug', val: rt.call_function('sanitize_key', [
			rt.call_function('wp_unslash',
				[rt.get_superglobal('_POST').array_get(rt.new_string('slug'))]),
		]) }, rt.ArrayItem{ key: 'oldVersion', val: '' }, rt.ArrayItem{ key: 'newVersion', val: '' }])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('update_plugins')])))))
		|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int(0), rt.call_function('validate_file', [var_plugin.clone()]))))) {
		var_status.array_set('errorMessage', rt.call_function('__', [
			rt.new_string('Sorry, you are not allowed to update plugins for this site.'),
		]))
		rt.call_function('wp_send_json_error', [var_status.clone()])
	}
	var_plugin_data = rt.call_function('get_plugin_data', [
		rt.new_string((rt.get_constant('WP_PLUGIN_DIR')).str() + '/' + var_plugin.str()),
	])
	var_status.array_set('plugin', var_plugin.clone())
	var_status.array_set('pluginName', var_plugin_data.array_get(rt.new_string('Name')))
	if rt.is_true(var_plugin_data.array_get(rt.new_string('Version'))) {
		var_status.array_set('oldVersion', rt.call_function('sprintf', [
			rt.call_function('__', [rt.new_string('Version %s')]),
			var_plugin_data.array_get(rt.new_string('Version')),
		]))
	}
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/class-wp-upgrader.php',
		'4')
	rt.call_function('wp_update_plugins', []rt.PhpVal{})
	var_skin = create_wp_ajax_upgrader_skin()
	var_upgrader = create_plugin_upgrader(var_skin)
	var_result = rt.call_method(var_upgrader, 'bulk_upgrade', [
		rt.create_array([rt.ArrayItem{ key: none, val: var_plugin }]),
	])
	if rt.is_true(rt.call_function('defined', [rt.new_string('WP_DEBUG')]))
		&& rt.is_true(rt.get_constant('WP_DEBUG')) {
		var_status.array_set('debug', var_skin.get_upgrade_messages())
	}
	if rt.is_true(rt.call_function('is_wp_error', [rt.get_property(var_skin, 'result')])) {
		var_status.array_set('errorCode', rt.call_method(rt.get_property(var_skin, 'result'),
			'get_error_code', []rt.PhpVal{}))
		var_status.array_set('errorMessage', rt.call_method(rt.get_property(var_skin, 'result'),
			'get_error_message', []rt.PhpVal{}))
		rt.call_function('wp_send_json_error', [var_status.clone()])
	} else if rt.is_true(rt.call_method(var_skin.get_errors(), 'has_errors', []rt.PhpVal{})) {
		var_status.array_set('errorMessage', var_skin.get_error_messages())
		rt.call_function('wp_send_json_error', [var_status.clone()])
	} else if var_result.clone().is_array() && !(!rt.is_true(var_result.array_get(var_plugin))) {
		if rt.is_true(rt.identical(rt.new_bool(true), var_result.array_get(var_plugin))) {
			var_status.array_set('errorMessage',
				rt.get_property(var_upgrader, 'strings').array_get(rt.new_string('up_to_date')))
			rt.call_function('wp_send_json_error', [var_status.clone()])
		}
		var_plugin_data = rt.call_function('get_plugins', [
			rt.new_string('/' +(var_result.array_get(var_plugin).array_get(rt.new_string('destination_name'))).str()),
		])
		var_plugin_data = rt.call_function('reset', [var_plugin_data.clone()])
		if rt.is_true(var_plugin_data.array_get(rt.new_string('Version'))) {
			var_status.array_set('newVersion', rt.call_function('sprintf', [
				rt.call_function('__', [rt.new_string('Version %s')]),
				var_plugin_data.array_get(rt.new_string('Version')),
			]))
		}
		rt.call_function('wp_send_json_success', [var_status.clone()])
	} else if rt.is_true(rt.identical(rt.new_bool(false), var_result)) {
		var_status.array_set('errorCode', 'unable_to_connect_to_filesystem')
		var_status.array_set('errorMessage', rt.call_function('__', [
			rt.new_string('Unable to connect to the filesystem. Please confirm your credentials.'),
		]))
		if rt.is_true(rt.new_bool(rt.instance_of(var_wp_filesystem, 'WP_Filesystem_Base')))
			&& rt.is_true(rt.call_function('is_wp_error', [rt.get_property(var_wp_filesystem, 'errors')]))
			&& rt.is_true(rt.call_method(rt.get_property(var_wp_filesystem, 'errors'), 'has_errors', []rt.PhpVal{})) {
			var_status.array_set('errorMessage', rt.call_function('esc_html', [
				rt.call_method(rt.get_property(var_wp_filesystem, 'errors'), 'get_error_message',
					[]rt.PhpVal{}),
			]))
		}
		rt.call_function('wp_send_json_error', [var_status.clone()])
	}
	var_status.array_set('errorMessage', rt.call_function('__', [
		rt.new_string('Plugin update failed.'),
	]))
	rt.call_function('wp_send_json_error', [var_status.clone()])
}

fn wp_ajax_delete_plugin() {
	mut var_wp_filesystem := rt.new_null()
	mut var_plugin := rt.new_null()
	mut var_status := rt.new_null()
	mut var_plugin_data := rt.new_null()
	mut var_url := rt.new_null()
	mut var_credentials := rt.new_null()
	mut var_result := rt.new_null()
	rt.call_function('check_ajax_referer', [rt.new_string('updates')])
	if !rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('slug')))
		|| !rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('plugin'))) {
		rt.call_function('wp_send_json_error', [
			rt.create_array([rt.ArrayItem{ key: 'slug', val: '' },
				rt.ArrayItem{ key: 'errorCode', val: 'no_plugin_specified' },
				rt.ArrayItem{ key: 'errorMessage', val: rt.call_function('__', [
					rt.new_string('No plugin specified.'),
				]) }]),
		])
	}
	var_plugin = rt.call_function('plugin_basename', [
		rt.call_function('sanitize_text_field', [
			rt.call_function('wp_unslash',
				[rt.get_superglobal('_POST').array_get(rt.new_string('plugin'))]),
		]),
	])
	var_status = rt.create_array([rt.ArrayItem{ key: 'delete', val: 'plugin' },
		rt.ArrayItem{ key: 'slug', val: rt.call_function('sanitize_key', [
			rt.call_function('wp_unslash',
				[rt.get_superglobal('_POST').array_get(rt.new_string('slug'))]),
		]) }])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('delete_plugins')])))))
		|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int(0), rt.call_function('validate_file', [var_plugin.clone()]))))) {
		var_status.array_set('errorMessage', rt.call_function('__', [
			rt.new_string('Sorry, you are not allowed to delete plugins for this site.'),
		]))
		rt.call_function('wp_send_json_error', [var_status.clone()])
	}
	var_plugin_data = rt.call_function('get_plugin_data', [
		rt.new_string((rt.get_constant('WP_PLUGIN_DIR')).str() + '/' + var_plugin.str()),
	])
	var_status.array_set('plugin', var_plugin.clone())
	var_status.array_set('pluginName', var_plugin_data.array_get(rt.new_string('Name')))
	if rt.is_true(rt.call_function('is_plugin_active', [var_plugin.clone()])) {
		var_status.array_set('errorMessage', rt.call_function('__', [
			rt.new_string('You cannot delete a plugin while it is active on the main site.'),
		]))
		rt.call_function('wp_send_json_error', [var_status.clone()])
	}
	var_url = rt.call_function('wp_nonce_url', [
		rt.new_string('plugins.php?action=delete-selected&verify-delete=1&checked[]=' +
			var_plugin.str()),
		rt.new_string('bulk-plugins'),
	])
	rt.call_function('ob_start', []rt.PhpVal{})
	var_credentials = rt.call_function('request_filesystem_credentials', [
		var_url.clone()])
	rt.call_function('ob_end_clean', []rt.PhpVal{})
	if rt.is_true(rt.identical(rt.new_bool(false), var_credentials))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('WP_Filesystem', [var_credentials.clone()]))))) {
		var_status.array_set('errorCode', 'unable_to_connect_to_filesystem')
		var_status.array_set('errorMessage', rt.call_function('__', [
			rt.new_string('Unable to connect to the filesystem. Please confirm your credentials.'),
		]))
		if rt.is_true(rt.new_bool(rt.instance_of(var_wp_filesystem, 'WP_Filesystem_Base')))
			&& rt.is_true(rt.call_function('is_wp_error', [rt.get_property(var_wp_filesystem, 'errors')]))
			&& rt.is_true(rt.call_method(rt.get_property(var_wp_filesystem, 'errors'), 'has_errors', []rt.PhpVal{})) {
			var_status.array_set('errorMessage', rt.call_function('esc_html', [
				rt.call_method(rt.get_property(var_wp_filesystem, 'errors'), 'get_error_message',
					[]rt.PhpVal{}),
			]))
		}
		rt.call_function('wp_send_json_error', [var_status.clone()])
	}
	var_result = rt.call_function('delete_plugins', [
		rt.create_array([rt.ArrayItem{ key: none, val: var_plugin }]),
	])
	if rt.is_true(rt.call_function('is_wp_error', [var_result.clone()])) {
		var_status.array_set('errorMessage', rt.call_method(var_result, 'get_error_message',
			[]rt.PhpVal{}))
		rt.call_function('wp_send_json_error', [var_status.clone()])
	} else if rt.is_true(rt.identical(rt.new_bool(false), var_result)) {
		var_status.array_set('errorMessage', rt.call_function('__', [
			rt.new_string('Plugin could not be deleted.'),
		]))
		rt.call_function('wp_send_json_error', [var_status.clone()])
	}
	rt.call_function('wp_send_json_success', [var_status.clone()])
}

fn wp_ajax_search_plugins() {
	mut var_GLOBALS := rt.new_null()
	mut var_pagenow := rt.new_null()
	mut var_wp_list_table := rt.new_null()
	mut var_status := rt.new_null()
	rt.call_function('check_ajax_referer', [rt.new_string('updates')])
	rt.call_function('wp_plugin_update_rows', []rt.PhpVal{})
	mut iife_temp_2 := Class_WP_Plugin_Dependencies{}
	mut iife_result_2 := iife_temp_2.initialize()
	var_pagenow = if rt.get_superglobal('_POST').array_isset(rt.new_string('pagenow')) { rt.call_function('sanitize_key', [
			rt.get_superglobal('_POST').array_get(rt.new_string('pagenow')),
		]) } else { rt.new_string('') }
	if rt.is_true(rt.identical(rt.new_string('plugins-network'), var_pagenow))
		|| rt.is_true(rt.identical(rt.new_string('plugins'), var_pagenow)) {
		rt.call_function('set_current_screen', [var_pagenow.clone()])
	}
	var_wp_list_table = rt.call_function('_get_list_table', [
		rt.new_string('WP_Plugins_List_Table'),
		rt.create_array([
			rt.ArrayItem{ key: 'screen', val: rt.call_function('get_current_screen', []rt.PhpVal{}) },
		]),
	])
	var_status = rt.new_array()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_wp_list_table, 'ajax_user_can',
		[]rt.PhpVal{})))))
	{
		var_status.array_set('errorMessage', rt.call_function('__', [
			rt.new_string('Sorry, you are not allowed to manage plugins for this site.'),
		]))
		rt.call_function('wp_send_json_error', [var_status.clone()])
	}
	rt.get_superglobal('_SERVER').array_set('REQUEST_URI', rt.call_function('add_query_arg', [
		rt.call_function('array_diff_key', [rt.get_superglobal('_POST').clone(),
			rt.create_array([rt.ArrayItem{ key: '_ajax_nonce', val: rt.new_null() },
				rt.ArrayItem{ key: 'action', val: rt.new_null() }])]),
		rt.call_function('network_admin_url', [rt.new_string('plugins.php'),
			rt.new_string('relative')]),
	]))
	var_GLOBALS.array_set('s', rt.call_function('wp_unslash', [
		rt.get_superglobal('_POST').array_get(rt.new_string('s')),
	]))
	rt.call_method(var_wp_list_table, 'prepare_items', []rt.PhpVal{})
	rt.call_function('ob_start', []rt.PhpVal{})
	rt.call_method(var_wp_list_table, 'display', []rt.PhpVal{})
	var_status.array_set('count', rt.get_property(var_wp_list_table, 'items').array_count())
	var_status.array_set('items', rt.call_function('ob_get_clean', []rt.PhpVal{}))
	rt.call_function('wp_send_json_success', [var_status.clone()])
}

fn wp_ajax_search_install_plugins() {
	mut var_pagenow := rt.new_null()
	mut var_wp_list_table := rt.new_null()
	mut var_status := rt.new_null()
	rt.call_function('check_ajax_referer', [rt.new_string('updates')])
	var_pagenow = if rt.get_superglobal('_POST').array_isset(rt.new_string('pagenow')) { rt.call_function('sanitize_key', [
			rt.get_superglobal('_POST').array_get(rt.new_string('pagenow')),
		]) } else { rt.new_string('') }
	if rt.is_true(rt.identical(rt.new_string('plugin-install-network'), var_pagenow))
		|| rt.is_true(rt.identical(rt.new_string('plugin-install'), var_pagenow)) {
		rt.call_function('set_current_screen', [var_pagenow.clone()])
	}
	var_wp_list_table = rt.call_function('_get_list_table', [
		rt.new_string('WP_Plugin_Install_List_Table'),
		rt.create_array([
			rt.ArrayItem{ key: 'screen', val: rt.call_function('get_current_screen', []rt.PhpVal{}) },
		]),
	])
	var_status = rt.new_array()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_wp_list_table, 'ajax_user_can',
		[]rt.PhpVal{})))))
	{
		var_status.array_set('errorMessage', rt.call_function('__', [
			rt.new_string('Sorry, you are not allowed to manage plugins for this site.'),
		]))
		rt.call_function('wp_send_json_error', [var_status.clone()])
	}
	rt.get_superglobal('_SERVER').array_set('REQUEST_URI', rt.call_function('add_query_arg', [
		rt.call_function('array_diff_key', [rt.get_superglobal('_POST').clone(),
			rt.create_array([rt.ArrayItem{ key: '_ajax_nonce', val: rt.new_null() },
				rt.ArrayItem{ key: 'action', val: rt.new_null() }])]),
		rt.call_function('network_admin_url', [rt.new_string('plugin-install.php'),
			rt.new_string('relative')]),
	]))
	rt.call_method(var_wp_list_table, 'prepare_items', []rt.PhpVal{})
	rt.call_function('ob_start', []rt.PhpVal{})
	rt.call_method(var_wp_list_table, 'display', []rt.PhpVal{})
	var_status.array_set('count', rt.new_int((rt.call_method(var_wp_list_table,
		'get_pagination_arg', [rt.new_string('total_items')])).to_i64()))
	var_status.array_set('items', rt.call_function('ob_get_clean', []rt.PhpVal{}))
	rt.call_function('wp_send_json_success', [var_status.clone()])
}

fn wp_ajax_edit_theme_plugin_file() {
	mut var_edit_result := rt.new_null()
	var_edit_result = rt.call_function('wp_edit_theme_plugin_file', [
		rt.call_function('wp_unslash', [rt.get_superglobal('_POST').clone()]),
	])
	if rt.is_true(rt.call_function('is_wp_error', [var_edit_result.clone()])) {
		rt.call_function('wp_send_json_error', [
			rt.call_function('array_merge', [
				rt.create_array([
					rt.ArrayItem{ key: 'code', val: rt.call_method(var_edit_result,
						'get_error_code', []rt.PhpVal{}) },
					rt.ArrayItem{ key: 'message', val: rt.call_method(var_edit_result,
						'get_error_message', []rt.PhpVal{}) },
				]),
				rt.cast_array(rt.call_method(var_edit_result, 'get_error_data', []rt.PhpVal{})),
			]),
		])
	} else {
		rt.call_function('wp_send_json_success', [
			rt.create_array([
				rt.ArrayItem{ key: 'message', val: rt.call_function('__', [
					rt.new_string('File edited successfully.'),
				]) },
			]),
		])
	}
}

fn wp_ajax_wp_privacy_export_personal_data() {
	mut var_request_id := rt.new_null()
	mut var_request := rt.new_null()
	mut var_email_address := rt.new_null()
	mut var_exporter_index := rt.new_null()
	mut var_page := rt.new_null()
	mut var_send_as_email := false
	mut var_exporters := rt.new_null()
	mut var_exporter_keys := rt.new_null()
	mut var_exporter_key := rt.new_null()
	mut var_exporter := rt.new_null()
	mut var_exporter_friendly_name := rt.new_null()
	mut var_callback := rt.new_null()
	mut var_response := rt.new_null()
	if !rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('id'))) {
		rt.call_function('wp_send_json_error', [
			rt.call_function('__', [rt.new_string('Missing request ID.')]),
		])
	}
	var_request_id =
		rt.new_int((rt.get_superglobal('_POST').array_get(rt.new_string('id'))).to_i64())
	if rt.is_true(rt.less(var_request_id, rt.new_int(1))) {
		rt.call_function('wp_send_json_error', [
			rt.call_function('__', [rt.new_string('Invalid request ID.')]),
		])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('export_others_personal_data'),
	])))))
	{
		rt.call_function('wp_send_json_error', [
			rt.call_function('__', [
				rt.new_string('Sorry, you are not allowed to perform this action.'),
			]),
		])
	}
	rt.call_function('check_ajax_referer', [
		rt.new_string('wp-privacy-export-personal-data-' + var_request_id.str()),
		rt.new_string('security'),
	])
	var_request = rt.call_function('wp_get_user_request', [var_request_id.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_request))))
		|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('export_personal_data'), rt.get_property(var_request, 'action_name'))))) {
		rt.call_function('wp_send_json_error', [
			rt.call_function('__', [rt.new_string('Invalid request type.')]),
		])
	}
	var_email_address = rt.get_property(var_request, 'email')
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_email', [
		var_email_address.clone()])))))
	{
		rt.call_function('wp_send_json_error', [
			rt.call_function('__', [
				rt.new_string('A valid email address must be given.'),
			]),
		])
	}
	if !(rt.get_superglobal('_POST').array_isset(rt.new_string('exporter'))) {
		rt.call_function('wp_send_json_error', [
			rt.call_function('__', [rt.new_string('Missing exporter index.')]),
		])
	}
	var_exporter_index =
		rt.new_int((rt.get_superglobal('_POST').array_get(rt.new_string('exporter'))).to_i64())
	if !(rt.get_superglobal('_POST').array_isset(rt.new_string('page'))) {
		rt.call_function('wp_send_json_error', [
			rt.call_function('__', [rt.new_string('Missing page index.')]),
		])
	}
	var_page = rt.new_int((rt.get_superglobal('_POST').array_get(rt.new_string('page'))).to_i64())
	var_send_as_email = (if rt.get_superglobal('_POST').array_isset(rt.new_string('sendAsEmail')) {
		rt.identical(rt.new_string('true'),
			rt.get_superglobal('_POST').array_get(rt.new_string('sendAsEmail')))
	} else {
		rt.new_bool(false)
	}).to_bool()
	var_exporters = rt.call_function('apply_filters', [
		rt.new_string('wp_privacy_personal_data_exporters'),
		rt.new_array(),
	])
	if !(var_exporters.clone().is_array()) {
		rt.call_function('wp_send_json_error', [
			rt.call_function('__', [
				rt.new_string('An exporter has improperly used the registration filter.'),
			]),
		])
	}
	if 0 < var_exporters.clone().array_count() {
		if rt.is_true(rt.less(var_exporter_index, rt.new_int(1))) {
			rt.call_function('wp_send_json_error', [
				rt.call_function('__', [
					rt.new_string('Exporter index cannot be negative.'),
				]),
			])
		}
		if rt.is_true(rt.greater(var_exporter_index,
			rt.new_int(var_exporters.clone().array_count())))
		{
			rt.call_function('wp_send_json_error', [
				rt.call_function('__', [rt.new_string('Exporter index is out of range.')]),
			])
		}
		if rt.is_true(rt.less(var_page, rt.new_int(1))) {
			rt.call_function('wp_send_json_error', [
				rt.call_function('__', [
					rt.new_string('Page index cannot be less than one.'),
				]),
			])
		}
		var_exporter_keys = rt.func_array_keys(var_exporters.clone())
		var_exporter_key = var_exporter_keys.array_get(rt.sub(var_exporter_index, rt.new_int(1)))
		var_exporter = var_exporters.array_get(var_exporter_key)
		if !(var_exporter.clone().is_array()) {
			rt.call_function('wp_send_json_error', [
				rt.call_function('sprintf', [
					rt.call_function('__', [
						rt.new_string('Expected an array describing the exporter at index %s.'),
					]),
					var_exporter_key.clone(),
				]),
			])
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_exporter.clone().array_isset(rt.new_string('exporter_friendly_name'))))))) {
			rt.call_function('wp_send_json_error', [
				rt.call_function('sprintf', [
					rt.call_function('__', [
						rt.new_string('Exporter array at index %s does not include a friendly name.'),
					]),
					var_exporter_key.clone(),
				]),
			])
		}
		var_exporter_friendly_name = var_exporter.array_get(rt.new_string('exporter_friendly_name'))
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_exporter.clone().array_isset(rt.new_string('callback'))))))) {
			rt.call_function('wp_send_json_error', [
				rt.call_function('sprintf', [
					rt.call_function('__', [
						rt.new_string('Exporter does not include a callback: %s.'),
					]),
					rt.call_function('esc_html', [
						var_exporter_friendly_name.clone(),
					]),
				]),
			])
		}
		if !(rt.call_function('is_callable', [var_exporter.array_get(rt.new_string('callback'))])) {
			rt.call_function('wp_send_json_error', [
				rt.call_function('sprintf', [
					rt.call_function('__', [
						rt.new_string('Exporter callback is not a valid callback: %s.'),
					]),
					rt.call_function('esc_html', [
						var_exporter_friendly_name.clone(),
					]),
				]),
			])
		}
		var_callback = var_exporter.array_get(rt.new_string('callback'))
		var_response = rt.call_function('call_user_func', [var_callback.clone(),
			var_email_address.clone(), var_page.clone()])
		if rt.is_true(rt.call_function('is_wp_error', [var_response.clone()])) {
			rt.call_function('wp_send_json_error', [var_response.clone()])
		}
		if !(var_response.clone().is_array()) {
			rt.call_function('wp_send_json_error', [
				rt.call_function('sprintf', [
					rt.call_function('__', [
						rt.new_string('Expected response as an array from exporter: %s.'),
					]),
					rt.call_function('esc_html', [
						var_exporter_friendly_name.clone(),
					]),
				]),
			])
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_response.clone().array_isset(rt.new_string('data'))))))) {
			rt.call_function('wp_send_json_error', [
				rt.call_function('sprintf', [
					rt.call_function('__', [
						rt.new_string('Expected data in response array from exporter: %s.'),
					]),
					rt.call_function('esc_html', [
						var_exporter_friendly_name.clone(),
					]),
				]),
			])
		}
		if !(var_response.array_get(rt.new_string('data')).is_array()) {
			rt.call_function('wp_send_json_error', [
				rt.call_function('sprintf', [
					rt.call_function('__', [
						rt.new_string('Expected data array in response array from exporter: %s.'),
					]),
					rt.call_function('esc_html', [
						var_exporter_friendly_name.clone(),
					]),
				]),
			])
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_response.clone().array_isset(rt.new_string('done'))))))) {
			rt.call_function('wp_send_json_error', [
				rt.call_function('sprintf', [
					rt.call_function('__', [
						rt.new_string('Expected done (boolean) in response array from exporter: %s.'),
					]),
					rt.call_function('esc_html', [
						var_exporter_friendly_name.clone(),
					]),
				]),
			])
		}
	} else {
		var_exporter_key = rt.new_string('')
		var_response = rt.create_array([rt.ArrayItem{ key: 'data', val: rt.new_array() },
			rt.ArrayItem{ key: 'done', val: true }])
	}
	var_response = rt.call_function('apply_filters', [
		rt.new_string('wp_privacy_personal_data_export_page'),
		var_response.clone(),
		var_exporter_index.clone(),
		var_email_address.clone(),
		var_page.clone(),
		var_request_id.clone(),
		rt.new_bool(var_send_as_email).clone(),
		var_exporter_key.clone(),
	])
	if rt.is_true(rt.call_function('is_wp_error', [var_response.clone()])) {
		rt.call_function('wp_send_json_error', [var_response.clone()])
	}
	rt.call_function('wp_send_json_success', [var_response.clone()])
}

fn wp_ajax_wp_privacy_erase_personal_data() {
	mut var_request_id := rt.new_null()
	mut var_request := rt.new_null()
	mut var_email_address := rt.new_null()
	mut var_eraser_index := rt.new_null()
	mut var_page := rt.new_null()
	mut var_erasers := rt.new_null()
	mut var_eraser_keys := rt.new_null()
	mut var_eraser_key := rt.new_null()
	mut var_eraser := rt.new_null()
	mut var_eraser_friendly_name := rt.new_null()
	mut var_callback := rt.new_null()
	mut var_response := rt.new_null()
	if !rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('id'))) {
		rt.call_function('wp_send_json_error', [
			rt.call_function('__', [rt.new_string('Missing request ID.')]),
		])
	}
	var_request_id =
		rt.new_int((rt.get_superglobal('_POST').array_get(rt.new_string('id'))).to_i64())
	if rt.is_true(rt.less(var_request_id, rt.new_int(1))) {
		rt.call_function('wp_send_json_error', [
			rt.call_function('__', [rt.new_string('Invalid request ID.')]),
		])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('erase_others_personal_data')])))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('delete_users')]))))) {
		rt.call_function('wp_send_json_error', [
			rt.call_function('__', [
				rt.new_string('Sorry, you are not allowed to perform this action.'),
			]),
		])
	}
	rt.call_function('check_ajax_referer', [
		rt.new_string('wp-privacy-erase-personal-data-' + var_request_id.str()),
		rt.new_string('security'),
	])
	var_request = rt.call_function('wp_get_user_request', [var_request_id.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_request))))
		|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('remove_personal_data'), rt.get_property(var_request, 'action_name'))))) {
		rt.call_function('wp_send_json_error', [
			rt.call_function('__', [rt.new_string('Invalid request type.')]),
		])
	}
	var_email_address = rt.get_property(var_request, 'email')
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_email', [
		var_email_address.clone()])))))
	{
		rt.call_function('wp_send_json_error', [
			rt.call_function('__', [rt.new_string('Invalid email address in request.')]),
		])
	}
	if !(rt.get_superglobal('_POST').array_isset(rt.new_string('eraser'))) {
		rt.call_function('wp_send_json_error', [
			rt.call_function('__', [rt.new_string('Missing eraser index.')]),
		])
	}
	var_eraser_index =
		rt.new_int((rt.get_superglobal('_POST').array_get(rt.new_string('eraser'))).to_i64())
	if !(rt.get_superglobal('_POST').array_isset(rt.new_string('page'))) {
		rt.call_function('wp_send_json_error', [
			rt.call_function('__', [rt.new_string('Missing page index.')]),
		])
	}
	var_page = rt.new_int((rt.get_superglobal('_POST').array_get(rt.new_string('page'))).to_i64())
	var_erasers = rt.call_function('apply_filters', [
		rt.new_string('wp_privacy_personal_data_erasers'),
		rt.new_array(),
	])
	if 0 < var_erasers.clone().array_count() {
		if rt.is_true(rt.less(var_eraser_index, rt.new_int(1))) {
			rt.call_function('wp_send_json_error', [
				rt.call_function('__', [
					rt.new_string('Eraser index cannot be less than one.'),
				]),
			])
		}
		if rt.is_true(rt.greater(var_eraser_index, rt.new_int(var_erasers.clone().array_count()))) {
			rt.call_function('wp_send_json_error', [
				rt.call_function('__', [rt.new_string('Eraser index is out of range.')]),
			])
		}
		if rt.is_true(rt.less(var_page, rt.new_int(1))) {
			rt.call_function('wp_send_json_error', [
				rt.call_function('__', [
					rt.new_string('Page index cannot be less than one.'),
				]),
			])
		}
		var_eraser_keys = rt.func_array_keys(var_erasers.clone())
		var_eraser_key = var_eraser_keys.array_get(rt.sub(var_eraser_index, rt.new_int(1)))
		var_eraser = var_erasers.array_get(var_eraser_key)
		if !(var_eraser.clone().is_array()) {
			rt.call_function('wp_send_json_error', [
				rt.call_function('sprintf', [
					rt.call_function('__', [
						rt.new_string('Expected an array describing the eraser at index %d.'),
					]),
					var_eraser_index.clone(),
				]),
			])
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_eraser.clone().array_isset(rt.new_string('eraser_friendly_name'))))))) {
			rt.call_function('wp_send_json_error', [
				rt.call_function('sprintf', [
					rt.call_function('__', [
						rt.new_string('Eraser array at index %d does not include a friendly name.'),
					]),
					var_eraser_index.clone(),
				]),
			])
		}
		var_eraser_friendly_name = var_eraser.array_get(rt.new_string('eraser_friendly_name'))
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_eraser.clone().array_isset(rt.new_string('callback'))))))) {
			rt.call_function('wp_send_json_error', [
				rt.call_function('sprintf', [
					rt.call_function('__', [
						rt.new_string('Eraser does not include a callback: %s.'),
					]),
					rt.call_function('esc_html', [
						var_eraser_friendly_name.clone(),
					]),
				]),
			])
		}
		if !(rt.call_function('is_callable', [var_eraser.array_get(rt.new_string('callback'))])) {
			rt.call_function('wp_send_json_error', [
				rt.call_function('sprintf', [
					rt.call_function('__', [
						rt.new_string('Eraser callback is not valid: %s.'),
					]),
					rt.call_function('esc_html', [
						var_eraser_friendly_name.clone(),
					]),
				]),
			])
		}
		var_callback = var_eraser.array_get(rt.new_string('callback'))
		var_response = rt.call_function('call_user_func', [var_callback.clone(),
			var_email_address.clone(), var_page.clone()])
		if rt.is_true(rt.call_function('is_wp_error', [var_response.clone()])) {
			rt.call_function('wp_send_json_error', [var_response.clone()])
		}
		if !(var_response.clone().is_array()) {
			rt.call_function('wp_send_json_error', [
				rt.call_function('sprintf', [
					rt.call_function('__', [
						rt.new_string('Did not receive array from %1$s eraser (index %2$d).'),
					]),
					rt.call_function('esc_html', [
						var_eraser_friendly_name.clone(),
					]),
					var_eraser_index.clone(),
				]),
			])
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_response.clone().array_isset(rt.new_string('items_removed'))))))) {
			rt.call_function('wp_send_json_error', [
				rt.call_function('sprintf', [
					rt.call_function('__', [
						rt.new_string('Expected items_removed key in response array from %1$s eraser (index %2$d).'),
					]),
					rt.call_function('esc_html', [
						var_eraser_friendly_name.clone(),
					]),
					var_eraser_index.clone(),
				]),
			])
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_response.clone().array_isset(rt.new_string('items_retained'))))))) {
			rt.call_function('wp_send_json_error', [
				rt.call_function('sprintf', [
					rt.call_function('__', [
						rt.new_string('Expected items_retained key in response array from %1$s eraser (index %2$d).'),
					]),
					rt.call_function('esc_html', [
						var_eraser_friendly_name.clone(),
					]),
					var_eraser_index.clone(),
				]),
			])
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_response.clone().array_isset(rt.new_string('messages'))))))) {
			rt.call_function('wp_send_json_error', [
				rt.call_function('sprintf', [
					rt.call_function('__', [
						rt.new_string('Expected messages key in response array from %1$s eraser (index %2$d).'),
					]),
					rt.call_function('esc_html', [
						var_eraser_friendly_name.clone(),
					]),
					var_eraser_index.clone(),
				]),
			])
		}
		if !(var_response.array_get(rt.new_string('messages')).is_array()) {
			rt.call_function('wp_send_json_error', [
				rt.call_function('sprintf', [
					rt.call_function('__', [
						rt.new_string('Expected messages key to reference an array in response array from %1$s eraser (index %2$d).'),
					]),
					rt.call_function('esc_html', [
						var_eraser_friendly_name.clone(),
					]),
					var_eraser_index.clone(),
				]),
			])
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_response.clone().array_isset(rt.new_string('done'))))))) {
			rt.call_function('wp_send_json_error', [
				rt.call_function('sprintf', [
					rt.call_function('__', [
						rt.new_string('Expected done flag in response array from %1$s eraser (index %2$d).'),
					]),
					rt.call_function('esc_html', [
						var_eraser_friendly_name.clone(),
					]),
					var_eraser_index.clone(),
				]),
			])
		}
	} else {
		var_eraser_key = rt.new_string('')
		var_response = rt.create_array([rt.ArrayItem{ key: 'items_removed', val: false },
			rt.ArrayItem{ key: 'items_retained', val: false },
			rt.ArrayItem{ key: 'messages', val: rt.new_array() },
			rt.ArrayItem{ key: 'done', val: true }])
	}
	var_response = rt.call_function('apply_filters', [
		rt.new_string('wp_privacy_personal_data_erasure_page'),
		var_response.clone(),
		var_eraser_index.clone(),
		var_email_address.clone(),
		var_page.clone(),
		var_request_id.clone(),
		var_eraser_key.clone(),
	])
	if rt.is_true(rt.call_function('is_wp_error', [var_response.clone()])) {
		rt.call_function('wp_send_json_error', [var_response.clone()])
	}
	rt.call_function('wp_send_json_success', [var_response.clone()])
}

fn wp_ajax_health_check_dotorg_communication() {
	mut var_site_health := rt.new_null()
	rt.call_function('_doing_it_wrong', [
		rt.new_string('wp_ajax_health_check_dotorg_communication'),
		rt.call_function('sprintf', [
			rt.call_function('__', [
				rt.new_string('The Site Health check for %1$s has been replaced with %2$s.'),
			]),
			rt.new_string('wp_ajax_health_check_dotorg_communication'),
			rt.new_string('WP_REST_Site_Health_Controller::test_dotorg_communication'),
		]),
		rt.new_string('5.6.0'),
	])
	rt.call_function('check_ajax_referer', [rt.new_string('health-check-site-status')])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('view_site_health_checks'),
	])))))
	{
		rt.call_function('wp_send_json_error', []rt.PhpVal{})
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [
		rt.new_string('WP_Site_Health'),
	])))))
	{
		rt.include_file(
			(rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/class-wp-site-health.php', '4')
	}
	mut iife_temp_3 := Class_WP_Site_Health{}
	mut iife_result_3 := iife_temp_3.get_instance()
	var_site_health = iife_result_3
	rt.call_function('wp_send_json_success', [
		rt.call_method(var_site_health, 'get_test_dotorg_communication', []rt.PhpVal{}),
	])
}

fn wp_ajax_health_check_background_updates() {
	mut var_site_health := rt.new_null()
	rt.call_function('_doing_it_wrong', [
		rt.new_string('wp_ajax_health_check_background_updates'),
		rt.call_function('sprintf', [
			rt.call_function('__', [
				rt.new_string('The Site Health check for %1$s has been replaced with %2$s.'),
			]),
			rt.new_string('wp_ajax_health_check_background_updates'),
			rt.new_string('WP_REST_Site_Health_Controller::test_background_updates'),
		]),
		rt.new_string('5.6.0'),
	])
	rt.call_function('check_ajax_referer', [rt.new_string('health-check-site-status')])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('view_site_health_checks'),
	])))))
	{
		rt.call_function('wp_send_json_error', []rt.PhpVal{})
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [
		rt.new_string('WP_Site_Health'),
	])))))
	{
		rt.include_file(
			(rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/class-wp-site-health.php', '4')
	}
	mut iife_temp_4 := Class_WP_Site_Health{}
	mut iife_result_4 := iife_temp_4.get_instance()
	var_site_health = iife_result_4
	rt.call_function('wp_send_json_success', [
		rt.call_method(var_site_health, 'get_test_background_updates', []rt.PhpVal{}),
	])
}

fn wp_ajax_health_check_loopback_requests() {
	mut var_site_health := rt.new_null()
	rt.call_function('_doing_it_wrong', [
		rt.new_string('wp_ajax_health_check_loopback_requests'),
		rt.call_function('sprintf', [
			rt.call_function('__', [
				rt.new_string('The Site Health check for %1$s has been replaced with %2$s.'),
			]),
			rt.new_string('wp_ajax_health_check_loopback_requests'),
			rt.new_string('WP_REST_Site_Health_Controller::test_loopback_requests'),
		]),
		rt.new_string('5.6.0'),
	])
	rt.call_function('check_ajax_referer', [rt.new_string('health-check-site-status')])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('view_site_health_checks'),
	])))))
	{
		rt.call_function('wp_send_json_error', []rt.PhpVal{})
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [
		rt.new_string('WP_Site_Health'),
	])))))
	{
		rt.include_file(
			(rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/class-wp-site-health.php', '4')
	}
	mut iife_temp_5 := Class_WP_Site_Health{}
	mut iife_result_5 := iife_temp_5.get_instance()
	var_site_health = iife_result_5
	rt.call_function('wp_send_json_success', [
		rt.call_method(var_site_health, 'get_test_loopback_requests', []rt.PhpVal{}),
	])
}

fn wp_ajax_health_check_site_status_result() {
	rt.call_function('check_ajax_referer', [
		rt.new_string('health-check-site-status-result'),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('view_site_health_checks'),
	])))))
	{
		rt.call_function('wp_send_json_error', []rt.PhpVal{})
	}
	rt.call_function('set_transient', [rt.new_string('health-check-site-status-result'),
		rt.call_function('wp_json_encode',
			[rt.get_superglobal('_POST').array_get(rt.new_string('counts'))])])
	rt.call_function('wp_send_json_success', []rt.PhpVal{})
}

fn wp_ajax_health_check_get_sizes() {
	mut var_sizes_data := rt.new_null()
	mut var_all_sizes := rt.new_null()
	mut var_value := rt.new_null()
	mut var_name := rt.new_null()
	mut var_data := rt.new_null()
	rt.call_function('_doing_it_wrong', [rt.new_string('wp_ajax_health_check_get_sizes'),
		rt.call_function('sprintf', [
			rt.call_function('__', [
				rt.new_string('The Site Health check for %1$s has been replaced with %2$s.'),
			]),
			rt.new_string('wp_ajax_health_check_get_sizes'),
			rt.new_string('WP_REST_Site_Health_Controller::get_directory_sizes'),
		]),
		rt.new_string('5.6.0')])
	rt.call_function('check_ajax_referer', [
		rt.new_string('health-check-site-status-result'),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('view_site_health_checks')])))))
		|| rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) {
		rt.call_function('wp_send_json_error', []rt.PhpVal{})
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [
		rt.new_string('WP_Debug_Data'),
	])))))
	{
		rt.include_file(
			(rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/class-wp-debug-data.php', '4')
	}
	mut iife_temp_6 := Class_WP_Debug_Data{}
	mut iife_result_6 := iife_temp_6.get_sizes()
	var_sizes_data = iife_result_6
	var_all_sizes = rt.create_array([rt.ArrayItem{ key: 'raw', val: 0 }])
	mut iter_24 := var_sizes_data.iterator()
	for {
		item_24 := iter_24.next() or { break }
		mut var_value_shadow := item_24.val
		mut var_name_shadow := item_24.key
		var_name_shadow = rt.call_function('sanitize_text_field', [
			var_name_shadow.clone()])
		var_data = rt.new_array()
		if var_value_shadow.array_isset(rt.new_string('size')) {
			if rt.is_true(rt.new_bool(var_value_shadow.array_get(rt.new_string('size')).is_string())) {
				var_data.array_set('size', rt.call_function('sanitize_text_field', [
					var_value_shadow.array_get(rt.new_string('size')),
				]))
			} else {
				var_data.array_set('size',
					rt.new_int((var_value_shadow.array_get(rt.new_string('size'))).to_i64()))
			}
		}
		if var_value_shadow.array_isset(rt.new_string('debug')) {
			if rt.is_true(rt.new_bool(var_value_shadow.array_get(rt.new_string('debug')).is_string())) {
				var_data.array_set('debug', rt.call_function('sanitize_text_field', [
					var_value_shadow.array_get(rt.new_string('debug')),
				]))
			} else {
				var_data.array_set('debug',
					rt.new_int((var_value_shadow.array_get(rt.new_string('debug'))).to_i64()))
			}
		}
		if !(!rt.is_true(var_value_shadow.array_get(rt.new_string('raw')))) {
			var_data.array_set('raw',
				rt.new_int((var_value_shadow.array_get(rt.new_string('raw'))).to_i64()))
		}
		var_all_sizes.array_set(var_name_shadow, var_data.clone())
	}
	if var_all_sizes.array_get(rt.new_string('total_size')).array_isset(rt.new_string('debug'))
		&& rt.is_true(rt.identical(rt.new_string('not available'), var_all_sizes.array_get(rt.new_string('total_size')).array_get(rt.new_string('debug')))) {
		rt.call_function('wp_send_json_error', [var_all_sizes.clone()])
	}
	rt.call_function('wp_send_json_success', [var_all_sizes.clone()])
}

fn wp_ajax_rest_nonce() {
	fn () {
		print((rt.call_function('wp_create_nonce', [rt.new_string('wp_rest')])).str())
		exit(0)
	}()
}

fn wp_ajax_toggle_auto_updates() {
	mut var_asset := rt.new_null()
	mut var_state := rt.new_null()
	mut var_type := rt.new_null()
	mut var_error_message := rt.new_null()
	mut var_option := rt.new_null()
	mut var_all_items := rt.new_null()
	mut var_auto_updates := rt.new_null()
	rt.call_function('check_ajax_referer', [rt.new_string('updates')])
	if !rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('type')))
		|| !rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('asset')))
		|| !rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('state'))) {
		rt.call_function('wp_send_json_error', [
			rt.create_array([
				rt.ArrayItem{ key: 'error', val: rt.call_function('__', [
					rt.new_string('Invalid data. No selected item.'),
				]) },
			]),
		])
	}
	var_asset = rt.call_function('sanitize_text_field', [
		rt.call_function('urldecode',
			[rt.get_superglobal('_POST').array_get(rt.new_string('asset'))]),
	])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('enable'), rt.get_superglobal('_POST').array_get(rt.new_string('state'))))))
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('disable'), rt.get_superglobal('_POST').array_get(rt.new_string('state')))))) {
		rt.call_function('wp_send_json_error', [
			rt.create_array([
				rt.ArrayItem{ key: 'error', val: rt.call_function('__', [
					rt.new_string('Invalid data. Unknown state.'),
				]) },
			]),
		])
	}
	var_state = rt.get_superglobal('_POST').array_get(rt.new_string('state'))
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('plugin'), rt.get_superglobal('_POST').array_get(rt.new_string('type'))))))
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('theme'), rt.get_superglobal('_POST').array_get(rt.new_string('type')))))) {
		rt.call_function('wp_send_json_error', [
			rt.create_array([
				rt.ArrayItem{ key: 'error', val: rt.call_function('__', [
					rt.new_string('Invalid data. Unknown type.'),
				]) },
			]),
		])
	}
	var_type = rt.get_superglobal('_POST').array_get(rt.new_string('type'))
	mut switch_val_6 := var_type
	if rt.is_true(rt.equal(switch_val_6, rt.new_string('plugin'))) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
			rt.new_string('update_plugins'),
		])))))
		{
			var_error_message = rt.call_function('__', [
				rt.new_string('Sorry, you are not allowed to modify plugins.'),
			])
			rt.call_function('wp_send_json_error', [
				rt.create_array([rt.ArrayItem{ key: 'error', val: var_error_message }]),
			])
		}
		var_option = rt.new_string('auto_update_plugins')
		var_all_items = rt.call_function('apply_filters', [rt.new_string('all_plugins'),
			rt.call_function('get_plugins', []rt.PhpVal{})])
	} else if rt.is_true(rt.equal(switch_val_6, rt.new_string('theme'))) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
			rt.new_string('update_themes'),
		])))))
		{
			var_error_message = rt.call_function('__', [
				rt.new_string('Sorry, you are not allowed to modify themes.'),
			])
			rt.call_function('wp_send_json_error', [
				rt.create_array([rt.ArrayItem{ key: 'error', val: var_error_message }]),
			])
		}
		var_option = rt.new_string('auto_update_themes')
		var_all_items = rt.call_function('wp_get_themes', []rt.PhpVal{})
	} else {
		rt.call_function('wp_send_json_error', [
			rt.create_array([
				rt.ArrayItem{ key: 'error', val: rt.call_function('__', [
					rt.new_string('Invalid data. Unknown type.'),
				]) },
			]),
		])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_all_items.clone().array_isset(var_asset.clone())))))) {
		var_error_message = rt.call_function('__', [
			rt.new_string('Invalid data. The item does not exist.'),
		])
		rt.call_function('wp_send_json_error', [
			rt.create_array([rt.ArrayItem{ key: 'error', val: var_error_message }]),
		])
	}
	var_auto_updates = rt.cast_array(rt.call_function('get_site_option', [
		var_option.clone(), rt.new_array()]))
	if rt.is_true(rt.identical(rt.new_string('disable'), var_state)) {
		var_auto_updates = rt.call_function('array_diff', [var_auto_updates.clone(),
			rt.create_array([rt.ArrayItem{ key: none, val: var_asset }])])
	} else {
		var_auto_updates.array_push(var_asset.clone())
		var_auto_updates = rt.call_function('array_unique', [
			var_auto_updates.clone()])
	}
	var_auto_updates = rt.call_function('array_intersect', [var_auto_updates.clone(),
		rt.func_array_keys(var_all_items.clone())])
	rt.call_function('update_site_option', [var_option.clone(),
		var_auto_updates.clone()])
	rt.call_function('wp_send_json_success', []rt.PhpVal{})
}

fn wp_ajax_send_password_reset() {
	mut var_user_id := rt.new_null()
	mut var_user := rt.new_null()
	mut var_results := rt.new_null()
	var_user_id = rt.new_int(if rt.get_superglobal('_POST').array_isset(rt.new_string('user_id')) {
		rt.new_int((rt.get_superglobal('_POST').array_get(rt.new_string('user_id'))).to_i64())
	} else {
		0
	})
	rt.call_function('check_ajax_referer', [
		rt.new_string('reset-password-for-' + var_user_id.str()),
		rt.new_string('nonce'),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('edit_user'),
		var_user_id.clone(),
	])))))
	{
		rt.call_function('wp_send_json_error', [
			rt.call_function('__', [
				rt.new_string('Cannot send password reset, permission denied.'),
			]),
		])
	}
	var_user = rt.call_function('get_userdata', [var_user_id.clone()])
	var_results = rt.call_function('retrieve_password', [
		rt.get_property(var_user, 'user_login'),
	])
	if rt.is_true(rt.identical(rt.new_bool(true), var_results)) {
		rt.call_function('wp_send_json_success', [
			rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('A password reset link was emailed to %s.'),
				]),
				rt.get_property(var_user, 'display_name'),
			]),
		])
	} else {
		rt.call_function('wp_send_json_error', [
			rt.call_method(var_results, 'get_error_message', []rt.PhpVal{}),
		])
	}
}

struct Class_WP_Community_Events {
	rt.PhpObjectBase
}

struct Class_WP_Ajax_Response {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

struct Class__WP_Editors {
	rt.PhpObjectBase
}

struct Class_WP_Query {
	rt.PhpObjectBase
}

struct Class_WP_Session_Tokens {
	rt.PhpObjectBase
}

struct Class_WP_Site_Icon {
	rt.PhpObjectBase
}

struct Class_WP_Ajax_Upgrader_Skin {
	rt.PhpObjectBase
}

struct Class_Theme_Upgrader {
	rt.PhpObjectBase
}

struct Class_Plugin_Upgrader {
	rt.PhpObjectBase
}

struct Class_WP_Plugin_Dependencies {
	rt.PhpObjectBase
}

struct Class_WP_Site_Health {
	rt.PhpObjectBase
}

struct Class_WP_Debug_Data {
	rt.PhpObjectBase
}

fn create_wp_community_events(_args ...rt.PhpVal) &Class_WP_Community_Events {
	mut obj := &Class_WP_Community_Events{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_ajax_response(_args ...rt.PhpVal) &Class_WP_Ajax_Response {
	mut obj := &Class_WP_Ajax_Response{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_error(_args ...rt.PhpVal) &Class_WP_Error {
	mut obj := &Class_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create__wp_editors(_args ...rt.PhpVal) &Class__WP_Editors {
	mut obj := &Class__WP_Editors{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_query(_args ...rt.PhpVal) &Class_WP_Query {
	mut obj := &Class_WP_Query{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_session_tokens(_args ...rt.PhpVal) &Class_WP_Session_Tokens {
	mut obj := &Class_WP_Session_Tokens{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_site_icon(_args ...rt.PhpVal) &Class_WP_Site_Icon {
	mut obj := &Class_WP_Site_Icon{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_ajax_upgrader_skin(_args ...rt.PhpVal) &Class_WP_Ajax_Upgrader_Skin {
	mut obj := &Class_WP_Ajax_Upgrader_Skin{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_theme_upgrader(_args ...rt.PhpVal) &Class_Theme_Upgrader {
	mut obj := &Class_Theme_Upgrader{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_plugin_upgrader(_args ...rt.PhpVal) &Class_Plugin_Upgrader {
	mut obj := &Class_Plugin_Upgrader{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_plugin_dependencies(_args ...rt.PhpVal) &Class_WP_Plugin_Dependencies {
	mut obj := &Class_WP_Plugin_Dependencies{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_site_health(_args ...rt.PhpVal) &Class_WP_Site_Health {
	mut obj := &Class_WP_Site_Health{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_debug_data(_args ...rt.PhpVal) &Class_WP_Debug_Data {
	mut obj := &Class_WP_Debug_Data{
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

fn (mut this Class_WP_Ajax_Response) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Ajax_Response) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Ajax_Response) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class__WP_Editors) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class__WP_Editors) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class__WP_Editors) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WP_Query) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Query) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Query) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WP_Session_Tokens) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Session_Tokens) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Session_Tokens) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WP_Site_Icon) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Site_Icon) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Site_Icon) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WP_Ajax_Upgrader_Skin) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Ajax_Upgrader_Skin) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Ajax_Upgrader_Skin) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Theme_Upgrader) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Theme_Upgrader) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Theme_Upgrader) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Plugin_Upgrader) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Plugin_Upgrader) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Plugin_Upgrader) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WP_Plugin_Dependencies) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Plugin_Dependencies) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Plugin_Dependencies) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WP_Site_Health) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Site_Health) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Site_Health) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WP_Debug_Data) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Debug_Data) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Debug_Data) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn init_registry() {
	rt.register_func('wp_ajax_nopriv_heartbeat', fn (args []rt.PhpVal) rt.PhpVal {
		return wp_ajax_nopriv_heartbeat()
	})
	rt.register_func('wp_ajax_fetch_list', fn (args []rt.PhpVal) rt.PhpVal {
		return wp_ajax_fetch_list()
	})
	rt.register_func('wp_ajax_ajax_tag_search', fn (args []rt.PhpVal) rt.PhpVal {
		return wp_ajax_ajax_tag_search()
	})
	rt.register_func('wp_ajax_wp_compression_test', fn (args []rt.PhpVal) rt.PhpVal {
		return wp_ajax_wp_compression_test()
	})
	rt.register_func('wp_ajax_imgedit_preview', fn (args []rt.PhpVal) rt.PhpVal {
		return wp_ajax_imgedit_preview()
	})
	rt.register_func('wp_ajax_oembed_cache', fn (args []rt.PhpVal) rt.PhpVal {
		return wp_ajax_oembed_cache()
	})
	rt.register_func('wp_ajax_autocomplete_user', fn (args []rt.PhpVal) rt.PhpVal {
		return wp_ajax_autocomplete_user()
	})
	rt.register_func('wp_ajax_get_community_events', fn (args []rt.PhpVal) rt.PhpVal {
		return wp_ajax_get_community_events()
	})
	rt.register_func('wp_ajax_dashboard_widgets', fn (args []rt.PhpVal) rt.PhpVal {
		return wp_ajax_dashboard_widgets()
	})
	rt.register_func('wp_ajax_logged_in', fn (args []rt.PhpVal) rt.PhpVal {
		return wp_ajax_logged_in()
	})
	rt.register_func('_wp_ajax_delete_comment_response', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		return _wp_ajax_delete_comment_response(arg_0, arg_1)
	})
	rt.register_func('_wp_ajax_add_hierarchical_term', fn (args []rt.PhpVal) rt.PhpVal {
		return _wp_ajax_add_hierarchical_term()
	})
	rt.register_func('wp_ajax_delete_comment', fn (args []rt.PhpVal) rt.PhpVal {
		return wp_ajax_delete_comment()
	})
	rt.register_func('wp_ajax_delete_tag', fn (args []rt.PhpVal) rt.PhpVal {
		return wp_ajax_delete_tag()
	})
	rt.register_func('wp_ajax_delete_link', fn (args []rt.PhpVal) rt.PhpVal {
		return wp_ajax_delete_link()
	})
	rt.register_func('wp_ajax_delete_meta', fn (args []rt.PhpVal) rt.PhpVal {
		return wp_ajax_delete_meta()
	})
	rt.register_func('wp_ajax_delete_post', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return wp_ajax_delete_post(arg_0)
	})
	rt.register_func('wp_ajax_trash_post', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return wp_ajax_trash_post(arg_0)
	})
	rt.register_func('wp_ajax_untrash_post', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return wp_ajax_untrash_post(arg_0)
	})
	rt.register_func('wp_ajax_delete_page', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return wp_ajax_delete_page(arg_0)
	})
	rt.register_func('wp_ajax_dim_comment', fn (args []rt.PhpVal) rt.PhpVal {
		return wp_ajax_dim_comment()
	})
	rt.register_func('wp_ajax_add_link_category', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return wp_ajax_add_link_category(arg_0)
	})
	rt.register_func('wp_ajax_add_tag', fn (args []rt.PhpVal) rt.PhpVal {
		return wp_ajax_add_tag()
	})
	rt.register_func('wp_ajax_get_tagcloud', fn (args []rt.PhpVal) rt.PhpVal {
		return wp_ajax_get_tagcloud()
	})
	rt.register_func('wp_ajax_get_comments', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return wp_ajax_get_comments(arg_0)
	})
	rt.register_func('wp_ajax_replyto_comment', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return wp_ajax_replyto_comment(arg_0)
	})
	rt.register_func('wp_ajax_edit_comment', fn (args []rt.PhpVal) rt.PhpVal {
		return wp_ajax_edit_comment()
	})
	rt.register_func('wp_ajax_add_menu_item', fn (args []rt.PhpVal) rt.PhpVal {
		return wp_ajax_add_menu_item()
	})
	rt.register_func('wp_ajax_add_meta', fn (args []rt.PhpVal) rt.PhpVal {
		return wp_ajax_add_meta()
	})
	rt.register_func('wp_ajax_add_user', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return wp_ajax_add_user(arg_0)
	})
	rt.register_func('wp_ajax_closed_postboxes', fn (args []rt.PhpVal) rt.PhpVal {
		return wp_ajax_closed_postboxes()
	})
	rt.register_func('wp_ajax_hidden_columns', fn (args []rt.PhpVal) rt.PhpVal {
		return wp_ajax_hidden_columns()
	})
	rt.register_func('wp_ajax_update_welcome_panel', fn (args []rt.PhpVal) rt.PhpVal {
		return wp_ajax_update_welcome_panel()
	})
	rt.register_func('wp_ajax_menu_get_metabox', fn (args []rt.PhpVal) rt.PhpVal {
		return wp_ajax_menu_get_metabox()
	})
	rt.register_func('wp_ajax_wp_link_ajax', fn (args []rt.PhpVal) rt.PhpVal {
		return wp_ajax_wp_link_ajax()
	})
	rt.register_func('wp_ajax_menu_locations_save', fn (args []rt.PhpVal) rt.PhpVal {
		return wp_ajax_menu_locations_save()
	})
	rt.register_func('wp_ajax_meta_box_order', fn (args []rt.PhpVal) rt.PhpVal {
		return wp_ajax_meta_box_order()
	})
	rt.register_func('wp_ajax_menu_quick_search', fn (args []rt.PhpVal) rt.PhpVal {
		return wp_ajax_menu_quick_search()
	})
	rt.register_func('wp_ajax_get_permalink', fn (args []rt.PhpVal) rt.PhpVal {
		return wp_ajax_get_permalink()
	})
	rt.register_func('wp_ajax_sample_permalink', fn (args []rt.PhpVal) rt.PhpVal {
		return wp_ajax_sample_permalink()
	})
	rt.register_func('wp_ajax_inline_save', fn (args []rt.PhpVal) rt.PhpVal {
		return wp_ajax_inline_save()
	})
	rt.register_func('wp_ajax_inline_save_tax', fn (args []rt.PhpVal) rt.PhpVal {
		return wp_ajax_inline_save_tax()
	})
	rt.register_func('wp_ajax_find_posts', fn (args []rt.PhpVal) rt.PhpVal {
		return wp_ajax_find_posts()
	})
	rt.register_func('wp_ajax_widgets_order', fn (args []rt.PhpVal) rt.PhpVal {
		return wp_ajax_widgets_order()
	})
	rt.register_func('wp_ajax_save_widget', fn (args []rt.PhpVal) rt.PhpVal {
		return wp_ajax_save_widget()
	})
	rt.register_func('wp_ajax_update_widget', fn (args []rt.PhpVal) rt.PhpVal {
		return wp_ajax_update_widget()
	})
	rt.register_func('wp_ajax_delete_inactive_widgets', fn (args []rt.PhpVal) rt.PhpVal {
		return wp_ajax_delete_inactive_widgets()
	})
	rt.register_func('wp_ajax_media_create_image_subsizes', fn (args []rt.PhpVal) rt.PhpVal {
		return wp_ajax_media_create_image_subsizes()
	})
	rt.register_func('wp_ajax_upload_attachment', fn (args []rt.PhpVal) rt.PhpVal {
		return wp_ajax_upload_attachment()
	})
	rt.register_func('wp_ajax_image_editor', fn (args []rt.PhpVal) rt.PhpVal {
		return wp_ajax_image_editor()
	})
	rt.register_func('wp_ajax_set_post_thumbnail', fn (args []rt.PhpVal) rt.PhpVal {
		return wp_ajax_set_post_thumbnail()
	})
	rt.register_func('wp_ajax_get_post_thumbnail_html', fn (args []rt.PhpVal) rt.PhpVal {
		return wp_ajax_get_post_thumbnail_html()
	})
	rt.register_func('wp_ajax_set_attachment_thumbnail', fn (args []rt.PhpVal) rt.PhpVal {
		return wp_ajax_set_attachment_thumbnail()
	})
	rt.register_func('wp_ajax_date_format', fn (args []rt.PhpVal) rt.PhpVal {
		return wp_ajax_date_format()
	})
	rt.register_func('wp_ajax_time_format', fn (args []rt.PhpVal) rt.PhpVal {
		return wp_ajax_time_format()
	})
	rt.register_func('wp_ajax_wp_fullscreen_save_post', fn (args []rt.PhpVal) rt.PhpVal {
		return wp_ajax_wp_fullscreen_save_post()
	})
	rt.register_func('wp_ajax_wp_remove_post_lock', fn (args []rt.PhpVal) rt.PhpVal {
		return wp_ajax_wp_remove_post_lock()
	})
	rt.register_func('wp_ajax_dismiss_wp_pointer', fn (args []rt.PhpVal) rt.PhpVal {
		return wp_ajax_dismiss_wp_pointer()
	})
	rt.register_func('wp_ajax_get_attachment', fn (args []rt.PhpVal) rt.PhpVal {
		return wp_ajax_get_attachment()
	})
	rt.register_func('wp_ajax_query_attachments', fn (args []rt.PhpVal) rt.PhpVal {
		return wp_ajax_query_attachments()
	})
	rt.register_func('wp_ajax_save_attachment', fn (args []rt.PhpVal) rt.PhpVal {
		return wp_ajax_save_attachment()
	})
	rt.register_func('wp_ajax_save_attachment_compat', fn (args []rt.PhpVal) rt.PhpVal {
		return wp_ajax_save_attachment_compat()
	})
	rt.register_func('wp_ajax_save_attachment_order', fn (args []rt.PhpVal) rt.PhpVal {
		return wp_ajax_save_attachment_order()
	})
	rt.register_func('wp_ajax_send_attachment_to_editor', fn (args []rt.PhpVal) rt.PhpVal {
		return wp_ajax_send_attachment_to_editor()
	})
	rt.register_func('wp_ajax_send_link_to_editor', fn (args []rt.PhpVal) rt.PhpVal {
		return wp_ajax_send_link_to_editor()
	})
	rt.register_func('wp_ajax_heartbeat', fn (args []rt.PhpVal) rt.PhpVal {
		return wp_ajax_heartbeat()
	})
	rt.register_func('wp_ajax_get_revision_diffs', fn (args []rt.PhpVal) rt.PhpVal {
		return wp_ajax_get_revision_diffs()
	})
	rt.register_func('wp_ajax_save_user_color_scheme', fn (args []rt.PhpVal) rt.PhpVal {
		return wp_ajax_save_user_color_scheme()
	})
	rt.register_func('wp_ajax_query_themes', fn (args []rt.PhpVal) rt.PhpVal {
		return wp_ajax_query_themes()
	})
	rt.register_func('wp_ajax_parse_embed', fn (args []rt.PhpVal) rt.PhpVal {
		return wp_ajax_parse_embed()
	})
	rt.register_func('wp_ajax_parse_media_shortcode', fn (args []rt.PhpVal) rt.PhpVal {
		return wp_ajax_parse_media_shortcode()
	})
	rt.register_func('wp_ajax_destroy_sessions', fn (args []rt.PhpVal) rt.PhpVal {
		return wp_ajax_destroy_sessions()
	})
	rt.register_func('wp_ajax_crop_image', fn (args []rt.PhpVal) rt.PhpVal {
		return wp_ajax_crop_image()
	})
	rt.register_func('wp_ajax_generate_password', fn (args []rt.PhpVal) rt.PhpVal {
		return wp_ajax_generate_password()
	})
	rt.register_func('wp_ajax_nopriv_generate_password', fn (args []rt.PhpVal) rt.PhpVal {
		return wp_ajax_nopriv_generate_password()
	})
	rt.register_func('wp_ajax_save_wporg_username', fn (args []rt.PhpVal) rt.PhpVal {
		return wp_ajax_save_wporg_username()
	})
	rt.register_func('wp_ajax_install_theme', fn (args []rt.PhpVal) rt.PhpVal {
		return wp_ajax_install_theme()
	})
	rt.register_func('wp_ajax_update_theme', fn (args []rt.PhpVal) rt.PhpVal {
		return wp_ajax_update_theme()
	})
	rt.register_func('wp_ajax_delete_theme', fn (args []rt.PhpVal) rt.PhpVal {
		return wp_ajax_delete_theme()
	})
	rt.register_func('wp_ajax_install_plugin', fn (args []rt.PhpVal) rt.PhpVal {
		return wp_ajax_install_plugin()
	})
	rt.register_func('wp_ajax_activate_plugin', fn (args []rt.PhpVal) rt.PhpVal {
		return wp_ajax_activate_plugin()
	})
	rt.register_func('wp_ajax_update_plugin', fn (args []rt.PhpVal) rt.PhpVal {
		return wp_ajax_update_plugin()
	})
	rt.register_func('wp_ajax_delete_plugin', fn (args []rt.PhpVal) rt.PhpVal {
		return wp_ajax_delete_plugin()
	})
	rt.register_func('wp_ajax_search_plugins', fn (args []rt.PhpVal) rt.PhpVal {
		return wp_ajax_search_plugins()
	})
	rt.register_func('wp_ajax_search_install_plugins', fn (args []rt.PhpVal) rt.PhpVal {
		return wp_ajax_search_install_plugins()
	})
	rt.register_func('wp_ajax_edit_theme_plugin_file', fn (args []rt.PhpVal) rt.PhpVal {
		return wp_ajax_edit_theme_plugin_file()
	})
	rt.register_func('wp_ajax_wp_privacy_export_personal_data', fn (args []rt.PhpVal) rt.PhpVal {
		return wp_ajax_wp_privacy_export_personal_data()
	})
	rt.register_func('wp_ajax_wp_privacy_erase_personal_data', fn (args []rt.PhpVal) rt.PhpVal {
		return wp_ajax_wp_privacy_erase_personal_data()
	})
	rt.register_func('wp_ajax_health_check_dotorg_communication', fn (args []rt.PhpVal) rt.PhpVal {
		return wp_ajax_health_check_dotorg_communication()
	})
	rt.register_func('wp_ajax_health_check_background_updates', fn (args []rt.PhpVal) rt.PhpVal {
		return wp_ajax_health_check_background_updates()
	})
	rt.register_func('wp_ajax_health_check_loopback_requests', fn (args []rt.PhpVal) rt.PhpVal {
		return wp_ajax_health_check_loopback_requests()
	})
	rt.register_func('wp_ajax_health_check_site_status_result', fn (args []rt.PhpVal) rt.PhpVal {
		return wp_ajax_health_check_site_status_result()
	})
	rt.register_func('wp_ajax_health_check_get_sizes', fn (args []rt.PhpVal) rt.PhpVal {
		return wp_ajax_health_check_get_sizes()
	})
	rt.register_func('wp_ajax_rest_nonce', fn (args []rt.PhpVal) rt.PhpVal {
		return wp_ajax_rest_nonce()
	})
	rt.register_func('wp_ajax_toggle_auto_updates', fn (args []rt.PhpVal) rt.PhpVal {
		return wp_ajax_toggle_auto_updates()
	})
	rt.register_func('wp_ajax_send_password_reset', fn (args []rt.PhpVal) rt.PhpVal {
		return wp_ajax_send_password_reset()
	})
	rt.register_class_factory('WP_Community_Events', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_wp_community_events()
		return rt.new_object('WP_Community_Events', []string{}, obj)
	})
	rt.register_class_factory('WP_Ajax_Response', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_wp_ajax_response()
		return rt.new_object('WP_Ajax_Response', []string{}, obj)
	})
	rt.register_class_factory('WP_Error', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_wp_error()
		return rt.new_object('WP_Error', []string{}, obj)
	})
	rt.register_class_factory('_WP_Editors', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create__wp_editors()
		return rt.new_object('_WP_Editors', []string{}, obj)
	})
	rt.register_class_factory('WP_Query', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_wp_query()
		return rt.new_object('WP_Query', []string{}, obj)
	})
	rt.register_class_factory('WP_Session_Tokens', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_wp_session_tokens()
		return rt.new_object('WP_Session_Tokens', []string{}, obj)
	})
	rt.register_class_factory('WP_Site_Icon', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_wp_site_icon()
		return rt.new_object('WP_Site_Icon', []string{}, obj)
	})
	rt.register_class_factory('WP_Ajax_Upgrader_Skin', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_wp_ajax_upgrader_skin()
		return rt.new_object('WP_Ajax_Upgrader_Skin', []string{}, obj)
	})
	rt.register_class_factory('Theme_Upgrader', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_theme_upgrader()
		return rt.new_object('Theme_Upgrader', []string{}, obj)
	})
	rt.register_class_factory('Plugin_Upgrader', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_plugin_upgrader()
		return rt.new_object('Plugin_Upgrader', []string{}, obj)
	})
	rt.register_class_factory('WP_Plugin_Dependencies', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_wp_plugin_dependencies()
		return rt.new_object('WP_Plugin_Dependencies', []string{}, obj)
	})
	rt.register_class_factory('WP_Site_Health', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_wp_site_health()
		return rt.new_object('WP_Site_Health', []string{}, obj)
	})
	rt.register_class_factory('WP_Debug_Data', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_wp_debug_data()
		return rt.new_object('WP_Debug_Data', []string{}, obj)
	})
}

fn init() {
	init_registry()
}

fn main() {
	defer {
		rt.shutdown()
	}
}
