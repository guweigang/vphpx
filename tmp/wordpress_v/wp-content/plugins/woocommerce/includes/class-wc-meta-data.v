import rt

struct Class_WC_Meta_Data {
	rt.PhpObjectBase
pub mut:
		current_data rt.PhpVal = rt.new_null()
		data rt.PhpVal = rt.new_null()
}

fn (mut this Class_WC_Meta_Data) construct(var_meta rt.PhpVal)  {
	this.current_data = var_meta.dup()
	this.apply_changes()
}

fn (mut this Class_WC_Meta_Data) jsonserialize() rt.PhpVal {
	return this.get_data()
}

fn (mut this Class_WC_Meta_Data) apply_changes()  {
	this.data = this.current_data
}

fn (mut this Class_WC_Meta_Data) magic_set(var_key rt.PhpVal, var_value rt.PhpVal)  {
	this.current_data.array_set(var_key, var_value.dup())
}

fn (mut this Class_WC_Meta_Data) magic_isset(var_key rt.PhpVal) bool {
	return this.current_data.array_isset(var_key.dup())
}

fn (mut this Class_WC_Meta_Data) magic_get(var_key rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.new_bool(this.current_data.array_isset(var_key.dup()))) {
		return this.current_data.array_get(var_key)
	}
	return rt.new_null()
}

fn (mut this Class_WC_Meta_Data) get_changes() rt.PhpVal {
	mut var_changes := rt.new_array()
	{
		mut iter_1 := this.current_data.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_value := item_1.val
			mut var_id := item_1.key
			if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(this.data.array_isset(var_id.dup())))))) || rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
				var_changes.array_set(var_id, var_value.dup())
			}
		}
	}
	return var_changes.dup()
}

fn (mut this Class_WC_Meta_Data) get_data() rt.PhpVal {
	return this.data
}

fn create_wc_meta_data(arg_0 rt.PhpVal) &Class_WC_Meta_Data {
	mut obj := &Class_WC_Meta_Data{
		PhpObjectBase: rt.PhpObjectBase{}
		current_data: rt.new_null()
		data: rt.new_null()
	}
	obj.construct(arg_0)
	return obj
}

fn (mut this Class_WC_Meta_Data) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'jsonSerialize' {
			return this.jsonserialize()
		}
		'apply_changes' {
			this.apply_changes()
			return rt.new_null()
		}
		'__set' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.magic_set(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'__isset' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.magic_isset(dispatch_arg_0))
		}
		'__get' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.magic_get(dispatch_arg_0)
		}
		'get_changes' {
			return this.get_changes()
		}
		'get_data' {
			return this.get_data()
		}
		else { return none }
	}
}

fn (this &Class_WC_Meta_Data) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'current_data' { return this.current_data }
		'data' { return this.data }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_Meta_Data) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'current_data' { this.current_data = val; return true }
		'data' { this.data = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}




pub fn init_wp_content_plugins_woocommerce_includes_class_wc_meta_data_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
