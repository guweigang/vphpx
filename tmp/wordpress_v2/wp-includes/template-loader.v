import rt

fn main() {
	defer {
		rt.shutdown()
	}

	if rt.is_true(rt.call_function('wp_using_themes', []rt.PhpVal{})) {
		rt.call_function('do_action', [rt.new_string('template_redirect')])
	}
	if rt.is_true(rt.identical(rt.new_string('HEAD'), rt.get_superglobal('_SERVER').array_get(rt.new_string('REQUEST_METHOD'))))
		&& rt.is_true(rt.call_function('apply_filters', [rt.new_string('exit_on_http_head'), rt.new_bool(true)])) {
		exit(0)
	}
	if rt.is_true(rt.call_function('is_robots', []rt.PhpVal{})) {
		rt.call_function('do_action', [rt.new_string('do_robots')])
		return rt.new_null()
	} else if rt.is_true(rt.call_function('is_favicon', []rt.PhpVal{})) {
		rt.call_function('do_action', [rt.new_string('do_favicon')])
		return rt.new_null()
	} else if rt.is_true(rt.call_function('is_feed', []rt.PhpVal{})) {
		rt.call_function('do_feed', []rt.PhpVal{})
		return rt.new_null()
	} else if rt.is_true(rt.call_function('is_trackback', []rt.PhpVal{})) {
		rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-trackback.php', '3')
		return rt.new_null()
	}
	if rt.is_true(rt.call_function('wp_using_themes', []rt.PhpVal{})) {
		mut var_tag_templates := {
			'is_embed':             'get_embed_template'
			'is_404':               'get_404_template'
			'is_search':            'get_search_template'
			'is_front_page':        'get_front_page_template'
			'is_home':              'get_home_template'
			'is_privacy_policy':    'get_privacy_policy_template'
			'is_post_type_archive': 'get_post_type_archive_template'
			'is_tax':               'get_taxonomy_template'
			'is_attachment':        'get_attachment_template'
			'is_single':            'get_single_template'
			'is_page':              'get_page_template'
			'is_singular':          'get_singular_template'
			'is_category':          'get_category_template'
			'is_tag':               'get_tag_template'
			'is_author':            'get_author_template'
			'is_date':              'get_date_template'
			'is_archive':           'get_archive_template'
		}
		mut var_template := rt.new_bool(false)
		for var_tag, var_template_getter in var_tag_templates {
			if rt.is_true(rt.call_function('call_user_func', [
				rt.new_string(tag)]))
			{
				var_template = rt.call_function('call_user_func', [
					rt.new_string(template_getter),
				])
			}
			if rt.is_true(var_template) {
				if rt.is_true(rt.identical(rt.new_string('is_attachment'), rt.new_string(tag))) {
					rt.call_function('remove_filter', [rt.new_string('the_content'),
						rt.new_string('prepend_attachment')])
				}
				break
			}
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(var_template)))) {
			var_template = rt.call_function('get_index_template', []rt.PhpVal{})
		}
		var_template = rt.call_function('apply_filters', [
			rt.new_string('template_include'),
			var_template.clone(),
		])
		mut var_is_stringy := var_template.clone().is_string()
			|| var_template.clone().is_object()
			&& rt.is_true(rt.call_function('method_exists', [var_template.clone(), rt.new_string('__toString')]))
		var_template = if var_is_stringy { rt.call_function('realpath', [
				rt.new_string(var_template.str()),
			]) } else { rt.new_null() }
		if var_template.clone().is_string()
			&& rt.is_true(rt.call_function('str_ends_with', [var_template.clone(), rt.new_string('.php')]))
			|| rt.is_true(rt.call_function('str_ends_with', [var_template.clone(), rt.new_string('.html')]))
			&& rt.is_true(rt.call_function('is_file', [var_template.clone()]))
			&& rt.is_true(rt.call_function('is_readable', [var_template.clone()])) {
			rt.call_function('do_action', [rt.new_string('wp_before_include_template'),
				var_template.clone()])
			rt.include_file(var_template.to_string(), '1')
		} else if rt.is_true(rt.call_function('current_user_can', [
			rt.new_string('switch_themes'),
		]))
		{
			mut var_theme := rt.call_function('wp_get_theme', []rt.PhpVal{})
			if rt.is_true(rt.call_method(var_theme, 'errors', []rt.PhpVal{})) {
				rt.call_function('wp_die', [
					rt.call_method(var_theme, 'errors', []rt.PhpVal{}),
				])
			}
		}
		return rt.new_null()
	}
}
