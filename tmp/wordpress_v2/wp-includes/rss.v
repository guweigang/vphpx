import rt
import crypto.md5

const global_const_rss = 'RSS'
const global_const_atom = 'Atom'
const global_const_magpie_user_agent = 'WordPress/' +
	(var_GLOBALS.array_get(rt.new_string('wp_version'))).str()
const global_const_magpie_user_agent = var_ua

struct Class_MagpieRSS {
	rt.PhpObjectBase
pub mut:
	parser              rt.PhpVal = rt.new_null()
	current_item        rt.PhpVal = rt.new_array()
	items               rt.PhpVal = rt.new_array()
	channel             rt.PhpVal = rt.new_array()
	textinput           rt.PhpVal = rt.new_array()
	image               rt.PhpVal = rt.new_array()
	feed_type           string
	feed_version        rt.PhpVal = rt.new_null()
	stack               rt.PhpVal = rt.new_array()
	inchannel           bool
	initem              bool
	incontent           rt.PhpVal = rt.new_bool(false)
	intextinput         bool
	inimage             bool
	current_field       rt.PhpVal = rt.new_string('')
	current_namespace   rt.PhpVal = rt.new_bool(false)
	_CONTENT_CONSTRUCTS rt.PhpVal = rt.new_array()
}

fn (mut this Class_MagpieRSS) construct(var_source rt.PhpVal) {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('xml_parser_create'),
	])))))
	{
		rt.call_function('wp_trigger_error', [rt.new_string(''),
			rt.new_string("PHP's XML extension is not available. Please contact your hosting provider to enable PHP's XML extension.")])
		return
	}
	mut var_parser := rt.call_function('xml_parser_create', []rt.PhpVal{})
	this.parser = var_parser.clone()
	rt.call_function('xml_set_element_handler', [this.parser,
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('MagpieRSS', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'feed_start_element' },
		]),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('MagpieRSS', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'feed_end_element' },
		])])
	rt.call_function('xml_set_character_data_handler', [this.parser,
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('MagpieRSS', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'feed_cdata' },
		])])
	mut var_status := rt.call_function('xml_parse', [this.parser, var_source.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_status)))) {
		mut var_errorcode := rt.call_function('xml_get_error_code', [this.parser])
		if rt.is_true(rt.new_bool(!rt.is_true(rt.equal(var_errorcode,
			rt.get_constant('XML_ERROR_NONE')))))
		{
			mut var_xml_error := rt.call_function('xml_error_string', [
				var_errorcode.clone()])
			mut var_error_line := rt.call_function('xml_get_current_line_number', [
				this.parser,
			])
			mut var_error_col := rt.call_function('xml_get_current_column_number', [
				this.parser,
			])
			mut var_errormsg :=
				rt.new_string('${var_xml_error.to_string()} at line ${var_error_line.to_string()}, column ${var_error_col.to_string()}')
			this.error(var_errormsg.clone(), rt.new_null())
		}
	}
	if rt.is_true(rt.less(rt.get_constant('PHP_VERSION_ID'), rt.new_int(80000))) {
		rt.call_function('xml_parser_free', [this.parser])
	}
	this.parser = rt.new_null()
	this.normalize()
}

fn (mut this Class_MagpieRSS) magpierss(var_source rt.PhpVal) {
	mut iife_temp_0 := Class_MagpieRSS{}
	iife_temp_0.construct(var_source.clone())
	rt.new_null()
}

