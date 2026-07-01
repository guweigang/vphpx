import rt

struct Class_WC_Product_Factory {
	rt.PhpObjectBase
}

fn (mut this Class_WC_Product_Factory) get_product(product_id bool, var_deprecated rt.PhpVal) bool {
	mut product_id_mutated := product_id
	product_id_mutated = (// unsupported expression: Expr_Cast_Int).to_bool()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(product_id_mutated))))) {
		return false
	}
	mut var_use_product_cache := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Utilities_FeaturesUtil{}; return temp.feature_is_enabled(arg_0) }(rt.new_string('product_instance_caching'))
	if rt.is_true(rt.new_bool(rt.is_true(var_use_product_cache) && !rt.is_true(var_deprecated))) {
		mut var_product_cache := rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Internal_Caches_ProductCache.class()])
		mut var_product := rt.call_method(var_product_cache, 'get', [rt.new_bool(product_id_mutated).dup()])
		if rt.is_true(var_product) {
			return (var_product).to_bool()
		}
	}
	rt.call_function('_prime_post_caches', [rt.create_array([rt.ArrayItem{ key: none, val: product_id_mutated }])])
	mut var_product_type := Class_WC_Product_Factory.get_product_type(rt.new_bool(product_id_mutated))
	if !(!rt.is_true(var_deprecated)) {
		rt.call_function('wc_deprecated_argument', [rt.new_string('args'), rt.new_string('3.0'), rt.new_string('Passing args to the product factory is deprecated. If you need to force a type, construct the product class directly.')])
		if var_deprecated.array_isset(rt.new_string('product_type')) {
			var_product_type = Class_WC_Product_Factory.get_classname_from_product_type(var_deprecated.array_get('product_type'))
		}
	}
	mut var_classname := Class_WC_Product_Factory.get_product_classname(rt.new_bool(product_id_mutated), var_product_type.dup())
	var_product = rt.create_object_dynamically(var_classname, [rt.new_bool(product_id_mutated).dup(), var_deprecated.dup()])
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(var_use_product_cache) && !(var_product_cache).is_null())) && rt.is_true(rt.new_bool(rt.instance_of(var_product, 'WC_Product'))))) {
		rt.call_method(var_product_cache, 'set', [var_product.dup()])
		if rt.has_exception() { unsafe { goto catch_label_1 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	return (var_product).to_bool()
	unsafe { goto end_label_1 }

catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'Exception') {
		mut var_e := var_e_1.dup()
		return false
		unsafe { goto end_label_1 }
	}
	else {
		rt.throw_exception(var_e_1)
		unsafe { goto end_label_1 }
	}

end_label_1:
	return false
}

fn Class_WC_Product_Factory.get_product_classname(var_product_id rt.PhpVal, var_product_type rt.PhpVal) rt.PhpVal {
	mut var_product_id_mutated := var_product_id
	mut var_product_type_mutated := var_product_type
	mut var_classname := rt.call_function('apply_filters', [rt.new_string('woocommerce_product_class'), Class_WC_Product_Factory.get_classname_from_product_type(var_product_type_mutated.dup()), var_product_type_mutated.dup(), if rt.is_true(rt.identical(Class_Automattic_WooCommerce_Enums_ProductType.variation(), var_product_type_mutated)) { rt.new_string('product_variation') } else { rt.new_string('product') }, var_product_id_mutated.dup()])
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_classname)))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [var_classname.dup()]))))))) {
		var_classname = rt.new_string(rt.new_string('WC_Product_Simple'))
	}
	return var_classname.dup()
}

fn Class_WC_Product_Factory.get_product_type(var_product_id rt.PhpVal) rt.PhpVal {
	mut var_product_id_mutated := var_product_id
	mut var_override := rt.call_function('apply_filters', [rt.new_string('woocommerce_product_type_query'), rt.new_bool(false), var_product_id_mutated.dup()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_override)))) {
		return rt.call_method(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Data_Store{}; return temp.load(arg_0) }(rt.new_string('product')), 'get_product_type', [var_product_id_mutated.dup()])
	} else {
		return var_override.dup()
	}
	return rt.new_null()
}

