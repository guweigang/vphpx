import rt

fn render_block_core_site_logo(var_attributes rt.PhpVal) string {
	mut var_adjust_width_height_filter := rt.new_null()
	mut var_custom_logo := rt.new_null()
	mut var_processor := rt.new_null()
	mut var_classnames := []rt.PhpVal{}
	mut var_wrapper_attributes := rt.new_null()
	mut var_html := rt.new_null()
	closure_1_fn := fn [var_attributes] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_image := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		if !rt.is_true(var_attributes.array_get(rt.new_string('width'))) || !rt.is_true(var_image)
			|| rt.is_true(rt.new_bool(!(rt.is_true(var_image.array_get(rt.new_int(1))))))
			|| rt.is_true(rt.new_bool(!(rt.is_true(var_image.array_get(rt.new_int(2)))))) {
			return var_image.str()
		}
		mut var_height := rt.new_float((var_attributes.array_get(rt.new_string('width'))).to_f64()) / rt.new_float((var_image.array_get(rt.new_int(1))).to_f64()) / rt.new_float((var_image.array_get(rt.new_int(2))).to_f64())
		return (rt.create_array([
			rt.ArrayItem{ key: none, val: var_image.array_get(rt.new_int(0)) },
			rt.ArrayItem{
				key: none
				val: rt.new_int((var_attributes.array_get(rt.new_string('width'))).to_i64())
			},
			rt.ArrayItem{ key: none, val: rt.new_int(var_height.to_i64()) },
		])).str()
	}
	var_adjust_width_height_filter = rt.new_closure(closure_1_fn)
	rt.call_function('add_filter', [rt.new_string('wp_get_attachment_image_src'),
		var_adjust_width_height_filter.clone()])
	var_custom_logo = rt.call_function('get_custom_logo', []rt.PhpVal{})
	rt.call_function('remove_filter', [rt.new_string('wp_get_attachment_image_src'),
		var_adjust_width_height_filter.clone()])
	if !rt.is_true(var_custom_logo) {
		return ''
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_attributes.array_get(rt.new_string('isLink')))))) {
		var_custom_logo = rt.call_function('preg_replace', [
			rt.new_string('#<a.*?>(.*?)</a>#i'),
			rt.new_string('\\1'),
			var_custom_logo.clone(),
		])
	}
	if rt.is_true(var_attributes.array_get(rt.new_string('isLink')))
		&& rt.is_true(rt.identical(rt.new_string('_blank'), var_attributes.array_get(rt.new_string('linkTarget')))) {
		var_processor = create_wp_html_tag_processor(var_custom_logo.clone())
		var_processor.next_tag(rt.new_string('a'))
		if rt.is_true(rt.identical(rt.new_string('home'),
			var_processor.get_attribute(rt.new_string('rel'))))
		{
			var_processor.set_attribute(rt.new_string('aria-label'), rt.call_function('__', [
				rt.new_string('(Home link, opens in a new tab)'),
			]))
			var_processor.set_attribute(rt.new_string('target'),
				var_attributes.array_get(rt.new_string('linkTarget')))
		}
		var_custom_logo = var_processor.get_updated_html()
	}
	var_classnames = []rt.PhpVal{}
	if !rt.is_true(var_attributes.array_get(rt.new_string('width'))) {
		var_classnames << 'is-default-size'
	}
	var_wrapper_attributes = rt.call_function('get_block_wrapper_attributes', [
		rt.create_array([
			rt.ArrayItem{ key: 'class', val: rt.call_function('implode', [
				rt.new_string(' '),
				rt.create_array_from_list(var_classnames),
			]) },
		]),
	])
	var_html = rt.call_function('sprintf', [rt.new_string('<div %s>%s</div>'),
		var_wrapper_attributes.clone(), var_custom_logo.clone()])
	return var_html.str()
}

fn register_block_core_site_logo_setting() {
	rt.call_function('register_setting', [rt.new_string('general'),
		rt.new_string('site_logo'),
		rt.create_array([
			rt.ArrayItem{ key: 'show_in_rest', val: rt.create_array([
				rt.ArrayItem{ key: 'name', val: 'site_logo' },
			]) },
			rt.ArrayItem{ key: 'type', val: 'integer' },
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('Logo'),
			]) },
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Site logo.'),
			]) },
		])])
}

