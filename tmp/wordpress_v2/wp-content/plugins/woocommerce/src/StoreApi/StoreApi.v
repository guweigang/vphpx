import rt

struct Class_Automattic_WooCommerce_StoreApi_StoreApi {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_StoreApi) init() {
	mut var_authentication := rt.call_method(Class_Automattic_WooCommerce_StoreApi_StoreApi.container(),
		'get', [Class_Automattic_WooCommerce_StoreApi_Authentication.class()])
	rt.call_function('add_filter', [rt.new_string('woocommerce_session_handler'),
		rt.create_array([rt.ArrayItem{ key: none, val: var_authentication },
			rt.ArrayItem{ key: none, val: 'maybe_use_store_api_session_handler' }]),
		rt.new_int(0)])
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_rest_should_load_namespace', [rt.new_string('wc/store')])))))
			&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_rest_should_load_namespace', [rt.new_string('wc/private')]))))) {
			return
		}
		rt.call_method(rt.call_method(Class_Automattic_WooCommerce_StoreApi_StoreApi.container(),
			'get', [Class_Automattic_WooCommerce_StoreApi_Legacy.class()]), 'init', []rt.PhpVal{})
		rt.call_method(rt.call_method(Class_Automattic_WooCommerce_StoreApi_StoreApi.container(),
			'get', [Class_Automattic_WooCommerce_StoreApi_RoutesController.class()]),
			'register_all_routes', []rt.PhpVal{})
		return rt.new_null()
	}
	rt.call_function('add_action', [rt.new_string('rest_api_init'),
		rt.new_closure(closure_1_fn)])
	closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_rest_should_load_namespace', [
			rt.new_string('wc/store'),
		])))))
		{
			return
		}
		rt.call_method(rt.call_method(Class_Automattic_WooCommerce_StoreApi_StoreApi.container(),
			'get', [Class_Automattic_WooCommerce_StoreApi_Authentication.class()]), 'init',
			[]rt.PhpVal{})
		return rt.new_null()
	}
	rt.call_function('add_action', [rt.new_string('rest_api_init'),
		rt.new_closure(closure_2_fn), rt.new_int(11)])
	closure_3_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_routes := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_ns := if args.len > 1 { args[1].clone() } else { rt.new_null() }
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('wc/store/v1'), var_ns)))) {
			return
		}
		var_routes = rt.call_function('array_merge', [var_routes.clone(),
			rt.call_method(rt.call_method(Class_Automattic_WooCommerce_StoreApi_StoreApi.container(),
				'get', [
				Class_Automattic_WooCommerce_StoreApi_RoutesController.class(),
			]), 'get_all_routes', [
				rt.new_string('v1'),
			])])
		return
	}
	rt.call_function('add_action', [
		rt.new_string('woocommerce_blocks_pre_get_routes_from_namespace'),
		rt.new_closure(closure_3_fn),
		rt.new_int(10),
		rt.new_int(2),
	])
}

