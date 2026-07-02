import rt

struct Class_WC_REST_Products_Catalog_Controller {
	rt.PhpObjectBase
pub mut:
	namespace rt.PhpVal = rt.new_string('wc/v3')
	rest_base rt.PhpVal = rt.new_string('products/catalog')
}

fn (mut this Class_WC_REST_Products_Catalog_Controller) register_routes() {
	rt.call_function('register_rest_route', [this.namespace, rt.new_string('/' +
		(this.rest_base).str()),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.creatable() },
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Products_Catalog_Controller', [
						'WC_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'request_catalog' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Products_Catalog_Controller', [
						'WC_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'request_catalog_permissions_check' },
				]) },
				rt.ArrayItem{ key: 'args', val: rt.create_array([
					rt.ArrayItem{ key: 'fields', val: rt.create_array([
						rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
							rt.new_string('Product/variation fields to include in the catalog. Can be an array or comma-separated string.'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'type', val: rt.create_array([
							rt.ArrayItem{ key: none, val: 'array' },
							rt.ArrayItem{ key: none, val: 'string' },
						]) },
						rt.ArrayItem{ key: 'items', val: rt.create_array([
							rt.ArrayItem{ key: 'type', val: 'string' },
						]) },
						rt.ArrayItem{ key: 'required', val: true },
						rt.ArrayItem{ key: 'validate_callback', val: rt.create_array([
							rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Products_Catalog_Controller', [
								'WC_REST_Controller',
							], &this) },
							rt.ArrayItem{ key: none, val: 'validate_fields_arg' },
						]) },
						rt.ArrayItem{ key: 'sanitize_callback', val: rt.create_array([
							rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Products_Catalog_Controller', [
								'WC_REST_Controller',
							], &this) },
							rt.ArrayItem{ key: none, val: 'sanitize_fields_arg' },
						]) },
					]) },
					rt.ArrayItem{ key: 'force_generate', val: rt.create_array([
						rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
							rt.new_string('Whether to generate a new catalog file regardless of whether a catalog file already exists.'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'type', val: 'boolean' },
						rt.ArrayItem{ key: 'default', val: false },
						rt.ArrayItem{ key: 'sanitize_callback', val: 'rest_sanitize_boolean' },
					]) },
				]) },
			]) },
			rt.ArrayItem{ key: 'schema', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Products_Catalog_Controller', [
					'WC_REST_Controller',
				], &this) },
				rt.ArrayItem{ key: none, val: 'catalog_schema' },
			]) },
		])])
}

fn (mut this Class_WC_REST_Products_Catalog_Controller) request_catalog(var_request rt.PhpVal) rt.PhpVal {
	mut var_fields := this.sanitize_fields_arg(if !(rt.call_method(var_request, 'get_param', [
		rt.new_string('fields'),
	])).is_null() { rt.call_method(var_request, 'get_param', [
			rt.new_string('fields')]) } else { rt.new_array() })
	mut var_force_generate := if !(rt.call_method(var_request, 'get_param', [
		rt.new_string('force_generate'),
	])).is_null() { rt.call_method(var_request, 'get_param', [
			rt.new_string('force_generate'),
		]) } else { rt.new_bool(false) }
	mut var_file_info := this.get_catalog_file_info(var_fields.clone())
	if rt.is_true(rt.call_function('is_wp_error', [var_file_info.clone()])) {
		return var_file_info.clone()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_force_generate))))
		&& rt.is_true(rt.call_function('file_exists', [var_file_info.array_get(rt.new_string('filepath'))])) {
		mut var_response_data := {
			'status':       rt.new_string('complete')
			'download_url': var_file_info.array_get(rt.new_string('url'))
		}
		return rt.call_function('rest_ensure_response', [
			rt.create_array_from_native_map(var_response_data),
		])
	}
	return this.catalog_generation_response(var_file_info.clone())
}

fn (mut this Class_WC_REST_Products_Catalog_Controller) request_catalog_permissions_check(var_request rt.PhpVal) bool {
	if !(
		rt.is_true(rt.call_function('wc_rest_check_post_permissions', [rt.new_string('product'), rt.new_string('read')]))
		&& rt.is_true(rt.call_function('wc_rest_check_post_permissions', [rt.new_string('product_variation'), rt.new_string('read')]))) {
		return (create_wp_error(rt.new_string('woocommerce_rest_cannot_view'), rt.call_function('__', [
			rt.new_string('Sorry, you cannot list resources.'),
			rt.new_string('woocommerce'),
		]), rt.create_array([
			rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code',
				[]rt.PhpVal{}) },
		]))).to_bool()
	}
	return true
}

