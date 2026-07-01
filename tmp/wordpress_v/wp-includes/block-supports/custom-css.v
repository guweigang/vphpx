import rt

fn wp_render_custom_css_support_styles(var_parsed_block rt.PhpVal) rt.PhpVal {
	mut var_custom_css := if !(var_parsed_block.array_get('attrs').array_get('style').array_get('css')).is_null() { var_parsed_block.array_get('attrs').array_get('style').array_get('css') } else { rt.new_null() }
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_custom_css.dup().is_string()))))) || rt.is_true(rt.identical(rt.new_string(''), rt.new_string(var_custom_css.dup().to_string().trim_space()))))) {
		return var_parsed_block.dup()
	}
	mut var_block_type := rt.call_method(fn () rt.PhpVal { mut temp := Class_WP_Block_Type_Registry{}; return temp.get_instance() }(), 'get_registered', [var_parsed_block.array_get('blockName')])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('block_has_support', [var_block_type.dup(), rt.new_string('customCSS'), rt.new_bool(true)]))))) {
		return var_parsed_block.dup()
	}
	if rt.is_true(rt.call_function('preg_match', [rt.new_string('#</?\\w+#'), var_custom_css.dup()])) {
		return var_parsed_block.dup()
	}
	mut var_class_name := rt.call_function('wp_unique_id_from_values', [var_parsed_block.dup(), rt.new_string('wp-custom-css-')])
	mut var_existing_class_name := if !(var_parsed_block.array_get('attrs').array_get('className')).is_null() { var_parsed_block.array_get('attrs').array_get('className') } else { rt.new_null() }
	mut var_updated_class_name := if rt.is_true(rt.new_bool(var_existing_class_name.dup().is_string())) { rt.new_string("${var_existing_class_name.to_string()} ${var_class_name.to_string()}") } else { var_class_name }
	rt.call_function('_wp_array_set', [var_parsed_block.dup(), rt.create_array([rt.ArrayItem{ key: none, val: 'attrs' }, rt.ArrayItem{ key: none, val: 'className' }]), var_updated_class_name.dup()])
	mut var_selector := rt.new_string('.' + (var_class_name).str())
	mut var_processed_css := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_WP_Theme_JSON{}; return temp.process_blocks_custom_css(arg_0, arg_1) }(var_custom_css.dup(), var_selector.dup())
	if !(!rt.is_true(var_processed_css)) {
		rt.call_function('wp_register_style', [rt.new_string('wp-block-custom-css'), rt.new_bool(false), rt.create_array([rt.ArrayItem{ key: none, val: 'global-styles' }])])
		rt.call_function('wp_add_inline_style', [rt.new_string('wp-block-custom-css'), var_processed_css.dup()])
	}
	return var_parsed_block.dup()
}

fn wp_enqueue_block_custom_css() {
	rt.call_function('wp_enqueue_style', [rt.new_string('wp-block-custom-css')])
}

fn wp_render_custom_css_class_name(var_block_content rt.PhpVal, var_block rt.PhpVal) rt.PhpVal {
	mut var_class_name_attr := if !(var_block.array_get('attrs').array_get('className')).is_null() { var_block.array_get('attrs').array_get('className') } else { rt.new_null() }
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_class_name_attr.dup().is_string()))))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('str_contains', [var_class_name_attr.dup(), rt.new_string('wp-custom-css-')]))))))) {
		return var_block_content.dup()
	}
	mut var_custom_class_name := rt.new_null()
	mut var_token_delimiter := ' \t\r\n'
	mut var_class_token := rt.call_function('strtok', [var_class_name_attr.dup(), rt.new_string(var_token_delimiter).dup()])
	for rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		if rt.is_true(rt.call_function('str_starts_with', [var_class_token.dup(), rt.new_string('wp-custom-css-')])) {
			var_custom_class_name = var_class_token.dup()
			break
		}
		var_class_token = rt.call_function('strtok', [rt.new_string(var_token_delimiter).dup()])
	}
	if rt.is_true(rt.identical(rt.new_null(), var_custom_class_name)) {
		return var_block_content.dup()
	}
	mut var_tags := create_wp_html_tag_processor(var_block_content.dup())
	if rt.is_true(var_tags.next_tag()) {
		var_tags.add_class(rt.new_string('has-custom-css'))
		var_tags.add_class(var_custom_class_name.dup())
	}
	return var_tags.get_updated_html()
}

