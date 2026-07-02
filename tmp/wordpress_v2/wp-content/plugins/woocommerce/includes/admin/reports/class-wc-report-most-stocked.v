import rt

struct Class_WC_Report_Most_Stocked {
	rt.PhpObjectBase
}

fn (mut this Class_WC_Report_Most_Stocked) get_items(var_current_page rt.PhpVal, var_per_page rt.PhpVal) {
	mut var_wpdb := rt.new_null()
	this.dispatch_set_prop('max_items', rt.new_int(0))
	this.dispatch_set_prop('items', rt.new_array())
	mut var_stock := rt.call_function('absint', [
		rt.call_function('max', [
			rt.call_function('get_option', [
				rt.new_string('woocommerce_notify_low_stock_amount'),
			]),
			rt.new_int(0),
		]),
	])
	mut var_query_from := rt.call_function('apply_filters', [
		rt.new_string('woocommerce_report_most_stocked_query_from'),
		rt.call_method(var_wpdb, 'prepare', [
			rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('\n\t\t\t\tFROM '), rt.get_property(var_wpdb,
				'posts')), rt.new_string(' as posts\n\t\t\t\tINNER JOIN ')), rt.get_property(var_wpdb,
				'wc_product_meta_lookup')),
				rt.new_string(" AS lookup ON posts.ID = lookup.product_id\n\t\t\t\tWHERE 1=1\n\t\t\t\tAND posts.post_type IN ( 'product', 'product_variation' )\n\t\t\t\tAND posts.post_status = 'publish'\n\t\t\t\tAND lookup.stock_quantity > %d\n\t\t\t\t")),
			var_stock.clone(),
		]),
	])
	this.dispatch_set_prop('items', rt.call_method(var_wpdb, 'get_results', [
		rt.call_method(var_wpdb, 'prepare', [
			rt.new_string('SELECT SQL_CALC_FOUND_ROWS posts.ID as id, posts.post_parent as parent ${var_query_from.to_string()} ORDER BY lookup.stock_quantity DESC, id ASC LIMIT %d, %d;'),
			rt.mul(rt.sub(var_current_page, rt.new_int(1)), var_per_page),
			var_per_page.clone(),
		]),
	]))
	this.dispatch_set_prop('max_items', rt.call_method(var_wpdb, 'get_var', [
		rt.new_string('SELECT FOUND_ROWS();'),
	]))
}

struct Class_WC_Report_Stock {
	rt.PhpObjectBase
}

fn create_wc_report_most_stocked(_args ...rt.PhpVal) &Class_WC_Report_Most_Stocked {
	mut obj := &Class_WC_Report_Most_Stocked{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_report_stock(_args ...rt.PhpVal) &Class_WC_Report_Stock {
	mut obj := &Class_WC_Report_Stock{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Report_Most_Stocked) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_items' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.get_items(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_Report_Most_Stocked) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Report_Most_Stocked) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_Report_Stock) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Report_Stock) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Report_Stock) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [
		rt.new_string('WC_Report_Stock'),
	])))))
	{
		rt.include_file((rt.call_function('dirname', [rt.new_string(@FILE)])).str() +
			'/class-wc-report-stock.php', '4')
	}
}