fn (mut this Class_WC_REST_Products_Catalog_Controller) validate_fields_arg(var_value rt.PhpVal) bool {
	mut var_value_mutated := var_value
	if !(var_value_mutated.clone().is_array()) && !(var_value_mutated.clone().is_string()) {
		return (create_wp_error(rt.new_string('invalid_fields'), rt.call_function('__', [
			rt.new_string('fields must be an array of strings or a comma-separated string.'),
			rt.new_string('woocommerce'),
		]))).to_bool()
	}
	if (var_value_mutated.clone().is_array() && !rt.is_true(var_value_mutated))
		|| (var_value_mutated.clone().is_string()
		&& rt.is_true(rt.identical(rt.new_string(''), rt.new_string(var_value_mutated.clone().to_string().trim_space())))) {
		return (create_wp_error(rt.new_string('invalid_fields'), rt.call_function('__', [
			rt.new_string('fields cannot be empty.'),
			rt.new_string('woocommerce'),
		]))).to_bool()
	}
	return true
}

fn (mut this Class_WC_REST_Products_Catalog_Controller) sanitize_fields_arg(var_value rt.PhpVal) rt.PhpVal {
	mut var_value_mutated := var_value
	if rt.is_true(rt.new_bool(var_value_mutated.clone().is_string())) {
		var_value_mutated = rt.call_function('array_map', [rt.new_string('trim'),
			rt.call_function('explode', [rt.new_string(','), var_value_mutated.clone()])])
	}
	return this.canonicalize_fields(mut rt.cast_object_ptr[Class_array](if var_value_mutated.clone().is_array() {
		var_value_mutated
	} else {
		rt.new_array()
	}))
}

fn (mut this Class_WC_REST_Products_Catalog_Controller) catalog_schema() rt.PhpVal {
	return rt.create_array([
		rt.ArrayItem{ key: '$schema', val: 'http://json-schema.org/draft-04/schema#' },
		rt.ArrayItem{ key: 'title', val: 'products_catalog' },
		rt.ArrayItem{ key: 'type', val: 'object' },
		rt.ArrayItem{ key: 'properties', val: rt.create_array([
			rt.ArrayItem{ key: 'status', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Products catalog generation status.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'enum', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'pending' },
					rt.ArrayItem{ key: none, val: 'processing' },
					rt.ArrayItem{ key: none, val: 'complete' },
					rt.ArrayItem{ key: none, val: 'failed' },
				]) },
			]) },
			rt.ArrayItem{ key: 'download_url', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Products catalog file URL. Null when catalog is not ready.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'type', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'string' },
					rt.ArrayItem{ key: none, val: 'null' },
				]) },
				rt.ArrayItem{ key: 'format', val: 'uri' },
			]) },
		]) },
		rt.ArrayItem{ key: 'required', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'status' },
			rt.ArrayItem{ key: none, val: 'download_url' },
		]) },
	])
}

fn (mut this Class_WC_REST_Products_Catalog_Controller) catalog_generation_response(var_file_info rt.PhpVal) rt.PhpVal {
	mut var_file_info_mutated := var_file_info
	mut var_result := rt.new_bool(this.generate_catalog_file(var_file_info_mutated.clone()))
	if rt.is_true(rt.call_function('is_wp_error', [var_result.clone()])) {
		return var_result.clone()
	}
	return rt.call_function('rest_ensure_response', [
		rt.create_array([rt.ArrayItem{ key: 'status', val: 'complete' },
			rt.ArrayItem{
				key: 'download_url'
				val: var_file_info_mutated.array_get(rt.new_string('url'))
			}]),
	])
}

fn (mut this Class_WC_REST_Products_Catalog_Controller) generate_catalog_file(var_file_info rt.PhpVal) bool {
	mut var_file_info_mutated := var_file_info
	mut iife_temp_0 := Class_Automattic_WooCommerce_Internal_Utilities_FilesystemUtil{}
	mut iife_result_0 := iife_temp_0.mkdir_p_not_indexable(var_file_info_mutated.array_get(rt.new_string('directory')),
		rt.new_bool(true))
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	unsafe {
		goto end_label_1
	}
	catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'Exception') {
		mut var_exception := var_e_1.clone()
		return (create_wp_error(rt.new_string('catalog_dir_creation_failed'), rt.call_method(var_exception,
			'getMessage', []rt.PhpVal{}), rt.create_array([
			rt.ArrayItem{ key: 'status', val: 500 },
		]))).to_bool()
		unsafe {
			goto end_label_1
		}
	} else {
		rt.throw_exception(var_e_1)
		unsafe {
			goto end_label_1
		}
	}

	end_label_1:
	mut var_catalog_data := rt.new_array()
	mut var_json := rt.call_function('wp_json_encode', [var_catalog_data.clone()])
	mut var_result := rt.call_function('file_put_contents', [
		var_file_info_mutated.array_get(rt.new_string('filepath')),
		var_json.clone(),
		rt.get_constant('LOCK_EX'),
	])
	if rt.is_true(rt.identical(rt.new_bool(false), var_result)) {
		return (create_wp_error(rt.new_string('catalog_generation_failed'), rt.call_function('__', [
			rt.new_string('Failed to generate catalog file.'),
			rt.new_string('woocommerce'),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 500 }]))).to_bool()
	}
	return true
}

