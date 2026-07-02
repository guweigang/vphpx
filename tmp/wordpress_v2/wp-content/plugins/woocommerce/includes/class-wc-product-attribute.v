import rt

struct Class_WC_Product_Attribute {
	rt.PhpObjectBase
pub mut:
	data       rt.PhpVal = rt.new_array()
	extra_data rt.PhpVal = rt.new_array()
}

fn (mut this Class_WC_Product_Attribute) is_taxonomy() rt.PhpVal {
	return rt.less(rt.new_int(0), this.get_id())
}

fn (mut this Class_WC_Product_Attribute) get_taxonomy() rt.PhpVal {
	return if rt.is_true(this.is_taxonomy()) { this.get_name() } else { rt.new_string('') }
}

fn (mut this Class_WC_Product_Attribute) get_taxonomy_object() rt.PhpVal {
	mut var_wc_product_attributes := rt.new_null()
	return if rt.is_true(this.is_taxonomy()) {
		var_wc_product_attributes.array_get(this.get_name())
	} else {
		rt.new_null()
	}
}

fn (mut this Class_WC_Product_Attribute) get_terms() rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(this.is_taxonomy()))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('taxonomy_exists', [this.get_name()]))))) {
		return rt.new_null()
	}
	mut var_terms := []rt.PhpVal{}
	mut iter_1 := this.get_options().iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_option := item_1.val
		if rt.is_true(rt.new_bool(var_option.clone().is_long())) {
			mut var_term := rt.call_function('get_term_by', [
				rt.new_string('id'), var_option.clone(), this.get_name()])
		} else {
			var_term = rt.call_function('get_term_by', [rt.new_string('name'),
				var_option.clone(), this.get_name()])
			if rt.is_true(rt.new_bool(!(rt.is_true(var_term))))
				|| rt.is_true(rt.call_function('is_wp_error', [var_term.clone()])) {
				mut var_new_term := rt.call_function('wp_insert_term', [
					var_option.clone(), this.get_name()])
				var_term = if rt.is_true(rt.call_function('is_wp_error', [
					var_new_term.clone()]))
				{ rt.new_bool(false) } else { rt.call_function('get_term_by', [
						rt.new_string('id'),
						var_new_term.array_get(rt.new_string('term_id')),
						this.get_name(),
					]) }
			}
		}
		if rt.is_true(var_term)
			&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_term.clone()]))))) {
			var_terms << var_term.clone()
		}
	}
	return var_terms.clone()
}

fn (mut this Class_WC_Product_Attribute) get_slugs() rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(this.is_taxonomy()))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('taxonomy_exists', [this.get_name()]))))) {
		return this.get_options()
	}
	mut var_terms := []rt.PhpVal{}
	mut iter_2 := this.get_options().iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_option := item_2.val
		if rt.is_true(rt.new_bool(var_option.clone().is_long())) {
			mut var_term := rt.call_function('get_term_by', [
				rt.new_string('id'), var_option.clone(), this.get_name()])
		} else {
			var_term = rt.call_function('get_term_by', [rt.new_string('name'),
				var_option.clone(), this.get_name()])
			if rt.is_true(rt.new_bool(!(rt.is_true(var_term))))
				|| rt.is_true(rt.call_function('is_wp_error', [var_term.clone()])) {
				mut var_new_term := rt.call_function('wp_insert_term', [
					var_option.clone(), this.get_name()])
				var_term = if rt.is_true(rt.call_function('is_wp_error', [
					var_new_term.clone()]))
				{ rt.new_bool(false) } else { rt.call_function('get_term_by', [
						rt.new_string('id'),
						var_new_term.array_get(rt.new_string('term_id')),
						this.get_name(),
					]) }
			}
		}
		if rt.is_true(var_term)
			&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_term.clone()]))))) {
			var_terms << rt.get_property(var_term, 'slug')
		}
	}
	return var_terms.clone()
}

