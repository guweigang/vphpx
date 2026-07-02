import rt
import crypto.md5

struct Class_WP_REST_URL_Details_Controller {
	rt.PhpObjectBase
}

fn (mut this Class_WP_REST_URL_Details_Controller) construct() {
	this.dispatch_set_prop('namespace', rt.new_string('wp-block-editor/v1'))
	this.dispatch_set_prop('rest_base', rt.new_string('url-details'))
}

fn (mut this Class_WP_REST_URL_Details_Controller) register_routes() {
	rt.call_function('register_rest_route', [rt.get_property(rt.new_object('WP_REST_URL_Details_Controller', ['WP_REST_Controller'], &this), 'namespace'), rt.new_string('/' + rt.get_property(rt.new_object('WP_REST_URL_Details_Controller', ['WP_REST_Controller'], &this), 'rest_base')), rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_URL_Details_Controller', ['WP_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'parse_url_details' }]) }, rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'url', val: rt.create_array([rt.ArrayItem{ key: 'required', val: true }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('The URL to process.')]) }, rt.ArrayItem{ key: 'validate_callback', val: 'wp_http_validate_url' }, rt.ArrayItem{ key: 'sanitize_callback', val: 'sanitize_url' }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'format', val: 'uri' }]) }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_URL_Details_Controller', ['WP_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'permissions_check' }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_URL_Details_Controller', ['WP_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_public_item_schema' }]) }]) }])])
}

fn (mut this Class_WP_REST_URL_Details_Controller) get_item_schema() rt.PhpVal {
	if rt.is_true(rt.get_property(rt.new_object('WP_REST_URL_Details_Controller', ['WP_REST_Controller'], &this), 'schema')) {
		return this.add_additional_fields_schema(rt.get_property(rt.new_object('WP_REST_URL_Details_Controller', ['WP_REST_Controller'], &this), 'schema'))
	}
	this.dispatch_set_prop('schema', rt.create_array([rt.ArrayItem{ key: '$schema', val: 'http://json-schema.org/draft-04/schema#' }, rt.ArrayItem{ key: 'title', val: 'url-details' }, rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: 'title', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('The contents of the %s element from the URL.')]), rt.new_string('<title>')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }, rt.ArrayItem{ key: none, val: 'embed' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'icon', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('The favicon image link of the %s element from the URL.')]), rt.new_string('<link rel="icon">')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'format', val: 'uri' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }, rt.ArrayItem{ key: none, val: 'embed' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'description', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('The content of the %s element from the URL.')]), rt.new_string('<meta name="description">')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }, rt.ArrayItem{ key: none, val: 'embed' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'image', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('The Open Graph image link of the %1$s or %2$s element from the URL.')]), rt.new_string('<meta property="og:image">'), rt.new_string('<meta property="og:image:url">')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'format', val: 'uri' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }, rt.ArrayItem{ key: none, val: 'embed' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }]) }]))
	return this.add_additional_fields_schema(rt.get_property(rt.new_object('WP_REST_URL_Details_Controller', ['WP_REST_Controller'], &this), 'schema'))
}

