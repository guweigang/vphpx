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

fn (mut this Class_SimplePie_SimplePie) construct() {
	if rt.is_true(rt.call_function('version_compare', [rt.get_constant('PHP_VERSION'), rt.new_string('7.2'), rt.new_string('<')])) {
		fn () { print((rt.new_string('Please upgrade to PHP 7.2 or newer.')).str()); exit(0) }()
	}
	this.set_useragent(rt.new_null())
	this.set_cache_namefilter(mut rt.cast_object_ptr[Class_SimplePie_Cache_NameFilter](create_simplepie_cache_callablenamefilter(this.cache_name_function)))
	this.sanitize = create_simplepie_sanitize()
	this.registry = create_simplepie_registry()
	if rt.is_true(rt.greater(rt.call_function('func_num_args', []rt.PhpVal{}), rt.new_int(0))) {
		rt.call_function('trigger_error', [rt.new_string('Passing parameters to the constructor is no longer supported. Please use set_feed_url(), set_cache_location(), and set_cache_duration() directly.'), rt.get_constant('E_USER_DEPRECATED')])
		mut var_args := rt.call_function('func_get_args', []rt.PhpVal{})
		match var_args.clone().array_count() {
			3 {
				this.set_cache_duration((var_args.array_get(rt.new_int(2))).to_i64())
			}
			2 {
				this.set_cache_location((var_args.array_get(rt.new_int(1))).str())
			}
			1 {
				this.set_feed_url(var_args.array_get(rt.new_int(0)))
				this.init()
			}
		}
	}
}

fn (mut this Class_SimplePie_SimplePie) magic_tostring() string {
	return md5.hexhash(rt.call_function('serialize', [this.data]).to_string())
}

fn (mut this Class_SimplePie_SimplePie) magic_destruct() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('gc_enabled', []rt.PhpVal{}))))) {
		if !(!rt.is_true(this.data.array_get(rt.new_string('items')))) {
			mut iter_1 := this.data.array_get(rt.new_string('items')).iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_item := item_1.val
				rt.call_method(var_item, '__destruct', []rt.PhpVal{})
			}
			var_item = rt.new_null()
			this.data.array_unset(rt.new_string('items'))
		}
		if !(!rt.is_true(this.data.array_get(rt.new_string('ordered_items')))) {
			mut iter_2 := this.data.array_get(rt.new_string('ordered_items')).iterator()
			for {
				item_2 := iter_2.next() or { break }
				mut var_item := item_2.val
				rt.call_method(var_item, '__destruct', []rt.PhpVal{})
			}
			var_item = rt.new_null()
			this.data.array_unset(rt.new_string('ordered_items'))
		}
	}
}

fn (mut this Class_SimplePie_SimplePie) force_feed(enable bool) {
	this.force_feed = rt.new_bool(enable)
}

fn (mut this Class_SimplePie_SimplePie) set_feed_url(var_url rt.PhpVal) {
	mut var_url_mutated := var_url
	this.multifeed_url = rt.new_array()
	if rt.is_true(rt.new_bool(var_url_mutated.clone().is_array())) {
		rt.call_function('trigger_error', [rt.new_string('Fetching multiple feeds with single SimplePie instance is deprecated since SimplePie 1.9.0, create one SimplePie instance per feed and use SimplePie::merge_items to get a single list of items.'), rt.get_constant('E_USER_DEPRECATED')])
		mut iter_3 := var_url_mutated.iterator()
		for {
			item_3 := iter_3.next() or { break }
			mut var_value := item_3.val
			this.multifeed_url.array_push(rt.call_method(this.registry, 'call', [Class_SimplePie_Misc.class(), rt.new_string('fix_protocol'), rt.create_array([rt.ArrayItem{ key: none, val: var_value }, rt.ArrayItem{ key: none, val: 1 }])]))
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
	this.file = var_file_mutated
	return true
}

fn (mut this Class_SimplePie_SimplePie) set_raw_data(data string) {
	this.raw_data = rt.new_string(data)
}

fn (mut this Class_SimplePie_SimplePie) set_http_client(mut var_http_client Class_Psr_Http_Client_ClientInterface, mut var_request_factory Class_Psr_Http_Message_RequestFactoryInterface, mut var_uri_factory Class_Psr_Http_Message_UriFactoryInterface) {
	mut var_http_client_mutated := var_http_client
	this.http_client = create_simplepie_http_psr18client(var_http_client_mutated, var_request_factory, var_uri_factory)
}

fn (mut this Class_SimplePie_SimplePie) set_timeout(timeout i64) {
	if this.http_client_injected {
		rt.throw_exception(rt.new_object('SimplePie_Exception', []string{}, create_simplepie_exception(rt.call_function('sprintf', [rt.new_string('Using "%s()" has no effect, because you already provided a HTTP client with "%s::set_http_client()". Configure timeout in your HTTP client instead.'), rt.new_string(@METHOD), Class_SimplePie_SimplePie_SimplePie.class()]))))
	}
	this.timeout = timeout
	if this.http_client.is_object() && rt.is_true(rt.new_bool(rt.instance_of(this.http_client, 'SimplePie_HTTP_FileClient'))) {
		this.http_client = rt.new_null()
	} else if rt.is_true(rt.new_bool(this.http_client.is_object())) {
		rt.call_function('trigger_error', [rt.call_function('sprintf', [rt.new_string('Using "%s()" has no effect, because you already provided a HTTP client with "%s::set_http_client()". Configure the timeout in your HTTP client instead.'), rt.new_string(@METHOD), rt.call_function('get_class', [rt.new_object('SimplePie_SimplePie', []string{}, &this)])]), rt.get_constant('E_USER_NOTICE')])
	}
}

fn (mut this Class_SimplePie_SimplePie) set_curl_options(mut var_curl_options Class_SimplePie_array) {
	if this.http_client_injected {
		rt.throw_exception(rt.new_object('SimplePie_Exception', []string{}, create_simplepie_exception(rt.call_function('sprintf', [rt.new_string('Using "%s()" has no effect, because you already provided a HTTP client with "%s::set_http_client()". Configure custom curl options in your HTTP client instead.'), rt.new_string(@METHOD), Class_SimplePie_SimplePie_SimplePie.class()]))))
	}
	this.curl_options = var_curl_options
	if this.http_client.is_object() && rt.is_true(rt.new_bool(rt.instance_of(this.http_client, 'SimplePie_HTTP_FileClient'))) {
		this.http_client = rt.new_null()
	} else if rt.is_true(rt.new_bool(this.http_client.is_object())) {
		rt.call_function('trigger_error', [rt.call_function('sprintf', [rt.new_string('Using "%s()" has no effect, because you already provided a HTTP client with "%s::set_http_client()". Configure the curl options in your HTTP client instead.'), rt.new_string(@METHOD), rt.call_function('get_class', [rt.new_object('SimplePie_SimplePie', []string{}, &this)])]), rt.get_constant('E_USER_NOTICE')])
	}
}

fn (mut this Class_SimplePie_SimplePie) force_fsockopen(enable bool) {
	if this.http_client_injected {
		rt.throw_exception(rt.new_object('SimplePie_Exception', []string{}, create_simplepie_exception(rt.call_function('sprintf', [rt.new_string('Using "%s()" has no effect, because you already provided a HTTP client with "%s::set_http_client()". Configure fsockopen in your HTTP client instead.'), rt.new_string(@METHOD), Class_SimplePie_SimplePie_SimplePie.class()]))))
	}
	this.force_fsockopen = rt.new_bool(enable)
	if this.http_client.is_object() && rt.is_true(rt.new_bool(rt.instance_of(this.http_client, 'SimplePie_HTTP_FileClient'))) {
		this.http_client = rt.new_null()
	} else if rt.is_true(rt.new_bool(this.http_client.is_object())) {
		rt.call_function('trigger_error', [rt.call_function('sprintf', [rt.new_string('Using "%s()" has no effect, because you already provided a HTTP client with "%s::set_http_client()". Configure fsockopen in your HTTP client instead.'), rt.new_string(@METHOD), rt.call_function('get_class', [rt.new_object('SimplePie_SimplePie', []string{}, &this)])]), rt.get_constant('E_USER_NOTICE')])
	}
}

fn (mut this Class_SimplePie_SimplePie) enable_cache(enable bool) {
	this.enable_cache = rt.new_bool(enable)
}

fn (mut this Class_SimplePie_SimplePie) set_cache(mut var_cache Class_Psr_SimpleCache_CacheInterface) {
	mut var_cache_mutated := var_cache
	this.cache = create_simplepie_cache_psr16(var_cache_mutated)
}

fn (mut this Class_SimplePie_SimplePie) force_cache_fallback(enable bool) {
	this.force_cache_fallback = rt.new_bool(enable)
}

fn (mut this Class_SimplePie_SimplePie) set_cache_duration(seconds i64) {
	this.cache_duration = rt.new_int(seconds)
}

fn (mut this Class_SimplePie_SimplePie) set_autodiscovery_cache_duration(seconds i64) {
	this.autodiscovery_cache_duration = rt.new_int(seconds)
}

fn (mut this Class_SimplePie_SimplePie) set_cache_location(location string) {
	this.cache_location = rt.new_string(location)
}

fn (mut this Class_SimplePie_SimplePie) get_cache_filename(url string) rt.PhpVal {
	mut url_mutated := url
	url_mutated = url_mutated + if rt.is_true(this.force_feed) { '#force_feed' } else { '' }
	mut var_options := rt.new_array()
	if rt.is_true(rt.new_bool(!rt.is_true(rt.equal(this.timeout, rt.new_int(10))))) {
		var_options.array_set(rt.get_constant('CURLOPT_TIMEOUT'), this.timeout)
	}
	mut iife_temp_0 := Class_SimplePie_Misc{}
	mut iife_result_0 := iife_temp_0.get_default_useragent()
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(this.useragent, iife_result_0)))) {
		var_options.array_set(rt.get_constant('CURLOPT_USERAGENT'), this.useragent)
	}
	if !(!rt.is_true(this.curl_options)) {
		mut iter_4 := this.curl_options.iterator()
		for {
			item_4 := iter_4.next() or { break }
			mut var_v := item_4.val
			mut var_k := item_4.key
			var_options.array_set(var_k, var_v.clone())
		}
	}
	if !(!rt.is_true(var_options)) {
		rt.call_function('ksort', [var_options.clone()])
		url_mutated = url_mutated + '#' + (rt.call_function('urlencode', [rt.call_function('var_export', [var_options.clone(), rt.new_bool(true)])])).str()
	}
	return rt.call_method(this.cache_namefilter, 'filter', [rt.new_string(url_mutated).clone()])
}

fn (mut this Class_SimplePie_SimplePie) enable_order_by_date(enable bool) {
	this.order_by_date = rt.new_bool(enable)
}

fn (mut this Class_SimplePie_SimplePie) set_input_encoding(encoding bool) {
	if var_encoding {
		this.input_encoding = encoding.str()
	} else {
		this.input_encoding = rt.new_bool(false)
	}
}

fn (mut this Class_SimplePie_SimplePie) set_autodiscovery_level(level i64) {
	this.autodiscovery = rt.new_int(level)
}

fn (mut this Class_SimplePie_SimplePie) get_registry() rt.PhpVal {
	return this.registry
}

fn (mut this Class_SimplePie_SimplePie) set_cache_class(class string) rt.PhpVal {
	mut class_mutated := class
	rt.call_function('trigger_error', [rt.call_function('sprintf', [rt.new_string('"%s()" is deprecated since SimplePie 1.3, please use "SimplePie\\SimplePie::set_cache()" instead.'), rt.new_string(@METHOD)]), rt.get_constant('E_USER_DEPRECATED')])
	return rt.call_method(this.registry, 'register', [Class_SimplePie_Cache.class(), rt.new_string(class_mutated).clone(), rt.new_bool(true)])
}

fn (mut this Class_SimplePie_SimplePie) set_locator_class(class string) rt.PhpVal {
	mut class_mutated := class
	rt.call_function('trigger_error', [rt.call_function('sprintf', [rt.new_string('"%s()" is deprecated since SimplePie 1.3, please use "SimplePie\\SimplePie::get_registry()" instead.'), rt.new_string(@METHOD)]), rt.get_constant('E_USER_DEPRECATED')])
	return rt.call_method(this.registry, 'register', [Class_SimplePie_Locator.class(), rt.new_string(class_mutated).clone(), rt.new_bool(true)])
}

fn (mut this Class_SimplePie_SimplePie) set_parser_class(class string) rt.PhpVal {
	mut class_mutated := class
	rt.call_function('trigger_error', [rt.call_function('sprintf', [rt.new_string('"%s()" is deprecated since SimplePie 1.3, please use "SimplePie\\SimplePie::get_registry()" instead.'), rt.new_string(@METHOD)]), rt.get_constant('E_USER_DEPRECATED')])
	return rt.call_method(this.registry, 'register', [Class_SimplePie_Parser.class(), rt.new_string(class_mutated).clone(), rt.new_bool(true)])
}

fn (mut this Class_SimplePie_SimplePie) set_file_class(class string) rt.PhpVal {
	mut class_mutated := class
	rt.call_function('trigger_error', [rt.call_function('sprintf', [rt.new_string('"%s()" is deprecated since SimplePie 1.3, please use "SimplePie\\SimplePie::get_registry()" instead.'), rt.new_string(@METHOD)]), rt.get_constant('E_USER_DEPRECATED')])
	return rt.call_method(this.registry, 'register', [Class_SimplePie_File.class(), rt.new_string(class_mutated).clone(), rt.new_bool(true)])
}

fn (mut this Class_SimplePie_SimplePie) set_sanitize_class(class string) rt.PhpVal {
	mut class_mutated := class
	rt.call_function('trigger_error', [rt.call_function('sprintf', [rt.new_string('"%s()" is deprecated since SimplePie 1.3, please use "SimplePie\\SimplePie::get_registry()" instead.'), rt.new_string(@METHOD)]), rt.get_constant('E_USER_DEPRECATED')])
	return rt.call_method(this.registry, 'register', [Class_SimplePie_Sanitize.class(), rt.new_string(class_mutated).clone(), rt.new_bool(true)])
}

fn (mut this Class_SimplePie_SimplePie) set_item_class(class string) rt.PhpVal {
	mut class_mutated := class
	rt.call_function('trigger_error', [rt.call_function('sprintf', [rt.new_string('"%s()" is deprecated since SimplePie 1.3, please use "SimplePie\\SimplePie::get_registry()" instead.'), rt.new_string(@METHOD)]), rt.get_constant('E_USER_DEPRECATED')])
	return rt.call_method(this.registry, 'register', [Class_SimplePie_Item.class(), rt.new_string(class_mutated).clone(), rt.new_bool(true)])
}

fn (mut this Class_SimplePie_SimplePie) set_author_class(class string) rt.PhpVal {
	mut class_mutated := class
	rt.call_function('trigger_error', [rt.call_function('sprintf', [rt.new_string('"%s()" is deprecated since SimplePie 1.3, please use "SimplePie\\SimplePie::get_registry()" instead.'), rt.new_string(@METHOD)]), rt.get_constant('E_USER_DEPRECATED')])
	return rt.call_method(this.registry, 'register', [Class_SimplePie_Author.class(), rt.new_string(class_mutated).clone(), rt.new_bool(true)])
}

fn (mut this Class_SimplePie_SimplePie) set_category_class(class string) rt.PhpVal {
	mut class_mutated := class
	rt.call_function('trigger_error', [rt.call_function('sprintf', [rt.new_string('"%s()" is deprecated since SimplePie 1.3, please use "SimplePie\\SimplePie::get_registry()" instead.'), rt.new_string(@METHOD)]), rt.get_constant('E_USER_DEPRECATED')])
	return rt.call_method(this.registry, 'register', [Class_SimplePie_Category.class(), rt.new_string(class_mutated).clone(), rt.new_bool(true)])
}

fn (mut this Class_SimplePie_SimplePie) set_enclosure_class(class string) rt.PhpVal {
	mut class_mutated := class
	rt.call_function('trigger_error', [rt.call_function('sprintf', [rt.new_string('"%s()" is deprecated since SimplePie 1.3, please use "SimplePie\\SimplePie::get_registry()" instead.'), rt.new_string(@METHOD)]), rt.get_constant('E_USER_DEPRECATED')])
	return rt.call_method(this.registry, 'register', [Class_SimplePie_Enclosure.class(), rt.new_string(class_mutated).clone(), rt.new_bool(true)])
}

