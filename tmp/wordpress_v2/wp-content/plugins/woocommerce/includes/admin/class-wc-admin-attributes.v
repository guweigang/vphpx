import rt

struct Class_WC_Admin_Attributes {
	rt.PhpObjectBase
}

fn init_static_wc_admin_attributes() {
	rt.init_static_prop('WC_Admin_Attributes', 'edited_attribute_id', rt.new_null())
}

fn Class_WC_Admin_Attributes.output() {
	mut var_result := rt.new_string('')
	mut var_action := rt.new_string('')
	if !(!rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('add_new_attribute')))) {
		var_action = rt.new_string('add')
	} else if
		!(!rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('save_attribute'))))
		&& !(!rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('edit')))) {
		var_action = rt.new_string('edit')
	} else if !(!rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('delete')))) {
		var_action = rt.new_string('delete')
	}
	mut switch_val_1 := var_action
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('add'))) {
		var_result = Class_WC_Admin_Attributes.process_add_attribute()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('edit'))) {
		var_result = Class_WC_Admin_Attributes.process_edit_attribute()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('delete'))) {
		var_result = Class_WC_Admin_Attributes.process_delete_attribute()
	}
	if rt.is_true(rt.call_function('is_wp_error', [var_result.clone()])) {
		print('<div id="woocommerce_errors" class="error"><p>' +
			(rt.call_function('wp_kses_post', [rt.call_method(var_result, 'get_error_message', []rt.PhpVal{})])).str() +
			'</p></div>')
	}
	if !(!rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('edit')))) {
		Class_WC_Admin_Attributes.edit_attribute()
	} else {
		Class_WC_Admin_Attributes.add_attribute()
	}
}

fn Class_WC_Admin_Attributes.get_posted_attribute() rt.PhpVal {
	mut var_attribute := rt.create_array([
		rt.ArrayItem{
			key: 'attribute_label'
			val: if rt.get_superglobal('_POST').array_isset(rt.new_string('attribute_label')) { rt.call_function('wc_clean', [
					rt.call_function('wp_unslash', [
						rt.get_superglobal('_POST').array_get(rt.new_string('attribute_label')),
					]),
				]) } else { rt.new_string('') }
		},
		rt.ArrayItem{
			key: 'attribute_name'
			val: if rt.get_superglobal('_POST').array_isset(rt.new_string('attribute_name')) { rt.call_function('wc_sanitize_taxonomy_name', [
					rt.call_function('wp_unslash', [
						rt.get_superglobal('_POST').array_get(rt.new_string('attribute_name')),
					]),
				]) } else { rt.new_string('') }
		},
		rt.ArrayItem{
			key: 'attribute_type'
			val: if rt.get_superglobal('_POST').array_isset(rt.new_string('attribute_type')) { rt.call_function('wc_clean', [
					rt.call_function('wp_unslash', [
						rt.get_superglobal('_POST').array_get(rt.new_string('attribute_type')),
					]),
				]) } else { rt.new_string('select') }
		},
		rt.ArrayItem{
			key: 'attribute_orderby'
			val: if rt.get_superglobal('_POST').array_isset(rt.new_string('attribute_orderby')) { rt.call_function('wc_clean', [
					rt.call_function('wp_unslash', [
						rt.get_superglobal('_POST').array_get(rt.new_string('attribute_orderby')),
					]),
				]) } else { rt.new_string('') }
		},
		rt.ArrayItem{
			key: 'attribute_public'
			val: if rt.get_superglobal('_POST').array_isset(rt.new_string('attribute_public')) {
				1
			} else {
				0
			}
		},
	])
	if !rt.is_true(var_attribute.array_get(rt.new_string('attribute_type'))) {
		var_attribute.array_set('attribute_type', 'select')
	}
	if !rt.is_true(var_attribute.array_get(rt.new_string('attribute_label'))) {
		var_attribute.array_set('attribute_label', rt.call_function('ucfirst', [
			var_attribute.array_get(rt.new_string('attribute_name')),
		]))
	}
	if !rt.is_true(var_attribute.array_get(rt.new_string('attribute_name'))) {
		var_attribute.array_set('attribute_name', rt.call_function('wc_sanitize_taxonomy_name', [
			var_attribute.array_get(rt.new_string('attribute_label')),
		]))
	}
	return var_attribute.clone()
}

