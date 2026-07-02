import rt

pub fn Class_WC_Tracks.prefix() string {
	return 'wcadmin_'
}

struct Class_WC_Tracks {
	rt.PhpObjectBase
}

fn Class_WC_Tracks.get_products_count() rt.PhpVal {
	mut iife_temp_0 := Class_WC_Tracker{}
	mut iife_result_0 := iife_temp_0.get_product_counts()
	mut var_product_counts := iife_result_0
	return var_product_counts.array_get(rt.new_string('total'))
}

fn Class_WC_Tracks.get_blog_details(var_user_id rt.PhpVal) rt.PhpVal {
	mut var_blog_details := rt.call_function('get_transient', [
		rt.new_string('wc_tracks_blog_details'),
	])
	if rt.is_true(rt.identical(rt.new_bool(false), var_blog_details)) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [
			rt.new_string('\\WC_Install'),
		])))))
		{
			rt.include_file((rt.get_constant('WC_ABSPATH')).str() + 'includes/class-wc-install.php',
				'2')
		}
		mut iife_temp_1 := Class_WC_Install{}
		mut iife_result_1 := iife_temp_1.maybe_set_store_id()
		mut iife_temp_2 := Class_Jetpack_Options{}
		mut iife_result_2 := iife_temp_2.get_option(rt.new_string('id'))
		var_blog_details = rt.create_array([
			rt.ArrayItem{ key: 'url', val: rt.call_function('home_url', []rt.PhpVal{}) },
			rt.ArrayItem{ key: 'blog_lang', val: rt.call_function('get_user_locale', [
				var_user_id.clone(),
			]) },
			rt.ArrayItem{
				key: 'blog_id'
				val: if rt.is_true(rt.call_function('class_exists', [
					rt.new_string('Jetpack_Options'),
				]))
				{ iife_result_2 } else { rt.new_null() }
			},
			rt.ArrayItem{ key: 'store_id', val: rt.call_function('get_option', [
				Class_WC_Install.store_id_option(),
				rt.new_null(),
			]) },
			rt.ArrayItem{ key: 'products_count', val: Class_WC_Tracks.get_products_count() },
			rt.ArrayItem{ key: 'wc_version', val: rt.call_method(rt.call_function('WC',
				[]rt.PhpVal{}), 'stable_version', []rt.PhpVal{}) },
		])
		rt.call_function('set_transient', [rt.new_string('wc_tracks_blog_details'),
			var_blog_details.clone(), rt.get_constant('DAY_IN_SECONDS')])
	}
	return var_blog_details.clone()
}

fn Class_WC_Tracks.get_server_details() rt.PhpVal {
	mut var_data := rt.new_array()
	var_data.array_set('_via_ua', if rt.get_superglobal('_SERVER').array_isset(rt.new_string('HTTP_USER_AGENT')) { rt.call_function('wc_clean', [
			rt.call_function('wp_unslash', [
				rt.get_superglobal('_SERVER').array_get(rt.new_string('HTTP_USER_AGENT')),
			]),
		]) } else { rt.new_string('') })
	var_data.array_set('_via_ip', if rt.get_superglobal('_SERVER').array_isset(rt.new_string('REMOTE_ADDR')) { rt.call_function('wc_clean', [
			rt.call_function('wp_unslash', [rt.get_superglobal('_SERVER').array_get(rt.new_string('REMOTE_ADDR'))]),
		]) } else { rt.new_string('') })
	var_data.array_set('_lg', if rt.get_superglobal('_SERVER').array_isset(rt.new_string('HTTP_ACCEPT_LANGUAGE')) { rt.call_function('wc_clean', [
			rt.call_function('wp_unslash', [
				rt.get_superglobal('_SERVER').array_get(rt.new_string('HTTP_ACCEPT_LANGUAGE')),
			]),
		]) } else { rt.new_string('') })
	var_data.array_set('_dr', if rt.get_superglobal('_SERVER').array_isset(rt.new_string('HTTP_REFERER')) { rt.call_function('wc_clean', [
			rt.call_function('wp_unslash', [rt.get_superglobal('_SERVER').array_get(rt.new_string('HTTP_REFERER'))]),
		]) } else { rt.new_string('') })
	mut var_uri := if rt.get_superglobal('_SERVER').array_isset(rt.new_string('REQUEST_URI')) { rt.call_function('wc_clean', [
			rt.call_function('wp_unslash', [rt.get_superglobal('_SERVER').array_get(rt.new_string('REQUEST_URI'))]),
		]) } else { rt.new_string('') }
	mut var_host := if rt.get_superglobal('_SERVER').array_isset(rt.new_string('HTTP_HOST')) { rt.call_function('wc_clean', [
			rt.call_function('wp_unslash', [rt.get_superglobal('_SERVER').array_get(rt.new_string('HTTP_HOST'))]),
		]) } else { rt.new_string('') }
	var_data.array_set('_dl', if rt.get_superglobal('_SERVER').array_isset(rt.new_string('REQUEST_SCHEME')) {
			(rt.call_function('wc_clean', [rt.call_function('wp_unslash', [rt.get_superglobal('_SERVER').array_get(rt.new_string('REQUEST_SCHEME'))])])).str() +
			'://' + var_host.str() + var_uri.str()
	} else {
		''
	})
	return var_data.clone()
}