fn (mut this Class_SimplePie_SimplePie) set_caption_class(class string) rt.PhpVal {
	mut class_mutated := class
	rt.call_function('trigger_error', [rt.call_function('sprintf', [rt.new_string('"%s()" is deprecated since SimplePie 1.3, please use "SimplePie\\SimplePie::get_registry()" instead.'), rt.new_string(@METHOD)]), rt.get_constant('E_USER_DEPRECATED')])
	return rt.call_method(this.registry, 'register', [Class_SimplePie_Caption.class(), rt.new_string(class_mutated).clone(), rt.new_bool(true)])
}

fn (mut this Class_SimplePie_SimplePie) set_copyright_class(class string) rt.PhpVal {
	mut class_mutated := class
	rt.call_function('trigger_error', [rt.call_function('sprintf', [rt.new_string('"%s()" is deprecated since SimplePie 1.3, please use "SimplePie\\SimplePie::get_registry()" instead.'), rt.new_string(@METHOD)]), rt.get_constant('E_USER_DEPRECATED')])
	return rt.call_method(this.registry, 'register', [Class_SimplePie_Copyright.class(), rt.new_string(class_mutated).clone(), rt.new_bool(true)])
}

fn (mut this Class_SimplePie_SimplePie) set_credit_class(class string) rt.PhpVal {
	mut class_mutated := class
	rt.call_function('trigger_error', [rt.call_function('sprintf', [rt.new_string('"%s()" is deprecated since SimplePie 1.3, please use "SimplePie\\SimplePie::get_registry()" instead.'), rt.new_string(@METHOD)]), rt.get_constant('E_USER_DEPRECATED')])
	return rt.call_method(this.registry, 'register', [Class_SimplePie_Credit.class(), rt.new_string(class_mutated).clone(), rt.new_bool(true)])
}

fn (mut this Class_SimplePie_SimplePie) set_rating_class(class string) rt.PhpVal {
	mut class_mutated := class
	rt.call_function('trigger_error', [rt.call_function('sprintf', [rt.new_string('"%s()" is deprecated since SimplePie 1.3, please use "SimplePie\\SimplePie::get_registry()" instead.'), rt.new_string(@METHOD)]), rt.get_constant('E_USER_DEPRECATED')])
	return rt.call_method(this.registry, 'register', [Class_SimplePie_Rating.class(), rt.new_string(class_mutated).clone(), rt.new_bool(true)])
}

fn (mut this Class_SimplePie_SimplePie) set_restriction_class(class string) rt.PhpVal {
	mut class_mutated := class
	rt.call_function('trigger_error', [rt.call_function('sprintf', [rt.new_string('"%s()" is deprecated since SimplePie 1.3, please use "SimplePie\\SimplePie::get_registry()" instead.'), rt.new_string(@METHOD)]), rt.get_constant('E_USER_DEPRECATED')])
	return rt.call_method(this.registry, 'register', [Class_SimplePie_Restriction.class(), rt.new_string(class_mutated).clone(), rt.new_bool(true)])
}

fn (mut this Class_SimplePie_SimplePie) set_content_type_sniffer_class(class string) rt.PhpVal {
	mut class_mutated := class
	rt.call_function('trigger_error', [rt.call_function('sprintf', [rt.new_string('"%s()" is deprecated since SimplePie 1.3, please use "SimplePie\\SimplePie::get_registry()" instead.'), rt.new_string(@METHOD)]), rt.get_constant('E_USER_DEPRECATED')])
	return rt.call_method(this.registry, 'register', [Class_SimplePie_Content_Type_Sniffer.class(), rt.new_string(class_mutated).clone(), rt.new_bool(true)])
}

fn (mut this Class_SimplePie_SimplePie) set_source_class(class string) rt.PhpVal {
	mut class_mutated := class
	rt.call_function('trigger_error', [rt.call_function('sprintf', [rt.new_string('"%s()" is deprecated since SimplePie 1.3, please use "SimplePie\\SimplePie::get_registry()" instead.'), rt.new_string(@METHOD)]), rt.get_constant('E_USER_DEPRECATED')])
	return rt.call_method(this.registry, 'register', [Class_SimplePie_Source.class(), rt.new_string(class_mutated).clone(), rt.new_bool(true)])
}

fn (mut this Class_SimplePie_SimplePie) set_useragent(mut var_ua Class_SimplePie_?string) {
	mut var_ua_mutated := var_ua
	if this.http_client_injected {
		rt.throw_exception(rt.new_object('SimplePie_Exception', []string{}, create_simplepie_exception(rt.call_function('sprintf', [rt.new_string('Using "%s()" has no effect, because you already provided a HTTP client with "%s::set_http_client()". Configure user agent string in your HTTP client instead.'), rt.new_string(@METHOD), Class_SimplePie_SimplePie_SimplePie.class()]))))
	}
	if rt.is_true(rt.identical(var_ua_mutated, rt.new_null())) {
	mut iife_temp_1 := Class_SimplePie_Misc{}
	mut iife_result_1 := iife_temp_1.get_default_useragent()
	var_ua_mutated = iife_result_1
	}
	this.useragent = (var_ua_mutated).str()
	if this.http_client.is_object() && rt.is_true(rt.new_bool(rt.instance_of(this.http_client, 'SimplePie_HTTP_FileClient'))) {
		this.http_client = rt.new_null()
	} else if rt.is_true(rt.new_bool(this.http_client.is_object())) {
		rt.call_function('trigger_error', [rt.call_function('sprintf', [rt.new_string('Using "%s()" has no effect, because you already provided a HTTP client with "%s::set_http_client()". Configure the useragent in your HTTP client instead.'), rt.new_string(@METHOD), rt.call_function('get_class', [rt.new_object('SimplePie_SimplePie', []string{}, &this)])]), rt.get_constant('E_USER_NOTICE')])
	}
}

fn (mut this Class_SimplePie_SimplePie) set_cache_namefilter(mut var_filter Class_SimplePie_Cache_NameFilter) {
	this.cache_namefilter = var_filter
}

fn (mut this Class_SimplePie_SimplePie) set_cache_name_function(mut var_function Class_SimplePie_?string) {
	mut var_function_mutated := var_function
	if rt.is_true(rt.identical(var_function_mutated, rt.new_null())) {
	var_function_mutated = rt.new_string('md5')
	}
	this.cache_name_function = var_function_mutated
	this.set_cache_namefilter(mut rt.cast_object_ptr[Class_SimplePie_Cache_NameFilter](create_simplepie_cache_callablenamefilter(this.cache_name_function)))
}

fn (mut this Class_SimplePie_SimplePie) set_stupidly_fast(set bool) {
	if var_set {
		this.enable_order_by_date(false)
		this.remove_div(false)
		this.strip_comments(false)
		this.strip_htmltags((rt.new_array()).str(), rt.new_null())
		this.strip_attributes((rt.new_array()).str())
		this.add_attributes((rt.new_array()).str())
		this.set_image_handler(false, '')
		this.set_https_domains(mut rt.cast_object_ptr[Class_SimplePie_array](rt.new_array()))
	}
}

fn (mut this Class_SimplePie_SimplePie) set_max_checked_feeds(max i64) {
	this.max_checked_feeds = rt.new_int(max)
}

fn (mut this Class_SimplePie_SimplePie) remove_div(enable bool) {
	rt.call_method(this.sanitize, 'remove_div', [rt.new_bool(enable)])
}

fn (mut this Class_SimplePie_SimplePie) strip_htmltags(tags string, mut var_encode Class_SimplePie_?bool) {
	mut tags_mutated := tags
	if rt.is_true(rt.identical(rt.new_string(tags_mutated), rt.new_string(''))) {
	tags_mutated = (this.strip_htmltags).str()
	}
	rt.call_method(this.sanitize, 'strip_htmltags', [rt.new_string(tags_mutated).clone()])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_encode, rt.new_null())))) {
		rt.call_method(this.sanitize, 'encode_instead_of_strip', [var_encode])
	}
}

fn (mut this Class_SimplePie_SimplePie) encode_instead_of_strip(enable bool) {
	rt.call_method(this.sanitize, 'encode_instead_of_strip', [rt.new_bool(enable)])
}

fn (mut this Class_SimplePie_SimplePie) rename_attributes(attribs string) {
	mut attribs_mutated := attribs
	if rt.is_true(rt.identical(rt.new_string(attribs_mutated), rt.new_string(''))) {
	attribs_mutated = (this.rename_attributes).str()
	}
	rt.call_method(this.sanitize, 'rename_attributes', [rt.new_string(attribs_mutated).clone()])
}

fn (mut this Class_SimplePie_SimplePie) strip_attributes(attribs string) {
	mut attribs_mutated := attribs
	if rt.is_true(rt.identical(rt.new_string(attribs_mutated), rt.new_string(''))) {
	attribs_mutated = (this.strip_attributes).str()
	}
	rt.call_method(this.sanitize, 'strip_attributes', [rt.new_string(attribs_mutated).clone()])
}

fn (mut this Class_SimplePie_SimplePie) add_attributes(attribs string) {
	mut attribs_mutated := attribs
	if rt.is_true(rt.identical(rt.new_string(attribs_mutated), rt.new_string(''))) {
	attribs_mutated = (this.add_attributes).str()
	}
	rt.call_method(this.sanitize, 'add_attributes', [rt.new_string(attribs_mutated).clone()])
}

fn (mut this Class_SimplePie_SimplePie) set_output_encoding(encoding string) {
	rt.call_method(this.sanitize, 'set_output_encoding', [rt.new_string(encoding)])
}

fn (mut this Class_SimplePie_SimplePie) strip_comments(strip bool) {
	rt.call_method(this.sanitize, 'strip_comments', [rt.new_bool(strip)])
}

fn (mut this Class_SimplePie_SimplePie) set_url_replacements(mut var_element_attribute Class_SimplePie_?array) {
	rt.call_method(this.sanitize, 'set_url_replacements', [var_element_attribute])
}

fn (mut this Class_SimplePie_SimplePie) set_https_domains(mut var_domains Class_SimplePie_array) {
	rt.call_method(this.sanitize, 'set_https_domains', [var_domains])
}

fn (mut this Class_SimplePie_SimplePie) set_image_handler(page bool, qs string) {
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(page), rt.new_bool(false))))) {
		rt.call_method(this.sanitize, 'set_image_handler', [rt.new_string(page.str() + '?' + qs + '=')])
	} else {
		this.image_handler = ''
	}
}

fn (mut this Class_SimplePie_SimplePie) set_item_limit(limit i64) {
	this.item_limit = rt.new_int(limit)
}

fn (mut this Class_SimplePie_SimplePie) enable_exceptions(enable bool) {
	this.enable_exceptions = rt.new_bool(enable)
}

