import rt

fn _wp_menu_output(var_menu rt.PhpVal, var_submenu rt.PhpVal, submenu_as_parent bool) {
	mut var_self := rt.new_null()
	mut var_parent_file := rt.new_null()
	mut var_submenu_file := rt.new_null()
	mut var_plugin_page := rt.new_null()
	mut var_typenow := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var_first := true
	{
		mut iter_1 := var_menu.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_item := item_1.val
			mut var_key := item_1.key
			mut var_admin_is_parent := false
			mut var_class := rt.new_array()
			mut var_aria_attributes := ''
			mut var_aria_hidden := ''
			mut var_is_separator := false
			if var_first {
				var_class.array_push('wp-first-item')
				var_first = false
			}
			mut var_submenu_items := rt.new_array()
			if !(!rt.is_true(var_submenu.array_get(var_item.array_get(2)))) {
				var_class.array_push('wp-has-submenu')
				var_submenu_items = var_submenu.array_get(var_item.array_get(2))
			}
			if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(var_parent_file) && rt.is_true(rt.identical(var_item.array_get(2), var_parent_file)))) || rt.is_true(rt.new_bool(!rt.is_true(var_typenow) && rt.is_true(rt.identical(var_self, var_item.array_get(2))))))) {
				if !(!rt.is_true(var_submenu_items)) {
					var_class.array_push('wp-has-current-submenu wp-menu-open')
				} else {
					var_class.array_push('current')
					// unsupported expression: Expr_AssignOp_Concat
				}
			} else {
				var_class.array_push('wp-not-current-submenu')
				if !(!rt.is_true(var_submenu_items)) {
					// unsupported expression: Expr_AssignOp_Concat
				}
			}
			if !(!rt.is_true(var_item.array_get(4))) {
				var_class.array_push(rt.call_function('esc_attr', [var_item.array_get(4)]))
			}
			var_class = rt.new_string(if rt.is_true(var_class) { ' class="' + (rt.call_function('implode', [rt.new_string(' '), var_class.dup()])).str() + '"' } else { rt.new_string('') })
			mut var_id := rt.new_string(if !(!rt.is_true(var_item.array_get(5))) { ' id="' + (rt.call_function('preg_replace', [rt.new_string('|[^a-zA-Z0-9_:.]|'), rt.new_string('-'), var_item.array_get(5)])).str() + '"' } else { rt.new_string('') })
			mut var_img := rt.new_string(rt.new_string(''))
			mut var_img_style := rt.new_string(rt.new_string(''))
			mut var_img_class := rt.new_string(rt.new_string(' dashicons-before'))
			if rt.is_true(rt.call_function('str_contains', [var_class.dup(), rt.new_string('wp-menu-separator')])) {
				var_is_separator = true
			}
			if !(!rt.is_true(var_item.array_get(6))) {
				var_img = rt.new_string('<img src="' + (rt.call_function('esc_url', [var_item.array_get(6)])).str() + '" alt="" />')
				if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('none'), var_item.array_get(6))) || rt.is_true(rt.identical(rt.new_string('div'), var_item.array_get(6))))) {
					var_img = rt.new_string(rt.new_string('<br />'))
				} else if rt.is_true(rt.call_function('str_starts_with', [var_item.array_get(6), rt.new_string('data:image/svg+xml;base64,')])) {
					var_img = rt.new_string(rt.new_string('<br />'))
					var_img_style = rt.new_string(' style="background-image:url(\'' + (rt.call_function('esc_attr', [var_item.array_get(6)])).str() + '\')"')
					var_img_class = rt.new_string(rt.new_string(' svg'))
				} else if rt.is_true(rt.call_function('str_starts_with', [var_item.array_get(6), rt.new_string('dashicons-')])) {
					var_img = rt.new_string(rt.new_string('<br />'))
					var_img_class = rt.new_string(' dashicons-before ' + (rt.call_function('sanitize_html_class', [var_item.array_get(6)])).str())
				}
			}
			mut var_title := rt.call_function('wptexturize', [var_item.array_get(0)])
			if var_is_separator {
				var_aria_hidden = ' aria-hidden="true"'
			}
			print("\n\t<li${var_class.to_string()}${var_id.to_string()}${var_aria_hidden}>")
			if var_is_separator {
				print('<div class="separator"></div>')
			} else if var_submenu_as_parent && !(!rt.is_true(var_submenu_items)) {
				var_submenu_items = rt.call_function('array_values', [var_submenu_items.dup()])
				mut var_menu_hook := rt.call_function('get_plugin_page_hook', [var_submenu_items.array_get(0).array_get(2), var_item.array_get(2)])
				mut var_menu_file := var_submenu_items.array_get(0).array_get(2)
				mut var_pos := rt.call_function('strpos', [var_menu_file.dup(), rt.new_string('?')])
				if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
					var_menu_file = rt.call_function('substr', [var_menu_file.dup(), rt.new_int(0), var_pos.dup()])
				}
				if rt.is_true(rt.new_bool(!(!rt.is_true(var_menu_hook)) || rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) && rt.is_true(rt.call_function('file_exists', [(rt.get_constant('WP_PLUGIN_DIR')).str() + "/${var_menu_file.to_string()}"])))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('file_exists', [(rt.get_constant('ABSPATH')).str() + "/wp-admin/${var_menu_file.to_string()}"]))))))))) {
					var_admin_is_parent = true
					print(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('<a href=\'admin.php?page='), var_submenu_items.array_get(0).array_get(2)), rt.new_string('\'')), var_class), rt.new_string(' ')), rt.new_string(var_aria_attributes)), rt.new_string('><div class=\'wp-menu-image')), var_img_class), rt.new_string('\'')), var_img_style), rt.new_string(' aria-hidden=\'true\'>')), var_img), rt.new_string('</div><div class=\'wp-menu-name\'>')), var_title), rt.new_string('</div></a>')))
				} else {
					print(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('\n\t<a href=\''), var_submenu_items.array_get(0).array_get(2)), rt.new_string('\'')), var_class), rt.new_string(' ')), rt.new_string(var_aria_attributes)), rt.new_string('><div class=\'wp-menu-image')), var_img_class), rt.new_string('\'')), var_img_style), rt.new_string(' aria-hidden=\'true\'>')), var_img), rt.new_string('</div><div class=\'wp-menu-name\'>')), var_title), rt.new_string('</div></a>')))
				}
			} else if rt.is_true(rt.new_bool(!(!rt.is_true(var_item.array_get(2))) && rt.is_true(rt.call_function('current_user_can', [var_item.array_get(1)])))) {
				var_menu_hook = rt.call_function('get_plugin_page_hook', [var_item.array_get(2), rt.new_string('admin.php')])
				var_menu_file = var_item.array_get(2)
				var_pos = rt.call_function('strpos', [var_menu_file.dup(), rt.new_string('?')])
				if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
					var_menu_file = rt.call_function('substr', [var_menu_file.dup(), rt.new_int(0), var_pos.dup()])
				}
				if rt.is_true(rt.new_bool(!(!rt.is_true(var_menu_hook)) || rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) && rt.is_true(rt.call_function('file_exists', [(rt.get_constant('WP_PLUGIN_DIR')).str() + "/${var_menu_file.to_string()}"])))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('file_exists', [(rt.get_constant('ABSPATH')).str() + "/wp-admin/${var_menu_file.to_string()}"]))))))))) {
					var_admin_is_parent = true
					print(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('\n\t<a href=\'admin.php?page='), var_item.array_get(2)), rt.new_string('\'')), var_class), rt.new_string(' ')), rt.new_string(var_aria_attributes)), rt.new_string('><div class=\'wp-menu-image')), var_img_class), rt.new_string('\'')), var_img_style), rt.new_string(' aria-hidden=\'true\'>')), var_img), rt.new_string('</div><div class=\'wp-menu-name\'>')), var_item.array_get(0)), rt.new_string('</div></a>')))
				} else {
					print(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('\n\t<a href=\''), var_item.array_get(2)), rt.new_string('\'')), var_class), rt.new_string(' ')), rt.new_string(var_aria_attributes)), rt.new_string('><div class=\'wp-menu-image')), var_img_class), rt.new_string('\'')), var_img_style), rt.new_string(' aria-hidden=\'true\'>')), var_img), rt.new_string('</div><div class=\'wp-menu-name\'>')), var_item.array_get(0)), rt.new_string('</div></a>')))
				}
			}
			if !(!rt.is_true(var_submenu_items)) {
				print('\n\t<ul class=\'wp-submenu wp-submenu-wrap\'>')
				print(rt.concat(rt.concat(rt.new_string('<li class=\'wp-submenu-head\' aria-hidden=\'true\'>'), var_item.array_get(0)), rt.new_string('</li>')))
				var_first = true
				{
					mut iter_2 := var_submenu_items.iterator()
					for {
						item_2 := iter_2.next() or { break }
						mut var_sub_item := item_2.val
						mut var_sub_key := item_2.key
						if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [var_sub_item.array_get(1)]))))) {
							continue
						}
						var_class = rt.new_array()
						var_aria_attributes = ''
						if var_first {
							var_class.array_push('wp-first-item')
							var_first = false
						}
						var_menu_file = var_item.array_get(2)
						var_pos = rt.call_function('strpos', [var_menu_file.dup(), rt.new_string('?')])
						if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
							var_menu_file = rt.call_function('substr', [var_menu_file.dup(), rt.new_int(0), var_pos.dup()])
						}
						mut var_self_type := rt.new_string(if !(!rt.is_true(var_typenow)) { (var_self).str() + '?post_type=' + (var_typenow).str() } else { rt.new_string('nothing') })
						if !(var_submenu_file).is_null() {
							if rt.is_true(rt.identical(var_submenu_file, var_sub_item.array_get(2))) {
								var_class.array_push('current')
								// unsupported expression: Expr_AssignOp_Concat
							}
							// unsupported statement: Stmt_Nop
						} else if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(!(var_plugin_page).is_null()) && rt.is_true(rt.identical(var_self, var_sub_item.array_get(2))))) || rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(var_plugin_page).is_null() && rt.is_true(rt.identical(var_plugin_page, var_sub_item.array_get(2))))) && rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.identical(var_item.array_get(2), var_self_type)) || rt.is_true(rt.identical(var_item.array_get(2), var_self)))) || rt.is_true(rt.identical(rt.call_function('file_exists', [var_menu_file.dup()]), rt.new_bool(false))))))))) {
							var_class.array_push('current')
							// unsupported expression: Expr_AssignOp_Concat
						}
						if !(!rt.is_true(var_sub_item.array_get(4))) {
							var_class.array_push(rt.call_function('esc_attr', [var_sub_item.array_get(4)]))
						}
						var_class = rt.new_string(if rt.is_true(var_class) { ' class="' + (rt.call_function('implode', [rt.new_string(' '), var_class.dup()])).str() + '"' } else { rt.new_string('') })
						var_menu_hook = rt.call_function('get_plugin_page_hook', [var_sub_item.array_get(2), var_item.array_get(2)])
						mut var_sub_file := var_sub_item.array_get(2)
						var_pos = rt.call_function('strpos', [var_sub_file.dup(), rt.new_string('?')])
						if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
							var_sub_file = rt.call_function('substr', [var_sub_file.dup(), rt.new_int(0), var_pos.dup()])
						}
						var_title = rt.call_function('wptexturize', [var_sub_item.array_get(0)])
						if rt.is_true(rt.new_bool(!(!rt.is_true(var_menu_hook)) || rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) && rt.is_true(rt.call_function('file_exists', [(rt.get_constant('WP_PLUGIN_DIR')).str() + "/${var_sub_file.to_string()}"])))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('file_exists', [(rt.get_constant('ABSPATH')).str() + "/wp-admin/${var_sub_file.to_string()}"]))))))))) {
							if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(var_admin_is_parent) && rt.is_true(rt.call_function('file_exists', [(rt.get_constant('WP_PLUGIN_DIR')).str() + "/${var_menu_file.to_string()}"])))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_dir', [(rt.get_constant('WP_PLUGIN_DIR')).str() + rt.concat(rt.new_string('/'), var_item.array_get(2))]))))))) || rt.is_true(rt.call_function('file_exists', [var_menu_file.dup()])))) {
								mut var_sub_item_url := rt.call_function('add_query_arg', [rt.create_array([rt.ArrayItem{ key: 'page', val: var_sub_item.array_get(2) }]), var_item.array_get(2)])
							} else {
								var_sub_item_url = rt.call_function('add_query_arg', [rt.create_array([rt.ArrayItem{ key: 'page', val: var_sub_item.array_get(2) }]), rt.new_string('admin.php')])
							}
							var_sub_item_url = rt.call_function('esc_url', [var_sub_item_url.dup()])
							print("<li${var_class.to_string()}><a href='${var_sub_item_url.to_string()}'${var_class.to_string()}${var_aria_attributes}>${var_title.to_string()}</a></li>")
						} else {
							print(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('<li'), var_class), rt.new_string('><a href=\'')), var_sub_item.array_get(2)), rt.new_string('\'')), var_class), rt.new_string(var_aria_attributes)), rt.new_string('>')), var_title), rt.new_string('</a></li>')))
						}
					}
				}
				print('</ul>')
			}
			print('</li>')
		}
	}
	print( +  + '<span class="collapse-button-icon" aria-hidden="true"></span>' + '<span class="collapse-button-label">' + (rt.call_function('__', [rt.new_string('Collapse Menu')])).str() + '</span>' + '</button></li>')
}


