import rt
import crypto.md5

pub fn Class_SimplePie_SimplePie.name() string {
	return 'SimplePie'
}
pub fn Class_SimplePie_SimplePie.version() string {
	return '1.9.0'
}
pub fn Class_SimplePie_SimplePie.url() string {
	return 'http://simplepie.org'
}
pub fn Class_SimplePie_SimplePie.linkback() string {
	return '<a href="' + (Class_SimplePie_SimplePie_SimplePie.url()).str() + '" title="' + (Class_SimplePie_SimplePie_SimplePie.name()).str() + ' ' + (Class_SimplePie_SimplePie_SimplePie.version()).str() + '">' + (Class_SimplePie_SimplePie_SimplePie.name()).str() + '</a>'
}
pub fn Class_SimplePie_SimplePie.locator_none() i64 {
	return 0
}
pub fn Class_SimplePie_SimplePie.locator_autodiscovery() i64 {
	return 1
}
pub fn Class_SimplePie_SimplePie.locator_local_extension() i64 {
	return 2
}
pub fn Class_SimplePie_SimplePie.locator_local_body() i64 {
	return 4
}
pub fn Class_SimplePie_SimplePie.locator_remote_extension() i64 {
	return 8
}
pub fn Class_SimplePie_SimplePie.locator_remote_body() i64 {
	return 16
}
pub fn Class_SimplePie_SimplePie.locator_all() i64 {
	return 31
}
pub fn Class_SimplePie_SimplePie.type_none() i64 {
	return 0
}
pub fn Class_SimplePie_SimplePie.type_rss_090() i64 {
	return 1
}
pub fn Class_SimplePie_SimplePie.type_rss_091_netscape() i64 {
	return 2
}
pub fn Class_SimplePie_SimplePie.type_rss_091_userland() i64 {
	return 4
}
pub fn Class_SimplePie_SimplePie.type_rss_091() i64 {
	return 6
}
pub fn Class_SimplePie_SimplePie.type_rss_092() i64 {
	return 8
}
pub fn Class_SimplePie_SimplePie.type_rss_093() i64 {
	return 16
}
pub fn Class_SimplePie_SimplePie.type_rss_094() i64 {
	return 32
}
pub fn Class_SimplePie_SimplePie.type_rss_10() i64 {
	return 64
}
pub fn Class_SimplePie_SimplePie.type_rss_20() i64 {
	return 128
}
pub fn Class_SimplePie_SimplePie.type_rss_rdf() i64 {
	return 65
}
pub fn Class_SimplePie_SimplePie.type_rss_syndication() i64 {
	return 190
}
pub fn Class_SimplePie_SimplePie.type_rss_all() i64 {
	return 255
}
pub fn Class_SimplePie_SimplePie.type_atom_03() i64 {
	return 256
}
pub fn Class_SimplePie_SimplePie.type_atom_10() i64 {
	return 512
}
pub fn Class_SimplePie_SimplePie.type_atom_all() i64 {
	return 768
}
pub fn Class_SimplePie_SimplePie.type_all() i64 {
	return 1023
}
pub fn Class_SimplePie_SimplePie.construct_none() i64 {
	return 0
}
pub fn Class_SimplePie_SimplePie.construct_text() i64 {
	return 1
}
pub fn Class_SimplePie_SimplePie.construct_html() i64 {
	return 2
}
pub fn Class_SimplePie_SimplePie.construct_xhtml() i64 {
	return 4
}
pub fn Class_SimplePie_SimplePie.construct_base64() i64 {
	return 8
}
pub fn Class_SimplePie_SimplePie.construct_iri() i64 {
	return 16
}
pub fn Class_SimplePie_SimplePie.construct_maybe_html() i64 {
	return 32
}
pub fn Class_SimplePie_SimplePie.construct_all() i64 {
	return 63
}
pub fn Class_SimplePie_SimplePie.same_case() i64 {
	return 1
}
pub fn Class_SimplePie_SimplePie.lowercase() i64 {
	return 2
}
pub fn Class_SimplePie_SimplePie.uppercase() i64 {
	return 4
}
pub fn Class_SimplePie_SimplePie.pcre_html_attribute() string {
	return '((?:[\\x09\\x0A\\x0B\\x0C\\x0D\\x20]+[^\\x09\\x0A\\x0B\\x0C\\x0D\\x20\\x2F\\x3E][^\\x09\\x0A\\x0B\\x0C\\x0D\\x20\\x2F\\x3D\\x3E]*(?:[\\x09\\x0A\\x0B\\x0C\\x0D\\x20]*=[\\x09\\x0A\\x0B\\x0C\\x0D\\x20]*(?:"(?:[^"]*)"|\'(?:[^\']*)\'|(?:[^\\x09\\x0A\\x0B\\x0C\\x0D\\x20\\x22\\x27\\x3E][^\\x09\\x0A\\x0B\\x0C\\x0D\\x20\\x3E]*)?))?)*)[\\x09\\x0A\\x0B\\x0C\\x0D\\x20]*'
}
pub fn Class_SimplePie_SimplePie.pcre_xml_attribute() string {
	return '((?:\\s+(?:(?:[^\\s:]+:)?[^\\s:]+)\\s*=\\s*(?:"(?:[^"]*)"|\'(?:[^\']*)\'))*)\\s*'
}
pub fn Class_SimplePie_SimplePie.namespace_xml() string {
	return 'http://www.w3.org/XML/1998/namespace'
}
pub fn Class_SimplePie_SimplePie.namespace_atom_10() string {
	return 'http://www.w3.org/2005/Atom'
}
pub fn Class_SimplePie_SimplePie.namespace_atom_03() string {
	return 'http://purl.org/atom/ns#'
}
pub fn Class_SimplePie_SimplePie.namespace_rdf() string {
	return 'http://www.w3.org/1999/02/22-rdf-syntax-ns#'
}
pub fn Class_SimplePie_SimplePie.namespace_rss_090() string {
	return 'http://my.netscape.com/rdf/simple/0.9/'
}
pub fn Class_SimplePie_SimplePie.namespace_rss_10() string {
	return 'http://purl.org/rss/1.0/'
}
pub fn Class_SimplePie_SimplePie.namespace_rss_10_modules_content() string {
	return 'http://purl.org/rss/1.0/modules/content/'
}
pub fn Class_SimplePie_SimplePie.namespace_rss_20() string {
	return ''
}
pub fn Class_SimplePie_SimplePie.namespace_dc_10() string {
	return 'http://purl.org/dc/elements/1.0/'
}
pub fn Class_SimplePie_SimplePie.namespace_dc_11() string {
	return 'http://purl.org/dc/elements/1.1/'
}
pub fn Class_SimplePie_SimplePie.namespace_w3c_basic_geo() string {
	return 'http://www.w3.org/2003/01/geo/wgs84_pos#'
}
pub fn Class_SimplePie_SimplePie.namespace_georss() string {
	return 'http://www.georss.org/georss'
}
pub fn Class_SimplePie_SimplePie.namespace_mediarss() string {
	return 'http://search.yahoo.com/mrss/'
}
pub fn Class_SimplePie_SimplePie.namespace_mediarss_wrong() string {
	return 'http://search.yahoo.com/mrss'
}
pub fn Class_SimplePie_SimplePie.namespace_mediarss_wrong2() string {
	return 'http://video.search.yahoo.com/mrss'
}
pub fn Class_SimplePie_SimplePie.namespace_mediarss_wrong3() string {
	return 'http://video.search.yahoo.com/mrss/'
}
pub fn Class_SimplePie_SimplePie.namespace_mediarss_wrong4() string {
	return 'http://www.rssboard.org/media-rss'
}
pub fn Class_SimplePie_SimplePie.namespace_mediarss_wrong5() string {
	return 'http://www.rssboard.org/media-rss/'
}
pub fn Class_SimplePie_SimplePie.namespace_itunes() string {
	return 'http://www.itunes.com/dtds/podcast-1.0.dtd'
}
pub fn Class_SimplePie_SimplePie.namespace_xhtml() string {
	return 'http://www.w3.org/1999/xhtml'
}
pub fn Class_SimplePie_SimplePie.iana_link_relations_registry() string {
	return 'http://www.iana.org/assignments/relation/'
}
pub fn Class_SimplePie_SimplePie.file_source_none() i64 {
	return 0
}
pub fn Class_SimplePie_SimplePie.file_source_remote() i64 {
	return 1
}
pub fn Class_SimplePie_SimplePie.file_source_local() i64 {
	return 2
}
pub fn Class_SimplePie_SimplePie.file_source_fsockopen() i64 {
	return 4
}
pub fn Class_SimplePie_SimplePie.file_source_curl() i64 {
	return 8
}
pub fn Class_SimplePie_SimplePie.file_source_file_get_contents() i64 {
	return 16
}
pub fn Class_SimplePie_SimplePie.default_http_accept_header() string {
	return 'application/atom+xml, application/rss+xml, application/rdf+xml;q=0.9, application/xml;q=0.8, text/xml;q=0.8, text/html;q=0.7, unknown/unknown;q=0.1, application/unknown;q=0.1, */*;q=0.1'
}
struct Class_SimplePie_SimplePie {
	rt.PhpObjectBase
pub mut:
		data rt.PhpVal = rt.new_array()
		error rt.PhpVal = rt.new_null()
		status_code rt.PhpVal = rt.new_int(0)
		sanitize rt.PhpVal = rt.new_null()
		useragent rt.PhpVal = rt.new_string('')
		feed_url rt.PhpVal = rt.new_null()
		permanent_url rt.PhpVal = rt.new_null()
		file rt.PhpVal = rt.new_null()
		raw_data rt.PhpVal = rt.new_null()
		timeout rt.PhpVal = rt.new_int(10)
		curl_options rt.PhpVal = rt.new_array()
		force_fsockopen rt.PhpVal = rt.new_bool(false)
		force_feed rt.PhpVal = rt.new_bool(false)
		enable_cache rt.PhpVal = rt.new_bool(true)
		cache rt.PhpVal = rt.new_null()
		cache_namefilter rt.PhpVal = rt.new_null()
		force_cache_fallback rt.PhpVal = rt.new_bool(false)
		cache_duration rt.PhpVal = rt.new_int(3600)
		autodiscovery_cache_duration rt.PhpVal = rt.new_int(604800)
		cache_location rt.PhpVal = rt.new_string('./cache')
		cache_name_function rt.PhpVal = rt.new_string('md5')
		order_by_date rt.PhpVal = rt.new_bool(true)
		input_encoding rt.PhpVal = rt.new_bool(false)
		autodiscovery rt.PhpVal = rt.new_null()
		registry rt.PhpVal = rt.new_null()
		max_checked_feeds rt.PhpVal = rt.new_int(10)
		all_discovered_feeds rt.PhpVal = rt.new_array()
		image_handler string
		multifeed_url rt.PhpVal = rt.new_array()
		multifeed_objects rt.PhpVal = rt.new_array()
		config_settings rt.PhpVal = rt.new_null()
		item_limit rt.PhpVal = rt.new_int(0)
		check_modified bool
		strip_attributes rt.PhpVal = rt.new_array()
		add_attributes rt.PhpVal = rt.new_array()
		strip_htmltags rt.PhpVal = rt.new_array()
		rename_attributes rt.PhpVal = rt.new_array()
		enable_exceptions rt.PhpVal = rt.new_bool(false)
		http_client rt.PhpVal = rt.new_null()
		http_client_injected bool
}

