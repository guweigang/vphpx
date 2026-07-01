import rt

fn render_block_core_video(var_attributes rt.PhpVal, content string) string {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('str_contains', [rt.new_string(content), rt.new_string('<video')]))))) {
		return content
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(var_attributes.array_isset(rt.new_string('id'))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_attributes.array_get('id').is_long()))))))) || rt.is_true(rt.less_equal(var_attributes.array_get('id'), rt.new_int(0))))) {
		return content
	}
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return content
	}
	mut var_metadata := rt.call_function('wp_get_attachment_metadata', [var_attributes.array_get('id')])
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(var_metadata.array_isset(rt.new_string('width')) && var_metadata.array_isset(rt.new_string('height'))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_metadata.array_get('width').is_long())) && rt.is_true(rt.new_bool(var_metadata.array_get('height').is_long()))))))))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.is_true(rt.greater(var_metadata.array_get('width'), rt.new_int(0))) && rt.is_true(rt.greater(var_metadata.array_get('height'), rt.new_int(0)))))))))) {
		return content
	}
	mut var_p := create_wp_html_tag_processor(rt.new_string(content).dup())
	if rt.is_true(rt.new_bool(!(rt.is_true(var_p.next_tag(rt.create_array([rt.ArrayItem{ key: 'tag_name', val: 'VIDEO' }])))))) {
		return content
	}
	var_p.set_attribute(rt.new_string('width'), // unsupported expression: Expr_Cast_String)
	var_p.set_attribute(rt.new_string('height'), // unsupported expression: Expr_Cast_String)
	mut var_style := var_p.get_attribute(rt.new_string('style'))
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_style.dup().is_string()))))) {
		var_style = rt.new_string(rt.new_string(''))
	}
	mut var_aspect_ratio_style := rt.call_function('sprintf', [rt.new_string('aspect-ratio: %d / %d;'), var_metadata.array_get('width'), var_metadata.array_get('height')])
	var_p.set_attribute(rt.new_string('style'), rt.new_string((var_aspect_ratio_style).str() + (var_style).str()))
	return (var_p.get_updated_html()).str()
}

fn register_block_core_video() {
	rt.call_function('register_block_type_from_metadata', [@DIR + '/video', rt.create_array([rt.ArrayItem{ key: 'render_callback', val: 'render_block_core_video' }])])
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




pub fn init_wp_includes_blocks_video_php() {
	rt.call_function('add_action', [rt.new_string('init'), rt.new_string('register_block_core_video')])
}
