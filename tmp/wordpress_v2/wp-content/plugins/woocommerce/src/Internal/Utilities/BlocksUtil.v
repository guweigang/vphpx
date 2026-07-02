import rt

struct Class_Automattic_WooCommerce_Internal_Utilities_BlocksUtil {
	rt.PhpObjectBase
}

fn Class_Automattic_WooCommerce_Internal_Utilities_BlocksUtil.flatten_blocks(var_blocks rt.PhpVal) rt.PhpVal {
	mut var_blocks_mutated := var_blocks
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_carry := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_block := if args.len > 1 { args[1].clone() } else { rt.new_null() }
		var_carry.clone().array_push(rt.call_function('array_diff_key', [
			var_block.clone(),
			rt.call_function('array_flip', [
				rt.create_array([rt.ArrayItem{ key: none, val: 'innerBlocks' }]),
			])]))
		if var_block.array_isset(rt.new_string('innerBlocks')) {
			mut var_inner_blocks :=
				Class_Automattic_WooCommerce_Internal_Utilities_BlocksUtil.flatten_blocks(var_block.array_get(rt.new_string('innerBlocks')))
			return rt.call_function('array_merge', [var_carry.clone(),
				var_inner_blocks.clone()])
		}
		return var_carry.clone()
	}
	return rt.call_function('array_reduce', [var_blocks_mutated.clone(),
		rt.new_closure(closure_1_fn), rt.new_array()])
}

fn Class_Automattic_WooCommerce_Internal_Utilities_BlocksUtil.get_blocks_from_widget_area(var_block_name rt.PhpVal) rt.PhpVal {
	mut var_blocks := rt.call_function('get_option', [rt.new_string('widget_block')])
	if !(var_blocks.clone().is_array()) || !rt.is_true(var_blocks) {
		return rt.new_array()
	}
	closure_2_fn := fn [var_block_name] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_acc := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_block := if args.len > 1 { args[1].clone() } else { rt.new_null() }
		mut var_parsed_blocks := if !(!rt.is_true(var_block.array_get(rt.new_string('content')))) { rt.call_function('parse_blocks', [
				var_block.array_get(rt.new_string('content')),
			]) } else { rt.new_array() }
		if !(!rt.is_true(var_parsed_blocks))
			&& rt.is_true(rt.identical(var_block_name, var_parsed_blocks.array_get(rt.new_int(0)).array_get(rt.new_string('blockName')))) {
			var_acc.clone().array_push(var_parsed_blocks.array_get(rt.new_int(0)))
		}
		return var_acc.clone()
	}
	return rt.call_function('array_reduce', [var_blocks.clone(),
		rt.new_closure(closure_2_fn), rt.new_array()])
}

fn Class_Automattic_WooCommerce_Internal_Utilities_BlocksUtil.get_block_from_template_part(var_block_name rt.PhpVal, var_template_part_slug rt.PhpVal) rt.PhpVal {
	mut var_template := rt.call_function('get_block_template', [
		rt.new_string((rt.call_function('get_stylesheet', []rt.PhpVal{})).str() + '//' +
			var_template_part_slug.str()),
		rt.new_string('wp_template_part'),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_template))))
		|| rt.is_true(rt.identical(rt.new_null(), rt.get_property(var_template, 'content'))) {
		return rt.new_array()
	}
	mut var_blocks := rt.call_function('parse_blocks', [
		rt.get_property(var_template, 'content'),
	])
	mut var_flatten_blocks :=
		Class_Automattic_WooCommerce_Internal_Utilities_BlocksUtil.flatten_blocks(var_blocks.clone())
	closure_3_fn := fn [var_block_name] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_block := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.identical(var_block_name, var_block.array_get(rt.new_string('blockName')))
	}
	closure_4_fn := fn [var_block_name] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_block := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.identical(var_block_name, var_block.array_get(rt.new_string('blockName')))
	}
	return rt.call_function('array_values', [
		rt.call_function('array_filter', [var_flatten_blocks.clone(),
			rt.new_closure(closure_3_fn)]),
	])
}

fn create_automattic_woocommerce_internal_utilities_blocksutil(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Utilities_BlocksUtil {
	mut obj := &Class_Automattic_WooCommerce_Internal_Utilities_BlocksUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_Utilities_BlocksUtil) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'flatten_blocks' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Internal_Utilities_BlocksUtil.flatten_blocks(dispatch_arg_0)
		}
		'get_blocks_from_widget_area' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Internal_Utilities_BlocksUtil.get_blocks_from_widget_area(dispatch_arg_0)
		}
		'get_block_from_template_part' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Internal_Utilities_BlocksUtil.get_block_from_template_part(dispatch_arg_0,
				dispatch_arg_1)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Utilities_BlocksUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Utilities_BlocksUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
