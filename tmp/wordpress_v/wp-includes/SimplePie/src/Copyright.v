import rt
import crypto.md5

struct Class_SimplePie_Copyright {
	rt.PhpObjectBase
pub mut:
		url rt.PhpVal = rt.new_null()
		label rt.PhpVal = rt.new_null()
}

fn (mut this Class_SimplePie_Copyright) construct(mut var_url Class_SimplePie_?string, mut var_label Class_SimplePie_?string)  {
	this.url = var_url.dup()
	this.label = var_label.dup()
}

fn (mut this Class_SimplePie_Copyright) magic_tostring() string {
	return md5.hexhash(rt.call_function('serialize', [rt.new_object('SimplePie_Copyright', []string{}, &this)]).to_string())
}

fn (mut this Class_SimplePie_Copyright) get_url() rt.PhpVal {
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return this.url
	}
	return rt.new_null()
}

fn (mut this Class_SimplePie_Copyright) get_attribution() rt.PhpVal {
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return this.label
	}
	return rt.new_null()
}

fn create_simplepie_copyright(arg_0 rt.PhpVal, arg_1 rt.PhpVal) &Class_SimplePie_Copyright {
	mut obj := &Class_SimplePie_Copyright{
		PhpObjectBase: rt.PhpObjectBase{}
		url: rt.new_null()
		label: rt.new_null()
	}
	obj.construct(arg_0, arg_1)
	return obj
}

fn (mut this Class_SimplePie_Copyright) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_SimplePie_?string](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_SimplePie_?string](if args.len > 1 { args[1] } else { rt.new_null() })
			this.construct(mut dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'__toString' {
			return rt.new_string(this.magic_tostring())
		}
		'get_url' {
			return this.get_url()
		}
		'get_attribution' {
			return this.get_attribution()
		}
		else { return none }
	}
}

fn (this &Class_SimplePie_Copyright) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'url' { return this.url }
		'label' { return this.label }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_SimplePie_Copyright) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'url' { this.url = val; return true }
		'label' { this.label = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}




pub fn init_wp_includes_simplepie_src_copyright_php() {
	// unsupported statement: Stmt_Declare
	rt.call_function('class_alias', [rt.new_string('SimplePie\\Copyright'), rt.new_string('SimplePie_Copyright')])
}
