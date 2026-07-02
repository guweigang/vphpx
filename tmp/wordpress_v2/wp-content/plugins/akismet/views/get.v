import rt

struct Class_Akismet_Admin {
	rt.PhpObjectBase
}

fn create_akismet_admin(_args ...rt.PhpVal) &Class_Akismet_Admin {
	mut obj := &Class_Akismet_Admin{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Akismet_Admin) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Akismet_Admin) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Akismet_Admin) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_classes := rt.new_null()
	mut var_redirect := rt.new_null()
	mut var_utm_source := rt.new_null()
	mut var_utm_medium := rt.new_null()
	mut var_utm_campaign := rt.new_null()
	mut var_utm_content := rt.new_null()
	mut var_text := rt.new_null()
	mut var_submit_classes_attr := rt.new_string('akismet-button')
	if !var_classes.is_null()
		&& if rt.call_function('is_countable', [var_classes.clone()]) { var_classes.clone().array_count() } else { 0 } > 0 {
		var_submit_classes_attr = rt.call_function('implode', [
			rt.new_string(' '), var_classes.clone()])
	}
	mut iife_temp_0 := Class_Akismet_Admin{}
	mut iife_result_0 := iife_temp_0.get_page_url()
	mut var_query_args := rt.create_array([
		rt.ArrayItem{ key: 'passback_url', val: iife_result_0 },
		rt.ArrayItem{
			key: 'redirect'
			val: if !var_redirect.is_null() { var_redirect } else { rt.new_string('plugin-signup') }
		},
	])
	mut var_utm_args := {
		'utm_source':   if !var_utm_source.is_null() {
			var_utm_source
		} else {
			rt.new_string('akismet_plugin')
		}
		'utm_medium':   if !var_utm_medium.is_null() {
			var_utm_medium
		} else {
			rt.new_string('in_plugin')
		}
		'utm_campaign': if !var_utm_campaign.is_null() {
			var_utm_campaign
		} else {
			rt.new_string('plugin_static_link')
		}
		'utm_content':  if !var_utm_content.is_null() {
			var_utm_content
		} else {
			rt.new_string('get_view_link')
		}
	}
	var_query_args = rt.call_function('array_merge', [var_query_args.clone(),
		rt.create_array_from_native_map(var_utm_args)])
	mut var_url := rt.call_function('add_query_arg', [var_query_args.clone(),
		rt.new_string('https://akismet.com/get/')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [var_url.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_submit_classes_attr.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [if var_text.clone().is_string() {
		var_text
	} else {
		rt.new_string('')
	}]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('(opens in a new tab)'),
		rt.new_string('akismet')])
	// unsupported statement: Stmt_InlineHTML
}
