import rt

struct Class_WP_HTML_Span {
	rt.PhpObjectBase
pub mut:
	start  i64
	length i64
}

fn (mut this Class_WP_HTML_Span) construct(start i64, length i64) {
	this.start = start
	this.length = length
}

fn create_wp_html_span(start i64, length i64) &Class_WP_HTML_Span {
	mut obj := &Class_WP_HTML_Span{
		PhpObjectBase: rt.PhpObjectBase{}
		start:         i64(0)
		length:        i64(0)
	}
	obj.construct(start, length)
	return obj
}

fn (mut this Class_WP_HTML_Span) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			this.construct(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WP_HTML_Span) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'start' { return rt.new_int(this.start) }
		'length' { return rt.new_int(this.length) }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_HTML_Span) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'start' {
			this.start = val.to_i64()
			return true
		}
		'length' {
			this.length = val.to_i64()
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn main() {
	defer {
		rt.shutdown()
	}
}
