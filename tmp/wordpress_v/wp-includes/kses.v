import rt

fn wp_kses(var_content_arg rt.PhpVal, var_allowed_html rt.PhpVal, var_allowed_protocols_arg rt.PhpVal) rt.PhpVal {
	mut var_content := var_content_arg
	mut var_allowed_protocols := var_allowed_protocols_arg
	if !rt.is_true(var_allowed_protocols) {
		var_allowed_protocols = rt.call_function('wp_allowed_protocols', []rt.PhpVal{})
	}
	var_content = wp_kses_no_null(var_content.clone(), rt.create_array([
		rt.ArrayItem{ key: 'slash_zero', val: 'keep' },
	]))
	var_content = wp_kses_normalize_entities(var_content.clone(), '')
	var_content = wp_kses_hook(var_content.clone(), var_allowed_html.clone(),
		var_allowed_protocols.clone())
	return wp_kses_split(var_content.clone(), var_allowed_html.clone(),
		var_allowed_protocols.clone())
}

fn wp_kses_one_attr(var_attr_arg rt.PhpVal, var_element rt.PhpVal) string {
	mut var_attr := var_attr_arg
	mut var_uris := rt.new_null()
	mut var_allowed_html := rt.new_null()
	mut var_allowed_protocols := rt.new_null()
	mut var_matches := []rt.PhpVal{}
	mut var_lead := rt.new_null()
	mut var_trail := rt.new_null()
	mut var_split := rt.new_null()
	mut var_name := rt.new_null()
	mut var_value := rt.new_null()
	mut var_quote := rt.new_null()
	mut var_vless := ''
	var_uris = wp_kses_uri_attributes()
	var_allowed_html = wp_kses_allowed_html('post')
	var_allowed_protocols = rt.call_function('wp_allowed_protocols', []rt.PhpVal{})
	var_attr = wp_kses_no_null(var_attr.clone(), rt.create_array([
		rt.ArrayItem{ key: 'slash_zero', val: 'keep' },
	]))
	var_matches = rt.new_array()
	rt.call_function('preg_match', [rt.new_string('/^\\s*/'),
		var_attr.clone(), rt.create_array_from_list(var_matches)])
	var_lead = var_matches.array_get(0)
	rt.call_function('preg_match', [rt.new_string('/\\s*$/'),
		var_attr.clone(), rt.create_array_from_list(var_matches)])
	var_trail = var_matches.array_get(0)
	if !rt.is_true(var_trail) {
		var_attr = rt.call_function('substr', [var_attr.clone(),
			rt.new_int(var_lead.clone().to_string().len)])
	} else {
		var_attr = rt.call_function('substr', [var_attr.clone(),
			rt.new_int(var_lead.clone().to_string().len), -var_trail.clone().to_string().len])
	}
	var_split = rt.call_function('preg_split', [rt.new_string('/\\s*=\\s*/'),
		var_attr.clone(), rt.new_int(2)])
	var_name = var_split.array_get(0)
	if var_split.clone().array_count() == 2 {
		var_value = var_split.array_get(1)
		if rt.is_true(rt.identical(rt.new_string(''), var_value)) {
			var_quote = rt.new_string('')
		} else {
			var_quote = var_value.array_get(0)
		}
		if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('"'), var_quote))
			|| rt.is_true(rt.identical(rt.new_string("'"), var_quote))))
		{
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('str_ends_with', [
				var_value.clone(),
				var_quote.clone(),
			])))))
			{
				return ''
			}
			var_value = rt.call_function('substr', [var_value.clone(),
				rt.new_int(1), -1])
		} else {
			var_quote = rt.new_string('"')
		}
		var_value = rt.call_function('esc_attr', [var_value.clone()])
		if rt.is_true(rt.call_function('in_array', [
			rt.new_string(var_name.clone().to_string().to_lower()),
			var_uris.clone(),
			rt.new_bool(true),
		]))
		{
			var_value = rt.new_string(wp_kses_bad_protocol(var_value.clone(),
				var_allowed_protocols.clone()))
		}
		var_attr =
			rt.new_string('${var_name.to_string()}=${var_quote.to_string()}${var_value.to_string()}${var_quote.to_string()}')
		var_vless = 'n'
	} else {
		var_value = rt.new_string('')
		var_vless = 'y'
	}
	rt.new_bool(wp_kses_attr_check(var_name.clone(), var_value.clone(), var_attr.clone(),
		rt.new_string(var_vless.str()).clone(), var_element.clone(), var_allowed_html.clone()))
	return var_lead.str() + var_attr.str() + var_trail.str()
}

fn wp_kses_allowed_html(context string) rt.PhpVal {
	mut var_context := context
	mut var_allowedposttags := rt.new_null()
	mut var_allowedtags := rt.new_null()
	mut var_allowedentitynames := []rt.PhpVal{}
	mut var_html := ''
	mut var_tags := rt.new_null()
	if rt.is_true(rt.new_bool(rt.new_string(var_context.str()).is_array())) {
		var_html = var_context
		var_context = 'explicit'
		return rt.call_function('apply_filters', [rt.new_string('wp_kses_allowed_html'),
			rt.new_string(var_html.str()).clone(), rt.new_string(var_context.str())])
	}
	mut switch_val_1 := rt.new_string(var_context.str())
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('post'))) {
		var_tags = rt.call_function('apply_filters', [
			rt.new_string('wp_kses_allowed_html'),
			var_allowedposttags.clone(),
			rt.new_string(var_context.str()),
		])
		if rt.is_true(rt.new_bool(
			rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.get_constant('CUSTOM_TAGS')))))
			&& !(var_tags.array_isset(rt.new_string('form')))))
			&& var_tags.array_isset(rt.new_string('input'))
			|| var_tags.array_isset(rt.new_string('select'))))
		{
			var_tags = var_allowedposttags.clone()
			var_tags.array_set('form', rt.create_array([
				rt.ArrayItem{ key: 'action', val: true },
				rt.ArrayItem{ key: 'accept', val: true },
				rt.ArrayItem{ key: 'accept-charset', val: true },
				rt.ArrayItem{ key: 'enctype', val: true },
				rt.ArrayItem{ key: 'method', val: true },
				rt.ArrayItem{ key: 'name', val: true },
				rt.ArrayItem{ key: 'target', val: true },
			]))
			var_tags = rt.call_function('apply_filters', [
				rt.new_string('wp_kses_allowed_html'),
				var_tags.clone(),
				rt.new_string(var_context.str()),
			])
		}
		return var_tags.clone()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('user_description')))
		|| rt.is_true(rt.equal(switch_val_1, rt.new_string('pre_term_description')))
		|| rt.is_true(rt.equal(switch_val_1, rt.new_string('pre_user_description'))) {
		var_tags = var_allowedtags.clone()
		var_tags.array_get_mut('a').array_set('rel', true)
		var_tags.array_get_mut('a').array_set('target', true)
		return rt.call_function('apply_filters', [rt.new_string('wp_kses_allowed_html'),
			var_tags.clone(), rt.new_string(var_context.str())])
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('strip'))) {
		return rt.call_function('apply_filters', [rt.new_string('wp_kses_allowed_html'),
			rt.new_array(), rt.new_string(var_context.str())])
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('entities'))) {
		return rt.call_function('apply_filters', [rt.new_string('wp_kses_allowed_html'),
			rt.create_array_from_list(var_allowedentitynames),
			rt.new_string(var_context.str())])
	} else {
		return rt.call_function('apply_filters', [rt.new_string('wp_kses_allowed_html'),
			var_allowedtags.clone(), rt.new_string(var_context.str())])
	}
	return rt.new_null()
}

fn wp_kses_hook(var_content rt.PhpVal, var_allowed_html rt.PhpVal, var_allowed_protocols rt.PhpVal) rt.PhpVal {
	return rt.call_function('apply_filters', [rt.new_string('pre_kses'),
		var_content.clone(), var_allowed_html.clone(), var_allowed_protocols.clone()])
}

fn wp_kses_version() string {
	return '0.2.2'
}

fn wp_kses_split(var_content rt.PhpVal, var_allowed_html rt.PhpVal, var_allowed_protocols rt.PhpVal) rt.PhpVal {
	mut var_pass_allowed_html := rt.new_null()
	mut var_pass_allowed_protocols := rt.new_null()
	mut var_token_pattern := ''
	var_pass_allowed_html = var_allowed_html.clone()
	var_pass_allowed_protocols = var_allowed_protocols.clone()
	var_token_pattern = '~\n\t(                      # Detect comments of various flavors before attempting to find tags.\n\t\t(<!--.*?(-->|$))   #  - Normative HTML comments.\n\t\t|\n\t\t</[^a-zA-Z][^>]*>  #  - Closing tags with invalid tag names.\n\t\t|\n\t\t<![^>]*>           #  - Invalid markup declaration nodes. Not all invalid nodes\n\t\t                   #    are matched so as to avoid breaking legacy behaviors.\n\t)\n\t|\n\t(<[^>]*(>|$)|>)        # Tag-like spans of text.\n~x'
	return rt.call_function('preg_replace_callback', [rt.new_string(var_token_pattern.str()).clone(),
		rt.new_string('_wp_kses_split_callback'), var_content.clone()])
}

fn wp_kses_uri_attributes() rt.PhpVal {
	mut var_uri_attributes := rt.new_null()
	var_uri_attributes = rt.create_array([rt.ArrayItem{ key: none, val: 'action' },
		rt.ArrayItem{ key: none, val: 'archive' }, rt.ArrayItem{ key: none, val: 'background' },
		rt.ArrayItem{ key: none, val: 'cite' }, rt.ArrayItem{ key: none, val: 'classid' },
		rt.ArrayItem{ key: none, val: 'codebase' }, rt.ArrayItem{ key: none, val: 'data' },
		rt.ArrayItem{ key: none, val: 'formaction' }, rt.ArrayItem{ key: none, val: 'href' },
		rt.ArrayItem{ key: none, val: 'icon' }, rt.ArrayItem{ key: none, val: 'longdesc' },
		rt.ArrayItem{ key: none, val: 'manifest' }, rt.ArrayItem{ key: none, val: 'poster' },
		rt.ArrayItem{ key: none, val: 'profile' }, rt.ArrayItem{ key: none, val: 'src' },
		rt.ArrayItem{ key: none, val: 'usemap' }, rt.ArrayItem{ key: none, val: 'xmlns' }])
	var_uri_attributes = rt.call_function('apply_filters', [
		rt.new_string('wp_kses_uri_attributes'),
		var_uri_attributes.clone(),
	])
	return var_uri_attributes.clone()
}

fn _wp_kses_split_callback(var_matches rt.PhpVal) rt.PhpVal {
	mut var_pass_allowed_html := rt.new_null()
	mut var_pass_allowed_protocols := rt.new_null()
	return rt.new_string(wp_kses_split2(var_matches.array_get(0), var_pass_allowed_html.clone(),
		var_pass_allowed_protocols.clone()))
}

