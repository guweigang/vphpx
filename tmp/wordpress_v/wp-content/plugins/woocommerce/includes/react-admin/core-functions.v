import rt

fn wc_admin_number_format(var_number rt.PhpVal) rt.PhpVal {
	mut var_currency_settings := fn () rt.PhpVal {
		mut temp := Class_Automattic_WooCommerce_Internal_Admin_Settings{}
		return temp.get_currency_settings()
	}()
	return rt.call_function('number_format', [var_number.dup(),
		rt.new_int(0), var_currency_settings.array_get('decimalSeparator'),
		var_currency_settings.array_get('thousandSeparator')])
}

fn wc_admin_url(var_path rt.PhpVal, var_query rt.PhpVal) rt.PhpVal {
	if !(!rt.is_true(var_query)) {
		mut var_query_string := rt.call_function('http_build_query', [
			var_query.dup()])
		var_path = rt.new_string(if rt.is_true(var_path) {
			'&path=' + var_path.str() + '&' + var_query_string.str()
		} else {
			rt.new_string('')
		})
	}
	return rt.call_function('admin_url', [
		'admin.php?page=wc-admin' + var_path.str(),
		rt.call_function('dirname', [rt.new_string(@FILE)]),
	])
}

fn wc_admin_record_tracks_event(var_event_name rt.PhpVal, var_properties rt.PhpVal) {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('post_type_exists', [
		rt.new_string('product'),
	])))))
	{
		return rt.new_null()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [
		rt.new_string('WC_Tracks'),
	])))))
	{
		if rt.is_true(rt.new_bool(
			rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('WC_ABSPATH')])))))
			|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('file_exists', [(rt.get_constant('WC_ABSPATH')).str() + 'includes/tracks/class-wc-tracks.php'])))))))
		{
			return rt.new_null()
		}
		rt.include_file(
			(rt.get_constant('WC_ABSPATH')).str() + 'includes/tracks/class-wc-tracks.php', '2')
		rt.include_file(
			(rt.get_constant('WC_ABSPATH')).str() + 'includes/tracks/class-wc-tracks-event.php',
			'2')
		rt.include_file(
			(rt.get_constant('WC_ABSPATH')).str() + 'includes/tracks/class-wc-tracks-client.php',
			'2')
		rt.include_file(
			(rt.get_constant('WC_ABSPATH')).str() + 'includes/tracks/class-wc-tracks-footer-pixel.php',
			'2')
		rt.include_file(
			(rt.get_constant('WC_ABSPATH')).str() + 'includes/tracks/class-wc-site-tracking.php',
			'2')
	}
	fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal {
		mut temp := Class_WC_Tracks{}
		return temp.record_event(arg_0, arg_1)
	}(var_event_name.dup(), var_properties.dup())
}

struct Class_Automattic_WooCommerce_Internal_Admin_Settings {
	rt.PhpObjectBase
}

struct Class_WC_Tracks {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_admin_settings() &Class_Automattic_WooCommerce_Internal_Admin_Settings {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Settings{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_tracks() &Class_WC_Tracks {
	mut obj := &Class_WC_Tracks{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Settings) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_Tracks) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Tracks) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Tracks) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_woocommerce_includes_react_admin_core_functions_php() {
}