fn (mut this Class_MagpieRSS) feed_start_element(var_p rt.PhpVal, var_element rt.PhpVal, var_attrs rt.PhpVal) {
	mut var_element_mutated := var_element
	mut var_attrs_mutated := var_attrs
	var_element_mutated = rt.new_string(var_element_mutated.clone().to_string().to_lower())
	mut var_el := var_element_mutated
	var_attrs_mutated = rt.call_function('array_change_key_case', [
		var_attrs_mutated.clone(), rt.get_constant('CASE_LOWER')])
	mut var_ns := rt.new_bool(false)
	if rt.is_true(rt.call_function('strpos', [var_element_mutated.clone(),
		rt.new_string(':')]))
	{
		mut list_tmp_1 := rt.call_function('explode', [rt.new_string(':'),
			var_element_mutated.clone(), rt.new_int(2)])
		var_ns = list_tmp_1.array_get(0)
		var_el = list_tmp_1.array_get(1)
	}
	if rt.is_true(var_ns)
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.equal(var_ns, rt.new_string('rdf'))))) {
		this.current_namespace = var_ns.clone()
	}
	if !(!(this.feed_type).is_null()) {
		if rt.is_true(rt.equal(var_el, rt.new_string('rdf'))) {
			this.feed_type = global_const_rss
			this.feed_version = rt.new_string('1.0')
		} else if rt.is_true(rt.equal(var_el, rt.new_string('rss'))) {
			this.feed_type = global_const_rss
			this.feed_version = var_attrs_mutated.array_get(rt.new_string('version'))
		} else if rt.is_true(rt.equal(var_el, rt.new_string('feed'))) {
			this.feed_type = global_const_atom
			this.feed_version = var_attrs_mutated.array_get(rt.new_string('version'))
			this.inchannel = true
		}
		return
	}
	if rt.is_true(rt.equal(var_el, rt.new_string('channel'))) {
		this.inchannel = true
	} else if rt.is_true(rt.equal(var_el, rt.new_string('item')))
		|| rt.is_true(rt.equal(var_el, rt.new_string('entry'))) {
		this.initem = true
		if var_attrs_mutated.array_isset(rt.new_string('rdf:about')) {
			this.current_item.array_set('about',
				var_attrs_mutated.array_get(rt.new_string('rdf:about')))
		}
	} else if rt.is_true(rt.equal(this.feed_type, rt.new_string(global_const_rss)))
		&& rt.is_true(rt.equal(this.current_namespace, rt.new_string('')))
		&& rt.is_true(rt.equal(var_el, rt.new_string('textinput'))) {
		this.intextinput = true
	} else if rt.is_true(rt.equal(this.feed_type, rt.new_string(global_const_rss)))
		&& rt.is_true(rt.equal(this.current_namespace, rt.new_string('')))
		&& rt.is_true(rt.equal(var_el, rt.new_string('image'))) {
		this.inimage = true
	} else if rt.is_true(rt.equal(this.feed_type, rt.new_string(global_const_atom)))
		&& rt.is_true(rt.call_function('in_array', [var_el.clone(), this._CONTENT_CONSTRUCTS])) {
		if rt.is_true(rt.equal(var_el, rt.new_string('content'))) {
			var_el = rt.new_string('atom_content')
		}
		this.incontent = var_el.clone()
	} else if rt.is_true(rt.equal(this.feed_type, rt.new_string(global_const_atom)))
		&& rt.is_true(this.incontent) {
		mut var_attrs_str := rt.call_function('join', [rt.new_string(' '),
			rt.call_function('array_map', [
				rt.create_array([rt.ArrayItem{ key: none, val: 'MagpieRSS' },
					rt.ArrayItem{ key: none, val: 'map_attrs' }]),
				rt.func_array_keys(var_attrs_mutated.clone()),
				rt.call_function('array_values', [var_attrs_mutated.clone()]),
			])])
		this.append_content(rt.new_string('<${var_element.to_string()} ${var_attrs_str.to_string()}>'))
		rt.call_function('array_unshift', [this.stack, var_el.clone()])
	} else if rt.is_true(rt.equal(this.feed_type, rt.new_string(global_const_atom)))
		&& rt.is_true(rt.equal(var_el, rt.new_string('link'))) {
		if var_attrs_mutated.array_isset(rt.new_string('rel'))
			&& rt.is_true(rt.equal(var_attrs_mutated.array_get(rt.new_string('rel')), rt.new_string('alternate'))) {
			mut var_link_el := rt.new_string('link')
		} else {
			var_link_el = rt.new_string('link_' +
				(var_attrs_mutated.array_get(rt.new_string('rel'))).str())
		}
		this.append(var_link_el.clone(), var_attrs_mutated.array_get(rt.new_string('href')))
	} else {
		rt.call_function('array_unshift', [this.stack, var_el.clone()])
	}
}

fn (mut this Class_MagpieRSS) feed_cdata(var_p rt.PhpVal, var_text rt.PhpVal) {
	if rt.is_true(rt.equal(this.feed_type, rt.new_string(global_const_atom)))
		&& rt.is_true(this.incontent) {
		this.append_content(var_text.clone())
	} else {
		mut var_current_el := rt.call_function('join', [rt.new_string('_'),
			rt.call_function('array_reverse', [this.stack])])
		this.append(var_current_el.clone(), var_text.clone())
	}
}

fn (mut this Class_MagpieRSS) feed_end_element(var_p rt.PhpVal, var_el rt.PhpVal) {
	mut var_el_mutated := var_el
	var_el_mutated = rt.new_string(var_el_mutated.clone().to_string().to_lower())
	if rt.is_true(rt.equal(var_el_mutated, rt.new_string('item')))
		|| rt.is_true(rt.equal(var_el_mutated, rt.new_string('entry'))) {
		this.items.array_push(this.current_item)
		this.current_item = rt.new_array()
		this.initem = false
	} else if rt.is_true(rt.equal(this.feed_type, rt.new_string(global_const_rss)))
		&& rt.is_true(rt.equal(this.current_namespace, rt.new_string('')))
		&& rt.is_true(rt.equal(var_el_mutated, rt.new_string('textinput'))) {
		this.intextinput = false
	} else if rt.is_true(rt.equal(this.feed_type, rt.new_string(global_const_rss)))
		&& rt.is_true(rt.equal(this.current_namespace, rt.new_string('')))
		&& rt.is_true(rt.equal(var_el_mutated, rt.new_string('image'))) {
		this.inimage = false
	} else if rt.is_true(rt.equal(this.feed_type, rt.new_string(global_const_atom)))
		&& rt.is_true(rt.call_function('in_array', [var_el_mutated.clone(), this._CONTENT_CONSTRUCTS])) {
		this.incontent = rt.new_bool(false)
	} else if rt.is_true(rt.equal(var_el_mutated, rt.new_string('channel')))
		|| rt.is_true(rt.equal(var_el_mutated, rt.new_string('feed'))) {
		this.inchannel = false
	} else if rt.is_true(rt.equal(this.feed_type, rt.new_string(global_const_atom)))
		&& rt.is_true(this.incontent) {
		if rt.is_true(rt.equal(this.stack.array_get(rt.new_int(0)), var_el_mutated)) {
			this.append_content(rt.new_string('</${var_el.to_string()}>'))
		} else {
			this.append_content(rt.new_string('<${var_el.to_string()} />'))
		}
		rt.call_function('array_shift', [this.stack])
	} else {
		rt.call_function('array_shift', [this.stack])
	}
	this.current_namespace = rt.new_bool(false)
}

