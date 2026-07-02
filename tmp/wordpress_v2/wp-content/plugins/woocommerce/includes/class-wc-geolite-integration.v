import rt

struct Class_WC_Geolite_Integration {
	rt.PhpObjectBase
pub mut:
	database rt.PhpVal = rt.new_string('')
	log      rt.PhpVal = rt.new_null()
}

fn (mut this Class_WC_Geolite_Integration) construct(var_database rt.PhpVal) {
	this.database = var_database.clone()
}

fn (mut this Class_WC_Geolite_Integration) get_country_iso(var_ip_address rt.PhpVal) rt.PhpVal {
	rt.call_function('wc_deprecated_function', [rt.new_string('get_country_iso'),
		rt.new_string('3.9.0')])
	mut var_iso_code := rt.new_string('')
	mut var_reader := create_maxmind_db_reader(this.database)
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	mut var_data := var_reader.get(var_ip_address.clone())
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	if var_data.array_get(rt.new_string('country')).array_isset(rt.new_string('iso_code')) {
		var_iso_code =
			var_data.array_get(rt.new_string('country')).array_get(rt.new_string('iso_code'))
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
	}
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	var_reader.close()
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	unsafe {
		goto end_label_1
	}
	catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'Exception') {
		mut var_e := var_e_1.clone()
		this.log(rt.call_method(var_e, 'getMessage', []rt.PhpVal{}), 'warning')
		unsafe {
			goto end_label_1
		}
	} else {
		rt.throw_exception(var_e_1)
		unsafe {
			goto end_label_1
		}
	}

	end_label_1:
	return rt.call_function('sanitize_text_field', [
		rt.new_string(var_iso_code.clone().to_string().to_upper()),
	])
}

fn (mut this Class_WC_Geolite_Integration) log(var_message rt.PhpVal, level string) {
	if rt.is_true(rt.new_bool(this.log.is_null())) {
		this.log = rt.call_function('wc_get_logger', []rt.PhpVal{})
	}
	rt.call_method(this.log, 'log', [rt.new_string(level), var_message.clone(),
		rt.create_array([rt.ArrayItem{ key: 'source', val: 'geoip' }])])
}

struct Class_MaxMind_Db_Reader {
	rt.PhpObjectBase
}

fn create_wc_geolite_integration(arg_0 rt.PhpVal) &Class_WC_Geolite_Integration {
	mut obj := &Class_WC_Geolite_Integration{
		PhpObjectBase: rt.PhpObjectBase{}
		database:      rt.new_string('')
		log:           rt.new_null()
	}
	obj.construct(arg_0)
	return obj
}

fn create_maxmind_db_reader(_args ...rt.PhpVal) &Class_MaxMind_Db_Reader {
	mut obj := &Class_MaxMind_Db_Reader{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Geolite_Integration) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'get_country_iso' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_country_iso(dispatch_arg_0)
		}
		'log' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			this.log(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_Geolite_Integration) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'database' { return this.database }
		'log' { return this.log }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_Geolite_Integration) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'database' {
			this.database = val
			return true
		}
		'log' {
			this.log = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_MaxMind_Db_Reader) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_MaxMind_Db_Reader) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_MaxMind_Db_Reader) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}
