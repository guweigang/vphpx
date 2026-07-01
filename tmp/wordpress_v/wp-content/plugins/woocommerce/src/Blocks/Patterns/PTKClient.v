import rt

pub fn Class_Automattic_WooCommerce_Blocks_Patterns_PTKClient.patterns_toolkit_url() string {
	return 'https://public-api.wordpress.com/rest/v1/ptk/patterns/'
}
struct Class_Automattic_WooCommerce_Blocks_Patterns_PTKClient {
	rt.PhpObjectBase
pub mut:
		schema rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Patterns_PTKClient) construct()  {
	this.schema = rt.create_array([rt.ArrayItem{ key: 'type', val: 'array' }, rt.ArrayItem{ key: 'items', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: 'ID', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'required', val: true }]) }, rt.ArrayItem{ key: 'site_id', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'required', val: true }]) }, rt.ArrayItem{ key: 'title', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'required', val: true }]) }, rt.ArrayItem{ key: 'name', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'required', val: true }]) }, rt.ArrayItem{ key: 'html', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'required', val: true }]) }, rt.ArrayItem{ key: 'categories', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'additionalProperties', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: 'slug', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'required', val: true }]) }, rt.ArrayItem{ key: 'title', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'required', val: true }]) }, rt.ArrayItem{ key: 'description', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'required', val: true }]) }]) }]) }]) }]) }]) }])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Patterns_PTKClient) fetch_patterns(mut var_options Class_Automattic_WooCommerce_Blocks_Patterns_array) rt.PhpVal {
	mut var_locale := rt.call_function('get_user_locale', []rt.PhpVal{})
	mut var_lang := rt.call_function('preg_replace', [rt.new_string('/(_.*)$/'), rt.new_string(''), var_locale.dup()])
	mut var_ptk_url := rt.new_string(rt.concat(Class_Automattic_WooCommerce_Blocks_Patterns_Automattic_WooCommerce_Blocks_Patterns_PTKClient.patterns_toolkit_url(), var_lang))
	if var_options.array_isset(rt.new_string('site')) {
		var_ptk_url = rt.call_function('add_query_arg', [rt.new_string('site'), var_options.array_get('site'), var_ptk_url.dup()])
	}
	if var_options.array_isset(rt.new_string('categories')) {
		var_ptk_url = rt.call_function('add_query_arg', [rt.new_string('categories'), rt.call_function('implode', [rt.new_string(','), var_options.array_get('categories')]), var_ptk_url.dup()])
	}
	if var_options.array_isset(rt.new_string('per_page')) {
		var_ptk_url = rt.call_function('add_query_arg', [rt.new_string('per_page'), var_options.array_get('per_page'), var_ptk_url.dup()])
	}
	mut var_patterns := rt.call_function('wp_safe_remote_get', [var_ptk_url.dup()])
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('is_wp_error', [var_patterns.dup()])) || rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		return create_wp_error(rt.new_string('patterns_toolkit_api_error'), rt.call_function('__', [rt.new_string('Failed to connect with the Patterns Toolkit API: try again later.'), rt.new_string('woocommerce')]))
	}
	mut var_body := rt.call_function('wp_remote_retrieve_body', [var_patterns.dup()])
	if !rt.is_true(var_body) {
		return create_wp_error(rt.new_string('patterns_toolkit_api_error'), rt.call_function('__', [rt.new_string('Empty response received from the Patterns Toolkit API.'), rt.new_string('woocommerce')]))
	}
	mut var_decoded_body := rt.call_function('json_decode', [var_body.dup(), rt.new_bool(true)])
	mut var_is_pattern_payload_valid := rt.new_bool(this.is_valid_schema(var_decoded_body.dup()))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_is_pattern_payload_valid)))) {
		return create_wp_error(rt.new_string('patterns_toolkit_api_error'), rt.call_function('__', [rt.new_string('Wrong response received from the Patterns Toolkit API: try again later.'), rt.new_string('woocommerce')]))
	}
	return var_decoded_body.dup()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Patterns_PTKClient) is_valid_schema(var_patterns rt.PhpVal) bool {
	mut var_patterns_mutated := var_patterns
	mut var_is_pattern_payload_valid := rt.call_function('rest_validate_value_from_schema', [var_patterns_mutated.dup(), this.schema])
	return !(rt.is_true(rt.call_function('is_wp_error', [var_is_pattern_payload_valid.dup()])))
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blocks_patterns_ptkclient() &Class_Automattic_WooCommerce_Blocks_Patterns_PTKClient {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Patterns_PTKClient{
		PhpObjectBase: rt.PhpObjectBase{}
		schema: rt.new_null()
	}
	obj.construct()
	return obj
}

fn create_wp_error() &Class_WP_Error {
	mut obj := &Class_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Patterns_PTKClient) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'fetch_patterns' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Blocks_Patterns_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.fetch_patterns(mut dispatch_arg_0)
		}
		'is_valid_schema' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.is_valid_schema(dispatch_arg_0))
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Blocks_Patterns_PTKClient) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'schema' { return this.schema }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Patterns_PTKClient) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'schema' { this.schema = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
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




pub fn init_wp_content_plugins_woocommerce_src_blocks_patterns_ptkclient_php() {
}