fn wp_kses_split2(var_content_arg rt.PhpVal, var_allowed_html_arg rt.PhpVal, var_allowed_protocols rt.PhpVal) string {
	mut var_content := var_content_arg
	mut var_allowed_html := var_allowed_html_arg
	mut var_matches := []rt.PhpVal{}
	mut var_opener := rt.new_null()
	mut var_prev := rt.new_null()
	mut var_newstring := rt.new_null()
	mut var_slash := ''
	mut var_elem := rt.new_null()
	mut var_attrlist := rt.new_null()
	var_content = wp_kses_stripslashes(var_content.clone())
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('str_starts_with', [
		var_content.clone(),
		rt.new_string('<'),
	])))))
	{
		return '&gt;'
	}
	if rt.is_true(rt.identical(rt.new_int(1), rt.call_function('preg_match', [
		rt.new_string('~^(?:</[^a-zA-Z][^>]*>|<![a-z][^>]*>)$~'),
		var_content.clone(),
	])))
	{
		var_opener = var_content.array_get(1)
		var_content = rt.call_function('substr', [var_content.clone(),
			rt.new_int(2), -1])
		for {
			var_prev = var_content.clone()
			var_content = wp_kses(var_content.clone(), var_allowed_html.clone(),
				var_allowed_protocols.clone())
			if !(rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_prev, var_content))))) {
				break
			}
		}
		return '<${var_opener.to_string()}${var_content.to_string()}>'
	}
	if rt.is_true(rt.call_function('str_starts_with', [var_content.clone(),
		rt.new_string('<!--')]))
	{
		var_content = rt.call_function('str_replace', [
			rt.create_array([rt.ArrayItem{ key: none, val: '<!--' },
				rt.ArrayItem{ key: none, val: '-->' }]),
			rt.new_string(''),
			var_content.clone(),
		])
		var_newstring = wp_kses(var_content.clone(), var_allowed_html.clone(),
			var_allowed_protocols.clone())
		for rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_newstring, var_content)))) {
			var_content = var_newstring
		}
		if rt.is_true(rt.identical(rt.new_string(''), var_content)) {
			return ''
		}
		var_content = rt.call_function('preg_replace', [rt.new_string('/--+/'),
			rt.new_string('-'), var_content.clone()])
		var_content = rt.call_function('preg_replace', [rt.new_string('/-$/'),
			rt.new_string(''), var_content.clone()])
		return '<!--${var_content.to_string()}-->'
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('preg_match', [
		rt.new_string('%^<\\s*(/\\s*)?([a-zA-Z0-9-]+)([^>]*)>?$%'),
		var_content.clone(),
		rt.create_array_from_list(var_matches),
	])))))
	{
		return ''
	}
	var_slash = var_matches.array_get(1).to_string().trim_space()
	var_elem = var_matches.array_get(2)
	var_attrlist = var_matches.array_get(3)
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_allowed_html.clone().is_array()))))) {
		var_allowed_html = wp_kses_allowed_html(var_allowed_html.clone())
	}
	if !(var_allowed_html.array_isset(rt.new_string(var_elem.clone().to_string().to_lower()))) {
		return ''
	}
	if rt.is_true(rt.new_bool('' != var_slash)) {
		return '</${var_elem.to_string()}>'
	}
	return wp_kses_attr(var_elem.clone(), var_attrlist.clone(), var_allowed_html.clone(),
		var_allowed_protocols.clone())
}

fn wp_kses_attr(var_element rt.PhpVal, var_attr rt.PhpVal, var_allowed_html_arg rt.PhpVal, var_allowed_protocols rt.PhpVal) string {
	mut var_allowed_html := var_allowed_html_arg
	mut var_xhtml_slash := ''
	mut var_element_low := ''
	mut var_attrarr := rt.new_null()
	mut var_required_attrs := rt.new_null()
	mut var_stripped_tag := ''
	mut var_attr2 := rt.new_null()
	mut var_arreach := map[string]rt.PhpVal{}
	mut var_required := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_allowed_html.clone().is_array()))))) {
		var_allowed_html = wp_kses_allowed_html(var_allowed_html.clone())
	}
	var_xhtml_slash = ''
	if rt.is_true(rt.call_function('preg_match', [rt.new_string('%\\s*/\\s*$%'),
		var_attr.clone()]))
	{
		var_xhtml_slash = ' /'
	}
	var_element_low = var_element.clone().to_string().to_lower()
	if rt.is_true(rt.new_bool(!rt.is_true(var_allowed_html.array_get(var_element_low))
		|| rt.is_true(rt.identical(rt.new_bool(true), var_allowed_html.array_get(var_element_low)))))
	{
		return '<${var_element.to_string()}${var_xhtml_slash}>'
	}
	var_attrarr = wp_kses_hair(var_attr.clone(), var_allowed_protocols.clone())
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_required_attr_limits := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return var_required_attr_limits.array_isset(rt.new_string('required'))
			&& rt.is_true(rt.identical(rt.new_bool(true), var_required_attr_limits.array_get('required')))
	}
	var_required_attrs = rt.call_function('array_filter', [var_allowed_html.array_get(var_element_low),
		rt.new_closure(closure_1_fn)])
	var_stripped_tag = ''
	if var_xhtml_slash == '' {
		var_stripped_tag = '<${var_element.to_string()}>'
	}
	var_attr2 = rt.new_string('')
	mut iter_1 := var_attrarr.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_arreach_shadow := item_1.val
		var_required =
			rt.new_bool(var_required_attrs.array_isset(rt.new_string(var_arreach_shadow.array_get('name').to_string().to_lower())))
		if rt.is_true(rt.new_bool(wp_kses_attr_check(var_arreach_shadow.array_get('name'),
			var_arreach_shadow.array_get('value'), var_arreach_shadow.array_get('whole'),
			var_arreach_shadow.array_get('vless'), var_element.clone(), var_allowed_html.clone())))
		{
			var_attr2 = rt.concat(var_attr2, rt.new_string(' ' +
				(var_arreach_shadow.array_get('whole')).str()))
			if rt.is_true(var_required) {
				var_required_attrs.array_unset(rt.new_string(var_arreach_shadow.array_get('name').to_string().to_lower()))
			}
		} else if rt.is_true(var_required) {
			return var_stripped_tag
		}
	}
	if !(!rt.is_true(var_required_attrs)) {
		return var_stripped_tag
	}
	var_attr2 = rt.call_function('preg_replace', [rt.new_string('/[<>]/'),
		rt.new_string(''), var_attr2.clone()])
	return '<${var_element.to_string()}${var_attr2.to_string()}${var_xhtml_slash}>'
}

fn wp_kses_attr_check(var_name_arg rt.PhpVal, var_value_arg rt.PhpVal, var_whole_arg rt.PhpVal, var_vless rt.PhpVal, var_element rt.PhpVal, var_allowed_html rt.PhpVal) bool {
	mut var_name := var_name_arg
	mut var_value := var_value_arg
	mut var_whole := var_whole_arg
	mut var_match := []rt.PhpVal{}
	mut var_name_low := ''
	mut var_element_low := ''
	mut var_allowed_attr := rt.new_null()
	mut var_new_value := rt.new_null()
	mut var_currval := rt.new_null()
	mut var_currkey := rt.new_null()
	var_name_low = var_name.to_lower()
	var_element_low = var_element.clone().to_string().to_lower()
	if !(var_allowed_html.array_isset(rt.new_string(var_element_low.str()))) {
		var_name = ''
		var_value = rt.new_string('')
		var_whole = rt.new_string('')
		return false
	}
	var_allowed_attr = var_allowed_html.array_get(var_element_low)
	if rt.is_true(rt.new_bool(!(var_allowed_attr.array_isset(rt.new_string(var_name_low.str())))
		|| rt.is_true(rt.identical(rt.new_string(''), var_allowed_attr.array_get(var_name_low)))))
	{
		if rt.is_true(rt.new_bool(
			rt.is_true(rt.new_bool(rt.is_true(rt.call_function('str_starts_with', [rt.new_string(var_name_low.str()).clone(), rt.new_string('data-')]))
			&& !(!rt.is_true(var_allowed_attr.array_get('data-*')))))
			&& rt.is_true(rt.call_function('preg_match', [rt.new_string('/^data-[a-z0-9_-]+$/'), rt.new_string(var_name_low.str()).clone(), rt.create_array_from_list(var_match)]))))
		{
			var_allowed_attr.array_set(var_match.array_get(0), var_allowed_attr.array_get('data-*'))
		} else {
			var_name = ''
			var_value = rt.new_string('')
			var_whole = rt.new_string('')
			return false
		}
	}
	if rt.is_true(rt.identical(rt.new_string('style'), rt.new_string(var_name_low.str()))) {
		var_new_value = safecss_filter_attr(var_value.clone(), '')
		if !rt.is_true(var_new_value) {
			var_name = ''
			var_value = rt.new_string('')
			var_whole = rt.new_string('')
			return false
		}
		var_whole = rt.call_function('str_replace', [var_value.clone(),
			var_new_value.clone(), var_whole.clone()])
		var_value = var_new_value.clone()
	}
	if rt.is_true(rt.new_bool(var_allowed_attr.array_get(var_name_low).is_array())) {
		mut iter_2 := var_allowed_attr.array_get(var_name_low).iterator()
		for {
			item_2 := iter_2.next() or { break }
			mut var_currval_shadow := item_2.val
			mut var_currkey_shadow := item_2.key
			if !(wp_kses_check_attr_val(var_value.clone(), var_vless.clone(),
				var_currkey_shadow.clone(), var_currval_shadow.clone())) {
				var_name = ''
				var_value = rt.new_string('')
				var_whole = rt.new_string('')
				return false
			}
		}
	}
	return true
}

fn wp_kses_hair(var_attr rt.PhpVal, var_allowed_protocols rt.PhpVal) rt.PhpVal {
	mut var_attributes := rt.new_null()
	mut var_uris := rt.new_null()
	mut var_processor := rt.new_null()
	mut var_attribute_names := rt.new_null()
	mut var_syntax_characters := map[string]rt.PhpVal{}
	mut var_name := rt.new_null()
	mut var_value := rt.new_null()
	mut var_is_bool := false
	mut var_recoded := rt.new_null()
	mut var_whole := rt.new_null()
	var_attributes = rt.new_array()
	var_uris = wp_kses_uri_attributes()
	var_processor = create_wp_html_tag_processor(rt.new_string('<wp ${var_attr.to_string()}>'))
	var_processor.next_token()
	var_attribute_names = var_processor.get_attribute_names_with_prefix(rt.new_string(''))
	if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_null(), var_attribute_names))
		|| 0 == var_attribute_names.clone().array_count()))
	{
		return var_attributes.clone()
	}
	var_syntax_characters = {
		'&': '&amp;'
		'<': '&lt;'
		'>': '&gt;'
		"'": '&apos;'
		'"': '&quot;'
	}
	mut iter_3 := var_attribute_names.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_name_shadow := item_3.val
		var_value = var_processor.get_attribute(var_name_shadow.clone())
		var_is_bool = (rt.identical(rt.new_bool(true), var_value)).to_bool()
		if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_value.clone().is_string()))
			&& rt.is_true(rt.call_function('in_array', [var_name_shadow.clone(), var_uris.clone(), rt.new_bool(true)]))))
		{
			var_value = rt.new_string(wp_kses_bad_protocol(var_value.clone(),
				var_allowed_protocols.clone()))
		}
		var_recoded = if var_is_bool { rt.new_string('') } else { rt.call_function('strtr', [
				var_value.clone(),
				rt.create_array_from_native_map(var_syntax_characters),
			]) }
		var_whole = if var_is_bool {
			var_name_shadow
		} else {
			rt.new_string("${var_name.to_string()}=\"${var_recoded.to_string()}\"")
		}
		var_attributes.array_set(var_name_shadow, rt.create_array([
			rt.ArrayItem{ key: 'name', val: var_name_shadow },
			rt.ArrayItem{ key: 'value', val: var_recoded },
			rt.ArrayItem{ key: 'whole', val: var_whole },
			rt.ArrayItem{
				key: 'vless'
				val: if var_is_bool { 'y' } else { 'n' }
			},
		]))
	}
	return var_attributes.clone()
}

fn wp_kses_attr_parse(var_element rt.PhpVal) bool {
	mut var_matches := []rt.PhpVal{}
	mut var_valid := rt.new_null()
	mut var_begin := rt.new_null()
	mut var_slash := rt.new_null()
	mut var_elname := rt.new_null()
	mut var_attr := rt.new_null()
	mut var_end := rt.new_null()
	mut var_xhtml_slash := rt.new_null()
	mut var_attrarr := rt.new_null()
	var_valid = rt.call_function('preg_match', [
		rt.new_string('%^(<\\s*)(/\\s*)?([a-zA-Z0-9]+\\s*)([^>]*)(>?)$%'),
		var_element.clone(),
		rt.create_array_from_list(var_matches),
	])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int(1), var_valid)))) {
		return false
	}
	var_begin = var_matches.array_get(1)
	var_slash = var_matches.array_get(2)
	var_elname = var_matches.array_get(3)
	var_attr = var_matches.array_get(4)
	var_end = var_matches.array_get(5)
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), var_slash)))) {
		return false
	}
	if rt.is_true(rt.identical(rt.new_int(1), rt.call_function('preg_match', [
		rt.new_string('%\\s*/\\s*$%'),
		var_attr.clone(),
		rt.create_array_from_list(var_matches),
	])))
	{
		var_xhtml_slash = var_matches.array_get(0)
		var_attr = rt.call_function('substr', [var_attr.clone(),
			rt.new_int(0), -var_xhtml_slash.clone().to_string().len])
	} else {
		var_xhtml_slash = rt.new_string('')
	}
	var_attrarr = wp_kses_hair_parse(var_attr.clone())
	if rt.is_true(rt.identical(rt.new_bool(false), var_attrarr)) {
		return false
	}
	rt.call_function('array_unshift', [var_attrarr.clone(),
		rt.new_string(var_begin.str() + var_slash.str() + var_elname.str())])
	var_attrarr.clone().array_push(rt.new_string(var_xhtml_slash.str() + var_end.str()))
	return var_attrarr.to_bool()
}