fn Class_WC_Product_Factory.get_classname_from_product_type(var_product_type rt.PhpVal) rt.PhpVal {
	mut var_product_type_mutated := var_product_type
	return if rt.is_true(var_product_type_mutated) { 'WC_Product_' + (rt.call_function('implode', [rt.new_string('_'), rt.call_function('array_map', [rt.new_string('ucfirst'), rt.call_function('explode', [rt.new_string('-'), var_product_type_mutated.dup()])])])).str() } else { rt.new_bool(false) }
}

fn (mut this Class_WC_Product_Factory) get_product_id(var_product rt.PhpVal) bool {
	mut var_post := rt.new_null()
	mut var_product_mutated := var_product
	// unsupported statement: Stmt_Global
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_bool(false), var_product_mutated)) && !(var_post).is_null() && !(rt.get_property(var_post, 'ID')).is_null())) && rt.is_true(rt.identical(rt.new_string('product'), rt.call_function('get_post_type', [rt.get_property(var_post, 'ID')]))))) {
		return (rt.call_function('absint', [rt.get_property(var_post, 'ID')])).to_bool()
	} else if rt.is_true(rt.new_bool(var_product_mutated.dup().is_long() || var_product_mutated.dup().is_double())) {
		return (var_product_mutated).to_bool()
	} else if rt.is_true(rt.new_bool(rt.instance_of(var_product_mutated, 'WC_Product'))) {
		return (rt.call_method(var_product_mutated, 'get_id', []rt.PhpVal{})).to_bool()
	} else if !(!rt.is_true(rt.get_property(var_product_mutated, 'ID'))) {
		return (rt.get_property(var_product_mutated, 'ID')).to_bool()
	} else {
		return false
	}
	return false
}

struct Class_Automattic_WooCommerce_Utilities_FeaturesUtil {
	rt.PhpObjectBase
}

struct Class_WC_Data_Store {
	rt.PhpObjectBase
}

fn create_wc_product_factory() &Class_WC_Product_Factory {
	mut obj := &Class_WC_Product_Factory{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_utilities_featuresutil() &Class_Automattic_WooCommerce_Utilities_FeaturesUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_FeaturesUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_data_store() &Class_WC_Data_Store {
	mut obj := &Class_WC_Data_Store{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Product_Factory) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_product' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(this.get_product(dispatch_arg_0, dispatch_arg_1))
		}
		'get_product_classname' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_WC_Product_Factory.get_product_classname(dispatch_arg_0, dispatch_arg_1)
		}
		'get_product_type' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_Product_Factory.get_product_type(dispatch_arg_0)
		}
		'get_classname_from_product_type' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_Product_Factory.get_classname_from_product_type(dispatch_arg_0)
		}
		'get_product_id' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.get_product_id(dispatch_arg_0))
		}
		else { return none }
	}
}

fn (this &Class_WC_Product_Factory) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Product_Factory) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Utilities_FeaturesUtil) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Utilities_FeaturesUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_FeaturesUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Data_Store) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Data_Store) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Data_Store) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn init_registry() {
	rt.register_class_factory('WC_Product_Factory', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wc_product_factory()
		return rt.new_object('WC_Product_Factory', []string{}, obj)
	})
	rt.register_class_factory('Automattic_WooCommerce_Utilities_FeaturesUtil', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_utilities_featuresutil()
		return rt.new_object('Automattic_WooCommerce_Utilities_FeaturesUtil', []string{}, obj)
	})
	rt.register_class_factory('WC_Data_Store', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wc_data_store()
		return rt.new_object('WC_Data_Store', []string{}, obj)
	})
}

fn init() {
	init_registry()
}



pub fn init_wp_content_plugins_woocommerce_includes_class_wc_product_factory_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