fn (mut this Class_WP_REST_URL_Details_Controller) parse_url_details(var_request rt.PhpVal) rt.PhpVal {
	mut var_url := rt.call_function('untrailingslashit', [var_request.array_get(rt.new_string('url'))])
	if !rt.is_true(var_url) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('rest_invalid_url'), rt.call_function('__', [rt.new_string('Invalid URL')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 404 }])))
	}
	mut var_cache_key := rt.new_string(this.build_cache_key_for_url(var_url.clone()))
	mut var_cached_response := this.get_cache(var_cache_key.clone())
	if !(!rt.is_true(var_cached_response)) {
	mut var_remote_url_response := var_cached_response.clone()
	} else {
		var_remote_url_response = this.get_remote_url(var_url.clone())
		if rt.is_true(rt.call_function('is_wp_error', [var_remote_url_response.clone()])) || !rt.is_true(var_remote_url_response) {
			return var_remote_url_response.clone()
		}
		this.set_cache(var_cache_key.clone(), (var_remote_url_response).str())
	}
	mut var_html_head := this.get_document_head(var_remote_url_response.clone())
	mut var_meta_elements := this.get_meta_with_content_elements(var_html_head.clone())
	mut var_data := this.add_additional_fields_to_object(rt.create_array([rt.ArrayItem{ key: 'title', val: this.get_title(var_html_head.clone()) }, rt.ArrayItem{ key: 'icon', val: this.get_icon(var_html_head.clone(), var_url.clone()) }, rt.ArrayItem{ key: 'description', val: this.get_description(var_meta_elements.clone()) }, rt.ArrayItem{ key: 'image', val: this.get_image(var_meta_elements.clone(), var_url.clone()) }]), var_request.clone())
	mut var_response := rt.call_function('rest_ensure_response', [var_data.clone()])
	return rt.call_function('apply_filters', [rt.new_string('rest_prepare_url_details'), var_response.clone(), var_url.clone(), var_request.clone(), var_remote_url_response.clone()])
}

fn (mut this Class_WP_REST_URL_Details_Controller) permissions_check() bool {
	if rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_posts')])) {
		return true
	}
	mut iter_1 := rt.call_function('get_post_types', [rt.create_array([rt.ArrayItem{ key: 'show_in_rest', val: true }]), rt.new_string('objects')]).iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_post_type := item_1.val
		if rt.is_true(rt.call_function('current_user_can', [rt.get_property(rt.get_property(var_post_type, 'cap'), 'edit_posts')])) {
			return true
		}
	}
	return (create_wp_error(rt.new_string('rest_cannot_view_url_details'), rt.call_function('__', [rt.new_string('Sorry, you are not allowed to process remote URLs.')]), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code', []rt.PhpVal{}) }]))).to_bool()
}

fn (mut this Class_WP_REST_URL_Details_Controller) get_remote_url(var_url rt.PhpVal) rt.PhpVal {
	mut var_url_mutated := var_url
	mut var_modified_user_agent := rt.new_string('WP-URLDetails/' + (rt.call_function('get_bloginfo', [rt.new_string('version')])).str() + ' (+' + (rt.call_function('get_bloginfo', [rt.new_string('url')])).str() + ')')
	mut var_args := rt.create_array([rt.ArrayItem{ key: 'limit_response_size', val: rt.mul(rt.new_int(150), rt.get_constant('KB_IN_BYTES')) }, rt.ArrayItem{ key: 'user-agent', val: var_modified_user_agent }])
	var_args = rt.call_function('apply_filters', [rt.new_string('rest_url_details_http_request_args'), var_args.clone(), var_url_mutated.clone()])
	mut var_response := rt.call_function('wp_safe_remote_get', [var_url_mutated.clone(), var_args.clone()])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(Class_WP_Http.ok(), rt.call_function('wp_remote_retrieve_response_code', [var_response.clone()]))))) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('no_response'), rt.call_function('__', [rt.new_string('URL not found. Response returned a non-200 status code for this URL.')]), rt.create_array([rt.ArrayItem{ key: 'status', val: Class_WP_Http.not_found() }])))
	}
	mut var_remote_body := rt.call_function('wp_remote_retrieve_body', [var_response.clone()])
	if !rt.is_true(var_remote_body) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('no_content'), rt.call_function('__', [rt.new_string('Unable to retrieve body from response at this URL.')]), rt.create_array([rt.ArrayItem{ key: 'status', val: Class_WP_Http.not_found() }])))
	}
	return var_remote_body.clone()
}

