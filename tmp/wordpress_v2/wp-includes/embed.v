import rt

fn wp_embed_register_handler(id string, var_regex rt.PhpVal, var_callback rt.PhpVal, priority i64) {
	mut var_id := id
	mut var_priority := priority
	mut var_wp_embed := rt.new_null()
	rt.call_method(var_wp_embed, 'register_handler', [rt.new_string(id),
		var_regex.clone(), var_callback.clone(), rt.new_int(priority)])
}

fn wp_embed_unregister_handler(var_id rt.PhpVal, priority i64) {
	mut var_priority := priority
	mut var_wp_embed := rt.new_null()
	rt.call_method(var_wp_embed, 'unregister_handler', [var_id.clone(),
		rt.new_int(priority)])
}

fn wp_embed_defaults(url string) rt.PhpVal {
	mut var_url := url
	mut var_GLOBALS := rt.new_null()
	mut var_width := rt.new_null()
	mut var_height := rt.new_null()
	if !(!rt.is_true(var_GLOBALS.array_get(rt.new_string('content_width')))) {
		var_width = rt.new_int((var_GLOBALS.array_get(rt.new_string('content_width'))).to_i64())
	}
	if !rt.is_true(var_width) {
		var_width = rt.new_int(500)
	}
	var_height = rt.call_function('min', [
		rt.new_int((rt.call_function('ceil', [rt.new_float(var_width * 1.5)])).to_i64()),
		rt.new_int(1000),
	])
	return rt.call_function('apply_filters', [rt.new_string('embed_defaults'),
		rt.call_function('compact', [rt.new_string('width'), rt.new_string('height')]),
		rt.new_string(url)])
}

fn wp_oembed_get(var_url rt.PhpVal, args string) rt.PhpVal {
	mut var_args := args
	mut var_oembed := rt.new_null()
	var_oembed = _wp_oembed_get_object()
	return rt.call_method(var_oembed, 'get_html', [var_url.clone(),
		rt.new_string(args)])
}

fn _wp_oembed_get_object() rt.PhpVal {
	mut var_wp_oembed := rt.new_null()
	if rt.is_true(rt.new_bool(var_wp_oembed.clone().is_null())) {
		var_wp_oembed = create_wp_oembed()
	}
	return var_wp_oembed.clone()
}

fn wp_oembed_add_provider(var_format rt.PhpVal, var_provider rt.PhpVal, regex bool) {
	mut var_regex := regex
	mut var_oembed := rt.new_null()
	if rt.is_true(rt.call_function('did_action', [rt.new_string('plugins_loaded')])) {
		var_oembed = _wp_oembed_get_object()
		rt.get_property(var_oembed, 'providers').array_set(var_format, rt.create_array([
			rt.ArrayItem{ key: none, val: var_provider },
			rt.ArrayItem{ key: none, val: regex },
		]))
	} else {
		mut iife_temp_0 := Class_WP_oEmbed{}
		mut iife_result_0 := iife_temp_0._add_provider_early(var_format.clone(),
			var_provider.clone(), rt.new_bool(regex))
	}
}

fn wp_oembed_remove_provider(var_format rt.PhpVal) bool {
	mut var_oembed := rt.new_null()
	if rt.is_true(rt.call_function('did_action', [rt.new_string('plugins_loaded')])) {
		var_oembed = _wp_oembed_get_object()
		if rt.get_property(var_oembed, 'providers').array_isset(var_format) {
			rt.get_property(var_oembed, 'providers').array_unset(var_format)
			return true
		}
	} else {
		mut iife_temp_1 := Class_WP_oEmbed{}
		mut iife_result_1 := iife_temp_1._remove_provider_early(var_format.clone())
	}
	return false
}

fn wp_maybe_load_embeds() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('apply_filters', [
		rt.new_string('load_default_embeds'),
		rt.new_bool(true),
	])))))
	{
		return
	}
	wp_embed_register_handler('youtube_embed_url',
		rt.new_string('#https?://(www\\.)?youtube\\.com/(?:v|embed)/([^/]+)#i'),
		rt.new_string('wp_embed_handler_youtube'), 0)
	wp_embed_register_handler('audio', rt.new_string('#^https?://.+?\\.(' +
		(rt.call_function('implode', [rt.new_string('|'), rt.call_function('wp_get_audio_extensions', []rt.PhpVal{})])).str() +
		')$#i'), rt.call_function('apply_filters', [
		rt.new_string('wp_audio_embed_handler'),
		rt.new_string('wp_embed_handler_audio'),
	]), 9999)
	wp_embed_register_handler('video', rt.new_string('#^https?://.+?\\.(' +
		(rt.call_function('implode', [rt.new_string('|'), rt.call_function('wp_get_video_extensions', []rt.PhpVal{})])).str() +
		')$#i'), rt.call_function('apply_filters', [
		rt.new_string('wp_video_embed_handler'),
		rt.new_string('wp_embed_handler_video'),
	]), 9999)
}

fn wp_embed_handler_youtube(var_matches rt.PhpVal, var_attr rt.PhpVal, var_url rt.PhpVal, var_rawattr rt.PhpVal) rt.PhpVal {
	mut var_wp_embed := rt.new_null()
	mut var_embed := rt.new_null()
	var_embed = rt.call_method(var_wp_embed, 'autoembed', [
		rt.call_function('sprintf', [rt.new_string('https://youtube.com/watch?v=%s'),
			rt.call_function('urlencode', [var_matches.array_get(rt.new_int(2))])]),
	])
	return rt.call_function('apply_filters', [rt.new_string('wp_embed_handler_youtube'),
		var_embed.clone(), var_attr.clone(), var_url.clone(),
		rt.create_array_from_native_map(var_rawattr)])
}

