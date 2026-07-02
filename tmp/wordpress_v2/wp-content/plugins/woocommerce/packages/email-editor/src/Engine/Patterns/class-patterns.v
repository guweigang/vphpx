import rt

struct Class_Automattic_WooCommerce_EmailEditor_Engine_Patterns_Patterns {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Patterns_Patterns) initialize() {
	this.register_block_pattern_categories()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Patterns_Patterns) register_block_pattern_categories() {
	mut var_categories := rt.create_array([
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'name', val: 'email-contents' },
			rt.ArrayItem{ key: 'label', val: rt.call_function('_x', [
				rt.new_string('Email Contents'),
				rt.new_string('Block pattern category'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('A collection of email content layouts.'),
				rt.new_string('woocommerce'),
			]) },
		]) },
	])
	mut iter_1 := var_categories.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_category := item_1.val
		rt.call_function('register_block_pattern_category', [
			var_category.array_get(rt.new_string('name')),
			rt.create_array([
				rt.ArrayItem{ key: 'label', val: var_category.array_get(rt.new_string('label')) },
				rt.ArrayItem{
					key: 'description'
					val: if !(var_category.array_get(rt.new_string('description'))).is_null() {
						var_category.array_get(rt.new_string('description'))
					} else {
						rt.new_string('')
					}
				},
			]),
		])
	}
}

fn create_automattic_woocommerce_emaileditor_engine_patterns_patterns(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditor_Engine_Patterns_Patterns {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Engine_Patterns_Patterns{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Patterns_Patterns) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'initialize' {
			this.initialize()
			return rt.new_null()
		}
		'register_block_pattern_categories' {
			this.register_block_pattern_categories()
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Engine_Patterns_Patterns) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Patterns_Patterns) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
