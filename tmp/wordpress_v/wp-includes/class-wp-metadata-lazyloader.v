import rt

struct Class_WP_Metadata_Lazyloader {
	rt.PhpObjectBase
pub mut:
	pending_objects rt.PhpVal = rt.new_null()
	settings        rt.PhpVal = rt.new_array()
}

fn (mut this Class_WP_Metadata_Lazyloader) construct() {
	this.settings = rt.create_array([
		rt.ArrayItem{ key: 'term', val: rt.create_array([
			rt.ArrayItem{ key: 'filter', val: 'get_term_metadata' },
			rt.ArrayItem{ key: 'callback', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('WP_Metadata_Lazyloader', []string{},
					&this) },
				rt.ArrayItem{ key: none, val: 'lazyload_meta_callback' },
			]) },
		]) },
		rt.ArrayItem{ key: 'comment', val: rt.create_array([
			rt.ArrayItem{ key: 'filter', val: 'get_comment_metadata' },
			rt.ArrayItem{ key: 'callback', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('WP_Metadata_Lazyloader', []string{},
					&this) },
				rt.ArrayItem{ key: none, val: 'lazyload_meta_callback' },
			]) },
		]) },
		rt.ArrayItem{ key: 'blog', val: rt.create_array([
			rt.ArrayItem{ key: 'filter', val: 'get_blog_metadata' },
			rt.ArrayItem{ key: 'callback', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('WP_Metadata_Lazyloader', []string{},
					&this) },
				rt.ArrayItem{ key: none, val: 'lazyload_meta_callback' },
			]) },
		]) },
	])
}

fn (mut this Class_WP_Metadata_Lazyloader) queue_objects(var_object_type rt.PhpVal, var_object_ids rt.PhpVal) rt.PhpVal {
	mut var_object_ids_mutated := var_object_ids
	if !(this.settings.array_isset(var_object_type)) {
		return create_wp_error(rt.new_string('invalid_object_type'), rt.call_function('__', [
			rt.new_string('Invalid object type.'),
		]))
	}
	mut var_type_settings := this.settings.array_get(var_object_type)
	if !(this.pending_objects.array_isset(var_object_type)) {
		this.pending_objects.array_set(var_object_type, rt.new_array())
	}
	{
		mut iter_1 := var_object_ids_mutated.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_object_id := item_1.val
			if !(this.pending_objects.array_get(var_object_type).array_isset(var_object_id)) {
				this.pending_objects.array_get_mut(var_object_type).array_set(var_object_id, 1)
			}
		}
	}
	rt.call_function('add_filter', [var_type_settings.array_get('filter'),
		var_type_settings.array_get('callback'), rt.new_int(10),
		rt.new_int(5)])
	rt.call_function('do_action', [rt.new_string('metadata_lazyloader_queued_objects'),
		var_object_ids_mutated.dup(), var_object_type.dup(),
		rt.new_object('WP_Metadata_Lazyloader',
			[]string{}, &this)])
	return rt.new_null()
}

fn (mut this Class_WP_Metadata_Lazyloader) reset_queue(var_object_type rt.PhpVal) rt.PhpVal {
	if !(this.settings.array_isset(var_object_type)) {
		return create_wp_error(rt.new_string('invalid_object_type'), rt.call_function('__', [
			rt.new_string('Invalid object type.'),
		]))
	}
	mut var_type_settings := this.settings.array_get(var_object_type)
	this.pending_objects.array_set(var_object_type, rt.new_array())
	rt.call_function('remove_filter', [var_type_settings.array_get('filter'),
		var_type_settings.array_get('callback')])
	return rt.new_null()
}

fn (mut this Class_WP_Metadata_Lazyloader) lazyload_term_meta(var_check rt.PhpVal) rt.PhpVal {
	rt.call_function('_deprecated_function', [rt.new_string(@METHOD),
		rt.new_string('6.3.0'), rt.new_string('WP_Metadata_Lazyloader::lazyload_meta_callback')])
	return this.lazyload_meta_callback(var_check.dup(), rt.new_int(0), rt.new_string(''),
		rt.new_bool(false), rt.new_string('term'))
}

fn (mut this Class_WP_Metadata_Lazyloader) lazyload_comment_meta(var_check rt.PhpVal) rt.PhpVal {
	rt.call_function('_deprecated_function', [rt.new_string(@METHOD),
		rt.new_string('6.3.0'), rt.new_string('WP_Metadata_Lazyloader::lazyload_meta_callback')])
	return this.lazyload_meta_callback(var_check.dup(), rt.new_int(0), rt.new_string(''),
		rt.new_bool(false), rt.new_string('comment'))
}

fn (mut this Class_WP_Metadata_Lazyloader) lazyload_meta_callback(var_check rt.PhpVal, var_object_id rt.PhpVal, var_meta_key rt.PhpVal, var_single rt.PhpVal, var_meta_type rt.PhpVal) rt.PhpVal {
	if !rt.is_true(this.pending_objects.array_get(var_meta_type)) {
		return var_check.dup()
	}
	mut var_object_ids := rt.func_array_keys(this.pending_objects.array_get(var_meta_type))
	if rt.is_true(rt.new_bool(rt.is_true(var_object_id)
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_object_id.dup(), var_object_ids.dup(), rt.new_bool(true)])))))))
	{
		var_object_ids.array_push(var_object_id.dup())
	}
	rt.call_function('update_meta_cache', [var_meta_type.dup(),
		var_object_ids.dup()])
	this.reset_queue(var_meta_type.dup())
	return var_check.dup()
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

fn create_wp_metadata_lazyloader() &Class_WP_Metadata_Lazyloader {
	mut obj := &Class_WP_Metadata_Lazyloader{
		PhpObjectBase:   rt.PhpObjectBase{}
		pending_objects: rt.new_null()
		settings:        rt.new_array()
	}
	obj.construct()
	return obj
}

fn create_wp_error() &Class_WP_Error {
	mut obj := &Class_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Metadata_Lazyloader) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'queue_objects' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.queue_objects(dispatch_arg_0, dispatch_arg_1)
		}
		'reset_queue' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.reset_queue(dispatch_arg_0)
		}
		'lazyload_term_meta' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.lazyload_term_meta(dispatch_arg_0)
		}
		'lazyload_comment_meta' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.lazyload_comment_meta(dispatch_arg_0)
		}
		'lazyload_meta_callback' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			dispatch_arg_4 := if args.len > 4 { args[4] } else { rt.new_null() }
			return this.lazyload_meta_callback(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2,
				dispatch_arg_3, dispatch_arg_4)
		}
		else {
			return none
		}
	}
}

fn (this &Class_WP_Metadata_Lazyloader) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'pending_objects' { return this.pending_objects }
		'settings' { return this.settings }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_Metadata_Lazyloader) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'pending_objects' {
			this.pending_objects = val
			return true
		}
		'settings' {
			this.settings = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
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

pub fn init_wp_includes_class_wp_metadata_lazyloader_php() {
}
