import rt

struct Class_SimplePie_Locator {
	rt.PhpObjectBase
pub mut:
		useragent rt.PhpVal = rt.new_null()
		timeout i64
		file rt.PhpVal = rt.new_null()
		local rt.PhpVal = rt.new_array()
		elsewhere rt.PhpVal = rt.new_array()
		cached_entities rt.PhpVal = rt.new_array()
		http_base rt.PhpVal = rt.new_null()
		base rt.PhpVal = rt.new_null()
		base_location rt.PhpVal = rt.new_int(0)
		checked_feeds rt.PhpVal = rt.new_int(0)
		max_checked_feeds i64
		force_fsockopen bool
		curl_options rt.PhpVal = rt.new_array()
		dom rt.PhpVal = rt.new_null()
		registry rt.PhpVal = rt.new_null()
		http_client rt.PhpVal = rt.new_null()
}

fn (mut this Class_SimplePie_Locator) construct(mut var_file Class_SimplePie_File, timeout i64, mut var_useragent Class_SimplePie_?string, max_checked_feeds i64, force_fsockopen bool, mut var_curl_options Class_SimplePie_array)  {
	this.file = var_file.dup()
	this.useragent = var_useragent.dup()
	this.timeout = timeout
	this.max_checked_feeds = max_checked_feeds
	this.force_fsockopen = force_fsockopen
	this.curl_options = var_curl_options.dup()
	mut var_body := rt.call_method(this.file, 'get_body_content', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('class_exists', [rt.new_string('DOMDocument')])) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotEqual))) {
		this.dom = create_simplepie_domdocument()
		rt.call_function('set_error_handler', [rt.create_array([rt.ArrayItem{ key: none, val: Class_SimplePie_Misc.class() }, rt.ArrayItem{ key: none, val: 'silence_errors' }])])
		rt.call_method(this.dom, 'loadHTML', [var_body.dup()])
		if rt.has_exception() { unsafe { goto catch_label_1 } }
		unsafe { goto end_label_1 }

catch_label_1:
		mut var_e_1 := rt.get_and_clear_exception()
		if rt.instance_of(var_e_1, 'SimplePie_Throwable') {
			mut var_ex := var_e_1.dup()
			this.dom = rt.new_null()
			unsafe { goto end_label_1 }
		}
		else {
			rt.throw_exception(var_e_1)
			unsafe { goto end_label_1 }
		}

end_label_1:
		rt.call_function('restore_error_handler', []rt.PhpVal{})
	} else {
		this.dom = rt.new_null()
	}
}

fn (mut this Class_SimplePie_Locator) set_http_client(mut var_http_client Class_Psr_Http_Client_ClientInterface, mut var_request_factory Class_Psr_Http_Message_RequestFactoryInterface, mut var_uri_factory Class_Psr_Http_Message_UriFactoryInterface)  {
	this.http_client = create_simplepie_http_psr18client(var_http_client.dup(), var_request_factory.dup(), var_uri_factory.dup())
}

fn (mut this Class_SimplePie_Locator) set_registry(mut var_registry Class_SimplePie_SimplePie_Registry)  {
	this.registry = var_registry.dup()
}