fn wp_embed_handler_audio(var_matches rt.PhpVal, var_attr rt.PhpVal, var_url rt.PhpVal, var_rawattr rt.PhpVal) rt.PhpVal {
	mut var_audio := rt.new_null()
	var_audio = rt.call_function('sprintf', [rt.new_string('[audio src="%s" /]'),
		rt.call_function('esc_url', [var_url.clone()])])
	return rt.call_function('apply_filters', [rt.new_string('wp_embed_handler_audio'),
		var_audio.clone(), var_attr.clone(), var_url.clone(),
		rt.create_array_from_native_map(var_rawattr)])
}

fn wp_embed_handler_video(var_matches rt.PhpVal, var_attr rt.PhpVal, var_url rt.PhpVal, var_rawattr rt.PhpVal) rt.PhpVal {
	mut var_dimensions := ''
	mut var_video := rt.new_null()
	var_dimensions = ''
	if !(!rt.is_true(var_rawattr.array_get(rt.new_string('width'))))
		&& !(!rt.is_true(var_rawattr.array_get(rt.new_string('height')))) {
		var_dimensions = var_dimensions +(rt.call_function('sprintf', [rt.new_string('width="%d" '), rt.new_int((var_rawattr.array_get(rt.new_string('width'))).to_i64())])).str()
		var_dimensions = var_dimensions +(rt.call_function('sprintf', [rt.new_string('height="%d" '), rt.new_int((var_rawattr.array_get(rt.new_string('height'))).to_i64())])).str()
	}
	var_video = rt.call_function('sprintf', [rt.new_string('[video %s src="%s" /]'),
		rt.new_string(var_dimensions.str()).clone(), rt.call_function('esc_url', [
			var_url.clone(),
		])])
	return rt.call_function('apply_filters', [rt.new_string('wp_embed_handler_video'),
		var_video.clone(), var_attr.clone(), var_url.clone(),
		rt.create_array_from_native_map(var_rawattr)])
}

fn wp_oembed_register_route() {
	mut var_controller := rt.new_null()
	var_controller = create_wp_oembed_controller()
	var_controller.register_routes()
}

fn wp_oembed_add_discovery_links() {
	mut var_output := ''
	if rt.is_true(rt.call_function('doing_action', [rt.new_string('wp_head')])) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('has_action', [
			rt.new_string('wp_head'),
			rt.new_string('wp_oembed_add_discovery_links'),
			rt.new_int(10),
		])))))
		{
			return
		}
		rt.call_function('remove_action', [rt.new_string('wp_head'),
			rt.new_string('wp_oembed_add_discovery_links')])
	}
	var_output = ''
	if rt.is_true(rt.call_function('is_singular', []rt.PhpVal{}))
		&& rt.is_true(rt.call_function('is_post_embeddable', []rt.PhpVal{})) {
		var_output = var_output + '<link rel="alternate" title="' +
			(rt.call_function('_x', [rt.new_string('oEmbed (JSON)'), rt.new_string('oEmbed resource link name')])).str() +
			'" type="application/json+oembed" href="' +
			(rt.call_function('esc_url', [get_oembed_endpoint_url(rt.call_function('get_permalink', []rt.PhpVal{}), '')])).str() +
			'" />' + '\n'
		if rt.is_true(rt.call_function('class_exists', [
			rt.new_string('SimpleXMLElement'),
		]))
		{
			var_output = var_output + '<link rel="alternate" title="' +
				(rt.call_function('_x', [rt.new_string('oEmbed (XML)'), rt.new_string('oEmbed resource link name')])).str() +
				'" type="text/xml+oembed" href="' +
				(rt.call_function('esc_url', [get_oembed_endpoint_url(rt.call_function('get_permalink', []rt.PhpVal{}), 'xml')])).str() +
				'" />' + '\n'
		}
	}
	rt.echo_val(rt.call_function('apply_filters', [
		rt.new_string('oembed_discovery_links'),
		rt.new_string(var_output.str()).clone(),
	]))
}

fn wp_oembed_add_host_js() {
}

fn wp_maybe_enqueue_oembed_host_js(var_html rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.call_function('has_action', [rt.new_string('wp_head'), rt.new_string('wp_oembed_add_host_js')]))
		&& rt.is_true(rt.call_function('preg_match', [rt.new_string('/<blockquote\\s[^>]*?wp-embedded-content/'), var_html.clone()])) {
		rt.call_function('wp_enqueue_script', [rt.new_string('wp-embed')])
	}
	return var_html.clone()
}

fn get_post_embed_url(var_post_arg rt.PhpVal) bool {
	mut var_post := var_post_arg
	mut var_embed_url := rt.new_null()
	mut var_path_conflict := rt.new_null()
	var_post = rt.call_function('get_post', [var_post.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_post)))) {
		return false
	}
	var_embed_url = rt.new_string(
		(rt.call_function('trailingslashit', [rt.call_function('get_permalink', [var_post.clone()])])).str() +
		(rt.call_function('user_trailingslashit', [rt.new_string('embed')])).str())
	var_path_conflict = rt.call_function('get_page_by_path', [
		rt.call_function('str_replace', [rt.call_function('home_url', []rt.PhpVal{}),
			rt.new_string(''), var_embed_url.clone()]),
		rt.get_constant('OBJECT'),
		rt.call_function('get_post_types', [rt.create_array([
			rt.ArrayItem{ key: 'public', val: true },
		])]),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('get_option', [rt.new_string('permalink_structure')])))))
		|| rt.is_true(var_path_conflict) {
		var_embed_url = rt.call_function('add_query_arg', [
			rt.create_array([rt.ArrayItem{ key: 'embed', val: 'true' }]),
			rt.call_function('get_permalink', [var_post.clone()]),
		])
	}
	return (rt.call_function('sanitize_url', [
		rt.call_function('apply_filters', [rt.new_string('post_embed_url'),
			var_embed_url.clone(), var_post.clone()]),
	])).to_bool()
}

