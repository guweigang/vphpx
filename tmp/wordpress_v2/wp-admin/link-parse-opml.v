import rt

fn startelement(var_parser rt.PhpVal, var_tag_name rt.PhpVal, var_attrs rt.PhpVal) {
	mut var_names := []rt.PhpVal{}
	mut var_urls := []rt.PhpVal{}
	mut var_targets := []rt.PhpVal{}
	mut var_descriptions := []rt.PhpVal{}
	mut var_feeds := []rt.PhpVal{}
	mut var_name := rt.new_null()
	mut var_url := rt.new_null()
	if rt.is_true(rt.identical(rt.new_string('OUTLINE'), var_tag_name)) {
		var_name = rt.new_string('')
		if var_attrs.array_isset(rt.new_string('TEXT')) {
			var_name = var_attrs.array_get(rt.new_string('TEXT'))
		}
		if var_attrs.array_isset(rt.new_string('TITLE')) {
			var_name = var_attrs.array_get(rt.new_string('TITLE'))
		}
		var_url = rt.new_string('')
		if var_attrs.array_isset(rt.new_string('URL')) {
			var_url = var_attrs.array_get(rt.new_string('URL'))
		}
		if var_attrs.array_isset(rt.new_string('HTMLURL')) {
			var_url = var_attrs.array_get(rt.new_string('HTMLURL'))
		}
		var_names << var_name.clone()
		var_urls << var_url.clone()
		var_targets << if !(var_attrs.array_get(rt.new_string('TARGET'))).is_null() {
			var_attrs.array_get(rt.new_string('TARGET'))
		} else {
			rt.new_string('')
		}
		var_feeds << if !(var_attrs.array_get(rt.new_string('XMLURL'))).is_null() {
			var_attrs.array_get(rt.new_string('XMLURL'))
		} else {
			rt.new_string('')
		}
		var_descriptions << if !(var_attrs.array_get(rt.new_string('DESCRIPTION'))).is_null() {
			var_attrs.array_get(rt.new_string('DESCRIPTION'))
		} else {
			rt.new_string('')
		}
	}
}

fn endelement(var_parser rt.PhpVal, var_tag_name rt.PhpVal) {
}

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_opml := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		exit(0)
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('xml_parser_create'),
	])))))
	{
		rt.call_function('wp_trigger_error', [rt.new_string(''),
			rt.call_function('__', [
				rt.new_string("PHP's XML extension is not available. Please contact your hosting provider to enable PHP's XML extension."),
			])])
		rt.call_function('wp_die', [
			rt.call_function('__', [
				rt.new_string("PHP's XML extension is not available. Please contact your hosting provider to enable PHP's XML extension."),
			]),
		])
	}
	mut var_xml_parser := rt.call_function('xml_parser_create', []rt.PhpVal{})
	rt.call_function('xml_set_element_handler', [var_xml_parser.clone(),
		rt.new_string('startElement'), rt.new_string('endElement')])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('xml_parse', [
		var_xml_parser.clone(), var_opml.clone(), rt.new_bool(true)])))))
	{
		rt.call_function('printf', [
			rt.call_function('__', [rt.new_string('XML Error: %1$s at line %2$s')]),
			rt.call_function('xml_error_string', [
				rt.call_function('xml_get_error_code', [var_xml_parser.clone()]),
			]),
			rt.call_function('xml_get_current_line_number', [
				var_xml_parser.clone(),
			]),
		])
	}
	if rt.is_true(rt.less(rt.get_constant('PHP_VERSION_ID'), rt.new_int(80000))) {
		rt.call_function('xml_parser_free', [var_xml_parser.clone()])
	}
	var_xml_parser = rt.new_null()
}
