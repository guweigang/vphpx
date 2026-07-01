import rt

struct Class_WC_Autoloader {
	rt.PhpObjectBase
pub mut:
		include_path rt.PhpVal = rt.new_string('')
}

fn (mut this Class_WC_Autoloader) construct()  {
	if rt.is_true(rt.call_function('function_exists', [rt.new_string('__autoload')])) {
		rt.call_function('spl_autoload_register', [rt.new_string('__autoload')])
	}
	rt.call_function('spl_autoload_register', [rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Autoloader', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'autoload' }])])
	this.include_path = (rt.call_function('untrailingslashit', [rt.call_function('plugin_dir_path', [rt.get_constant('WC_PLUGIN_FILE')])])).str() + '/includes/'
}

fn (mut this Class_WC_Autoloader) get_file_name_from_class(var_class rt.PhpVal) string {
	mut var_class_mutated := var_class
	return 'class-' + (rt.call_function('str_replace', [rt.new_string('_'), rt.new_string('-'), var_class_mutated.dup()])).str() + '.php'
}

fn (mut this Class_WC_Autoloader) load_file(var_path rt.PhpVal) bool {
	mut var_path_mutated := var_path
	if rt.is_true(rt.new_bool(rt.is_true(var_path_mutated) && rt.is_true(rt.call_function('is_readable', [var_path_mutated.dup()])))) {
		rt.include_file((var_path_mutated).to_string(), '2')
		return true
	}
	return false
}

fn (mut this Class_WC_Autoloader) autoload(var_class rt.PhpVal)  {
	mut var_class_mutated := var_class
	var_class_mutated = rt.new_string(rt.new_string(var_class_mutated.dup().to_string().to_lower()))
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return rt.new_null()
	}
	if rt.is_true(rt.identical(rt.new_string('wc_api'), var_class_mutated)) {
		return rt.new_null()
	}
	if rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Packages{}; return temp.should_load_class(arg_0) }(var_class_mutated.dup())) {
		return rt.new_null()
	}
	mut var_file := rt.new_string(this.get_file_name_from_class(var_class_mutated.dup()))
	mut var_path := rt.new_string(rt.new_string(''))
	if rt.is_true(rt.identical(rt.new_int(0), rt.call_function('strpos', [var_class_mutated.dup(), rt.new_string('wc_addons_gateway_')]))) {
		var_path = rt.new_string((this.include_path).str() + 'gateways/' + (rt.call_function('substr', [rt.call_function('str_replace', [rt.new_string('_'), rt.new_string('-'), var_class_mutated.dup()]), rt.new_int(18)])).str() + '/')
	} else if rt.is_true(rt.identical(rt.new_int(0), rt.call_function('strpos', [var_class_mutated.dup(), rt.new_string('wc_gateway_')]))) {
		var_path = rt.new_string((this.include_path).str() + 'gateways/' + (rt.call_function('substr', [rt.call_function('str_replace', [rt.new_string('_'), rt.new_string('-'), var_class_mutated.dup()]), rt.new_int(11)])).str() + '/')
	} else if rt.is_true(rt.identical(rt.new_int(0), rt.call_function('strpos', [var_class_mutated.dup(), rt.new_string('wc_shipping_')]))) {
		var_path = rt.new_string((this.include_path).str() + 'shipping/' + (rt.call_function('substr', [rt.call_function('str_replace', [rt.new_string('_'), rt.new_string('-'), var_class_mutated.dup()]), rt.new_int(12)])).str() + '/')
	} else if rt.is_true(rt.identical(rt.new_int(0), rt.call_function('strpos', [var_class_mutated.dup(), rt.new_string('wc_shortcode_')]))) {
		var_path = rt.new_string((this.include_path).str() + 'shortcodes/')
	} else if rt.is_true(rt.identical(rt.new_int(0), rt.call_function('strpos', [var_class_mutated.dup(), rt.new_string('wc_meta_box')]))) {
		var_path = rt.new_string((this.include_path).str() + 'admin/meta-boxes/')
	} else if rt.is_true(rt.identical(rt.new_int(0), rt.call_function('strpos', [var_class_mutated.dup(), rt.new_string('wc_admin')]))) {
		var_path = rt.new_string((this.include_path).str() + 'admin/')
	} else if rt.is_true(rt.identical(rt.new_int(0), rt.call_function('strpos', [var_class_mutated.dup(), rt.new_string('wc_payment_token_')]))) {
		var_path = rt.new_string((this.include_path).str() + 'payment-tokens/')
	} else if rt.is_true(rt.identical(rt.new_int(0), rt.call_function('strpos', [var_class_mutated.dup(), rt.new_string('wc_log_handler_')]))) {
		var_path = rt.new_string((this.include_path).str() + 'log-handlers/')
	} else if rt.is_true(rt.identical(rt.new_int(0), rt.call_function('strpos', [var_class_mutated.dup(), rt.new_string('wc_integration')]))) {
		var_path = rt.new_string((this.include_path).str() + 'integrations/' + (rt.call_function('substr', [rt.call_function('str_replace', [rt.new_string('_'), rt.new_string('-'), var_class_mutated.dup()]), rt.new_int(15)])).str() + '/')
	} else if rt.is_true(rt.identical(rt.new_int(0), rt.call_function('strpos', [var_class_mutated.dup(), rt.new_string('wc_notes_')]))) {
		var_path = rt.new_string((this.include_path).str() + 'admin/notes/')
	} else if rt.is_true(rt.identical(rt.new_int(0), rt.call_function('strpos', [var_class_mutated.dup(), rt.new_string('wc_rest_')]))) {
		if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
			if rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_Features_Features{}; return temp.is_enabled(arg_0) }(rt.new_string('rest-api-v4'))) {
				mut var_rest_controller_paths := ['rest-api/Controllers/Version4/']
				for var_rest_path in var_rest_controller_paths {
					if this.load_file(rt.new_string((this.include_path).str() + rest_path + (var_file).str())) {
						return rt.new_null()
					}
				}
				this.load_rest_v4_controller_recursively(var_file.dup())
			}
		} else {
			var_rest_controller_paths = ['rest-api/Controllers/Version1/', 'rest-api/Controllers/Version2/', 'rest-api/Controllers/Version3/', 'rest-api/Controllers/Telemetry/']
			for var_rest_path in var_rest_controller_paths {
				if this.load_file(rt.new_string((this.include_path).str() + rest_path + (var_file).str())) {
					return rt.new_null()
				}
			}
		}
	}
	if !rt.is_true(var_path) || !(this.load_file(rt.new_string((var_path).str() + (var_file).str()))) {
		this.load_file(rt.new_string((this.include_path).str() + (var_file).str()))
	}
}

