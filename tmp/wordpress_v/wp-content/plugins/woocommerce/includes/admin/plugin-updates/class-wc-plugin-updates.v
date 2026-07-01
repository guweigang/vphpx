import rt

pub fn Class_WC_Plugin_Updates.version_required_header() string {
	return 'WC requires at least'
}
pub fn Class_WC_Plugin_Updates.version_tested_header() string {
	return 'WC tested up to'
}
struct Class_WC_Plugin_Updates {
	rt.PhpObjectBase
pub mut:
		new_version rt.PhpVal = rt.new_string('')
		major_untested_plugins rt.PhpVal = rt.new_array()
}

fn (mut this Class_WC_Plugin_Updates) generic_modal_js()  {
	// unsupported statement: Stmt_InlineHTML
}

fn (mut this Class_WC_Plugin_Updates) get_extensions_inline_warning_major() rt.PhpVal {
	mut var_upgrade_type := rt.new_string(rt.new_string('major'))
	mut var_plugins := this.major_untested_plugins
	mut var_version_parts := rt.call_function('explode', [rt.new_string('.'), this.new_version])
	mut var_new_version := rt.new_string((var_version_parts.array_get(0)).str() + '.0')
	if !rt.is_true(var_plugins) {
		return rt.new_null()
	}
	mut var_message := rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('<strong>Heads up!</strong> The versions of the following plugins you\'re running haven\'t been tested with WooCommerce %s. Please update them or confirm compatibility before updating WooCommerce, or you may experience issues:'), rt.new_string('woocommerce')]), var_new_version.dup()])
	rt.call_function('ob_start', []rt.PhpVal{})
	rt.include_file(@DIR + '/views/html-notice-untested-extensions-inline.php', '1')
	return rt.call_function('ob_get_clean', []rt.PhpVal{})
}

fn (mut this Class_WC_Plugin_Updates) get_extensions_modal_warning() rt.PhpVal {
	mut var_version_parts := rt.call_function('explode', [rt.new_string('.'), this.new_version])
	mut var_new_version := rt.new_string((var_version_parts.array_get(0)).str() + '.0')
	mut var_plugins := this.major_untested_plugins
	rt.call_function('ob_start', []rt.PhpVal{})
	rt.include_file(@DIR + '/views/html-notice-untested-extensions-modal.php', '1')
	return rt.call_function('ob_get_clean', []rt.PhpVal{})
}

fn (mut this Class_WC_Plugin_Updates) get_untested_plugins(var_new_version rt.PhpVal, var_release rt.PhpVal) rt.PhpVal {
	mut var_new_version_mutated := var_new_version
	if rt.is_true(rt.identical(rt.new_string('none'), var_release)) {
		return rt.new_array()
	}
	mut var_extensions := rt.call_function('array_merge', [this.get_plugins_with_header(rt.new_string(Class_WC_Plugin_Updates.version_tested_header())), this.get_plugins_for_woocommerce()])
	mut var_untested := rt.new_array()
	mut var_new_version_parts := rt.call_function('explode', [rt.new_string('.'), var_new_version_mutated.dup()])
	mut var_version := var_new_version_parts.array_get(0)
	if rt.is_true(rt.identical(rt.new_string('minor'), var_release)) {
		// unsupported expression: Expr_AssignOp_Concat
	}
	{
		mut iter_1 := var_extensions.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_plugin := item_1.val
			mut var_file := item_1.key
			if !(!rt.is_true(var_plugin.array_get(Class_WC_Plugin_Updates.version_tested_header()))) {
				mut var_plugin_version_parts := rt.call_function('explode', [rt.new_string('.'), var_plugin.array_get(Class_WC_Plugin_Updates.version_tested_header())])
				if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_plugin_version_parts.array_get(0).is_long() || var_plugin_version_parts.array_get(0).is_double()))))) || rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('minor'), var_release)) && !(var_plugin_version_parts.array_isset(rt.new_int(1))))))) || rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('minor'), var_release)) && rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_plugin_version_parts.array_get(1).is_long() || var_plugin_version_parts.array_get(1).is_double()))))))))) {
					continue
				}
				mut var_plugin_version := var_plugin_version_parts.array_get(0)
				if rt.is_true(rt.identical(rt.new_string('minor'), var_release)) {
					// unsupported expression: Expr_AssignOp_Concat
				}
				if rt.is_true(rt.call_function('version_compare', [var_plugin_version.dup(), var_version.dup(), rt.new_string('<')])) {
					var_untested.array_set(var_file, var_plugin.dup())
				}
			} else {
				var_plugin.array_set(Class_WC_Plugin_Updates.version_tested_header(), rt.call_function('__', [rt.new_string('unknown'), rt.new_string('woocommerce')]))
				var_untested.array_set(var_file, var_plugin.dup())
			}
		}
	}
	return var_untested.dup()
}

