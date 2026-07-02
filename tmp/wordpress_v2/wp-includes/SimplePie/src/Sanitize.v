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

fn (mut this Class_SimplePie_Sanitize) construct() {
	this.set_url_replacements(mut rt.cast_object_ptr[Class_SimplePie_?array](rt.new_null()))
}

fn (mut this Class_SimplePie_Sanitize) remove_div(enable bool) {
	this.remove_div = enable
}

fn (mut this Class_SimplePie_Sanitize) set_image_handler(page bool) {
	if var_page {
		this.image_handler = page.str()
	} else {
		this.image_handler = rt.new_string('')
	}
}

fn (mut this Class_SimplePie_Sanitize) set_registry(mut var_registry Class_SimplePie_SimplePie_Registry) {
	this.registry = var_registry
}

fn (mut this Class_SimplePie_Sanitize) pass_cache_data(enable_cache bool, cache_location string, cache_name_function string, cache_class string, mut var_cache Class_SimplePie_?DataCache) {
	mut cache_name_function_mutated := cache_name_function
	mut var_cache_mutated := var_cache
	this.enable_cache = rt.new_bool(enable_cache)
	if var_cache_location.len > 0 && var_cache_location != '0' {
		this.cache_location = rt.new_string(cache_location)
	}
	if !(rt.new_string(cache_name_function_mutated).clone().is_string()) && rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(rt.new_object('SimplePie_Cache_CallableNameFilter', []string{}, rt.new_string(cache_name_function_mutated)), 'SimplePie_Cache_NameFilter')))))) {
		rt.throw_exception(rt.new_object('InvalidArgumentException', []string{}, create_invalidargumentexception(rt.call_function('sprintf', [rt.new_string('%s(): Argument #3 ($cache_name_function) must be of type %s'), rt.new_string(@METHOD), Class_SimplePie_Cache_NameFilter.class()]), rt.new_int(1))))
	}
	if rt.is_true(rt.new_bool(rt.new_string(cache_name_function_mutated).clone().is_string())) {
		this.cache_name_function = rt.new_string(cache_name_function_mutated).clone()
	cache_name_function_mutated = (create_simplepie_cache_callablenamefilter(rt.new_string(cache_name_function_mutated).clone())).str()
	}
	this.cache_namefilter = rt.new_string(cache_name_function_mutated).clone()
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_cache_mutated, rt.new_null())))) {
		this.cache = var_cache_mutated
	}
}

fn (mut this Class_SimplePie_Sanitize) set_http_client(mut var_http_client Class_Psr_Http_Client_ClientInterface, mut var_request_factory Class_Psr_Http_Message_RequestFactoryInterface, mut var_uri_factory Class_Psr_Http_Message_UriFactoryInterface) {
	this.http_client = create_simplepie_http_psr18client(var_http_client, var_request_factory, var_uri_factory)
}

fn (mut this Class_SimplePie_Sanitize) pass_file_data(file_class string, timeout i64, useragent string, force_fsockopen bool, mut var_curl_options Class_SimplePie_array) {
	if var_timeout != 0 {
		this.timeout = rt.new_int(timeout)
	}
	if var_useragent.len > 0 && var_useragent != '0' {
		this.useragent = rt.new_string(useragent)
	}
	if var_force_fsockopen {
		this.force_fsockopen = rt.new_bool(force_fsockopen)
	}
	this.curl_options = var_curl_options
	this.http_client = rt.new_null()
}

fn (mut this Class_SimplePie_Sanitize) strip_htmltags(var_tags rt.PhpVal) {
	if rt.is_true(var_tags) {
		if rt.is_true(rt.new_bool(var_tags.clone().is_array())) {
			this.strip_htmltags = var_tags.clone()
		} else {
			this.strip_htmltags = rt.call_function('explode', [rt.new_string(','), var_tags.clone()])
		}
	} else {
		this.strip_htmltags = rt.new_array()
	}
}

fn (mut this Class_SimplePie_Sanitize) encode_instead_of_strip(encode bool) {
	this.encode_instead_of_strip = rt.new_bool(encode)
}

fn (mut this Class_SimplePie_Sanitize) rename_attributes(var_attribs rt.PhpVal) {
	if rt.is_true(var_attribs) {
		if rt.is_true(rt.new_bool(var_attribs.clone().is_array())) {
			this.rename_attributes = var_attribs.clone()
		} else {
			this.rename_attributes = rt.call_function('explode', [rt.new_string(','), var_attribs.clone()])
		}
	} else {
		this.rename_attributes = rt.new_array()
	}
}

