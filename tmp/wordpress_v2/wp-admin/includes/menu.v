import rt

fn add_cssclass(class_to_add string, var_classes rt.PhpVal) string {
	mut var_class_to_add := class_to_add
	if !rt.is_true(var_classes) {
		return class_to_add
	}
	return (var_classes).str() + ' ' + class_to_add
}

fn add_menu_classes(var_menu rt.PhpVal) rt.PhpVal {
	mut var_first_item := false
	mut var_last_order := rt.new_null()
	mut var_items_count := i64(0)
	mut var_i := i64(0)
	mut var_top := []rt.PhpVal{}
	mut var_order := rt.new_null()
	mut var_classes := rt.new_null()
	var_first_item = false
	var_last_order = rt.new_bool(false)
	var_items_count = var_menu.clone().array_count()
	var_i = 0
	mut iter_7 := var_menu.iterator()
	for {
		item_7 := iter_7.next() or { break }
		mut var_top_shadow := item_7.val
		mut var_order_shadow := item_7.key
		var_i += 1
		if rt.is_true(rt.identical(rt.new_int(0), var_order_shadow)) {
			var_menu.array_get_mut(0).array_set(4, add_cssclass('menu-top-first', var_top_shadow[4]))
			var_last_order = rt.new_int(0)
			continue
		}
		if rt.is_true(rt.call_function('str_starts_with', [var_top_shadow[2], rt.new_string('separator')])) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_last_order)))) {
			var_first_item = true
			var_classes = var_menu.array_get(var_last_order).array_get(rt.new_int(4))
			var_menu.array_get_mut(var_last_order).array_set(4, add_cssclass('menu-top-last', var_classes.clone()))
			continue
		}
		if var_first_item {
			var_first_item = false
			var_classes = var_menu.array_get(var_order_shadow).array_get(rt.new_int(4))
			var_menu.array_get_mut(var_order_shadow).array_set(4, add_cssclass('menu-top-first', var_classes.clone()))
		}
		if var_i == var_items_count {
			var_classes = var_menu.array_get(var_order_shadow).array_get(rt.new_int(4))
			var_menu.array_get_mut(var_order_shadow).array_set(4, add_cssclass('menu-top-last', var_classes.clone()))
		}
	var_last_order = var_order_shadow
	}
	return rt.call_function('apply_filters', [rt.new_string('add_menu_classes'), var_menu.clone()])
}

mut var_default_menu_order := var_menu_order.clone()
var_menu_order = rt.call_function('apply_filters', [rt.new_string('menu_order'), var_menu_order.clone()])
var_menu_order = rt.call_function('array_flip', [var_menu_order.clone()])
var_default_menu_order = rt.call_function('array_flip', [var_default_menu_order.clone()])
fn sort_menu(var_a_arg rt.PhpVal, var_b_arg rt.PhpVal) i64 {
	mut var_a := var_a_arg
	mut var_b := var_b_arg
	mut var_menu_order := rt.new_null()
	mut var_default_menu_order := rt.new_null()
	var_a = var_a.array_get(rt.new_int(2))
	var_b = var_b.array_get(rt.new_int(2))
	if var_menu_order.array_isset(var_a) && !(var_menu_order.array_isset(var_b)) {
		return -1
	} else if !(var_menu_order.array_isset(var_a)) && var_menu_order.array_isset(var_b) {
		return 1
	} else if var_menu_order.array_isset(var_a) && var_menu_order.array_isset(var_b) {
		return (rt.new_null()).to_i64()
	} else {
		return (rt.new_null()).to_i64()
	}
	return 0
}


