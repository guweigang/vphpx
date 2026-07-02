import rt

struct Class_WP_List_Util {
	rt.PhpObjectBase
pub mut:
	input   rt.PhpVal = rt.new_array()
	output  rt.PhpVal = rt.new_array()
	orderby rt.PhpVal = rt.new_array()
}

fn (mut this Class_WP_List_Util) construct(var_input rt.PhpVal) {
	this.output = var_input.clone()
	this.input = var_input.clone()
}

fn (mut this Class_WP_List_Util) get_input() rt.PhpVal {
	return this.input
}

fn (mut this Class_WP_List_Util) get_output() rt.PhpVal {
	return this.output
}

fn (mut this Class_WP_List_Util) filter(var_args rt.PhpVal, operator string) rt.PhpVal {
	mut operator_mutated := operator
	if !rt.is_true(var_args) {
		return this.output
	}
	operator_mutated = operator_mutated.to_upper()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
		rt.new_string(operator_mutated).clone(),
		rt.create_array([
			rt.ArrayItem{ key: none, val: 'AND' },
			rt.ArrayItem{ key: none, val: 'OR' },
			rt.ArrayItem{ key: none, val: 'NOT' },
		]),
		rt.new_bool(true)])))))
	{
		this.output = rt.new_array()
		return this.output
	}
	mut var_count := rt.new_int(var_args.clone().array_count())
	mut var_filtered := rt.new_array()
	mut iter_1 := this.output.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_obj := item_1.val
		mut var_key := item_1.key
		mut var_matched := rt.new_int(0)
		mut iter_2 := var_args.iterator()
		for {
			item_2 := iter_2.next() or { break }
			mut var_m_value := item_2.val
			mut var_m_key := item_2.key
			if rt.is_true(rt.new_bool(var_obj.clone().is_array())) {
				if rt.is_true(rt.new_bool(var_obj.clone().array_isset(var_m_key.clone())))
					&& rt.is_true(rt.equal(var_m_value, var_obj.array_get(var_m_key))) {
					rt.pre_inc(var_matched)
				}
			} else if rt.is_true(rt.new_bool(var_obj.clone().is_object())) {
				if !(rt.get_property(var_obj, '{"nodeType":"Expr_Variable","line":124,"name":"m_key"}')).is_null()
					&& rt.is_true(rt.equal(var_m_value, rt.get_property(var_obj, '{"nodeType":"Expr_Variable","line":124,"name":"m_key"}'))) {
					rt.pre_inc(var_matched)
				}
			}
		}
		if ((rt.is_true(rt.identical(rt.new_string('AND'), rt.new_string(operator_mutated)))
			&& rt.is_true(rt.identical(var_matched, var_count)))
			|| (rt.is_true(rt.identical(rt.new_string('OR'), rt.new_string(operator_mutated)))
			&& rt.is_true(rt.greater(var_matched, rt.new_int(0)))))
			|| (rt.is_true(rt.identical(rt.new_string('NOT'), rt.new_string(operator_mutated)))
			&& rt.is_true(rt.identical(rt.new_int(0), var_matched))) {
			var_filtered.array_set(var_key, var_obj.clone())
		}
	}
	this.output = var_filtered.clone()
	return this.output
}

fn (mut this Class_WP_List_Util) pluck(var_field rt.PhpVal, var_index_key rt.PhpVal) rt.PhpVal {
	mut var_newlist := rt.new_array()
	if rt.is_true(rt.new_bool(!(rt.is_true(var_index_key)))) {
		mut iter_3 := this.output.iterator()
		for {
			item_3 := iter_3.next() or { break }
			mut var_value := item_3.val
			mut var_key := item_3.key
			if rt.is_true(rt.new_bool(var_value.clone().is_object())) {
				var_newlist.array_set(var_key, rt.get_property(var_value,
					'{"nodeType":"Expr_Variable","line":168,"name":"field"}'))
			} else if rt.is_true(rt.new_bool(var_value.clone().is_array())) {
				var_newlist.array_set(var_key, var_value.array_get(var_field))
			} else {
				rt.call_function('_doing_it_wrong', [rt.new_string(@METHOD),
					rt.call_function('__', [
						rt.new_string('Values for the input array must be either objects or arrays.'),
					]),
					rt.new_string('6.2.0')])
			}
		}
		this.output = var_newlist.clone()
		return this.output
	}
	mut iter_4 := this.output.iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_value := item_4.val
		if rt.is_true(rt.new_bool(var_value.clone().is_object())) {
			if !(rt.get_property(var_value,
				'{"nodeType":"Expr_Variable","line":191,"name":"index_key"}')).is_null() {
				var_newlist.array_set(rt.get_property(var_value,
					'{"nodeType":"Expr_Variable","line":192,"name":"index_key"}'), rt.get_property(var_value,
					'{"nodeType":"Expr_Variable","line":192,"name":"field"}'))
			} else {
				var_newlist.array_push(rt.get_property(var_value,
					'{"nodeType":"Expr_Variable","line":194,"name":"field"}'))
			}
		} else if rt.is_true(rt.new_bool(var_value.clone().is_array())) {
			if var_value.array_isset(var_index_key) {
				var_newlist.array_set(var_value.array_get(var_index_key),
					var_value.array_get(var_field))
			} else {
				var_newlist.array_push(var_value.array_get(var_field))
			}
		} else {
			rt.call_function('_doing_it_wrong', [rt.new_string(@METHOD),
				rt.call_function('__', [
					rt.new_string('Values for the input array must be either objects or arrays.'),
				]),
				rt.new_string('6.2.0')])
		}
	}
	this.output = var_newlist.clone()
	return this.output
}

