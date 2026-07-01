import rt

pub fn Class_WP_Customize_Nav_Menu_Item_Setting.id_pattern() string {
	return '/^nav_menu_item\\[(?P<id>-?\\d+)\\]$/'
}
pub fn Class_WP_Customize_Nav_Menu_Item_Setting.post_type() string {
	return 'nav_menu_item'
}
pub fn Class_WP_Customize_Nav_Menu_Item_Setting.type() string {
	return 'nav_menu_item'
}
struct Class_WP_Customize_Nav_Menu_Item_Setting {
	rt.PhpObjectBase
pub mut:
		prop_type rt.PhpVal = rt.new_null()
		default rt.PhpVal = rt.new_array()
		transport rt.PhpVal = rt.new_string('refresh')
		post_id rt.PhpVal = rt.new_null()
		value rt.PhpVal = rt.new_null()
		previous_post_id rt.PhpVal = rt.new_null()
		original_nav_menu_term_id rt.PhpVal = rt.new_null()
		is_updated bool
		update_status string
		update_error rt.PhpVal = rt.new_null()
}

fn (mut this Class_WP_Customize_Nav_Menu_Item_Setting) construct(mut var_manager Class_WP_Customize_Manager, var_id rt.PhpVal, mut var_args Class_array)  {
	mut var_matches := map[string]rt.PhpVal{}
	if !rt.is_true(rt.get_property(var_manager, 'nav_menus')) {
		rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.new_string('Expected WP_Customize_Manager::$nav_menus to be set.'))))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('preg_match', [Class_WP_Customize_Nav_Menu_Item_Setting.id_pattern(), var_id.dup(), var_matches.dup()]))))) {
		rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.new_string("Illegal widget setting ID: ${var_id.to_string()}"))))
	}
	this.post_id = // unsupported expression: Expr_Cast_Int
	rt.call_function('add_action', [rt.new_string('wp_update_nav_menu_item'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Customize_Nav_Menu_Item_Setting', ['WP_Customize_Setting'], &this) }, rt.ArrayItem{ key: none, val: 'flush_cached_value' }]), rt.new_int(10), rt.new_int(2)])
	this.Class_WP_Customize_Setting.construct(rt.new_object('WP_Customize_Manager', []string{}, var_manager), var_id.dup(), rt.new_object('array', []string{}, var_args))
	if !(this.value).is_null() {
		this.populate_value()
		{
			mut iter_1 := rt.call_function('array_diff', [rt.func_array_keys(this.default), rt.func_array_keys(this.value)]).iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_missing := item_1.val
				rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.new_string("Supplied nav_menu_item value missing property: ${var_missing.to_string()}"))))
			}
		}
	}
}

fn (mut this Class_WP_Customize_Nav_Menu_Item_Setting) flush_cached_value(var_menu_id rt.PhpVal, var_menu_item_id rt.PhpVal)  {
	mut var_menu_id_mutated := var_menu_id
	var_menu_id_mutated = rt.new_null()
	if rt.is_true(rt.identical(var_menu_item_id, this.post_id)) {
		this.value = rt.new_null()
	}
}

fn (mut this Class_WP_Customize_Nav_Menu_Item_Setting) value() rt.PhpVal {
	mut var_type_label := rt.new_null()
	if rt.is_true(rt.new_bool(rt.is_true(rt.get_property(rt.new_object('WP_Customize_Nav_Menu_Item_Setting', ['WP_Customize_Setting'], &this), 'is_previewed')) && rt.is_true(rt.identical(rt.call_function('get_current_blog_id', []rt.PhpVal{}), rt.get_property(rt.new_object('WP_Customize_Nav_Menu_Item_Setting', ['WP_Customize_Setting'], &this), '_previewed_blog_id'))))) {
		mut var_undefined := create_stdclass()
		mut var_post_value := this.post_value(rt.new_object('stdClass', []string{}, var_undefined))
		if rt.is_true(rt.identical(var_undefined, var_post_value)) {
			mut var_value := rt.get_property(rt.new_object('WP_Customize_Nav_Menu_Item_Setting', ['WP_Customize_Setting'], &this), '_original_value')
		} else {
			var_value = var_post_value.dup()
		}
	} else if !(this.value).is_null() {
		var_value = this.value
	} else {
		var_value = rt.new_bool(rt.new_bool(false))
		if rt.is_true(rt.greater(this.post_id, rt.new_int(0))) {
			mut var_post := rt.call_function('get_post', [this.post_id])
			if rt.is_true(rt.new_bool(rt.is_true(var_post) && rt.is_true(rt.identical(Class_WP_Customize_Nav_Menu_Item_Setting.post_type(), rt.get_property(var_post, 'post_type'))))) {
				mut var_is_title_empty := rt.new_bool(!rt.is_true(rt.get_property(var_post, 'post_title')))
				var_value = rt.cast_array(rt.call_function('wp_setup_nav_menu_item', [var_post.dup()]))
				if var_value.array_isset(rt.new_string('type_label')) {
					var_type_label = var_value.array_get('type_label')
				}
				if rt.is_true(var_is_title_empty) {
					var_value.array_set('title', '')
				}
			}
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_value.dup().is_array()))))) {
			var_value = this.default
		}
		this.value = var_value.dup()
		this.populate_value()
		var_value = this.value
	}
	if rt.is_true(rt.new_bool(var_value.dup().is_array())) {
		mut var_value_obj := // unsupported expression: Expr_Cast_Object
		var_value.array_set('type_label', if !(var_type_label).is_null() { var_type_label } else { this.get_type_label(var_value_obj.dup()) })
		var_value.array_set('original_title', this.get_original_title(var_value_obj.dup()))
	}
	return var_value.dup()
}

