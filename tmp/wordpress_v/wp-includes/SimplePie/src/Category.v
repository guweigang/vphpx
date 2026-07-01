import rt
import crypto.md5

struct Class_SimplePie_Category {
	rt.PhpObjectBase
pub mut:
		term rt.PhpVal = rt.new_null()
		scheme rt.PhpVal = rt.new_null()
		label rt.PhpVal = rt.new_null()
		prop_type rt.PhpVal = rt.new_null()
}

fn (mut this Class_SimplePie_Category) construct(mut var_term Class_SimplePie_?string, mut var_scheme Class_SimplePie_?string, mut var_label Class_SimplePie_?string, mut var_type Class_SimplePie_?string)  {
	this.term = var_term.dup()
	this.scheme = var_scheme.dup()
	this.label = var_label.dup()
	this.prop_type = var_type.dup()
}

fn (mut this Class_SimplePie_Category) magic_tostring() string {
	return md5.hexhash(rt.call_function('serialize', [rt.new_object('SimplePie_Category', []string{}, &this)]).to_string())
}

fn (mut this Class_SimplePie_Category) get_term() rt.PhpVal {
	return this.term
}

fn (mut this Class_SimplePie_Category) get_scheme() rt.PhpVal {
	return this.scheme
}

fn (mut this Class_SimplePie_Category) get_label(strict bool) rt.PhpVal {
	if rt.is_true(rt.new_bool(rt.is_true(rt.identical(this.label, rt.new_null())) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		return this.get_term()
	}
	return this.label
}

fn (mut this Class_SimplePie_Category) get_type() rt.PhpVal {
	return this.prop_type
}

fn create_simplepie_category(arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal, arg_3 rt.PhpVal) &Class_SimplePie_Category {
	mut obj := &Class_SimplePie_Category{
		PhpObjectBase: rt.PhpObjectBase{}
		term: rt.new_null()
		scheme: rt.new_null()
		label: rt.new_null()
		prop_type: rt.new_null()
	}
	obj.construct(arg_0, arg_1, arg_2, arg_3)
	return obj
}

fn (mut this Class_SimplePie_Category) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_SimplePie_?string](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_SimplePie_?string](if args.len > 1 { args[1] } else { rt.new_null() })
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_SimplePie_?string](if args.len > 2 { args[2] } else { rt.new_null() })
			mut dispatch_arg_3 := rt.cast_object_ptr[Class_SimplePie_?string](if args.len > 3 { args[3] } else { rt.new_null() })
			this.construct(mut dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2, mut dispatch_arg_3)
			return rt.new_null()
		}
		'__toString' {
			return rt.new_string(this.magic_tostring())
		}
		'get_term' {
			return this.get_term()
		}
		'get_scheme' {
			return this.get_scheme()
		}
		'get_label' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			return this.get_label(dispatch_arg_0)
		}
		'get_type' {
			return this.get_type()
		}
		else { return none }
	}
}

fn (this &Class_SimplePie_Category) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'term' { return this.term }
		'scheme' { return this.scheme }
		'label' { return this.label }
		'type' { return this.prop_type }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_SimplePie_Category) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'term' { this.term = val; return true }
		'scheme' { this.scheme = val; return true }
		'label' { this.label = val; return true }
		'type' { this.prop_type = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}




pub fn init_wp_includes_simplepie_src_category_php() {
	// unsupported statement: Stmt_Declare
	rt.call_function('class_alias', [rt.new_string('SimplePie\\Category'), rt.new_string('SimplePie_Category')])
}
