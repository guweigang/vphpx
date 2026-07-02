import rt

struct Class_Automattic_WooCommerce_Blocks_Library {
	rt.PhpObjectBase
}

fn Class_Automattic_WooCommerce_Blocks_Library.init() {
	rt.call_function('_deprecated_function', [rt.new_string('Library::init'),
		rt.new_string('5.0.0')])
}

fn Class_Automattic_WooCommerce_Blocks_Library.define_tables() {
	rt.call_function('_deprecated_function', [rt.new_string('Library::define_tables'),
		rt.new_string('5.0.0')])
}

fn Class_Automattic_WooCommerce_Blocks_Library.register_blocks() {
	rt.call_function('_deprecated_function', [rt.new_string('Library::register_blocks'),
		rt.new_string('5.0.0')])
}

fn create_automattic_woocommerce_blocks_library(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_Library {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Library{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Library) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'init' {
			Class_Automattic_WooCommerce_Blocks_Library.init()
			return rt.new_null()
		}
		'define_tables' {
			Class_Automattic_WooCommerce_Blocks_Library.define_tables()
			return rt.new_null()
		}
		'register_blocks' {
			Class_Automattic_WooCommerce_Blocks_Library.register_blocks()
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Blocks_Library) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Library) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