fn (mut this Class_WP_Customize_Nav_Menu_Item_Setting) js_value() rt.PhpVal {
	mut var_value := this.Class_WP_Customize_Setting.js_value()
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_value.dup().is_array())) && var_value.array_isset(rt.new_string('original_title')))) {
		var_value.array_set('original_title', rt.call_function('html_entity_decode', [var_value.array_get('original_title'), rt.get_constant('ENT_QUOTES'), rt.call_function('get_bloginfo', [rt.new_string('charset')])]))
	}
	return var_value.dup()
}

fn (mut this Class_WP_Customize_Nav_Menu_Item_Setting) get_original_title(var_item rt.PhpVal) rt.PhpVal {
	mut var_item_mutated := var_item
	mut var_original_title := rt.new_string(rt.new_string(''))
	if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('post_type'), rt.get_property(var_item_mutated, 'type'))) && !(!rt.is_true(rt.get_property(var_item_mutated, 'object_id'))))) {
		mut var_original_object := rt.call_function('get_post', [rt.get_property(var_item_mutated, 'object_id')])
		if rt.is_true(var_original_object) {
			var_original_title = rt.call_function('apply_filters', [rt.new_string('the_title'), rt.get_property(var_original_object, 'post_title'), rt.get_property(var_original_object, 'ID')])
			if rt.is_true(rt.identical(rt.new_string(''), var_original_title)) {
				var_original_title = rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('#%d (no title)')]), rt.get_property(var_original_object, 'ID')])
			}
		}
	} else if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('taxonomy'), rt.get_property(var_item_mutated, 'type'))) && !(!rt.is_true(rt.get_property(var_item_mutated, 'object_id'))))) {
		mut var_original_term_title := rt.call_function('get_term_field', [rt.new_string('name'), rt.get_property(var_item_mutated, 'object_id'), rt.get_property(var_item_mutated, 'object'), rt.new_string('raw')])
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_original_term_title.dup()]))))) {
			var_original_title = var_original_term_title.dup()
		}
	} else if rt.is_true(rt.identical(rt.new_string('post_type_archive'), rt.get_property(var_item_mutated, 'type'))) {
		var_original_object = rt.call_function('get_post_type_object', [rt.get_property(var_item_mutated, 'object')])
		if rt.is_true(var_original_object) {
			var_original_title = rt.get_property(rt.get_property(var_original_object, 'labels'), 'archives')
		}
	}
	return var_original_title.dup()
}

fn (mut this Class_WP_Customize_Nav_Menu_Item_Setting) get_type_label(var_item rt.PhpVal) rt.PhpVal {
	mut var_item_mutated := var_item
	if rt.is_true(rt.identical(rt.new_string('post_type'), rt.get_property(var_item_mutated, 'type'))) {
		mut var_object := rt.call_function('get_post_type_object', [rt.get_property(var_item_mutated, 'object')])
		if rt.is_true(var_object) {
			mut var_type_label := rt.get_property(rt.get_property(var_object, 'labels'), 'singular_name')
		} else {
			var_type_label = rt.get_property(var_item_mutated, 'object')
		}
	} else if rt.is_true(rt.identical(rt.new_string('taxonomy'), rt.get_property(var_item_mutated, 'type'))) {
		var_object = rt.call_function('get_taxonomy', [rt.get_property(var_item_mutated, 'object')])
		if rt.is_true(var_object) {
			var_type_label = rt.get_property(rt.get_property(var_object, 'labels'), 'singular_name')
		} else {
			var_type_label = rt.get_property(var_item_mutated, 'object')
		}
	} else if rt.is_true(rt.identical(rt.new_string('post_type_archive'), rt.get_property(var_item_mutated, 'type'))) {
		var_type_label = rt.call_function('__', [rt.new_string('Post Type Archive')])
	} else {
		var_type_label = rt.call_function('__', [rt.new_string('Custom Link')])
	}
	return var_type_label.dup()
}

