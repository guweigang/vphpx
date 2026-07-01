import rt

pub fn Class_WC_Tracks.prefix() string {
	return 'wcadmin_'
}
struct Class_WC_Tracks {
	rt.PhpObjectBase
}

fn Class_WC_Tracks.get_products_count() rt.PhpVal {
	mut var_product_counts := fn () rt.PhpVal { mut temp := Class_WC_Tracker{}; return temp.get_product_counts() }()
	return var_product_counts.array_get('total')
}

fn Class_WC_Tracks.get_blog_details(var_user_id rt.PhpVal) rt.PhpVal {
	mut var_blog_details := rt.call_function('get_transient', [rt.new_string('wc_tracks_blog_details')])
	if rt.is_true(rt.identical(rt.new_bool(false), var_blog_details)) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [rt.new_string('\\WC_Install')]))))) {
			rt.include_file((rt.get_constant('WC_ABSPATH')).str() + 'includes/class-wc-install.php', '2')
		}
		fn () rt.PhpVal { mut temp := Class_WC_Install{}; return temp.maybe_set_store_id() }()
		var_blog_details = rt.create_array([rt.ArrayItem{ key: 'url', val: rt.call_function('home_url', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'blog_lang', val: rt.call_function('get_user_locale', [var_user_id.dup()]) }, rt.ArrayItem{ key: 'blog_id', val: if rt.is_true(rt.call_function('class_exists', [rt.new_string('Jetpack_Options')])) { fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Jetpack_Options{}; return temp.get_option(arg_0) }(rt.new_string('id')) } else { rt.new_null() } }, rt.ArrayItem{ key: 'store_id', val: rt.call_function('get_option', [Class_WC_Install.store_id_option(), rt.new_null()]) }, rt.ArrayItem{ key: 'products_count', val: Class_WC_Tracks.get_products_count() }, rt.ArrayItem{ key: 'wc_version', val: rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'stable_version', []rt.PhpVal{}) }])
		rt.call_function('set_transient', [rt.new_string('wc_tracks_blog_details'), var_blog_details.dup(), rt.get_constant('DAY_IN_SECONDS')])
	}
	return var_blog_details.dup()
}

fn Class_WC_Tracks.get_server_details() rt.PhpVal {
	mut var_data := rt.new_array()
	var_data.array_set('_via_ua', if rt.get_superglobal('_SERVER').array_isset(rt.new_string('HTTP_USER_AGENT')) { rt.call_function('wc_clean', [rt.call_function('wp_unslash', [rt.get_superglobal('_SERVER').array_get('HTTP_USER_AGENT')])]) } else { rt.new_string('') })
	var_data.array_set('_via_ip', if rt.get_superglobal('_SERVER').array_isset(rt.new_string('REMOTE_ADDR')) { rt.call_function('wc_clean', [rt.call_function('wp_unslash', [rt.get_superglobal('_SERVER').array_get('REMOTE_ADDR')])]) } else { rt.new_string('') })
	var_data.array_set('_lg', if rt.get_superglobal('_SERVER').array_isset(rt.new_string('HTTP_ACCEPT_LANGUAGE')) { rt.call_function('wc_clean', [rt.call_function('wp_unslash', [rt.get_superglobal('_SERVER').array_get('HTTP_ACCEPT_LANGUAGE')])]) } else { rt.new_string('') })
	var_data.array_set('_dr', if rt.get_superglobal('_SERVER').array_isset(rt.new_string('HTTP_REFERER')) { rt.call_function('wc_clean', [rt.call_function('wp_unslash', [rt.get_superglobal('_SERVER').array_get('HTTP_REFERER')])]) } else { rt.new_string('') })
	mut var_uri := if rt.get_superglobal('_SERVER').array_isset(rt.new_string('REQUEST_URI')) { rt.call_function('wc_clean', [rt.call_function('wp_unslash', [rt.get_superglobal('_SERVER').array_get('REQUEST_URI')])]) } else { rt.new_string('') }
	mut var_host := if rt.get_superglobal('_SERVER').array_isset(rt.new_string('HTTP_HOST')) { rt.call_function('wc_clean', [rt.call_function('wp_unslash', [rt.get_superglobal('_SERVER').array_get('HTTP_HOST')])]) } else { rt.new_string('') }
	var_data.array_set('_dl', if rt.get_superglobal('_SERVER').array_isset(rt.new_string('REQUEST_SCHEME')) { (rt.call_function('wc_clean', [rt.call_function('wp_unslash', [rt.get_superglobal('_SERVER').array_get('REQUEST_SCHEME')])])).str() + '://' + (var_host).str() + (var_uri).str() } else { '' })
	return var_data.dup()
}

fn Class_WC_Tracks.get_role_details(var_user rt.PhpVal) rt.PhpVal {
	mut var_user_mutated := var_user
	return rt.create_array([rt.ArrayItem{ key: 'role', val: if !(!rt.is_true(rt.get_property(var_user_mutated, 'roles'))) { rt.call_function('array_values', [rt.get_property(var_user_mutated, 'roles')]).array_get(0) } else { rt.new_string('') } }, rt.ArrayItem{ key: 'can_install_plugins', val: rt.call_method(var_user_mutated, 'has_cap', [rt.new_string('install_plugins')]) }, rt.ArrayItem{ key: 'can_activate_plugins', val: rt.call_method(var_user_mutated, 'has_cap', [rt.new_string('activate_plugins')]) }, rt.ArrayItem{ key: 'can_manage_woocommerce', val: rt.call_method(var_user_mutated, 'has_cap', [rt.new_string('manage_woocommerce')]) }])
}