fn (mut this Class_SimplePie_SimplePie) construct()  {
	if rt.is_true(rt.call_function('version_compare', [rt.get_constant('PHP_VERSION'), rt.new_string('7.2'), rt.new_string('<')])) {
		// unsupported expression: Expr_Exit
	}
	this.set_useragent(rt.new_null())
	this.set_cache_namefilter(mut rt.cast_object_ptr[Class_SimplePie_Cache_NameFilter](create_simplepie_cache_callablenamefilter(this.cache_name_function)))
	this.sanitize = create_simplepie_sanitize()
	this.registry = create_simplepie_registry()
	if rt.is_true(rt.greater(rt.call_function('func_num_args', []rt.PhpVal{}), rt.new_int(0))) {
		rt.call_function('trigger_error', [rt.new_string('Passing parameters to the constructor is no longer supported. Please use set_feed_url(), set_cache_location(), and set_cache_duration() directly.'), rt.get_constant('E_USER_DEPRECATED')])
		mut var_args := rt.call_function('func_get_args', []rt.PhpVal{})
		match var_args.dup().array_count() {
			3 {
				this.set_cache_duration((var_args.array_get(2)).to_i64())
			}
			2 {
				this.set_cache_location((var_args.array_get(1)).str())
			}
			1 {
				this.set_feed_url(var_args.array_get(0))
				this.init()
			}
		}
	}
}

fn (mut this Class_SimplePie_SimplePie) magic_tostring() string {
	return md5.hexhash(rt.call_function('serialize', [this.data]).to_string())
}

