import rt

struct Class_Automattic_WooCommerce_Api_Pagination_PageInfo {
	rt.PhpObjectBase
pub mut:
	has_next_page     rt.PhpVal = rt.new_null()
	has_previous_page rt.PhpVal = rt.new_null()
	start_cursor      rt.PhpVal = rt.new_null()
	end_cursor        rt.PhpVal = rt.new_null()
}

fn create_automattic_woocommerce_api_pagination_pageinfo() &Class_Automattic_WooCommerce_Api_Pagination_PageInfo {
	mut obj := &Class_Automattic_WooCommerce_Api_Pagination_PageInfo{
		PhpObjectBase:     rt.PhpObjectBase{}
		has_next_page:     rt.new_null()
		has_previous_page: rt.new_null()
		start_cursor:      rt.new_null()
		end_cursor:        rt.new_null()
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Api_Pagination_PageInfo) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Api_Pagination_PageInfo) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'has_next_page' { return this.has_next_page }
		'has_previous_page' { return this.has_previous_page }
		'start_cursor' { return this.start_cursor }
		'end_cursor' { return this.end_cursor }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Api_Pagination_PageInfo) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'has_next_page' {
			this.has_next_page = val
			return true
		}
		'has_previous_page' {
			this.has_previous_page = val
			return true
		}
		'start_cursor' {
			this.start_cursor = val
			return true
		}
		'end_cursor' {
			this.end_cursor = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

pub fn init_wp_content_plugins_woocommerce_src_api_pagination_pageinfo_php() {
	// unsupported statement: Stmt_Declare
}
