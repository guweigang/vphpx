import rt

fn render_block_core_button(var_attributes rt.PhpVal, var_content rt.PhpVal) string {
	mut var_p := rt.new_null()
	mut var_tag := rt.new_null()
	mut var_is_empty := false
	var_p = create_wp_html_tag_processor(var_content.clone())
	var_tag = rt.new_null()
	for rt.is_true(var_p.next_tag()) {
		var_tag = var_p.get_tag()
		if rt.is_true(rt.identical(rt.new_string('A'), var_tag))
			|| rt.is_true(rt.identical(rt.new_string('BUTTON'), var_tag)) {
			break
		}
	}
	if rt.is_true(rt.identical(rt.new_null(), var_tag)) {
		return var_content.str()
	}
	var_is_empty = true
	for rt.is_true(var_p.next_token())
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_tag, var_p.get_token_name()))))
		&& var_is_empty {
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('#comment'),
			var_p.get_token_type()))))
		{
			var_is_empty = false
		}
	}
	if var_is_empty {
		return ''
	}
	return var_content.str()
}

fn register_block_core_button() {
	rt.call_function('register_block_type_from_metadata', [
		rt.new_string(@DIR + '/button'),
		rt.create_array([
			rt.ArrayItem{ key: 'render_callback', val: 'render_block_core_button' },
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
		[rt.new_string('init'), rt.new_string('register_block_core_button')])
}