fn (mut this Class_WP_REST_URL_Details_Controller) get_title(var_html rt.PhpVal) string {
	mut var_match_title := []rt.PhpVal{}
	mut var_pattern := rt.new_string('#<title[^>]*>(.*?)<\\s*/\\s*title>#is')
	rt.call_function('preg_match', [var_pattern.clone(), var_html.clone(), rt.create_array_from_list(var_match_title)])
	if !rt.is_true(var_match_title.array_get(rt.new_int(1))) || !(var_match_title.array_get(rt.new_int(1)).is_string()) {
		return ''
	}
	mut var_title := rt.new_string(var_match_title.array_get(rt.new_int(1)).to_string().trim_space())
	return (this.prepare_metadata_for_output(var_title.clone())).str()
}

fn (mut this Class_WP_REST_URL_Details_Controller) get_icon(var_html rt.PhpVal, var_url rt.PhpVal) rt.PhpVal {
	mut var_url_mutated := var_url
	mut var_pattern := rt.new_string('#<link\\s[^>]*rel=(?:[\\"\']??)\\s*(?:icon|shortcut icon|icon shortcut)\\s*(?:[\\"\']??)[^>]*\\/?>#isU')
	rt.call_function('preg_match', [var_pattern.clone(), var_html.clone(), var_element.clone()])
	if !rt.is_true(var_element.array_get(rt.new_int(0))) || !(var_element.array_get(rt.new_int(0)).is_string()) {
		return rt.new_string('')
	}
	mut var_element := rt.new_string(var_element.array_get(rt.new_int(0)).to_string().trim_space())
	var_pattern = rt.new_string('#href=([\\"\']??)([^\\" >]*?)\\1[^>]*#isU')
	rt.call_function('preg_match', [var_pattern.clone(), var_element.clone(), var_icon.clone()])
	if !rt.is_true(var_icon.array_get(rt.new_int(2))) || !(var_icon.array_get(rt.new_int(2)).is_string()) {
		return rt.new_string('')
	}
	mut var_icon := rt.new_string(var_icon.array_get(rt.new_int(2)).to_string().trim_space())
	mut var_parsed_icon := rt.call_function('parse_url', [var_icon.clone()])
	if var_parsed_icon.array_isset(rt.new_string('scheme')) && rt.is_true(rt.identical(rt.new_string('data'), var_parsed_icon.array_get(rt.new_string('scheme')))) {
		return var_icon.clone()
	}
	if !(var_url_mutated.clone().is_string()) || rt.is_true(rt.identical(rt.new_string(''), var_url_mutated)) {
		return var_icon.clone()
	}
	mut var_parsed_url := rt.call_function('parse_url', [var_url_mutated.clone()])
	if var_parsed_url.array_isset(rt.new_string('scheme')) && var_parsed_url.array_isset(rt.new_string('host')) {
	mut var_root_url := rt.new_string((var_parsed_url.array_get(rt.new_string('scheme'))).str() + '://' + (var_parsed_url.array_get(rt.new_string('host'))).str() + '/')
	mut iife_temp_0 := Class_WP_Http{}
	mut iife_result_0 := iife_temp_0.make_absolute_url(var_icon.clone(), var_root_url.clone())
	var_icon = iife_result_0
	}
	return var_icon.clone()
}

fn (mut this Class_WP_REST_URL_Details_Controller) get_description(var_meta_elements rt.PhpVal) string {
	mut var_meta_elements_mutated := var_meta_elements
	if !rt.is_true(var_meta_elements_mutated.array_get(rt.new_int(0))) {
		return ''
	}
	mut var_description := rt.new_string(this.get_metadata_from_meta_element(var_meta_elements_mutated.clone(), rt.new_string('name'), rt.new_string('(?:description|og:description)')))
	if rt.is_true(rt.identical(rt.new_string(''), var_description)) {
		return ''
	}
	return (this.prepare_metadata_for_output(var_description.clone())).str()
}