fn (mut this Class_MagpieRSS) concat(var_str1 rt.PhpVal, str2 string) {
	mut var_str1_mutated := var_str1
	if !(!var_str1_mutated.is_null()) {
		var_str1_mutated = rt.new_string('')
	}
	var_str1_mutated = rt.concat(var_str1_mutated, rt.new_string(str2))
}

fn (mut this Class_MagpieRSS) append_content(var_text rt.PhpVal) {
	if this.initem {
		this.concat(this.current_item.array_get(this.incontent), var_text.str())
	} else if this.inchannel {
		this.concat(this.channel.array_get(this.incontent), var_text.str())
	}
}

fn (mut this Class_MagpieRSS) append(var_el rt.PhpVal, var_text rt.PhpVal) {
	mut var_el_mutated := var_el
	if rt.is_true(rt.new_bool(!(rt.is_true(var_el_mutated)))) {
		return
	}
	if rt.is_true(this.current_namespace) {
		if this.initem {
			this.concat(this.current_item.array_get(this.current_namespace).array_get(var_el_mutated),
				var_text.str())
		} else if this.inchannel {
			this.concat(this.channel.array_get(this.current_namespace).array_get(var_el_mutated),
				var_text.str())
		} else if this.intextinput {
			this.concat(this.textinput.array_get(this.current_namespace).array_get(var_el_mutated),
				var_text.str())
		} else if this.inimage {
			this.concat(this.image.array_get(this.current_namespace).array_get(var_el_mutated),
				var_text.str())
		}
	} else {
		if this.initem {
			this.concat(this.current_item.array_get(var_el_mutated), var_text.str())
		} else if this.intextinput {
			this.concat(this.textinput.array_get(var_el_mutated), var_text.str())
		} else if this.inimage {
			this.concat(this.image.array_get(var_el_mutated), var_text.str())
		} else if this.inchannel {
			this.concat(this.channel.array_get(var_el_mutated), var_text.str())
		}
	}
}

fn (mut this Class_MagpieRSS) normalize() {
	if this.is_atom() {
		this.channel.array_set('description', this.channel.array_get(rt.new_string('tagline')))
		mut var_i := rt.new_int(0)
		for {
			if !(rt.is_true(rt.less(var_i, rt.new_int(this.items.array_count())))) { break
			 }
			mut var_item := this.items.array_get(var_i)
			if var_item.array_isset(rt.new_string('summary')) {
				var_item.array_set('description', var_item.array_get(rt.new_string('summary')))
			}
			if var_item.array_isset(rt.new_string('atom_content')) {
				var_item.array_get_mut('content').array_set('encoded',
					var_item.array_get(rt.new_string('atom_content')))
			}
			this.items.array_set(var_i, var_item.clone())
			rt.post_inc(var_i)
		}
	} else if this.is_rss() {
		this.channel.array_set('tagline', this.channel.array_get(rt.new_string('description')))
		var_i = rt.new_int(0)
		for {
			if !(rt.is_true(rt.less(var_i, rt.new_int(this.items.array_count())))) { break
			 }
			var_item = this.items.array_get(var_i)
			if var_item.array_isset(rt.new_string('description')) {
				var_item.array_set('summary', var_item.array_get(rt.new_string('description')))
			}
			if var_item.array_get(rt.new_string('content')).array_isset(rt.new_string('encoded')) {
				var_item.array_set('atom_content',
					var_item.array_get(rt.new_string('content')).array_get(rt.new_string('encoded')))
			}
			this.items.array_set(var_i, var_item.clone())
			rt.post_inc(var_i)
		}
	}
}

fn (mut this Class_MagpieRSS) is_rss() bool {
	if rt.is_true(rt.equal(this.feed_type, rt.new_string(global_const_rss))) {
		return (this.feed_version).to_bool()
	} else {
		return false
	}
	return false
}

fn (mut this Class_MagpieRSS) is_atom() bool {
	if rt.is_true(rt.equal(this.feed_type, rt.new_string(global_const_atom))) {
		return (this.feed_version).to_bool()
	} else {
		return false
	}
	return false
}

fn (mut this Class_MagpieRSS) map_attrs(var_k rt.PhpVal, var_v rt.PhpVal) string {
	return "${var_k.to_string()}=\"${var_v.to_string()}\""
}

fn (mut this Class_MagpieRSS) error(var_errormsg rt.PhpVal, var_lvl rt.PhpVal) {
	mut var_errormsg_mutated := var_errormsg
	if rt.is_true(rt.get_constant('MAGPIE_DEBUG')) {
		rt.call_function('wp_trigger_error', [rt.new_string(''),
			var_errormsg_mutated.clone(), var_lvl.clone()])
	} else {
		rt.call_function('error_log', [var_errormsg_mutated.clone(),
			rt.new_int(0)])
	}
}

