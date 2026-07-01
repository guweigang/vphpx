import rt

const global_const_rss = 'RSS'
const global_const_atom = 'Atom'
const global_const_magpie_user_agent = 'WordPress/' + (var_GLOBALS.array_get('wp_version')).str()
struct Class_MagpieRSS {
	rt.PhpObjectBase
pub mut:
		parser rt.PhpVal = rt.new_null()
		current_item rt.PhpVal = rt.new_array()
		items rt.PhpVal = rt.new_array()
		channel rt.PhpVal = rt.new_array()
		textinput rt.PhpVal = rt.new_array()
		image rt.PhpVal = rt.new_array()
		feed_type string
		feed_version rt.PhpVal = rt.new_null()
		stack rt.PhpVal = rt.new_array()
		inchannel bool
		initem bool
		incontent rt.PhpVal = rt.new_bool(false)
		intextinput bool
		inimage bool
		current_field rt.PhpVal = rt.new_string('')
		current_namespace rt.PhpVal = rt.new_bool(false)
		_CONTENT_CONSTRUCTS rt.PhpVal = rt.new_array()
}

fn (mut this Class_MagpieRSS) construct(var_source rt.PhpVal)  {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('xml_parser_create')]))))) {
		rt.call_function('wp_trigger_error', [rt.new_string(''), rt.new_string('PHP\'s XML extension is not available. Please contact your hosting provider to enable PHP\'s XML extension.')])
		return
	}
	mut var_parser := rt.call_function('xml_parser_create', []rt.PhpVal{})
	this.parser = var_parser.dup()
	rt.call_function('xml_set_element_handler', [this.parser, rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('MagpieRSS', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'feed_start_element' }]), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('MagpieRSS', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'feed_end_element' }])])
	rt.call_function('xml_set_character_data_handler', [this.parser, rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('MagpieRSS', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'feed_cdata' }])])
	mut var_status := rt.call_function('xml_parse', [this.parser, var_source.dup()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_status)))) {
		mut var_errorcode := rt.call_function('xml_get_error_code', [this.parser])
		if rt.is_true(// unsupported expression: Expr_BinaryOp_NotEqual) {
			mut var_xml_error := rt.call_function('xml_error_string', [var_errorcode.dup()])
			mut var_error_line := rt.call_function('xml_get_current_line_number', [this.parser])
			mut var_error_col := rt.call_function('xml_get_current_column_number', [this.parser])
			mut var_errormsg := rt.new_string(rt.new_string("${var_xml_error.to_string()} at line ${var_error_line.to_string()}, column ${var_error_col.to_string()}"))
			this.error(var_errormsg.dup(), rt.new_null())
		}
	}
	if rt.is_true(rt.less(rt.get_constant('PHP_VERSION_ID'), rt.new_int(80000))) {
		rt.call_function('xml_parser_free', [this.parser])
	}
	this.parser = rt.new_null()
	this.normalize()
}

fn (mut this Class_MagpieRSS) magpierss(var_source rt.PhpVal)  {
	fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_MagpieRSS{}; temp.construct(arg_0); return rt.new_null() }(var_source.dup())
}

