import rt

struct Class_WC_REST_Report_Customers_Totals_Controller {
	rt.PhpObjectBase
pub mut:
	namespace rt.PhpVal = rt.new_string('wc/v3')
	rest_base rt.PhpVal = rt.new_string('reports/customers/totals')
}

fn (mut this Class_WC_REST_Report_Customers_Totals_Controller) get_reports() rt.PhpVal {
	mut var_users_count := rt.call_function('count_users', []rt.PhpVal{})
	mut var_total_customers := rt.new_int(0)
	mut iter_1 := var_users_count.array_get(rt.new_string('avail_roles')).iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_total := item_1.val
		mut var_role := item_1.key
		if rt.is_true(rt.call_function('in_array', [var_role.clone(),
			rt.create_array([rt.ArrayItem{ key: none, val: 'administrator' },
				rt.ArrayItem{ key: none, val: 'shop_manager' }]),
			rt.new_bool(true)]))
		{
			continue
		}
		var_total_customers = rt.add(var_total_customers, rt.new_int(var_total.to_i64()))
	}
	mut var_customers_query := create_wp_user_query(rt.create_array([
		rt.ArrayItem{ key: 'role__not_in', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'administrator' },
			rt.ArrayItem{ key: none, val: 'shop_manager' },
		]) },
		rt.ArrayItem{ key: 'number', val: 0 },
		rt.ArrayItem{ key: 'fields', val: 'ID' },
		rt.ArrayItem{ key: 'count_total', val: true },
		rt.ArrayItem{ key: 'meta_query', val: rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'key', val: 'paying_customer' },
				rt.ArrayItem{ key: 'value', val: 1 },
				rt.ArrayItem{ key: 'compare', val: '=' },
			]) },
		]) },
	]))
	mut var_total_paying := rt.new_int((var_customers_query.get_total()).to_i64())
	mut var_data := rt.create_array([
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'slug', val: 'paying' },
			rt.ArrayItem{ key: 'name', val: rt.call_function('__', [
				rt.new_string('Paying customer'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'total', val: var_total_paying },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'slug', val: 'non_paying' },
			rt.ArrayItem{ key: 'name', val: rt.call_function('__', [
				rt.new_string('Non-paying customer'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'total', val: rt.sub(var_total_customers, var_total_paying) },
		]) },
	])
	return var_data.clone()
}

fn (mut this Class_WC_REST_Report_Customers_Totals_Controller) prepare_item_for_response(var_report rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	mut var_data := rt.create_array([
		rt.ArrayItem{ key: 'slug', val: rt.get_property(var_report, 'slug') },
		rt.ArrayItem{ key: 'name', val: rt.get_property(var_report, 'name') },
		rt.ArrayItem{ key: 'total', val: rt.get_property(var_report, 'total') },
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
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_rest_prepare_report_customers_count'),
		var_response.clone(),
		var_report.clone(),
		var_request.clone(),
	])
}

fn (mut this Class_WC_REST_Report_Customers_Totals_Controller) get_item_schema() rt.PhpVal {
	mut var_schema := {
		'$schema':    rt.new_string('http://json-schema.org/draft-04/schema#')
		'title':      rt.new_string('report_customer_total')
		'type':       rt.new_string('object')
		'properties': {
			'slug':  {
				'description': rt.call_function('__', [
					rt.new_string('An alphanumeric identifier for the resource.'),
					rt.new_string('woocommerce'),
				])
				'type':        rt.new_string('string')
				'context':     map[string]rt.PhpVal{}
				'readonly':    rt.new_bool(true)
			}
			'name':  {
				'description': rt.call_function('__', [
					rt.new_string('Customer type name.'),
					rt.new_string('woocommerce'),
				])
				'type':        rt.new_string('string')
				'context':     map[string]rt.PhpVal{}
				'readonly':    rt.new_bool(true)
			}
			'total': {
				'description': rt.call_function('__', [
					rt.new_string('Amount of customers.'),
					rt.new_string('woocommerce'),
				])
				'type':        rt.new_string('string')
				'context':     map[string]rt.PhpVal{}
				'readonly':    rt.new_bool(true)
			}
		}
	}
	return this.add_additional_fields_schema(var_schema.clone())
}

struct Class_WC_REST_Reports_Controller {
	rt.PhpObjectBase
}

struct Class_WP_User_Query {
	rt.PhpObjectBase
}

fn create_wc_rest_report_customers_totals_controller(_args ...rt.PhpVal) &Class_WC_REST_Report_Customers_Totals_Controller {
	mut obj := &Class_WC_REST_Report_Customers_Totals_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
		namespace:     rt.new_string('wc/v3')
		rest_base:     rt.new_string('reports/customers/totals')
	}
	return obj
}

fn create_wc_rest_reports_controller(_args ...rt.PhpVal) &Class_WC_REST_Reports_Controller {
	mut obj := &Class_WC_REST_Reports_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_user_query(_args ...rt.PhpVal) &Class_WP_User_Query {
	mut obj := &Class_WP_User_Query{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_REST_Report_Customers_Totals_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_reports' {
			return this.get_reports()
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

fn (this &Class_WC_REST_Report_Customers_Totals_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'namespace' { return this.namespace }
		'rest_base' { return this.rest_base }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_REST_Report_Customers_Totals_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_WC_REST_Reports_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_REST_Reports_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_REST_Reports_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WP_User_Query) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_User_Query) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_User_Query) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}