fn (mut this Class_SimplePie_Locator) find(type i64, mut var_working Class_SimplePie_?array) rt.PhpVal {
	rt.call_function('assert', [// unsupported expression: Expr_BinaryOp_NotIdentical])
	if this.is_feed(mut rt.cast_object_ptr[Class_SimplePie_HTTP_Response](this.file), false) {
		return this.file
	}
	if rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_SimplePie_Misc{}; return temp.is_remote_uri(arg_0) }(rt.call_method(this.file, 'get_final_requested_uri', []rt.PhpVal{}))) {
		mut var_sniffer := rt.call_method(this.registry, 'create', [Class_SimplePie_Content_Type_Sniffer.class(), rt.create_array([rt.ArrayItem{ key: none, val: this.file }])])
		if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
			return rt.new_null()
		}
	}
	if rt.is_true(type & rt.bitwise_not(Class_SimplePie_SimplePie_SimplePie.locator_none())) {
		this.get_base()
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.bitwise_and(rt.new_int(type), Class_SimplePie_SimplePie_SimplePie.locator_autodiscovery())) && rt.is_true(var_working = this.autodiscovery()))) {
		return var_working.array_get(0)
	}
	if rt.is_true(rt.new_bool(rt.is_true(type & rt.bitwise_or(rt.bitwise_or(rt.bitwise_or(Class_SimplePie_SimplePie_SimplePie.locator_local_extension(), Class_SimplePie_SimplePie_SimplePie.locator_local_body()), Class_SimplePie_SimplePie_SimplePie.locator_remote_extension()), Class_SimplePie_SimplePie_SimplePie.locator_remote_body())) && rt.is_true(this.get_links()))) {
		if rt.is_true(rt.new_bool(rt.is_true(rt.bitwise_and(rt.new_int(type), Class_SimplePie_SimplePie_SimplePie.locator_local_extension())) && rt.is_true(var_working = this.extension(mut rt.cast_object_ptr[Class_SimplePie_array](this.local))))) {
			return var_working.array_get(0)
		}
		if rt.is_true(rt.new_bool(rt.is_true(rt.bitwise_and(rt.new_int(type), Class_SimplePie_SimplePie_SimplePie.locator_local_body())) && rt.is_true(var_working = this.body(mut rt.cast_object_ptr[Class_SimplePie_array](this.local))))) {
			return var_working.array_get(0)
		}
		if rt.is_true(rt.new_bool(rt.is_true(rt.bitwise_and(rt.new_int(type), Class_SimplePie_SimplePie_SimplePie.locator_remote_extension())) && rt.is_true(var_working = this.extension(mut rt.cast_object_ptr[Class_SimplePie_array](this.elsewhere))))) {
			return var_working.array_get(0)
		}
		if rt.is_true(rt.new_bool(rt.is_true(rt.bitwise_and(rt.new_int(type), Class_SimplePie_SimplePie_SimplePie.locator_remote_body())) && rt.is_true(var_working = this.body(mut rt.cast_object_ptr[Class_SimplePie_array](this.elsewhere))))) {
			return var_working.array_get(0)
		}
	}
	return rt.new_null()
}

fn (mut this Class_SimplePie_Locator) is_feed(mut var_file Class_SimplePie_HTTP_Response, check_html bool) bool {
	rt.call_function('assert', [// unsupported expression: Expr_BinaryOp_NotIdentical])
	if rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_SimplePie_Misc{}; return temp.is_remote_uri(arg_0) }(var_file.get_final_requested_uri())) {
		mut var_sniffer := rt.call_method(this.registry, 'create', [Class_SimplePie_Content_Type_Sniffer.class(), rt.create_array([rt.ArrayItem{ key: none, val: var_file }])])
		mut var_sniffed := rt.call_method(var_sniffer, 'get_type', []rt.PhpVal{})
		mut var_mime_types := rt.create_array([rt.ArrayItem{ key: none, val: 'application/rss+xml' }, rt.ArrayItem{ key: none, val: 'application/rdf+xml' }, rt.ArrayItem{ key: none, val: 'text/rdf' }, rt.ArrayItem{ key: none, val: 'application/atom+xml' }, rt.ArrayItem{ key: none, val: 'text/xml' }, rt.ArrayItem{ key: none, val: 'application/xml' }, rt.ArrayItem{ key: none, val: 'application/x-rss+xml' }])
		if var_check_html {
			var_mime_types.array_push('text/html')
		}
		return (rt.call_function('in_array', [var_sniffed.dup(), var_mime_types.dup()])).to_bool()
	} else if rt.is_true(rt.call_function('is_file', [var_file.get_final_requested_uri()])) {
		return true
	} else {
		return false
	}
	return false
}

