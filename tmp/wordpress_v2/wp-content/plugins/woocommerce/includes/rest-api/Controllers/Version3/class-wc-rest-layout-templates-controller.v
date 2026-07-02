import rt

struct Class_WC_REST_Layout_Templates_Controller {
	rt.PhpObjectBase
pub mut:
	namespace rt.PhpVal = rt.new_string('wc/v3')
	rest_base rt.PhpVal = rt.new_string('layout-templates')
}

fn (mut this Class_WC_REST_Layout_Templates_Controller) register_routes() {
	rt.call_function('register_rest_route', [this.namespace, rt.new_string('/' +
		(this.rest_base).str()),
		rt.create_array([
			rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() },
			rt.ArrayItem{ key: 'callback', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Layout_Templates_Controller', [
					'WC_REST_Controller',
				], &this) },
				rt.ArrayItem{ key: none, val: 'get_items' },
			]) },
			rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Layout_Templates_Controller', [
					'WC_REST_Controller',
				], &this) },
				rt.ArrayItem{ key: none, val: 'get_items_permissions_check' },
			]) },
			rt.ArrayItem{ key: 'args', val: rt.create_array([
				rt.ArrayItem{ key: 'area', val: rt.create_array([
					rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
						rt.new_string('Area to get templates for.'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: '' },
				]) },
			]) },
		])])
	rt.call_function('register_rest_route', [this.namespace,
		rt.new_string('/' + (this.rest_base).str() + '/(?P<id>\\w[\\w\\s\\-]*)'),
		rt.create_array([
			rt.ArrayItem{ key: 'args', val: rt.create_array([
				rt.ArrayItem{ key: 'id', val: rt.create_array([
					rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
						rt.new_string('Unique identifier for the resource.'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
			]) },
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() },
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Layout_Templates_Controller', [
						'WC_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_item' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Layout_Templates_Controller', [
						'WC_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_item_permissions_check' },
				]) },
				rt.ArrayItem{ key: 'args', val: rt.new_array() },
			]) },
		])])
}

fn (mut this Class_WC_REST_Layout_Templates_Controller) get_items_permissions_check(var_request rt.PhpVal) bool {
	return true
}

fn (mut this Class_WC_REST_Layout_Templates_Controller) get_item_permissions_check(var_request rt.PhpVal) bool {
	return true
}

fn (mut this Class_WC_REST_Layout_Templates_Controller) get_items(var_request rt.PhpVal) rt.PhpVal {
	mut var_layout_templates := this.get_layout_templates(mut rt.cast_object_ptr[Class_array](rt.create_array([
		rt.ArrayItem{ key: 'area', val: var_request.array_get(rt.new_string('area')) },
	])))
	mut var_response := rt.call_function('rest_ensure_response', [
		var_layout_templates.clone()])
	return var_response.clone()
}

fn (mut this Class_WC_REST_Layout_Templates_Controller) get_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_layout_templates := this.get_layout_templates(mut rt.cast_object_ptr[Class_array](rt.create_array([
		rt.ArrayItem{ key: 'id', val: var_request.array_get(rt.new_string('id')) },
	])))
	if rt.is_true(rt.new_bool(var_layout_templates.clone().array_count() != 1)) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('woocommerce_rest_layout_template_invalid_id'), rt.call_function('__', [
			rt.new_string('Invalid layout template ID.'),
			rt.new_string('woocommerce'),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 404 }])))
	}
	mut var_response := rt.call_function('rest_ensure_response', [
		rt.call_function('current', [var_layout_templates.clone()]),
	])
	return var_response.clone()
}

fn (mut this Class_WC_REST_Layout_Templates_Controller) get_layout_templates(mut var_query_params Class_array) rt.PhpVal {
	mut var_layout_template_registry := rt.call_method(rt.call_function('wc_get_container',
		[]rt.PhpVal{}), 'get', [
		Class_Automattic_WooCommerce_LayoutTemplates_LayoutTemplateRegistry.class(),
	])
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_layout_template := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.call_method(var_layout_template, 'to_json', []rt.PhpVal{})
	}
	closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_layout_template := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.call_method(var_layout_template, 'to_json', []rt.PhpVal{})
	}
	return rt.call_function('array_map', [rt.new_closure(closure_1_fn),
		rt.call_method(var_layout_template_registry, 'instantiate_layout_templates', [
			var_query_params,
		])])
}

struct Class_WC_REST_Controller {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

fn create_wc_rest_layout_templates_controller(_args ...rt.PhpVal) &Class_WC_REST_Layout_Templates_Controller {
	mut obj := &Class_WC_REST_Layout_Templates_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
		namespace:     rt.new_string('wc/v3')
		rest_base:     rt.new_string('layout-templates')
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

fn (mut this Class_WC_REST_Layout_Templates_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'register_routes' {
			this.register_routes()
			return rt.new_null()
		}
		'get_items_permissions_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.get_items_permissions_check(dispatch_arg_0))
		}
		'get_item_permissions_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.get_item_permissions_check(dispatch_arg_0))
		}
		'get_items' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_items(dispatch_arg_0)
		}
		'get_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_item(dispatch_arg_0)
		}
		'get_layout_templates' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.get_layout_templates(mut dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_REST_Layout_Templates_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'namespace' { return this.namespace }
		'rest_base' { return this.rest_base }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_REST_Layout_Templates_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}
