import rt

struct Class_Automattic_WooCommerce_Internal_EmailEditor_EmailPatterns_PatternsController {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_EmailPatterns_PatternsController) init() {
	this.register_patterns()
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_EmailPatterns_PatternsController) register_patterns() {
	mut var_patterns := rt.new_array()
	var_patterns.array_push(create_automattic_woocommerce_internal_emaileditor_emailpatterns_wooemailcontentpattern())
	mut iter_1 := var_patterns.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_pattern := item_1.val
		rt.call_function('register_block_pattern', [
			rt.new_string((rt.call_method(var_pattern, 'get_namespace', []rt.PhpVal{})).str() +
				'/' + (rt.call_method(var_pattern, 'get_name', []rt.PhpVal{})).str()),
			rt.call_method(var_pattern, 'get_properties', []rt.PhpVal{}),
		])
	}
}

struct Class_Automattic_WooCommerce_Internal_EmailEditor_EmailPatterns_WooEmailContentPattern {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_emaileditor_emailpatterns_patternscontroller(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_EmailEditor_EmailPatterns_PatternsController {
	mut obj := &Class_Automattic_WooCommerce_Internal_EmailEditor_EmailPatterns_PatternsController{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_emaileditor_emailpatterns_wooemailcontentpattern(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_EmailEditor_EmailPatterns_WooEmailContentPattern {
	mut obj := &Class_Automattic_WooCommerce_Internal_EmailEditor_EmailPatterns_WooEmailContentPattern{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_EmailPatterns_PatternsController) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'init' {
			this.init()
			return rt.new_null()
		}
		'register_patterns' {
			this.register_patterns()
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_EmailEditor_EmailPatterns_PatternsController) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_EmailPatterns_PatternsController) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_EmailPatterns_WooEmailContentPattern) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_EmailEditor_EmailPatterns_WooEmailContentPattern) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_EmailPatterns_WooEmailContentPattern) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}
