import rt

struct Class_WC_Order_Item_Data_Store {
	rt.PhpObjectBase
}

fn (mut this Class_WC_Order_Item_Data_Store) add_order_item(var_order_id rt.PhpVal, var_item rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_order_id_mutated := var_order_id
	// unsupported statement: Stmt_Global
	rt.call_method(var_wpdb, 'insert', [(rt.get_property(var_wpdb, 'prefix')).str() +
		'woocommerce_order_items',
		rt.create_array([
			rt.ArrayItem{ key: 'order_item_name', val: var_item.array_get('order_item_name') },
			rt.ArrayItem{ key: 'order_item_type', val: var_item.array_get('order_item_type') },
			rt.ArrayItem{ key: 'order_id', val: var_order_id_mutated },
		]),
		rt.create_array([
			rt.ArrayItem{ key: none, val: '%s' },
			rt.ArrayItem{ key: none, val: '%s' },
			rt.ArrayItem{ key: none, val: '%d' },
		])])
	mut var_item_id := rt.call_function('absint', [
		rt.get_property(var_wpdb, 'insert_id'),
	])
	this.clear_caches(var_item_id.dup(), var_order_id_mutated.dup())
	return var_item_id.dup()
}

fn (mut this Class_WC_Order_Item_Data_Store) update_order_item(var_item_id rt.PhpVal, var_item rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_item_id_mutated := var_item_id
	// unsupported statement: Stmt_Global
	mut var_updated := rt.call_method(var_wpdb, 'update', [
		(rt.get_property(var_wpdb, 'prefix')).str() + 'woocommerce_order_items',
		var_item.dup(),
		rt.create_array([rt.ArrayItem{ key: 'order_item_id', val: var_item_id_mutated }]),
	])
	this.clear_caches(var_item_id_mutated.dup(), rt.new_null())
	return var_updated.dup()
}

fn (mut this Class_WC_Order_Item_Data_Store) delete_order_item(var_item_id rt.PhpVal) {
	mut var_wpdb := rt.new_null()
	mut var_item_id_mutated := var_item_id
	mut var_order_id := this.get_order_id_by_order_item_id(var_item_id_mutated.dup())
	// unsupported statement: Stmt_Global
	rt.call_method(var_wpdb, 'query', [
		rt.call_method(var_wpdb, 'prepare', [
			rt.concat(rt.concat(rt.new_string('DELETE FROM '), rt.get_property(var_wpdb, 'prefix')),
				rt.new_string('woocommerce_order_items WHERE order_item_id = %d')),
			var_item_id_mutated.dup(),
		]),
	])
	rt.call_method(var_wpdb, 'query', [
		rt.call_method(var_wpdb, 'prepare', [
			rt.concat(rt.concat(rt.new_string('DELETE FROM '), rt.get_property(var_wpdb, 'prefix')),
				rt.new_string('woocommerce_order_itemmeta WHERE order_item_id = %d')),
			var_item_id_mutated.dup(),
		]),
	])
	this.clear_caches(var_item_id_mutated.dup(), var_order_id.dup())
}

fn (mut this Class_WC_Order_Item_Data_Store) update_metadata(var_item_id rt.PhpVal, var_meta_key rt.PhpVal, var_meta_value rt.PhpVal, prev_value string) rt.PhpVal {
	mut var_item_id_mutated := var_item_id
	return rt.call_function('update_metadata', [rt.new_string('order_item'),
		var_item_id_mutated.dup(), var_meta_key.dup(), if rt.is_true(rt.new_bool(var_meta_value.dup().is_string())) { rt.call_function('wp_slash', [
				var_meta_value.dup(),
			]) } else { var_meta_value }, rt.new_string(prev_value)])
}

fn (mut this Class_WC_Order_Item_Data_Store) add_metadata(var_item_id rt.PhpVal, var_meta_key rt.PhpVal, var_meta_value rt.PhpVal, unique bool) rt.PhpVal {
	mut var_item_id_mutated := var_item_id
	return rt.call_function('add_metadata', [rt.new_string('order_item'),
		var_item_id_mutated.dup(), rt.call_function('wp_slash', [
			var_meta_key.dup()]),
		if rt.is_true(rt.new_bool(var_meta_value.dup().is_string())) { rt.call_function('wp_slash', [
				var_meta_value.dup()]) } else { var_meta_value }, rt.new_bool(unique)])
}

