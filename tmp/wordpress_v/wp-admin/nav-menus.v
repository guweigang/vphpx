import rt


fn main() {
	defer {
		rt.shutdown()
	}

	mut var_current_user := rt.new_null()
	rt.include_file(@DIR + '/admin.php', '4')
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/nav-menu.php', '4')
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_theme_supports', [rt.new_string('menus')]))))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_theme_supports', [rt.new_string('widgets')]))))))) {
		rt.call_function('wp_die', [rt.call_function('__', [rt.new_string('Your theme does not support navigation menus or widgets.')])])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_theme_options')]))))) {
		rt.call_function('wp_die', ['<h1>' + (rt.call_function('__', [rt.new_string('You need a higher level of permission.')])).str() + '</h1>' + '<p>' + (rt.call_function('__', [rt.new_string('Sorry, you are not allowed to edit theme options on this site.')])).str() + '</p>', rt.new_int(403)])
	}
	mut var_title := rt.call_function('__', [rt.new_string('Menus')])
	rt.call_function('wp_enqueue_script', [rt.new_string('nav-menu')])
	if rt.is_true(rt.call_function('wp_is_mobile', []rt.PhpVal{})) {
		rt.call_function('wp_enqueue_script', [rt.new_string('jquery-touch-punch')])
	}
	mut var_messages := []rt.PhpVal{}
	mut var_nav_menu_selected_title := rt.new_string(rt.new_string(''))
	mut var_nav_menu_selected_id := if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('menu')) { // unsupported expression: Expr_Cast_Int } else { rt.new_int(0) }
	mut var_locations := rt.call_function('get_registered_nav_menus', []rt.PhpVal{})
	mut var_menu_locations := rt.call_function('get_nav_menu_locations', []rt.PhpVal{})
	mut var_num_locations := rt.func_array_keys(var_locations.dup()).array_count()
	mut var_action := if !(rt.get_superglobal('_REQUEST').array_get('action')).is_null() { rt.get_superglobal('_REQUEST').array_get('action') } else { rt.new_string('edit') }
	rt.call_function('_wp_expand_nav_menu_post_data', []rt.PhpVal{})
	mut switch_val_1 := var_action
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('add-menu-item'))) {
		rt.call_function('check_admin_referer', [rt.new_string('add-menu_item'), rt.new_string('menu-settings-column-nonce')])
		if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('nav-menu-locations')) {
			rt.call_function('set_theme_mod', [rt.new_string('nav_menu_locations'), rt.call_function('array_map', [rt.new_string('absint'), rt.get_superglobal('_REQUEST').array_get('menu-locations')])])
		} else if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('menu-item')) {
			rt.call_function('wp_save_nav_menu_items', [var_nav_menu_selected_id.dup(), rt.get_superglobal('_REQUEST').array_get('menu-item')])
		}
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('move-down-menu-item'))) {
		rt.call_function('check_admin_referer', [rt.new_string('move-menu_item')])
		mut var_menu_item_id := if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('menu-item')) { // unsupported expression: Expr_Cast_Int } else { rt.new_int(0) }
		if rt.is_true(rt.call_function('is_nav_menu_item', [var_menu_item_id.dup()])) {
			mut var_menus := if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('menu')) { rt.create_array([rt.ArrayItem{ key: none, val: // unsupported expression: Expr_Cast_Int }]) } else { rt.call_function('wp_get_object_terms', [var_menu_item_id.dup(), rt.new_string('nav_menu'), rt.create_array([rt.ArrayItem{ key: 'fields', val: 'ids' }])]) }
			if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_menus.dup()]))))) && !(!rt.is_true(var_menus.array_get(0))))) {
				mut var_menu_id := // unsupported expression: Expr_Cast_Int
				mut var_ordered_menu_items := rt.call_function('wp_get_nav_menu_items', [var_menu_id.dup()])
				mut var_menu_item_data := rt.cast_array(rt.call_function('wp_setup_nav_menu_item', [rt.call_function('get_post', [var_menu_item_id.dup()])]))
				mut var_dbids_to_orders := []rt.PhpVal{}
				mut var_orders_to_dbids := []rt.PhpVal{}
				{
					mut iter_1 := rt.cast_array(var_ordered_menu_items).iterator()
					for {
						item_1 := iter_1.next() or { break }
						mut var_ordered_menu_item_object := item_1.val
						if !(rt.get_property(var_ordered_menu_item_object, 'ID')).is_null() {
							if !(rt.get_property(var_ordered_menu_item_object, 'menu_order')).is_null() {
								var_dbids_to_orders.array_set(rt.get_property(var_ordered_menu_item_object, 'ID'), rt.get_property(var_ordered_menu_item_object, 'menu_order'))
								var_orders_to_dbids.array_set(rt.get_property(var_ordered_menu_item_object, 'menu_order'), rt.get_property(var_ordered_menu_item_object, 'ID'))
							}
						}
					}
				}
				if var_orders_to_dbids.array_isset(rt.add(var_dbids_to_orders.array_get(var_menu_item_id), rt.new_int(1))) {
					mut var_next_item_id := var_orders_to_dbids.array_get(rt.add(var_dbids_to_orders.array_get(var_menu_item_id), rt.new_int(1)))
					mut var_next_item_data := rt.cast_array(rt.call_function('wp_setup_nav_menu_item', [rt.call_function('get_post', [var_next_item_id.dup()])]))
					if rt.is_true(rt.new_bool(!(!rt.is_true(var_menu_item_data.array_get('menu_item_parent'))) && rt.is_true(rt.new_bool(!rt.is_true(var_next_item_data.array_get('menu_item_parent')) || rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))))) {
						if rt.is_true(rt.call_function('in_array', [// unsupported expression: Expr_Cast_Int, var_orders_to_dbids.dup(), rt.new_bool(true)])) {
							mut var_parent_db_id := // unsupported expression: Expr_Cast_Int
						} else {
							var_parent_db_id = rt.new_int(rt.new_int(0))
						}
						mut var_parent_object := rt.call_function('wp_setup_nav_menu_item', [rt.call_function('get_post', [var_parent_db_id.dup()])])
						if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_parent_object.dup()]))))) {
							mut var_parent_data := rt.cast_array(var_parent_object)
							var_menu_item_data.array_set('menu_item_parent', var_parent_data.array_get('menu_item_parent'))
							var_menu_item_data = rt.call_function('_wp_reset_invalid_menu_item_parent', [var_menu_item_data.dup()])
							rt.call_function('update_post_meta', [var_menu_item_data.array_get('ID'), rt.new_string('_menu_item_menu_item_parent'), // unsupported expression: Expr_Cast_Int])
						}
						// unsupported statement: Stmt_Nop
					} else {
						var_next_item_data.array_set('menu_order', rt.sub(var_next_item_data.array_get('menu_order'), rt.new_int(1)))
						var_menu_item_data.array_set('menu_order', rt.add(var_menu_item_data.array_get('menu_order'), rt.new_int(1)))
						var_menu_item_data.array_set('menu_item_parent', var_next_item_data.array_get('ID'))
						var_menu_item_data = rt.call_function('_wp_reset_invalid_menu_item_parent', [var_menu_item_data.dup()])
						rt.call_function('update_post_meta', [var_menu_item_data.array_get('ID'), rt.new_string('_menu_item_menu_item_parent'), // unsupported expression: Expr_Cast_Int])
						rt.call_function('wp_update_post', [var_menu_item_data.dup()])
						rt.call_function('wp_update_post', [var_next_item_data.dup()])
					}
					// unsupported statement: Stmt_Nop
				} else if rt.is_true(rt.new_bool(!(!rt.is_true(var_menu_item_data.array_get('menu_item_parent'))) && rt.is_true(rt.call_function('in_array', [// unsupported expression: Expr_Cast_Int, var_orders_to_dbids.dup(), rt.new_bool(true)])))) {
					var_menu_item_data.array_set('menu_item_parent', // unsupported expression: Expr_Cast_Int)
					var_menu_item_data = rt.call_function('_wp_reset_invalid_menu_item_parent', [var_menu_item_data.dup()])
					rt.call_function('update_post_meta', [var_menu_item_data.array_get('ID'), rt.new_string('_menu_item_menu_item_parent'), // unsupported expression: Expr_Cast_Int])
				}
			}
		}
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('move-up-menu-item'))) {
		rt.call_function('check_admin_referer', [rt.new_string('move-menu_item')])
		var_menu_item_id = if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('menu-item')) { // unsupported expression: Expr_Cast_Int } else { rt.new_int(0) }
		if rt.is_true(rt.call_function('is_nav_menu_item', [var_menu_item_id.dup()])) {
			if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('menu')) {
				var_menus = rt.create_array([rt.ArrayItem{ key: none, val: // unsupported expression: Expr_Cast_Int }])
			} else {
				var_menus = rt.call_function('wp_get_object_terms', [var_menu_item_id.dup(), rt.new_string('nav_menu'), rt.create_array([rt.ArrayItem{ key: 'fields', val: 'ids' }])])
			}
			if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_menus.dup()]))))) && !(!rt.is_true(var_menus.array_get(0))))) {
				var_menu_id = // unsupported expression: Expr_Cast_Int
				var_ordered_menu_items = rt.call_function('wp_get_nav_menu_items', [var_menu_id.dup()])
				var_menu_item_data = rt.cast_array(rt.call_function('wp_setup_nav_menu_item', [rt.call_function('get_post', [var_menu_item_id.dup()])]))
				var_dbids_to_orders = []rt.PhpVal{}
				var_orders_to_dbids = []rt.PhpVal{}
				{
					mut iter_1 := rt.cast_array(var_ordered_menu_items).iterator()
					for {
						item_1 := iter_1.next() or { break }
						mut var_ordered_menu_item_object := item_1.val
						if !(rt.get_property(var_ordered_menu_item_object, 'ID')).is_null() {
							if !(rt.get_property(var_ordered_menu_item_object, 'menu_order')).is_null() {
								var_dbids_to_orders.array_set(rt.get_property(var_ordered_menu_item_object, 'ID'), rt.get_property(var_ordered_menu_item_object, 'menu_order'))
								var_orders_to_dbids.array_set(rt.get_property(var_ordered_menu_item_object, 'menu_order'), rt.get_property(var_ordered_menu_item_object, 'ID'))
							}
						}
					}
				}
				if !(!rt.is_true(var_dbids_to_orders.array_get(var_menu_item_id))) && !(!rt.is_true(var_orders_to_dbids.array_get(rt.sub(var_dbids_to_orders.array_get(var_menu_item_id), rt.new_int(1))))) {
					if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(!rt.is_true(var_menu_item_data.array_get('menu_item_parent'))) && rt.is_true(rt.call_function('in_array', [// unsupported expression: Expr_Cast_Int, rt.func_array_keys(var_dbids_to_orders.dup()), rt.new_bool(true)])))) && var_orders_to_dbids.array_isset(rt.sub(var_dbids_to_orders.array_get(var_menu_item_id), rt.new_int(1))))) && rt.is_true(rt.identical(// unsupported expression: Expr_Cast_Int, var_orders_to_dbids.array_get(rt.sub(var_dbids_to_orders.array_get(var_menu_item_id), rt.new_int(1))))))) {
						if rt.is_true(rt.call_function('in_array', [// unsupported expression: Expr_Cast_Int, var_orders_to_dbids.dup(), rt.new_bool(true)])) {
							var_parent_db_id = // unsupported expression: Expr_Cast_Int
						} else {
							var_parent_db_id = rt.new_int(rt.new_int(0))
						}
						var_parent_object = rt.call_function('wp_setup_nav_menu_item', [rt.call_function('get_post', [var_parent_db_id.dup()])])
						if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_parent_object.dup()]))))) {
							var_parent_data = rt.cast_array(var_parent_object)
							if !(!rt.is_true(var_dbids_to_orders.array_get(var_parent_db_id))) && !(!rt.is_true(var_orders_to_dbids.array_get(rt.sub(var_dbids_to_orders.array_get(var_parent_db_id), rt.new_int(1))))) && !(!rt.is_true(var_parent_data.array_get('menu_item_parent'))) {
								var_menu_item_data.array_set('menu_item_parent', var_parent_data.array_get('menu_item_parent'))
								// unsupported statement: Stmt_Nop
							} else if !(!rt.is_true(var_dbids_to_orders.array_get(var_parent_db_id))) && !(!rt.is_true(var_orders_to_dbids.array_get(rt.sub(var_dbids_to_orders.array_get(var_parent_db_id), rt.new_int(1))))) {
								mut var__possible_parent_id := // unsupported expression: Expr_Cast_Int
								if rt.is_true(rt.call_function('in_array', [var__possible_parent_id.dup(), rt.func_array_keys(var_dbids_to_orders.dup()), rt.new_bool(true)])) {
									var_menu_item_data.array_set('menu_item_parent', var__possible_parent_id.dup())
								} else {
									var_menu_item_data.array_set('menu_item_parent', 0)
								}
								// unsupported statement: Stmt_Nop
							} else {
								var_menu_item_data.array_set('menu_item_parent', 0)
							}
							var_parent_data.array_set('menu_order', rt.add(var_parent_data.array_get('menu_order'), rt.new_int(1)))
							var_menu_item_data.array_set('menu_order', rt.sub(var_menu_item_data.array_get('menu_order'), rt.new_int(1)))
							rt.call_function('update_post_meta', [var_menu_item_data.array_get('ID'), rt.new_string('_menu_item_menu_item_parent'), // unsupported expression: Expr_Cast_Int])
							rt.call_function('wp_update_post', [var_menu_item_data.dup()])
							rt.call_function('wp_update_post', [var_parent_data.dup()])
						}
						// unsupported statement: Stmt_Nop
					} else if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!rt.is_true(var_menu_item_data.array_get('menu_order')) || !rt.is_true(var_menu_item_data.array_get('menu_item_parent')) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [// unsupported expression: Expr_Cast_Int, rt.func_array_keys(var_dbids_to_orders.dup()), rt.new_bool(true)]))))))) || !rt.is_true(var_orders_to_dbids.array_get(rt.sub(var_dbids_to_orders.array_get(var_menu_item_id), rt.new_int(1)))))) || rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
						var_menu_item_data.array_set('menu_item_parent', // unsupported expression: Expr_Cast_Int)
						var_menu_item_data = rt.call_function('_wp_reset_invalid_menu_item_parent', [var_menu_item_data.dup()])
						rt.call_function('update_post_meta', [var_menu_item_data.array_get('ID'), rt.new_string('_menu_item_menu_item_parent'), // unsupported expression: Expr_Cast_Int])
						rt.call_function('wp_update_post', [var_menu_item_data.dup()])
					}
				}
			}
		}
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('delete-menu-item'))) {
		var_menu_item_id = // unsupported expression: Expr_Cast_Int
		rt.call_function('check_admin_referer', ['delete-menu_item_' + (var_menu_item_id).str()])
		if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('is_nav_menu_item', [var_menu_item_id.dup()])) && rt.is_true(rt.call_function('wp_delete_post', [var_menu_item_id.dup(), rt.new_bool(true)])))) {
			var_messages << rt.call_function('wp_get_admin_notice', [rt.call_function('__', [rt.new_string('The menu item has been successfully deleted.')]), rt.create_array([rt.ArrayItem{ key: 'id', val: 'message' }, rt.ArrayItem{ key: 'additional_classes', val: rt.create_array([rt.ArrayItem{ key: none, val: 'updated' }]) }, rt.ArrayItem{ key: 'dismissible', val: true }])])
		}
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('delete'))) {
		rt.call_function('check_admin_referer', ['delete-nav_menu-' + (var_nav_menu_selected_id).str()])
		if rt.is_true(rt.call_function('is_nav_menu', [var_nav_menu_selected_id.dup()])) {
			mut var_deletion := rt.call_function('wp_delete_nav_menu', [var_nav_menu_selected_id.dup()])
		} else {
			var_nav_menu_selected_id = rt.new_int(rt.new_int(0))
			rt.get_superglobal('_REQUEST').array_unset(rt.new_string('menu'))
		}
		if !(!(var_deletion).is_null()) {
			break
		}
		if rt.is_true(rt.call_function('is_wp_error', [var_deletion.dup()])) {
			var_messages << rt.call_function('wp_get_admin_notice', [rt.call_method(var_deletion, 'get_error_message', []rt.PhpVal{}), rt.create_array([rt.ArrayItem{ key: 'id', val: 'message' }, rt.ArrayItem{ key: 'additional_classes', val: rt.create_array([rt.ArrayItem{ key: none, val: 'error' }]) }, rt.ArrayItem{ key: 'dismissible', val: true }])])
		} else {
			var_messages << rt.call_function('wp_get_admin_notice', [rt.call_function('__', [rt.new_string('The menu has been successfully deleted.')]), rt.create_array([rt.ArrayItem{ key: 'id', val: 'message' }, rt.ArrayItem{ key: 'additional_classes', val: rt.create_array([rt.ArrayItem{ key: none, val: 'updated' }]) }, rt.ArrayItem{ key: 'dismissible', val: true }])])
		}
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('delete_menus'))) {
		rt.call_function('check_admin_referer', [rt.new_string('nav_menus_bulk_actions')])
		{
			mut iter_1 := rt.get_superglobal('_REQUEST').array_get('delete_menus').iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_menu_id_to_delete := item_1.val
				if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_nav_menu', [var_menu_id_to_delete.dup()]))))) {
					continue
				}
				var_deletion = rt.call_function('wp_delete_nav_menu', [.dup()])
				if rt.is_true(rt.call_function('is_wp_error', [.dup()])) {
					
				}
			}
		}
		if !() {
		}
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('update'))) {
		
	} else if rt.is_true(rt.equal(switch_val_1, )) {
	}
}
