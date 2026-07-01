import rt

struct Class_WP_Site_Icon {
	rt.PhpObjectBase
pub mut:
		min_size rt.PhpVal = rt.new_int(512)
		page_crop rt.PhpVal = rt.new_int(512)
		site_icon_sizes rt.PhpVal = rt.new_array()
}

fn (mut this Class_WP_Site_Icon) construct()  {
	rt.call_function('add_action', [rt.new_string('delete_attachment'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Site_Icon', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'delete_attachment_data' }])])
	rt.call_function('add_filter', [rt.new_string('get_post_metadata'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Site_Icon', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'get_post_metadata' }]), rt.new_int(10), rt.new_int(4)])
}

fn (mut this Class_WP_Site_Icon) create_attachment_object(var_cropped rt.PhpVal, var_parent_attachment_id rt.PhpVal) rt.PhpVal {
	rt.call_function('_deprecated_function', [rt.new_string(@METHOD), rt.new_string('6.5.0'), rt.new_string('wp_copy_parent_attachment_properties()')])
	mut var_parent := rt.call_function('get_post', [var_parent_attachment_id.dup()])
	mut var_parent_url := rt.call_function('wp_get_attachment_url', [rt.get_property(var_parent, 'ID')])
	mut var_url := rt.call_function('str_replace', [rt.call_function('wp_basename', [var_parent_url.dup()]), rt.call_function('wp_basename', [var_cropped.dup()]), var_parent_url.dup()])
	mut var_size := rt.call_function('wp_getimagesize', [var_cropped.dup()])
	mut var_image_type := if rt.is_true(var_size) { var_size.array_get('mime') } else { rt.new_string('image/jpeg') }
	mut var_attachment := { 'ID': var_parent_attachment_id, 'post_title': rt.call_function('wp_basename', [var_cropped.dup()]), 'post_content': var_url, 'post_mime_type': var_image_type, 'guid': var_url, 'context': rt.new_string('site-icon') }
	return var_attachment.dup()
}

fn (mut this Class_WP_Site_Icon) insert_attachment(var_attachment rt.PhpVal, var_file rt.PhpVal) rt.PhpVal {
	mut var_attachment_mutated := var_attachment
	mut var_attachment_id := rt.call_function('wp_insert_attachment', [var_attachment_mutated.dup(), var_file.dup()])
	mut var_metadata := rt.call_function('wp_generate_attachment_metadata', [var_attachment_id.dup(), var_file.dup()])
	var_metadata = rt.call_function('apply_filters', [rt.new_string('site_icon_attachment_metadata'), var_metadata.dup()])
	rt.call_function('wp_update_attachment_metadata', [var_attachment_id.dup(), var_metadata.dup()])
	return var_attachment_id.dup()
}

fn (mut this Class_WP_Site_Icon) additional_sizes(var_sizes rt.PhpVal) rt.PhpVal {
	mut var_sizes_mutated := var_sizes
	mut var_only_crop_sizes := rt.new_array()
	this.site_icon_sizes = rt.call_function('apply_filters', [rt.new_string('site_icon_image_sizes'), this.site_icon_sizes])
	rt.call_function('natsort', [this.site_icon_sizes])
	this.site_icon_sizes = rt.call_function('array_reverse', [this.site_icon_sizes])
	{
		mut iter_1 := var_sizes_mutated.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_size_array := item_1.val
			mut var_name := item_1.key
			if var_size_array.array_isset(rt.new_string('crop')) {
				var_only_crop_sizes.array_set(var_name, var_size_array.dup())
			}
		}
	}
	{
		mut iter_1 := this.site_icon_sizes.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_size := item_1.val
			if rt.is_true(rt.less(var_size, this.min_size)) {
				var_only_crop_sizes.array_set('site_icon-' + (var_size).str(), rt.create_array([rt.ArrayItem{ key: 'width ', val: var_size }, rt.ArrayItem{ key: 'height', val: var_size }, rt.ArrayItem{ key: 'crop', val: true }]))
			}
		}
	}
	return var_only_crop_sizes.dup()
}

fn (mut this Class_WP_Site_Icon) intermediate_image_sizes(var_sizes rt.PhpVal) rt.PhpVal {
	mut var_sizes_mutated := var_sizes
	this.site_icon_sizes = rt.call_function('apply_filters', [rt.new_string('site_icon_image_sizes'), this.site_icon_sizes])
	{
		mut iter_1 := this.site_icon_sizes.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_size := item_1.val
			var_sizes_mutated.array_push('site_icon-' + (var_size).str())
		}
	}
	return var_sizes_mutated.dup()
}

fn (mut this Class_WP_Site_Icon) delete_attachment_data(var_post_id rt.PhpVal)  {
	mut var_site_icon_id := // unsupported expression: Expr_Cast_Int
	if rt.is_true(rt.new_bool(rt.is_true(var_site_icon_id) && rt.is_true(rt.identical(var_post_id, var_site_icon_id)))) {
		rt.call_function('delete_option', [rt.new_string('site_icon')])
	}
}

fn (mut this Class_WP_Site_Icon) get_post_metadata(var_value rt.PhpVal, var_post_id rt.PhpVal, var_meta_key rt.PhpVal, var_single rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.new_bool(rt.is_true(var_single) && rt.is_true(rt.identical(rt.new_string('_wp_attachment_backup_sizes'), var_meta_key)))) {
		mut var_site_icon_id := // unsupported expression: Expr_Cast_Int
		if rt.is_true(rt.identical(var_post_id, var_site_icon_id)) {
			rt.call_function('add_filter', [rt.new_string('intermediate_image_sizes'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Site_Icon', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'intermediate_image_sizes' }])])
		}
	}
	return var_value.dup()
}

fn create_wp_site_icon() &Class_WP_Site_Icon {
	mut obj := &Class_WP_Site_Icon{
		PhpObjectBase: rt.PhpObjectBase{}
		min_size: rt.new_int(512)
		page_crop: rt.new_int(512)
		site_icon_sizes: rt.new_array()
	}
	obj.construct()
	return obj
}

fn (mut this Class_WP_Site_Icon) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'create_attachment_object' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.create_attachment_object(dispatch_arg_0, dispatch_arg_1)
		}
		'insert_attachment' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.insert_attachment(dispatch_arg_0, dispatch_arg_1)
		}
		'additional_sizes' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.additional_sizes(dispatch_arg_0)
		}
		'intermediate_image_sizes' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.intermediate_image_sizes(dispatch_arg_0)
		}
		'delete_attachment_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.delete_attachment_data(dispatch_arg_0)
			return rt.new_null()
		}
		'get_post_metadata' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			return this.get_post_metadata(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
		}
		else { return none }
	}
}

fn (this &Class_WP_Site_Icon) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'min_size' { return this.min_size }
		'page_crop' { return this.page_crop }
		'site_icon_sizes' { return this.site_icon_sizes }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_Site_Icon) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'min_size' { this.min_size = val; return true }
		'page_crop' { this.page_crop = val; return true }
		'site_icon_sizes' { this.site_icon_sizes = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}




pub fn init_wp_admin_includes_class_wp_site_icon_php() {
}
