import rt

fn _add_template_loader_filters() {
	if rt.get_superglobal('_GET').array_isset(rt.new_string('_wp-find-template'))
		&& rt.is_true(rt.call_function('current_theme_supports', [rt.new_string('block-templates')])) {
		rt.call_function('add_action', [rt.new_string('pre_get_posts'),
			rt.new_string('_resolve_template_for_new_post')])
	}
}

fn wp_render_empty_block_template_warning(var_block_template rt.PhpVal) rt.PhpVal {
	rt.call_function('wp_enqueue_style', [rt.new_string('wp-empty-template-alert')])
	return rt.call_function('sprintf', [
		rt.new_string('<div id="wp-empty-template-alert">\n\t\t\t<h2>%1$s</h2>\n\t\t\t<p>%2$s</p>\n\t\t\t<a href="%3$s" class="wp-element-button">\n\t\t\t\t%4$s\n\t\t\t</a>\n\t\t</div>'),
		rt.call_function('esc_html', [rt.get_property(var_block_template, 'title')]),
		rt.call_function('__', [
			rt.new_string('This page is blank because the template is empty. You can reset or customize it in the Site Editor.'),
		]),
		rt.call_function('get_edit_post_link', [
			rt.get_property(var_block_template, 'wp_id'),
			rt.new_string('site-editor'),
		]),
		rt.call_function('__', [
			rt.new_string('Edit template'),
		]),
	])
}

fn locate_block_template(var_template rt.PhpVal, var_type rt.PhpVal, var_templates_arg rt.PhpVal) string {
	mut var_templates := var_templates_arg
	mut var_relative_template_path := rt.new_null()
	mut var_index := rt.new_null()
	mut var_block_template := rt.new_null()
	mut var__wp_current_template_id := rt.new_null()
	mut var__wp_current_template_content := rt.new_null()
	mut var_theme_template := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_theme_supports', [
		rt.new_string('block-templates'),
	])))))
	{
		return var_template.str()
	}
	if rt.is_true(var_template) {
		var_relative_template_path = rt.call_function('str_replace', [
			rt.create_array([
				rt.ArrayItem{ key: none, val:
					(rt.call_function('get_stylesheet_directory', []rt.PhpVal{})).str() + '/' },
				rt.ArrayItem{ key: none, val:
					(rt.call_function('get_template_directory', []rt.PhpVal{})).str() + '/' },
			]),
			rt.new_string(''),
			var_template.clone(),
		])
		var_index = rt.call_function('array_search', [var_relative_template_path.clone(),
			var_templates.clone(), rt.new_bool(true)])
		var_templates = rt.call_function('array_slice', [var_templates.clone(),
			rt.new_int(0), rt.add(var_index, rt.new_int(1))])
	}
	var_block_template = resolve_block_template(var_type.clone(), var_templates.clone(),
		var_template.clone())
	if rt.is_true(var_block_template) {
		var__wp_current_template_id = rt.get_property(var_block_template, 'id')
		if !rt.is_true(rt.get_property(var_block_template, 'content')) {
			if rt.is_true(rt.call_function('is_user_logged_in', []rt.PhpVal{})) {
				var__wp_current_template_content =
					wp_render_empty_block_template_warning(var_block_template.clone())
			} else {
				if rt.is_true(rt.get_property(var_block_template, 'has_theme_file')) {
					var_theme_template = rt.call_function('_get_block_template_file', [
						rt.new_string('wp_template'),
						rt.get_property(var_block_template, 'slug'),
					])
					var__wp_current_template_content = rt.call_function('file_get_contents', [
						var_theme_template.array_get(rt.new_string('path')),
					])
				} else {
					var__wp_current_template_content = rt.get_property(var_block_template,
						'content')
				}
			}
		} else if !(!rt.is_true(rt.get_property(var_block_template, 'content'))) {
			var__wp_current_template_content = rt.get_property(var_block_template, 'content')
		}
		if rt.get_superglobal('_GET').array_isset(rt.new_string('_wp-find-template')) {
			rt.call_function('wp_send_json_success', [var_block_template.clone()])
		}
	} else {
		if rt.is_true(var_template) {
			return var_template.str()
		}
		if rt.is_true(rt.identical(rt.new_string('index'), var_type)) {
			if rt.get_superglobal('_GET').array_isset(rt.new_string('_wp-find-template')) {
				rt.call_function('wp_send_json_error', [
					rt.create_array([
						rt.ArrayItem{ key: 'message', val: rt.call_function('__', [
							rt.new_string('No matching template found.'),
						]) },
					]),
				])
			}
		} else {
			return ''
		}
	}
	rt.call_function('add_action', [rt.new_string('wp_head'),
		rt.new_string('_block_template_viewport_meta_tag'), rt.new_int(0)])
	rt.call_function('remove_action', [rt.new_string('wp_head'),
		rt.new_string('_wp_render_title_tag'), rt.new_int(1)])
	rt.call_function('add_action', [rt.new_string('wp_head'),
		rt.new_string('_block_template_render_title_tag'), rt.new_int(1)])
	return
		(rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/template-canvas.php'
}

