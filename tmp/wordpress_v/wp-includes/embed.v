import rt

fn wp_embed_register_handler(id string, var_regex rt.PhpVal, var_callback rt.PhpVal, priority i64) {
	mut var_wp_embed := rt.new_null()
	// unsupported statement: Stmt_Global
	rt.call_method(var_wp_embed, 'register_handler', [rt.new_string(id), var_regex.dup(), var_callback.dup(), rt.new_int(priority)])
}

fn wp_embed_unregister_handler(var_id rt.PhpVal, priority i64) {
	mut var_wp_embed := rt.new_null()
	// unsupported statement: Stmt_Global
	rt.call_method(var_wp_embed, 'unregister_handler', [var_id.dup(), rt.new_int(priority)])
}

fn wp_embed_defaults(url string) rt.PhpVal {
	mut var_GLOBALS := rt.new_null()
	if !(!rt.is_true(var_GLOBALS.array_get('content_width'))) {
		mut var_width := // unsupported expression: Expr_Cast_Int
	}
	if !rt.is_true(var_width) {
		var_width = rt.new_int(rt.new_int(500))
	}
	mut var_height := rt.call_function('min', [// unsupported expression: Expr_Cast_Int, rt.new_int(1000)])
	return rt.call_function('apply_filters', [rt.new_string('embed_defaults'), rt.call_function('compact', [rt.new_string('width'), rt.new_string('height')]), rt.new_string(url)])
}

fn wp_oembed_get(var_url rt.PhpVal, args string) rt.PhpVal {
	mut var_oembed := _wp_oembed_get_object()
	return rt.call_method(var_oembed, 'get_html', [var_url.dup(), rt.new_string(args)])
}

fn _wp_oembed_get_object() rt.PhpVal {
	// unsupported statement: Stmt_Static
	if rt.is_true(rt.new_bool(var_wp_oembed.dup().is_null())) {
		mut var_wp_oembed := create_wp_oembed()
	}
	return var_wp_oembed.dup()
}

fn wp_oembed_add_provider(var_format rt.PhpVal, var_provider rt.PhpVal, regex bool) {
	if rt.is_true(rt.call_function('did_action', [rt.new_string('plugins_loaded')])) {
		mut var_oembed := _wp_oembed_get_object()
		rt.get_property(var_oembed, 'providers').array_set(var_format, rt.create_array([rt.ArrayItem{ key: none, val: var_provider }, rt.ArrayItem{ key: none, val: regex }]))
	} else {
		fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_WP_oEmbed{}; return temp._add_provider_early(arg_0, arg_1, arg_2) }(var_format.dup(), var_provider.dup(), rt.new_bool(regex))
	}
}

fn wp_oembed_remove_provider(var_format rt.PhpVal) bool {
	if rt.is_true(rt.call_function('did_action', [rt.new_string('plugins_loaded')])) {
		mut var_oembed := _wp_oembed_get_object()
		if rt.get_property(var_oembed, 'providers').array_isset(var_format) {
			rt.get_property(var_oembed, 'providers').array_unset(var_format)
			return true
		}
	} else {
		fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WP_oEmbed{}; return temp._remove_provider_early(arg_0) }(var_format.dup())
	}
	return false
}

fn wp_maybe_load_embeds() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('apply_filters', [rt.new_string('load_default_embeds'), rt.new_bool(true)]))))) {
		return rt.new_null()
	}
	wp_embed_register_handler('youtube_embed_url', rt.new_string('#https?://(www\\.)?youtube\\.com/(?:v|embed)/([^/]+)#i'), rt.new_string('wp_embed_handler_youtube'), 0)
	wp_embed_register_handler('audio', '#^https?://.+?\\.(' + (rt.call_function('implode', [rt.new_string('|'), rt.call_function('wp_get_audio_extensions', []rt.PhpVal{})])).str() + ')$#i', rt.call_function('apply_filters', [rt.new_string('wp_audio_embed_handler'), rt.new_string('wp_embed_handler_audio')]), 9999)
	wp_embed_register_handler('video', '#^https?://.+?\\.(' + (rt.call_function('implode', [rt.new_string('|'), rt.call_function('wp_get_video_extensions', []rt.PhpVal{})])).str() + ')$#i', rt.call_function('apply_filters', [rt.new_string('wp_video_embed_handler'), rt.new_string('wp_embed_handler_video')]), 9999)
}

fn wp_embed_handler_youtube(var_matches rt.PhpVal, var_attr rt.PhpVal, var_url rt.PhpVal, var_rawattr rt.PhpVal) rt.PhpVal {
	mut var_wp_embed := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var_embed := rt.call_method(var_wp_embed, 'autoembed', [rt.call_function('sprintf', [rt.new_string('https://youtube.com/watch?v=%s'), rt.call_function('urlencode', [var_matches.array_get(2)])])])
	return rt.call_function('apply_filters', [rt.new_string('wp_embed_handler_youtube'), var_embed.dup(), var_attr.dup(), var_url.dup(), var_rawattr.dup()])
}