fn Class_WC_Tracks.record_event(var_event_name rt.PhpVal, var_event_properties rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(fn () rt.PhpVal { mut temp := Class_WC_Site_Tracking{}; return temp.is_tracking_enabled() }())))) {
		return false
	}
	mut var_user := rt.call_function('wp_get_current_user', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.instance_of(var_user, 'WP_User'))) && rt.is_true(rt.identical(rt.new_string('wptests_capabilities'), rt.get_property(var_user, 'cap_key'))))) {
		return false
	}
	mut var_prefixed_event_name := rt.new_string(Class_WC_Tracks.prefix() + (var_event_name).str())
	mut var_properties := Class_WC_Tracks.get_properties(var_prefixed_event_name.dup(), var_event_properties.dup())
	mut var_event_obj := create_wc_tracks_event(var_properties.dup())
	if rt.is_true(rt.call_function('is_wp_error', [rt.get_property(var_event_obj, 'error')])) {
		return (rt.get_property(var_event_obj, 'error')).to_bool()
	}
	return (var_event_obj.record()).to_bool()
}

fn Class_WC_Tracks.track_woocommerce_allow_tracking_toggled(var_prev_value rt.PhpVal, var_new_value rt.PhpVal, context string)  {
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		Class_WC_Tracks.record_event(rt.new_string('woocommerce_allow_tracking_toggled'), rt.create_array([rt.ArrayItem{ key: 'previous_value', val: var_prev_value }, rt.ArrayItem{ key: 'new_value', val: var_new_value }, rt.ArrayItem{ key: 'context', val: context }]))
	}
}

fn Class_WC_Tracks.get_properties(var_event_name rt.PhpVal, var_event_properties rt.PhpVal) rt.PhpVal {
	mut var_properties := rt.call_function('apply_filters', [rt.new_string('woocommerce_tracks_event_properties'), var_event_properties.dup(), var_event_name.dup()])
	mut var_user := rt.call_function('wp_get_current_user', []rt.PhpVal{})
	mut var_identity := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Tracks_Client{}; return temp.get_identity(arg_0) }(rt.get_property(var_user, 'ID'))
	var_properties.array_unset(rt.new_string('_ui'))
	var_properties.array_unset(rt.new_string('_ut'))
	mut var_data := if rt.is_true(var_event_name) { rt.create_array([rt.ArrayItem{ key: '_en', val: var_event_name }, rt.ArrayItem{ key: '_ts', val: fn () rt.PhpVal { mut temp := Class_WC_Tracks_Client{}; return temp.build_timestamp() }() }]) } else { rt.new_array() }
	mut var_server_details := Class_WC_Tracks.get_server_details()
	mut var_blog_details := Class_WC_Tracks.get_blog_details(rt.get_property(var_user, 'ID'))
	mut var_role_details := Class_WC_Tracks.get_role_details(var_user.dup())
	return rt.call_function('array_merge', [var_properties.dup(), var_data.dup(), var_server_details.dup(), var_identity.dup(), var_blog_details.dup(), var_role_details.dup()])
}

struct Class_WC_Tracker {
	rt.PhpObjectBase
}

struct Class_WC_Install {
	rt.PhpObjectBase
}

struct Class_Jetpack_Options {
	rt.PhpObjectBase
}

struct Class_WC_Site_Tracking {
	rt.PhpObjectBase
}

struct Class_WC_Tracks_Event {
	rt.PhpObjectBase
}

struct Class_WC_Tracks_Client {
	rt.PhpObjectBase
}

fn create_wc_tracks() &Class_WC_Tracks {
	mut obj := &Class_WC_Tracks{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_tracker() &Class_WC_Tracker {
	mut obj := &Class_WC_Tracker{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_install() &Class_WC_Install {
	mut obj := &Class_WC_Install{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_jetpack_options() &Class_Jetpack_Options {
	mut obj := &Class_Jetpack_Options{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_site_tracking() &Class_WC_Site_Tracking {
	mut obj := &Class_WC_Site_Tracking{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_tracks_event() &Class_WC_Tracks_Event {
	mut obj := &Class_WC_Tracks_Event{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_tracks_client() &Class_WC_Tracks_Client {
	mut obj := &Class_WC_Tracks_Client{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Tracks) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_products_count' {
			return Class_WC_Tracks.get_products_count()
		}
		'get_blog_details' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_Tracks.get_blog_details(dispatch_arg_0)
		}
		'get_server_details' {
			return Class_WC_Tracks.get_server_details()
		}
		'get_role_details' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_Tracks.get_role_details(dispatch_arg_0)
		}
		'record_event' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(Class_WC_Tracks.record_event(dispatch_arg_0, dispatch_arg_1))
		}
		'track_woocommerce_allow_tracking_toggled' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			Class_WC_Tracks.track_woocommerce_allow_tracking_toggled(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'get_properties' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_WC_Tracks.get_properties(dispatch_arg_0, dispatch_arg_1)
		}
		else { return none }
	}
}

fn (this &Class_WC_Tracks) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Tracks) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Tracker) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Tracker) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Tracker) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Install) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Install) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Install) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Jetpack_Options) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Jetpack_Options) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Jetpack_Options) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Site_Tracking) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Site_Tracking) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Site_Tracking) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Tracks_Event) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Tracks_Event) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Tracks_Event) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Tracks_Client) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Tracks_Client) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Tracks_Client) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_includes_tracks_class_wc_tracks_php() {
}
