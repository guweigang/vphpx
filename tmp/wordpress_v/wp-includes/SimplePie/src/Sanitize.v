import rt

struct Class_SimplePie_Sanitize {
	rt.PhpObjectBase
pub mut:
		base rt.PhpVal = rt.new_string('')
		remove_div rt.PhpVal = rt.new_bool(true)
		image_handler rt.PhpVal = rt.new_string('')
		strip_htmltags rt.PhpVal = rt.new_array()
		encode_instead_of_strip rt.PhpVal = rt.new_bool(false)
		strip_attributes rt.PhpVal = rt.new_array()
		rename_attributes rt.PhpVal = rt.new_array()
		add_attributes rt.PhpVal = rt.new_array()
		strip_comments rt.PhpVal = rt.new_bool(false)
		output_encoding rt.PhpVal = rt.new_string('UTF-8')
		enable_cache rt.PhpVal = rt.new_bool(true)
		cache_location rt.PhpVal = rt.new_string('./cache')
		cache_name_function rt.PhpVal = rt.new_string('md5')
		cache_namefilter rt.PhpVal = rt.new_null()
		timeout rt.PhpVal = rt.new_int(10)
		useragent rt.PhpVal = rt.new_string('')
		force_fsockopen rt.PhpVal = rt.new_bool(false)
		replace_url_attributes rt.PhpVal = rt.new_array()
		curl_options rt.PhpVal = rt.new_array()
		registry rt.PhpVal = rt.new_null()
		cache rt.PhpVal = rt.new_null()
		cache_duration rt.PhpVal = rt.new_int(3600)
		https_domains rt.PhpVal = rt.new_array()
		http_client rt.PhpVal = rt.new_null()
}

fn (mut this Class_SimplePie_Sanitize) construct()  {
	this.set_url_replacements(mut rt.cast_object_ptr[Class_SimplePie_?array](rt.new_null()))
}

fn (mut this Class_SimplePie_Sanitize) remove_div(enable bool)  {
	this.remove_div = // unsupported expression: Expr_Cast_Bool
}

fn (mut this Class_SimplePie_Sanitize) set_image_handler(page bool)  {
	if var_page {
		this.image_handler = // unsupported expression: Expr_Cast_String
	} else {
		this.image_handler = rt.new_string('')
	}
}

fn (mut this Class_SimplePie_Sanitize) set_registry(mut var_registry Class_SimplePie_SimplePie_Registry)  {
	this.registry = var_registry.dup()
}

fn (mut this Class_SimplePie_Sanitize) pass_cache_data(enable_cache bool, cache_location string, cache_name_function string, cache_class string, mut var_cache Class_SimplePie_?DataCache)  {
	mut cache_name_function_mutated := cache_name_function
	mut var_cache_mutated := var_cache
	this.enable_cache = rt.new_bool(enable_cache).dup()
	if var_cache_location.len > 0 && var_cache_location != '0' {
		this.cache_location = rt.new_string(cache_location).dup()
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.new_string(cache_name_function_mutated).is_string()))))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(rt.new_object('SimplePie_Cache_CallableNameFilter', []string{}, rt.new_string(cache_name_function_mutated)), 'SimplePie_Cache_NameFilter')))))))) {
		rt.throw_exception(rt.new_object('InvalidArgumentException', []string{}, create_invalidargumentexception(rt.call_function('sprintf', [rt.new_string('%s(): Argument #3 ($cache_name_function) must be of type %s'), rt.new_string(@METHOD), Class_SimplePie_Cache_NameFilter.class()]), rt.new_int(1))))
	}
	if rt.is_true(rt.new_bool(rt.new_string(cache_name_function_mutated).is_string())) {
		this.cache_name_function = rt.new_string(cache_name_function_mutated).dup()
		cache_name_function_mutated = (create_simplepie_cache_callablenamefilter(rt.new_string(cache_name_function_mutated).dup())).str()
	}
	this.cache_namefilter = rt.new_string(cache_name_function_mutated).dup()
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		this.cache = var_cache_mutated.dup()
	}
}