fn (mut this Class_WC_Autoloader) load_rest_v4_controller_recursively(var_file rt.PhpVal) bool {
	mut var_file_mutated := var_file
	mut var_v4_base_path := rt.new_string((this.include_path).str() + 'rest-api/Controllers/Version4/')
	if rt.is_true(rt.call_function('is_dir', [var_v4_base_path.dup()])) {
		mut var_iterator := create_recursiveiteratoriterator(create_recursivedirectoryiterator(var_v4_base_path.dup(), Class_RecursiveDirectoryIterator.skip_dots()), Class_RecursiveIteratorIterator.self_first())
		{
			mut iter_1 := var_iterator.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_dir_info := item_1.val
				if rt.is_true(rt.call_method(var_dir_info, 'isDir', []rt.PhpVal{})) {
					mut var_subdir_path := rt.new_string((rt.call_method(var_dir_info, 'getPathname', []rt.PhpVal{})).str() + '/')
					if this.load_file(rt.new_string((var_subdir_path).str() + (var_file_mutated).str())) {
						return true
					}
				}
			}
		}
	}
	return false
}

struct Class_Automattic_WooCommerce_Packages {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_Features_Features {
	rt.PhpObjectBase
}

struct Class_RecursiveIteratorIterator {
	rt.PhpObjectBase
}

struct Class_RecursiveDirectoryIterator {
	rt.PhpObjectBase
}

fn create_wc_autoloader() &Class_WC_Autoloader {
	mut obj := &Class_WC_Autoloader{
		PhpObjectBase: rt.PhpObjectBase{}
		include_path: rt.new_string('')
	}
	obj.construct()
	return obj
}

fn create_automattic_woocommerce_packages() &Class_Automattic_WooCommerce_Packages {
	mut obj := &Class_Automattic_WooCommerce_Packages{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_features_features() &Class_Automattic_WooCommerce_Admin_Features_Features {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_Features{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_recursiveiteratoriterator() &Class_RecursiveIteratorIterator {
	mut obj := &Class_RecursiveIteratorIterator{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_recursivedirectoryiterator() &Class_RecursiveDirectoryIterator {
	mut obj := &Class_RecursiveDirectoryIterator{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Autoloader) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'get_file_name_from_class' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.get_file_name_from_class(dispatch_arg_0))
		}
		'load_file' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.load_file(dispatch_arg_0))
		}
		'autoload' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.autoload(dispatch_arg_0)
			return rt.new_null()
		}
		'load_rest_v4_controller_recursively' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.load_rest_v4_controller_recursively(dispatch_arg_0))
		}
		else { return none }
	}
}

fn (this &Class_WC_Autoloader) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'include_path' { return this.include_path }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_Autoloader) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'include_path' { this.include_path = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_Packages) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Packages) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Packages) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Admin_Features_Features) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_Features) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Features) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_RecursiveIteratorIterator) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_RecursiveIteratorIterator) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_RecursiveIteratorIterator) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_RecursiveDirectoryIterator) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_RecursiveDirectoryIterator) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_RecursiveDirectoryIterator) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_includes_class_wc_autoloader_php() {
	// unsupported statement: Stmt_Declare
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
	create_wc_autoloader()
}