fn (mut this Class_SimplePie_SimplePie) init() bool {
	mut var_values := rt.new_null()
	mut var_headers := rt.new_null()
	mut var_sniffed := rt.new_null()
	mut var_charset := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('extension_loaded', [rt.new_string('xml')]))))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('extension_loaded', [rt.new_string('pcre')]))))) {
		this.error = rt.new_string('XML or PCRE extensions not loaded!')
		return false
	} else if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('extension_loaded', [rt.new_string('xmlreader')]))))) {
		mut var_xml_is_sane := rt.new_null()
		if rt.is_true(rt.identical(var_xml_is_sane, rt.new_null())) {
			mut var_parser_check := rt.call_function('xml_parser_create', []rt.PhpVal{})
			rt.call_function('xml_parse_into_struct', [var_parser_check.clone(), rt.new_string('<foo>&amp;</foo>'), var_values.clone()])
			if rt.is_true(rt.less(rt.get_constant('PHP_VERSION_ID'), rt.new_int(80000))) {
				rt.call_function('xml_parser_free', [var_parser_check.clone()])
			}
		var_xml_is_sane = rt.new_bool(var_values.array_get(rt.new_int(0)).array_isset(rt.new_string('value')))
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(var_xml_is_sane)))) {
			return false
		}
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_method(this.registry, 'get_class', [Class_SimplePie_Sanitize.class()]), Class_SimplePie_Sanitize.class())))) {
		this.sanitize = rt.call_method(this.registry, 'create', [Class_SimplePie_Sanitize.class()])
	}
	if rt.is_true(rt.call_function('method_exists', [this.sanitize, rt.new_string('set_registry')])) {
		rt.call_method(this.sanitize, 'set_registry', [this.registry])
	}
	mut var_cache := rt.call_method(this.registry, 'get_class', [Class_SimplePie_Cache.class()])
	rt.call_function('assert', [rt.new_bool(!rt.is_true(rt.identical(var_cache, rt.new_null()))), rt.new_string('Cache must be defined')])
	rt.call_method(this.sanitize, 'pass_cache_data', [this.enable_cache, this.cache_location, this.cache_namefilter, var_cache.clone(), this.cache])
	mut var_http_client := this.get_http_client()
	if rt.is_true(rt.new_bool(rt.instance_of(var_http_client, 'SimplePie_HTTP_Psr18Client'))) {
		rt.call_method(this.sanitize, 'set_http_client', [rt.call_method(var_http_client, 'getHttpClient', []rt.PhpVal{}), rt.call_method(var_http_client, 'getRequestFactory', []rt.PhpVal{}), rt.call_method(var_http_client, 'getUriFactory', []rt.PhpVal{})])
	}
	if !(!rt.is_true(this.multifeed_url)) {
		mut var_i := rt.new_int(0)
		mut var_success := rt.new_int(0)
		this.multifeed_objects = rt.new_array()
		this.error = rt.new_array()
		mut iter_5 := this.multifeed_url.iterator()
		for {
			item_5 := iter_5.next() or { break }
			mut var_url := item_5.val
			this.multifeed_objects.array_set(var_i, rt.new_object('SimplePie_SimplePie', []string{}, &this).dup())
			rt.call_method(this.multifeed_objects.array_get(var_i), 'set_feed_url', [var_url.clone()])
			mut var_single_success := rt.call_method(this.multifeed_objects.array_get(var_i), 'init', []rt.PhpVal{})
			rt.new_null()
			if rt.is_true(rt.new_bool(!(rt.is_true(var_single_success)))) {
				this.error.array_set(var_i, rt.call_method(this.multifeed_objects.array_get(var_i), 'error', []rt.PhpVal{}))
			}
			rt.post_inc(var_i)
		}
		return (var_success).to_bool()
	} else if rt.is_true(rt.identical(this.feed_url, rt.new_null())) && rt.is_true(rt.identical(this.raw_data, rt.new_null())) {
		return false
	}
	this.error = rt.new_null()
	this.data = rt.new_array()
	this.check_modified = false
	this.multifeed_objects = rt.new_array()
	var_cache = rt.new_bool(false)
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(this.feed_url, rt.new_null())))) {
		mut var_parsed_feed_url := rt.call_method(this.registry, 'call', [Class_SimplePie_Misc.class(), rt.new_string('parse_url'), rt.create_array([rt.ArrayItem{ key: none, val: this.feed_url }])])
		if rt.is_true(this.enable_cache) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_parsed_feed_url.array_get(rt.new_string('scheme')), rt.new_string(''))))) {
		var_cache = this.get_cache((this.feed_url).str())
		}
		mut var_fetched := this.fetch_data(var_cache.clone())
		if rt.is_true(rt.identical(var_fetched, rt.new_bool(true))) {
			return true
		} else if rt.is_true(rt.identical(var_fetched, rt.new_bool(false))) {
			return false
		}
		mut list_tmp_1 := var_fetched
		var_headers = (list_tmp_1).array_get(0)
		var_sniffed = (list_tmp_1).array_get(1)
	}
	if !rt.is_true(this.raw_data) {
		this.error = rt.concat(rt.concat(rt.new_string('A feed could not be found at `'), this.feed_url), rt.new_string('`. Empty body.'))
		rt.call_method(this.registry, 'call', [Class_SimplePie_Misc.class(), rt.new_string('error'), rt.create_array([rt.ArrayItem{ key: none, val: this.error }, rt.ArrayItem{ key: none, val: rt.get_constant('E_USER_NOTICE') }, rt.ArrayItem{ key: none, val: @FILE }, rt.ArrayItem{ key: none, val: @LINE.int() }])])
		return false
	}
	mut var_encodings := rt.new_array()
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(this.input_encoding, rt.new_bool(false))))) {
		var_encodings.array_push(this.input_encoding.to_string().to_upper())
	}
	mut var_application_types := rt.create_array([rt.ArrayItem{ key: none, val: 'application/xml' }, rt.ArrayItem{ key: none, val: 'application/xml-dtd' }, rt.ArrayItem{ key: none, val: 'application/xml-external-parsed-entity' }])
	mut var_text_types := rt.create_array([rt.ArrayItem{ key: none, val: 'text/xml' }, rt.ArrayItem{ key: none, val: 'text/xml-external-parsed-entity' }])
	if !(var_sniffed).is_null() {
		if rt.is_true(rt.call_function('in_array', [var_sniffed.clone(), var_application_types.clone()])) || (rt.is_true(rt.identical(rt.call_function('substr', [var_sniffed.clone(), rt.new_int(0), rt.new_int(12)]), rt.new_string('application/'))) && rt.is_true(rt.identical(rt.call_function('substr', [var_sniffed.clone(), rt.new_int(-4)]), rt.new_string('+xml')))) {
			if var_headers.array_isset(rt.new_string('content-type')) && rt.is_true(rt.call_function('preg_match', [rt.new_string('/;\\x20?charset=([^;]*)/i'), var_headers.array_get(rt.new_string('content-type')), var_charset.clone()])) {
				var_encodings.array_push(var_charset.array_get(rt.new_int(1)).to_string().to_upper())
			}
			var_encodings = rt.call_function('array_merge', [var_encodings.clone(), rt.call_method(this.registry, 'call', [Class_SimplePie_Misc.class(), rt.new_string('xml_encoding'), rt.create_array([rt.ArrayItem{ key: none, val: this.raw_data }, rt.ArrayItem{ key: none, val: this.registry }])])])
			var_encodings.array_push('UTF-8')
		} else if rt.is_true(rt.call_function('in_array', [var_sniffed.clone(), var_text_types.clone()])) || (rt.is_true(rt.identical(rt.call_function('substr', [var_sniffed.clone(), rt.new_int(0), rt.new_int(5)]), rt.new_string('text/'))) && rt.is_true(rt.identical(rt.call_function('substr', [var_sniffed.clone(), rt.new_int(-4)]), rt.new_string('+xml')))) {
			if var_headers.array_isset(rt.new_string('content-type')) && rt.is_true(rt.call_function('preg_match', [rt.new_string('/;\\x20?charset=([^;]*)/i'), var_headers.array_get(rt.new_string('content-type')), var_charset.clone()])) {
				var_encodings.array_push(var_charset.array_get(rt.new_int(1)).to_string().to_upper())
			}
			var_encodings.array_push('US-ASCII')
		} else if rt.is_true(rt.identical(rt.call_function('substr', [var_sniffed.clone(), rt.new_int(0), rt.new_int(5)]), rt.new_string('text/'))) {
			var_encodings.array_push('UTF-8')
		}
	}
	var_encodings = rt.call_function('array_merge', [var_encodings.clone(), rt.call_method(this.registry, 'call', [Class_SimplePie_Misc.class(), rt.new_string('xml_encoding'), rt.create_array([rt.ArrayItem{ key: none, val: this.raw_data }, rt.ArrayItem{ key: none, val: this.registry }])])])
	var_encodings.array_push('UTF-8')
	var_encodings.array_push('ISO-8859-1')
	var_encodings = rt.call_function('array_unique', [var_encodings.clone()])
	mut iter_6 := var_encodings.iterator()
	for {
		item_6 := iter_6.next() or { break }
		mut var_encoding := item_6.val
		mut var_utf8_data := rt.call_method(this.registry, 'call', [Class_SimplePie_Misc.class(), rt.new_string('change_encoding'), rt.create_array([rt.ArrayItem{ key: none, val: this.raw_data }, rt.ArrayItem{ key: none, val: var_encoding }, rt.ArrayItem{ key: none, val: 'UTF-8' }])])
		if rt.is_true(var_utf8_data) {
			mut var_parser := rt.call_method(this.registry, 'create', [Class_SimplePie_Parser.class()])
			if rt.is_true(rt.call_method(var_parser, 'parse', [var_utf8_data.clone(), rt.new_string('UTF-8'), if !(this.permanent_url).is_null() { this.permanent_url } else { rt.new_string('') }])) {
				this.data = rt.call_method(var_parser, 'get_data', []rt.PhpVal{})
				if rt.is_true(rt.new_bool(!(rt.is_true(rt.bitwise_and(this.get_type(), rt.bitwise_not(Class_SimplePie_SimplePie_SimplePie.type_none())))))) {
					this.error = rt.concat(rt.concat(rt.new_string('A feed could not be found at `'), this.feed_url), rt.new_string('`. This does not appear to be a valid RSS or Atom feed.'))
					rt.call_method(this.registry, 'call', [Class_SimplePie_Misc.class(), rt.new_string('error'), rt.create_array([rt.ArrayItem{ key: none, val: this.error }, rt.ArrayItem{ key: none, val: rt.get_constant('E_USER_NOTICE') }, rt.ArrayItem{ key: none, val: @FILE }, rt.ArrayItem{ key: none, val: @LINE.int() }])])
					return false
				}
				if !(var_headers).is_null() {
					this.data.array_set('headers', var_headers.clone())
				}
				mut iife_temp_2 := Class_SimplePie_Misc{}
				mut iife_result_2 := iife_temp_2.get_build()
				this.data.array_set('build', iife_result_2)
				this.data.array_set('cache_expiration_time', rt.add(this.cache_duration, rt.call_function('time', []rt.PhpVal{})))
				if rt.is_true(var_cache) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_cache, 'set_data', [this.get_cache_filename((this.feed_url).str()), this.data, this.cache_duration]))))) {
					rt.call_function('trigger_error', [rt.concat(this.cache_location, rt.new_string(' is not writable. Make sure you\'ve set the correct relative or absolute path, and that the location is server-writable.')), rt.get_constant('E_USER_WARNING')])
				}
				return true
			}
		}
	}
	if !(var_parser).is_null() {
		this.error = this.feed_url
		this.error = rt.concat(this.error, rt.call_function('sprintf', [rt.new_string(' is invalid XML, likely due to invalid characters. XML error: %s at line %d, column %d'), rt.call_method(var_parser, 'get_error_string', []rt.PhpVal{}), rt.call_method(var_parser, 'get_current_line', []rt.PhpVal{}), rt.call_method(var_parser, 'get_current_column', []rt.PhpVal{})]))
	} else {
		this.error = rt.new_string('The data could not be converted to UTF-8.')
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('extension_loaded', [rt.new_string('mbstring')]))))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('extension_loaded', [rt.new_string('iconv')]))))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [rt.new_string('\\UConverter')]))))) {
			this.error = rt.concat(this.error, rt.new_string(' You MUST have either the iconv, mbstring or intl (PHP 5.5+) extension installed and enabled.'))
		} else {
			mut var_missingExtensions := rt.new_array()
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('extension_loaded', [rt.new_string('iconv')]))))) {
				var_missingExtensions.array_push('iconv')
			}
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('extension_loaded', [rt.new_string('mbstring')]))))) {
				var_missingExtensions.array_push('mbstring')
			}
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [rt.new_string('\\UConverter')]))))) {
				var_missingExtensions.array_push('intl (PHP 5.5+)')
			}
			this.error = rt.concat(this.error, rt.new_string(' Try installing/enabling the ' + (rt.call_function('implode', [rt.new_string(' or '), var_missingExtensions.clone()])).str() + ' extension.'))
		}
	}
	rt.call_method(this.registry, 'call', [Class_SimplePie_Misc.class(), rt.new_string('error'), rt.create_array([rt.ArrayItem{ key: none, val: this.error }, rt.ArrayItem{ key: none, val: rt.get_constant('E_USER_NOTICE') }, rt.ArrayItem{ key: none, val: @FILE }, rt.ArrayItem{ key: none, val: @LINE.int() }])])
	return false
}

fn (mut this Class_SimplePie_SimplePie) fetch_data(var_cache rt.PhpVal) rt.PhpVal {
	mut var_cache_mutated := var_cache
	if rt.is_true(rt.new_bool(rt.instance_of(var_cache_mutated, 'SimplePie_Cache_Base'))) {
	var_cache_mutated = create_simplepie_cache_basedatacache(var_cache_mutated.clone())
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_cache_mutated, rt.new_bool(false))))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_cache_mutated, 'SimplePie_Cache_DataCache')))))) {
		rt.throw_exception(rt.new_object('InvalidArgumentException', []string{}, create_invalidargumentexception(rt.call_function('sprintf', [rt.new_string('%s(): Argument #1 ($cache) must be of type %s|false'), rt.new_string(@METHOD), Class_SimplePie_Cache_DataCache.class()]), rt.new_int(1))))
	}
	mut var_cacheKey := this.get_cache_filename((this.feed_url).str())
	if rt.is_true(var_cache_mutated) {
		this.data = rt.call_method(var_cache_mutated, 'get_data', [var_cacheKey.clone(), rt.new_array()])
		if !(!rt.is_true(this.data)) {
			mut iife_temp_3 := Class_SimplePie_Misc{}
			mut iife_result_3 := iife_temp_3.get_build()
			if !(this.data.array_isset(rt.new_string('build'))) || rt.is_true(rt.new_bool(!rt.is_true(rt.identical(this.data.array_get(rt.new_string('build')), iife_result_3)))) {
				rt.call_method(var_cache_mutated, 'delete_data', [var_cacheKey.clone()])
				this.data = rt.new_array()
			} else if this.data.array_isset(rt.new_string('url')) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(this.data.array_get(rt.new_string('url')), this.feed_url)))) {
				var_cache_mutated = rt.new_bool(false)
				this.data = rt.new_array()
			} else if this.data.array_isset(rt.new_string('feed_url')) {
				if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(this.data.array_get(rt.new_string('feed_url')), this.data.array_get(rt.new_string('url')))))) {
					this.set_feed_url(this.data.array_get(rt.new_string('feed_url')))
					this.data.array_set('url', this.data.array_get(rt.new_string('feed_url')))
					rt.call_method(var_cache_mutated, 'set_data', [this.get_cache_filename((this.feed_url).str()), this.data, this.autodiscovery_cache_duration])
					return rt.new_bool(this.init())
				}
				rt.call_method(var_cache_mutated, 'delete_data', [this.get_cache_filename((this.feed_url).str())])
				this.data = rt.new_array()
			} else if !(this.data.array_isset(rt.new_string('cache_expiration_time'))) || rt.is_true(rt.less(this.data.array_get(rt.new_string('cache_expiration_time')), rt.call_function('time', []rt.PhpVal{}))) {
				this.check_modified = true
				if this.data.array_get(rt.new_string('headers')).array_isset(rt.new_string('last-modified')) || this.data.array_get(rt.new_string('headers')).array_isset(rt.new_string('etag')) {
					mut var_headers := rt.create_array([rt.ArrayItem{ key: 'Accept', val: Class_SimplePie_SimplePie.default_http_accept_header() }])
					if this.data.array_get(rt.new_string('headers')).array_isset(rt.new_string('last-modified')) {
						var_headers.array_set('if-modified-since', this.data.array_get(rt.new_string('headers')).array_get(rt.new_string('last-modified')))
					}
					if this.data.array_get(rt.new_string('headers')).array_isset(rt.new_string('etag')) {
						var_headers.array_set('if-none-match', this.data.array_get(rt.new_string('headers')).array_get(rt.new_string('etag')))
					}
					mut var_file := rt.call_method(this.get_http_client(), 'request', [Class_SimplePie_HTTP_Client.method_get(), this.feed_url, var_headers.clone()])
					if rt.has_exception() { unsafe { goto catch_label_1 } }
					this.status_code = rt.call_method(var_file, 'get_status_code', []rt.PhpVal{})
					if rt.has_exception() { unsafe { goto catch_label_1 } }
					unsafe { goto end_label_1 }

catch_label_1:
					mut var_e_1 := rt.get_and_clear_exception()
					if rt.instance_of(var_e_1, 'SimplePie_HTTP_ClientException') {
						mut var_th := var_e_1.clone()
						this.check_modified = false
						this.status_code = rt.new_int(0)
						if rt.is_true(this.force_cache_fallback) {
							this.data.array_set('cache_expiration_time', rt.add(this.cache_duration, rt.call_function('time', []rt.PhpVal{})))
							rt.call_method(var_cache_mutated, 'set_data', [var_cacheKey.clone(), this.data, this.cache_duration])
							return rt.new_bool(true)
						}
						mut var_failedFileReason := rt.call_method(var_th, 'getMessage', []rt.PhpVal{})
						unsafe { goto end_label_1 }
					}
					else {
						rt.throw_exception(var_e_1)
						unsafe { goto end_label_1 }
					}

end_label_1:
					if rt.is_true(rt.identical(this.status_code, rt.new_int(304))) {
						this.raw_data = rt.new_bool(false)
						this.data.array_set('cache_expiration_time', rt.add(this.cache_duration, rt.call_function('time', []rt.PhpVal{})))
						rt.call_method(var_cache_mutated, 'set_data', [var_cacheKey.clone(), this.data, this.cache_duration])
						return rt.new_bool(true)
					}
				}
			} else {
				this.raw_data = rt.new_bool(false)
				return rt.new_bool(true)
			}
		} else {
			this.data = rt.new_array()
		}
	}
	if !(!(var_file).is_null()) {
		if rt.is_true(rt.new_bool(rt.instance_of(this.file, 'SimplePie_File'))) && rt.is_true(rt.identical(rt.call_method(this.file, 'get_final_requested_uri', []rt.PhpVal{}), this.feed_url)) {
			var_file = this.file
		} else if !(var_failedFileReason).is_null() {
			this.error = var_failedFileReason.clone()
			return rt.new_bool(!(!rt.is_true(this.data)))
		} else {
			var_headers = rt.create_array([rt.ArrayItem{ key: 'Accept', val: Class_SimplePie_SimplePie.default_http_accept_header() }])
			var_file = rt.call_method(this.get_http_client(), 'request', [Class_SimplePie_HTTP_Client.method_get(), this.feed_url, var_headers.clone()])
			if rt.has_exception() { unsafe { goto catch_label_2 } }
			unsafe { goto end_label_2 }

catch_label_2:
			mut var_e_2 := rt.get_and_clear_exception()
			if rt.instance_of(var_e_2, 'SimplePie_HTTP_ClientException') {
				var_th = var_e_2.clone()
				this.error = rt.call_method(var_th, 'getMessage', []rt.PhpVal{})
				return rt.new_bool(!(!rt.is_true(this.data)))
				unsafe { goto end_label_2 }
			}
			else {
				rt.throw_exception(var_e_2)
				unsafe { goto end_label_2 }
			}

end_label_2:
		}
	}
	this.status_code = rt.call_method(var_file, 'get_status_code', []rt.PhpVal{})
	mut iife_temp_4 := Class_SimplePie_Misc{}
	mut iife_result_4 := iife_temp_4.is_remote_uri(rt.call_method(var_file, 'get_final_requested_uri', []rt.PhpVal{}))
	if !(rt.is_true(rt.new_bool(!(rt.is_true(iife_result_4)))) || (rt.is_true(rt.identical(rt.call_method(var_file, 'get_status_code', []rt.PhpVal{}), rt.new_int(200))) || (rt.is_true(rt.greater(rt.call_method(var_file, 'get_status_code', []rt.PhpVal{}), rt.new_int(206))) && rt.is_true(rt.less(rt.call_method(var_file, 'get_status_code', []rt.PhpVal{}), rt.new_int(300)))))) {
		this.error = 'Retrieved unsupported status code "' + (this.status_code).str() + '"'
		return rt.new_bool(!(!rt.is_true(this.data)))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(this.force_feed)))) {
		mut iife_temp_5 := Class_SimplePie_File{}
		mut iife_result_5 := iife_temp_5.fromresponse(var_file.clone())
		mut var_locate := rt.call_method(this.registry, 'create', [Class_SimplePie_Locator.class(), rt.create_array([rt.ArrayItem{ key: none, val: if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_file, 'SimplePie_File')))))) { iife_result_5 } else { var_file } }, rt.ArrayItem{ key: none, val: this.timeout }, rt.ArrayItem{ key: none, val: this.useragent }, rt.ArrayItem{ key: none, val: this.max_checked_feeds }, rt.ArrayItem{ key: none, val: this.force_fsockopen }, rt.ArrayItem{ key: none, val: this.curl_options }])])
		mut var_http_client := this.get_http_client()
		if rt.is_true(rt.new_bool(rt.instance_of(var_http_client, 'SimplePie_HTTP_Psr18Client'))) {
			rt.call_method(var_locate, 'set_http_client', [rt.call_method(var_http_client, 'getHttpClient', []rt.PhpVal{}), rt.call_method(var_http_client, 'getRequestFactory', []rt.PhpVal{}), rt.call_method(var_http_client, 'getUriFactory', []rt.PhpVal{})])
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_locate, 'is_feed', [var_file.clone()]))))) {
			mut var_copyStatusCode := rt.call_method(var_file, 'get_status_code', []rt.PhpVal{})
			mut var_copyContentType := rt.call_method(var_file, 'get_header_line', [rt.new_string('content-type')])
			mut var_microformats := rt.new_bool(false)
			if rt.has_exception() { unsafe { goto catch_label_3 } }
			if rt.is_true(rt.call_function('class_exists', [rt.new_string('DOMXpath')])) && rt.is_true(rt.call_function('function_exists', [rt.new_string('Mf2\\parse')])) {
				mut var_doc := create_simplepie_domdocument()
				if rt.has_exception() { unsafe { goto catch_label_3 } }
				var_doc.loadhtml(rt.call_method(var_file, 'get_body_content', []rt.PhpVal{}))
				if rt.has_exception() { unsafe { goto catch_label_3 } }
				mut var_xpath := create_simplepie_domxpath(var_doc)
				if rt.has_exception() { unsafe { goto catch_label_3 } }
				mut var_query := rt.new_string('//*[contains(concat(" ", @class, " "), " h-feed ") or ' + 'contains(concat(" ", @class, " "), " h-entry ")]')
				if rt.has_exception() { unsafe { goto catch_label_3 } }
				mut var_result := var_xpath.query(var_query.clone())
				if rt.has_exception() { unsafe { goto catch_label_3 } }
				var_microformats = rt.new_bool(!rt.is_true(rt.identical(rt.get_property(var_result, 'length'), rt.new_int(0))))
				if rt.has_exception() { unsafe { goto catch_label_3 } }
			}
			if rt.has_exception() { unsafe { goto catch_label_3 } }
			mut var_discovered := rt.call_method(var_locate, 'find', [this.autodiscovery, this.all_discovered_feeds])
			if rt.has_exception() { unsafe { goto catch_label_3 } }
			if rt.is_true(var_microformats) {
				mut var_hub := rt.call_method(var_locate, 'get_rel_link', [rt.new_string('hub')])
				if rt.has_exception() { unsafe { goto catch_label_3 } }
				mut var_self := rt.call_method(var_locate, 'get_rel_link', [rt.new_string('self')])
				if rt.has_exception() { unsafe { goto catch_label_3 } }
				if rt.is_true(var_hub) || rt.is_true(var_self) {
					var_file = this.store_links(mut rt.cast_object_ptr[Class_SimplePie_HTTP_Response](var_file), mut rt.cast_object_ptr[Class_SimplePie_?string](var_hub), mut rt.cast_object_ptr[Class_SimplePie_?string](var_self))
					if rt.has_exception() { unsafe { goto catch_label_3 } }
				}
				if rt.has_exception() { unsafe { goto catch_label_3 } }
				if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(this.all_discovered_feeds, rt.new_null())))) {
					this.all_discovered_feeds.array_push(var_file.clone())
					if rt.has_exception() { unsafe { goto catch_label_3 } }
				}
				if rt.has_exception() { unsafe { goto catch_label_3 } }
			} else {
				if rt.is_true(var_discovered) {
					var_file = var_discovered.clone()
					if rt.has_exception() { unsafe { goto catch_label_3 } }
				} else {
					var_file = rt.new_null()
					if rt.has_exception() { unsafe { goto catch_label_3 } }
					this.error = rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('A feed could not be found at `'), this.feed_url), rt.new_string('`; the status code is `')), var_copyStatusCode), rt.new_string('` and content-type is `')), var_copyContentType), rt.new_string('`'))
					if rt.has_exception() { unsafe { goto catch_label_3 } }
					rt.call_method(this.registry, 'call', [Class_SimplePie_Misc.class(), rt.new_string('error'), rt.create_array([rt.ArrayItem{ key: none, val: this.error }, rt.ArrayItem{ key: none, val: rt.get_constant('E_USER_NOTICE') }, rt.ArrayItem{ key: none, val: @FILE }, rt.ArrayItem{ key: none, val: @LINE.int() }])])
					if rt.has_exception() { unsafe { goto catch_label_3 } }
					return rt.new_bool(false)
				}
				if rt.has_exception() { unsafe { goto catch_label_3 } }
			}
			if rt.has_exception() { unsafe { goto catch_label_3 } }
			unsafe { goto end_label_3 }