fn wp_embed_handler_audio(var_matches rt.PhpVal, var_attr rt.PhpVal, var_url rt.PhpVal, var_rawattr rt.PhpVal) rt.PhpVal {
	mut var_audio := rt.call_function('sprintf', [rt.new_string('[audio src="%s" /]'), rt.call_function('esc_url', [var_url.dup()])])
	return rt.call_function('apply_filters', [rt.new_string('wp_embed_handler_audio'), var_audio.dup(), var_attr.dup(), var_url.dup(), var_rawattr.dup()])
}

fn wp_embed_handler_video(var_matches rt.PhpVal, var_attr rt.PhpVal, var_url rt.PhpVal, var_rawattr rt.PhpVal) rt.PhpVal {
	mut var_dimensions := ''
	if !(!rt.is_true(var_rawattr.array_get('width'))) && !(!rt.is_true(var_rawattr.array_get('height'))) {
		// unsupported expression: Expr_AssignOp_Concat
		// unsupported expression: Expr_AssignOp_Concat
	}
	mut var_video := rt.call_function('sprintf', [rt.new_string('[video %s src="%s" /]'), rt.new_string(var_dimensions).dup(), rt.call_function('esc_url', [var_url.dup()])])
	return rt.call_function('apply_filters', [rt.new_string('wp_embed_handler_video'), var_video.dup(), var_attr.dup(), var_url.dup(), var_rawattr.dup()])
}

fn wp_oembed_register_route() {
	mut var_controller := create_wp_oembed_controller()
	var_controller.register_routes()
}

fn wp_oembed_add_discovery_links() {
	if rt.is_true(rt.call_function('doing_action', [rt.new_string('wp_head')])) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('has_action', [rt.new_string('wp_head'), rt.new_string('wp_oembed_add_discovery_links'), rt.new_int(10)]))))) {
			return rt.new_null()
		}
		rt.call_function('remove_action', [rt.new_string('wp_head'), rt.new_string('wp_oembed_add_discovery_links')])
	}
	mut var_output := ''
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('is_singular', []rt.PhpVal{})) && rt.is_true(rt.call_function('is_post_embeddable', []rt.PhpVal{})))) {
		// unsupported expression: Expr_AssignOp_Concat
		if rt.is_true(rt.call_function('class_exists', [rt.new_string('SimpleXMLElement')])) {
			// unsupported expression: Expr_AssignOp_Concat
		}
	}
	rt.echo_val(rt.call_function('apply_filters', [rt.new_string('oembed_discovery_links'), rt.new_string(var_output).dup()]))
}

fn wp_oembed_add_host_js() {
}

fn wp_maybe_enqueue_oembed_host_js(var_html rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('has_action', [rt.new_string('wp_head'), rt.new_string('wp_oembed_add_host_js')])) && rt.is_true(rt.call_function('preg_match', [rt.new_string('/<blockquote\\s[^>]*?wp-embedded-content/'), var_html.dup()])))) {
		rt.call_function('wp_enqueue_script', [rt.new_string('wp-embed')])
	}
	return var_html.dup()
}

fn get_post_embed_url(var_post rt.PhpVal) bool {
	var_post = rt.call_function('get_post', [var_post.dup()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_post)))) {
		return false
	}
	mut var_embed_url := rt.new_string(rt.concat(rt.call_function('trailingslashit', [rt.call_function('get_permalink', [var_post.dup()])]), rt.call_function('user_trailingslashit', [rt.new_string('embed')])))
	mut var_path_conflict := rt.call_function('get_page_by_path', [rt.call_function('str_replace', [rt.call_function('home_url', []rt.PhpVal{}), rt.new_string(''), var_embed_url.dup()]), rt.get_constant('OBJECT'), rt.call_function('get_post_types', [rt.create_array([rt.ArrayItem{ key: 'public', val: true }])])])
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('get_option', [rt.new_string('permalink_structure')]))))) || rt.is_true(var_path_conflict))) {
		var_embed_url = rt.call_function('add_query_arg', [rt.create_array([rt.ArrayItem{ key: 'embed', val: 'true' }]), rt.call_function('get_permalink', [var_post.dup()])])
	}
	return (rt.call_function('sanitize_url', [rt.call_function('apply_filters', [rt.new_string('post_embed_url'), var_embed_url.dup(), var_post.dup()])])).to_bool()
}