fn wp_kses_hair_parse(var_attr rt.PhpVal) rt.PhpVal {
	mut var_attrarr := rt.new_null()
	mut var_regex := ''
	mut var_validation := ''
	mut var_extraction := ''
	if rt.is_true(rt.identical(rt.new_string(''), var_attr)) {
		return rt.new_array()
	}
	var_regex = '(?:\n\t\t\t\t[_a-zA-Z][-_a-zA-Z0-9:.]* # Attribute name.\n\t\t\t|\n\t\t\t\t\\[\\[?[^\\[\\]]+\\]\\]?        # Shortcode in the name position implies unfiltered_html.\n\t\t)\n\t\t(?:                               # Attribute value.\n\t\t\t\\s*=\\s*                       # All values begin with "=".\n\t\t\t(?:\n\t\t\t\t"[^"]*"                   # Double-quoted.\n\t\t\t|\n\t\t\t\t\'[^\']*\'                # Single-quoted.\n\t\t\t|\n\t\t\t\t[^\\s"\']+                 # Non-quoted.\n\t\t\t\t(?:\\s|$)                  # Must have a space.\n\t\t\t)\n\t\t|\n\t\t\t(?:\\s|$)                      # If attribute has no value, space is required.\n\t\t)\n\t\t\\s*                               # Trailing space is optional except as mentioned above.\n\t\t'
	var_validation = rt.concat(rt.concat(rt.new_string('/^('), rt.new_string(var_regex.str())),
		rt.new_string(')+$/x'))
	var_extraction = '/${var_regex}/x'
	if rt.is_true(rt.identical(rt.new_int(1), rt.call_function('preg_match', [
		rt.new_string(var_validation.str()).clone(), var_attr.clone()])))
	{
		rt.call_function('preg_match_all', [rt.new_string(var_extraction.str()).clone(),
			var_attr.clone(), var_attrarr.clone()])
		return var_attrarr.array_get(0)
	} else {
		return rt.new_bool(false)
	}
	return rt.new_null()
}

fn wp_kses_check_attr_val(var_value rt.PhpVal, var_vless rt.PhpVal, var_checkname rt.PhpVal, var_checkvalue rt.PhpVal) bool {
	mut var_ok := false
	var_ok = true
	mut switch_val_2 := rt.new_string(var_checkname.clone().to_string().to_lower())
	if rt.is_true(rt.equal(switch_val_2, rt.new_string('maxlen'))) {
		if rt.is_true(rt.greater(rt.new_int(var_value.clone().to_string().len), var_checkvalue)) {
			var_ok = false
		}
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('minlen'))) {
		if rt.is_true(rt.less(rt.new_int(var_value.clone().to_string().len), var_checkvalue)) {
			var_ok = false
		}
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('maxval'))) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('preg_match', [
			rt.new_string('/^\\s{0,6}[0-9]{1,6}\\s{0,6}$/'),
			var_value.clone(),
		])))))
		{
			var_ok = false
		}
		if rt.is_true(rt.greater(var_value, var_checkvalue)) {
			var_ok = false
		}
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('minval'))) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('preg_match', [
			rt.new_string('/^\\s{0,6}[0-9]{1,6}\\s{0,6}$/'),
			var_value.clone(),
		])))))
		{
			var_ok = false
		}
		if rt.is_true(rt.less(var_value, var_checkvalue)) {
			var_ok = false
		}
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('valueless'))) {
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(var_checkvalue.clone().to_string().to_lower()),
			var_vless))))
		{
			var_ok = false
		}
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('values'))) {
		if rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('array_search', [
			rt.new_string(var_value.clone().to_string().to_lower()),
			var_checkvalue.clone(),
			rt.new_bool(true),
		])))
		{
			var_ok = false
		}
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('value_callback'))) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('call_user_func', [
			var_checkvalue.clone(),
			var_value.clone(),
		])))))
		{
			var_ok = false
		}
	}
	return var_ok
}

fn wp_kses_bad_protocol(var_content_arg rt.PhpVal, var_allowed_protocols rt.PhpVal) string {
	mut var_content := var_content_arg
	mut var_iterations := i64(0)
	mut var_original_content := rt.new_null()
	var_content = wp_kses_no_null(var_content.clone(), rt.new_null())
	if rt.is_true(rt.new_bool(
		rt.is_true(rt.new_bool(rt.is_true(rt.call_function('str_starts_with', [var_content.clone(), rt.new_string('https://')]))
		&& rt.is_true(rt.call_function('in_array', [rt.new_string('https'), var_allowed_protocols.clone(), rt.new_bool(true)]))))
		|| rt.is_true(rt.new_bool(rt.is_true(rt.call_function('str_starts_with', [var_content.clone(), rt.new_string('http://')]))
		&& rt.is_true(rt.call_function('in_array', [rt.new_string('http'), var_allowed_protocols.clone(), rt.new_bool(true)]))))))
	{
		return var_content.str()
	}
	var_iterations = 0
	for {
		var_original_content = var_content.clone()
		var_content = rt.new_string(wp_kses_bad_protocol_once(var_content.clone(),
			var_allowed_protocols.clone(), 0))
		if !(rt.is_true(rt.new_bool(
			rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_original_content, var_content))))
			&& rt.is_true(rt.less(rt.pre_inc(rt.new_int(var_iterations)), rt.new_int(6)))))) {
			break
		}
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_original_content, var_content)))) {
		return ''
	}
	return var_content.str()
}

fn wp_kses_no_null(var_content_arg rt.PhpVal, var_options_arg rt.PhpVal) rt.PhpVal {
	mut var_content := var_content_arg
	mut var_options := var_options_arg
	if !(var_options.array_isset(rt.new_string('slash_zero'))) {
		var_options = {
			'slash_zero': 'remove'
		}
	}
	var_content = rt.call_function('preg_replace', [
		rt.new_string('/[\\x00-\\x08\\x0B\\x0C\\x0E-\\x1F]/'),
		rt.new_string(''),
		var_content.clone(),
	])
	if rt.is_true(rt.identical(rt.new_string('remove'), var_options.array_get('slash_zero'))) {
		var_content = rt.call_function('preg_replace', [rt.new_string('/\\\\+0+/'),
			rt.new_string(''), var_content.clone()])
	}
	return var_content.clone()
}

fn wp_kses_stripslashes(var_content rt.PhpVal) rt.PhpVal {
	return rt.call_function('preg_replace', [rt.new_string('%\\\\"%'),
		rt.new_string('"'), var_content.clone()])
}

fn wp_kses_array_lc(var_inarray rt.PhpVal) rt.PhpVal {
	mut var_outarray := rt.new_null()
	mut var_inval := rt.new_null()
	mut var_inkey := rt.new_null()
	mut var_outkey := ''
	mut var_inval2 := rt.new_null()
	mut var_inkey2 := rt.new_null()
	mut var_outkey2 := ''
	var_outarray = rt.new_array()
	mut iter_4 := rt.cast_array(var_inarray).iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_inval_shadow := item_4.val
		mut var_inkey_shadow := item_4.key
		var_outkey = var_inkey_shadow.clone().to_string().to_lower()
		var_outarray.array_set(var_outkey, rt.new_array())
		mut iter_5 := rt.cast_array(var_inval_shadow).iterator()
		for {
			item_5 := iter_5.next() or { break }
			mut var_inval2_shadow := item_5.val
			mut var_inkey2_shadow := item_5.key
			var_outkey2 = var_inkey2_shadow.clone().to_string().to_lower()
			var_outarray.array_get_mut(var_outkey).array_set(var_outkey2, var_inval2_shadow.clone())
		}
	}
	return var_outarray.clone()
}

fn wp_kses_html_error(var_attr rt.PhpVal) rt.PhpVal {
	return rt.call_function('preg_replace', [
		rt.new_string('/^("[^"]*("|$)|\'[^\']*(\'|$)|\\S)*\\s*/'),
		rt.new_string(''),
		var_attr.clone(),
	])
}

fn wp_kses_bad_protocol_once(var_content_arg rt.PhpVal, var_allowed_protocols rt.PhpVal, count i64) string {
	mut var_count := count
	mut var_content := var_content_arg
	mut var_content2 := rt.new_null()
	mut var_protocol := rt.new_null()
	var_content = rt.call_function('preg_replace', [
		rt.new_string('/(&#0*58(?![;0-9])|&#x0*3a(?![;a-f0-9]))/i'),
		rt.new_string('$1;'),
		var_content.clone(),
	])
	var_content2 = rt.call_function('preg_split', [
		rt.new_string('/:|&#0*58;|&#x0*3a;|&colon;/i'),
		var_content.clone(),
		rt.new_int(2),
	])
	if rt.is_true(rt.new_bool(var_content2.array_isset(rt.new_int(1))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('preg_match', [rt.new_string('%/\\?%'), var_content2.array_get(0)])))))))
	{
		var_content = rt.new_string(var_content2.array_get(1).to_string().trim_space())
		var_protocol = rt.new_string(wp_kses_bad_protocol_once2(var_content2.array_get(0),
			var_allowed_protocols.clone()))
		if rt.is_true(rt.identical(rt.new_string('feed:'), var_protocol)) {
			if count > 2 {
				return ''
			}
			var_content = rt.new_string(wp_kses_bad_protocol_once(var_content.clone(),
				var_allowed_protocols.clone(), rt.pre_inc(rt.new_int(count))))
			if !rt.is_true(var_content) {
				return var_content.str()
			}
		}
		var_content = rt.new_string(var_protocol.str() + var_content.str())
	}
	return var_content.str()
}

fn wp_kses_bad_protocol_once2(var_scheme_arg rt.PhpVal, var_allowed_protocols rt.PhpVal) string {
	mut var_scheme := var_scheme_arg
	mut var_allowed := false
	mut var_one_protocol := rt.new_null()
	var_scheme = wp_kses_decode_entities(var_scheme.clone())
	var_scheme = rt.call_function('preg_replace', [rt.new_string('/\\s/'),
		rt.new_string(''), var_scheme.clone()])
	var_scheme = wp_kses_no_null(var_scheme.clone(), rt.new_null())
	var_scheme = rt.new_string(var_scheme.clone().to_string().to_lower())
	var_allowed = false
	mut iter_6 := rt.cast_array(var_allowed_protocols).iterator()
	for {
		item_6 := iter_6.next() or { break }
		mut var_one_protocol_shadow := item_6.val
		if rt.is_true(rt.identical(rt.new_string(var_one_protocol_shadow.clone().to_string().to_lower()),
			var_scheme))
		{
			var_allowed = true
			break
		}
	}
	if var_allowed {
		return '${var_scheme.to_string()}:'
	} else {
		return ''
	}
	return ''
}

fn wp_kses_normalize_entities(var_content_arg rt.PhpVal, context string) rt.PhpVal {
	mut var_context := context
	mut var_content := var_content_arg
	var_content = rt.call_function('str_replace', [rt.new_string('&'),
		rt.new_string('&amp;'), var_content.clone()])
	var_content = rt.call_function('preg_replace_callback', [
		rt.new_string('/&amp;#(0*[1-9][0-9]{0,6});/'),
		rt.new_string('wp_kses_normalize_entities2'),
		var_content.clone(),
	])
	var_content = rt.call_function('preg_replace_callback', [
		rt.new_string('/&amp;#[Xx](0*[1-9A-Fa-f][0-9A-Fa-f]{0,5});/'),
		rt.new_string('wp_kses_normalize_entities3'),
		var_content.clone(),
	])
	if rt.is_true(rt.identical(rt.new_string('xml'), rt.new_string(var_context.str()))) {
		var_content = rt.call_function('preg_replace_callback', [
			rt.new_string('/&amp;([A-Za-z]{2,8}[0-9]{0,2});/'),
			rt.new_string('wp_kses_xml_named_entities'),
			var_content.clone(),
		])
	} else {
		var_content = rt.call_function('preg_replace_callback', [
			rt.new_string('/&amp;([A-Za-z]{2,8}[0-9]{0,2});/'),
			rt.new_string('wp_kses_named_entities'),
			var_content.clone(),
		])
	}
	return var_content.clone()
}

fn wp_kses_named_entities(var_matches rt.PhpVal) string {
	mut var_allowedentitynames := []rt.PhpVal{}
	mut var_i := rt.new_null()
	if !rt.is_true(var_matches.array_get(1)) {
		return ''
	}
	var_i = var_matches.array_get(1)
	return if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
		var_i.clone(),
		rt.create_array_from_list(var_allowedentitynames),
		rt.new_bool(true),
	])))))
	{ '&amp;${var_i.to_string()};' } else { '&${var_i.to_string()};' }
}

