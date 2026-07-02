import rt

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_LexicalDistance {
	rt.PhpObjectBase
pub mut:
		input string
		inputLowerCase string
		inputArray rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_LexicalDistance) construct(input string) {
	this.input = input
	this.inputLowerCase = input.to_lower()
	this.inputArray = Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_LexicalDistance.stringtoarray(this.inputLowerCase)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_LexicalDistance) measure(option string, threshold f64) i64 {
	mut var_upRow := rt.new_null()
	mut var_currentRow := rt.new_null()
	if rt.is_true(rt.identical(this.input, rt.new_string(option))) {
		return 0
	}
	mut var_optionLowerCase := rt.new_string(option.to_lower())
	if rt.is_true(rt.identical(this.inputLowerCase, var_optionLowerCase)) {
		return 1
	}
	mut var_a := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_LexicalDistance.stringtoarray((var_optionLowerCase).str())
	mut var_b := this.inputArray
	if var_a.clone().array_count() < var_b.clone().array_count() {
	mut var_tmp := var_a.clone()
	var_a = var_b.clone()
	var_b = var_tmp.clone()
	}
	mut var_aLength := rt.new_int(var_a.clone().array_count())
	mut var_bLength := rt.new_int(var_b.clone().array_count())
	if rt.is_true(rt.greater(rt.sub(var_aLength, var_bLength), rt.new_float(threshold))) {
		return (rt.new_null()).to_i64()
	}
	mut var_rows := rt.new_array()
	mut var_i := rt.new_int(0)
	for {
		if !(rt.is_true(rt.less_equal(var_i, var_bLength))) { break }
		var_rows.array_get_mut(0).array_set(var_i, var_i.clone())
		rt.pre_inc(var_i)
	}
	mut var_i := rt.new_int(1)
	for {
		if !(rt.is_true(rt.less_equal(var_i, var_aLength))) { break }
		mut var_upRow := var_rows.array_get(rt.mod_(rt.sub(var_i, rt.new_int(1)), rt.new_int(3)))
		mut var_currentRow := var_rows.array_get(rt.mod_(var_i, rt.new_int(3)))
		mut var_smallestCell := var_currentRow.array_set(0, var_i.clone())
		mut var_j := rt.new_int(1)
		for {
			if !(rt.is_true(rt.less_equal(var_j, var_bLength))) { break }
			mut var_cost := rt.new_int(if rt.is_true(rt.identical(var_a.array_get(rt.sub(var_i, rt.new_int(1))), var_b.array_get(rt.sub(var_j, rt.new_int(1))))) { 0 } else { 1 })
			mut var_currentCell := rt.call_function('min', [rt.add(var_upRow.array_get(var_j), rt.new_int(1)), rt.add(var_currentRow.array_get(rt.sub(var_j, rt.new_int(1))), rt.new_int(1)), rt.add(var_upRow.array_get(rt.sub(var_j, rt.new_int(1))), var_cost)])
			if rt.is_true(rt.greater(var_i, rt.new_int(1))) && rt.is_true(rt.greater(var_j, rt.new_int(1))) && rt.is_true(rt.identical(var_a.array_get(rt.sub(var_i, rt.new_int(1))), var_b.array_get(rt.sub(var_j, rt.new_int(2))))) && rt.is_true(rt.identical(var_a.array_get(rt.sub(var_i, rt.new_int(2))), var_b.array_get(rt.sub(var_j, rt.new_int(1))))) {
			mut var_doubleDiagonalCell := var_rows.array_get(rt.mod_(rt.sub(var_i, rt.new_int(2)), rt.new_int(3))).array_get(rt.sub(var_j, rt.new_int(2)))
			var_currentCell = rt.call_function('min', [var_currentCell.clone(), rt.add(var_doubleDiagonalCell, rt.new_int(1))])
			}
			if rt.is_true(rt.less(var_currentCell, var_smallestCell)) {
			var_smallestCell = var_currentCell.clone()
			}
			var_currentRow.array_set(var_j, var_currentCell.clone())
			rt.pre_inc(var_j)
		}
		if rt.is_true(rt.greater(var_smallestCell, rt.new_float(threshold))) {
			return (rt.new_null()).to_i64()
		}
		rt.pre_inc(var_i)
	}
	mut var_distance := var_rows.array_get(rt.mod_(var_aLength, rt.new_int(3))).array_get(var_bLength)
	return (if rt.is_true(rt.less_equal(var_distance, rt.new_float(threshold))) { var_distance } else { rt.new_null() }).to_i64()
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_LexicalDistance.stringtoarray(str string) rt.PhpVal {
	mut var_array := rt.new_array()
	mut iter_1 := rt.call_function('mb_str_split', [rt.new_string(str)]).iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_char := item_1.val
		var_array.array_push(rt.call_function('mb_ord', [var_char.clone()]))
	}
	return var_array.clone()
}

fn create_automattic_woocommerce_vendor_graphql_utils_lexicaldistance(input string) &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_LexicalDistance {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_LexicalDistance{
		PhpObjectBase: rt.PhpObjectBase{}
		input: ''
		inputLowerCase: ''
		inputArray: rt.new_null()
	}
	obj.construct(input)
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_LexicalDistance) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'measure' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_f64()
			return rt.new_int(this.measure(dispatch_arg_0, dispatch_arg_1))
		}
		'stringToArray' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_LexicalDistance.stringtoarray(dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_LexicalDistance) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'input' { return rt.new_string(this.input) }
		'inputLowerCase' { return rt.new_string(this.inputLowerCase) }
		'inputArray' { return this.inputArray }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_LexicalDistance) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'input' { this.input = (val).str(); return true }
		'inputLowerCase' { this.inputLowerCase = (val).str(); return true }
		'inputArray' { this.inputArray = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}



fn main() {
	defer {
		rt.shutdown()
	}

}