fn (mut this Class_SimplePie_SimplePie) magic_destruct()  {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('gc_enabled', []rt.PhpVal{}))))) {
		if !(!rt.is_true(this.data.array_get('items'))) {
			{
				mut iter_1 := this.data.array_get('items').iterator()
				for {
					item_1 := iter_1.next() or { break }
					mut var_item := item_1.val
					rt.call_method(var_item, '__destruct', []rt.PhpVal{})
				}
			}
			var_item = rt.new_null()
			this.data.array_unset(rt.new_string('items'))
		}
		if !(!rt.is_true(this.data.array_get('ordered_items'))) {
			{
				mut iter_1 := this.data.array_get('ordered_items').iterator()
				for {
					item_1 := iter_1.next() or { break }
					mut var_item := item_1.val
					rt.call_method(var_item, '__destruct', []rt.PhpVal{})
				}
			}
			var_item = rt.new_null()
			this.data.array_unset(rt.new_string('ordered_items'))
		}
	}
}

fn (mut this Class_SimplePie_SimplePie) force_feed(enable bool)  {
	this.force_feed = rt.new_bool(enable).dup()
}

fn (mut this Class_SimplePie_SimplePie) set_feed_url(var_url rt.PhpVal)  {
	mut var_url_mutated := var_url
	this.multifeed_url = rt.new_array()
	if rt.is_true(rt.new_bool(var_url_mutated.dup().is_array())) {
		rt.call_function('trigger_error', [rt.new_string('Fetching multiple feeds with single SimplePie instance is deprecated since SimplePie 1.9.0, create one SimplePie instance per feed and use SimplePie::merge_items to get a single list of items.'), rt.get_constant('E_USER_DEPRECATED')])
		{
			mut iter_1 := var_url_mutated.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_value := item_1.val
				this.multifeed_url.array_push(rt.call_method(this.registry, 'call', [Class_SimplePie_Misc.class(), rt.new_string('fix_protocol'), rt.create_array([rt.ArrayItem{ key: none, val: var_value }, rt.ArrayItem{ key: none, val: 1 }])]))
			}
		}
	} else {
		this.feed_url = rt.call_method(this.registry, 'call', [Class_SimplePie_Misc.class(), rt.new_string('fix_protocol'), rt.create_array([rt.ArrayItem{ key: none, val: var_url_mutated }, rt.ArrayItem{ key: none, val: 1 }])])
		this.permanent_url = this.feed_url
	}
}

fn (mut this Class_SimplePie_SimplePie) set_file(mut var_file Class_SimplePie_File) bool {
	mut var_file_mutated := var_file
	this.feed_url = rt.call_method(var_file_mutated, 'get_final_requested_uri', []rt.PhpVal{})
	this.permanent_url = this.feed_url
	// unsupported expression: Expr_AssignRef
	return true
}

fn (mut this Class_SimplePie_SimplePie) set_raw_data(data string)  {
	this.raw_data = rt.new_string(data).dup()
}

fn (mut this Class_SimplePie_SimplePie) set_http_client(mut var_http_client Class_Psr_Http_Client_ClientInterface, mut var_request_factory Class_Psr_Http_Message_RequestFactoryInterface, mut var_uri_factory Class_Psr_Http_Message_UriFactoryInterface)  {
	mut var_http_client_mutated := var_http_client
	this.http_client = create_simplepie_http_psr18client(var_http_client_mutated.dup(), var_request_factory.dup(), var_uri_factory.dup())
}

fn (mut this Class_SimplePie_SimplePie) set_timeout(timeout i64)  {
	if rt.is_true(this.http_client_injected) {
		rt.throw_exception(rt.new_object('SimplePie_Exception', []string{}, create_simplepie_exception(rt.call_function('sprintf', [rt.new_string('Using "%s()" has no effect, because you already provided a HTTP client with "%s::set_http_client()". Configure timeout in your HTTP client instead.'), rt.new_string(@METHOD), Class_SimplePie_SimplePie_SimplePie.class()]))))
	}
	this.timeout = // unsupported expression: Expr_Cast_Int
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(this.http_client.is_object())) && rt.is_true(rt.new_bool(rt.instance_of(this.http_client, 'SimplePie_HTTP_FileClient'))))) {
		this.http_client = rt.new_null()
	} else if rt.is_true(rt.new_bool(this.http_client.is_object())) {
		rt.call_function('trigger_error', [rt.call_function('sprintf', [rt.new_string('Using "%s()" has no effect, because you already provided a HTTP client with "%s::set_http_client()". Configure the timeout in your HTTP client instead.'), rt.new_string(@METHOD), rt.call_function('get_class', [rt.new_object('SimplePie_SimplePie', []string{}, &this)])]), rt.get_constant('E_USER_NOTICE')])
	}
}

fn (mut this Class_SimplePie_SimplePie) set_curl_options(mut var_curl_options Class_SimplePie_array)  {
	if rt.is_true(this.http_client_injected) {
		rt.throw_exception(rt.new_object('SimplePie_Exception', []string{}, create_simplepie_exception(rt.call_function('sprintf', [rt.new_string('Using "%s()" has no effect, because you already provided a HTTP client with "%s::set_http_client()". Configure custom curl options in your HTTP client instead.'), rt.new_string(@METHOD), Class_SimplePie_SimplePie_SimplePie.class()]))))
	}
	this.curl_options = var_curl_options.dup()
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(this.http_client.is_object())) && rt.is_true(rt.new_bool(rt.instance_of(this.http_client, 'SimplePie_HTTP_FileClient'))))) {
		this.http_client = rt.new_null()
	} else if rt.is_true(rt.new_bool(this.http_client.is_object())) {
		rt.call_function('trigger_error', [rt.call_function('sprintf', [rt.new_string('Using "%s()" has no effect, because you already provided a HTTP client with "%s::set_http_client()". Configure the curl options in your HTTP client instead.'), rt.new_string(@METHOD), rt.call_function('get_class', [rt.new_object('SimplePie_SimplePie', []string{}, &this)])]), rt.get_constant('E_USER_NOTICE')])
	}
}

fn (mut this Class_SimplePie_SimplePie) force_fsockopen(enable bool)  {
	if rt.is_true(this.http_client_injected) {
		rt.throw_exception(rt.new_object('SimplePie_Exception', []string{}, create_simplepie_exception(rt.call_function('sprintf', [rt.new_string('Using "%s()" has no effect, because you already provided a HTTP client with "%s::set_http_client()". Configure fsockopen in your HTTP client instead.'), rt.new_string(@METHOD), Class_SimplePie_SimplePie_SimplePie.class()]))))
	}
	this.force_fsockopen = rt.new_bool(enable).dup()
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(this.http_client.is_object())) && rt.is_true(rt.new_bool(rt.instance_of(this.http_client, 'SimplePie_HTTP_FileClient'))))) {
		this.http_client = rt.new_null()
	} else if rt.is_true(rt.new_bool(this.http_client.is_object())) {
		rt.call_function('trigger_error', [rt.call_function('sprintf', [rt.new_string('Using "%s()" has no effect, because you already provided a HTTP client with "%s::set_http_client()". Configure fsockopen in your HTTP client instead.'), rt.new_string(@METHOD), rt.call_function('get_class', [rt.new_object('SimplePie_SimplePie', []string{}, &this)])]), rt.get_constant('E_USER_NOTICE')])
	}
}

