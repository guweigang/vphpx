import rt

struct Class_WC_REST_Report_Top_Sellers_V1_Controller {
	rt.PhpObjectBase
pub mut:
	namespace rt.PhpVal = rt.new_string('wc/v1')
	rest_base rt.PhpVal = rt.new_string('reports/top_sellers')
}

fn (mut this Class_WC_REST_Report_Top_Sellers_V1_Controller) get_items(var_request rt.PhpVal) rt.PhpVal {
	mut var_filter := {
		'period':   var_request.array_get(rt.new_string('period'))
		'date_min': var_request.array_get(rt.new_string('date_min'))
		'date_max': var_request.array_get(rt.new_string('date_max'))
	}
	this.setup_report(var_filter.clone())
	mut var_report_data := rt.call_method(rt.get_property(rt.new_object('WC_REST_Report_Top_Sellers_V1_Controller', [
		'WC_REST_Report_Sales_V1_Controller',
	], &this), 'report'), 'get_order_report_data', [
		rt.create_array([
			rt.ArrayItem{ key: 'data', val: rt.create_array([
				rt.ArrayItem{ key: '_product_id', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'order_item_meta' },
					rt.ArrayItem{ key: 'order_item_type', val: 'line_item' },
					rt.ArrayItem{ key: 'function', val: '' },
					rt.ArrayItem{ key: 'name', val: 'product_id' },
				]) },
				rt.ArrayItem{ key: '_qty', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'order_item_meta' },
					rt.ArrayItem{ key: 'order_item_type', val: 'line_item' },
					rt.ArrayItem{ key: 'function', val: 'SUM' },
					rt.ArrayItem{ key: 'name', val: 'order_item_qty' },
				]) },
			]) },
			rt.ArrayItem{ key: 'order_by', val: 'order_item_qty DESC' },
			rt.ArrayItem{ key: 'group_by', val: 'product_id' },
			rt.ArrayItem{
				key: 'limit'
				val: if var_filter.array_isset(rt.new_string('limit')) { rt.call_function('absint', [
						var_filter['limit'],
					]) } else { rt.new_int(12) }
			},
			rt.ArrayItem{ key: 'query_type', val: 'get_results' },
			rt.ArrayItem{ key: 'filter_range', val: true },
		]),
	])
	mut var_top_sellers := []rt.PhpVal{}
	mut iter_1 := var_report_data.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_item := item_1.val
		mut var_product := rt.call_function('wc_get_product', [
			rt.get_property(var_item, 'product_id'),
		])
		if rt.is_true(var_product) {
			var_top_sellers << rt.create_array([
				rt.ArrayItem{ key: 'name', val: rt.call_method(var_product, 'get_name',
					[]rt.PhpVal{}) },
				rt.ArrayItem{ key: 'product_id', val: rt.new_int((rt.get_property(var_item,
					'product_id')).to_i64()) },
				rt.ArrayItem{ key: 'quantity', val: rt.call_function('wc_stock_amount', [
					rt.get_property(var_item, 'order_item_qty'),
				]) },
			])
		}
	}
	mut var_data := []rt.PhpVal{}
	for var_top_seller in var_top_sellers {
		mut var_item := this.prepare_item_for_response(rt.new_object('stdClass', []string{},
			rt.array_to_object(var_top_seller)), var_request.clone())
		var_data.array_push(this.prepare_response_for_collection(var_item.clone()))
	}
	return rt.call_function('rest_ensure_response', [var_data.clone()])
}