fn (mut this Class_WC_Product_Attribute) get_data() rt.PhpVal {
	return rt.call_function('array_merge', [this.extra_data, this.data,
		rt.create_array([
			rt.ArrayItem{
				key: 'is_visible'
				val: if rt.is_true(this.get_visible()) { 1 } else { 0 }
			},
			rt.ArrayItem{
				key: 'is_variation'
				val: if rt.is_true(this.get_variation()) { 1 } else { 0 }
			},
			rt.ArrayItem{
				key: 'is_taxonomy'
				val: if rt.is_true(this.is_taxonomy()) { 1 } else { 0 }
			},
			rt.ArrayItem{
				key: 'value'
				val: if rt.is_true(this.is_taxonomy()) { rt.new_string('') } else { rt.call_function('wc_implode_text_attributes', [
						this.get_options(),
					]) }
			},
		])])
}

fn (mut this Class_WC_Product_Attribute) set_extra_data(key string, var_value rt.PhpVal) {
	this.extra_data.array_set(key, var_value.clone())
}

fn (mut this Class_WC_Product_Attribute) set_id(var_value rt.PhpVal) {
	this.data.array_set('id', rt.call_function('absint', [var_value.clone()]))
}

fn (mut this Class_WC_Product_Attribute) set_name(var_value rt.PhpVal) {
	this.data.array_set('name', var_value.clone())
}

fn (mut this Class_WC_Product_Attribute) set_options(var_value rt.PhpVal) {
	this.data.array_set('options', var_value.clone())
}

fn (mut this Class_WC_Product_Attribute) set_position(var_value rt.PhpVal) {
	this.data.array_set('position', rt.call_function('absint', [
		var_value.clone()]))
}

fn (mut this Class_WC_Product_Attribute) set_visible(var_value rt.PhpVal) {
	this.data.array_set('visible', rt.call_function('wc_string_to_bool', [
		var_value.clone()]))
}

fn (mut this Class_WC_Product_Attribute) set_variation(var_value rt.PhpVal) {
	this.data.array_set('variation', rt.call_function('wc_string_to_bool', [
		var_value.clone()]))
}

fn (mut this Class_WC_Product_Attribute) get_all_extra_data() rt.PhpVal {
	return this.extra_data
}

fn (mut this Class_WC_Product_Attribute) get_extra_data(key string) rt.PhpVal {
	return if !(this.extra_data.array_get(rt.new_string(key))).is_null() {
		this.extra_data.array_get(rt.new_string(key))
	} else {
		rt.new_null()
	}
}

fn (mut this Class_WC_Product_Attribute) get_id() rt.PhpVal {
	return this.data.array_get(rt.new_string('id'))
}

fn (mut this Class_WC_Product_Attribute) get_name() rt.PhpVal {
	return this.data.array_get(rt.new_string('name'))
}

fn (mut this Class_WC_Product_Attribute) get_options() rt.PhpVal {
	return this.data.array_get(rt.new_string('options'))
}

fn (mut this Class_WC_Product_Attribute) get_position() rt.PhpVal {
	return this.data.array_get(rt.new_string('position'))
}

fn (mut this Class_WC_Product_Attribute) get_visible() rt.PhpVal {
	return this.data.array_get(rt.new_string('visible'))
}

fn (mut this Class_WC_Product_Attribute) get_variation() rt.PhpVal {
	return this.data.array_get(rt.new_string('variation'))
}

fn (mut this Class_WC_Product_Attribute) offsetget(var_offset rt.PhpVal) rt.PhpVal {
	mut switch_val_1 := var_offset
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('is_variation'))) {
		return rt.new_int(if rt.is_true(this.get_variation()) { 1 } else { 0 })
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('is_visible'))) {
		return rt.new_int(if rt.is_true(this.get_visible()) { 1 } else { 0 })
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('is_taxonomy'))) {
		return rt.new_int(if rt.is_true(this.is_taxonomy()) { 1 } else { 0 })
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('value'))) {
		return if rt.is_true(this.is_taxonomy()) { rt.new_string('') } else { rt.call_function('wc_implode_text_attributes', [
				this.get_options(),
			]) }
	} else {
		if rt.is_true(rt.call_function('is_callable', [
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('WC_Product_Attribute', [
					'ArrayAccess',
				], &this) },
				rt.ArrayItem{ key: none, val: 'get_${var_offset.to_string()}' },
			]),
		]))
		{
			return rt.call_method(rt.new_object('WC_Product_Attribute', [
				'ArrayAccess',
			], &this), 'get_${var_offset.to_string()}', []rt.PhpVal{})
		}
		if this.extra_data.array_isset(var_offset) {
			return this.extra_data.array_get(var_offset)
		}
	}
	return rt.new_string('')
}

