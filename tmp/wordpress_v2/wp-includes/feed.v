import rt

fn get_bloginfo_rss(show string) rt.PhpVal {
	mut var_show := show
	mut var_info := rt.new_null()
	var_info = rt.call_function('strip_tags', [
		rt.call_function('get_bloginfo', [rt.new_string(show)]),
	])
	return rt.call_function('apply_filters', [rt.new_string('get_bloginfo_rss'),
		rt.call_function('convert_chars', [var_info.clone()]),
		rt.new_string(show)])
}

fn bloginfo_rss(show string) {
	mut var_show := show
	rt.echo_val(rt.call_function('apply_filters', [rt.new_string('bloginfo_rss'),
		get_bloginfo_rss(show), rt.new_string(show)]))
}

fn get_default_feed() rt.PhpVal {
	mut var_default_feed := rt.new_null()
	var_default_feed = rt.call_function('apply_filters', [rt.new_string('default_feed'),
		rt.new_string('rss2')])
	return if rt.is_true(rt.identical(rt.new_string('rss'), var_default_feed)) {
		rt.new_string('rss2')
	} else {
		var_default_feed
	}
}

fn get_wp_title_rss(deprecated string) rt.PhpVal {
	mut var_deprecated := deprecated
	if rt.is_true(rt.new_bool('&#8211;' != deprecated)) {
		rt.call_function('_deprecated_argument', [rt.new_string(@FN),
			rt.new_string('4.4.0'),
			rt.call_function('sprintf', [
				rt.call_function('__', [rt.new_string('Use the %s filter instead.')]),
				rt.new_string('<code>document_title_separator</code>'),
			])])
	}
	return rt.call_function('apply_filters', [rt.new_string('get_wp_title_rss'),
		rt.call_function('wp_get_document_title', []rt.PhpVal{}),
		rt.new_string(deprecated)])
}

fn wp_title_rss(deprecated string) {
	mut var_deprecated := deprecated
	if rt.is_true(rt.new_bool('&#8211;' != deprecated)) {
		rt.call_function('_deprecated_argument', [rt.new_string(@FN),
			rt.new_string('4.4.0'),
			rt.call_function('sprintf', [
				rt.call_function('__', [rt.new_string('Use the %s filter instead.')]),
				rt.new_string('<code>document_title_separator</code>'),
			])])
	}
	rt.echo_val(rt.call_function('apply_filters', [rt.new_string('wp_title_rss'),
		get_wp_title_rss(''), rt.new_string(deprecated)]))
}

fn get_the_title_rss(post i64) rt.PhpVal {
	mut var_post := post
	mut var_title := rt.new_null()
	var_title = rt.call_function('get_the_title', [rt.new_int(post)])
	return rt.call_function('apply_filters', [rt.new_string('the_title_rss'),
		var_title.clone()])
}

fn the_title_rss() {
	rt.echo_val(get_the_title_rss(0))
}

fn get_the_content_feed(var_feed_type_arg rt.PhpVal) rt.PhpVal {
	mut var_feed_type := var_feed_type_arg
	mut var_content := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(var_feed_type)))) {
		var_feed_type = get_default_feed()
	}
	var_content = rt.call_function('apply_filters', [rt.new_string('the_content'),
		rt.call_function('get_the_content', []rt.PhpVal{})])
	var_content = rt.call_function('str_replace', [rt.new_string(']]>'),
		rt.new_string(']]&gt;'), var_content.clone()])
	return rt.call_function('apply_filters', [rt.new_string('the_content_feed'),
		var_content.clone(), var_feed_type.clone()])
}

fn the_content_feed(var_feed_type rt.PhpVal) {
	rt.echo_val(get_the_content_feed(var_feed_type.clone()))
}

fn the_excerpt_rss() {
	mut var_output := rt.new_null()
	var_output = rt.call_function('get_the_excerpt', []rt.PhpVal{})
	rt.echo_val(rt.call_function('apply_filters', [rt.new_string('the_excerpt_rss'),
		var_output.clone()]))
}

