import rt

struct Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_Html2Text {
	rt.PhpObjectBase
}

fn Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_Html2Text.default_options() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'ignore_errors', val: false }, rt.ArrayItem{ key: 'drop_links', val: false }, rt.ArrayItem{ key: 'char_set', val: 'auto' }])
}

fn Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_Html2Text.convert(html string, var_options rt.PhpVal) string {
	mut html_mutated := html
	mut var_options_mutated := var_options
	if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_bool(false), var_options_mutated)) || rt.is_true(rt.identical(rt.new_bool(true), var_options_mutated)))) {
		var_options_mutated = rt.create_array([rt.ArrayItem{ key: 'ignore_errors', val: var_options_mutated }])
	}
	var_options_mutated = rt.call_function('array_merge', [Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_Html2Text.default_options(), var_options_mutated.dup()])
	{
		mut iter_1 := rt.func_array_keys(var_options_mutated.dup()).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_key := item_1.val
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_key.dup(), rt.func_array_keys(Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_Html2Text.default_options()), rt.new_bool(true)]))))) {
				rt.call_function('error_log', ['Html2Text: Invalid option provided: ' + (rt.call_function('htmlspecialchars', [// unsupported expression: Expr_Cast_String, rt.get_constant('ENT_QUOTES'), rt.new_string('UTF-8')])).str() + '. Valid options are: ' + (rt.call_function('htmlspecialchars', [rt.call_function('implode', [rt.new_string(','), rt.func_array_keys(Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_Html2Text.default_options())]), rt.get_constant('ENT_QUOTES'), rt.new_string('UTF-8')])).str()])
				rt.throw_exception(rt.new_object('Automattic_WooCommerce_EmailEditor_Engine_Renderer_InvalidArgumentException', []string{}, create_automattic_woocommerce_emaileditor_engine_renderer_invalidargumentexception(rt.new_string('Invalid option provided for html2text conversion.'))))
			}
		}
	}
	mut var_is_office_document := Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_Html2Text.is_office_document(html_mutated)
	if rt.is_true(var_is_office_document) {
		html_mutated = (rt.call_function('str_replace', [rt.create_array([rt.ArrayItem{ key: none, val: '<o:p>' }, rt.ArrayItem{ key: none, val: '</o:p>' }]), rt.new_string(''), rt.new_string(html_mutated).dup()])).str()
	}
	html_mutated = (Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_Html2Text.fix_newlines(html_mutated)).str()
	if rt.is_true(rt.new_bool(rt.is_true(rt.less(rt.add(rt.mul(rt.get_constant('PHP_MAJOR_VERSION'), rt.new_int(10)), rt.get_constant('PHP_MINOR_VERSION')), rt.new_int(81))) && rt.is_true(rt.call_function('mb_detect_encoding', [rt.new_string(html_mutated).dup(), rt.new_string('UTF-8'), rt.new_bool(true)])))) {
		mut var_converted := rt.call_function('mb_convert_encoding', [rt.new_string(html_mutated).dup(), rt.new_string('HTML-ENTITIES'), rt.new_string('UTF-8')])
		html_mutated = (if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) { var_converted } else { rt.new_string(html_mutated) }).str()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.new_string(html_mutated).dup().is_string()))))) {
		html_mutated = (// unsupported expression: Expr_Cast_String).str()
	}
	mut var_doc := Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_Html2Text.get_document(html_mutated, mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_array](var_options_mutated))
	mut var_output := Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_Html2Text.iterate_over_node(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_DOMNode](var_doc), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_?string](rt.new_null()), false, (var_is_office_document).to_bool(), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_array](var_options_mutated))
	var_output = Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_Html2Text.process_whitespace_newlines((var_output).str())
	return (var_output).str()
}

fn Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_Html2Text.fix_newlines(text string) string {
	mut text_mutated := text
	text_mutated = (rt.call_function('str_replace', [rt.new_string('\r\n'), rt.new_string('\n'), rt.new_string(text_mutated).dup()])).str()
	text_mutated = (rt.call_function('str_replace', [rt.new_string('\r'), rt.new_string('\n'), rt.new_string(text_mutated).dup()])).str()
	return text_mutated
}

fn Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_Html2Text.nbsp_codes() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: none, val: ' ' }, rt.ArrayItem{ key: none, val: '\\u00a0' }])
}

fn Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_Html2Text.zwnj_codes() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: none, val: '‌' }, rt.ArrayItem{ key: none, val: '\\u200c' }])
}