fn fetch_rss(var_url rt.PhpVal) bool {
	mut var_resp := rt.new_null()
	mut var_cache := rt.new_null()
	mut var_cache_status := rt.new_null()
	mut var_request_headers := map[string]rt.PhpVal{}
	mut var_rss := rt.new_null()
	mut var_errormsg := rt.new_null()
	mut var_http_error := rt.new_null()
	init()
	if !(!var_url.is_null()) {
		return false
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.get_constant('MAGPIE_CACHE_ON'))))) {
		var_resp = _fetch_remote_file(var_url.clone(), '')
		if rt.is_true(rt.new_bool(is_success(rt.get_property(var_resp, 'status')))) {
			return _response_to_rss(var_resp.clone())
		} else {
			return false
		}
	} else {
		var_cache = create_rsscache(rt.get_constant('MAGPIE_CACHE_DIR'),
			rt.get_constant('MAGPIE_CACHE_AGE'))
		if rt.is_true(rt.get_constant('MAGPIE_DEBUG'))
			&& rt.is_true(rt.get_property(var_cache, 'ERROR')) {
			rt.call_function('debug', [rt.get_property(var_cache, 'ERROR'),
				rt.get_constant('E_USER_WARNING')])
		}
		var_cache_status = rt.new_int(0)
		var_request_headers = rt.new_array()
		var_rss = rt.new_int(0)
		var_errormsg = rt.new_int(0)
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.get_property(var_cache, 'ERROR'))))) {
			var_cache_status = var_cache.check_cache(var_url.clone())
		}
		if rt.is_true(rt.equal(var_cache_status, rt.new_string('HIT'))) {
			var_rss = var_cache.get(var_url.clone())
			if !var_rss.is_null() && rt.is_true(var_rss) {
				rt.set_property(var_rss, 'from_cache', rt.new_int(1))
				if rt.is_true(rt.greater(rt.get_constant('MAGPIE_DEBUG'), rt.new_int(1))) {
					rt.call_function('debug', [rt.new_string('MagpieRSS: Cache HIT'),
						rt.get_constant('E_USER_NOTICE')])
				}
				return var_rss.to_bool()
			}
		}
		if rt.is_true(rt.equal(var_cache_status, rt.new_string('STALE'))) {
			var_rss = var_cache.get(var_url.clone())
			if !(rt.get_property(var_rss, 'etag')).is_null()
				&& rt.is_true(rt.get_property(var_rss, 'last_modified')) {
				var_request_headers['If-None-Match'] = rt.get_property(var_rss, 'etag')
				var_request_headers['If-Last-Modified'] = rt.get_property(var_rss, 'last_modified')
			}
		}
		var_resp = _fetch_remote_file(var_url.clone(),
			rt.create_array_from_native_map(var_request_headers))
		if !var_resp.is_null() && rt.is_true(var_resp) {
			if rt.is_true(rt.equal(rt.get_property(var_resp, 'status'), rt.new_string('304'))) {
				if rt.is_true(rt.greater(rt.get_constant('MAGPIE_DEBUG'), rt.new_int(1))) {
					rt.call_function('debug', [
						rt.new_string('Got 304 for ${var_url.to_string()}'),
					])
				}
				var_cache.set(var_url.clone(), var_rss.clone())
				return var_rss.to_bool()
			} else if rt.is_true(rt.new_bool(is_success(rt.get_property(var_resp, 'status')))) {
				var_rss = rt.new_bool(_response_to_rss(var_resp.clone()))
				if rt.is_true(var_rss) {
					if rt.is_true(rt.greater(rt.get_constant('MAGPIE_DEBUG'), rt.new_int(1))) {
						rt.call_function('debug', [rt.new_string('Fetch successful')])
					}
					var_cache.set(var_url.clone(), var_rss.clone())
					return var_rss.to_bool()
				}
			} else {
				var_errormsg = rt.new_string('Failed to fetch ${var_url.to_string()}. ')
				if rt.is_true(rt.get_property(var_resp, 'error')) {
					var_http_error = rt.call_function('substr', [
						rt.get_property(var_resp, 'error'),
						rt.new_int(0),
						rt.new_int(-2),
					])
					var_errormsg = rt.concat(var_errormsg,
						rt.new_string('(HTTP Error: ${var_http_error.to_string()})'))
				} else {
					var_errormsg = rt.concat(var_errormsg, rt.new_string('(HTTP Response: ' +
						(rt.get_property(var_resp, 'response_code')).str() + ')'))
				}
			}
		} else {
			var_errormsg = rt.new_string('Unable to retrieve RSS file for unknown reasons.')
		}
		if rt.is_true(var_rss) {
			if rt.is_true(rt.get_constant('MAGPIE_DEBUG')) {
				rt.call_function('debug', [
					rt.new_string('Returning STALE object for ${var_url.to_string()}'),
				])
			}
			return var_rss.to_bool()
		}
		return false
	}
	return false
}

