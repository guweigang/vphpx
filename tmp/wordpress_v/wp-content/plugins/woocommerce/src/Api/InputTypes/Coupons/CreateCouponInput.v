import rt

struct Class_Automattic_WooCommerce_Api_InputTypes_Coupons_CreateCouponInput {
	rt.PhpObjectBase
pub mut:
	code                        rt.PhpVal = rt.new_null()
	description                 rt.PhpVal = rt.new_null()
	discount_type               rt.PhpVal = rt.new_null()
	amount                      rt.PhpVal = rt.new_null()
	status                      rt.PhpVal = rt.new_null()
	date_expires                rt.PhpVal = rt.new_null()
	individual_use              rt.PhpVal = rt.new_null()
	product_ids                 rt.PhpVal = rt.new_null()
	excluded_product_ids        rt.PhpVal = rt.new_null()
	usage_limit                 rt.PhpVal = rt.new_null()
	usage_limit_per_user        rt.PhpVal = rt.new_null()
	limit_usage_to_x_items      rt.PhpVal = rt.new_null()
	free_shipping               rt.PhpVal = rt.new_null()
	product_categories          rt.PhpVal = rt.new_null()
	excluded_product_categories rt.PhpVal = rt.new_null()
	exclude_sale_items          rt.PhpVal = rt.new_null()
	minimum_amount              rt.PhpVal = rt.new_null()
	maximum_amount              rt.PhpVal = rt.new_null()
	email_restrictions          rt.PhpVal = rt.new_null()
}

fn create_automattic_woocommerce_api_inputtypes_coupons_createcouponinput() &Class_Automattic_WooCommerce_Api_InputTypes_Coupons_CreateCouponInput {
	mut obj := &Class_Automattic_WooCommerce_Api_InputTypes_Coupons_CreateCouponInput{
		PhpObjectBase:               rt.PhpObjectBase{}
		code:                        rt.new_null()
		description:                 rt.new_null()
		discount_type:               rt.new_null()
		amount:                      rt.new_null()
		status:                      rt.new_null()
		date_expires:                rt.new_null()
		individual_use:              rt.new_null()
		product_ids:                 rt.new_null()
		excluded_product_ids:        rt.new_null()
		usage_limit:                 rt.new_null()
		usage_limit_per_user:        rt.new_null()
		limit_usage_to_x_items:      rt.new_null()
		free_shipping:               rt.new_null()
		product_categories:          rt.new_null()
		excluded_product_categories: rt.new_null()
		exclude_sale_items:          rt.new_null()
		minimum_amount:              rt.new_null()
		maximum_amount:              rt.new_null()
		email_restrictions:          rt.new_null()
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Api_InputTypes_Coupons_CreateCouponInput) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Api_InputTypes_Coupons_CreateCouponInput) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'code' { return this.code }
		'description' { return this.description }
		'discount_type' { return this.discount_type }
		'amount' { return this.amount }
		'status' { return this.status }
		'date_expires' { return this.date_expires }
		'individual_use' { return this.individual_use }
		'product_ids' { return this.product_ids }
		'excluded_product_ids' { return this.excluded_product_ids }
		'usage_limit' { return this.usage_limit }
		'usage_limit_per_user' { return this.usage_limit_per_user }
		'limit_usage_to_x_items' { return this.limit_usage_to_x_items }
		'free_shipping' { return this.free_shipping }
		'product_categories' { return this.product_categories }
		'excluded_product_categories' { return this.excluded_product_categories }
		'exclude_sale_items' { return this.exclude_sale_items }
		'minimum_amount' { return this.minimum_amount }
		'maximum_amount' { return this.maximum_amount }
		'email_restrictions' { return this.email_restrictions }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Api_InputTypes_Coupons_CreateCouponInput) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'code' {
			this.code = val
			return true
		}
		'description' {
			this.description = val
			return true
		}
		'discount_type' {
			this.discount_type = val
			return true
		}
		'amount' {
			this.amount = val
			return true
		}
		'status' {
			this.status = val
			return true
		}
		'date_expires' {
			this.date_expires = val
			return true
		}
		'individual_use' {
			this.individual_use = val
			return true
		}
		'product_ids' {
			this.product_ids = val
			return true
		}
		'excluded_product_ids' {
			this.excluded_product_ids = val
			return true
		}
		'usage_limit' {
			this.usage_limit = val
			return true
		}
		'usage_limit_per_user' {
			this.usage_limit_per_user = val
			return true
		}
		'limit_usage_to_x_items' {
			this.limit_usage_to_x_items = val
			return true
		}
		'free_shipping' {
			this.free_shipping = val
			return true
		}
		'product_categories' {
			this.product_categories = val
			return true
		}
		'excluded_product_categories' {
			this.excluded_product_categories = val
			return true
		}
		'exclude_sale_items' {
			this.exclude_sale_items = val
			return true
		}
		'minimum_amount' {
			this.minimum_amount = val
			return true
		}
		'maximum_amount' {
			this.maximum_amount = val
			return true
		}
		'email_restrictions' {
			this.email_restrictions = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

pub fn init_wp_content_plugins_woocommerce_src_api_inputtypes_coupons_createcouponinput_php() {
	// unsupported statement: Stmt_Declare
}