fn Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_Html2Text.process_whitespace_newlines(text string) string {
	mut text_mutated := text
	mut var_result := rt.call_function('preg_replace', [rt.new_string('/ *\\t */im'), rt.new_string('\t'), rt.new_string(text_mutated).dup()])
	text_mutated = (if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) { var_result } else { rt.new_string(text_mutated) }).str()
	text_mutated = text_mutated.trim_left(' \t\n\r')
	var_result = rt.call_function('preg_replace', [rt.new_string('/\n[ \t]*/im'), rt.new_string('\n'), rt.new_string(text_mutated).dup()])
	text_mutated = (if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) { var_result } else { rt.new_string(text_mutated) }).str()
	text_mutated = (Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_Html2Text.render_text(text_mutated)).str()
	text_mutated = text_mutated.trim_right(' \t\n\r')
	var_result = rt.call_function('preg_replace', [rt.new_string('/[ \t]*\n/im'), rt.new_string('\n'), rt.new_string(text_mutated).dup()])
	text_mutated = (if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) { var_result } else { rt.new_string(text_mutated) }).str()
	text_mutated = (Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_Html2Text.fix_newlines(text_mutated)).str()
	var_result = rt.call_function('preg_replace', [rt.new_string('/\n\n\n*/im'), rt.new_string('\n\n'), rt.new_string(text_mutated).dup()])
	return (if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) { var_result } else { rt.new_string(text_mutated) }).str()
}

fn Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_Html2Text.is_office_document(html string) bool {
	mut html_mutated := html
	return (// unsupported expression: Expr_BinaryOp_NotIdentical).to_bool()
}

fn Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_Html2Text.is_whitespace(text string) bool {
	mut text_mutated := text
	return rt.new_bool(0 == Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_Html2Text.render_text(text_mutated).to_string().trim_space().len)
}

fn Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_Html2Text.get_document(html string, mut var_options Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_array) rt.PhpVal {
	mut html_mutated := html
	mut var_options_mutated := var_options
	mut var_doc := create_automattic_woocommerce_emaileditor_engine_renderer_domdocument()
	html_mutated = html_mutated.trim_space()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_string(html_mutated))))) {
		return var_doc.dup()
	}
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		html_mutated = '<body>' + html_mutated + '</body>'
	}
	mut var_header := rt.new_string(rt.new_string(''))
	if rt.is_true(rt.greater_equal(rt.add(rt.mul(rt.get_constant('PHP_MAJOR_VERSION'), rt.new_int(10)), rt.get_constant('PHP_MINOR_VERSION')), rt.new_int(81))) {
		mut var_char_set := if rt.is_true(rt.new_bool(!(!rt.is_true(var_options_mutated.array_get('char_set'))) && rt.is_true(rt.new_bool(var_options_mutated.array_get('char_set').is_string())))) { var_options_mutated.array_get('char_set') } else { rt.new_string('auto') }
		if rt.is_true(rt.identical(rt.new_string('auto'), var_char_set)) {
			mut var_detected := rt.call_function('mb_detect_encoding', [rt.new_string(html_mutated).dup()])
			var_char_set = if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) { var_detected } else { rt.new_string('UTF-8') }
		} else if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
			mut var_encoding_list := rt.call_function('explode', [rt.new_string(','), var_char_set.dup()])
			var_encoding_list = rt.call_function('array_map', [rt.new_string('trim'), var_encoding_list.dup()])
			closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_encoding := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return rt.new_bool(!(!rt.is_true(var_encoding)))
	}
			var_encoding_list = rt.call_function('array_filter', [var_encoding_list.dup(), rt.new_closure(closure_1_fn)])
			if !(!rt.is_true(var_encoding_list)) {
				var_encoding_list = rt.call_function('array_values', [var_encoding_list.dup()])
				rt.call_function('mb_detect_order', [var_encoding_list.dup()])
				var_detected = rt.call_function('mb_detect_encoding', [rt.new_string(html_mutated).dup()])
				var_char_set = if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) { var_detected } else { rt.new_string('UTF-8') }
			}
		}
		if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
			var_options_mutated.array_set('ignore_errors', true)
		}
		var_header = rt.new_string('<?xml version="1.0" encoding="' + (var_char_set).str() + '">')
	}
	if !(!rt.is_true(var_options_mutated.array_get('ignore_errors'))) {
		rt.set_property(var_doc, 'strictErrorChecking', rt.new_bool(false))
		rt.set_property(var_doc, 'recover', rt.new_bool(true))
		rt.set_property(var_doc, 'xmlStandalone', rt.new_bool(true))
		mut var_old_internal_errors := rt.call_function('libxml_use_internal_errors', [rt.new_bool(true)])
		mut var_load_result := rt.call_method(var_doc, 'loadHTML', [(var_header).str() + html_mutated, rt.bitwise_or(rt.bitwise_or(rt.bitwise_or(rt.get_constant('LIBXML_NOWARNING'), rt.get_constant('LIBXML_NOERROR')), rt.get_constant('LIBXML_NONET')), rt.get_constant('LIBXML_PARSEHUGE'))])
		rt.call_function('libxml_use_internal_errors', [var_old_internal_errors.dup()])
	} else {
		var_load_result = rt.call_method(var_doc, 'loadHTML', [(var_header).str() + html_mutated])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_load_result)))) {
		mut var_html_preview := rt.new_string(if html_mutated.len > 500 { (rt.call_function('substr', [rt.new_string(html_mutated).dup(), rt.new_int(0), rt.new_int(500)])).str() + '...[truncated]' } else { rt.new_string(html_mutated) })
		rt.call_function('error_log', ['Html2Text: Failed to load HTML content: ' + (rt.call_function('htmlspecialchars', [var_html_preview.dup(), rt.get_constant('ENT_QUOTES'), rt.new_string('UTF-8')])).str()])
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_EmailEditor_Engine_Renderer_Html2Text_Exception', []string{}, create_automattic_woocommerce_emaileditor_engine_renderer_html2text_exception(rt.new_string('Could not load HTML - the content may be malformed.'))))
	}
	return var_doc.dup()
}