fn the_permalink_rss() {
	rt.echo_val(rt.call_function('esc_url', [
		rt.call_function('apply_filters', [rt.new_string('the_permalink_rss'),
			rt.call_function('get_permalink', []rt.PhpVal{})]),
	]))
}

fn comments_link_feed() {
	rt.echo_val(rt.call_function('esc_url', [
		rt.call_function('apply_filters', [rt.new_string('comments_link_feed'),
			rt.call_function('get_comments_link', []rt.PhpVal{})]),
	]))
}

fn comment_guid(var_comment_id rt.PhpVal) {
	rt.echo_val(rt.call_function('esc_url', [get_comment_guid(var_comment_id.clone())]))
}

fn get_comment_guid(var_comment_id rt.PhpVal) rt.PhpVal {
	mut var_comment := rt.new_null()
	var_comment = rt.call_function('get_comment', [var_comment_id.clone()])
	if !(var_comment.clone().is_object()) {
		return rt.new_bool(false)
	}
	return rt.new_string(
		(rt.call_function('get_the_guid', [rt.get_property(var_comment, 'comment_post_ID')])).str() +
		'#comment-' + (rt.get_property(var_comment, 'comment_ID')).str())
}

fn comment_link(var_comment rt.PhpVal) {
	rt.echo_val(rt.call_function('esc_url', [
		rt.call_function('apply_filters', [rt.new_string('comment_link'),
			rt.call_function('get_comment_link', [var_comment.clone()])]),
	]))
}

fn get_comment_author_rss() rt.PhpVal {
	return rt.call_function('apply_filters', [rt.new_string('comment_author_rss'),
		rt.call_function('get_comment_author', []rt.PhpVal{})])
}

fn comment_author_rss() {
	rt.echo_val(get_comment_author_rss())
}

fn comment_text_rss() {
	mut var_comment_text := rt.new_null()
	var_comment_text = rt.call_function('get_comment_text', []rt.PhpVal{})
	var_comment_text = rt.call_function('apply_filters', [
		rt.new_string('comment_text_rss'),
		var_comment_text.clone(),
	])
	rt.echo_val(var_comment_text)
}

fn get_the_category_rss(var_type_arg rt.PhpVal) rt.PhpVal {
	mut var_type := var_type_arg
	mut var_categories := rt.new_null()
	mut var_tags := rt.new_null()
	mut var_the_list := ''
	mut var_cat_names := rt.new_null()
	mut var_filter := ''
	mut var_category := rt.new_null()
	mut var_tag := rt.new_null()
	mut var_cat_name := rt.new_null()
	if !rt.is_true(var_type) {
		var_type = get_default_feed()
	}
	var_categories = rt.call_function('get_the_category', []rt.PhpVal{})
	var_tags = rt.call_function('get_the_tags', []rt.PhpVal{})
	var_the_list = ''
	var_cat_names = rt.new_array()
	var_filter = 'rss'
	if rt.is_true(rt.identical(rt.new_string('atom'), var_type)) {
		var_filter = 'raw'
	}
	if !(!rt.is_true(var_categories)) {
		mut iter_1 := rt.cast_array(var_categories).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_category_shadow := item_1.val
			var_cat_names.array_push(rt.call_function('sanitize_term_field', [
				rt.new_string('name'),
				rt.get_property(var_category_shadow, 'name'),
				rt.get_property(var_category_shadow, 'term_id'),
				rt.new_string('category'),
				rt.new_string(var_filter.str()).clone(),
			]))
		}
	}
	if !(!rt.is_true(var_tags)) {
		mut iter_2 := rt.cast_array(var_tags).iterator()
		for {
			item_2 := iter_2.next() or { break }
			mut var_tag_shadow := item_2.val
			var_cat_names.array_push(rt.call_function('sanitize_term_field', [
				rt.new_string('name'),
				rt.get_property(var_tag_shadow, 'name'),
				rt.get_property(var_tag_shadow, 'term_id'),
				rt.new_string('post_tag'),
				rt.new_string(var_filter.str()).clone(),
			]))
		}
	}
	var_cat_names = rt.call_function('array_unique', [var_cat_names.clone()])
	mut iter_3 := var_cat_names.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_cat_name_shadow := item_3.val
		if rt.is_true(rt.identical(rt.new_string('rdf'), var_type)) {
			var_the_list = var_the_list +
				'\t\t<dc:subject><![CDATA[${var_cat_name.to_string()}]]></dc:subject>\n'
		} else if rt.is_true(rt.identical(rt.new_string('atom'), var_type)) {
			var_the_list = var_the_list +(rt.call_function('sprintf', [rt.new_string('<category scheme="%1$s" term="%2$s" />'), rt.call_function('esc_attr', [get_bloginfo_rss('url')]), rt.call_function('esc_attr', [var_cat_name_shadow.clone()])])).str()
		} else {
			var_the_list = var_the_list + '\t\t<category><![CDATA[' +
				(rt.call_function('html_entity_decode', [var_cat_name_shadow.clone(), rt.get_constant('ENT_COMPAT'), rt.call_function('get_option', [rt.new_string('blog_charset')])])).str() +
				']]></category>\n'
		}
	}
	return rt.call_function('apply_filters', [rt.new_string('the_category_rss'),
		rt.new_string(var_the_list.str()).clone(), var_type.clone()])
}