fn get_oembed_endpoint_url(permalink string, format string) rt.PhpVal {
	mut var_permalink := permalink
	mut var_format := format
	mut var_url := rt.new_null()
	var_url = rt.call_function('rest_url', [rt.new_string('oembed/1.0/embed')])
	if rt.is_true(rt.new_bool('' != permalink)) {
		var_url = rt.call_function('add_query_arg', [
			rt.create_array([
				rt.ArrayItem{ key: 'url', val: rt.call_function('urlencode', [
					rt.new_string(permalink),
				]) },
				rt.ArrayItem{
					key: 'format'
					val: if rt.is_true(rt.new_bool('json' != format)) {
						rt.new_string(format)
					} else {
						rt.new_bool(false)
					}
				},
			]),
			var_url.clone(),
		])
	}
	return rt.call_function('apply_filters', [rt.new_string('oembed_endpoint_url'),
		var_url.clone(), rt.new_string(permalink), rt.new_string(format)])
}

fn get_post_embed_html(var_width rt.PhpVal, var_height rt.PhpVal, var_post_arg rt.PhpVal) bool {
	mut var_post := var_post_arg
	mut var_embed_url := false
	mut var_secret := rt.new_null()
	mut var_output := rt.new_null()
	mut var_js_path := rt.new_null()
	var_post = rt.call_function('get_post', [var_post.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_post)))) {
		return false
	}
	var_embed_url = get_post_embed_url(var_post.clone())
	var_secret = rt.call_function('wp_generate_password', [rt.new_int(10),
		rt.new_bool(false)])
	var_embed_url = rt.concat(var_embed_url, rt.new_string('#?secret=${var_secret.to_string()}'))
	var_output = rt.call_function('sprintf', [
		rt.new_string('<blockquote class="wp-embedded-content" data-secret="%1$s"><a href="%2$s">%3$s</a></blockquote>'),
		rt.call_function('esc_attr', [var_secret.clone()]),
		rt.call_function('esc_url', [rt.call_function('get_permalink', [
			var_post.clone()])]),
		rt.call_function('get_the_title', [var_post.clone()]),
	])
	var_output = rt.concat(var_output, rt.call_function('sprintf', [
		rt.new_string('<iframe sandbox="allow-scripts" security="restricted" src="%1$s" width="%2$d" height="%3$d" title="%4$s" data-secret="%5$s" frameborder="0" marginwidth="0" marginheight="0" scrolling="no" class="wp-embedded-content"></iframe>'),
		rt.call_function('esc_url', [rt.new_bool(var_embed_url).clone()]),
		rt.call_function('absint', [var_width.clone()]),
		rt.call_function('absint', [var_height.clone()]),
		rt.call_function('esc_attr', [
			rt.call_function('sprintf', [
				rt.call_function('__', [rt.new_string('&#8220;%1$s&#8221; &#8212; %2$s')]),
				rt.call_function('get_the_title', [var_post.clone()]),
				rt.call_function('get_bloginfo', [rt.new_string('name')]),
			]),
		]),
		rt.call_function('esc_attr', [
			var_secret.clone(),
		]),
	]))
	var_js_path = rt.new_string('/js/wp-embed' +
		(rt.call_function('wp_scripts_get_suffix', []rt.PhpVal{})).str() + '.js')
	var_output = rt.concat(var_output, rt.call_function('wp_get_inline_script_tag', [
		rt.new_string((
			rt.call_function('file_get_contents', [rt.new_string((rt.get_constant('ABSPATH')).str() +
			(rt.get_constant('WPINC')).str() + var_js_path.str())]).to_string().trim_space() +
			'\n//# sourceURL=' +(rt.call_function('esc_url_raw', [rt.call_function('includes_url', [var_js_path.clone()])])).str()).str()),
	]))
	return (rt.call_function('apply_filters', [rt.new_string('embed_html'),
		var_output.clone(), var_post.clone(), var_width.clone(),
		var_height.clone()])).to_bool()
}

