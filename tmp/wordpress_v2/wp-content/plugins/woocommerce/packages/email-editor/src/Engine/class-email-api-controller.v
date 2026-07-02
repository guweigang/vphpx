import rt

struct Class_Automattic_WooCommerce_EmailEditor_Engine_Email_Api_Controller {
	rt.PhpObjectBase
pub mut:
	personalization_tags_registry rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Email_Api_Controller) construct(mut var_personalization_tags_registry Class_Automattic_WooCommerce_EmailEditor_Engine_PersonalizationTags_Personalization_Tags_Registry) {
	this.personalization_tags_registry = var_personalization_tags_registry
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Email_Api_Controller) get_email_data() rt.PhpVal {
	return rt.new_array()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Email_Api_Controller) save_email_data(mut var_data Class_Automattic_WooCommerce_EmailEditor_Engine_array, mut var_email_post Class_WP_Post) {
	mut var_data_mutated := var_data
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Email_Api_Controller) send_preview_email_data(mut var_request Class_WP_REST_Request) rt.PhpVal {
	mut var_data := var_request.get_params()
	mut var_result := rt.call_function('apply_filters', [
		rt.new_string('woocommerce_email_editor_send_preview_email'),
		var_data.clone(),
	])
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	return rt.new_object('WP_REST_Response', []string{}, create_wp_rest_response(rt.create_array([
		rt.ArrayItem{ key: 'success', val: var_result.to_bool() },
		rt.ArrayItem{ key: 'result', val: var_result },
	]), if rt.is_true(var_result) { 200 } else { 400 }))
	unsafe {
		goto end_label_1
	}
	catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'Automattic_WooCommerce_EmailEditor_Engine_Exception') {
		mut var_exception := var_e_1.clone()
		return rt.new_object('WP_REST_Response', []string{}, create_wp_rest_response(rt.create_array([
			rt.ArrayItem{ key: 'error', val: rt.call_method(var_exception, 'getMessage',
				[]rt.PhpVal{}) },
		]), rt.new_int(400)))
		unsafe {
			goto end_label_1
		}
	} else {
		rt.throw_exception(var_e_1)
		unsafe {
			goto end_label_1
		}
	}

	end_label_1:
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Email_Api_Controller) get_personalization_tags() rt.PhpVal {
	mut var_tags := rt.call_method(this.personalization_tags_registry, 'get_all', []rt.PhpVal{})
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_tag := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.create_array([
			rt.ArrayItem{ key: 'name', val: rt.call_method(var_tag, 'get_name', []rt.PhpVal{}) },
			rt.ArrayItem{ key: 'token', val: rt.call_method(var_tag, 'get_token', []rt.PhpVal{}) },
			rt.ArrayItem{ key: 'category', val: rt.call_method(var_tag, 'get_category',
				[]rt.PhpVal{}) },
			rt.ArrayItem{ key: 'attributes', val: rt.call_method(var_tag, 'get_attributes',
				[]rt.PhpVal{}) },
			rt.ArrayItem{ key: 'valueToInsert', val: rt.call_method(var_tag, 'get_value_to_insert',
				[]rt.PhpVal{}) },
			rt.ArrayItem{ key: 'postTypes', val: rt.call_method(var_tag, 'get_post_types',
				[]rt.PhpVal{}) },
		])
	}
	closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_tag := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.create_array([
			rt.ArrayItem{ key: 'name', val: rt.call_method(var_tag, 'get_name', []rt.PhpVal{}) },
			rt.ArrayItem{ key: 'token', val: rt.call_method(var_tag, 'get_token', []rt.PhpVal{}) },
			rt.ArrayItem{ key: 'category', val: rt.call_method(var_tag, 'get_category',
				[]rt.PhpVal{}) },
			rt.ArrayItem{ key: 'attributes', val: rt.call_method(var_tag, 'get_attributes',
				[]rt.PhpVal{}) },
			rt.ArrayItem{ key: 'valueToInsert', val: rt.call_method(var_tag, 'get_value_to_insert',
				[]rt.PhpVal{}) },
			rt.ArrayItem{ key: 'postTypes', val: rt.call_method(var_tag, 'get_post_types',
				[]rt.PhpVal{}) },
		])
	}
	closure_3_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_tag := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.create_array([
			rt.ArrayItem{ key: 'name', val: rt.call_method(var_tag, 'get_name', []rt.PhpVal{}) },
			rt.ArrayItem{ key: 'token', val: rt.call_method(var_tag, 'get_token', []rt.PhpVal{}) },
			rt.ArrayItem{ key: 'category', val: rt.call_method(var_tag, 'get_category',
				[]rt.PhpVal{}) },
			rt.ArrayItem{ key: 'attributes', val: rt.call_method(var_tag, 'get_attributes',
				[]rt.PhpVal{}) },
			rt.ArrayItem{ key: 'valueToInsert', val: rt.call_method(var_tag, 'get_value_to_insert',
				[]rt.PhpVal{}) },
			rt.ArrayItem{ key: 'postTypes', val: rt.call_method(var_tag, 'get_post_types',
				[]rt.PhpVal{}) },
		])
	}
	closure_4_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_tag := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.create_array([
			rt.ArrayItem{ key: 'name', val: rt.call_method(var_tag, 'get_name', []rt.PhpVal{}) },
			rt.ArrayItem{ key: 'token', val: rt.call_method(var_tag, 'get_token', []rt.PhpVal{}) },
			rt.ArrayItem{ key: 'category', val: rt.call_method(var_tag, 'get_category',
				[]rt.PhpVal{}) },
			rt.ArrayItem{ key: 'attributes', val: rt.call_method(var_tag, 'get_attributes',
				[]rt.PhpVal{}) },
			rt.ArrayItem{ key: 'valueToInsert', val: rt.call_method(var_tag, 'get_value_to_insert',
				[]rt.PhpVal{}) },
			rt.ArrayItem{ key: 'postTypes', val: rt.call_method(var_tag, 'get_post_types',
				[]rt.PhpVal{}) },
		])
	}
	return rt.new_object('WP_REST_Response', []string{}, create_wp_rest_response(rt.create_array([
		rt.ArrayItem{ key: 'success', val: true },
		rt.ArrayItem{ key: 'result', val: rt.call_function('array_values', [
			rt.call_function('array_map', [rt.new_closure(closure_1_fn),
				var_tags.clone()]),
		]) },
	]), rt.new_int(200)))
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Email_Api_Controller) get_personalization_tags_collection(mut var_request Class_WP_REST_Request) rt.PhpVal {
	mut var_post_id := var_request.get_param(rt.new_string('post_id'))
	var_post_id = rt.new_int(if var_post_id.clone().is_long() || var_post_id.clone().is_double() {
		rt.new_int(var_post_id.to_i64())
	} else {
		0
	})
	if rt.is_true(rt.greater(var_post_id, rt.new_int(0))) {
		rt.call_function('do_action', [
			rt.new_string('woocommerce_email_editor_personalization_tags_for_post'),
			var_post_id.clone(),
		])
	}
	mut var_tags := rt.call_method(this.personalization_tags_registry, 'get_all', []rt.PhpVal{})
	closure_5_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_tag := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.create_array([
			rt.ArrayItem{ key: 'name', val: rt.call_method(var_tag, 'get_name', []rt.PhpVal{}) },
			rt.ArrayItem{ key: 'token', val: rt.call_method(var_tag, 'get_token', []rt.PhpVal{}) },
			rt.ArrayItem{ key: 'category', val: rt.call_method(var_tag, 'get_category',
				[]rt.PhpVal{}) },
			rt.ArrayItem{ key: 'attributes', val: rt.call_method(var_tag, 'get_attributes',
				[]rt.PhpVal{}) },
			rt.ArrayItem{ key: 'valueToInsert', val: rt.call_method(var_tag, 'get_value_to_insert',
				[]rt.PhpVal{}) },
			rt.ArrayItem{ key: 'postTypes', val: rt.call_method(var_tag, 'get_post_types',
				[]rt.PhpVal{}) },
		])
	}
	closure_6_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_tag := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.create_array([
			rt.ArrayItem{ key: 'name', val: rt.call_method(var_tag, 'get_name', []rt.PhpVal{}) },
			rt.ArrayItem{ key: 'token', val: rt.call_method(var_tag, 'get_token', []rt.PhpVal{}) },
			rt.ArrayItem{ key: 'category', val: rt.call_method(var_tag, 'get_category',
				[]rt.PhpVal{}) },
			rt.ArrayItem{ key: 'attributes', val: rt.call_method(var_tag, 'get_attributes',
				[]rt.PhpVal{}) },
			rt.ArrayItem{ key: 'valueToInsert', val: rt.call_method(var_tag, 'get_value_to_insert',
				[]rt.PhpVal{}) },
			rt.ArrayItem{ key: 'postTypes', val: rt.call_method(var_tag, 'get_post_types',
				[]rt.PhpVal{}) },
		])
	}
	closure_7_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_tag := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.create_array([
			rt.ArrayItem{ key: 'name', val: rt.call_method(var_tag, 'get_name', []rt.PhpVal{}) },
			rt.ArrayItem{ key: 'token', val: rt.call_method(var_tag, 'get_token', []rt.PhpVal{}) },
			rt.ArrayItem{ key: 'category', val: rt.call_method(var_tag, 'get_category',
				[]rt.PhpVal{}) },
			rt.ArrayItem{ key: 'attributes', val: rt.call_method(var_tag, 'get_attributes',
				[]rt.PhpVal{}) },
			rt.ArrayItem{ key: 'valueToInsert', val: rt.call_method(var_tag, 'get_value_to_insert',
				[]rt.PhpVal{}) },
			rt.ArrayItem{ key: 'postTypes', val: rt.call_method(var_tag, 'get_post_types',
				[]rt.PhpVal{}) },
		])
	}
	closure_8_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_tag := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.create_array([
			rt.ArrayItem{ key: 'name', val: rt.call_method(var_tag, 'get_name', []rt.PhpVal{}) },
			rt.ArrayItem{ key: 'token', val: rt.call_method(var_tag, 'get_token', []rt.PhpVal{}) },
			rt.ArrayItem{ key: 'category', val: rt.call_method(var_tag, 'get_category',
				[]rt.PhpVal{}) },
			rt.ArrayItem{ key: 'attributes', val: rt.call_method(var_tag, 'get_attributes',
				[]rt.PhpVal{}) },
			rt.ArrayItem{ key: 'valueToInsert', val: rt.call_method(var_tag, 'get_value_to_insert',
				[]rt.PhpVal{}) },
			rt.ArrayItem{ key: 'postTypes', val: rt.call_method(var_tag, 'get_post_types',
				[]rt.PhpVal{}) },
		])
	}
	return rt.new_object('WP_REST_Response', []string{}, create_wp_rest_response(rt.call_function('array_values', [
		rt.call_function('array_map', [rt.new_closure(closure_5_fn),
			var_tags.clone()]),
	]), rt.new_int(200)))
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Email_Api_Controller) get_email_data_schema() rt.PhpVal {
	mut iife_temp_8 := Class_Automattic_WooCommerce_EmailEditor_Validator_Builder{}
	mut iife_result_8 := iife_temp_8.object()
	return rt.call_method(iife_result_8, 'to_array', []rt.PhpVal{})
}