fn (mut this Class_SimplePie_Locator) get_base()  {
	rt.call_function('assert', [// unsupported expression: Expr_BinaryOp_NotIdentical])
	if rt.is_true(rt.identical(this.dom, rt.new_null())) {
		rt.throw_exception(rt.new_object('SimplePie_SimplePie_Exception', []string{}, create_simplepie_simplepie_exception(rt.new_string('DOMDocument not found, unable to use locator'))))
	}
	this.http_base = rt.call_method(this.file, 'get_final_requested_uri', []rt.PhpVal{})
	this.base = this.http_base
	mut var_elements := rt.call_method(this.dom, 'getElementsByTagName', [rt.new_string('base')])
	{
		mut iter_1 := var_elements.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_element := item_1.val
			if rt.is_true(rt.call_method(var_element, 'hasAttribute', [rt.new_string('href')])) {
				mut var_base := rt.call_method(this.registry, 'call', [Class_SimplePie_Misc.class(), rt.new_string('absolutize_url'), rt.create_array([rt.ArrayItem{ key: none, val: rt.call_method(var_element, 'getAttribute', [rt.new_string('href')]).to_string().trim_space() }, rt.ArrayItem{ key: none, val: this.http_base }])])
				if rt.is_true(rt.identical(var_base, rt.new_bool(false))) {
					continue
				}
				this.base = var_base.dup()
				this.base_location = if rt.is_true(rt.call_function('method_exists', [var_element.dup(), rt.new_string('getLineNo')])) { rt.call_method(var_element, 'getLineNo', []rt.PhpVal{}) } else { rt.new_int(0) }
				break
			}
		}
	}
}

fn (mut this Class_SimplePie_Locator) autodiscovery() rt.PhpVal {
	mut var_done := rt.new_array()
	mut var_feeds := rt.new_array()
	var_feeds = rt.call_function('array_merge', [var_feeds.dup(), this.search_elements_by_tag('link', mut rt.cast_object_ptr[Class_SimplePie_array](var_done), mut rt.cast_object_ptr[Class_SimplePie_array](var_feeds))])
	var_feeds = rt.call_function('array_merge', [var_feeds.dup(), this.search_elements_by_tag('a', mut rt.cast_object_ptr[Class_SimplePie_array](var_done), mut rt.cast_object_ptr[Class_SimplePie_array](var_feeds))])
	var_feeds = rt.call_function('array_merge', [var_feeds.dup(), this.search_elements_by_tag('area', mut rt.cast_object_ptr[Class_SimplePie_array](var_done), mut rt.cast_object_ptr[Class_SimplePie_array](var_feeds))])
	if !(!rt.is_true(var_feeds)) {
		return rt.call_function('array_values', [var_feeds.dup()])
	}
	return rt.new_null()
}

fn (mut this Class_SimplePie_Locator) search_elements_by_tag(name string, mut var_done Class_SimplePie_array, mut var_feeds Class_SimplePie_array) rt.PhpVal {
	mut var_done_mutated := var_done
	mut var_feeds_mutated := var_feeds
	rt.call_function('assert', [// unsupported expression: Expr_BinaryOp_NotIdentical])
	if rt.is_true(rt.identical(this.dom, rt.new_null())) {
		rt.throw_exception(rt.new_object('SimplePie_SimplePie_Exception', []string{}, create_simplepie_simplepie_exception(rt.new_string('DOMDocument not found, unable to use locator'))))
	}
	mut var_links := rt.call_method(this.dom, 'getElementsByTagName', [rt.new_string(name)])
	{
		mut iter_1 := var_links.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_link := item_1.val
			if rt.is_true(rt.identical(this.checked_feeds, this.max_checked_feeds)) {
				break
			}
			if rt.is_true(rt.new_bool(rt.is_true(rt.call_method(var_link, 'hasAttribute', [rt.new_string('href')])) && rt.is_true(rt.call_method(var_link, 'hasAttribute', [rt.new_string('rel')])))) {
				mut var_rel := rt.call_function('array_unique', [rt.call_method(this.registry, 'call', [Class_SimplePie_Misc.class(), rt.new_string('space_separated_tokens'), rt.create_array([rt.ArrayItem{ key: none, val: rt.call_method(var_link, 'getAttribute', [rt.new_string('rel')]).to_string().to_lower() }])])])
				mut var_line := if rt.is_true(rt.call_function('method_exists', [var_link.dup(), rt.new_string('getLineNo')])) { rt.call_method(var_link, 'getLineNo', []rt.PhpVal{}) } else { rt.new_int(1) }
				if rt.is_true(rt.less(this.base_location, var_line)) {
					mut var_href := rt.call_method(this.registry, 'call', [Class_SimplePie_Misc.class(), rt.new_string('absolutize_url'), rt.create_array([rt.ArrayItem{ key: none, val: rt.call_method(var_link, 'getAttribute', [rt.new_string('href')]).to_string().trim_space() }, rt.ArrayItem{ key: none, val: this.base }])])
				} else {
					var_href = rt.call_method(this.registry, 'call', [Class_SimplePie_Misc.class(), rt.new_string('absolutize_url'), rt.create_array([rt.ArrayItem{ key: none, val: rt.call_method(var_link, 'getAttribute', [rt.new_string('href')]).to_string().trim_space() }, rt.ArrayItem{ key: none, val: this.http_base }])])
				}
				if rt.is_true(rt.identical(var_href, rt.new_bool(false))) {
					continue
				}
				if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_href.dup(), var_done_mutated.dup()]))))) && rt.is_true(rt.call_function('in_array', [rt.new_string('feed'), var_rel.dup()])))) || rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.call_function('in_array', [rt.new_string('alternate'), var_rel.dup()])) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [rt.new_string('stylesheet'), var_rel.dup()]))))))) && rt.is_true(rt.call_method(var_link, 'hasAttribute', [rt.new_string('type')])))) && rt.is_true(rt.call_function('in_array', [rt.new_string(rt.call_method(this.registry, 'call', [Class_SimplePie_Misc.class(), rt.new_string('parse_mime'), rt.create_array([rt.ArrayItem{ key: none, val: rt.call_method(var_link, 'getAttribute', [rt.new_string('type')]) }])]).to_string().to_lower()), rt.create_array([rt.ArrayItem{ key: none, val: 'text/html' }, rt.ArrayItem{ key: none, val: 'application/rss+xml' }, rt.ArrayItem{ key: none, val: 'application/atom+xml' }])])))) && !(var_feeds_mutated.array_isset(var_href)))))) {
					rt.post_inc(this.checked_feeds)
					mut var_headers := rt.create_array([rt.ArrayItem{ key: 'Accept', val: Class_SimplePie_SimplePie.default_http_accept_header() }])
					mut var_feed := rt.call_method(this.get_http_client(), 'request', [Class_SimplePie_HTTP_Client.method_get(), var_href.dup(), var_headers.dup()])
					if rt.has_exception() { unsafe { goto catch_label_2 } }
					if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_SimplePie_Misc{}; return temp.is_remote_uri(arg_0) }(rt.call_method(var_feed, 'get_final_requested_uri', []rt.PhpVal{})))))) || rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.call_method(var_feed, 'get_status_code', []rt.PhpVal{}), rt.new_int(200))) || rt.is_true(rt.new_bool(rt.is_true(rt.greater(rt.call_method(var_feed, 'get_status_code', []rt.PhpVal{}), rt.new_int(206))) && rt.is_true(rt.less(rt.call_method(var_feed, 'get_status_code', []rt.PhpVal{}), rt.new_int(300))))))))) && this.is_feed(mut rt.cast_object_ptr[Class_SimplePie_HTTP_Response](var_feed), true))) {
						var_feeds_mutated.array_set(var_href, var_feed.dup())
						if rt.has_exception() { unsafe { goto catch_label_2 } }
					}
					if rt.has_exception() { unsafe { goto catch_label_2 } }
					unsafe { goto end_label_2 }

