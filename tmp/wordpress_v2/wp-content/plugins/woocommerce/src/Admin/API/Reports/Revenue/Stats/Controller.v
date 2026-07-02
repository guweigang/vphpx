import rt

struct Class_Automattic_WooCommerce_Admin_API_Reports_Revenue_Stats_Controller {
	rt.PhpObjectBase
pub mut:
	rest_base rt.PhpVal = rt.new_string('reports/revenue/stats')
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Revenue_Stats_Controller) prepare_reports_query(var_request rt.PhpVal) rt.PhpVal {
	mut var_args := rt.new_array()
	var_args.array_set('before', var_request.array_get(rt.new_string('before')))
	var_args.array_set('after', var_request.array_get(rt.new_string('after')))
	var_args.array_set('interval', var_request.array_get(rt.new_string('interval')))
	var_args.array_set('page', var_request.array_get(rt.new_string('page')))
	var_args.array_set('per_page', var_request.array_get(rt.new_string('per_page')))
	var_args.array_set('orderby', var_request.array_get(rt.new_string('orderby')))
	var_args.array_set('order', var_request.array_get(rt.new_string('order')))
	var_args.array_set('segmentby', var_request.array_get(rt.new_string('segmentby')))
	var_args.array_set('fields', var_request.array_get(rt.new_string('fields')))
	var_args.array_set('force_cache_refresh',
		var_request.array_get(rt.new_string('force_cache_refresh')))
	var_args.array_set('date_type', var_request.array_get(rt.new_string('date_type')))
	return var_args.clone()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Revenue_Stats_Controller) get_datastore_data(var_query_args rt.PhpVal) rt.PhpVal {
	mut var_query :=
		create_automattic_woocommerce_admin_api_reports_revenue_query(var_query_args.clone())
	return var_query.get_data()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Revenue_Stats_Controller) get_export_items(var_request rt.PhpVal) rt.PhpVal {
	mut var_response := this.get_items(var_request.clone())
	mut var_data := rt.call_method(var_response, 'get_data', []rt.PhpVal{})
	mut var_intervals := var_data.array_get(rt.new_string('intervals'))
	rt.call_method(var_response, 'set_data', [var_intervals.clone()])
	return var_response.clone()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Revenue_Stats_Controller) prepare_item_for_response(var_report rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	mut var_response := this.Class_Automattic_WooCommerce_Admin_API_Reports_GenericStatsController.prepare_item_for_response(var_report.clone(),
		var_request.clone())
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_rest_prepare_report_revenue_stats'),
		var_response.clone(),
		var_report.clone(),
		var_request.clone(),
	])
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Revenue_Stats_Controller) get_item_properties_schema() rt.PhpVal {
	return rt.create_array([
		rt.ArrayItem{ key: 'total_sales', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Total sales.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'number' },
			rt.ArrayItem{ key: 'context', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'view' },
				rt.ArrayItem{ key: none, val: 'edit' },
			]) },
			rt.ArrayItem{ key: 'readonly', val: true },
			rt.ArrayItem{ key: 'indicator', val: true },
			rt.ArrayItem{ key: 'format', val: 'currency' },
		]) },
		rt.ArrayItem{ key: 'net_revenue', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Net sales.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'number' },
			rt.ArrayItem{ key: 'context', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'view' },
				rt.ArrayItem{ key: none, val: 'edit' },
			]) },
			rt.ArrayItem{ key: 'readonly', val: true },
			rt.ArrayItem{ key: 'indicator', val: true },
			rt.ArrayItem{ key: 'format', val: 'currency' },
		]) },
		rt.ArrayItem{ key: 'coupons', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Amount discounted by coupons.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'number' },
			rt.ArrayItem{ key: 'context', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'view' },
				rt.ArrayItem{ key: none, val: 'edit' },
			]) },
			rt.ArrayItem{ key: 'readonly', val: true },
		]) },
		rt.ArrayItem{ key: 'coupons_count', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Unique coupons count.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'number' },
			rt.ArrayItem{ key: 'context', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'view' },
				rt.ArrayItem{ key: none, val: 'edit' },
			]) },
			rt.ArrayItem{ key: 'readonly', val: true },
			rt.ArrayItem{ key: 'format', val: 'currency' },
		]) },
		rt.ArrayItem{ key: 'shipping', val: rt.create_array([
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Shipping'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Total of shipping.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'number' },
			rt.ArrayItem{ key: 'context', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'view' },
				rt.ArrayItem{ key: none, val: 'edit' },
			]) },
			rt.ArrayItem{ key: 'readonly', val: true },
			rt.ArrayItem{ key: 'indicator', val: true },
			rt.ArrayItem{ key: 'format', val: 'currency' },
		]) },
		rt.ArrayItem{ key: 'taxes', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Total of taxes.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'number' },
			rt.ArrayItem{ key: 'context', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'view' },
				rt.ArrayItem{ key: none, val: 'edit' },
			]) },
			rt.ArrayItem{ key: 'readonly', val: true },
			rt.ArrayItem{ key: 'format', val: 'currency' },
		]) },
		rt.ArrayItem{ key: 'refunds', val: rt.create_array([
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Returns'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Total of returns.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'number' },
			rt.ArrayItem{ key: 'context', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'view' },
				rt.ArrayItem{ key: none, val: 'edit' },
			]) },
			rt.ArrayItem{ key: 'readonly', val: true },
			rt.ArrayItem{ key: 'indicator', val: true },
			rt.ArrayItem{ key: 'format', val: 'currency' },
		]) },
		rt.ArrayItem{ key: 'orders_count', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Number of orders.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'integer' },
			rt.ArrayItem{ key: 'context', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'view' },
				rt.ArrayItem{ key: none, val: 'edit' },
			]) },
			rt.ArrayItem{ key: 'readonly', val: true },
		]) },
		rt.ArrayItem{ key: 'num_items_sold', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Items sold.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'integer' },
			rt.ArrayItem{ key: 'context', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'view' },
				rt.ArrayItem{ key: none, val: 'edit' },
			]) },
			rt.ArrayItem{ key: 'readonly', val: true },
		]) },
		rt.ArrayItem{ key: 'gross_sales', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Gross sales.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'number' },
			rt.ArrayItem{ key: 'context', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'view' },
				rt.ArrayItem{ key: none, val: 'edit' },
			]) },
			rt.ArrayItem{ key: 'readonly', val: true },
			rt.ArrayItem{ key: 'indicator', val: true },
			rt.ArrayItem{ key: 'format', val: 'currency' },
		]) },
	])
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Revenue_Stats_Controller) get_item_schema() rt.PhpVal {
	mut var_schema :=
		this.Class_Automattic_WooCommerce_Admin_API_Reports_GenericStatsController.get_item_schema()
	var_schema.array_set('title', 'report_revenue_stats')
	var_schema.array_get_mut('properties').array_get_mut('totals').array_get_mut('properties').array_set('products', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Products sold.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'integer' },
		rt.ArrayItem{ key: 'context', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'view' },
			rt.ArrayItem{ key: none, val: 'edit' },
		]) },
		rt.ArrayItem{ key: 'readonly', val: true },
	]))
	return this.add_additional_fields_schema(var_schema.clone())
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Revenue_Stats_Controller) get_collection_params() rt.PhpVal {
	mut var_params :=
		this.Class_Automattic_WooCommerce_Admin_API_Reports_GenericStatsController.get_collection_params()
	var_params.array_get_mut('orderby').array_set('enum', this.apply_custom_orderby_filters(rt.create_array([
		rt.ArrayItem{ key: none, val: 'date' },
		rt.ArrayItem{ key: none, val: 'total_sales' },
		rt.ArrayItem{ key: none, val: 'coupons' },
		rt.ArrayItem{ key: none, val: 'refunds' },
		rt.ArrayItem{ key: none, val: 'shipping' },
		rt.ArrayItem{ key: none, val: 'taxes' },
		rt.ArrayItem{ key: none, val: 'net_revenue' },
		rt.ArrayItem{ key: none, val: 'orders_count' },
		rt.ArrayItem{ key: none, val: 'items_sold' },
		rt.ArrayItem{ key: none, val: 'gross_sales' },
	])))
	var_params.array_set('segmentby', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Segment the response by additional constraint.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'string' },
		rt.ArrayItem{ key: 'enum', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'product' },
			rt.ArrayItem{ key: none, val: 'category' },
			rt.ArrayItem{ key: none, val: 'variation' },
			rt.ArrayItem{ key: none, val: 'coupon' },
			rt.ArrayItem{ key: none, val: 'customer_type' },
		]) },
		rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' },
	]))
	var_params.array_set('date_type', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Override the "woocommerce_date_type" option that is used for the database date field considered for revenue reports.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'string' },
		rt.ArrayItem{ key: 'enum', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'date_paid' },
			rt.ArrayItem{ key: none, val: 'date_created' },
			rt.ArrayItem{ key: none, val: 'date_completed' },
		]) },
		rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' },
	]))
	var_params.array_unset(rt.new_string('fields'))
	return var_params.clone()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Revenue_Stats_Controller) get_export_columns() rt.PhpVal {
	mut var_export_columns := rt.create_array([
		rt.ArrayItem{ key: 'date', val: rt.call_function('__', [
			rt.new_string('Date'), rt.new_string('woocommerce')]) },
		rt.ArrayItem{ key: 'orders_count', val: rt.call_function('__', [
			rt.new_string('Orders'), rt.new_string('woocommerce')]) },
		rt.ArrayItem{ key: 'gross_sales', val: rt.call_function('__', [
			rt.new_string('Gross sales'), rt.new_string('woocommerce')]) },
		rt.ArrayItem{ key: 'refunds', val: rt.call_function('__', [
			rt.new_string('Returns'), rt.new_string('woocommerce')]) },
		rt.ArrayItem{ key: 'coupons', val: rt.call_function('__', [
			rt.new_string('Coupons'), rt.new_string('woocommerce')]) },
		rt.ArrayItem{ key: 'net_revenue', val: rt.call_function('__', [
			rt.new_string('Net sales'), rt.new_string('woocommerce')]) },
		rt.ArrayItem{ key: 'taxes', val: rt.call_function('__', [
			rt.new_string('Taxes'), rt.new_string('woocommerce')]) },
		rt.ArrayItem{ key: 'shipping', val: rt.call_function('__', [
			rt.new_string('Shipping'), rt.new_string('woocommerce')]) },
		rt.ArrayItem{ key: 'total_sales', val: rt.call_function('__', [
			rt.new_string('Total sales'), rt.new_string('woocommerce')]) },
	])
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_report_revenue_stats_export_columns'),
		var_export_columns.clone(),
	])
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Revenue_Stats_Controller) prepare_item_for_export(var_item rt.PhpVal) rt.PhpVal {
	mut var_subtotals := rt.cast_array(var_item.array_get(rt.new_string('subtotals')))
	mut iife_temp_0 := Class_Automattic_WooCommerce_Admin_API_Reports_Revenue_Stats_Controller{}
	mut iife_result_0 :=
		iife_temp_0.csv_number_format(var_subtotals.array_get(rt.new_string('gross_sales')))
	mut iife_temp_1 := Class_Automattic_WooCommerce_Admin_API_Reports_Revenue_Stats_Controller{}
	mut iife_result_1 :=
		iife_temp_1.csv_number_format(var_subtotals.array_get(rt.new_string('refunds')))
	mut iife_temp_2 := Class_Automattic_WooCommerce_Admin_API_Reports_Revenue_Stats_Controller{}
	mut iife_result_2 :=
		iife_temp_2.csv_number_format(var_subtotals.array_get(rt.new_string('coupons')))
	mut iife_temp_3 := Class_Automattic_WooCommerce_Admin_API_Reports_Revenue_Stats_Controller{}
	mut iife_result_3 :=
		iife_temp_3.csv_number_format(var_subtotals.array_get(rt.new_string('net_revenue')))
	mut iife_temp_4 := Class_Automattic_WooCommerce_Admin_API_Reports_Revenue_Stats_Controller{}
	mut iife_result_4 :=
		iife_temp_4.csv_number_format(var_subtotals.array_get(rt.new_string('taxes')))
	mut iife_temp_5 := Class_Automattic_WooCommerce_Admin_API_Reports_Revenue_Stats_Controller{}
	mut iife_result_5 :=
		iife_temp_5.csv_number_format(var_subtotals.array_get(rt.new_string('shipping')))
	mut iife_temp_6 := Class_Automattic_WooCommerce_Admin_API_Reports_Revenue_Stats_Controller{}
	mut iife_result_6 :=
		iife_temp_6.csv_number_format(var_subtotals.array_get(rt.new_string('total_sales')))
	mut var_export_item := rt.create_array([
		rt.ArrayItem{ key: 'date', val: var_item.array_get(rt.new_string('date_start')) },
		rt.ArrayItem{
			key: 'orders_count'
			val: var_subtotals.array_get(rt.new_string('orders_count'))
		},
		rt.ArrayItem{ key: 'gross_sales', val: iife_result_0 },
		rt.ArrayItem{ key: 'refunds', val: iife_result_1 },
		rt.ArrayItem{ key: 'coupons', val: iife_result_2 },
		rt.ArrayItem{ key: 'net_revenue', val: iife_result_3 },
		rt.ArrayItem{ key: 'taxes', val: iife_result_4 },
		rt.ArrayItem{ key: 'shipping', val: iife_result_5 },
		rt.ArrayItem{ key: 'total_sales', val: iife_result_6 },
	])
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_report_revenue_stats_prepare_export_item'),
		var_export_item.clone(),
		var_item.clone(),
	])
}

