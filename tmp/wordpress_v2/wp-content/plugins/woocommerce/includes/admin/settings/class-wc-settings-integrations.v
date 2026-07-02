import rt

struct Class_WC_Settings_Integrations {
	rt.PhpObjectBase
pub mut:
	icon rt.PhpVal = rt.new_string('plugins')
}

fn (mut this Class_WC_Settings_Integrations) construct() {
	this.dispatch_set_prop('id', rt.new_string('integration'))
	this.dispatch_set_prop('label', rt.call_function('__', [rt.new_string('Integration'),
		rt.new_string('woocommerce')]))
	if !(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'integrations')).is_null()
		&& rt.is_true(rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'integrations'), 'get_integrations', []rt.PhpVal{})) {
		this.Class_WC_Settings_Page.construct()
	}
}

fn (mut this Class_WC_Settings_Integrations) get_own_sections() rt.PhpVal {
	mut var_current_section := rt.get_superglobal('current_section')
	mut var_sections := map[string]rt.PhpVal{}
	if rt.is_true(rt.new_bool(!(rt.is_true(this.wc_is_installing())))) {
		mut var_integrations := this.get_integrations()
		if rt.is_true(rt.new_bool(!(rt.is_true(var_current_section))))
			&& !(!rt.is_true(var_integrations)) {
			var_current_section = rt.get_property(rt.call_function('current', [
				var_integrations.clone(),
			]), 'id')
		}
		if var_integrations.clone().array_count() > 1 {
			mut iter_1 := var_integrations.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_integration := item_1.val
				mut var_title := if !rt.is_true(rt.get_property(var_integration, 'method_title')) { rt.call_function('ucfirst', [
						rt.get_property(var_integration, 'id'),
					]) } else { rt.get_property(var_integration, 'method_title') }
				var_sections[rt.get_property(var_integration, 'id').to_string().to_lower()] = rt.call_function('esc_html', [
					var_title.clone(),
				])
			}
		}
	}
	return var_sections.clone()
}

fn (mut this Class_WC_Settings_Integrations) wc_is_installing() rt.PhpVal {
	mut iife_temp_0 := Class_Automattic_Jetpack_Constants{}
	mut iife_result_0 := iife_temp_0.is_defined(rt.new_string('WC_INSTALLING'))
	return iife_result_0
}

fn (mut this Class_WC_Settings_Integrations) get_integrations() rt.PhpVal {
	return rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'integrations'),
		'get_integrations', []rt.PhpVal{})
}

fn (mut this Class_WC_Settings_Integrations) output() {
	mut var_current_section := rt.new_null()
	mut var_integrations := this.get_integrations()
	if var_integrations.array_isset(var_current_section) {
		rt.call_method(var_integrations.array_get(var_current_section), 'admin_options',
			[]rt.PhpVal{})
	}
}

struct Class_WC_Settings_Page {
	rt.PhpObjectBase
}

struct Class_Automattic_Jetpack_Constants {
	rt.PhpObjectBase
}

fn create_wc_settings_integrations() &Class_WC_Settings_Integrations {
	mut obj := &Class_WC_Settings_Integrations{
		PhpObjectBase: rt.PhpObjectBase{}
		icon:          rt.new_string('plugins')
	}
	obj.construct()
	return obj
}

fn create_wc_settings_page(_args ...rt.PhpVal) &Class_WC_Settings_Page {
	mut obj := &Class_WC_Settings_Page{
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

fn (mut this Class_WC_Settings_Integrations) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'get_own_sections' {
			return this.get_own_sections()
		}
		'wc_is_installing' {
			return this.wc_is_installing()
		}
		'get_integrations' {
			return this.get_integrations()
		}
		'output' {
			this.output()
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_Settings_Integrations) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'icon' { return this.icon }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_Settings_Integrations) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'icon' {
			this.icon = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_WC_Settings_Page) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Settings_Page) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Settings_Page) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [
		rt.new_string('WC_Settings_Integrations'),
		rt.new_bool(false),
	])))))
	{
	}
	return rt.new_object('WC_Settings_Integrations', ['WC_Settings_Page'],
		create_wc_settings_integrations())
}
