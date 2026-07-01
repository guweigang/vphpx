import rt

struct Class_Automattic_WooCommerce_Admin_DataSourcePoller {
	rt.PhpObjectBase
}

fn Class_Automattic_WooCommerce_Admin_DataSourcePoller.log_deprecation() {
	// unsupported statement: Stmt_Nop
}

fn (mut this Class_Automattic_WooCommerce_Admin_DataSourcePoller) construct(var_id rt.PhpVal, var_data_sources rt.PhpVal, var_args rt.PhpVal) {
	Class_Automattic_WooCommerce_Admin_DataSourcePoller.log_deprecation()
	this.Class_Automattic_WooCommerce_Admin_RemoteSpecs_DataSourcePoller.construct(var_id.dup(),
		var_data_sources.dup(), var_args.dup())
}

fn (mut this Class_Automattic_WooCommerce_Admin_DataSourcePoller) get_specs_from_data_sources() rt.PhpVal {
	Class_Automattic_WooCommerce_Admin_DataSourcePoller.log_deprecation()
	return this.Class_Automattic_WooCommerce_Admin_RemoteSpecs_DataSourcePoller.get_specs_from_data_sources()
}

fn (mut this Class_Automattic_WooCommerce_Admin_DataSourcePoller) read_specs_from_data_sources() rt.PhpVal {
	Class_Automattic_WooCommerce_Admin_DataSourcePoller.log_deprecation()
	return this.Class_Automattic_WooCommerce_Admin_RemoteSpecs_DataSourcePoller.read_specs_from_data_sources()
}

fn (mut this Class_Automattic_WooCommerce_Admin_DataSourcePoller) delete_specs_transient() rt.PhpVal {
	Class_Automattic_WooCommerce_Admin_DataSourcePoller.log_deprecation()
	return this.Class_Automattic_WooCommerce_Admin_RemoteSpecs_DataSourcePoller.delete_specs_transient()
}

fn (mut this Class_Automattic_WooCommerce_Admin_DataSourcePoller) set_specs_transient(var_specs rt.PhpVal, expiration i64) rt.PhpVal {
	Class_Automattic_WooCommerce_Admin_DataSourcePoller.log_deprecation()
	return this.Class_Automattic_WooCommerce_Admin_RemoteSpecs_DataSourcePoller.set_specs_transient(var_specs.dup(),
		rt.new_int(expiration))
}

struct Class_Automattic_WooCommerce_Admin_RemoteSpecs_DataSourcePoller {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_datasourcepoller(arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) &Class_Automattic_WooCommerce_Admin_DataSourcePoller {
	mut obj := &Class_Automattic_WooCommerce_Admin_DataSourcePoller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	obj.construct(arg_0, arg_1, arg_2)
	return obj
}

fn create_automattic_woocommerce_admin_remotespecs_datasourcepoller() &Class_Automattic_WooCommerce_Admin_RemoteSpecs_DataSourcePoller {
	mut obj := &Class_Automattic_WooCommerce_Admin_RemoteSpecs_DataSourcePoller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_DataSourcePoller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'log_deprecation' {
			Class_Automattic_WooCommerce_Admin_DataSourcePoller.log_deprecation()
			return rt.new_null()
		}
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			this.construct(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'get_specs_from_data_sources' {
			return this.get_specs_from_data_sources()
		}
		'read_specs_from_data_sources' {
			return this.read_specs_from_data_sources()
		}
		'delete_specs_transient' {
			return this.delete_specs_transient()
		}
		'set_specs_transient' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			return this.set_specs_transient(dispatch_arg_0, dispatch_arg_1)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_DataSourcePoller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_DataSourcePoller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_DataSourcePoller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_RemoteSpecs_DataSourcePoller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_DataSourcePoller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_woocommerce_src_admin_datasourcepoller_php() {
}
