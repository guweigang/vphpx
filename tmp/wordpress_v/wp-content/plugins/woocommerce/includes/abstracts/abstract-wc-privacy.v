import rt

struct Class_WC_Abstract_Privacy {
	rt.PhpObjectBase
pub mut:
		name rt.PhpVal = rt.new_null()
		exporters rt.PhpVal = rt.new_array()
		erasers rt.PhpVal = rt.new_array()
		export_priority rt.PhpVal = rt.new_null()
		erase_priority rt.PhpVal = rt.new_null()
}

fn (mut this Class_WC_Abstract_Privacy) construct(name string, export_priority i64, erase_priority i64)  {
	this.name = rt.new_string(name).dup()
	this.export_priority = rt.new_int(export_priority).dup()
	this.erase_priority = rt.new_int(erase_priority).dup()
	this.init()
}

fn (mut this Class_WC_Abstract_Privacy) init()  {
	rt.call_function('add_action', [rt.new_string('admin_init'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Abstract_Privacy', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'add_privacy_message' }])])
	rt.call_function('add_filter', [rt.new_string('wp_privacy_personal_data_exporters'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Abstract_Privacy', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'register_exporters' }]), this.export_priority])
	rt.call_function('add_filter', [rt.new_string('wp_privacy_personal_data_erasers'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Abstract_Privacy', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'register_erasers' }]), this.erase_priority])
}

fn (mut this Class_WC_Abstract_Privacy) add_privacy_message()  {
	if rt.is_true(rt.call_function('function_exists', [rt.new_string('wp_add_privacy_policy_content')])) {
		mut var_content := rt.new_string(this.get_privacy_message())
		if rt.is_true(var_content) {
			rt.call_function('wp_add_privacy_policy_content', [this.name, this.get_privacy_message()])
		}
	}
}

fn (mut this Class_WC_Abstract_Privacy) get_privacy_message() string {
	return ''
}

fn (mut this Class_WC_Abstract_Privacy) register_exporters(var_exporters rt.PhpVal) rt.PhpVal {
	mut var_exporters_mutated := var_exporters
	{
		mut iter_1 := this.exporters.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_exporter := item_1.val
			mut var_id := item_1.key
			var_exporters_mutated.array_set(var_id, var_exporter.dup())
		}
	}
	return var_exporters_mutated.dup()
}

fn (mut this Class_WC_Abstract_Privacy) register_erasers(var_erasers rt.PhpVal) rt.PhpVal {
	mut var_erasers_mutated := var_erasers
	{
		mut iter_1 := this.erasers.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_eraser := item_1.val
			mut var_id := item_1.key
			var_erasers_mutated.array_set(var_id, var_eraser.dup())
		}
	}
	return var_erasers_mutated.dup()
}

fn (mut this Class_WC_Abstract_Privacy) add_exporter(var_id rt.PhpVal, var_name rt.PhpVal, var_callback rt.PhpVal) rt.PhpVal {
	this.exporters.array_set(var_id, rt.create_array([rt.ArrayItem{ key: 'exporter_friendly_name', val: var_name }, rt.ArrayItem{ key: 'callback', val: var_callback }]))
	return this.exporters
}

fn (mut this Class_WC_Abstract_Privacy) add_eraser(var_id rt.PhpVal, var_name rt.PhpVal, var_callback rt.PhpVal) rt.PhpVal {
	this.erasers.array_set(var_id, rt.create_array([rt.ArrayItem{ key: 'eraser_friendly_name', val: var_name }, rt.ArrayItem{ key: 'callback', val: var_callback }]))
	return this.erasers
}

fn create_wc_abstract_privacy(name string, export_priority i64, erase_priority i64) &Class_WC_Abstract_Privacy {
	mut obj := &Class_WC_Abstract_Privacy{
		PhpObjectBase: rt.PhpObjectBase{}
		name: rt.new_null()
		exporters: rt.new_array()
		erasers: rt.new_array()
		export_priority: rt.new_null()
		erase_priority: rt.new_null()
	}
	obj.construct(name, export_priority, erase_priority)
	return obj
}

fn (mut this Class_WC_Abstract_Privacy) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_i64()
			this.construct(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'init' {
			this.init()
			return rt.new_null()
		}
		'add_privacy_message' {
			this.add_privacy_message()
			return rt.new_null()
		}
		'get_privacy_message' {
			return rt.new_string(this.get_privacy_message())
		}
		'register_exporters' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.register_exporters(dispatch_arg_0)
		}
		'register_erasers' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.register_erasers(dispatch_arg_0)
		}
		'add_exporter' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.add_exporter(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'add_eraser' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.add_eraser(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		else { return none }
	}
}

fn (this &Class_WC_Abstract_Privacy) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'name' { return this.name }
		'exporters' { return this.exporters }
		'erasers' { return this.erasers }
		'export_priority' { return this.export_priority }
		'erase_priority' { return this.erase_priority }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_Abstract_Privacy) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'name' { this.name = val; return true }
		'exporters' { this.exporters = val; return true }
		'erasers' { this.erasers = val; return true }
		'export_priority' { this.export_priority = val; return true }
		'erase_priority' { this.erase_priority = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}




pub fn init_wp_content_plugins_woocommerce_includes_abstracts_abstract_wc_privacy_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
