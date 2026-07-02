import rt

pub fn Class_WC_Integration_MaxMind_Database_Service.database() string {
	return 'GeoLite2-Country'
}

pub fn Class_WC_Integration_MaxMind_Database_Service.database_extension() string {
	return '.mmdb'
}

struct Class_WC_Integration_MaxMind_Database_Service {
	rt.PhpObjectBase
pub mut:
	database_prefix rt.PhpVal = rt.new_null()
}

fn (mut this Class_WC_Integration_MaxMind_Database_Service) construct(var_database_prefix rt.PhpVal) {
	this.database_prefix = var_database_prefix.clone()
}

fn (mut this Class_WC_Integration_MaxMind_Database_Service) get_database_path() rt.PhpVal {
	mut var_uploads_dir := rt.call_function('wp_upload_dir', []rt.PhpVal{})
	mut var_database_path := rt.new_string(
		(rt.call_function('trailingslashit', [var_uploads_dir.array_get(rt.new_string('basedir'))])).str() +
		'woocommerce_uploads/')
	if !(!rt.is_true(this.database_prefix)) {
		var_database_path = rt.concat(var_database_path, rt.new_string(
			(this.database_prefix).str() + '-'))
	}
	var_database_path = rt.concat(var_database_path, rt.new_string(
		Class_WC_Integration_MaxMind_Database_Service.database() +
		Class_WC_Integration_MaxMind_Database_Service.database_extension()))
	var_database_path = rt.call_function('apply_filters_deprecated', [
		rt.new_string('woocommerce_geolocation_local_database_path'),
		rt.create_array([rt.ArrayItem{ key: none, val: var_database_path },
			rt.ArrayItem{ key: none, val: 2 }]),
		rt.new_string('3.9.0'),
		rt.new_string('woocommerce_maxmind_geolocation_database_path'),
	])
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_maxmind_geolocation_database_path'),
		var_database_path.clone(),
	])
}

fn (mut this Class_WC_Integration_MaxMind_Database_Service) download_database(var_license_key rt.PhpVal) rt.PhpVal {
	mut var_download_uri := rt.call_function('add_query_arg', [
		rt.create_array([
			rt.ArrayItem{
				key: 'edition_id'
				val: Class_WC_Integration_MaxMind_Database_Service.database()
			},
			rt.ArrayItem{ key: 'license_key', val: rt.call_function('urlencode', [
				rt.call_function('wc_clean', [var_license_key.clone()]),
			]) },
			rt.ArrayItem{ key: 'suffix', val: 'tar.gz' },
		]),
		rt.new_string('https://download.maxmind.com/app/geoip_download'),
	])
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/file.php', '4')
	mut var_tmp_archive_path := rt.call_function('download_url', [
		rt.call_function('esc_url_raw', [var_download_uri.clone()]),
	])
	if rt.is_true(rt.call_function('is_wp_error', [var_tmp_archive_path.clone()])) {
		mut var_error_data := rt.call_method(var_tmp_archive_path, 'get_error_data', []rt.PhpVal{})
		if var_error_data.array_isset(rt.new_string('code')) {
			mut switch_val_1 := var_error_data.array_get(rt.new_string('code'))
			if rt.is_true(rt.equal(switch_val_1, rt.new_int(401))) {
				return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('woocommerce_maxmind_geolocation_database_license_key'), rt.call_function('__', [
					rt.new_string('The MaxMind license key is invalid. If you have recently created this key, you may need to wait for it to become active.'),
					rt.new_string('woocommerce'),
				])))
			}
		}
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('woocommerce_maxmind_geolocation_database_download'), rt.call_function('__', [
			rt.new_string('Failed to download the MaxMind database.'),
			rt.new_string('woocommerce'),
		])))
	}
	mut var_file := create_phardata(var_tmp_archive_path.clone())
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	mut var_tmp_database_path := rt.new_string(
		(rt.call_function('trailingslashit', [rt.call_function('dirname', [var_tmp_archive_path.clone()])])).str() +
		(rt.call_function('trailingslashit', [rt.call_method(var_file.current(), 'getFilename', []rt.PhpVal{})])).str() +
		Class_WC_Integration_MaxMind_Database_Service.database() +
		Class_WC_Integration_MaxMind_Database_Service.database_extension())
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	var_file.extractto(rt.call_function('dirname', [var_tmp_archive_path.clone()]), rt.new_string(
		(rt.call_function('trailingslashit', [rt.call_method(var_file.current(), 'getFilename', []rt.PhpVal{})])).str() +
		Class_WC_Integration_MaxMind_Database_Service.database() +
		Class_WC_Integration_MaxMind_Database_Service.database_extension()), rt.new_bool(true))
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	unsafe {
		goto finally_label_1
	}
	catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'Exception') {
		mut var_exception := var_e_1.clone()
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('woocommerce_maxmind_geolocation_database_archive'), rt.call_method(var_exception,
			'getMessage', []rt.PhpVal{})))
		unsafe {
			goto finally_label_1
		}
	} else {
		rt.throw_exception(var_e_1)
		unsafe {
			goto finally_label_1
		}
	}

	finally_label_1:
	rt.call_function('unlink', [var_tmp_archive_path.clone()])
	if rt.has_exception() { return rt.new_null() }

	end_label_1:
	return var_tmp_database_path.clone()
}