fn Class_Automattic_WooCommerce_StoreApi_StoreApi.container(reset bool) rt.PhpVal {
	mut var_container := rt.new_null()
	if var_reset {
		var_container = rt.new_null()
	}
	if rt.is_true(var_container) {
		return var_container.clone()
	}
	var_container = create_automattic_woocommerce_blocks_registry_container()
	closure_4_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		return rt.new_object('Automattic_WooCommerce_StoreApi_Authentication', []string{},
			create_automattic_woocommerce_storeapi_authentication())
	}
	rt.call_method(var_container, 'register', [
		Class_Automattic_WooCommerce_StoreApi_Authentication.class(),
		rt.new_closure(closure_4_fn),
	])
	closure_5_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		return rt.new_object('Automattic_WooCommerce_StoreApi_Legacy', []string{},
			create_automattic_woocommerce_storeapi_legacy())
	}
	rt.call_method(var_container, 'register', [
		Class_Automattic_WooCommerce_StoreApi_Legacy.class(),
		rt.new_closure(closure_5_fn),
	])
	closure_6_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_container := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.new_object('Automattic_WooCommerce_StoreApi_RoutesController', []string{}, create_automattic_woocommerce_storeapi_routescontroller(rt.call_method(var_container,
			'get', [Class_Automattic_WooCommerce_StoreApi_SchemaController.class()])))
	}
	rt.call_method(var_container, 'register', [
		Class_Automattic_WooCommerce_StoreApi_RoutesController.class(),
		rt.new_closure(closure_6_fn),
	])
	closure_7_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_container := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.new_object('Automattic_WooCommerce_StoreApi_SchemaController', []string{}, create_automattic_woocommerce_storeapi_schemacontroller(rt.call_method(var_container,
			'get', [
			Class_Automattic_WooCommerce_StoreApi_Schemas_ExtendSchema.class(),
		])))
	}
	rt.call_method(var_container, 'register', [
		Class_Automattic_WooCommerce_StoreApi_SchemaController.class(),
		rt.new_closure(closure_7_fn),
	])
	closure_8_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_container := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.new_object('Automattic_WooCommerce_StoreApi_Schemas_ExtendSchema', []string{}, create_automattic_woocommerce_storeapi_schemas_extendschema(rt.call_method(var_container,
			'get', [Class_Automattic_WooCommerce_StoreApi_Formatters.class()])))
	}
	rt.call_method(var_container, 'register', [
		Class_Automattic_WooCommerce_StoreApi_Schemas_ExtendSchema.class(),
		rt.new_closure(closure_8_fn),
	])
	closure_9_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_formatters := create_automattic_woocommerce_storeapi_formatters()
		rt.call_method(var_formatters, 'register', [rt.new_string('money'),
			Class_Automattic_WooCommerce_StoreApi_Formatters_MoneyFormatter.class()])
		rt.call_method(var_formatters, 'register', [rt.new_string('html'),
			Class_Automattic_WooCommerce_StoreApi_Formatters_HtmlFormatter.class()])
		rt.call_method(var_formatters, 'register', [rt.new_string('currency'),
			Class_Automattic_WooCommerce_StoreApi_Formatters_CurrencyFormatter.class()])
		return var_formatters.clone()
	}
	rt.call_method(var_container, 'register', [
		Class_Automattic_WooCommerce_StoreApi_Formatters.class(),
		rt.new_closure(closure_9_fn),
	])
	return var_container.clone()
}

struct Class_Automattic_WooCommerce_Blocks_Registry_Container {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_StoreApi_Authentication {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_StoreApi_Legacy {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_StoreApi_RoutesController {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_StoreApi_SchemaController {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_StoreApi_Schemas_ExtendSchema {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_StoreApi_Formatters {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_storeapi_storeapi(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_StoreApi_StoreApi {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_StoreApi{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_registry_container(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_Registry_Container {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Registry_Container{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_storeapi_authentication(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_StoreApi_Authentication {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Authentication{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_storeapi_legacy(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_StoreApi_Legacy {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Legacy{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_storeapi_routescontroller(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_StoreApi_RoutesController {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_RoutesController{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_storeapi_schemacontroller(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_StoreApi_SchemaController {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_SchemaController{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_storeapi_schemas_extendschema(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_StoreApi_Schemas_ExtendSchema {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Schemas_ExtendSchema{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_storeapi_formatters(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_StoreApi_Formatters {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Formatters{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_StoreApi) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'init' {
			this.init()
			return rt.new_null()
		}
		'container' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			return Class_Automattic_WooCommerce_StoreApi_StoreApi.container(dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_StoreApi_StoreApi) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_StoreApi) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Registry_Container) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_Registry_Container) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Registry_Container) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Authentication) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Authentication) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Authentication) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Legacy) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Legacy) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Legacy) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_RoutesController) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_StoreApi_RoutesController) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_RoutesController) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_SchemaController) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_StoreApi_SchemaController) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_SchemaController) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_ExtendSchema) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Schemas_ExtendSchema) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_ExtendSchema) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Formatters) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Formatters) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Formatters) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