fn (mut this Class_WP_Customize_Nav_Menu_Item_Setting) populate_value()  {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(this.value.is_array()))))) {
		return rt.new_null()
	}
	if this.value.array_isset(rt.new_string('menu_order')) {
		this.value.array_set('position', this.value.array_get('menu_order'))
		this.value.array_unset(rt.new_string('menu_order'))
	}
	if this.value.array_isset(rt.new_string('post_status')) {
		this.value.array_set('status', this.value.array_get('post_status'))
		this.value.array_unset(rt.new_string('post_status'))
	}
	if rt.is_true(rt.new_bool(!(this.value.array_isset(rt.new_string('nav_menu_term_id'))) && rt.is_true(rt.greater(this.post_id, rt.new_int(0))))) {
		mut var_menus := rt.call_function('wp_get_post_terms', [this.post_id, Class_WP_Customize_Nav_Menu_Setting.taxonomy(), rt.create_array([rt.ArrayItem{ key: 'fields', val: 'ids' }])])
		if !(!rt.is_true(var_menus)) {
			this.value.array_set('nav_menu_term_id', rt.call_function('array_shift', [var_menus.dup()]))
		} else {
			this.value.array_set('nav_menu_term_id', 0)
		}
	}
	{
		mut iter_1 := rt.create_array([rt.ArrayItem{ key: none, val: 'object_id' }, rt.ArrayItem{ key: none, val: 'menu_item_parent' }, rt.ArrayItem{ key: none, val: 'nav_menu_term_id' }]).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_key := item_1.val
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(this.value.array_get(var_key).is_long()))))) {
				this.value.array_set(var_key, // unsupported expression: Expr_Cast_Int)
			}
		}
	}
	{
		mut iter_1 := rt.create_array([rt.ArrayItem{ key: none, val: 'classes' }, rt.ArrayItem{ key: none, val: 'xfn' }]).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_key := item_1.val
			if rt.is_true(rt.new_bool(this.value.array_get(var_key).is_array())) {
				this.value.array_set(var_key, rt.call_function('implode', [rt.new_string(' '), this.value.array_get(var_key)]))
			}
		}
	}
	if !(this.value.array_isset(rt.new_string('title'))) {
		this.value.array_set('title', '')
	}
	if !(this.value.array_isset(rt.new_string('_invalid'))) {
		this.value.array_set('_invalid', false)
		mut var_is_known_invalid := rt.new_bool(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('post_type'), this.value.array_get('type'))) || rt.is_true(rt.identical(rt.new_string('post_type_archive'), this.value.array_get('type'))))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('post_type_exists', [this.value.array_get('object')]))))))) || rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('taxonomy'), this.value.array_get('type'))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('taxonomy_exists', [this.value.array_get('object')])))))))))
		if rt.is_true(var_is_known_invalid) {
			this.value.array_set('_invalid', true)
		}
	}
	mut var_irrelevant_properties := ['ID', 'comment_count', 'comment_status', 'db_id', 'filter', 'guid', 'ping_status', 'pinged', 'post_author', 'post_content', 'post_content_filtered', 'post_date', 'post_date_gmt', 'post_excerpt', 'post_mime_type', 'post_modified', 'post_modified_gmt', 'post_name', 'post_parent', 'post_password', 'post_title', 'post_type', 'to_ping']
	for var_property in var_irrelevant_properties {
		this.value.array_unset(rt.new_string(property))
	}
}