fn wp_kses_xml_named_entities(var_matches rt.PhpVal) string {
	mut var_allowedentitynames := []rt.PhpVal{}
	mut var_allowedxmlentitynames := []rt.PhpVal{}
	mut var_i := rt.new_null()
	if !rt.is_true(var_matches.array_get(1)) {
		return ''
	}
	var_i = var_matches.array_get(1)
	if rt.is_true(rt.call_function('in_array', [var_i.clone(),
		rt.create_array_from_list(var_allowedxmlentitynames),
		rt.new_bool(true)]))
	{
		return '&${var_i.to_string()};'
	} else if rt.is_true(rt.call_function('in_array', [var_i.clone(),
		rt.create_array_from_list(var_allowedentitynames), rt.new_bool(true)]))
	{
		return (rt.call_function('html_entity_decode', [
			rt.new_string('&${var_i.to_string()};'),
			rt.get_constant('ENT_HTML5'),
		])).str()
	}
	return '&amp;${var_i.to_string()};'
}

fn wp_kses_normalize_entities2(var_matches rt.PhpVal) string {
	mut var_i := rt.new_null()
	if !rt.is_true(var_matches.array_get(1)) {
		return ''
	}
	var_i = var_matches.array_get(1)
	if rt.is_true(rt.new_bool(valid_unicode(var_i.clone()))) {
		var_i = rt.call_function('str_pad', [
			rt.new_string(var_i.clone().to_string().trim_left(' \t\n\r')),
			rt.new_int(3),
			rt.new_string('0'),
			rt.get_constant('STR_PAD_LEFT'),
		])
		var_i = rt.new_string('&#${var_i.to_string()};')
	} else {
		var_i = rt.new_string('&amp;#${var_i.to_string()};')
	}
	return var_i.str()
}

fn wp_kses_normalize_entities3(var_matches rt.PhpVal) string {
	mut var_hexchars := rt.new_null()
	if !rt.is_true(var_matches.array_get(1)) {
		return ''
	}
	var_hexchars = var_matches.array_get(1)
	return if !(valid_unicode(rt.call_function('hexdec', [var_hexchars.clone()]))) {
		'&amp;#x${var_hexchars.to_string()};'
	} else {
		'&#x' + var_hexchars.clone().to_string().trim_left(' \t\n\r') + ';'
	}
}

fn valid_unicode(var_i_arg rt.PhpVal) bool {
	mut var_i := var_i_arg
	var_i = rt.new_int(var_i.to_i64())
	return
		rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_int(9), var_i))
		|| rt.is_true(rt.identical(rt.new_int(10), var_i))))
		|| rt.is_true(rt.identical(rt.new_int(13), var_i))))
		|| rt.is_true(rt.new_bool(rt.is_true(rt.less_equal(rt.new_int(32), var_i))
		&& rt.is_true(rt.less_equal(var_i, rt.new_int(55295)))))))
		|| rt.is_true(rt.new_bool(rt.is_true(rt.less_equal(rt.new_int(57344), var_i))
		&& rt.is_true(rt.less_equal(var_i, rt.new_int(65533)))))))
		|| rt.is_true(rt.new_bool(rt.is_true(rt.less_equal(rt.new_int(65536), var_i))
		&& rt.is_true(rt.less_equal(var_i, rt.new_int(1114111)))))
}

fn wp_kses_decode_entities(var_content_arg rt.PhpVal) rt.PhpVal {
	mut var_content := var_content_arg
	var_content = rt.call_function('preg_replace_callback', [
		rt.new_string('/&#([0-9]+);/'),
		rt.new_string('_wp_kses_decode_entities_chr'),
		var_content.clone(),
	])
	var_content = rt.call_function('preg_replace_callback', [
		rt.new_string('/&#[Xx]([0-9A-Fa-f]+);/'),
		rt.new_string('_wp_kses_decode_entities_chr_hexdec'),
		var_content.clone(),
	])
	return var_content.clone()
}

fn _wp_kses_decode_entities_chr(var_matches rt.PhpVal) rt.PhpVal {
	return rt.call_function('chr', [var_matches.array_get(1)])
}

fn _wp_kses_decode_entities_chr_hexdec(var_matches rt.PhpVal) rt.PhpVal {
	return rt.call_function('chr', [
		rt.call_function('hexdec', [var_matches.array_get(1)]),
	])
}

fn wp_filter_kses(var_data rt.PhpVal) rt.PhpVal {
	return rt.call_function('addslashes', [
		wp_kses(rt.call_function('stripslashes', [var_data.clone()]), rt.call_function('current_filter',
			[]rt.PhpVal{}), rt.new_null()),
	])
}

fn wp_kses_data(var_data rt.PhpVal) rt.PhpVal {
	return wp_kses(var_data.clone(), rt.call_function('current_filter', []rt.PhpVal{}),
		rt.new_null())
}

fn wp_filter_post_kses(var_data rt.PhpVal) rt.PhpVal {
	return rt.call_function('addslashes', [
		wp_kses(rt.call_function('stripslashes', [var_data.clone()]), rt.new_string('post'),
			rt.new_null()),
	])
}

fn wp_filter_global_styles_post(var_data rt.PhpVal) rt.PhpVal {
	mut var_decoded_data := rt.new_null()
	mut var_json_decoding_error := rt.new_null()
	mut var_data_to_encode := rt.new_null()
	var_decoded_data = rt.call_function('json_decode', [
		rt.call_function('wp_unslash', [var_data.clone()]),
		rt.new_bool(true),
	])
	var_json_decoding_error = rt.call_function('json_last_error', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(
		rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.get_constant('JSON_ERROR_NONE'), var_json_decoding_error))
		&& rt.is_true(rt.new_bool(var_decoded_data.clone().is_array()))))
		&& var_decoded_data.array_isset(rt.new_string('isGlobalStylesUserThemeJSON'))))
		&& rt.is_true(var_decoded_data.array_get('isGlobalStylesUserThemeJSON'))))
	{
		var_decoded_data.array_unset(rt.new_string('isGlobalStylesUserThemeJSON'))
		mut iife_temp_1 := Class_WP_Theme_JSON{}
		mut iife_result_1 := iife_temp_1.remove_insecure_properties(var_decoded_data.clone(),
			rt.new_string('custom'))
		var_data_to_encode = iife_result_1
		var_data_to_encode.array_set('isGlobalStylesUserThemeJSON', true)
		return rt.call_function('wp_slash', [
			rt.call_function('wp_json_encode', [var_data_to_encode.clone(),
				rt.bitwise_or(rt.bitwise_or(rt.get_constant('JSON_UNESCAPED_SLASHES'),
					rt.get_constant('JSON_HEX_TAG')), rt.get_constant('JSON_HEX_AMP'))]),
		])
	}
	return var_data.clone()
}

fn wp_kses_post(var_data rt.PhpVal) rt.PhpVal {
	return wp_kses(var_data.clone(), rt.new_string('post'), rt.new_null())
}

fn wp_kses_post_deep(var_data rt.PhpVal) rt.PhpVal {
	return rt.call_function('map_deep', [var_data.clone(), rt.new_string('wp_kses_post')])
}

fn wp_filter_nohtml_kses(var_data rt.PhpVal) rt.PhpVal {
	return rt.call_function('addslashes', [
		wp_kses(rt.call_function('stripslashes', [var_data.clone()]), rt.new_string('strip'),
			rt.new_null()),
	])
}

fn kses_init_filters() {
	rt.call_function('add_filter', [rt.new_string('title_save_pre'),
		rt.new_string('wp_filter_kses')])
	if rt.is_true(rt.call_function('current_user_can', [rt.new_string('unfiltered_html')])) {
		rt.call_function('add_filter', [rt.new_string('pre_comment_content'),
			rt.new_string('wp_filter_post_kses')])
	} else {
		rt.call_function('add_filter', [rt.new_string('pre_comment_content'),
			rt.new_string('wp_filter_kses')])
	}
	rt.call_function('add_filter', [rt.new_string('content_save_pre'),
		rt.new_string('wp_filter_global_styles_post'), rt.new_int(9)])
	rt.call_function('add_filter', [rt.new_string('content_filtered_save_pre'),
		rt.new_string('wp_filter_global_styles_post'), rt.new_int(9)])
	rt.call_function('add_filter', [rt.new_string('content_save_pre'),
		rt.new_string('wp_filter_post_kses')])
	rt.call_function('add_filter', [rt.new_string('excerpt_save_pre'),
		rt.new_string('wp_filter_post_kses')])
	rt.call_function('add_filter', [rt.new_string('content_filtered_save_pre'),
		rt.new_string('wp_filter_post_kses')])
}

fn kses_remove_filters() {
	rt.call_function('remove_filter', [rt.new_string('title_save_pre'),
		rt.new_string('wp_filter_kses')])
	rt.call_function('remove_filter', [rt.new_string('pre_comment_content'),
		rt.new_string('wp_filter_post_kses')])
	rt.call_function('remove_filter', [rt.new_string('pre_comment_content'),
		rt.new_string('wp_filter_kses')])
	rt.call_function('remove_filter', [rt.new_string('content_save_pre'),
		rt.new_string('wp_filter_global_styles_post'), rt.new_int(9)])
	rt.call_function('remove_filter', [rt.new_string('content_filtered_save_pre'),
		rt.new_string('wp_filter_global_styles_post'), rt.new_int(9)])
	rt.call_function('remove_filter', [rt.new_string('content_save_pre'),
		rt.new_string('wp_filter_post_kses')])
	rt.call_function('remove_filter', [rt.new_string('excerpt_save_pre'),
		rt.new_string('wp_filter_post_kses')])
	rt.call_function('remove_filter', [rt.new_string('content_filtered_save_pre'),
		rt.new_string('wp_filter_post_kses')])
}

fn kses_init() {
	kses_remove_filters()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('unfiltered_html'),
	])))))
	{
		kses_init_filters()
	}
}

