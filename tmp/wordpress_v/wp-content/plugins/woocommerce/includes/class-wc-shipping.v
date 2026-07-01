import rt
import crypto.md5

struct Class_WC_Shipping {
	rt.PhpObjectBase
pub mut:
		enabled rt.PhpVal = rt.new_bool(false)
		shipping_methods rt.PhpVal = rt.new_null()
		shipping_classes rt.PhpVal = rt.new_array()
		packages rt.PhpVal = rt.new_array()
		_instance rt.PhpVal = rt.new_null()
}

fn Class_WC_Shipping.instance() rt.PhpVal {
	if rt.is_true(rt.new_bool(// unsupported expression: Expr_StaticPropertyFetch.is_null())) {
		// unsupported assign target: Expr_StaticPropertyFetch
	}
	return // unsupported expression: Expr_StaticPropertyFetch
}

fn (mut this Class_WC_Shipping) magic_clone()  {
	rt.call_function('wc_doing_it_wrong', [rt.new_string(@FN), rt.call_function('__', [rt.new_string('Cloning is forbidden.'), rt.new_string('woocommerce')]), rt.new_string('2.1')])
}

fn (mut this Class_WC_Shipping) magic_wakeup()  {
	rt.call_function('wc_doing_it_wrong', [rt.new_string(@FN), rt.call_function('__', [rt.new_string('Unserializing instances of this class is forbidden.'), rt.new_string('woocommerce')]), rt.new_string('2.1')])
}

fn (mut this Class_WC_Shipping) magic_get(var_name rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.identical(rt.new_string('shipping_total'), var_name)) {
		return rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'cart'), 'get_shipping_total', []rt.PhpVal{})
	}
	if rt.is_true(rt.identical(rt.new_string('shipping_taxes'), var_name)) {
		return rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'cart'), 'get_shipping_taxes', []rt.PhpVal{})
	}
	return rt.new_null()
}

fn (mut this Class_WC_Shipping) construct()  {
	this.enabled = rt.call_function('wc_shipping_enabled', []rt.PhpVal{})
	if rt.is_true(this.enabled) {
		this.init()
	}
}

fn (mut this Class_WC_Shipping) init()  {
	rt.call_function('do_action', [rt.new_string('woocommerce_shipping_init')])
}

fn (mut this Class_WC_Shipping) get_shipping_method_class_names() rt.PhpVal {
	mut var_shipping_methods := { 'flat_rate': 'WC_Shipping_Flat_Rate', 'free_shipping': 'WC_Shipping_Free_Shipping', 'local_pickup': 'WC_Shipping_Local_Pickup' }
	mut var_maybe_load_legacy_methods := ['flat_rate', 'free_shipping', 'international_delivery', 'local_delivery', 'local_pickup']
	closure_4_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_3_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_method := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return rt.call_function('sprintf', [rt.new_string('woocommerce_%s_settings'), var_method.dup()])
	}
	mut var_method := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return rt.call_function('sprintf', [rt.new_string('woocommerce_%s_settings'), var_method.dup()])
	}
	mut var_method := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return rt.call_function('sprintf', [rt.new_string('woocommerce_%s_settings'), var_method.dup()])
	}
	mut var_method := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return rt.call_function('sprintf', [rt.new_string('woocommerce_%s_settings'), var_method.dup()])
	}
	rt.call_function('wp_prime_option_caches', [rt.call_function('array_map', [rt.new_closure(closure_1_fn), var_maybe_load_legacy_methods.dup()])])
	for var_method in var_maybe_load_legacy_methods {
		mut var_options := rt.call_function('get_option', ['woocommerce_' + method + '_settings'])
		if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(var_options) && var_options.array_isset(rt.new_string('enabled')))) && rt.is_true(rt.identical(rt.new_string('yes'), var_options.array_get('enabled'))))) {
			var_shipping_methods['legacy_' + method] = 'WC_Shipping_Legacy_' + method
		}
	}
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_shipping_methods'), var_shipping_methods.dup()])
}

