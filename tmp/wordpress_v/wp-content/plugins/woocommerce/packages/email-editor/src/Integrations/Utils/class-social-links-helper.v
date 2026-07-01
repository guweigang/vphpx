import rt

struct Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Social_Links_Helper {
	rt.PhpObjectBase
}

fn Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Social_Links_Helper.detect_whiteish_color(var_input_color rt.PhpVal) bool {
	if !rt.is_true(var_input_color) {
		return false
	}
	mut var_color :=
		rt.new_string(rt.new_string(var_input_color.dup().to_string().trim_left(' \t\n\r')))
	if var_color.dup().to_string().len == 3 {
		var_color = rt.new_string((var_color.array_get(0)).str() + (var_color.array_get(0)).str() +
			(var_color.array_get(1)).str() + (var_color.array_get(1)).str() +
			(var_color.array_get(2)).str() + (var_color.array_get(2)).str())
	}
	mut var_r := rt.call_function('hexdec', [
		rt.call_function('substr', [var_color.dup(), rt.new_int(0),
			rt.new_int(2)]),
	])
	mut var_g := rt.call_function('hexdec', [
		rt.call_function('substr', [var_color.dup(), rt.new_int(2),
			rt.new_int(2)]),
	])
	mut var_b := rt.call_function('hexdec', [
		rt.call_function('substr', [var_color.dup(), rt.new_int(4),
			rt.new_int(2)]),
	])
	mut var_brightness := rt.new_float(0.299 * var_r + 0.587 * var_g + 0.114 * var_b)
	return (rt.greater(var_brightness, rt.new_int(240))).to_bool()
}

fn Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Social_Links_Helper.get_service_brand_color(var_service_name rt.PhpVal) rt.PhpVal {
	mut var_service_brand_color := rt.create_array([
		rt.ArrayItem{ key: 'amazon', val: '#f90' },
		rt.ArrayItem{ key: 'bandcamp', val: '#1ea0c3' },
		rt.ArrayItem{ key: 'behance', val: '#0757fe' },
		rt.ArrayItem{ key: 'bluesky', val: '#0a7aff' },
		rt.ArrayItem{ key: 'codepen', val: '#1e1f26' },
		rt.ArrayItem{ key: 'deviantart', val: '#02e49b' },
		rt.ArrayItem{ key: 'discord', val: '#5865f2' },
		rt.ArrayItem{ key: 'dribbble', val: '#e94c89' },
		rt.ArrayItem{ key: 'dropbox', val: '#4280ff' },
		rt.ArrayItem{ key: 'etsy', val: '#f45800' },
		rt.ArrayItem{ key: 'facebook', val: '#0866ff' },
		rt.ArrayItem{ key: 'fivehundredpx', val: '#000' },
		rt.ArrayItem{ key: 'flickr', val: '#0461dd' },
		rt.ArrayItem{ key: 'foursquare', val: '#e65678' },
		rt.ArrayItem{ key: 'github', val: '#24292d' },
		rt.ArrayItem{ key: 'goodreads', val: '#382110' },
		rt.ArrayItem{ key: 'google', val: '#ea4434' },
		rt.ArrayItem{ key: 'gravatar', val: '#1d4fc4' },
		rt.ArrayItem{ key: 'instagram', val: '#f00075' },
		rt.ArrayItem{ key: 'lastfm', val: '#e21b24' },
		rt.ArrayItem{ key: 'linkedin', val: '#0d66c2' },
		rt.ArrayItem{ key: 'mastodon', val: '#3288d4' },
		rt.ArrayItem{ key: 'medium', val: '#000' },
		rt.ArrayItem{ key: 'meetup', val: '#f6405f' },
		rt.ArrayItem{ key: 'patreon', val: '#000' },
		rt.ArrayItem{ key: 'pinterest', val: '#e60122' },
		rt.ArrayItem{ key: 'pocket', val: '#ef4155' },
		rt.ArrayItem{ key: 'reddit', val: '#ff4500' },
		rt.ArrayItem{ key: 'skype', val: '#0478d7' },
		rt.ArrayItem{ key: 'snapchat', val: '#fff' },
		rt.ArrayItem{ key: 'soundcloud', val: '#ff5600' },
		rt.ArrayItem{ key: 'spotify', val: '#1bd760' },
		rt.ArrayItem{ key: 'telegram', val: '#2aabee' },
		rt.ArrayItem{ key: 'threads', val: '#000' },
		rt.ArrayItem{ key: 'tiktok', val: '#000' },
		rt.ArrayItem{ key: 'tumblr', val: '#011835' },
		rt.ArrayItem{ key: 'twitch', val: '#6440a4' },
		rt.ArrayItem{ key: 'twitter', val: '#1da1f2' },
		rt.ArrayItem{ key: 'vimeo', val: '#1eb7ea' },
		rt.ArrayItem{ key: 'vk', val: '#4680c2' },
		rt.ArrayItem{ key: 'whatsapp', val: '#25d366' },
		rt.ArrayItem{ key: 'wordpress', val: '#3499cd' },
		rt.ArrayItem{ key: 'x', val: '#000' },
		rt.ArrayItem{ key: 'yelp', val: '#d32422' },
		rt.ArrayItem{ key: 'youtube', val: '#f00' },
	])
	return if !(var_service_brand_color.array_get(var_service_name)).is_null() {
		var_service_brand_color.array_get(var_service_name)
	} else {
		rt.new_string('')
	}
}

fn Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Social_Links_Helper.get_default_social_link_size() string {
	return 'has-normal-icon-size'
}

fn Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Social_Links_Helper.get_social_link_size_option_value(var_size rt.PhpVal) rt.PhpVal {
	mut var_options := rt.create_array([
		rt.ArrayItem{ key: 'has-small-icon-size', val: '16px' },
		rt.ArrayItem{ key: 'has-normal-icon-size', val: '24px' },
		rt.ArrayItem{ key: 'has-large-icon-size', val: '36px' },
		rt.ArrayItem{ key: 'has-huge-icon-size', val: '48px' },
	])
	return if !(var_options.array_get(var_size)).is_null() {
		var_options.array_get(var_size)
	} else {
		rt.new_string('24px')
	}
	// unsupported statement: Stmt_Nop
	return rt.new_null()
}

fn create_automattic_woocommerce_emaileditor_integrations_utils_social_links_helper() &Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Social_Links_Helper {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Social_Links_Helper{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Social_Links_Helper) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'detect_whiteish_color' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Social_Links_Helper.detect_whiteish_color(dispatch_arg_0))
		}
		'get_service_brand_color' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Social_Links_Helper.get_service_brand_color(dispatch_arg_0)
		}
		'get_default_social_link_size' {
			return rt.new_string(Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Social_Links_Helper.get_default_social_link_size())
		}
		'get_social_link_size_option_value' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Social_Links_Helper.get_social_link_size_option_value(dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Social_Links_Helper) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Social_Links_Helper) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_woocommerce_packages_email_editor_src_integrations_utils_class_social_links_helper_php() {
	// unsupported statement: Stmt_Declare
}