fn register_block_core_site_icon_setting() {
	rt.call_function('register_setting', [rt.new_string('general'),
		rt.new_string('site_icon'),
		rt.create_array([
			rt.ArrayItem{ key: 'show_in_rest', val: true },
			rt.ArrayItem{ key: 'type', val: 'integer' },
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('Icon'),
			]) },
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Site icon.'),
			]) },
		])])
}

fn register_block_core_site_logo() {
	rt.call_function('register_block_type_from_metadata', [
		rt.new_string(@DIR + '/site-logo'),
		rt.create_array([
			rt.ArrayItem{ key: 'render_callback', val: 'render_block_core_site_logo' },
		]),
	])
}

fn _override_custom_logo_theme_mod(var_custom_logo rt.PhpVal) rt.PhpVal {
	mut var_site_logo := rt.new_null()
	var_site_logo = rt.call_function('get_option', [rt.new_string('site_logo')])
	return if rt.is_true(rt.identical(rt.new_bool(false), var_site_logo)) {
		var_custom_logo
	} else {
		var_site_logo
	}
}

fn _sync_custom_logo_to_site_logo(var_value rt.PhpVal) rt.PhpVal {
	if !rt.is_true(var_value) {
		rt.call_function('delete_option', [rt.new_string('site_logo')])
	} else {
		rt.call_function('update_option', [rt.new_string('site_logo'),
			var_value.clone()])
	}
	return var_value.clone()
}

fn _delete_site_logo_on_remove_custom_logo(var_old_value rt.PhpVal, var_value rt.PhpVal) {
	mut var__ignore_site_logo_changes := rt.new_null()
	if rt.is_true(var__ignore_site_logo_changes) {
		return
	}
	if var_old_value.array_isset(rt.new_string('custom_logo'))
		&& !(var_value.array_isset(rt.new_string('custom_logo'))) {
		rt.call_function('delete_option', [rt.new_string('site_logo')])
	}
}

fn _delete_site_logo_on_remove_theme_mods() {
	mut var__ignore_site_logo_changes := rt.new_null()
	if rt.is_true(var__ignore_site_logo_changes) {
		return
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('get_theme_support', [
		rt.new_string('custom-logo'),
	])))))
	{
		rt.call_function('delete_option', [rt.new_string('site_logo')])
	}
}

fn _delete_site_logo_on_remove_custom_logo_on_setup_theme() {
	mut var_theme := rt.new_null()
	var_theme = rt.call_function('get_option', [rt.new_string('stylesheet')])
	rt.call_function('add_action', [
		rt.new_string('update_option_theme_mods_${var_theme.to_string()}'),
		rt.new_string('_delete_site_logo_on_remove_custom_logo'),
		rt.new_int(10),
		rt.new_int(2),
	])
	rt.call_function('add_action', [
		rt.new_string('delete_option_theme_mods_${var_theme.to_string()}'),
		rt.new_string('_delete_site_logo_on_remove_theme_mods'),
	])
}

fn _delete_custom_logo_on_remove_site_logo() {
	mut var__ignore_site_logo_changes := false
	var__ignore_site_logo_changes = true
	rt.call_function('remove_theme_mod', [rt.new_string('custom_logo')])
	var__ignore_site_logo_changes = false
}

struct Class_WP_HTML_Tag_Processor {
	rt.PhpObjectBase
}

fn create_wp_html_tag_processor(_args ...rt.PhpVal) &Class_WP_HTML_Tag_Processor {
	mut obj := &Class_WP_HTML_Tag_Processor{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
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

	rt.call_function('add_action', [rt.new_string('rest_api_init'),
		rt.new_string('register_block_core_site_logo_setting'),
		rt.new_int(10)])
	rt.call_function('add_action', [rt.new_string('rest_api_init'),
		rt.new_string('register_block_core_site_icon_setting'),
		rt.new_int(10)])
	rt.call_function('add_action', [rt.new_string('init'),
		rt.new_string('register_block_core_site_logo')])
	rt.call_function('add_filter', [rt.new_string('theme_mod_custom_logo'),
		rt.new_string('_override_custom_logo_theme_mod')])
	rt.call_function('add_filter', [rt.new_string('pre_set_theme_mod_custom_logo'),
		rt.new_string('_sync_custom_logo_to_site_logo')])
	rt.call_function('add_action', [rt.new_string('setup_theme'),
		rt.new_string('_delete_site_logo_on_remove_custom_logo_on_setup_theme'),
		rt.new_int(11)])
	rt.call_function('add_action', [rt.new_string('delete_option_site_logo'),
		rt.new_string('_delete_custom_logo_on_remove_site_logo')])
}
