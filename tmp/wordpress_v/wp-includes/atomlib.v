import rt

struct Class_AtomFeed {
	rt.PhpObjectBase
pub mut:
		links rt.PhpVal = rt.new_array()
		categories rt.PhpVal = rt.new_array()
		entries rt.PhpVal = rt.new_array()
}

struct Class_AtomEntry {
	rt.PhpObjectBase
pub mut:
		links rt.PhpVal = rt.new_array()
		categories rt.PhpVal = rt.new_array()
}

struct Class_AtomParser {
	rt.PhpObjectBase
pub mut:
		NS rt.PhpVal = rt.new_string('http://www.w3.org/2005/Atom')
		ATOM_CONTENT_ELEMENTS rt.PhpVal = rt.new_array()
		ATOM_SIMPLE_ELEMENTS rt.PhpVal = rt.new_array()
		debug rt.PhpVal = rt.new_bool(false)
		depth rt.PhpVal = rt.new_int(0)
		indent rt.PhpVal = rt.new_int(2)
		in_content rt.PhpVal = rt.new_null()
		ns_contexts rt.PhpVal = rt.new_array()
		ns_decls rt.PhpVal = rt.new_array()
		content_ns_decls rt.PhpVal = rt.new_array()
		content_ns_contexts rt.PhpVal = rt.new_array()
		is_xhtml bool
		is_html bool
		is_text bool
		skipped_div rt.PhpVal = rt.new_bool(false)
		FILE rt.PhpVal = rt.new_string('php://input')
		feed rt.PhpVal = rt.new_null()
		current rt.PhpVal = rt.new_null()
		map_attrs_func rt.PhpVal = rt.new_null()
		map_xmlns_func rt.PhpVal = rt.new_null()
		error rt.PhpVal = rt.new_null()
		content string
}

fn (mut this Class_AtomParser) construct()  {
	this.feed = create_atomfeed()
	this.current = rt.new_null()
	this.map_attrs_func = rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'map_attrs' }])
	this.map_xmlns_func = rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'map_xmlns' }])
}

fn (mut this Class_AtomParser) atomparser()  {
	fn () rt.PhpVal { mut temp := Class_AtomParser{}; temp.construct(); return rt.new_null() }()
}

fn Class_AtomParser.map_attrs(var_k rt.PhpVal, var_v rt.PhpVal) string {
	return "${var_k.to_string()}=\"${var_v.to_string()}\""
}

fn Class_AtomParser.map_xmlns(var_p rt.PhpVal, var_n rt.PhpVal) string {
	mut var_xd := rt.new_string(rt.new_string('xmlns'))
	if 0 < var_n.array_get(0).to_string().len {
		// unsupported expression: Expr_AssignOp_Concat
	}
	return rt.concat(rt.concat(rt.concat(var_xd, rt.new_string('="')), var_n.array_get(1)), rt.new_string('"'))
}

fn (mut this Class_AtomParser) _p(var_msg rt.PhpVal)  {
	if rt.is_true(this.debug) {
		// unsupported expression: Expr_Print
	}
}

fn (mut this Class_AtomParser) error_handler(var_log_level rt.PhpVal, var_log_text rt.PhpVal, var_error_file rt.PhpVal, var_error_line rt.PhpVal)  {
	this.error = var_log_text.dup()
}