fn Class_WC_Tracks.get_role_details(var_user rt.PhpVal) rt.PhpVal {
	mut var_user_mutated := var_user
	return rt.create_array([
		rt.ArrayItem{
			key: 'role'
			val: if !(!rt.is_true(rt.get_property(var_user_mutated, 'roles'))) { rt.call_function('array_values', [
					rt.get_property(var_user_mutated, 'roles'),
				]).array_get(rt.new_int(0)) } else { rt.new_string('') }
		},
		rt.ArrayItem{ key: 'can_install_plugins', val: rt.call_method(var_user_mutated, 'has_cap', [
			rt.new_string('install_plugins'),
		]) },
		rt.ArrayItem{ key: 'can_activate_plugins', val: rt.call_method(var_user_mutated, 'has_cap', [
			rt.new_string('activate_plugins'),
		]) },
		rt.ArrayItem{ key: 'can_manage_woocommerce', val: rt.call_method(var_user_mutated,
			'has_cap', [
			rt.new_string('manage_woocommerce'),
		]) },
	])
}

fn Class_WC_Tracks.record_event(var_event_name rt.PhpVal, var_event_properties rt.PhpVal) bool {
	mut iife_temp_3 := Class_WC_Site_Tracking{}
	mut iife_result_3 := iife_temp_3.is_tracking_enabled()
	if rt.is_true(rt.new_bool(!(rt.is_true(iife_result_3)))) {
		return false
	}
	mut var_user := rt.call_function('wp_get_current_user', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(rt.instance_of(var_user, 'WP_User')))
		&& rt.is_true(rt.identical(rt.new_string('wptests_capabilities'), rt.get_property(var_user, 'cap_key'))) {
		return false
	}
	mut var_prefixed_event_name := rt.new_string(Class_WC_Tracks.prefix() + var_event_name.str())
	mut var_properties := Class_WC_Tracks.get_properties(var_prefixed_event_name.clone(),
		var_event_properties.clone())
	mut var_event_obj := create_wc_tracks_event(var_properties.clone())
	if rt.is_true(rt.call_function('is_wp_error', [
		rt.get_property(var_event_obj, 'error'),
	]))
	{
		return (rt.get_property(var_event_obj, 'error')).to_bool()
	}
	return (var_event_obj.record()).to_bool()
}

fn Class_WC_Tracks.track_woocommerce_allow_tracking_toggled(var_prev_value rt.PhpVal, var_new_value rt.PhpVal, context string) {
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_new_value, var_prev_value)))) {
		Class_WC_Tracks.record_event(rt.new_string('woocommerce_allow_tracking_toggled'), rt.create_array([
			rt.ArrayItem{ key: 'previous_value', val: var_prev_value },
			rt.ArrayItem{ key: 'new_value', val: var_new_value },
			rt.ArrayItem{ key: 'context', val: context },
		]))
	}
}

fn Class_WC_Tracks.get_properties(var_event_name rt.PhpVal, var_event_properties rt.PhpVal) rt.PhpVal {
	mut var_properties := rt.call_function('apply_filters', [
		rt.new_string('woocommerce_tracks_event_properties'),
		var_event_properties.clone(),
		var_event_name.clone(),
	])
	mut var_user := rt.call_function('wp_get_current_user', []rt.PhpVal{})
	mut iife_temp_4 := Class_WC_Tracks_Client{}
	mut iife_result_4 := iife_temp_4.get_identity(rt.get_property(var_user, 'ID'))
	mut var_identity := iife_result_4
	var_properties.array_unset(rt.new_string('_ui'))
	var_properties.array_unset(rt.new_string('_ut'))
	mut iife_temp_5 := Class_WC_Tracks_Client{}
	mut iife_result_5 := iife_temp_5.build_timestamp()
	mut var_data := if rt.is_true(var_event_name) { rt.create_array([
			rt.ArrayItem{ key: '_en', val: var_event_name },
			rt.ArrayItem{ key: '_ts', val: iife_result_5 },
		]) } else { rt.new_array() }
	mut var_server_details := Class_WC_Tracks.get_server_details()
	mut var_blog_details := Class_WC_Tracks.get_blog_details(rt.get_property(var_user, 'ID'))
	mut var_role_details := Class_WC_Tracks.get_role_details(var_user.clone())
	return rt.call_function('array_merge', [var_properties.clone(),
		var_data.clone(), var_server_details.clone(), var_identity.clone(),
		var_blog_details.clone(), var_role_details.clone()])
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

fn create_wc_tracks(_args ...rt.PhpVal) &Class_WC_Tracks {
	mut obj := &Class_WC_Tracks{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_tracker(_args ...rt.PhpVal) &Class_WC_Tracker {
	mut obj := &Class_WC_Tracker{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_install(_args ...rt.PhpVal) &Class_WC_Install {
	mut obj := &Class_WC_Install{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_jetpack_options(_args ...rt.PhpVal) &Class_Jetpack_Options {
	mut obj := &Class_Jetpack_Options{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_site_tracking(_args ...rt.PhpVal) &Class_WC_Site_Tracking {
	mut obj := &Class_WC_Site_Tracking{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_tracks_event(_args ...rt.PhpVal) &Class_WC_Tracks_Event {
	mut obj := &Class_WC_Tracks_Event{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_tracks_client(_args ...rt.PhpVal) &Class_WC_Tracks_Client {
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
			Class_WC_Tracks.track_woocommerce_allow_tracking_toggled(dispatch_arg_0,
				dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'get_properties' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_WC_Tracks.get_properties(dispatch_arg_0, dispatch_arg_1)
		}
		else {
			return none
		}
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

fn main() {
	defer {
		rt.shutdown()
	}
}