struct Class_WP_REST_Response {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditor_Validator_Builder {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_emaileditor_engine_email_api_controller(arg_0 rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditor_Engine_Email_Api_Controller {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Engine_Email_Api_Controller{
		PhpObjectBase:                 rt.PhpObjectBase{}
		personalization_tags_registry: rt.new_null()
	}
	obj.construct(arg_0)
	return obj
}

fn create_wp_rest_response(_args ...rt.PhpVal) &Class_WP_REST_Response {
	mut obj := &Class_WP_REST_Response{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditor_validator_builder(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditor_Validator_Builder {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Validator_Builder{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Email_Api_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_PersonalizationTags_Personalization_Tags_Registry](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.construct(mut dispatch_arg_0)
			return rt.new_null()
		}
		'get_email_data' {
			return this.get_email_data()
		}
		'save_email_data' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_WP_Post](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			this.save_email_data(mut dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'send_preview_email_data' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_REST_Request](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.send_preview_email_data(mut dispatch_arg_0)
		}
		'get_personalization_tags' {
			return this.get_personalization_tags()
		}
		'get_personalization_tags_collection' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_REST_Request](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.get_personalization_tags_collection(mut dispatch_arg_0)
		}
		'get_email_data_schema' {
			return this.get_email_data_schema()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Engine_Email_Api_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'personalization_tags_registry' { return this.personalization_tags_registry }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Email_Api_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'personalization_tags_registry' {
			this.personalization_tags_registry = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_WP_REST_Response) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_REST_Response) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_REST_Response) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Validator_Builder) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Validator_Builder) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Validator_Builder) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