fn (mut this Class_WP_Customize_Nav_Menu_Item_Setting) preview() bool {
	if rt.is_true(rt.get_property(rt.new_object('WP_Customize_Nav_Menu_Item_Setting', ['WP_Customize_Setting'], &this), 'is_previewed')) {
		return false
	}
	mut var_undefined := create_stdclass()
	mut var_is_placeholder := rt.less(this.post_id, rt.new_int(0))
	mut var_is_dirty := // unsupported expression: Expr_BinaryOp_NotIdentical
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_is_placeholder)))) && rt.is_true(rt.new_bool(!(rt.is_true(var_is_dirty)))))) {
		return false
	}
	this.dispatch_set_prop('is_previewed', rt.new_bool(true))
	this.dispatch_set_prop('_original_value', this.value())
	this.original_nav_menu_term_id = rt.get_property(rt.new_object('WP_Customize_Nav_Menu_Item_Setting', ['WP_Customize_Setting'], &this), '_original_value').array_get('nav_menu_term_id')
	this.dispatch_set_prop('_previewed_blog_id', rt.call_function('get_current_blog_id', []rt.PhpVal{}))
	rt.call_function('add_filter', [rt.new_string('wp_get_nav_menu_items'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Customize_Nav_Menu_Item_Setting', ['WP_Customize_Setting'], &this) }, rt.ArrayItem{ key: none, val: 'filter_wp_get_nav_menu_items' }]), rt.new_int(10), rt.new_int(3)])
	mut var_sort_callback := [@STRUCT, 'sort_wp_get_nav_menu_items']
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('has_filter', [rt.new_string('wp_get_nav_menu_items'), var_sort_callback.dup()]))))) {
		rt.call_function('add_filter', [rt.new_string('wp_get_nav_menu_items'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'sort_wp_get_nav_menu_items' }]), rt.new_int(1000), rt.new_int(3)])
	}
	return true
}

fn (mut this Class_WP_Customize_Nav_Menu_Item_Setting) filter_wp_get_nav_menu_items(var_items rt.PhpVal, var_menu rt.PhpVal, var_args rt.PhpVal) rt.PhpVal {
	mut var_items_mutated := var_items
	mut var_this_item := this.value()
	mut var_current_nav_menu_term_id := rt.new_null()
	if var_this_item.array_isset(rt.new_string('nav_menu_term_id')) {
		var_current_nav_menu_term_id = var_this_item.array_get('nav_menu_term_id')
		var_this_item.array_unset(rt.new_string('nav_menu_term_id'))
	}
	mut var_should_filter := rt.new_bool(rt.new_bool(rt.is_true(rt.identical(rt.get_property(var_menu, 'term_id'), this.original_nav_menu_term_id)) || rt.is_true(rt.identical(rt.get_property(var_menu, 'term_id'), var_current_nav_menu_term_id))))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_should_filter)))) {
		return var_items_mutated.dup()
	}
	mut var_should_remove := rt.new_bool(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_bool(false), var_this_item)) || rt.is_true(rt.new_bool(var_this_item.array_isset(rt.new_string('_invalid')) && rt.is_true(rt.identical(rt.new_bool(true), var_this_item.array_get('_invalid'))))))) || rt.is_true(rt.new_bool(rt.is_true(rt.identical(this.original_nav_menu_term_id, rt.get_property(var_menu, 'term_id'))) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical)))))
	if rt.is_true(var_should_remove) {
		mut var_filtered_items := []rt.PhpVal{}
		{
			mut iter_1 := var_items_mutated.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_item := item_1.val
				if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
					var_filtered_items << var_item.dup()
				}
			}
		}
		return var_filtered_items.dup()
	}
	mut var_mutated := rt.new_bool(rt.new_bool(false))
	mut var_should_update := rt.new_bool(rt.new_bool(rt.is_true(rt.new_bool(.dup().is_array())) && rt.is_true(rt.identical(, ))))
	if rt.is_true(var_should_update) {
		{
			mut iter_1 := var_items_mutated.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_item := item_1.val
				if rt.is_true() {
				}
			}
		}
		if rt.is_true() {
		}
	}
	return var_items_mutated.dup()
}

fn Class_WP_Customize_Nav_Menu_Item_Setting.sort_wp_get_nav_menu_items(var_items rt.PhpVal, var_menu rt.PhpVal, var_args rt.PhpVal) rt.PhpVal {
	mut var_items_mutated := var_items
	.array_unset()
}

fn (mut this Class_WP_Customize_Nav_Menu_Item_Setting) value_as_wp_post_nav_menu_item() rt.PhpVal {
}

fn (mut this Class_WP_Customize_Nav_Menu_Item_Setting) sanitize(var_value rt.PhpVal) rt.PhpVal {
	mut var_value_mutated := var_value
}

fn (mut this Class_WP_Customize_Nav_Menu_Item_Setting) update(var_value rt.PhpVal) bool {
	mut var_value_mutated := var_value
}

fn (mut this Class_WP_Customize_Nav_Menu_Item_Setting) amend_customize_save_response(var_data rt.PhpVal) rt.PhpVal {
	mut var_data_mutated := var_data
}

struct Class_WP_Customize_Setting {
	rt.PhpObjectBase
}

struct Class_Exception {
	rt.PhpObjectBase
pub mut:
		message string
		code i64
		file string
		line i64
}