fn (mut this Class_WC_Plugin_Updates) get_plugins_with_header(var_header rt.PhpVal) rt.PhpVal {
	mut var_plugins := rt.call_function('get_plugins', []rt.PhpVal{})
	mut var_matches := rt.new_array()
	{
		mut iter_1 := var_plugins.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_plugin := item_1.val
			mut var_file := item_1.key
			if !(!rt.is_true(var_plugin.array_get(var_header))) {
				var_matches.array_set(var_file, var_plugin.dup())
			}
		}
	}
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_get_plugins_with_header'), var_matches.dup(), var_header.dup(), var_plugins.dup()])
}

fn (mut this Class_WC_Plugin_Updates) get_plugins_for_woocommerce() rt.PhpVal {
	mut var_plugins := rt.call_function('get_plugins', []rt.PhpVal{})
	mut var_matches := rt.new_array()
	{
		mut iter_1 := var_plugins.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_plugin := item_1.val
			mut var_file := item_1.key
			if rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) && rt.is_true(rt.new_bool(rt.is_true(rt.call_function('stristr', [var_plugin.array_get('Name'), rt.new_string('woocommerce')])) || rt.is_true(rt.call_function('stristr', [var_plugin.array_get('Description'), rt.new_string('woocommerce')])))))) {
				var_matches.array_set(var_file, var_plugin.dup())
			}
		}
	}
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_get_plugins_for_woocommerce'), var_matches.dup(), var_plugins.dup()])
}

fn create_wc_plugin_updates() &Class_WC_Plugin_Updates {
	mut obj := &Class_WC_Plugin_Updates{
		PhpObjectBase: rt.PhpObjectBase{}
		new_version: rt.new_string('')
		major_untested_plugins: rt.new_array()
	}
	return obj
}

fn (mut this Class_WC_Plugin_Updates) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'generic_modal_js' {
			this.generic_modal_js()
			return rt.new_null()
		}
		'get_extensions_inline_warning_major' {
			return this.get_extensions_inline_warning_major()
		}
		'get_extensions_modal_warning' {
			return this.get_extensions_modal_warning()
		}
		'get_untested_plugins' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.get_untested_plugins(dispatch_arg_0, dispatch_arg_1)
		}
		'get_plugins_with_header' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_plugins_with_header(dispatch_arg_0)
		}
		'get_plugins_for_woocommerce' {
			return this.get_plugins_for_woocommerce()
		}
		else { return none }
	}
}

fn (this &Class_WC_Plugin_Updates) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'new_version' { return this.new_version }
		'major_untested_plugins' { return this.major_untested_plugins }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_Plugin_Updates) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'new_version' { this.new_version = val; return true }
		'major_untested_plugins' { this.major_untested_plugins = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}




pub fn init_wp_content_plugins_woocommerce_includes_admin_plugin_updates_class_wc_plugin_updates_php() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))))) {
		// unsupported expression: Expr_Exit
	}
}