fn (mut this Class_SimplePie_Sanitize) strip_attributes(var_attribs rt.PhpVal) {
	if rt.is_true(var_attribs) {
		if rt.is_true(rt.new_bool(var_attribs.clone().is_array())) {
			this.strip_attributes = var_attribs.clone()
		} else {
			this.strip_attributes = rt.call_function('explode', [rt.new_string(','), var_attribs.clone()])
		}
	} else {
		this.strip_attributes = rt.new_array()
	}
}

fn (mut this Class_SimplePie_Sanitize) add_attributes(mut var_attribs Class_SimplePie_array) {
	this.add_attributes = var_attribs
}

fn (mut this Class_SimplePie_Sanitize) strip_comments(strip bool) {
	this.strip_comments = rt.new_bool(strip)
}

fn (mut this Class_SimplePie_Sanitize) set_output_encoding(encoding string) {
	this.output_encoding = rt.new_string(encoding)
}

fn (mut this Class_SimplePie_Sanitize) set_url_replacements(mut var_element_attribute Class_SimplePie_?array) {
	mut var_element_attribute_mutated := var_element_attribute
	if rt.is_true(rt.identical(var_element_attribute_mutated, rt.new_null())) {
	var_element_attribute_mutated = rt.create_array([rt.ArrayItem{ key: 'a', val: 'href' }, rt.ArrayItem{ key: 'area', val: 'href' }, rt.ArrayItem{ key: 'audio', val: 'src' }, rt.ArrayItem{ key: 'blockquote', val: 'cite' }, rt.ArrayItem{ key: 'del', val: 'cite' }, rt.ArrayItem{ key: 'form', val: 'action' }, rt.ArrayItem{ key: 'img', val: rt.create_array([rt.ArrayItem{ key: none, val: 'longdesc' }, rt.ArrayItem{ key: none, val: 'src' }]) }, rt.ArrayItem{ key: 'input', val: 'src' }, rt.ArrayItem{ key: 'ins', val: 'cite' }, rt.ArrayItem{ key: 'q', val: 'cite' }, rt.ArrayItem{ key: 'source', val: 'src' }, rt.ArrayItem{ key: 'video', val: rt.create_array([rt.ArrayItem{ key: none, val: 'poster' }, rt.ArrayItem{ key: none, val: 'src' }]) }])
	}
	this.replace_url_attributes = var_element_attribute_mutated
}

fn (mut this Class_SimplePie_Sanitize) set_https_domains(mut var_domains Class_SimplePie_array) {
	this.https_domains = rt.new_array()
	mut iter_1 := var_domains.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_domain := item_1.val
		var_domain = rt.new_string(var_domain.clone().to_string().trim_space())
		mut var_segments := rt.call_function('array_reverse', [rt.call_function('explode', [rt.new_string('.'), var_domain.clone()])])
		mut var_node := this.https_domains
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
			var_node = var_node.array_get(var_segment)
		}
	var_node = rt.new_bool(true)
	}
}

fn (mut this Class_SimplePie_Sanitize) is_https_domain(domain string) rt.PhpVal {
	mut var_node := rt.new_null()
	mut domain_mutated := domain
	domain_mutated = domain_mutated.trim_space()
	mut var_segments := rt.call_function('array_reverse', [rt.call_function('explode', [rt.new_string('.'), rt.new_string(domain_mutated).clone()])])
	var_node = this.https_domains
	mut iter_3 := var_segments.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_segment := item_3.val
		if var_node.array_isset(var_segment) {
			var_node = var_node.array_get(var_segment)
		} else {
			break
		}
	}
	return rt.identical(var_node, rt.new_bool(true))
}

fn (mut this Class_SimplePie_Sanitize) https_url(url string) rt.PhpVal {
	mut var_parsed := rt.call_function('parse_url', [rt.new_string(url), rt.get_constant('PHP_URL_HOST')])
	return if rt.is_true(rt.identical(rt.new_string(rt.call_function('substr', [rt.new_string(url), rt.new_int(0), rt.new_int(7)]).to_string().to_lower()), rt.new_string('http://'))) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_parsed, rt.new_bool(false))))) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_parsed, rt.new_null())))) && rt.is_true(this.is_https_domain((var_parsed).str())) { rt.call_function('substr_replace', [rt.new_string(url), rt.new_string('s'), rt.new_int(4), rt.new_int(0)]) } else { rt.new_string(url) }
}

