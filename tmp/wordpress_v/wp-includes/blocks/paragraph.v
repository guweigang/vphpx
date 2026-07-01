import rt

fn block_core_paragraph_add_class(var_block_content rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(var_block_content)))) {
		return var_block_content.dup()
	}
	mut var_processor := create_wp_html_tag_processor(var_block_content.dup())
	if rt.is_true(var_processor.next_tag(rt.new_string('p'))) {
		var_processor.add_class(rt.new_string('wp-block-paragraph'))
	}
	return var_processor.get_updated_html()
}

fn register_block_core_paragraph() {
	rt.call_function('register_block_type_from_metadata', [@DIR + '/paragraph'])
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

pub fn init_wp_includes_blocks_paragraph_php() {
	rt.call_function('add_filter', [rt.new_string('render_block_core/paragraph'),
		rt.new_string('block_core_paragraph_add_class')])
	rt.call_function('add_action', [rt.new_string('init'),
		rt.new_string('register_block_core_paragraph')])
}
