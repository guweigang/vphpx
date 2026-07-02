import rt

fn wp_nav_menu_max_depth(var_classes rt.PhpVal) string {
	mut var__wp_nav_menu_max_depth := i64(0)
	return '${var_classes.to_string()} menu-max-depth-${var__wp_nav_menu_max_depth.str()}'
}

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_current_user := rt.new_null()
	rt.include_file(@DIR + '/admin.php', '4')
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/nav-menu.php', '4')
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_theme_supports', [rt.new_string('menus')])))))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_theme_supports', [rt.new_string('widgets')]))))) {
		rt.call_function('wp_die', [
			rt.call_function('__', [
				rt.new_string('Your theme does not support navigation menus or widgets.'),
			]),
		])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('edit_theme_options'),
	])))))
	{
		rt.call_function('wp_die', [
			rt.new_string('<h1>' +
				(rt.call_function('__', [rt.new_string('You need a higher level of permission.')])).str() +
				'</h1>' + '<p>' +
				(rt.call_function('__', [rt.new_string('Sorry, you are not allowed to edit theme options on this site.')])).str() +
				'</p>'),
			rt.new_int(403),
		])
	}
	mut var_title := rt.call_function('__', [rt.new_string('Menus')])
	rt.call_function('wp_enqueue_script', [rt.new_string('nav-menu')])
	if rt.is_true(rt.call_function('wp_is_mobile', []rt.PhpVal{})) {
		rt.call_function('wp_enqueue_script', [rt.new_string('jquery-touch-punch')])
	}
	mut var_messages := []rt.PhpVal{}
	mut var_nav_menu_selected_title := rt.new_string('')
	mut var_nav_menu_selected_id := rt.new_int(if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('menu')) {
		rt.new_int((rt.get_superglobal('_REQUEST').array_get(rt.new_string('menu'))).to_i64())
	} else {
		0
	})
	mut var_locations := rt.call_function('get_registered_nav_menus', []rt.PhpVal{})
	mut var_menu_locations := rt.call_function('get_nav_menu_locations', []rt.PhpVal{})
	mut var_num_locations := rt.func_array_keys(var_locations.clone()).array_count()
	mut var_action := if !(rt.get_superglobal('_REQUEST').array_get(rt.new_string('action'))).is_null() {
		rt.get_superglobal('_REQUEST').array_get(rt.new_string('action'))
	} else {
		rt.new_string('edit')
	}
	rt.call_function('_wp_expand_nav_menu_post_data', []rt.PhpVal{})
	mut switch_val_1 := var_action
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('add-menu-item'))) {
		rt.call_function('check_admin_referer', [rt.new_string('add-menu_item'),
			rt.new_string('menu-settings-column-nonce')])
		if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('nav-menu-locations')) {
			rt.call_function('set_theme_mod', [rt.new_string('nav_menu_locations'),
				rt.call_function('array_map', [rt.new_string('absint'),
					rt.get_superglobal('_REQUEST').array_get(rt.new_string('menu-locations'))])])
		} else if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('menu-item')) {
			rt.call_function('wp_save_nav_menu_items', [var_nav_menu_selected_id.clone(),
				rt.get_superglobal('_REQUEST').array_get(rt.new_string('menu-item'))])
		}
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('move-down-menu-item'))) {
		rt.call_function('check_admin_referer', [rt.new_string('move-menu_item')])
		mut var_menu_item_id := rt.new_int(if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('menu-item')) {
			rt.new_int((rt.get_superglobal('_REQUEST').array_get(rt.new_string('menu-item'))).to_i64())
		} else {
			0
		})
		if rt.is_true(rt.call_function('is_nav_menu_item', [var_menu_item_id.clone()])) {
			mut var_menus := if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('menu')) { rt.create_array([
					rt.ArrayItem{
						key: none
						val: rt.new_int((rt.get_superglobal('_REQUEST').array_get(rt.new_string('menu'))).to_i64())
					},
				]) } else { rt.call_function('wp_get_object_terms', [
					var_menu_item_id.clone(), rt.new_string('nav_menu'),
					rt.create_array([rt.ArrayItem{ key: 'fields', val: 'ids' }])]) }
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_menus.clone()])))))
				&& !(!rt.is_true(var_menus.array_get(rt.new_int(0)))) {
				mut var_menu_id := rt.new_int((var_menus.array_get(rt.new_int(0))).to_i64())
				mut var_ordered_menu_items := rt.call_function('wp_get_nav_menu_items', [
					var_menu_id.clone(),
				])
				mut var_menu_item_data := rt.cast_array(rt.call_function('wp_setup_nav_menu_item', [
					rt.call_function('get_post', [var_menu_item_id.clone()]),
				]))
				mut var_dbids_to_orders := []rt.PhpVal{}
				mut var_orders_to_dbids := []rt.PhpVal{}
				mut iter_1 := rt.cast_array(var_ordered_menu_items).iterator()
				for {
					item_1 := iter_1.next() or { break }
					mut var_ordered_menu_item_object := item_1.val
					if !(rt.get_property(var_ordered_menu_item_object, 'ID')).is_null() {
						if !(rt.get_property(var_ordered_menu_item_object, 'menu_order')).is_null() {
							var_dbids_to_orders.array_set(rt.get_property(var_ordered_menu_item_object,
								'ID'), rt.get_property(var_ordered_menu_item_object, 'menu_order'))
							var_orders_to_dbids.array_set(rt.get_property(var_ordered_menu_item_object,
								'menu_order'), rt.get_property(var_ordered_menu_item_object, 'ID'))
						}
					}
				}
				if var_orders_to_dbids.array_isset(rt.add(var_dbids_to_orders.array_get(var_menu_item_id),
					rt.new_int(1)))
				{
					mut var_next_item_id := var_orders_to_dbids.array_get(rt.add(var_dbids_to_orders.array_get(var_menu_item_id),
						rt.new_int(1)))
					mut var_next_item_data := rt.cast_array(rt.call_function('wp_setup_nav_menu_item', [
						rt.call_function('get_post', [var_next_item_id.clone()]),
					]))
					if !(!rt.is_true(var_menu_item_data.array_get(rt.new_string('menu_item_parent'))))
						&& !rt.is_true(var_next_item_data.array_get(rt.new_string('menu_item_parent')))
						|| rt.is_true(rt.new_bool(rt.new_int((var_next_item_data.array_get(rt.new_string('menu_item_parent'))).to_i64()) != rt.new_int((var_menu_item_data.array_get(rt.new_string('menu_item_parent'))).to_i64()))) {
						if rt.is_true(rt.call_function('in_array', [
							rt.new_int((var_menu_item_data.array_get(rt.new_string('menu_item_parent'))).to_i64()),
							var_orders_to_dbids.clone(),
							rt.new_bool(true),
						]))
						{
							mut var_parent_db_id :=
								rt.new_int((var_menu_item_data.array_get(rt.new_string('menu_item_parent'))).to_i64())
						} else {
							var_parent_db_id = rt.new_int(0)
						}
						mut var_parent_object := rt.call_function('wp_setup_nav_menu_item', [
							rt.call_function('get_post', [var_parent_db_id.clone()]),
						])
						if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [
							var_parent_object.clone(),
						])))))
						{
							mut var_parent_data := rt.cast_array(var_parent_object)
							var_menu_item_data.array_set('menu_item_parent',
								var_parent_data.array_get(rt.new_string('menu_item_parent')))
							var_menu_item_data = rt.call_function('_wp_reset_invalid_menu_item_parent', [
								var_menu_item_data.clone(),
							])
							rt.call_function('update_post_meta', [
								var_menu_item_data.array_get(rt.new_string('ID')),
								rt.new_string('_menu_item_menu_item_parent'),
								rt.new_int((var_menu_item_data.array_get(rt.new_string('menu_item_parent'))).to_i64()),
							])
						}
					} else {
						var_next_item_data.array_set('menu_order', rt.sub(var_next_item_data.array_get(rt.new_string('menu_order')),
							rt.new_int(1)))
						var_menu_item_data.array_set('menu_order', rt.add(var_menu_item_data.array_get(rt.new_string('menu_order')),
							rt.new_int(1)))
						var_menu_item_data.array_set('menu_item_parent',
							var_next_item_data.array_get(rt.new_string('ID')))
						var_menu_item_data = rt.call_function('_wp_reset_invalid_menu_item_parent', [
							var_menu_item_data.clone(),
						])
						rt.call_function('update_post_meta', [
							var_menu_item_data.array_get(rt.new_string('ID')),
							rt.new_string('_menu_item_menu_item_parent'),
							rt.new_int((var_menu_item_data.array_get(rt.new_string('menu_item_parent'))).to_i64()),
						])
						rt.call_function('wp_update_post', [var_menu_item_data.clone()])
						rt.call_function('wp_update_post', [var_next_item_data.clone()])
					}
				} else if
					!(!rt.is_true(var_menu_item_data.array_get(rt.new_string('menu_item_parent'))))
					&& rt.is_true(rt.call_function('in_array', [rt.new_int((var_menu_item_data.array_get(rt.new_string('menu_item_parent'))).to_i64()), var_orders_to_dbids.clone(), rt.new_bool(true)])) {
					var_menu_item_data.array_set('menu_item_parent', rt.new_int((rt.call_function('get_post_meta', [
						var_menu_item_data.array_get(rt.new_string('menu_item_parent')),
						rt.new_string('_menu_item_menu_item_parent'),
						rt.new_bool(true),
					])).to_i64()))
					var_menu_item_data = rt.call_function('_wp_reset_invalid_menu_item_parent', [
						var_menu_item_data.clone(),
					])
					rt.call_function('update_post_meta', [
						var_menu_item_data.array_get(rt.new_string('ID')),
						rt.new_string('_menu_item_menu_item_parent'),
						rt.new_int((var_menu_item_data.array_get(rt.new_string('menu_item_parent'))).to_i64()),
					])
				}
			}
		}
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('move-up-menu-item'))) {
		rt.call_function('check_admin_referer', [rt.new_string('move-menu_item')])
		var_menu_item_id = rt.new_int(if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('menu-item')) {
			rt.new_int((rt.get_superglobal('_REQUEST').array_get(rt.new_string('menu-item'))).to_i64())
		} else {
			0
		})
		if rt.is_true(rt.call_function('is_nav_menu_item', [var_menu_item_id.clone()])) {
			if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('menu')) {
				var_menus = rt.create_array([
					rt.ArrayItem{
						key: none
						val: rt.new_int((rt.get_superglobal('_REQUEST').array_get(rt.new_string('menu'))).to_i64())
					},
				])
			} else {
				var_menus = rt.call_function('wp_get_object_terms', [
					var_menu_item_id.clone(), rt.new_string('nav_menu'),
					rt.create_array([rt.ArrayItem{ key: 'fields', val: 'ids' }])])
			}
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_menus.clone()])))))
				&& !(!rt.is_true(var_menus.array_get(rt.new_int(0)))) {
				var_menu_id = rt.new_int((var_menus.array_get(rt.new_int(0))).to_i64())
				var_ordered_menu_items = rt.call_function('wp_get_nav_menu_items', [
					var_menu_id.clone(),
				])
				var_menu_item_data = rt.cast_array(rt.call_function('wp_setup_nav_menu_item', [
					rt.call_function('get_post', [var_menu_item_id.clone()]),
				]))
				var_dbids_to_orders = []rt.PhpVal{}
				var_orders_to_dbids = []rt.PhpVal{}
				mut iter_2 := rt.cast_array(var_ordered_menu_items).iterator()
				for {
					item_2 := iter_2.next() or { break }
					mut var_ordered_menu_item_object := item_2.val
					if !(rt.get_property(var_ordered_menu_item_object, 'ID')).is_null() {
						if !(rt.get_property(var_ordered_menu_item_object, 'menu_order')).is_null() {
							var_dbids_to_orders.array_set(rt.get_property(var_ordered_menu_item_object,
								'ID'), rt.get_property(var_ordered_menu_item_object, 'menu_order'))
							var_orders_to_dbids.array_set(rt.get_property(var_ordered_menu_item_object,
								'menu_order'), rt.get_property(var_ordered_menu_item_object, 'ID'))
						}
					}
				}
				if !(!rt.is_true(var_dbids_to_orders.array_get(var_menu_item_id)))
					&& !(!rt.is_true(var_orders_to_dbids.array_get(rt.sub(var_dbids_to_orders.array_get(var_menu_item_id), rt.new_int(1))))) {
					if !(!rt.is_true(var_menu_item_data.array_get(rt.new_string('menu_item_parent'))))
						&& rt.is_true(rt.call_function('in_array', [rt.new_int((var_menu_item_data.array_get(rt.new_string('menu_item_parent'))).to_i64()), rt.func_array_keys(var_dbids_to_orders.clone()), rt.new_bool(true)]))
						&& var_orders_to_dbids.array_isset(rt.sub(var_dbids_to_orders.array_get(var_menu_item_id), rt.new_int(1)))
						&& rt.is_true(rt.identical(rt.new_int((var_menu_item_data.array_get(rt.new_string('menu_item_parent'))).to_i64()), var_orders_to_dbids.array_get(rt.sub(var_dbids_to_orders.array_get(var_menu_item_id), rt.new_int(1))))) {
						if rt.is_true(rt.call_function('in_array', [
							rt.new_int((var_menu_item_data.array_get(rt.new_string('menu_item_parent'))).to_i64()),
							var_orders_to_dbids.clone(),
							rt.new_bool(true),
						]))
						{
							var_parent_db_id =
								rt.new_int((var_menu_item_data.array_get(rt.new_string('menu_item_parent'))).to_i64())
						} else {
							var_parent_db_id = rt.new_int(0)
						}
						var_parent_object = rt.call_function('wp_setup_nav_menu_item', [
							rt.call_function('get_post', [var_parent_db_id.clone()]),
						])
						if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [
							var_parent_object.clone(),
						])))))
						{
							var_parent_data = rt.cast_array(var_parent_object)
							if !(!rt.is_true(var_dbids_to_orders.array_get(var_parent_db_id)))
								&& !(!rt.is_true(var_orders_to_dbids.array_get(rt.sub(var_dbids_to_orders.array_get(var_parent_db_id), rt.new_int(1)))))
								&& !(!rt.is_true(var_parent_data.array_get(rt.new_string('menu_item_parent')))) {
								var_menu_item_data.array_set('menu_item_parent',
									var_parent_data.array_get(rt.new_string('menu_item_parent')))
							} else if
								!(!rt.is_true(var_dbids_to_orders.array_get(var_parent_db_id)))
								&& !(!rt.is_true(var_orders_to_dbids.array_get(rt.sub(var_dbids_to_orders.array_get(var_parent_db_id), rt.new_int(1))))) {
								mut var__possible_parent_id := rt.new_int((rt.call_function('get_post_meta', [
									var_orders_to_dbids.array_get(rt.sub(var_dbids_to_orders.array_get(var_parent_db_id),
										rt.new_int(1))),
									rt.new_string('_menu_item_menu_item_parent'),
									rt.new_bool(true),
								])).to_i64())
								if rt.is_true(rt.call_function('in_array', [
									var__possible_parent_id.clone(),
									rt.func_array_keys(var_dbids_to_orders.clone()),
									rt.new_bool(true)]))
								{
									var_menu_item_data.array_set('menu_item_parent',
										var__possible_parent_id.clone())
								} else {
									var_menu_item_data.array_set('menu_item_parent', 0)
								}
							} else {
								var_menu_item_data.array_set('menu_item_parent', 0)
							}
							var_parent_data.array_set('menu_order', rt.add(var_parent_data.array_get(rt.new_string('menu_order')),
								rt.new_int(1)))
							var_menu_item_data.array_set('menu_order', rt.sub(var_menu_item_data.array_get(rt.new_string('menu_order')),
								rt.new_int(1)))
							rt.call_function('update_post_meta', [
								var_menu_item_data.array_get(rt.new_string('ID')),
								rt.new_string('_menu_item_menu_item_parent'),
								rt.new_int((var_menu_item_data.array_get(rt.new_string('menu_item_parent'))).to_i64()),
							])
							rt.call_function('wp_update_post', [
								var_menu_item_data.clone()])
							rt.call_function('wp_update_post', [
								var_parent_data.clone()])
						}
					} else if
						!rt.is_true(var_menu_item_data.array_get(rt.new_string('menu_order')))
						|| !rt.is_true(var_menu_item_data.array_get(rt.new_string('menu_item_parent')))
						|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [rt.new_int((var_menu_item_data.array_get(rt.new_string('menu_item_parent'))).to_i64()), rt.func_array_keys(var_dbids_to_orders.clone()), rt.new_bool(true)])))))
						|| !rt.is_true(var_orders_to_dbids.array_get(rt.sub(var_dbids_to_orders.array_get(var_menu_item_id), rt.new_int(1))))
						|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_orders_to_dbids.array_get(rt.sub(var_dbids_to_orders.array_get(var_menu_item_id), rt.new_int(1))), rt.new_int((var_menu_item_data.array_get(rt.new_string('menu_item_parent'))).to_i64()))))) {
						var_menu_item_data.array_set('menu_item_parent', rt.new_int((var_orders_to_dbids.array_get(rt.sub(var_dbids_to_orders.array_get(var_menu_item_id),
							rt.new_int(1)))).to_i64()))
						var_menu_item_data = rt.call_function('_wp_reset_invalid_menu_item_parent', [
							var_menu_item_data.clone(),
						])
						rt.call_function('update_post_meta', [
							var_menu_item_data.array_get(rt.new_string('ID')),
							rt.new_string('_menu_item_menu_item_parent'),
							rt.new_int((var_menu_item_data.array_get(rt.new_string('menu_item_parent'))).to_i64()),
						])
						rt.call_function('wp_update_post', [var_menu_item_data.clone()])
					}
				}
			}
		}
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('delete-menu-item'))) {
		var_menu_item_id =
			rt.new_int((rt.get_superglobal('_REQUEST').array_get(rt.new_string('menu-item'))).to_i64())
		rt.call_function('check_admin_referer', [
			rt.new_string('delete-menu_item_' + var_menu_item_id.str()),
		])
		if rt.is_true(rt.call_function('is_nav_menu_item', [var_menu_item_id.clone()]))
			&& rt.is_true(rt.call_function('wp_delete_post', [var_menu_item_id.clone(), rt.new_bool(true)])) {
			var_messages << rt.call_function('wp_get_admin_notice', [
				rt.call_function('__', [
					rt.new_string('The menu item has been successfully deleted.'),
				]),
				rt.create_array([
					rt.ArrayItem{ key: 'id', val: 'message' },
					rt.ArrayItem{ key: 'additional_classes', val: rt.create_array([
						rt.ArrayItem{ key: none, val: 'updated' },
					]) },
					rt.ArrayItem{ key: 'dismissible', val: true },
				]),
			])
		}
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('delete'))) {
		rt.call_function('check_admin_referer', [
			rt.new_string('delete-nav_menu-' + var_nav_menu_selected_id.str()),
		])
		if rt.is_true(rt.call_function('is_nav_menu', [var_nav_menu_selected_id.clone()])) {
			mut var_deletion := rt.call_function('wp_delete_nav_menu', [
				var_nav_menu_selected_id.clone()])
		} else {
			var_nav_menu_selected_id = rt.new_int(0)
			rt.get_superglobal('_REQUEST').array_unset(rt.new_string('menu'))
		}
		if !(!var_deletion.is_null()) {
		}
		if rt.is_true(rt.call_function('is_wp_error', [var_deletion.clone()])) {
			var_messages << rt.call_function('wp_get_admin_notice', [
				rt.call_method(var_deletion, 'get_error_message', []rt.PhpVal{}),
				rt.create_array([rt.ArrayItem{ key: 'id', val: 'message' },
					rt.ArrayItem{ key: 'additional_classes', val: rt.create_array([
						rt.ArrayItem{ key: none, val: 'error' },
					]) }, rt.ArrayItem{ key: 'dismissible', val: true }]),
			])
		} else {
			var_messages << rt.call_function('wp_get_admin_notice', [
				rt.call_function('__', [
					rt.new_string('The menu has been successfully deleted.'),
				]),
				rt.create_array([
					rt.ArrayItem{ key: 'id', val: 'message' },
					rt.ArrayItem{ key: 'additional_classes', val: rt.create_array([
						rt.ArrayItem{ key: none, val: 'updated' },
					]) },
					rt.ArrayItem{ key: 'dismissible', val: true },
				]),
			])
		}
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('delete_menus'))) {
		rt.call_function('check_admin_referer', [rt.new_string('nav_menus_bulk_actions')])
		mut iter_3 :=
			rt.get_superglobal('_REQUEST').array_get(rt.new_string('delete_menus')).iterator()
		for {
			item_3 := iter_3.next() or { break }
			mut var_menu_id_to_delete := item_3.val
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_nav_menu', [
				var_menu_id_to_delete.clone(),
			])))))
			{
				continue
			}
			var_deletion = rt.call_function('wp_delete_nav_menu', [
				var_menu_id_to_delete.clone()])
			if rt.is_true(rt.call_function('is_wp_error', [var_deletion.clone()])) {
				var_messages << rt.call_function('wp_get_admin_notice', [
					rt.call_method(var_deletion, 'get_error_message', []rt.PhpVal{}),
					rt.create_array([rt.ArrayItem{ key: 'id', val: 'message' },
						rt.ArrayItem{ key: 'additional_classes', val: rt.create_array([
							rt.ArrayItem{ key: none, val: 'error' },
						]) }, rt.ArrayItem{ key: 'dismissible', val: true }]),
				])
				mut var_deletion_error := true
			}
		}
		if !var_deletion_error {
			var_messages << rt.call_function('wp_get_admin_notice', [
				rt.call_function('__', [
					rt.new_string('Selected menus have been successfully deleted.'),
				]),
				rt.create_array([
					rt.ArrayItem{ key: 'id', val: 'message' },
					rt.ArrayItem{ key: 'additional_classes', val: rt.create_array([
						rt.ArrayItem{ key: none, val: 'updated' },
					]) },
					rt.ArrayItem{ key: 'dismissible', val: true },
				]),
			])
		}
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('update'))) {
		rt.call_function('check_admin_referer', [rt.new_string('update-nav_menu'),
			rt.new_string('update-nav-menu-nonce')])
		mut var_new_menu_locations := []rt.PhpVal{}
		if rt.get_superglobal('_POST').array_isset(rt.new_string('menu-locations')) {
			var_new_menu_locations = rt.call_function('array_map', [
				rt.new_string('absint'),
				rt.get_superglobal('_POST').array_get(rt.new_string('menu-locations')),
			])
			var_menu_locations = rt.call_function('array_merge', [
				var_menu_locations.clone(), var_new_menu_locations.clone()])
		}
		if rt.is_true(rt.identical(rt.new_int(0), var_nav_menu_selected_id)) {
			mut var_new_menu_title := rt.call_function('esc_html', [
				rt.get_superglobal('_POST').array_get(rt.new_string('menu-name')),
			]).to_string().trim_space()
			if var_new_menu_title.len > 0 && var_new_menu_title != '0' {
				mut var__nav_menu_selected_id := rt.call_function('wp_update_nav_menu_object', [
					rt.new_int(0),
					rt.create_array([
						rt.ArrayItem{ key: 'menu-name', val: var_new_menu_title },
					]),
				])
				if rt.is_true(rt.call_function('is_wp_error', [
					var__nav_menu_selected_id.clone()]))
				{
					var_messages << rt.call_function('wp_get_admin_notice', [
						rt.call_method(var__nav_menu_selected_id, 'get_error_message',
							[]rt.PhpVal{}),
						rt.create_array([rt.ArrayItem{ key: 'id', val: 'message' },
							rt.ArrayItem{ key: 'additional_classes', val: rt.create_array([
								rt.ArrayItem{ key: none, val: 'error' },
							]) }, rt.ArrayItem{ key: 'dismissible', val: true }]),
					])
				} else {
					mut var__menu_object := rt.call_function('wp_get_nav_menu_object', [
						var__nav_menu_selected_id.clone(),
					])
					var_nav_menu_selected_id = var__nav_menu_selected_id.clone()
					var_nav_menu_selected_title = rt.get_property(var__menu_object, 'name')
					if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('menu-item')) {
						rt.call_function('wp_save_nav_menu_items', [
							var_nav_menu_selected_id.clone(),
							rt.call_function('absint', [
								rt.get_superglobal('_REQUEST').array_get(rt.new_string('menu-item')),
							])])
					}
					if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('zero-menu-state'))
						|| !(!rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('auto-add-pages')))) {
						rt.call_function('wp_nav_menu_update_menu_items', [
							var_nav_menu_selected_id.clone(),
							var_nav_menu_selected_title.clone()])
					}
					if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('zero-menu-state')) {
						var_locations = rt.call_function('get_nav_menu_locations', []rt.PhpVal{})
						mut iter_4 := var_locations.iterator()
						for {
							item_4 := iter_4.next() or { break }
							mut var_menu_id_shadow := item_4.val
							mut var_location := item_4.key
							var_locations.array_set(var_location, var_nav_menu_selected_id.clone())
						}
						rt.call_function('set_theme_mod', [
							rt.new_string('nav_menu_locations'),
							var_locations.clone(),
						])
					} else if var_new_menu_locations.clone().array_count() > 0 {
						var_locations = rt.call_function('get_nav_menu_locations', []rt.PhpVal{})
						mut iter_5 := rt.func_array_keys(var_new_menu_locations.clone()).iterator()
						for {
							item_5 := iter_5.next() or { break }
							mut var_location := item_5.val
							var_locations.array_set(var_location, var_nav_menu_selected_id.clone())
						}
						rt.call_function('set_theme_mod', [
							rt.new_string('nav_menu_locations'),
							var_locations.clone(),
						])
					}
					if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('use-location')) {
						var_locations = rt.call_function('get_registered_nav_menus', []rt.PhpVal{})
						var_menu_locations = rt.call_function('get_nav_menu_locations',
							[]rt.PhpVal{})
						if var_locations.array_isset(rt.get_superglobal('_REQUEST').array_get(rt.new_string('use-location'))) {
							var_menu_locations.array_set(rt.get_superglobal('_REQUEST').array_get(rt.new_string('use-location')),
								var_nav_menu_selected_id.clone())
						}
						rt.call_function('set_theme_mod', [
							rt.new_string('nav_menu_locations'),
							var_menu_locations.clone(),
						])
					}
					rt.call_function('wp_redirect', [
						rt.call_function('admin_url', [
							rt.new_string('nav-menus.php?menu=' + var__nav_menu_selected_id.str()),
						]),
					])
					exit(0)
				}
			} else {
				var_messages << rt.call_function('wp_get_admin_notice', [
					rt.call_function('__', [
						rt.new_string('Please enter a valid menu name.'),
					]),
					rt.create_array([
						rt.ArrayItem{ key: 'id', val: 'message' },
						rt.ArrayItem{ key: 'additional_classes', val: rt.create_array([
							rt.ArrayItem{ key: none, val: 'error' },
						]) },
						rt.ArrayItem{ key: 'dismissible', val: true },
					]),
				])
			}
		} else {
			mut iter_6 := var_locations.iterator()
			for {
				item_6 := iter_6.next() or { break }
				mut var_description := item_6.val
				mut var_location := item_6.key
				if !rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('menu-locations')))
					|| !rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('menu-locations')).array_get(var_location))
					&& var_menu_locations.array_isset(var_location)
					&& rt.is_true(rt.identical(var_menu_locations.array_get(var_location), var_nav_menu_selected_id)) {
					var_menu_locations.array_unset(var_location)
				}
			}
			rt.call_function('set_theme_mod', [rt.new_string('nav_menu_locations'),
				var_menu_locations.clone()])
			var__menu_object = rt.call_function('wp_get_nav_menu_object', [
				var_nav_menu_selected_id.clone()])
			mut var_menu_title := rt.new_string(rt.call_function('esc_html', [
				rt.get_superglobal('_POST').array_get(rt.new_string('menu-name')),
			]).to_string().trim_space())
			if rt.is_true(rt.new_bool(!(rt.is_true(var_menu_title)))) {
				var_messages << rt.call_function('wp_get_admin_notice', [
					rt.call_function('__', [
						rt.new_string('Please enter a valid menu name.'),
					]),
					rt.create_array([
						rt.ArrayItem{ key: 'id', val: 'message' },
						rt.ArrayItem{ key: 'additional_classes', val: rt.create_array([
							rt.ArrayItem{ key: none, val: 'error' },
						]) },
						rt.ArrayItem{ key: 'dismissible', val: true },
					]),
				])
				var_menu_title = rt.get_property(var__menu_object, 'name')
			}
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [
				var__menu_object.clone(),
			])))))
			{
				var__nav_menu_selected_id = rt.call_function('wp_update_nav_menu_object', [
					var_nav_menu_selected_id.clone(),
					rt.create_array([
						rt.ArrayItem{ key: 'menu-name', val: var_menu_title },
					]),
				])
				if rt.is_true(rt.call_function('is_wp_error', [
					var__nav_menu_selected_id.clone()]))
				{
					var__menu_object = var__nav_menu_selected_id.clone()
					var_messages << rt.call_function('wp_get_admin_notice', [
						rt.call_method(var__nav_menu_selected_id, 'get_error_message',
							[]rt.PhpVal{}),
						rt.create_array([rt.ArrayItem{ key: 'id', val: 'message' },
							rt.ArrayItem{ key: 'additional_classes', val: rt.create_array([
								rt.ArrayItem{ key: none, val: 'error' },
							]) }, rt.ArrayItem{ key: 'dismissible', val: true }]),
					])
				} else {
					var__menu_object = rt.call_function('wp_get_nav_menu_object', [
						var__nav_menu_selected_id.clone(),
					])
					var_nav_menu_selected_title = rt.get_property(var__menu_object, 'name')
				}
			}
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [
				var__menu_object.clone(),
			])))))
			{
				var_messages = rt.call_function('array_merge', [
					rt.create_array_from_list(var_messages),
					rt.call_function('wp_nav_menu_update_menu_items', [
						var__nav_menu_selected_id.clone(), var_nav_menu_selected_title.clone()]),
				])
				if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_nav_menu_selected_id,
					var__nav_menu_selected_id))))
				{
					rt.call_function('wp_redirect', [
						rt.call_function('admin_url', [
							rt.new_string('nav-menus.php?menu=' +
								rt.new_int(var__nav_menu_selected_id.to_i64()).str()),
						]),
					])
					exit(0)
				}
			}
		}
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('locations'))) {
		if !(var_num_locations != 0) {
			rt.call_function('wp_redirect', [
				rt.call_function('admin_url', [rt.new_string('nav-menus.php')]),
			])
			exit(0)
		}
		rt.call_function('add_filter', [rt.new_string('screen_options_show_screen'),
			rt.new_string('__return_false')])
		if rt.get_superglobal('_POST').array_isset(rt.new_string('menu-locations')) {
			rt.call_function('check_admin_referer', [
				rt.new_string('save-menu-locations'),
			])
			var_new_menu_locations = rt.call_function('array_map', [
				rt.new_string('absint'),
				rt.get_superglobal('_POST').array_get(rt.new_string('menu-locations')),
			])
			var_menu_locations = rt.call_function('array_merge', [
				var_menu_locations.clone(), var_new_menu_locations.clone()])
			rt.call_function('set_theme_mod', [rt.new_string('nav_menu_locations'),
				var_menu_locations.clone()])
			var_messages << rt.call_function('wp_get_admin_notice', [
				rt.call_function('__', [rt.new_string('Menu locations updated.')]),
				rt.create_array([rt.ArrayItem{ key: 'id', val: 'message' },
					rt.ArrayItem{ key: 'additional_classes', val: rt.create_array([
						rt.ArrayItem{ key: none, val: 'updated' },
					]) }, rt.ArrayItem{ key: 'dismissible', val: true }]),
			])
		}
	}
	mut var_nav_menus := rt.call_function('wp_get_nav_menus', []rt.PhpVal{})
	mut var_menu_count := var_nav_menus.clone().array_count()
	mut var_add_new_screen := if rt.get_superglobal('_GET').array_isset(rt.new_string('menu'))
		&& 0 == rt.new_int((rt.get_superglobal('_GET').array_get(rt.new_string('menu'))).to_i64()) {
		true
	} else {
		false
	}
	mut var_locations_screen := if rt.get_superglobal('_GET').array_isset(rt.new_string('action'))
		&& rt.is_true(rt.identical(rt.new_string('locations'), rt.get_superglobal('_GET').array_get(rt.new_string('action')))) {
		true
	} else {
		false
	}
	mut var_page_count := rt.call_function('wp_count_posts', [
		rt.new_string('page')])
	if 1 == rt.call_function('get_registered_nav_menus', []rt.PhpVal{}).array_count()
		&& !var_add_new_screen && !rt.is_true(var_nav_menus)
		&& !(!rt.is_true(rt.get_property(var_page_count, 'publish'))) {
		mut var_one_theme_location_no_menus := true
	} else {
		var_one_theme_location_no_menus = false
	}
	mut var_nav_menus_l10n := {
		'oneThemeLocationNoMenus': rt.new_bool(var_one_theme_location_no_menus)
		'moveUp':                  rt.call_function('__', [rt.new_string('Move up one')])
		'moveDown':                rt.call_function('__', [
			rt.new_string('Move down one'),
		])
		'moveToTop':               rt.call_function('__', [
			rt.new_string('Move to the top'),
		])
		'moveUnder':               rt.call_function('__', [
			rt.new_string('Move under %s'),
		])
		'moveOutFrom':             rt.call_function('__', [
			rt.new_string('Move out from under %s'),
		])
		'under':                   rt.call_function('__', [rt.new_string('Under %s')])
		'outFrom':                 rt.call_function('__', [
			rt.new_string('Out from under %s'),
		])
		'menuFocus':               rt.call_function('__', [
			rt.new_string('Edit %1$s (%2$s, %3$d of %4$d)'),
		])
		'subMenuFocus':            rt.call_function('__', [
			rt.new_string('Edit %1$s (%2$s, sub-item %3$d of %4$d under %5$s)'),
		])
		'subMenuMoreDepthFocus':   rt.call_function('__', [
			rt.new_string('Edit %1$s (%2$s, sub-item %3$d of %4$d under %5$s, level %6$d)'),
		])
		'menuItemDeletion':        rt.call_function('__', [rt.new_string('item %s')])
		'itemsDeleted':            rt.call_function('__', [
			rt.new_string('Deleted menu item: %s.'),
		])
		'itemAdded':               rt.call_function('__', [
			rt.new_string('Menu item added'),
		])
		'itemRemoved':             rt.call_function('__', [
			rt.new_string('Menu item removed'),
		])
		'movedUp':                 rt.call_function('__', [
			rt.new_string('Menu item moved up'),
		])
		'movedDown':               rt.call_function('__', [
			rt.new_string('Menu item moved down'),
		])
		'movedTop':                rt.call_function('__', [
			rt.new_string('Menu item moved to the top'),
		])
		'movedLeft':               rt.call_function('__', [
			rt.new_string('Menu item moved out of submenu'),
		])
		'movedRight':              rt.call_function('__', [
			rt.new_string('Menu item is now a sub-item'),
		])
		'parentUpdated':           rt.call_function('__', [
			rt.new_string('Menu parent updated'),
		])
		'orderUpdated':            rt.call_function('__', [
			rt.new_string('Menu order updated'),
		])
	}
	rt.call_function('wp_localize_script', [rt.new_string('nav-menu'),
		rt.new_string('menus'), rt.create_array_from_native_map(var_nav_menus_l10n)])
	if 0 == var_menu_count && !var_add_new_screen && !var_one_theme_location_no_menus {
		rt.call_function('wp_redirect', [
			rt.call_function('admin_url', [
				rt.new_string('nav-menus.php?action=edit&menu=0'),
			]),
		])
	}
	mut var_recently_edited := rt.call_function('absint', [
		rt.call_function('get_user_option', [rt.new_string('nav_menu_recently_edited')]),
	])
	if !rt.is_true(var_recently_edited)
		&& rt.is_true(rt.call_function('is_nav_menu', [var_nav_menu_selected_id.clone()])) {
		var_recently_edited = var_nav_menu_selected_id.clone()
	}
	if !rt.is_true(var_nav_menu_selected_id)
		&& !(rt.get_superglobal('_GET').array_isset(rt.new_string('menu')))
		&& rt.is_true(rt.call_function('is_nav_menu', [var_recently_edited.clone()])) {
		var_nav_menu_selected_id = var_recently_edited.clone()
	}
	if !var_add_new_screen && var_menu_count > 0
		&& rt.get_superglobal('_GET').array_isset(rt.new_string('action'))
		&& rt.is_true(rt.identical(rt.new_string('delete'), rt.get_superglobal('_GET').array_get(rt.new_string('action')))) {
		var_nav_menu_selected_id = rt.get_property(var_nav_menus.array_get(rt.new_int(0)),
			'term_id')
	}
	if var_one_theme_location_no_menus {
		var_nav_menu_selected_id = rt.new_int(0)
	} else if !rt.is_true(var_nav_menu_selected_id) && !(!rt.is_true(var_nav_menus))
		&& !var_add_new_screen {
		var_nav_menu_selected_id = rt.get_property(var_nav_menus.array_get(rt.new_int(0)),
			'term_id')
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_nav_menu_selected_id, var_recently_edited))))
		&& rt.is_true(rt.call_function('is_nav_menu', [var_nav_menu_selected_id.clone()])) {
		rt.call_function('update_user_meta', [rt.get_property(var_current_user, 'ID'),
			rt.new_string('nav_menu_recently_edited'), var_nav_menu_selected_id.clone()])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_nav_menu_selected_title))))
		&& rt.is_true(rt.call_function('is_nav_menu', [var_nav_menu_selected_id.clone()])) {
		var__menu_object = rt.call_function('wp_get_nav_menu_object', [
			var_nav_menu_selected_id.clone()])
		var_nav_menu_selected_title = if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [
			var__menu_object.clone(),
		])))))
		{ rt.get_property(var__menu_object, 'name') } else { rt.new_string('') }
	}
	mut iter_7 := rt.cast_array(var_nav_menus).iterator()
	for {
		item_7 := iter_7.next() or { break }
		mut var__nav_menu := item_7.val
		mut var_key := item_7.key
		rt.set_property(var_nav_menus.array_get(var_key), 'truncated_name', rt.call_function('wp_html_excerpt', [
			rt.get_property(var__nav_menu, 'name'),
			rt.new_int(40),
			rt.new_string('&hellip;'),
		]))
	}
	if rt.is_true(rt.call_function('current_theme_supports', [
		rt.new_string('menus')]))
	{
		var_locations = rt.call_function('get_registered_nav_menus', []rt.PhpVal{})
		var_menu_locations = rt.call_function('get_nav_menu_locations', []rt.PhpVal{})
	}
	mut var__wp_nav_menu_max_depth := rt.get_superglobal('_wp_nav_menu_max_depth')
	var__wp_nav_menu_max_depth = 0
	if rt.is_true(rt.call_function('is_nav_menu', [var_nav_menu_selected_id.clone()])) {
		mut var_menu_items := rt.call_function('wp_get_nav_menu_items', [
			var_nav_menu_selected_id.clone(),
			rt.create_array([
				rt.ArrayItem{ key: 'post_status', val: 'any' },
			])])
		mut var_edit_markup := rt.call_function('wp_get_nav_menu_to_edit', [
			var_nav_menu_selected_id.clone()])
	}
	rt.call_function('add_filter', [rt.new_string('admin_body_class'),
		rt.new_string('wp_nav_menu_max_depth')])
	rt.call_function('wp_nav_menu_setup', []rt.PhpVal{})
	rt.call_function('wp_initial_nav_menu_meta_boxes', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_theme_supports', [rt.new_string('menus')])))))
		&& !(var_num_locations != 0) {
		mut var_message_no_theme_support := rt.call_function('sprintf', [
			rt.call_function('__', [
				rt.new_string('Your theme does not natively support menus, but you can use them in sidebars by adding a &#8220;Navigation Menu&#8221; widget on the <a href="%s">Widgets</a> screen.'),
			]),
			rt.call_function('admin_url', [
				rt.new_string('widgets.php'),
			]),
		])
		var_messages << rt.call_function('wp_get_admin_notice', [
			var_message_no_theme_support.clone(),
			rt.create_array([
				rt.ArrayItem{ key: 'id', val: 'message' },
				rt.ArrayItem{ key: 'additional_classes', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'updated' },
				]) },
				rt.ArrayItem{ key: 'dismissible', val: true },
			])])
	}
	if !var_locations_screen {
		mut var_overview := rt.new_string('<p>' +
			(rt.call_function('__', [rt.new_string('This screen is used for managing your navigation menus.')])).str() +
			'</p>')
		var_overview = rt.concat(var_overview, rt.new_string('<p>' +
			(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Menus can be displayed in locations defined by your theme, even used in sidebars by adding a &#8220;Navigation Menu&#8221; widget on the <a href="%1$s">Widgets</a> screen. If your theme does not support the navigation menus feature (the default themes, %2$s and %3$s, do), you can learn about adding this support by following the documentation link to the side.')]), rt.call_function('admin_url', [rt.new_string('widgets.php')]), rt.new_string('Twenty Twenty'), rt.new_string('Twenty Twenty-One')])).str() +
			'</p>'))
		var_overview = rt.concat(var_overview, rt.new_string('<p>' +
			(rt.call_function('__', [rt.new_string('From this screen you can:')])).str() + '</p>'))
		var_overview = rt.concat(var_overview, rt.new_string('<ul><li>' +
			(rt.call_function('__', [rt.new_string('Create, edit, and delete menus')])).str() +
			'</li>'))
		var_overview = rt.concat(var_overview, rt.new_string('<li>' +
			(rt.call_function('__', [rt.new_string('Add, organize, and modify individual menu items')])).str() +
			'</li></ul>'))
		rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'add_help_tab', [
			rt.create_array([rt.ArrayItem{ key: 'id', val: 'overview' },
				rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
					rt.new_string('Overview'),
				]) }, rt.ArrayItem{ key: 'content', val: var_overview }]),
		])
		mut var_menu_management := rt.new_string('<p>' +
			(rt.call_function('__', [rt.new_string('The menu management box at the top of the screen is used to control which menu is opened in the editor below.')])).str() +
			'</p>')
		var_menu_management = rt.concat(var_menu_management, rt.new_string('<ul><li>' +
			(rt.call_function('__', [rt.new_string('To edit an existing menu, <strong>choose a menu from the dropdown and click Select</strong>')])).str() +
			'</li>'))
		var_menu_management = rt.concat(var_menu_management, rt.new_string('<li>' +
			(rt.call_function('__', [rt.new_string('If you have not yet created any menus, <strong>click the &#8217;create a new menu&#8217; link</strong> to get started')])).str() +
			'</li></ul>'))
		var_menu_management = rt.concat(var_menu_management, rt.new_string('<p>' +
			(rt.call_function('__', [rt.new_string('You can assign individual menus to the theme&#8217;s menu locations by <strong>selecting the desired settings</strong> at the bottom of the menu editor. To assign menus to all theme menu locations at once, <strong>visit the Manage Locations tab</strong> at the top of the screen.')])).str() +
			'</p>'))
		rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'add_help_tab', [
			rt.create_array([rt.ArrayItem{ key: 'id', val: 'menu-management' },
				rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
					rt.new_string('Menu Management'),
				]) }, rt.ArrayItem{ key: 'content', val: var_menu_management }]),
		])
		mut var_editing_menus := rt.new_string('<p>' +
			(rt.call_function('__', [rt.new_string('Each navigation menu may contain a mix of links to pages, categories, custom URLs or other content types. Menu links are added by selecting items from the expanding boxes in the left-hand column below.')])).str() +
			'</p>')
		var_editing_menus = rt.concat(var_editing_menus, rt.new_string('<p>' +
			(rt.call_function('__', [rt.new_string('<strong>Clicking the arrow to the right of any menu item</strong> in the editor will reveal a standard group of settings. Additional settings such as link target, CSS classes, link relationships, and link descriptions can be enabled and disabled via the Screen Options tab.')])).str() +
			'</p>'))
		var_editing_menus = rt.concat(var_editing_menus, rt.new_string('<ul><li>' +
			(rt.call_function('__', [rt.new_string('Add one or several items at once by <strong>selecting the checkbox next to each item and clicking Add to Menu</strong>')])).str() +
			'</li>'))
		var_editing_menus = rt.concat(var_editing_menus, rt.new_string('<li>' +
			(rt.call_function('__', [rt.new_string('To add a custom link, <strong>expand the Custom Links section, enter a URL and link text, and click Add to Menu</strong>')])).str() +
			'</li>'))
		var_editing_menus = rt.concat(var_editing_menus, rt.new_string('<li>' +
			(rt.call_function('__', [rt.new_string('To reorganize menu items, <strong>drag and drop items with your mouse or use your keyboard</strong>. Drag or move a menu item a little to the right to make it a submenu')])).str() +
			'</li>'))
		var_editing_menus = rt.concat(var_editing_menus, rt.new_string('<li>' +
			(rt.call_function('__', [rt.new_string('Delete a menu item by <strong>expanding it and clicking the Remove link</strong>')])).str() +
			'</li></ul>'))
		rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'add_help_tab', [
			rt.create_array([rt.ArrayItem{ key: 'id', val: 'editing-menus' },
				rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
					rt.new_string('Editing Menus'),
				]) }, rt.ArrayItem{ key: 'content', val: var_editing_menus }]),
		])
	} else {
		mut var_locations_overview := rt.new_string('<p>' +
			(rt.call_function('__', [rt.new_string('This screen is used for globally assigning menus to locations defined by your theme.')])).str() +
			'</p>')
		var_locations_overview = rt.concat(var_locations_overview, rt.new_string('<ul><li>' +
			(rt.call_function('__', [rt.new_string('To assign menus to one or more theme menu locations, <strong>select a menu from each location&#8217;s dropdown</strong>. When you are finished, <strong>click Save Changes</strong>')])).str() +
			'</li>'))
		var_locations_overview = rt.concat(var_locations_overview, rt.new_string('<li>' +
			(rt.call_function('__', [rt.new_string('To edit a menu currently assigned to a theme menu location, <strong>click the adjacent &#8217;Edit&#8217; link</strong>')])).str() +
			'</li>'))
		var_locations_overview = rt.concat(var_locations_overview, rt.new_string('<li>' +
			(rt.call_function('__', [rt.new_string('To add a new menu instead of assigning an existing one, <strong>click the &#8217;Use new menu&#8217; link</strong>. Your new menu will be automatically assigned to that location in the theme.')])).str() +
			'</li></ul>'))
		rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'add_help_tab', [
			rt.create_array([rt.ArrayItem{ key: 'id', val: 'locations-overview' },
				rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
					rt.new_string('Overview'),
				]) }, rt.ArrayItem{ key: 'content', val: var_locations_overview }]),
		])
	}
	rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'set_help_sidebar', [
		rt.new_string('<p><strong>' +
			(rt.call_function('__', [rt.new_string('For more information:')])).str() +
			'</strong></p>' + '<p>' +
			(rt.call_function('__', [rt.new_string('<a href="https://wordpress.org/documentation/article/appearance-menus-screen/">Documentation on Menus</a>')])).str() +
			'</p>' + '<p>' +
			(rt.call_function('__', [rt.new_string('<a href="https://wordpress.org/support/forums/">Support forums</a>')])).str() +
			'</p>'),
	])
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-header.php', '4')
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Menus')])
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.call_function('current_user_can', [rt.new_string('customize')])) {
		mut var_focus := if var_locations_screen { rt.create_array([
				rt.ArrayItem{ key: 'section', val: 'menu_locations' },
			]) } else { rt.create_array([rt.ArrayItem{ key: 'panel', val: 'nav_menus' }]) }
		rt.call_function('printf', [
			rt.new_string(' <a class="page-title-action hide-if-no-customize" href="%1$s">%2$s</a>'),
			rt.call_function('esc_url', [
				rt.call_function('add_query_arg', [
					rt.create_array([
						rt.ArrayItem{ key: none, val: rt.create_array([
							rt.ArrayItem{ key: 'autofocus', val: var_focus },
						]) },
						rt.ArrayItem{ key: 'return', val: rt.call_function('urlencode', [
							rt.call_function('remove_query_arg', [
								rt.call_function('wp_removable_query_args', []rt.PhpVal{}),
								rt.call_function('wp_unslash', [
									rt.get_superglobal('_SERVER').array_get(rt.new_string('REQUEST_URI')),
								]),
							]),
						]) },
					]),
					rt.call_function('admin_url', [
						rt.new_string('customize.php'),
					]),
				]),
			]),
			rt.call_function('__', [
				rt.new_string('Manage with Live Preview'),
			]),
		])
	}
	mut var_nav_tab_active_class := ''
	mut var_nav_aria_current := ''
	if !(rt.get_superglobal('_GET').array_isset(rt.new_string('action')))
		|| (rt.get_superglobal('_GET').array_isset(rt.new_string('action'))
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('locations'), rt.get_superglobal('_GET').array_get(rt.new_string('action'))))))) {
		var_nav_tab_active_class = ' nav-tab-active'
		var_nav_aria_current = ' aria-current="page"'
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('Secondary menu')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [
		rt.call_function('admin_url', [rt.new_string('nav-menus.php')]),
	]))
	// unsupported statement: Stmt_InlineHTML
	print(var_nav_tab_active_class)
	// unsupported statement: Stmt_InlineHTML
	print(var_nav_aria_current)
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Edit Menus')])
	// unsupported statement: Stmt_InlineHTML
	if var_num_locations != 0 && var_menu_count != 0 {
		mut var_active_tab_class := ''
		mut var_aria_current := ''
		if var_locations_screen {
			var_active_tab_class = ' nav-tab-active'
			var_aria_current = ' aria-current="page"'
		}
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_url', [
			rt.call_function('add_query_arg', [
				rt.create_array([rt.ArrayItem{ key: 'action', val: 'locations' }]),
				rt.call_function('admin_url', [rt.new_string('nav-menus.php')]),
			]),
		]))
		// unsupported statement: Stmt_InlineHTML
		print(var_active_tab_class)
		// unsupported statement: Stmt_InlineHTML
		print(var_aria_current)
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Manage Locations')])
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	for var_message in var_messages {
		print(var_message.str() + '\n')
	}
	// unsupported statement: Stmt_InlineHTML
	if var_locations_screen {
		if 1 == var_num_locations {
			print('<p>' +
				(rt.call_function('__', [rt.new_string('Your theme supports one menu. Select which menu you would like to use.')])).str() +
				'</p>')
		} else {
			print('<p>' +
				(rt.call_function('sprintf', [rt.call_function('_n', [rt.new_string('Your theme supports %s menu. Select which menu appears in each location.'), rt.new_string('Your theme supports %s menus. Select which menu appears in each location.'), rt.new_int(var_num_locations).clone()]), rt.call_function('number_format_i18n', [rt.new_int(var_num_locations).clone()])])).str() +
				'</p>')
		}
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_url', [
			rt.call_function('add_query_arg', [
				rt.create_array([rt.ArrayItem{ key: 'action', val: 'locations' }]),
				rt.call_function('admin_url', [rt.new_string('nav-menus.php')]),
			]),
		]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Menu Location')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Assigned Menu')])
		// unsupported statement: Stmt_InlineHTML
		mut iter_8 := var_locations.iterator()
		for {
			item_8 := iter_8.next() or { break }
			mut var__name := item_8.val
			mut var__location := item_8.key
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(var__location)
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(var__name)
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(var__location)
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(var__location)
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('printf', [rt.new_string('&mdash; %s &mdash;'),
				rt.call_function('esc_html__', [rt.new_string('Select a Menu')])])
			// unsupported statement: Stmt_InlineHTML
			mut iter_9 := var_nav_menus.iterator()
			for {
				item_9 := iter_9.next() or { break }
				mut var_menu := item_9.val
				mut var_data_orig := ''
				mut var_selected := var_menu_locations.array_isset(var__location)
					&& rt.is_true(rt.identical(var_menu_locations.array_get(var__location), rt.get_property(var_menu, 'term_id')))
				if var_selected {
					var_data_orig = 'data-orig="true"'
				}
				// unsupported statement: Stmt_InlineHTML
				print(var_data_orig)
				// unsupported statement: Stmt_InlineHTML
				rt.call_function('selected', [rt.new_bool(var_selected).clone()])
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.get_property(var_menu, 'term_id'))
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('wp_html_excerpt', [
					rt.get_property(var_menu, 'name'),
					rt.new_int(40),
					rt.new_string('&hellip;'),
				]))
				// unsupported statement: Stmt_InlineHTML
			}
			// unsupported statement: Stmt_InlineHTML
			if var_menu_locations.array_isset(var__location)
				&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int(0), var_menu_locations.array_get(var__location))))) {
				// unsupported statement: Stmt_InlineHTML
				rt.call_function('printf', [
					rt.new_string('<a href="%1$s">\n\t\t\t\t\t\t\t\t\t\t\t<span aria-hidden="true">%2$s</span>\n\t\t\t\t\t\t\t\t\t\t\t<span class="screen-reader-text">%3$s</span>\n\t\t\t\t\t\t\t\t\t\t</a>'),
					rt.call_function('esc_url', [
						rt.call_function('add_query_arg', [
							rt.create_array([rt.ArrayItem{ key: 'action', val: 'edit' },
								rt.ArrayItem{
									key: 'menu'
									val: var_menu_locations.array_get(var__location)
								}]),
							rt.call_function('admin_url', [rt.new_string('nav-menus.php')]),
						]),
					]),
					rt.call_function('_x', [
						rt.new_string('Edit'),
						rt.new_string('menu'),
					]),
					rt.call_function('__', [
						rt.new_string('Edit selected menu'),
					]),
				])
				// unsupported statement: Stmt_InlineHTML
			}
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('printf', [rt.new_string('<a href="%1$s">%2$s</a>'),
				rt.call_function('esc_url', [
					rt.call_function('add_query_arg', [
						rt.create_array([rt.ArrayItem{ key: 'action', val: 'edit' },
							rt.ArrayItem{ key: 'menu', val: 0 },
							rt.ArrayItem{ key: 'use-location', val: var__location }]),
						rt.call_function('admin_url', [rt.new_string('nav-menus.php')]),
					]),
				]),
				rt.call_function('_x', [
					rt.new_string('Use new menu'),
					rt.new_string('menu'),
				])])
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('submit_button', [
			rt.call_function('__', [rt.new_string('Save Changes')]),
			rt.new_string('primary left'),
			rt.new_string('nav-menu-locations'),
			rt.new_bool(false),
		])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('wp_nonce_field', [rt.new_string('save-menu-locations')])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [var_nav_menu_selected_id.clone()]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('do_action', [rt.new_string('after_menu_locations_table')])
		// unsupported statement: Stmt_InlineHTML
	} else {
		// unsupported statement: Stmt_InlineHTML
		if var_menu_count < 1 {
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('_e', [rt.new_string('Create your first menu below.')])
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('_e', [
				rt.new_string('Fill in the Menu Name and click the Create Menu button to create your first menu.'),
			])
			// unsupported statement: Stmt_InlineHTML
		} else if var_menu_count < 2 {
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('printf', [
				rt.call_function('__', [
					rt.new_string('Edit your menu below, or <a href="%s">create a new menu</a>. Do not forget to save your changes!'),
				]),
				rt.call_function('esc_url', [
					rt.call_function('add_query_arg', [
						rt.create_array([rt.ArrayItem{ key: 'action', val: 'edit' },
							rt.ArrayItem{ key: 'menu', val: 0 }]),
						rt.call_function('admin_url', [rt.new_string('nav-menus.php')]),
					]),
				]),
			])
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('_e', [
				rt.new_string('Click the Save Menu button to save your changes.'),
			])
			// unsupported statement: Stmt_InlineHTML
		} else {
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_url', [
				rt.call_function('admin_url', [rt.new_string('nav-menus.php')]),
			]))
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('_e', [rt.new_string('Select a menu to edit:')])
			// unsupported statement: Stmt_InlineHTML
			if var_add_new_screen {
				// unsupported statement: Stmt_InlineHTML
				rt.call_function('_e', [rt.new_string('&mdash; Select &mdash;')])
				// unsupported statement: Stmt_InlineHTML
			}
			// unsupported statement: Stmt_InlineHTML
			mut iter_10 := rt.cast_array(var_nav_menus).iterator()
			for {
				item_10 := iter_10.next() or { break }
				mut var__nav_menu := item_10.val
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_attr', [
					rt.get_property(var__nav_menu, 'term_id'),
				]))
				// unsupported statement: Stmt_InlineHTML
				rt.call_function('selected', [rt.get_property(var__nav_menu, 'term_id'),
					var_nav_menu_selected_id.clone()])
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_html', [
					rt.get_property(var__nav_menu, 'truncated_name'),
				]))
				if !(!rt.is_true(var_menu_locations))
					&& rt.is_true(rt.call_function('in_array', [rt.get_property(var__nav_menu, 'term_id'), var_menu_locations.clone(), rt.new_bool(true)])) {
					mut var_locations_assigned_to_this_menu := []rt.PhpVal{}
					mut iter_11 := rt.func_array_keys(var_menu_locations.clone(), rt.get_property(var__nav_menu,
						'term_id'), rt.new_bool(true)).iterator()
					for {
						item_11 := iter_11.next() or { break }
						mut var_menu_location_key := item_11.val
						if var_locations.array_isset(var_menu_location_key) {
							var_locations_assigned_to_this_menu << var_locations.array_get(var_menu_location_key)
						}
					}
					mut var_locations_listed_per_menu := rt.call_function('absint', [
						rt.call_function('apply_filters', [
							rt.new_string('wp_nav_locations_listed_per_menu'),
							rt.new_int(3),
						]),
					])
					mut var_assigned_locations := rt.call_function('array_slice', [
						rt.create_array_from_list(var_locations_assigned_to_this_menu),
						rt.new_int(0),
						var_locations_listed_per_menu.clone(),
					])
					if !(!rt.is_true(var_assigned_locations)) {
						rt.call_function('printf', [rt.new_string(' (%1$s%2$s)'),
							rt.call_function('implode', [rt.new_string(', '),
								var_assigned_locations.clone()]),
							rt.new_string((if var_locations_assigned_to_this_menu.len > var_assigned_locations.clone().array_count() {
								' &hellip;'
							} else {
								''
							}).str())])
					}
				}
				// unsupported statement: Stmt_InlineHTML
			}
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('esc_attr_e', [rt.new_string('Select')])
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('printf', [
				rt.call_function('__', [
					rt.new_string('or <a href="%s">create a new menu</a>. Do not forget to save your changes!'),
				]),
				rt.call_function('esc_url', [
					rt.call_function('add_query_arg', [
						rt.create_array([rt.ArrayItem{ key: 'action', val: 'edit' },
							rt.ArrayItem{ key: 'menu', val: 0 }]),
						rt.call_function('admin_url', [rt.new_string('nav-menus.php')]),
					]),
				]),
			])
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('_e', [
				rt.new_string('Click the Save Menu button to save your changes.'),
			])
			// unsupported statement: Stmt_InlineHTML
		}
		mut var_metabox_holder_disabled_class := ''
		if rt.get_superglobal('_GET').array_isset(rt.new_string('menu'))
			&& 0 == rt.new_int((rt.get_superglobal('_GET').array_get(rt.new_string('menu'))).to_i64()) {
			var_metabox_holder_disabled_class = ' metabox-holder-disabled'
		}
		// unsupported statement: Stmt_InlineHTML
		print(var_metabox_holder_disabled_class)
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [var_nav_menu_selected_id.clone()]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('wp_nonce_field', [rt.new_string('add-menu_item'),
			rt.new_string('menu-settings-column-nonce')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Add menu items')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('do_accordion_sections', [rt.new_string('nav-menus'),
			rt.new_string('side'), rt.new_null()])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Menu structure')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('wp_nonce_field', [rt.new_string('closedpostboxes'),
			rt.new_string('closedpostboxesnonce'), rt.new_bool(false)])
		rt.call_function('wp_nonce_field', [rt.new_string('meta-box-order'),
			rt.new_string('meta-box-order-nonce'), rt.new_bool(false)])
		rt.call_function('wp_nonce_field', [rt.new_string('update-nav_menu'),
			rt.new_string('update-nav-menu-nonce')])
		mut var_menu_name_aria_desc := if var_add_new_screen {
			' aria-describedby="menu-name-desc"'
		} else {
			''
		}
		if var_one_theme_location_no_menus {
			mut var_menu_name_val := rt.new_string('value="' +
				(rt.call_function('esc_attr__', [rt.new_string('Menu 1')])).str() + '"')
			// unsupported statement: Stmt_InlineHTML
		} else {
			var_menu_name_val = rt.new_string('value="' +
				(rt.call_function('esc_attr', [var_nav_menu_selected_title.clone()])).str() + '"')
		}
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [var_nav_menu_selected_id.clone()]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Menu Name')])
		// unsupported statement: Stmt_InlineHTML
		print(var_menu_name_val.str() + var_menu_name_aria_desc)
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('submit_button', [if !rt.is_true(var_nav_menu_selected_id) { rt.call_function('__', [
				rt.new_string('Create Menu'),
			]) } else { rt.call_function('__', [
				rt.new_string('Save Menu'),
			]) }, rt.new_string('primary large menu-save'), rt.new_string('save_menu'),
			rt.new_bool(false), rt.create_array([
				rt.ArrayItem{ key: 'id', val: 'save_menu_header' },
			])])
		// unsupported statement: Stmt_InlineHTML
		if !var_add_new_screen {
			// unsupported statement: Stmt_InlineHTML
			mut var_hide_style := ''
			if !var_menu_items.is_null() && 0 == var_menu_items.clone().array_count() {
				var_hide_style = 'style="display: none;"'
			}
			if var_one_theme_location_no_menus {
				mut var_starter_copy := rt.call_function('__', [
					rt.new_string('Edit your default menu by adding or removing items. Drag the items into the order you prefer. Click Create Menu to save your changes.'),
				])
			} else {
				var_starter_copy = rt.call_function('__', [
					rt.new_string('Drag the items into the order you prefer. Click the arrow on the right of the item to reveal additional configuration options.'),
				])
			}
			// unsupported statement: Stmt_InlineHTML
			print(var_hide_style)
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(var_starter_copy)
			// unsupported statement: Stmt_InlineHTML
			print(var_hide_style)
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('_e', [rt.new_string('Bulk Select')])
			// unsupported statement: Stmt_InlineHTML
			if !var_edit_markup.is_null()
				&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_edit_markup.clone()]))))) {
				rt.echo_val(var_edit_markup)
			} else {
				// unsupported statement: Stmt_InlineHTML
			}
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
		if var_add_new_screen {
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('_e', [
				rt.new_string('Give your menu a name, then click Create Menu.'),
			])
			// unsupported statement: Stmt_InlineHTML
			if rt.get_superglobal('_GET').array_isset(rt.new_string('use-location')) {
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_attr', [
					rt.get_superglobal('_GET').array_get(rt.new_string('use-location')),
				]))
				// unsupported statement: Stmt_InlineHTML
			}
			// unsupported statement: Stmt_InlineHTML
		}
		mut var_no_menus_style := ''
		if var_one_theme_location_no_menus {
			var_no_menus_style = 'style="display: none;"'
		}
		// unsupported statement: Stmt_InlineHTML
		if !var_add_new_screen {
			// unsupported statement: Stmt_InlineHTML
			print(var_hide_style)
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('_e', [rt.new_string('Bulk Select')])
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('esc_attr_e', [rt.new_string('Remove Selected Items')])
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('_e', [
				rt.new_string('List of menu items selected for deletion:'),
			])
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
		print(var_no_menus_style)
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Menu Settings')])
		// unsupported statement: Stmt_InlineHTML
		if !(!var_auto_add.is_null()) {
			mut var_auto_add := rt.call_function('get_option', [
				rt.new_string('nav_menu_options'),
			])
			if !(var_auto_add.array_isset(rt.new_string('auto_add'))) {
				var_auto_add = rt.new_bool(false)
			} else if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('array_search', [
				var_nav_menu_selected_id.clone(),
				var_auto_add.array_get(rt.new_string('auto_add')),
				rt.new_bool(true),
			])))))
			{
				var_auto_add = rt.new_bool(true)
			} else {
				var_auto_add = rt.new_bool(false)
			}
		}
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Auto add pages')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('checked', [var_auto_add.clone()])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('printf', [
			rt.call_function('__', [
				rt.new_string('Automatically add new top-level pages to this menu'),
			]),
			rt.call_function('esc_url', [
				rt.call_function('admin_url', [rt.new_string('edit.php?post_type=page')]),
			]),
		])
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(rt.call_function('current_theme_supports', [
			rt.new_string('menus')]))
		{
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('_e', [rt.new_string('Menu location')])
			// unsupported statement: Stmt_InlineHTML
			mut iter_12 := var_locations.iterator()
			for {
				item_12 := iter_12.next() or { break }
				mut var_description := item_12.val
				mut var_location := item_12.key
				mut var_checked := false
				mut var_theme_location_set_id := ''
				if var_menu_locations.array_isset(var_location)
					&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int(0), var_nav_menu_selected_id))))
					&& rt.is_true(rt.identical(var_menu_locations.array_get(var_location), var_nav_menu_selected_id)) {
					var_checked = true
				}
				if !(!rt.is_true(var_menu_locations.array_get(var_location)))
					&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_menu_locations.array_get(var_location), var_nav_menu_selected_id)))) {
					var_theme_location_set_id = 'theme-location-set-${var_location.to_string()}'
				}
				// unsupported statement: Stmt_InlineHTML
				rt.call_function('checked', [rt.new_bool(var_checked).clone()])
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_attr', [var_location.clone()]))
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_attr', [var_location.clone()]))
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_attr', [var_nav_menu_selected_id.clone()]))
				// unsupported statement: Stmt_InlineHTML
				if rt.is_true(rt.new_bool('' != var_theme_location_set_id)) {
					// unsupported statement: Stmt_InlineHTML
					rt.echo_val(rt.call_function('esc_attr', [
						rt.new_string(var_theme_location_set_id.str()).clone()]))
					// unsupported statement: Stmt_InlineHTML
				}
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_attr', [var_location.clone()]))
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_html', [var_description.clone()]))
				// unsupported statement: Stmt_InlineHTML
				if rt.is_true(rt.new_bool('' != var_theme_location_set_id)) {
					// unsupported statement: Stmt_InlineHTML
					rt.echo_val(rt.call_function('esc_attr', [
						rt.new_string(var_theme_location_set_id.str()).clone()]))
					// unsupported statement: Stmt_InlineHTML
					rt.call_function('printf', [
						rt.call_function('_x', [rt.new_string('(Currently set to: %s)'),
							rt.new_string('menu location')]),
						if rt.is_true(rt.call_function('is_nav_menu', [
							var_menu_locations.array_get(var_location)]))
						{ rt.call_function('esc_html', [
								rt.get_property(rt.call_function('wp_get_nav_menu_object', [
									var_menu_locations.array_get(var_location),
								]), 'name'),
							]) } else { rt.call_function('__', [
								rt.new_string('an unknown menu'),
							]) },
					])
					// unsupported statement: Stmt_InlineHTML
				}
				// unsupported statement: Stmt_InlineHTML
			}
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('submit_button', [if !rt.is_true(var_nav_menu_selected_id) { rt.call_function('__', [
				rt.new_string('Create Menu'),
			]) } else { rt.call_function('__', [
				rt.new_string('Save Menu'),
			]) }, rt.new_string('primary large menu-save'), rt.new_string('save_menu'),
			rt.new_bool(false), rt.create_array([
				rt.ArrayItem{ key: 'id', val: 'save_menu_footer' },
			])])
		// unsupported statement: Stmt_InlineHTML
		if var_menu_count > 0 {
			// unsupported statement: Stmt_InlineHTML
			if var_add_new_screen {
				// unsupported statement: Stmt_InlineHTML
				rt.call_function('printf', [
					rt.new_string('<a class="submitcancel cancellation menu-cancel" href="%1$s">%2$s</a>'),
					rt.call_function('esc_url', [
						rt.call_function('admin_url', [rt.new_string('nav-menus.php')]),
					]),
					rt.call_function('__', [
						rt.new_string('Cancel'),
					]),
				])
				// unsupported statement: Stmt_InlineHTML
			} else {
				// unsupported statement: Stmt_InlineHTML
				rt.call_function('printf', [
					rt.new_string('<a class="submitdelete deletion menu-delete" href="%1$s">%2$s</a>'),
					rt.call_function('esc_url', [
						rt.call_function('wp_nonce_url', [
							rt.call_function('add_query_arg', [
								rt.create_array([
									rt.ArrayItem{ key: 'action', val: 'delete' },
									rt.ArrayItem{ key: 'menu', val: var_nav_menu_selected_id },
								]),
								rt.call_function('admin_url', [
									rt.new_string('nav-menus.php'),
								]),
							]),
							rt.new_string('delete-nav_menu-' + var_nav_menu_selected_id.str()),
						]),
					]),
					rt.call_function('__', [
						rt.new_string('Delete Menu'),
					]),
				])
				// unsupported statement: Stmt_InlineHTML
			}
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-footer.php', '4')
}