fn (mut this Class_SimplePie_Sanitize) set_http_client(mut var_http_client Class_Psr_Http_Client_ClientInterface, mut var_request_factory Class_Psr_Http_Message_RequestFactoryInterface, mut var_uri_factory Class_Psr_Http_Message_UriFactoryInterface)  {
	this.http_client = create_simplepie_http_psr18client(var_http_client.dup(), var_request_factory.dup(), var_uri_factory.dup())
}

fn (mut this Class_SimplePie_Sanitize) pass_file_data(file_class string, timeout i64, useragent string, force_fsockopen bool, mut var_curl_options Class_SimplePie_array)  {
	if var_timeout != 0 {
		this.timeout = rt.new_int(timeout).dup()
	}
	if var_useragent.len > 0 && var_useragent != '0' {
		this.useragent = rt.new_string(useragent).dup()
	}
	if var_force_fsockopen {
		this.force_fsockopen = rt.new_bool(force_fsockopen).dup()
	}
	this.curl_options = var_curl_options.dup()
	this.http_client = rt.new_null()
}

fn (mut this Class_SimplePie_Sanitize) strip_htmltags(var_tags rt.PhpVal)  {
	if rt.is_true(var_tags) {
		if rt.is_true(rt.new_bool(var_tags.dup().is_array())) {
			this.strip_htmltags = var_tags.dup()
		} else {
			this.strip_htmltags = rt.call_function('explode', [rt.new_string(','), var_tags.dup()])
		}
	} else {
		this.strip_htmltags = rt.new_array()
	}
}

fn (mut this Class_SimplePie_Sanitize) encode_instead_of_strip(encode bool)  {
	this.encode_instead_of_strip = rt.new_bool(encode).dup()
}

fn (mut this Class_SimplePie_Sanitize) rename_attributes(var_attribs rt.PhpVal)  {
	if rt.is_true(var_attribs) {
		if rt.is_true(rt.new_bool(var_attribs.dup().is_array())) {
			this.rename_attributes = var_attribs.dup()
		} else {
			this.rename_attributes = rt.call_function('explode', [rt.new_string(','), var_attribs.dup()])
		}
	} else {
		this.rename_attributes = rt.new_array()
	}
}

fn (mut this Class_SimplePie_Sanitize) strip_attributes(var_attribs rt.PhpVal)  {
	if rt.is_true(var_attribs) {
		if rt.is_true(rt.new_bool(var_attribs.dup().is_array())) {
			this.strip_attributes = var_attribs.dup()
		} else {
			this.strip_attributes = rt.call_function('explode', [rt.new_string(','), var_attribs.dup()])
		}
	} else {
		this.strip_attributes = rt.new_array()
	}
}

fn (mut this Class_SimplePie_Sanitize) add_attributes(mut var_attribs Class_SimplePie_array)  {
	this.add_attributes = var_attribs.dup()
}

fn (mut this Class_SimplePie_Sanitize) strip_comments(strip bool)  {
	this.strip_comments = rt.new_bool(strip).dup()
}

fn (mut this Class_SimplePie_Sanitize) set_output_encoding(encoding string)  {
	this.output_encoding = rt.new_string(encoding).dup()
}

