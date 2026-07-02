import rt

struct Class_WC_Legacy_Webhook {
	rt.PhpObjectBase
}

fn (mut this Class_WC_Legacy_Webhook) magic_isset(var_key rt.PhpVal) bool {
	mut var_legacy_keys := ['id', 'status', 'post_data', 'delivery_url', 'secret', 'topic', 'hooks',
		'resource', 'event', 'failure_count', 'api_version']
	if rt.is_true(rt.call_function('in_array', [var_key.clone(),
		rt.create_array_from_list(var_legacy_keys), rt.new_bool(true)]))
	{
		return true
	}
	return false
}

fn (mut this Class_WC_Legacy_Webhook) magic_get(var_key rt.PhpVal) rt.PhpVal {
	rt.call_function('wc_doing_it_wrong', [var_key.clone(),
		rt.new_string('Webhook properties should not be accessed directly.'),
		rt.new_string('3.2')])
	mut switch_val_1 := var_key
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('id'))) {
		mut var_value := this.get_id()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('status'))) {
		var_value = this.get_status()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('post_data'))) {
		var_value = rt.new_null()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('delivery_url'))) {
		var_value = this.get_delivery_url()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('secret'))) {
		var_value = this.get_secret()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('topic'))) {
		var_value = this.get_topic()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('hooks'))) {
		var_value = this.get_hooks()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('resource'))) {
		var_value = this.get_resource()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('event'))) {
		var_value = this.get_event()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('failure_count'))) {
		var_value = this.get_failure_count()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('api_version'))) {
		var_value = this.get_api_version()
	} else {
		var_value = rt.new_string('')
	}
	return var_value.clone()
}

fn (mut this Class_WC_Legacy_Webhook) get_post_data() rt.PhpVal {
	rt.call_function('wc_deprecated_function', [
		rt.new_string('WC_Webhook::get_post_data'),
		rt.new_string('3.2'),
	])
	return rt.new_null()
}

fn (mut this Class_WC_Legacy_Webhook) update_status(var_status rt.PhpVal) {
	rt.call_function('wc_deprecated_function', [
		rt.new_string('WC_Webhook::update_status'),
		rt.new_string('3.2'),
		rt.new_string('WC_Webhook::set_status'),
	])
	this.set_status(var_status.clone())
	this.save()
}

struct Class_WC_Data {
	rt.PhpObjectBase
}

fn create_wc_legacy_webhook(_args ...rt.PhpVal) &Class_WC_Legacy_Webhook {
	mut obj := &Class_WC_Legacy_Webhook{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_data(_args ...rt.PhpVal) &Class_WC_Data {
	mut obj := &Class_WC_Data{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Legacy_Webhook) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__isset' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.magic_isset(dispatch_arg_0))
		}
		'__get' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.magic_get(dispatch_arg_0)
		}
		'get_post_data' {
			return this.get_post_data()
		}
		'update_status' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.update_status(dispatch_arg_0)
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_Legacy_Webhook) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Legacy_Webhook) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_Data) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Data) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Data) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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
