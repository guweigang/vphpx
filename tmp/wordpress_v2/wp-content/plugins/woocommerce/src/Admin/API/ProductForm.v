import rt

struct Class_Automattic_WooCommerce_Admin_API_ProductForm {
	rt.PhpObjectBase
pub mut:
	namespace rt.PhpVal = rt.new_string('wc-admin')
	rest_base rt.PhpVal = rt.new_string('product-form')
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_ProductForm) register_routes() {
	rt.call_function('register_rest_route', [this.namespace, rt.new_string('/' +
		(this.rest_base).str()),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{
					key: 'methods'
					val: Class_Automattic_WooCommerce_Admin_API_WP_REST_Server.readable()
				},
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_ProductForm', [
						'Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_form_config' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_ProductForm', [
						'Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_product_form_permission_check' },
				]) },
			]) },
			rt.ArrayItem{ key: 'schema', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_ProductForm', [
					'Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller',
				], &this) },
				rt.ArrayItem{ key: none, val: 'get_public_item_schema' },
			]) },
		])])
	rt.call_function('register_rest_route', [this.namespace,
		rt.new_string('/' + (this.rest_base).str() + '/fields'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{
					key: 'methods'
					val: Class_Automattic_WooCommerce_Admin_API_WP_REST_Server.readable()
				},
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_ProductForm', [
						'Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_fields' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_ProductForm', [
						'Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_product_form_permission_check' },
				]) },
			]) },
			rt.ArrayItem{ key: 'schema', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_ProductForm', [
					'Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller',
				], &this) },
				rt.ArrayItem{ key: none, val: 'get_public_item_schema' },
			]) },
		])])
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_ProductForm) get_product_form_permission_check(var_request rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('manage_woocommerce'),
	])))))
	{
		return (create_automattic_woocommerce_admin_api_wp_error(rt.new_string('woocommerce_rest_cannot_create'), rt.call_function('__', [
			rt.new_string('Sorry, you are not allowed to retrieve product form data.'),
			rt.new_string('woocommerce'),
		]), rt.create_array([
			rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code',
				[]rt.PhpVal{}) },
		]))).to_bool()
	}
	return true
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_ProductForm) get_fields(var_request rt.PhpVal) rt.PhpVal {
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_field := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.call_method(var_field, 'get_json', []rt.PhpVal{})
	}
	mut iife_temp_1 := Class_Automattic_WooCommerce_Internal_Admin_ProductForm_FormFactory{}
	mut iife_result_1 := iife_temp_1.get_fields()
	closure_3_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_field := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.call_method(var_field, 'get_json', []rt.PhpVal{})
	}
	mut var_json := rt.call_function('array_map', [rt.new_closure(closure_1_fn), iife_result_1])
	return rt.call_function('rest_ensure_response', [var_json.clone()])
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_ProductForm) get_form_config(var_request rt.PhpVal) rt.PhpVal {
	closure_4_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_field := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.call_method(var_field, 'get_json', []rt.PhpVal{})
	}
	mut iife_temp_4 := Class_Automattic_WooCommerce_Internal_Admin_ProductForm_FormFactory{}
	mut iife_result_4 := iife_temp_4.get_fields()
	closure_6_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_field := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.call_method(var_field, 'get_json', []rt.PhpVal{})
	}
	mut var_fields := rt.call_function('array_map', [rt.new_closure(closure_4_fn), iife_result_4])
	closure_7_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_subsection := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.call_method(var_subsection, 'get_json', []rt.PhpVal{})
	}
	mut iife_temp_7 := Class_Automattic_WooCommerce_Internal_Admin_ProductForm_FormFactory{}
	mut iife_result_7 := iife_temp_7.get_subsections()
	closure_9_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_subsection := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.call_method(var_subsection, 'get_json', []rt.PhpVal{})
	}
	mut var_subsections := rt.call_function('array_map', [rt.new_closure(closure_7_fn),
		iife_result_7])
	closure_10_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_section := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.call_method(var_section, 'get_json', []rt.PhpVal{})
	}
	mut iife_temp_10 := Class_Automattic_WooCommerce_Internal_Admin_ProductForm_FormFactory{}
	mut iife_result_10 := iife_temp_10.get_sections()
	closure_12_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_section := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.call_method(var_section, 'get_json', []rt.PhpVal{})
	}
	mut var_sections := rt.call_function('array_map',
		[rt.new_closure(closure_10_fn), iife_result_10])
	closure_13_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_tab := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.call_method(var_tab, 'get_json', []rt.PhpVal{})
	}
	mut iife_temp_13 := Class_Automattic_WooCommerce_Internal_Admin_ProductForm_FormFactory{}
	mut iife_result_13 := iife_temp_13.get_tabs()
	closure_15_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_tab := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.call_method(var_tab, 'get_json', []rt.PhpVal{})
	}
	mut var_tabs := rt.call_function('array_map', [rt.new_closure(closure_13_fn), iife_result_13])
	return rt.call_function('rest_ensure_response', [
		rt.create_array([rt.ArrayItem{ key: 'fields', val: var_fields },
			rt.ArrayItem{ key: 'subsections', val: var_subsections },
			rt.ArrayItem{ key: 'sections', val: var_sections },
			rt.ArrayItem{ key: 'tabs', val: var_tabs }]),
	])
}

struct Class_Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_API_WP_Error {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Admin_ProductForm_FormFactory {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_api_productform(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_API_ProductForm {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_ProductForm{
		PhpObjectBase: rt.PhpObjectBase{}
		namespace:     rt.new_string('wc-admin')
		rest_base:     rt.new_string('product-form')
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_wc_rest_data_controller(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_wp_error(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_API_WP_Error {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_productform_formfactory(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_ProductForm_FormFactory {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_ProductForm_FormFactory{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_ProductForm) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'register_routes' {
			this.register_routes()
			return rt.new_null()
		}
		'get_product_form_permission_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.get_product_form_permission_check(dispatch_arg_0))
		}
		'get_fields' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_fields(dispatch_arg_0)
		}
		'get_form_config' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_form_config(dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_API_ProductForm) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'namespace' { return this.namespace }
		'rest_base' { return this.rest_base }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_ProductForm) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_WP_Error) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_API_WP_Error) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_WP_Error) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ProductForm_FormFactory) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_ProductForm_FormFactory) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ProductForm_FormFactory) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}