fn the_category_rss(var_type rt.PhpVal) {
	rt.echo_val(get_the_category_rss(var_type.clone()))
}

fn html_type_rss() {
	mut var_type := rt.new_null()
	var_type = rt.call_function('get_bloginfo', [rt.new_string('html_type')])
	if rt.is_true(rt.call_function('str_contains', [var_type.clone(),
		rt.new_string('xhtml')]))
	{
		var_type = rt.new_string('xhtml')
	} else {
		var_type = rt.new_string('html')
	}
	rt.echo_val(var_type)
}

fn rss_enclosure() {
	mut var_val := rt.new_null()
	mut var_key := rt.new_null()
	mut var_enc := rt.new_null()
	mut var_enclosure := rt.new_null()
	mut var_t := rt.new_null()
	mut var_type := rt.new_null()
	if rt.is_true(rt.call_function('post_password_required', []rt.PhpVal{})) {
		return
	}
	mut iter_4 := rt.cast_array(rt.call_function('get_post_custom', []rt.PhpVal{})).iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_val_shadow := item_4.val
		mut var_key_shadow := item_4.key
		if rt.is_true(rt.identical(rt.new_string('enclosure'), var_key_shadow)) {
			mut iter_5 := rt.cast_array(var_val_shadow).iterator()
			for {
				item_5 := iter_5.next() or { break }
				mut var_enc_shadow := item_5.val
				var_enclosure = rt.call_function('explode', [
					rt.new_string('\n'), var_enc_shadow.clone()])
				if var_enclosure.clone().array_count() < 3 {
					continue
				}
				var_t = rt.call_function('preg_split', [rt.new_string('/[ \\t]/'),
					rt.new_string(var_enclosure.array_get(rt.new_int(2)).to_string().trim_space())])
				var_type = var_t.array_get(rt.new_int(0))
				rt.echo_val(rt.call_function('apply_filters', [
					rt.new_string('rss_enclosure'),
					rt.new_string('<enclosure url="' +
						(rt.call_function('esc_url', [rt.new_string(var_enclosure.array_get(rt.new_int(0)).to_string().trim_space())])).str() +
						'" length="' +
						(rt.call_function('absint', [rt.new_string(var_enclosure.array_get(rt.new_int(1)).to_string().trim_space())])).str() +
						'" type="' + (rt.call_function('esc_attr', [var_type.clone()])).str() +
						'" />' + '\n'),
				]))
			}
		}
	}
}

