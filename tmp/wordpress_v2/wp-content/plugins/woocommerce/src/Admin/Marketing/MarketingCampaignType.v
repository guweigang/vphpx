import rt

struct Class_Automattic_WooCommerce_Admin_Marketing_MarketingCampaignType {
	rt.PhpObjectBase
pub mut:
	id          string
	channel     rt.PhpVal = rt.new_null()
	name        string
	description string
	create_url  string
	icon_url    string
}

fn (mut this Class_Automattic_WooCommerce_Admin_Marketing_MarketingCampaignType) construct(id string, mut var_channel Class_Automattic_WooCommerce_Admin_Marketing_MarketingChannelInterface, name string, description string, create_url string, icon_url string) {
	this.id = id
	this.channel = var_channel
	this.name = name
	this.description = description
	this.create_url = create_url
	this.icon_url = icon_url
}

fn (mut this Class_Automattic_WooCommerce_Admin_Marketing_MarketingCampaignType) get_id() string {
	return this.id
}

fn (mut this Class_Automattic_WooCommerce_Admin_Marketing_MarketingCampaignType) get_channel() rt.PhpVal {
	return this.channel
}

fn (mut this Class_Automattic_WooCommerce_Admin_Marketing_MarketingCampaignType) get_name() string {
	return this.name
}

fn (mut this Class_Automattic_WooCommerce_Admin_Marketing_MarketingCampaignType) get_description() string {
	return this.description
}

fn (mut this Class_Automattic_WooCommerce_Admin_Marketing_MarketingCampaignType) get_create_url() string {
	return this.create_url
}

fn (mut this Class_Automattic_WooCommerce_Admin_Marketing_MarketingCampaignType) get_icon_url() string {
	return this.icon_url
}

fn create_automattic_woocommerce_admin_marketing_marketingcampaigntype(id string, arg_1 rt.PhpVal, name string, description string, create_url string, icon_url string) &Class_Automattic_WooCommerce_Admin_Marketing_MarketingCampaignType {
	mut obj := &Class_Automattic_WooCommerce_Admin_Marketing_MarketingCampaignType{
		PhpObjectBase: rt.PhpObjectBase{}
		id:            ''
		channel:       rt.new_null()
		name:          ''
		description:   ''
		create_url:    ''
		icon_url:      ''
	}
	obj.construct(id, arg_1, name, description, create_url, icon_url)
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_Marketing_MarketingCampaignType) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Admin_Marketing_MarketingChannelInterface](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).str()
			dispatch_arg_4 := (if args.len > 4 { args[4] } else { rt.new_null() }).str()
			dispatch_arg_5 := (if args.len > 5 { args[5] } else { rt.new_null() }).str()
			this.construct(dispatch_arg_0, mut dispatch_arg_1, dispatch_arg_2, dispatch_arg_3,
				dispatch_arg_4, dispatch_arg_5)
			return rt.new_null()
		}
		'get_id' {
			return rt.new_string(this.get_id())
		}
		'get_channel' {
			return this.get_channel()
		}
		'get_name' {
			return rt.new_string(this.get_name())
		}
		'get_description' {
			return rt.new_string(this.get_description())
		}
		'get_create_url' {
			return rt.new_string(this.get_create_url())
		}
		'get_icon_url' {
			return rt.new_string(this.get_icon_url())
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_Marketing_MarketingCampaignType) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'id' { return rt.new_string(this.id) }
		'channel' { return this.channel }
		'name' { return rt.new_string(this.name) }
		'description' { return rt.new_string(this.description) }
		'create_url' { return rt.new_string(this.create_url) }
		'icon_url' { return rt.new_string(this.icon_url) }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_Marketing_MarketingCampaignType) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'id' {
			this.id = val.str()
			return true
		}
		'channel' {
			this.channel = val
			return true
		}
		'name' {
			this.name = val.str()
			return true
		}
		'description' {
			this.description = val.str()
			return true
		}
		'create_url' {
			this.create_url = val.str()
			return true
		}
		'icon_url' {
			this.icon_url = val.str()
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