fn (mut this Class_SimplePie_Sanitize) sanitize(data string, type i64, base string) rt.PhpVal {
	mut data_mutated := data
	data_mutated = data_mutated.trim_space()
	if rt.is_true(rt.new_bool(data_mutated != '')) || rt.is_true(rt.bitwise_and(rt.new_int(type), Class_SimplePie_SimplePie_SimplePie.construct_iri())) {
		if rt.is_true(rt.bitwise_and(rt.new_int(type), Class_SimplePie_SimplePie_SimplePie.construct_maybe_html())) {
			if rt.is_true(rt.call_function('preg_match', [rt.new_string('/(&(#(x[0-9a-fA-F]+|[0-9]+)|[a-zA-Z0-9]+)|<\\/[A-Za-z][^\\x09\\x0A\\x0B\\x0C\\x0D\\x20\\x2F\\x3E]*' + (Class_SimplePie_SimplePie_SimplePie.pcre_html_attribute()).str() + '>)/'), rt.new_string(data_mutated).clone()])) {
				rt.new_null()
			} else {
				rt.new_null()
			}
		}
		if rt.is_true(rt.bitwise_and(rt.new_int(type), Class_SimplePie_SimplePie_SimplePie.construct_base64())) {
		data_mutated = (rt.call_function('base64_decode', [rt.new_string(data_mutated).clone()])).str()
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
			mut var_xpath := create_domxpath(var_document)
			if rt.is_true(this.strip_comments) {
				mut var_comments := var_xpath.query(rt.new_string('//comment()'))
				mut iter_4 := var_comments.iterator()
				for {
					item_4 := iter_4.next() or { break }
					mut var_comment := item_4.val
					mut var_parentNode := rt.get_property(var_comment, 'parentNode')
					rt.call_function('assert', [rt.new_bool(!rt.is_true(rt.identical(var_parentNode, rt.new_null()))), rt.new_string('For PHPStan, comment must have a parent')])
					rt.call_method(var_parentNode, 'removeChild', [var_comment.clone()])
				}
			}
			if rt.is_true(this.strip_htmltags) {
				mut iter_5 := this.strip_htmltags.iterator()
				for {
					item_5 := iter_5.next() or { break }
					mut var_tag := item_5.val
					this.strip_tag((var_tag).str(), mut var_document, mut var_xpath, type)
				}
			}
			if rt.is_true(this.rename_attributes) {
				mut iter_6 := this.rename_attributes.iterator()
				for {
					item_6 := iter_6.next() or { break }
					mut var_attrib := item_6.val
					this.rename_attr((var_attrib).str(), mut var_xpath)
				}
			}
			if rt.is_true(this.strip_attributes) {
				mut iter_7 := this.strip_attributes.iterator()
				for {
					item_7 := iter_7.next() or { break }
					mut var_attrib := item_7.val
					this.strip_attr((var_attrib).str(), mut var_xpath)
				}
			}
			if rt.is_true(this.add_attributes) {
				mut iter_8 := this.add_attributes.iterator()
				for {
					item_8 := iter_8.next() or { break }
					mut var_valuePairs := item_8.val
					mut var_tag := item_8.key
					this.add_attr((var_tag).str(), mut rt.cast_object_ptr[Class_SimplePie_array](var_valuePairs), mut var_document)
				}
			}
			this.base = rt.new_string(base)
			mut iter_9 := this.replace_url_attributes.iterator()
			for {
				item_9 := iter_9.next() or { break }
				mut var_attributes := item_9.val
				mut var_element := item_9.key
				this.replace_urls(mut var_document, (var_element).str(), var_attributes.clone())
			}
			if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(this.image_handler, rt.new_string(''))))) && rt.is_true(this.enable_cache) {
				mut var_images := var_document.getelementsbytagname(rt.new_string('img'))
				mut iter_10 := var_images.iterator()
				for {
					item_10 := iter_10.next() or { break }
					mut var_img := item_10.val
					if rt.is_true(rt.call_method(var_img, 'hasAttribute', [rt.new_string('src')])) {
						mut var_image_url := rt.call_method(this.cache_namefilter, 'filter', [rt.call_method(var_img, 'getAttribute', [rt.new_string('src')])])
						mut var_cache := this.get_cache((var_image_url).str())
						if rt.is_true(rt.call_method(var_cache, 'get_data', [var_image_url.clone(), rt.new_bool(false)])) {
							rt.call_method(var_img, 'setAttribute', [rt.new_string('src'), rt.new_string((this.image_handler).str() + (var_image_url).str())])
						} else {
							mut var_file := rt.call_method(this.get_http_client(), 'request', [Class_SimplePie_HTTP_Client.method_get(), rt.call_method(var_img, 'getAttribute', [rt.new_string('src')]), rt.create_array([rt.ArrayItem{ key: 'X-FORWARDED-FOR', val: rt.get_superglobal('_SERVER').array_get(rt.new_string('REMOTE_ADDR')) }])])
							if rt.has_exception() { unsafe { goto catch_label_1 } }
							unsafe { goto end_label_1 }

catch_label_1:
							mut var_e_1 := rt.get_and_clear_exception()
							if rt.instance_of(var_e_1, 'SimplePie_HTTP_ClientException') {
								mut var_th := var_e_1.clone()
								continue
								unsafe { goto end_label_1 }
							}
							else {
								rt.throw_exception(var_e_1)
								unsafe { goto end_label_1 }
							}

end_label_1:
							mut iife_temp_0 := Class_SimplePie_Misc{}
							mut iife_result_0 := iife_temp_0.is_remote_uri(rt.call_method(var_file, 'get_final_requested_uri', []rt.PhpVal{}))
							if rt.is_true(rt.new_bool(!(rt.is_true(iife_result_0)))) || (rt.is_true(rt.identical(rt.call_method(var_file, 'get_status_code', []rt.PhpVal{}), rt.new_int(200))) || (rt.is_true(rt.greater(rt.call_method(var_file, 'get_status_code', []rt.PhpVal{}), rt.new_int(206))) && rt.is_true(rt.less(rt.call_method(var_file, 'get_status_code', []rt.PhpVal{}), rt.new_int(300))))) {
								if rt.is_true(rt.call_method(var_cache, 'set_data', [var_image_url.clone(), rt.create_array([rt.ArrayItem{ key: 'headers', val: rt.call_method(var_file, 'get_headers', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'body', val: rt.call_method(var_file, 'get_body_content', []rt.PhpVal{}) }]), this.cache_duration])) {
									rt.call_method(var_img, 'setAttribute', [rt.new_string('src'), rt.new_string((this.image_handler).str() + (var_image_url).str())])
								} else {
									rt.call_function('trigger_error', [rt.concat(this.cache_location, rt.new_string(' is not writable. Make sure you\'ve set the correct relative or absolute path, and that the location is server-writable.')), rt.get_constant('E_USER_WARNING')])
								}
							}
						}
					}
				}
			}
			mut var_div := rt.new_null()
			mut var_item := rt.call_method(var_document.getelementsbytagname(rt.new_string('body')), 'item', [rt.new_int(0)])
			if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_item, rt.new_null())))) {
			var_div = rt.get_property(var_item, 'firstChild')
			}
			data_mutated = (var_document.savehtml(var_div.clone())).str().trim_space()
			if rt.is_true(this.remove_div) {
			data_mutated = (rt.call_function('preg_replace', [rt.new_string('/^<div' + (Class_SimplePie_SimplePie_SimplePie.pcre_xml_attribute()).str() + '>/'), rt.new_string(''), rt.new_string(data_mutated).clone()])).str()
			data_mutated = (rt.call_function('preg_replace', [rt.new_string('/<\\/div>$/'), rt.new_string(''), rt.new_string(data_mutated)])).str()
			} else {
			data_mutated = (rt.call_function('preg_replace', [rt.new_string('/^<div' + (Class_SimplePie_SimplePie_SimplePie.pcre_xml_attribute()).str() + '>/'), rt.new_string('<div>'), rt.new_string(data_mutated).clone()])).str()
			}
		data_mutated = (rt.call_function('str_replace', [rt.new_string('</source>'), rt.new_string(''), rt.new_string(data_mutated)])).str()
		}
		if rt.is_true(rt.bitwise_and(rt.new_int(type), Class_SimplePie_SimplePie_SimplePie.construct_iri())) {
			mut var_absolute := rt.call_method(this.registry, 'call', [Class_SimplePie_Misc.class(), rt.new_string('absolutize_url'), rt.create_array([rt.ArrayItem{ key: none, val: data_mutated }, rt.ArrayItem{ key: none, val: base }])])
			if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_absolute, rt.new_bool(false))))) {
			data_mutated = (var_absolute).str()
			}
		}
		if rt.is_true(type & rt.bitwise_or(Class_SimplePie_SimplePie_SimplePie.construct_text(), Class_SimplePie_SimplePie_SimplePie.construct_iri())) {
		data_mutated = (rt.call_function('htmlspecialchars', [rt.new_string(data_mutated).clone(), rt.get_constant('ENT_COMPAT'), rt.new_string('UTF-8')])).str()
		}
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(this.output_encoding, rt.new_string('UTF-8'))))) {
		data_mutated = (rt.call_method(this.registry, 'call', [Class_SimplePie_Misc.class(), rt.new_string('change_encoding'), rt.create_array([rt.ArrayItem{ key: none, val: data_mutated }, rt.ArrayItem{ key: none, val: 'UTF-8' }, rt.ArrayItem{ key: none, val: this.output_encoding }])])).str()
		}
	}
	return rt.new_string(data_mutated)
}

