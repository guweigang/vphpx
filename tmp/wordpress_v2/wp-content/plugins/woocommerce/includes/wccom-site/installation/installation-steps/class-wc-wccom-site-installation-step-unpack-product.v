import rt

struct Class_WC_WCCOM_Site_Installation_Step_Unpack_Product {
	rt.PhpObjectBase
pub mut:
	state rt.PhpVal = rt.new_null()
}

fn (mut this Class_WC_WCCOM_Site_Installation_Step_Unpack_Product) construct(var_state rt.PhpVal) {
	this.state = var_state.clone()
}

fn (mut this Class_WC_WCCOM_Site_Installation_Step_Unpack_Product) run() rt.PhpVal {
	mut iife_temp_0 := Class_WC_WCCOM_Site_Installer{}
	mut iife_result_0 := iife_temp_0.get_wp_upgrader()
	mut var_upgrader := iife_result_0
	mut var_unpacked_path := rt.call_method(var_upgrader, 'unpack_package', [
		rt.call_method(this.state, 'get_download_path', []rt.PhpVal{}),
		rt.new_bool(true),
	])
	if !rt.is_true(var_unpacked_path) {
		rt.throw_exception(rt.new_object('WC_REST_WCCOM_Site_Installer_Error', []string{},
			create_wc_rest_wccom_site_installer_error(Class_WC_REST_WCCOM_Site_Installer_Error_Codes.missing_unpacked_path())))
	}
	rt.call_method(this.state, 'set_unpacked_path', [var_unpacked_path.clone()])
	return this.state
}

struct Class_WC_WCCOM_Site_Installer {
	rt.PhpObjectBase
}

struct Class_WC_REST_WCCOM_Site_Installer_Error {
	rt.PhpObjectBase
}

fn create_wc_wccom_site_installation_step_unpack_product(arg_0 rt.PhpVal) &Class_WC_WCCOM_Site_Installation_Step_Unpack_Product {
	mut obj := &Class_WC_WCCOM_Site_Installation_Step_Unpack_Product{
		PhpObjectBase: rt.PhpObjectBase{}
		state:         rt.new_null()
	}
	obj.construct(arg_0)
	return obj
}

fn create_wc_wccom_site_installer(_args ...rt.PhpVal) &Class_WC_WCCOM_Site_Installer {
	mut obj := &Class_WC_WCCOM_Site_Installer{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_rest_wccom_site_installer_error(_args ...rt.PhpVal) &Class_WC_REST_WCCOM_Site_Installer_Error {
	mut obj := &Class_WC_REST_WCCOM_Site_Installer_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_WCCOM_Site_Installation_Step_Unpack_Product) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'run' {
			return this.run()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_WCCOM_Site_Installation_Step_Unpack_Product) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'state' { return this.state }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_WCCOM_Site_Installation_Step_Unpack_Product) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'state' {
			this.state = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_WC_WCCOM_Site_Installer) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_WCCOM_Site_Installer) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_WCCOM_Site_Installer) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_REST_WCCOM_Site_Installer_Error) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_REST_WCCOM_Site_Installer_Error) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_REST_WCCOM_Site_Installer_Error) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}