fn atom_enclosure() {
	mut var_val := rt.new_null()
	mut var_key := rt.new_null()
	mut var_enc := rt.new_null()
	mut var_enclosure := rt.new_null()
	mut var_url := ''
	mut var_type := ''
	mut var_length := rt.new_null()
	mut var_mimes := rt.new_null()
	mut var_i := i64(0)
	mut var_html_link_tag := rt.new_null()
	if rt.is_true(rt.call_function('post_password_required', []rt.PhpVal{})) {
		return
	}
	mut iter_6 := rt.cast_array(rt.call_function('get_post_custom', []rt.PhpVal{})).iterator()
	for {
		item_6 := iter_6.next() or { break }
		mut var_val_shadow := item_6.val
		mut var_key_shadow := item_6.key
		if rt.is_true(rt.identical(rt.new_string('enclosure'), var_key_shadow)) {
			mut iter_7 := rt.cast_array(var_val_shadow).iterator()
			for {
				item_7 := iter_7.next() or { break }
				mut var_enc_shadow := item_7.val
				var_enclosure = rt.call_function('explode', [
					rt.new_string('\n'), var_enc_shadow.clone()])
				var_url = ''
				var_type = ''
				var_length = rt.new_int(0)
				var_mimes = rt.call_function('get_allowed_mime_types', []rt.PhpVal{})
				if var_enclosure.array_isset(rt.new_int(0))
					&& var_enclosure.array_get(rt.new_int(0)).is_string() {
					var_url = var_enclosure.array_get(rt.new_int(0)).to_string().trim_space()
				}
				var_i = 1
				for {
					if !(var_i <= 2) { break
					 }
					if var_enclosure.array_isset(rt.new_int(var_i)) {
						if rt.is_true(rt.new_bool(
							var_enclosure.array_get(rt.new_int(var_i)).is_long()
							|| var_enclosure.array_get(rt.new_int(var_i)).is_double()))
						{
							var_length =
								rt.new_string(var_enclosure.array_get(rt.new_int(var_i)).to_string().trim_space())
						} else if rt.is_true(rt.call_function('in_array', [
							var_enclosure.array_get(rt.new_int(var_i)),
							var_mimes.clone(),
							rt.new_bool(true),
						]))
						{
							var_type =
								var_enclosure.array_get(rt.new_int(var_i)).to_string().trim_space()
						}
					}
					var_i += 1
				}
				var_html_link_tag = rt.call_function('sprintf', [
					rt.new_string('<link href="%s" rel="enclosure" length="%d" type="%s" />\n'),
					rt.call_function('esc_url', [rt.new_string(var_url.str()).clone()]),
					rt.call_function('esc_attr', [var_length.clone()]),
					rt.call_function('esc_attr', [rt.new_string(var_type.str()).clone()]),
				])
				rt.echo_val(rt.call_function('apply_filters', [
					rt.new_string('atom_enclosure'),
					var_html_link_tag.clone(),
				]))
			}
		}
	}
}

fn prep_atom_text_construct(var_data_arg rt.PhpVal) rt.PhpVal {
	mut var_data := var_data_arg
	mut var_parser := rt.new_null()
	mut var_code := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('str_contains', [rt.new_string(var_data.str()).clone(), rt.new_string('<')])))))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('str_contains', [rt.new_string(var_data.str()).clone(), rt.new_string('&')]))))) {
		return rt.create_array([rt.ArrayItem{ key: none, val: 'text' },
			rt.ArrayItem{ key: none, val: var_data }])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('xml_parser_create'),
	])))))
	{
		rt.call_function('wp_trigger_error', [rt.new_string(''),
			rt.call_function('__', [
				rt.new_string("PHP's XML extension is not available. Please contact your hosting provider to enable PHP's XML extension."),
			])])
		return rt.create_array([rt.ArrayItem{ key: none, val: 'html' },
			rt.ArrayItem{ key: none, val: '<![CDATA[${var_data}]]>' }])
	}
	var_parser = rt.call_function('xml_parser_create', []rt.PhpVal{})
	rt.call_function('xml_parse', [var_parser.clone(), rt.new_string('<div>' + var_data + '</div>'),
		rt.new_bool(true)])
	var_code = rt.call_function('xml_get_error_code', [var_parser.clone()])
	if rt.is_true(rt.less(rt.get_constant('PHP_VERSION_ID'), rt.new_int(80000))) {
		rt.call_function('xml_parser_free', [var_parser.clone()])
	}
	var_parser = rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(var_code)))) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('str_contains', [
			rt.new_string(var_data.str()).clone(),
			rt.new_string('<'),
		])))))
		{
			return rt.create_array([rt.ArrayItem{ key: none, val: 'text' },
				rt.ArrayItem{ key: none, val: var_data }])
		} else {
			var_data = "<div xmlns='http://www.w3.org/1999/xhtml'>${var_data}</div>"
			return rt.create_array([rt.ArrayItem{ key: none, val: 'xhtml' },
				rt.ArrayItem{ key: none, val: var_data }])
		}
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('str_contains', [
		rt.new_string(var_data.str()).clone(), rt.new_string(']]>')])))))
	{
		return rt.create_array([rt.ArrayItem{ key: none, val: 'html' },
			rt.ArrayItem{ key: none, val: '<![CDATA[${var_data}]]>' }])
	} else {
		return rt.create_array([rt.ArrayItem{ key: none, val: 'html' },
			rt.ArrayItem{ key: none, val: rt.call_function('htmlspecialchars', [
				rt.new_string(var_data.str()).clone(),
			]) }])
	}
	return rt.new_null()
}