fn (mut this Class_SimplePie_Sanitize) preprocess(html string, type i64) rt.PhpVal {
	mut html_mutated := html
	mut var_ret := rt.new_string('')
	html_mutated = (rt.call_function('preg_replace', [rt.new_string('%</?(?:html|body)[^>]*?' + '>%is'), rt.new_string(''), rt.new_string(html_mutated).clone()])).str()
	if rt.is_true(type & rt.bitwise_not(Class_SimplePie_SimplePie_SimplePie.construct_xhtml())) {
		html_mutated = '<div>' + html_mutated + '</div>'
		var_ret = rt.concat(var_ret, rt.new_string('<!DOCTYPE html>'))
	mut var_content_type := rt.new_string('text/html')
	} else {
		var_ret = rt.concat(var_ret, rt.new_string('<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">'))
	var_content_type = rt.new_string('application/xhtml+xml')
	}
	var_ret = rt.concat(var_ret, rt.new_string('<html><head>'))
	var_ret = rt.concat(var_ret, rt.new_string('<meta http-equiv="Content-Type" content="' + (var_content_type).str() + '; charset=utf-8" />'))
	var_ret = rt.concat(var_ret, rt.new_string('</head><body>' + html_mutated + '</body></html>'))
	return var_ret.clone()
}