fn (mut this Class_MagpieRSS) feed_start_element(var_p rt.PhpVal, var_element rt.PhpVal, var_attrs rt.PhpVal)  {
	mut var_element_mutated := var_element
	mut var_attrs_mutated := var_attrs
	mut var_el := var_element_mutated = rt.new_string(rt.new_string(var_element_mutated.dup().to_string().to_lower()))
	var_attrs_mutated = rt.call_function('array_change_key_case', [var_attrs_mutated.dup(), rt.get_constant('CASE_LOWER')])
	mut var_ns := rt.new_bool(rt.new_bool(false))
	if rt.is_true(rt.call_function('strpos', [var_element_mutated.dup(), rt.new_string(':')])) {
		// unsupported assign target: Expr_List
	}
	if rt.is_true(rt.new_bool(rt.is_true(var_ns) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotEqual))) {
		this.current_namespace = var_ns.dup()
	}
	if !(!(this.feed_type).is_null()) {
		if rt.is_true(rt.equal(var_el, rt.new_string('rdf'))) {
			this.feed_type = global_const_rss
			this.feed_version = rt.new_string('1.0')
		} else if rt.is_true(rt.equal(var_el, rt.new_string('rss'))) {
			this.feed_type = global_const_rss
			this.feed_version = var_attrs_mutated.array_get('version')
		} else if rt.is_true(rt.equal(var_el, rt.new_string('feed'))) {
			this.feed_type = global_const_atom
			this.feed_version = var_attrs_mutated.array_get('version')
			this.inchannel = true
		}
		return rt.new_null()
	}
	if rt.is_true(rt.equal(var_el, rt.new_string('channel'))) {
		this.inchannel = true
	} else if rt.is_true(rt.new_bool(rt.is_true(rt.equal(var_el, rt.new_string('item'))) || rt.is_true(rt.equal(var_el, rt.new_string('entry'))))) {
		this.initem = true
		if var_attrs_mutated.array_isset(rt.new_string('rdf:about')) {
			this.current_item.array_set('about', var_attrs_mutated.array_get('rdf:about'))
		}
	} else if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.equal(this.feed_type, rt.new_string(global_const_rss))) && rt.is_true(rt.equal(this.current_namespace, rt.new_string(''))))) && rt.is_true(rt.equal(var_el, rt.new_string('textinput'))))) {
		this.intextinput = true
	} else if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.equal(this.feed_type, rt.new_string(global_const_rss))) && rt.is_true(rt.equal(this.current_namespace, rt.new_string(''))))) && rt.is_true(rt.equal(var_el, rt.new_string('image'))))) {
		this.inimage = true
	} else if rt.is_true(rt.new_bool(rt.is_true(rt.equal(this.feed_type, rt.new_string(global_const_atom))) && rt.is_true(rt.call_function('in_array', [var_el.dup(), this._CONTENT_CONSTRUCTS])))) {
		if rt.is_true(rt.equal(var_el, rt.new_string('content'))) {
			var_el = rt.new_string(rt.new_string('atom_content'))
		}
		this.incontent = var_el.dup()
	} else if rt.is_true(rt.new_bool(rt.is_true(rt.equal(this.feed_type, rt.new_string(global_const_atom))) && rt.is_true(this.incontent))) {
		mut var_attrs_str := rt.call_function('join', [rt.new_string(' '), rt.call_function('array_map', [rt.create_array([rt.ArrayItem{ key: none, val: 'MagpieRSS' }, rt.ArrayItem{ key: none, val: 'map_attrs' }]), rt.func_array_keys(var_attrs_mutated.dup()), rt.call_function('array_values', [var_attrs_mutated.dup()])])])
		this.append_content(rt.new_string("<${var_element.to_string()} ${var_attrs_str.to_string()}>"))
		rt.call_function('array_unshift', [this.stack, var_el.dup()])
	} else if rt.is_true(rt.new_bool(rt.is_true(rt.equal(this.feed_type, rt.new_string(global_const_atom))) && rt.is_true(rt.equal(var_el, rt.new_string('link'))))) {
		if rt.is_true(rt.new_bool(var_attrs_mutated.array_isset(rt.new_string('rel')) && rt.is_true(rt.equal(var_attrs_mutated.array_get('rel'), rt.new_string('alternate'))))) {
			mut var_link_el := rt.new_string(rt.new_string('link'))
		} else {
			var_link_el = rt.new_string('link_' + (var_attrs_mutated.array_get('rel')).str())
		}
		this.append(var_link_el.dup(), var_attrs_mutated.array_get('href'))
	} else {
		rt.call_function('array_unshift', [this.stack, var_el.dup()])
	}
}

fn (mut this Class_MagpieRSS) feed_cdata(var_p rt.PhpVal, var_text rt.PhpVal)  {
	if rt.is_true(rt.new_bool(rt.is_true(rt.equal(this.feed_type, rt.new_string(global_const_atom))) && rt.is_true(this.incontent))) {
		this.append_content(var_text.dup())
	} else {
		mut var_current_el := rt.call_function('join', [rt.new_string('_'), rt.call_function('array_reverse', [this.stack])])
		this.append(var_current_el.dup(), var_text.dup())
	}
}