fn get_oembed_response_data(var_post_arg rt.PhpVal, var_width_arg rt.PhpVal) bool {
	mut var_post := var_post_arg
	mut var_width := var_width_arg
	mut var_min_max_width := rt.new_null()
	mut var_height := rt.new_null()
	mut var_data := rt.new_null()
	mut var_author := rt.new_null()
	var_post = rt.call_function('get_post', [var_post.clone()])
	var_width = rt.call_function('absint', [var_width.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_post)))) {
		return false
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_post_publicly_viewable', [
		var_post.clone(),
	])))))
	{
		return false
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_post_embeddable', [
		var_post.clone(),
	])))))
	{
		return false
	}
	var_min_max_width = rt.call_function('apply_filters', [
		rt.new_string('oembed_min_max_width'),
		rt.create_array([rt.ArrayItem{ key: 'min', val: 200 },
			rt.ArrayItem{ key: 'max', val: 600 }]),
	])
	var_width = rt.call_function('min', [
		rt.call_function('max', [var_min_max_width.array_get(rt.new_string('min')),
			var_width.clone()]),
		var_min_max_width.array_get(rt.new_string('max')),
	])
	var_height = rt.call_function('max', [
		rt.new_int((rt.call_function('ceil', [
			rt.mul(rt.div(var_width, rt.new_int(16)), rt.new_int(9)),
		])).to_i64()),
		rt.new_int(200),
	])
	var_data = rt.create_array([rt.ArrayItem{ key: 'version', val: '1.0' },
		rt.ArrayItem{ key: 'provider_name', val: rt.call_function('get_bloginfo', [
			rt.new_string('name'),
		]) }, rt.ArrayItem{ key: 'provider_url', val: rt.call_function('get_home_url',
			[]rt.PhpVal{}) }, rt.ArrayItem{ key: 'author_name', val: rt.call_function('get_bloginfo', [
			rt.new_string('name'),
		]) }, rt.ArrayItem{ key: 'author_url', val: rt.call_function('get_home_url', []rt.PhpVal{}) },
		rt.ArrayItem{ key: 'title', val: rt.call_function('get_the_title', [
			var_post.clone(),
		]) }, rt.ArrayItem{ key: 'type', val: 'link' }])
	var_author = rt.call_function('get_userdata', [
		rt.get_property(var_post, 'post_author'),
	])
	if rt.is_true(var_author) {
		var_data.array_set('author_name', rt.get_property(var_author, 'display_name'))
		var_data.array_set('author_url', rt.call_function('get_author_posts_url', [
			rt.get_property(var_author, 'ID'),
		]))
	}
	return (rt.call_function('apply_filters', [rt.new_string('oembed_response_data'),
		var_data.clone(), var_post.clone(), var_width.clone(),
		var_height.clone()])).to_bool()
}

fn get_oembed_response_data_for_url(var_url rt.PhpVal, var_args rt.PhpVal) bool {
	mut var_switched_blog := false
	mut var_url_parts := rt.new_null()
	mut var_qv := map[string]rt.PhpVal{}
	mut var_path := rt.new_null()
	mut var_sites := rt.new_null()
	mut var_site := rt.new_null()
	mut var_post_id := rt.new_null()
	mut var_width := rt.new_null()
	mut var_data := false
	var_switched_blog = false
	if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) {
		var_url_parts = rt.call_function('wp_parse_args', [
			rt.call_function('wp_parse_url', [var_url.clone()]),
			rt.create_array([rt.ArrayItem{ key: 'host', val: '' },
				rt.ArrayItem{ key: 'port', val: rt.new_null() },
				rt.ArrayItem{ key: 'path', val: '/' }]),
		])
		var_qv = {
			'domain':
				(var_url_parts.array_get(rt.new_string('host'))).str() + if rt.is_true(var_url_parts.array_get(rt.new_string('port'))) { ':' +
				(var_url_parts.array_get(rt.new_string('port'))).str() } else { '' }
			'path':                   rt.new_string('/')
			'update_site_meta_cache': rt.new_bool(false)
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_subdomain_install',
			[]rt.PhpVal{})))))
		{
			var_path = rt.call_function('explode', [rt.new_string('/'),
				rt.new_string(var_url_parts.array_get(rt.new_string('path')).to_string().trim_left(' \t\n\r'))])
			var_path = rt.call_function('reset', [var_path.clone()])
			if rt.is_true(var_path) {
				var_qv['path'] =
					(rt.get_property(rt.call_function('get_network', []rt.PhpVal{}), 'path')).str() +
					var_path.str() + '/'
			}
		}
		var_sites = rt.call_function('get_sites', [
			rt.create_array_from_native_map(var_qv),
		])
		var_site = rt.call_function('reset', [var_sites.clone()])
		if !(!rt.is_true(rt.get_property(var_site, 'deleted')))
			|| !(!rt.is_true(rt.get_property(var_site, 'spam')))
			|| !(!rt.is_true(rt.get_property(var_site, 'archived'))) {
			return false
		}
		if rt.is_true(var_site)
			&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('get_current_blog_id', []rt.PhpVal{}), rt.new_int((rt.get_property(var_site, 'blog_id')).to_i64()))))) {
			rt.call_function('switch_to_blog', [rt.get_property(var_site, 'blog_id')])
			var_switched_blog = true
		}
	}
	var_post_id = rt.call_function('url_to_postid', [var_url.clone()])
	var_post_id = rt.call_function('apply_filters', [
		rt.new_string('oembed_request_post_id'),
		var_post_id.clone(),
		var_url.clone(),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_post_id)))) {
		if var_switched_blog {
			rt.call_function('restore_current_blog', []rt.PhpVal{})
		}
		return false
	}
	var_width = if !(var_args.array_get(rt.new_string('width'))).is_null() {
		var_args.array_get(rt.new_string('width'))
	} else {
		rt.new_int(0)
	}
	var_data = get_oembed_response_data(var_post_id.clone(), var_width.clone())
	if var_switched_blog {
		rt.call_function('restore_current_blog', []rt.PhpVal{})
	}
	return (if var_data {
		rt.array_to_object(rt.new_bool(var_data))
	} else {
		rt.new_bool(false)
	}).to_bool()
}