fn (mut this Class_WP_REST_URL_Details_Controller) get_image(var_meta_elements rt.PhpVal, var_url rt.PhpVal) string {
	mut var_meta_elements_mutated := var_meta_elements
	mut var_url_mutated := var_url
	mut var_image := rt.new_string(this.get_metadata_from_meta_element(var_meta_elements_mutated.clone(), rt.new_string('property'), rt.new_string('(?:og:image|og:image:url)')))
	if rt.is_true(rt.identical(rt.new_string(''), var_image)) {
		return ''
	}
	mut var_parsed_url := rt.call_function('parse_url', [var_url_mutated.clone()])
	if var_parsed_url.array_isset(rt.new_string('scheme')) && var_parsed_url.array_isset(rt.new_string('host')) {
	mut var_root_url := rt.new_string((var_parsed_url.array_get(rt.new_string('scheme'))).str() + '://' + (var_parsed_url.array_get(rt.new_string('host'))).str() + '/')
	mut iife_temp_1 := Class_WP_Http{}
	mut iife_result_1 := iife_temp_1.make_absolute_url(var_image.clone(), var_root_url.clone())
	var_image = iife_result_1
	}
	return (var_image).str()
}

fn (mut this Class_WP_REST_URL_Details_Controller) prepare_metadata_for_output(var_metadata rt.PhpVal) rt.PhpVal {
	mut var_metadata_mutated := var_metadata
	var_metadata_mutated = rt.call_function('html_entity_decode', [var_metadata_mutated.clone(), rt.get_constant('ENT_QUOTES'), rt.call_function('get_bloginfo', [rt.new_string('charset')])])
	var_metadata_mutated = rt.call_function('wp_strip_all_tags', [var_metadata_mutated.clone()])
	return var_metadata_mutated.clone()
}

fn (mut this Class_WP_REST_URL_Details_Controller) build_cache_key_for_url(var_url rt.PhpVal) string {
	mut var_url_mutated := var_url
	return 'g_url_details_response_' + md5.hexhash(var_url_mutated.clone().to_string())
}

fn (mut this Class_WP_REST_URL_Details_Controller) get_cache(var_key rt.PhpVal) rt.PhpVal {
	return rt.call_function('get_site_transient', [var_key.clone()])
}

fn (mut this Class_WP_REST_URL_Details_Controller) set_cache(var_key rt.PhpVal, data string) rt.PhpVal {
	mut data_mutated := data
	mut var_ttl := rt.get_constant('HOUR_IN_SECONDS')
	mut var_cache_expiration := rt.call_function('apply_filters', [rt.new_string('rest_url_details_cache_expiration'), var_ttl.clone()])
	return rt.call_function('set_site_transient', [var_key.clone(), rt.new_string(data_mutated).clone(), var_cache_expiration.clone()])
}

fn (mut this Class_WP_REST_URL_Details_Controller) get_document_head(var_html rt.PhpVal) rt.PhpVal {
	mut var_head_html := var_html
	mut var_head_start := rt.call_function('strpos', [var_html.clone(), rt.new_string('<head')])
	if rt.is_true(rt.identical(rt.new_bool(false), var_head_start)) {
		return var_html.clone()
	}
	mut var_head_end := rt.call_function('strpos', [var_head_html.clone(), rt.new_string('</head>')])
	if rt.is_true(rt.identical(rt.new_bool(false), var_head_end)) {
		var_head_end = rt.call_function('strpos', [var_head_html.clone(), rt.new_string('<body')])
		if rt.is_true(rt.identical(rt.new_bool(false), var_head_end)) {
			return var_html.clone()
		}
	}
	var_head_html = rt.call_function('substr', [var_head_html.clone(), var_head_start.clone(), var_head_end.clone()])
	var_head_html = rt.concat(var_head_html, rt.new_string('</head>'))
	return var_head_html.clone()
}

fn (mut this Class_WP_REST_URL_Details_Controller) get_meta_with_content_elements(var_html rt.PhpVal) rt.PhpVal {
	mut var_elements := rt.new_null()
	mut var_pattern := rt.new_string('#<meta\\s' + '[^>]*' + 'content=(["\']??)(.*)\\1' + '[^>]*' + '\\/?>#' + 'isU')
	rt.call_function('preg_match_all', [var_pattern.clone(), var_html.clone(), var_elements.clone()])
	return var_elements.clone()
}