fn (mut this Class_SimplePie_Sanitize) replace_urls(mut var_document Class_DOMDocument, tag string, var_attributes rt.PhpVal) {
	mut var_document_mutated := var_document
	mut var_attributes_mutated := var_attributes
	if !(var_attributes_mutated.clone().is_array()) {
	var_attributes_mutated = rt.create_array([rt.ArrayItem{ key: none, val: var_attributes_mutated }])
	}
	if !(this.strip_htmltags.is_array()) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [rt.new_string(tag), this.strip_htmltags]))))) {
		mut var_elements := var_document_mutated.getelementsbytagname(rt.new_string(tag))
		mut iter_11 := var_elements.iterator()
		for {
			item_11 := iter_11.next() or { break }
			mut var_element := item_11.val
			mut iter_12 := var_attributes_mutated.iterator()
			for {
				item_12 := iter_12.next() or { break }
				mut var_attribute := item_12.val
				if rt.is_true(rt.call_method(var_element, 'hasAttribute', [var_attribute.clone()])) {
					mut var_value := rt.call_method(this.registry, 'call', [Class_SimplePie_Misc.class(), rt.new_string('absolutize_url'), rt.create_array([rt.ArrayItem{ key: none, val: rt.call_method(var_element, 'getAttribute', [var_attribute.clone()]) }, rt.ArrayItem{ key: none, val: this.base }])])
					if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_value, rt.new_bool(false))))) {
						var_value = this.https_url((var_value).str())
						rt.call_method(var_element, 'setAttribute', [var_attribute.clone(), var_value.clone()])
					}
				}
			}
		}
	}
}

