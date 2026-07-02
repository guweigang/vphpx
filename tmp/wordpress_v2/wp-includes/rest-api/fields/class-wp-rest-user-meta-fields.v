import rt

struct Class_WP_REST_User_Meta_Fields {
	rt.PhpObjectBase
}

fn (mut this Class_WP_REST_User_Meta_Fields) get_meta_type() string {
	return 'user'
}

fn (mut this Class_WP_REST_User_Meta_Fields) get_meta_subtype() string {
	return 'user'
}

fn (mut this Class_WP_REST_User_Meta_Fields) get_rest_field_type() string {
	return 'user'
}

struct Class_WP_REST_Meta_Fields {
	rt.PhpObjectBase
}

fn create_wp_rest_user_meta_fields(_args ...rt.PhpVal) &Class_WP_REST_User_Meta_Fields {
	mut obj := &Class_WP_REST_User_Meta_Fields{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_rest_meta_fields(_args ...rt.PhpVal) &Class_WP_REST_Meta_Fields {
	mut obj := &Class_WP_REST_Meta_Fields{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_REST_User_Meta_Fields) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_meta_type' {
			return rt.new_string(this.get_meta_type())
		}
		'get_meta_subtype' {
			return rt.new_string(this.get_meta_subtype())
		}
		'get_rest_field_type' {
			return rt.new_string(this.get_rest_field_type())
		}
		else {
			return none
		}
	}
}

fn (this &Class_WP_REST_User_Meta_Fields) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_REST_User_Meta_Fields) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WP_REST_Meta_Fields) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_REST_Meta_Fields) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_REST_Meta_Fields) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
