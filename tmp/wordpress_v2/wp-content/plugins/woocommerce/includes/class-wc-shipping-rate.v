import rt

struct Class_WC_Shipping_Rate {
	rt.PhpObjectBase
pub mut:
		data rt.PhpVal = rt.new_array()
		meta_data rt.PhpVal = rt.new_array()
}

fn (mut this Class_WC_Shipping_Rate) construct(id string, label string, cost i64, var_taxes rt.PhpVal, method_id string, instance_id i64, var_tax_status rt.PhpVal, description string, delivery_time string) {
	mut var_taxes_mutated := var_taxes
	this.set_id(rt.new_string(id))
	this.set_label(rt.new_string(label))
	this.set_cost(rt.new_int(cost))
	this.set_taxes(var_taxes_mutated.clone())
	this.set_method_id(rt.new_string(method_id))
	this.set_instance_id(rt.new_int(instance_id))
	this.set_tax_status(var_tax_status.clone())
	this.set_description(rt.new_string(description))
	this.set_delivery_time(rt.new_string(delivery_time))
}

fn (mut this Class_WC_Shipping_Rate) magic_isset(var_key rt.PhpVal) rt.PhpVal {
	return rt.new_bool(this.data.array_isset(var_key))
}

fn (mut this Class_WC_Shipping_Rate) magic_get(var_key rt.PhpVal) string {
	if rt.is_true(rt.call_function('is_callable', [rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Shipping_Rate', ['JsonSerializable'], &this) }, rt.ArrayItem{ key: none, val: "get_${var_key.to_string()}" }])])) {
		return (rt.call_method(rt.new_object('WC_Shipping_Rate', ['JsonSerializable'], &this), "get_${var_key.to_string()}", []rt.PhpVal{})).str()
	}
	if this.data.array_isset(var_key) {
		return (this.data.array_get(var_key)).str()
	}
	return ''
}

fn (mut this Class_WC_Shipping_Rate) magic_set(var_key rt.PhpVal, var_value rt.PhpVal) {
	if rt.is_true(rt.call_function('is_callable', [rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Shipping_Rate', ['JsonSerializable'], &this) }, rt.ArrayItem{ key: none, val: "set_${var_key.to_string()}" }])])) {
		rt.call_method(rt.new_object('WC_Shipping_Rate', ['JsonSerializable'], &this), "set_${var_key.to_string()}", [var_value.clone()])
	} else {
		this.data.array_set(var_key, var_value.clone())
	}
}

fn (mut this Class_WC_Shipping_Rate) jsonserialize() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'data', val: this.data }, rt.ArrayItem{ key: 'meta_data', val: this.meta_data }])
}

fn (mut this Class_WC_Shipping_Rate) set_id(var_id rt.PhpVal) {
	this.data.array_set('id', (var_id).str())
}

fn (mut this Class_WC_Shipping_Rate) set_method_id(var_method_id rt.PhpVal) {
	this.data.array_set('method_id', (var_method_id).str())
}

fn (mut this Class_WC_Shipping_Rate) set_instance_id(var_instance_id rt.PhpVal) {
	this.data.array_set('instance_id', rt.call_function('absint', [var_instance_id.clone()]))
}

fn (mut this Class_WC_Shipping_Rate) set_label(var_label rt.PhpVal) {
	this.data.array_set('label', (var_label).str())
}

fn (mut this Class_WC_Shipping_Rate) set_cost(var_cost rt.PhpVal) {
	this.data.array_set('cost', var_cost.clone())
}

fn (mut this Class_WC_Shipping_Rate) set_taxes(var_taxes rt.PhpVal) {
	mut var_taxes_mutated := var_taxes
	this.data.array_set('taxes', if !(!rt.is_true(var_taxes_mutated)) && var_taxes_mutated.clone().is_array() { var_taxes_mutated } else { rt.new_array() })
}

fn (mut this Class_WC_Shipping_Rate) set_tax_status(var_value rt.PhpVal) {
	if rt.is_true(rt.call_function('in_array', [var_value.clone(), rt.create_array([rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_ProductTaxStatus.taxable() }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_ProductTaxStatus.none() }]), rt.new_bool(true)])) {
		this.data.array_set('tax_status', var_value.clone())
	}
}

fn (mut this Class_WC_Shipping_Rate) set_description(var_description rt.PhpVal) {
	this.data.array_set('description', (var_description).str())
}

fn (mut this Class_WC_Shipping_Rate) set_delivery_time(var_delivery_time rt.PhpVal) {
	this.data.array_set('delivery_time', (var_delivery_time).str())
}

fn (mut this Class_WC_Shipping_Rate) get_id() rt.PhpVal {
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_shipping_rate_id'), this.data.array_get(rt.new_string('id')), rt.new_object('WC_Shipping_Rate', ['JsonSerializable'], &this)])
}

fn (mut this Class_WC_Shipping_Rate) get_method_id() rt.PhpVal {
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_shipping_rate_method_id'), this.data.array_get(rt.new_string('method_id')), rt.new_object('WC_Shipping_Rate', ['JsonSerializable'], &this)])
}

fn (mut this Class_WC_Shipping_Rate) get_instance_id() rt.PhpVal {
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_shipping_rate_instance_id'), this.data.array_get(rt.new_string('instance_id')), rt.new_object('WC_Shipping_Rate', ['JsonSerializable'], &this)])
}

fn (mut this Class_WC_Shipping_Rate) get_label() rt.PhpVal {
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_shipping_rate_label'), this.data.array_get(rt.new_string('label')), rt.new_object('WC_Shipping_Rate', ['JsonSerializable'], &this)])
}