fn (mut this Class_SimplePie_Sanitize) do_strip_htmltags(mut var_match Class_SimplePie_array) string {
	mut var_match_mutated := var_match
	if rt.is_true(this.encode_instead_of_strip) {
		if var_match_mutated.array_isset(rt.new_int(4)) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [rt.new_string(var_match_mutated.array_get(rt.new_int(1)).to_string().to_lower()), rt.create_array([rt.ArrayItem{ key: none, val: 'script' }, rt.ArrayItem{ key: none, val: 'style' }])]))))) {
			var_match_mutated.array_set(1, rt.call_function('htmlspecialchars', [var_match_mutated.array_get(rt.new_int(1)), rt.get_constant('ENT_COMPAT'), rt.new_string('UTF-8')]))
			var_match_mutated.array_set(2, rt.call_function('htmlspecialchars', [var_match_mutated.array_get(rt.new_int(2)), rt.get_constant('ENT_COMPAT'), rt.new_string('UTF-8')]))
			return rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('&lt;'), var_match_mutated.array_get(rt.new_int(1))), var_match_mutated.array_get(rt.new_int(2))), rt.new_string('&gt;')), var_match_mutated.array_get(rt.new_int(3))), rt.new_string('&lt;/')), var_match_mutated.array_get(rt.new_int(1))), rt.new_string('&gt;'))
		} else {
			return (rt.call_function('htmlspecialchars', [var_match_mutated.array_get(rt.new_int(0)), rt.get_constant('ENT_COMPAT'), rt.new_string('UTF-8')])).str()
		}
	} else if var_match_mutated.array_isset(rt.new_int(4)) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [rt.new_string(var_match_mutated.array_get(rt.new_int(1)).to_string().to_lower()), rt.create_array([rt.ArrayItem{ key: none, val: 'script' }, rt.ArrayItem{ key: none, val: 'style' }])]))))) {
		return (var_match_mutated.array_get(rt.new_int(4))).str()
	} else {
		return ''
	}
	return ''
}

fn (mut this Class_SimplePie_Sanitize) strip_tag(tag string, mut var_document Class_DOMDocument, mut var_xpath Class_DOMXPath, type i64) {
	mut var_document_mutated := var_document
	mut var_xpath_mutated := var_xpath
	mut var_elements := var_xpath_mutated.query(rt.new_string('body//' + tag))
	if rt.is_true(rt.identical(var_elements, rt.new_bool(false))) {
		rt.throw_exception(rt.new_object('SimplePie_SimplePie_Exception', []string{}, create_simplepie_simplepie_exception(rt.call_function('sprintf', [rt.new_string('%s(): Possibly malformed expression, check argument #1 ($tag)'), rt.new_string(@METHOD)]), rt.new_int(1))))
	}
	if rt.is_true(this.encode_instead_of_strip) {
		mut iter_13 := var_elements.iterator()
		for {
			item_13 := iter_13.next() or { break }
			mut var_element := item_13.val
			mut var_fragment := var_document_mutated.createdocumentfragment()
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [rt.new_string(tag), rt.create_array([rt.ArrayItem{ key: none, val: 'script' }, rt.ArrayItem{ key: none, val: 'style' }])]))))) {
				mut var_text := rt.new_string('<' + tag)
				if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.get_property(var_element, 'attributes'), rt.new_null())))) {
					mut var_attrs := rt.new_array()
					mut iter_14 := rt.get_property(var_element, 'attributes').iterator()
					for {
						item_14 := iter_14.next() or { break }
						mut var_attr := item_14.val
						mut var_name := item_14.key
						mut var_value := rt.get_property(var_attr, 'value')
						if !rt.is_true(var_value) && rt.is_true(rt.bitwise_and(rt.new_int(type), Class_SimplePie_SimplePie_SimplePie.construct_xhtml())) {
						var_value = var_name
						} else if !rt.is_true(var_value) && rt.is_true(rt.bitwise_and(rt.new_int(type), Class_SimplePie_SimplePie_SimplePie.construct_html())) {
							var_attrs.array_push(var_name.clone())
							continue
						}
						var_attrs.array_push((var_name).str() + '="' + (rt.get_property(var_attr, 'value')).str() + '"')
					}
					var_text = rt.concat(var_text, rt.new_string(' ' + (rt.call_function('implode', [rt.new_string(' '), var_attrs.clone()])).str()))
				}
				var_text = rt.concat(var_text, rt.new_string('>'))
				rt.call_method(var_fragment, 'appendChild', [create_simplepie_domtext(var_text.clone())])
			}
			mut var_number := rt.get_property(rt.get_property(var_element, 'childNodes'), 'length')
			mut var_i := var_number.clone()
			for {
				if !(rt.is_true(rt.greater(var_i, rt.new_int(0)))) { break }
				mut var_child := rt.call_method(rt.get_property(var_element, 'childNodes'), 'item', [rt.new_int(0)])
				if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_child, rt.new_null())))) {
					rt.call_method(var_fragment, 'appendChild', [var_child.clone()])
				}
				rt.post_dec(var_i)
			}
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [rt.new_string(tag), rt.create_array([rt.ArrayItem{ key: none, val: 'script' }, rt.ArrayItem{ key: none, val: 'style' }])]))))) {
				rt.call_method(var_fragment, 'appendChild', [create_simplepie_domtext('</' + tag + '>')])
			}
			mut var_parentNode := rt.get_property(var_element, 'parentNode')
			if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_parentNode, rt.new_null())))) {
				rt.call_method(var_parentNode, 'replaceChild', [var_fragment.clone(), var_element.clone()])
			}
		}
		return
	} else if rt.is_true(rt.call_function('in_array', [rt.new_string(tag), rt.create_array([rt.ArrayItem{ key: none, val: 'script' }, rt.ArrayItem{ key: none, val: 'style' }])])) {
		mut iter_15 := var_elements.iterator()
		for {
			item_15 := iter_15.next() or { break }
			mut var_element := item_15.val
			mut var_parentNode := rt.get_property(var_element, 'parentNode')
			if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_parentNode, rt.new_null())))) {
				rt.call_method(var_parentNode, 'removeChild', [var_element.clone()])
			}
		}
		return
	} else {
		mut iter_16 := var_elements.iterator()
		for {
			item_16 := iter_16.next() or { break }
			mut var_element := item_16.val
			mut var_fragment := var_document_mutated.createdocumentfragment()
			mut var_number := rt.get_property(rt.get_property(var_element, 'childNodes'), 'length')
			mut var_i := var_number.clone()
			for {
				if !(rt.is_true(rt.greater(var_i, rt.new_int(0)))) { break }
				mut var_child := rt.call_method(rt.get_property(var_element, 'childNodes'), 'item', [rt.new_int(0)])
				if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_child, rt.new_null())))) {
					rt.call_method(var_fragment, 'appendChild', [var_child.clone()])
				}
				rt.post_dec(var_i)
			}
			mut var_parentNode := rt.get_property(var_element, 'parentNode')
			if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_parentNode, rt.new_null())))) {
				rt.call_method(var_parentNode, 'replaceChild', [var_fragment.clone(), var_element.clone()])
			}
		}
	}
}

