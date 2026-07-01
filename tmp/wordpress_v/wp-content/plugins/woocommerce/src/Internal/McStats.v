import rt

struct Class_Automattic_WooCommerce_Internal_McStats {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Internal_McStats) get_group_query_args(var_group_name rt.PhpVal) rt.PhpVal {
	mut var_stats := this.get_current_stats()
	if var_stats.array_isset(var_group_name) && !(!rt.is_true(var_stats.array_get(var_group_name))) {
		return rt.create_array([
			rt.ArrayItem{ key: 'x_woocommerce-${var_group_name.to_string()}', val: rt.call_function('implode', [
				rt.new_string(','),
				var_stats.array_get(var_group_name),
			]) },
		])
	}
	return rt.new_array()
}

fn (mut this Class_Automattic_WooCommerce_Internal_McStats) do_stats() {
	if rt.is_true(rt.new_bool(!(rt.is_true(fn () rt.PhpVal {
		mut temp := Class_Automattic_WooCommerce_Internal_WC_Site_Tracking{}
		return temp.is_tracking_enabled()
	}()))))
	{
		return rt.new_null()
	}
	this.Class_Automattic_Jetpack_A8c_Mc_Stats.do_stats()
}

fn (mut this Class_Automattic_WooCommerce_Internal_McStats) do_server_side_stat(var_url rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(fn () rt.PhpVal {
		mut temp := Class_Automattic_WooCommerce_Internal_WC_Site_Tracking{}
		return temp.is_tracking_enabled()
	}()))))
	{
		return false
	}
	return (this.Class_Automattic_Jetpack_A8c_Mc_Stats.do_server_side_stat(var_url.dup())).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Internal_McStats) do_server_side_stats() {
	if rt.is_true(rt.new_bool(!(rt.is_true(fn () rt.PhpVal {
		mut temp := Class_Automattic_WooCommerce_Internal_WC_Site_Tracking{}
		return temp.is_tracking_enabled()
	}()))))
	{
		return rt.new_null()
	}
	this.Class_Automattic_Jetpack_A8c_Mc_Stats.do_server_side_stats()
}

struct Class_Automattic_Jetpack_A8c_Mc_Stats {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_WC_Site_Tracking {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_mcstats() &Class_Automattic_WooCommerce_Internal_McStats {
	mut obj := &Class_Automattic_WooCommerce_Internal_McStats{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_jetpack_a8c_mc_stats() &Class_Automattic_Jetpack_A8c_Mc_Stats {
	mut obj := &Class_Automattic_Jetpack_A8c_Mc_Stats{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_wc_site_tracking() &Class_Automattic_WooCommerce_Internal_WC_Site_Tracking {
	mut obj := &Class_Automattic_WooCommerce_Internal_WC_Site_Tracking{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_McStats) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_group_query_args' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_group_query_args(dispatch_arg_0)
		}
		'do_stats' {
			this.do_stats()
			return rt.new_null()
		}
		'do_server_side_stat' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.do_server_side_stat(dispatch_arg_0))
		}
		'do_server_side_stats' {
			this.do_server_side_stats()
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_McStats) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_McStats) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_Jetpack_A8c_Mc_Stats) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_Jetpack_A8c_Mc_Stats) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_Jetpack_A8c_Mc_Stats) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Internal_WC_Site_Tracking) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_WC_Site_Tracking) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_WC_Site_Tracking) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_woocommerce_src_internal_mcstats_php() {
	// unsupported statement: Stmt_Declare
}