fn Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_Html2Text.render_text(text string) string {
	mut text_mutated := text
	text_mutated = (rt.call_function('str_replace', [Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_Html2Text.nbsp_codes(), rt.new_string(' '), rt.new_string(text_mutated).dup()])).str()
	text_mutated = (rt.call_function('str_replace', [Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_Html2Text.zwnj_codes(), rt.new_string(''), rt.new_string(text_mutated).dup()])).str()
	return text_mutated
}

fn Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_Html2Text.next_child_name(mut var_node Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_?DOMNode) string {
	if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_null(), var_node)) || rt.is_true(rt.identical(rt.new_null(), rt.get_property(var_node, 'nextSibling'))))) {
		return (rt.new_null()).str()
	}
	mut var_next_node := rt.get_property(var_node, 'nextSibling')
	for rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		if rt.is_true(rt.new_bool(rt.instance_of(var_next_node, 'Automattic_WooCommerce_EmailEditor_Engine_Renderer_DOMText'))) {
			if rt.is_true(rt.new_bool(!(rt.is_true(Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_Html2Text.is_whitespace((rt.get_property(var_next_node, 'wholeText')).str()))))) {
				break
			}
		}
		if rt.is_true(rt.new_bool(rt.instance_of(var_next_node, 'Automattic_WooCommerce_EmailEditor_Engine_Renderer_DOMElement'))) {
			break
		}
		var_next_node = rt.get_property(var_next_node, 'nextSibling')
	}
	mut var_next_name := rt.new_null()
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.instance_of(var_next_node, 'Automattic_WooCommerce_EmailEditor_Engine_Renderer_DOMElement'))) || rt.is_true(rt.new_bool(rt.instance_of(var_next_node, 'Automattic_WooCommerce_EmailEditor_Engine_Renderer_DOMText'))))) {
		var_next_name = rt.new_string(rt.new_string(rt.get_property(var_next_node, 'nodeName').to_string().to_lower()))
	}
	return (var_next_name).str()
}

