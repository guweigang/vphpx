import rt

struct Class_Automattic_WooCommerce_Admin_PluginsInstallLoggers_AsyncPluginsInstallLogger {
	rt.PhpObjectBase
pub mut:
		option_name string
}

fn (mut this Class_Automattic_WooCommerce_Admin_PluginsInstallLoggers_AsyncPluginsInstallLogger) construct(option_name string)  {
	this.option_name = option_name
	rt.call_function('add_option', [this.option_name, rt.create_array([rt.ArrayItem{ key: 'created_time', val: rt.call_function('time', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'status', val: 'pending' }, rt.ArrayItem{ key: 'plugins', val: rt.new_array() }]), rt.new_string(''), rt.new_string('no')])
	closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_error := rt.call_function('error_get_last', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(var_error.array_isset(rt.new_string('type')) && rt.is_true(rt.identical(rt.get_constant('E_ERROR'), var_error.array_get('type'))))) {
		mut var_option := this.get()
		var_option.array_set('status', 'failed')
		this.update(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Admin_PluginsInstallLoggers_array](var_option))
	}
	return rt.new_null()
	}
	mut var_error := rt.call_function('error_get_last', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(var_error.array_isset(rt.new_string('type')) && rt.is_true(rt.identical(rt.get_constant('E_ERROR'), var_error.array_get('type'))))) {
		mut var_option := this.get()
		var_option.array_set('status', 'failed')
		this.update(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Admin_PluginsInstallLoggers_array](var_option))
	}
	return rt.new_null()
	}
	rt.call_function('register_shutdown_function', [rt.new_closure(closure_1_fn)])
}

fn (mut this Class_Automattic_WooCommerce_Admin_PluginsInstallLoggers_AsyncPluginsInstallLogger) update(mut var_data Class_Automattic_WooCommerce_Admin_PluginsInstallLoggers_array) rt.PhpVal {
	return rt.call_function('update_option', [this.option_name, var_data])
}

fn (mut this Class_Automattic_WooCommerce_Admin_PluginsInstallLoggers_AsyncPluginsInstallLogger) get() rt.PhpVal {
	return rt.call_function('get_option', [this.option_name])
}

fn (mut this Class_Automattic_WooCommerce_Admin_PluginsInstallLoggers_AsyncPluginsInstallLogger) install_requested(plugin_name string)  {
	mut var_option := this.get()
	if !(var_option.array_get('plugins').array_isset(rt.new_string(plugin_name))) {
		var_option.array_get_mut('plugins').array_set(plugin_name, rt.create_array([rt.ArrayItem{ key: 'status', val: 'installing' }, rt.ArrayItem{ key: 'errors', val: rt.new_array() }, rt.ArrayItem{ key: 'install_duration', val: 0 }]))
	}
	this.update(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Admin_PluginsInstallLoggers_array](var_option))
}

fn (mut this Class_Automattic_WooCommerce_Admin_PluginsInstallLoggers_AsyncPluginsInstallLogger) installed(plugin_name string, duration i64)  {
	mut var_option := this.get()
	var_option.array_get_mut('plugins').array_get_mut(plugin_name).array_set('status', 'installed')
	var_option.array_get_mut('plugins').array_get_mut(plugin_name).array_set('install_duration', duration)
	this.update(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Admin_PluginsInstallLoggers_array](var_option))
}

fn (mut this Class_Automattic_WooCommerce_Admin_PluginsInstallLoggers_AsyncPluginsInstallLogger) activated(plugin_name string)  {
	mut var_option := this.get()
	var_option.array_get_mut('plugins').array_get_mut(plugin_name).array_set('status', 'activated')
	this.update(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Admin_PluginsInstallLoggers_array](var_option))
}

fn (mut this Class_Automattic_WooCommerce_Admin_PluginsInstallLoggers_AsyncPluginsInstallLogger) add_error(plugin_name string, mut var_error_message Class_Automattic_WooCommerce_Admin_PluginsInstallLoggers_?string)  {
	mut var_option := this.get()
	var_option.array_get_mut('plugins').array_get_mut(plugin_name).array_get_mut('errors').array_push(var_error_message.dup())
	var_option.array_get_mut('plugins').array_get_mut(plugin_name).array_set('status', 'failed')
	var_option.array_set('status', 'failed')
	rt.call_function('wc_admin_record_tracks_event', [rt.new_string('coreprofiler_store_extension_installed_and_activated'), rt.create_array([rt.ArrayItem{ key: 'success', val: false }, rt.ArrayItem{ key: 'extension', val: this.get_plugin_track_key(rt.new_string(plugin_name)) }, rt.ArrayItem{ key: 'error_message', val: var_error_message }])])
	this.update(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Admin_PluginsInstallLoggers_array](var_option))
}

fn (mut this Class_Automattic_WooCommerce_Admin_PluginsInstallLoggers_AsyncPluginsInstallLogger) complete(var_data rt.PhpVal)  {
	mut var_option := this.get()
	var_option.array_set('complete_time', rt.call_function('time', []rt.PhpVal{}))
	var_option.array_set('status', 'complete')
	this.track(var_data.dup())
	this.update(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Admin_PluginsInstallLoggers_array](var_option))
}

