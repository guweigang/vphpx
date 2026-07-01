import rt

struct Class_WP_Navigation_Fallback {
	rt.PhpObjectBase
}

fn Class_WP_Navigation_Fallback.update_wp_navigation_post_schema(var_schema rt.PhpVal) rt.PhpVal {
	var_schema.array_get_mut('properties').array_get_mut('status').array_set('context', rt.call_function('array_merge', [
		var_schema.array_get('properties').array_get('status').array_get('context'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'embed' }]),
	]))
	var_schema.array_get_mut('properties').array_get_mut('content').array_set('context', rt.call_function('array_merge', [
		var_schema.array_get('properties').array_get('content').array_get('context'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'embed' }]),
	]))
	var_schema.array_get_mut('properties').array_get_mut('content').array_get_mut('properties').array_get_mut('raw').array_set('context', rt.call_function('array_merge', [
		var_schema.array_get('properties').array_get('content').array_get('properties').array_get('raw').array_get('context'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'embed' }]),
	]))
	var_schema.array_get_mut('properties').array_get_mut('content').array_get_mut('properties').array_get_mut('rendered').array_set('context', rt.call_function('array_merge', [
		var_schema.array_get('properties').array_get('content').array_get('properties').array_get('rendered').array_get('context'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'embed' }]),
	]))
	var_schema.array_get_mut('properties').array_get_mut('content').array_get_mut('properties').array_get_mut('block_version').array_set('context', rt.call_function('array_merge', [
		var_schema.array_get('properties').array_get('content').array_get('properties').array_get('block_version').array_get('context'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'embed' }]),
	]))
	var_schema.array_get_mut('properties').array_get_mut('title').array_get_mut('properties').array_get_mut('raw').array_set('context', rt.call_function('array_merge', [
		var_schema.array_get('properties').array_get('title').array_get('properties').array_get('raw').array_get('context'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'embed' }]),
	]))
	return var_schema.dup()
}

fn Class_WP_Navigation_Fallback.get_fallback() rt.PhpVal {
	mut var_should_create_fallback := rt.call_function('apply_filters', [
		rt.new_string('wp_navigation_should_create_fallback'),
		rt.new_bool(true),
	])
	mut var_fallback := Class_WP_Navigation_Fallback.get_most_recently_published_navigation()
	if rt.is_true(rt.new_bool(rt.is_true(var_fallback)
		|| rt.is_true(rt.new_bool(!(rt.is_true(var_should_create_fallback))))))
	{
		return var_fallback.dup()
	}
	var_fallback = Class_WP_Navigation_Fallback.create_classic_menu_fallback()
	if rt.is_true(rt.new_bool(rt.is_true(var_fallback)
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_fallback.dup()])))))))
	{
		return if rt.is_true(rt.new_bool(rt.instance_of(var_fallback, 'WP_Post'))) {
			var_fallback
		} else {
			Class_WP_Navigation_Fallback.get_most_recently_published_navigation()
		}
	}
	var_fallback = Class_WP_Navigation_Fallback.create_default_fallback()
	if rt.is_true(rt.new_bool(rt.is_true(var_fallback)
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_fallback.dup()])))))))
	{
		return if rt.is_true(rt.new_bool(rt.instance_of(var_fallback, 'WP_Post'))) {
			var_fallback
		} else {
			Class_WP_Navigation_Fallback.get_most_recently_published_navigation()
		}
	}
	return rt.new_null()
}

fn Class_WP_Navigation_Fallback.get_most_recently_published_navigation() rt.PhpVal {
	mut var_parsed_args := {
		'post_type':              rt.new_string('wp_navigation')
		'no_found_rows':          rt.new_bool(true)
		'update_post_meta_cache': rt.new_bool(false)
		'update_post_term_cache': rt.new_bool(false)
		'order':                  rt.new_string('DESC')
		'orderby':                rt.new_string('date')
		'post_status':            rt.new_string('publish')
		'posts_per_page':         rt.new_int(1)
	}
	mut var_navigation_post := create_wp_query(var_parsed_args.dup())
	if rt.get_property(var_navigation_post, 'posts').array_count() > 0 {
		return rt.get_property(var_navigation_post, 'posts').array_get(0)
	}
	return rt.new_null()
}

