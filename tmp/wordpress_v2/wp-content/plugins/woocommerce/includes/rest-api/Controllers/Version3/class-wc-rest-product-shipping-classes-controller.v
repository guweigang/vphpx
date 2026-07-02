import rt

struct Class_WC_REST_Product_Shipping_Classes_Controller {
	rt.PhpObjectBase
pub mut:
	namespace rt.PhpVal = rt.new_string('wc/v3')
}

fn (mut this Class_WC_REST_Product_Shipping_Classes_Controller) register_routes() {
	this.Class_WC_REST_Product_Shipping_Classes_V2_Controller.register_routes()
	rt.call_function('register_rest_route', [this.namespace,
		rt.new_string('/' +
			(rt.get_property(rt.new_object('WC_REST_Product_Shipping_Classes_Controller', ['WC_REST_Product_Shipping_Classes_V2_Controller'], &this), 'rest_base')).str() +
			'/slug-suggestion'),
		rt.create_array([
			rt.ArrayItem{ key: 'args', val: rt.create_array([
				rt.ArrayItem{ key: 'name', val: rt.create_array([
					rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
						rt.new_string('Suggest a slug for the term.'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
			]) },
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() },
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Product_Shipping_Classes_Controller', [
						'WC_REST_Product_Shipping_Classes_V2_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'suggest_slug' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Product_Shipping_Classes_Controller', [
						'WC_REST_Product_Shipping_Classes_V2_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_item_permissions_check' },
				]) },
				rt.ArrayItem{
					key: 'args'
					val: this.get_endpoint_args_for_item_schema(Class_WP_REST_Server.editable())
				},
			]) },
			rt.ArrayItem{ key: 'schema', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Product_Shipping_Classes_Controller', [
					'WC_REST_Product_Shipping_Classes_V2_Controller',
				], &this) },
				rt.ArrayItem{ key: none, val: 'get_public_item_schema' },
			]) },
		])])
}

fn (mut this Class_WC_REST_Product_Shipping_Classes_Controller) suggest_slug(var_request rt.PhpVal) rt.PhpVal {
	mut var_name := var_request.array_get(rt.new_string('name'))
	mut var_slug := rt.call_function('sanitize_title', [var_name.clone()])
	mut var_term := rt.call_function('get_term_by', [rt.new_string('slug'),
		var_slug.clone(),
		rt.get_property(rt.new_object('WC_REST_Product_Shipping_Classes_Controller', [
			'WC_REST_Product_Shipping_Classes_V2_Controller',
		], &this), 'taxonomy')])
	if !(rt.get_property(var_term, 'slug')).is_null() {
		var_slug = rt.call_function('wp_unique_term_slug', [var_slug.clone(),
			rt.array_to_object(rt.create_array([
				rt.ArrayItem{ key: 'taxonomy', val: rt.get_property(rt.new_object('WC_REST_Product_Shipping_Classes_Controller', [
					'WC_REST_Product_Shipping_Classes_V2_Controller',
				], &this), 'taxonomy') },
			]))])
	}
	return rt.call_function('rest_ensure_response', [var_slug.clone()])
}

struct Class_WC_REST_Product_Shipping_Classes_V2_Controller {
	rt.PhpObjectBase
}

fn create_wc_rest_product_shipping_classes_controller(_args ...rt.PhpVal) &Class_WC_REST_Product_Shipping_Classes_Controller {
	mut obj := &Class_WC_REST_Product_Shipping_Classes_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
		namespace:     rt.new_string('wc/v3')
	}
	return obj
}

fn create_wc_rest_product_shipping_classes_v2_controller(_args ...rt.PhpVal) &Class_WC_REST_Product_Shipping_Classes_V2_Controller {
	mut obj := &Class_WC_REST_Product_Shipping_Classes_V2_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_REST_Product_Shipping_Classes_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'register_routes' {
			this.register_routes()
			return rt.new_null()
		}
		'suggest_slug' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.suggest_slug(dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_REST_Product_Shipping_Classes_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'namespace' { return this.namespace }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_REST_Product_Shipping_Classes_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'namespace' {
			this.namespace = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_WC_REST_Product_Shipping_Classes_V2_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_REST_Product_Shipping_Classes_V2_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_REST_Product_Shipping_Classes_V2_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}
