import rt

pub fn Class_Automattic_WooCommerce_Internal_Admin_Notes_NewSalesRecord.note_name() string {
	return 'wc-admin-new-sales-record'
}

pub fn Class_Automattic_WooCommerce_Internal_Admin_Notes_NewSalesRecord.record_date_option_key() string {
	return 'woocommerce_sales_record_date'
}

pub fn Class_Automattic_WooCommerce_Internal_Admin_Notes_NewSalesRecord.record_amount_option_key() string {
	return 'woocommerce_sales_record_amount'
}

struct Class_Automattic_WooCommerce_Internal_Admin_Notes_NewSalesRecord {
	rt.PhpObjectBase
}

fn Class_Automattic_WooCommerce_Internal_Admin_Notes_NewSalesRecord.sum_sales_for_date(var_date rt.PhpVal) rt.PhpVal {
	mut var_order_query := create_automattic_woocommerce_internal_admin_notes_wc_order_query(rt.create_array([
		rt.ArrayItem{ key: 'date_created', val: var_date },
	]))
	mut var_orders := var_order_query.get_orders()
	mut var_total := rt.new_int(0)
	mut iter_1 := rt.cast_array(var_orders).iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_order := item_1.val
		var_total = rt.add(var_total, rt.call_method(var_order, 'get_total', []rt.PhpVal{}))
	}
	return var_total.clone()
}

fn Class_Automattic_WooCommerce_Internal_Admin_Notes_NewSalesRecord.possibly_add_note() {
	mut var_sales_record_notes_enabled := rt.call_function('apply_filters', [
		rt.new_string('woocommerce_admin_sales_record_milestone_enabled'),
		rt.new_bool(true),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_sales_record_notes_enabled)))) {
		return
	}
	mut var_yesterday := rt.call_function('gmdate', [rt.new_string('Y-m-d'),
		rt.sub(rt.call_function('current_time', [rt.new_string('timestamp'),
			rt.new_int(0)]), rt.get_constant('DAY_IN_SECONDS'))])
	mut var_total :=
		Class_Automattic_WooCommerce_Internal_Admin_Notes_NewSalesRecord.sum_sales_for_date(var_yesterday.clone())
	if rt.is_true(rt.greater_equal(rt.new_int(0), var_total)) {
		return
	}
	mut var_record_date := rt.call_function('get_option', [
		Class_Automattic_WooCommerce_Internal_Admin_Notes_Automattic_WooCommerce_Internal_Admin_Notes_NewSalesRecord.record_date_option_key(),
		rt.new_string(''),
	])
	mut var_record_amt := rt.new_float(rt.call_function('get_option', [
		Class_Automattic_WooCommerce_Internal_Admin_Notes_Automattic_WooCommerce_Internal_Admin_Notes_NewSalesRecord.record_amount_option_key(),
		rt.new_int(0),
	]).to_f64())
	if !rt.is_true(var_record_date) {
		rt.call_function('update_option', [
			Class_Automattic_WooCommerce_Internal_Admin_Notes_Automattic_WooCommerce_Internal_Admin_Notes_NewSalesRecord.record_date_option_key(),
			var_yesterday.clone(),
		])
		rt.call_function('update_option', [
			Class_Automattic_WooCommerce_Internal_Admin_Notes_Automattic_WooCommerce_Internal_Admin_Notes_NewSalesRecord.record_amount_option_key(),
			var_total.clone(),
		])
		return
	}
	if rt.is_true(rt.greater(var_total, var_record_amt)) {
		rt.call_function('update_option', [
			Class_Automattic_WooCommerce_Internal_Admin_Notes_Automattic_WooCommerce_Internal_Admin_Notes_NewSalesRecord.record_date_option_key(),
			var_yesterday.clone(),
		])
		rt.call_function('update_option', [
			Class_Automattic_WooCommerce_Internal_Admin_Notes_Automattic_WooCommerce_Internal_Admin_Notes_NewSalesRecord.record_amount_option_key(),
			var_total.clone(),
		])
		mut iife_temp_0 := Class_Automattic_WooCommerce_Admin_Notes_Notes{}
		mut iife_result_0 :=
			iife_temp_0.delete_notes_with_name(Class_Automattic_WooCommerce_Internal_Admin_Notes_Automattic_WooCommerce_Internal_Admin_Notes_NewSalesRecord.note_name())
		mut var_note := Class_Automattic_WooCommerce_Internal_Admin_Notes_NewSalesRecord.get_note_with_record_data(var_record_date.clone(),
			var_record_amt.clone(), var_yesterday.clone(), var_total.clone())
		rt.call_method(var_note, 'save', []rt.PhpVal{})
	}
}

