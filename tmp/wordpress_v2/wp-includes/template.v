import rt

fn get_query_template(type string, var_templates_arg rt.PhpVal) rt.PhpVal {
	mut var_type := type
	mut var_templates := var_templates_arg
	mut var_template := rt.new_null()
	var_type = (rt.call_function('preg_replace', [rt.new_string('|[^a-z0-9-]+|'),
		rt.new_string(''), rt.new_string(var_type.str())])).str()
	if !rt.is_true(var_templates) {
		var_templates = rt.create_array([
			rt.ArrayItem{ key: none, val: '${var_type}.php' },
		])
	}
	var_templates = rt.call_function('apply_filters', [
		rt.new_string('${var_type}_template_hierarchy'),
		var_templates.clone(),
	])
	var_template = locate_template(var_templates.clone(), false, false, rt.new_null())
	var_template = rt.call_function('locate_block_template', [
		var_template.clone(), rt.new_string(var_type.str()), var_templates.clone()])
	return rt.call_function('apply_filters', [rt.new_string('${var_type}_template'),
		var_template.clone(), rt.new_string(var_type.str()), var_templates.clone()])
}

fn get_index_template() rt.PhpVal {
	return get_query_template('index', rt.new_null())
}

fn get_404_template() rt.PhpVal {
	return get_query_template('404', rt.new_null())
}

fn get_archive_template() rt.PhpVal {
	mut var_post_types := rt.new_null()
	mut var_templates := rt.new_null()
	mut var_post_type := rt.new_null()
	var_post_types = rt.call_function('array_filter', [
		rt.cast_array(rt.call_function('get_query_var', [rt.new_string('post_type')])),
	])
	var_templates = rt.new_array()
	if var_post_types.clone().array_count() == 1 {
		var_post_type = rt.call_function('reset', [var_post_types.clone()])
		var_templates.array_push('archive-${var_post_type.to_string()}.php')
	}
	var_templates.array_push('archive.php')
	return get_query_template('archive', var_templates.clone())
}

fn get_post_type_archive_template() string {
	mut var_post_type := rt.new_null()
	mut var_obj := rt.new_null()
	var_post_type = rt.call_function('get_query_var', [rt.new_string('post_type')])
	if rt.is_true(rt.new_bool(var_post_type.clone().is_array())) {
		var_post_type = rt.call_function('reset', [var_post_type.clone()])
	}
	var_obj = rt.call_function('get_post_type_object', [var_post_type.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_obj, 'WP_Post_Type'))))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.get_property(var_obj, 'has_archive'))))) {
		return ''
	}
	return (get_archive_template()).str()
}

fn get_author_template() rt.PhpVal {
	mut var_author := rt.new_null()
	mut var_templates := rt.new_null()
	var_author = rt.call_function('get_queried_object', []rt.PhpVal{})
	var_templates = rt.new_array()
	if rt.is_true(rt.new_bool(rt.instance_of(var_author, 'WP_User'))) {
		var_templates.array_push(rt.concat(rt.concat(rt.new_string('author-'), rt.get_property(var_author,
			'user_nicename')), rt.new_string('.php')))
		var_templates.array_push(rt.concat(rt.concat(rt.new_string('author-'), rt.get_property(var_author,
			'ID')), rt.new_string('.php')))
	}
	var_templates.array_push('author.php')
	return get_query_template('author', var_templates.clone())
}

fn get_category_template() rt.PhpVal {
	mut var_category := rt.new_null()
	mut var_templates := rt.new_null()
	mut var_slug_decoded := rt.new_null()
	var_category = rt.call_function('get_queried_object', []rt.PhpVal{})
	var_templates = rt.new_array()
	if !(!rt.is_true(rt.get_property(var_category, 'slug'))) {
		var_slug_decoded = rt.call_function('urldecode', [
			rt.get_property(var_category, 'slug'),
		])
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_slug_decoded, rt.get_property(var_category,
			'slug')))))
		{
			var_templates.array_push('category-${var_slug_decoded.to_string()}.php')
		}
		var_templates.array_push(rt.concat(rt.concat(rt.new_string('category-'), rt.get_property(var_category,
			'slug')), rt.new_string('.php')))
		var_templates.array_push(rt.concat(rt.concat(rt.new_string('category-'), rt.get_property(var_category,
			'term_id')), rt.new_string('.php')))
	}
	var_templates.array_push('category.php')
	return get_query_template('category', var_templates.clone())
}