catch_label_3:
			mut var_e_3 := rt.get_and_clear_exception()
			if rt.instance_of(var_e_3, 'SimplePie_Exception') {
				mut var_e := var_e_3.clone()
				var_file = rt.new_null()
				this.error = rt.call_method(var_e, 'getMessage', []rt.PhpVal{})
				rt.call_method(this.registry, 'call', [Class_SimplePie_Misc.class(), rt.new_string('error'), rt.create_array([rt.ArrayItem{ key: none, val: this.error }, rt.ArrayItem{ key: none, val: rt.get_constant('E_USER_NOTICE') }, rt.ArrayItem{ key: none, val: rt.call_method(var_e, 'getFile', []rt.PhpVal{}) }, rt.ArrayItem{ key: none, val: rt.call_method(var_e, 'getLine', []rt.PhpVal{}) }])])
				return rt.new_bool(false)
				unsafe { goto end_label_3 }
			}
			else {
				rt.throw_exception(var_e_3)
				unsafe { goto end_label_3 }
			}

end_label_3:
			if rt.is_true(var_cache_mutated) {
				mut iife_temp_6 := Class_SimplePie_Misc{}
				mut iife_result_6 := iife_temp_6.get_build()
				this.data = rt.create_array([rt.ArrayItem{ key: 'url', val: this.feed_url }, rt.ArrayItem{ key: 'feed_url', val: rt.call_method(var_file, 'get_final_requested_uri', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'build', val: iife_result_6 }, rt.ArrayItem{ key: 'cache_expiration_time', val: rt.add(this.cache_duration, rt.call_function('time', []rt.PhpVal{})) }])
				if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_cache_mutated, 'set_data', [var_cacheKey.clone(), this.data, this.cache_duration]))))) {
					rt.call_function('trigger_error', [rt.concat(this.cache_location, rt.new_string(' is not writable. Make sure you\'ve set the correct relative or absolute path, and that the location is server-writable.')), rt.get_constant('E_USER_WARNING')])
				}
			}
		}
		this.feed_url = rt.call_method(var_file, 'get_final_requested_uri', []rt.PhpVal{})
	var_locate = rt.new_null()
	}
	this.raw_data = rt.call_method(var_file, 'get_body_content', []rt.PhpVal{})
	this.permanent_url = rt.call_method(var_file, 'get_permanent_uri', []rt.PhpVal{})
	var_headers = rt.new_array()
	mut iter_7 := rt.call_method(var_file, 'get_headers', []rt.PhpVal{}).iterator()
	for {
		item_7 := iter_7.next() or { break }
		mut var_values := item_7.val
		mut var_key := item_7.key
		var_headers.array_set(var_key, rt.call_function('implode', [rt.new_string(', '), var_values.clone()]))
	}
	mut var_sniffer := rt.call_method(this.registry, 'create', [Class_SimplePie_Content_Type_Sniffer.class(), rt.create_array([rt.ArrayItem{ key: none, val: var_file }])])
	mut var_sniffed := rt.call_method(var_sniffer, 'get_type', []rt.PhpVal{})
	return rt.create_array([rt.ArrayItem{ key: none, val: var_headers }, rt.ArrayItem{ key: none, val: var_sniffed }])
}

fn (mut this Class_SimplePie_SimplePie) error() rt.PhpVal {
	return this.error
}

fn (mut this Class_SimplePie_SimplePie) status_code() rt.PhpVal {
	return this.status_code
}

fn (mut this Class_SimplePie_SimplePie) get_raw_data() rt.PhpVal {
	return this.raw_data
}

fn (mut this Class_SimplePie_SimplePie) get_encoding() rt.PhpVal {
	return rt.get_property(this.sanitize, 'output_encoding')
}

fn (mut this Class_SimplePie_SimplePie) handle_content_type(mime string) {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('headers_sent', []rt.PhpVal{}))))) {
		mut var_header := rt.new_string("Content-type: ${var_mime};")
		if rt.is_true(this.get_encoding()) {
			var_header = rt.concat(var_header, rt.new_string(' charset=' + (this.get_encoding()).str()))
		} else {
			var_header = rt.concat(var_header, rt.new_string(' charset=UTF-8'))
		}
		rt.call_function('header', [var_header.clone()])
	}
}

fn (mut this Class_SimplePie_SimplePie) get_type() rt.PhpVal {
	if !(this.data.array_isset(rt.new_string('type'))) {
		this.data.array_set('type', Class_SimplePie_SimplePie_SimplePie.type_all())
		if this.data.array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_atom_10()).array_isset(rt.new_string('feed')) {
			rt.new_null()
		} else if this.data.array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_atom_03()).array_isset(rt.new_string('feed')) {
			rt.new_null()
		} else if this.data.array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_rdf()).array_isset(rt.new_string('RDF')) {
			if this.data.array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_rdf()).array_get(rt.new_string('RDF')).array_get(rt.new_int(0)).array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_rss_10()).array_isset(rt.new_string('channel')) || this.data.array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_rdf()).array_get(rt.new_string('RDF')).array_get(rt.new_int(0)).array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_rss_10()).array_isset(rt.new_string('image')) || this.data.array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_rdf()).array_get(rt.new_string('RDF')).array_get(rt.new_int(0)).array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_rss_10()).array_isset(rt.new_string('item')) || this.data.array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_rdf()).array_get(rt.new_string('RDF')).array_get(rt.new_int(0)).array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_rss_10()).array_isset(rt.new_string('textinput')) {
				rt.new_null()
			}
			if this.data.array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_rdf()).array_get(rt.new_string('RDF')).array_get(rt.new_int(0)).array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_rss_090()).array_isset(rt.new_string('channel')) || this.data.array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_rdf()).array_get(rt.new_string('RDF')).array_get(rt.new_int(0)).array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_rss_090()).array_isset(rt.new_string('image')) || this.data.array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_rdf()).array_get(rt.new_string('RDF')).array_get(rt.new_int(0)).array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_rss_090()).array_isset(rt.new_string('item')) || this.data.array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_rdf()).array_get(rt.new_string('RDF')).array_get(rt.new_int(0)).array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_rss_090()).array_isset(rt.new_string('textinput')) {
				rt.new_null()
			}
		} else if this.data.array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_rss_20()).array_isset(rt.new_string('rss')) {
			rt.new_null()
			if this.data.array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_rss_20()).array_get(rt.new_string('rss')).array_get(rt.new_int(0)).array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_isset(rt.new_string('version')) {
				mut switch_val_2 := rt.new_string(this.data.array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_rss_20()).array_get(rt.new_string('rss')).array_get(rt.new_int(0)).array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_get(rt.new_string('version')).to_string().trim_space())
				if rt.is_true(rt.equal(switch_val_2, rt.new_string('0.91'))) {
					rt.new_null()
					if this.data.array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_rss_20()).array_get(rt.new_string('rss')).array_get(rt.new_int(0)).array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_rss_20()).array_get(rt.new_string('skiphours')).array_get(rt.new_string('hour')).array_get(rt.new_int(0)).array_isset(rt.new_string('data')) {
						mut switch_val_3 := rt.new_string(this.data.array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_rss_20()).array_get(rt.new_string('rss')).array_get(rt.new_int(0)).array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_rss_20()).array_get(rt.new_string('skiphours')).array_get(rt.new_string('hour')).array_get(rt.new_int(0)).array_get(rt.new_string('data')).to_string().trim_space())
						if rt.is_true(rt.equal(switch_val_3, rt.new_string('0'))) {
							rt.new_null()
						} else if rt.is_true(rt.equal(switch_val_3, rt.new_string('24'))) {
							rt.new_null()
						}
					}
				} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('0.92'))) {
					rt.new_null()
				} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('0.93'))) {
					rt.new_null()
				} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('0.94'))) {
					rt.new_null()
				} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('2.0'))) {
					rt.new_null()
				}
			}
		} else {
			this.data.array_set('type', Class_SimplePie_SimplePie_SimplePie.type_none())
		}
	}
	return this.data.array_get(rt.new_string('type'))
}

fn (mut this Class_SimplePie_SimplePie) subscribe_url(permanent bool) rt.PhpVal {
	if var_permanent {
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(this.permanent_url, rt.new_null())))) {
			return rt.call_function('str_replace', [rt.new_string('&amp;'), rt.new_string('&'), rt.new_string(this.sanitize((this.permanent_url).str(), (Class_SimplePie_SimplePie_SimplePie.construct_iri()).to_i64(), ''))])
		}
	} else {
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(this.feed_url, rt.new_null())))) {
			return rt.call_function('str_replace', [rt.new_string('&amp;'), rt.new_string('&'), rt.new_string(this.sanitize((this.feed_url).str(), (Class_SimplePie_SimplePie_SimplePie.construct_iri()).to_i64(), ''))])
		}
	}
	return rt.new_null()
}

fn (mut this Class_SimplePie_SimplePie) get_feed_tags(namespace string, tag string) rt.PhpVal {
	mut var_type := this.get_type()
	if rt.is_true(rt.bitwise_and(var_type, Class_SimplePie_SimplePie_SimplePie.type_atom_10())) {
		if this.data.array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_atom_10()).array_get(rt.new_string('feed')).array_get(rt.new_int(0)).array_get(rt.new_string('child')).array_get(rt.new_string(namespace)).array_isset(rt.new_string(tag)) {
			return this.data.array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_atom_10()).array_get(rt.new_string('feed')).array_get(rt.new_int(0)).array_get(rt.new_string('child')).array_get(rt.new_string(namespace)).array_get(rt.new_string(tag))
		}
	}
	if rt.is_true(rt.bitwise_and(var_type, Class_SimplePie_SimplePie_SimplePie.type_atom_03())) {
		if this.data.array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_atom_03()).array_get(rt.new_string('feed')).array_get(rt.new_int(0)).array_get(rt.new_string('child')).array_get(rt.new_string(namespace)).array_isset(rt.new_string(tag)) {
			return this.data.array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_atom_03()).array_get(rt.new_string('feed')).array_get(rt.new_int(0)).array_get(rt.new_string('child')).array_get(rt.new_string(namespace)).array_get(rt.new_string(tag))
		}
	}
	if rt.is_true(rt.bitwise_and(var_type, Class_SimplePie_SimplePie_SimplePie.type_rss_rdf())) {
		if this.data.array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_rdf()).array_get(rt.new_string('RDF')).array_get(rt.new_int(0)).array_get(rt.new_string('child')).array_get(rt.new_string(namespace)).array_isset(rt.new_string(tag)) {
			return this.data.array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_rdf()).array_get(rt.new_string('RDF')).array_get(rt.new_int(0)).array_get(rt.new_string('child')).array_get(rt.new_string(namespace)).array_get(rt.new_string(tag))
		}
	}
	if rt.is_true(rt.bitwise_and(var_type, Class_SimplePie_SimplePie_SimplePie.type_rss_syndication())) {
		if this.data.array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_rss_20()).array_get(rt.new_string('rss')).array_get(rt.new_int(0)).array_get(rt.new_string('child')).array_get(rt.new_string(namespace)).array_isset(rt.new_string(tag)) {
			return this.data.array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_rss_20()).array_get(rt.new_string('rss')).array_get(rt.new_int(0)).array_get(rt.new_string('child')).array_get(rt.new_string(namespace)).array_get(rt.new_string(tag))
		}
	}
	return rt.new_null()
}

fn (mut this Class_SimplePie_SimplePie) get_channel_tags(namespace string, tag string) rt.PhpVal {
	mut var_type := this.get_type()
	if rt.is_true(rt.bitwise_and(var_type, Class_SimplePie_SimplePie_SimplePie.type_atom_all())) {
		mut var_return := this.get_feed_tags(namespace, tag)
		if rt.is_true(var_return) {
			return var_return.clone()
		}
	}
	if rt.is_true(rt.bitwise_and(var_type, Class_SimplePie_SimplePie_SimplePie.type_rss_10())) {
		mut var_channel := this.get_feed_tags((Class_SimplePie_SimplePie_SimplePie.namespace_rss_10()).str(), 'channel')
		if rt.is_true(var_channel) {
			if var_channel.array_get(rt.new_int(0)).array_get(rt.new_string('child')).array_get(rt.new_string(namespace)).array_isset(rt.new_string(tag)) {
				return var_channel.array_get(rt.new_int(0)).array_get(rt.new_string('child')).array_get(rt.new_string(namespace)).array_get(rt.new_string(tag))
			}
		}
	}
	if rt.is_true(rt.bitwise_and(var_type, Class_SimplePie_SimplePie_SimplePie.type_rss_090())) {
		var_channel = this.get_feed_tags((Class_SimplePie_SimplePie_SimplePie.namespace_rss_090()).str(), 'channel')
		if rt.is_true(var_channel) {
			if var_channel.array_get(rt.new_int(0)).array_get(rt.new_string('child')).array_get(rt.new_string(namespace)).array_isset(rt.new_string(tag)) {
				return var_channel.array_get(rt.new_int(0)).array_get(rt.new_string('child')).array_get(rt.new_string(namespace)).array_get(rt.new_string(tag))
			}
		}
	}
	if rt.is_true(rt.bitwise_and(var_type, Class_SimplePie_SimplePie_SimplePie.type_rss_syndication())) {
		var_channel = this.get_feed_tags((Class_SimplePie_SimplePie_SimplePie.namespace_rss_20()).str(), 'channel')
		if rt.is_true(var_channel) {
			if var_channel.array_get(rt.new_int(0)).array_get(rt.new_string('child')).array_get(rt.new_string(namespace)).array_isset(rt.new_string(tag)) {
				return var_channel.array_get(rt.new_int(0)).array_get(rt.new_string('child')).array_get(rt.new_string(namespace)).array_get(rt.new_string(tag))
			}
		}
	}
	return rt.new_null()
}