fn (mut this Class_WP_List_Util) sort(var_orderby rt.PhpVal, order string, preserve_keys bool) rt.PhpVal {
	mut var_orderby_mutated := var_orderby
	if !rt.is_true(var_orderby_mutated) {
		return this.output
	}
	if rt.is_true(rt.new_bool(var_orderby_mutated.clone().is_string())) {
		var_orderby_mutated = rt.create_array([
			rt.ArrayItem{ key: var_orderby_mutated, val: order },
		])
	}
	mut iter_5 := var_orderby_mutated.iterator()
	for {
		item_5 := iter_5.next() or { break }
		mut var_direction := item_5.val
		mut var_field := item_5.key
		var_orderby_mutated.array_set(var_field, if rt.is_true(rt.identical(rt.new_string('DESC'),
			rt.new_string(var_direction.clone().to_string().to_upper())))
		{
			'DESC'
		} else {
			'ASC'
		})
	}
	this.orderby = var_orderby_mutated.clone()
	if var_preserve_keys {
		rt.call_function('uasort', [this.output,
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('WP_List_Util', []string{}, &this) },
				rt.ArrayItem{ key: none, val: 'sort_callback' },
			])])
	} else {
		rt.call_function('usort', [this.output,
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('WP_List_Util', []string{}, &this) },
				rt.ArrayItem{ key: none, val: 'sort_callback' },
			])])
	}
	this.orderby = rt.new_array()
	return this.output
}

fn (mut this Class_WP_List_Util) sort_callback(var_a rt.PhpVal, var_b rt.PhpVal) i64 {
	mut var_a_mutated := var_a
	mut var_b_mutated := var_b
	if !rt.is_true(this.orderby) {
		return 0
	}
	var_a_mutated = rt.cast_array(var_a_mutated)
	var_b_mutated = rt.cast_array(var_b_mutated)
	mut iter_6 := this.orderby.iterator()
	for {
		item_6 := iter_6.next() or { break }
		mut var_direction := item_6.val
		mut var_field := item_6.key
		if !(var_a_mutated.array_isset(var_field)) || !(var_b_mutated.array_isset(var_field)) {
			continue
		}
		if rt.is_true(rt.equal(var_a_mutated.array_get(var_field),
			var_b_mutated.array_get(var_field)))
		{
			continue
		}
		mut var_results := if rt.is_true(rt.identical(rt.new_string('DESC'), var_direction)) { rt.create_array([
				rt.ArrayItem{ key: none, val: 1 },
				rt.ArrayItem{ key: none, val: -1 },
			]) } else { rt.create_array([rt.ArrayItem{ key: none, val: -1 },
				rt.ArrayItem{ key: none, val: 1 }]) }
		if var_a_mutated.array_get(var_field).is_long()
			|| var_a_mutated.array_get(var_field).is_double()
			&& var_b_mutated.array_get(var_field).is_long()
			|| var_b_mutated.array_get(var_field).is_double() {
			return (if rt.is_true(rt.less(var_a_mutated.array_get(var_field),
				var_b_mutated.array_get(var_field)))
			{
				var_results.array_get(rt.new_int(0))
			} else {
				var_results.array_get(rt.new_int(1))
			}).to_i64()
		}
		return (if rt.is_true(rt.greater(rt.new_int(0), rt.call_function('strcmp', [
			var_a_mutated.array_get(var_field),
			var_b_mutated.array_get(var_field),
		])))
		{
			var_results.array_get(rt.new_int(0))
		} else {
			var_results.array_get(rt.new_int(1))
		}).to_i64()
	}
	return 0
}

fn create_wp_list_util(arg_0 rt.PhpVal) &Class_WP_List_Util {
	mut obj := &Class_WP_List_Util{
		PhpObjectBase: rt.PhpObjectBase{}
		input:         rt.new_array()
		output:        rt.new_array()
		orderby:       rt.new_array()
	}
	obj.construct(arg_0)
	return obj
}

fn (mut this Class_WP_List_Util) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'get_input' {
			return this.get_input()
		}
		'get_output' {
			return this.get_output()
		}
		'filter' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return this.filter(dispatch_arg_0, dispatch_arg_1)
		}
		'pluck' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.pluck(dispatch_arg_0, dispatch_arg_1)
		}
		'sort' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
			return this.sort(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'sort_callback' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_int(this.sort_callback(dispatch_arg_0, dispatch_arg_1))
		}
		else {
			return none
		}
	}
}

fn (this &Class_WP_List_Util) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'input' { return this.input }
		'output' { return this.output }
		'orderby' { return this.orderby }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_List_Util) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'input' {
			this.input = val
			return true
		}
		'output' {
			this.output = val
			return true
		}
		'orderby' {
			this.orderby = val
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
