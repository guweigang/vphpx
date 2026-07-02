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
	if rt.is_true(rt.identical(rt.new_bool(false), var_options_mutated)) || rt.is_true(rt.identical(rt.new_bool(true), var_options_mutated)) {
	var_options_mutated = rt.create_array([rt.ArrayItem{ key: 'ignore_errors', val: var_options_mutated }])
	}
	var_options_mutated = rt.call_function('array_merge', [Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_Html2Text.default_options(), var_options_mutated.clone()])
	mut iter_1 := rt.func_array_keys(var_options_mutated.clone()).iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_key := item_1.val
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_key.clone(), rt.func_array_keys(Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_Html2Text.default_options()), rt.new_bool(true)]))))) {
			rt.call_function('error_log', [rt.new_string('Html2Text: Invalid option provided: ' + (rt.call_function('htmlspecialchars', [rt.new_string((var_key).str()), rt.get_constant('ENT_QUOTES'), rt.new_string('UTF-8')])).str() + '. Valid options are: ' + (rt.call_function('htmlspecialchars', [rt.call_function('implode', [rt.new_string(','), rt.func_array_keys(Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_Html2Text.default_options())]), rt.get_constant('ENT_QUOTES'), rt.new_string('UTF-8')])).str())])
			rt.throw_exception(rt.new_object('Automattic_WooCommerce_EmailEditor_Engine_Renderer_InvalidArgumentException', []string{}, create_automattic_woocommerce_emaileditor_engine_renderer_invalidargumentexception(rt.new_string('Invalid option provided for html2text conversion.'))))
		}
	}
	mut var_is_office_document := Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_Html2Text.is_office_document(html_mutated)
	if rt.is_true(var_is_office_document) {
	html_mutated = (rt.call_function('str_replace', [rt.create_array([rt.ArrayItem{ key: none, val: '<o:p>' }, rt.ArrayItem{ key: none, val: '</o:p>' }]), rt.new_string(''), rt.new_string(html_mutated).clone()])).str()
	}
	html_mutated = (Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_Html2Text.fix_newlines(html_mutated)).str()
	if rt.is_true(rt.less(rt.add(rt.mul(rt.get_constant('PHP_MAJOR_VERSION'), rt.new_int(10)), rt.get_constant('PHP_MINOR_VERSION')), rt.new_int(81))) && rt.is_true(rt.call_function('mb_detect_encoding', [rt.new_string(html_mutated).clone(), rt.new_string('UTF-8'), rt.new_bool(true)])) {
	mut var_converted := rt.call_function('mb_convert_encoding', [rt.new_string(html_mutated).clone(), rt.new_string('HTML-ENTITIES'), rt.new_string('UTF-8')])
	html_mutated = (if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_converted)))) { var_converted } else { rt.new_string(html_mutated) }).str()
	}
	if !(rt.new_string(html_mutated).clone().is_string()) {
	html_mutated = html_mutated
	}
	mut var_doc := Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_Html2Text.get_document(html_mutated, mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_array](var_options_mutated))
	mut var_output := Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_Html2Text.iterate_over_node(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_DOMNode](var_doc), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_?string](rt.new_null()), false, (var_is_office_document).to_bool(), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_array](var_options_mutated))
	var_output = Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_Html2Text.process_whitespace_newlines((var_output).str())
	return (var_output).str()
}