fn get_oembed_response_data_rich(var_data rt.PhpVal, var_post rt.PhpVal, var_width rt.PhpVal, var_height rt.PhpVal) rt.PhpVal {
	mut var_thumbnail_url := rt.new_null()
	mut var_thumbnail_width := rt.new_null()
	mut var_thumbnail_height := rt.new_null()
	mut var_thumbnail_id := rt.new_null()
	var_data.array_set('width', rt.call_function('absint', [var_width.clone()]))
	var_data.array_set('height', rt.call_function('absint', [
		var_height.clone()]))
	var_data.array_set('type', 'rich')
	var_data.array_set('html', get_post_embed_html(var_width.clone(), var_height.clone(),
		var_post.clone()))
	var_thumbnail_id = rt.new_bool(false)
	if rt.is_true(rt.call_function('has_post_thumbnail', [
		rt.get_property(var_post, 'ID'),
	]))
	{
		var_thumbnail_id = rt.call_function('get_post_thumbnail_id', [
			rt.get_property(var_post, 'ID'),
		])
	}
	if rt.is_true(rt.identical(rt.new_string('attachment'), rt.call_function('get_post_type', [
		var_post.clone(),
	])))
	{
		if rt.is_true(rt.call_function('wp_attachment_is_image', [
			var_post.clone()]))
		{
			var_thumbnail_id = rt.get_property(var_post, 'ID')
		} else if rt.is_true(rt.call_function('wp_attachment_is', [
			rt.new_string('video'),
			var_post.clone(),
		]))
		{
			var_thumbnail_id = rt.call_function('get_post_thumbnail_id', [
				var_post.clone()])
			var_data.array_set('type', 'video')
		}
	}
	if rt.is_true(var_thumbnail_id) {
		mut list_tmp_1 := rt.call_function('wp_get_attachment_image_src', [
			var_thumbnail_id.clone(),
			rt.create_array([
				rt.ArrayItem{ key: none, val: var_width },
				rt.ArrayItem{ key: none, val: 0 },
			])])
		var_thumbnail_url = list_tmp_1.array_get(0)
		var_thumbnail_width = list_tmp_1.array_get(1)
		var_thumbnail_height = list_tmp_1.array_get(2)
		var_data.array_set('thumbnail_url', var_thumbnail_url.clone())
		var_data.array_set('thumbnail_width', var_thumbnail_width.clone())
		var_data.array_set('thumbnail_height', var_thumbnail_height.clone())
	}
	return var_data.clone()
}

fn wp_oembed_ensure_format(var_format rt.PhpVal) string {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
		var_format.clone(),
		rt.create_array([rt.ArrayItem{ key: none, val: 'json' },
			rt.ArrayItem{ key: none, val: 'xml' }]),
		rt.new_bool(true)])))))
	{
		return 'json'
	}
	return var_format.str()
}

fn _oembed_rest_pre_serve_request(var_served rt.PhpVal, var_result_arg rt.PhpVal, var_request rt.PhpVal, var_server rt.PhpVal) bool {
	mut var_result := var_result_arg
	mut var_params := rt.new_null()
	mut var_data := rt.new_null()
	var_params = rt.call_method(var_request, 'get_params', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('/oembed/1.0/embed'), rt.call_method(var_request, 'get_route', []rt.PhpVal{})))))
		|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('GET'), rt.call_method(var_request, 'get_method', []rt.PhpVal{}))))) {
		return var_served.to_bool()
	}
	if !(var_params.array_isset(rt.new_string('format')))
		|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('xml'), var_params.array_get(rt.new_string('format')))))) {
		return var_served.to_bool()
	}
	var_data = rt.call_method(var_server, 'response_to_data', [
		var_result.clone(), rt.new_bool(false)])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [
		rt.new_string('SimpleXMLElement'),
	])))))
	{
		rt.call_function('status_header', [rt.new_int(501)])
		fn () {
			print((rt.call_function('get_status_header_desc', [
				rt.new_int(501)])).str())
			exit(0)
		}()
	}
	var_result = rt.new_bool(_oembed_create_xml(var_data.clone(), rt.new_null()))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_result)))) {
		rt.call_function('status_header', [rt.new_int(501)])
		fn () {
			print((rt.call_function('get_status_header_desc', [
				rt.new_int(501)])).str())
			exit(0)
		}()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('headers_sent', []rt.PhpVal{}))))) {
		rt.call_method(var_server, 'send_header', [rt.new_string('Content-Type'),
			rt.new_string('text/xml; charset=' +
				(rt.call_function('get_option', [rt.new_string('blog_charset')])).str())])
	}
	rt.echo_val(var_result)
	return true
}

fn _oembed_create_xml(var_data rt.PhpVal, var_node_arg rt.PhpVal) bool {
	mut var_node := var_node_arg
	mut var_value := rt.new_null()
	mut var_key := ''
	mut var_item := rt.new_null()
	if !(var_data.clone().is_array()) || !rt.is_true(var_data) {
		return false
	}
	if rt.is_true(rt.identical(rt.new_null(), var_node)) {
		var_node = create_simplexmlelement(rt.new_string('<oembed></oembed>'))
	}
	mut iter_1 := var_data.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_value_shadow := item_1.val
		mut var_key_shadow := item_1.key
		if rt.is_true(rt.new_bool(rt.new_string(var_key_shadow.str()).is_long()
			|| rt.new_string(var_key_shadow.str()).is_double()))
		{
			var_key_shadow = rt.new_string('oembed')
		}
		if rt.is_true(rt.new_bool(var_value_shadow.clone().is_array())) {
			var_item = var_node.addchild(rt.new_string(var_key_shadow.str()))
			rt.new_bool(_oembed_create_xml(var_value_shadow.clone(), var_item.clone()))
		} else {
			var_node.addchild(rt.new_string(var_key_shadow.str()), rt.call_function('esc_html', [
				var_value_shadow.clone(),
			]))
		}
	}
	return (var_node.asxml()).to_bool()
}