fn (mut this Class_SimplePie_SimplePie) enable_cache(enable bool)  {
	this.enable_cache = rt.new_bool(enable).dup()
}

fn (mut this Class_SimplePie_SimplePie) set_cache(mut var_cache Class_Psr_SimpleCache_CacheInterface)  {
	mut var_cache_mutated := var_cache
	this.cache = create_simplepie_cache_psr16(var_cache_mutated.dup())
}

fn (mut this Class_SimplePie_SimplePie) force_cache_fallback(enable bool)  {
	this.force_cache_fallback = rt.new_bool(enable).dup()
}

fn (mut this Class_SimplePie_SimplePie) set_cache_duration(seconds i64)  {
	this.cache_duration = rt.new_int(seconds).dup()
}

fn (mut this Class_SimplePie_SimplePie) set_autodiscovery_cache_duration(seconds i64)  {
	this.autodiscovery_cache_duration = rt.new_int(seconds).dup()
}

fn (mut this Class_SimplePie_SimplePie) set_cache_location(location string)  {
	this.cache_location = rt.new_string(location).dup()
}

fn (mut this Class_SimplePie_SimplePie) get_cache_filename(url string) rt.PhpVal {
	mut url_mutated := url
	// unsupported expression: Expr_AssignOp_Concat
	mut var_options := rt.new_array()
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotEqual) {
		var_options.array_set(rt.get_constant('CURLOPT_TIMEOUT'), this.timeout)
	}
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		var_options.array_set(rt.get_constant('CURLOPT_USERAGENT'), this.useragent)
	}
	if !(!rt.is_true(this.curl_options)) {
		{
			mut iter_1 := this.curl_options.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_v := item_1.val
				mut var_k := item_1.key
				var_options.array_set(var_k, var_v.dup())
			}
		}
	}
	if !(!rt.is_true(var_options)) {
		rt.call_function('ksort', [var_options.dup()])
		// unsupported expression: Expr_AssignOp_Concat
	}
	return rt.call_method(this.cache_namefilter, 'filter', [rt.new_string(url_mutated).dup()])
}

fn (mut this Class_SimplePie_SimplePie) enable_order_by_date(enable bool)  {
	this.order_by_date = rt.new_bool(enable).dup()
}

fn (mut this Class_SimplePie_SimplePie) set_input_encoding(encoding bool)  {
	if var_encoding {
		this.input_encoding = // unsupported expression: Expr_Cast_String
	} else {
		this.input_encoding = rt.new_bool(false)
	}
}

fn (mut this Class_SimplePie_SimplePie) set_autodiscovery_level(level i64)  {
	this.autodiscovery = rt.new_int(level).dup()
}

fn (mut this Class_SimplePie_SimplePie) get_registry() rt.PhpVal {
	return this.registry
}

fn (mut this Class_SimplePie_SimplePie) set_cache_class(class string) rt.PhpVal {
	mut class_mutated := class
	rt.call_function('trigger_error', [rt.call_function('sprintf', [rt.new_string('"%s()" is deprecated since SimplePie 1.3, please use "SimplePie\\SimplePie::set_cache()" instead.'), rt.new_string(@METHOD)]), rt.get_constant('E_USER_DEPRECATED')])
	return rt.call_method(this.registry, 'register', [Class_SimplePie_Cache.class(), rt.new_string(class_mutated).dup(), rt.new_bool(true)])
}

fn (mut this Class_SimplePie_SimplePie) set_locator_class(class string) rt.PhpVal {
	mut class_mutated := class
	rt.call_function('trigger_error', [rt.call_function('sprintf', [rt.new_string('"%s()" is deprecated since SimplePie 1.3, please use "SimplePie\\SimplePie::get_registry()" instead.'), rt.new_string(@METHOD)]), rt.get_constant('E_USER_DEPRECATED')])
	return rt.call_method(this.registry, 'register', [Class_SimplePie_Locator.class(), rt.new_string(class_mutated).dup(), rt.new_bool(true)])
}

fn (mut this Class_SimplePie_SimplePie) set_parser_class(class string) rt.PhpVal {
	mut class_mutated := class
	rt.call_function('trigger_error', [rt.call_function('sprintf', [rt.new_string('"%s()" is deprecated since SimplePie 1.3, please use "SimplePie\\SimplePie::get_registry()" instead.'), rt.new_string(@METHOD)]), rt.get_constant('E_USER_DEPRECATED')])
	return rt.call_method(this.registry, 'register', [Class_SimplePie_Parser.class(), rt.new_string(class_mutated).dup(), rt.new_bool(true)])
}

fn (mut this Class_SimplePie_SimplePie) set_file_class(class string) rt.PhpVal {
	mut class_mutated := class
	rt.call_function('trigger_error', [rt.call_function('sprintf', [rt.new_string('"%s()" is deprecated since SimplePie 1.3, please use "SimplePie\\SimplePie::get_registry()" instead.'), rt.new_string(@METHOD)]), rt.get_constant('E_USER_DEPRECATED')])
	return rt.call_method(this.registry, 'register', [Class_SimplePie_File.class(), rt.new_string(class_mutated).dup(), rt.new_bool(true)])
}

fn (mut this Class_SimplePie_SimplePie) set_sanitize_class(class string) rt.PhpVal {
	mut class_mutated := class
	rt.call_function('trigger_error', [rt.call_function('sprintf', [rt.new_string('"%s()" is deprecated since SimplePie 1.3, please use "SimplePie\\SimplePie::get_registry()" instead.'), rt.new_string(@METHOD)]), rt.get_constant('E_USER_DEPRECATED')])
	return rt.call_method(this.registry, 'register', [Class_SimplePie_Sanitize.class(), rt.new_string(class_mutated).dup(), rt.new_bool(true)])
}

fn (mut this Class_SimplePie_SimplePie) set_item_class(class string) rt.PhpVal {
	mut class_mutated := class
	rt.call_function('trigger_error', [rt.call_function('sprintf', [rt.new_string('"%s()" is deprecated since SimplePie 1.3, please use "SimplePie\\SimplePie::get_registry()" instead.'), rt.new_string(@METHOD)]), rt.get_constant('E_USER_DEPRECATED')])
	return rt.call_method(this.registry, 'register', [Class_SimplePie_Item.class(), rt.new_string(class_mutated).dup(), rt.new_bool(true)])
}

fn (mut this Class_SimplePie_SimplePie) set_author_class(class string) rt.PhpVal {
	mut class_mutated := class
	rt.call_function('trigger_error', [rt.call_function('sprintf', [, ]), rt.get_constant('E_USER_DEPRECATED')])
	return rt.call_method(, 'register', [, .dup(), ])
}

