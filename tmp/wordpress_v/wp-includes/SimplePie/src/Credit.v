import rt
import crypto.md5

struct Class_SimplePie_Credit {
	rt.PhpObjectBase
pub mut:
		role rt.PhpVal = rt.new_null()
		scheme rt.PhpVal = rt.new_null()
		name rt.PhpVal = rt.new_null()
}

fn (mut this Class_SimplePie_Credit) construct(mut var_role Class_SimplePie_?string, mut var_scheme Class_SimplePie_?string, mut var_name Class_SimplePie_?string)  {
	this.role = var_role.dup()
	this.scheme = var_scheme.dup()
	this.name = var_name.dup()
}

fn (mut this Class_SimplePie_Credit) magic_tostring() string {
	return md5.hexhash(rt.call_function('serialize', [rt.new_object('SimplePie_Credit', []string{}, &this)]).to_string())
}

fn (mut this Class_SimplePie_Credit) get_role() rt.PhpVal {
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return this.role
	}
	return rt.new_null()
}

fn (mut this Class_SimplePie_Credit) get_scheme() rt.PhpVal {
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return this.scheme
	}
	return rt.new_null()
}

fn (mut this Class_SimplePie_Credit) get_name() rt.PhpVal {
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return this.name
	}
	return rt.new_null()
}

fn create_simplepie_credit(arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) &Class_SimplePie_Credit {
	mut obj := &Class_SimplePie_Credit{
		PhpObjectBase: rt.PhpObjectBase{}
		role: rt.new_null()
		scheme: rt.new_null()
		name: rt.new_null()
	}
	obj.construct(arg_0, arg_1, arg_2)
	return obj
}

fn (mut this Class_SimplePie_Credit) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_SimplePie_?string](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_SimplePie_?string](if args.len > 1 { args[1] } else { rt.new_null() })
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_SimplePie_?string](if args.len > 2 { args[2] } else { rt.new_null() })
			this.construct(mut dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2)
			return rt.new_null()
		}
		'__toString' {
			return rt.new_string(this.magic_tostring())
		}
		'get_role' {
			return this.get_role()
		}
		'get_scheme' {
			return this.get_scheme()
		}
		'get_name' {
			return this.get_name()
		}
		else { return none }
	}
}

fn (this &Class_SimplePie_Credit) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'role' { return this.role }
		'scheme' { return this.scheme }
		'name' { return this.name }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_SimplePie_Credit) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'role' { this.role = val; return true }
		'scheme' { this.scheme = val; return true }
		'name' { this.name = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}




pub fn init_wp_includes_simplepie_src_credit_php() {
	// unsupported statement: Stmt_Declare
	rt.call_function('class_alias', [rt.new_string('SimplePie\\Credit'), rt.new_string('SimplePie_Credit')])
}
