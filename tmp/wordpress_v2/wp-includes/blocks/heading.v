import rt

fn block_core_heading_render(var_attributes rt.PhpVal, var_content rt.PhpVal) rt.PhpVal {
	mut var_p := rt.new_null()
	mut var_header_tags := []rt.PhpVal{}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_content)))) {
		return var_content.clone()
	}
	var_p = create_wp_html_tag_processor(var_content.clone())
	var_header_tags = ['H1', 'H2', 'H3', 'H4', 'H5', 'H6']
	for rt.is_true(var_p.next_tag()) {
		if rt.is_true(rt.call_function('in_array', [var_p.get_tag(),
			rt.create_array_from_list(var_header_tags), rt.new_bool(true)]))
		{
			var_p.add_class(rt.new_string('wp-block-heading'))
			break
		}
	}
	return var_p.get_updated_html()
}

fn register_block_core_heading() {
	rt.call_function('register_block_type_from_metadata', [
		rt.new_string(@DIR + '/heading'),
		rt.create_array([
			rt.ArrayItem{ key: 'render_callback', val: 'block_core_heading_render' },
		]),
	])
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
		[rt.new_string('init'), rt.new_string('register_block_core_heading')])
}
