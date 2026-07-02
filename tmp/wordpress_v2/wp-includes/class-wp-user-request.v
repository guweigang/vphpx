import rt

struct Class_WP_User_Request {
	rt.PhpObjectBase
pub mut:
	ID                  rt.PhpVal = rt.new_int(0)
	user_id             rt.PhpVal = rt.new_int(0)
	email               rt.PhpVal = rt.new_string('')
	action_name         rt.PhpVal = rt.new_string('')
	status              rt.PhpVal = rt.new_string('')
	created_timestamp   rt.PhpVal = rt.new_null()
	modified_timestamp  rt.PhpVal = rt.new_null()
	confirmed_timestamp rt.PhpVal = rt.new_null()
	completed_timestamp rt.PhpVal = rt.new_null()
	request_data        rt.PhpVal = rt.new_array()
	confirm_key         rt.PhpVal = rt.new_string('')
}

fn (mut this Class_WP_User_Request) construct(var_post rt.PhpVal) {
	this.ID = rt.get_property(var_post, 'ID')
	this.user_id = rt.get_property(var_post, 'post_author')
	this.email = rt.get_property(var_post, 'post_title')
	this.action_name = rt.get_property(var_post, 'post_name')
	this.status = rt.get_property(var_post, 'post_status')
	this.created_timestamp = rt.call_function('strtotime', [
		rt.get_property(var_post, 'post_date_gmt'),
	])
	this.modified_timestamp = rt.call_function('strtotime', [
		rt.get_property(var_post, 'post_modified_gmt'),
	])
	this.confirmed_timestamp = rt.new_int((rt.call_function('get_post_meta', [
		rt.get_property(var_post, 'ID'),
		rt.new_string('_wp_user_request_confirmed_timestamp'),
		rt.new_bool(true),
	])).to_i64())
	this.completed_timestamp = rt.new_int((rt.call_function('get_post_meta', [
		rt.get_property(var_post, 'ID'),
		rt.new_string('_wp_user_request_completed_timestamp'),
		rt.new_bool(true),
	])).to_i64())
	this.request_data = rt.call_function('json_decode', [
		rt.get_property(var_post, 'post_content'),
		rt.new_bool(true),
	])
	this.confirm_key = rt.get_property(var_post, 'post_password')
}

fn create_wp_user_request(arg_0 rt.PhpVal) &Class_WP_User_Request {
	mut obj := &Class_WP_User_Request{
		PhpObjectBase:       rt.PhpObjectBase{}
		ID:                  rt.new_int(0)
		user_id:             rt.new_int(0)
		email:               rt.new_string('')
		action_name:         rt.new_string('')
		status:              rt.new_string('')
		created_timestamp:   rt.new_null()
		modified_timestamp:  rt.new_null()
		confirmed_timestamp: rt.new_null()
		completed_timestamp: rt.new_null()
		request_data:        rt.new_array()
		confirm_key:         rt.new_string('')
	}
	obj.construct(arg_0)
	return obj
}

fn (mut this Class_WP_User_Request) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WP_User_Request) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'ID' { return this.ID }
		'user_id' { return this.user_id }
		'email' { return this.email }
		'action_name' { return this.action_name }
		'status' { return this.status }
		'created_timestamp' { return this.created_timestamp }
		'modified_timestamp' { return this.modified_timestamp }
		'confirmed_timestamp' { return this.confirmed_timestamp }
		'completed_timestamp' { return this.completed_timestamp }
		'request_data' { return this.request_data }
		'confirm_key' { return this.confirm_key }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_User_Request) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'ID' {
			this.ID = val
			return true
		}
		'user_id' {
			this.user_id = val
			return true
		}
		'email' {
			this.email = val
			return true
		}
		'action_name' {
			this.action_name = val
			return true
		}
		'status' {
			this.status = val
			return true
		}
		'created_timestamp' {
			this.created_timestamp = val
			return true
		}
		'modified_timestamp' {
			this.modified_timestamp = val
			return true
		}
		'confirmed_timestamp' {
			this.confirmed_timestamp = val
			return true
		}
		'completed_timestamp' {
			this.completed_timestamp = val
			return true
		}
		'request_data' {
			this.request_data = val
			return true
		}
		'confirm_key' {
			this.confirm_key = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn main() {
	defer {
		rt.shutdown()
	}
}
