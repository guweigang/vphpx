import rt

struct Class_Automattic_WooCommerce_Admin_Marketing_MarketingChannels {
	rt.PhpObjectBase
pub mut:
	registered_channels rt.PhpVal = rt.new_array()
}

fn (mut this Class_Automattic_WooCommerce_Admin_Marketing_MarketingChannels) register(mut var_channel Class_Automattic_WooCommerce_Admin_Marketing_MarketingChannelInterface) {
	if this.registered_channels.array_isset(var_channel.get_slug()) {
		rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.call_function('__', [
			rt.new_string('Marketing channel cannot be registered because there is already a channel registered with the same slug!'),
			rt.new_string('woocommerce'),
		]))))
	}
	this.registered_channels.array_set(var_channel.get_slug(), var_channel.dup())
}

fn (mut this Class_Automattic_WooCommerce_Admin_Marketing_MarketingChannels) unregister_all() {
	this.registered_channels = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Admin_Marketing_MarketingChannels) get_registered_channels() rt.PhpVal {
	mut var_channels := rt.call_function('apply_filters', [
		rt.new_string('woocommerce_marketing_channels'),
		this.registered_channels,
	])
	return rt.call_function('array_values', [var_channels.dup()])
}

struct Class_Exception {
	rt.PhpObjectBase
pub mut:
	message string
	code    i64
	file    string
	line    i64
}

fn (mut this Class_Exception) construct(var_message rt.PhpVal) {
	this.message = var_message.to_string()
}

fn (mut this Class_Exception) getmessage() string {
	return this.message
}

fn create_automattic_woocommerce_admin_marketing_marketingchannels() &Class_Automattic_WooCommerce_Admin_Marketing_MarketingChannels {
	mut obj := &Class_Automattic_WooCommerce_Admin_Marketing_MarketingChannels{
		PhpObjectBase:       rt.PhpObjectBase{}
		registered_channels: rt.new_array()
	}
	return obj
}

fn create_exception(arg_0 rt.PhpVal) &Class_Exception {
	mut obj := &Class_Exception{
		PhpObjectBase: rt.PhpObjectBase{}
		message:       ''
		code:          i64(0)
		file:          ''
		line:          i64(0)
	}
	obj.construct(arg_0)
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_Marketing_MarketingChannels) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'register' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Admin_Marketing_MarketingChannelInterface](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.register(mut dispatch_arg_0)
			return rt.new_null()
		}
		'unregister_all' {
			this.unregister_all()
			return rt.new_null()
		}
		'get_registered_channels' {
			return this.get_registered_channels()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_Marketing_MarketingChannels) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'registered_channels' { return this.registered_channels }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_Marketing_MarketingChannels) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'registered_channels' {
			this.registered_channels = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_Exception) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'getMessage' {
			return rt.new_string(this.getmessage())
		}
		else {
			return none
		}
	}
}

fn (this &Class_Exception) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'message' { return rt.new_string(this.message) }
		'code' { return rt.new_int(this.code) }
		'file' { return rt.new_string(this.file) }
		'line' { return rt.new_int(this.line) }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Exception) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'message' {
			this.message = val.str()
			return true
		}
		'code' {
			this.code = val.to_i64()
			return true
		}
		'file' {
			this.file = val.str()
			return true
		}
		'line' {
			this.line = val.to_i64()
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

pub fn init_wp_content_plugins_woocommerce_src_admin_marketing_marketingchannels_php() {
}
