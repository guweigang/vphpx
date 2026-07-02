import rt

struct Class_WP_REST_Blocks_Controller {
	rt.PhpObjectBase
}

fn (mut this Class_WP_REST_Blocks_Controller) check_read_permission(var_post rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('read_post'),
		rt.get_property(var_post, 'ID'),
	])))))
	{
		return false
	}
	return (this.Class_WP_REST_Posts_Controller.check_read_permission(var_post.clone())).to_bool()
}

fn (mut this Class_WP_REST_Blocks_Controller) filter_response_by_context(var_data rt.PhpVal, var_context rt.PhpVal) rt.PhpVal {
	mut var_data_mutated := var_data
	var_data_mutated = this.Class_WP_REST_Posts_Controller.filter_response_by_context(var_data_mutated.clone(),
		var_context.clone())
	var_data_mutated.array_get(rt.new_string('title')).array_unset(rt.new_string('rendered'))
	var_data_mutated.array_get(rt.new_string('content')).array_unset(rt.new_string('rendered'))
	var_data_mutated.array_set('wp_pattern_sync_status', if !(var_data_mutated.array_get(rt.new_string('meta')).array_get(rt.new_string('wp_pattern_sync_status'))).is_null() {
		var_data_mutated.array_get(rt.new_string('meta')).array_get(rt.new_string('wp_pattern_sync_status'))
	} else {
		rt.new_string('')
	})
	var_data_mutated.array_get(rt.new_string('meta')).array_unset(rt.new_string('wp_pattern_sync_status'))
	return var_data_mutated.clone()
}

fn (mut this Class_WP_REST_Blocks_Controller) get_item_schema() rt.PhpVal {
	if rt.is_true(rt.get_property(rt.new_object('WP_REST_Blocks_Controller', [
		'WP_REST_Posts_Controller',
	], &this), 'schema'))
	{
		return this.add_additional_fields_schema(rt.get_property(rt.new_object('WP_REST_Blocks_Controller', [
			'WP_REST_Posts_Controller',
		], &this), 'schema'))
	}
	mut var_schema := this.Class_WP_REST_Posts_Controller.get_item_schema()
	var_schema.array_get_mut('properties').array_get_mut('title').array_get_mut('properties').array_get_mut('raw').array_set('context', rt.create_array([
		rt.ArrayItem{ key: none, val: 'view' },
		rt.ArrayItem{ key: none, val: 'edit' },
	]))
	var_schema.array_get_mut('properties').array_get_mut('content').array_get_mut('properties').array_get_mut('raw').array_set('context', rt.create_array([
		rt.ArrayItem{ key: none, val: 'view' },
		rt.ArrayItem{ key: none, val: 'edit' },
	]))
	var_schema.array_get(rt.new_string('properties')).array_get(rt.new_string('title')).array_get(rt.new_string('properties')).array_unset(rt.new_string('rendered'))
	var_schema.array_get(rt.new_string('properties')).array_get(rt.new_string('content')).array_get(rt.new_string('properties')).array_unset(rt.new_string('rendered'))
	this.dispatch_set_prop('schema', var_schema.clone())
	return this.add_additional_fields_schema(rt.get_property(rt.new_object('WP_REST_Blocks_Controller', [
		'WP_REST_Posts_Controller',
	], &this), 'schema'))
}

struct Class_WP_REST_Posts_Controller {
	rt.PhpObjectBase
}

fn create_wp_rest_blocks_controller(_args ...rt.PhpVal) &Class_WP_REST_Blocks_Controller {
	mut obj := &Class_WP_REST_Blocks_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_rest_posts_controller(_args ...rt.PhpVal) &Class_WP_REST_Posts_Controller {
	mut obj := &Class_WP_REST_Posts_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_REST_Blocks_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'check_read_permission' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.check_read_permission(dispatch_arg_0))
		}
		'filter_response_by_context' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.filter_response_by_context(dispatch_arg_0, dispatch_arg_1)
		}
		'get_item_schema' {
			return this.get_item_schema()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WP_REST_Blocks_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_REST_Blocks_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WP_REST_Posts_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_REST_Posts_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_REST_Posts_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