fn Class_WC_Admin_Attributes.process_add_attribute() bool {
	rt.call_function('check_admin_referer', [
		rt.new_string('woocommerce-add-new_attribute'),
	])
	mut var_attribute := Class_WC_Admin_Attributes.get_posted_attribute()
	mut var_args := {
		'name':         var_attribute.array_get(rt.new_string('attribute_label'))
		'slug':         var_attribute.array_get(rt.new_string('attribute_name'))
		'type':         var_attribute.array_get(rt.new_string('attribute_type'))
		'order_by':     var_attribute.array_get(rt.new_string('attribute_orderby'))
		'has_archives': var_attribute.array_get(rt.new_string('attribute_public'))
	}
	mut var_id := rt.call_function('wc_create_attribute', [
		rt.create_array_from_native_map(var_args),
	])
	if rt.is_true(rt.call_function('is_wp_error', [var_id.clone()])) {
		return var_id.to_bool()
	}
	return true
}

fn Class_WC_Admin_Attributes.process_edit_attribute() bool {
	mut var_attribute_id := if rt.get_superglobal('_GET').array_isset(rt.new_string('edit')) { rt.call_function('absint', [
			rt.get_superglobal('_GET').array_get(rt.new_string('edit')),
		]) } else { rt.new_int(0) }
	rt.call_function('check_admin_referer', [
		rt.new_string('woocommerce-save-attribute_' + var_attribute_id.str()),
	])
	mut var_attribute := Class_WC_Admin_Attributes.get_posted_attribute()
	mut var_args := {
		'name':         var_attribute.array_get(rt.new_string('attribute_label'))
		'slug':         var_attribute.array_get(rt.new_string('attribute_name'))
		'type':         var_attribute.array_get(rt.new_string('attribute_type'))
		'order_by':     var_attribute.array_get(rt.new_string('attribute_orderby'))
		'has_archives': var_attribute.array_get(rt.new_string('attribute_public'))
	}
	mut var_id := rt.call_function('wc_update_attribute', [var_attribute_id.clone(),
		rt.create_array_from_native_map(var_args)])
	if rt.is_true(rt.call_function('is_wp_error', [var_id.clone()])) {
		return var_id.to_bool()
	}
	rt.set_static_prop('WC_Admin_Attributes', 'edited_attribute_id', var_id.clone())
	return true
}

fn Class_WC_Admin_Attributes.process_delete_attribute() rt.PhpVal {
	mut var_attribute_id := if rt.get_superglobal('_GET').array_isset(rt.new_string('delete')) { rt.call_function('absint', [
			rt.get_superglobal('_GET').array_get(rt.new_string('delete')),
		]) } else { rt.new_int(0) }
	rt.call_function('check_admin_referer', [
		rt.new_string('woocommerce-delete-attribute_' + var_attribute_id.str()),
	])
	return rt.call_function('wc_delete_attribute', [var_attribute_id.clone()])
}

