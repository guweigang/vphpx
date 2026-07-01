import rt

struct Class_WC_Product_Usage {
	rt.PhpObjectBase
}

fn Class_WC_Product_Usage.load() {
	Class_WC_Product_Usage.includes()
}

fn Class_WC_Product_Usage.includes() {
	rt.include_file(
		(rt.get_constant('WC_ABSPATH')).str() + 'includes/product-usage/class-wc-product-usage-rule-set.php',
		'4')
}

fn Class_WC_Product_Usage.get_rules_for_product(product_id i64) rt.PhpVal {
	mut var_rules := Class_WC_Product_Usage.get_product_usage_restriction_rule(product_id)
	if rt.is_true(rt.identical(rt.new_null(), var_rules)) {
		return rt.new_null()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal {
		mut temp := Class_WC_Helper{}
		return temp.has_product_subscription(arg_0)
	}(rt.new_int(product_id))))))
	{
		return create_wc_product_usage_rule_set(var_rules.dup())
	}
	mut var_subscriptions := rt.call_function('wp_list_filter', [
		fn () rt.PhpVal {
			mut temp := Class_WC_Helper{}
			return temp.get_installed_subscriptions()
		}(),
		rt.create_array([rt.ArrayItem{ key: 'product_id', val: product_id }])])
	if !rt.is_true(var_subscriptions) {
		return create_wc_product_usage_rule_set(var_rules.dup())
	}
	mut var_product_subscription := rt.call_function('current', [
		var_subscriptions.dup()])
	if rt.is_true(var_product_subscription.array_get('expired')) {
		return create_wc_product_usage_rule_set(var_rules.dup())
	}
	return rt.new_null()
}

fn Class_WC_Product_Usage.get_product_usage_restriction_rule(product_id i64) rt.PhpVal {
	mut var_rules := fn () rt.PhpVal {
		mut temp := Class_WC_Helper{}
		return temp.get_product_usage_notice_rules()
	}()
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
	if rt.instance_of(var_e_1, 'Exception') {
		mut var_e := var_e_1.dup()
		return rt.new_null()
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
	if !rt.is_true(var_rules.array_get('restricted_products').array_get(product_id)) {
		return rt.new_null()
	}
	return var_rules.array_get('restricted_products').array_get(product_id)
}

struct Class_WC_Helper {
	rt.PhpObjectBase
}

struct Class_WC_Product_Usage_Rule_Set {
	rt.PhpObjectBase
}

fn create_wc_product_usage() &Class_WC_Product_Usage {
	mut obj := &Class_WC_Product_Usage{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_helper() &Class_WC_Helper {
	mut obj := &Class_WC_Helper{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_product_usage_rule_set() &Class_WC_Product_Usage_Rule_Set {
	mut obj := &Class_WC_Product_Usage_Rule_Set{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Product_Usage) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'load' {
			Class_WC_Product_Usage.load()
			return rt.new_null()
		}
		'includes' {
			Class_WC_Product_Usage.includes()
			return rt.new_null()
		}
		'get_rules_for_product' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			return Class_WC_Product_Usage.get_rules_for_product(dispatch_arg_0)
		}
		'get_product_usage_restriction_rule' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			return Class_WC_Product_Usage.get_product_usage_restriction_rule(dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_Product_Usage) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Product_Usage) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_Helper) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Helper) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Helper) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_Product_Usage_Rule_Set) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Product_Usage_Rule_Set) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Product_Usage_Rule_Set) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_woocommerce_includes_product_usage_class_wc_product_usage_php() {
	// unsupported statement: Stmt_Declare
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		// unsupported expression: Expr_Exit
	}
	Class_WC_Product_Usage.load()
}