fn main() {
	defer {
		rt.shutdown()
	}

	mut var_submenu := rt.new_null()
	mut var_compat := rt.new_null()
	mut var_admin_page_hooks := rt.new_null()
	mut var__wp_real_parent_file := rt.new_null()
	if rt.is_true(rt.call_function('is_network_admin', []rt.PhpVal{})) {
		rt.call_function('do_action', [rt.new_string('_network_admin_menu')])
	} else if rt.is_true(rt.call_function('is_user_admin', []rt.PhpVal{})) {
		rt.call_function('do_action', [rt.new_string('_user_admin_menu')])
	} else {
		rt.call_function('do_action', [rt.new_string('_admin_menu')])
	}
	mut var_menu := rt.get_superglobal('menu')
	mut iter_1 := var_menu.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_menu_page := item_1.val
		mut var_pos := rt.call_function('strpos', [var_menu_page.array_get(rt.new_int(2)), rt.new_string('?')])
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_pos)))) {
			mut var_hook_name := rt.call_function('substr', [var_menu_page.array_get(rt.new_int(2)), rt.new_int(0), var_pos.clone()])
			mut var_hook_args := rt.call_function('substr', [var_menu_page.array_get(rt.new_int(2)), rt.add(var_pos, rt.new_int(1))])
			rt.call_function('wp_parse_str', [var_hook_args.clone(), var_hook_args.clone()])
			if var_hook_args.array_isset(rt.new_string('post_type')) {
			var_hook_name = var_hook_args.array_get(rt.new_string('post_type'))
			} else {
			var_hook_name = rt.call_function('basename', [var_hook_name.clone(), rt.new_string('.php')])
			}
			var_hook_args = rt.new_null()
		} else {
		var_hook_name = rt.call_function('basename', [var_menu_page.array_get(rt.new_int(2)), rt.new_string('.php')])
		}
		var_hook_name = rt.call_function('sanitize_title', [var_hook_name.clone()])
		if var_compat.array_isset(var_hook_name) {
		var_hook_name = var_compat.array_get(var_hook_name)
		} else if rt.is_true(rt.new_bool(!(rt.is_true(var_hook_name)))) {
			continue
		}
		var_admin_page_hooks.array_set(var_menu_page.array_get(rt.new_int(2)), var_hook_name.clone())
	}
	var_menu_page = rt.new_null()
	var_compat = rt.new_null()
	mut var__wp_submenu_nopriv := rt.new_array()
	mut var__wp_menu_nopriv := rt.new_array()
	mut iter_2 := var_submenu.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_sub := item_2.val
		mut var_parent := item_2.key
		mut iter_3 := var_sub.iterator()
		for {
			item_3 := iter_3.next() or { break }
			mut var_data := item_3.val
			mut var_index := item_3.key
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [var_data.array_get(rt.new_int(1))]))))) {
				var_submenu.array_get(var_parent).array_unset(var_index)
				var__wp_submenu_nopriv.array_get_mut(var_parent).array_set(var_data.array_get(rt.new_int(2)), true)
			}
		}
		var_index = rt.new_null()
		var_data = rt.new_null()
		if !rt.is_true(var_submenu.array_get(var_parent)) {
			var_submenu.array_unset(var_parent)
		}
	}
	var_sub = rt.new_null()
	var_parent = rt.new_null()
	mut iter_4 := var_menu.iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_data := item_4.val
		mut var_id := item_4.key
		if !rt.is_true(var_submenu.array_get(var_data.array_get(rt.new_int(2)))) {
			continue
		}
		mut var_subs := var_submenu.array_get(var_data.array_get(rt.new_int(2)))
		mut var_first_sub := rt.call_function('reset', [var_subs.clone()])
		mut var_old_parent := var_data.array_get(rt.new_int(2))
		mut var_new_parent := var_first_sub.array_get(rt.new_int(2))
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_new_parent, var_old_parent)))) {
			var__wp_real_parent_file.array_set(var_old_parent, var_new_parent.clone())
			var_menu.array_get_mut(var_id).array_set(2, var_new_parent.clone())
			mut iter_5 := var_submenu.array_get(var_old_parent).iterator()
			for {
				item_5 := iter_5.next() or { break }
				mut var_data_shadow := item_5.val
				mut var_index := item_5.key
				var_submenu.array_get_mut(var_new_parent).array_set(var_index, var_submenu.array_get(var_old_parent).array_get(var_index))
				var_submenu.array_get(var_old_parent).array_unset(var_index)
			}
			var_submenu.array_unset(var_old_parent)
			var_index = rt.new_null()
			if var__wp_submenu_nopriv.array_isset(var_old_parent) {
				var__wp_submenu_nopriv.array_set(var_new_parent, var__wp_submenu_nopriv.array_get(var_old_parent))
			}
		}
	}
	var_id = rt.new_null()
	var_data = rt.new_null()
	var_subs = rt.new_null()
	var_first_sub = rt.new_null()
	var_old_parent = rt.new_null()
	var_new_parent = rt.new_null()
	if rt.is_true(rt.call_function('is_network_admin', []rt.PhpVal{})) {
		rt.call_function('do_action', [rt.new_string('network_admin_menu'), rt.new_string('')])
	} else if rt.is_true(rt.call_function('is_user_admin', []rt.PhpVal{})) {
		rt.call_function('do_action', [rt.new_string('user_admin_menu'), rt.new_string('')])
	} else {
		rt.call_function('do_action', [rt.new_string('admin_menu'), rt.new_string('')])
	}
	mut iter_6 := var_menu.iterator()
	for {
		item_6 := iter_6.next() or { break }
		mut var_data := item_6.val
		mut var_id := item_6.key
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [var_data.array_get(rt.new_int(1))]))))) {
			var__wp_menu_nopriv.array_set(var_data.array_get(rt.new_int(2)), true)
		}
		if !(!rt.is_true(var_submenu.array_get(var_data.array_get(rt.new_int(2))))) && 1 == var_submenu.array_get(var_data.array_get(rt.new_int(2))).array_count() {
			mut var_subs := var_submenu.array_get(var_data.array_get(rt.new_int(2)))
			mut var_first_sub := rt.call_function('reset', [var_subs.clone()])
			if rt.is_true(rt.identical(var_data.array_get(rt.new_int(2)), var_first_sub.array_get(rt.new_int(2)))) {
				var_submenu.array_unset(var_data.array_get(rt.new_int(2)))
			}
		}
		if !rt.is_true(var_submenu.array_get(var_data.array_get(rt.new_int(2)))) {
			if var__wp_menu_nopriv.array_isset(var_data.array_get(rt.new_int(2))) {
				var_menu.array_unset(var_id)
			}
		}
	}
	var_id = rt.new_null()
	var_data = rt.new_null()
	var_subs = rt.new_null()
	var_first_sub = rt.new_null()
	rt.call_function('uksort', [var_menu.clone(), rt.new_string('strnatcasecmp')])
	if rt.is_true(rt.call_function('apply_filters', [rt.new_string('custom_menu_order'), rt.new_bool(false)])) {
		mut var_menu_order := rt.new_array()
		mut iter_8 := var_menu.iterator()
		for {
			item_8 := iter_8.next() or { break }
			mut var_menu_item := item_8.val
			var_menu_order.array_push(var_menu_item.array_get(rt.new_int(2)))
		}
		var_menu_item = rt.new_null()
		rt.call_function('usort', [var_menu.clone(), rt.new_string('sort_menu')])
		var_menu_order = rt.new_null()
		var_default_menu_order = rt.new_null()
	}
	mut var_prev_menu_was_separator := false
	mut iter_9 := var_menu.iterator()
	for {
		item_9 := iter_9.next() or { break }
		mut var_data := item_9.val
		mut var_id := item_9.key
		if rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('stristr', [var_data.array_get(rt.new_int(4)), rt.new_string('wp-menu-separator')]))) {
		var_prev_menu_was_separator = false
		} else {
			if rt.is_true(rt.identical(rt.new_bool(true), rt.new_bool(var_prev_menu_was_separator))) {
				var_menu.array_unset(var_id)
			}
		var_prev_menu_was_separator = true
		}
	}
	var_id = rt.new_null()
	var_data = rt.new_null()
	var_prev_menu_was_separator = false
	mut var_last_menu_key := rt.func_array_keys(var_menu.clone())
	var_last_menu_key = rt.call_function('array_pop', [var_last_menu_key.clone()])
	if !(!rt.is_true(var_menu)) && rt.is_true(rt.identical(rt.new_string('wp-menu-separator'), var_menu.array_get(var_last_menu_key).array_get(rt.new_int(4)))) {
		var_menu.array_unset(var_last_menu_key)
	}
	var_last_menu_key = rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('user_can_access_admin_page', []rt.PhpVal{}))))) {
		rt.call_function('do_action', [rt.new_string('admin_page_access_denied')])
		rt.call_function('wp_die', [rt.call_function('__', [rt.new_string('Sorry, you are not allowed to access this page.')]), rt.new_int(403)])
	}
}