fn (mut this Class_SimplePie_SimplePie) set_category_class(class string) rt.PhpVal {
	mut class_mutated := class
	
}

fn (mut this Class_SimplePie_SimplePie) set_enclosure_class(class string) rt.PhpVal {
	mut class_mutated := class
}

fn (mut this Class_SimplePie_SimplePie) set_caption_class(class string) rt.PhpVal {
	mut class_mutated := class
}

fn (mut this Class_SimplePie_SimplePie) set_copyright_class(class string) rt.PhpVal {
	mut class_mutated := class
}

fn (mut this Class_SimplePie_SimplePie) set_credit_class(class string) rt.PhpVal {
	mut class_mutated := class
}

fn (mut this Class_SimplePie_SimplePie) set_rating_class(class string) rt.PhpVal {
	mut class_mutated := class
}

fn (mut this Class_SimplePie_SimplePie) set_restriction_class(class string) rt.PhpVal {
	mut class_mutated := class
}

fn (mut this Class_SimplePie_SimplePie) set_content_type_sniffer_class(class string) rt.PhpVal {
	mut class_mutated := class
}

fn (mut this Class_SimplePie_SimplePie) set_source_class(class string) rt.PhpVal {
	mut class_mutated := class
}

fn (mut this Class_SimplePie_SimplePie) set_useragent(mut var_ua Class_SimplePie_?string)  {
	mut var_ua_mutated := var_ua
}

fn (mut this Class_SimplePie_SimplePie) set_cache_namefilter(mut var_filter Class_SimplePie_Cache_NameFilter)  {
}

fn (mut this Class_SimplePie_SimplePie) set_cache_name_function(mut var_function Class_SimplePie_?string)  {
	mut var_function_mutated := var_function
}

fn (mut this Class_SimplePie_SimplePie) set_stupidly_fast(set bool)  {
}

fn (mut this Class_SimplePie_SimplePie) set_max_checked_feeds(max i64)  {
}

fn (mut this Class_SimplePie_SimplePie) remove_div(enable bool)  {
}

fn (mut this Class_SimplePie_SimplePie) strip_htmltags(tags string, mut var_encode Class_SimplePie_?bool)  {
	mut tags_mutated := tags
}

fn (mut this Class_SimplePie_SimplePie) encode_instead_of_strip(enable bool)  {
}

fn (mut this Class_SimplePie_SimplePie) rename_attributes(attribs string)  {
	mut attribs_mutated := attribs
}

fn (mut this Class_SimplePie_SimplePie) strip_attributes(attribs string)  {
	mut attribs_mutated := attribs
}

fn (mut this Class_SimplePie_SimplePie) add_attributes(attribs string)  {
	mut attribs_mutated := attribs
}

fn (mut this Class_SimplePie_SimplePie) set_output_encoding(encoding string)  {
}

fn (mut this Class_SimplePie_SimplePie) strip_comments(strip bool)  {
}

fn (mut this Class_SimplePie_SimplePie) set_url_replacements(mut var_element_attribute Class_SimplePie_?array)  {
}

fn (mut this Class_SimplePie_SimplePie) set_https_domains(mut var_domains Class_SimplePie_array)  {
}

fn (mut this Class_SimplePie_SimplePie) set_image_handler(page bool, qs string)  {
}

fn (mut this Class_SimplePie_SimplePie) set_item_limit(limit i64)  {
}

fn (mut this Class_SimplePie_SimplePie) enable_exceptions(enable bool)  {
}

fn (mut this Class_SimplePie_SimplePie) init() bool {
	mut var_values := rt.new_null()
	mut var_headers := rt.new_null()
	mut var_sniffed := rt.new_null()
	mut var_charset := rt.new_null()
}

fn (mut this Class_SimplePie_SimplePie) fetch_data(var_cache rt.PhpVal) rt.PhpVal {
	mut var_cache_mutated := var_cache
}

fn (mut this Class_SimplePie_SimplePie) error() rt.PhpVal {
}

fn (mut this Class_SimplePie_SimplePie) status_code() rt.PhpVal {
}

fn (mut this Class_SimplePie_SimplePie) get_raw_data() rt.PhpVal {
}

fn (mut this Class_SimplePie_SimplePie) get_encoding() rt.PhpVal {
}

fn (mut this Class_SimplePie_SimplePie) handle_content_type(mime string)  {
}

fn (mut this Class_SimplePie_SimplePie) get_type() rt.PhpVal {
}

fn (mut this Class_SimplePie_SimplePie) subscribe_url(permanent bool) rt.PhpVal {
}

fn (mut this Class_SimplePie_SimplePie) get_feed_tags(namespace string, tag string) rt.PhpVal {
}

fn (mut this Class_SimplePie_SimplePie) get_channel_tags(namespace string, tag string) rt.PhpVal {
}

fn (mut this Class_SimplePie_SimplePie) get_image_tags(namespace string, tag string) rt.PhpVal {
}

fn (mut this Class_SimplePie_SimplePie) get_base(mut var_element Class_SimplePie_array) rt.PhpVal {
}

fn (mut this Class_SimplePie_SimplePie) sanitize(data string, type i64, base string) rt.PhpVal {
	mut type_mutated := type
	return rt.new_null()
}

fn (mut this Class_SimplePie_SimplePie) get_title() rt.PhpVal {
}

fn (mut this Class_SimplePie_SimplePie) get_category(key i64) rt.PhpVal {
}

fn (mut this Class_SimplePie_SimplePie) get_categories() rt.PhpVal {
}

fn (mut this Class_SimplePie_SimplePie) get_author(key i64) rt.PhpVal {
}

fn (mut this Class_SimplePie_SimplePie) get_authors() rt.PhpVal {
}

fn (mut this Class_SimplePie_SimplePie) get_contributor(key i64) rt.PhpVal {
}

fn (mut this Class_SimplePie_SimplePie) get_contributors() rt.PhpVal {
}

fn (mut this Class_SimplePie_SimplePie) get_link(key i64, rel string) rt.PhpVal {
}

fn (mut this Class_SimplePie_SimplePie) get_permalink() rt.PhpVal {
}

fn (mut this Class_SimplePie_SimplePie) get_links(rel string) rt.PhpVal {
	mut var_matches := rt.new_null()
}

fn (mut this Class_SimplePie_SimplePie) get_all_discovered_feeds() rt.PhpVal {
}

fn (mut this Class_SimplePie_SimplePie) get_description() rt.PhpVal {
}

fn (mut this Class_SimplePie_SimplePie) get_copyright() rt.PhpVal {
}

fn (mut this Class_SimplePie_SimplePie) get_language() rt.PhpVal {
}