fn (mut this Class_AtomParser) parse() bool {
	rt.call_function('set_error_handler', [rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('AtomParser', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'error_handler' }])])
	rt.call_function('array_unshift', [this.ns_contexts, rt.new_array()])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('xml_parser_create_ns')]))))) {
		rt.call_function('trigger_error', [rt.call_function('__', [rt.new_string('PHP\'s XML extension is not available. Please contact your hosting provider to enable PHP\'s XML extension.')])])
		return false
	}
	mut var_parser := rt.call_function('xml_parser_create_ns', []rt.PhpVal{})
	rt.call_function('xml_set_element_handler', [var_parser.dup(), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('AtomParser', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'start_element' }]), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('AtomParser', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'end_element' }])])
	rt.call_function('xml_parser_set_option', [var_parser.dup(), rt.get_constant('XML_OPTION_CASE_FOLDING'), rt.new_int(0)])
	rt.call_function('xml_parser_set_option', [var_parser.dup(), rt.get_constant('XML_OPTION_SKIP_WHITE'), rt.new_int(0)])
	rt.call_function('xml_set_character_data_handler', [var_parser.dup(), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('AtomParser', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'cdata' }])])
	rt.call_function('xml_set_default_handler', [var_parser.dup(), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('AtomParser', []string{}, &this) }, rt.ArrayItem{ key: none, val: '_default' }])])
	rt.call_function('xml_set_start_namespace_decl_handler', [var_parser.dup(), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('AtomParser', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'start_ns' }])])
	rt.call_function('xml_set_end_namespace_decl_handler', [var_parser.dup(), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('AtomParser', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'end_ns' }])])
	this.content = ''
	mut var_ret := rt.new_bool(rt.new_bool(true))
	mut var_fp := rt.call_function('fopen', [this.FILE, rt.new_string('r')])
	for rt.is_true(mut var_data := rt.call_function('fread', [var_fp.dup(), rt.new_int(4096)])) {
		if rt.is_true(this.debug) {
			// unsupported expression: Expr_AssignOp_Concat
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('xml_parse', [var_parser.dup(), var_data.dup(), rt.call_function('feof', [var_fp.dup()])]))))) {
			rt.call_function('trigger_error', [rt.call_function('sprintf', [(rt.call_function('__', [rt.new_string('XML Error: %1$s at line %2$s')])).str() + '\n', rt.call_function('xml_error_string', [rt.call_function('xml_get_error_code', [var_parser.dup()])]), rt.call_function('xml_get_current_line_number', [var_parser.dup()])])])
			var_ret = rt.new_bool(rt.new_bool(false))
			break
		}
	}
	rt.call_function('fclose', [var_fp.dup()])
	if rt.is_true(rt.less(rt.get_constant('PHP_VERSION_ID'), rt.new_int(80000))) {
		rt.call_function('xml_parser_free', [var_parser.dup()])
	}
	var_parser = rt.new_null()
	rt.call_function('restore_error_handler', []rt.PhpVal{})
	return (var_ret).to_bool()
}

fn (mut this Class_AtomParser) start_element(var_parser rt.PhpVal, var_name rt.PhpVal, var_attrs rt.PhpVal)  {
	mut var_parser_mutated := var_parser
	mut var_name_mutated := var_name
	mut var_name_parts := rt.call_function('explode', [rt.new_string(':'), var_name_mutated.dup()])
	mut var_tag := rt.call_function('array_pop', [var_name_parts.dup()])
	mut switch_val_1 := var_name_mutated
	if rt.is_true(rt.equal(switch_val_1, (this.NS).str() + ':feed')) {
		this.current = this.feed
	} else if rt.is_true(rt.equal(switch_val_1, (this.NS).str() + ':entry')) {
		this.current = create_atomentry()
	}
	this._p(rt.new_string("start_element('${var_name.to_string()}')"))
	rt.call_function('array_unshift', [this.ns_contexts, this.ns_decls])
	rt.post_inc(this.depth)
	if !(!rt.is_true(this.in_content)) {
		this.content_ns_decls = rt.new_array()
		if rt.is_true(rt.new_bool(rt.is_true(this.is_html) || rt.is_true(this.is_text))) {
			rt.call_function('trigger_error', [rt.new_string('Invalid content in element found. Content must not be of type text or html if it contains markup.')])
		}
		mut var_attrs_prefix := rt.new_array()
		{
			mut iter_1 := var_attrs.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_value := item_1.val
				mut var_key := item_1.key
				mut var_with_prefix := this.ns_to_prefix(var_key.dup(), true)
				var_attrs_prefix.array_set(var_with_prefix.array_get(1), this.xml_escape(var_value.dup()))
			}
		}
		mut var_attrs_str := rt.call_function('join', [rt.new_string(' '), rt.call_function('array_map', [this.map_attrs_func, rt.func_array_keys(var_attrs_prefix.dup()), rt.call_function('array_values', [var_attrs_prefix.dup()])])])
		if var_attrs_str.dup().to_string().len > 0 {
			var_attrs_str = rt.new_string(' ' + (var_attrs_str).str())
		}
		mut var_with_prefix := this.ns_to_prefix(var_name_mutated.dup(), false)
		if !(this.is_declared_content_ns(var_with_prefix.array_get(0))) {
			this.content_ns_decls.array_push(var_with_prefix.array_get(0))
		}
		mut var_xmlns_str := rt.new_string(rt.new_string(''))
		if this.content_ns_decls.array_count() > 0 {
			rt.call_function('array_unshift', [this.content_ns_contexts, this.content_ns_decls])
			// unsupported expression: Expr_AssignOp_Concat
			if var_xmlns_str.dup().to_string().len > 0 {
				var_xmlns_str = rt.new_string(' ' + (var_xmlns_str).str())
			}
		}
		this.in_content.array_push(rt.create_array([rt.ArrayItem{ key: none, val: var_tag }, rt.ArrayItem{ key: none, val: this.depth }, rt.ArrayItem{ key: none, val: '<' + (var_with_prefix.array_get(1)).str() + "${var_xmlns_str.to_string()}${var_attrs_str.to_string()}" + '>' }]))
	} else {
		if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('in_array', [var_tag.dup(), this.ATOM_CONTENT_ELEMENTS])) || rt.is_true(rt.call_function('in_array', [var_tag.dup(), this.ATOM_SIMPLE_ELEMENTS])))) {
			this.in_content = rt.new_array()
			this.is_xhtml = rt.equal(var_attrs.array_get('type'), rt.new_string('xhtml'))
			this.is_html = rt.is_true(rt.equal(var_attrs.array_get('type'), rt.new_string('html'))) || rt.is_true(rt.equal(var_attrs.array_get('type'), rt.new_string('text/html')))
			this.is_text = rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [rt.new_string('type'), rt.func_array_keys(var_attrs.dup())]))))) || rt.is_true(rt.equal(var_attrs.array_get('type'), rt.new_string('text')))
			mut var_type := if rt.is_true(this.is_xhtml) { rt.new_string('XHTML') } else { if rt.is_true(this.is_html) { rt.new_string('HTML') } else { if rt.is_true(this.is_text) { rt.new_string('TEXT') } else { var_attrs.array_get('type') } } }
			if rt.is_true(rt.call_function('in_array', [rt.new_string('src'), rt.func_array_keys(var_attrs.dup())])) {
				rt.set_property(this.current, '{"nodeType":"Expr_Variable","line":265,"name":"tag"}', var_attrs.dup())
			} else {
				this.in_content.array_push(rt.create_array([rt.ArrayItem{ key: none, val: var_tag }, rt.ArrayItem{ key: none, val: this.depth }, rt.ArrayItem{ key: none, val: var_type }]))
			}
		} else {
			if rt.is_true(rt.equal(var_tag, rt.new_string('link'))) {
				rt.get_property(this.current, 'links').array_push(var_attrs.dup())
			} else {
				if rt.is_true(rt.equal(var_tag, rt.new_string('category'))) {
					rt.get_property(this.current, 'categories').array_push(var_attrs.dup())
				}
			}
		}
	}
	this.ns_decls = rt.new_array()
}