fn (mut this Class_SimplePie_SimplePie) get_image_tags(namespace string, tag string) rt.PhpVal {
	mut var_type := this.get_type()
	if rt.is_true(rt.bitwise_and(var_type, Class_SimplePie_SimplePie_SimplePie.type_rss_10())) {
		mut var_image := this.get_feed_tags((Class_SimplePie_SimplePie_SimplePie.namespace_rss_10()).str(), 'image')
		if rt.is_true(var_image) {
			if var_image.array_get(rt.new_int(0)).array_get(rt.new_string('child')).array_get(rt.new_string(namespace)).array_isset(rt.new_string(tag)) {
				return var_image.array_get(rt.new_int(0)).array_get(rt.new_string('child')).array_get(rt.new_string(namespace)).array_get(rt.new_string(tag))
			}
		}
	}
	if rt.is_true(rt.bitwise_and(var_type, Class_SimplePie_SimplePie_SimplePie.type_rss_090())) {
		var_image = this.get_feed_tags((Class_SimplePie_SimplePie_SimplePie.namespace_rss_090()).str(), 'image')
		if rt.is_true(var_image) {
			if var_image.array_get(rt.new_int(0)).array_get(rt.new_string('child')).array_get(rt.new_string(namespace)).array_isset(rt.new_string(tag)) {
				return var_image.array_get(rt.new_int(0)).array_get(rt.new_string('child')).array_get(rt.new_string(namespace)).array_get(rt.new_string(tag))
			}
		}
	}
	if rt.is_true(rt.bitwise_and(var_type, Class_SimplePie_SimplePie_SimplePie.type_rss_syndication())) {
		var_image = this.get_channel_tags((Class_SimplePie_SimplePie_SimplePie.namespace_rss_20()).str(), 'image')
		if rt.is_true(var_image) {
			if var_image.array_get(rt.new_int(0)).array_get(rt.new_string('child')).array_get(rt.new_string(namespace)).array_isset(rt.new_string(tag)) {
				return var_image.array_get(rt.new_int(0)).array_get(rt.new_string('child')).array_get(rt.new_string(namespace)).array_get(rt.new_string(tag))
			}
		}
	}
	return rt.new_null()
}

fn (mut this Class_SimplePie_SimplePie) get_base(mut var_element Class_SimplePie_array) rt.PhpVal {
	if !(!rt.is_true(var_element.array_get(rt.new_string('xml_base_explicit')))) && var_element.array_isset(rt.new_string('xml_base')) {
		return var_element.array_get(rt.new_string('xml_base'))
	}
	mut var_link := this.get_link(0, 'alternate')
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_link, rt.new_null())))) {
		return var_link.clone()
	}
	var_link = this.get_link(0, 'self')
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_link, rt.new_null())))) {
		return var_link.clone()
	}
	return if !(this.subscribe_url(false)).is_null() { this.subscribe_url(false) } else { rt.new_string('') }
}

fn (mut this Class_SimplePie_SimplePie) sanitize(data string, type i64, base string) string {
	mut type_mutated := type
	return (rt.call_method(this.sanitize, 'sanitize', [rt.new_string(data), rt.new_int(type_mutated).clone(), rt.new_string(base)])).str()
	unsafe { goto end_label_4 }

catch_label_4:
	mut var_e_4 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_4, 'SimplePie_Exception') {
		mut var_e := var_e_4.clone()
		if rt.is_true(rt.new_bool(!(rt.is_true(this.enable_exceptions)))) {
			this.error = rt.call_method(var_e, 'getMessage', []rt.PhpVal{})
			rt.call_method(this.registry, 'call', [Class_SimplePie_Misc.class(), rt.new_string('error'), rt.create_array([rt.ArrayItem{ key: none, val: this.error }, rt.ArrayItem{ key: none, val: rt.get_constant('E_USER_WARNING') }, rt.ArrayItem{ key: none, val: rt.call_method(var_e, 'getFile', []rt.PhpVal{}) }, rt.ArrayItem{ key: none, val: rt.call_method(var_e, 'getLine', []rt.PhpVal{}) }])])
			return ''
		}
		rt.throw_exception(var_e)
		unsafe { goto end_label_4 }
	}
	else {
		rt.throw_exception(var_e_4)
		unsafe { goto end_label_4 }
	}

end_label_4:
	return ''
}

fn (mut this Class_SimplePie_SimplePie) get_title() rt.PhpVal {
	mut var_return := this.get_channel_tags((Class_SimplePie_SimplePie_SimplePie.namespace_atom_10()).str(), 'title')
	if rt.is_true(var_return) {
		return rt.new_string(this.sanitize((var_return.array_get(rt.new_int(0)).array_get(rt.new_string('data'))).str(), (rt.call_method(this.registry, 'call', [Class_SimplePie_Misc.class(), rt.new_string('atom_10_construct_type'), rt.create_array([rt.ArrayItem{ key: none, val: var_return.array_get(rt.new_int(0)).array_get(rt.new_string('attribs')) }])])).to_i64(), (this.get_base(mut rt.cast_object_ptr[Class_SimplePie_array](var_return.array_get(rt.new_int(0))))).str()))
	var_return = this.get_channel_tags((Class_SimplePie_SimplePie_SimplePie.namespace_atom_03()).str(), 'title')
	} else if rt.is_true(var_return) {
		return rt.new_string(this.sanitize((var_return.array_get(rt.new_int(0)).array_get(rt.new_string('data'))).str(), (rt.call_method(this.registry, 'call', [Class_SimplePie_Misc.class(), rt.new_string('atom_03_construct_type'), rt.create_array([rt.ArrayItem{ key: none, val: var_return.array_get(rt.new_int(0)).array_get(rt.new_string('attribs')) }])])).to_i64(), (this.get_base(mut rt.cast_object_ptr[Class_SimplePie_array](var_return.array_get(rt.new_int(0))))).str()))
	var_return = this.get_channel_tags((Class_SimplePie_SimplePie_SimplePie.namespace_rss_10()).str(), 'title')
	} else if rt.is_true(var_return) {
		return rt.new_string(this.sanitize((var_return.array_get(rt.new_int(0)).array_get(rt.new_string('data'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_maybe_html()).to_i64(), (this.get_base(mut rt.cast_object_ptr[Class_SimplePie_array](var_return.array_get(rt.new_int(0))))).str()))
	var_return = this.get_channel_tags((Class_SimplePie_SimplePie_SimplePie.namespace_rss_090()).str(), 'title')
	} else if rt.is_true(var_return) {
		return rt.new_string(this.sanitize((var_return.array_get(rt.new_int(0)).array_get(rt.new_string('data'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_maybe_html()).to_i64(), (this.get_base(mut rt.cast_object_ptr[Class_SimplePie_array](var_return.array_get(rt.new_int(0))))).str()))
	var_return = this.get_channel_tags((Class_SimplePie_SimplePie_SimplePie.namespace_rss_20()).str(), 'title')
	} else if rt.is_true(var_return) {
		return rt.new_string(this.sanitize((var_return.array_get(rt.new_int(0)).array_get(rt.new_string('data'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_maybe_html()).to_i64(), (this.get_base(mut rt.cast_object_ptr[Class_SimplePie_array](var_return.array_get(rt.new_int(0))))).str()))
	var_return = this.get_channel_tags((Class_SimplePie_SimplePie_SimplePie.namespace_dc_11()).str(), 'title')
	} else if rt.is_true(var_return) {
		return rt.new_string(this.sanitize((var_return.array_get(rt.new_int(0)).array_get(rt.new_string('data'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), ''))
	var_return = this.get_channel_tags((Class_SimplePie_SimplePie_SimplePie.namespace_dc_10()).str(), 'title')
	} else if rt.is_true(var_return) {
		return rt.new_string(this.sanitize((var_return.array_get(rt.new_int(0)).array_get(rt.new_string('data'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), ''))
	}
	return rt.new_null()
}

fn (mut this Class_SimplePie_SimplePie) get_category(key i64) rt.PhpVal {
	mut var_categories := this.get_categories()
	if var_categories.array_isset(rt.new_int(key)) {
		return var_categories.array_get(rt.new_int(key))
	}
	return rt.new_null()
}

fn (mut this Class_SimplePie_SimplePie) get_categories() rt.PhpVal {
	mut var_categories := rt.new_array()
	mut iter_8 := rt.cast_array(this.get_channel_tags((Class_SimplePie_SimplePie_SimplePie.namespace_atom_10()).str(), 'category')).iterator()
	for {
		item_8 := iter_8.next() or { break }
		mut var_category := item_8.val
		mut var_term := rt.new_null()
		mut var_scheme := rt.new_null()
		mut var_label := rt.new_null()
		if var_category.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_isset(rt.new_string('term')) {
		var_term = rt.new_string(this.sanitize((var_category.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_get(rt.new_string('term'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), ''))
		}
		if var_category.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_isset(rt.new_string('scheme')) {
		var_scheme = rt.new_string(this.sanitize((var_category.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_get(rt.new_string('scheme'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), ''))
		}
		if var_category.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_isset(rt.new_string('label')) {
		var_label = rt.new_string(this.sanitize((var_category.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_get(rt.new_string('label'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), ''))
		}
		var_categories.array_push(rt.call_method(this.registry, 'create', [Class_SimplePie_Category.class(), rt.create_array([rt.ArrayItem{ key: none, val: var_term }, rt.ArrayItem{ key: none, val: var_scheme }, rt.ArrayItem{ key: none, val: var_label }])]))
	}
	mut iter_9 := rt.cast_array(this.get_channel_tags((Class_SimplePie_SimplePie_SimplePie.namespace_rss_20()).str(), 'category')).iterator()
	for {
		item_9 := iter_9.next() or { break }
		mut var_category := item_9.val
		mut var_term := rt.new_string(this.sanitize((var_category.array_get(rt.new_string('data'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), ''))
		if var_category.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_isset(rt.new_string('domain')) {
		mut var_scheme := rt.new_string(this.sanitize((var_category.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_get(rt.new_string('domain'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), ''))
		} else {
		var_scheme = rt.new_null()
		}
		var_categories.array_push(rt.call_method(this.registry, 'create', [Class_SimplePie_Category.class(), rt.create_array([rt.ArrayItem{ key: none, val: var_term }, rt.ArrayItem{ key: none, val: var_scheme }, rt.ArrayItem{ key: none, val: rt.new_null() }])]))
	}
	mut iter_10 := rt.cast_array(this.get_channel_tags((Class_SimplePie_SimplePie_SimplePie.namespace_dc_11()).str(), 'subject')).iterator()
	for {
		item_10 := iter_10.next() or { break }
		mut var_category := item_10.val
		var_categories.array_push(rt.call_method(this.registry, 'create', [Class_SimplePie_Category.class(), rt.create_array([rt.ArrayItem{ key: none, val: this.sanitize((var_category.array_get(rt.new_string('data'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '') }, rt.ArrayItem{ key: none, val: rt.new_null() }, rt.ArrayItem{ key: none, val: rt.new_null() }])]))
	}
	mut iter_11 := rt.cast_array(this.get_channel_tags((Class_SimplePie_SimplePie_SimplePie.namespace_dc_10()).str(), 'subject')).iterator()
	for {
		item_11 := iter_11.next() or { break }
		mut var_category := item_11.val
		var_categories.array_push(rt.call_method(this.registry, 'create', [Class_SimplePie_Category.class(), rt.create_array([rt.ArrayItem{ key: none, val: this.sanitize((var_category.array_get(rt.new_string('data'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '') }, rt.ArrayItem{ key: none, val: rt.new_null() }, rt.ArrayItem{ key: none, val: rt.new_null() }])]))
	}
	if !(!rt.is_true(var_categories)) {
		return rt.call_function('array_unique', [var_categories.clone()])
	}
	return rt.new_null()
}

fn (mut this Class_SimplePie_SimplePie) get_author(key i64) rt.PhpVal {
	mut var_authors := this.get_authors()
	if var_authors.array_isset(rt.new_int(key)) {
		return var_authors.array_get(rt.new_int(key))
	}
	return rt.new_null()
}

fn (mut this Class_SimplePie_SimplePie) get_authors() rt.PhpVal {
	mut var_authors := rt.new_array()
	mut iter_12 := rt.cast_array(this.get_channel_tags((Class_SimplePie_SimplePie_SimplePie.namespace_atom_10()).str(), 'author')).iterator()
	for {
		item_12 := iter_12.next() or { break }
		mut var_author := item_12.val
		mut var_name := rt.new_null()
		mut var_uri := rt.new_null()
		mut var_email := rt.new_null()
		if var_author.array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_atom_10()).array_get(rt.new_string('name')).array_get(rt.new_int(0)).array_isset(rt.new_string('data')) {
		var_name = rt.new_string(this.sanitize((var_author.array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_atom_10()).array_get(rt.new_string('name')).array_get(rt.new_int(0)).array_get(rt.new_string('data'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), ''))
		}
		if var_author.array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_atom_10()).array_get(rt.new_string('uri')).array_get(rt.new_int(0)).array_isset(rt.new_string('data')) {
		var_uri = var_author.array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_atom_10()).array_get(rt.new_string('uri')).array_get(rt.new_int(0))
		var_uri = rt.new_string(this.sanitize((var_uri.array_get(rt.new_string('data'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_iri()).to_i64(), (this.get_base(mut rt.cast_object_ptr[Class_SimplePie_array](var_uri))).str()))
		}
		if var_author.array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_atom_10()).array_get(rt.new_string('email')).array_get(rt.new_int(0)).array_isset(rt.new_string('data')) {
		var_email = rt.new_string(this.sanitize((var_author.array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_atom_10()).array_get(rt.new_string('email')).array_get(rt.new_int(0)).array_get(rt.new_string('data'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), ''))
		}
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_name, rt.new_null())))) || rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_email, rt.new_null())))) || rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_uri, rt.new_null())))) {
			var_authors.array_push(rt.call_method(this.registry, 'create', [Class_SimplePie_Author.class(), rt.create_array([rt.ArrayItem{ key: none, val: var_name }, rt.ArrayItem{ key: none, val: var_uri }, rt.ArrayItem{ key: none, val: var_email }])]))
		}
	}
	mut var_author := this.get_channel_tags((Class_SimplePie_SimplePie_SimplePie.namespace_atom_03()).str(), 'author')
	if rt.is_true(var_author) {
		mut var_name := rt.new_null()
		mut var_url := rt.new_null()
		mut var_email := rt.new_null()
		if var_author.array_get(rt.new_int(0)).array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_atom_03()).array_get(rt.new_string('name')).array_get(rt.new_int(0)).array_isset(rt.new_string('data')) {
		var_name = rt.new_string(this.sanitize((var_author.array_get(rt.new_int(0)).array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_atom_03()).array_get(rt.new_string('name')).array_get(rt.new_int(0)).array_get(rt.new_string('data'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), ''))
		}
		if var_author.array_get(rt.new_int(0)).array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_atom_03()).array_get(rt.new_string('url')).array_get(rt.new_int(0)).array_isset(rt.new_string('data')) {
		var_url = var_author.array_get(rt.new_int(0)).array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_atom_03()).array_get(rt.new_string('url')).array_get(rt.new_int(0))
		var_url = rt.new_string(this.sanitize((var_url.array_get(rt.new_string('data'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_iri()).to_i64(), (this.get_base(mut rt.cast_object_ptr[Class_SimplePie_array](var_url))).str()))
		}
		if var_author.array_get(rt.new_int(0)).array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_atom_03()).array_get(rt.new_string('email')).array_get(rt.new_int(0)).array_isset(rt.new_string('data')) {
		var_email = rt.new_string(this.sanitize((var_author.array_get(rt.new_int(0)).array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_atom_03()).array_get(rt.new_string('email')).array_get(rt.new_int(0)).array_get(rt.new_string('data'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), ''))
		}
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_name, rt.new_null())))) || rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_email, rt.new_null())))) || rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_url, rt.new_null())))) {
			var_authors.array_push(rt.call_method(this.registry, 'create', [Class_SimplePie_Author.class(), rt.create_array([rt.ArrayItem{ key: none, val: var_name }, rt.ArrayItem{ key: none, val: var_url }, rt.ArrayItem{ key: none, val: var_email }])]))
		}
	}
	mut iter_13 := rt.cast_array(this.get_channel_tags((Class_SimplePie_SimplePie_SimplePie.namespace_dc_11()).str(), 'creator')).iterator()
	for {
		item_13 := iter_13.next() or { break }
		mut var_author_shadow := item_13.val
		var_authors.array_push(rt.call_method(this.registry, 'create', [Class_SimplePie_Author.class(), rt.create_array([rt.ArrayItem{ key: none, val: this.sanitize((var_author_shadow.array_get(rt.new_string('data'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '') }, rt.ArrayItem{ key: none, val: rt.new_null() }, rt.ArrayItem{ key: none, val: rt.new_null() }])]))
	}
	mut iter_14 := rt.cast_array(this.get_channel_tags((Class_SimplePie_SimplePie_SimplePie.namespace_dc_10()).str(), 'creator')).iterator()
	for {
		item_14 := iter_14.next() or { break }
		mut var_author_shadow := item_14.val
		var_authors.array_push(rt.call_method(this.registry, 'create', [Class_SimplePie_Author.class(), rt.create_array([rt.ArrayItem{ key: none, val: this.sanitize((var_author_shadow.array_get(rt.new_string('data'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '') }, rt.ArrayItem{ key: none, val: rt.new_null() }, rt.ArrayItem{ key: none, val: rt.new_null() }])]))
	}
	mut iter_15 := rt.cast_array(this.get_channel_tags((Class_SimplePie_SimplePie_SimplePie.namespace_itunes()).str(), 'author')).iterator()
	for {
		item_15 := iter_15.next() or { break }
		mut var_author_shadow := item_15.val
		var_authors.array_push(rt.call_method(this.registry, 'create', [Class_SimplePie_Author.class(), rt.create_array([rt.ArrayItem{ key: none, val: this.sanitize((var_author_shadow.array_get(rt.new_string('data'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), '') }, rt.ArrayItem{ key: none, val: rt.new_null() }, rt.ArrayItem{ key: none, val: rt.new_null() }])]))
	}
	if !(!rt.is_true(var_authors)) {
		return rt.call_function('array_unique', [var_authors.clone()])
	}
	return rt.new_null()
}

fn (mut this Class_SimplePie_SimplePie) get_contributor(key i64) rt.PhpVal {
	mut var_contributors := this.get_contributors()
	if var_contributors.array_isset(rt.new_int(key)) {
		return var_contributors.array_get(rt.new_int(key))
	}
	return rt.new_null()
}

fn (mut this Class_SimplePie_SimplePie) get_contributors() rt.PhpVal {
	mut var_contributors := rt.new_array()
	mut iter_16 := rt.cast_array(this.get_channel_tags((Class_SimplePie_SimplePie_SimplePie.namespace_atom_10()).str(), 'contributor')).iterator()
	for {
		item_16 := iter_16.next() or { break }
		mut var_contributor := item_16.val
		mut var_name := rt.new_null()
		mut var_uri := rt.new_null()
		mut var_email := rt.new_null()
		if var_contributor.array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_atom_10()).array_get(rt.new_string('name')).array_get(rt.new_int(0)).array_isset(rt.new_string('data')) {
		var_name = rt.new_string(this.sanitize((var_contributor.array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_atom_10()).array_get(rt.new_string('name')).array_get(rt.new_int(0)).array_get(rt.new_string('data'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), ''))
		}
		if var_contributor.array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_atom_10()).array_get(rt.new_string('uri')).array_get(rt.new_int(0)).array_isset(rt.new_string('data')) {
		var_uri = var_contributor.array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_atom_10()).array_get(rt.new_string('uri')).array_get(rt.new_int(0))
		var_uri = rt.new_string(this.sanitize((var_uri.array_get(rt.new_string('data'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_iri()).to_i64(), (this.get_base(mut rt.cast_object_ptr[Class_SimplePie_array](var_uri))).str()))
		}
		if var_contributor.array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_atom_10()).array_get(rt.new_string('email')).array_get(rt.new_int(0)).array_isset(rt.new_string('data')) {
		var_email = rt.new_string(this.sanitize((var_contributor.array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_atom_10()).array_get(rt.new_string('email')).array_get(rt.new_int(0)).array_get(rt.new_string('data'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), ''))
		}
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_name, rt.new_null())))) || rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_email, rt.new_null())))) || rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_uri, rt.new_null())))) {
			var_contributors.array_push(rt.call_method(this.registry, 'create', [Class_SimplePie_Author.class(), rt.create_array([rt.ArrayItem{ key: none, val: var_name }, rt.ArrayItem{ key: none, val: var_uri }, rt.ArrayItem{ key: none, val: var_email }])]))
		}
	}
	mut iter_17 := rt.cast_array(this.get_channel_tags((Class_SimplePie_SimplePie_SimplePie.namespace_atom_03()).str(), 'contributor')).iterator()
	for {
		item_17 := iter_17.next() or { break }
		mut var_contributor := item_17.val
		mut var_name := rt.new_null()
		mut var_url := rt.new_null()
		mut var_email := rt.new_null()
		if var_contributor.array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_atom_03()).array_get(rt.new_string('name')).array_get(rt.new_int(0)).array_isset(rt.new_string('data')) {
		var_name = rt.new_string(this.sanitize((var_contributor.array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_atom_03()).array_get(rt.new_string('name')).array_get(rt.new_int(0)).array_get(rt.new_string('data'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), ''))
		}
		if var_contributor.array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_atom_03()).array_get(rt.new_string('url')).array_get(rt.new_int(0)).array_isset(rt.new_string('data')) {
		var_url = var_contributor.array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_atom_03()).array_get(rt.new_string('url')).array_get(rt.new_int(0))
		var_url = rt.new_string(this.sanitize((var_url.array_get(rt.new_string('data'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_iri()).to_i64(), (this.get_base(mut rt.cast_object_ptr[Class_SimplePie_array](var_url))).str()))
		}
		if var_contributor.array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_atom_03()).array_get(rt.new_string('email')).array_get(rt.new_int(0)).array_isset(rt.new_string('data')) {
		var_email = rt.new_string(this.sanitize((var_contributor.array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_atom_03()).array_get(rt.new_string('email')).array_get(rt.new_int(0)).array_get(rt.new_string('data'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), ''))
		}
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_name, rt.new_null())))) || rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_email, rt.new_null())))) || rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_url, rt.new_null())))) {
			var_contributors.array_push(rt.call_method(this.registry, 'create', [Class_SimplePie_Author.class(), rt.create_array([rt.ArrayItem{ key: none, val: var_name }, rt.ArrayItem{ key: none, val: var_url }, rt.ArrayItem{ key: none, val: var_email }])]))
		}
	}
	if !(!rt.is_true(var_contributors)) {
		return rt.call_function('array_unique', [var_contributors.clone()])
	}
	return rt.new_null()
}

