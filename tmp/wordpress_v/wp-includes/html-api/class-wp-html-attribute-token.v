import rt

struct Class_WP_HTML_Attribute_Token {
	rt.PhpObjectBase
pub mut:
	name            rt.PhpVal = rt.new_null()
	value_starts_at rt.PhpVal = rt.new_null()
	value_length    rt.PhpVal = rt.new_null()
	start           rt.PhpVal = rt.new_null()
	length          rt.PhpVal = rt.new_null()
	is_true         rt.PhpVal = rt.new_null()
}

fn (mut this Class_WP_HTML_Attribute_Token) construct(var_name rt.PhpVal, var_value_start rt.PhpVal, var_value_length rt.PhpVal, var_start rt.PhpVal, var_length rt.PhpVal, var_is_true rt.PhpVal) {
	this.name = var_name.dup()
	this.value_starts_at = var_value_start.dup()
	this.value_length = var_value_length.dup()
	this.start = var_start.dup()
	this.length = var_length.dup()
	this.is_true = var_is_true.dup()
}

fn create_wp_html_attribute_token(arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal, arg_3 rt.PhpVal, arg_4 rt.PhpVal, arg_5 rt.PhpVal) &Class_WP_HTML_Attribute_Token {
	mut obj := &Class_WP_HTML_Attribute_Token{
		PhpObjectBase:   rt.PhpObjectBase{}
		name:            rt.new_null()
		value_starts_at: rt.new_null()
		value_length:    rt.new_null()
		start:           rt.new_null()
		length:          rt.new_null()
		is_true:         rt.new_null()
	}
	obj.construct(arg_0, arg_1, arg_2, arg_3, arg_4, arg_5)
	return obj
}

fn (mut this Class_WP_HTML_Attribute_Token) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			dispatch_arg_4 := if args.len > 4 { args[4] } else { rt.new_null() }
			dispatch_arg_5 := if args.len > 5 { args[5] } else { rt.new_null() }
			this.construct(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3,
				dispatch_arg_4, dispatch_arg_5)
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WP_HTML_Attribute_Token) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'name' { return this.name }
		'value_starts_at' { return this.value_starts_at }
		'value_length' { return this.value_length }
		'start' { return this.start }
		'length' { return this.length }
		'is_true' { return this.is_true }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_HTML_Attribute_Token) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'name' {
			this.name = val
			return true
		}
		'value_starts_at' {
			this.value_starts_at = val
			return true
		}
		'value_length' {
			this.value_length = val
			return true
		}
		'start' {
			this.start = val
			return true
		}
		'length' {
			this.length = val
			return true
		}
		'is_true' {
			this.is_true = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

pub fn init_wp_includes_html_api_class_wp_html_attribute_token_php() {
}
