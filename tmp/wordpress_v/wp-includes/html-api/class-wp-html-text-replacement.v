import rt

struct Class_WP_HTML_Text_Replacement {
	rt.PhpObjectBase
pub mut:
	start  i64
	length i64
	text   string
}

fn (mut this Class_WP_HTML_Text_Replacement) construct(start i64, length i64, text string) {
	this.start = start
	this.length = length
	this.text = text
}

fn create_wp_html_text_replacement(start i64, length i64, text string) &Class_WP_HTML_Text_Replacement {
	mut obj := &Class_WP_HTML_Text_Replacement{
		PhpObjectBase: rt.PhpObjectBase{}
		start:         i64(0)
		length:        i64(0)
		text:          ''
	}
	obj.construct(start, length, text)
	return obj
}

fn (mut this Class_WP_HTML_Text_Replacement) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			this.construct(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WP_HTML_Text_Replacement) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'start' { return rt.new_int(this.start) }
		'length' { return rt.new_int(this.length) }
		'text' { return rt.new_string(this.text) }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_HTML_Text_Replacement) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'start' {
			this.start = val.to_i64()
			return true
		}
		'length' {
			this.length = val.to_i64()
			return true
		}
		'text' {
			this.text = val.str()
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

pub fn init_wp_includes_html_api_class_wp_html_text_replacement_php() {
}
