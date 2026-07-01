import rt

struct Class_Automattic_WooCommerce_Api_Types_Products_ProductReview {
	rt.PhpObjectBase
pub mut:
	id           rt.PhpVal = rt.new_null()
	product_id   rt.PhpVal = rt.new_null()
	reviewer     rt.PhpVal = rt.new_null()
	review       rt.PhpVal = rt.new_null()
	rating       rt.PhpVal = rt.new_null()
	date_created rt.PhpVal = rt.new_null()
}

fn create_automattic_woocommerce_api_types_products_productreview() &Class_Automattic_WooCommerce_Api_Types_Products_ProductReview {
	mut obj := &Class_Automattic_WooCommerce_Api_Types_Products_ProductReview{
		PhpObjectBase: rt.PhpObjectBase{}
		id:            rt.new_null()
		product_id:    rt.new_null()
		reviewer:      rt.new_null()
		review:        rt.new_null()
		rating:        rt.new_null()
		date_created:  rt.new_null()
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Api_Types_Products_ProductReview) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Api_Types_Products_ProductReview) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'id' { return this.id }
		'product_id' { return this.product_id }
		'reviewer' { return this.reviewer }
		'review' { return this.review }
		'rating' { return this.rating }
		'date_created' { return this.date_created }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Api_Types_Products_ProductReview) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'id' {
			this.id = val
			return true
		}
		'product_id' {
			this.product_id = val
			return true
		}
		'reviewer' {
			this.reviewer = val
			return true
		}
		'review' {
			this.review = val
			return true
		}
		'rating' {
			this.rating = val
			return true
		}
		'date_created' {
			this.date_created = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

pub fn init_wp_content_plugins_woocommerce_src_api_types_products_productreview_php() {
	// unsupported statement: Stmt_Declare
}
