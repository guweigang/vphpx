import rt

struct Class_WC_Object_Query {
	rt.PhpObjectBase
pub mut:
	query_vars rt.PhpVal = rt.new_array()
}

fn (mut this Class_WC_Object_Query) construct(var_args rt.PhpVal) {
	this.query_vars = rt.call_function('wp_parse_args', [var_args.dup(),
		this.get_default_query_vars()])
}

fn (mut this Class_WC_Object_Query) get_query_vars() rt.PhpVal {
	return this.query_vars
}

fn (mut this Class_WC_Object_Query) get(var_query_var rt.PhpVal, default string) rt.PhpVal {
	if this.query_vars.array_isset(var_query_var) {
		return this.query_vars.array_get(var_query_var)
	}
	return rt.new_string(default)
}

fn (mut this Class_WC_Object_Query) set(var_query_var rt.PhpVal, var_value rt.PhpVal) {
	this.query_vars.array_set(var_query_var, var_value.dup())
}

fn (mut this Class_WC_Object_Query) get_default_query_vars() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'name', val: '' },
		rt.ArrayItem{ key: 'parent', val: '' }, rt.ArrayItem{ key: 'parent_exclude', val: '' },
		rt.ArrayItem{ key: 'exclude', val: '' }, rt.ArrayItem{ key: 'limit', val: rt.call_function('get_option', [
			rt.new_string('posts_per_page'),
		]) }, rt.ArrayItem{ key: 'page', val: 1 }, rt.ArrayItem{ key: 'offset', val: '' },
		rt.ArrayItem{ key: 'paginate', val: false }, rt.ArrayItem{ key: 'order', val: 'DESC' },
		rt.ArrayItem{ key: 'orderby', val: 'date' }, rt.ArrayItem{ key: 'return', val: 'objects' }])
}

fn create_wc_object_query(arg_0 rt.PhpVal) &Class_WC_Object_Query {
	mut obj := &Class_WC_Object_Query{
		PhpObjectBase: rt.PhpObjectBase{}
		query_vars:    rt.new_array()
	}
	obj.construct(arg_0)
	return obj
}

fn (mut this Class_WC_Object_Query) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'get_query_vars' {
			return this.get_query_vars()
		}
		'get' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return this.get(dispatch_arg_0, dispatch_arg_1)
		}
		'set' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.set(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'get_default_query_vars' {
			return this.get_default_query_vars()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_Object_Query) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'query_vars' { return this.query_vars }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_Object_Query) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'query_vars' {
			this.query_vars = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

pub fn init_wp_content_plugins_woocommerce_includes_abstracts_abstract_wc_object_query_php() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		// unsupported expression: Expr_Exit
	}
}
