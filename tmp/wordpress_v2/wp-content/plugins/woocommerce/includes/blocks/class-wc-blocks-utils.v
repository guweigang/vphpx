import rt

struct Class_WC_Blocks_Utils {
	rt.PhpObjectBase
}

fn Class_WC_Blocks_Utils.get_all_blocks_from_page(var_woo_page_name rt.PhpVal) rt.PhpVal {
	mut var_page_id := rt.call_function('wc_get_page_id', [var_woo_page_name.clone()])
	mut var_page := rt.call_function('get_post', [var_page_id.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_page)))) {
		return rt.new_array()
	}
	mut var_blocks := rt.call_function('parse_blocks', [
		rt.get_property(var_page, 'post_content'),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_blocks)))) {
		return rt.new_array()
	}
	return var_blocks.clone()
}

fn Class_WC_Blocks_Utils.get_blocks_from_page(var_block_name rt.PhpVal, var_woo_page_name rt.PhpVal) rt.PhpVal {
	mut var_page_blocks := Class_WC_Blocks_Utils.get_all_blocks_from_page(var_woo_page_name.clone())
	closure_1_fn := fn [var_block_name] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_block := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.identical(var_block_name, var_block.array_get(rt.new_string('blockName')))
	}
	closure_2_fn := fn [var_block_name] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_block := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.identical(var_block_name, var_block.array_get(rt.new_string('blockName')))
	}
	return rt.call_function('array_values', [
		rt.call_function('array_filter', [var_page_blocks.clone(),
			rt.new_closure(closure_1_fn)]),
	])
}

fn Class_WC_Blocks_Utils.has_block_in_page(var_page rt.PhpVal, var_block_name rt.PhpVal) bool {
	mut var_page_mutated := var_page
	mut var_page_to_check := rt.call_function('get_post', [var_page_mutated.clone()])
	if rt.is_true(rt.identical(rt.new_null(), var_page_to_check)) {
		return false
	}
	mut var_blocks := rt.call_function('parse_blocks', [
		rt.get_property(var_page_to_check, 'post_content'),
	])
	mut iter_1 := var_blocks.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_block := item_1.val
		if rt.is_true(rt.identical(var_block_name, var_block.array_get(rt.new_string('blockName')))) {
			return true
		}
	}
	return false
}

fn create_wc_blocks_utils(_args ...rt.PhpVal) &Class_WC_Blocks_Utils {
	mut obj := &Class_WC_Blocks_Utils{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Blocks_Utils) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_all_blocks_from_page' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_Blocks_Utils.get_all_blocks_from_page(dispatch_arg_0)
		}
		'get_blocks_from_page' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_WC_Blocks_Utils.get_blocks_from_page(dispatch_arg_0, dispatch_arg_1)
		}
		'has_block_in_page' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(Class_WC_Blocks_Utils.has_block_in_page(dispatch_arg_0,
				dispatch_arg_1))
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_Blocks_Utils) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Blocks_Utils) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}