fn (mut this Class_WC_REST_Products_Catalog_Controller) get_catalog_file_info(var_fields rt.PhpVal) rt.PhpVal {
	mut var_fields_mutated := var_fields
	mut var_upload_dir := rt.call_function('wp_upload_dir', []rt.PhpVal{})
	if !(!rt.is_true(var_upload_dir.array_get(rt.new_string('error')))) {
		return create_wp_error(rt.new_string('upload_dir_error'),
			var_upload_dir.array_get(rt.new_string('error')), rt.create_array([
			rt.ArrayItem{ key: 'status', val: 500 },
		]))
	}
	mut var_catalog_dir := rt.new_string(
		(rt.call_function('trailingslashit', [var_upload_dir.array_get(rt.new_string('basedir'))])).str() +
		'wc-catalog/')
	mut var_catalog_url := rt.new_string(
		(rt.call_function('trailingslashit', [var_upload_dir.array_get(rt.new_string('baseurl'))])).str() +
		'wc-catalog/')
	mut var_today := rt.call_function('gmdate', [rt.new_string('Y-m-d')])
	mut var_catalog_hash := rt.call_function('wp_hash', [
		rt.new_string(var_today.str() +
			(rt.call_function('wp_json_encode', [var_fields_mutated.clone()])).str()),
	])
	mut var_filename :=
		rt.new_string('products-${var_today.to_string()}-${var_catalog_hash.to_string()}.json')
	return rt.create_array([
		rt.ArrayItem{ key: 'filepath', val: var_catalog_dir.str() + var_filename.str() },
		rt.ArrayItem{ key: 'url', val: var_catalog_url.str() + var_filename.str() },
		rt.ArrayItem{ key: 'directory', val: var_catalog_dir },
	])
}

fn (mut this Class_WC_REST_Products_Catalog_Controller) canonicalize_fields(mut var_fields Class_array) rt.PhpVal {
	mut var_fields_mutated := var_fields
	var_fields_mutated = rt.call_function('array_values', [
		rt.call_function('array_unique', [
			rt.call_function('array_map', [rt.new_string('strval'), var_fields_mutated]),
		]),
	])
	rt.call_function('sort', [var_fields_mutated, rt.get_constant('SORT_STRING')])
	return rt.new_object('array', []string{}, var_fields_mutated)
}

struct Class_WC_REST_Controller {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Utilities_FilesystemUtil {
	rt.PhpObjectBase
}

fn create_wc_rest_products_catalog_controller(_args ...rt.PhpVal) &Class_WC_REST_Products_Catalog_Controller {
	mut obj := &Class_WC_REST_Products_Catalog_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
		namespace:     rt.new_string('wc/v3')
		rest_base:     rt.new_string('products/catalog')
	}
	return obj
}

fn create_wc_rest_controller(_args ...rt.PhpVal) &Class_WC_REST_Controller {
	mut obj := &Class_WC_REST_Controller{
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

fn create_automattic_woocommerce_internal_utilities_filesystemutil(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Utilities_FilesystemUtil {
	mut obj := &Class_Automattic_WooCommerce_Internal_Utilities_FilesystemUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_REST_Products_Catalog_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'register_routes' {
			this.register_routes()
			return rt.new_null()
		}
		'request_catalog' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.request_catalog(dispatch_arg_0)
		}
		'request_catalog_permissions_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.request_catalog_permissions_check(dispatch_arg_0))
		}
		'validate_fields_arg' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.validate_fields_arg(dispatch_arg_0))
		}
		'sanitize_fields_arg' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.sanitize_fields_arg(dispatch_arg_0)
		}
		'catalog_schema' {
			return this.catalog_schema()
		}
		'catalog_generation_response' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.catalog_generation_response(dispatch_arg_0)
		}
		'generate_catalog_file' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.generate_catalog_file(dispatch_arg_0))
		}
		'get_catalog_file_info' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_catalog_file_info(dispatch_arg_0)
		}
		'canonicalize_fields' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.canonicalize_fields(mut dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_REST_Products_Catalog_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'namespace' { return this.namespace }
		'rest_base' { return this.rest_base }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_REST_Products_Catalog_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'namespace' {
			this.namespace = val
			return true
		}
		'rest_base' {
			this.rest_base = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_WC_REST_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_REST_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_REST_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_Automattic_WooCommerce_Internal_Utilities_FilesystemUtil) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Utilities_FilesystemUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Utilities_FilesystemUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}
