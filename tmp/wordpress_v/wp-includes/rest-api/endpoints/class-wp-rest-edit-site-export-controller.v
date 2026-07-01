import rt

struct Class_WP_REST_Edit_Site_Export_Controller {
	rt.PhpObjectBase
}

fn (mut this Class_WP_REST_Edit_Site_Export_Controller) construct() {
	this.dispatch_set_prop('namespace', rt.new_string('wp-block-editor/v1'))
	this.dispatch_set_prop('rest_base', rt.new_string('export'))
}

fn (mut this Class_WP_REST_Edit_Site_Export_Controller) register_routes() {
	rt.call_function('register_rest_route', [
		rt.get_property(rt.new_object('WP_REST_Edit_Site_Export_Controller', [
			'WP_REST_Controller',
		], &this), 'namespace'),
		'/' +
			rt.get_property(rt.new_object('WP_REST_Edit_Site_Export_Controller', ['WP_REST_Controller'], &this), 'rest_base'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() },
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Edit_Site_Export_Controller', [
						'WP_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'export' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Edit_Site_Export_Controller', [
						'WP_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'permissions_check' },
				]) },
			]) },
		]),
	])
}

fn (mut this Class_WP_REST_Edit_Site_Export_Controller) permissions_check() bool {
	if rt.is_true(rt.call_function('current_user_can', [rt.new_string('export')])) {
		return true
	}
	return (create_wp_error(rt.new_string('rest_cannot_export_templates'), rt.call_function('__', [
		rt.new_string('Sorry, you are not allowed to export templates and template parts.'),
	]), rt.create_array([
		rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code',
			[]rt.PhpVal{}) },
	]))).to_bool()
}

fn (mut this Class_WP_REST_Edit_Site_Export_Controller) export() rt.PhpVal {
	mut var_filename := rt.call_function('wp_generate_block_templates_export_file', []rt.PhpVal{})
	if rt.is_true(rt.call_function('is_wp_error', [var_filename.dup()])) {
		rt.call_method(var_filename, 'add_data', [
			rt.create_array([rt.ArrayItem{ key: 'status', val: 500 }]),
		])
		return var_filename.dup()
	}
	mut var_theme_name := rt.call_function('basename', [
		rt.call_function('get_stylesheet', []rt.PhpVal{}),
	])
	rt.call_function('header', [rt.new_string('Content-Type: application/zip')])
	rt.call_function('header', [
		'Content-Disposition: attachment; filename=' + var_theme_name.str() + '.zip',
	])
	rt.call_function('header', [
		'Content-Length: ' + (rt.call_function('filesize', [var_filename.dup()])).str(),
	])
	rt.call_function('flush', []rt.PhpVal{})
	rt.call_function('readfile', [var_filename.dup()])
	rt.call_function('unlink', [var_filename.dup()])
	// unsupported expression: Expr_Exit
	return rt.new_null()
}

struct Class_WP_REST_Controller {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

fn create_wp_rest_edit_site_export_controller() &Class_WP_REST_Edit_Site_Export_Controller {
	mut obj := &Class_WP_REST_Edit_Site_Export_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	obj.construct()
	return obj
}

fn create_wp_rest_controller() &Class_WP_REST_Controller {
	mut obj := &Class_WP_REST_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_error() &Class_WP_Error {
	mut obj := &Class_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_REST_Edit_Site_Export_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'register_routes' {
			this.register_routes()
			return rt.new_null()
		}
		'permissions_check' {
			return rt.new_bool(this.permissions_check())
		}
		'export' {
			return this.export()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WP_REST_Edit_Site_Export_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_REST_Edit_Site_Export_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WP_REST_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_REST_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_REST_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WP_Error) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Error) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Error) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_includes_rest_api_endpoints_class_wp_rest_edit_site_export_controller_php() {
}