fn get_tag_template() rt.PhpVal {
	mut var_tag := rt.new_null()
	mut var_templates := rt.new_null()
	mut var_slug_decoded := rt.new_null()
	var_tag = rt.call_function('get_queried_object', []rt.PhpVal{})
	var_templates = rt.new_array()
	if !(!rt.is_true(rt.get_property(var_tag, 'slug'))) {
		var_slug_decoded = rt.call_function('urldecode', [
			rt.get_property(var_tag, 'slug'),
		])
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_slug_decoded, rt.get_property(var_tag,
			'slug')))))
		{
			var_templates.array_push('tag-${var_slug_decoded.to_string()}.php')
		}
		var_templates.array_push(rt.concat(rt.concat(rt.new_string('tag-'), rt.get_property(var_tag,
			'slug')), rt.new_string('.php')))
		var_templates.array_push(rt.concat(rt.concat(rt.new_string('tag-'), rt.get_property(var_tag,
			'term_id')), rt.new_string('.php')))
	}
	var_templates.array_push('tag.php')
	return get_query_template('tag', var_templates.clone())
}

fn get_taxonomy_template() rt.PhpVal {
	mut var_term := rt.new_null()
	mut var_templates := rt.new_null()
	mut var_taxonomy := rt.new_null()
	mut var_slug_decoded := rt.new_null()
	var_term = rt.call_function('get_queried_object', []rt.PhpVal{})
	var_templates = rt.new_array()
	if !(!rt.is_true(rt.get_property(var_term, 'slug'))) {
		var_taxonomy = rt.get_property(var_term, 'taxonomy')
		var_slug_decoded = rt.call_function('urldecode', [
			rt.get_property(var_term, 'slug'),
		])
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_slug_decoded, rt.get_property(var_term,
			'slug')))))
		{
			var_templates.array_push('taxonomy-${var_taxonomy.to_string()}-${var_slug_decoded.to_string()}.php')
		}
		var_templates.array_push(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('taxonomy-'),
			var_taxonomy), rt.new_string('-')), rt.get_property(var_term, 'slug')),
			rt.new_string('.php')))
		var_templates.array_push(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('taxonomy-'),
			var_taxonomy), rt.new_string('-')), rt.get_property(var_term, 'term_id')),
			rt.new_string('.php')))
		var_templates.array_push('taxonomy-${var_taxonomy.to_string()}.php')
	}
	var_templates.array_push('taxonomy.php')
	return get_query_template('taxonomy', var_templates.clone())
}

fn get_date_template() rt.PhpVal {
	return get_query_template('date', rt.new_null())
}

fn get_home_template() rt.PhpVal {
	mut var_templates := rt.new_null()
	var_templates = rt.create_array([rt.ArrayItem{ key: none, val: 'home.php' },
		rt.ArrayItem{ key: none, val: 'index.php' }])
	return get_query_template('home', var_templates.clone())
}

fn get_front_page_template() rt.PhpVal {
	mut var_templates := rt.new_null()
	var_templates = rt.create_array([rt.ArrayItem{ key: none, val: 'front-page.php' }])
	return get_query_template('frontpage', var_templates.clone())
}

fn get_privacy_policy_template() rt.PhpVal {
	mut var_templates := rt.new_null()
	var_templates = rt.create_array([
		rt.ArrayItem{ key: none, val: 'privacy-policy.php' },
	])
	return get_query_template('privacypolicy', var_templates.clone())
}

