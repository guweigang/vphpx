import rt

struct Class_WC_Plugins_Screen_Updates {
	rt.PhpObjectBase
pub mut:
	upgrade_notice rt.PhpVal = rt.new_string('')
}

fn (mut this Class_WC_Plugins_Screen_Updates) construct() {
	rt.call_function('add_action', [
		rt.new_string('in_plugin_update_message-woocommerce/woocommerce.php'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Plugins_Screen_Updates', [
				'WC_Plugin_Updates',
			], &this) },
			rt.ArrayItem{ key: none, val: 'in_plugin_update_message' },
		]),
		rt.new_int(10),
		rt.new_int(2),
	])
}

fn (mut this Class_WC_Plugins_Screen_Updates) in_plugin_update_message(var_args rt.PhpVal, var_response rt.PhpVal) {
	mut var_response_mutated := var_response
	mut iife_temp_0 := Class_Automattic_Jetpack_Constants{}
	mut iife_result_0 :=
		iife_temp_0.get_constant(rt.new_string('WC_SSR_PLUGIN_UPDATE_RELEASE_VERSION_TYPE'))
	mut var_version_type := iife_result_0
	if !(var_version_type.clone().is_string()) {
		var_version_type = rt.new_string('none')
	}
	this.dispatch_set_prop('new_version', rt.get_property(var_response_mutated, 'new_version'))
	this.upgrade_notice = this.get_upgrade_notice(rt.get_property(var_response_mutated,
		'new_version'))
	this.dispatch_set_prop('major_untested_plugins', this.get_untested_plugins(rt.get_property(var_response_mutated,
		'new_version'), var_version_type.clone()))
	mut iife_temp_1 := Class_Automattic_Jetpack_Constants{}
	mut iife_result_1 := iife_temp_1.get_constant(rt.new_string('WC_VERSION'))
	mut var_current_version_parts := rt.call_function('explode', [
		rt.new_string('.'), iife_result_1])
	mut var_new_version_parts := rt.call_function('explode', [
		rt.new_string('.'),
		rt.get_property(rt.new_object('WC_Plugins_Screen_Updates', [
			'WC_Plugin_Updates',
		], &this), 'new_version')])
	if rt.is_true(rt.call_function('version_compare', [
		rt.new_string((var_current_version_parts.array_get(rt.new_int(0))).str() + '.' +
			(var_current_version_parts.array_get(rt.new_int(1))).str()),
		rt.new_string((var_new_version_parts.array_get(rt.new_int(0))).str() + '.' +
			(var_new_version_parts.array_get(rt.new_int(1))).str()),
		rt.new_string('='),
	]))
	{
		return
	}
	if !(!rt.is_true(rt.get_property(rt.new_object('WC_Plugins_Screen_Updates', [
		'WC_Plugin_Updates',
	], &this), 'major_untested_plugins'))) {
		this.upgrade_notice = rt.concat(this.upgrade_notice,
			this.get_extensions_inline_warning_major())
	}
	if !(!rt.is_true(rt.get_property(rt.new_object('WC_Plugins_Screen_Updates', [
		'WC_Plugin_Updates',
	], &this), 'major_untested_plugins'))) {
		this.upgrade_notice = rt.concat(this.upgrade_notice, this.get_extensions_modal_warning())
		rt.call_function('add_action', [rt.new_string('admin_print_footer_scripts'),
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('WC_Plugins_Screen_Updates', [
					'WC_Plugin_Updates',
				], &this) },
				rt.ArrayItem{ key: none, val: 'plugin_screen_modal_js' },
			])])
	}
	rt.echo_val(rt.call_function('apply_filters', [
		rt.new_string('woocommerce_in_plugin_update_message'),
		rt.new_string((if rt.is_true(this.upgrade_notice) {
			'</p>' + (rt.call_function('wp_kses_post', [this.upgrade_notice])).str() +
				'<p class="dummy">'
		} else {
			''
		}).str()),
	]))
}

fn (mut this Class_WC_Plugins_Screen_Updates) get_upgrade_notice(var_version rt.PhpVal) rt.PhpVal {
	mut var_transient_name := rt.new_string('wc_upgrade_notice_' + var_version.str())
	mut var_upgrade_notice := rt.call_function('get_transient', [
		var_transient_name.clone()])
	if rt.is_true(rt.identical(rt.new_bool(false), var_upgrade_notice)) {
		mut var_response := rt.call_function('wp_safe_remote_get', [
			rt.new_string('https://plugins.svn.wordpress.org/woocommerce/trunk/readme.txt'),
		])
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_response.clone()])))))
			&& !(!rt.is_true(var_response.array_get(rt.new_string('body')))) {
			var_upgrade_notice = this.parse_update_notice(var_response.array_get(rt.new_string('body')),
				var_version.clone())
			rt.call_function('set_transient', [var_transient_name.clone(),
				var_upgrade_notice.clone(), rt.get_constant('DAY_IN_SECONDS')])
		}
	}
	return var_upgrade_notice.clone()
}