fn Class_WC_Admin_Attributes.edit_attribute() {
	mut var_wpdb := rt.new_null()
	mut var_edit := if rt.get_superglobal('_GET').array_isset(rt.new_string('edit')) { rt.call_function('absint', [
			rt.get_superglobal('_GET').array_get(rt.new_string('edit')),
		]) } else { rt.new_int(0) }
	mut var_attribute_to_edit := rt.call_method(var_wpdb, 'get_row', [
		rt.call_method(var_wpdb, 'prepare', [
			rt.concat(rt.concat(rt.new_string('\n\t\t\t\tSELECT attribute_type, attribute_label, attribute_name, attribute_orderby, attribute_public\n\t\t\t\tFROM '), rt.get_property(var_wpdb,
				'prefix')),
				rt.new_string('woocommerce_attribute_taxonomies WHERE attribute_id = %d\n\t\t\t\t')),
			var_edit.clone(),
		]),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Edit attribute'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.new_bool(!(rt.is_true(var_attribute_to_edit)))) {
		print('<div id="woocommerce_errors" class="error"><p>' +
			(rt.call_function('esc_html__', [rt.new_string('Error: non-existing attribute ID.'), rt.new_string('woocommerce')])).str() +
			'</p></div>')
	} else {
		if rt.is_true(rt.greater(rt.get_static_prop('WC_Admin_Attributes', 'edited_attribute_id'),
			rt.new_int(0)))
		{
			print('<div id="message" class="updated"><p>' +
				(rt.call_function('esc_html__', [rt.new_string('Attribute updated successfully'), rt.new_string('woocommerce')])).str() +
				'</p><p><a href="' +
				(rt.call_function('esc_url', [rt.call_function('admin_url', [rt.new_string('edit.php?post_type=product&amp;page=product_attributes')])])).str() +
				'">' +
				(rt.call_function('esc_html__', [rt.new_string('Back to Attributes'), rt.new_string('woocommerce')])).str() +
				'</a></p></div>')
			rt.set_static_prop('WC_Admin_Attributes', 'edited_attribute_id', rt.new_null())
		}
		mut var_att_type := rt.get_property(var_attribute_to_edit, 'attribute_type')
		mut var_att_label := rt.call_function('format_to_edit', [
			rt.get_property(var_attribute_to_edit, 'attribute_label'),
		])
		mut var_att_name := rt.get_property(var_attribute_to_edit, 'attribute_name')
		mut var_att_orderby := rt.get_property(var_attribute_to_edit, 'attribute_orderby')
		mut var_att_public := rt.get_property(var_attribute_to_edit, 'attribute_public')
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('absint', [var_edit.clone()]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('do_action', [
			rt.new_string('woocommerce_before_edit_attribute_fields'),
		])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Name'),
			rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [var_att_label.clone()]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [
			rt.new_string('Name for the attribute (shown on the front-end).'),
			rt.new_string('woocommerce'),
		])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Slug'),
			rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [var_att_name.clone()]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [
			rt.new_string('Unique slug/reference for the attribute; must be no more than 28 characters.'),
			rt.new_string('woocommerce'),
		])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Enable archives?'),
			rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('checked', [var_att_public.clone(), rt.new_int(1)])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [
			rt.new_string('Enable this if you want this attribute to have product archives in your store.'),
			rt.new_string('woocommerce'),
		])
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(rt.call_function('wc_has_custom_attribute_types', []rt.PhpVal{})) {
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('esc_html_e', [rt.new_string('Type'),
				rt.new_string('woocommerce')])
			// unsupported statement: Stmt_InlineHTML
			mut iter_1 := rt.call_function('wc_get_attribute_types', []rt.PhpVal{}).iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_value := item_1.val
				mut var_key := item_1.key
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_attr', [var_key.clone()]))
				// unsupported statement: Stmt_InlineHTML
				rt.call_function('selected', [var_att_type.clone(),
					var_key.clone()])
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_html', [var_value.clone()]))
				// unsupported statement: Stmt_InlineHTML
			}
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('do_action', [
				rt.new_string('woocommerce_admin_attribute_types'),
			])
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('esc_html_e', [
				rt.new_string("Determines how this attribute's values are displayed."),
				rt.new_string('woocommerce'),
			])
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Default sort order'),
			rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('selected', [var_att_orderby.clone(),
			rt.new_string('menu_order')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Custom ordering'),
			rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('selected', [var_att_orderby.clone(),
			rt.new_string('name')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Name'),
			rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('selected', [var_att_orderby.clone(),
			rt.new_string('name_num')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Name (numeric)'),
			rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('selected', [var_att_orderby.clone(),
			rt.new_string('id')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Term ID'),
			rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [
			rt.new_string('Determines the sort order of the terms on the frontend shop product pages. If using custom ordering, you can drag and drop the terms in this attribute.'),
			rt.new_string('woocommerce'),
		])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('do_action', [
			rt.new_string('woocommerce_after_edit_attribute_fields'),
		])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_attr_e', [rt.new_string('Update'),
			rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Update'),
			rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('wp_nonce_field', [
			rt.new_string('woocommerce-save-attribute_' + var_edit.str()),
		])
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
}

fn Class_WC_Admin_Attributes.add_attribute() {
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [
		rt.call_function('get_admin_page_title', []rt.PhpVal{}),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Name'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Slug'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.call_function('wc_has_custom_attribute_types', []rt.PhpVal{})) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Type'),
			rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Order by'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Terms'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	mut var_attribute_taxonomies := rt.call_function('wc_get_attribute_taxonomies', []rt.PhpVal{})
	if rt.is_true(var_attribute_taxonomies) {
		mut var_max_terms_to_display := rt.call_function('apply_filters', [
			rt.new_string('woocommerce_max_terms_displayed_in_attributes_page'),
			rt.new_int(100),
		])
		mut iter_2 := var_attribute_taxonomies.iterator()
		for {
			item_2 := iter_2.next() or { break }
			mut var_tax := item_2.val
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [
				rt.call_function('wc_attribute_taxonomy_name', [
					rt.get_property(var_tax, 'attribute_name'),
				]),
			]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_html', [
				rt.get_property(var_tax, 'attribute_label'),
			]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_url', [
				rt.call_function('add_query_arg', [rt.new_string('edit'),
					rt.get_property(var_tax, 'attribute_id'),
					rt.new_string('edit.php?post_type=product&amp;page=product_attributes')]),
			]))
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('esc_html_e', [rt.new_string('Edit'),
				rt.new_string('woocommerce')])
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_url', [
				rt.call_function('wp_nonce_url', [
					rt.call_function('add_query_arg', [rt.new_string('delete'),
						rt.get_property(var_tax, 'attribute_id'),
						rt.new_string('edit.php?post_type=product&amp;page=product_attributes')]),
					rt.new_string('woocommerce-delete-attribute_' +
						(rt.get_property(var_tax, 'attribute_id')).str()),
				]),
			]))
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('esc_html_e', [rt.new_string('Delete'),
				rt.new_string('woocommerce')])
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_html', [
				rt.get_property(var_tax, 'attribute_name'),
			]))
			// unsupported statement: Stmt_InlineHTML
			if rt.is_true(rt.call_function('wc_has_custom_attribute_types', []rt.PhpVal{})) {
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_html', [
					rt.call_function('wc_get_attribute_type_label', [
						rt.get_property(var_tax, 'attribute_type'),
					]),
				]))
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(if rt.is_true(rt.get_property(var_tax, 'attribute_public')) { rt.call_function('esc_html__', [
						rt.new_string('(Public)'),
						rt.new_string('woocommerce'),
					]) } else { rt.new_string('') })
				// unsupported statement: Stmt_InlineHTML
			}
			// unsupported statement: Stmt_InlineHTML
			mut switch_val_2 := rt.get_property(var_tax, 'attribute_orderby')
			if rt.is_true(rt.equal(switch_val_2, rt.new_string('name'))) {
				rt.call_function('esc_html_e', [rt.new_string('Name'),
					rt.new_string('woocommerce')])
			} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('name_num'))) {
				rt.call_function('esc_html_e', [rt.new_string('Name (numeric)'),
					rt.new_string('woocommerce')])
			} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('id'))) {
				rt.call_function('esc_html_e', [rt.new_string('Term ID'),
					rt.new_string('woocommerce')])
			} else {
				rt.call_function('esc_html_e', [rt.new_string('Custom ordering'),
					rt.new_string('woocommerce')])
			}
			// unsupported statement: Stmt_InlineHTML
			mut var_taxonomy := rt.call_function('wc_attribute_taxonomy_name', [
				rt.get_property(var_tax, 'attribute_name'),
			])
			if rt.is_true(rt.call_function('taxonomy_exists', [
				var_taxonomy.clone()]))
			{
				mut var_total_count := rt.new_int((rt.call_function('get_terms', [
					rt.create_array([rt.ArrayItem{ key: 'taxonomy', val: var_taxonomy },
						rt.ArrayItem{ key: 'fields', val: 'count' },
						rt.ArrayItem{ key: 'hide_empty', val: false }]),
				])).to_i64())
				if rt.is_true(rt.identical(rt.new_int(0), var_total_count)) {
					print('<span class="na">&ndash;</span>')
				} else if rt.is_true(rt.greater(var_max_terms_to_display, rt.new_int(0))) {
					mut var_terms := rt.call_function('get_terms', [
						rt.create_array([
							rt.ArrayItem{ key: 'taxonomy', val: var_taxonomy },
							rt.ArrayItem{ key: 'number', val: var_max_terms_to_display },
							rt.ArrayItem{ key: 'fields', val: 'names' },
							rt.ArrayItem{ key: 'hide_empty', val: false },
						]),
					])
					mut var_terms_string := rt.call_function('implode', [
						rt.new_string(', '),
						var_terms.clone(),
					])
					if rt.is_true(rt.greater(var_total_count, var_max_terms_to_display)) {
						mut var_remaining := rt.sub(var_total_count, var_max_terms_to_display)
						var_terms_string = rt.call_function('sprintf', [
							rt.call_function('__', [rt.new_string('%1$s... (%2$s more)'),
								rt.new_string('woocommerce')]),
							var_terms_string.clone(),
							var_remaining.clone(),
						])
					}
					rt.echo_val(rt.call_function('esc_html', [
						var_terms_string.clone()]))
				} else if rt.is_true(rt.identical(rt.new_int(1), var_total_count)) {
					rt.echo_val(rt.call_function('esc_html', [
						rt.call_function('__', [rt.new_string('1 term'),
							rt.new_string('woocommerce')]),
					]))
				} else {
					rt.echo_val(rt.call_function('esc_html', [
						rt.call_function('sprintf', [
							rt.call_function('__', [rt.new_string('%s terms'),
								rt.new_string('woocommerce')]),
							var_total_count.clone(),
						]),
					]))
				}
			} else {
				print('<span class="na">&ndash;</span><br />')
			}
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [
				rt.call_function('wc_attribute_taxonomy_name', [
					rt.get_property(var_tax, 'attribute_name'),
				]),
			]))
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('esc_html_e', [rt.new_string('Configure terms'),
				rt.new_string('woocommerce')])
			// unsupported statement: Stmt_InlineHTML
		}
	} else {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('No attributes currently exist.'),
			rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Add new attribute'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [
		rt.new_string('Attributes let you define extra product data, such as size or color. You can use these attributes in the shop sidebar using the "layered nav" widgets.'),
		rt.new_string('woocommerce'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [
		rt.new_string('woocommerce_before_add_attribute_fields'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Name'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [
		rt.new_string('Name for the attribute (shown on the front-end).'),
		rt.new_string('woocommerce'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Slug'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [
		rt.new_string('Unique slug/reference for the attribute; must be no more than 28 characters.'),
		rt.new_string('woocommerce'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Enable Archives?'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [
		rt.new_string('Enable this if you want this attribute to have product archives in your store.'),
		rt.new_string('woocommerce'),
	])
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.call_function('wc_has_custom_attribute_types', []rt.PhpVal{})) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Type'),
			rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		mut iter_3 := rt.call_function('wc_get_attribute_types', []rt.PhpVal{}).iterator()
		for {
			item_3 := iter_3.next() or { break }
			mut var_value := item_3.val
			mut var_key := item_3.key
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [var_key.clone()]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_html', [var_value.clone()]))
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('do_action', [
			rt.new_string('woocommerce_admin_attribute_types'),
		])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [
			rt.new_string("Determines how this attribute's values are displayed."),
			rt.new_string('woocommerce'),
		])
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Default sort order'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Custom ordering'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Name'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Name (numeric)'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Term ID'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [
		rt.new_string('Determines the sort order of the terms on the frontend shop product pages. If using custom ordering, you can drag and drop the terms in this attribute.'),
		rt.new_string('woocommerce'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [
		rt.new_string('woocommerce_after_add_attribute_fields'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('Add attribute'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Add attribute'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('wp_nonce_field', [rt.new_string('woocommerce-add-new_attribute')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [
		rt.new_string('Are you sure you want to delete this attribute?'),
		rt.new_string('woocommerce'),
	])
	// unsupported statement: Stmt_InlineHTML
}

fn create_wc_admin_attributes(_args ...rt.PhpVal) &Class_WC_Admin_Attributes {
	mut obj := &Class_WC_Admin_Attributes{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Admin_Attributes) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'output' {
			Class_WC_Admin_Attributes.output()
			return rt.new_null()
		}
		'get_posted_attribute' {
			return Class_WC_Admin_Attributes.get_posted_attribute()
		}
		'process_add_attribute' {
			return rt.new_bool(Class_WC_Admin_Attributes.process_add_attribute())
		}
		'process_edit_attribute' {
			return rt.new_bool(Class_WC_Admin_Attributes.process_edit_attribute())
		}
		'process_delete_attribute' {
			return Class_WC_Admin_Attributes.process_delete_attribute()
		}
		'edit_attribute' {
			Class_WC_Admin_Attributes.edit_attribute()
			return rt.new_null()
		}
		'add_attribute' {
			Class_WC_Admin_Attributes.add_attribute()
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_Admin_Attributes) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Admin_Attributes) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}