fn get_page_template() rt.PhpVal {
	mut var_id := rt.new_null()
	mut var_template := rt.new_null()
	mut var_pagename := rt.new_null()
	mut var_post := rt.new_null()
	mut var_templates := rt.new_null()
	mut var_pagename_decoded := rt.new_null()
	var_id = rt.call_function('get_queried_object_id', []rt.PhpVal{})
	var_template = rt.call_function('get_page_template_slug', []rt.PhpVal{})
	var_pagename = rt.call_function('get_query_var', [rt.new_string('pagename')])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_pagename)))) && rt.is_true(var_id) {
		var_post = rt.call_function('get_queried_object', []rt.PhpVal{})
		if rt.is_true(var_post) {
			var_pagename = rt.get_property(var_post, 'post_name')
		}
	}
	var_templates = rt.new_array()
	if rt.is_true(var_template)
		&& rt.is_true(rt.identical(rt.new_int(0), rt.call_function('validate_file', [var_template.clone()]))) {
		var_templates.array_push(var_template.clone())
	}
	if rt.is_true(var_pagename) {
		var_pagename_decoded = rt.call_function('urldecode', [
			var_pagename.clone()])
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_pagename_decoded, var_pagename)))) {
			var_templates.array_push('page-${var_pagename_decoded.to_string()}.php')
		}
		var_templates.array_push('page-${var_pagename.to_string()}.php')
	}
	if rt.is_true(var_id) {
		var_templates.array_push('page-${var_id.to_string()}.php')
	}
	var_templates.array_push('page.php')
	return get_query_template('page', var_templates.clone())
}

fn get_search_template() rt.PhpVal {
	return get_query_template('search', rt.new_null())
}

fn get_single_template() rt.PhpVal {
	mut var_object := rt.new_null()
	mut var_templates := rt.new_null()
	mut var_template := rt.new_null()
	mut var_name_decoded := rt.new_null()
	var_object = rt.call_function('get_queried_object', []rt.PhpVal{})
	var_templates = rt.new_array()
	if !(!rt.is_true(rt.get_property(var_object, 'post_type'))) {
		var_template = rt.call_function('get_page_template_slug', [
			var_object.clone()])
		if rt.is_true(var_template)
			&& rt.is_true(rt.identical(rt.new_int(0), rt.call_function('validate_file', [var_template.clone()]))) {
			var_templates.array_push(var_template.clone())
		}
		var_name_decoded = rt.call_function('urldecode', [
			rt.get_property(var_object, 'post_name'),
		])
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_name_decoded, rt.get_property(var_object,
			'post_name')))))
		{
			var_templates.array_push(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('single-'), rt.get_property(var_object,
				'post_type')), rt.new_string('-')), var_name_decoded), rt.new_string('.php')))
		}
		var_templates.array_push(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('single-'), rt.get_property(var_object,
			'post_type')), rt.new_string('-')), rt.get_property(var_object, 'post_name')),
			rt.new_string('.php')))
		var_templates.array_push(rt.concat(rt.concat(rt.new_string('single-'), rt.get_property(var_object,
			'post_type')), rt.new_string('.php')))
	}
	var_templates.array_push('single.php')
	return get_query_template('single', var_templates.clone())
}

fn get_embed_template() rt.PhpVal {
	mut var_object := rt.new_null()
	mut var_templates := rt.new_null()
	mut var_post_format := rt.new_null()
	var_object = rt.call_function('get_queried_object', []rt.PhpVal{})
	var_templates = rt.new_array()
	if !(!rt.is_true(rt.get_property(var_object, 'post_type'))) {
		var_post_format = rt.call_function('get_post_format', [
			var_object.clone()])
		if rt.is_true(var_post_format) {
			var_templates.array_push(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('embed-'), rt.get_property(var_object,
				'post_type')), rt.new_string('-')), var_post_format), rt.new_string('.php')))
		}
		var_templates.array_push(rt.concat(rt.concat(rt.new_string('embed-'), rt.get_property(var_object,
			'post_type')), rt.new_string('.php')))
	}
	var_templates.array_push('embed.php')
	return get_query_template('embed', var_templates.clone())
}

fn get_singular_template() rt.PhpVal {
	return get_query_template('singular', rt.new_null())
}