fn (mut this Class_SimplePie_Sanitize) set_url_replacements(mut var_element_attribute Class_SimplePie_?array)  {
	mut var_element_attribute_mutated := var_element_attribute
	if rt.is_true(rt.identical(var_element_attribute_mutated, rt.new_null())) {
		var_element_attribute_mutated = rt.create_array([rt.ArrayItem{ key: 'a', val: 'href' }, rt.ArrayItem{ key: 'area', val: 'href' }, rt.ArrayItem{ key: 'audio', val: 'src' }, rt.ArrayItem{ key: 'blockquote', val: 'cite' }, rt.ArrayItem{ key: 'del', val: 'cite' }, rt.ArrayItem{ key: 'form', val: 'action' }, rt.ArrayItem{ key: 'img', val: rt.create_array([rt.ArrayItem{ key: none, val: 'longdesc' }, rt.ArrayItem{ key: none, val: 'src' }]) }, rt.ArrayItem{ key: 'input', val: 'src' }, rt.ArrayItem{ key: 'ins', val: 'cite' }, rt.ArrayItem{ key: 'q', val: 'cite' }, rt.ArrayItem{ key: 'source', val: 'src' }, rt.ArrayItem{ key: 'video', val: rt.create_array([rt.ArrayItem{ key: none, val: 'poster' }, rt.ArrayItem{ key: none, val: 'src' }]) }])
	}
	this.replace_url_attributes = var_element_attribute_mutated.dup()
}

fn (mut this Class_SimplePie_Sanitize) set_https_domains(mut var_domains Class_SimplePie_array)  {
	this.https_domains = rt.new_array()
	{
		mut iter_1 := var_domains.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_domain := item_1.val
			var_domain = rt.new_string(rt.new_string(var_domain.dup().to_string().trim_space()))
			mut var_segments := rt.call_function('array_reverse', [rt.call_function('explode', [rt.new_string('.'), var_domain.dup()])])
			// unsupported expression: Expr_AssignRef
			{
				mut iter_2 := var_segments.iterator()
				for {
					item_2 := iter_2.next() or { break }
					mut var_segment := item_2.val
					if rt.is_true(rt.identical(var_node, rt.new_bool(true))) {
						break
					}
					if !(var_node.array_isset(var_segment)) {
						var_node.array_set(var_segment, rt.new_array())
					}
					// unsupported expression: Expr_AssignRef
				}
			}
			mut var_node := rt.new_bool(rt.new_bool(true))
		}
	}
}

fn (mut this Class_SimplePie_Sanitize) is_https_domain(domain string) rt.PhpVal {
	mut var_node := rt.new_null()
	mut domain_mutated := domain
	domain_mutated = domain_mutated.trim_space()
	mut var_segments := rt.call_function('array_reverse', [rt.call_function('explode', [rt.new_string('.'), rt.new_string(domain_mutated).dup()])])
	// unsupported expression: Expr_AssignRef
	{
		mut iter_1 := var_segments.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_segment := item_1.val
			if var_node.array_isset(var_segment) {
				// unsupported expression: Expr_AssignRef
			} else {
				break
			}
		}
	}
	return rt.identical(var_node, rt.new_bool(true))
}

fn (mut this Class_SimplePie_Sanitize) https_url(url string) rt.PhpVal {
	return if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string(rt.call_function('substr', [rt.new_string(url), rt.new_int(0), rt.new_int(7)]).to_string().to_lower()), rt.new_string('http://'))) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) && rt.is_true(this.is_https_domain((var_parsed).str())))) { rt.call_function('substr_replace', [rt.new_string(url), rt.new_string('s'), rt.new_int(4), rt.new_int(0)]) } else { rt.new_string(url) }
}

