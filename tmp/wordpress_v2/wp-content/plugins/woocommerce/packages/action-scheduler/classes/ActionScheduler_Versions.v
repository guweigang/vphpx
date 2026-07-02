import rt

struct Class_ActionScheduler_Versions {
	rt.PhpObjectBase
pub mut:
	versions rt.PhpVal = rt.new_array()
	sources  rt.PhpVal = rt.new_array()
}

fn init_static_actionscheduler_versions() {
	rt.init_static_prop('ActionScheduler_Versions', 'instance', rt.new_null())
}

fn (mut this Class_ActionScheduler_Versions) register(var_version_string rt.PhpVal, var_initialization_callback rt.PhpVal) bool {
	if this.versions.array_isset(var_version_string) {
		return false
	}
	mut var_backtrace := rt.call_function('debug_backtrace', [
		rt.get_constant('DEBUG_BACKTRACE_IGNORE_ARGS'),
	])
	mut var_source := var_backtrace.array_get(rt.new_int(0)).array_get(rt.new_string('file'))
	this.versions.array_set(var_version_string, var_initialization_callback.clone())
	this.sources.array_set(var_source, var_version_string.clone())
	return true
}

fn (mut this Class_ActionScheduler_Versions) get_versions() rt.PhpVal {
	return this.versions
}

fn (mut this Class_ActionScheduler_Versions) get_sources() rt.PhpVal {
	return this.sources
}

fn (mut this Class_ActionScheduler_Versions) latest_version() bool {
	mut var_keys := rt.func_array_keys(this.versions)
	if !rt.is_true(var_keys) {
		return false
	}
	rt.call_function('uasort', [var_keys.clone(), rt.new_string('version_compare')])
	return (rt.call_function('end', [var_keys.clone()])).to_bool()
}

fn (mut this Class_ActionScheduler_Versions) latest_version_callback() string {
	mut var_latest := rt.new_bool(this.latest_version())
	if !rt.is_true(var_latest) || !(this.versions.array_isset(var_latest)) {
		return '__return_null'
	}
	return (this.versions.array_get(var_latest)).str()
}

fn Class_ActionScheduler_Versions.instance() rt.PhpVal {
	if !rt.is_true(rt.get_static_prop('ActionScheduler_Versions', 'instance')) {
		rt.set_static_prop('ActionScheduler_Versions', 'instance', rt.new_object('ActionScheduler_Versions',
			[]string{}, create_actionscheduler_versions()))
	}
	return rt.get_static_prop('ActionScheduler_Versions', 'instance')
}

fn Class_ActionScheduler_Versions.initialize_latest_version() {
	mut var_self := Class_ActionScheduler_Versions.instance()
	rt.call_function('call_user_func', [
		rt.call_method(var_self, 'latest_version_callback', []rt.PhpVal{}),
	])
}

fn (mut this Class_ActionScheduler_Versions) active_source() rt.PhpVal {
	rt.call_function('_deprecated_function', [rt.new_string(@METHOD),
		rt.new_string('3.9.2'), rt.new_string('ActionScheduler_SystemInformation::active_source()')])
	mut iife_temp_0 := Class_ActionScheduler_SystemInformation{}
	mut iife_result_0 := iife_temp_0.active_source()
	return iife_result_0
}

fn (mut this Class_ActionScheduler_Versions) active_source_path() string {
	rt.call_function('_deprecated_function', [rt.new_string(@METHOD),
		rt.new_string('3.9.2'), rt.new_string('ActionScheduler_SystemInformation::active_source_path()')])
	mut iife_temp_1 := Class_ActionScheduler_SystemInformation{}
	mut iife_result_1 := iife_temp_1.active_source_path()
	return iife_result_1.str()
}

struct Class_ActionScheduler_SystemInformation {
	rt.PhpObjectBase
}

fn create_actionscheduler_versions(_args ...rt.PhpVal) &Class_ActionScheduler_Versions {
	mut obj := &Class_ActionScheduler_Versions{
		PhpObjectBase: rt.PhpObjectBase{}
		versions:      rt.new_array()
		sources:       rt.new_array()
	}
	return obj
}

fn create_actionscheduler_systeminformation(_args ...rt.PhpVal) &Class_ActionScheduler_SystemInformation {
	mut obj := &Class_ActionScheduler_SystemInformation{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_ActionScheduler_Versions) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'register' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(this.register(dispatch_arg_0, dispatch_arg_1))
		}
		'get_versions' {
			return this.get_versions()
		}
		'get_sources' {
			return this.get_sources()
		}
		'latest_version' {
			return rt.new_bool(this.latest_version())
		}
		'latest_version_callback' {
			return rt.new_string(this.latest_version_callback())
		}
		'instance' {
			return Class_ActionScheduler_Versions.instance()
		}
		'initialize_latest_version' {
			Class_ActionScheduler_Versions.initialize_latest_version()
			return rt.new_null()
		}
		'active_source' {
			return this.active_source()
		}
		'active_source_path' {
			return rt.new_string(this.active_source_path())
		}
		else {
			return none
		}
	}
}

fn (this &Class_ActionScheduler_Versions) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'versions' { return this.versions }
		'sources' { return this.sources }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_ActionScheduler_Versions) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'versions' {
			this.versions = val
			return true
		}
		'sources' {
			this.sources = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_ActionScheduler_SystemInformation) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ActionScheduler_SystemInformation) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ActionScheduler_SystemInformation) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
