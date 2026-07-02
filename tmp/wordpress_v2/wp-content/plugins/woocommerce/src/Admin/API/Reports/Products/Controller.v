import rt

struct Class_Automattic_WooCommerce_Admin_API_Reports_Products_Controller {
	rt.PhpObjectBase
pub mut:
	rest_base     rt.PhpVal = rt.new_string('reports/products')
	param_mapping rt.PhpVal = rt.new_array()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Products_Controller) get_datastore_data(var_query_args rt.PhpVal) rt.PhpVal {
	mut var_query := create_automattic_woocommerce_admin_api_reports_genericquery(var_query_args.clone(),
		rt.new_string('products'))
	return var_query.get_data()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Products_Controller) prepare_item_for_response(var_report rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	mut var_response := this.Class_Automattic_WooCommerce_Admin_API_Reports_GenericController.prepare_item_for_response(var_report.clone(),
		var_request.clone())
	rt.call_method(var_response, 'add_links', [this.prepare_links(var_report.clone())])
	mut var_filtered_response := rt.call_function('apply_filters', [
		rt.new_string('woocommerce_rest_prepare_report_products'),
		var_response.clone(),
		var_report.clone(),
		var_request.clone(),
	])
	if rt.get_property(var_filtered_response, 'data').array_get(rt.new_string('extended_info')).array_isset(rt.new_string('name')) {
		rt.get_property(var_filtered_response, 'data').array_get_mut('extended_info').array_set('name', rt.call_function('wp_strip_all_tags', [
			rt.get_property(var_filtered_response, 'data').array_get(rt.new_string('extended_info')).array_get(rt.new_string('name')),
		]))
	}
	return var_filtered_response.clone()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Products_Controller) prepare_reports_query(var_request rt.PhpVal) rt.PhpVal {
	mut var_args := rt.new_array()
	mut var_registered := rt.func_array_keys(this.get_collection_params())
	mut iter_1 := var_registered.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_param_name := item_1.val
		if var_request.array_isset(var_param_name) {
			if this.param_mapping.array_isset(var_param_name) {
				var_args.array_set(this.param_mapping.array_get(var_param_name),
					var_request.array_get(var_param_name))
			} else {
				var_args.array_set(var_param_name, var_request.array_get(var_param_name))
			}
		}
	}
	return var_args.clone()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Products_Controller) prepare_links(var_object rt.PhpVal) rt.PhpVal {
	mut var_links := rt.create_array([
		rt.ArrayItem{ key: 'product', val: rt.create_array([
			rt.ArrayItem{ key: 'href', val: rt.call_function('rest_url', [
				rt.call_function('sprintf', [rt.new_string('/%s/%s/%d'),
					rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_Reports_Products_Controller', [
						'Automattic_WooCommerce_Admin_API_Reports_GenericController',
						'ExportableInterface',
					], &this), 'namespace'),
					rt.new_string('products'), var_object.array_get(rt.new_string('product_id'))]),
			]) },
		]) },
	])
	return var_links.clone()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Products_Controller) get_item_schema() rt.PhpVal {
	mut var_schema := rt.create_array([
		rt.ArrayItem{ key: '$schema', val: 'http://json-schema.org/draft-04/schema#' },
		rt.ArrayItem{ key: 'title', val: 'report_products' },
		rt.ArrayItem{ key: 'type', val: 'object' },
		rt.ArrayItem{ key: 'properties', val: rt.create_array([
			rt.ArrayItem{ key: 'product_id', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'integer' },
				rt.ArrayItem{ key: 'readonly', val: true },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Product ID.'),
					rt.new_string('woocommerce'),
				]) },
			]) },
			rt.ArrayItem{ key: 'items_sold', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'integer' },
				rt.ArrayItem{ key: 'readonly', val: true },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Number of items sold.'),
					rt.new_string('woocommerce'),
				]) },
			]) },
			rt.ArrayItem{ key: 'net_revenue', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'number' },
				rt.ArrayItem{ key: 'readonly', val: true },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Total Net sales of all items sold.'),
					rt.new_string('woocommerce'),
				]) },
			]) },
			rt.ArrayItem{ key: 'orders_count', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'integer' },
				rt.ArrayItem{ key: 'readonly', val: true },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Number of orders product appeared in.'),
					rt.new_string('woocommerce'),
				]) },
			]) },
			rt.ArrayItem{ key: 'extended_info', val: rt.create_array([
				rt.ArrayItem{ key: 'name', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'readonly', val: true },
					rt.ArrayItem{ key: 'context', val: rt.create_array([
						rt.ArrayItem{ key: none, val: 'view' },
						rt.ArrayItem{ key: none, val: 'edit' },
					]) },
					rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
						rt.new_string('Product name.'),
						rt.new_string('woocommerce'),
					]) },
				]) },
				rt.ArrayItem{ key: 'price', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'number' },
					rt.ArrayItem{ key: 'readonly', val: true },
					rt.ArrayItem{ key: 'context', val: rt.create_array([
						rt.ArrayItem{ key: none, val: 'view' },
						rt.ArrayItem{ key: none, val: 'edit' },
					]) },
					rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
						rt.new_string('Product price.'),
						rt.new_string('woocommerce'),
					]) },
				]) },
				rt.ArrayItem{ key: 'image', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'readonly', val: true },
					rt.ArrayItem{ key: 'context', val: rt.create_array([
						rt.ArrayItem{ key: none, val: 'view' },
						rt.ArrayItem{ key: none, val: 'edit' },
					]) },
					rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
						rt.new_string('Product image.'),
						rt.new_string('woocommerce'),
					]) },
				]) },
				rt.ArrayItem{ key: 'permalink', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'readonly', val: true },
					rt.ArrayItem{ key: 'context', val: rt.create_array([
						rt.ArrayItem{ key: none, val: 'view' },
						rt.ArrayItem{ key: none, val: 'edit' },
					]) },
					rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
						rt.new_string('Product link.'),
						rt.new_string('woocommerce'),
					]) },
				]) },
				rt.ArrayItem{ key: 'category_ids', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'array' },
					rt.ArrayItem{ key: 'readonly', val: true },
					rt.ArrayItem{ key: 'context', val: rt.create_array([
						rt.ArrayItem{ key: none, val: 'view' },
						rt.ArrayItem{ key: none, val: 'edit' },
					]) },
					rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
						rt.new_string('Product category IDs.'),
						rt.new_string('woocommerce'),
					]) },
				]) },
				rt.ArrayItem{ key: 'stock_status', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'readonly', val: true },
					rt.ArrayItem{ key: 'context', val: rt.create_array([
						rt.ArrayItem{ key: none, val: 'view' },
						rt.ArrayItem{ key: none, val: 'edit' },
					]) },
					rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
						rt.new_string('Product inventory status.'),
						rt.new_string('woocommerce'),
					]) },
				]) },
				rt.ArrayItem{ key: 'stock_quantity', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'integer' },
					rt.ArrayItem{ key: 'readonly', val: true },
					rt.ArrayItem{ key: 'context', val: rt.create_array([
						rt.ArrayItem{ key: none, val: 'view' },
						rt.ArrayItem{ key: none, val: 'edit' },
					]) },
					rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
						rt.new_string('Product inventory quantity.'),
						rt.new_string('woocommerce'),
					]) },
				]) },
				rt.ArrayItem{ key: 'low_stock_amount', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'integer' },
					rt.ArrayItem{ key: 'readonly', val: true },
					rt.ArrayItem{ key: 'context', val: rt.create_array([
						rt.ArrayItem{ key: none, val: 'view' },
						rt.ArrayItem{ key: none, val: 'edit' },
					]) },
					rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
						rt.new_string('Product inventory threshold for low stock.'),
						rt.new_string('woocommerce'),
					]) },
				]) },
				rt.ArrayItem{ key: 'variations', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'array' },
					rt.ArrayItem{ key: 'readonly', val: true },
					rt.ArrayItem{ key: 'context', val: rt.create_array([
						rt.ArrayItem{ key: none, val: 'view' },
						rt.ArrayItem{ key: none, val: 'edit' },
					]) },
					rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
						rt.new_string('Product variations IDs.'),
						rt.new_string('woocommerce'),
					]) },
				]) },
				rt.ArrayItem{ key: 'sku', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'readonly', val: true },
					rt.ArrayItem{ key: 'context', val: rt.create_array([
						rt.ArrayItem{ key: none, val: 'view' },
						rt.ArrayItem{ key: none, val: 'edit' },
					]) },
					rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
						rt.new_string('Product SKU.'),
						rt.new_string('woocommerce'),
					]) },
				]) },
			]) },
		]) },
	])
	return this.add_additional_fields_schema(var_schema.clone())
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Products_Controller) get_collection_params() rt.PhpVal {
	mut var_params :=
		this.Class_Automattic_WooCommerce_Admin_API_Reports_GenericController.get_collection_params()
	var_params.array_get_mut('orderby').array_set('enum', this.apply_custom_orderby_filters(rt.create_array([
		rt.ArrayItem{ key: none, val: 'date' },
		rt.ArrayItem{ key: none, val: 'net_revenue' },
		rt.ArrayItem{ key: none, val: 'orders_count' },
		rt.ArrayItem{ key: none, val: 'items_sold' },
		rt.ArrayItem{ key: none, val: 'product_name' },
		rt.ArrayItem{ key: none, val: 'variations' },
		rt.ArrayItem{ key: none, val: 'sku' },
	])))
	var_params.array_set('categories', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Limit result to items from the specified categories.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'array' },
		rt.ArrayItem{ key: 'sanitize_callback', val: 'wp_parse_id_list' },
		rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' },
		rt.ArrayItem{ key: 'items', val: rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'integer' },
		]) },
	]))
	var_params.array_set('match', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Indicates whether all the conditions should be true for the resulting set, or if any one of them is sufficient. Match affects the following parameters: status_is, status_is_not, product_includes, product_excludes, coupon_includes, coupon_excludes, customer, categories'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'string' },
		rt.ArrayItem{ key: 'default', val: 'all' },
		rt.ArrayItem{ key: 'enum', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'all' },
			rt.ArrayItem{ key: none, val: 'any' },
		]) },
		rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' },
	]))
	var_params.array_set('products', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Limit result to items with specified product ids.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'array' },
		rt.ArrayItem{ key: 'sanitize_callback', val: 'wp_parse_id_list' },
		rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' },
		rt.ArrayItem{ key: 'items', val: rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'integer' },
		]) },
	]))
	var_params.array_set('extended_info', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Add additional piece of info about each product to the report.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'boolean' },
		rt.ArrayItem{ key: 'default', val: false },
		rt.ArrayItem{ key: 'sanitize_callback', val: 'wc_string_to_bool' },
		rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' },
	]))
	return var_params.clone()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Products_Controller) get_stock_status(var_status rt.PhpVal) rt.PhpVal {
	mut var_statuses := rt.call_function('wc_get_product_stock_status_options', []rt.PhpVal{})
	return if var_statuses.array_isset(var_status) {
		var_statuses.array_get(var_status)
	} else {
		rt.new_string('')
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Products_Controller) get_categories(var_category_ids rt.PhpVal) rt.PhpVal {
	mut var_category_names := rt.call_function('get_terms', [
		rt.create_array([rt.ArrayItem{ key: 'taxonomy', val: 'product_cat' },
			rt.ArrayItem{ key: 'include', val: var_category_ids },
			rt.ArrayItem{ key: 'fields', val: 'names' }]),
	])
	return rt.call_function('implode', [rt.new_string(', '), var_category_names.clone()])
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Products_Controller) get_export_columns() rt.PhpVal {
	mut var_export_columns := rt.create_array([
		rt.ArrayItem{ key: 'product_name', val: rt.call_function('__', [
			rt.new_string('Product title'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'sku', val: rt.call_function('__', [
			rt.new_string('SKU'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'items_sold', val: rt.call_function('__', [
			rt.new_string('Items sold'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'net_revenue', val: rt.call_function('__', [
			rt.new_string('N. Revenue'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'orders_count', val: rt.call_function('__', [
			rt.new_string('Orders'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'product_cat', val: rt.call_function('__', [
			rt.new_string('Category'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'variations', val: rt.call_function('__', [
			rt.new_string('Variations'),
			rt.new_string('woocommerce'),
		]) },
	])
	if rt.is_true(rt.identical(rt.new_string('yes'), rt.call_function('get_option', [
		rt.new_string('woocommerce_manage_stock'),
	])))
	{
		var_export_columns.array_set('stock_status', rt.call_function('__', [
			rt.new_string('Status'),
			rt.new_string('woocommerce'),
		]))
		var_export_columns.array_set('stock', rt.call_function('__', [
			rt.new_string('Stock'),
			rt.new_string('woocommerce'),
		]))
	}
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_report_products_export_columns'),
		var_export_columns.clone(),
	])
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Products_Controller) prepare_item_for_export(var_item rt.PhpVal) rt.PhpVal {
	mut var_export_item := rt.create_array([
		rt.ArrayItem{
			key: 'product_name'
			val: var_item.array_get(rt.new_string('extended_info')).array_get(rt.new_string('name'))
		},
		rt.ArrayItem{
			key: 'sku'
			val: var_item.array_get(rt.new_string('extended_info')).array_get(rt.new_string('sku'))
		},
		rt.ArrayItem{ key: 'items_sold', val: var_item.array_get(rt.new_string('items_sold')) },
		rt.ArrayItem{ key: 'net_revenue', val: var_item.array_get(rt.new_string('net_revenue')) },
		rt.ArrayItem{ key: 'orders_count', val: var_item.array_get(rt.new_string('orders_count')) },
		rt.ArrayItem{
			key: 'product_cat'
			val: this.get_categories(var_item.array_get(rt.new_string('extended_info')).array_get(rt.new_string('category_ids')))
		},
		rt.ArrayItem{
			key: 'variations'
			val: if var_item.array_get(rt.new_string('extended_info')).array_isset(rt.new_string('variations')) {
				var_item.array_get(rt.new_string('extended_info')).array_get(rt.new_string('variations')).array_count()
			} else {
				0
			}
		},
	])
	if rt.is_true(rt.identical(rt.new_string('yes'), rt.call_function('get_option', [
		rt.new_string('woocommerce_manage_stock'),
	])))
	{
		if rt.is_true(var_item.array_get(rt.new_string('extended_info')).array_get(rt.new_string('manage_stock'))) {
			var_export_item.array_set('stock_status',
				this.get_stock_status(var_item.array_get(rt.new_string('extended_info')).array_get(rt.new_string('stock_status'))))
			var_export_item.array_set('stock',
				var_item.array_get(rt.new_string('extended_info')).array_get(rt.new_string('stock_quantity')))
		} else {
			var_export_item.array_set('stock_status', rt.call_function('__', [
				rt.new_string('N/A'),
				rt.new_string('woocommerce'),
			]))
			var_export_item.array_set('stock', rt.call_function('__', [
				rt.new_string('N/A'),
				rt.new_string('woocommerce'),
			]))
		}
	}
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_report_products_prepare_export_item'),
		var_export_item.clone(),
		var_item.clone(),
	])
}

struct Class_Automattic_WooCommerce_Admin_API_Reports_GenericController {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_API_Reports_GenericQuery {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_api_reports_products_controller(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_API_Reports_Products_Controller {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_Products_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
		rest_base:     rt.new_string('reports/products')
		param_mapping: rt.new_array()
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_reports_genericcontroller(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_API_Reports_GenericController {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_GenericController{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_reports_genericquery(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_API_Reports_GenericQuery {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Reports_GenericQuery{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Products_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_datastore_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_datastore_data(dispatch_arg_0)
		}
		'prepare_item_for_response' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.prepare_item_for_response(dispatch_arg_0, dispatch_arg_1)
		}
		'prepare_reports_query' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.prepare_reports_query(dispatch_arg_0)
		}
		'prepare_links' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.prepare_links(dispatch_arg_0)
		}
		'get_item_schema' {
			return this.get_item_schema()
		}
		'get_collection_params' {
			return this.get_collection_params()
		}
		'get_stock_status' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_stock_status(dispatch_arg_0)
		}
		'get_categories' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_categories(dispatch_arg_0)
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

fn (this &Class_Automattic_WooCommerce_Admin_API_Reports_Products_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'rest_base' { return this.rest_base }
		'param_mapping' { return this.param_mapping }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_Products_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'rest_base' {
			this.rest_base = val
			return true
		}
		'param_mapping' {
			this.param_mapping = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_GenericController) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_API_Reports_GenericController) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_GenericController) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_GenericQuery) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_API_Reports_GenericQuery) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Reports_GenericQuery) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}