fn (mut this Class_SimplePie_Sanitize) sanitize(data string, type i64, base string) rt.PhpVal {
	mut data_mutated := data
	data_mutated = data_mutated.trim_space()
	if rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) || rt.is_true(rt.bitwise_and(rt.new_int(type), Class_SimplePie_SimplePie_SimplePie.construct_iri())))) {
		if rt.is_true(rt.bitwise_and(rt.new_int(type), Class_SimplePie_SimplePie_SimplePie.construct_maybe_html())) {
			if rt.is_true(rt.call_function('preg_match', ['/(&(#(x[0-9a-fA-F]+|[0-9]+)|[a-zA-Z0-9]+)|<\\/[A-Za-z][^\\x09\\x0A\\x0B\\x0C\\x0D\\x20\\x2F\\x3E]*' + (Class_SimplePie_SimplePie_SimplePie.pcre_html_attribute()).str() + '>)/', rt.new_string(data_mutated).dup()])) {
				// unsupported expression: Expr_AssignOp_BitwiseOr
			} else {
				// unsupported expression: Expr_AssignOp_BitwiseOr
			}
		}
		if rt.is_true(rt.bitwise_and(rt.new_int(type), Class_SimplePie_SimplePie_SimplePie.construct_base64())) {
			data_mutated = (rt.call_function('base64_decode', [rt.new_string(data_mutated).dup()])).str()
		}
		if rt.is_true(type & rt.bitwise_or(Class_SimplePie_SimplePie_SimplePie.construct_html(), Class_SimplePie_SimplePie_SimplePie.construct_xhtml())) {
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [rt.new_string('DOMDocument')]))))) {
				rt.throw_exception(rt.new_object('SimplePie_SimplePie_Exception', []string{}, create_simplepie_simplepie_exception(rt.new_string('DOMDocument not found, unable to use sanitizer'))))
			}
			mut var_document := create_domdocument()
			rt.set_property(var_document, 'encoding', rt.new_string('UTF-8'))
			data_mutated = (this.preprocess(data_mutated, type)).str()
			rt.call_function('set_error_handler', [rt.create_array([rt.ArrayItem{ key: none, val: Class_SimplePie_Misc.class() }, rt.ArrayItem{ key: none, val: 'silence_errors' }])])
			var_document.loadhtml(rt.new_string(data_mutated))
			rt.call_function('restore_error_handler', []rt.PhpVal{})
			mut var_xpath := create_domxpath(var_document.dup())
			if rt.is_true(this.strip_comments) {
				mut var_comments := var_xpath.query(rt.new_string('//comment()'))
				{
					mut iter_1 := var_comments.iterator()
					for {
						item_1 := iter_1.next() or { break }
						mut var_comment := item_1.val
						mut var_parentNode := rt.get_property(var_comment, 'parentNode')
						rt.call_function('assert', [// unsupported expression: Expr_BinaryOp_NotIdentical, rt.new_string('For PHPStan, comment must have a parent')])
						rt.call_method(var_parentNode, 'removeChild', [var_comment.dup()])
					}
				}
			}
			if rt.is_true(this.strip_htmltags) {
				{
					mut iter_1 := this.strip_htmltags.iterator()
					for {
						item_1 := iter_1.next() or { break }
						mut var_tag := item_1.val
						this.strip_tag((var_tag).str(), mut var_document, mut var_xpath, type)
					}
				}
			}
			if rt.is_true(this.rename_attributes) {
				{
					mut iter_1 := this.rename_attributes.iterator()
					for {
						item_1 := iter_1.next() or { break }
						mut var_attrib := item_1.val
						this.rename_attr((var_attrib).str(), mut var_xpath)
					}
				}
			}
			if rt.is_true(this.strip_attributes) {
				{
					mut iter_1 := this.strip_attributes.iterator()
					for {
						item_1 := iter_1.next() or { break }
						mut var_attrib := item_1.val
						this.strip_attr((var_attrib).str(), mut var_xpath)
					}
				}
			}
			if rt.is_true(this.add_attributes) {
				{
					mut iter_1 := this.add_attributes.iterator()
					for {
						item_1 := iter_1.next() or { break }
						mut var_valuePairs := item_1.val
						mut var_tag := item_1.key
						this.add_attr((var_tag).str(), mut rt.cast_object_ptr[Class_SimplePie_array](var_valuePairs), mut var_document)
					}
				}
			}
			this.base = rt.new_string(base).dup()
			{
				mut iter_1 := this.replace_url_attributes.iterator()
				for {
					item_1 := iter_1.next() or { break }
					mut var_attributes := item_1.val
					mut var_element := item_1.key
					this.replace_urls(mut , ().str(), .dup())
				}
			}
			if rt.is_true() {
			}
			
		}
		if rt.is_true() {
		}
		if rt.is_true() {
		}
		if rt.is_true() {
		}
	}
	return rt.new_string(data_mutated)
}

