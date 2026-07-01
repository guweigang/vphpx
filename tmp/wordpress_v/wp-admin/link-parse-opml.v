import rt

fn startElement(var_parser rt.PhpVal, var_tag_name rt.PhpVal, var_attrs rt.PhpVal) {
	mut var_names := []rt.PhpVal{}
	mut var_urls := []rt.PhpVal{}
	mut var_targets := []rt.PhpVal{}
	mut var_descriptions := []rt.PhpVal{}
	mut var_feeds := []rt.PhpVal{}
	// unsupported statement: Stmt_Global
	if rt.is_true(rt.identical(rt.new_string('OUTLINE'), var_tag_name)) {
		mut var_name := rt.new_string(rt.new_string(''))
		if var_attrs.array_isset(rt.new_string('TEXT')) {
			var_name = var_attrs.array_get('TEXT')
		}
		if var_attrs.array_isset(rt.new_string('TITLE')) {
			var_name = var_attrs.array_get('TITLE')
		}
		mut var_url := rt.new_string(rt.new_string(''))
		if var_attrs.array_isset(rt.new_string('URL')) {
			var_url = var_attrs.array_get('URL')
		}
		if var_attrs.array_isset(rt.new_string('HTMLURL')) {
			var_url = var_attrs.array_get('HTMLURL')
		}
		var_names << var_name.dup()
		var_urls << var_url.dup()
		var_targets << if !(var_attrs.array_get('TARGET')).is_null() { var_attrs.array_get('TARGET') } else { rt.new_string('') }
		var_feeds << if !(var_attrs.array_get('XMLURL')).is_null() { var_attrs.array_get('XMLURL') } else { rt.new_string('') }
		var_descriptions << if !(var_attrs.array_get('DESCRIPTION')).is_null() { var_attrs.array_get('DESCRIPTION') } else { rt.new_string('') }
	}
	// unsupported statement: Stmt_Nop
}

fn endElement(var_parser rt.PhpVal, var_tag_name rt.PhpVal) {
	// unsupported statement: Stmt_Nop
}


fn main() {
	defer {
		rt.shutdown()
	}

	mut var_opml := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))))) {
		// unsupported expression: Expr_Exit
	}
	// unsupported statement: Stmt_Global
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('xml_parser_create')]))))) {
		rt.call_function('wp_trigger_error', [rt.new_string(''), rt.call_function('__', [rt.new_string('PHP\'s XML extension is not available. Please contact your hosting provider to enable PHP\'s XML extension.')])])
		rt.call_function('wp_die', [rt.call_function('__', [rt.new_string('PHP\'s XML extension is not available. Please contact your hosting provider to enable PHP\'s XML extension.')])])
	}
	mut var_xml_parser := rt.call_function('xml_parser_create', []rt.PhpVal{})
	rt.call_function('xml_set_element_handler', [var_xml_parser.dup(), rt.new_string('startElement'), rt.new_string('endElement')])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('xml_parse', [var_xml_parser.dup(), var_opml.dup(), rt.new_bool(true)]))))) {
		rt.call_function('printf', [rt.call_function('__', [rt.new_string('XML Error: %1$s at line %2$s')]), rt.call_function('xml_error_string', [rt.call_function('xml_get_error_code', [var_xml_parser.dup()])]), rt.call_function('xml_get_current_line_number', [var_xml_parser.dup()])])
	}
	if rt.is_true(rt.less(rt.get_constant('PHP_VERSION_ID'), rt.new_int(80000))) {
		rt.call_function('xml_parser_free', [var_xml_parser.dup()])
	}
	var_xml_parser = rt.new_null()
}