fn wp_register_custom_css_support(var_block_type rt.PhpVal) {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.get_property(var_block_type, 'attributes'))))) {
		rt.set_property(var_block_type, 'attributes', rt.new_array())
	}
	if rt.is_true(rt.new_bool(rt.get_property(var_block_type, 'attributes').array_isset(rt.new_string('style')))) {
		return rt.new_null()
	}
	mut var_has_custom_css_support := rt.call_function('block_has_support', [var_block_type.dup(), rt.create_array([rt.ArrayItem{ key: none, val: 'customCSS' }]), rt.new_bool(true)])
	if rt.is_true(var_has_custom_css_support) {
		rt.get_property(var_block_type, 'attributes').array_set('style', rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' }]))
	}
}

fn wp_strip_custom_css_from_blocks(var_content rt.PhpVal) rt.PhpVal {
	mut var_token_type := rt.new_null()
	mut var_attrs := map[string]rt.PhpVal{}
	mut var_start_offset := rt.new_null()
	mut var_token_length := rt.new_null()
	mut var_offset := rt.new_null()
	mut var_length := rt.new_null()
	mut var_new_json := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('has_blocks', [var_content.dup()]))))) {
		return var_content.dup()
	}
	mut var_unslashed := rt.call_function('stripslashes', [var_content.dup()])
	mut var_parser := create_wp_block_parser()
	rt.set_property(var_parser, 'document', var_unslashed.dup())
	rt.set_property(var_parser, 'offset', rt.new_int(0))
	mut var_end := var_unslashed.dup().to_string().len
	mut var_replacements := rt.new_array()
	for rt.is_true(rt.less(rt.get_property(var_parser, 'offset'), rt.new_int(var_end))) {
		mut var_next_token := var_parser.next_token()
		if rt.is_true(rt.identical(rt.new_string('no-more-tokens'), var_next_token.array_get(0))) {
			break
		}
		// unsupported assign target: Expr_List
		rt.set_property(var_parser, 'offset', rt.add(var_start_offset, var_token_length))
		if rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
			continue
		}
		if !(var_attrs.array_get('style').array_isset(rt.new_string('css'))) {
			continue
		}
		var_attrs.array_get('style').array_unset(rt.new_string('css'))
		if !rt.is_true(var_attrs.array_get('style')) {
			var_attrs.delete('style')
		}
		mut var_token_string := rt.call_function('substr', [var_unslashed.dup(), var_start_offset.dup(), var_token_length.dup()])
		mut var_json_rel_start := rt.call_function('strcspn', [var_token_string.dup(), rt.new_string('{')])
		mut var_json_rel_end := rt.call_function('strrpos', [var_token_string.dup(), rt.new_string('}')])
		mut var_json_start := rt.add(var_start_offset, var_json_rel_start)
		mut var_json_length := rt.add(rt.sub(var_json_rel_end, var_json_rel_start), rt.new_int(1))
		if !rt.is_true(var_attrs) {
			var_replacements << rt.create_array([rt.ArrayItem{ key: none, val: var_json_start }, rt.ArrayItem{ key: none, val: rt.add(var_json_length, rt.new_int(1)) }, rt.ArrayItem{ key: none, val: '' }])
		} else {
			var_replacements << rt.create_array([rt.ArrayItem{ key: none, val: var_json_start }, rt.ArrayItem{ key: none, val: var_json_length }, rt.ArrayItem{ key: none, val: rt.call_function('serialize_block_attributes', [var_attrs.dup()]) }])
		}
	}
	if !rt.is_true(var_replacements) {
		return var_content.dup()
	}
	mut var_result := ''
	mut var_was_at := rt.new_int(rt.new_int(0))
	for var_replacement in var_replacements {
		// unsupported assign target: Expr_List
		// unsupported expression: Expr_AssignOp_Concat
		var_was_at = rt.add(var_offset, var_length)
	}
	if rt.is_true(rt.less(var_was_at, rt.new_int(var_end))) {
		// unsupported expression: Expr_AssignOp_Concat
	}
	return rt.call_function('addslashes', [rt.new_string(var_result).dup()])
}

