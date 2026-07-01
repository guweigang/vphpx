import rt

struct Class_WC_Report_Stock {
	rt.PhpObjectBase
pub mut:
		max_items rt.PhpVal = rt.new_null()
}

fn (mut this Class_WC_Report_Stock) construct()  {
	this.Class_WP_List_Table.construct(rt.create_array([rt.ArrayItem{ key: 'singular', val: 'stock' }, rt.ArrayItem{ key: 'plural', val: 'stock' }, rt.ArrayItem{ key: 'ajax', val: false }]))
}

fn (mut this Class_WC_Report_Stock) no_items()  {
	rt.call_function('_e', [rt.new_string('No products found.'), rt.new_string('woocommerce')])
}

fn (mut this Class_WC_Report_Stock) display_tablenav(var_position rt.PhpVal)  {
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		this.Class_WP_List_Table.display_tablenav(var_position.dup())
	}
}

fn (mut this Class_WC_Report_Stock) output_report()  {
	this.prepare_items()
	print('<div id="poststuff" class="woocommerce-reports-wide">')
	this.display()
	print('</div>')
}

fn (mut this Class_WC_Report_Stock) column_default(var_item rt.PhpVal, var_column_name rt.PhpVal)  {
	// unsupported statement: Stmt_Global
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_product)))) || rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		mut var_product := rt.call_function('wc_get_product', [rt.get_property(var_item, 'id')])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_product)))) {
		return rt.new_null()
	}
	mut switch_val_1 := var_column_name
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('product'))) {
		if rt.is_true(mut var_sku := rt.call_method(var_product, 'get_sku', []rt.PhpVal{})) {
			print((rt.call_function('esc_html', [var_sku.dup()])).str() + ' - ')
		}
		rt.echo_val(rt.call_function('esc_html', [rt.call_method(var_product, 'get_name', []rt.PhpVal{})]))
		if rt.is_true(rt.call_method(var_product, 'is_type', [Class_Automattic_WooCommerce_Enums_ProductType.variation()])) {
			print('<div class="description">' + (rt.call_function('wp_kses_post', [rt.call_function('wc_get_formatted_variation', [var_product.dup(), rt.new_bool(true)])])).str() + '</div>')
		}
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('parent'))) {
		if rt.is_true(rt.get_property(var_item, 'parent')) {
			rt.echo_val(rt.call_function('esc_html', [rt.call_function('get_the_title', [rt.get_property(var_item, 'parent')])]))
		} else {
			print('-')
		}
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('stock_status'))) {
		if rt.is_true(rt.call_method(var_product, 'is_on_backorder', []rt.PhpVal{})) {
			mut var_stock_html := rt.new_string('<mark class="onbackorder">' + (rt.call_function('__', [rt.new_string('On backorder'), rt.new_string('woocommerce')])).str() + '</mark>')
		} else if rt.is_true(rt.call_method(var_product, 'is_in_stock', []rt.PhpVal{})) {
			var_stock_html = rt.new_string('<mark class="instock">' + (rt.call_function('__', [rt.new_string('In stock'), rt.new_string('woocommerce')])).str() + '</mark>')
		} else {
			var_stock_html = rt.new_string('<mark class="outofstock">' + (rt.call_function('__', [rt.new_string('Out of stock'), rt.new_string('woocommerce')])).str() + '</mark>')
		}
		rt.echo_val(rt.call_function('apply_filters', [rt.new_string('woocommerce_admin_stock_html'), var_stock_html.dup(), var_product.dup()]))
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('stock_level'))) {
		rt.echo_val(rt.call_function('esc_html', [rt.call_method(var_product, 'get_stock_quantity', []rt.PhpVal{})]))
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('wc_actions'))) {
		// unsupported statement: Stmt_InlineHTML
		mut var_actions := rt.new_array()
		mut var_action_id := if rt.is_true(rt.call_method(var_product, 'is_type', [Class_Automattic_WooCommerce_Enums_ProductType.variation()])) { rt.get_property(var_item, 'parent') } else { rt.get_property(var_item, 'id') }
		var_actions.array_set('edit', rt.create_array([rt.ArrayItem{ key: 'url', val: rt.call_function('admin_url', ['post.php?post=' + (var_action_id).str() + '&action=edit']) }, rt.ArrayItem{ key: 'name', val: rt.call_function('__', [rt.new_string('Edit'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'action', val: 'edit' }]))
		if rt.is_true(rt.call_method(var_product, 'is_visible', []rt.PhpVal{})) {
			var_actions.array_set('view', rt.create_array([rt.ArrayItem{ key: 'url', val: rt.call_function('get_permalink', [var_action_id.dup()]) }, rt.ArrayItem{ key: 'name', val: rt.call_function('__', [rt.new_string('View'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'action', val: 'view' }]))
		}
		var_actions = rt.call_function('apply_filters', [rt.new_string('woocommerce_admin_stock_report_product_actions'), var_actions.dup(), var_product.dup()])
		{
			mut iter_1 := var_actions.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_action := item_1.val
				rt.call_function('printf', [rt.new_string('<a class="button tips %1$s" href="%2$s" data-tip="%3$s">%4$s</a>'), rt.call_function('esc_attr', [var_action.array_get('action')]), rt.call_function('esc_url', [var_action.array_get('url')]), rt.call_function('sprintf', [rt.call_function('esc_attr__', [rt.new_string('%s product'), rt.new_string('woocommerce')]), var_action.array_get('name')]), rt.call_function('esc_html', [var_action.array_get('name')])])
			}
		}
		// unsupported statement: Stmt_InlineHTML
	}
}

fn (mut this Class_WC_Report_Stock) get_columns() rt.PhpVal {
	mut var_columns := { 'product': rt.call_function('__', [rt.new_string('Product'), rt.new_string('woocommerce')]), 'parent': rt.call_function('__', [rt.new_string('Parent'), rt.new_string('woocommerce')]), 'stock_level': rt.call_function('__', [rt.new_string('Units in stock'), rt.new_string('woocommerce')]), 'stock_status': rt.call_function('__', [rt.new_string('Stock status'), rt.new_string('woocommerce')]), 'wc_actions': rt.call_function('__', [rt.new_string('Actions'), rt.new_string('woocommerce')]) }
	return var_columns.dup()
}

fn (mut this Class_WC_Report_Stock) prepare_items()  {
	this.dispatch_set_prop('_column_headers', rt.create_array([rt.ArrayItem{ key: none, val: this.get_columns() }, rt.ArrayItem{ key: none, val: rt.new_array() }, rt.ArrayItem{ key: none, val: this.get_sortable_columns() }]))
	mut var_current_page := rt.call_function('absint', [this.get_pagenum()])
	mut var_per_page := rt.call_function('apply_filters', [rt.new_string('woocommerce_admin_stock_report_products_per_page'), rt.new_int(20)])
	this.get_items(var_current_page.dup(), var_per_page.dup())
	this.set_pagination_args(rt.create_array([rt.ArrayItem{ key: 'total_items', val: this.max_items }, rt.ArrayItem{ key: 'per_page', val: var_per_page }, rt.ArrayItem{ key: 'total_pages', val: rt.call_function('ceil', [rt.div(this.max_items, var_per_page)]) }]))
}

struct Class_WP_List_Table {
	rt.PhpObjectBase
}

fn create_wc_report_stock() &Class_WC_Report_Stock {
	mut obj := &Class_WC_Report_Stock{
		PhpObjectBase: rt.PhpObjectBase{}
		max_items: rt.new_null()
	}
	obj.construct()
	return obj
}

fn create_wp_list_table() &Class_WP_List_Table {
	mut obj := &Class_WP_List_Table{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Report_Stock) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'no_items' {
			this.no_items()
			return rt.new_null()
		}
		'display_tablenav' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.display_tablenav(dispatch_arg_0)
			return rt.new_null()
		}
		'output_report' {
			this.output_report()
			return rt.new_null()
		}
		'column_default' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.column_default(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'get_columns' {
			return this.get_columns()
		}
		'prepare_items' {
			this.prepare_items()
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_WC_Report_Stock) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'max_items' { return this.max_items }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_Report_Stock) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'max_items' { this.max_items = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_WP_List_Table) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_List_Table) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_List_Table) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_includes_admin_reports_class_wc_report_stock_php() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))))) {
		// unsupported expression: Expr_Exit
		// unsupported statement: Stmt_Nop
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [rt.new_string('WP_List_Table')]))))) {
		rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/class-wp-list-table.php', '4')
	}
}