fn resolve_block_template(var_template_type rt.PhpVal, var_template_hierarchy_arg rt.PhpVal, var_fallback_template rt.PhpVal) rt.PhpVal {
	mut var_template_hierarchy := var_template_hierarchy_arg
	mut var_slugs := rt.new_null()
	mut var_query := map[string]rt.PhpVal{}
	mut var_templates := rt.new_null()
	mut var_slug_priorities := rt.new_null()
	mut var_theme_base_path := rt.new_null()
	mut var_parent_theme_base_path := rt.new_null()
	mut var_fallback_template_slug := rt.new_null()
	mut var_template_file := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(var_template_type)))) {
		return rt.new_null()
	}
	if !rt.is_true(var_template_hierarchy) {
		var_template_hierarchy = [var_template_type]
	}
	var_slugs = rt.call_function('array_map', [
		rt.new_string('_strip_template_file_suffix'),
		rt.create_array_from_list(var_template_hierarchy),
	])
	var_query = {
		'slug__in': var_slugs
	}
	var_templates = rt.call_function('get_block_templates', [
		rt.create_array_from_native_map(var_query),
	])
	var_slug_priorities = rt.call_function('array_flip', [var_slugs.clone()])
	closure_1_fn := fn [var_slug_priorities] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_template_a := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_template_b := if args.len > 1 { args[1].clone() } else { rt.new_null() }
		return rt.sub(var_slug_priorities.array_get(rt.get_property(var_template_a, 'slug')), var_slug_priorities.array_get(rt.get_property(var_template_b,
			'slug')))
	}
	rt.call_function('usort', [var_templates.clone(), rt.new_closure(closure_1_fn)])
	var_theme_base_path = rt.new_string(
		(rt.call_function('get_stylesheet_directory', []rt.PhpVal{})).str() +
		(rt.get_constant('DIRECTORY_SEPARATOR')).str())
	var_parent_theme_base_path = rt.new_string(
		(rt.call_function('get_template_directory', []rt.PhpVal{})).str() +
		(rt.get_constant('DIRECTORY_SEPARATOR')).str())
	if rt.is_true(rt.call_function('str_starts_with', [var_fallback_template.clone(), var_theme_base_path.clone()]))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('str_contains', [var_fallback_template.clone(), var_parent_theme_base_path.clone()]))))) {
		var_fallback_template_slug = rt.call_function('substr', [
			var_fallback_template.clone(),
			rt.add(rt.call_function('strpos', [
				var_fallback_template.clone(), var_theme_base_path.clone()]),
				rt.new_int(var_theme_base_path.clone().to_string().len)),
			rt.new_int(-4)])
		if rt.is_true(rt.new_int(var_templates.clone().array_count()))
			&& rt.is_true(rt.identical(var_fallback_template_slug, rt.get_property(var_templates.array_get(rt.new_int(0)), 'slug')))
			&& rt.is_true(rt.identical(rt.new_string('theme'), rt.get_property(var_templates.array_get(rt.new_int(0)), 'source'))) {
			var_template_file = rt.call_function('_get_block_template_file', [
				rt.new_string('wp_template'),
				var_fallback_template_slug.clone(),
			])
			if rt.is_true(var_template_file)
				&& rt.is_true(rt.identical(rt.call_function('get_template', []rt.PhpVal{}), var_template_file.array_get(rt.new_string('theme')))) {
				rt.call_function('array_shift', [var_templates.clone()])
			}
		}
	}
	return if rt.is_true(rt.new_int(var_templates.clone().array_count())) {
		var_templates.array_get(rt.new_int(0))
	} else {
		rt.new_null()
	}
}