fn (mut this Class_SimplePie_SimplePie) get_latitude() rt.PhpVal {
	mut var_match := rt.new_null()
}

fn (mut this Class_SimplePie_SimplePie) get_longitude() rt.PhpVal {
	mut var_match := rt.new_null()
}

fn (mut this Class_SimplePie_SimplePie) get_image_title() rt.PhpVal {
}

fn (mut this Class_SimplePie_SimplePie) get_image_url() rt.PhpVal {
}

fn (mut this Class_SimplePie_SimplePie) get_image_link() rt.PhpVal {
}

fn (mut this Class_SimplePie_SimplePie) get_image_width() rt.PhpVal {
}

fn (mut this Class_SimplePie_SimplePie) get_image_height() rt.PhpVal {
}

fn (mut this Class_SimplePie_SimplePie) get_item_quantity(max i64) rt.PhpVal {
}

fn (mut this Class_SimplePie_SimplePie) get_item(key i64) rt.PhpVal {
}

fn (mut this Class_SimplePie_SimplePie) get_items(start i64, end i64) rt.PhpVal {
}

fn (mut this Class_SimplePie_SimplePie) set_favicon_handler(page bool, qs string) bool {
}

fn (mut this Class_SimplePie_SimplePie) get_favicon() rt.PhpVal {
}

fn (mut this Class_SimplePie_SimplePie) magic_call(method string, mut var_args Class_SimplePie_array) rt.PhpVal {
	mut var_args_mutated := var_args
	return rt.new_null()
}

fn (mut this Class_SimplePie_SimplePie) make_item(mut var_data Class_SimplePie_array) rt.PhpVal {
}

fn Class_SimplePie_SimplePie.sort_items(mut var_a Class_SimplePie_Item, mut var_b Class_SimplePie_Item) i64 {
}

fn Class_SimplePie_SimplePie.merge_items(mut var_urls Class_SimplePie_array, start i64, end i64, limit i64) rt.PhpVal {
}

fn (mut this Class_SimplePie_SimplePie) store_links(mut var_file Class_SimplePie_HTTP_Response, mut var_hub Class_SimplePie_?string, mut var_self Class_SimplePie_?string) rt.PhpVal {
	mut var_file_mutated := var_file
	mut var_hub_mutated := var_hub
	mut var_self_mutated := var_self
}

fn (mut this Class_SimplePie_SimplePie) get_cache(feed_url string) rt.PhpVal {
}

fn (mut this Class_SimplePie_SimplePie) get_http_client() rt.PhpVal {
}

struct Class_SimplePie_Cache_CallableNameFilter {
	rt.PhpObjectBase
}

struct Class_SimplePie_Sanitize {
	rt.PhpObjectBase
}

struct Class_SimplePie_Registry {
	rt.PhpObjectBase
}

struct Class_SimplePie_HTTP_Psr18Client {
	rt.PhpObjectBase
}

struct Class_SimplePie_Exception {
	rt.PhpObjectBase
}

struct Class_SimplePie_Cache_Psr16 {
	rt.PhpObjectBase
}

fn create_simplepie_simplepie() &Class_SimplePie_SimplePie {
	mut obj := &Class_SimplePie_SimplePie{
		PhpObjectBase: rt.PhpObjectBase{}
		data: rt.new_array()
		error: rt.new_null()
		status_code: rt.new_int(0)
		sanitize: rt.new_null()
		useragent: rt.new_string('')
		feed_url: rt.new_null()
		permanent_url: rt.new_null()
		file: rt.new_null()
		raw_data: rt.new_null()
		timeout: rt.new_int(10)
		curl_options: rt.new_array()
		force_fsockopen: rt.new_bool(false)
		force_feed: rt.new_bool(false)
		enable_cache: rt.new_bool(true)
		cache: rt.new_null()
		cache_namefilter: rt.new_null()
		force_cache_fallback: rt.new_bool(false)
		cache_duration: rt.new_int(3600)
		autodiscovery_cache_duration: rt.new_int(604800)
		cache_location: rt.new_string('./cache')
		cache_name_function: rt.new_string('md5')
		order_by_date: rt.new_bool(true)
		input_encoding: rt.new_bool(false)
		autodiscovery: rt.new_null()
		registry: rt.new_null()
		max_checked_feeds: rt.new_int(10)
		all_discovered_feeds: rt.new_array()
		image_handler: ''
		multifeed_url: rt.new_array()
		multifeed_objects: rt.new_array()
		config_settings: rt.new_null()
		item_limit: rt.new_int(0)
		check_modified: false
		strip_attributes: rt.new_array()
		add_attributes: rt.new_array()
		strip_htmltags: rt.new_array()
		rename_attributes: rt.new_array()
		enable_exceptions: rt.new_bool(false)
		http_client: rt.new_null()
		http_client_injected: false
	}
	obj.construct()
	return obj
}