fn _fetch_remote_file(var_url rt.PhpVal, headers string) rt.PhpVal {
	mut var_headers := headers
	mut var_resp := rt.new_null()
	mut var_error := rt.new_null()
	mut var_return_headers := []rt.PhpVal{}
	mut var_value := rt.new_null()
	mut var_key := rt.new_null()
	mut var_v := rt.new_null()
	mut var_response := rt.new_null()
	var_resp = rt.call_function('wp_safe_remote_request', [var_url.clone(),
		rt.create_array([rt.ArrayItem{ key: 'headers', val: headers },
			rt.ArrayItem{ key: 'timeout', val: rt.get_constant('MAGPIE_FETCH_TIME_OUT') }])])
	if rt.is_true(rt.call_function('is_wp_error', [var_resp.clone()])) {
		var_error = rt.call_function('array_shift', [rt.get_property(var_resp, 'errors')])
		var_resp = create_stdclass()
		rt.set_property(var_resp, 'status', rt.new_int(500))
		rt.set_property(var_resp, 'response_code', rt.new_int(500))
		rt.set_property(var_resp, 'error', (var_error.array_get(rt.new_int(0))).str() + '\n')
		return mut rt.cast_object_ptr[Class_stdClass](var_resp)
	}
	var_return_headers = rt.new_array()
	mut iter_1 := rt.call_function('wp_remote_retrieve_headers', [
		var_resp.clone()]).iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_value_shadow := item_1.val
		mut var_key_shadow := item_1.key
		if !(var_value_shadow.clone().is_array()) {
			var_return_headers << '${var_key.to_string()}: ${var_value.to_string()}'
		} else {
			mut iter_2 := var_value_shadow.iterator()
			for {
				item_2 := iter_2.next() or { break }
				mut var_v_shadow := item_2.val
				var_return_headers << '${var_key.to_string()}: ${var_v.to_string()}'
			}
		}
	}
	var_response = create_stdclass()
	rt.set_property(var_response, 'status', rt.call_function('wp_remote_retrieve_response_code', [
		var_resp.clone(),
	]))
	rt.set_property(var_response, 'response_code', rt.call_function('wp_remote_retrieve_response_code', [
		var_resp.clone(),
	]))
	rt.set_property(var_response, 'headers', var_return_headers.clone())
	rt.set_property(var_response, 'results', rt.call_function('wp_remote_retrieve_body', [
		var_resp.clone(),
	]))
	return mut var_response
}

fn _response_to_rss(var_resp rt.PhpVal) bool {
	mut var_rss := rt.new_null()
	mut var_h := rt.new_null()
	mut var_field := rt.new_null()
	mut var_val := ''
	mut var_errormsg := ''
	var_rss = create_magpierss(rt.get_property(var_resp, 'results'))
	if rt.is_true(var_rss) && !(!(rt.get_property(var_rss, 'ERROR')).is_null())
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.get_property(var_rss, 'ERROR'))))) {
		mut iter_3 := rt.cast_array(rt.get_property(var_resp, 'headers')).iterator()
		for {
			item_3 := iter_3.next() or { break }
			mut var_h_shadow := item_3.val
			if rt.is_true(rt.call_function('strpos', [var_h_shadow.clone(),
				rt.new_string(': ')]))
			{
				mut list_tmp_2 := rt.call_function('explode', [
					rt.new_string(': '), var_h_shadow.clone(),
					rt.new_int(2)])
				var_field = list_tmp_2.array_get(0)
				var_val = list_tmp_2.array_get(1)
			} else {
				var_field = var_h_shadow
				var_val = ''
			}
			if rt.is_true(rt.equal(var_field, rt.new_string('etag'))) {
				rt.set_property(var_rss, 'etag', rt.new_string(var_val.str()).clone())
			}
			if rt.is_true(rt.equal(var_field, rt.new_string('last-modified'))) {
				rt.set_property(var_rss, 'last_modified', rt.new_string(var_val.str()).clone())
			}
		}
		return var_rss.to_bool()
	} else {
		var_errormsg = 'Failed to parse RSS file.'
		if rt.is_true(var_rss) {
			var_errormsg = var_errormsg + ' (' + (rt.get_property(var_rss, 'ERROR')).str() + ')'
		}
		return false
	}
	return false
}

fn init() {
	mut var_GLOBALS := rt.new_null()
	mut var_ua := rt.new_null()
	if rt.is_true(rt.call_function('defined', [rt.new_string('MAGPIE_INITALIZED')])) {
		return
	} else {
		rt.call_function('define', [rt.new_string('MAGPIE_INITALIZED'),
			rt.new_int(1)])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('MAGPIE_CACHE_ON'),
	])))))
	{
		rt.call_function('define', [rt.new_string('MAGPIE_CACHE_ON'),
			rt.new_int(1)])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('MAGPIE_CACHE_DIR'),
	])))))
	{
		rt.call_function('define', [rt.new_string('MAGPIE_CACHE_DIR'),
			rt.new_string('./cache')])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('MAGPIE_CACHE_AGE'),
	])))))
	{
		rt.call_function('define', [rt.new_string('MAGPIE_CACHE_AGE'),
			rt.new_int(60 * 60)])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('MAGPIE_CACHE_FRESH_ONLY'),
	])))))
	{
		rt.call_function('define', [rt.new_string('MAGPIE_CACHE_FRESH_ONLY'),
			rt.new_int(0)])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('MAGPIE_DEBUG'),
	])))))
	{
		rt.call_function('define', [rt.new_string('MAGPIE_DEBUG'),
			rt.new_int(0)])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('MAGPIE_USER_AGENT'),
	])))))
	{
		var_ua = rt.new_string('WordPress/' +
			(var_GLOBALS.array_get(rt.new_string('wp_version'))).str())
		if rt.is_true(rt.get_constant('MAGPIE_CACHE_ON')) {
			var_ua = rt.new_string(var_ua.str() + ')')
		} else {
			var_ua = rt.new_string(var_ua.str() + '; No cache)')
		}
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('MAGPIE_FETCH_TIME_OUT'),
	])))))
	{
		rt.call_function('define', [rt.new_string('MAGPIE_FETCH_TIME_OUT'),
			rt.new_int(2)])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('MAGPIE_USE_GZIP'),
	])))))
	{
		rt.call_function('define', [rt.new_string('MAGPIE_USE_GZIP'),
			rt.new_bool(true)])
	}
}

fn is_info(var_sc rt.PhpVal) bool {
	return rt.is_true(rt.greater_equal(var_sc, rt.new_int(100)))
		&& rt.is_true(rt.less(var_sc, rt.new_int(200)))
}

