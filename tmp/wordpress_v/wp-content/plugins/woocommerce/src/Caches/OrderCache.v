import rt

struct Class_Automattic_WooCommerce_Caches_OrderCache {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Caches_OrderCache) get_object_type() string {
	if rt.is_true(rt.identical(rt.new_string('yes'), rt.call_function('get_option', [
		Class_Automattic_WooCommerce_Internal_DataStores_Orders_CustomOrdersTableController.hpos_datastore_caching_enabled_option(),
	])))
	{
		return 'order_objects'
	} else {
		return 'orders'
	}
	return ''
}

fn (mut this Class_Automattic_WooCommerce_Caches_OrderCache) get_object_id(var_object rt.PhpVal) rt.PhpVal {
	return rt.call_method(var_object, 'get_id', []rt.PhpVal{})
}

fn (mut this Class_Automattic_WooCommerce_Caches_OrderCache) validate(var_object rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_object,
		'Automattic_WooCommerce_Caches_WC_Abstract_Order'))))))
	{
		return rt.create_array([
			rt.ArrayItem{ key: none, val:
				'The supplied order is not an instance of WC_Abstract_Order, ' +
				(rt.call_function('gettype', [var_object.dup()])).str() },
		])
	}
	return rt.new_null()
}

struct Class_Automattic_WooCommerce_Caching_ObjectCache {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_caches_ordercache() &Class_Automattic_WooCommerce_Caches_OrderCache {
	mut obj := &Class_Automattic_WooCommerce_Caches_OrderCache{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_caching_objectcache() &Class_Automattic_WooCommerce_Caching_ObjectCache {
	mut obj := &Class_Automattic_WooCommerce_Caching_ObjectCache{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Caches_OrderCache) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_object_type' {
			return rt.new_string(this.get_object_type())
		}
		'get_object_id' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_object_id(dispatch_arg_0)
		}
		'validate' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.validate(dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Caches_OrderCache) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Caches_OrderCache) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Caching_ObjectCache) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Caching_ObjectCache) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Caching_ObjectCache) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_woocommerce_src_caches_ordercache_php() {
}