fn _block_template_render_title_tag() {
	print('<title>' + (rt.call_function('wp_get_document_title', []rt.PhpVal{})).str() +
		'</title>' + '\n')
}

fn get_the_block_template_html() string {
	mut var__wp_current_template_id := rt.new_null()
	mut var__wp_current_template_content := rt.new_null()
	mut var_wp_embed := rt.new_null()
	mut var_wp_query := rt.new_null()
	mut var_content := rt.new_null()
	mut var_template_html := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(var__wp_current_template_content)))) {
		if rt.is_true(rt.call_function('is_user_logged_in', []rt.PhpVal{})) {
			return '<h1>' +
				(rt.call_function('esc_html__', [rt.new_string('No matching template found')])).str() +
				'</h1>'
		}
		return ''
	}
	var_content = rt.call_method(var_wp_embed, 'run_shortcode', [
		var__wp_current_template_content.clone()])
	var_content = rt.call_method(var_wp_embed, 'autoembed', [
		var_content.clone()])
	var_content = rt.call_function('shortcode_unautop', [var_content.clone()])
	var_content = rt.call_function('do_shortcode', [var_content.clone()])
	if rt.is_true(var__wp_current_template_id)
		&& rt.is_true(rt.call_function('str_starts_with', [var__wp_current_template_id.clone(), rt.new_string((rt.call_function('get_stylesheet', []rt.PhpVal{})).str() + '//')]))
		&& rt.is_true(rt.call_function('is_singular', []rt.PhpVal{}))
		&& rt.is_true(rt.identical(rt.new_int(1), rt.get_property(var_wp_query, 'post_count')))
		&& rt.is_true(rt.call_function('have_posts', []rt.PhpVal{})) {
		for rt.is_true(rt.call_function('have_posts', []rt.PhpVal{})) {
			rt.call_function('the_post', []rt.PhpVal{})
			var_content = rt.call_function('do_blocks', [var_content.clone()])
		}
	} else {
		var_content = rt.call_function('do_blocks', [var_content.clone()])
	}
	var_content = rt.call_function('wptexturize', [var_content.clone()])
	var_content = rt.call_function('convert_smilies', [var_content.clone()])
	var_content = rt.call_function('wp_filter_content_tags', [
		var_content.clone(), rt.new_string('template')])
	var_content = rt.call_function('str_replace', [rt.new_string(']]>'),
		rt.new_string(']]&gt;'), var_content.clone()])
	var_template_html = rt.new_string('<div class="wp-site-blocks">' + var_content.str() + '</div>')
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('has_action', [rt.new_string('wp_footer'), rt.new_string('the_block_template_skip_link')])))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('has_action', [rt.new_string('wp_enqueue_scripts'), rt.new_string('wp_enqueue_block_template_skip_link')]))))) {
		return var_template_html.str()
	}
	return _block_template_add_skip_link(var_template_html.clone())
}

fn _block_template_add_skip_link(template_html string) string {
	mut var_template_html := template_html
	mut var_processor := rt.new_null()
	mut var_skip_link_target_id := rt.new_null()
	mut var_skip_link := rt.new_null()
	var_processor = rt.create_object_dynamically(rt.new_null(), [
		rt.new_string(template_html),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_processor, 'next_tag', [
		rt.create_array([rt.ArrayItem{ key: 'tag_name', val: 'DIV' },
			rt.ArrayItem{ key: 'class_name', val: 'wp-site-blocks' }]),
	])))))
	{
		return template_html
	}
	rt.call_method(var_processor, 'set_bookmark', [
		rt.new_string('skip_link_insertion_point'),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_processor, 'next_tag', [
		rt.new_string('MAIN'),
	])))))
	{
		return template_html
	}
	var_skip_link_target_id = rt.call_method(var_processor, 'get_attribute', [
		rt.new_string('id'),
	])
	if !(var_skip_link_target_id.clone().is_string())
		|| rt.is_true(rt.identical(rt.new_string(''), var_skip_link_target_id)) {
		var_skip_link_target_id = rt.new_string('wp--skip-link--target')
		rt.call_method(var_processor, 'set_attribute', [rt.new_string('id'),
			var_skip_link_target_id.clone()])
	}
	rt.call_method(var_processor, 'seek', [rt.new_string('skip_link_insertion_point')])
	var_skip_link = rt.call_function('sprintf', [
		rt.new_string('<a class="skip-link screen-reader-text" id="wp-skip-link" href="%s">%s</a>'),
		rt.call_function('esc_url', [
			rt.new_string('#' + var_skip_link_target_id.str()),
		]),
		rt.call_function('esc_html__', [
			rt.new_string('Skip to content'),
		]),
	])
	rt.call_method(var_processor, 'insert_before', [var_skip_link.clone()])
	return (rt.call_method(var_processor, 'get_updated_html', []rt.PhpVal{})).str()
}