fn is_success(var_sc rt.PhpVal) bool {
	return rt.is_true(rt.greater_equal(var_sc, rt.new_int(200)))
		&& rt.is_true(rt.less(var_sc, rt.new_int(300)))
}

fn is_redirect(var_sc rt.PhpVal) bool {
	return rt.is_true(rt.greater_equal(var_sc, rt.new_int(300)))
		&& rt.is_true(rt.less(var_sc, rt.new_int(400)))
}

fn is_error(var_sc rt.PhpVal) bool {
	return rt.is_true(rt.greater_equal(var_sc, rt.new_int(400)))
		&& rt.is_true(rt.less(var_sc, rt.new_int(600)))
}

fn is_client_error(var_sc rt.PhpVal) bool {
	return rt.is_true(rt.greater_equal(var_sc, rt.new_int(400)))
		&& rt.is_true(rt.less(var_sc, rt.new_int(500)))
}

fn is_server_error(var_sc rt.PhpVal) bool {
	return rt.is_true(rt.greater_equal(var_sc, rt.new_int(500)))
		&& rt.is_true(rt.less(var_sc, rt.new_int(600)))
}

struct Class_RSSCache {
	rt.PhpObjectBase
pub mut:
	BASE_CACHE rt.PhpVal = rt.new_null()
	MAX_AGE    rt.PhpVal = rt.new_int(43200)
	ERROR      rt.PhpVal = rt.new_string('')
}

fn (mut this Class_RSSCache) construct(base string, age string) {
	this.BASE_CACHE = (rt.get_constant('WP_CONTENT_DIR')).str() + '/cache'
	if var_base.len > 0 && var_base != '0' {
		this.BASE_CACHE = rt.new_string(base)
	}
	if var_age.len > 0 && var_age != '0' {
		this.MAX_AGE = rt.new_string(age)
	}
}

fn (mut this Class_RSSCache) rsscache(base string, age string) {
	mut iife_temp_1 := Class_RSSCache{}
	iife_temp_1.construct(base, age)
	rt.new_null()
}

fn (mut this Class_RSSCache) set(var_url rt.PhpVal, var_rss rt.PhpVal) rt.PhpVal {
	mut var_rss_mutated := var_rss
	mut var_cache_option := rt.new_string('rss_' + this.file_name(var_url.clone()))
	rt.call_function('set_transient', [var_cache_option.clone(),
		var_rss_mutated.clone(), this.MAX_AGE])
	return var_cache_option.clone()
}

fn (mut this Class_RSSCache) get(var_url rt.PhpVal) i64 {
	this.ERROR = rt.new_string('')
	mut var_cache_option := rt.new_string('rss_' + this.file_name(var_url.clone()))
	mut var_rss := rt.call_function('get_transient', [var_cache_option.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_rss)))) {
		this.debug(rt.new_string('Cache does not contain: ${var_url.to_string()} (cache option: ${var_cache_option.to_string()})'),
			rt.new_null())
		return 0
	}
	return var_rss.to_i64()
}

fn (mut this Class_RSSCache) check_cache(var_url rt.PhpVal) string {
	this.ERROR = rt.new_string('')
	mut var_cache_option := rt.new_string('rss_' + this.file_name(var_url.clone()))
	if rt.is_true(rt.call_function('get_transient', [var_cache_option.clone()])) {
		return 'HIT'
	} else {
		return 'MISS'
	}
	return ''
}

fn (mut this Class_RSSCache) serialize(var_rss rt.PhpVal) rt.PhpVal {
	mut var_rss_mutated := var_rss
	return rt.call_function('serialize', [var_rss_mutated.clone()])
}

fn (mut this Class_RSSCache) unserialize(var_data rt.PhpVal) rt.PhpVal {
	return rt.call_function('unserialize', [var_data.clone()])
}

fn (mut this Class_RSSCache) file_name(var_url rt.PhpVal) string {
	return md5.hexhash(var_url.clone().to_string())
}

fn (mut this Class_RSSCache) error(var_errormsg rt.PhpVal, var_lvl rt.PhpVal) {
	mut var_errormsg_mutated := var_errormsg
	this.ERROR = var_errormsg_mutated.clone()
	if rt.is_true(rt.get_constant('MAGPIE_DEBUG')) {
		rt.call_function('wp_trigger_error', [rt.new_string(''),
			var_errormsg_mutated.clone(), var_lvl.clone()])
	} else {
		rt.call_function('error_log', [var_errormsg_mutated.clone(),
			rt.new_int(0)])
	}
}

fn (mut this Class_RSSCache) debug(var_debugmsg rt.PhpVal, var_lvl rt.PhpVal) {
	if rt.is_true(rt.get_constant('MAGPIE_DEBUG')) {
		this.error(rt.new_string('MagpieRSS [debug] ${var_debugmsg.to_string()}'), var_lvl.clone())
	}
}

