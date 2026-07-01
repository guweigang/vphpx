import rt

struct Class_Automattic_WooCommerce_StoreApi_Schemas_ExtendSchema {
	rt.PhpObjectBase
pub mut:
	endpoints            rt.PhpVal = rt.new_array()
	formatters           rt.PhpVal = rt.new_null()
	extend_data          rt.PhpVal = rt.new_array()
	callback_methods     rt.PhpVal = rt.new_array()
	payment_requirements rt.PhpVal = rt.new_array()
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_ExtendSchema) construct(mut var_formatters Class_Automattic_WooCommerce_StoreApi_Formatters) {
	this.formatters = var_formatters.dup()
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_ExtendSchema) register_endpoint_data(var_args rt.PhpVal) {
	mut var_args_mutated := var_args
	var_args_mutated = rt.call_function('wp_parse_args', [var_args_mutated.dup(),
		rt.create_array([rt.ArrayItem{ key: 'endpoint', val: '' },
			rt.ArrayItem{ key: 'namespace', val: '' }, rt.ArrayItem{
				key: 'schema_callback'
				val: rt.new_null()
			}, rt.ArrayItem{ key: 'data_callback', val: rt.new_null() },
			rt.ArrayItem{ key: 'schema_type', val: rt.get_constant('ARRAY_A') }])])
	if rt.is_true(rt.new_bool(
		rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_args_mutated.array_get('namespace').is_string())))))
		|| !rt.is_true(var_args_mutated.array_get('namespace'))))
	{
		this.throw_exception(rt.new_string('You must provide a plugin namespace when extending a Store REST endpoint.'))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
		var_args_mutated.array_get('endpoint'),
		this.endpoints,
		rt.new_bool(true),
	])))))
	{
		this.throw_exception(rt.call_function('sprintf', [
			rt.new_string('You must provide a valid Store REST endpoint to extend, valid endpoints are: %1$s. You provided %2$s.'),
			rt.call_function('implode', [rt.new_string(', '), this.endpoints]),
			var_args_mutated.array_get('endpoint'),
		]))
	}
	if rt.is_true(rt.new_bool(
		rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_args_mutated.array_get('schema_callback').is_null())))))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_callable', [var_args_mutated.array_get('schema_callback')])))))))
	{
		this.throw_exception(rt.new_string('$schema_callback must be a callable function.'))
	}
	if rt.is_true(rt.new_bool(
		rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_args_mutated.array_get('data_callback').is_null())))))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_callable', [var_args_mutated.array_get('data_callback')])))))))
	{
		this.throw_exception(rt.new_string('$data_callback must be a callable function.'))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
		var_args_mutated.array_get('schema_type'),
		rt.create_array([rt.ArrayItem{ key: none, val: rt.get_constant('ARRAY_N') },
			rt.ArrayItem{ key: none, val: rt.get_constant('ARRAY_A') }]),
		rt.new_bool(true),
	])))))
	{
		this.throw_exception(rt.call_function('sprintf', [
			rt.new_string('Data type must be either ARRAY_N for a numeric array or ARRAY_A for an object like array. You provided %1$s.'),
			var_args_mutated.array_get('schema_type'),
		]))
	}
	this.extend_data.array_get_mut(var_args_mutated.array_get('endpoint')).array_set(var_args_mutated.array_get('namespace'), rt.create_array([
		rt.ArrayItem{ key: 'schema_callback', val: var_args_mutated.array_get('schema_callback') },
		rt.ArrayItem{ key: 'data_callback', val: var_args_mutated.array_get('data_callback') },
		rt.ArrayItem{ key: 'schema_type', val: var_args_mutated.array_get('schema_type') },
	]))
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_ExtendSchema) register_update_callback(var_args rt.PhpVal) {
	mut var_args_mutated := var_args
	var_args_mutated = rt.call_function('wp_parse_args', [var_args_mutated.dup(),
		rt.create_array([rt.ArrayItem{ key: 'namespace', val: '' },
			rt.ArrayItem{ key: 'callback', val: rt.new_null() }])])
	if rt.is_true(rt.new_bool(
		rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_args_mutated.array_get('namespace').is_string())))))
		|| !rt.is_true(var_args_mutated.array_get('namespace'))))
	{
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_StoreApi_Schemas_Exception',
			[]string{},
			create_automattic_woocommerce_storeapi_schemas_exception(rt.new_string('You must provide a plugin namespace when extending a Store REST endpoint.'))))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_callable', [
		var_args_mutated.array_get('callback'),
	])))))
	{
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_StoreApi_Schemas_Exception',
			[]string{},
			create_automattic_woocommerce_storeapi_schemas_exception(rt.new_string('There is no valid callback supplied to register_update_callback.'))))
	}
	this.callback_methods.array_set(var_args_mutated.array_get('namespace'), var_args_mutated.dup())
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_ExtendSchema) register_payment_requirements(var_args rt.PhpVal) {
	mut var_args_mutated := var_args
	if rt.is_true(rt.new_bool(!rt.is_true(var_args_mutated.array_get('data_callback'))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_callable', [var_args_mutated.array_get('data_callback')])))))))
	{
		this.throw_exception(rt.new_string('$data_callback must be a callable function.'))
	}
	this.payment_requirements.array_push(var_args_mutated.array_get('data_callback'))
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_ExtendSchema) get_formatter(var_name rt.PhpVal) rt.PhpVal {
	return rt.get_property(this.formatters, '{"nodeType":"Expr_Variable","line":185,"name":"name"}')
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_ExtendSchema) get_update_callback(var_namespace rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_namespace.dup().is_string()))))) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_StoreApi_Schemas_Exception',
			[]string{},
			create_automattic_woocommerce_storeapi_schemas_exception(rt.new_string('You must provide a plugin namespace when extending a Store REST endpoint.'))))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(this.callback_methods.array_isset(var_namespace.dup())))))) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_StoreApi_Schemas_Exception',
			[]string{}, create_automattic_woocommerce_storeapi_schemas_exception(rt.call_function('sprintf', [
			rt.new_string('There is no such namespace registered: %1$s.'),
			var_namespace.dup(),
		]))))
	}
	if rt.is_true(rt.new_bool(
		rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(this.callback_methods.array_get(var_namespace).array_isset(rt.new_string('callback')))))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_callable', [this.callback_methods.array_get(var_namespace).array_get('callback')])))))))
	{
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_StoreApi_Schemas_Exception',
			[]string{}, create_automattic_woocommerce_storeapi_schemas_exception(rt.call_function('sprintf', [
			rt.new_string('There is no valid callback registered for: %1$s.'),
			var_namespace.dup(),
		]))))
	}
	return this.callback_methods.array_get(var_namespace).array_get('callback')
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_ExtendSchema) get_endpoint_data(var_endpoint rt.PhpVal, mut var_passed_args Class_Automattic_WooCommerce_StoreApi_Schemas_array) rt.PhpVal {
	mut var_registered_data := rt.new_array()
	if this.extend_data.array_isset(var_endpoint) {
		{
			mut iter_1 := this.extend_data.array_get(var_endpoint).iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_callbacks := item_1.val
				mut var_namespace := item_1.key
				if rt.is_true(rt.new_bool(var_callbacks.array_get('data_callback').is_null())) {
					continue
				}
				mut var_data := rt.call_callable(var_callbacks.array_get('data_callback'), [
					var_passed_args,
				])
				if rt.has_exception() {
					unsafe {
						goto catch_label_1
					}
				}
				if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_data.dup().is_array()))))) {
					var_data = rt.new_array()
					if rt.has_exception() {
						unsafe {
							goto catch_label_1
						}
					}
					rt.throw_exception(rt.new_object('Automattic_WooCommerce_StoreApi_Schemas_Exception',
						[]string{},
						create_automattic_woocommerce_storeapi_schemas_exception(rt.new_string('$data_callback must return an array.'))))
					if rt.has_exception() {
						unsafe {
							goto catch_label_1
						}
					}
				}
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
				if rt.instance_of(var_e_1, 'Automattic_WooCommerce_StoreApi_Schemas_Throwable') {
					mut var_e := var_e_1.dup()
					this.throw_exception(var_e.dup())
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
				var_registered_data.array_set(var_namespace, var_data.dup())
			}
		}
	}
	return
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_ExtendSchema) get_endpoint_schema(var_endpoint rt.PhpVal, mut var_passed_args Class_Automattic_WooCommerce_StoreApi_Schemas_array) rt.PhpVal {
	mut var_registered_schema := rt.new_array()
	if this.extend_data.array_isset(var_endpoint) {
		{
			mut iter_1 := this.extend_data.array_get(var_endpoint).iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_callbacks := item_1.val
				mut var_namespace := item_1.key
				if rt.is_true(rt.new_bool(var_callbacks.array_get('schema_callback').is_null())) {
					continue
				}
				mut var_schema := rt.call_callable(var_callbacks.array_get('schema_callback'), [
					var_passed_args,
				])
				if rt.has_exception() {
					unsafe {
						goto catch_label_2
					}
				}
				if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_schema.dup().is_array()))))) {
					var_schema = rt.new_array()
					if rt.has_exception() {
						unsafe {
							goto catch_label_2
						}
					}
					rt.throw_exception(rt.new_object('Automattic_WooCommerce_StoreApi_Schemas_Exception',
						[]string{},
						create_automattic_woocommerce_storeapi_schemas_exception(rt.new_string('$schema_callback must return an array.'))))
					if rt.has_exception() {
						unsafe {
							goto catch_label_2
						}
					}
				}
				if rt.has_exception() {
					unsafe {
						goto catch_label_2
					}
				}
				unsafe {
					goto end_label_2
				}
				catch_label_2:
				mut var_e_2 := rt.get_and_clear_exception()
				if rt.instance_of(var_e_2, 'Automattic_WooCommerce_StoreApi_Schemas_Throwable') {
					mut var_e := var_e_2.dup()
					this.throw_exception(var_e.dup())
					unsafe {
						goto end_label_2
					}
				} else {
					rt.throw_exception(var_e_2)
					unsafe {
						goto end_label_2
					}
				}

				end_label_2:
				var_registered_schema.array_set(var_namespace, this.format_extensions_properties(var_namespace.dup(),
					var_schema.dup(), var_callbacks.array_get('schema_type')))
			}
		}
	}
	return
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_ExtendSchema) get_payment_requirements(mut var_requirements Class_Automattic_WooCommerce_StoreApi_Schemas_array) rt.PhpVal {
	mut var_requirements_mutated := var_requirements
	if !(!rt.is_true(this.payment_requirements)) {
		{
			mut iter_1 := this.payment_requirements.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_callback := item_1.val
				mut var_data := rt.call_callable(var_callback, []rt.PhpVal{})
				if rt.has_exception() {
					unsafe {
						goto catch_label_3
					}
				}
				if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_data.dup().is_array()))))) {
					rt.throw_exception(rt.new_object('Automattic_WooCommerce_StoreApi_Schemas_Exception',
						[]string{},
						create_automattic_woocommerce_storeapi_schemas_exception(rt.new_string('$data_callback must return an array.'))))
					if rt.has_exception() {
						unsafe {
							goto catch_label_3
						}
					}
				}
				if rt.has_exception() {
					unsafe {
						goto catch_label_3
					}
				}
				var_requirements_mutated = rt.call_function('array_unique', [
					rt.call_function('array_merge', [var_requirements_mutated.dup(),
						var_data.dup()]),
				])
				if rt.has_exception() {
					unsafe {
						goto catch_label_3
					}
				}
				unsafe {
					goto end_label_3
				}
				catch_label_3:
				mut var_e_3 := rt.get_and_clear_exception()
				if rt.instance_of(var_e_3, 'Automattic_WooCommerce_StoreApi_Schemas_Throwable') {
					mut var_e := var_e_3.dup()
					this.throw_exception(var_e.dup())
					unsafe {
						goto end_label_3
					}
				} else {
					rt.throw_exception(var_e_3)
					unsafe {
						goto end_label_3
					}
				}

				end_label_3:
			}
		}
	}
	return rt.new_object('Automattic_WooCommerce_StoreApi_Schemas_array', []string{},
		var_requirements_mutated)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_ExtendSchema) throw_exception(var_exception_or_error rt.PhpVal) {
	mut var_exception := if rt.is_true(rt.new_bool(var_exception_or_error.dup().is_string())) {
		create_automattic_woocommerce_storeapi_schemas_exception(var_exception_or_error.dup())
	} else {
		var_exception_or_error
	}
	rt.call_function('wc_caught_exception', [var_exception.dup()])
	if rt.is_true(rt.new_bool(
		rt.is_true(rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('WP_DEBUG')]))
		&& rt.is_true(rt.get_constant('WP_DEBUG'))))
		&& rt.is_true(rt.call_function('current_user_can', [rt.new_string('manage_woocommerce')]))))
	{
		rt.throw_exception(var_exception)
	}
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_ExtendSchema) format_extensions_properties(var_namespace rt.PhpVal, var_schema rt.PhpVal, var_schema_type rt.PhpVal) rt.PhpVal {
	mut var_schema_mutated := var_schema
	if rt.is_true(rt.identical(rt.get_constant('ARRAY_N'), var_schema_type)) {
		return rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('sprintf', [
				rt.call_function('__', [rt.new_string('Extension data registered by %s'),
					rt.new_string('woocommerce')]),
				var_namespace.dup(),
			]) },
			rt.ArrayItem{ key: 'type', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'array' },
				rt.ArrayItem{ key: none, val: 'null' },
			]) },
			rt.ArrayItem{ key: 'context', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'view' },
				rt.ArrayItem{ key: none, val: 'edit' },
			]) },
			rt.ArrayItem{ key: 'items', val: var_schema_mutated },
		])
	}
	return rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('sprintf', [
			rt.call_function('__', [rt.new_string('Extension data registered by %s'),
				rt.new_string('woocommerce')]),
			var_namespace.dup(),
		]) },
		rt.ArrayItem{ key: 'type', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'object' },
			rt.ArrayItem{ key: none, val: 'null' },
		]) },
		rt.ArrayItem{ key: 'context', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'view' },
			rt.ArrayItem{ key: none, val: 'edit' },
		]) },
		rt.ArrayItem{ key: 'properties', val: var_schema_mutated },
	])
}