fn (mut this Class_WC_REST_Report_Top_Sellers_V1_Controller) prepare_item_for_response(var_top_seller rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	mut var_data := rt.create_array([
		rt.ArrayItem{ key: 'name', val: rt.get_property(var_top_seller, 'name') },
		rt.ArrayItem{ key: 'product_id', val: rt.get_property(var_top_seller, 'product_id') },
		rt.ArrayItem{ key: 'quantity', val: rt.get_property(var_top_seller, 'quantity') },
	])
	mut var_context := if !(!rt.is_true(var_request.array_get(rt.new_string('context')))) {
		var_request.array_get(rt.new_string('context'))
	} else {
		rt.new_string('view')
	}
	var_data = this.add_additional_fields_to_object(var_data.clone(), var_request.clone())
	var_data = this.filter_response_by_context(var_data.clone(), var_context.clone())
	mut var_response := rt.call_function('rest_ensure_response', [
		var_data.clone()])
	rt.call_method(var_response, 'add_links', [
		rt.create_array([
			rt.ArrayItem{ key: 'about', val: rt.create_array([
				rt.ArrayItem{ key: 'href', val: rt.call_function('rest_url', [
					rt.call_function('sprintf', [rt.new_string('%s/reports'), this.namespace]),
				]) },
			]) },
			rt.ArrayItem{ key: 'product', val: rt.create_array([
				rt.ArrayItem{ key: 'href', val: rt.call_function('rest_url', [
					rt.call_function('sprintf', [rt.new_string('/%s/products/%s'), this.namespace,
						rt.get_property(var_top_seller, 'product_id')]),
				]) },
			]) },
		]),
	])
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_rest_prepare_report_top_sellers'),
		var_response.clone(),
		var_top_seller.clone(),
		var_request.clone(),
	])
}

fn (mut this Class_WC_REST_Report_Top_Sellers_V1_Controller) get_item_schema() rt.PhpVal {
	mut var_schema := {
		'$schema':    rt.new_string('http://json-schema.org/draft-04/schema#')
		'title':      rt.new_string('top_sellers_report')
		'type':       rt.new_string('object')
		'properties': {
			'name':       {
				'description': rt.call_function('__', [rt.new_string('Product name.'),
					rt.new_string('woocommerce')])
				'type':        rt.new_string('string')
				'context':     map[string]rt.PhpVal{}
				'readonly':    rt.new_bool(true)
			}
			'product_id': {
				'description': rt.call_function('__', [rt.new_string('Product ID.'),
					rt.new_string('woocommerce')])
				'type':        rt.new_string('integer')
				'context':     map[string]rt.PhpVal{}
				'readonly':    rt.new_bool(true)
			}
			'quantity':   {
				'description': rt.call_function('__', [
					rt.new_string('Total number of purchases.'),
					rt.new_string('woocommerce'),
				])
				'type':        rt.new_string('integer')
				'context':     map[string]rt.PhpVal{}
				'readonly':    rt.new_bool(true)
			}
		}
	}
	return this.add_additional_fields_schema(var_schema.clone())
}

struct Class_WC_REST_Report_Sales_V1_Controller {
	rt.PhpObjectBase
}

fn create_wc_rest_report_top_sellers_v1_controller(_args ...rt.PhpVal) &Class_WC_REST_Report_Top_Sellers_V1_Controller {
	mut obj := &Class_WC_REST_Report_Top_Sellers_V1_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
		namespace:     rt.new_string('wc/v1')
		rest_base:     rt.new_string('reports/top_sellers')
	}
	return obj
}

fn create_wc_rest_report_sales_v1_controller(_args ...rt.PhpVal) &Class_WC_REST_Report_Sales_V1_Controller {
	mut obj := &Class_WC_REST_Report_Sales_V1_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_REST_Report_Top_Sellers_V1_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_items' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_items(dispatch_arg_0)
		}
		'prepare_item_for_response' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.prepare_item_for_response(dispatch_arg_0, dispatch_arg_1)
		}
		'get_item_schema' {
			return this.get_item_schema()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_REST_Report_Top_Sellers_V1_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'namespace' { return this.namespace }
		'rest_base' { return this.rest_base }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_REST_Report_Top_Sellers_V1_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'namespace' {
			this.namespace = val
			return true
		}
		'rest_base' {
			this.rest_base = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_WC_REST_Report_Sales_V1_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_REST_Report_Sales_V1_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_REST_Report_Sales_V1_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		exit(0)
	}
}
