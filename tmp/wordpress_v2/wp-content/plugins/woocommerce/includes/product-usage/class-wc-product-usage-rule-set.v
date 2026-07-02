import rt

struct Class_WC_Product_Usage_Rule_Set {
	rt.PhpObjectBase
pub mut:
	rules rt.PhpVal = rt.new_null()
}

fn (mut this Class_WC_Product_Usage_Rule_Set) construct(var_rules rt.PhpVal) {
	this.rules = var_rules.clone()
}

fn (mut this Class_WC_Product_Usage_Rule_Set) get_rule(rule_name string) rt.PhpVal {
	if !(this.rules.array_isset(rt.new_string(rule_name))) {
		return rt.new_null()
	}
	return this.rules.array_get(rt.new_string(rule_name))
}

fn create_wc_product_usage_rule_set(arg_0 rt.PhpVal) &Class_WC_Product_Usage_Rule_Set {
	mut obj := &Class_WC_Product_Usage_Rule_Set{
		PhpObjectBase: rt.PhpObjectBase{}
		rules:         rt.new_null()
	}
	obj.construct(arg_0)
	return obj
}

fn (mut this Class_WC_Product_Usage_Rule_Set) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'get_rule' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_rule(dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_Product_Usage_Rule_Set) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'rules' { return this.rules }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_Product_Usage_Rule_Set) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'rules' {
			this.rules = val
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

	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		exit(0)
	}
}