fn (mut this Class_MagpieRSS) feed_end_element(var_p rt.PhpVal, var_el rt.PhpVal)  {
	mut var_el_mutated := var_el
	var_el_mutated = rt.new_string(rt.new_string(var_el_mutated.dup().to_string().to_lower()))
	if rt.is_true(rt.new_bool(rt.is_true(rt.equal(var_el_mutated, rt.new_string('item'))) || rt.is_true(rt.equal(var_el_mutated, rt.new_string('entry'))))) {
		this.items.array_push(this.current_item)
		this.current_item = rt.new_array()
		this.initem = false
	} else if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.equal(this.feed_type, rt.new_string(global_const_rss))) && rt.is_true(rt.equal(this.current_namespace, rt.new_string(''))))) && rt.is_true(rt.equal(var_el_mutated, rt.new_string('textinput'))))) {
		this.intextinput = false
	} else if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.equal(this.feed_type, rt.new_string(global_const_rss))) && rt.is_true(rt.equal(this.current_namespace, rt.new_string(''))))) && rt.is_true(rt.equal(var_el_mutated, rt.new_string('image'))))) {
		this.inimage = false
	} else if rt.is_true(rt.new_bool(rt.is_true(rt.equal(this.feed_type, rt.new_string(global_const_atom))) && rt.is_true(rt.call_function('in_array', [var_el_mutated.dup(), this._CONTENT_CONSTRUCTS])))) {
		this.incontent = rt.new_bool(false)
	} else if rt.is_true(rt.new_bool(rt.is_true(rt.equal(var_el_mutated, rt.new_string('channel'))) || rt.is_true(rt.equal(var_el_mutated, rt.new_string('feed'))))) {
		this.inchannel = false
	} else if rt.is_true(rt.new_bool(rt.is_true(rt.equal(this.feed_type, rt.new_string(global_const_atom))) && rt.is_true(this.incontent))) {
		if rt.is_true(rt.equal(this.stack.array_get(0), var_el_mutated)) {
			this.append_content(rt.new_string("</${var_el.to_string()}>"))
		} else {
			this.append_content(rt.new_string("<${var_el.to_string()} />"))
		}
		rt.call_function('array_shift', [this.stack])
	} else {
		rt.call_function('array_shift', [this.stack])
	}
	this.current_namespace = rt.new_bool(false)
}

fn (mut this Class_MagpieRSS) concat(var_str1 rt.PhpVal, str2 string)  {
	mut var_str1_mutated := var_str1
	if !(!(var_str1_mutated).is_null()) {
		var_str1_mutated = rt.new_string(rt.new_string(''))
	}
	// unsupported expression: Expr_AssignOp_Concat
}

fn (mut this Class_MagpieRSS) append_content(var_text rt.PhpVal)  {
	if rt.is_true(this.initem) {
		this.concat(this.current_item.array_get(this.incontent), (var_text).str())
	} else if rt.is_true(this.inchannel) {
		this.concat(this.channel.array_get(this.incontent), (var_text).str())
	}
}

fn (mut this Class_MagpieRSS) append(var_el rt.PhpVal, var_text rt.PhpVal)  {
	mut var_el_mutated := var_el
	if rt.is_true(rt.new_bool(!(rt.is_true(var_el_mutated)))) {
		return rt.new_null()
	}
	if rt.is_true(this.current_namespace) {
		if rt.is_true(this.initem) {
			this.concat(this.current_item.array_get(this.current_namespace).array_get(var_el_mutated), (var_text).str())
		} else if rt.is_true(this.inchannel) {
			this.concat(this.channel.array_get(this.current_namespace).array_get(var_el_mutated), (var_text).str())
		} else if rt.is_true(this.intextinput) {
			this.concat(this.textinput.array_get(this.current_namespace).array_get(var_el_mutated), (var_text).str())
		} else if rt.is_true(this.inimage) {
			this.concat(this.image.array_get(this.current_namespace).array_get(var_el_mutated), (var_text).str())
		}
	} else {
		if rt.is_true(this.initem) {
			this.concat(this.current_item.array_get(var_el_mutated), (var_text).str())
		} else if rt.is_true(this.intextinput) {
			this.concat(this.textinput.array_get(var_el_mutated), (var_text).str())
		} else if rt.is_true(this.inimage) {
			this.concat(this.image.array_get(var_el_mutated), (var_text).str())
		} else if rt.is_true(this.inchannel) {
			this.concat(this.channel.array_get(var_el_mutated), (var_text).str())
		}
	}
}