fn (mut this Class_Exception) construct(var_message rt.PhpVal) {
	this.message = var_message.to_string()
}

fn (mut this Class_Exception) getmessage() string {
	return this.message
}

struct Class_stdClass {
	rt.PhpObjectBase
}

fn create_wp_customize_nav_menu_item_setting(arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) &Class_WP_Customize_Nav_Menu_Item_Setting {
	mut obj := &Class_WP_Customize_Nav_Menu_Item_Setting{
		PhpObjectBase: rt.PhpObjectBase{}
		prop_type: rt.new_null()
		default: rt.new_array()
		transport: rt.new_string('refresh')
		post_id: rt.new_null()
		value: rt.new_null()
		previous_post_id: rt.new_null()
		original_nav_menu_term_id: rt.new_null()
		is_updated: false
		update_status: ''
		update_error: rt.new_null()
	}
	obj.construct(arg_0, arg_1, arg_2)
	return obj
}

fn create_wp_customize_setting() &Class_WP_Customize_Setting {
	mut obj := &Class_WP_Customize_Setting{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_exception(arg_0 rt.PhpVal) &Class_Exception {
	mut obj := &Class_Exception{
		PhpObjectBase: rt.PhpObjectBase{}
		message: ''
		code: i64(0)
		file: ''
		line: i64(0)
	}
	obj.construct(arg_0)
	return obj
}

fn create_stdclass() &Class_stdClass {
	mut obj := &Class_stdClass{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Customize_Nav_Menu_Item_Setting) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_Customize_Manager](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_array](if args.len > 2 { args[2] } else { rt.new_null() })
			this.construct(mut dispatch_arg_0, dispatch_arg_1, mut dispatch_arg_2)
			return rt.new_null()
		}
		'flush_cached_value' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.flush_cached_value(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'value' {
			return this.value()
		}
		'js_value' {
			return this.js_value()
		}
		'get_original_title' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_original_title(dispatch_arg_0)
		}
		'get_type_label' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_type_label(dispatch_arg_0)
		}
		'populate_value' {
			this.populate_value()
			return rt.new_null()
		}
		'preview' {
			return rt.new_bool(this.preview())
		}
		'filter_wp_get_nav_menu_items' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.filter_wp_get_nav_menu_items(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'sort_wp_get_nav_menu_items' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return Class_WP_Customize_Nav_Menu_Item_Setting.sort_wp_get_nav_menu_items(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'value_as_wp_post_nav_menu_item' {
			return this.value_as_wp_post_nav_menu_item()
		}
		'sanitize' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.sanitize(dispatch_arg_0)
		}
		'update' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.update(dispatch_arg_0))
		}
		'amend_customize_save_response' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.amend_customize_save_response(dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_WP_Customize_Nav_Menu_Item_Setting) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'type' { return this.prop_type }
		'default' { return this.default }
		'transport' { return this.transport }
		'post_id' { return this.post_id }
		'value' { return this.value }
		'previous_post_id' { return this.previous_post_id }
		'original_nav_menu_term_id' { return this.original_nav_menu_term_id }
		'is_updated' { return rt.new_bool(this.is_updated) }
		'update_status' { return rt.new_string(this.update_status) }
		'update_error' { return this.update_error }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_Customize_Nav_Menu_Item_Setting) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'type' { this.prop_type = val; return true }
		'default' { this.default = val; return true }
		'transport' { this.transport = val; return true }
		'post_id' { this.post_id = val; return true }
		'value' { this.value = val; return true }
		'previous_post_id' { this.previous_post_id = val; return true }
		'original_nav_menu_term_id' { this.original_nav_menu_term_id = val; return true }
		'is_updated' { this.is_updated = (val).to_bool(); return true }
		'update_status' { this.update_status = (val).str(); return true }
		'update_error' { this.update_error = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_WP_Customize_Setting) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Customize_Setting) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Customize_Setting) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Exception) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'getMessage' {
			return rt.new_string(this.getmessage())
		}
		else { return none }
	}
}

fn (this &Class_Exception) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'message' { return rt.new_string(this.message) }
		'code' { return rt.new_int(this.code) }
		'file' { return rt.new_string(this.file) }
		'line' { return rt.new_int(this.line) }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Exception) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'message' { this.message = (val).str(); return true }
		'code' { this.code = (val).to_i64(); return true }
		'file' { this.file = (val).str(); return true }
		'line' { this.line = (val).to_i64(); return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_stdClass) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_stdClass) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_stdClass) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_includes_customize_class_wp_customize_nav_menu_item_setting_php() {
}