fn get_attachment_template() rt.PhpVal {
	mut var_type := rt.new_null()
	mut var_subtype := rt.new_null()
	mut var_attachment := rt.new_null()
	mut var_templates := rt.new_null()
	var_attachment = rt.call_function('get_queried_object', []rt.PhpVal{})
	var_templates = rt.new_array()
	if rt.is_true(var_attachment) {
		if rt.is_true(rt.call_function('str_contains', [
			rt.get_property(var_attachment, 'post_mime_type'),
			rt.new_string('/'),
		]))
		{
			mut list_tmp_1 := rt.call_function('explode', [rt.new_string('/'),
				rt.get_property(var_attachment, 'post_mime_type')])
			var_type = list_tmp_1.array_get(0)
			var_subtype = list_tmp_1.array_get(1)
		} else {
			mut list_tmp_2 := rt.create_array([
				rt.ArrayItem{ key: none, val: rt.get_property(var_attachment, 'post_mime_type') },
				rt.ArrayItem{ key: none, val: '' },
			])
			var_type = list_tmp_2.array_get(0)
			var_subtype = list_tmp_2.array_get(1)
		}
		if !(!rt.is_true(var_subtype)) {
			var_templates.array_push('${var_type.to_string()}-${var_subtype.to_string()}.php')
			var_templates.array_push('${var_subtype.to_string()}.php')
		}
		var_templates.array_push('${var_type.to_string()}.php')
	}
	var_templates.array_push('attachment.php')
	return get_query_template('attachment', var_templates.clone())
}

fn wp_set_template_globals() {
	mut var_wp_stylesheet_path := rt.new_null()
	mut var_wp_template_path := rt.new_null()
	var_wp_stylesheet_path = rt.call_function('get_stylesheet_directory', []rt.PhpVal{})
	var_wp_template_path = rt.call_function('get_template_directory', []rt.PhpVal{})
}

fn locate_template(var_template_names rt.PhpVal, load bool, load_once bool, var_args rt.PhpVal) rt.PhpVal {
	mut var_load := load
	mut var_load_once := load_once
	mut var_wp_stylesheet_path := rt.new_null()
	mut var_wp_template_path := rt.new_null()
	mut var_is_child_theme := rt.new_null()
	mut var_located := rt.new_null()
	mut var_template_name := rt.new_null()
	if !(!var_wp_stylesheet_path.is_null()) || !(!var_wp_template_path.is_null()) {
		wp_set_template_globals()
	}
	var_is_child_theme = rt.call_function('is_child_theme', []rt.PhpVal{})
	var_located = rt.new_string('')
	mut iter_1 := rt.cast_array(var_template_names).iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_template_name_shadow := item_1.val
		if rt.is_true(rt.new_bool(!(rt.is_true(var_template_name_shadow)))) {
			continue
		}
		if rt.is_true(rt.call_function('file_exists', [
			rt.new_string(var_wp_stylesheet_path.str() + '/' + var_template_name_shadow.str()),
		]))
		{
			var_located = rt.new_string(var_wp_stylesheet_path.str() + '/' +
				var_template_name_shadow.str())
			break
		} else if rt.is_true(var_is_child_theme)
			&& rt.is_true(rt.call_function('file_exists', [rt.new_string(var_wp_template_path.str() + '/' + var_template_name_shadow.str())])) {
			var_located = rt.new_string(var_wp_template_path.str() + '/' +
				var_template_name_shadow.str())
			break
		} else if rt.is_true(rt.call_function('file_exists', [
			rt.new_string((rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() +
				'/theme-compat/' + var_template_name_shadow.str()),
		]))
		{
			var_located = rt.new_string((rt.get_constant('ABSPATH')).str() +
				(rt.get_constant('WPINC')).str() + '/theme-compat/' + var_template_name_shadow.str())
			break
		}
	}
	if var_load
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), var_located)))) {
		load_template(var_located.clone(), load_once, var_args.clone())
	}
	return var_located.clone()
}