fn Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_Html2Text.fix_newlines(text string) string {
	mut text_mutated := text
	text_mutated = (rt.call_function('str_replace', [rt.new_string('\r\n'), rt.new_string('\n'), rt.new_string(text_mutated).clone()])).str()
	text_mutated = (rt.call_function('str_replace', [rt.new_string('\r'), rt.new_string('\n'), rt.new_string(text_mutated).clone()])).str()
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
	mut var_result := rt.call_function('preg_replace', [rt.new_string('/ *\\t */im'), rt.new_string('\t'), rt.new_string(text_mutated).clone()])
	text_mutated = (if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_result)))) { var_result } else { rt.new_string(text_mutated) }).str()
	text_mutated = text_mutated.trim_left(' \t\n\r')
	var_result = rt.call_function('preg_replace', [rt.new_string('/\n[ \t]*/im'), rt.new_string('\n'), rt.new_string(text_mutated).clone()])
	text_mutated = (if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_result)))) { var_result } else { rt.new_string(text_mutated) }).str()
	text_mutated = (Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_Html2Text.render_text(text_mutated)).str()
	text_mutated = text_mutated.trim_right(' \t\n\r')
	var_result = rt.call_function('preg_replace', [rt.new_string('/[ \t]*\n/im'), rt.new_string('\n'), rt.new_string(text_mutated).clone()])
	text_mutated = (if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_result)))) { var_result } else { rt.new_string(text_mutated) }).str()
	text_mutated = (Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_Html2Text.fix_newlines(text_mutated)).str()
	var_result = rt.call_function('preg_replace', [rt.new_string('/\n\n\n*/im'), rt.new_string('\n\n'), rt.new_string(text_mutated).clone()])
	return (if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_result)))) { var_result } else { rt.new_string(text_mutated) }).str()
}

fn Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_Html2Text.is_office_document(html string) bool {
	mut html_mutated := html
	return rt.new_bool(!rt.is_true(rt.identical(rt.call_function('strpos', [rt.new_string(html_mutated).clone(), rt.new_string('urn:schemas-microsoft-com:office')]), rt.new_bool(false))))
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
		return var_doc.clone()
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('<'), rt.new_string(html_mutated).array_get(rt.new_int(0)))))) {
	html_mutated = '<body>' + html_mutated + '</body>'
	}
	mut var_header := rt.new_string('')
	if rt.is_true(rt.greater_equal(rt.add(rt.mul(rt.get_constant('PHP_MAJOR_VERSION'), rt.new_int(10)), rt.get_constant('PHP_MINOR_VERSION')), rt.new_int(81))) {
		mut var_char_set := if !(!rt.is_true(var_options_mutated.array_get(rt.new_string('char_set')))) && var_options_mutated.array_get(rt.new_string('char_set')).is_string() { var_options_mutated.array_get(rt.new_string('char_set')) } else { rt.new_string('auto') }
		if rt.is_true(rt.identical(rt.new_string('auto'), var_char_set)) {
		mut var_detected := rt.call_function('mb_detect_encoding', [rt.new_string(html_mutated).clone()])
		var_char_set = if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_detected)))) { var_detected } else { rt.new_string('UTF-8') }
		} else if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('strpos', [var_char_set.clone(), rt.new_string(',')]), rt.new_bool(false))))) {
			mut var_encoding_list := rt.call_function('explode', [rt.new_string(','), var_char_set.clone()])
			var_encoding_list = rt.call_function('array_map', [rt.new_string('trim'), var_encoding_list.clone()])
			closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
				mut var_encoding := if args.len > 0 { args[0].clone() } else { rt.new_null() }
				return rt.new_bool(!(!rt.is_true(var_encoding)))
				}
			var_encoding_list = rt.call_function('array_filter', [var_encoding_list.clone(), rt.new_closure(closure_1_fn)])
			if !(!rt.is_true(var_encoding_list)) {
				var_encoding_list = rt.call_function('array_values', [var_encoding_list.clone()])
				rt.call_function('mb_detect_order', [var_encoding_list.clone()])
			var_detected = rt.call_function('mb_detect_encoding', [rt.new_string(html_mutated).clone()])
			var_char_set = if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_detected)))) { var_detected } else { rt.new_string('UTF-8') }
			}
		}
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('strpos', [var_char_set.clone(), rt.new_string('1252')]), rt.new_bool(false))))) {
			var_options_mutated.array_set('ignore_errors', true)
		}
	var_header = rt.new_string('<?xml version="1.0" encoding="' + (var_char_set).str() + '">')
	}
	if !(!rt.is_true(var_options_mutated.array_get(rt.new_string('ignore_errors')))) {
		rt.set_property(var_doc, 'strictErrorChecking', rt.new_bool(false))
		rt.set_property(var_doc, 'recover', rt.new_bool(true))
		rt.set_property(var_doc, 'xmlStandalone', rt.new_bool(true))
		mut var_old_internal_errors := rt.call_function('libxml_use_internal_errors', [rt.new_bool(true)])
		mut var_load_result := rt.call_method(var_doc, 'loadHTML', [rt.new_string((var_header).str() + html_mutated), rt.bitwise_or(rt.bitwise_or(rt.bitwise_or(rt.get_constant('LIBXML_NOWARNING'), rt.get_constant('LIBXML_NOERROR')), rt.get_constant('LIBXML_NONET')), rt.get_constant('LIBXML_PARSEHUGE'))])
		rt.call_function('libxml_use_internal_errors', [var_old_internal_errors.clone()])
	} else {
	var_load_result = rt.call_method(var_doc, 'loadHTML', [rt.new_string((var_header).str() + html_mutated)])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_load_result)))) {
		mut var_html_preview := rt.new_string((if html_mutated.len > 500 { (rt.call_function('substr', [rt.new_string(html_mutated).clone(), rt.new_int(0), rt.new_int(500)])).str() + '...[truncated]' } else { html_mutated }).str())
		rt.call_function('error_log', [rt.new_string('Html2Text: Failed to load HTML content: ' + (rt.call_function('htmlspecialchars', [var_html_preview.clone(), rt.get_constant('ENT_QUOTES'), rt.new_string('UTF-8')])).str())])
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_EmailEditor_Engine_Renderer_Html2Text_Exception', []string{}, create_automattic_woocommerce_emaileditor_engine_renderer_html2text_exception(rt.new_string('Could not load HTML - the content may be malformed.'))))
	}
	return var_doc.clone()
}

