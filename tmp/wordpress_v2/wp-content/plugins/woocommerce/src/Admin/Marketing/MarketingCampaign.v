import rt

struct Class_Automattic_WooCommerce_Admin_Marketing_MarketingCampaign {
	rt.PhpObjectBase
pub mut:
		id string
		prop_type rt.PhpVal = rt.new_null()
		title string
		manage_url string
		cost rt.PhpVal = rt.new_null()
		sales rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Admin_Marketing_MarketingCampaign) construct(id string, mut var_type Class_Automattic_WooCommerce_Admin_Marketing_MarketingCampaignType, title string, manage_url string, mut var_cost Class_Automattic_WooCommerce_Admin_Marketing_?Price, mut var_sales Class_Automattic_WooCommerce_Admin_Marketing_?Price) {
	this.id = id
	this.prop_type = var_type
	this.title = title
	this.manage_url = manage_url
	this.cost = var_cost
	this.sales = var_sales
}

fn (mut this Class_Automattic_WooCommerce_Admin_Marketing_MarketingCampaign) get_id() string {
	return this.id
}

fn (mut this Class_Automattic_WooCommerce_Admin_Marketing_MarketingCampaign) get_type() rt.PhpVal {
	return this.prop_type
}

fn (mut this Class_Automattic_WooCommerce_Admin_Marketing_MarketingCampaign) get_title() string {
	return this.title
}

fn (mut this Class_Automattic_WooCommerce_Admin_Marketing_MarketingCampaign) get_manage_url() string {
	return this.manage_url
}

fn (mut this Class_Automattic_WooCommerce_Admin_Marketing_MarketingCampaign) get_cost() rt.PhpVal {
	return this.cost
}

fn (mut this Class_Automattic_WooCommerce_Admin_Marketing_MarketingCampaign) get_sales() rt.PhpVal {
	return this.sales
}

fn create_automattic_woocommerce_admin_marketing_marketingcampaign(id string, arg_1 rt.PhpVal, title string, manage_url string, arg_4 rt.PhpVal, arg_5 rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Marketing_MarketingCampaign {
	mut obj := &Class_Automattic_WooCommerce_Admin_Marketing_MarketingCampaign{
		PhpObjectBase: rt.PhpObjectBase{}
		id: ''
		prop_type: rt.new_null()
		title: ''
		manage_url: ''
		cost: rt.new_null()
		sales: rt.new_null()
	}
	obj.construct(id, arg_1, title, manage_url, arg_4, arg_5)
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_Marketing_MarketingCampaign) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Admin_Marketing_MarketingCampaignType](if args.len > 1 { args[1] } else { rt.new_null() })
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).str()
			mut dispatch_arg_4 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Admin_Marketing_?Price](if args.len > 4 { args[4] } else { rt.new_null() })
			mut dispatch_arg_5 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Admin_Marketing_?Price](if args.len > 5 { args[5] } else { rt.new_null() })
			this.construct(dispatch_arg_0, mut dispatch_arg_1, dispatch_arg_2, dispatch_arg_3, mut dispatch_arg_4, mut dispatch_arg_5)
			return rt.new_null()
		}
		'get_id' {
			return rt.new_string(this.get_id())
		}
		'get_type' {
			return this.get_type()
		}
		'get_title' {
			return rt.new_string(this.get_title())
		}
		'get_manage_url' {
			return rt.new_string(this.get_manage_url())
		}
		'get_cost' {
			return this.get_cost()
		}
		'get_sales' {
			return this.get_sales()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_Marketing_MarketingCampaign) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'id' { return rt.new_string(this.id) }
		'type' { return this.prop_type }
		'title' { return rt.new_string(this.title) }
		'manage_url' { return rt.new_string(this.manage_url) }
		'cost' { return this.cost }
		'sales' { return this.sales }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_Marketing_MarketingCampaign) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'id' { this.id = (val).str(); return true }
		'type' { this.prop_type = val; return true }
		'title' { this.title = (val).str(); return true }
		'manage_url' { this.manage_url = (val).str(); return true }
		'cost' { this.cost = val; return true }
		'sales' { this.sales = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}



fn main() {
	defer {
		rt.shutdown()
	}

}