fn (mut this Class_SimplePie_Sanitize) preprocess(html string, type i64) rt.PhpVal {
	mut html_mutated := html
	
}

fn (mut this Class_SimplePie_Sanitize) replace_urls(mut var_document Class_DOMDocument, tag string, var_attributes rt.PhpVal)  {
	mut var_document_mutated := var_document
	mut var_attributes_mutated := var_attributes
}

fn (mut this Class_SimplePie_Sanitize) do_strip_htmltags(mut var_match Class_SimplePie_array) string {
	mut var_match_mutated := var_match
	return ''
}

fn (mut this Class_SimplePie_Sanitize) strip_tag(tag string, mut var_document Class_DOMDocument, mut var_xpath Class_DOMXPath, type i64)  {
	mut var_document_mutated := var_document
	mut var_xpath_mutated := var_xpath
}

fn (mut this Class_SimplePie_Sanitize) strip_attr(attrib string, mut var_xpath Class_DOMXPath)  {
	mut var_xpath_mutated := var_xpath
}

fn (mut this Class_SimplePie_Sanitize) rename_attr(attrib string, mut var_xpath Class_DOMXPath)  {
	mut var_xpath_mutated := var_xpath
}

fn (mut this Class_SimplePie_Sanitize) add_attr(tag string, mut var_valuePairs Class_SimplePie_array, mut var_document Class_DOMDocument)  {
	mut var_document_mutated := var_document
}

fn (mut this Class_SimplePie_Sanitize) get_cache(image_url string) rt.PhpVal {
	mut image_url_mutated := image_url
}

fn (mut this Class_SimplePie_Sanitize) get_http_client() rt.PhpVal {
}

struct Class_InvalidArgumentException {
	rt.PhpObjectBase
}

struct Class_SimplePie_Cache_CallableNameFilter {
	rt.PhpObjectBase
}

struct Class_SimplePie_HTTP_Psr18Client {
	rt.PhpObjectBase
}

struct Class_SimplePie_SimplePie_Exception {
	rt.PhpObjectBase
}

struct Class_DOMDocument {
	rt.PhpObjectBase
}

struct Class_DOMXPath {
	rt.PhpObjectBase
}

fn create_simplepie_sanitize() &Class_SimplePie_Sanitize {
	mut obj := &Class_SimplePie_Sanitize{
		PhpObjectBase: rt.PhpObjectBase{}
		base: rt.new_string('')
		remove_div: rt.new_bool(true)
		image_handler: rt.new_string('')
		strip_htmltags: rt.new_array()
		encode_instead_of_strip: rt.new_bool(false)
		strip_attributes: rt.new_array()
		rename_attributes: rt.new_array()
		add_attributes: rt.new_array()
		strip_comments: rt.new_bool(false)
		output_encoding: rt.new_string('UTF-8')
		enable_cache: rt.new_bool(true)
		cache_location: rt.new_string('./cache')
		cache_name_function: rt.new_string('md5')
		cache_namefilter: rt.new_null()
		timeout: rt.new_int(10)
		useragent: rt.new_string('')
		force_fsockopen: rt.new_bool(false)
		replace_url_attributes: rt.new_array()
		curl_options: rt.new_array()
		registry: rt.new_null()
		cache: rt.new_null()
		cache_duration: rt.new_int(3600)
		https_domains: rt.new_array()
		http_client: rt.new_null()
	}
	obj.construct()
	return obj
}