fn parse_w3cdtf(var_date_str rt.PhpVal) i64 {
	mut var_match := []rt.PhpVal{}
	mut var_year := rt.new_null()
	mut var_month := rt.new_null()
	mut var_day := rt.new_null()
	mut var_hours := rt.new_null()
	mut var_minutes := rt.new_null()
	mut var_seconds := rt.new_null()
	mut var_tz_mod := rt.new_null()
	mut var_pat := ''
	mut var_epoch := rt.new_null()
	mut var_offset := rt.new_null()
	mut var_tz_hour := i64(0)
	mut var_tz_min := i64(0)
	mut var_offset_secs := rt.new_null()
	var_pat = '/(\\d{4})-(\\d{2})-(\\d{2})T(\\d{2}):(\\d{2})(:(\\d{2}))?(?:([-+])(\\d{2}):?(\\d{2})|(Z))?/'
	if rt.is_true(rt.call_function('preg_match', [rt.new_string(var_pat.str()).clone(),
		var_date_str.clone(), rt.create_array_from_list(var_match)]))
	{
		mut list_tmp_3 := rt.create_array([rt.ArrayItem{ key: none, val: var_match[1] },
			rt.ArrayItem{ key: none, val: var_match[2] }, rt.ArrayItem{ key: none, val: var_match[3] },
			rt.ArrayItem{ key: none, val: var_match[4] }, rt.ArrayItem{ key: none, val: var_match[5] },
			rt.ArrayItem{ key: none, val: var_match[7] }])
		var_year = list_tmp_3.array_get(0)
		var_month = list_tmp_3.array_get(1)
		var_day = list_tmp_3.array_get(2)
		var_hours = list_tmp_3.array_get(3)
		var_minutes = list_tmp_3.array_get(4)
		var_seconds = list_tmp_3.array_get(5)
		var_epoch = rt.call_function('gmmktime', [var_hours.clone(),
			var_minutes.clone(), var_seconds.clone(), var_month.clone(),
			var_day.clone(), var_year.clone()])
		var_offset = rt.new_int(0)
		if rt.is_true(rt.equal(var_match[11], rt.new_string('Z'))) {
		} else {
			mut list_tmp_4 := rt.create_array([
				rt.ArrayItem{ key: none, val: var_match[8] },
				rt.ArrayItem{ key: none, val: var_match[9] },
				rt.ArrayItem{ key: none, val: var_match[10] },
			])
			var_tz_mod = list_tmp_4.array_get(0)
			var_tz_hour = list_tmp_4.array_get(1)
			var_tz_min = list_tmp_4.array_get(2)
			if !(var_tz_hour != 0) {
				var_tz_hour = 0
			}
			if !(var_tz_min != 0) {
				var_tz_min = 0
			}
			var_offset_secs = rt.new_int(var_tz_hour * 60 + var_tz_min * 60)
			if rt.is_true(rt.equal(var_tz_mod, rt.new_string('+'))) {
				var_offset_secs = rt.mul(var_offset_secs, -1)
			}
			var_offset = var_offset_secs.clone()
		}
		var_epoch = rt.add(var_epoch, var_offset)
		return var_epoch.to_i64()
	} else {
		return -1
	}
	return 0
}

fn wp_rss(var_url rt.PhpVal, var_num_items rt.PhpVal) {
	mut var_rss := false
	mut var_item := rt.new_null()
	var_rss = fetch_rss(var_url.clone())
	if rt.is_true(var_rss) {
		print('<ul>')
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_num_items, -1)))) {
			rt.set_property(rt.new_bool(var_rss), 'items', rt.call_function('array_slice', [
				rt.get_property(rt.new_bool(var_rss), 'items'),
				rt.new_int(0),
				var_num_items.clone(),
			]))
		}
		mut iter_4 := rt.cast_array(rt.get_property(rt.new_bool(var_rss), 'items')).iterator()
		for {
			item_4 := iter_4.next() or { break }
			mut var_item_shadow := item_4.val
			rt.call_function('printf', [
				rt.new_string('<li><a href="%1$s" title="%2$s">%3$s</a></li>'),
				rt.call_function('esc_url', [var_item_shadow.array_get(rt.new_string('link'))]),
				rt.call_function('esc_attr', [
					rt.call_function('strip_tags', [
						var_item_shadow.array_get(rt.new_string('description')),
					]),
				]),
				rt.call_function('esc_html', [
					var_item_shadow.array_get(rt.new_string('title')),
				]),
			])
		}
		print('</ul>')
	} else {
		rt.call_function('_e', [
			rt.new_string('An error has occurred, which probably means the feed is down. Try again later.'),
		])
	}
}

fn get_rss(var_url rt.PhpVal, num_items i64) bool {
	mut var_num_items := num_items
	mut var_rss := false
	mut var_item := rt.new_null()
	var_rss = fetch_rss(var_url.clone())
	if var_rss {
		rt.set_property(rt.new_bool(var_rss), 'items', rt.call_function('array_slice', [
			rt.get_property(rt.new_bool(var_rss), 'items'),
			rt.new_int(0),
			rt.new_int(num_items),
		]))
		mut iter_5 := rt.cast_array(rt.get_property(rt.new_bool(var_rss), 'items')).iterator()
		for {
			item_5 := iter_5.next() or { break }
			mut var_item_shadow := item_5.val
			print('<li>\n')
			print(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string("<a href='"),
				var_item_shadow.array_get(rt.new_string('link'))), rt.new_string("' title='")),
				var_item_shadow.array_get(rt.new_string('description'))), rt.new_string("'>")))
			rt.echo_val(rt.call_function('esc_html', [
				var_item_shadow.array_get(rt.new_string('title')),
			]))
			print('</a><br />\n')
			print('</li>\n')
		}
	} else {
		return false
	}
	return false
}

struct Class_stdClass {
	rt.PhpObjectBase
}