fn (mut this Class_AtomParser) end_element(var_parser rt.PhpVal, var_name rt.PhpVal)  {
	mut var_parser_mutated := var_parser
	mut var_name_mutated := var_name
	mut var_name_parts := rt.call_function('explode', [rt.new_string(':'), var_name_mutated.dup()])
	mut var_tag := rt.call_function('array_pop', [var_name_parts.dup()])
	mut var_ccount := rt.new_int(rt.new_int(this.in_content.array_count()))
	if !(!rt.is_true(this.in_content)) {
		if rt.is_true(rt.new_bool(rt.is_true(rt.equal(this.in_content.array_get(0).array_get(0), var_tag)) && rt.is_true(rt.equal(this.in_content.array_get(0).array_get(1), this.depth)))) {
			mut var_origtype := this.in_content.array_get(0).array_get(2)
			rt.call_function('array_shift', [this.in_content])
			mut var_newcontent := rt.new_array()
			{
				mut iter_1 := this.in_content.iterator()
				for {
					item_1 := iter_1.next() or { break }
					mut var_c := item_1.val
					if var_c.dup().array_count() == 3 {
						var_newcontent.dup().array_push(var_c.array_get(2))
					} else {
						if rt.is_true(rt.new_bool(rt.is_true(this.is_xhtml) || rt.is_true(this.is_text))) {
							var_newcontent.dup().array_push(this.xml_escape(var_c.dup()))
						} else {
							var_newcontent.dup().array_push(var_c.dup())
						}
					}
				}
			}
			if rt.is_true(rt.call_function('in_array', [var_tag.dup(), this.ATOM_CONTENT_ELEMENTS])) {
				rt.set_property(this.current, '{"nodeType":"Expr_Variable","line":306,"name":"tag"}', rt.create_array([rt.ArrayItem{ key: none, val: var_origtype }, rt.ArrayItem{ key: none, val: rt.call_function('join', [rt.new_string(''), var_newcontent.dup()]) }]))
			} else {
				rt.set_property(this.current, '{"nodeType":"Expr_Variable","line":308,"name":"tag"}', rt.call_function('join', [rt.new_string(''), var_newcontent.dup()]))
			}
			this.in_content = rt.new_array()
		} else {
			if rt.is_true(rt.new_bool(rt.is_true(rt.equal(this.in_content.array_get(rt.sub(var_ccount, rt.new_int(1))).array_get(0), var_tag)) && rt.is_true(rt.equal(this.in_content.array_get(rt.sub(var_ccount, rt.new_int(1))).array_get(1), this.depth)))) {
				this.in_content.array_get_mut(rt.sub(var_ccount, rt.new_int(1))).array_set(2, (rt.call_function('substr', [this.in_content.array_get(rt.sub(var_ccount, rt.new_int(1))).array_get(2), rt.new_int(0), // unsupported expression: Expr_UnaryMinus])).str() + '/>')
			} else {
				mut var_endtag := this.ns_to_prefix(var_name_mutated.dup(), false)
				this.in_content.array_push(rt.create_array([rt.ArrayItem{ key: none, val: var_tag }, rt.ArrayItem{ key: none, val: this.depth }, rt.ArrayItem{ key: none, val: rt.concat(rt.concat(rt.new_string('</'), var_endtag.array_get(1)), rt.new_string('>')) }]))
			}
		}
	}
	rt.call_function('array_shift', [this.ns_contexts])
	rt.post_dec(this.depth)
	if rt.is_true(rt.equal(var_name_mutated, (this.NS).str() + ':entry')) {
		rt.get_property(this.feed, 'entries').array_push(this.current)
		this.current = rt.new_null()
	}
	this._p(rt.new_string("end_element('${var_name.to_string()}')"))
}

fn (mut this Class_AtomParser) start_ns(var_parser rt.PhpVal, var_prefix rt.PhpVal, var_uri rt.PhpVal)  {
	mut var_parser_mutated := var_parser
	this._p(rt.new_string('starting: ' + (var_prefix).str() + ':' + (var_uri).str()))
	this.ns_decls.array_push(rt.create_array([rt.ArrayItem{ key: none, val: var_prefix }, rt.ArrayItem{ key: none, val: var_uri }]))
}

fn (mut this Class_AtomParser) end_ns(var_parser rt.PhpVal, var_prefix rt.PhpVal)  {
	mut var_parser_mutated := var_parser
	this._p(rt.new_string('ending: #' + (var_prefix).str() + '#'))
}

fn (mut this Class_AtomParser) cdata(var_parser rt.PhpVal, var_data rt.PhpVal)  {
	mut var_parser_mutated := var_parser
	this._p(rt.new_string( + ().str() + '#'))
	if !(!rt.is_true(this.in_content)) {
		.array_push(.dup())
	}
}

fn (mut this Class_AtomParser) _default(var_parser rt.PhpVal, var_data rt.PhpVal)  {
	mut var_parser_mutated := var_parser
	// unsupported statement: Stmt_Nop
}

fn (mut this Class_AtomParser) ns_to_prefix(var_qname rt.PhpVal, attr bool) rt.PhpVal {
	
	return rt.new_null()
}

fn (mut this Class_AtomParser) is_declared_content_ns(var_new_mapping rt.PhpVal) bool {
}

fn (mut this Class_AtomParser) xml_escape(var_content rt.PhpVal) rt.PhpVal {
}

fn create_atomfeed() &Class_AtomFeed {
	mut obj := &Class_AtomFeed{
		PhpObjectBase: rt.PhpObjectBase{}
		links: rt.new_array()
		categories: rt.new_array()
		entries: rt.new_array()
	}
	return obj
}

fn create_atomentry() &Class_AtomEntry {
	mut obj := &Class_AtomEntry{
		PhpObjectBase: rt.PhpObjectBase{}
		links: rt.new_array()
		categories: rt.new_array()
	}
	return obj
}

fn create_atomparser() &Class_AtomParser {
	mut obj := &Class_AtomParser{
		PhpObjectBase: rt.PhpObjectBase{}
		NS: rt.new_string('http://www.w3.org/2005/Atom')
		ATOM_CONTENT_ELEMENTS: rt.new_array()
		ATOM_SIMPLE_ELEMENTS: rt.new_array()
		debug: rt.new_bool(false)
		depth: rt.new_int(0)
		indent: rt.new_int(2)
		in_content: rt.new_null()
		ns_contexts: rt.new_array()
		ns_decls: rt.new_array()
		content_ns_decls: rt.new_array()
		content_ns_contexts: rt.new_array()
		is_xhtml: false
		is_html: false
		is_text: false
		skipped_div: rt.new_bool(false)
		FILE: rt.new_string('php://input')
		feed: rt.new_null()
		current: rt.new_null()
		map_attrs_func: rt.new_null()
		map_xmlns_func: rt.new_null()
		error: rt.new_null()
		content: ''
	}
	obj.construct()
	return obj
}

fn (mut this Class_AtomFeed) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_AtomFeed) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'links' { return this.links }
		'categories' { return this.categories }
		'entries' { return this.entries }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_AtomFeed) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'links' { this.links = val; return true }
		'categories' { this.categories = val; return true }
		'entries' { this.entries = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_AtomEntry) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_AtomEntry) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'links' { return this.links }
		'categories' { return this.categories }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_AtomEntry) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'links' { this.links = val; return true }
		'categories' { this.categories = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_AtomParser) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'AtomParser' {
			this.atomparser()
			return rt.new_null()
		}
		'map_attrs' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_string(Class_AtomParser.map_attrs(dispatch_arg_0, dispatch_arg_1))
		}
		'map_xmlns' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_string(Class_AtomParser.map_xmlns(dispatch_arg_0, dispatch_arg_1))
		}
		'_p' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this._p(dispatch_arg_0)
			return rt.new_null()
		}
		'error_handler' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			this.error_handler(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
			return rt.new_null()
		}
		'parse' {
			return rt.new_bool(this.parse())
		}
		'start_element' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			this.start_element(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'end_element' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.end_element(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'start_ns' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			this.start_ns(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'end_ns' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.end_ns(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'cdata' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.cdata(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'_default' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this._default(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'ns_to_prefix' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			return this.ns_to_prefix(dispatch_arg_0, dispatch_arg_1)
		}
		'is_declared_content_ns' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.is_declared_content_ns(dispatch_arg_0))
		}
		'xml_escape' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.xml_escape(dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_AtomParser) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'NS' { return this.NS }
		'ATOM_CONTENT_ELEMENTS' { return this.ATOM_CONTENT_ELEMENTS }
		'ATOM_SIMPLE_ELEMENTS' { return this.ATOM_SIMPLE_ELEMENTS }
		'debug' { return this.debug }
		'depth' { return this.depth }
		'indent' { return this.indent }
		'in_content' { return this.in_content }
		'ns_contexts' { return this.ns_contexts }
		'ns_decls' { return this.ns_decls }
		'content_ns_decls' { return this.content_ns_decls }
		'content_ns_contexts' { return this.content_ns_contexts }
		'is_xhtml' { return rt.new_bool(this.is_xhtml) }
		'is_html' { return rt.new_bool(this.is_html) }
		'is_text' { return rt.new_bool(this.is_text) }
		'skipped_div' { return this.skipped_div }
		'FILE' { return this.FILE }
		'feed' { return this.feed }
		'current' { return this.current }
		'map_attrs_func' { return this.map_attrs_func }
		'map_xmlns_func' { return this.map_xmlns_func }
		'error' { return this.error }
		'content' { return rt.new_string(this.content) }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_AtomParser) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'NS' { this.NS = val; return true }
		'ATOM_CONTENT_ELEMENTS' { this.ATOM_CONTENT_ELEMENTS = val; return true }
		'ATOM_SIMPLE_ELEMENTS' { this.ATOM_SIMPLE_ELEMENTS = val; return true }
		'debug' { this.debug = val; return true }
		'depth' { this.depth = val; return true }
		'indent' { this.indent = val; return true }
		'in_content' { this.in_content = val; return true }
		'ns_contexts' { this.ns_contexts = val; return true }
		'ns_decls' { this.ns_decls = val; return true }
		'content_ns_decls' { this.content_ns_decls = val; return true }
		'content_ns_contexts' { this.content_ns_contexts = val; return true }
		'is_xhtml' { this.is_xhtml = (val).to_bool(); return true }
		'is_html' { this.is_html = (val).to_bool(); return true }
		'is_text' { this.is_text = (val).to_bool(); return true }
		'skipped_div' { this.skipped_div = val; return true }
		'FILE' { this.FILE = val; return true }
		'feed' { this.feed = val; return true }
		'current' { this.current = val; return true }
		'map_attrs_func' { this.map_attrs_func = val; return true }
		'map_xmlns_func' { this.map_xmlns_func = val; return true }
		'error' { this.error = val; return true }
		'content' { this.content = (val).str(); return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}




pub fn init_wp_includes_atomlib_php() {
}