fn wp_filter_oembed_iframe_title_attribute(var_result_arg rt.PhpVal, var_data rt.PhpVal, var_url rt.PhpVal) rt.PhpVal {
	mut var_result := var_result_arg
	mut var_matches := []rt.PhpVal{}
	mut var_title := rt.new_null()
	mut var_pattern := ''
	mut var_attrs := rt.new_null()
	mut var_item := rt.new_null()
	mut var_attr := rt.new_null()
	mut var_lower_attr := ''
	mut var_attr_string := rt.new_null()
	if rt.is_true(rt.identical(rt.new_bool(false), var_result))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [rt.get_property(var_data, 'type'), rt.create_array([rt.ArrayItem{
		key: none
		val: 'rich'
	}, rt.ArrayItem{ key: none, val: 'video' }]), rt.new_bool(true)]))))) {
		return var_result.clone()
	}
	var_title = if !(!rt.is_true(rt.get_property(var_data, 'title'))) {
		rt.get_property(var_data, 'title')
	} else {
		rt.new_string('')
	}
	var_pattern = '`<iframe([^>]*)>`i'
	if rt.is_true(rt.call_function('preg_match', [rt.new_string(var_pattern.str()).clone(),
		var_result.clone(), rt.create_array_from_list(var_matches)]))
	{
		var_attrs = rt.call_function('wp_kses_hair', [var_matches[1],
			rt.call_function('wp_allowed_protocols', []rt.PhpVal{})])
		mut iter_2 := var_attrs.iterator()
		for {
			item_2 := iter_2.next() or { break }
			mut var_item_shadow := item_2.val
			mut var_attr_shadow := item_2.key
			var_lower_attr = var_attr_shadow.clone().to_string().to_lower()
			if rt.is_true(rt.identical(rt.new_string(var_lower_attr.str()), var_attr_shadow)) {
				continue
			}
			if !(var_attrs.array_isset(rt.new_string(var_lower_attr.str()))) {
				var_attrs.array_set(var_lower_attr, var_item_shadow.clone())
				var_attrs.array_unset(var_attr_shadow)
			}
		}
	}
	if !(!rt.is_true(var_attrs.array_get(rt.new_string('title')).array_get(rt.new_string('value')))) {
		var_title = var_attrs.array_get(rt.new_string('title')).array_get(rt.new_string('value'))
	}
	var_title = rt.call_function('apply_filters', [
		rt.new_string('oembed_iframe_title_attribute'),
		var_title.clone(),
		var_result.clone(),
		var_data.clone(),
		var_url.clone(),
	])
	if rt.is_true(rt.identical(rt.new_string(''), var_title)) {
		return var_result.clone()
	}
	if var_attrs.array_isset(rt.new_string('title')) {
		var_attrs.array_unset(rt.new_string('title'))
		var_attr_string = rt.call_function('implode', [rt.new_string(' '),
			rt.call_function('wp_list_pluck', [var_attrs.clone(),
				rt.new_string('whole')])])
		var_result = rt.call_function('str_replace', [var_matches[0],
			rt.new_string('<iframe ' + var_attr_string.clone().to_string().trim_space() + '>'),
			var_result.clone()])
	}
	return rt.call_function('str_ireplace', [rt.new_string('<iframe '),
		rt.call_function('sprintf', [rt.new_string('<iframe title="%s" '),
			rt.call_function('esc_attr', [var_title.clone()])]),
		var_result.clone()])
}

fn wp_filter_oembed_result(var_result rt.PhpVal, var_data rt.PhpVal, var_url_arg rt.PhpVal) bool {
	mut var_url := var_url_arg
	mut var_content := []rt.PhpVal{}
	mut var_results := []rt.PhpVal{}
	mut var_wp_oembed := rt.new_null()
	mut var_allowed_html := map[string]rt.PhpVal{}
	mut var_html := rt.new_null()
	mut var_secret := rt.new_null()
	mut var_q := rt.new_null()
	if rt.is_true(rt.identical(rt.new_bool(false), var_result))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [rt.get_property(var_data, 'type'), rt.create_array([rt.ArrayItem{
		key: none
		val: 'rich'
	}, rt.ArrayItem{ key: none, val: 'video' }]), rt.new_bool(true)]))))) {
		return var_result.to_bool()
	}
	var_wp_oembed = _wp_oembed_get_object()
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), rt.call_method(var_wp_oembed,
		'get_provider', [var_url.clone(), rt.create_array([
		rt.ArrayItem{ key: 'discover', val: false },
	])])))))
	{
		return var_result.to_bool()
	}
	var_allowed_html = {
		'a':          {
			'href': rt.new_bool(true)
		}
		'blockquote': map[string]rt.PhpVal{}
		'iframe':     {
			'src':          rt.new_bool(true)
			'width':        rt.new_bool(true)
			'height':       rt.new_bool(true)
			'frameborder':  rt.new_bool(true)
			'marginwidth':  rt.new_bool(true)
			'marginheight': rt.new_bool(true)
			'scrolling':    rt.new_bool(true)
			'title':        rt.new_bool(true)
		}
	}
	var_html = rt.call_function('wp_kses', [var_result.clone(),
		rt.create_array_from_native_map(var_allowed_html)])
	rt.call_function('preg_match', [
		rt.new_string('|(<blockquote>.*?</blockquote>)?.*(<iframe.*?></iframe>)|ms'),
		var_html.clone(),
		rt.create_array_from_list(var_content),
	])
	if !rt.is_true(var_content[2]) {
		return false
	}
	var_html = rt.new_string((var_content[1]).str() + (var_content[2]).str())
	rt.call_function('preg_match', [rt.new_string('/ src=([\'"])(.*?)\\1/'),
		var_html.clone(), rt.create_array_from_list(var_results)])
	if !(!rt.is_true(var_results)) {
		var_secret = rt.call_function('wp_generate_password', [
			rt.new_int(10), rt.new_bool(false)])
		var_url = rt.call_function('esc_url', [
			rt.concat(rt.concat(var_results[2], rt.new_string('#?secret=')), var_secret),
		])
		var_q = var_results[1]
		var_html = rt.call_function('str_replace', [var_results[0],
			rt.new_string(' src=' + var_q.str() + var_url.str() + var_q.str() + ' data-secret=' +
				var_q.str() + var_secret.str() + var_q.str()),
			var_html.clone()])
		var_html = rt.call_function('str_replace', [rt.new_string('<blockquote'),
			rt.new_string("<blockquote data-secret=\"${var_secret.to_string()}\""),
			var_html.clone()])
	}
	var_allowed_html.array_get_mut('blockquote').array_set('data-secret', true)
	var_allowed_html.array_get_mut('iframe').array_set('data-secret', true)
	var_html = rt.call_function('wp_kses', [var_html.clone(),
		rt.create_array_from_native_map(var_allowed_html)])
	if !(!rt.is_true(var_content[1])) {
		var_html = rt.call_function('str_replace', [rt.new_string('<iframe'),
			rt.new_string('<iframe style="position: absolute; visibility: hidden;"'),
			var_html.clone()])
		var_html = rt.call_function('str_replace', [rt.new_string('<blockquote'),
			rt.new_string('<blockquote class="wp-embedded-content"'),
			var_html.clone()])
	}
	var_html = rt.call_function('str_ireplace', [rt.new_string('<iframe'),
		rt.new_string('<iframe class="wp-embedded-content" sandbox="allow-scripts" security="restricted"'),
		var_html.clone()])
	return var_html.to_bool()
}