fn create_simplepie_cache_callablenamefilter() &Class_SimplePie_Cache_CallableNameFilter {
	mut obj := &Class_SimplePie_Cache_CallableNameFilter{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_simplepie_sanitize() &Class_SimplePie_Sanitize {
	mut obj := &Class_SimplePie_Sanitize{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_simplepie_registry() &Class_SimplePie_Registry {
	mut obj := &Class_SimplePie_Registry{
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

fn create_simplepie_exception() &Class_SimplePie_Exception {
	mut obj := &Class_SimplePie_Exception{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_simplepie_cache_psr16() &Class_SimplePie_Cache_Psr16 {
	mut obj := &Class_SimplePie_Cache_Psr16{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_SimplePie_SimplePie) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'__toString' {
			return rt.new_string(this.magic_tostring())
		}
		'__destruct' {
			this.magic_destruct()
			return rt.new_null()
		}
		'force_feed' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			this.force_feed(dispatch_arg_0)
			return rt.new_null()
		}
		'set_feed_url' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_feed_url(dispatch_arg_0)
			return rt.new_null()
		}
		'set_file' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_SimplePie_File](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_bool(this.set_file(mut dispatch_arg_0))
		}
		'set_raw_data' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			this.set_raw_data(dispatch_arg_0)
			return rt.new_null()
		}
		'set_http_client' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Psr_Http_Client_ClientInterface](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Psr_Http_Message_RequestFactoryInterface](if args.len > 1 { args[1] } else { rt.new_null() })
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Psr_Http_Message_UriFactoryInterface](if args.len > 2 { args[2] } else { rt.new_null() })
			this.set_http_client(mut dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2)
			return rt.new_null()
		}
		'set_timeout' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			this.set_timeout(dispatch_arg_0)
			return rt.new_null()
		}
		'set_curl_options' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_SimplePie_array](if args.len > 0 { args[0] } else { rt.new_null() })
			this.set_curl_options(mut dispatch_arg_0)
			return rt.new_null()
		}
		'force_fsockopen' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			this.force_fsockopen(dispatch_arg_0)
			return rt.new_null()
		}
		'enable_cache' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			this.enable_cache(dispatch_arg_0)
			return rt.new_null()
		}
		'set_cache' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Psr_SimpleCache_CacheInterface](if args.len > 0 { args[0] } else { rt.new_null() })
			this.set_cache(mut dispatch_arg_0)
			return rt.new_null()
		}
		'force_cache_fallback' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			this.force_cache_fallback(dispatch_arg_0)
			return rt.new_null()
		}
		'set_cache_duration' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			this.set_cache_duration(dispatch_arg_0)
			return rt.new_null()
		}
		'set_autodiscovery_cache_duration' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			this.set_autodiscovery_cache_duration(dispatch_arg_0)
			return rt.new_null()
		}
		'set_cache_location' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			this.set_cache_location(dispatch_arg_0)
			return rt.new_null()
		}
		'get_cache_filename' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_cache_filename(dispatch_arg_0)
		}
		'enable_order_by_date' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			this.enable_order_by_date(dispatch_arg_0)
			return rt.new_null()
		}
		'set_input_encoding' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			this.set_input_encoding(dispatch_arg_0)
			return rt.new_null()
		}
		'set_autodiscovery_level' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			this.set_autodiscovery_level(dispatch_arg_0)
			return rt.new_null()
		}
		'get_registry' {
			return this.get_registry()
		}
		'set_cache_class' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.set_cache_class(dispatch_arg_0)
		}
		'set_locator_class' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.set_locator_class(dispatch_arg_0)
		}
		'set_parser_class' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.set_parser_class(dispatch_arg_0)
		}
		'set_file_class' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.set_file_class(dispatch_arg_0)
		}
		'set_sanitize_class' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.set_sanitize_class(dispatch_arg_0)
		}
		'set_item_class' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.set_item_class(dispatch_arg_0)
		}
		'set_author_class' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.set_author_class(dispatch_arg_0)
		}
		'set_category_class' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.set_category_class(dispatch_arg_0)
		}
		'set_enclosure_class' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.set_enclosure_class(dispatch_arg_0)
		}
		'set_caption_class' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.set_caption_class(dispatch_arg_0)
		}
		'set_copyright_class' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.set_copyright_class(dispatch_arg_0)
		}
		'set_credit_class' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.set_credit_class(dispatch_arg_0)
		}
		'set_rating_class' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.set_rating_class(dispatch_arg_0)
		}
		'set_restriction_class' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.set_restriction_class(dispatch_arg_0)
		}
		'set_content_type_sniffer_class' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.set_content_type_sniffer_class(dispatch_arg_0)
		}
		'set_source_class' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.set_source_class(dispatch_arg_0)
		}
		'set_useragent' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_SimplePie_?string](if args.len > 0 { args[0] } else { rt.new_null() })
			this.set_useragent(mut dispatch_arg_0)
			return rt.new_null()
		}
		'set_cache_namefilter' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_SimplePie_Cache_NameFilter](if args.len > 0 { args[0] } else { rt.new_null() })
			this.set_cache_namefilter(mut dispatch_arg_0)
			return rt.new_null()
		}
		'set_cache_name_function' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_SimplePie_?string](if args.len > 0 { args[0] } else { rt.new_null() })
			this.set_cache_name_function(mut dispatch_arg_0)
			return rt.new_null()
		}
		'set_stupidly_fast' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			this.set_stupidly_fast(dispatch_arg_0)
			return rt.new_null()
		}
		'set_max_checked_feeds' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			this.set_max_checked_feeds(dispatch_arg_0)
			return rt.new_null()
		}
		'remove_div' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			this.remove_div(dispatch_arg_0)
			return rt.new_null()
		}
		'strip_htmltags' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_SimplePie_?bool](if args.len > 1 { args[1] } else { rt.new_null() })
			this.strip_htmltags(dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'encode_instead_of_strip' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			this.encode_instead_of_strip(dispatch_arg_0)
			return rt.new_null()
		}
		'rename_attributes' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			this.rename_attributes(dispatch_arg_0)
			return rt.new_null()
		}
		'strip_attributes' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			this.strip_attributes(dispatch_arg_0)
			return rt.new_null()
		}
		'add_attributes' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			this.add_attributes(dispatch_arg_0)
			return rt.new_null()
		}
		'set_output_encoding' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			this.set_output_encoding(dispatch_arg_0)
			return rt.new_null()
		}
		'strip_comments' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			this.strip_comments(dispatch_arg_0)
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
		'set_image_handler' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			this.set_image_handler(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'set_item_limit' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			this.set_item_limit(dispatch_arg_0)
			return rt.new_null()
		}
		'enable_exceptions' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			this.enable_exceptions(dispatch_arg_0)
			return rt.new_null()
		}
		'init' {
			return rt.new_bool(this.init())
		}
		'fetch_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.fetch_data(dispatch_arg_0)
		}
		'error' {
			return this.error()
		}
		'status_code' {
			return this.status_code()
		}
		'get_raw_data' {
			return this.get_raw_data()
		}
		'get_encoding' {
			return this.get_encoding()
		}
		'handle_content_type' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			this.handle_content_type(dispatch_arg_0)
			return rt.new_null()
		}
		'get_type' {
			return this.get_type()
		}
		'subscribe_url' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			return this.subscribe_url(dispatch_arg_0)
		}
		'get_feed_tags' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return this.get_feed_tags(dispatch_arg_0, dispatch_arg_1)
		}
		'get_channel_tags' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return this.get_channel_tags(dispatch_arg_0, dispatch_arg_1)
		}
		'get_image_tags' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return this.get_image_tags(dispatch_arg_0, dispatch_arg_1)
		}
		'get_base' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_SimplePie_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.get_base(mut dispatch_arg_0)
		}
		'sanitize' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			return this.sanitize(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'get_title' {
			return this.get_title()
		}
		'get_category' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			return this.get_category(dispatch_arg_0)
		}
		'get_categories' {
			return this.get_categories()
		}
		'get_author' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			return this.get_author(dispatch_arg_0)
		}
		'get_authors' {
			return this.get_authors()
		}
		'get_contributor' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			return this.get_contributor(dispatch_arg_0)
		}
		'get_contributors' {
			return this.get_contributors()
		}
		'get_link' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return this.get_link(dispatch_arg_0, dispatch_arg_1)
		}
		'get_permalink' {
			return this.get_permalink()
		}
		'get_links' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_links(dispatch_arg_0)
		}
		'get_all_discovered_feeds' {
			return this.get_all_discovered_feeds()
		}
		'get_description' {
			return this.get_description()
		}
		'get_copyright' {
			return this.get_copyright()
		}
		'get_language' {
			return this.get_language()
		}
		'get_latitude' {
			return this.get_latitude()
		}
		'get_longitude' {
			return this.get_longitude()
		}
		'get_image_title' {
			return this.get_image_title()
		}
		'get_image_url' {
			return this.get_image_url()
		}
		'get_image_link' {
			return this.get_image_link()
		}
		'get_image_width' {
			return this.get_image_width()
		}
		'get_image_height' {
			return this.get_image_height()
		}
		'get_item_quantity' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			return this.get_item_quantity(dispatch_arg_0)
		}
		'get_item' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			return this.get_item(dispatch_arg_0)
		}
		'get_items' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			return this.get_items(dispatch_arg_0, dispatch_arg_1)
		}
		'set_favicon_handler' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return rt.new_bool(this.set_favicon_handler(dispatch_arg_0, dispatch_arg_1))
		}
		'get_favicon' {
			return this.get_favicon()
		}
		'__call' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_SimplePie_array](if args.len > 1 { args[1] } else { rt.new_null() })
			return this.magic_call(dispatch_arg_0, mut dispatch_arg_1)
		}
		'make_item' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_SimplePie_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.make_item(mut dispatch_arg_0)
		}
		'sort_items' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_SimplePie_Item](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_SimplePie_Item](if args.len > 1 { args[1] } else { rt.new_null() })
			return rt.new_int(Class_SimplePie_SimplePie.sort_items(mut dispatch_arg_0, mut dispatch_arg_1))
		}
		'merge_items' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_SimplePie_array](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_i64()
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).to_i64()
			return Class_SimplePie_SimplePie.merge_items(mut dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
		}
		'store_links' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_SimplePie_HTTP_Response](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_SimplePie_?string](if args.len > 1 { args[1] } else { rt.new_null() })
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_SimplePie_?string](if args.len > 2 { args[2] } else { rt.new_null() })
			return this.store_links(mut dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2)
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