fn main() {
	defer {
		rt.shutdown()
	}

	mut var_menu := rt.new_null()
	mut var_submenu := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))))) {
		// unsupported expression: Expr_Exit
	}
	mut var_self := rt.call_function('preg_replace', [rt.new_string('|^.*/wp-admin/network/|i'), rt.new_string(''), rt.get_superglobal('_SERVER').array_get('PHP_SELF')])
	var_self = rt.call_function('preg_replace', [rt.new_string('|^.*/wp-admin/|i'), rt.new_string(''), var_self.dup()])
	var_self = rt.call_function('preg_replace', [rt.new_string('|^.*/plugins/|i'), rt.new_string(''), var_self.dup()])
	var_self = rt.call_function('preg_replace', [rt.new_string('|^.*/mu-plugins/|i'), rt.new_string(''), var_self.dup()])
	// unsupported statement: Stmt_Global
	mut var_parent_file := rt.call_function('apply_filters', [rt.new_string('parent_file'), var_parent_file.dup()])
	mut var_submenu_file := rt.call_function('apply_filters', [rt.new_string('submenu_file'), var_submenu_file.dup(), var_parent_file.dup()])
	rt.call_function('get_admin_page_parent', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('Main menu')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Skip to main content')])
	// unsupported statement: Stmt_InlineHTML
	
}