fn create_invalidargumentexception() &Class_InvalidArgumentException {
	mut obj := &Class_InvalidArgumentException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_simplepie_cache_callablenamefilter() &Class_SimplePie_Cache_CallableNameFilter {
	mut obj := &Class_SimplePie_Cache_CallableNameFilter{
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

fn create_simplepie_simplepie_exception() &Class_SimplePie_SimplePie_Exception {
	mut obj := &Class_SimplePie_SimplePie_Exception{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_domdocument() &Class_DOMDocument {
	mut obj := &Class_DOMDocument{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_domxpath() &Class_DOMXPath {
	mut obj := &Class_DOMXPath{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_SimplePie_Sanitize) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'remove_div' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			this.remove_div(dispatch_arg_0)
			return rt.new_null()
		}
		'set_image_handler' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			this.set_image_handler(dispatch_arg_0)
			return rt.new_null()
		}
		'set_registry' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_SimplePie_SimplePie_Registry](if args.len > 0 { args[0] } else { rt.new_null() })
			this.set_registry(mut dispatch_arg_0)
			return rt.new_null()
		}
		'pass_cache_data' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).str()
			mut dispatch_arg_4 := rt.cast_object_ptr[Class_SimplePie_?DataCache](if args.len > 4 { args[4] } else { rt.new_null() })
			this.pass_cache_data(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3, mut dispatch_arg_4)
			return rt.new_null()
		}
		'set_http_client' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Psr_Http_Client_ClientInterface](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Psr_Http_Message_RequestFactoryInterface](if args.len > 1 { args[1] } else { rt.new_null() })
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Psr_Http_Message_UriFactoryInterface](if args.len > 2 { args[2] } else { rt.new_null() })
			this.set_http_client(mut dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2)
			return rt.new_null()
		}
		'pass_file_data' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).to_bool()
			mut dispatch_arg_4 := rt.cast_object_ptr[Class_SimplePie_array](if args.len > 4 { args[4] } else { rt.new_null() })
			this.pass_file_data(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3, mut dispatch_arg_4)
			return rt.new_null()
		}
		'strip_htmltags' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.strip_htmltags(dispatch_arg_0)
			return rt.new_null()
		}
		'encode_instead_of_strip' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			this.encode_instead_of_strip(dispatch_arg_0)
			return rt.new_null()
		}
		'rename_attributes' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.rename_attributes(dispatch_arg_0)
			return rt.new_null()
		}
		'strip_attributes' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.strip_attributes(dispatch_arg_0)
			return rt.new_null()
		}
		'add_attributes' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_SimplePie_array](if args.len > 0 { args[0] } else { rt.new_null() })
			this.add_attributes(mut dispatch_arg_0)
			return rt.new_null()
		}
		'strip_comments' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			this.strip_comments(dispatch_arg_0)
			return rt.new_null()
		}
		'set_output_encoding' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			this.set_output_encoding(dispatch_arg_0)
			return rt.new_null()
		}
		'set_url_replacements' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_SimplePie_?array](if args.len > 0 { args[0] } else { rt.new_null() })
			this.set_url_replacements(mut dispatch_arg_0)
			return rt.new_null()
		}
		'set_https_domains' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_SimplePie_array](if args.len > 0 { args[0] } else { rt.new_null() })
			this.set_https_domains(mut dispatch_arg_0)
			return rt.new_null()
		}
		'is_https_domain' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.is_https_domain(dispatch_arg_0)
		}
		'https_url' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.https_url(dispatch_arg_0)
		}
		'sanitize' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			return this.sanitize(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'preprocess' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			return this.preprocess(dispatch_arg_0, dispatch_arg_1)
		}
		'replace_urls' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_DOMDocument](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			this.replace_urls(mut dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'do_strip_htmltags' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_SimplePie_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_string(this.do_strip_htmltags(mut dispatch_arg_0))
		}
		'strip_tag' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_DOMDocument](if args.len > 1 { args[1] } else { rt.new_null() })
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_DOMXPath](if args.len > 2 { args[2] } else { rt.new_null() })
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).to_i64()
			this.strip_tag(dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2, dispatch_arg_3)
			return rt.new_null()
		}
		'strip_attr' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_DOMXPath](if args.len > 1 { args[1] } else { rt.new_null() })
			this.strip_attr(dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'rename_attr' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_DOMXPath](if args.len > 1 { args[1] } else { rt.new_null() })
			this.rename_attr(dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'add_attr' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_SimplePie_array](if args.len > 1 { args[1] } else { rt.new_null() })
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_DOMDocument](if args.len > 2 { args[2] } else { rt.new_null() })
			this.add_attr(dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2)
			return rt.new_null()
		}
		'get_cache' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_cache(dispatch_arg_0)
		}
		'get_http_client' {
			return this.get_http_client()
		}
		else { return none }
	}
}