fn Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_Html2Text.iterate_over_node(mut var_node Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_DOMNode, mut var_prev_name Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_?string, in_pre bool, is_office_document bool, mut var_options Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_array) string {
	mut is_office_document_mutated := is_office_document
	mut var_options_mutated := var_options
	if rt.is_true(rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_EmailEditor_Engine_Renderer_DOMNode', []string{}, var_node), 'Automattic_WooCommerce_EmailEditor_Engine_Renderer_DOMText'))) {
		if var_in_pre {
			mut var_text := rt.new_string('\n' + Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_Html2Text.render_text((rt.get_property(var_node, 'wholeText')).str()).to_string().trim_space() + '\n')
			mut var_result := rt.call_function('preg_replace', [rt.new_string('/[ \t]*\n/im'), rt.new_string('\n'), var_text.dup()])
			var_text = if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) { var_result } else { var_text }
			return (rt.call_function('str_replace', [rt.new_string('\n'), rt.new_string('\r'), var_text.dup()])).str()
		}
		var_text = Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_Html2Text.render_text((rt.get_property(var_node, 'wholeText')).str())
		var_result = rt.call_function('preg_replace', [rt.new_string('/[\\t\\n\\f\\r ]+/im'), rt.new_string(' '), var_text.dup()])
		var_text = if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) { var_result } else { var_text }
		if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_Html2Text.is_whitespace((var_text).str()))))) && rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('p'), var_prev_name)) || rt.is_true(rt.identical(rt.new_string('div'), var_prev_name)))))) {
			return '\n' + (var_text).str()
		}
		return (var_text).str()
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_EmailEditor_Engine_Renderer_DOMNode', []string{}, var_node), 'Automattic_WooCommerce_EmailEditor_Engine_Renderer_DOMDocumentType'))) || rt.is_true(rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_EmailEditor_Engine_Renderer_DOMNode', []string{}, var_node), 'Automattic_WooCommerce_EmailEditor_Engine_Renderer_DOMProcessingInstruction'))))) {
		return ''
	}
	mut var_name := rt.new_string(rt.new_string(rt.get_property(var_node, 'nodeName').to_string().to_lower()))
	mut var_next_name := Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_Html2Text.next_child_name(mut var_node)
	mut switch_val_1 := var_name
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('hr'))) {
		mut var_prefix := rt.new_string(rt.new_string(''))
		if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
			var_prefix = rt.new_string(rt.new_string('\n'))
		}
		return (var_prefix).str() + '---------------------------------------------------------------\n'
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('style'))) || rt.is_true(rt.equal(switch_val_1, rt.new_string('head'))) || rt.is_true(rt.equal(switch_val_1, rt.new_string('title'))) || rt.is_true(rt.equal(switch_val_1, rt.new_string('meta'))) || rt.is_true(rt.equal(switch_val_1, rt.new_string('script'))) {
		return ''
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('h1'))) || rt.is_true(rt.equal(switch_val_1, rt.new_string('h2'))) || rt.is_true(rt.equal(switch_val_1, rt.new_string('h3'))) || rt.is_true(rt.equal(switch_val_1, rt.new_string('h4'))) || rt.is_true(rt.equal(switch_val_1, rt.new_string('h5'))) || rt.is_true(rt.equal(switch_val_1, rt.new_string('h6'))) || rt.is_true(rt.equal(switch_val_1, rt.new_string('ol'))) || rt.is_true(rt.equal(switch_val_1, rt.new_string('ul'))) || rt.is_true(rt.equal(switch_val_1, rt.new_string('pre'))) {
		mut var_output := rt.new_string(rt.new_string('\n\n'))
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('td'))) || rt.is_true(rt.equal(switch_val_1, rt.new_string('th'))) {
		var_output = rt.new_string(rt.new_string('\t'))
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('p'))) {
		if rt.is_true(rt.new_bool(rt.is_true() && rt.is_true())) {
			
		}
		
	} else if rt.is_true(rt.equal(switch_val_1, )) {
	} else if rt.is_true(rt.equal(switch_val_1, )) {
	} else if rt.is_true(rt.equal(switch_val_1, )) {
	} else {
	}
}

struct Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_InvalidArgumentException {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_DOMDocument {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_Html2Text_Exception {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_emaileditor_engine_renderer_html2text() &Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_Html2Text {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_Html2Text{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditor_engine_renderer_invalidargumentexception() &Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_InvalidArgumentException {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_InvalidArgumentException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditor_engine_renderer_domdocument() &Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_DOMDocument {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_DOMDocument{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditor_engine_renderer_html2text_exception() &Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_Html2Text_Exception {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_Html2Text_Exception{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_Html2Text) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'default_options' {
			return Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_Html2Text.default_options()
		}
		'convert' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_string(Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_Html2Text.convert(dispatch_arg_0, dispatch_arg_1))
		}
		'fix_newlines' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_Html2Text.fix_newlines(dispatch_arg_0))
		}
		'nbsp_codes' {
			return Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_Html2Text.nbsp_codes()
		}
		'zwnj_codes' {
			return Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_Html2Text.zwnj_codes()
		}
		'process_whitespace_newlines' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_Html2Text.process_whitespace_newlines(dispatch_arg_0))
		}
		'is_office_document' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_Html2Text.is_office_document(dispatch_arg_0))
		}
		'is_whitespace' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_Html2Text.is_whitespace(dispatch_arg_0))
		}
		'get_document' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_array](if args.len > 1 { args[1] } else { rt.new_null() })
			return Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_Html2Text.get_document(dispatch_arg_0, mut dispatch_arg_1)
		}
		'render_text' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_Html2Text.render_text(dispatch_arg_0))
		}
		'next_child_name' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_?DOMNode](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_string(Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_Html2Text.next_child_name(mut dispatch_arg_0))
		}
		'iterate_over_node' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_DOMNode](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_?string](if args.len > 1 { args[1] } else { rt.new_null() })
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).to_bool()
			mut dispatch_arg_4 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_array](if args.len > 4 { args[4] } else { rt.new_null() })
			return rt.new_string(Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_Html2Text.iterate_over_node(mut dispatch_arg_0, mut dispatch_arg_1, dispatch_arg_2, dispatch_arg_3, mut dispatch_arg_4))
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_Html2Text) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_Html2Text) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_InvalidArgumentException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_InvalidArgumentException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_InvalidArgumentException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_DOMDocument) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_DOMDocument) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_DOMDocument) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_Html2Text_Exception) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_Html2Text_Exception) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_Html2Text_Exception) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_packages_email_editor_src_engine_renderer_class_html2text_php() {
	// unsupported statement: Stmt_Declare
}