catch_label_2:
					mut var_e_2 := rt.get_and_clear_exception()
					if rt.instance_of(var_e_2, 'SimplePie_HTTP_ClientException') {
						mut var_th := var_e_2.dup()
						// unsupported statement: Stmt_Nop
						unsafe { goto end_label_2 }
					}
					else {
						rt.throw_exception(var_e_2)
						unsafe { goto end_label_2 }
					}

end_label_2:
				}
				var_done_mutated.array_push(var_href.dup())
			}
		}
	}
	return rt.new_object('SimplePie_array', []string{}, var_feeds_mutated)
}

fn (mut this Class_SimplePie_Locator) get_links() rt.PhpVal {
	rt.call_function('assert', [// unsupported expression: Expr_BinaryOp_NotIdentical])
	if rt.is_true(rt.identical(this.dom, rt.new_null())) {
		rt.throw_exception(rt.new_object('SimplePie_SimplePie_Exception', []string{}, create_simplepie_simplepie_exception(rt.new_string('DOMDocument not found, unable to use locator'))))
	}
	mut var_links := rt.call_method(this.dom, 'getElementsByTagName', [rt.new_string('a')])
	{
		mut iter_1 := var_links.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_link := item_1.val
			if rt.is_true(rt.call_method(var_link, 'hasAttribute', [rt.new_string('href')])) {
				mut var_href := rt.new_string(rt.new_string(rt.call_method(var_link, 'getAttribute', [rt.new_string('href')]).to_string().trim_space()))
				mut var_parsed := rt.call_method(this.registry, 'call', [Class_SimplePie_Misc.class(), rt.new_string('parse_url'), rt.create_array([rt.ArrayItem{ key: none, val: var_href }])])
				if rt.is_true(rt.new_bool(rt.is_true(rt.identical(var_parsed.array_get('scheme'), rt.new_string(''))) || rt.is_true(rt.call_function('preg_match', [rt.new_string('/^(https?|feed)?$/i'), var_parsed.array_get('scheme')])))) {
					if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('method_exists', [var_link.dup(), rt.new_string('getLineNo')])) && rt.is_true(rt.less(this.base_location, rt.call_method(var_link, 'getLineNo', []rt.PhpVal{}))))) {
						var_href = rt.call_method(this.registry, 'call', [Class_SimplePie_Misc.class(), rt.new_string('absolutize_url'), rt.create_array([rt.ArrayItem{ key: none, val: rt.call_method(var_link, 'getAttribute', [rt.new_string('href')]).to_string().trim_space() }, rt.ArrayItem{ key: none, val: this.base }])])
					} else {
						var_href = rt.call_method(this.registry, 'call', [Class_SimplePie_Misc.class(), rt.new_string('absolutize_url'), rt.create_array([rt.ArrayItem{ key: none, val: rt.call_method(var_link, 'getAttribute', [rt.new_string('href')]).to_string().trim_space() }, rt.ArrayItem{ key: none, val: this.http_base }])])
					}
					if rt.is_true(rt.identical(var_href, rt.new_bool(false))) {
						continue
					}
					mut var_current := rt.call_method(this.registry, 'call', [Class_SimplePie_Misc.class(), rt.new_string('parse_url'), rt.create_array([rt.ArrayItem{ key: none, val: rt.call_method(this.file, 'get_final_requested_uri', []rt.PhpVal{}) }])])
					if rt.is_true(rt.new_bool(rt.is_true(rt.identical(var_parsed.array_get('authority'), rt.new_string(''))) || rt.is_true(rt.identical(var_parsed.array_get('authority'), var_current.array_get('authority'))))) {
						this.local.array_push(var_href.dup())
					} else {
						this.elsewhere.array_push(var_href.dup())
					}
				}
			}
		}
	}
	this.local = rt.call_function('array_unique', [this.local])
	this.elsewhere = rt.call_function('array_unique', [this.elsewhere])
	if !(!rt.is_true(this.local)) || !(!rt.is_true(this.elsewhere)) {
		return rt.new_bool(true)
	}
	return rt.new_null()
}

