import rt

struct Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Admin_SyncUI {
	rt.PhpObjectBase
pub mut:
	register rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Admin_SyncUI) init(mut var_register Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Register) {
	this.register = var_register
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Admin_SyncUI) init_hooks() {
	mut iife_temp_0 := Class_Automattic_WooCommerce_Internal_Utilities_Users{}
	mut iife_result_0 := iife_temp_0.is_site_administrator()
	if rt.is_true(rt.new_bool(!(rt.is_true(iife_result_0)))) {
		return
	}
	rt.call_function('add_filter', [rt.new_string('woocommerce_debug_tools'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Admin_SyncUI',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'add_tools' },
		])])
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Admin_SyncUI) add_tools(mut var_tools Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Admin_array) rt.PhpVal {
	mut var_tools_mutated := var_tools
	mut var_sync := rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [
		Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Synchronize.class(),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_sync, 'in_progress', []rt.PhpVal{}))))) {
		var_tools_mutated.array_set('approved_directories_sync', rt.create_array([
			rt.ArrayItem{ key: 'name', val: rt.call_function('__', [
				rt.new_string('Synchronize approved download directories'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [
				rt.new_string('Updates the list of Approved Product Download Directories. Note that triggering this tool does not impact whether the Approved Download Directories list is enabled or not.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'button', val: rt.call_function('__', [
				rt.new_string('Update'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'callback', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Admin_SyncUI',
					[]string{}, &this) },
				rt.ArrayItem{ key: none, val: 'trigger_sync' },
			]) },
			rt.ArrayItem{ key: 'requires_refresh', val: true },
		]))
		var_tools_mutated.array_set('approved_directories_clear', rt.create_array([
			rt.ArrayItem{ key: 'name', val: rt.call_function('__', [
				rt.new_string('Empty the approved download directories list'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [
				rt.new_string('Removes all existing entries from the Approved Product Download Directories list.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'button', val: rt.call_function('__', [
				rt.new_string('Clear'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'callback', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Admin_SyncUI',
					[]string{}, &this) },
				rt.ArrayItem{ key: none, val: 'clear_existing_entries' },
			]) },
			rt.ArrayItem{ key: 'requires_refresh', val: true },
		]))
	} else {
		var_tools_mutated.array_set('cancel_directories_scan', rt.create_array([
			rt.ArrayItem{ key: 'name', val: rt.call_function('__', [
				rt.new_string('Cancel synchronization of approved directories'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'desc', val: rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('The Approved Product Download Directories list is currently being synchronized with the product catalog (%d%% complete). If you need to, you can cancel it.'),
					rt.new_string('woocommerce'),
				]),
				rt.call_method(var_sync, 'get_progress', []rt.PhpVal{}),
			]) },
			rt.ArrayItem{ key: 'button', val: rt.call_function('__', [
				rt.new_string('Cancel'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'callback', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Admin_SyncUI',
					[]string{}, &this) },
				rt.ArrayItem{ key: none, val: 'cancel_sync' },
			]) },
		]))
	}
	return rt.new_object('Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Admin_array',
		[]string{}, var_tools_mutated)
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Admin_SyncUI) trigger_sync() {
	this.security_check()
	rt.call_method(rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [
		Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Synchronize.class(),
	]), 'start', []rt.PhpVal{})
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Admin_SyncUI) clear_existing_entries() {
	this.security_check()
	rt.call_method(this.register, 'delete_all', []rt.PhpVal{})
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Admin_SyncUI) cancel_sync() {
	this.security_check()
	rt.call_method(rt.call_function('wc_get_logger', []rt.PhpVal{}), 'log', [
		rt.new_string('info'),
		rt.call_function('__', [
			rt.new_string('Approved Download Directories sync: scan has been cancelled.'),
			rt.new_string('woocommerce'),
		]),
	])
	rt.call_method(rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [
		Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Synchronize.class(),
	]), 'stop', []rt.PhpVal{})
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Admin_SyncUI) security_check() {
	mut iife_temp_1 := Class_Automattic_WooCommerce_Internal_Utilities_Users{}
	mut iife_result_1 := iife_temp_1.is_site_administrator()
	if rt.is_true(rt.new_bool(!(rt.is_true(iife_result_1)))) {
		rt.call_function('wp_die', [
			rt.call_function('esc_html__', [
				rt.new_string('You do not have permission to modify the list of approved directories for product downloads.'),
				rt.new_string('woocommerce'),
			]),
		])
	}
}

struct Class_Automattic_WooCommerce_Internal_Utilities_Users {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_productdownloads_approveddirectories_admin_syncui(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Admin_SyncUI {
	mut obj := &Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Admin_SyncUI{
		PhpObjectBase: rt.PhpObjectBase{}
		register:      rt.new_null()
	}
	return obj
}

fn create_automattic_woocommerce_internal_utilities_users(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Utilities_Users {
	mut obj := &Class_Automattic_WooCommerce_Internal_Utilities_Users{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Admin_SyncUI) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'init' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Register](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.init(mut dispatch_arg_0)
			return rt.new_null()
		}
		'init_hooks' {
			this.init_hooks()
			return rt.new_null()
		}
		'add_tools' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Admin_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.add_tools(mut dispatch_arg_0)
		}
		'trigger_sync' {
			this.trigger_sync()
			return rt.new_null()
		}
		'clear_existing_entries' {
			this.clear_existing_entries()
			return rt.new_null()
		}
		'cancel_sync' {
			this.cancel_sync()
			return rt.new_null()
		}
		'security_check' {
			this.security_check()
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Admin_SyncUI) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'register' { return this.register }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Admin_SyncUI) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'register' {
			this.register = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Utilities_Users) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Utilities_Users) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Utilities_Users) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