fn atom_site_icon() {
	mut var_url := rt.new_null()
	var_url = rt.call_function('get_site_icon_url', [rt.new_int(32)])
	if rt.is_true(var_url) {
		print('<icon>' + (rt.call_function('convert_chars', [var_url.clone()])).str() + '</icon>\n')
	}
}

fn rss2_site_icon() {
	mut var_rss_title := rt.new_null()
	mut var_url := rt.new_null()
	var_rss_title = get_wp_title_rss('')
	if !rt.is_true(var_rss_title) {
		var_rss_title = get_bloginfo_rss('name')
	}
	var_url = rt.call_function('get_site_icon_url', [rt.new_int(32)])
	if rt.is_true(var_url) {
		print('\n<image>\n\t<url>' + (rt.call_function('convert_chars', [var_url.clone()])).str() +
			'</url>\n\t<title>' + var_rss_title.str() + '</title>\n\t<link>' +
			(get_bloginfo_rss('url')).str() + '</link>\n\t<width>32</width>\n\t<height>32</height>\n</image> ' + '\n')
	}
}

fn get_self_link() rt.PhpVal {
	mut var_parsed := rt.new_null()
	mut var_domain := rt.new_null()
	var_parsed = rt.call_function('parse_url', [
		rt.call_function('home_url', []rt.PhpVal{}),
	])
	var_domain = var_parsed.array_get(rt.new_string('host'))
	if var_parsed.array_isset(rt.new_string('port')) {
		var_domain = rt.concat(var_domain, rt.new_string(':' +
			(var_parsed.array_get(rt.new_string('port'))).str()))
	}
	return rt.call_function('set_url_scheme', [
		rt.new_string('http://' + var_domain.str() +(rt.call_function('wp_unslash', [rt.get_superglobal('_SERVER').array_get(rt.new_string('REQUEST_URI'))])).str()),
	])
}

fn self_link() {
	rt.echo_val(rt.call_function('esc_url', [
		rt.call_function('apply_filters', [rt.new_string('self_link'),
			get_self_link()]),
	]))
}

fn get_feed_build_date(var_format rt.PhpVal) rt.PhpVal {
	mut var_wp_query := rt.new_null()
	mut var_datetime := rt.new_null()
	mut var_max_modified_time := rt.new_null()
	mut var_utc := rt.new_null()
	mut var_modified_times := rt.new_null()
	mut var_comment_times := rt.new_null()
	var_datetime = rt.new_bool(false)
	var_max_modified_time = rt.new_bool(false)
	var_utc = create_datetimezone(rt.new_string('UTC'))
	if !(!rt.is_true(var_wp_query))
		&& rt.is_true(rt.call_method(var_wp_query, 'have_posts', []rt.PhpVal{})) {
		var_modified_times = rt.call_function('wp_list_pluck', [
			rt.get_property(var_wp_query, 'posts'),
			rt.new_string('post_modified_gmt'),
		])
		if rt.is_true(rt.call_method(var_wp_query, 'is_comment_feed', []rt.PhpVal{}))
			&& rt.is_true(rt.get_property(var_wp_query, 'comment_count')) {
			var_comment_times = rt.call_function('wp_list_pluck', [
				rt.get_property(var_wp_query, 'comments'),
				rt.new_string('comment_date_gmt'),
			])
			var_modified_times = rt.call_function('array_merge', [
				var_modified_times.clone(), var_comment_times.clone()])
		}
		var_datetime = rt.call_function('date_create_immutable_from_format', [
			rt.new_string('Y-m-d H:i:s'),
			rt.call_function('max', [var_modified_times.clone()]),
			var_utc,
		])
	}
	if rt.is_true(rt.identical(rt.new_bool(false), var_datetime)) {
		var_datetime = rt.call_function('date_create_immutable_from_format', [
			rt.new_string('Y-m-d H:i:s'),
			rt.call_function('get_lastpostmodified', [rt.new_string('GMT')]),
			var_utc,
		])
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_datetime)))) {
		var_max_modified_time = rt.call_method(var_datetime, 'format', [
			var_format.clone()])
	}
	return rt.call_function('apply_filters', [rt.new_string('get_feed_build_date'),
		var_max_modified_time.clone(), var_format.clone()])
}

