import rt

fn wp_credits(version string, locale string) bool {
	mut var_version := version
	mut var_locale := locale
	mut var_results := rt.new_null()
	mut var_url := rt.new_null()
	mut var_options := map[string]rt.PhpVal{}
	mut var_response := rt.new_null()
	if !(var_version.len > 0 && var_version != '0') {
	var_version = (rt.call_function('wp_get_wp_version', []rt.PhpVal{})).str()
	}
	if !(var_locale.len > 0 && var_locale != '0') {
	var_locale = (rt.call_function('get_user_locale', []rt.PhpVal{})).str()
	}
	var_results = rt.call_function('get_site_transient', [rt.new_string('wordpress_credits_' + var_locale)])
	if !(var_results.clone().is_array()) || rt.is_true(rt.call_function('str_contains', [rt.new_string((var_version).str()), rt.new_string('-')])) || (var_results.array_get(rt.new_string('data')).array_isset(rt.new_string('version')) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('str_starts_with', [rt.new_string((var_version).str()), var_results.array_get(rt.new_string('data')).array_get(rt.new_string('version'))])))))) {
		var_url = rt.new_string("http://api.wordpress.org/core/credits/1.1/?version=${var_version}&locale=${var_locale}")
		var_options = { 'user-agent': 'WordPress/' + var_version + '; ' + (rt.call_function('home_url', [rt.new_string('/')])).str() }
		if rt.is_true(rt.call_function('wp_http_supports', [rt.create_array([rt.ArrayItem{ key: none, val: 'ssl' }])])) {
		var_url = rt.call_function('set_url_scheme', [var_url.clone(), rt.new_string('https')])
		}
		var_response = rt.call_function('wp_remote_get', [var_url.clone(), rt.create_array_from_native_map(var_options)])
		if rt.is_true(rt.call_function('is_wp_error', [var_response.clone()])) || rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int(200), rt.call_function('wp_remote_retrieve_response_code', [var_response.clone()]))))) {
			return false
		}
		var_results = rt.call_function('json_decode', [rt.call_function('wp_remote_retrieve_body', [var_response.clone()]), rt.new_bool(true)])
		if !(var_results.clone().is_array()) {
			return false
		}
		rt.call_function('set_site_transient', [rt.new_string('wordpress_credits_' + var_locale), var_results.clone(), rt.get_constant('DAY_IN_SECONDS')])
	}
	return (var_results).to_bool()
}

fn _wp_credits_add_profile_link(var_display_name_arg rt.PhpVal, var_username rt.PhpVal, var_profiles rt.PhpVal) {
	mut var_display_name := var_display_name_arg
var_display_name = rt.new_string('<a href="' + (rt.call_function('esc_url', [rt.call_function('sprintf', [var_profiles.clone(), var_username.clone()])])).str() + '">' + (rt.call_function('esc_html', [var_display_name.clone()])).str() + '</a>')
}

fn _wp_credits_build_object_link(var_data_arg rt.PhpVal) {
	mut var_data := var_data_arg
var_data = rt.new_string('<a href="' + (rt.call_function('esc_url', [var_data.array_get(rt.new_int(1))])).str() + '">' + (rt.call_function('esc_html', [var_data.array_get(rt.new_int(0))])).str() + '</a>')
}

fn wp_credits_section_title(var_group_data rt.PhpVal) {
	mut var_title := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_int(var_group_data.clone().array_count()))))) {
		return
	}
	if rt.is_true(var_group_data.array_get(rt.new_string('name'))) {
		if rt.is_true(rt.identical(rt.new_string('Translators'), var_group_data.array_get(rt.new_string('name')))) {
		var_title = rt.call_function('_x', [rt.new_string('Translators'), rt.new_string('Translate this to be the equivalent of English Translators in your language for the credits page Translators section')])
		} else if var_group_data.array_isset(rt.new_string('placeholders')) {
		var_title = rt.call_function('vsprintf', [rt.call_function('translate', [var_group_data.array_get(rt.new_string('name'))]), var_group_data.array_get(rt.new_string('placeholders'))])
		} else {
		var_title = rt.call_function('translate', [var_group_data.array_get(rt.new_string('name'))])
		}
		print('<h2 class="wp-people-group-title">' + (rt.call_function('esc_html', [var_title.clone()])).str() + '</h2>\n')
	}
}

