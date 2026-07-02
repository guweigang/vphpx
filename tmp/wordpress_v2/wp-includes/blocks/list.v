import rt

fn block_core_list_render(var_attributes rt.PhpVal, var_content rt.PhpVal) rt.PhpVal {
	mut var_processor := rt.new_null()
	mut var_list_tags := []rt.PhpVal{}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_content)))) {
		return var_content.clone()
	}
	var_processor = create_wp_html_tag_processor(var_content.clone())
	var_list_tags = ['OL', 'UL']
	for rt.is_true(var_processor.next_tag()) {
		if rt.is_true(rt.call_function('in_array', [var_processor.get_tag(),
			rt.create_array_from_list(var_list_tags), rt.new_bool(true)]))
		{
			var_processor.add_class(rt.new_string('wp-block-list'))
			break
		}
	}
	return var_processor.get_updated_html()
}

fn register_block_core_list() {
	rt.call_function('register_block_type_from_metadata', [rt.new_string(@DIR + '/list'),
		rt.create_array([
			rt.ArrayItem{ key: 'render_callback', val: 'block_core_list_render' },
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
		[rt.new_string('init'), rt.new_string('register_block_core_list')])
}