fn load_template(var__template_file rt.PhpVal, load_once bool, var_args rt.PhpVal) {
	mut var_load_once := load_once
	mut var_posts := rt.new_null()
	mut var_post := rt.new_null()
	mut var_wp_did_header := rt.new_null()
	mut var_wp_query := rt.new_null()
	mut var_wp_rewrite := rt.new_null()
	mut var_wpdb := rt.new_null()
	mut var_wp_version := rt.new_null()
	mut var_wp := rt.new_null()
	mut var_id := rt.new_null()
	mut var_comment := rt.new_null()
	mut var_user_ID := rt.new_null()
	mut var_s := rt.new_null()
	if rt.is_true(rt.new_bool(rt.get_property(var_wp_query, 'query_vars').is_array())) {
		rt.call_function('extract', [rt.get_property(var_wp_query, 'query_vars'),
			rt.get_constant('EXTR_SKIP')])
	}
	if !var_s.is_null() {
		var_s = rt.call_function('esc_attr', [var_s.clone()])
	}
	rt.call_function('do_action', [rt.new_string('wp_before_load_template'),
		var__template_file.clone(), rt.new_bool(load_once), var_args.clone()])
	if var_load_once {
		rt.include_file(var__template_file.to_string(), '4')
	} else {
		rt.include_file(var__template_file.to_string(), '3')
	}
	rt.call_function('do_action', [rt.new_string('wp_after_load_template'),
		var__template_file.clone(), rt.new_bool(load_once), var_args.clone()])
}

fn wp_should_output_buffer_template_for_enhancement() bool {
	return (rt.call_function('apply_filters', [
		rt.new_string('wp_should_output_buffer_template_for_enhancement'),
		rt.new_bool(
			rt.is_true(rt.call_function('has_filter', [rt.new_string('wp_template_enhancement_output_buffer')]))
			|| rt.is_true(rt.call_function('has_action', [rt.new_string('wp_finalized_template_enhancement_output_buffer')]))),
	])).to_bool()
}

fn wp_start_template_enhancement_output_buffer() bool {
	mut var_started := rt.new_null()
	if !(wp_should_output_buffer_template_for_enhancement()) {
		return false
	}
	var_started = rt.call_function('ob_start', [
		rt.new_string('wp_finalize_template_enhancement_output_buffer'),
		rt.new_int(0),
		rt.bitwise_xor(rt.get_constant('PHP_OUTPUT_HANDLER_STDFLAGS'),
			rt.get_constant('PHP_OUTPUT_HANDLER_FLUSHABLE')),
	])
	if rt.is_true(var_started) {
		rt.call_function('do_action', [
			rt.new_string('wp_template_enhancement_output_buffer_started'),
		])
	}
	return var_started.to_bool()
}