fn get_oembed_endpoint_url(permalink string, format string) rt.PhpVal {
	mut var_url := rt.call_function('rest_url', [rt.new_string('oembed/1.0/embed')])
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		var_url = rt.call_function('add_query_arg', [rt.create_array([rt.ArrayItem{ key: 'url', val: rt.call_function('urlencode', [rt.new_string(permalink)]) }, rt.ArrayItem{ key: 'format', val: if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) { rt.new_string(format) } else { rt.new_bool(false) } }]), var_url.dup()])
	}
	return rt.call_function('apply_filters', [rt.new_string('oembed_endpoint_url'), var_url.dup(), rt.new_string(permalink), rt.new_string(format)])
}

fn get_post_embed_html(var_width rt.PhpVal, var_height rt.PhpVal, var_post rt.PhpVal) bool {
	var_post = rt.call_function('get_post', [var_post.dup()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_post)))) {
		return false
	}
	mut var_embed_url := get_post_embed_url(var_post.dup())
	mut var_secret := rt.call_function('wp_generate_password', [rt.new_int(10), rt.new_bool(false)])
	// unsupported expression: Expr_AssignOp_Concat
	mut var_output := rt.call_function('sprintf', [rt.new_string('<blockquote class="wp-embedded-content" data-secret="%1$s"><a href="%2$s">%3$s</a></blockquote>'), rt.call_function('esc_attr', [var_secret.dup()]), rt.call_function('esc_url', [rt.call_function('get_permalink', [var_post.dup()])]), rt.call_function('get_the_title', [var_post.dup()])])
	// unsupported expression: Expr_AssignOp_Concat
	mut var_js_path := rt.new_string('/js/wp-embed' + (rt.call_function('wp_scripts_get_suffix', []rt.PhpVal{})).str() + '.js')
	// unsupported expression: Expr_AssignOp_Concat
	return (rt.call_function('apply_filters', [rt.new_string('embed_html'), var_output.dup(), var_post.dup(), var_width.dup(), var_height.dup()])).to_bool()
}

fn get_oembed_response_data(var_post rt.PhpVal, var_width rt.PhpVal) bool {
	var_post = rt.call_function('get_post', [var_post.dup()])
	var_width = rt.call_function('absint', [var_width.dup()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_post)))) {
		return false
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_post_publicly_viewable', [var_post.dup()]))))) {
		return false
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_post_embeddable', [var_post.dup()]))))) {
		return false
	}
	mut var_min_max_width := rt.call_function('apply_filters', [rt.new_string('oembed_min_max_width'), rt.create_array([rt.ArrayItem{ key: 'min', val: 200 }, rt.ArrayItem{ key: 'max', val: 600 }])])
	var_width = rt.call_function('min', [rt.call_function('max', [var_min_max_width.array_get('min'), var_width.dup()]), var_min_max_width.array_get('max')])
	mut var_height := rt.call_function('max', [// unsupported expression: Expr_Cast_Int, rt.new_int(200)])
	mut var_data := rt.create_array([rt.ArrayItem{ key: 'version', val: '1.0' }, rt.ArrayItem{ key: 'provider_name', val: rt.call_function('get_bloginfo', [rt.new_string('name')]) }, rt.ArrayItem{ key: 'provider_url', val: rt.call_function('get_home_url', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'author_name', val: rt.call_function('get_bloginfo', [rt.new_string('name')]) }, rt.ArrayItem{ key: 'author_url', val: rt.call_function('get_home_url', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'title', val: rt.call_function('get_the_title', [var_post.dup()]) }, rt.ArrayItem{ key: 'type', val: 'link' }])
	mut var_author := rt.call_function('get_userdata', [rt.get_property(var_post, 'post_author')])
	if rt.is_true(var_author) {
		var_data.array_set('author_name', rt.get_property(var_author, 'display_name'))
		var_data.array_set('author_url', rt.call_function('get_author_posts_url', [rt.get_property(var_author, 'ID')]))
	}
	return (rt.call_function('apply_filters', [rt.new_string('oembed_response_data'), var_data.dup(), var_post.dup(), var_width.dup(), var_height.dup()])).to_bool()
}

fn get_oembed_response_data_for_url(var_url rt.PhpVal, var_args rt.PhpVal) bool {
	mut var_switched_blog := false
	if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) {
		
	}
	
}

struct Class_WP_oEmbed {
	rt.PhpObjectBase
}

struct Class_WP_oEmbed_Controller {
	rt.PhpObjectBase
}

fn create_wp_oembed() &Class_WP_oEmbed {
	mut obj := &Class_WP_oEmbed{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_oembed_controller() &Class_WP_oEmbed_Controller {
	mut obj := &Class_WP_oEmbed_Controller{
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




pub fn init_wp_includes_embed_php() {
}