fn feed_content_type(type string) rt.PhpVal {
	mut var_type := type
	mut var_types := map[string]rt.PhpVal{}
	mut var_content_type := rt.new_null()
	if var_type == '' {
		var_type = (get_default_feed()).str()
	}
	var_types = {
		'rss':      'application/rss+xml'
		'rss2':     'application/rss+xml'
		'rss-http': 'text/xml'
		'atom':     'application/atom+xml'
		'rdf':      'application/rdf+xml'
	}
	var_content_type = rt.new_string((if !(var_types[var_type] == '') {
		var_types[var_type]
	} else {
		'application/octet-stream'
	}).str())
	return rt.call_function('apply_filters', [rt.new_string('feed_content_type'),
		var_content_type.clone(), rt.new_string(var_type.str())])
}

fn fetch_feed(var_url_arg rt.PhpVal) rt.PhpVal {
	mut var_url := var_url_arg
	mut var_feed := rt.new_null()
	mut var_feeds := []rt.PhpVal{}
	mut var_simplepie_errors := []rt.PhpVal{}
	mut var_feed_url := rt.new_null()
	mut var_simplepie_instance := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [
		rt.new_string('SimplePie\\SimplePie'),
		rt.new_bool(false),
	])))))
	{
		rt.include_file(
			(rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/class-simplepie.php',
			'4')
	}
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/class-wp-feed-cache-transient.php',
		'4')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/class-wp-simplepie-file.php',
		'4')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/class-wp-simplepie-sanitize-kses.php',
		'4')
	var_feed = create_simplepie_simplepie()
	rt.call_method(var_feed.get_registry(), 'register', [
		Class_SimplePie_Sanitize.class(),
		rt.new_string('WP_SimplePie_Sanitize_KSES'),
		rt.new_bool(true),
	])
	rt.set_property(var_feed, 'sanitize', create_wp_simplepie_sanitize_kses())
	if rt.is_true(rt.call_function('method_exists', [rt.new_string('SimplePie_Cache'),
		rt.new_string('register')]))
	{
		mut iife_temp_0 := Class_SimplePie_Cache{}
		mut iife_result_0 := iife_temp_0.register(rt.new_string('wp_transient'),
			rt.new_string('WP_Feed_Cache_Transient'))
		var_feed.set_cache_location(rt.new_string('wp_transient'))
	} else {
		rt.include_file(
			(rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/class-wp-feed-cache.php',
			'4')
		var_feed.set_cache_class(rt.new_string('WP_Feed_Cache'))
	}
	rt.call_method(var_feed.get_registry(), 'register', [Class_SimplePie_File.class(),
		rt.new_string('WP_SimplePie_File'), rt.new_bool(true)])
	var_feed.set_cache_duration(rt.call_function('apply_filters', [
		rt.new_string('wp_feed_cache_transient_lifetime'),
		rt.mul(rt.new_int(12), rt.get_constant('HOUR_IN_SECONDS')),
		var_url.clone(),
	]))
	rt.call_function('do_action_ref_array', [rt.new_string('wp_feed_options'),
		rt.create_array([rt.ArrayItem{ key: none, val: var_feed },
			rt.ArrayItem{ key: none, val: var_url }])])
	if !rt.is_true(var_url) {
		var_feed.init()
		var_feed.set_output_encoding(rt.call_function('get_bloginfo', [
			rt.new_string('charset'),
		]))
		if rt.is_true(var_feed.error()) {
			return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('simplepie-error'),
				var_feed.error()))
		}
		return mut var_feed
	} else if var_url.clone().is_array() && var_url.clone().array_count() == 1 {
		var_url = rt.call_function('array_shift', [var_url.clone()])
	} else if rt.is_true(rt.new_bool(var_url.clone().is_array())) {
		var_feeds = rt.new_array()
		var_simplepie_errors = rt.new_array()
		mut iter_8 := var_url.iterator()
		for {
			item_8 := iter_8.next() or { break }
			mut var_feed_url_shadow := item_8.val
			var_simplepie_instance = var_feed.dup()
			rt.call_method(var_simplepie_instance, 'set_feed_url', [
				var_feed_url_shadow.clone()])
			rt.call_method(var_simplepie_instance, 'init', []rt.PhpVal{})
			rt.call_method(var_simplepie_instance, 'set_output_encoding', [
				rt.call_function('get_bloginfo', [rt.new_string('charset')]),
			])
			if rt.is_true(rt.call_method(var_simplepie_instance, 'error', []rt.PhpVal{})) {
				var_simplepie_errors << rt.call_function('sprintf', [
					rt.call_function('__', [
						rt.new_string('Error fetching feed %1$s: %2$s'),
					]),
					rt.call_function('esc_url', [
						var_feed_url_shadow.clone(),
					]),
					rt.call_method(var_simplepie_instance, 'error', []rt.PhpVal{}),
				])
				var_simplepie_instance = rt.new_null()
				continue
			}
			var_feeds << var_simplepie_instance.clone()
			var_simplepie_instance = rt.new_null()
		}
		if !(!rt.is_true(var_simplepie_errors)) {
			return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('simplepie-error'),
				var_simplepie_errors.clone()))
		}
		var_feed.init()
		mut iife_temp_1 := Class_SimplePie_SimplePie{}
		mut iife_result_1 := iife_temp_1.merge_items(var_feeds.clone())
		rt.get_property(var_feed, 'data').array_set('items', iife_result_1)
		return mut var_feed
	}
	var_feed.set_feed_url(var_url.clone())
	var_feed.init()
	var_feed.set_output_encoding(rt.call_function('get_bloginfo', [
		rt.new_string('charset'),
	]))
	if rt.is_true(var_feed.error()) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('simplepie-error'),
			var_feed.error()))
	}
	return mut var_feed
}