fn wp_finalize_template_enhancement_output_buffer(output string, phase i64) string {
	mut var_output := output
	mut var_phase := phase
	mut var_is_html_content_type := rt.new_null()
	mut var_html_content_types := []rt.PhpVal{}
	mut var_header := rt.new_null()
	mut var_header_parts := rt.new_null()
	mut var_media_type := ''
	mut var_filtered_output := rt.new_null()
	mut var_did_just_catch := false
	mut var_error_log := rt.new_null()
	mut var_original_display_errors := rt.new_null()
	mut var_throwable := rt.new_null()
	mut var_error := map[string]rt.PhpVal{}
	mut var_type := rt.new_null()
	mut var_format := ''
	if rt.is_true(rt.new_bool(rt.bitwise_and(rt.new_int(phase),
		rt.get_constant('PHP_OUTPUT_HANDLER_CLEAN')) != 0))
	{
		return output
	}
	var_is_html_content_type = rt.new_null()
	var_html_content_types = ['text/html', 'application/xhtml+xml']
	mut iter_2 := rt.call_function('headers_list', []rt.PhpVal{}).iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_header_shadow := item_2.val
		var_header_parts = rt.call_function('explode', [rt.new_string(':'),
			rt.new_string(var_header_shadow.clone().to_string().to_lower()),
			rt.new_int(2)])
		if var_header_parts.clone().array_count() == 2
			&& rt.is_true(rt.identical(rt.new_string('content-type'), var_header_parts.array_get(rt.new_int(0)))) {
			var_media_type = rt.call_function('strtok', [var_header_parts.array_get(rt.new_int(1)),
				rt.new_string(';')]).to_string().trim_space()
			var_is_html_content_type = rt.call_function('in_array', [
				rt.new_string(var_media_type.str()).clone(),
				rt.create_array_from_list(var_html_content_types),
				rt.new_bool(true)])
			break
		}
	}
	if rt.is_true(rt.identical(rt.new_null(), var_is_html_content_type)) {
		var_is_html_content_type = rt.call_function('in_array', [
			rt.call_function('ini_get', [rt.new_string('default_mimetype')]),
			rt.create_array_from_list(var_html_content_types),
			rt.new_bool(true),
		])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_is_html_content_type)))) {
		rt.call_function('do_action', [
			rt.new_string('wp_finalized_template_enhancement_output_buffer'),
			rt.new_string(output),
		])
		return output
	}
	var_filtered_output = rt.new_string(output)
	var_did_just_catch = false
	var_error_log = rt.new_array()
	closure_1_fn := fn [mut var_error_log, mut var_did_just_catch] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_level := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_message := if args.len > 1 { args[1].clone() } else { rt.new_null() }
		mut var_file := if args.len > 2 { args[2].clone() } else { rt.new_null() }
		mut var_line := if args.len > 3 { args[3].clone() } else { rt.new_null() }
		if rt.is_true(rt.identical(rt.get_constant('E_USER_ERROR'), var_level)) {
			rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(
				(rt.call_function('__', [rt.new_string('User error triggered:')])).str() + ' ' +
				var_message.str())))
		}
		if var_did_just_catch {
			var_level = rt.get_constant('E_USER_ERROR')
		}
		if rt.is_true(rt.bitwise_and(rt.call_function('error_reporting', []rt.PhpVal{}), var_level)) {
			var_error_log.array_push(rt.call_function('compact', [
				rt.new_string('level'), rt.new_string('message'),
				rt.new_string('file'), rt.new_string('line')]))
		}
		return false
	}
	closure_2_fn := fn [mut var_error_log, mut var_did_just_catch] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_level := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_message := if args.len > 1 { args[1].clone() } else { rt.new_null() }
		mut var_file := if args.len > 2 { args[2].clone() } else { rt.new_null() }
		mut var_line := if args.len > 3 { args[3].clone() } else { rt.new_null() }
		if rt.is_true(rt.identical(rt.get_constant('E_USER_ERROR'), var_level)) {
			rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(
				(rt.call_function('__', [rt.new_string('User error triggered:')])).str() + ' ' +
				var_message.str())))
		}
		if var_did_just_catch {
			var_level = rt.get_constant('E_USER_ERROR')
		}
		if rt.is_true(rt.bitwise_and(rt.call_function('error_reporting', []rt.PhpVal{}), var_level)) {
			var_error_log.array_push(rt.call_function('compact', [
				rt.new_string('level'), rt.new_string('message'),
				rt.new_string('file'), rt.new_string('line')]))
		}
		return false
	}
	rt.call_function('set_error_handler', [rt.new_closure(closure_1_fn)])
	var_original_display_errors = rt.call_function('ini_get', [
		rt.new_string('display_errors'),
	])
	if rt.is_true(var_original_display_errors) {
		rt.call_function('ini_set', [rt.new_string('display_errors'),
			rt.new_int(0)])
	}
	var_filtered_output = rt.new_string((rt.call_function('apply_filters', [
		rt.new_string('wp_template_enhancement_output_buffer'),
		var_filtered_output.clone(),
		rt.new_string(output),
	])).str())
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	unsafe {
		goto end_label_1
	}
	catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'Throwable') {
		var_throwable = var_e_1.clone()
		var_did_just_catch = true
		rt.call_function('trigger_error', [
			rt.new_string(
				(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Uncaught "%s" thrown:')]), rt.call_function('get_class', [var_throwable.clone()])])).str() +
				' ' + (rt.call_method(var_throwable, 'getMessage', []rt.PhpVal{})).str()),
			rt.get_constant('E_USER_WARNING'),
		])
		var_did_just_catch = false
		unsafe {
			goto end_label_1
		}
	} else {
		rt.throw_exception(var_e_1)
		unsafe {
			goto end_label_1
		}
	}

	end_label_1:
	rt.call_function('do_action', [
		rt.new_string('wp_finalized_template_enhancement_output_buffer'),
		var_filtered_output.clone(),
	])
	if rt.has_exception() {
		unsafe {
			goto catch_label_2
		}
	}
	unsafe {
		goto end_label_2
	}
	catch_label_2:
	mut var_e_2 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_2, 'Throwable') {
		var_throwable = var_e_2.clone()
		var_did_just_catch = true
		rt.call_function('trigger_error', [
			rt.new_string(
				(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Uncaught "%s" thrown:')]), rt.call_function('get_class', [var_throwable.clone()])])).str() +
				' ' + (rt.call_method(var_throwable, 'getMessage', []rt.PhpVal{})).str()),
			rt.get_constant('E_USER_WARNING'),
		])
		var_did_just_catch = false
		unsafe {
			goto end_label_2
		}
	} else {
		rt.throw_exception(var_e_2)
		unsafe {
			goto end_label_2
		}
	}

	end_label_2:
	if rt.is_true(var_original_display_errors)
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('stderr'), var_original_display_errors)))) {
		mut iter_3 := var_error_log.iterator()
		for {
			item_3 := iter_3.next() or { break }
			mut var_error_shadow := item_3.val
			mut switch_val_1 := var_error_shadow['level']
			if rt.is_true(rt.equal(switch_val_1, rt.get_constant('E_USER_NOTICE'))) {
				var_type = rt.new_string('Notice')
			} else if rt.is_true(rt.equal(switch_val_1, rt.get_constant('E_USER_DEPRECATED'))) {
				var_type = rt.new_string('Deprecated')
			} else if rt.is_true(rt.equal(switch_val_1, rt.get_constant('E_USER_WARNING'))) {
				var_type = rt.new_string('Warning')
			} else {
				var_type = rt.new_string('Error')
			}
			if rt.is_true(rt.call_function('ini_get', [rt.new_string('html_errors')])) {
				var_format = '%s<br />\n<b>%s</b>:  %s in <b>%s</b> on line <b>%s</b><br />\n%s'
			} else {
				var_format = '%s\n%s: %s in %s on line %s\n%s'
			}
			var_filtered_output = rt.concat(var_filtered_output, rt.call_function('sprintf', [
				rt.new_string(var_format.str()).clone(),
				rt.call_function('ini_get', [rt.new_string('error_prepend_string')]),
				var_type.clone(),
				var_error_shadow['message'],
				var_error_shadow['file'],
				var_error_shadow['line'],
				rt.call_function('ini_get', [rt.new_string('error_append_string')]),
			]))
		}
		rt.call_function('ini_set', [rt.new_string('display_errors'),
			var_original_display_errors.clone()])
	}
	rt.call_function('restore_error_handler', []rt.PhpVal{})
	return var_filtered_output.str()
}