fn (mut this Class_MagpieRSS) normalize()  {
	if this.is_atom() {
		this.channel.array_set('description', this.channel.array_get('tagline'))
		{
			mut var_i := rt.new_int(rt.new_int(0))
			for {
				if !(rt.is_true(rt.less(var_i, rt.new_int(this.items.array_count())))) { break }
				mut var_item := this.items.array_get(var_i)
				if var_item.array_isset(rt.new_string('summary')) {
					var_item.array_set('description', var_item.array_get('summary'))
				}
				if var_item.array_isset(rt.new_string('atom_content')) {
					var_item.array_get_mut('content').array_set('encoded', var_item.array_get('atom_content'))
				}
				this.items.array_set(var_i, var_item.dup())
				rt.post_inc(var_i)
			}
		}
	} else if this.is_rss() {
		this.channel.array_set('tagline', this.channel.array_get('description'))
		{
			var_i = rt.new_int(rt.new_int(0))
			for {
				if !(rt.is_true(rt.less(var_i, rt.new_int(this.items.array_count())))) { break }
				var_item = this.items.array_get(var_i)
				if var_item.array_isset(rt.new_string('description')) {
					var_item.array_set('summary', var_item.array_get('description'))
				}
				if var_item.array_get('content').array_isset(rt.new_string('encoded')) {
					var_item.array_set('atom_content', var_item.array_get('content').array_get('encoded'))
				}
				this.items.array_set(var_i, var_item.dup())
				rt.post_inc(var_i)
			}
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

fn (mut this Class_MagpieRSS) error(var_errormsg rt.PhpVal, var_lvl rt.PhpVal)  {
	mut var_errormsg_mutated := var_errormsg
	if rt.is_true(rt.get_constant('MAGPIE_DEBUG')) {
		rt.call_function('wp_trigger_error', [rt.new_string(''), var_errormsg_mutated.dup(), var_lvl.dup()])
	} else {
		rt.call_function('error_log', [.dup(), ])
	}
}

fn fetch_rss(var_url rt.PhpVal) bool {
	return false
}

fn _fetch_remote_file(var_url rt.PhpVal, headers string) rt.PhpVal {
}

fn create_magpierss(arg_0 rt.PhpVal) &Class_MagpieRSS {
	mut obj := &Class_MagpieRSS{
		PhpObjectBase: rt.PhpObjectBase{}
		parser: rt.new_null()
		current_item: rt.new_array()
		items: rt.new_array()
		channel: rt.new_array()
		textinput: rt.new_array()
		image: rt.new_array()
		feed_type: ''
		feed_version: rt.new_null()
		stack: rt.new_array()
		inchannel: false
		initem: false
		incontent: rt.new_bool(false)
		intextinput: false
		inimage: false
		current_field: rt.new_string('')
		current_namespace: rt.new_bool(false)
		_CONTENT_CONSTRUCTS: rt.new_array()
	}
	obj.construct(arg_0)
	return obj
}

fn create_rsscache() &Class_RSSCache {
	mut obj := &Class_RSSCache{
		PhpObjectBase: rt.PhpObjectBase{}
		BASE_CACHE: rt.new_null()
		MAX_AGE: rt.new_int(43200)
		ERROR: rt.new_string('')
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
		else { return none }
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
		'parser' { this.parser = val; return true }
		'current_item' { this.current_item = val; return true }
		'items' { this.items = val; return true }
		'channel' { this.channel = val; return true }
		'textinput' { this.textinput = val; return true }
		'image' { this.image = val; return true }
		'feed_type' { this.feed_type = (val).str(); return true }
		'feed_version' { this.feed_version = val; return true }
		'stack' { this.stack = val; return true }
		'inchannel' { this.inchannel = (val).to_bool(); return true }
		'initem' { this.initem = (val).to_bool(); return true }
		'incontent' { this.incontent = val; return true }
		'intextinput' { this.intextinput = (val).to_bool(); return true }
		'inimage' { this.inimage = (val).to_bool(); return true }
		'current_field' { this.current_field = val; return true }
		'current_namespace' { this.current_namespace = val; return true }
		'_CONTENT_CONSTRUCTS' { this._CONTENT_CONSTRUCTS = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_RSSCache) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_RSSCache) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_RSSCache) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_includes_rss_php() {
	mut var_GLOBALS := rt.new_null()
	rt.call_function('_deprecated_file', [rt.call_function('basename', [rt.new_string(@FILE)]), rt.new_string('3.0.0'), (rt.get_constant('WPINC')).str() + '/class-simplepie.php'])
	rt.call_function('do_action', [rt.new_string('load_feed_engine')])
	if rt.is_true(rt.new_bool(!(rt.is_true()))) {
	}
}
