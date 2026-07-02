import rt

struct Class_WP_Theme_JSON_Data {
	rt.PhpObjectBase
pub mut:
	theme_json rt.PhpVal = rt.new_null()
	origin     rt.PhpVal = rt.new_string('')
}

fn (mut this Class_WP_Theme_JSON_Data) construct(var_data rt.PhpVal, origin string) {
	this.origin = rt.new_string(origin)
	this.theme_json = create_wp_theme_json(var_data.clone(), this.origin)
}

fn (mut this Class_WP_Theme_JSON_Data) update_with(var_new_data rt.PhpVal) rt.PhpVal {
	rt.call_method(this.theme_json, 'merge', [
		create_wp_theme_json(var_new_data.clone(), this.origin),
	])
	return rt.new_object('WP_Theme_JSON_Data', []string{}, this)
}

fn (mut this Class_WP_Theme_JSON_Data) get_data() rt.PhpVal {
	return rt.call_method(this.theme_json, 'get_raw_data', []rt.PhpVal{})
}

fn (mut this Class_WP_Theme_JSON_Data) get_theme_json() rt.PhpVal {
	return this.theme_json
}

struct Class_WP_Theme_JSON {
	rt.PhpObjectBase
}

fn create_wp_theme_json_data(arg_0 rt.PhpVal, origin string) &Class_WP_Theme_JSON_Data {
	mut obj := &Class_WP_Theme_JSON_Data{
		PhpObjectBase: rt.PhpObjectBase{}
		theme_json:    rt.new_null()
		origin:        rt.new_string('')
	}
	obj.construct(arg_0, origin)
	return obj
}

fn create_wp_theme_json(_args ...rt.PhpVal) &Class_WP_Theme_JSON {
	mut obj := &Class_WP_Theme_JSON{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Theme_JSON_Data) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			this.construct(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'update_with' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.update_with(dispatch_arg_0)
		}
		'get_data' {
			return this.get_data()
		}
		'get_theme_json' {
			return this.get_theme_json()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WP_Theme_JSON_Data) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'theme_json' { return this.theme_json }
		'origin' { return this.origin }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_Theme_JSON_Data) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'theme_json' {
			this.theme_json = val
			return true
		}
		'origin' {
			this.origin = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_WP_Theme_JSON) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Theme_JSON) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Theme_JSON) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