struct Class_Automattic_WooCommerce_StoreApi_Schemas_Exception {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_storeapi_schemas_extendschema(arg_0 rt.PhpVal) &Class_Automattic_WooCommerce_StoreApi_Schemas_ExtendSchema {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Schemas_ExtendSchema{
		PhpObjectBase:        rt.PhpObjectBase{}
		endpoints:            rt.new_array()
		formatters:           rt.new_null()
		extend_data:          rt.new_array()
		callback_methods:     rt.new_array()
		payment_requirements: rt.new_array()
	}
	obj.construct(arg_0)
	return obj
}

fn create_automattic_woocommerce_storeapi_schemas_exception() &Class_Automattic_WooCommerce_StoreApi_Schemas_Exception {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Schemas_Exception{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_ExtendSchema) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Formatters](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.construct(mut dispatch_arg_0)
			return rt.new_null()
		}
		'register_endpoint_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.register_endpoint_data(dispatch_arg_0)
			return rt.new_null()
		}
		'register_update_callback' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.register_update_callback(dispatch_arg_0)
			return rt.new_null()
		}
		'register_payment_requirements' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.register_payment_requirements(dispatch_arg_0)
			return rt.new_null()
		}
		'get_formatter' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_formatter(dispatch_arg_0)
		}
		'get_update_callback' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_update_callback(dispatch_arg_0)
		}
		'get_endpoint_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Schemas_array](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			return this.get_endpoint_data(dispatch_arg_0, mut dispatch_arg_1)
		}
		'get_endpoint_schema' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Schemas_array](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			return this.get_endpoint_schema(dispatch_arg_0, mut dispatch_arg_1)
		}
		'get_payment_requirements' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Schemas_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.get_payment_requirements(mut dispatch_arg_0)
		}
		'throw_exception' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.throw_exception(dispatch_arg_0)
			return rt.new_null()
		}
		'format_extensions_properties' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.format_extensions_properties(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Schemas_ExtendSchema) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'endpoints' { return this.endpoints }
		'formatters' { return this.formatters }
		'extend_data' { return this.extend_data }
		'callback_methods' { return this.callback_methods }
		'payment_requirements' { return this.payment_requirements }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_ExtendSchema) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'endpoints' {
			this.endpoints = val
			return true
		}
		'formatters' {
			this.formatters = val
			return true
		}
		'extend_data' {
			this.extend_data = val
			return true
		}
		'callback_methods' {
			this.callback_methods = val
			return true
		}
		'payment_requirements' {
			this.payment_requirements = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_Exception) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Schemas_Exception) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_Exception) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn init_registry() {
}

fn init() {
	init_registry()
}

pub fn init_wp_content_plugins_woocommerce_src_storeapi_schemas_extendschema_php() {
}