fn (mut this Class_WC_Shipping) load_shipping_methods(var_package rt.PhpVal) rt.PhpVal {
	mut var_package_mutated := var_package
	if !(!rt.is_true(var_package_mutated)) {
		mut var_debug_mode := rt.identical(rt.new_string('yes'), rt.call_function('get_option', [rt.new_string('woocommerce_shipping_debug_mode'), rt.new_string('no')]))
		mut var_shipping_zone := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Shipping_Zones{}; return temp.get_zone_matching_package(arg_0) }(var_package_mutated.dup())
		this.shipping_methods = rt.call_method(var_shipping_zone, 'get_shipping_methods', [rt.new_bool(true)])
		mut var_matched_zone_notice := rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Customer matched zone "%s"'), rt.new_string('woocommerce')]), rt.call_method(var_shipping_zone, 'get_zone_name', []rt.PhpVal{})])
		if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(var_debug_mode) && rt.is_true(rt.new_bool(!(rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_Jetpack_Constants{}; return temp.is_defined(arg_0) }(rt.new_string('WOOCOMMERCE_CHECKOUT')))))))) && rt.is_true(rt.new_bool(!(rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_Jetpack_Constants{}; return temp.is_defined(arg_0) }(rt.new_string('WC_DOING_AJAX')))))))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_has_notice', [var_matched_zone_notice.dup()]))))))) {
			rt.call_function('wc_add_notice', [var_matched_zone_notice.dup()])
		}
	} else {
		this.shipping_methods = rt.new_array()
	}
	{
		mut iter_1 := this.get_shipping_method_class_names().iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_method_class := item_1.val
			mut var_method_id := item_1.key
			this.register_shipping_method(var_method_class.dup())
		}
	}
	rt.call_function('do_action', [rt.new_string('woocommerce_load_shipping_methods'), var_package_mutated.dup()])
	return this.get_shipping_methods()
}

fn (mut this Class_WC_Shipping) register_shipping_method(var_method rt.PhpVal) bool {
	mut var_method_mutated := var_method
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_method_mutated.dup().is_object()))))) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [var_method_mutated.dup()]))))) {
			return false
		}
		var_method_mutated = rt.create_object_dynamically(var_method_mutated, []rt.PhpVal{})
	}
	if rt.is_true(rt.new_bool(this.shipping_methods.is_null())) {
		this.shipping_methods = rt.new_array()
	}
	this.shipping_methods.array_set(rt.get_property(var_method_mutated, 'id'), var_method_mutated.dup())
	return false
}

fn (mut this Class_WC_Shipping) unregister_shipping_methods()  {
	this.shipping_methods = rt.new_null()
}

fn (mut this Class_WC_Shipping) get_shipping_methods() rt.PhpVal {
	if rt.is_true(rt.new_bool(this.shipping_methods.is_null())) {
		this.load_shipping_methods(rt.new_null())
	}
	return this.shipping_methods
}

fn (mut this Class_WC_Shipping) get_shipping_classes() rt.PhpVal {
	if !rt.is_true(this.shipping_classes) {
		mut var_classes := rt.call_function('get_terms', [rt.new_string('product_shipping_class'), rt.create_array([rt.ArrayItem{ key: 'hide_empty', val: '0' }, rt.ArrayItem{ key: 'orderby', val: 'name' }])])
		this.shipping_classes = if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_classes.dup()]))))) { var_classes } else { rt.new_array() }
	}
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_get_shipping_classes'), this.shipping_classes])
}

fn (mut this Class_WC_Shipping) calculate_shipping(var_packages rt.PhpVal) rt.PhpVal {
	this.packages = rt.new_array()
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(this.enabled)))) || !rt.is_true(var_packages))) {
		return rt.new_array()
	}
	{
		mut iter_1 := var_packages.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_package := item_1.val
			mut var_package_key := item_1.key
			this.packages.array_set(var_package_key, this.calculate_shipping_for_package(var_package.dup(), (var_package_key).to_i64()))
		}
	}
	this.packages = rt.call_function('array_filter', [rt.cast_array(rt.call_function('apply_filters', [rt.new_string('woocommerce_shipping_packages'), this.packages]))])
	return this.packages
}

fn (mut this Class_WC_Shipping) is_package_shippable(var_package rt.PhpVal) bool {
	mut var_package_mutated := var_package
	if !rt.is_true(var_package_mutated.array_get('destination').array_get('country')) {
		return true
	}
	mut var_allowed := rt.func_array_keys(rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'countries'), 'get_shipping_countries', []rt.PhpVal{}))
	return (rt.call_function('in_array', [var_package_mutated.array_get('destination').array_get('country'), var_allowed.dup(), rt.new_bool(true)])).to_bool()
}

