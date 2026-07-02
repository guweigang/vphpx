import rt

fn render_block_core_file(var_attributes rt.PhpVal, var_content rt.PhpVal) rt.PhpVal {
	mut var_processor := rt.new_null()
	mut var_filename := rt.new_null()
	mut var_has_filename := false
	mut var_label := rt.new_null()
	if !rt.is_true(var_attributes.array_get(rt.new_string('displayPreview'))) {
		return var_content.clone()
	}
	rt.call_function('wp_enqueue_script_module', [
		rt.new_string('@wordpress/block-library/file/view'),
	])
	var_processor = create_wp_html_tag_processor(var_content.clone())
	if rt.is_true(var_processor.next_tag()) {
		var_processor.set_attribute(rt.new_string('data-wp-interactive'),
			rt.new_string('core/file'))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_processor.next_tag(rt.new_string('OBJECT')))))) {
		return var_content.clone()
	}
	var_processor.set_attribute(rt.new_string('data-wp-bind--hidden'),
		rt.new_string('!state.hasPdfPreview'))
	var_processor.set_attribute(rt.new_string('hidden'), rt.new_bool(true))
	var_filename = var_processor.get_attribute(rt.new_string('aria-label'))
	var_has_filename = var_filename.clone().is_string() && !(!rt.is_true(var_filename))
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('PDF embed'), var_filename))))
	var_label = if var_has_filename { rt.call_function('sprintf', [
			rt.call_function('__', [rt.new_string('Embed of %s.')]),
			var_filename.clone(),
		]) } else { rt.call_function('__', [rt.new_string('PDF embed')]) }
	var_processor.set_attribute(rt.new_string('aria-label'), var_label.clone())
	return var_processor.get_updated_html()
}

fn register_block_core_file() {
	rt.call_function('register_block_type_from_metadata', [rt.new_string(@DIR + '/file'),
		rt.create_array([
			rt.ArrayItem{ key: 'render_callback', val: 'render_block_core_file' },
		])])
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

	rt.call_function('add_action',
		[rt.new_string('init'), rt.new_string('register_block_core_file')])
}