fn (mut this Class_WP_REST_URL_Details_Controller) get_metadata_from_meta_element(var_meta_elements rt.PhpVal, var_attr rt.PhpVal, var_attr_value rt.PhpVal) string {
	mut var_match := rt.new_null()
	mut var_meta_elements_mutated := var_meta_elements
	if !rt.is_true(var_meta_elements_mutated.array_get(rt.new_int(0))) {
		return ''
	}
	mut var_metadata := rt.new_string('')
	mut var_pattern := rt.new_string('#' + (var_attr).str() + '=([\\"\']??)\\s*' + (var_attr_value).str() + '\\s*\\1' + '#isU')
	mut iter_2 := var_meta_elements_mutated.array_get(rt.new_int(0)).iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_element := item_2.val
		mut var_index := item_2.key
		rt.call_function('preg_match', [var_pattern.clone(), var_element.clone(), var_match.clone()])
		if !rt.is_true(var_match) {
			continue
		}
		if var_meta_elements_mutated.array_get(rt.new_int(2)).array_isset(var_index) && var_meta_elements_mutated.array_get(rt.new_int(2)).array_get(var_index).is_string() {
		var_metadata = rt.new_string(var_meta_elements_mutated.array_get(rt.new_int(2)).array_get(var_index).to_string().trim_space())
		}
		break
	}
	return (var_metadata).str()
}

struct Class_WP_REST_Controller {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

struct Class_WP_Http {
	rt.PhpObjectBase
}

fn create_wp_rest_url_details_controller() &Class_WP_REST_URL_Details_Controller {
	mut obj := &Class_WP_REST_URL_Details_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	obj.construct()
	return obj
}

fn create_wp_rest_controller(_args ...rt.PhpVal) &Class_WP_REST_Controller {
	mut obj := &Class_WP_REST_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_error(_args ...rt.PhpVal) &Class_WP_Error {
	mut obj := &Class_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_http(_args ...rt.PhpVal) &Class_WP_Http {
	mut obj := &Class_WP_Http{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_REST_URL_Details_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'register_routes' {
			this.register_routes()
			return rt.new_null()
		}
		'get_item_schema' {
			return this.get_item_schema()
		}
		'parse_url_details' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.parse_url_details(dispatch_arg_0)
		}
		'permissions_check' {
			return rt.new_bool(this.permissions_check())
		}
		'get_remote_url' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_remote_url(dispatch_arg_0)
		}
		'get_title' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.get_title(dispatch_arg_0))
		}
		'get_icon' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.get_icon(dispatch_arg_0, dispatch_arg_1)
		}
		'get_description' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.get_description(dispatch_arg_0))
		}
		'get_image' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_string(this.get_image(dispatch_arg_0, dispatch_arg_1))
		}
		'prepare_metadata_for_output' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.prepare_metadata_for_output(dispatch_arg_0)
		}
		'build_cache_key_for_url' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.build_cache_key_for_url(dispatch_arg_0))
		}
		'get_cache' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_cache(dispatch_arg_0)
		}
		'set_cache' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return this.set_cache(dispatch_arg_0, dispatch_arg_1)
		}
		'get_document_head' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_document_head(dispatch_arg_0)
		}
		'get_meta_with_content_elements' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_meta_with_content_elements(dispatch_arg_0)
		}
		'get_metadata_from_meta_element' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return rt.new_string(this.get_metadata_from_meta_element(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2))
		}
		else { return none }
	}
}

fn (this &Class_WP_REST_URL_Details_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_REST_URL_Details_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_REST_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_REST_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_REST_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_Error) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Error) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Error) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_Http) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Http) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Http) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}



fn main() {
	defer {
		rt.shutdown()
	}

}
