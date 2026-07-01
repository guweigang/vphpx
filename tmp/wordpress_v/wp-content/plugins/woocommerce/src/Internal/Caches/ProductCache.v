import rt

struct Class_Automattic_WooCommerce_Internal_Caches_ProductCache {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Internal_Caches_ProductCache) get_object_type() string {
	return 'product_objects'
}

fn (mut this Class_Automattic_WooCommerce_Internal_Caches_ProductCache) get_object_id(var_product rt.PhpVal) rt.PhpVal {
	mut var_product_mutated := var_product
	return rt.call_method(var_product_mutated, 'get_id', []rt.PhpVal{})
}

fn (mut this Class_Automattic_WooCommerce_Internal_Caches_ProductCache) validate(var_product rt.PhpVal) rt.PhpVal {
	mut var_product_mutated := var_product
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_product_mutated, 'WC_Product')))))) {
		return rt.create_array([rt.ArrayItem{ key: none, val: 'The supplied product is not an instance of WC_Product' }])
	}
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Caches_ProductCache) set(var_product rt.PhpVal, var_id rt.PhpVal, expiration i64) bool {
	mut var_product_mutated := var_product
	mut var_id_mutated := var_id
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		var_id_mutated = // unsupported expression: Expr_Cast_Int
	}
	mut var_original_mode := rt.call_method(var_product_mutated, 'get_clone_mode', []rt.PhpVal{})
	rt.call_method(var_product_mutated, 'set_clone_mode', [Class_Automattic_WooCommerce_Internal_Caches_WC_Data.clone_mode_cache()])
	mut var_result := this.Class_Automattic_WooCommerce_Caching_ObjectCache.set(var_product_mutated.dup(), var_id_mutated.dup(), rt.new_int(expiration))
	rt.call_method(var_product_mutated, 'set_clone_mode', [var_original_mode.dup()])
	return (var_result).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Caches_ProductCache) remove(var_id rt.PhpVal) bool {
	mut var_id_mutated := var_id
	return (this.Class_Automattic_WooCommerce_Caching_ObjectCache.remove(// unsupported expression: Expr_Cast_Int)).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Caches_ProductCache) get(var_id rt.PhpVal, expiration i64, mut var_get_from_datastore_callback Class_Automattic_WooCommerce_Internal_Caches_?callable) rt.PhpVal {
	mut var_id_mutated := var_id
	var_id_mutated = // unsupported expression: Expr_Cast_Int
	mut var_product := this.Class_Automattic_WooCommerce_Caching_ObjectCache.get(var_id_mutated.dup(), rt.new_int(expiration), rt.new_object('Automattic_WooCommerce_Internal_Caches_?callable', []string{}, var_get_from_datastore_callback))
	if rt.is_true(rt.new_bool(rt.instance_of(var_product, 'WC_Product'))) {
		rt.call_method(var_product, 'set_clone_mode', [Class_Automattic_WooCommerce_Internal_Caches_WC_Data.clone_mode_duplicate()])
		return var_product.dup()
	}
	return rt.new_null()
}

struct Class_Automattic_WooCommerce_Caching_ObjectCache {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_caches_productcache() &Class_Automattic_WooCommerce_Internal_Caches_ProductCache {
	mut obj := &Class_Automattic_WooCommerce_Internal_Caches_ProductCache{
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

fn (mut this Class_Automattic_WooCommerce_Internal_Caches_ProductCache) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
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
		'set' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_i64()
			return rt.new_bool(this.set(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2))
		}
		'remove' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.remove(dispatch_arg_0))
		}
		'get' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Caches_?callable](if args.len > 2 { args[2] } else { rt.new_null() })
			return this.get(dispatch_arg_0, dispatch_arg_1, mut dispatch_arg_2)
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Caches_ProductCache) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Caches_ProductCache) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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




pub fn init_wp_content_plugins_woocommerce_src_internal_caches_productcache_php() {
	// unsupported statement: Stmt_Declare
}