struct Class_DateTimeZone {
	rt.PhpObjectBase
}

struct Class_SimplePie_SimplePie {
	rt.PhpObjectBase
}

struct Class_WP_SimplePie_Sanitize_KSES {
	rt.PhpObjectBase
}

struct Class_SimplePie_Cache {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

fn create_datetimezone(_args ...rt.PhpVal) &Class_DateTimeZone {
	mut obj := &Class_DateTimeZone{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_simplepie_simplepie(_args ...rt.PhpVal) &Class_SimplePie_SimplePie {
	mut obj := &Class_SimplePie_SimplePie{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_simplepie_sanitize_kses(_args ...rt.PhpVal) &Class_WP_SimplePie_Sanitize_KSES {
	mut obj := &Class_WP_SimplePie_Sanitize_KSES{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_simplepie_cache(_args ...rt.PhpVal) &Class_SimplePie_Cache {
	mut obj := &Class_SimplePie_Cache{
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

fn (mut this Class_DateTimeZone) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_DateTimeZone) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_DateTimeZone) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_SimplePie_SimplePie) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_SimplePie_SimplePie) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_SimplePie_SimplePie) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WP_SimplePie_Sanitize_KSES) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_SimplePie_Sanitize_KSES) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_SimplePie_Sanitize_KSES) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_SimplePie_Cache) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_SimplePie_Cache) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_SimplePie_Cache) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn main() {
	defer {
		rt.shutdown()
	}
}