fn Class_Automattic_WooCommerce_Internal_Admin_Notes_NewSalesRecord.get_note_with_record_data(var_record_date rt.PhpVal, var_record_amt rt.PhpVal, var_yesterday rt.PhpVal, var_total rt.PhpVal) rt.PhpVal {
	mut var_record_date_mutated := var_record_date
	mut var_record_amt_mutated := var_record_amt
	mut var_yesterday_mutated := var_yesterday
	mut var_total_mutated := var_total
	if rt.is_true(rt.identical(rt.call_function('substr', [
		rt.call_function('get_user_locale', []rt.PhpVal{}),
		rt.new_int(0),
		rt.new_int(2),
	]), rt.new_string('en')))
	{
		mut var_date_format := rt.new_string('F jS')
	} else {
		var_date_format = rt.call_function('get_option', [rt.new_string('date_format')])
	}
	mut var_formatted_yesterday := rt.call_function('date_i18n', [
		var_date_format.clone(), rt.call_function('strtotime', [
			var_yesterday_mutated.clone()])])
	mut var_formatted_total := rt.call_function('html_entity_decode', [
		rt.call_function('wp_strip_all_tags', [
			rt.call_function('wc_price', [var_total_mutated.clone()]),
		]),
	])
	mut var_formatted_record_date := rt.call_function('date_i18n', [
		var_date_format.clone(), rt.call_function('strtotime', [
			var_record_date_mutated.clone()])])
	mut var_formatted_record_amt := rt.call_function('html_entity_decode', [
		rt.call_function('wp_strip_all_tags', [
			rt.call_function('wc_price', [var_record_amt_mutated.clone()]),
		]),
	])
	mut var_content := rt.call_function('sprintf', [
		rt.call_function('__', [
			rt.new_string('Woohoo, %1$s was your record day for sales! Net sales was %2$s beating the previous record of %3$s set on %4$s.'),
			rt.new_string('woocommerce'),
		]),
		var_formatted_yesterday.clone(),
		var_formatted_total.clone(),
		var_formatted_record_amt.clone(),
		var_formatted_record_date.clone(),
	])
	mut var_content_data := rt.array_to_object(rt.create_array([
		rt.ArrayItem{ key: 'old_record_date', val: var_record_date_mutated },
		rt.ArrayItem{ key: 'old_record_amt', val: var_record_amt_mutated },
		rt.ArrayItem{ key: 'new_record_date', val: var_yesterday_mutated },
		rt.ArrayItem{ key: 'new_record_amt', val: var_total_mutated },
	]))
	mut var_report_url := rt.new_string(
		'?page=wc-admin&path=/analytics/revenue&period=custom&compare=previous_year&after=' +
		var_yesterday_mutated.str() + '&before=' + var_yesterday_mutated.str())
	mut var_note := create_automattic_woocommerce_admin_notes_note()
	rt.call_method(var_note, 'set_title', [
		rt.call_function('__', [rt.new_string('New sales record!'),
			rt.new_string('woocommerce')]),
	])
	rt.call_method(var_note, 'set_content', [var_content.clone()])
	rt.call_method(var_note, 'set_content_data', [var_content_data.clone()])
	rt.call_method(var_note, 'set_type', [
		Class_Automattic_WooCommerce_Admin_Notes_Note.e_wc_admin_note_informational(),
	])
	rt.call_method(var_note, 'set_name', [
		Class_Automattic_WooCommerce_Internal_Admin_Notes_Automattic_WooCommerce_Internal_Admin_Notes_NewSalesRecord.note_name(),
	])
	rt.call_method(var_note, 'set_source', [rt.new_string('woocommerce-admin')])
	rt.call_method(var_note, 'add_action', [rt.new_string('view-report'),
		rt.call_function('__', [rt.new_string('View report'),
			rt.new_string('woocommerce')]),
		var_report_url.clone()])
	return var_note.clone()
}

fn Class_Automattic_WooCommerce_Internal_Admin_Notes_NewSalesRecord.get_note() bool {
	mut iife_temp_1 := Class_Automattic_WooCommerce_Admin_Notes_Notes{}
	mut iife_result_1 :=
		iife_temp_1.get_note_by_name(Class_Automattic_WooCommerce_Internal_Admin_Notes_Automattic_WooCommerce_Internal_Admin_Notes_NewSalesRecord.note_name())
	mut var_note := iife_result_1
	if rt.is_true(rt.new_bool(!(rt.is_true(var_note)))) {
		return false
	}
	mut var_content_data := rt.call_method(var_note, 'get_content_data', []rt.PhpVal{})
	return (Class_Automattic_WooCommerce_Internal_Admin_Notes_NewSalesRecord.get_note_with_record_data(rt.get_property(var_content_data,
		'old_record_date'), rt.get_property(var_content_data, 'old_record_amt'), rt.get_property(var_content_data,
		'new_record_date'), rt.get_property(var_content_data, 'new_record_amt'))).to_bool()
}

struct Class_Automattic_WooCommerce_Internal_Admin_Notes_WC_Order_Query {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_Notes_Notes {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_Notes_Note {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_admin_notes_newsalesrecord(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_Notes_NewSalesRecord {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Notes_NewSalesRecord{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_notes_wc_order_query(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_Notes_WC_Order_Query {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Notes_WC_Order_Query{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_notes_notes(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Notes_Notes {
	mut obj := &Class_Automattic_WooCommerce_Admin_Notes_Notes{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_notes_note(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Notes_Note {
	mut obj := &Class_Automattic_WooCommerce_Admin_Notes_Note{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Notes_NewSalesRecord) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'sum_sales_for_date' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Internal_Admin_Notes_NewSalesRecord.sum_sales_for_date(dispatch_arg_0)
		}
		'possibly_add_note' {
			Class_Automattic_WooCommerce_Internal_Admin_Notes_NewSalesRecord.possibly_add_note()
			return rt.new_null()
		}
		'get_note_with_record_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Internal_Admin_Notes_NewSalesRecord.get_note_with_record_data(dispatch_arg_0,
				dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
		}
		'get_note' {
			return rt.new_bool(Class_Automattic_WooCommerce_Internal_Admin_Notes_NewSalesRecord.get_note())
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Notes_NewSalesRecord) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Notes_NewSalesRecord) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Notes_WC_Order_Query) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Notes_WC_Order_Query) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Notes_WC_Order_Query) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Notes_Notes) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Notes_Notes) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Notes_Notes) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Notes_Note) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Notes_Note) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Notes_Note) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}