fn Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_Html2Text.render_text(text string) string {
	mut text_mutated := text
	text_mutated = (rt.call_function('str_replace', [Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_Html2Text.nbsp_codes(), rt.new_string(' '), rt.new_string(text_mutated).clone()])).str()
	text_mutated = (rt.call_function('str_replace', [Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_Html2Text.zwnj_codes(), rt.new_string(''), rt.new_string(text_mutated).clone()])).str()
	return text_mutated
}

fn Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_Html2Text.next_child_name(mut var_node Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_?DOMNode) string {
	if rt.is_true(rt.identical(rt.new_null(), var_node)) || rt.is_true(rt.identical(rt.new_null(), rt.get_property(var_node, 'nextSibling'))) {
		return (rt.new_null()).str()
	}
	mut var_next_node := rt.get_property(var_node, 'nextSibling')
	for rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_next_node)))) {
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
	if rt.is_true(rt.new_bool(rt.instance_of(var_next_node, 'Automattic_WooCommerce_EmailEditor_Engine_Renderer_DOMElement'))) || rt.is_true(rt.new_bool(rt.instance_of(var_next_node, 'Automattic_WooCommerce_EmailEditor_Engine_Renderer_DOMText'))) {
	var_next_name = rt.new_string(rt.get_property(var_next_node, 'nodeName').to_string().to_lower())
	}
	return (var_next_name).str()
}

