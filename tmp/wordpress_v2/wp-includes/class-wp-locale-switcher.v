import rt

struct Class_WP_Locale_Switcher {
	rt.PhpObjectBase
pub mut:
	stack               rt.PhpVal = rt.new_array()
	original_locale     rt.PhpVal = rt.new_null()
	available_languages rt.PhpVal = rt.new_null()
}

fn (mut this Class_WP_Locale_Switcher) construct() {
	this.original_locale = rt.call_function('determine_locale', []rt.PhpVal{})
	this.available_languages = rt.call_function('array_merge', [
		rt.create_array([rt.ArrayItem{ key: none, val: 'en_US' }]),
		rt.call_function('get_available_languages', []rt.PhpVal{}),
	])
}

fn (mut this Class_WP_Locale_Switcher) init() {
	rt.call_function('add_filter', [rt.new_string('locale'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WP_Locale_Switcher', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'filter_locale' },
		])])
	rt.call_function('add_filter', [rt.new_string('determine_locale'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WP_Locale_Switcher', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'filter_locale' },
		])])
}

fn (mut this Class_WP_Locale_Switcher) switch_to_locale(var_locale rt.PhpVal, user_id bool) bool {
	mut var_locale_mutated := var_locale
	mut var_current_locale := rt.call_function('determine_locale', []rt.PhpVal{})
	if rt.is_true(rt.identical(var_current_locale, var_locale_mutated)) {
		return false
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
		var_locale_mutated.clone(), this.available_languages, rt.new_bool(true)])))))
	{
		return false
	}
	this.stack.array_push(rt.create_array([
		rt.ArrayItem{ key: none, val: var_locale_mutated },
		rt.ArrayItem{ key: none, val: user_id },
	]))
	this.change_locale(var_locale_mutated.clone())
	rt.call_function('do_action', [rt.new_string('switch_locale'),
		var_locale_mutated.clone(), rt.new_bool(user_id)])
	return true
}

fn (mut this Class_WP_Locale_Switcher) switch_to_user_locale(var_user_id rt.PhpVal) rt.PhpVal {
	mut var_locale := rt.call_function('get_user_locale', [var_user_id.clone()])
	return rt.new_bool(this.switch_to_locale(var_locale.clone(), var_user_id.to_bool()))
}

fn (mut this Class_WP_Locale_Switcher) restore_previous_locale() bool {
	mut var_previous_locale := rt.call_function('array_pop', [this.stack])
	if rt.is_true(rt.identical(rt.new_null(), var_previous_locale)) {
		return false
	}
	mut var_entry := rt.call_function('end', [this.stack])
	mut var_locale := if var_entry.clone().is_array() {
		var_entry.array_get(rt.new_int(0))
	} else {
		rt.new_bool(false)
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_locale)))) {
		var_locale = this.original_locale
	}
	this.change_locale(var_locale.clone())
	rt.call_function('do_action', [rt.new_string('restore_previous_locale'),
		var_locale.clone(), var_previous_locale.array_get(rt.new_int(0))])
	return var_locale.to_bool()
}

fn (mut this Class_WP_Locale_Switcher) restore_current_locale() bool {
	if !rt.is_true(this.stack) {
		return false
	}
	this.stack = rt.create_array([
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: none, val: this.original_locale },
			rt.ArrayItem{ key: none, val: false },
		]) },
	])
	return this.restore_previous_locale()
}

fn (mut this Class_WP_Locale_Switcher) is_switched() bool {
	return !(!rt.is_true(this.stack))
}

fn (mut this Class_WP_Locale_Switcher) get_switched_locale() bool {
	mut var_entry := rt.call_function('end', [this.stack])
	if rt.is_true(var_entry) {
		return (var_entry.array_get(rt.new_int(0))).to_bool()
	}
	return false
}

fn (mut this Class_WP_Locale_Switcher) get_switched_user_id() bool {
	mut var_entry := rt.call_function('end', [this.stack])
	if rt.is_true(var_entry) {
		return (var_entry.array_get(rt.new_int(1))).to_bool()
	}
	return false
}

