import rt

fn block_core_details_set_img_fetchpriority_low(var_block_content rt.PhpVal, var_block rt.PhpVal) string {
	mut var_tags := rt.new_null()
	if !(var_block_content.clone().is_string()) {
		return ''
	}
	if rt.is_true(if !(var_block.array_get(rt.new_string('attrs')).array_get(rt.new_string('showContent'))).is_null() {
		var_block.array_get(rt.new_string('attrs')).array_get(rt.new_string('showContent'))
	} else {
		rt.new_bool(false)
	})
	{
		return var_block_content.str()
	}
	var_tags = create_wp_html_tag_processor(var_block_content.clone())
	for rt.is_true(var_tags.next_tag(rt.new_string('IMG'))) {
		var_tags.set_attribute(rt.new_string('fetchpriority'), rt.new_string('low'))
	}
	return (var_tags.get_updated_html()).str()
}

fn register_block_core_details() {
	rt.call_function('register_block_type_from_metadata', [
		rt.new_string(@DIR + '/details'),
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

	rt.call_function('add_filter', [rt.new_string('render_block_core/details'),
		rt.new_string('block_core_details_set_img_fetchpriority_low'),
		rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_action',
		[rt.new_string('init'), rt.new_string('register_block_core_details')])
}
