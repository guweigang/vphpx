import rt

struct Class_Automattic_WooCommerce_Api_Pagination_Edge {
	rt.PhpObjectBase
pub mut:
	cursor rt.PhpVal = rt.new_null()
	node   rt.PhpVal = rt.new_null()
}

fn create_automattic_woocommerce_api_pagination_edge() &Class_Automattic_WooCommerce_Api_Pagination_Edge {
	mut obj := &Class_Automattic_WooCommerce_Api_Pagination_Edge{
		PhpObjectBase: rt.PhpObjectBase{}
		cursor:        rt.new_null()
		node:          rt.new_null()
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Api_Pagination_Edge) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Api_Pagination_Edge) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'cursor' { return this.cursor }
		'node' { return this.node }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Api_Pagination_Edge) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'cursor' {
			this.cursor = val
			return true
		}
		'node' {
			this.node = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

pub fn init_wp_content_plugins_woocommerce_src_api_pagination_edge_php() {
	// unsupported statement: Stmt_Declare
}
