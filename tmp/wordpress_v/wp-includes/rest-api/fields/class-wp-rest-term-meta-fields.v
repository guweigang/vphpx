import rt

struct Class_WP_REST_Term_Meta_Fields {
	rt.PhpObjectBase
pub mut:
	taxonomy rt.PhpVal = rt.new_null()
}

fn (mut this Class_WP_REST_Term_Meta_Fields) construct(var_taxonomy rt.PhpVal) {
	this.taxonomy = var_taxonomy.dup()
}

fn (mut this Class_WP_REST_Term_Meta_Fields) get_meta_type() string {
	return 'term'
}

fn (mut this Class_WP_REST_Term_Meta_Fields) get_meta_subtype() rt.PhpVal {
	return this.taxonomy
}

fn (mut this Class_WP_REST_Term_Meta_Fields) get_rest_field_type() rt.PhpVal {
	return if rt.is_true(rt.identical(rt.new_string('post_tag'), this.taxonomy)) {
		rt.new_string('tag')
	} else {
		this.taxonomy
	}
}

struct Class_WP_REST_Meta_Fields {
	rt.PhpObjectBase
}

fn create_wp_rest_term_meta_fields(arg_0 rt.PhpVal) &Class_WP_REST_Term_Meta_Fields {
	mut obj := &Class_WP_REST_Term_Meta_Fields{
		PhpObjectBase: rt.PhpObjectBase{}
		taxonomy:      rt.new_null()
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

fn (mut this Class_WP_REST_Term_Meta_Fields) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
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

fn (this &Class_WP_REST_Term_Meta_Fields) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'taxonomy' { return this.taxonomy }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_REST_Term_Meta_Fields) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'taxonomy' {
			this.taxonomy = val
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

pub fn init_wp_includes_rest_api_fields_class_wp_rest_term_meta_fields_php() {
}
