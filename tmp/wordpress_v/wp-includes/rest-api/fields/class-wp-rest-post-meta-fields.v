import rt

struct Class_WP_REST_Post_Meta_Fields {
	rt.PhpObjectBase
pub mut:
	post_type rt.PhpVal = rt.new_null()
}

fn (mut this Class_WP_REST_Post_Meta_Fields) construct(var_post_type rt.PhpVal) {
	this.post_type = var_post_type.dup()
}

fn (mut this Class_WP_REST_Post_Meta_Fields) get_meta_type() string {
	return 'post'
}

fn (mut this Class_WP_REST_Post_Meta_Fields) get_meta_subtype() rt.PhpVal {
	return this.post_type
}

fn (mut this Class_WP_REST_Post_Meta_Fields) get_rest_field_type() rt.PhpVal {
	return this.post_type
}

struct Class_WP_REST_Meta_Fields {
	rt.PhpObjectBase
}

fn create_wp_rest_post_meta_fields(arg_0 rt.PhpVal) &Class_WP_REST_Post_Meta_Fields {
	mut obj := &Class_WP_REST_Post_Meta_Fields{
		PhpObjectBase: rt.PhpObjectBase{}
		post_type:     rt.new_null()
	}
	obj.construct(arg_0)
	return obj
}

fn create_wp_rest_meta_fields() &Class_WP_REST_Meta_Fields {
	mut obj := &Class_WP_REST_Meta_Fields{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_REST_Post_Meta_Fields) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'get_meta_type' {
			return rt.new_string(this.get_meta_type())
		}
		'get_meta_subtype' {
			return this.get_meta_subtype()
		}
		'get_rest_field_type' {
			return this.get_rest_field_type()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WP_REST_Post_Meta_Fields) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'post_type' { return this.post_type }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_REST_Post_Meta_Fields) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'post_type' {
			this.post_type = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
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

pub fn init_wp_includes_rest_api_fields_class_wp_rest_post_meta_fields_php() {
}