fn (mut this Class_WC_Shipping_Rate) get_cost() rt.PhpVal {
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_shipping_rate_cost'), this.data.array_get(rt.new_string('cost')), rt.new_object('WC_Shipping_Rate', ['JsonSerializable'], &this)])
}

fn (mut this Class_WC_Shipping_Rate) get_taxes() rt.PhpVal {
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_shipping_rate_taxes'), this.data.array_get(rt.new_string('taxes')), rt.new_object('WC_Shipping_Rate', ['JsonSerializable'], &this)])
}

fn (mut this Class_WC_Shipping_Rate) get_shipping_tax() rt.PhpVal {
	mut var_taxes := this.get_taxes()
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_get_shipping_tax'), rt.new_float(if var_taxes.clone().array_count() > 0 && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'customer'), 'get_is_vat_exempt', []rt.PhpVal{}))))) { rt.new_float((rt.call_function('array_sum', [var_taxes.clone()])).to_f64()) } else { 0 }), rt.new_object('WC_Shipping_Rate', ['JsonSerializable'], &this)])
}

fn (mut this Class_WC_Shipping_Rate) get_tax_status() rt.PhpVal {
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_shipping_rate_tax_status'), this.data.array_get(rt.new_string('tax_status')), rt.new_object('WC_Shipping_Rate', ['JsonSerializable'], &this)])
}

fn (mut this Class_WC_Shipping_Rate) get_description() rt.PhpVal {
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_shipping_rate_description'), this.data.array_get(rt.new_string('description')), rt.new_object('WC_Shipping_Rate', ['JsonSerializable'], &this)])
}

fn (mut this Class_WC_Shipping_Rate) get_delivery_time() rt.PhpVal {
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_shipping_rate_delivery_time'), this.data.array_get(rt.new_string('delivery_time')), rt.new_object('WC_Shipping_Rate', ['JsonSerializable'], &this)])
}

fn (mut this Class_WC_Shipping_Rate) add_meta_data(var_key rt.PhpVal, var_value rt.PhpVal) {
	this.meta_data.array_set(rt.call_function('wc_clean', [var_key.clone()]), rt.call_function('wc_clean', [var_value.clone()]))
}

fn (mut this Class_WC_Shipping_Rate) get_meta_data() rt.PhpVal {
	return this.meta_data
}

fn create_wc_shipping_rate(id string, label string, cost i64, arg_3 rt.PhpVal, method_id string, instance_id i64, description string, delivery_time string, arg_8 rt.PhpVal) &Class_WC_Shipping_Rate {
	mut obj := &Class_WC_Shipping_Rate{
		PhpObjectBase: rt.PhpObjectBase{}
		data: rt.new_array()
		meta_data: rt.new_array()
	}
	obj.construct(id, label, cost, arg_3, method_id, instance_id, description, delivery_time, arg_8)
	return obj
}

fn (mut this Class_WC_Shipping_Rate) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_i64()
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			dispatch_arg_4 := (if args.len > 4 { args[4] } else { rt.new_null() }).str()
			dispatch_arg_5 := (if args.len > 5 { args[5] } else { rt.new_null() }).to_i64()
			dispatch_arg_6 := if args.len > 6 { args[6] } else { rt.new_null() }
			dispatch_arg_7 := (if args.len > 7 { args[7] } else { rt.new_null() }).str()
			dispatch_arg_8 := (if args.len > 8 { args[8] } else { rt.new_null() }).str()
			this.construct(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3, dispatch_arg_4, dispatch_arg_5, dispatch_arg_6, dispatch_arg_7, dispatch_arg_8)
			return rt.new_null()
		}
		'__isset' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.magic_isset(dispatch_arg_0)
		}
		'__get' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.magic_get(dispatch_arg_0))
		}
		'__set' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.magic_set(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'jsonSerialize' {
			return this.jsonserialize()
		}
		'set_id' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_id(dispatch_arg_0)
			return rt.new_null()
		}
		'set_method_id' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_method_id(dispatch_arg_0)
			return rt.new_null()
		}
		'set_instance_id' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_instance_id(dispatch_arg_0)
			return rt.new_null()
		}
		'set_label' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_label(dispatch_arg_0)
			return rt.new_null()
		}
		'set_cost' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_cost(dispatch_arg_0)
			return rt.new_null()
		}
		'set_taxes' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_taxes(dispatch_arg_0)
			return rt.new_null()
		}
		'set_tax_status' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_tax_status(dispatch_arg_0)
			return rt.new_null()
		}
		'set_description' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_description(dispatch_arg_0)
			return rt.new_null()
		}
		'set_delivery_time' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_delivery_time(dispatch_arg_0)
			return rt.new_null()
		}
		'get_id' {
			return this.get_id()
		}
		'get_method_id' {
			return this.get_method_id()
		}
		'get_instance_id' {
			return this.get_instance_id()
		}
		'get_label' {
			return this.get_label()
		}
		'get_cost' {
			return this.get_cost()
		}
		'get_taxes' {
			return this.get_taxes()
		}
		'get_shipping_tax' {
			return this.get_shipping_tax()
		}
		'get_tax_status' {
			return this.get_tax_status()
		}
		'get_description' {
			return this.get_description()
		}
		'get_delivery_time' {
			return this.get_delivery_time()
		}
		'add_meta_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.add_meta_data(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'get_meta_data' {
			return this.get_meta_data()
		}
		else { return none }
	}
}

fn (this &Class_WC_Shipping_Rate) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'data' { return this.data }
		'meta_data' { return this.meta_data }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_Shipping_Rate) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'data' { this.data = val; return true }
		'meta_data' { this.meta_data = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn init_registry() {
}

fn init() {
	init_registry()
}


fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(exit(0)))
}