fn (mut this Class_WP_Locale_Switcher) filter_locale(var_locale rt.PhpVal) rt.PhpVal {
	mut var_locale_mutated := var_locale
	mut var_switched_locale := rt.new_bool(this.get_switched_locale())
	if rt.is_true(var_switched_locale) {
		return var_switched_locale.clone()
	}
	return var_locale_mutated.clone()
}

fn (mut this Class_WP_Locale_Switcher) load_translations(var_locale rt.PhpVal) {
	mut var_l10n := rt.new_null()
	mut var_locale_mutated := var_locale
	mut var_domains := if rt.is_true(var_l10n) {
		rt.func_array_keys(var_l10n.clone())
	} else {
		rt.new_array()
	}
	rt.call_function('load_default_textdomain', [var_locale_mutated.clone()])
	mut iter_1 := var_domains.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_domain := item_1.val
		if rt.is_true(rt.identical(rt.new_string('default'), var_domain)) {
			continue
		}
		rt.call_function('unload_textdomain', [var_domain.clone(),
			rt.new_bool(true)])
		rt.call_function('get_translations_for_domain', [var_domain.clone()])
	}
}

fn (mut this Class_WP_Locale_Switcher) change_locale(var_locale rt.PhpVal) {
	mut var_phpmailer := rt.new_null()
	mut var_locale_mutated := var_locale
	mut var_wp_locale := rt.get_superglobal('wp_locale')
	this.load_translations(var_locale_mutated.clone())
	var_wp_locale = create_wp_locale()
	mut iife_temp_0 := Class_WP_Translation_Controller{}
	mut iife_result_0 := iife_temp_0.get_instance()
	rt.call_method(iife_result_0, 'set_locale', [var_locale_mutated.clone()])
	if rt.is_true(rt.new_bool(rt.instance_of(var_phpmailer, 'WP_PHPMailer'))) {
		rt.call_method(var_phpmailer, 'setLanguage', []rt.PhpVal{})
	}
	rt.call_function('do_action', [rt.new_string('change_locale'),
		var_locale_mutated.clone()])
}

struct Class_WP_Locale {
	rt.PhpObjectBase
}

struct Class_WP_Translation_Controller {
	rt.PhpObjectBase
}

fn create_wp_locale_switcher() &Class_WP_Locale_Switcher {
	mut obj := &Class_WP_Locale_Switcher{
		PhpObjectBase:       rt.PhpObjectBase{}
		stack:               rt.new_array()
		original_locale:     rt.new_null()
		available_languages: rt.new_null()
	}
	obj.construct()
	return obj
}

fn create_wp_locale(_args ...rt.PhpVal) &Class_WP_Locale {
	mut obj := &Class_WP_Locale{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_translation_controller(_args ...rt.PhpVal) &Class_WP_Translation_Controller {
	mut obj := &Class_WP_Translation_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Locale_Switcher) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'init' {
			this.init()
			return rt.new_null()
		}
		'switch_to_locale' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			return rt.new_bool(this.switch_to_locale(dispatch_arg_0, dispatch_arg_1))
		}
		'switch_to_user_locale' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.switch_to_user_locale(dispatch_arg_0)
		}
		'restore_previous_locale' {
			return rt.new_bool(this.restore_previous_locale())
		}
		'restore_current_locale' {
			return rt.new_bool(this.restore_current_locale())
		}
		'is_switched' {
			return rt.new_bool(this.is_switched())
		}
		'get_switched_locale' {
			return rt.new_bool(this.get_switched_locale())
		}
		'get_switched_user_id' {
			return rt.new_bool(this.get_switched_user_id())
		}
		'filter_locale' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.filter_locale(dispatch_arg_0)
		}
		'load_translations' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.load_translations(dispatch_arg_0)
			return rt.new_null()
		}
		'change_locale' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.change_locale(dispatch_arg_0)
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WP_Locale_Switcher) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'stack' { return this.stack }
		'original_locale' { return this.original_locale }
		'available_languages' { return this.available_languages }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_Locale_Switcher) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'stack' {
			this.stack = val
			return true
		}
		'original_locale' {
			this.original_locale = val
			return true
		}
		'available_languages' {
			this.available_languages = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_WP_Locale) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Locale) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Locale) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WP_Translation_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Translation_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Translation_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