fn _block_template_viewport_meta_tag() {
	print('<meta name="viewport" content="width=device-width, initial-scale=1" />' + '\n')
}

fn _strip_template_file_suffix(var_template_file rt.PhpVal) rt.PhpVal {
	return rt.call_function('preg_replace', [rt.new_string('/\\.(php|html)$/'),
		rt.new_string(''), var_template_file.clone()])
}

fn _block_template_render_without_post_block_context(var_context rt.PhpVal) rt.PhpVal {
	if var_context.array_isset(rt.new_string('postType'))
		&& rt.is_true(rt.identical(rt.new_string('wp_template'), var_context.array_get(rt.new_string('postType')))) {
		var_context.delete('postId')
		var_context.delete('postType')
	}
	return var_context.clone()
}

fn _resolve_template_for_new_post(var_wp_query rt.PhpVal) {
	mut var_page_id := rt.new_null()
	mut var_p := rt.new_null()
	mut var_post_id := rt.new_null()
	mut var_post := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_wp_query, 'is_main_query',
		[]rt.PhpVal{})))))
	{
		return
	}
	rt.call_function('remove_filter', [rt.new_string('pre_get_posts'),
		rt.new_string('_resolve_template_for_new_post')])
	var_page_id = if !(rt.get_property(var_wp_query, 'query').array_get(rt.new_string('page_id'))).is_null() {
		rt.get_property(var_wp_query, 'query').array_get(rt.new_string('page_id'))
	} else {
		rt.new_null()
	}
	var_p = if !(rt.get_property(var_wp_query, 'query').array_get(rt.new_string('p'))).is_null() {
		rt.get_property(var_wp_query, 'query').array_get(rt.new_string('p'))
	} else {
		rt.new_null()
	}
	var_post_id = if rt.is_true(var_page_id) { var_page_id } else { var_p }
	var_post = rt.call_function('get_post', [var_post_id.clone()])
	if rt.is_true(var_post)
		&& rt.is_true(rt.identical(rt.new_string('auto-draft'), rt.get_property(var_post, 'post_status')))
		&& rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_post'), rt.get_property(var_post, 'ID')])) {
		rt.call_method(var_wp_query, 'set', [rt.new_string('post_status'),
			rt.new_string('auto-draft')])
	}
}

fn register_block_template(var_template_name rt.PhpVal, var_args rt.PhpVal) rt.PhpVal {
	mut iife_temp_1 := Class_WP_Block_Templates_Registry{}
	mut iife_result_1 := iife_temp_1.get_instance()
	return rt.call_method(iife_result_1, 'register', [var_template_name.clone(),
		var_args.clone()])
}

fn unregister_block_template(var_template_name rt.PhpVal) rt.PhpVal {
	mut iife_temp_2 := Class_WP_Block_Templates_Registry{}
	mut iife_result_2 := iife_temp_2.get_instance()
	return rt.call_method(iife_result_2, 'unregister', [var_template_name.clone()])
}

struct Class_WP_Block_Templates_Registry {
	rt.PhpObjectBase
}

fn create_wp_block_templates_registry(_args ...rt.PhpVal) &Class_WP_Block_Templates_Registry {
	mut obj := &Class_WP_Block_Templates_Registry{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Block_Templates_Registry) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Block_Templates_Registry) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Block_Templates_Registry) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn init_registry() {
	rt.register_class_factory('WP_Block_Templates_Registry', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_wp_block_templates_registry()
		return rt.new_object('WP_Block_Templates_Registry', []string{}, obj)
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