fn (mut this Class_SimplePie_Locator) get_rel_link(rel string) rt.PhpVal {
	mut rel_mutated := rel
	
}

fn (mut this Class_SimplePie_Locator) extension(mut var_array Class_SimplePie_array) rt.PhpVal {
}

fn (mut this Class_SimplePie_Locator) body(mut var_array Class_SimplePie_array) rt.PhpVal {
}

fn (mut this Class_SimplePie_Locator) get_http_client() rt.PhpVal {
}

struct Class_SimplePie_DOMDocument {
	rt.PhpObjectBase
}

struct Class_SimplePie_HTTP_Psr18Client {
	rt.PhpObjectBase
}

struct Class_SimplePie_Misc {
	rt.PhpObjectBase
}

struct Class_SimplePie_SimplePie_Exception {
	rt.PhpObjectBase
}

fn create_simplepie_locator(arg_0 rt.PhpVal, timeout i64, arg_2 rt.PhpVal, max_checked_feeds i64, force_fsockopen bool, arg_5 rt.PhpVal) &Class_SimplePie_Locator {
	mut obj := &Class_SimplePie_Locator{
		PhpObjectBase: rt.PhpObjectBase{}
		useragent: rt.new_null()
		timeout: i64(0)
		file: rt.new_null()
		local: rt.new_array()
		elsewhere: rt.new_array()
		cached_entities: rt.new_array()
		http_base: rt.new_null()
		base: rt.new_null()
		base_location: rt.new_int(0)
		checked_feeds: rt.new_int(0)
		max_checked_feeds: i64(0)
		force_fsockopen: false
		curl_options: rt.new_array()
		dom: rt.new_null()
		registry: rt.new_null()
		http_client: rt.new_null()
	}
	obj.construct(arg_0, timeout, arg_2, max_checked_feeds, force_fsockopen, arg_5)
	return obj
}