fn (mut this Class_WC_Shipping) calculate_shipping_for_package(var_package rt.PhpVal, package_key i64) bool {
	mut var_package_mutated := var_package
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(this.enabled)))) || !rt.is_true(var_package_mutated))) {
		return false
	}
	var_package_mutated.array_set('rates', rt.new_array())
	mut var_is_shippable := rt.new_bool(this.is_package_shippable(var_package_mutated.dup()))
	mut var_package_to_hash := var_package_mutated.dup()
	{
		mut iter_1 := var_package_to_hash.array_get('contents').iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_item := item_1.val
			mut var_item_id := item_1.key
			var_package_to_hash.array_get('contents').array_get(var_item_id).array_unset(rt.new_string('data'))
		}
	}
	mut var_wc_session_key := rt.new_string('shipping_for_package_' + package_key.str())
	mut var_stored_rates := rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'session'), 'get', [var_wc_session_key.dup()])
	mut var_package_hash := rt.new_string('wc_ship_' + md5.hexhash((rt.call_function('wp_json_encode', [var_package_to_hash.dup()])).str() + (fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Cache_Helper{}; return temp.get_transient_version(arg_0) }(rt.new_string('shipping'))).str()))
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_stored_rates.dup().is_array()))))) || rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) || rt.is_true(rt.identical(rt.new_string('yes'), rt.call_function('get_option', [rt.new_string('woocommerce_shipping_debug_mode'), rt.new_string('no')]))))) {
		{
			mut iter_1 := this.load_shipping_methods(var_package_mutated.dup()).iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_shipping_method := item_1.val
				if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_is_shippable)))) && rt.is_true(rt.new_bool(!(rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_StoreApi_Utilities_LocalPickupUtils{}; return temp.is_local_pickup_method(arg_0) }(rt.get_property(var_shipping_method, 'id')))))))) {
					continue
				}
				if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_shipping_method, 'supports', [rt.new_string('shipping-zones')]))))) || rt.is_true(rt.call_method(var_shipping_method, 'get_instance_id', []rt.PhpVal{})))) {
					rt.call_function('do_action', [rt.new_string('woocommerce_before_get_rates_for_package'), var_package_mutated.dup(), var_shipping_method.dup()])
					var_package_mutated.array_set('rates', rt.add(var_package_mutated.array_get('rates'), rt.call_method(var_shipping_method, 'get_rates_for_package', [var_package_mutated.dup()])))
					rt.call_function('do_action', [rt.new_string('woocommerce_after_get_rates_for_package'), var_package_mutated.dup(), var_shipping_method.dup()])
				}
			}
		}
		if rt.is_true(rt.identical(rt.new_string('yes'), rt.call_function('get_option', [rt.new_string('woocommerce_shipping_hide_rates_when_free'), rt.new_string('no')]))) {
			mut var_free_shipping := rt.new_array()
			mut var_local_pickup := rt.new_array()
			{
				mut iter_1 := var_package_mutated.array_get('rates').iterator()
				for {
					item_1 := iter_1.next() or { break }
					mut var_rate := item_1.val
					if rt.is_true(rt.identical(rt.new_string('free_shipping'), rt.get_property(var_rate, 'method_id'))) {
						var_free_shipping.array_set(rt.get_property(var_rate, 'id'), var_rate.dup())
						continue
					}
					if rt.is_true(rt.new_bool(rt.is_true(rt.call_method(this.shipping_methods.array_get(rt.get_property(var_rate, 'method_id')), 'supports', [rt.new_string('local-pickup')])) || rt.is_true(rt.identical(rt.new_string('local_pickup'), rt.get_property(var_rate, 'method_id'))))) {
						var_local_pickup.array_set(rt.get_property(var_rate, 'id'), var_rate.dup())
					}
				}
			}
			if !(!rt.is_true(var_free_shipping)) {
				var_package_mutated.array_set('rates', rt.call_function('array_merge', [var_free_shipping.dup(), var_local_pickup.dup()]))
			}
		}
		var_package_mutated.array_set('rates', rt.call_function('apply_filters', [rt.new_string('woocommerce_package_rates'), var_package_mutated.array_get('rates'), var_package_mutated.dup()]))
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_package_mutated.array_get('rates').is_array()))))) {
			var_package_mutated.array_set('rates', rt.new_array())
		}
		rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'session'), 'set', [var_wc_session_key.dup(), rt.create_array([rt.ArrayItem{ key: 'package_hash', val: var_package_hash }, rt.ArrayItem{ key: 'rates', val: var_package_mutated.array_get('rates') }])])
	} else {
		var_package_mutated.array_set('rates', var_stored_rates.array_get('rates'))
	}
	return (var_package_mutated).to_bool()
}

fn (mut this Class_WC_Shipping) get_packages() rt.PhpVal {
	return this.packages
}

fn (mut this Class_WC_Shipping) reset_shipping()  {
	rt.get_property(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'session'), 'chosen_shipping_methods') = rt.new_null()
	this.packages = rt.new_array()
}

fn (mut this Class_WC_Shipping) sort_shipping_methods() rt.PhpVal {
	rt.call_function('wc_deprecated_function', [rt.new_string('sort_shipping_methods'), rt.new_string('2.6')])
	return this.shipping_methods
}

struct Class_WC_Shipping_Zones {
	rt.PhpObjectBase
}