fn (mut this Class_Automattic_WooCommerce_Admin_PluginsInstallLoggers_AsyncPluginsInstallLogger) get_plugin_track_key(var_id rt.PhpVal) rt.PhpVal {
	mut var_slug := rt.call_function('explode', [rt.new_string(':'), var_id.dup()]).array_get(0)
	mut var_key := if rt.is_true(rt.call_function('preg_match', [rt.new_string('/^woocommerce(-|_)payments$/'), var_slug.dup()])) { rt.new_string('wcpay') } else { rt.call_function('explode', [rt.new_string(':'), rt.call_function('str_replace', [rt.new_string('-'), rt.new_string('_'), var_slug.dup()])]).array_get(0) }
	return var_key.dup()
}

fn (mut this Class_Automattic_WooCommerce_Admin_PluginsInstallLoggers_AsyncPluginsInstallLogger) get_timeframe(var_timeInMs rt.PhpVal) rt.PhpVal {
	mut var_time_frames := rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'name', val: '0-2s' }, rt.ArrayItem{ key: 'max', val: 2 }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'name', val: '2-5s' }, rt.ArrayItem{ key: 'max', val: 5 }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'name', val: '5-10s' }, rt.ArrayItem{ key: 'max', val: 10 }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'name', val: '10-15s' }, rt.ArrayItem{ key: 'max', val: 15 }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'name', val: '15-20s' }, rt.ArrayItem{ key: 'max', val: 20 }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'name', val: '20-30s' }, rt.ArrayItem{ key: 'max', val: 30 }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'name', val: '30-60s' }, rt.ArrayItem{ key: 'max', val: 60 }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'name', val: '>60s' }]) }])
	{
		mut iter_1 := var_time_frames.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_time_frame := item_1.val
			if !(var_time_frame.array_isset(rt.new_string('max'))) {
				return var_time_frame.array_get('name')
			}
			if rt.is_true(rt.less(var_timeInMs, rt.mul(var_time_frame.array_get('max'), rt.new_int(1000)))) {
				return var_time_frame.array_get('name')
			}
		}
	}
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Admin_PluginsInstallLoggers_AsyncPluginsInstallLogger) track(var_data rt.PhpVal)  {
	closure_4_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_3_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_extension := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return this.get_plugin_track_key(var_extension.dup())
	}
	mut var_extension := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return this.get_plugin_track_key(var_extension.dup())
	}
	mut var_track_data := rt.create_array([rt.ArrayItem{ key: 'success', val: true }, rt.ArrayItem{ key: 'installed_extensions', val: rt.call_function('array_map', [rt.new_closure(closure_3_fn), var_data.array_get('installed')]) }, rt.ArrayItem{ key: 'total_time', val: this.get_timeframe(rt.mul(rt.sub(rt.call_function('time', []rt.PhpVal{}), var_data.array_get('start_time')), rt.new_int(1000))) }])
	{
		mut iter_1 := var_data.array_get('installed').iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_plugin := item_1.val
			if !(var_data.array_get('time').array_isset(var_plugin)) {
				continue
			}
			mut var_plugin_track_key := this.get_plugin_track_key(var_plugin.dup())
			mut var_install_time := this.get_timeframe(var_data.array_get('time').array_get(var_plugin))
			var_track_data.array_set('install_time_' + (var_plugin_track_key).str(), var_install_time.dup())
			rt.call_function('wc_admin_record_tracks_event', [rt.new_string('coreprofiler_store_extension_installed_and_activated'), rt.create_array([rt.ArrayItem{ key: 'success', val: true }, rt.ArrayItem{ key: 'extension', val: var_plugin_track_key }, rt.ArrayItem{ key: 'install_time', val: var_install_time }])])
		}
	}
	rt.call_function('wc_admin_record_tracks_event', [rt.new_string('coreprofiler_store_extensions_installed_and_activated'), var_track_data.dup()])
}

fn create_automattic_woocommerce_admin_pluginsinstallloggers_asyncpluginsinstalllogger(option_name string) &Class_Automattic_WooCommerce_Admin_PluginsInstallLoggers_AsyncPluginsInstallLogger {
	mut obj := &Class_Automattic_WooCommerce_Admin_PluginsInstallLoggers_AsyncPluginsInstallLogger{
		PhpObjectBase: rt.PhpObjectBase{}
		option_name: ''
	}
	obj.construct(option_name)
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_PluginsInstallLoggers_AsyncPluginsInstallLogger) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'update' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Admin_PluginsInstallLoggers_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.update(mut dispatch_arg_0)
		}
		'get' {
			return this.get()
		}
		'install_requested' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			this.install_requested(dispatch_arg_0)
			return rt.new_null()
		}
		'installed' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			this.installed(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'activated' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			this.activated(dispatch_arg_0)
			return rt.new_null()
		}
		'add_error' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Admin_PluginsInstallLoggers_?string](if args.len > 1 { args[1] } else { rt.new_null() })
			this.add_error(dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'complete' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.complete(dispatch_arg_0)
			return rt.new_null()
		}
		'get_plugin_track_key' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_plugin_track_key(dispatch_arg_0)
		}
		'get_timeframe' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_timeframe(dispatch_arg_0)
		}
		'track' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.track(dispatch_arg_0)
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_PluginsInstallLoggers_AsyncPluginsInstallLogger) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'option_name' { return rt.new_string(this.option_name) }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_PluginsInstallLoggers_AsyncPluginsInstallLogger) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'option_name' { this.option_name = (val).str(); return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}




pub fn init_wp_content_plugins_woocommerce_src_admin_pluginsinstallloggers_asyncpluginsinstalllogger_php() {
}