fn wp_embed_excerpt_more(var_more_string rt.PhpVal) string {
	mut var_link := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_embed', []rt.PhpVal{}))))) {
		return var_more_string.str()
	}
	var_link = rt.call_function('sprintf', [
		rt.new_string('<a href="%1$s" class="wp-embed-more" target="_top">%2$s</a>'),
		rt.call_function('esc_url', [rt.call_function('get_permalink', []rt.PhpVal{})]),
		rt.call_function('sprintf', [rt.call_function('__', [
			rt.new_string('Continue reading %s'),
		]),
			rt.new_string('<span class="screen-reader-text">' +
				(rt.call_function('get_the_title', []rt.PhpVal{})).str() + '</span>')]),
	])
	return ' &hellip; ' + var_link.str()
}

fn the_excerpt_embed() {
	mut var_output := rt.new_null()
	var_output = rt.call_function('get_the_excerpt', []rt.PhpVal{})
	rt.echo_val(rt.call_function('apply_filters', [rt.new_string('the_excerpt_embed'),
		var_output.clone()]))
}

fn wp_embed_excerpt_attachment(var_content rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.call_function('is_attachment', []rt.PhpVal{})) {
		return rt.call_function('prepend_attachment', [rt.new_string('')])
	}
	return var_content.clone()
}

fn enqueue_embed_scripts() {
	rt.call_function('do_action', [rt.new_string('enqueue_embed_scripts')])
}

