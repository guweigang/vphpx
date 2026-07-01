import rt

struct Class_WC_Admin_Status {
	rt.PhpObjectBase
}

fn create_wc_admin_status() &Class_WC_Admin_Status {
	mut obj := &Class_WC_Admin_Status{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Admin_Status) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Admin_Status) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Admin_Status) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_woocommerce_includes_admin_views_html_admin_page_status_php() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		// unsupported expression: Expr_Exit
	}
	mut var_current_tab := if !(!rt.is_true(rt.get_superglobal('_REQUEST').array_get('tab'))) { rt.call_function('sanitize_title', [
			rt.get_superglobal('_REQUEST').array_get('tab'),
		]) } else { rt.new_string('status') }
	mut var_tabs := rt.create_array([
		rt.ArrayItem{ key: 'status', val: rt.call_function('__', [
			rt.new_string('System status'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'tools', val: rt.call_function('__', [
			rt.new_string('Tools'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'logs', val: rt.call_function('__', [
			rt.new_string('Logs'),
			rt.new_string('woocommerce'),
		]) },
	])
	var_tabs = rt.call_function('apply_filters', [
		rt.new_string('woocommerce_admin_status_tabs'),
		var_tabs.dup(),
	])
	// unsupported statement: Stmt_InlineHTML
	{
		mut iter_1 := var_tabs.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_label := item_1.val
			mut var_name := item_1.key
			print('<a href="' +
				(rt.call_function('admin_url', ['admin.php?page=wc-status&tab=' + var_name.str()])).str() +
				'" class="nav-tab ')
			if rt.is_true(rt.equal(var_current_tab, var_name)) {
				print('nav-tab-active')
			}
			print('">' + var_label.str() + '</a>')
		}
	}
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_tabs.array_get(var_current_tab)]))
	// unsupported statement: Stmt_InlineHTML
	mut switch_val_1 := var_current_tab
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('tools'))) {
		fn () rt.PhpVal {
			mut temp := Class_WC_Admin_Status{}
			return temp.status_tools()
		}()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('logs'))) {
		fn () rt.PhpVal {
			mut temp := Class_WC_Admin_Status{}
			return temp.status_logs()
		}()
	} else {
		if rt.is_true(rt.new_bool(
			rt.is_true(rt.new_bool(var_tabs.dup().array_isset(var_current_tab.dup())))
			&& rt.is_true(rt.call_function('has_action', ['woocommerce_admin_status_content_' + var_current_tab.str()]))))
		{
			rt.call_function('do_action', [
				'woocommerce_admin_status_content_' + var_current_tab.str(),
			])
		} else {
			fn () rt.PhpVal {
				mut temp := Class_WC_Admin_Status{}
				return temp.status_report()
			}()
		}
	}
	// unsupported statement: Stmt_InlineHTML
}