struct Class_Exception {
	rt.PhpObjectBase
pub mut:
	message string
	code    i64
	file    string
	line    i64
}

fn (mut this Class_Exception) construct(var_message rt.PhpVal) {
	this.message = var_message.to_string()
}

fn (mut this Class_Exception) getmessage() string {
	return this.message
}

fn create_exception(arg_0 rt.PhpVal) &Class_Exception {
	mut obj := &Class_Exception{
		PhpObjectBase: rt.PhpObjectBase{}
		message:       ''
		code:          i64(0)
		file:          ''
		line:          i64(0)
	}
	obj.construct(arg_0)
	return obj
}

fn (mut this Class_Exception) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'getMessage' {
			return rt.new_string(this.getmessage())
		}
		else {
			return none
		}
	}
}

fn (this &Class_Exception) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'message' { return rt.new_string(this.message) }
		'code' { return rt.new_int(this.code) }
		'file' { return rt.new_string(this.file) }
		'line' { return rt.new_int(this.line) }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Exception) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'message' {
			this.message = val.str()
			return true
		}
		'code' {
			this.code = val.to_i64()
			return true
		}
		'file' {
			this.file = val.str()
			return true
		}
		'line' {
			this.line = val.to_i64()
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn main() {
	defer {
		rt.shutdown()
	}
}