struct Class_Automattic_Jetpack_Constants {
	rt.PhpObjectBase
}

struct Class_WC_Cache_Helper {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_StoreApi_Utilities_LocalPickupUtils {
	rt.PhpObjectBase
}

fn create_wc_shipping() &Class_WC_Shipping {
	mut obj := &Class_WC_Shipping{
		PhpObjectBase: rt.PhpObjectBase{}
		enabled: rt.new_bool(false)
		shipping_methods: rt.new_null()
		shipping_classes: rt.new_array()
		packages: rt.new_array()
		_instance: rt.new_null()
	}
	obj.construct()
	return obj
}

fn create_wc_shipping_zones() &Class_WC_Shipping_Zones {
	mut obj := &Class_WC_Shipping_Zones{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_jetpack_constants() &Class_Automattic_Jetpack_Constants {
	mut obj := &Class_Automattic_Jetpack_Constants{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_cache_helper() &Class_WC_Cache_Helper {
	mut obj := &Class_WC_Cache_Helper{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_storeapi_utilities_localpickuputils() &Class_Automattic_WooCommerce_StoreApi_Utilities_LocalPickupUtils {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Utilities_LocalPickupUtils{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Shipping) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'instance' {
			return Class_WC_Shipping.instance()
		}
		'__clone' {
			this.magic_clone()
			return rt.new_null()
		}
		'__wakeup' {
			this.magic_wakeup()
			return rt.new_null()
		}
		'__get' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.magic_get(dispatch_arg_0)
		}
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'init' {
			this.init()
			return rt.new_null()
		}
		'get_shipping_method_class_names' {
			return this.get_shipping_method_class_names()
		}
		'load_shipping_methods' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.load_shipping_methods(dispatch_arg_0)
		}
		'register_shipping_method' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.register_shipping_method(dispatch_arg_0))
		}
		'unregister_shipping_methods' {
			this.unregister_shipping_methods()
			return rt.new_null()
		}
		'get_shipping_methods' {
			return this.get_shipping_methods()
		}
		'get_shipping_classes' {
			return this.get_shipping_classes()
		}
		'calculate_shipping' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.calculate_shipping(dispatch_arg_0)
		}
		'is_package_shippable' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.is_package_shippable(dispatch_arg_0))
		}
		'calculate_shipping_for_package' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			return rt.new_bool(this.calculate_shipping_for_package(dispatch_arg_0, dispatch_arg_1))
		}
		'get_packages' {
			return this.get_packages()
		}
		'reset_shipping' {
			this.reset_shipping()
			return rt.new_null()
		}
		'sort_shipping_methods' {
			return this.sort_shipping_methods()
		}
		else { return none }
	}
}

fn (this &Class_WC_Shipping) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'enabled' { return this.enabled }
		'shipping_methods' { return this.shipping_methods }
		'shipping_classes' { return this.shipping_classes }
		'packages' { return this.packages }
		'_instance' { return this._instance }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_Shipping) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'enabled' { this.enabled = val; return true }
		'shipping_methods' { this.shipping_methods = val; return true }
		'shipping_classes' { this.shipping_classes = val; return true }
		'packages' { this.packages = val; return true }
		'_instance' { this._instance = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_WC_Shipping_Zones) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Shipping_Zones) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Shipping_Zones) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_Jetpack_Constants) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_Jetpack_Constants) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_Jetpack_Constants) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Cache_Helper) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Cache_Helper) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Cache_Helper) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_LocalPickupUtils) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Utilities_LocalPickupUtils) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_LocalPickupUtils) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn init_registry() {
	rt.register_class_factory('WC_Shipping', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wc_shipping()
		return rt.new_object('WC_Shipping', []string{}, obj)
	})
	rt.register_class_factory('WC_Shipping_Zones', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wc_shipping_zones()
		return rt.new_object('WC_Shipping_Zones', []string{}, obj)
	})
	rt.register_class_factory('Automattic_Jetpack_Constants', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_jetpack_constants()
		return rt.new_object('Automattic_Jetpack_Constants', []string{}, obj)
	})
	rt.register_class_factory('WC_Cache_Helper', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wc_cache_helper()
		return rt.new_object('WC_Cache_Helper', []string{}, obj)
	})
	rt.register_class_factory('Automattic_WooCommerce_StoreApi_Utilities_LocalPickupUtils', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_storeapi_utilities_localpickuputils()
		return rt.new_object('Automattic_WooCommerce_StoreApi_Utilities_LocalPickupUtils', []string{}, obj)
	})
}

fn init() {
	init_registry()
}



pub fn init_wp_content_plugins_woocommerce_includes_class_wc_shipping_php() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))))) {
		// unsupported expression: Expr_Exit
	}
}