fn safecss_filter_attr(var_css_arg rt.PhpVal, deprecated string) rt.PhpVal {
	mut var_deprecated := deprecated
	mut var_css := var_css_arg
	mut var_url_matches := []rt.PhpVal{}
	mut var_url_pieces := []rt.PhpVal{}
	mut var_allowed_protocols := rt.new_null()
	mut var_css_array := rt.new_null()
	mut var_allowed_attr := rt.new_null()
	mut var_css_url_data_types := []rt.PhpVal{}
	mut var_css_gradient_data_types := []rt.PhpVal{}
	mut var_css_item := ''
	mut var_css_test_string := rt.new_null()
	mut var_found := false
	mut var_url_attr := rt.new_null()
	mut var_gradient_attr := rt.new_null()
	mut var_is_custom_var := false
	mut var_parts := rt.new_null()
	mut var_css_selector := ''
	mut var_css_value := ''
	mut var_url_match := rt.new_null()
	mut var_url := ''
	mut var_allow_css := rt.new_null()
	if !(deprecated == '') {
		rt.call_function('_deprecated_argument', [rt.new_string(@FN),
			rt.new_string('2.8.1')])
	}
	var_css = wp_kses_no_null(var_css.clone(), rt.new_null())
	var_css = rt.call_function('str_replace', [
		rt.create_array([rt.ArrayItem{ key: none, val: '\n' },
			rt.ArrayItem{ key: none, val: '\r' }, rt.ArrayItem{ key: none, val: '\t' }]),
		rt.new_string(''),
		var_css.clone(),
	])
	var_allowed_protocols = rt.call_function('wp_allowed_protocols', []rt.PhpVal{})
	var_css_array = rt.call_function('explode', [rt.new_string(';'),
		rt.new_string(var_css.clone().to_string().trim_space())])
	var_allowed_attr = rt.call_function('apply_filters', [
		rt.new_string('safe_style_css'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'background' },
			rt.ArrayItem{ key: none, val: 'background-color' },
			rt.ArrayItem{ key: none, val: 'background-image' },
			rt.ArrayItem{ key: none, val: 'background-position' },
			rt.ArrayItem{ key: none, val: 'background-repeat' },
			rt.ArrayItem{ key: none, val: 'background-size' },
			rt.ArrayItem{ key: none, val: 'background-attachment' },
			rt.ArrayItem{ key: none, val: 'background-blend-mode' },
			rt.ArrayItem{ key: none, val: 'border' }, rt.ArrayItem{ key: none, val: 'border-radius' },
			rt.ArrayItem{ key: none, val: 'border-width' }, rt.ArrayItem{
				key: none
				val: 'border-color'
			}, rt.ArrayItem{ key: none, val: 'border-style' },
			rt.ArrayItem{ key: none, val: 'border-right' }, rt.ArrayItem{
				key: none
				val: 'border-right-color'
			}, rt.ArrayItem{ key: none, val: 'border-right-style' },
			rt.ArrayItem{ key: none, val: 'border-right-width' },
			rt.ArrayItem{ key: none, val: 'border-bottom' }, rt.ArrayItem{
				key: none
				val: 'border-bottom-color'
			}, rt.ArrayItem{ key: none, val: 'border-bottom-left-radius' },
			rt.ArrayItem{ key: none, val: 'border-bottom-right-radius' },
			rt.ArrayItem{ key: none, val: 'border-bottom-style' },
			rt.ArrayItem{ key: none, val: 'border-bottom-width' },
			rt.ArrayItem{ key: none, val: 'border-bottom-right-radius' },
			rt.ArrayItem{ key: none, val: 'border-bottom-left-radius' },
			rt.ArrayItem{ key: none, val: 'border-left' }, rt.ArrayItem{
				key: none
				val: 'border-left-color'
			}, rt.ArrayItem{ key: none, val: 'border-left-style' },
			rt.ArrayItem{ key: none, val: 'border-left-width' },
			rt.ArrayItem{ key: none, val: 'border-top' }, rt.ArrayItem{
				key: none
				val: 'border-top-color'
			}, rt.ArrayItem{ key: none, val: 'border-top-left-radius' },
			rt.ArrayItem{ key: none, val: 'border-top-right-radius' },
			rt.ArrayItem{ key: none, val: 'border-top-style' },
			rt.ArrayItem{ key: none, val: 'border-top-width' },
			rt.ArrayItem{ key: none, val: 'border-top-left-radius' },
			rt.ArrayItem{ key: none, val: 'border-top-right-radius' },
			rt.ArrayItem{ key: none, val: 'border-spacing' },
			rt.ArrayItem{ key: none, val: 'border-collapse' },
			rt.ArrayItem{ key: none, val: 'caption-side' }, rt.ArrayItem{ key: none, val: 'columns' },
			rt.ArrayItem{ key: none, val: 'column-count' }, rt.ArrayItem{
				key: none
				val: 'column-fill'
			}, rt.ArrayItem{ key: none, val: 'column-gap' }, rt.ArrayItem{
				key: none
				val: 'column-rule'
			}, rt.ArrayItem{ key: none, val: 'column-span' },
			rt.ArrayItem{ key: none, val: 'column-width' }, rt.ArrayItem{ key: none, val: 'display' },
			rt.ArrayItem{ key: none, val: 'color' }, rt.ArrayItem{ key: none, val: 'filter' },
			rt.ArrayItem{ key: none, val: 'font' }, rt.ArrayItem{ key: none, val: 'font-family' },
			rt.ArrayItem{ key: none, val: 'font-size' }, rt.ArrayItem{ key: none, val: 'font-style' },
			rt.ArrayItem{ key: none, val: 'font-variant' }, rt.ArrayItem{
				key: none
				val: 'font-weight'
			}, rt.ArrayItem{ key: none, val: 'letter-spacing' },
			rt.ArrayItem{ key: none, val: 'line-height' }, rt.ArrayItem{
				key: none
				val: 'text-align'
			}, rt.ArrayItem{ key: none, val: 'text-decoration' },
			rt.ArrayItem{ key: none, val: 'text-indent' }, rt.ArrayItem{
				key: none
				val: 'text-transform'
			}, rt.ArrayItem{ key: none, val: 'white-space' },
			rt.ArrayItem{ key: none, val: 'height' }, rt.ArrayItem{ key: none, val: 'min-height' },
			rt.ArrayItem{ key: none, val: 'max-height' }, rt.ArrayItem{ key: none, val: 'width' },
			rt.ArrayItem{ key: none, val: 'min-width' }, rt.ArrayItem{ key: none, val: 'max-width' },
			rt.ArrayItem{ key: none, val: 'margin' }, rt.ArrayItem{ key: none, val: 'margin-right' },
			rt.ArrayItem{ key: none, val: 'margin-bottom' }, rt.ArrayItem{
				key: none
				val: 'margin-left'
			}, rt.ArrayItem{ key: none, val: 'margin-top' }, rt.ArrayItem{
				key: none
				val: 'margin-block-start'
			}, rt.ArrayItem{ key: none, val: 'margin-block-end' },
			rt.ArrayItem{ key: none, val: 'margin-inline-start' },
			rt.ArrayItem{ key: none, val: 'margin-inline-end' },
			rt.ArrayItem{ key: none, val: 'padding' }, rt.ArrayItem{ key: none, val: 'padding-right' },
			rt.ArrayItem{ key: none, val: 'padding-bottom' },
			rt.ArrayItem{ key: none, val: 'padding-left' }, rt.ArrayItem{
				key: none
				val: 'padding-top'
			}, rt.ArrayItem{ key: none, val: 'padding-block-start' },
			rt.ArrayItem{ key: none, val: 'padding-block-end' },
			rt.ArrayItem{ key: none, val: 'padding-inline-start' },
			rt.ArrayItem{ key: none, val: 'padding-inline-end' },
			rt.ArrayItem{ key: none, val: 'flex' }, rt.ArrayItem{ key: none, val: 'flex-basis' },
			rt.ArrayItem{ key: none, val: 'flex-direction' },
			rt.ArrayItem{ key: none, val: 'flex-flow' }, rt.ArrayItem{ key: none, val: 'flex-grow' },
			rt.ArrayItem{ key: none, val: 'flex-shrink' }, rt.ArrayItem{ key: none, val: 'flex-wrap' },
			rt.ArrayItem{ key: none, val: 'gap' }, rt.ArrayItem{ key: none, val: 'column-gap' },
			rt.ArrayItem{ key: none, val: 'row-gap' }, rt.ArrayItem{
				key: none
				val: 'grid-template-columns'
			}, rt.ArrayItem{ key: none, val: 'grid-auto-columns' },
			rt.ArrayItem{ key: none, val: 'grid-column-start' },
			rt.ArrayItem{ key: none, val: 'grid-column-end' },
			rt.ArrayItem{ key: none, val: 'grid-column' }, rt.ArrayItem{
				key: none
				val: 'grid-column-gap'
			}, rt.ArrayItem{ key: none, val: 'grid-template-rows' },
			rt.ArrayItem{ key: none, val: 'grid-auto-rows' },
			rt.ArrayItem{ key: none, val: 'grid-row-start' },
			rt.ArrayItem{ key: none, val: 'grid-row-end' }, rt.ArrayItem{ key: none, val: 'grid-row' },
			rt.ArrayItem{ key: none, val: 'grid-row-gap' }, rt.ArrayItem{ key: none, val: 'grid-gap' },
			rt.ArrayItem{ key: none, val: 'justify-content' },
			rt.ArrayItem{ key: none, val: 'justify-items' }, rt.ArrayItem{
				key: none
				val: 'justify-self'
			}, rt.ArrayItem{ key: none, val: 'align-content' },
			rt.ArrayItem{ key: none, val: 'align-items' }, rt.ArrayItem{
				key: none
				val: 'align-self'
			}, rt.ArrayItem{ key: none, val: 'clear' }, rt.ArrayItem{ key: none, val: 'cursor' },
			rt.ArrayItem{ key: none, val: 'direction' }, rt.ArrayItem{ key: none, val: 'float' },
			rt.ArrayItem{ key: none, val: 'list-style-type' },
			rt.ArrayItem{ key: none, val: 'object-fit' }, rt.ArrayItem{
				key: none
				val: 'object-position'
			}, rt.ArrayItem{ key: none, val: 'opacity' }, rt.ArrayItem{ key: none, val: 'overflow' },
			rt.ArrayItem{ key: none, val: 'vertical-align' },
			rt.ArrayItem{ key: none, val: 'writing-mode' }, rt.ArrayItem{ key: none, val: 'position' },
			rt.ArrayItem{ key: none, val: 'top' }, rt.ArrayItem{ key: none, val: 'right' },
			rt.ArrayItem{ key: none, val: 'bottom' }, rt.ArrayItem{ key: none, val: 'left' },
			rt.ArrayItem{ key: none, val: 'z-index' }, rt.ArrayItem{ key: none, val: 'box-shadow' },
			rt.ArrayItem{ key: none, val: 'aspect-ratio' }, rt.ArrayItem{
				key: none
				val: 'container-type'
			}, rt.ArrayItem{ key: none, val: '--*' }]),
	])
	var_css_url_data_types = ['background', 'background-image', 'cursor', 'filter', 'list-style',
		'list-style-image']
	var_css_gradient_data_types = ['background', 'background-image']
	if !rt.is_true(var_allowed_attr) {
		return var_css.clone()
	}
	var_css = rt.new_string('')
	mut iter_7 := var_css_array.iterator()
	for {
		item_7 := iter_7.next() or { break }
		mut var_css_item_shadow := item_7.val
		if rt.is_true(rt.identical(rt.new_string(''), var_css_item_shadow)) {
			continue
		}
		var_css_item_shadow = rt.new_string(var_css_item_shadow.trim_space())
		var_css_test_string = rt.new_string(var_css_item_shadow.str()).clone()
		var_found = false
		var_url_attr = rt.new_bool(false)
		var_gradient_attr = rt.new_bool(false)
		var_is_custom_var = false
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('str_contains', [
			var_css_item_shadow.clone(),
			rt.new_string(':'),
		])))))
		{
			var_found = true
		} else {
			var_parts = rt.call_function('explode', [rt.new_string(':'),
				var_css_item_shadow.clone(), rt.new_int(2)])
			var_css_selector = var_parts.array_get(0).to_string().trim_space()
			if rt.is_true(rt.new_bool(
				rt.is_true(rt.call_function('in_array', [rt.new_string('--*'), var_allowed_attr.clone(), rt.new_bool(true)]))
				&& rt.is_true(rt.call_function('preg_match', [rt.new_string('/^--[a-zA-Z0-9-_]+$/'), rt.new_string(var_css_selector.str()).clone()]))))
			{
				var_allowed_attr.array_push(var_css_selector)
				var_is_custom_var = true
			}
			if rt.is_true(rt.call_function('in_array', [rt.new_string(var_css_selector.str()).clone(),
				var_allowed_attr.clone(), rt.new_bool(true)]))
			{
				var_found = true
				var_url_attr = rt.call_function('in_array', [
					rt.new_string(var_css_selector.str()).clone(),
					rt.create_array_from_list(var_css_url_data_types),
					rt.new_bool(true)])
				var_gradient_attr = rt.call_function('in_array', [
					rt.new_string(var_css_selector.str()).clone(),
					rt.create_array_from_list(var_css_gradient_data_types),
					rt.new_bool(true)])
			}
			if var_is_custom_var {
				var_css_value = var_parts.array_get(1).to_string().trim_space()
				var_url_attr = rt.call_function('str_starts_with', [
					rt.new_string(var_css_value.str()).clone(),
					rt.new_string('url(')])
				var_gradient_attr = rt.call_function('str_contains', [
					rt.new_string(var_css_value.str()).clone(),
					rt.new_string('-gradient(')])
			}
		}
		if rt.is_true(rt.new_bool(var_found && rt.is_true(var_url_attr))) {
			rt.call_function('preg_match_all', [rt.new_string('/url\\([^)]+\\)/'),
				var_parts.array_get(1), rt.create_array_from_list(var_url_matches)])
			mut iter_8 := var_url_matches.array_get(0).iterator()
			for {
				item_8 := iter_8.next() or { break }
				mut var_url_match_shadow := item_8.val
				rt.call_function('preg_match', [
					rt.new_string('/^url\\(\\s*([\'\\"]?)(.*)(\\g1)\\s*\\)$/'),
					var_url_match_shadow.clone(),
					rt.create_array_from_list(var_url_pieces),
				])
				if !rt.is_true(var_url_pieces.array_get(2)) {
					var_found = false
					break
				}
				var_url = var_url_pieces.array_get(2).to_string().trim_space()
				if rt.is_true(rt.new_bool(var_url == ''
					|| rt.is_true(rt.new_bool(wp_kses_bad_protocol(var_url, var_allowed_protocols.clone()) != var_url))))
				{
					var_found = false
					break
				} else {
					var_css_test_string = rt.call_function('str_replace', [
						var_url_match_shadow.clone(), rt.new_string(''),
						var_css_test_string.clone()])
				}
			}
		}
		if rt.is_true(rt.new_bool(var_found && rt.is_true(var_gradient_attr))) {
			var_css_value = var_parts.array_get(1).to_string().trim_space()
			if rt.is_true(rt.call_function('preg_match', [
				rt.new_string('/^(repeating-)?(linear|radial|conic)-gradient\\(([^()]|rgb[a]?\\([^()]*\\))*\\)$/'),
				rt.new_string(var_css_value.str()).clone(),
			]))
			{
				var_css_test_string = rt.call_function('str_replace', [
					rt.new_string(var_css_value.str()).clone(),
					rt.new_string(''), var_css_test_string.clone()])
			}
		}
		if var_found {
			var_css_test_string = rt.call_function('preg_replace', [
				rt.new_string('/\\b(?:var|calc|min|max|minmax|clamp|repeat)(\\((?:[^()]|(?1))*\\))/'),
				rt.new_string(''),
				var_css_test_string.clone(),
			])
			var_allow_css = rt.new_bool(!(rt.is_true(rt.call_function('preg_match', [
				rt.new_string('%[\\\\(&=}]|/\\*%'),
				var_css_test_string.clone(),
			]))))
			var_allow_css = rt.call_function('apply_filters', [
				rt.new_string('safecss_filter_attr_allow_css'),
				var_allow_css.clone(),
				var_css_test_string.clone(),
			])
			if rt.is_true(var_allow_css) {
				if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), var_css)))) {
					var_css = rt.concat(var_css, rt.new_string(';'))
				}
				var_css = rt.concat(var_css, var_css_item_shadow)
			}
		}
	}
	return var_css.clone()
}