fn (mut this Class_SimplePie_Sanitize) strip_attr(attrib string, mut var_xpath Class_DOMXPath) {
	mut var_xpath_mutated := var_xpath
	mut var_elements := var_xpath_mutated.query(rt.new_string('//*[@' + attrib + ']'))
	if rt.is_true(rt.identical(var_elements, rt.new_bool(false))) {
		rt.throw_exception(rt.new_object('SimplePie_SimplePie_Exception', []string{}, create_simplepie_simplepie_exception(rt.call_function('sprintf', [rt.new_string('%s(): Possibly malformed expression, check argument #1 ($attrib)'), rt.new_string(@METHOD)]), rt.new_int(1))))
	}
	mut iter_17 := var_elements.iterator()
	for {
		item_17 := iter_17.next() or { break }
		mut var_element := item_17.val
		rt.call_method(var_element, 'removeAttribute', [rt.new_string(attrib)])
	}
}

fn (mut this Class_SimplePie_Sanitize) rename_attr(attrib string, mut var_xpath Class_DOMXPath) {
	mut var_xpath_mutated := var_xpath
	mut var_elements := var_xpath_mutated.query(rt.new_string('//*[@' + attrib + ']'))
	if rt.is_true(rt.identical(var_elements, rt.new_bool(false))) {
		rt.throw_exception(rt.new_object('SimplePie_SimplePie_Exception', []string{}, create_simplepie_simplepie_exception(rt.call_function('sprintf', [rt.new_string('%s(): Possibly malformed expression, check argument #1 ($attrib)'), rt.new_string(@METHOD)]), rt.new_int(1))))
	}
	mut iter_18 := var_elements.iterator()
	for {
		item_18 := iter_18.next() or { break }
		mut var_element := item_18.val
		rt.call_method(var_element, 'setAttribute', [rt.new_string('data-sanitized-' + attrib), rt.call_method(var_element, 'getAttribute', [rt.new_string(attrib)])])
		rt.call_method(var_element, 'removeAttribute', [rt.new_string(attrib)])
	}
}

fn (mut this Class_SimplePie_Sanitize) add_attr(tag string, mut var_valuePairs Class_SimplePie_array, mut var_document Class_DOMDocument) {
	mut var_document_mutated := var_document
	mut var_elements := var_document_mutated.getelementsbytagname(rt.new_string(tag))
	mut iter_19 := var_elements.iterator()
	for {
		item_19 := iter_19.next() or { break }
		mut var_element := item_19.val
		mut iter_20 := var_valuePairs.iterator()
		for {
			item_20 := iter_20.next() or { break }
			mut var_value := item_20.val
			mut var_attrib := item_20.key
			rt.call_method(var_element, 'setAttribute', [var_attrib.clone(), var_value.clone()])
		}
	}
}