fn create_simplepie_domdocument() &Class_SimplePie_DOMDocument {
	mut obj := &Class_SimplePie_DOMDocument{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_simplepie_http_psr18client() &Class_SimplePie_HTTP_Psr18Client {
	mut obj := &Class_SimplePie_HTTP_Psr18Client{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_simplepie_misc() &Class_SimplePie_Misc {
	mut obj := &Class_SimplePie_Misc{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_simplepie_simplepie_exception() &Class_SimplePie_SimplePie_Exception {
	mut obj := &Class_SimplePie_SimplePie_Exception{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_SimplePie_Locator) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_SimplePie_File](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_SimplePie_?string](if args.len > 2 { args[2] } else { rt.new_null() })
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).to_i64()
			dispatch_arg_4 := (if args.len > 4 { args[4] } else { rt.new_null() }).to_bool()
			mut dispatch_arg_5 := rt.cast_object_ptr[Class_SimplePie_array](if args.len > 5 { args[5] } else { rt.new_null() })
			this.construct(mut dispatch_arg_0, dispatch_arg_1, mut dispatch_arg_2, dispatch_arg_3, dispatch_arg_4, mut dispatch_arg_5)
			return rt.new_null()
		}
		'set_http_client' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Psr_Http_Client_ClientInterface](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Psr_Http_Message_RequestFactoryInterface](if args.len > 1 { args[1] } else { rt.new_null() })
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Psr_Http_Message_UriFactoryInterface](if args.len > 2 { args[2] } else { rt.new_null() })
			this.set_http_client(mut dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2)
			return rt.new_null()
		}
		'set_registry' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_SimplePie_SimplePie_Registry](if args.len > 0 { args[0] } else { rt.new_null() })
			this.set_registry(mut dispatch_arg_0)
			return rt.new_null()
		}
		'find' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_SimplePie_?array](if args.len > 1 { args[1] } else { rt.new_null() })
			return this.find(dispatch_arg_0, mut dispatch_arg_1)
		}
		'is_feed' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_SimplePie_HTTP_Response](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			return rt.new_bool(this.is_feed(mut dispatch_arg_0, dispatch_arg_1))
		}
		'get_base' {
			this.get_base()
			return rt.new_null()
		}
		'autodiscovery' {
			return this.autodiscovery()
		}
		'search_elements_by_tag' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_SimplePie_array](if args.len > 1 { args[1] } else { rt.new_null() })
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_SimplePie_array](if args.len > 2 { args[2] } else { rt.new_null() })
			return this.search_elements_by_tag(dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2)
		}
		'get_links' {
			return this.get_links()
		}
		'get_rel_link' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_rel_link(dispatch_arg_0)
		}
		'extension' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_SimplePie_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.extension(mut dispatch_arg_0)
		}
		'body' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_SimplePie_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.body(mut dispatch_arg_0)
		}
		'get_http_client' {
			return this.get_http_client()
		}
		else { return none }
	}
}

fn (this &Class_SimplePie_Locator) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'useragent' { return this.useragent }
		'timeout' { return rt.new_int(this.timeout) }
		'file' { return this.file }
		'local' { return this.local }
		'elsewhere' { return this.elsewhere }
		'cached_entities' { return this.cached_entities }
		'http_base' { return this.http_base }
		'base' { return this.base }
		'base_location' { return this.base_location }
		'checked_feeds' { return this.checked_feeds }
		'max_checked_feeds' { return rt.new_int(this.max_checked_feeds) }
		'force_fsockopen' { return rt.new_bool(this.force_fsockopen) }
		'curl_options' { return this.curl_options }
		'dom' { return this.dom }
		'registry' { return this.registry }
		'http_client' { return this.http_client }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_SimplePie_Locator) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'useragent' { this.useragent = val; return true }
		'timeout' { this.timeout = (val).to_i64(); return true }
		'file' { this.file = val; return true }
		'local' { this.local = val; return true }
		'elsewhere' { this.elsewhere = val; return true }
		'cached_entities' { this.cached_entities = val; return true }
		'http_base' { this.http_base = val; return true }
		'base' { this.base = val; return true }
		'base_location' { this.base_location = val; return true }
		'checked_feeds' { this.checked_feeds = val; return true }
		'max_checked_feeds' { this.max_checked_feeds = (val).to_i64(); return true }
		'force_fsockopen' { this.force_fsockopen = (val).to_bool(); return true }
		'curl_options' { this.curl_options = val; return true }
		'dom' { this.dom = val; return true }
		'registry' { this.registry = val; return true }
		'http_client' { this.http_client = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_SimplePie_DOMDocument) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_SimplePie_DOMDocument) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_SimplePie_DOMDocument) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_SimplePie_HTTP_Psr18Client) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_SimplePie_HTTP_Psr18Client) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_SimplePie_HTTP_Psr18Client) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_SimplePie_Misc) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_SimplePie_Misc) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_SimplePie_Misc) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_SimplePie_SimplePie_Exception) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_SimplePie_SimplePie_Exception) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_SimplePie_SimplePie_Exception) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_includes_simplepie_src_locator_php() {
	// unsupported statement: Stmt_Declare
}