fn _wp_add_global_attributes(var_value_arg rt.PhpVal) rt.PhpVal {
	mut var_value := var_value_arg
	mut var_global_attributes := map[string]rt.PhpVal{}
	var_global_attributes = {
		'aria-controls':    true
		'aria-current':     true
		'aria-describedby': true
		'aria-details':     true
		'aria-expanded':    true
		'aria-hidden':      true
		'aria-label':       true
		'aria-labelledby':  true
		'aria-live':        true
		'class':            true
		'data-*':           true
		'dir':              true
		'hidden':           true
		'id':               true
		'lang':             true
		'style':            true
		'title':            true
		'role':             true
		'xml:lang':         true
	}
	if rt.is_true(rt.identical(rt.new_bool(true), var_value)) {
		var_value = rt.new_array()
	}
	if rt.is_true(rt.new_bool(var_value.clone().is_array())) {
		return rt.call_function('array_merge', [var_value.clone(),
			rt.create_array_from_native_map(var_global_attributes)])
	}
	return var_value.clone()
}

fn _wp_kses_allow_pdf_objects(var_url rt.PhpVal) bool {
	mut var_upload_info := rt.new_null()
	mut var_parsed_url := rt.new_null()
	mut var_upload_host := rt.new_null()
	mut var_upload_port := rt.new_null()
	if rt.is_true(rt.new_bool(
		rt.is_true(rt.call_function('str_contains', [var_url.clone(), rt.new_string('?')]))
		|| rt.is_true(rt.call_function('str_contains', [var_url.clone(), rt.new_string('#')]))))
	{
		return false
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('str_ends_with', [
		var_url.clone(), rt.new_string('.pdf')])))))
	{
		return false
	}
	var_upload_info = rt.call_function('wp_upload_dir', [rt.new_null(),
		rt.new_bool(false)])
	var_parsed_url = rt.call_function('wp_parse_url', [var_upload_info.array_get('url')])
	var_upload_host = if !(var_parsed_url.array_get('host')).is_null() {
		var_parsed_url.array_get('host')
	} else {
		rt.new_string('')
	}
	var_upload_port = rt.new_string((if var_parsed_url.array_isset(rt.new_string('port')) {
		':' + (var_parsed_url.array_get('port')).str()
	} else {
		''
	}).str())
	if rt.is_true(rt.new_bool(
		rt.is_true(rt.call_function('str_starts_with', [var_url.clone(), rt.new_string('http://${var_upload_host.to_string()}${var_upload_port.to_string()}/')]))
		|| rt.is_true(rt.call_function('str_starts_with', [var_url.clone(), rt.new_string('https://${var_upload_host.to_string()}${var_upload_port.to_string()}/')]))))
	{
		return true
	}
	return false
}

struct Class_WP_HTML_Tag_Processor {
	rt.PhpObjectBase
}

struct Class_WP_Theme_JSON {
	rt.PhpObjectBase
}