fn create_magpierss(arg_0 rt.PhpVal) &Class_MagpieRSS {
	mut obj := &Class_MagpieRSS{
		PhpObjectBase:       rt.PhpObjectBase{}
		parser:              rt.new_null()
		current_item:        rt.new_array()
		items:               rt.new_array()
		channel:             rt.new_array()
		textinput:           rt.new_array()
		image:               rt.new_array()
		feed_type:           ''
		feed_version:        rt.new_null()
		stack:               rt.new_array()
		inchannel:           false
		initem:              false
		incontent:           rt.new_bool(false)
		intextinput:         false
		inimage:             false
		current_field:       rt.new_string('')
		current_namespace:   rt.new_bool(false)
		_CONTENT_CONSTRUCTS: rt.new_array()
	}
	obj.construct(arg_0)
	return obj
}

fn create_rsscache(base string, age string) &Class_RSSCache {
	mut obj := &Class_RSSCache{
		PhpObjectBase: rt.PhpObjectBase{}
		BASE_CACHE:    rt.new_null()
		MAX_AGE:       rt.new_int(43200)
		ERROR:         rt.new_string('')
	}
	obj.construct(base, age)
	return obj
}

fn create_stdclass(_args ...rt.PhpVal) &Class_stdClass {
	mut obj := &Class_stdClass{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_MagpieRSS) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'MagpieRSS' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.magpierss(dispatch_arg_0)
			return rt.new_null()
		}
		'feed_start_element' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			this.feed_start_element(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'feed_cdata' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.feed_cdata(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'feed_end_element' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.feed_end_element(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'concat' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			this.concat(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'append_content' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.append_content(dispatch_arg_0)
			return rt.new_null()
		}
		'append' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.append(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'normalize' {
			this.normalize()
			return rt.new_null()
		}
		'is_rss' {
			return rt.new_bool(this.is_rss())
		}
		'is_atom' {
			return rt.new_bool(this.is_atom())
		}
		'map_attrs' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_string(this.map_attrs(dispatch_arg_0, dispatch_arg_1))
		}
		'error' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.error(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_MagpieRSS) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'parser' { return this.parser }
		'current_item' { return this.current_item }
		'items' { return this.items }
		'channel' { return this.channel }
		'textinput' { return this.textinput }
		'image' { return this.image }
		'feed_type' { return rt.new_string(this.feed_type) }
		'feed_version' { return this.feed_version }
		'stack' { return this.stack }
		'inchannel' { return rt.new_bool(this.inchannel) }
		'initem' { return rt.new_bool(this.initem) }
		'incontent' { return this.incontent }
		'intextinput' { return rt.new_bool(this.intextinput) }
		'inimage' { return rt.new_bool(this.inimage) }
		'current_field' { return this.current_field }
		'current_namespace' { return this.current_namespace }
		'_CONTENT_CONSTRUCTS' { return this._CONTENT_CONSTRUCTS }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_MagpieRSS) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'parser' {
			this.parser = val
			return true
		}
		'current_item' {
			this.current_item = val
			return true
		}
		'items' {
			this.items = val
			return true
		}
		'channel' {
			this.channel = val
			return true
		}
		'textinput' {
			this.textinput = val
			return true
		}
		'image' {
			this.image = val
			return true
		}
		'feed_type' {
			this.feed_type = val.str()
			return true
		}
		'feed_version' {
			this.feed_version = val
			return true
		}
		'stack' {
			this.stack = val
			return true
		}
		'inchannel' {
			this.inchannel = val.to_bool()
			return true
		}
		'initem' {
			this.initem = val.to_bool()
			return true
		}
		'incontent' {
			this.incontent = val
			return true
		}
		'intextinput' {
			this.intextinput = val.to_bool()
			return true
		}
		'inimage' {
			this.inimage = val.to_bool()
			return true
		}
		'current_field' {
			this.current_field = val
			return true
		}
		'current_namespace' {
			this.current_namespace = val
			return true
		}
		'_CONTENT_CONSTRUCTS' {
			this._CONTENT_CONSTRUCTS = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_RSSCache) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			this.construct(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'RSSCache' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			this.rsscache(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'set' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.set(dispatch_arg_0, dispatch_arg_1)
		}
		'get' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_int(this.get(dispatch_arg_0))
		}
		'check_cache' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.check_cache(dispatch_arg_0))
		}
		'serialize' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.serialize(dispatch_arg_0)
		}
		'unserialize' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.unserialize(dispatch_arg_0)
		}
		'file_name' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.file_name(dispatch_arg_0))
		}
		'error' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.error(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'debug' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.debug(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_RSSCache) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'BASE_CACHE' { return this.BASE_CACHE }
		'MAX_AGE' { return this.MAX_AGE }
		'ERROR' { return this.ERROR }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_RSSCache) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'BASE_CACHE' {
			this.BASE_CACHE = val
			return true
		}
		'MAX_AGE' {
			this.MAX_AGE = val
			return true
		}
		'ERROR' {
			this.ERROR = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_stdClass) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_stdClass) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_stdClass) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_GLOBALS := rt.new_null()
	rt.call_function('_deprecated_file', [
		rt.call_function('basename', [rt.new_string(@FILE)]),
		rt.new_string('3.0.0'),
		rt.new_string((rt.get_constant('WPINC')).str() + '/class-simplepie.php'),
	])
	rt.call_function('do_action', [rt.new_string('load_feed_engine')])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('fetch_rss'),
	])))))
	{
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('parse_w3cdtf'),
	])))))
	{
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('wp_rss'),
	])))))
	{
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('get_rss'),
	])))))
	{
	}
}