fn Class_WP_Navigation_Fallback.create_classic_menu_fallback() rt.PhpVal {
	mut var_classic_nav_menu := Class_WP_Navigation_Fallback.get_fallback_classic_menu()
	if rt.is_true(rt.new_bool(!(rt.is_true(var_classic_nav_menu)))) {
		return create_wp_error(rt.new_string('no_classic_menus'), rt.call_function('__', [
			rt.new_string('No Classic Menus found.'),
		]))
	}
	mut var_classic_nav_menu_blocks := fn (arg_0 rt.PhpVal) rt.PhpVal {
		mut temp := Class_WP_Classic_To_Block_Menu_Converter{}
		return temp.convert(arg_0)
	}(var_classic_nav_menu.dup())
	if rt.is_true(rt.call_function('is_wp_error', [var_classic_nav_menu_blocks.dup()])) {
		return var_classic_nav_menu_blocks.dup()
	}
	if !rt.is_true(var_classic_nav_menu_blocks) {
		return create_wp_error(rt.new_string('cannot_convert_classic_menu'), rt.call_function('__', [
			rt.new_string('Unable to convert Classic Menu to blocks.'),
		]))
	}
	mut var_classic_menu_fallback := rt.call_function('wp_insert_post', [
		rt.create_array([
			rt.ArrayItem{ key: 'post_content', val: var_classic_nav_menu_blocks },
			rt.ArrayItem{ key: 'post_title', val: rt.get_property(var_classic_nav_menu, 'name') },
			rt.ArrayItem{ key: 'post_name', val: rt.get_property(var_classic_nav_menu, 'slug') },
			rt.ArrayItem{ key: 'post_status', val: 'publish' },
			rt.ArrayItem{ key: 'post_type', val: 'wp_navigation' },
		]),
		rt.new_bool(true),
	])
	return var_classic_menu_fallback.dup()
}

fn Class_WP_Navigation_Fallback.get_fallback_classic_menu() rt.PhpVal {
	mut var_classic_nav_menus := rt.call_function('wp_get_nav_menus', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_classic_nav_menus))))
		|| rt.is_true(rt.call_function('is_wp_error', [var_classic_nav_menus.dup()]))))
	{
		return rt.new_null()
	}
	mut var_nav_menu := Class_WP_Navigation_Fallback.get_nav_menu_at_primary_location()
	if rt.is_true(var_nav_menu) {
		return var_nav_menu.dup()
	}
	var_nav_menu =
		Class_WP_Navigation_Fallback.get_nav_menu_with_primary_slug(var_classic_nav_menus.dup())
	if rt.is_true(var_nav_menu) {
		return var_nav_menu.dup()
	}
	return Class_WP_Navigation_Fallback.get_most_recently_created_nav_menu(var_classic_nav_menus.dup())
}

fn Class_WP_Navigation_Fallback.get_most_recently_created_nav_menu(var_classic_nav_menus rt.PhpVal) rt.PhpVal {
	mut var_classic_nav_menus_mutated := var_classic_nav_menus
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_a := if args.len > 0 { args[0].dup() } else { rt.new_null() }
		mut var_b := if args.len > 1 { args[1].dup() } else { rt.new_null() }
		return rt.sub(rt.get_property(var_b, 'term_id'), rt.get_property(var_a, 'term_id'))
	}
	rt.call_function('usort', [var_classic_nav_menus_mutated.dup(),
		rt.new_closure(closure_1_fn)])
	return var_classic_nav_menus_mutated.array_get(0)
}

fn Class_WP_Navigation_Fallback.get_nav_menu_with_primary_slug(var_classic_nav_menus rt.PhpVal) rt.PhpVal {
	mut var_classic_nav_menus_mutated := var_classic_nav_menus
	{
		mut iter_1 := var_classic_nav_menus_mutated.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_classic_nav_menu := item_1.val
			if rt.is_true(rt.identical(rt.new_string('primary'), rt.get_property(var_classic_nav_menu,
				'slug')))
			{
				return var_classic_nav_menu.dup()
			}
		}
	}
	return rt.new_null()
}

