import rt

struct Class_Automattic_WooCommerce_Caches_OrderCacheController {
	rt.PhpObjectBase
pub mut:
		order_cache rt.PhpVal = rt.new_null()
		features_controller rt.PhpVal = rt.new_null()
		orders_cache_usage_backup rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Caches_OrderCacheController) init(mut var_order_cache Class_Automattic_WooCommerce_Caches_OrderCache)  {
	this.order_cache = var_order_cache.dup()
}

fn (mut this Class_Automattic_WooCommerce_Caches_OrderCacheController) orders_cache_usage_is_enabled() bool {
	return (fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Utilities_OrderUtil{}; return temp.custom_orders_table_usage_is_enabled() }()).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Caches_OrderCacheController) temporarily_disable_orders_cache_usage()  {
	if this.orders_cache_usage_is_temporarly_disabled() {
		return rt.new_null()
	}
	this.orders_cache_usage_backup = this.orders_cache_usage_is_enabled()
}

fn (mut this Class_Automattic_WooCommerce_Caches_OrderCacheController) orders_cache_usage_is_temporarly_disabled() bool {
	return (// unsupported expression: Expr_BinaryOp_NotIdentical).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Caches_OrderCacheController) maybe_restore_orders_cache_usage()  {
	this.orders_cache_usage_backup = rt.new_null()
}

struct Class_Automattic_WooCommerce_Utilities_OrderUtil {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_caches_ordercachecontroller() &Class_Automattic_WooCommerce_Caches_OrderCacheController {
	mut obj := &Class_Automattic_WooCommerce_Caches_OrderCacheController{
		PhpObjectBase: rt.PhpObjectBase{}
		order_cache: rt.new_null()
		features_controller: rt.new_null()
		orders_cache_usage_backup: rt.new_null()
	}
	return obj
}

fn create_automattic_woocommerce_utilities_orderutil() &Class_Automattic_WooCommerce_Utilities_OrderUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_OrderUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Caches_OrderCacheController) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'init' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Caches_OrderCache](if args.len > 0 { args[0] } else { rt.new_null() })
			this.init(mut dispatch_arg_0)
			return rt.new_null()
		}
		'orders_cache_usage_is_enabled' {
			return rt.new_bool(this.orders_cache_usage_is_enabled())
		}
		'temporarily_disable_orders_cache_usage' {
			this.temporarily_disable_orders_cache_usage()
			return rt.new_null()
		}
		'orders_cache_usage_is_temporarly_disabled' {
			return rt.new_bool(this.orders_cache_usage_is_temporarly_disabled())
		}
		'maybe_restore_orders_cache_usage' {
			this.maybe_restore_orders_cache_usage()
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Caches_OrderCacheController) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'order_cache' { return this.order_cache }
		'features_controller' { return this.features_controller }
		'orders_cache_usage_backup' { return this.orders_cache_usage_backup }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Caches_OrderCacheController) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'order_cache' { this.order_cache = val; return true }
		'features_controller' { this.features_controller = val; return true }
		'orders_cache_usage_backup' { this.orders_cache_usage_backup = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_Utilities_OrderUtil) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Utilities_OrderUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_OrderUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_caches_ordercachecontroller_php() {
}