fn wp_credits_section_list(var_credits rt.PhpVal, slug string) {
	mut var_slug := slug
	mut var_group_data := rt.new_null()
	mut var_credits_data := rt.new_null()
	mut var_compact := rt.new_null()
	mut var_classes := rt.new_null()
	mut var_person_data := rt.new_null()
	mut var_size := rt.new_null()
	mut var_data := rt.new_null()
	mut var_data2x := rt.new_null()
	var_group_data = if !(var_credits.array_get(rt.new_string('groups')).array_get(rt.new_string(slug))).is_null() { var_credits.array_get(rt.new_string('groups')).array_get(rt.new_string(slug)) } else { rt.new_array() }
	var_credits_data = var_credits.array_get(rt.new_string('data'))
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_int(var_group_data.clone().array_count()))))) {
		return
	}
	if !(!rt.is_true(var_group_data.array_get(rt.new_string('shuffle')))) {
		rt.call_function('shuffle', [var_group_data.array_get(rt.new_string('data'))])
	}
	mut switch_val_1 := var_group_data.array_get(rt.new_string('type'))
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('list'))) {
		rt.call_function('array_walk', [var_group_data.array_get(rt.new_string('data')), rt.new_string('_wp_credits_add_profile_link'), var_credits_data.array_get(rt.new_string('profiles'))])
		print('<p class="wp-credits-list">' + (rt.call_function('wp_sprintf', [rt.new_string('%l.'), var_group_data.array_get(rt.new_string('data'))])).str() + '</p>\n\n')
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('libraries'))) {
		rt.call_function('array_walk', [var_group_data.array_get(rt.new_string('data')), rt.new_string('_wp_credits_build_object_link')])
		print('<p class="wp-credits-list">' + (rt.call_function('wp_sprintf', [rt.new_string('%l.'), var_group_data.array_get(rt.new_string('data'))])).str() + '</p>\n\n')
	} else {
		var_compact = rt.identical(rt.new_string('compact'), var_group_data.array_get(rt.new_string('type')))
		var_classes = rt.new_string('wp-people-group ' + if rt.is_true(var_compact) { 'compact' } else { '' })
		print('<ul class="' + (var_classes).str() + '" id="wp-people-group-' + slug + '">' + '\n')
		mut iter_1 := var_group_data.array_get(rt.new_string('data')).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_person_data_shadow := item_1.val
			print('<li class="wp-person" id="wp-person-' + (rt.call_function('esc_attr', [var_person_data_shadow.array_get(rt.new_int(2))])).str() + '">' + '\n\t')
			print('<a href="' + (rt.call_function('esc_url', [rt.call_function('sprintf', [var_credits_data.array_get(rt.new_string('profiles')), var_person_data_shadow.array_get(rt.new_int(2))])])).str() + '" class="web">')
			var_size = rt.new_int(if rt.is_true(var_compact) { 80 } else { 160 })
			var_data = rt.call_function('get_avatar_data', [rt.new_string((var_person_data_shadow.array_get(rt.new_int(1))).str() + '@sha256.gravatar.com'), rt.create_array([rt.ArrayItem{ key: 'size', val: var_size }])])
			var_data2x = rt.call_function('get_avatar_data', [rt.new_string((var_person_data_shadow.array_get(rt.new_int(1))).str() + '@sha256.gravatar.com'), rt.create_array([rt.ArrayItem{ key: 'size', val: rt.mul(var_size, rt.new_int(2)) }])])
			print('<span class="wp-person-avatar"><img src="' + (rt.call_function('esc_url', [var_data.array_get(rt.new_string('url'))])).str() + '" srcset="' + (rt.call_function('esc_url', [var_data2x.array_get(rt.new_string('url'))])).str() + ' 2x" class="gravatar" alt="" /></span>' + '\n')
			print((rt.call_function('esc_html', [var_person_data_shadow.array_get(rt.new_int(0))])).str() + '</a>\n\t')
			if rt.is_true(rt.new_bool(!(rt.is_true(var_compact)))) && !(!rt.is_true(var_person_data_shadow.array_get(rt.new_int(3)))) {
				print('<span class="title">' + (rt.call_function('translate', [var_person_data_shadow.array_get(rt.new_int(3))])).str() + '</span>\n')
			}
			print('</li>\n')
		}
		print('</ul>\n')
	}
}


fn main() {
	defer {
		rt.shutdown()
	}

}