fn Class_WP_Navigation_Fallback.get_nav_menu_at_primary_location() rt.PhpVal {
	mut var_locations := rt.call_function('get_nav_menu_locations', []rt.PhpVal{})
	if var_locations.array_isset(rt.new_string('primary')) {
		mut var_primary_menu := rt.call_function('wp_get_nav_menu_object', [
			var_locations.array_get('primary'),
		])
		if rt.is_true(var_primary_menu) {
			return var_primary_menu.dup()
		}
	}
	return rt.new_null()
}

fn Class_WP_Navigation_Fallback.create_default_fallback() rt.PhpVal {
	mut var_default_blocks := Class_WP_Navigation_Fallback.get_default_fallback_blocks()
	mut var_default_fallback := rt.call_function('wp_insert_post', [
		rt.create_array([rt.ArrayItem{ key: 'post_content', val: var_default_blocks },
			rt.ArrayItem{ key: 'post_title', val: rt.call_function('_x', [
				rt.new_string('Navigation'),
				rt.new_string('Title of a Navigation menu'),
			]) }, rt.ArrayItem{ key: 'post_name', val: 'navigation' },
			rt.ArrayItem{ key: 'post_status', val: 'publish' },
			rt.ArrayItem{ key: 'post_type', val: 'wp_navigation' }]),
		rt.new_bool(true),
	])
	return var_default_fallback.dup()
}

fn Class_WP_Navigation_Fallback.get_default_fallback_blocks() string {
	mut var_registry := fn () rt.PhpVal {
		mut temp := Class_WP_Block_Type_Registry{}
		return temp.get_instance()
	}()
	return if rt.is_true(rt.call_method(var_registry, 'is_registered', [
		rt.new_string('core/page-list'),
	]))
	{ '<!-- wp:page-list /-->' } else { '' }
}

struct Class_WP_Query {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

struct Class_WP_Classic_To_Block_Menu_Converter {
	rt.PhpObjectBase
}

struct Class_WP_Block_Type_Registry {
	rt.PhpObjectBase
}

fn create_wp_navigation_fallback() &Class_WP_Navigation_Fallback {
	mut obj := &Class_WP_Navigation_Fallback{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_query() &Class_WP_Query {
	mut obj := &Class_WP_Query{
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

fn create_wp_classic_to_block_menu_converter() &Class_WP_Classic_To_Block_Menu_Converter {
	mut obj := &Class_WP_Classic_To_Block_Menu_Converter{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_block_type_registry() &Class_WP_Block_Type_Registry {
	mut obj := &Class_WP_Block_Type_Registry{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Navigation_Fallback) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'update_wp_navigation_post_schema' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WP_Navigation_Fallback.update_wp_navigation_post_schema(dispatch_arg_0)
		}
		'get_fallback' {
			return Class_WP_Navigation_Fallback.get_fallback()
		}
		'get_most_recently_published_navigation' {
			return Class_WP_Navigation_Fallback.get_most_recently_published_navigation()
		}
		'create_classic_menu_fallback' {
			return Class_WP_Navigation_Fallback.create_classic_menu_fallback()
		}
		'get_fallback_classic_menu' {
			return Class_WP_Navigation_Fallback.get_fallback_classic_menu()
		}
		'get_most_recently_created_nav_menu' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WP_Navigation_Fallback.get_most_recently_created_nav_menu(dispatch_arg_0)
		}
		'get_nav_menu_with_primary_slug' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WP_Navigation_Fallback.get_nav_menu_with_primary_slug(dispatch_arg_0)
		}
		'get_nav_menu_at_primary_location' {
			return Class_WP_Navigation_Fallback.get_nav_menu_at_primary_location()
		}
		'create_default_fallback' {
			return Class_WP_Navigation_Fallback.create_default_fallback()
		}
		'get_default_fallback_blocks' {
			return rt.new_string(Class_WP_Navigation_Fallback.get_default_fallback_blocks())
		}
		else {
			return none
		}
	}
}

fn (this &Class_WP_Navigation_Fallback) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Navigation_Fallback) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WP_Query) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Query) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Query) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_WP_Classic_To_Block_Menu_Converter) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Classic_To_Block_Menu_Converter) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Classic_To_Block_Menu_Converter) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WP_Block_Type_Registry) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Block_Type_Registry) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Block_Type_Registry) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_includes_class_wp_navigation_fallback_php() {
}
