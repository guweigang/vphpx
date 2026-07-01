import rt

struct Class_WP_Font_Library {
	rt.PhpObjectBase
pub mut:
		collections rt.PhpVal = rt.new_array()
		instance rt.PhpVal = rt.new_null()
}

fn (mut this Class_WP_Font_Library) register_font_collection(slug string, mut var_args Class_array) rt.PhpVal {
	mut var_new_collection := create_wp_font_collection(rt.new_string(slug).dup(), var_args.dup())
	if this.is_collection_registered((rt.get_property(var_new_collection, 'slug')).str()) {
		mut var_error_message := rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Font collection with slug: "%s" is already registered.')]), rt.get_property(var_new_collection, 'slug')])
		rt.call_function('_doing_it_wrong', [rt.new_string(@METHOD), var_error_message.dup(), rt.new_string('6.5.0')])
		return mut rt.cast_object_ptr[Class_WP_Font_Collection](create_wp_error(rt.new_string('font_collection_registration_error'), var_error_message.dup()))
	}
	this.collections.array_set(rt.get_property(var_new_collection, 'slug'), var_new_collection.dup())
	return mut var_new_collection
}

fn (mut this Class_WP_Font_Library) unregister_font_collection(slug string) bool {
	if !(this.is_collection_registered(slug)) {
		rt.call_function('_doing_it_wrong', [rt.new_string(@METHOD), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Font collection "%s" not found.')]), rt.new_string(slug)]), rt.new_string('6.5.0')])
		return false
	}
	this.collections.array_unset(rt.new_string(slug))
	return true
}

fn (mut this Class_WP_Font_Library) is_collection_registered(slug string) bool {
	return this.collections.array_isset(rt.new_string(slug))
}

fn (mut this Class_WP_Font_Library) get_font_collections() rt.PhpVal {
	return this.collections
}

fn (mut this Class_WP_Font_Library) get_font_collection(slug string) rt.PhpVal {
	if this.is_collection_registered(slug) {
		return this.collections.array_get(slug)
	}
	return rt.new_null()
}

fn Class_WP_Font_Library.get_instance() rt.PhpVal {
	if rt.is_true(rt.identical(rt.new_null(), // unsupported expression: Expr_StaticPropertyFetch)) {
		// unsupported assign target: Expr_StaticPropertyFetch
	}
	return // unsupported expression: Expr_StaticPropertyFetch
}

struct Class_WP_Font_Collection {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

fn create_wp_font_library() &Class_WP_Font_Library {
	mut obj := &Class_WP_Font_Library{
		PhpObjectBase: rt.PhpObjectBase{}
		collections: rt.new_array()
		instance: rt.new_null()
	}
	return obj
}

fn create_wp_font_collection() &Class_WP_Font_Collection {
	mut obj := &Class_WP_Font_Collection{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_error() &Class_WP_Error {
	mut obj := &Class_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Font_Library) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'register_font_collection' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_array](if args.len > 1 { args[1] } else { rt.new_null() })
			return this.register_font_collection(dispatch_arg_0, mut dispatch_arg_1)
		}
		'unregister_font_collection' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(this.unregister_font_collection(dispatch_arg_0))
		}
		'is_collection_registered' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(this.is_collection_registered(dispatch_arg_0))
		}
		'get_font_collections' {
			return this.get_font_collections()
		}
		'get_font_collection' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_font_collection(dispatch_arg_0)
		}
		'get_instance' {
			return Class_WP_Font_Library.get_instance()
		}
		else { return none }
	}
}

fn (this &Class_WP_Font_Library) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'collections' { return this.collections }
		'instance' { return this.instance }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_Font_Library) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'collections' { this.collections = val; return true }
		'instance' { this.instance = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_WP_Font_Collection) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Font_Collection) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Font_Collection) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_Error) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Error) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Error) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_includes_fonts_class_wp_font_library_php() {
}
