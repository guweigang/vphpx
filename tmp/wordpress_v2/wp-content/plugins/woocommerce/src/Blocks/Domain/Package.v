import rt

struct Class_Automattic_WooCommerce_Blocks_Domain_Package {
	rt.PhpObjectBase
pub mut:
	version        rt.PhpVal = rt.new_null()
	path           rt.PhpVal = rt.new_null()
	plugin_dir_url rt.PhpVal = rt.new_null()
	feature_gating rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Package) construct(var_version rt.PhpVal, var_plugin_path rt.PhpVal, var_deprecated rt.PhpVal) {
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_deprecated)))) {
		rt.call_function('wc_deprecated_argument', [rt.new_string('FeatureGating'),
			rt.new_string('9.6'),
			rt.new_string('FeatureGating class is deprecated, please use wp_get_environment_type() instead.')])
		this.feature_gating = create_automattic_woocommerce_blocks_domain_services_featuregating()
	}
	this.version = var_version.clone()
	this.path = var_plugin_path.clone()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Package) get_version() rt.PhpVal {
	return this.version
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Package) get_version_stored_on_db() rt.PhpVal {
	return rt.call_function('get_option', [
		Class_Automattic_WooCommerce_Blocks_Options.wc_block_version(),
		rt.new_string(''),
	])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Package) set_version_stored_on_db() {
	rt.call_function('update_option', [
		Class_Automattic_WooCommerce_Blocks_Options.wc_block_version(),
		this.get_version(),
	])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Package) get_path(relative_path string) string {
	return (rt.call_function('trailingslashit', [this.path])).str() + relative_path
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Package) get_url(relative_url string) string {
	if rt.is_true(rt.new_bool(!(rt.is_true(this.plugin_dir_url)))) {
		this.plugin_dir_url = rt.call_function('plugin_dir_url', [
			rt.new_string((this.path).str() + '/index.php'),
		])
	}
	return (this.plugin_dir_url).str() + relative_url
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Package) feature() rt.PhpVal {
	return this.feature_gating
}

struct Class_Automattic_WooCommerce_Blocks_Domain_Services_FeatureGating {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blocks_domain_package(arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_Domain_Package {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Domain_Package{
		PhpObjectBase:  rt.PhpObjectBase{}
		version:        rt.new_null()
		path:           rt.new_null()
		plugin_dir_url: rt.new_null()
		feature_gating: rt.new_null()
	}
	obj.construct(arg_0, arg_1, arg_2)
	return obj
}

fn create_automattic_woocommerce_blocks_domain_services_featuregating(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_Domain_Services_FeatureGating {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Domain_Services_FeatureGating{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Package) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			this.construct(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'get_version' {
			return this.get_version()
		}
		'get_version_stored_on_db' {
			return this.get_version_stored_on_db()
		}
		'set_version_stored_on_db' {
			this.set_version_stored_on_db()
			return rt.new_null()
		}
		'get_path' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(this.get_path(dispatch_arg_0))
		}
		'get_url' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(this.get_url(dispatch_arg_0))
		}
		'feature' {
			return this.feature()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Blocks_Domain_Package) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'version' { return this.version }
		'path' { return this.path }
		'plugin_dir_url' { return this.plugin_dir_url }
		'feature_gating' { return this.feature_gating }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Package) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'version' {
			this.version = val
			return true
		}
		'path' {
			this.path = val
			return true
		}
		'plugin_dir_url' {
			this.plugin_dir_url = val
			return true
		}
		'feature_gating' {
			this.feature_gating = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_FeatureGating) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_Domain_Services_FeatureGating) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_FeatureGating) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