fn wp_enqueue_embed_styles() {
	mut var_suffix := rt.new_null()
	mut var_handle := ''
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('has_action', [
		rt.new_string('embed_head'),
		rt.new_string('print_embed_styles'),
	])))))
	{
		return
	}
	rt.call_function('remove_action', [rt.new_string('embed_head'),
		rt.new_string('print_embed_styles')])
	var_suffix = rt.call_function('wp_scripts_get_suffix', []rt.PhpVal{})
	var_handle = 'wp-embed-template'
	rt.call_function('wp_register_style', [rt.new_string(var_handle.str()).clone(),
		rt.new_bool(false)])
	rt.call_function('wp_add_inline_style', [rt.new_string(var_handle.str()).clone(),
		rt.call_function('file_get_contents', [
			rt.new_string(
				(rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/css/wp-embed-template${var_suffix.to_string()}.css'),
		])])
	rt.call_function('wp_enqueue_style', [rt.new_string(var_handle.str()).clone()])
}

fn print_embed_scripts() {
	mut var_js_path := rt.new_null()
	var_js_path = rt.new_string('/js/wp-embed-template' +
		(rt.call_function('wp_scripts_get_suffix', []rt.PhpVal{})).str() + '.js')
	rt.call_function('wp_print_inline_script_tag', [
		rt.new_string((
			rt.call_function('file_get_contents', [rt.new_string((rt.get_constant('ABSPATH')).str() +
			(rt.get_constant('WPINC')).str() + var_js_path.str())]).to_string().trim_space() +
			'\n//# sourceURL=' +(rt.call_function('esc_url_raw', [rt.call_function('includes_url', [var_js_path.clone()])])).str()).str()),
	])
}

fn _oembed_filter_feed_content(var_content rt.PhpVal) rt.PhpVal {
	mut var_p := rt.new_null()
	var_p = create_wp_html_tag_processor(var_content.clone())
	for rt.is_true(var_p.next_tag(rt.create_array([rt.ArrayItem, {
		key: 'tag_name'
		val: 'iframe'
	}]))) {
		if rt.is_true(var_p.has_class(rt.new_string('wp-embedded-content'))) {
			var_p.remove_attribute(rt.new_string('style'))
		}
	}
	return var_p.get_updated_html()
}

fn print_embed_comments_button() {
	if rt.is_true(rt.call_function('is_404', []rt.PhpVal{}))
		|| !(rt.is_true(rt.call_function('get_comments_number', []rt.PhpVal{}))
		|| rt.is_true(rt.call_function('comments_open', []rt.PhpVal{}))) {
		return
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('comments_link', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [
		rt.call_function('_n', [
			rt.new_string('%s <span class="screen-reader-text">Comment</span>'),
			rt.new_string('%s <span class="screen-reader-text">Comments</span>'),
			rt.call_function('get_comments_number', []rt.PhpVal{}),
		]),
		rt.call_function('number_format_i18n', [
			rt.call_function('get_comments_number', []rt.PhpVal{}),
		]),
	])
	// unsupported statement: Stmt_InlineHTML
}

fn print_embed_sharing_button() {
	if rt.is_true(rt.call_function('is_404', []rt.PhpVal{})) {
		return
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('Open sharing dialog')])
	// unsupported statement: Stmt_InlineHTML
}

fn print_embed_sharing_dialog() {
	mut var_unique_suffix := rt.new_null()
	mut var_share_tab_wordpress_id := rt.new_null()
	mut var_share_tab_html_id := rt.new_null()
	mut var_description_wordpress_id := rt.new_null()
	mut var_description_html_id := rt.new_null()
	if rt.is_true(rt.call_function('is_404', []rt.PhpVal{})) {
		return
	}
	var_unique_suffix = rt.new_string((rt.call_function('get_the_ID', []rt.PhpVal{})).str() + '-' +
		(rt.call_function('wp_rand', []rt.PhpVal{})).str())
	var_share_tab_wordpress_id = rt.new_string('wp-embed-share-tab-wordpress-' +
		var_unique_suffix.str())
	var_share_tab_html_id = rt.new_string('wp-embed-share-tab-html-' + var_unique_suffix.str())
	var_description_wordpress_id = rt.new_string('wp-embed-share-description-wordpress-' +
		var_unique_suffix.str())
	var_description_html_id = rt.new_string('wp-embed-share-description-html-' +
		var_unique_suffix.str())
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('Sharing options')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_share_tab_wordpress_id)
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('WordPress Embed')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_share_tab_html_id)
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('HTML Embed')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_share_tab_wordpress_id)
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('the_permalink', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('URL')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_description_wordpress_id)
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_description_wordpress_id)
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [
		rt.new_string('Copy and paste this URL into your WordPress site to embed'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_share_tab_html_id)
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('HTML')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_description_html_id)
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_textarea', [
		rt.new_bool(get_post_embed_html(rt.new_int(600), rt.new_int(400), rt.new_null())),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_description_html_id)
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [
		rt.new_string('Copy and paste this code into your site to embed'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('Close sharing dialog')])
	// unsupported statement: Stmt_InlineHTML
}

fn the_embed_site_title() {
	mut var_site_title := rt.new_null()
	var_site_title = rt.call_function('sprintf', [
		rt.new_string('<a href="%s" target="_top"><img src="%s" srcset="%s 2x" width="32" height="32" alt="" class="wp-embed-site-icon" /><span>%s</span></a>'),
		rt.call_function('esc_url', [rt.call_function('home_url', []rt.PhpVal{})]),
		rt.call_function('esc_url', [
			rt.call_function('get_site_icon_url', [rt.new_int(32),
				rt.call_function('includes_url', [
					rt.new_string('images/w-logo-blue.png'),
				])]),
		]),
		rt.call_function('esc_url', [
			rt.call_function('get_site_icon_url', [rt.new_int(64),
				rt.call_function('includes_url', [
					rt.new_string('images/w-logo-blue.png'),
				])]),
		]),
		rt.call_function('esc_html', [
			rt.call_function('get_bloginfo', [rt.new_string('name')]),
		]),
	])
	var_site_title = rt.new_string('<div class="wp-embed-site-title">' + var_site_title.str() +
		'</div>')
	rt.echo_val(rt.call_function('apply_filters', [
		rt.new_string('embed_site_title_html'),
		var_site_title.clone(),
	]))
}

fn wp_filter_pre_oembed_result(var_result rt.PhpVal, var_url rt.PhpVal, var_args rt.PhpVal) rt.PhpVal {
	mut var_data := false
	var_data = get_oembed_response_data_for_url(var_url.clone(),
		rt.create_array_from_native_map(var_args))
	if var_data {
		return rt.call_method(_wp_oembed_get_object(), 'data2html', [
			rt.new_bool(var_data).clone(), var_url.clone()])
	}
	return var_result.clone()
}

struct Class_WP_oEmbed {
	rt.PhpObjectBase
}

struct Class_WP_oEmbed_Controller {
	rt.PhpObjectBase
}

struct Class_SimpleXMLElement {
	rt.PhpObjectBase
}

struct Class_WP_HTML_Tag_Processor {
	rt.PhpObjectBase
}

fn create_wp_oembed(_args ...rt.PhpVal) &Class_WP_oEmbed {
	mut obj := &Class_WP_oEmbed{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_oembed_controller(_args ...rt.PhpVal) &Class_WP_oEmbed_Controller {
	mut obj := &Class_WP_oEmbed_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_simplexmlelement(_args ...rt.PhpVal) &Class_SimpleXMLElement {
	mut obj := &Class_SimpleXMLElement{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_html_tag_processor(_args ...rt.PhpVal) &Class_WP_HTML_Tag_Processor {
	mut obj := &Class_WP_HTML_Tag_Processor{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_oEmbed) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_oEmbed) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_oEmbed) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WP_oEmbed_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_oEmbed_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_oEmbed_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_SimpleXMLElement) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_SimpleXMLElement) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_SimpleXMLElement) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WP_HTML_Tag_Processor) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_HTML_Tag_Processor) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_HTML_Tag_Processor) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