fn (mut this Class_WC_Plugins_Screen_Updates) parse_update_notice(var_content rt.PhpVal, var_new_version rt.PhpVal) rt.PhpVal {
	mut var_version_parts := rt.call_function('explode', [rt.new_string('.'),
		var_new_version.clone()])
	mut var_check_for_notices := [(var_version_parts.array_get(rt.new_int(0))).str() + '.0',
		(var_version_parts.array_get(rt.new_int(0))).str() + '.0.0',
		
			(var_version_parts.array_get(rt.new_int(0))).str() + '.' +
			(var_version_parts.array_get(rt.new_int(1))).str(),
		(var_version_parts.array_get(rt.new_int(0))).str() + '.' +
			(var_version_parts.array_get(rt.new_int(1))).str() + '.' +
			(var_version_parts.array_get(rt.new_int(2))).str()]
	mut var_notice_regexp := rt.new_string(
		'~==\\s*Upgrade Notice\\s*==\\s*=\\s*(.*)\\s*=(.*)(=\\s*' +
		(rt.call_function('preg_quote', [var_new_version.clone()])).str() + '\\s*=|$)~Uis')
	mut var_upgrade_notice := rt.new_string('')
	for var_check_version in var_check_for_notices {
		mut iife_temp_2 := Class_Automattic_Jetpack_Constants{}
		mut iife_result_2 := iife_temp_2.get_constant(rt.new_string('WC_VERSION'))
		mut iife_temp_3 := Class_Automattic_Jetpack_Constants{}
		mut iife_result_3 := iife_temp_3.get_constant(rt.new_string('WC_VERSION'))
		if rt.is_true(rt.call_function('version_compare', [iife_result_2, rt.new_string(check_version),
			rt.new_string('>')]))
		{
			continue
		}
		mut var_matches := rt.new_null()
		if rt.is_true(rt.call_function('preg_match', [var_notice_regexp.clone(),
			var_content.clone(), var_matches.clone()]))
		{
			mut var_notices := rt.cast_array(rt.call_function('preg_split', [
				rt.new_string('~[\\r\\n]+~'),
				rt.new_string(var_matches.array_get(rt.new_int(2)).to_string().trim_space()),
			]))
			if rt.is_true(rt.call_function('version_compare', [
				rt.new_string(var_matches.array_get(rt.new_int(1)).to_string().trim_space()),
				rt.new_string(check_version),
				rt.new_string('='),
			]))
			{
				var_upgrade_notice = rt.concat(var_upgrade_notice,
					rt.new_string('<p class="wc_plugin_upgrade_notice">'))
				mut iter_1 := var_notices.iterator()
				for {
					item_1 := iter_1.next() or { break }
					mut var_line := item_1.val
					mut var_index := item_1.key
					var_upgrade_notice = rt.concat(var_upgrade_notice, rt.call_function('preg_replace', [
						rt.new_string('~\\[([^\\]]*)\\]\\(([^\\)]*)\\)~'),
						rt.new_string('<a href="${2}">${1}</a>'),
						var_line.clone(),
					]))
				}
				var_upgrade_notice = rt.concat(var_upgrade_notice, rt.new_string('</p>'))
			}
			break
		}
	}
	return rt.call_function('wp_kses_post', [var_upgrade_notice.clone()])
}

fn (mut this Class_WC_Plugins_Screen_Updates) plugin_screen_modal_js() {
	// unsupported statement: Stmt_InlineHTML
	this.generic_modal_js()
}

struct Class_WC_Plugin_Updates {
	rt.PhpObjectBase
}

struct Class_Automattic_Jetpack_Constants {
	rt.PhpObjectBase
}

fn create_wc_plugins_screen_updates() &Class_WC_Plugins_Screen_Updates {
	mut obj := &Class_WC_Plugins_Screen_Updates{
		PhpObjectBase:  rt.PhpObjectBase{}
		upgrade_notice: rt.new_string('')
	}
	obj.construct()
	return obj
}

fn create_wc_plugin_updates(_args ...rt.PhpVal) &Class_WC_Plugin_Updates {
	mut obj := &Class_WC_Plugin_Updates{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_jetpack_constants(_args ...rt.PhpVal) &Class_Automattic_Jetpack_Constants {
	mut obj := &Class_Automattic_Jetpack_Constants{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Plugins_Screen_Updates) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'in_plugin_update_message' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.in_plugin_update_message(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'get_upgrade_notice' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_upgrade_notice(dispatch_arg_0)
		}
		'parse_update_notice' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.parse_update_notice(dispatch_arg_0, dispatch_arg_1)
		}
		'plugin_screen_modal_js' {
			this.plugin_screen_modal_js()
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_Plugins_Screen_Updates) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'upgrade_notice' { return this.upgrade_notice }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_Plugins_Screen_Updates) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'upgrade_notice' {
			this.upgrade_notice = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_WC_Plugin_Updates) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Plugin_Updates) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Plugin_Updates) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_Jetpack_Constants) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_Jetpack_Constants) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_Jetpack_Constants) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		exit(0)
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [
		rt.new_string('WC_Plugin_Updates'),
	])))))
	{
		rt.include_file((rt.call_function('dirname', [rt.new_string(@FILE)])).str() +
			'/class-wc-plugin-updates.php', '2')
	}
	create_wc_plugins_screen_updates()
}