fn wp_custom_css_kses_init_filters() {
	rt.call_function('add_filter', [rt.new_string('content_save_pre'), rt.new_string('wp_strip_custom_css_from_blocks'), rt.new_int(8)])
	rt.call_function('add_filter', [rt.new_string('content_filtered_save_pre'), rt.new_string('wp_strip_custom_css_from_blocks'), rt.new_int(8)])
}

fn wp_custom_css_remove_filters() {
	rt.call_function('remove_filter', [rt.new_string('content_save_pre'), rt.new_string('wp_strip_custom_css_from_blocks'), rt.new_int(8)])
	rt.call_function('remove_filter', [rt.new_string('content_filtered_save_pre'), rt.new_string('wp_strip_custom_css_from_blocks'), rt.new_int(8)])
}

fn wp_custom_css_kses_init() {
	wp_custom_css_remove_filters()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_css')]))))) {
		wp_custom_css_kses_init_filters()
	}
}

fn wp_custom_css_force_filtered_html_on_import_filter(var_arg rt.PhpVal) rt.PhpVal {
	if rt.is_true(var_arg) {
		wp_custom_css_kses_init_filters()
	}
	return var_arg.dup()
}

struct Class_WP_Block_Type_Registry {
	rt.PhpObjectBase
}

struct Class_WP_Theme_JSON {
	rt.PhpObjectBase
}

struct Class_WP_HTML_Tag_Processor {
	rt.PhpObjectBase
}

struct Class_WP_Block_Parser {
	rt.PhpObjectBase
}

struct Class_WP_Block_Supports {
	rt.PhpObjectBase
}

fn create_wp_block_type_registry() &Class_WP_Block_Type_Registry {
	mut obj := &Class_WP_Block_Type_Registry{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_theme_json() &Class_WP_Theme_JSON {
	mut obj := &Class_WP_Theme_JSON{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_html_tag_processor() &Class_WP_HTML_Tag_Processor {
	mut obj := &Class_WP_HTML_Tag_Processor{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_block_parser() &Class_WP_Block_Parser {
	mut obj := &Class_WP_Block_Parser{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_block_supports() &Class_WP_Block_Supports {
	mut obj := &Class_WP_Block_Supports{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Block_Type_Registry) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Block_Type_Registry) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Block_Type_Registry) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_Theme_JSON) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Theme_JSON) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Theme_JSON) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
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


fn (mut this Class_WP_Block_Parser) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Block_Parser) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Block_Parser) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_Block_Supports) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Block_Supports) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Block_Supports) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_includes_block_supports_custom_css_php() {
	rt.call_function('add_filter', [rt.new_string('render_block'), rt.new_string('wp_render_custom_css_class_name'), rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_filter', [rt.new_string('render_block_data'), rt.new_string('wp_render_custom_css_support_styles'), rt.new_int(10), rt.new_int(1)])
	rt.call_function('add_action', [rt.new_string('wp_enqueue_scripts'), rt.new_string('wp_enqueue_block_custom_css'), rt.new_int(1)])
	rt.call_function('add_action', [rt.new_string('init'), rt.new_string('wp_custom_css_kses_init'), rt.new_int(20)])
	rt.call_function('add_action', [rt.new_string('set_current_user'), rt.new_string('wp_custom_css_kses_init')])
	rt.call_function('add_filter', [rt.new_string('force_filtered_html_on_import'), rt.new_string('wp_custom_css_force_filtered_html_on_import_filter'), rt.new_int(999)])
	rt.call_method(fn () rt.PhpVal { mut temp := Class_WP_Block_Supports{}; return temp.get_instance() }(), 'register', [rt.new_string('custom-css'), rt.create_array([rt.ArrayItem{ key: 'register_attribute', val: 'wp_register_custom_css_support' }])])
}