fn (this &Class_SimplePie_Sanitize) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'base' { return this.base }
		'remove_div' { return this.remove_div }
		'image_handler' { return this.image_handler }
		'strip_htmltags' { return this.strip_htmltags }
		'encode_instead_of_strip' { return this.encode_instead_of_strip }
		'strip_attributes' { return this.strip_attributes }
		'rename_attributes' { return this.rename_attributes }
		'add_attributes' { return this.add_attributes }
		'strip_comments' { return this.strip_comments }
		'output_encoding' { return this.output_encoding }
		'enable_cache' { return this.enable_cache }
		'cache_location' { return this.cache_location }
		'cache_name_function' { return this.cache_name_function }
		'cache_namefilter' { return this.cache_namefilter }
		'timeout' { return this.timeout }
		'useragent' { return this.useragent }
		'force_fsockopen' { return this.force_fsockopen }
		'replace_url_attributes' { return this.replace_url_attributes }
		'curl_options' { return this.curl_options }
		'registry' { return this.registry }
		'cache' { return this.cache }
		'cache_duration' { return this.cache_duration }
		'https_domains' { return this.https_domains }
		'http_client' { return this.http_client }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_SimplePie_Sanitize) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'base' { this.base = val; return true }
		'remove_div' { this.remove_div = val; return true }
		'image_handler' { this.image_handler = val; return true }
		'strip_htmltags' { this.strip_htmltags = val; return true }
		'encode_instead_of_strip' { this.encode_instead_of_strip = val; return true }
		'strip_attributes' { this.strip_attributes = val; return true }
		'rename_attributes' { this.rename_attributes = val; return true }
		'add_attributes' { this.add_attributes = val; return true }
		'strip_comments' { this.strip_comments = val; return true }
		'output_encoding' { this.output_encoding = val; return true }
		'enable_cache' { this.enable_cache = val; return true }
		'cache_location' { this.cache_location = val; return true }
		'cache_name_function' { this.cache_name_function = val; return true }
		'cache_namefilter' { this.cache_namefilter = val; return true }
		'timeout' { this.timeout = val; return true }
		'useragent' { this.useragent = val; return true }
		'force_fsockopen' { this.force_fsockopen = val; return true }
		'replace_url_attributes' { this.replace_url_attributes = val; return true }
		'curl_options' { this.curl_options = val; return true }
		'registry' { this.registry = val; return true }
		'cache' { this.cache = val; return true }
		'cache_duration' { this.cache_duration = val; return true }
		'https_domains' { this.https_domains = val; return true }
		'http_client' { this.http_client = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_InvalidArgumentException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_InvalidArgumentException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_InvalidArgumentException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_SimplePie_Cache_CallableNameFilter) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_SimplePie_Cache_CallableNameFilter) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_SimplePie_Cache_CallableNameFilter) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_SimplePie_SimplePie_Exception) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_SimplePie_SimplePie_Exception) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_SimplePie_SimplePie_Exception) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_DOMDocument) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_DOMDocument) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_DOMDocument) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_DOMXPath) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_DOMXPath) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_DOMXPath) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_includes_simplepie_src_sanitize_php() {
	// unsupported statement: Stmt_Declare
}