fn (mut this Class_SimplePie_Sanitize) get_cache(image_url string) rt.PhpVal {
	mut image_url_mutated := image_url
	if rt.is_true(rt.identical(this.cache, rt.new_null())) {
		mut var_cache := rt.call_method(this.registry, 'call', [Class_SimplePie_Cache.class(), rt.new_string('get_handler'), rt.create_array([rt.ArrayItem{ key: none, val: this.cache_location }, rt.ArrayItem{ key: none, val: image_url_mutated }, rt.ArrayItem{ key: none, val: Class_SimplePie_Cache_Base.type_image() }])])
		return rt.new_object('SimplePie_Cache_BaseDataCache', []string{}, create_simplepie_cache_basedatacache(var_cache.clone()))
	}
	return this.cache
}

fn (mut this Class_SimplePie_Sanitize) get_http_client() rt.PhpVal {
	if rt.is_true(rt.identical(this.http_client, rt.new_null())) {
		this.http_client = create_simplepie_http_fileclient(this.registry, rt.create_array([rt.ArrayItem{ key: 'timeout', val: this.timeout }, rt.ArrayItem{ key: 'redirects', val: 5 }, rt.ArrayItem{ key: 'useragent', val: this.useragent }, rt.ArrayItem{ key: 'force_fsockopen', val: this.force_fsockopen }, rt.ArrayItem{ key: 'curl_options', val: this.curl_options }]))
	}
	return this.http_client
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

struct Class_SimplePie_Misc {
	rt.PhpObjectBase
}

struct Class_SimplePie_DOMText {
	rt.PhpObjectBase
}

struct Class_SimplePie_Cache_BaseDataCache {
	rt.PhpObjectBase
}

struct Class_SimplePie_HTTP_FileClient {
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

fn create_invalidargumentexception(_args ...rt.PhpVal) &Class_InvalidArgumentException {
	mut obj := &Class_InvalidArgumentException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_simplepie_cache_callablenamefilter(_args ...rt.PhpVal) &Class_SimplePie_Cache_CallableNameFilter {
	mut obj := &Class_SimplePie_Cache_CallableNameFilter{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_simplepie_http_psr18client(_args ...rt.PhpVal) &Class_SimplePie_HTTP_Psr18Client {
	mut obj := &Class_SimplePie_HTTP_Psr18Client{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_simplepie_simplepie_exception(_args ...rt.PhpVal) &Class_SimplePie_SimplePie_Exception {
	mut obj := &Class_SimplePie_SimplePie_Exception{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_domdocument(_args ...rt.PhpVal) &Class_DOMDocument {
	mut obj := &Class_DOMDocument{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_domxpath(_args ...rt.PhpVal) &Class_DOMXPath {
	mut obj := &Class_DOMXPath{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_simplepie_misc(_args ...rt.PhpVal) &Class_SimplePie_Misc {
	mut obj := &Class_SimplePie_Misc{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_simplepie_domtext(_args ...rt.PhpVal) &Class_SimplePie_DOMText {
	mut obj := &Class_SimplePie_DOMText{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_simplepie_cache_basedatacache(_args ...rt.PhpVal) &Class_SimplePie_Cache_BaseDataCache {
	mut obj := &Class_SimplePie_Cache_BaseDataCache{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_simplepie_http_fileclient(_args ...rt.PhpVal) &Class_SimplePie_HTTP_FileClient {
	mut obj := &Class_SimplePie_HTTP_FileClient{
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


fn (mut this Class_SimplePie_Misc) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_SimplePie_Misc) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_SimplePie_Misc) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_SimplePie_DOMText) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_SimplePie_DOMText) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_SimplePie_DOMText) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_SimplePie_Cache_BaseDataCache) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_SimplePie_Cache_BaseDataCache) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_SimplePie_Cache_BaseDataCache) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_SimplePie_HTTP_FileClient) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_SimplePie_HTTP_FileClient) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_SimplePie_HTTP_FileClient) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}



fn main() {
	defer {
		rt.shutdown()
	}

	rt.call_function('class_alias', [rt.new_string('SimplePie\\Sanitize'), rt.new_string('SimplePie_Sanitize')])
}