fn (mut this Class_WC_Order_Item_Data_Store) delete_metadata(var_item_id rt.PhpVal, var_meta_key rt.PhpVal, meta_value string, delete_all bool) rt.PhpVal {
	mut var_item_id_mutated := var_item_id
	return rt.call_function('delete_metadata', [rt.new_string('order_item'),
		var_item_id_mutated.dup(), var_meta_key.dup(), if rt.is_true(rt.new_bool(rt.new_string(meta_value).is_string())) { rt.call_function('wp_slash', [
				rt.new_string(meta_value),
			]) } else { rt.new_string(meta_value) }, rt.new_bool(delete_all)])
}

fn (mut this Class_WC_Order_Item_Data_Store) get_metadata(var_item_id rt.PhpVal, var_key rt.PhpVal, single bool) rt.PhpVal {
	mut var_item_id_mutated := var_item_id
	return rt.call_function('get_metadata', [rt.new_string('order_item'),
		var_item_id_mutated.dup(), var_key.dup(), rt.new_bool(single)])
}

fn (mut this Class_WC_Order_Item_Data_Store) get_order_id_by_order_item_id(var_item_id rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_item_id_mutated := var_item_id
	// unsupported statement: Stmt_Global
	return
}

fn (mut this Class_WC_Order_Item_Data_Store) get_order_item_type(var_item_id rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_item_id_mutated := var_item_id
	// unsupported statement: Stmt_Global
	mut var_order_item_type := rt.call_method(var_wpdb, 'get_var', [
		rt.call_method(var_wpdb, 'prepare', [
			rt.concat(rt.concat(rt.new_string('SELECT order_item_type FROM '), rt.get_property(var_wpdb,
				'prefix')),
				rt.new_string('woocommerce_order_items WHERE order_item_id = %d LIMIT 1;')),
			var_item_id_mutated.dup(),
		]),
	])
	return var_order_item_type.dup()
}

fn (mut this Class_WC_Order_Item_Data_Store) clear_caches(var_item_id rt.PhpVal, var_order_id rt.PhpVal) {
	mut var_item_id_mutated := var_item_id
	mut var_order_id_mutated := var_order_id
	rt.call_function('wp_cache_delete', ['item-' + var_item_id_mutated.str(),
		rt.new_string('order-items')])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_order_id_mutated)))) {
		var_order_id_mutated = this.get_order_id_by_order_item_id(var_item_id_mutated.dup())
	}
	if rt.is_true(var_order_id_mutated) {
		rt.call_function('wp_cache_delete', [
			'order-items-' + var_order_id_mutated.str(),
			rt.new_string('orders'),
		])
		rt.call_function('wp_cache_delete', [
			'order-needs-processing-' + var_order_id_mutated.str(),
			rt.new_string('orders'),
		])
	}
}

fn create_wc_order_item_data_store() &Class_WC_Order_Item_Data_Store {
	mut obj := &Class_WC_Order_Item_Data_Store{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Order_Item_Data_Store) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'add_order_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.add_order_item(dispatch_arg_0, dispatch_arg_1)
		}
		'update_order_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.update_order_item(dispatch_arg_0, dispatch_arg_1)
		}
		'delete_order_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.delete_order_item(dispatch_arg_0)
			return rt.new_null()
		}
		'update_metadata' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).str()
			return this.update_metadata(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2,
				dispatch_arg_3)
		}
		'add_metadata' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).to_bool()
			return this.add_metadata(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
		}
		'delete_metadata' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).to_bool()
			return this.delete_metadata(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2,
				dispatch_arg_3)
		}
		'get_metadata' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
			return this.get_metadata(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'get_order_id_by_order_item_id' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_order_id_by_order_item_id(dispatch_arg_0)
		}
		'get_order_item_type' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_order_item_type(dispatch_arg_0)
		}
		'clear_caches' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.clear_caches(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_Order_Item_Data_Store) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Order_Item_Data_Store) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_woocommerce_includes_data_stores_class_wc_order_item_data_store_php() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		// unsupported expression: Expr_Exit
	}
}