fn (mut this Class_WC_Integration_MaxMind_Database_Service) get_iso_country_code_for_ip(var_ip_address rt.PhpVal) rt.PhpVal {
	mut var_country_code := rt.new_string('')
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [
		rt.new_string('MaxMind\\Db\\Reader'),
	])))))
	{
		rt.call_method(rt.call_function('wc_get_logger', []rt.PhpVal{}), 'notice', [
			rt.call_function('__', [rt.new_string('Missing MaxMind Reader library!'),
				rt.new_string('woocommerce')]),
			rt.create_array([rt.ArrayItem{ key: 'source', val: 'maxmind-geolocation' }]),
		])
		return var_country_code.clone()
	}
	mut var_database_path := this.get_database_path()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('file_exists', [
		var_database_path.clone()])))))
	{
		return var_country_code.clone()
	}
	mut var_reader := create_maxmind_db_reader(var_database_path.clone())
	if rt.has_exception() {
		unsafe {
			goto catch_label_2
		}
	}
	mut var_data := var_reader.get(var_ip_address.clone())
	if rt.has_exception() {
		unsafe {
			goto catch_label_2
		}
	}
	if var_data.array_get(rt.new_string('country')).array_isset(rt.new_string('iso_code')) {
		var_country_code =
			var_data.array_get(rt.new_string('country')).array_get(rt.new_string('iso_code'))
		if rt.has_exception() {
			unsafe {
				goto catch_label_2
			}
		}
	}
	if rt.has_exception() {
		unsafe {
			goto catch_label_2
		}
	}
	var_reader.close()
	if rt.has_exception() {
		unsafe {
			goto catch_label_2
		}
	}
	unsafe {
		goto end_label_2
	}
	catch_label_2:
	mut var_e_2 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_2, 'Exception') {
		mut var_e := var_e_2.clone()
		rt.call_method(rt.call_function('wc_get_logger', []rt.PhpVal{}), 'notice', [
			rt.call_method(var_e, 'getMessage', []rt.PhpVal{}),
			rt.create_array([rt.ArrayItem{ key: 'source', val: 'maxmind-geolocation' }]),
		])
		unsafe {
			goto end_label_2
		}
	} else {
		rt.throw_exception(var_e_2)
		unsafe {
			goto end_label_2
		}
	}

	end_label_2:
	return var_country_code.clone()
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

struct Class_PharData {
	rt.PhpObjectBase
}

struct Class_MaxMind_Db_Reader {
	rt.PhpObjectBase
}

fn create_wc_integration_maxmind_database_service(arg_0 rt.PhpVal) &Class_WC_Integration_MaxMind_Database_Service {
	mut obj := &Class_WC_Integration_MaxMind_Database_Service{
		PhpObjectBase:   rt.PhpObjectBase{}
		database_prefix: rt.new_null()
	}
	obj.construct(arg_0)
	return obj
}

fn create_wp_error(_args ...rt.PhpVal) &Class_WP_Error {
	mut obj := &Class_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_phardata(_args ...rt.PhpVal) &Class_PharData {
	mut obj := &Class_PharData{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_maxmind_db_reader(_args ...rt.PhpVal) &Class_MaxMind_Db_Reader {
	mut obj := &Class_MaxMind_Db_Reader{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Integration_MaxMind_Database_Service) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'get_database_path' {
			return this.get_database_path()
		}
		'download_database' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.download_database(dispatch_arg_0)
		}
		'get_iso_country_code_for_ip' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_iso_country_code_for_ip(dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_Integration_MaxMind_Database_Service) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'database_prefix' { return this.database_prefix }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_Integration_MaxMind_Database_Service) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'database_prefix' {
			this.database_prefix = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
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

fn (mut this Class_PharData) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_PharData) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_PharData) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_MaxMind_Db_Reader) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_MaxMind_Db_Reader) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_MaxMind_Db_Reader) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}