fn Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_Html2Text.iterate_over_node(mut var_node Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_DOMNode, mut var_prev_name Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_?string, in_pre bool, is_office_document bool, mut var_options Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_array) string {
	mut is_office_document_mutated := is_office_document
	mut var_options_mutated := var_options
	if rt.is_true(rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_EmailEditor_Engine_Renderer_DOMNode', []string{}, var_node), 'Automattic_WooCommerce_EmailEditor_Engine_Renderer_DOMText'))) {
		if var_in_pre {
			mut var_text := rt.new_string('\n' + Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_Html2Text.render_text((rt.get_property(var_node, 'wholeText')).str()).to_string().trim_space() + '\n')
			mut var_result := rt.call_function('preg_replace', [rt.new_string('/[ \t]*\n/im'), rt.new_string('\n'), var_text.clone()])
			var_text = if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_result)))) { var_result } else { var_text }
			return (rt.call_function('str_replace', [rt.new_string('\n'), rt.new_string('\r'), var_text.clone()])).str()
		}
		var_text = Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_Html2Text.render_text((rt.get_property(var_node, 'wholeText')).str())
		var_result = rt.call_function('preg_replace', [rt.new_string('/[\\t\\n\\f\\r ]+/im'), rt.new_string(' '), var_text.clone()])
		var_text = if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_result)))) { var_result } else { var_text }
		if rt.is_true(rt.new_bool(!(rt.is_true(Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_Html2Text.is_whitespace((var_text).str()))))) && rt.is_true(rt.identical(rt.new_string('p'), var_prev_name)) || rt.is_true(rt.identical(rt.new_string('div'), var_prev_name)) {
			return '\n' + (var_text).str()
		}
		return (var_text).str()
	}
	if rt.is_true(rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_EmailEditor_Engine_Renderer_DOMNode', []string{}, var_node), 'Automattic_WooCommerce_EmailEditor_Engine_Renderer_DOMDocumentType'))) || rt.is_true(rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_EmailEditor_Engine_Renderer_DOMNode', []string{}, var_node), 'Automattic_WooCommerce_EmailEditor_Engine_Renderer_DOMProcessingInstruction'))) {
		return ''
	}
	mut var_name := rt.new_string(rt.get_property(var_node, 'nodeName').to_string().to_lower())
	mut var_next_name := Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_Html2Text.next_child_name(mut var_node)
	mut switch_val_1 := var_name
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('hr'))) {
		mut var_prefix := rt.new_string('')
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_prev_name)))) {
		var_prefix = rt.new_string('\n')
		}
		return (var_prefix).str() + '---------------------------------------------------------------\n'
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('style'))) || rt.is_true(rt.equal(switch_val_1, rt.new_string('head'))) || rt.is_true(rt.equal(switch_val_1, rt.new_string('title'))) || rt.is_true(rt.equal(switch_val_1, rt.new_string('meta'))) || rt.is_true(rt.equal(switch_val_1, rt.new_string('script'))) {
		return ''
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('h1'))) || rt.is_true(rt.equal(switch_val_1, rt.new_string('h2'))) || rt.is_true(rt.equal(switch_val_1, rt.new_string('h3'))) || rt.is_true(rt.equal(switch_val_1, rt.new_string('h4'))) || rt.is_true(rt.equal(switch_val_1, rt.new_string('h5'))) || rt.is_true(rt.equal(switch_val_1, rt.new_string('h6'))) || rt.is_true(rt.equal(switch_val_1, rt.new_string('ol'))) || rt.is_true(rt.equal(switch_val_1, rt.new_string('ul'))) || rt.is_true(rt.equal(switch_val_1, rt.new_string('pre'))) {
	mut var_output := rt.new_string('\n\n')
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('td'))) || rt.is_true(rt.equal(switch_val_1, rt.new_string('th'))) {
	var_output = rt.new_string('\t')
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('p'))) {
		if rt.is_true(rt.new_bool(is_office_document_mutated)) && rt.is_true(rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_EmailEditor_Engine_Renderer_DOMNode', []string{}, var_node), 'Automattic_WooCommerce_EmailEditor_Engine_Renderer_DOMElement'))) && rt.is_true(rt.identical(rt.new_string('MsoNormal'), var_node.getattribute(rt.new_string('class')))) {
		var_output = rt.new_string('')
		var_name = rt.new_string('br')
		}
	var_output = rt.new_string('\n\n')
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('tr'))) {
	var_output = rt.new_string('\n')
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('div'))) {
		var_output = rt.new_string('')
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_prev_name)))) {
			var_output = rt.concat(var_output, rt.new_string('\n'))
		}
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('li'))) {
	var_output = rt.new_string('- ')
	} else {
	var_output = rt.new_string('')
	}
	if rt.is_true(rt.greater(rt.get_property(rt.get_property(var_node, 'childNodes'), 'length'), rt.new_int(0))) {
		mut var_n := rt.call_method(rt.get_property(var_node, 'childNodes'), 'item', [rt.new_int(0)])
		mut var_previous_sibling_names := rt.new_array()
		mut var_previous_sibling_name := rt.new_null()
		mut var_parts := rt.new_array()
		mut var_trailing_whitespace := rt.new_int(0)
		for rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_n)))) {
			var_text = Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_Html2Text.iterate_over_node(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_DOMNode](var_n), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_?string](var_previous_sibling_name), var_in_pre || rt.is_true(rt.identical(rt.new_string('pre'), var_name)), is_office_document_mutated, mut var_options_mutated)
			if rt.is_true(rt.new_bool(rt.instance_of(var_n, 'Automattic_WooCommerce_EmailEditor_Engine_Renderer_DOMDocumentType'))) || rt.is_true(rt.new_bool(rt.instance_of(var_n, 'Automattic_WooCommerce_EmailEditor_Engine_Renderer_DOMProcessingInstruction'))) || (rt.is_true(rt.new_bool(rt.instance_of(var_n, 'Automattic_WooCommerce_EmailEditor_Engine_Renderer_DOMText'))) && rt.is_true(Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_Html2Text.is_whitespace((var_text).str()))) {
				rt.pre_inc(var_trailing_whitespace)
			} else {
				var_previous_sibling_name = rt.new_string(rt.get_property(var_n, 'nodeName').to_string().to_lower())
				var_previous_sibling_names.array_push(var_previous_sibling_name.clone())
			var_trailing_whitespace = rt.new_int(0)
			}
			var_node.removechild(var_n.clone())
			var_n = rt.call_method(rt.get_property(var_node, 'childNodes'), 'item', [rt.new_int(0)])
			var_parts.array_push(var_text.clone())
		}
		for rt.is_true(rt.greater(rt.post_dec(var_trailing_whitespace), rt.new_int(0))) {
			rt.call_function('array_pop', [var_parts.clone()])
		}
		mut var_last_name := rt.call_function('array_pop', [var_previous_sibling_names.clone()])
		if rt.is_true(rt.identical(rt.new_string('br'), var_last_name)) {
			var_last_name = rt.call_function('array_pop', [var_previous_sibling_names.clone()])
			if rt.is_true(rt.identical(rt.new_string('#text'), var_last_name)) {
				rt.call_function('array_pop', [var_parts.clone()])
			}
		}
		var_output = rt.concat(var_output, rt.call_function('implode', [rt.new_string(''), var_parts.clone()]))
	}
	mut switch_val_2 := var_name
	if rt.is_true(rt.equal(switch_val_2, rt.new_string('h1'))) || rt.is_true(rt.equal(switch_val_2, rt.new_string('h2'))) || rt.is_true(rt.equal(switch_val_2, rt.new_string('h3'))) || rt.is_true(rt.equal(switch_val_2, rt.new_string('h4'))) || rt.is_true(rt.equal(switch_val_2, rt.new_string('h5'))) || rt.is_true(rt.equal(switch_val_2, rt.new_string('h6'))) || rt.is_true(rt.equal(switch_val_2, rt.new_string('pre'))) || rt.is_true(rt.equal(switch_val_2, rt.new_string('p'))) {
		var_output = rt.concat(var_output, rt.new_string('\n\n'))
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('br'))) {
		var_output = rt.concat(var_output, rt.new_string('\n'))
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('div'))) {
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('a'))) {
		mut var_href := if rt.is_true(rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_EmailEditor_Engine_Renderer_DOMNode', []string{}, var_node), 'Automattic_WooCommerce_EmailEditor_Engine_Renderer_DOMElement'))) { var_node.getattribute(rt.new_string('href')) } else { rt.new_string('') }
		var_output = rt.new_string(var_output.clone().to_string().trim_space())
		if rt.is_true(rt.identical(rt.new_string('['), rt.call_function('substr', [var_output.clone(), rt.new_int(0), rt.new_int(1)]))) && rt.is_true(rt.identical(rt.new_string(']'), rt.call_function('substr', [var_output.clone(), rt.new_int(-1)]))) {
			var_output = rt.call_function('substr', [var_output.clone(), rt.new_int(1), rt.new_int(var_output.clone().to_string().len - 2)])
			if rt.is_true(rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_EmailEditor_Engine_Renderer_DOMNode', []string{}, var_node), 'Automattic_WooCommerce_EmailEditor_Engine_Renderer_DOMElement'))) && rt.is_true(var_node.getattribute(rt.new_string('title'))) {
			var_output = var_node.getattribute(rt.new_string('title'))
			}
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(var_output)))) && rt.is_true(rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_EmailEditor_Engine_Renderer_DOMNode', []string{}, var_node), 'Automattic_WooCommerce_EmailEditor_Engine_Renderer_DOMElement'))) && rt.is_true(var_node.getattribute(rt.new_string('title'))) {
		var_output = var_node.getattribute(rt.new_string('title'))
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(var_href)))) {
			if rt.is_true(rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_EmailEditor_Engine_Renderer_DOMNode', []string{}, var_node), 'Automattic_WooCommerce_EmailEditor_Engine_Renderer_DOMElement'))) && rt.is_true(var_node.getattribute(rt.new_string('name'))) {
				if rt.is_true(var_options_mutated.array_get(rt.new_string('drop_links'))) {
				var_output = rt.new_string("${var_output.to_string()}")
				} else {
				var_output = rt.new_string("[${var_output.to_string()}]")
				}
			}
		} else if rt.is_true(rt.identical(var_href, var_output)) || rt.is_true(rt.identical(rt.new_string("mailto:${var_output.to_string()}"), var_href)) || rt.is_true(rt.identical(rt.new_string("http://${var_output.to_string()}"), var_href)) || rt.is_true(rt.identical(rt.new_string("https://${var_output.to_string()}"), var_href)) {
		var_output = rt.new_string("${var_output.to_string()}")
		} else if rt.is_true(var_output) {
			if rt.is_true(var_options_mutated.array_get(rt.new_string('drop_links'))) {
			var_output = rt.new_string("${var_output.to_string()}")
			} else {
			var_output = rt.new_string("[${var_output.to_string()}](${var_href.to_string()})")
			}
		} else {
		var_output = rt.new_string("${var_href.to_string()}")
		}
		mut switch_val_3 := var_next_name
		if rt.is_true(rt.equal(switch_val_3, rt.new_string('h1'))) || rt.is_true(rt.equal(switch_val_3, rt.new_string('h2'))) || rt.is_true(rt.equal(switch_val_3, rt.new_string('h3'))) || rt.is_true(rt.equal(switch_val_3, rt.new_string('h4'))) || rt.is_true(rt.equal(switch_val_3, rt.new_string('h5'))) || rt.is_true(rt.equal(switch_val_3, rt.new_string('h6'))) {
			var_output = rt.concat(var_output, rt.new_string('\n'))
		}
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('img'))) {
		if rt.is_true(rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_EmailEditor_Engine_Renderer_DOMNode', []string{}, var_node), 'Automattic_WooCommerce_EmailEditor_Engine_Renderer_DOMElement'))) && rt.is_true(var_node.getattribute(rt.new_string('title'))) {
		var_output = rt.new_string('[' + (var_node.getattribute(rt.new_string('title'))).str() + ']')
		} else if rt.is_true(rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_EmailEditor_Engine_Renderer_DOMNode', []string{}, var_node), 'Automattic_WooCommerce_EmailEditor_Engine_Renderer_DOMElement'))) && rt.is_true(var_node.getattribute(rt.new_string('alt'))) {
		var_output = rt.new_string('[' + (var_node.getattribute(rt.new_string('alt'))).str() + ']')
		} else {
		var_output = rt.new_string('')
		}
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('li'))) {
		var_output = rt.concat(var_output, rt.new_string('\n'))
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('blockquote'))) {
	var_output = Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_Html2Text.process_whitespace_newlines((var_output).str())
	var_output = rt.new_string('\n' + (var_output).str())
	var_result = rt.call_function('preg_replace', [rt.new_string('/\n/im'), rt.new_string('\n> '), var_output.clone()])
	var_output = if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_result)))) { var_result } else { var_output }
	var_result = rt.call_function('preg_replace', [rt.new_string('/\n> >/im'), rt.new_string('\n>>'), var_output.clone()])
	var_output = if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_result)))) { var_result } else { var_output }
	var_output = rt.new_string('\n' + (var_output).str() + '\n\n')
	} else {
	}
	return (var_output).str()
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

fn create_automattic_woocommerce_emaileditor_engine_renderer_html2text(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_Html2Text {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_Html2Text{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditor_engine_renderer_invalidargumentexception(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_InvalidArgumentException {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_InvalidArgumentException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditor_engine_renderer_domdocument(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_DOMDocument {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_DOMDocument{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditor_engine_renderer_html2text_exception(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_Html2Text_Exception {
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



fn main() {
	defer {
		rt.shutdown()
	}

}