fn (mut this Class_SimplePie_SimplePie) get_link(key i64, rel string) rt.PhpVal {
	mut var_links := this.get_links(rel)
	if var_links.array_isset(rt.new_int(key)) {
		return var_links.array_get(rt.new_int(key))
	}
	return rt.new_null()
}

fn (mut this Class_SimplePie_SimplePie) get_permalink() rt.PhpVal {
	return this.get_link(0, '')
}

fn (mut this Class_SimplePie_SimplePie) get_links(rel string) rt.PhpVal {
	mut var_matches := rt.new_null()
	if !(this.data.array_isset(rt.new_string('links'))) {
		this.data.array_set('links', rt.new_array())
		mut var_links := this.get_channel_tags((Class_SimplePie_SimplePie_SimplePie.namespace_atom_10()).str(), 'link')
		if rt.is_true(var_links) {
			mut iter_18 := var_links.iterator()
			for {
				item_18 := iter_18.next() or { break }
				mut var_link := item_18.val
				if var_link.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_isset(rt.new_string('href')) {
					mut var_link_rel := if var_link.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_isset(rt.new_string('rel')) { var_link.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_get(rt.new_string('rel')) } else { rt.new_string('alternate') }
					this.data.array_get_mut('links').array_get_mut(var_link_rel).array_push(this.sanitize((var_link.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_get(rt.new_string('href'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_iri()).to_i64(), (this.get_base(mut rt.cast_object_ptr[Class_SimplePie_array](var_link))).str()))
				}
			}
		}
		var_links = this.get_channel_tags((Class_SimplePie_SimplePie_SimplePie.namespace_atom_03()).str(), 'link')
		if rt.is_true(var_links) {
			mut iter_19 := var_links.iterator()
			for {
				item_19 := iter_19.next() or { break }
				mut var_link := item_19.val
				if var_link.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_isset(rt.new_string('href')) {
					mut var_link_rel := if var_link.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_isset(rt.new_string('rel')) { var_link.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_get(rt.new_string('rel')) } else { rt.new_string('alternate') }
					this.data.array_get_mut('links').array_get_mut(var_link_rel).array_push(this.sanitize((var_link.array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_get(rt.new_string('href'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_iri()).to_i64(), (this.get_base(mut rt.cast_object_ptr[Class_SimplePie_array](var_link))).str()))
				}
			}
		}
		var_links = this.get_channel_tags((Class_SimplePie_SimplePie_SimplePie.namespace_rss_10()).str(), 'link')
		if rt.is_true(var_links) {
			this.data.array_get_mut('links').array_get_mut('alternate').array_push(this.sanitize((var_links.array_get(rt.new_int(0)).array_get(rt.new_string('data'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_iri()).to_i64(), (this.get_base(mut rt.cast_object_ptr[Class_SimplePie_array](var_links.array_get(rt.new_int(0))))).str()))
		}
		var_links = this.get_channel_tags((Class_SimplePie_SimplePie_SimplePie.namespace_rss_090()).str(), 'link')
		if rt.is_true(var_links) {
			this.data.array_get_mut('links').array_get_mut('alternate').array_push(this.sanitize((var_links.array_get(rt.new_int(0)).array_get(rt.new_string('data'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_iri()).to_i64(), (this.get_base(mut rt.cast_object_ptr[Class_SimplePie_array](var_links.array_get(rt.new_int(0))))).str()))
		}
		var_links = this.get_channel_tags((Class_SimplePie_SimplePie_SimplePie.namespace_rss_20()).str(), 'link')
		if rt.is_true(var_links) {
			this.data.array_get_mut('links').array_get_mut('alternate').array_push(this.sanitize((var_links.array_get(rt.new_int(0)).array_get(rt.new_string('data'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_iri()).to_i64(), (this.get_base(mut rt.cast_object_ptr[Class_SimplePie_array](var_links.array_get(rt.new_int(0))))).str()))
		}
		mut var_keys := rt.func_array_keys(this.data.array_get(rt.new_string('links')))
		mut iter_20 := var_keys.iterator()
		for {
			item_20 := iter_20.next() or { break }
			mut var_key := item_20.val
			if rt.is_true(rt.call_method(this.registry, 'call', [Class_SimplePie_Misc.class(), rt.new_string('is_isegment_nz_nc'), rt.create_array([rt.ArrayItem{ key: none, val: var_key }])])) {
				if this.data.array_get(rt.new_string('links')).array_isset((Class_SimplePie_SimplePie_SimplePie.iana_link_relations_registry()).str() + (var_key).str()) {
					this.data.array_get_mut('links').array_set((Class_SimplePie_SimplePie_SimplePie.iana_link_relations_registry()).str() + (var_key).str(), rt.call_function('array_merge', [this.data.array_get(rt.new_string('links')).array_get(var_key), this.data.array_get(rt.new_string('links')).array_get(rt.new_string((Class_SimplePie_SimplePie_SimplePie.iana_link_relations_registry()).str() + (var_key).str()))]))
					this.data.array_get(rt.new_string('links')).array_get(var_key) = this.data.array_get(rt.new_string('links')).array_get(rt.new_string((Class_SimplePie_SimplePie_SimplePie.iana_link_relations_registry()).str() + (var_key).str()))
				} else {
					this.data.array_get(rt.new_string('links')).array_get(rt.new_string((Class_SimplePie_SimplePie_SimplePie.iana_link_relations_registry()).str() + (var_key).str())) = this.data.array_get(rt.new_string('links')).array_get(var_key)
				}
			} else if rt.is_true(rt.identical(rt.call_function('substr', [var_key.clone(), rt.new_int(0), rt.new_int(41)]), Class_SimplePie_SimplePie_SimplePie.iana_link_relations_registry())) {
				this.data.array_get(rt.new_string('links')).array_get(rt.call_function('substr', [var_key.clone(), rt.new_int(41)])) = this.data.array_get(rt.new_string('links')).array_get(var_key)
			}
			this.data.array_get_mut('links').array_set(var_key, rt.call_function('array_unique', [this.data.array_get(rt.new_string('links')).array_get(var_key)]))
		}
	}
	if this.data.array_get(rt.new_string('headers')).array_isset(rt.new_string('link')) {
		mut var_link_headers := this.data.array_get(rt.new_string('headers')).array_get(rt.new_string('link'))
		if rt.is_true(rt.new_bool(var_link_headers.clone().is_array())) {
		var_link_headers = rt.call_function('implode', [rt.new_string(','), var_link_headers.clone()])
		}
		if var_link_headers.clone().is_string() && rt.is_true(rt.call_function('preg_match_all', [rt.new_string('/<(?P<uri>[^>]+)>\\s*;\\s*rel\\s*=\\s*(?P<quote>"?)' + (rt.call_function('preg_quote', [rt.new_string(rel)])).str() + '(?P=quote)\\s*(?=,|$)/i'), var_link_headers.clone(), var_matches.clone()])) {
			return var_matches.array_get(rt.new_string('uri'))
		}
	}
	if this.data.array_get(rt.new_string('links')).array_isset(rt.new_string(rel)) {
		return this.data.array_get(rt.new_string('links')).array_get(rt.new_string(rel))
	}
	return rt.new_null()
}

fn (mut this Class_SimplePie_SimplePie) get_all_discovered_feeds() rt.PhpVal {
	return this.all_discovered_feeds
}

fn (mut this Class_SimplePie_SimplePie) get_description() rt.PhpVal {
	mut var_return := this.get_channel_tags((Class_SimplePie_SimplePie_SimplePie.namespace_atom_10()).str(), 'subtitle')
	if rt.is_true(var_return) {
		return rt.new_string(this.sanitize((var_return.array_get(rt.new_int(0)).array_get(rt.new_string('data'))).str(), (rt.call_method(this.registry, 'call', [Class_SimplePie_Misc.class(), rt.new_string('atom_10_construct_type'), rt.create_array([rt.ArrayItem{ key: none, val: var_return.array_get(rt.new_int(0)).array_get(rt.new_string('attribs')) }])])).to_i64(), (this.get_base(mut rt.cast_object_ptr[Class_SimplePie_array](var_return.array_get(rt.new_int(0))))).str()))
	var_return = this.get_channel_tags((Class_SimplePie_SimplePie_SimplePie.namespace_atom_03()).str(), 'tagline')
	} else if rt.is_true(var_return) {
		return rt.new_string(this.sanitize((var_return.array_get(rt.new_int(0)).array_get(rt.new_string('data'))).str(), (rt.call_method(this.registry, 'call', [Class_SimplePie_Misc.class(), rt.new_string('atom_03_construct_type'), rt.create_array([rt.ArrayItem{ key: none, val: var_return.array_get(rt.new_int(0)).array_get(rt.new_string('attribs')) }])])).to_i64(), (this.get_base(mut rt.cast_object_ptr[Class_SimplePie_array](var_return.array_get(rt.new_int(0))))).str()))
	var_return = this.get_channel_tags((Class_SimplePie_SimplePie_SimplePie.namespace_rss_10()).str(), 'description')
	} else if rt.is_true(var_return) {
		return rt.new_string(this.sanitize((var_return.array_get(rt.new_int(0)).array_get(rt.new_string('data'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_maybe_html()).to_i64(), (this.get_base(mut rt.cast_object_ptr[Class_SimplePie_array](var_return.array_get(rt.new_int(0))))).str()))
	var_return = this.get_channel_tags((Class_SimplePie_SimplePie_SimplePie.namespace_rss_090()).str(), 'description')
	} else if rt.is_true(var_return) {
		return rt.new_string(this.sanitize((var_return.array_get(rt.new_int(0)).array_get(rt.new_string('data'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_maybe_html()).to_i64(), (this.get_base(mut rt.cast_object_ptr[Class_SimplePie_array](var_return.array_get(rt.new_int(0))))).str()))
	var_return = this.get_channel_tags((Class_SimplePie_SimplePie_SimplePie.namespace_rss_20()).str(), 'description')
	} else if rt.is_true(var_return) {
		return rt.new_string(this.sanitize((var_return.array_get(rt.new_int(0)).array_get(rt.new_string('data'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_html()).to_i64(), (this.get_base(mut rt.cast_object_ptr[Class_SimplePie_array](var_return.array_get(rt.new_int(0))))).str()))
	var_return = this.get_channel_tags((Class_SimplePie_SimplePie_SimplePie.namespace_dc_11()).str(), 'description')
	} else if rt.is_true(var_return) {
		return rt.new_string(this.sanitize((var_return.array_get(rt.new_int(0)).array_get(rt.new_string('data'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), ''))
	var_return = this.get_channel_tags((Class_SimplePie_SimplePie_SimplePie.namespace_dc_10()).str(), 'description')
	} else if rt.is_true(var_return) {
		return rt.new_string(this.sanitize((var_return.array_get(rt.new_int(0)).array_get(rt.new_string('data'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), ''))
	var_return = this.get_channel_tags((Class_SimplePie_SimplePie_SimplePie.namespace_itunes()).str(), 'summary')
	} else if rt.is_true(var_return) {
		return rt.new_string(this.sanitize((var_return.array_get(rt.new_int(0)).array_get(rt.new_string('data'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_html()).to_i64(), (this.get_base(mut rt.cast_object_ptr[Class_SimplePie_array](var_return.array_get(rt.new_int(0))))).str()))
	var_return = this.get_channel_tags((Class_SimplePie_SimplePie_SimplePie.namespace_itunes()).str(), 'subtitle')
	} else if rt.is_true(var_return) {
		return rt.new_string(this.sanitize((var_return.array_get(rt.new_int(0)).array_get(rt.new_string('data'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_html()).to_i64(), (this.get_base(mut rt.cast_object_ptr[Class_SimplePie_array](var_return.array_get(rt.new_int(0))))).str()))
	}
	return rt.new_null()
}

fn (mut this Class_SimplePie_SimplePie) get_copyright() rt.PhpVal {
	mut var_return := this.get_channel_tags((Class_SimplePie_SimplePie_SimplePie.namespace_atom_10()).str(), 'rights')
	if rt.is_true(var_return) {
		return rt.new_string(this.sanitize((var_return.array_get(rt.new_int(0)).array_get(rt.new_string('data'))).str(), (rt.call_method(this.registry, 'call', [Class_SimplePie_Misc.class(), rt.new_string('atom_10_construct_type'), rt.create_array([rt.ArrayItem{ key: none, val: var_return.array_get(rt.new_int(0)).array_get(rt.new_string('attribs')) }])])).to_i64(), (this.get_base(mut rt.cast_object_ptr[Class_SimplePie_array](var_return.array_get(rt.new_int(0))))).str()))
	var_return = this.get_channel_tags((Class_SimplePie_SimplePie_SimplePie.namespace_atom_03()).str(), 'copyright')
	} else if rt.is_true(var_return) {
		return rt.new_string(this.sanitize((var_return.array_get(rt.new_int(0)).array_get(rt.new_string('data'))).str(), (rt.call_method(this.registry, 'call', [Class_SimplePie_Misc.class(), rt.new_string('atom_03_construct_type'), rt.create_array([rt.ArrayItem{ key: none, val: var_return.array_get(rt.new_int(0)).array_get(rt.new_string('attribs')) }])])).to_i64(), (this.get_base(mut rt.cast_object_ptr[Class_SimplePie_array](var_return.array_get(rt.new_int(0))))).str()))
	var_return = this.get_channel_tags((Class_SimplePie_SimplePie_SimplePie.namespace_rss_20()).str(), 'copyright')
	} else if rt.is_true(var_return) {
		return rt.new_string(this.sanitize((var_return.array_get(rt.new_int(0)).array_get(rt.new_string('data'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), ''))
	var_return = this.get_channel_tags((Class_SimplePie_SimplePie_SimplePie.namespace_dc_11()).str(), 'rights')
	} else if rt.is_true(var_return) {
		return rt.new_string(this.sanitize((var_return.array_get(rt.new_int(0)).array_get(rt.new_string('data'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), ''))
	var_return = this.get_channel_tags((Class_SimplePie_SimplePie_SimplePie.namespace_dc_10()).str(), 'rights')
	} else if rt.is_true(var_return) {
		return rt.new_string(this.sanitize((var_return.array_get(rt.new_int(0)).array_get(rt.new_string('data'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), ''))
	}
	return rt.new_null()
}

fn (mut this Class_SimplePie_SimplePie) get_language() rt.PhpVal {
	mut var_return := this.get_channel_tags((Class_SimplePie_SimplePie_SimplePie.namespace_rss_20()).str(), 'language')
	if rt.is_true(var_return) {
		return rt.new_string(this.sanitize((var_return.array_get(rt.new_int(0)).array_get(rt.new_string('data'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), ''))
	var_return = this.get_channel_tags((Class_SimplePie_SimplePie_SimplePie.namespace_dc_11()).str(), 'language')
	} else if rt.is_true(var_return) {
		return rt.new_string(this.sanitize((var_return.array_get(rt.new_int(0)).array_get(rt.new_string('data'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), ''))
	var_return = this.get_channel_tags((Class_SimplePie_SimplePie_SimplePie.namespace_dc_10()).str(), 'language')
	} else if rt.is_true(var_return) {
		return rt.new_string(this.sanitize((var_return.array_get(rt.new_int(0)).array_get(rt.new_string('data'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), ''))
	} else if this.data.array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_atom_10()).array_get(rt.new_string('feed')).array_get(rt.new_int(0)).array_isset(rt.new_string('xml_lang')) {
		return rt.new_string(this.sanitize((this.data.array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_atom_10()).array_get(rt.new_string('feed')).array_get(rt.new_int(0)).array_get(rt.new_string('xml_lang'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), ''))
	} else if this.data.array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_atom_03()).array_get(rt.new_string('feed')).array_get(rt.new_int(0)).array_isset(rt.new_string('xml_lang')) {
		return rt.new_string(this.sanitize((this.data.array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_atom_03()).array_get(rt.new_string('feed')).array_get(rt.new_int(0)).array_get(rt.new_string('xml_lang'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), ''))
	} else if this.data.array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_rdf()).array_get(rt.new_string('RDF')).array_get(rt.new_int(0)).array_isset(rt.new_string('xml_lang')) {
		return rt.new_string(this.sanitize((this.data.array_get(rt.new_string('child')).array_get(Class_SimplePie_SimplePie_SimplePie.namespace_rdf()).array_get(rt.new_string('RDF')).array_get(rt.new_int(0)).array_get(rt.new_string('xml_lang'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), ''))
	} else if this.data.array_get(rt.new_string('headers')).array_isset(rt.new_string('content-language')) {
		return rt.new_string(this.sanitize((this.data.array_get(rt.new_string('headers')).array_get(rt.new_string('content-language'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), ''))
	}
	return rt.new_null()
}

fn (mut this Class_SimplePie_SimplePie) get_latitude() rt.PhpVal {
	mut var_match := rt.new_null()
	mut var_return := this.get_channel_tags((Class_SimplePie_SimplePie_SimplePie.namespace_w3c_basic_geo()).str(), 'lat')
	if rt.is_true(var_return) {
		return rt.new_float((var_return.array_get(rt.new_int(0)).array_get(rt.new_string('data'))).to_f64())
	var_return = this.get_channel_tags((Class_SimplePie_SimplePie_SimplePie.namespace_georss()).str(), 'point')
	} else if rt.is_true(var_return) && rt.is_true(rt.call_function('preg_match', [rt.new_string('/^((?:-)?[0-9]+(?:\\.[0-9]+)) ((?:-)?[0-9]+(?:\\.[0-9]+))$/'), rt.new_string(var_return.array_get(rt.new_int(0)).array_get(rt.new_string('data')).to_string().trim_space()), var_match.clone()])) {
		return rt.new_float((var_match.array_get(rt.new_int(1))).to_f64())
	}
	return rt.new_null()
}

fn (mut this Class_SimplePie_SimplePie) get_longitude() rt.PhpVal {
	mut var_match := rt.new_null()
	mut var_return := this.get_channel_tags((Class_SimplePie_SimplePie_SimplePie.namespace_w3c_basic_geo()).str(), 'long')
	if rt.is_true(var_return) {
		return rt.new_float((var_return.array_get(rt.new_int(0)).array_get(rt.new_string('data'))).to_f64())
	var_return = this.get_channel_tags((Class_SimplePie_SimplePie_SimplePie.namespace_w3c_basic_geo()).str(), 'lon')
	} else if rt.is_true(var_return) {
		return rt.new_float((var_return.array_get(rt.new_int(0)).array_get(rt.new_string('data'))).to_f64())
	var_return = this.get_channel_tags((Class_SimplePie_SimplePie_SimplePie.namespace_georss()).str(), 'point')
	} else if rt.is_true(var_return) && rt.is_true(rt.call_function('preg_match', [rt.new_string('/^((?:-)?[0-9]+(?:\\.[0-9]+)) ((?:-)?[0-9]+(?:\\.[0-9]+))$/'), rt.new_string(var_return.array_get(rt.new_int(0)).array_get(rt.new_string('data')).to_string().trim_space()), var_match.clone()])) {
		return rt.new_float((var_match.array_get(rt.new_int(2))).to_f64())
	}
	return rt.new_null()
}

fn (mut this Class_SimplePie_SimplePie) get_image_title() rt.PhpVal {
	mut var_return := this.get_image_tags((Class_SimplePie_SimplePie_SimplePie.namespace_rss_10()).str(), 'title')
	if rt.is_true(var_return) {
		return rt.new_string(this.sanitize((var_return.array_get(rt.new_int(0)).array_get(rt.new_string('data'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), ''))
	var_return = this.get_image_tags((Class_SimplePie_SimplePie_SimplePie.namespace_rss_090()).str(), 'title')
	} else if rt.is_true(var_return) {
		return rt.new_string(this.sanitize((var_return.array_get(rt.new_int(0)).array_get(rt.new_string('data'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), ''))
	var_return = this.get_image_tags((Class_SimplePie_SimplePie_SimplePie.namespace_rss_20()).str(), 'title')
	} else if rt.is_true(var_return) {
		return rt.new_string(this.sanitize((var_return.array_get(rt.new_int(0)).array_get(rt.new_string('data'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), ''))
	var_return = this.get_image_tags((Class_SimplePie_SimplePie_SimplePie.namespace_dc_11()).str(), 'title')
	} else if rt.is_true(var_return) {
		return rt.new_string(this.sanitize((var_return.array_get(rt.new_int(0)).array_get(rt.new_string('data'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), ''))
	var_return = this.get_image_tags((Class_SimplePie_SimplePie_SimplePie.namespace_dc_10()).str(), 'title')
	} else if rt.is_true(var_return) {
		return rt.new_string(this.sanitize((var_return.array_get(rt.new_int(0)).array_get(rt.new_string('data'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_text()).to_i64(), ''))
	}
	return rt.new_null()
}

fn (mut this Class_SimplePie_SimplePie) get_image_url() rt.PhpVal {
	mut var_return := this.get_channel_tags((Class_SimplePie_SimplePie_SimplePie.namespace_itunes()).str(), 'image')
	if rt.is_true(var_return) {
		return rt.new_string(this.sanitize((var_return.array_get(rt.new_int(0)).array_get(rt.new_string('attribs')).array_get(rt.new_string('')).array_get(rt.new_string('href'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_iri()).to_i64(), ''))
	var_return = this.get_channel_tags((Class_SimplePie_SimplePie_SimplePie.namespace_atom_10()).str(), 'logo')
	} else if rt.is_true(var_return) {
		return rt.new_string(this.sanitize((var_return.array_get(rt.new_int(0)).array_get(rt.new_string('data'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_iri()).to_i64(), (this.get_base(mut rt.cast_object_ptr[Class_SimplePie_array](var_return.array_get(rt.new_int(0))))).str()))
	var_return = this.get_channel_tags((Class_SimplePie_SimplePie_SimplePie.namespace_atom_10()).str(), 'icon')
	} else if rt.is_true(var_return) {
		return rt.new_string(this.sanitize((var_return.array_get(rt.new_int(0)).array_get(rt.new_string('data'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_iri()).to_i64(), (this.get_base(mut rt.cast_object_ptr[Class_SimplePie_array](var_return.array_get(rt.new_int(0))))).str()))
	var_return = this.get_image_tags((Class_SimplePie_SimplePie_SimplePie.namespace_rss_10()).str(), 'url')
	} else if rt.is_true(var_return) {
		return rt.new_string(this.sanitize((var_return.array_get(rt.new_int(0)).array_get(rt.new_string('data'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_iri()).to_i64(), (this.get_base(mut rt.cast_object_ptr[Class_SimplePie_array](var_return.array_get(rt.new_int(0))))).str()))
	var_return = this.get_image_tags((Class_SimplePie_SimplePie_SimplePie.namespace_rss_090()).str(), 'url')
	} else if rt.is_true(var_return) {
		return rt.new_string(this.sanitize((var_return.array_get(rt.new_int(0)).array_get(rt.new_string('data'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_iri()).to_i64(), (this.get_base(mut rt.cast_object_ptr[Class_SimplePie_array](var_return.array_get(rt.new_int(0))))).str()))
	var_return = this.get_image_tags((Class_SimplePie_SimplePie_SimplePie.namespace_rss_20()).str(), 'url')
	} else if rt.is_true(var_return) {
		return rt.new_string(this.sanitize((var_return.array_get(rt.new_int(0)).array_get(rt.new_string('data'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_iri()).to_i64(), (this.get_base(mut rt.cast_object_ptr[Class_SimplePie_array](var_return.array_get(rt.new_int(0))))).str()))
	}
	return rt.new_null()
}

fn (mut this Class_SimplePie_SimplePie) get_image_link() rt.PhpVal {
	mut var_return := this.get_image_tags((Class_SimplePie_SimplePie_SimplePie.namespace_rss_10()).str(), 'link')
	if rt.is_true(var_return) {
		return rt.new_string(this.sanitize((var_return.array_get(rt.new_int(0)).array_get(rt.new_string('data'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_iri()).to_i64(), (this.get_base(mut rt.cast_object_ptr[Class_SimplePie_array](var_return.array_get(rt.new_int(0))))).str()))
	var_return = this.get_image_tags((Class_SimplePie_SimplePie_SimplePie.namespace_rss_090()).str(), 'link')
	} else if rt.is_true(var_return) {
		return rt.new_string(this.sanitize((var_return.array_get(rt.new_int(0)).array_get(rt.new_string('data'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_iri()).to_i64(), (this.get_base(mut rt.cast_object_ptr[Class_SimplePie_array](var_return.array_get(rt.new_int(0))))).str()))
	var_return = this.get_image_tags((Class_SimplePie_SimplePie_SimplePie.namespace_rss_20()).str(), 'link')
	} else if rt.is_true(var_return) {
		return rt.new_string(this.sanitize((var_return.array_get(rt.new_int(0)).array_get(rt.new_string('data'))).str(), (Class_SimplePie_SimplePie_SimplePie.construct_iri()).to_i64(), (this.get_base(mut rt.cast_object_ptr[Class_SimplePie_array](var_return.array_get(rt.new_int(0))))).str()))
	}
	return rt.new_null()
}

fn (mut this Class_SimplePie_SimplePie) get_image_width() rt.PhpVal {
	mut var_return := this.get_image_tags((Class_SimplePie_SimplePie_SimplePie.namespace_rss_20()).str(), 'width')
	if rt.is_true(var_return) {
		return rt.new_int(var_return.array_get(rt.new_int(0)).array_get(rt.new_string('data')).to_i64())
	} else if rt.is_true(rt.bitwise_and(this.get_type(), Class_SimplePie_SimplePie_SimplePie.type_rss_syndication())) && rt.is_true(this.get_image_tags((Class_SimplePie_SimplePie_SimplePie.namespace_rss_20()).str(), 'url')) {
		return rt.new_int(88)
	}
	return rt.new_null()
}

fn (mut this Class_SimplePie_SimplePie) get_image_height() rt.PhpVal {
	mut var_return := this.get_image_tags((Class_SimplePie_SimplePie_SimplePie.namespace_rss_20()).str(), 'height')
	if rt.is_true(var_return) {
		return rt.new_int(var_return.array_get(rt.new_int(0)).array_get(rt.new_string('data')).to_i64())
	} else if rt.is_true(rt.bitwise_and(this.get_type(), Class_SimplePie_SimplePie_SimplePie.type_rss_syndication())) && rt.is_true(this.get_image_tags((Class_SimplePie_SimplePie_SimplePie.namespace_rss_20()).str(), 'url')) {
		return rt.new_int(31)
	}
	return rt.new_null()
}

fn (mut this Class_SimplePie_SimplePie) get_item_quantity(max i64) rt.PhpVal {
	mut var_qty := rt.new_int(this.get_items(0, 0).array_count())
	if max == 0 {
		return var_qty.clone()
	}
	return rt.call_function('min', [var_qty.clone(), rt.new_int(max)])
}

fn (mut this Class_SimplePie_SimplePie) get_item(key i64) rt.PhpVal {
	mut var_items := this.get_items(0, 0)
	if var_items.array_isset(rt.new_int(key)) {
		return var_items.array_get(rt.new_int(key))
	}
	return rt.new_null()
}

fn (mut this Class_SimplePie_SimplePie) get_items(start i64, end i64) rt.PhpVal {
	if !(this.data.array_isset(rt.new_string('items'))) {
		if !(!rt.is_true(this.multifeed_objects)) {
			this.data.array_set('items', Class_SimplePie_SimplePie.merge_items(mut rt.cast_object_ptr[Class_SimplePie_array](this.multifeed_objects), start, end, (this.item_limit).to_i64()))
			if !rt.is_true(this.data.array_get(rt.new_string('items'))) {
				return rt.new_array()
			}
			return this.data.array_get(rt.new_string('items'))
		}
		this.data.array_set('items', rt.new_array())
		mut var_items := this.get_feed_tags((Class_SimplePie_SimplePie_SimplePie.namespace_atom_10()).str(), 'entry')
		if rt.is_true(var_items) {
			mut var_keys := rt.func_array_keys(var_items.clone())
			mut iter_21 := var_keys.iterator()
			for {
				item_21 := iter_21.next() or { break }
				mut var_key := item_21.val
				this.data.array_get_mut('items').array_push(this.make_item(mut rt.cast_object_ptr[Class_SimplePie_array](var_items.array_get(var_key))))
			}
		}
		var_items = this.get_feed_tags((Class_SimplePie_SimplePie_SimplePie.namespace_atom_03()).str(), 'entry')
		if rt.is_true(var_items) {
			var_keys = rt.func_array_keys(var_items.clone())
			mut iter_22 := var_keys.iterator()
			for {
				item_22 := iter_22.next() or { break }
				mut var_key := item_22.val
				this.data.array_get_mut('items').array_push(this.make_item(mut rt.cast_object_ptr[Class_SimplePie_array](var_items.array_get(var_key))))
			}
		}
		var_items = this.get_feed_tags((Class_SimplePie_SimplePie_SimplePie.namespace_rss_10()).str(), 'item')
		if rt.is_true(var_items) {
			var_keys = rt.func_array_keys(var_items.clone())
			mut iter_23 := var_keys.iterator()
			for {
				item_23 := iter_23.next() or { break }
				mut var_key := item_23.val
				this.data.array_get_mut('items').array_push(this.make_item(mut rt.cast_object_ptr[Class_SimplePie_array](var_items.array_get(var_key))))
			}
		}
		var_items = this.get_feed_tags((Class_SimplePie_SimplePie_SimplePie.namespace_rss_090()).str(), 'item')
		if rt.is_true(var_items) {
			var_keys = rt.func_array_keys(var_items.clone())
			mut iter_24 := var_keys.iterator()
			for {
				item_24 := iter_24.next() or { break }
				mut var_key := item_24.val
				this.data.array_get_mut('items').array_push(this.make_item(mut rt.cast_object_ptr[Class_SimplePie_array](var_items.array_get(var_key))))
			}
		}
		var_items = this.get_channel_tags((Class_SimplePie_SimplePie_SimplePie.namespace_rss_20()).str(), 'item')
		if rt.is_true(var_items) {
			var_keys = rt.func_array_keys(var_items.clone())
			mut iter_25 := var_keys.iterator()
			for {
				item_25 := iter_25.next() or { break }
				mut var_key := item_25.val
				this.data.array_get_mut('items').array_push(this.make_item(mut rt.cast_object_ptr[Class_SimplePie_array](var_items.array_get(var_key))))
			}
		}
	}
	if !rt.is_true(this.data.array_get(rt.new_string('items'))) {
		return rt.new_array()
	}
	if rt.is_true(this.order_by_date) {
		if !(this.data.array_isset(rt.new_string('ordered_items'))) {
			this.data.array_set('ordered_items', this.data.array_get(rt.new_string('items')))
			rt.call_function('usort', [this.data.array_get(rt.new_string('ordered_items')), rt.create_array([rt.ArrayItem{ key: none, val: rt.call_function('get_class', [rt.new_object('SimplePie_SimplePie', []string{}, &this)]) }, rt.ArrayItem{ key: none, val: 'sort_items' }])])
		}
	var_items = this.data.array_get(rt.new_string('ordered_items'))
	} else {
	var_items = this.data.array_get(rt.new_string('items'))
	}
	if end == 0 {
		return rt.call_function('array_slice', [var_items.clone(), rt.new_int(start)])
	}
	return rt.call_function('array_slice', [var_items.clone(), rt.new_int(start), rt.new_int(end)])
}

fn (mut this Class_SimplePie_SimplePie) set_favicon_handler(page bool, qs string) bool {
	rt.call_function('trigger_error', [rt.new_string('Favicon handling has been removed since SimplePie 1.3, please use your own handling'), rt.get_constant('E_USER_DEPRECATED')])
	return false
}

fn (mut this Class_SimplePie_SimplePie) get_favicon() rt.PhpVal {
	rt.call_function('trigger_error', [rt.new_string('Favicon handling has been removed since SimplePie 1.3, please use your own handling'), rt.get_constant('E_USER_DEPRECATED')])
	mut var_url := this.get_link(0, '')
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_url, rt.new_null())))) {
		return rt.new_string('https://www.google.com/s2/favicons?domain=' + (rt.call_function('urlencode', [var_url.clone()])).str())
	}
	return rt.new_bool(false)
}

fn (mut this Class_SimplePie_SimplePie) magic_call(method string, mut var_args Class_SimplePie_array) rt.PhpVal {
	mut var_args_mutated := var_args
	if rt.is_true(rt.identical(rt.call_function('strpos', [rt.new_string(method), rt.new_string('subscribe_')]), rt.new_int(0))) {
		rt.call_function('trigger_error', [rt.new_string('subscribe_*() has been deprecated since SimplePie 1.3, implement the callback yourself'), rt.get_constant('E_USER_DEPRECATED')])
		return rt.new_string('')
	}
	if rt.is_true(rt.identical(rt.new_string(method), rt.new_string('enable_xml_dump'))) {
		rt.call_function('trigger_error', [rt.new_string('enable_xml_dump() has been deprecated since SimplePie 1.3, use get_raw_data() instead'), rt.get_constant('E_USER_DEPRECATED')])
		return rt.new_bool(false)
	}
	mut var_class := rt.call_function('get_class', [rt.new_object('SimplePie_SimplePie', []string{}, &this)])
	mut var_trace := rt.call_function('debug_backtrace', []rt.PhpVal{})
	mut var_file := if !(var_trace.array_get(rt.new_int(0)).array_get(rt.new_string('file'))).is_null() { var_trace.array_get(rt.new_int(0)).array_get(rt.new_string('file')) } else { rt.new_string('') }
	mut var_line := if !(var_trace.array_get(rt.new_int(0)).array_get(rt.new_string('line'))).is_null() { var_trace.array_get(rt.new_int(0)).array_get(rt.new_string('line')) } else { rt.new_string('') }
	rt.throw_exception(rt.new_object('SimplePie_Exception', []string{}, create_simplepie_exception(rt.new_string("Call to undefined method ${var_class.to_string()}::${var_method}() in ${var_file.to_string()} on line ${var_line.to_string()}"))))
	return rt.new_null()
}

fn (mut this Class_SimplePie_SimplePie) make_item(mut var_data Class_SimplePie_array) rt.PhpVal {
	mut var_item := rt.call_method(this.registry, 'create', [Class_SimplePie_Item.class(), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('SimplePie_SimplePie', []string{}, &this) }, rt.ArrayItem{ key: none, val: var_data }])])
	rt.call_method(var_item, 'set_sanitize', [this.sanitize])
	return var_item.clone()
}

fn Class_SimplePie_SimplePie.sort_items(mut var_a Class_SimplePie_Item, mut var_b Class_SimplePie_Item) i64 {
	mut var_a_date := var_a.get_date(rt.new_string('U'))
	mut var_b_date := var_b.get_date(rt.new_string('U'))
	if rt.is_true(var_a_date) && rt.is_true(var_b_date) {
		return if rt.is_true(rt.greater(var_a_date, var_b_date)) { -1 } else { 1 }
	}
	if rt.is_true(var_a_date) {
		return 1
	}
	if rt.is_true(var_b_date) {
		return -1
	}
	return 0
}

fn Class_SimplePie_SimplePie.merge_items(mut var_urls Class_SimplePie_array, start i64, end i64, limit i64) rt.PhpVal {
	if var_urls.array_count() > 0 {
		mut var_items := rt.new_array()
		mut iter_26 := var_urls.iterator()
		for {
			item_26 := iter_26.next() or { break }
			mut var_arg := item_26.val
			if rt.is_true(rt.new_bool(rt.instance_of(var_arg, 'SimplePie_SimplePie'))) {
			var_items = rt.call_function('array_merge', [var_items.clone(), rt.call_method(var_arg, 'get_items', [rt.new_int(0), rt.new_int(limit)])])
			} else {
				rt.call_function('trigger_error', [rt.new_string('Arguments must be SimplePie objects'), rt.get_constant('E_USER_WARNING')])
			}
		}
		rt.call_function('usort', [var_items.clone(), rt.create_array([rt.ArrayItem{ key: none, val: rt.call_function('get_class', [var_urls.array_get(rt.new_int(0))]) }, rt.ArrayItem{ key: none, val: 'sort_items' }])])
		if end == 0 {
			return rt.call_function('array_slice', [var_items.clone(), rt.new_int(start)])
		}
		return rt.call_function('array_slice', [var_items.clone(), rt.new_int(start), rt.new_int(end)])
	}
	rt.call_function('trigger_error', [rt.new_string('Cannot merge zero SimplePie objects'), rt.get_constant('E_USER_WARNING')])
	return rt.new_array()
}

fn (mut this Class_SimplePie_SimplePie) store_links(mut var_file Class_SimplePie_HTTP_Response, mut var_hub Class_SimplePie_?string, mut var_self Class_SimplePie_?string) rt.PhpVal {
	mut var_file_mutated := var_file
	mut var_hub_mutated := var_hub
	mut var_self_mutated := var_self
	mut var_linkHeaderLine := rt.call_method(var_file_mutated, 'get_header_line', [rt.new_string('link')])
	mut var_linkHeader := rt.call_method(var_file_mutated, 'get_header', [rt.new_string('link')])
	if rt.is_true(var_hub_mutated) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('preg_match', [rt.new_string('/rel=hub/'), var_linkHeaderLine.clone()]))))) {
		var_linkHeader.array_push('<' + (var_hub_mutated).str() + '>; rel=hub')
	}
	if rt.is_true(var_self_mutated) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('preg_match', [rt.new_string('/rel=self/'), var_linkHeaderLine.clone()]))))) {
		var_linkHeader.array_push('<' + (var_self_mutated).str() + '>; rel=self')
	}
	if var_linkHeader.clone().array_count() > 0 {
	var_file_mutated = rt.call_method(var_file_mutated, 'with_header', [rt.new_string('link'), var_linkHeader.clone()])
	}
	return rt.new_object('SimplePie_HTTP_Response', []string{}, var_file_mutated)
}

fn (mut this Class_SimplePie_SimplePie) get_cache(feed_url string) rt.PhpVal {
	if rt.is_true(rt.identical(this.cache, rt.new_null())) {
		mut var_cache := rt.call_method(this.registry, 'call', [Class_SimplePie_Cache.class(), rt.new_string('get_handler'), rt.create_array([rt.ArrayItem{ key: none, val: this.cache_location }, rt.ArrayItem{ key: none, val: this.get_cache_filename(feed_url) }, rt.ArrayItem{ key: none, val: Class_SimplePie_Cache_Base.type_feed() }])])
		return rt.new_object('SimplePie_Cache_BaseDataCache', []string{}, create_simplepie_cache_basedatacache(var_cache.clone()))
	}
	return this.cache
}

fn (mut this Class_SimplePie_SimplePie) get_http_client() rt.PhpVal {
	if rt.is_true(rt.identical(this.http_client, rt.new_null())) {
		this.http_client = create_simplepie_http_fileclient(this.get_registry(), rt.create_array([rt.ArrayItem{ key: 'timeout', val: this.timeout }, rt.ArrayItem{ key: 'redirects', val: 5 }, rt.ArrayItem{ key: 'useragent', val: this.useragent }, rt.ArrayItem{ key: 'force_fsockopen', val: this.force_fsockopen }, rt.ArrayItem{ key: 'curl_options', val: this.curl_options }]))
		this.http_client_injected = true
	}
	return this.http_client
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

struct Class_SimplePie_Misc {
	rt.PhpObjectBase
}

struct Class_SimplePie_Cache_BaseDataCache {
	rt.PhpObjectBase
}

struct Class_InvalidArgumentException {
	rt.PhpObjectBase
}

struct Class_SimplePie_File {
	rt.PhpObjectBase
}

struct Class_SimplePie_DOMDocument {
	rt.PhpObjectBase
}

struct Class_SimplePie_DOMXpath {
	rt.PhpObjectBase
}

struct Class_SimplePie_HTTP_FileClient {
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

fn create_simplepie_cache_callablenamefilter(_args ...rt.PhpVal) &Class_SimplePie_Cache_CallableNameFilter {
	mut obj := &Class_SimplePie_Cache_CallableNameFilter{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_simplepie_sanitize(_args ...rt.PhpVal) &Class_SimplePie_Sanitize {
	mut obj := &Class_SimplePie_Sanitize{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_simplepie_registry(_args ...rt.PhpVal) &Class_SimplePie_Registry {
	mut obj := &Class_SimplePie_Registry{
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

fn create_simplepie_exception(_args ...rt.PhpVal) &Class_SimplePie_Exception {
	mut obj := &Class_SimplePie_Exception{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_simplepie_cache_psr16(_args ...rt.PhpVal) &Class_SimplePie_Cache_Psr16 {
	mut obj := &Class_SimplePie_Cache_Psr16{
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

fn create_simplepie_cache_basedatacache(_args ...rt.PhpVal) &Class_SimplePie_Cache_BaseDataCache {
	mut obj := &Class_SimplePie_Cache_BaseDataCache{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_invalidargumentexception(_args ...rt.PhpVal) &Class_InvalidArgumentException {
	mut obj := &Class_InvalidArgumentException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_simplepie_file(_args ...rt.PhpVal) &Class_SimplePie_File {
	mut obj := &Class_SimplePie_File{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_simplepie_domdocument(_args ...rt.PhpVal) &Class_SimplePie_DOMDocument {
	mut obj := &Class_SimplePie_DOMDocument{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_simplepie_domxpath(_args ...rt.PhpVal) &Class_SimplePie_DOMXpath {
	mut obj := &Class_SimplePie_DOMXpath{
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
			return rt.new_string(this.sanitize(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2))
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


fn (mut this Class_SimplePie_Misc) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_SimplePie_Misc) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_SimplePie_Misc) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_InvalidArgumentException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_InvalidArgumentException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_InvalidArgumentException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_SimplePie_File) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_SimplePie_File) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_SimplePie_File) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
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


fn (mut this Class_SimplePie_DOMXpath) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_SimplePie_DOMXpath) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_SimplePie_DOMXpath) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

	rt.call_function('class_alias', [rt.new_string('SimplePie\\SimplePie'), rt.new_string('SimplePie')])
}
