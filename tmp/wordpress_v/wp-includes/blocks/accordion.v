import rt

fn render_block_core_accordion(var_attributes rt.PhpVal, var_content rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(var_content)))) {
		return var_content.dup()
	}
	mut var_p := create_wp_html_tag_processor(var_content.dup())
	mut var_autoclose := if rt.is_true(var_attributes.array_get('autoclose')) {
		'true'
	} else {
		'false'
	}
	if rt.is_true(var_p.next_tag(rt.create_array([
		rt.ArrayItem{ key: 'class_name', val: 'wp-block-accordion' },
	])))
	{
		var_p.set_attribute(rt.new_string('data-wp-interactive'), rt.new_string('core/accordion'))
		var_p.set_attribute(rt.new_string('data-wp-context'), rt.new_string('{ "autoclose": ' +
			var_autoclose + ', "accordionItems": [] }'))
		var_content = var_p.get_updated_html()
	}
	return var_content.dup()
}

fn register_block_core_accordion() {
	rt.call_function('register_block_type_from_metadata', [@DIR + '/accordion',
		rt.create_array([
			rt.ArrayItem{ key: 'render_callback', val: 'render_block_core_accordion' },
		])])
}

struct Class_WP_HTML_Tag_Processor {
	rt.PhpObjectBase
}

fn create_wp_html_tag_processor() &Class_WP_HTML_Tag_Processor {
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

pub fn init_wp_includes_blocks_accordion_php() {
	rt.call_function('add_action', [rt.new_string('init'),
		rt.new_string('register_block_core_accordion')])
}
