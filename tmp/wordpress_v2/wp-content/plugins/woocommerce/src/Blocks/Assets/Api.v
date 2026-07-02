import rt
import crypto.md5

struct Class_Automattic_WooCommerce_Blocks_Assets_Api {
	rt.PhpObjectBase
pub mut:
	wc_version                rt.PhpVal = rt.new_null()
	inline_scripts            rt.PhpVal = rt.new_array()
	disable_cache             bool
	script_data               rt.PhpVal = rt.new_null()
	script_data_modified      bool
	script_data_hash          rt.PhpVal = rt.new_null()
	script_data_transient_key rt.PhpVal = rt.new_string('woocommerce_blocks_asset_api_script_data')
	package                   rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Assets_Api) construct(mut var_package Class_Automattic_WooCommerce_Blocks_Domain_Package) {
	mut iife_temp_0 := Class_Automattic_Jetpack_Constants{}
	mut iife_result_0 := iife_temp_0.get_constant(rt.new_string('WC_VERSION'))
	this.wc_version = 'wc-' + iife_result_0.str()
	this.package = var_package
	this.disable_cache = rt.is_true(rt.call_function('defined', [rt.new_string('SCRIPT_DEBUG')]))
		&& rt.is_true(rt.get_constant('SCRIPT_DEBUG'))
		|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('wp_get_environment_type', []rt.PhpVal{}), rt.new_string('production')))))
	if rt.is_true(rt.call_function('is_ssl', []rt.PhpVal{})) {
		this.script_data_transient_key = rt.concat(this.script_data_transient_key,
			rt.new_string('_ssl'))
	}
	if !(this.disable_cache) {
		this.script_data_hash = this.get_script_data_hash()
	}
	rt.call_function('add_action', [rt.new_string('shutdown'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_Assets_Api',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'update_script_data_cache' },
		]),
		rt.new_int(20)])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Assets_Api) get_file_version(var_file rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.call_function('defined', [rt.new_string('SCRIPT_DEBUG')]))
		&& rt.is_true(rt.get_constant('SCRIPT_DEBUG'))
		&& rt.is_true(rt.call_function('file_exists', [rt.new_string((rt.call_method(this.package, 'get_path', []rt.PhpVal{})).str() + var_file.str())])) {
		return rt.call_function('filemtime', [
			rt.call_method(this.package, 'get_path', [
				rt.new_string(var_file.clone().to_string().trim_space()),
			]),
		])
	}
	return this.wc_version
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Assets_Api) get_asset_url(relative_path string) rt.PhpVal {
	return rt.call_method(this.package, 'get_url', [rt.new_string(relative_path)])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Assets_Api) get_block_metadata_path(var_block_name rt.PhpVal, path string) bool {
	mut var_path_to_metadata_from_plugin_root := rt.call_method(this.package, 'get_path', [
		rt.new_string('assets/client/blocks/' + path + var_block_name.str() + '/block.json'),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('file_exists', [
		var_path_to_metadata_from_plugin_root.clone()])))))
	{
		return false
	}
	return var_path_to_metadata_from_plugin_root.to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Assets_Api) get_script_data_hash() string {
	return md5.hexhash(
		(rt.call_function('get_option', [rt.new_string('siteurl'), rt.new_string('')])).str() +
		(this.wc_version).str() + (rt.call_method(this.package, 'get_path', []rt.PhpVal{})).str())
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Assets_Api) get_cached_script_data() rt.PhpVal {
	if this.disable_cache {
		return rt.new_array()
	}
	mut var_transient_value := rt.call_function('json_decode', [
		rt.new_string((rt.call_function('get_transient', [this.script_data_transient_key])).str()),
		rt.new_bool(true),
	])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('json_last_error', []rt.PhpVal{}), rt.get_constant('JSON_ERROR_NONE')))))
		|| !rt.is_true(var_transient_value)
		|| !rt.is_true(var_transient_value.array_get(rt.new_string('script_data')))
		|| !rt.is_true(var_transient_value.array_get(rt.new_string('version')))
		|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_transient_value.array_get(rt.new_string('version')), this.wc_version))))
		|| !rt.is_true(var_transient_value.array_get(rt.new_string('hash')))
		|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_transient_value.array_get(rt.new_string('hash')), this.script_data_hash)))) {
		return rt.new_array()
	}
	return rt.cast_array(if !(var_transient_value.array_get(rt.new_string('script_data'))).is_null() {
		var_transient_value.array_get(rt.new_string('script_data'))
	} else {
		rt.new_array()
	})
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Assets_Api) update_script_data_cache() {
	if this.script_data.is_null() || this.disable_cache {
		return
	}
	if !(this.script_data_modified) {
		return
	}
	rt.call_function('set_transient', [this.script_data_transient_key,
		rt.call_function('wp_json_encode', [
			rt.create_array([rt.ArrayItem{ key: 'script_data', val: this.script_data },
				rt.ArrayItem{ key: 'version', val: this.wc_version },
				rt.ArrayItem{ key: 'hash', val: this.script_data_hash }]),
		]),
		rt.mul(rt.get_constant('DAY_IN_SECONDS'), rt.new_int(30))])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Assets_Api) get_asset_data(var_filename rt.PhpVal) rt.PhpVal {
	mut var_filename_mutated := var_filename
	mut var_asset_path := rt.call_method(this.package, 'get_path', [
		var_filename_mutated.clone()])
	mut var_asset := if rt.is_true(rt.call_function('file_exists', [
		var_asset_path.clone()]))
	{ rt.include_file(var_asset_path.to_string(), '3') } else { rt.new_array() }
	return var_asset.clone()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Assets_Api) get_script_data(var_relative_src rt.PhpVal, var_dependencies rt.PhpVal) rt.PhpVal {
	mut var_dependencies_mutated := var_dependencies
	if rt.is_true(rt.new_bool(!(rt.is_true(var_relative_src)))) {
		return rt.create_array([rt.ArrayItem{ key: 'src', val: '' },
			rt.ArrayItem{ key: 'version', val: '1' }, rt.ArrayItem{
				key: 'dependencies'
				val: var_dependencies_mutated
			}])
	}
	if rt.is_true(rt.new_bool(this.script_data.is_null())) {
		this.script_data = this.get_cached_script_data()
	}
	if !rt.is_true(this.script_data.array_get(var_relative_src)) {
		mut var_asset_path := rt.call_method(this.package, 'get_path', [
			rt.call_function('str_replace', [rt.new_string('.js'),
				rt.new_string('.asset.php'), var_relative_src.clone()]),
		])
		mut var_asset := if rt.is_true(rt.call_function('file_exists', [
			var_asset_path.clone()]))
		{ rt.include_file(var_asset_path.to_string(), '3') } else { rt.new_array() }
		this.script_data.array_set(var_relative_src, rt.create_array([
			rt.ArrayItem{ key: 'src', val: this.get_asset_url(var_relative_src.str()) },
			rt.ArrayItem{
				key: 'version'
				val: if !(!rt.is_true(var_asset.array_get(rt.new_string('version')))) {
					var_asset.array_get(rt.new_string('version'))
				} else {
					this.get_file_version(var_relative_src.clone())
				}
			},
			rt.ArrayItem{
				key: 'dependencies'
				val: if !(!rt.is_true(var_asset.array_get(rt.new_string('dependencies')))) {
					var_asset.array_get(rt.new_string('dependencies'))
				} else {
					rt.new_array()
				}
			},
		]))
		this.script_data_modified = true
	}
	return rt.create_array([
		rt.ArrayItem{
			key: 'src'
			val: this.script_data.array_get(var_relative_src).array_get(rt.new_string('src'))
		},
		rt.ArrayItem{
			key: 'version'
			val: this.script_data.array_get(var_relative_src).array_get(rt.new_string('version'))
		},
		rt.ArrayItem{ key: 'dependencies', val: rt.call_function('array_merge', [
			this.script_data.array_get(var_relative_src).array_get(rt.new_string('dependencies')),
			var_dependencies_mutated.clone(),
		]) },
	])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Assets_Api) register_script(var_handle rt.PhpVal, var_relative_src rt.PhpVal, var_dependencies rt.PhpVal, has_i18n bool) {
	mut var_dependencies_mutated := var_dependencies
	mut var_script_data := this.get_script_data(var_relative_src.clone(),
		var_dependencies_mutated.clone())
	if rt.is_true(rt.call_function('in_array', [var_handle.clone(),
		var_script_data.array_get(rt.new_string('dependencies')),
		rt.new_bool(true)]))
	{
		if rt.is_true(rt.identical(rt.call_function('wp_get_environment_type', []rt.PhpVal{}),
			rt.new_string('development')))
		{
			var_dependencies_mutated = rt.call_function('array_diff', [
				var_script_data.array_get(rt.new_string('dependencies')),
				rt.create_array([rt.ArrayItem{ key: none, val: var_handle }]),
			])
			closure_2_fn := fn [var_handle] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
				print('<div class="error"><p>')
				rt.call_function('printf', [
					rt.call_function('esc_html__', [
						rt.new_string('Script with handle %s had a dependency on itself which has been removed. This is an indicator that your JS code has a circular dependency that can cause bugs.'),
						rt.new_string('woocommerce'),
					]),
					rt.call_function('esc_html', [
						var_handle.clone(),
					]),
				])
				print('</p></div>')
				return rt.new_null()
			}
			rt.call_function('add_action', [rt.new_string('admin_notices'),
				rt.new_closure(closure_2_fn)])
		} else {
			rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.call_function('sprintf', [
				rt.new_string('Script with handle %s had a dependency on itself. This is an indicator that your JS code has a circular dependency that can cause bugs.'),
				var_handle.clone(),
			]))))
		}
	}
	mut var_script_dependencies := rt.call_function('apply_filters', [
		rt.new_string('woocommerce_blocks_register_script_dependencies'),
		var_script_data.array_get(rt.new_string('dependencies')),
		var_handle.clone(),
	])
	rt.call_function('wp_register_script', [var_handle.clone(),
		var_script_data.array_get(rt.new_string('src')), var_script_dependencies.clone(),
		var_script_data.array_get(rt.new_string('version')), rt.new_bool(true)])
	if var_has_i18n
		&& rt.is_true(rt.call_function('function_exists', [rt.new_string('wp_set_script_translations')])) {
		rt.call_function('wp_set_script_translations', [var_handle.clone(),
			rt.new_string('woocommerce'),
			rt.call_method(this.package, 'get_path', [
				rt.new_string('languages'),
			])])
		rt.call_function('wp_set_script_translations', [var_handle.clone(),
			rt.new_string('woocommerce'),
			rt.call_method(this.package, 'get_path', [
				rt.new_string('i18n/languages'),
			])])
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Assets_Api) register_style(var_handle rt.PhpVal, var_relative_src rt.PhpVal, var_deps rt.PhpVal, media string, rtl bool) {
	mut var_filename := rt.call_function('str_replace', [
		rt.call_function('plugins_url', [rt.new_string('/'),
			rt.call_function('dirname', [rt.new_string(@DIR)])]),
		rt.new_string(''),
		var_relative_src.clone(),
	])
	mut var_src := this.get_asset_url(var_relative_src.str())
	mut var_ver := this.get_file_version(var_filename.clone())
	rt.call_function('wp_register_style', [var_handle.clone(),
		var_src.clone(), var_deps.clone(), var_ver.clone(), rt.new_string(media)])
	if var_rtl {
		rt.call_function('wp_style_add_data', [var_handle.clone(),
			rt.new_string('rtl'), rt.new_string('replace')])
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Assets_Api) get_block_asset_build_path(var_filename rt.PhpVal, type string) string {
	mut var_filename_mutated := var_filename
	return 'assets/client/blocks/${var_filename.to_string()}.${var_type}'
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Assets_Api) add_inline_script(var_handle rt.PhpVal, var_script rt.PhpVal) {
	if !(!rt.is_true(this.inline_scripts.array_get(var_handle)))
		&& rt.is_true(rt.call_function('in_array', [var_script.clone(), this.inline_scripts.array_get(var_handle), rt.new_bool(true)])) {
		return
	}
	rt.call_function('wp_add_inline_script', [var_handle.clone(),
		var_script.clone()])
	if this.inline_scripts.array_isset(var_handle) {
		this.inline_scripts.array_get_mut(var_handle).array_push(var_script.clone())
	} else {
		this.inline_scripts.array_set(var_handle, rt.create_array([
			rt.ArrayItem{ key: none, val: var_script },
		]))
	}
}

struct Class_Automattic_Jetpack_Constants {
	rt.PhpObjectBase
}

struct Class_Exception {
	rt.PhpObjectBase
pub mut:
	message string
	code    i64
	file    string
	line    i64
}

fn (mut this Class_Exception) construct(var_message rt.PhpVal) {
	this.message = var_message.to_string()
}

fn (mut this Class_Exception) getmessage() string {
	return this.message
}

fn create_automattic_woocommerce_blocks_assets_api(arg_0 rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_Assets_Api {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Assets_Api{
		PhpObjectBase:             rt.PhpObjectBase{}
		wc_version:                rt.new_null()
		inline_scripts:            rt.new_array()
		disable_cache:             false
		script_data:               rt.new_null()
		script_data_modified:      false
		script_data_hash:          rt.new_null()
		script_data_transient_key: rt.new_string('woocommerce_blocks_asset_api_script_data')
		package:                   rt.new_null()
	}
	obj.construct(arg_0)
	return obj
}

fn create_automattic_jetpack_constants(_args ...rt.PhpVal) &Class_Automattic_Jetpack_Constants {
	mut obj := &Class_Automattic_Jetpack_Constants{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_exception(arg_0 rt.PhpVal) &Class_Exception {
	mut obj := &Class_Exception{
		PhpObjectBase: rt.PhpObjectBase{}
		message:       ''
		code:          i64(0)
		file:          ''
		line:          i64(0)
	}
	obj.construct(arg_0)
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Assets_Api) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Blocks_Domain_Package](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.construct(mut dispatch_arg_0)
			return rt.new_null()
		}
		'get_file_version' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_file_version(dispatch_arg_0)
		}
		'get_asset_url' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_asset_url(dispatch_arg_0)
		}
		'get_block_metadata_path' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return rt.new_bool(this.get_block_metadata_path(dispatch_arg_0, dispatch_arg_1))
		}
		'get_script_data_hash' {
			return rt.new_string(this.get_script_data_hash())
		}
		'get_cached_script_data' {
			return this.get_cached_script_data()
		}
		'update_script_data_cache' {
			this.update_script_data_cache()
			return rt.new_null()
		}
		'get_asset_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_asset_data(dispatch_arg_0)
		}
		'get_script_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.get_script_data(dispatch_arg_0, dispatch_arg_1)
		}
		'register_script' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).to_bool()
			this.register_script(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
			return rt.new_null()
		}
		'register_style' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).str()
			dispatch_arg_4 := (if args.len > 4 { args[4] } else { rt.new_null() }).to_bool()
			this.register_style(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3,
				dispatch_arg_4)
			return rt.new_null()
		}
		'get_block_asset_build_path' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return rt.new_string(this.get_block_asset_build_path(dispatch_arg_0, dispatch_arg_1))
		}
		'add_inline_script' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.add_inline_script(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Blocks_Assets_Api) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'wc_version' { return this.wc_version }
		'inline_scripts' { return this.inline_scripts }
		'disable_cache' { return rt.new_bool(this.disable_cache) }
		'script_data' { return this.script_data }
		'script_data_modified' { return rt.new_bool(this.script_data_modified) }
		'script_data_hash' { return this.script_data_hash }
		'script_data_transient_key' { return this.script_data_transient_key }
		'package' { return this.package }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Assets_Api) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'wc_version' {
			this.wc_version = val
			return true
		}
		'inline_scripts' {
			this.inline_scripts = val
			return true
		}
		'disable_cache' {
			this.disable_cache = val.to_bool()
			return true
		}
		'script_data' {
			this.script_data = val
			return true
		}
		'script_data_modified' {
			this.script_data_modified = val.to_bool()
			return true
		}
		'script_data_hash' {
			this.script_data_hash = val
			return true
		}
		'script_data_transient_key' {
			this.script_data_transient_key = val
			return true
		}
		'package' {
			this.package = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
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

fn (mut this Class_Exception) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'getMessage' {
			return rt.new_string(this.getmessage())
		}
		else {
			return none
		}
	}
}

fn (this &Class_Exception) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'message' { return rt.new_string(this.message) }
		'code' { return rt.new_int(this.code) }
		'file' { return rt.new_string(this.file) }
		'line' { return rt.new_int(this.line) }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Exception) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'message' {
			this.message = val.str()
			return true
		}
		'code' {
			this.code = val.to_i64()
			return true
		}
		'file' {
			this.file = val.str()
			return true
		}
		'line' {
			this.line = val.to_i64()
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn main() {
	defer {
		rt.shutdown()
	}
}