fn create_wp_html_tag_processor() &Class_WP_HTML_Tag_Processor {
	mut obj := &Class_WP_HTML_Tag_Processor{
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

fn (mut this Class_WP_HTML_Tag_Processor) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_HTML_Tag_Processor) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_HTML_Tag_Processor) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_GLOBALS := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('CUSTOM_TAGS'),
	])))))
	{
		rt.call_function('define', [rt.new_string('CUSTOM_TAGS'),
			rt.new_bool(false)])
	}
	mut var_allowedposttags := rt.get_superglobal('allowedposttags')
	mut var_allowedtags := rt.get_superglobal('allowedtags')
	mut var_allowedentitynames := rt.get_superglobal('allowedentitynames')
	mut var_allowedxmlentitynames := rt.get_superglobal('allowedxmlentitynames')
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.get_constant('CUSTOM_TAGS'))))) {
		var_allowedposttags = rt.create_array([
			rt.ArrayItem{ key: 'address', val: rt.new_array() },
			rt.ArrayItem{ key: 'a', val: rt.create_array([
				rt.ArrayItem{ key: 'href', val: true },
				rt.ArrayItem{ key: 'rel', val: true },
				rt.ArrayItem{ key: 'rev', val: true },
				rt.ArrayItem{ key: 'name', val: true },
				rt.ArrayItem{ key: 'target', val: true },
				rt.ArrayItem{ key: 'download', val: rt.create_array([
					rt.ArrayItem{ key: 'valueless', val: 'y' },
				]) },
			]) },
			rt.ArrayItem{ key: 'abbr', val: rt.new_array() },
			rt.ArrayItem{ key: 'acronym', val: rt.new_array() },
			rt.ArrayItem{ key: 'area', val: rt.create_array([
				rt.ArrayItem{ key: 'alt', val: true },
				rt.ArrayItem{ key: 'coords', val: true },
				rt.ArrayItem{ key: 'href', val: true },
				rt.ArrayItem{ key: 'nohref', val: true },
				rt.ArrayItem{ key: 'shape', val: true },
				rt.ArrayItem{ key: 'target', val: true },
			]) },
			rt.ArrayItem{ key: 'article', val: rt.create_array([
				rt.ArrayItem{ key: 'align', val: true },
			]) },
			rt.ArrayItem{ key: 'aside', val: rt.create_array([
				rt.ArrayItem{ key: 'align', val: true },
			]) },
			rt.ArrayItem{ key: 'audio', val: rt.create_array([
				rt.ArrayItem{ key: 'autoplay', val: true },
				rt.ArrayItem{ key: 'controls', val: true },
				rt.ArrayItem{ key: 'loop', val: true },
				rt.ArrayItem{ key: 'muted', val: true },
				rt.ArrayItem{ key: 'preload', val: true },
				rt.ArrayItem{ key: 'src', val: true },
			]) },
			rt.ArrayItem{ key: 'b', val: rt.new_array() },
			rt.ArrayItem{ key: 'bdo', val: rt.new_array() },
			rt.ArrayItem{ key: 'big', val: rt.new_array() },
			rt.ArrayItem{ key: 'blockquote', val: rt.create_array([
				rt.ArrayItem{ key: 'cite', val: true },
			]) },
			rt.ArrayItem{ key: 'br', val: rt.new_array() },
			rt.ArrayItem{ key: 'button', val: rt.create_array([
				rt.ArrayItem{ key: 'disabled', val: true },
				rt.ArrayItem{ key: 'name', val: true },
				rt.ArrayItem{ key: 'type', val: true },
				rt.ArrayItem{ key: 'value', val: true },
				rt.ArrayItem{ key: 'popovertarget', val: true },
				rt.ArrayItem{ key: 'popovertargetaction', val: true },
				rt.ArrayItem{ key: 'aria-haspopup', val: true },
			]) },
			rt.ArrayItem{ key: 'caption', val: rt.create_array([
				rt.ArrayItem{ key: 'align', val: true },
			]) },
			rt.ArrayItem{ key: 'cite', val: rt.new_array() },
			rt.ArrayItem{ key: 'code', val: rt.new_array() },
			rt.ArrayItem{ key: 'col', val: rt.create_array([
				rt.ArrayItem{ key: 'align', val: true },
				rt.ArrayItem{ key: 'char', val: true },
				rt.ArrayItem{ key: 'charoff', val: true },
				rt.ArrayItem{ key: 'span', val: true },
				rt.ArrayItem{ key: 'valign', val: true },
				rt.ArrayItem{ key: 'width', val: true },
			]) },
			rt.ArrayItem{ key: 'colgroup', val: rt.create_array([
				rt.ArrayItem{ key: 'align', val: true },
				rt.ArrayItem{ key: 'char', val: true },
				rt.ArrayItem{ key: 'charoff', val: true },
				rt.ArrayItem{ key: 'span', val: true },
				rt.ArrayItem{ key: 'valign', val: true },
				rt.ArrayItem{ key: 'width', val: true },
			]) },
			rt.ArrayItem{ key: 'data', val: rt.create_array([
				rt.ArrayItem{ key: 'value', val: true },
			]) },
			rt.ArrayItem{ key: 'del', val: rt.create_array([
				rt.ArrayItem{ key: 'datetime', val: true },
			]) },
			rt.ArrayItem{ key: 'dd', val: rt.new_array() },
			rt.ArrayItem{ key: 'dfn', val: rt.new_array() },
			rt.ArrayItem{ key: 'details', val: rt.create_array([
				rt.ArrayItem{ key: 'align', val: true },
				rt.ArrayItem{ key: 'open', val: true },
				rt.ArrayItem{ key: 'name', val: true },
			]) },
			rt.ArrayItem{ key: 'div', val: rt.create_array([
				rt.ArrayItem{ key: 'align', val: true },
				rt.ArrayItem{ key: 'popover', val: true },
			]) },
			rt.ArrayItem{ key: 'dialog', val: rt.create_array([
				rt.ArrayItem{ key: 'closedby', val: true },
				rt.ArrayItem{ key: 'open', val: true },
				rt.ArrayItem{ key: 'popover', val: true },
			]) },
			rt.ArrayItem{ key: 'dl', val: rt.new_array() },
			rt.ArrayItem{ key: 'dt', val: rt.new_array() },
			rt.ArrayItem{ key: 'em', val: rt.new_array() },
			rt.ArrayItem{ key: 'fieldset', val: rt.new_array() },
			rt.ArrayItem{ key: 'figure', val: rt.create_array([
				rt.ArrayItem{ key: 'align', val: true },
			]) },
			rt.ArrayItem{ key: 'figcaption', val: rt.create_array([
				rt.ArrayItem{ key: 'align', val: true },
			]) },
			rt.ArrayItem{ key: 'font', val: rt.create_array([
				rt.ArrayItem{ key: 'color', val: true },
				rt.ArrayItem{ key: 'face', val: true },
				rt.ArrayItem{ key: 'size', val: true },
			]) },
			rt.ArrayItem{ key: 'footer', val: rt.create_array([
				rt.ArrayItem{ key: 'align', val: true },
			]) },
			rt.ArrayItem{ key: 'h1', val: rt.create_array([
				rt.ArrayItem{ key: 'align', val: true },
			]) },
			rt.ArrayItem{ key: 'h2', val: rt.create_array([
				rt.ArrayItem{ key: 'align', val: true },
			]) },
			rt.ArrayItem{ key: 'h3', val: rt.create_array([
				rt.ArrayItem{ key: 'align', val: true },
			]) },
			rt.ArrayItem{ key: 'h4', val: rt.create_array([
				rt.ArrayItem{ key: 'align', val: true },
			]) },
			rt.ArrayItem{ key: 'h5', val: rt.create_array([
				rt.ArrayItem{ key: 'align', val: true },
			]) },
			rt.ArrayItem{ key: 'h6', val: rt.create_array([
				rt.ArrayItem{ key: 'align', val: true },
			]) },
			rt.ArrayItem{ key: 'header', val: rt.create_array([
				rt.ArrayItem{ key: 'align', val: true },
			]) },
			rt.ArrayItem{ key: 'hgroup', val: rt.create_array([
				rt.ArrayItem{ key: 'align', val: true },
			]) },
			rt.ArrayItem{ key: 'hr', val: rt.create_array([
				rt.ArrayItem{ key: 'align', val: true },
				rt.ArrayItem{ key: 'noshade', val: true },
				rt.ArrayItem{ key: 'size', val: true },
				rt.ArrayItem{ key: 'width', val: true },
			]) },
			rt.ArrayItem{ key: 'i', val: rt.new_array() },
			rt.ArrayItem{ key: 'img', val: rt.create_array([
				rt.ArrayItem{ key: 'alt', val: true },
				rt.ArrayItem{ key: 'align', val: true },
				rt.ArrayItem{ key: 'border', val: true },
				rt.ArrayItem{ key: 'height', val: true },
				rt.ArrayItem{ key: 'hspace', val: true },
				rt.ArrayItem{ key: 'loading', val: true },
				rt.ArrayItem{ key: 'longdesc', val: true },
				rt.ArrayItem{ key: 'vspace', val: true },
				rt.ArrayItem{ key: 'src', val: true },
				rt.ArrayItem{ key: 'usemap', val: true },
				rt.ArrayItem{ key: 'width', val: true },
			]) },
			rt.ArrayItem{ key: 'ins', val: rt.create_array([
				rt.ArrayItem{ key: 'datetime', val: true },
				rt.ArrayItem{ key: 'cite', val: true },
			]) },
			rt.ArrayItem{ key: 'kbd', val: rt.new_array() },
			rt.ArrayItem{ key: 'label', val: rt.create_array([
				rt.ArrayItem{ key: 'for', val: true },
			]) },
			rt.ArrayItem{ key: 'legend', val: rt.create_array([
				rt.ArrayItem{ key: 'align', val: true },
			]) },
			rt.ArrayItem{ key: 'li', val: rt.create_array([
				rt.ArrayItem{ key: 'align', val: true },
				rt.ArrayItem{ key: 'value', val: true },
			]) },
			rt.ArrayItem{ key: 'main', val: rt.create_array([
				rt.ArrayItem{ key: 'align', val: true },
			]) },
			rt.ArrayItem{ key: 'map', val: rt.create_array([
				rt.ArrayItem{ key: 'name', val: true },
			]) },
			rt.ArrayItem{ key: 'mark', val: rt.new_array() },
			rt.ArrayItem{ key: 'menu', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: true },
			]) },
			rt.ArrayItem{ key: 'meter', val: rt.create_array([
				rt.ArrayItem{ key: 'high', val: true },
				rt.ArrayItem{ key: 'low', val: true },
				rt.ArrayItem{ key: 'max', val: true },
				rt.ArrayItem{ key: 'min', val: true },
				rt.ArrayItem{ key: 'optimum', val: true },
				rt.ArrayItem{ key: 'value', val: true },
			]) },
			rt.ArrayItem{ key: 'nav', val: rt.create_array([
				rt.ArrayItem{ key: 'align', val: true },
			]) },
			rt.ArrayItem{ key: 'object', val: rt.create_array([
				rt.ArrayItem{ key: 'data', val: rt.create_array([
					rt.ArrayItem{ key: 'required', val: true },
					rt.ArrayItem{ key: 'value_callback', val: '_wp_kses_allow_pdf_objects' },
				]) },
				rt.ArrayItem{ key: 'type', val: rt.create_array([
					rt.ArrayItem{ key: 'required', val: true },
					rt.ArrayItem{ key: 'values', val: rt.create_array([
						rt.ArrayItem{ key: none, val: 'application/pdf' },
					]) },
				]) },
			]) },
			rt.ArrayItem{ key: 'p', val: rt.create_array([
				rt.ArrayItem{ key: 'align', val: true },
			]) },
			rt.ArrayItem{ key: 'pre', val: rt.create_array([
				rt.ArrayItem{ key: 'width', val: true },
			]) },
			rt.ArrayItem{ key: 'progress', val: rt.create_array([
				rt.ArrayItem{ key: 'max', val: true },
				rt.ArrayItem{ key: 'value', val: true },
			]) },
			rt.ArrayItem{ key: 'q', val: rt.create_array([
				rt.ArrayItem{ key: 'cite', val: true },
			]) },
			rt.ArrayItem{ key: 'rb', val: rt.new_array() },
			rt.ArrayItem{ key: 'rp', val: rt.new_array() },
			rt.ArrayItem{ key: 'rt', val: rt.new_array() },
			rt.ArrayItem{ key: 'rtc', val: rt.new_array() },
			rt.ArrayItem{ key: 'ruby', val: rt.new_array() },
			rt.ArrayItem{ key: 's', val: rt.new_array() },
			rt.ArrayItem{ key: 'samp', val: rt.new_array() },
			rt.ArrayItem{ key: 'search', val: rt.new_array() },
			rt.ArrayItem{ key: 'span', val: rt.create_array([
				rt.ArrayItem{ key: 'align', val: true },
			]) },
			rt.ArrayItem{ key: 'section', val: rt.create_array([
				rt.ArrayItem{ key: 'align', val: true },
			]) },
			rt.ArrayItem{ key: 'small', val: rt.new_array() },
			rt.ArrayItem{ key: 'strike', val: rt.new_array() },
			rt.ArrayItem{ key: 'strong', val: rt.new_array() },
			rt.ArrayItem{ key: 'sub', val: rt.new_array() },
			rt.ArrayItem{ key: 'summary', val: rt.create_array([
				rt.ArrayItem{ key: 'align', val: true },
			]) },
			rt.ArrayItem{ key: 'sup', val: rt.new_array() },
			rt.ArrayItem{ key: 'table', val: rt.create_array([
				rt.ArrayItem{ key: 'align', val: true },
				rt.ArrayItem{ key: 'bgcolor', val: true },
				rt.ArrayItem{ key: 'border', val: true },
				rt.ArrayItem{ key: 'cellpadding', val: true },
				rt.ArrayItem{ key: 'cellspacing', val: true },
				rt.ArrayItem{ key: 'rules', val: true },
				rt.ArrayItem{ key: 'summary', val: true },
				rt.ArrayItem{ key: 'width', val: true },
			]) },
			rt.ArrayItem{ key: 'tbody', val: rt.create_array([
				rt.ArrayItem{ key: 'align', val: true },
				rt.ArrayItem{ key: 'char', val: true },
				rt.ArrayItem{ key: 'charoff', val: true },
				rt.ArrayItem{ key: 'valign', val: true },
			]) },
			rt.ArrayItem{ key: 'td', val: rt.create_array([
				rt.ArrayItem{ key: 'abbr', val: true },
				rt.ArrayItem{ key: 'align', val: true },
				rt.ArrayItem{ key: 'axis', val: true },
				rt.ArrayItem{ key: 'bgcolor', val: true },
				rt.ArrayItem{ key: 'char', val: true },
				rt.ArrayItem{ key: 'charoff', val: true },
				rt.ArrayItem{ key: 'colspan', val: true },
				rt.ArrayItem{ key: 'headers', val: true },
				rt.ArrayItem{ key: 'height', val: true },
				rt.ArrayItem{ key: 'nowrap', val: true },
				rt.ArrayItem{ key: 'rowspan', val: true },
				rt.ArrayItem{ key: 'scope', val: true },
				rt.ArrayItem{ key: 'valign', val: true },
				rt.ArrayItem{ key: 'width', val: true },
			]) },
			rt.ArrayItem{ key: 'textarea', val: rt.create_array([
				rt.ArrayItem{ key: 'cols', val: true },
				rt.ArrayItem{ key: 'rows', val: true },
				rt.ArrayItem{ key: 'disabled', val: true },
				rt.ArrayItem{ key: 'name', val: true },
				rt.ArrayItem{ key: 'readonly', val: true },
			]) },
			rt.ArrayItem{ key: 'tfoot', val: rt.create_array([
				rt.ArrayItem{ key: 'align', val: true },
				rt.ArrayItem{ key: 'char', val: true },
				rt.ArrayItem{ key: 'charoff', val: true },
				rt.ArrayItem{ key: 'valign', val: true },
			]) },
			rt.ArrayItem{ key: 'th', val: rt.create_array([
				rt.ArrayItem{ key: 'abbr', val: true },
				rt.ArrayItem{ key: 'align', val: true },
				rt.ArrayItem{ key: 'axis', val: true },
				rt.ArrayItem{ key: 'bgcolor', val: true },
				rt.ArrayItem{ key: 'char', val: true },
				rt.ArrayItem{ key: 'charoff', val: true },
				rt.ArrayItem{ key: 'colspan', val: true },
				rt.ArrayItem{ key: 'headers', val: true },
				rt.ArrayItem{ key: 'height', val: true },
				rt.ArrayItem{ key: 'nowrap', val: true },
				rt.ArrayItem{ key: 'rowspan', val: true },
				rt.ArrayItem{ key: 'scope', val: true },
				rt.ArrayItem{ key: 'valign', val: true },
				rt.ArrayItem{ key: 'width', val: true },
			]) },
			rt.ArrayItem{ key: 'thead', val: rt.create_array([
				rt.ArrayItem{ key: 'align', val: true },
				rt.ArrayItem{ key: 'char', val: true },
				rt.ArrayItem{ key: 'charoff', val: true },
				rt.ArrayItem{ key: 'valign', val: true },
			]) },
			rt.ArrayItem{ key: 'time', val: rt.create_array([
				rt.ArrayItem{ key: 'datetime', val: true },
			]) },
			rt.ArrayItem{ key: 'title', val: rt.new_array() },
			rt.ArrayItem{ key: 'tr', val: rt.create_array([
				rt.ArrayItem{ key: 'align', val: true },
				rt.ArrayItem{ key: 'bgcolor', val: true },
				rt.ArrayItem{ key: 'char', val: true },
				rt.ArrayItem{ key: 'charoff', val: true },
				rt.ArrayItem{ key: 'valign', val: true },
			]) },
			rt.ArrayItem{ key: 'track', val: rt.create_array([
				rt.ArrayItem{ key: 'default', val: true },
				rt.ArrayItem{ key: 'kind', val: true },
				rt.ArrayItem{ key: 'label', val: true },
				rt.ArrayItem{ key: 'src', val: true },
				rt.ArrayItem{ key: 'srclang', val: true },
			]) },
			rt.ArrayItem{ key: 'tt', val: rt.new_array() },
			rt.ArrayItem{ key: 'u', val: rt.new_array() },
			rt.ArrayItem{ key: 'ul', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: true },
				rt.ArrayItem{ key: 'popover', val: true },
				rt.ArrayItem{ key: 'role', val: true },
			]) },
			rt.ArrayItem{ key: 'ol', val: rt.create_array([
				rt.ArrayItem{ key: 'start', val: true },
				rt.ArrayItem{ key: 'type', val: true },
				rt.ArrayItem{ key: 'reversed', val: true },
			]) },
			rt.ArrayItem{ key: 'var', val: rt.new_array() },
			rt.ArrayItem{ key: 'video', val: rt.create_array([
				rt.ArrayItem{ key: 'autoplay', val: true },
				rt.ArrayItem{ key: 'controls', val: true },
				rt.ArrayItem{ key: 'height', val: true },
				rt.ArrayItem{ key: 'loop', val: true },
				rt.ArrayItem{ key: 'muted', val: true },
				rt.ArrayItem{ key: 'playsinline', val: true },
				rt.ArrayItem{ key: 'poster', val: true },
				rt.ArrayItem{ key: 'preload', val: true },
				rt.ArrayItem{ key: 'src', val: true },
				rt.ArrayItem{ key: 'width', val: true },
			]) },
			rt.ArrayItem{ key: 'wbr', val: rt.new_array() },
		])
		mut var_math_global_attributes := {
			'displaystyle':   true
			'scriptlevel':    true
			'mathbackground': true
			'mathcolor':      true
			'mathsize':       true
			'class':          true
			'data-*':         true
			'dir':            true
			'id':             true
			'style':          true
		}
		mut var_math_overunder_attributes := {
			'accentunder': true
			'accent':      true
		}
		var_allowedposttags = rt.call_function('array_merge', [
			var_allowedposttags.clone(),
			rt.create_array([
				rt.ArrayItem{ key: 'math', val: rt.call_function('array_merge', [
					rt.create_array_from_native_map(var_math_global_attributes),
					rt.create_array([rt.ArrayItem{ key: 'display', val: true }]),
				]) },
				rt.ArrayItem{ key: 'mtext', val: var_math_global_attributes },
				rt.ArrayItem{ key: 'mi', val: rt.call_function('array_merge', [
					rt.create_array_from_native_map(var_math_global_attributes),
					rt.create_array([rt.ArrayItem{ key: 'mathvariant', val: true }]),
				]) },
				rt.ArrayItem{ key: 'mn', val: var_math_global_attributes },
				rt.ArrayItem{ key: 'mo', val: rt.call_function('array_merge', [
					rt.create_array_from_native_map(var_math_global_attributes),
					rt.create_array([rt.ArrayItem{ key: 'form', val: true },
						rt.ArrayItem{ key: 'fence', val: true },
						rt.ArrayItem{ key: 'separator', val: true },
						rt.ArrayItem{ key: 'lspace', val: true },
						rt.ArrayItem{ key: 'rspace', val: true },
						rt.ArrayItem{ key: 'stretchy', val: true },
						rt.ArrayItem{ key: 'symmetric', val: true },
						rt.ArrayItem{ key: 'maxsize', val: true },
						rt.ArrayItem{ key: 'minsize', val: true },
						rt.ArrayItem{ key: 'largeop', val: true },
						rt.ArrayItem{ key: 'movablelimits', val: true }]),
				]) },
				rt.ArrayItem{ key: 'mspace', val: rt.call_function('array_merge', [
					rt.create_array_from_native_map(var_math_global_attributes),
					rt.create_array([rt.ArrayItem{ key: 'width', val: true },
						rt.ArrayItem{ key: 'height', val: true },
						rt.ArrayItem{ key: 'depth', val: true }]),
				]) },
				rt.ArrayItem{ key: 'ms', val: var_math_global_attributes },
				rt.ArrayItem{ key: 'mrow', val: var_math_global_attributes },
				rt.ArrayItem{ key: 'mfrac', val: rt.call_function('array_merge', [
					rt.create_array_from_native_map(var_math_global_attributes),
					rt.create_array([rt.ArrayItem{ key: 'linethickness', val: true }]),
				]) },
				rt.ArrayItem{ key: 'msqrt', val: var_math_global_attributes },
				rt.ArrayItem{ key: 'mroot', val: var_math_global_attributes },
				rt.ArrayItem{ key: 'mstyle', val: var_math_global_attributes },
				rt.ArrayItem{ key: 'merror', val: var_math_global_attributes },
				rt.ArrayItem{ key: 'mpadded', val: rt.call_function('array_merge', [
					rt.create_array_from_native_map(var_math_global_attributes),
					rt.create_array([rt.ArrayItem{ key: 'width', val: true },
						rt.ArrayItem{ key: 'height', val: true },
						rt.ArrayItem{ key: 'depth', val: true },
						rt.ArrayItem{ key: 'lspace', val: true },
						rt.ArrayItem{ key: 'voffset', val: true }]),
				]) },
				rt.ArrayItem{ key: 'mphantom', val: var_math_global_attributes },
				rt.ArrayItem{ key: 'msub', val: var_math_global_attributes },
				rt.ArrayItem{ key: 'msup', val: var_math_global_attributes },
				rt.ArrayItem{ key: 'msubsup', val: var_math_global_attributes },
				rt.ArrayItem{ key: 'munder', val: rt.call_function('array_merge', [
					rt.create_array_from_native_map(var_math_global_attributes),
					rt.create_array_from_native_map(var_math_overunder_attributes),
				]) },
				rt.ArrayItem{ key: 'mover', val: rt.call_function('array_merge', [
					rt.create_array_from_native_map(var_math_global_attributes),
					rt.create_array_from_native_map(var_math_overunder_attributes),
				]) },
				rt.ArrayItem{ key: 'munderover', val: rt.call_function('array_merge', [
					rt.create_array_from_native_map(var_math_global_attributes),
					rt.create_array_from_native_map(var_math_overunder_attributes),
				]) },
				rt.ArrayItem{ key: 'mmultiscripts', val: var_math_global_attributes },
				rt.ArrayItem{ key: 'mprescripts', val: var_math_global_attributes },
				rt.ArrayItem{ key: 'mtable', val: rt.call_function('array_merge', [
					rt.create_array_from_native_map(var_math_global_attributes),
					rt.create_array([rt.ArrayItem{ key: 'columnalign', val: true },
						rt.ArrayItem{ key: 'rowspacing', val: true },
						rt.ArrayItem{ key: 'columnspacing', val: true },
						rt.ArrayItem{ key: 'align', val: true },
						rt.ArrayItem{ key: 'rowalign', val: true },
						rt.ArrayItem{ key: 'columnlines', val: true },
						rt.ArrayItem{ key: 'rowlines', val: true },
						rt.ArrayItem{ key: 'frame', val: true },
						rt.ArrayItem{ key: 'framespacing', val: true },
						rt.ArrayItem{ key: 'width', val: true }]),
				]) },
				rt.ArrayItem{ key: 'mtr', val: rt.call_function('array_merge', [
					rt.create_array_from_native_map(var_math_global_attributes),
					rt.create_array([rt.ArrayItem{ key: 'columnalign', val: true },
						rt.ArrayItem{ key: 'rowalign', val: true }]),
				]) },
				rt.ArrayItem{ key: 'mtd', val: rt.call_function('array_merge', [
					rt.create_array_from_native_map(var_math_global_attributes),
					rt.create_array([rt.ArrayItem{ key: 'columnspan', val: true },
						rt.ArrayItem{ key: 'rowspan', val: true },
						rt.ArrayItem{ key: 'columnalign', val: true },
						rt.ArrayItem{ key: 'rowalign', val: true }]),
				]) },
				rt.ArrayItem{ key: 'semantics', val: var_math_global_attributes },
				rt.ArrayItem{ key: 'annotation', val: rt.call_function('array_merge', [
					rt.create_array_from_native_map(var_math_global_attributes),
					rt.create_array([rt.ArrayItem{ key: 'encoding', val: true }]),
				]) },
				rt.ArrayItem{ key: 'menclose', val: rt.call_function('array_merge', [
					rt.create_array_from_native_map(var_math_global_attributes),
					rt.create_array([rt.ArrayItem{ key: 'notation', val: true }]),
				]) },
			])])
		var_allowedtags = rt.create_array([
			rt.ArrayItem{ key: 'a', val: rt.create_array([
				rt.ArrayItem{ key: 'href', val: true },
				rt.ArrayItem{ key: 'title', val: true },
			]) },
			rt.ArrayItem{ key: 'abbr', val: rt.create_array([
				rt.ArrayItem{ key: 'title', val: true },
			]) },
			rt.ArrayItem{ key: 'acronym', val: rt.create_array([
				rt.ArrayItem{ key: 'title', val: true },
			]) },
			rt.ArrayItem{ key: 'b', val: rt.new_array() },
			rt.ArrayItem{ key: 'blockquote', val: rt.create_array([
				rt.ArrayItem{ key: 'cite', val: true },
			]) },
			rt.ArrayItem{ key: 'cite', val: rt.new_array() },
			rt.ArrayItem{ key: 'code', val: rt.new_array() },
			rt.ArrayItem{ key: 'del', val: rt.create_array([
				rt.ArrayItem{ key: 'datetime', val: true },
			]) },
			rt.ArrayItem{ key: 'em', val: rt.new_array() },
			rt.ArrayItem{ key: 'i', val: rt.new_array() },
			rt.ArrayItem{ key: 'q', val: rt.create_array([
				rt.ArrayItem{ key: 'cite', val: true },
			]) },
			rt.ArrayItem{ key: 's', val: rt.new_array() },
			rt.ArrayItem{ key: 'strike', val: rt.new_array() },
			rt.ArrayItem{ key: 'strong', val: rt.new_array() },
		])
		var_allowedentitynames = ['nbsp', 'iexcl', 'cent', 'pound', 'curren', 'yen', 'brvbar',
			'sect', 'uml', 'copy', 'ordf', 'laquo', 'not', 'shy', 'reg', 'macr', 'deg', 'plusmn',
			'acute', 'micro', 'para', 'middot', 'cedil', 'ordm', 'raquo', 'iquest', 'Agrave',
			'Aacute', 'Acirc', 'Atilde', 'Auml', 'Aring', 'AElig', 'Ccedil', 'Egrave', 'Eacute',
			'Ecirc', 'Euml', 'Igrave', 'Iacute', 'Icirc', 'Iuml', 'ETH', 'Ntilde', 'Ograve', 'Oacute',
			'Ocirc', 'Otilde', 'Ouml', 'times', 'Oslash', 'Ugrave', 'Uacute', 'Ucirc', 'Uuml',
			'Yacute', 'THORN', 'szlig', 'agrave', 'aacute', 'acirc', 'atilde', 'auml', 'aring',
			'aelig', 'ccedil', 'egrave', 'eacute', 'ecirc', 'euml', 'igrave', 'iacute', 'icirc',
			'iuml', 'eth', 'ntilde', 'ograve', 'oacute', 'ocirc', 'otilde', 'ouml', 'divide',
			'oslash', 'ugrave', 'uacute', 'ucirc', 'uuml', 'yacute', 'thorn', 'yuml', 'quot', 'amp',
			'lt', 'gt', 'apos', 'OElig', 'oelig', 'Scaron', 'scaron', 'Yuml', 'circ', 'tilde',
			'ensp', 'emsp', 'thinsp', 'zwnj', 'zwj', 'lrm', 'rlm', 'ndash', 'mdash', 'lsquo', 'rsquo',
			'sbquo', 'ldquo', 'rdquo', 'bdquo', 'dagger', 'Dagger', 'permil', 'lsaquo', 'rsaquo',
			'euro', 'fnof', 'Alpha', 'Beta', 'Gamma', 'Delta', 'Epsilon', 'Zeta', 'Eta', 'Theta',
			'Iota', 'Kappa', 'Lambda', 'Mu', 'Nu', 'Xi', 'Omicron', 'Pi', 'Rho', 'Sigma', 'Tau',
			'Upsilon', 'Phi', 'Chi', 'Psi', 'Omega', 'alpha', 'beta', 'gamma', 'delta', 'epsilon',
			'zeta', 'eta', 'theta', 'iota', 'kappa', 'lambda', 'mu', 'nu', 'xi', 'omicron', 'pi',
			'rho', 'sigmaf', 'sigma', 'tau', 'upsilon', 'phi', 'chi', 'psi', 'omega', 'thetasym',
			'upsih', 'piv', 'bull', 'hellip', 'prime', 'Prime', 'oline', 'frasl', 'weierp', 'image',
			'real', 'trade', 'alefsym', 'larr', 'uarr', 'rarr', 'darr', 'harr', 'crarr', 'lArr',
			'uArr', 'rArr', 'dArr', 'hArr', 'forall', 'part', 'exist', 'empty', 'nabla', 'isin',
			'notin', 'ni', 'prod', 'sum', 'minus', 'lowast', 'radic', 'prop', 'infin', 'ang', 'and',
			'or', 'cap', 'cup', 'int', 'sim', 'cong', 'asymp', 'ne', 'equiv', 'le', 'ge', 'sub',
			'sup', 'nsub', 'sube', 'supe', 'oplus', 'otimes', 'perp', 'sdot', 'lceil', 'rceil',
			'lfloor', 'rfloor', 'lang', 'rang', 'loz', 'spades', 'clubs', 'hearts', 'diams', 'sup1',
			'sup2', 'sup3', 'frac14', 'frac12', 'frac34', 'there4']
		var_allowedxmlentitynames = ['amp', 'lt', 'gt', 'apos', 'quot']
		var_allowedposttags = rt.call_function('array_map', [
			rt.new_string('_wp_add_global_attributes'),
			var_allowedposttags.clone(),
		])
	} else {
		mut var_required_kses_globals := ['allowedposttags', 'allowedtags', 'allowedentitynames',
			'allowedxmlentitynames']
		mut var_missing_kses_globals := rt.new_array()
		for var_global_name in var_required_kses_globals {
			if rt.is_true(rt.new_bool(!(var_GLOBALS.array_isset(rt.new_string(global_name)))
				|| rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_GLOBALS.array_get(global_name).is_array())))))))
			{
				var_missing_kses_globals << '<code>$' + global_name + '</code>'
			}
		}
		if rt.is_true(var_missing_kses_globals) {
			rt.call_function('_doing_it_wrong', [rt.new_string('wp_kses_allowed_html'),
				rt.call_function('sprintf', [
					rt.call_function('__', [
						rt.new_string('When using the %1$s constant, make sure to set these globals to an array: %2$s.'),
					]),
					rt.new_string('<code>CUSTOM_TAGS</code>'),
					rt.call_function('implode', [
						rt.new_string(', '),
						rt.create_array_from_list(var_missing_kses_globals),
					]),
				]),
				rt.new_string('6.2.0')])
		}
		var_allowedtags = wp_kses_array_lc(var_allowedtags.clone())
		var_allowedposttags = wp_kses_array_lc(var_allowedposttags.clone())
	}
}