struct Class_Automattic_WooCommerce_Admin_API_Reports_GenericStatsController {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_API_Reports_Revenue_Query {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_api_reports_revenue_stats_controller(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_API_Reports_Revenue_Stats_Controller {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_Revenue_Stats_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
		rest_base:     rt.new_string('reports/revenue/stats')
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_reports_genericstatscontroller(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_API_Reports_GenericStatsController {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_GenericStatsController{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_reports_revenue_query(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_API_Reports_Revenue_Query {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_Revenue_Query{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Revenue_Stats_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'prepare_reports_query' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.prepare_reports_query(dispatch_arg_0)
		}
		'get_datastore_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_datastore_data(dispatch_arg_0)
		}
		'get_export_items' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_export_items(dispatch_arg_0)
		}
		'prepare_item_for_response' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.prepare_item_for_response(dispatch_arg_0, dispatch_arg_1)
		}
		'get_item_properties_schema' {
			return this.get_item_properties_schema()
		}
		'get_item_schema' {
			return this.get_item_schema()
		}
		'get_collection_params' {
			return this.get_collection_params()
		}
		'get_export_columns' {
			return this.get_export_columns()
		}
		'prepare_item_for_export' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.prepare_item_for_export(dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_API_Reports_Revenue_Stats_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'rest_base' { return this.rest_base }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Revenue_Stats_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'rest_base' {
			this.rest_base = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_GenericStatsController) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_API_Reports_GenericStatsController) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_GenericStatsController) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Revenue_Query) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_API_Reports_Revenue_Query) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Revenue_Query) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}
