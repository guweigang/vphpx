import rt

struct Class_WC_REST_Report_Reviews_Totals_Controller {
	rt.PhpObjectBase
pub mut:
	namespace rt.PhpVal = rt.new_string('wc/v3')
	rest_base rt.PhpVal = rt.new_string('reports/reviews/totals')
}

fn (mut this Class_WC_REST_Report_Reviews_Totals_Controller) get_reports() rt.PhpVal {
	mut var_data := rt.new_array()
	mut var_query_data := {
		'count':      rt.new_bool(true)
		'post_type':  rt.new_string('product')
		'meta_key':   rt.new_string('rating')
		'meta_value': rt.new_string('')
	}
	mut var_i := rt.new_int(1)
	for {
		if !(rt.is_true(rt.less_equal(var_i, rt.new_int(5)))) { break
		 }
		var_query_data['meta_value'] = var_i.clone()
		var_data.array_push(rt.create_array([
			rt.ArrayItem{ key: 'slug', val: 'rated_' + var_i.str() + '_out_of_5' },
			rt.ArrayItem{ key: 'name', val: rt.call_function('sprintf', [
				rt.call_function('__', [rt.new_string('Rated %s out of 5'),
					rt.new_string('woocommerce')]),
				var_i.clone(),
			]) },
			rt.ArrayItem{ key: 'total', val: rt.new_int((rt.call_function('get_comments', [
				rt.create_array_from_native_map(var_query_data),
			])).to_i64()) },
		]))
		rt.post_inc(var_i)
	}
	return var_data.clone()
}

fn (mut this Class_WC_REST_Report_Reviews_Totals_Controller) prepare_item_for_response(var_report rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
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
		rt.new_string('woocommerce_rest_prepare_report_reviews_count'),
		var_response.clone(),
		var_report.clone(),
		var_request.clone(),
	])
}

fn (mut this Class_WC_REST_Report_Reviews_Totals_Controller) get_item_schema() rt.PhpVal {
	mut var_schema := {
		'$schema':    rt.new_string('http://json-schema.org/draft-04/schema#')
		'title':      rt.new_string('report_review_total')
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
					rt.new_string('Review type name.'),
					rt.new_string('woocommerce'),
				])
				'type':        rt.new_string('string')
				'context':     map[string]rt.PhpVal{}
				'readonly':    rt.new_bool(true)
			}
			'total': {
				'description': rt.call_function('__', [
					rt.new_string('Amount of reviews.'),
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

fn create_wc_rest_report_reviews_totals_controller(_args ...rt.PhpVal) &Class_WC_REST_Report_Reviews_Totals_Controller {
	mut obj := &Class_WC_REST_Report_Reviews_Totals_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
		namespace:     rt.new_string('wc/v3')
		rest_base:     rt.new_string('reports/reviews/totals')
	}
	return obj
}

fn create_wc_rest_reports_controller(_args ...rt.PhpVal) &Class_WC_REST_Reports_Controller {
	mut obj := &Class_WC_REST_Reports_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_REST_Report_Reviews_Totals_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
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

fn (this &Class_WC_REST_Report_Reviews_Totals_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'namespace' { return this.namespace }
		'rest_base' { return this.rest_base }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_REST_Report_Reviews_Totals_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}