fn (mut this Class_WC_Product_Attribute) offsetset(var_offset rt.PhpVal, var_value rt.PhpVal) {
	mut switch_val_2 := var_offset
	if rt.is_true(rt.equal(switch_val_2, rt.new_string('is_variation'))) {
		this.set_variation(var_value.clone())
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('is_visible'))) {
		this.set_visible(var_value.clone())
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('value'))) {
		this.set_options(var_value.clone())
	} else {
		if rt.is_true(rt.call_function('is_callable', [
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('WC_Product_Attribute', [
					'ArrayAccess',
				], &this) },
				rt.ArrayItem{ key: none, val: 'set_${var_offset.to_string()}' },
			]),
		]))
		{
			rt.call_method(rt.new_object('WC_Product_Attribute', ['ArrayAccess'], &this),
				'set_${var_offset.to_string()}', [var_value.clone()])
		}
		this.extra_data.array_set(var_offset, var_value.clone())
	}
}

fn (mut this Class_WC_Product_Attribute) offsetunset(var_offset rt.PhpVal) {
}

fn (mut this Class_WC_Product_Attribute) offsetexists(var_offset rt.PhpVal) rt.PhpVal {
	return rt.call_function('in_array', [var_offset.clone(),
		rt.call_function('array_merge', [
			rt.create_array([rt.ArrayItem{ key: none, val: 'is_variation' },
				rt.ArrayItem{ key: none, val: 'is_visible' },
				rt.ArrayItem{ key: none, val: 'is_taxonomy' },
				rt.ArrayItem{ key: none, val: 'value' }]),
			rt.func_array_keys(this.data),
			rt.func_array_keys(this.extra_data),
		]),
		rt.new_bool(true)])
}

fn create_wc_product_attribute(_args ...rt.PhpVal) &Class_WC_Product_Attribute {
	mut obj := &Class_WC_Product_Attribute{
		PhpObjectBase: rt.PhpObjectBase{}
		data:          rt.new_array()
		extra_data:    rt.new_array()
	}
	return obj
}

fn (mut this Class_WC_Product_Attribute) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'is_taxonomy' {
			return this.is_taxonomy()
		}
		'get_taxonomy' {
			return this.get_taxonomy()
		}
		'get_taxonomy_object' {
			return this.get_taxonomy_object()
		}
		'get_terms' {
			return this.get_terms()
		}
		'get_slugs' {
			return this.get_slugs()
		}
		'get_data' {
			return this.get_data()
		}
		'set_extra_data' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.set_extra_data(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'set_id' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_id(dispatch_arg_0)
			return rt.new_null()
		}
		'set_name' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_name(dispatch_arg_0)
			return rt.new_null()
		}
		'set_options' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_options(dispatch_arg_0)
			return rt.new_null()
		}
		'set_position' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_position(dispatch_arg_0)
			return rt.new_null()
		}
		'set_visible' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_visible(dispatch_arg_0)
			return rt.new_null()
		}
		'set_variation' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_variation(dispatch_arg_0)
			return rt.new_null()
		}
		'get_all_extra_data' {
			return this.get_all_extra_data()
		}
		'get_extra_data' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_extra_data(dispatch_arg_0)
		}
		'get_id' {
			return this.get_id()
		}
		'get_name' {
			return this.get_name()
		}
		'get_options' {
			return this.get_options()
		}
		'get_position' {
			return this.get_position()
		}
		'get_visible' {
			return this.get_visible()
		}
		'get_variation' {
			return this.get_variation()
		}
		'offsetGet' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.offsetget(dispatch_arg_0)
		}
		'offsetSet' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.offsetset(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'offsetUnset' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.offsetunset(dispatch_arg_0)
			return rt.new_null()
		}
		'offsetExists' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.offsetexists(dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_Product_Attribute) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'data' { return this.data }
		'extra_data' { return this.extra_data }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_Product_Attribute) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'data' {
			this.data = val
			return true
		}
		'extra_data' {
			this.extra_data = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
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

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}
