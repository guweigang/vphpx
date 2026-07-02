import rt

struct Class_WC_WCCOM_Site_Installation_State_Storage {
	rt.PhpObjectBase
}

fn Class_WC_WCCOM_Site_Installation_State_Storage.get_state(var_product_id rt.PhpVal) rt.PhpVal {
	mut var_storage_key :=
		Class_WC_WCCOM_Site_Installation_State_Storage.get_storage_key(var_product_id.clone())
	mut var_data := rt.call_function('get_option', [var_storage_key.clone()])
	if !(var_data.clone().is_array()) {
		return rt.new_null()
	}
	mut iife_temp_0 := Class_WC_WCCOM_Site_Installation_State{}
	mut iife_result_0 := iife_temp_0.initiate_existing(var_product_id.clone(),
		var_data.array_get(rt.new_string('idempotency_key')),
		var_data.array_get(rt.new_string('last_step_name')),
		var_data.array_get(rt.new_string('last_step_status')),
		var_data.array_get(rt.new_string('last_step_error')),
		var_data.array_get(rt.new_string('started_date')))
	mut var_installation_state := iife_result_0
	rt.call_method(var_installation_state, 'set_product_type', [if !(var_data.array_get(rt.new_string('product_type'))).is_null() {
		var_data.array_get(rt.new_string('product_type'))
	} else {
		rt.new_null()
	}])
	rt.call_method(var_installation_state, 'set_product_name', [if !(var_data.array_get(rt.new_string('product_name'))).is_null() {
		var_data.array_get(rt.new_string('product_name'))
	} else {
		rt.new_null()
	}])
	rt.call_method(var_installation_state, 'set_download_url', [if !(var_data.array_get(rt.new_string('download_url'))).is_null() {
		var_data.array_get(rt.new_string('download_url'))
	} else {
		rt.new_null()
	}])
	rt.call_method(var_installation_state, 'set_download_path', [if !(var_data.array_get(rt.new_string('download_path'))).is_null() {
		var_data.array_get(rt.new_string('download_path'))
	} else {
		rt.new_null()
	}])
	rt.call_method(var_installation_state, 'set_unpacked_path', [if !(var_data.array_get(rt.new_string('unpacked_path'))).is_null() {
		var_data.array_get(rt.new_string('unpacked_path'))
	} else {
		rt.new_null()
	}])
	rt.call_method(var_installation_state, 'set_installed_path', [if !(var_data.array_get(rt.new_string('installed_path'))).is_null() {
		var_data.array_get(rt.new_string('installed_path'))
	} else {
		rt.new_null()
	}])
	rt.call_method(var_installation_state, 'set_already_installed_plugin_info', [if !(var_data.array_get(rt.new_string('already_installed_plugin_info'))).is_null() {
		var_data.array_get(rt.new_string('already_installed_plugin_info'))
	} else {
		rt.new_null()
	}])
	return var_installation_state.clone()
}

fn Class_WC_WCCOM_Site_Installation_State_Storage.save_state(mut var_state Class_WC_WCCOM_Site_Installation_State) bool {
	mut var_storage_key :=
		Class_WC_WCCOM_Site_Installation_State_Storage.get_storage_key(var_state.get_product_id())
	return (rt.call_function('update_option', [var_storage_key.clone(),
		rt.create_array([
			rt.ArrayItem{ key: 'product_id', val: var_state.get_product_id() },
			rt.ArrayItem{ key: 'idempotency_key', val: var_state.get_idempotency_key() },
			rt.ArrayItem{ key: 'last_step_name', val: var_state.get_last_step_name() },
			rt.ArrayItem{ key: 'last_step_status', val: var_state.get_last_step_status() },
			rt.ArrayItem{ key: 'last_step_error', val: var_state.get_last_step_error() },
			rt.ArrayItem{ key: 'product_type', val: var_state.get_product_type() },
			rt.ArrayItem{ key: 'product_name', val: var_state.get_product_name() },
			rt.ArrayItem{ key: 'download_url', val: var_state.get_download_url() },
			rt.ArrayItem{ key: 'download_path', val: var_state.get_download_path() },
			rt.ArrayItem{ key: 'unpacked_path', val: var_state.get_unpacked_path() },
			rt.ArrayItem{ key: 'installed_path', val: var_state.get_installed_path() },
			rt.ArrayItem{
				key: 'already_installed_plugin_info'
				val: var_state.get_already_installed_plugin_info()
			},
			rt.ArrayItem{ key: 'started_date', val: var_state.get_started_date() },
		])])).to_bool()
}

fn Class_WC_WCCOM_Site_Installation_State_Storage.delete_state(mut var_state Class_WC_WCCOM_Site_Installation_State) bool {
	mut var_storage_key :=
		Class_WC_WCCOM_Site_Installation_State_Storage.get_storage_key(var_state.get_product_id())
	return (rt.call_function('delete_option', [var_storage_key.clone()])).to_bool()
}

fn Class_WC_WCCOM_Site_Installation_State_Storage.get_storage_key(var_product_id rt.PhpVal) string {
	return (rt.call_function('sprintf', [
		rt.new_string('wccom-product-installation-state-%d'),
		var_product_id.clone(),
	])).str()
}

struct Class_WC_WCCOM_Site_Installation_State {
	rt.PhpObjectBase
}

fn create_wc_wccom_site_installation_state_storage(_args ...rt.PhpVal) &Class_WC_WCCOM_Site_Installation_State_Storage {
	mut obj := &Class_WC_WCCOM_Site_Installation_State_Storage{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_wccom_site_installation_state(_args ...rt.PhpVal) &Class_WC_WCCOM_Site_Installation_State {
	mut obj := &Class_WC_WCCOM_Site_Installation_State{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_WCCOM_Site_Installation_State_Storage) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_state' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_WCCOM_Site_Installation_State_Storage.get_state(dispatch_arg_0)
		}
		'save_state' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_WCCOM_Site_Installation_State](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return rt.new_bool(Class_WC_WCCOM_Site_Installation_State_Storage.save_state(mut dispatch_arg_0))
		}
		'delete_state' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_WCCOM_Site_Installation_State](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return rt.new_bool(Class_WC_WCCOM_Site_Installation_State_Storage.delete_state(mut dispatch_arg_0))
		}
		'get_storage_key' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(Class_WC_WCCOM_Site_Installation_State_Storage.get_storage_key(dispatch_arg_0))
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_WCCOM_Site_Installation_State_Storage) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_WCCOM_Site_Installation_State_Storage) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_WCCOM_Site_Installation_State) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_WCCOM_Site_Installation_State) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_WCCOM_Site_Installation_State) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}