fn (this &Class_SimplePie_SimplePie) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'data' { return this.data }
		'error' { return this.error }
		'status_code' { return this.status_code }
		'sanitize' { return this.sanitize }
		'useragent' { return this.useragent }
		'feed_url' { return this.feed_url }
		'permanent_url' { return this.permanent_url }
		'file' { return this.file }
		'raw_data' { return this.raw_data }
		'timeout' { return this.timeout }
		'curl_options' { return this.curl_options }
		'force_fsockopen' { return this.force_fsockopen }
		'force_feed' { return this.force_feed }
		'enable_cache' { return this.enable_cache }
		'cache' { return this.cache }
		'cache_namefilter' { return this.cache_namefilter }
		'force_cache_fallback' { return this.force_cache_fallback }
		'cache_duration' { return this.cache_duration }
		'autodiscovery_cache_duration' { return this.autodiscovery_cache_duration }
		'cache_location' { return this.cache_location }
		'cache_name_function' { return this.cache_name_function }
		'order_by_date' { return this.order_by_date }
		'input_encoding' { return this.input_encoding }
		'autodiscovery' { return this.autodiscovery }
		'registry' { return this.registry }
		'max_checked_feeds' { return this.max_checked_feeds }
		'all_discovered_feeds' { return this.all_discovered_feeds }
		'image_handler' { return rt.new_string(this.image_handler) }
		'multifeed_url' { return this.multifeed_url }
		'multifeed_objects' { return this.multifeed_objects }
		'config_settings' { return this.config_settings }
		'item_limit' { return this.item_limit }
		'check_modified' { return rt.new_bool(this.check_modified) }
		'strip_attributes' { return this.strip_attributes }
		'add_attributes' { return this.add_attributes }
		'strip_htmltags' { return this.strip_htmltags }
		'rename_attributes' { return this.rename_attributes }
		'enable_exceptions' { return this.enable_exceptions }
		'http_client' { return this.http_client }
		'http_client_injected' { return rt.new_bool(this.http_client_injected) }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_SimplePie_SimplePie) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'data' { this.data = val; return true }
		'error' { this.error = val; return true }
		'status_code' { this.status_code = val; return true }
		'sanitize' { this.sanitize = val; return true }
		'useragent' { this.useragent = val; return true }
		'feed_url' { this.feed_url = val; return true }
		'permanent_url' { this.permanent_url = val; return true }
		'file' { this.file = val; return true }
		'raw_data' { this.raw_data = val; return true }
		'timeout' { this.timeout = val; return true }
		'curl_options' { this.curl_options = val; return true }
		'force_fsockopen' { this.force_fsockopen = val; return true }
		'force_feed' { this.force_feed = val; return true }
		'enable_cache' { this.enable_cache = val; return true }
		'cache' { this.cache = val; return true }
		'cache_namefilter' { this.cache_namefilter = val; return true }
		'force_cache_fallback' { this.force_cache_fallback = val; return true }
		'cache_duration' { this.cache_duration = val; return true }
		'autodiscovery_cache_duration' { this.autodiscovery_cache_duration = val; return true }
		'cache_location' { this.cache_location = val; return true }
		'cache_name_function' { this.cache_name_function = val; return true }
		'order_by_date' { this.order_by_date = val; return true }
		'input_encoding' { this.input_encoding = val; return true }
		'autodiscovery' { this.autodiscovery = val; return true }
		'registry' { this.registry = val; return true }
		'max_checked_feeds' { this.max_checked_feeds = val; return true }
		'all_discovered_feeds' { this.all_discovered_feeds = val; return true }
		'image_handler' { this.image_handler = (val).str(); return true }
		'multifeed_url' { this.multifeed_url = val; return true }
		'multifeed_objects' { this.multifeed_objects = val; return true }
		'config_settings' { this.config_settings = val; return true }
		'item_limit' { this.item_limit = val; return true }
		'check_modified' { this.check_modified = (val).to_bool(); return true }
		'strip_attributes' { this.strip_attributes = val; return true }
		'add_attributes' { this.add_attributes = val; return true }
		'strip_htmltags' { this.strip_htmltags = val; return true }
		'rename_attributes' { this.rename_attributes = val; return true }
		'enable_exceptions' { this.enable_exceptions = val; return true }
		'http_client' { this.http_client = val; return true }
		'http_client_injected' { this.http_client_injected = (val).to_bool(); return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
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


fn (mut this Class_SimplePie_Sanitize) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_SimplePie_Sanitize) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_SimplePie_Sanitize) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_SimplePie_Registry) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_SimplePie_Registry) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_SimplePie_Registry) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_SimplePie_Exception) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_SimplePie_Exception) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_SimplePie_Exception) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_SimplePie_Cache_Psr16) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_SimplePie_Cache_Psr16) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_SimplePie_Cache_Psr16) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_includes_simplepie_src_simplepie_php() {
	// unsupported statement: Stmt_Declare
}
