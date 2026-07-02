import rt

pub fn Class_WP_REST_Search_Handler.result_ids() string {
	return 'ids'
}

pub fn Class_WP_REST_Search_Handler.result_total() string {
	return 'total'
}

struct Class_WP_REST_Search_Handler {
	rt.PhpObjectBase
pub mut:
	prop_type rt.PhpVal = rt.new_string('')
	subtypes  rt.PhpVal = rt.new_array()
}

fn (mut this Class_WP_REST_Search_Handler) get_type() rt.PhpVal {
	return this.prop_type
}

fn (mut this Class_WP_REST_Search_Handler) get_subtypes() rt.PhpVal {
	return this.subtypes
}

fn (mut this Class_WP_REST_Search_Handler) search_items(mut var_request Class_WP_REST_Request) {
}

fn (mut this Class_WP_REST_Search_Handler) prepare_item(var_id rt.PhpVal, mut var_fields Class_array) {
}

fn (mut this Class_WP_REST_Search_Handler) prepare_item_links(var_id rt.PhpVal) {
}

fn create_wp_rest_search_handler(_args ...rt.PhpVal) &Class_WP_REST_Search_Handler {
	mut obj := &Class_WP_REST_Search_Handler{
		PhpObjectBase: rt.PhpObjectBase{}
		prop_type:     rt.new_string('')
		subtypes:      rt.new_array()
	}
	return obj
}

fn (mut this Class_WP_REST_Search_Handler) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_type' {
			return this.get_type()
		}
		'get_subtypes' {
			return this.get_subtypes()
		}
		'search_items' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_REST_Request](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.search_items(mut dispatch_arg_0)
			return rt.new_null()
		}
		'prepare_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_array](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			this.prepare_item(dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'prepare_item_links' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.prepare_item_links(dispatch_arg_0)
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WP_REST_Search_Handler) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'type' { return this.prop_type }
		'subtypes' { return this.subtypes }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_REST_Search_Handler) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'type' {
			this.prop_type = val
			return true
		}
		'subtypes' {
			this.subtypes = val
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
