import rt

struct Class_File_Upload_Upgrader {
	rt.PhpObjectBase
pub mut:
	package  rt.PhpVal = rt.new_null()
	filename rt.PhpVal = rt.new_null()
	id       rt.PhpVal = rt.new_int(0)
}

fn (mut this Class_File_Upload_Upgrader) construct(var_form rt.PhpVal, var_urlholder rt.PhpVal) {
	mut var__FILES := rt.new_null()
	if !rt.is_true(var__FILES.array_get(var_form).array_get(rt.new_string('name')))
		&& !rt.is_true(rt.get_superglobal('_GET').array_get(var_urlholder)) {
		rt.call_function('wp_die', [
			rt.call_function('__', [rt.new_string('Please select a file')]),
		])
	}
	if !(!rt.is_true(var__FILES)) {
		mut var_overrides := {
			'test_form': false
			'test_type': false
		}
		mut var_file := rt.call_function('wp_handle_upload', [
			var__FILES.array_get(var_form), rt.create_array_from_native_map(var_overrides)])
		if var_file.array_isset(rt.new_string('error')) {
			rt.call_function('wp_die', [var_file.array_get(rt.new_string('error'))])
		}
		if rt.is_true(rt.identical(rt.new_string('pluginzip'), var_form))
			|| rt.is_true(rt.identical(rt.new_string('themezip'), var_form)) {
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_zip_file_is_valid', [
				var_file.array_get(rt.new_string('file')),
			])))))
			{
				rt.call_function('wp_delete_file', [var_file.array_get(rt.new_string('file'))])
				if rt.is_true(rt.identical(rt.new_string('pluginzip'), var_form)) {
					mut var_plugins_page := rt.call_function('sprintf', [
						rt.new_string('<a href="%s">%s</a>'),
						rt.call_function('self_admin_url', [
							rt.new_string('plugin-install.php'),
						]),
						rt.call_function('__', [
							rt.new_string('Return to the Plugin Installer'),
						]),
					])
					rt.call_function('wp_die', [
						rt.new_string(
							(rt.call_function('__', [rt.new_string('Incompatible Archive.')])).str() +
							'<br />' + var_plugins_page.str()),
					])
				}
				if rt.is_true(rt.identical(rt.new_string('themezip'), var_form)) {
					mut var_themes_page := rt.call_function('sprintf', [
						rt.new_string('<a href="%s" target="_parent">%s</a>'),
						rt.call_function('self_admin_url', [
							rt.new_string('theme-install.php'),
						]),
						rt.call_function('__', [
							rt.new_string('Return to the Theme Installer'),
						]),
					])
					rt.call_function('wp_die', [
						rt.new_string(
							(rt.call_function('__', [rt.new_string('Incompatible Archive.')])).str() +
							'<br />' + var_themes_page.str()),
					])
				}
			}
		}
		this.filename = var__FILES.array_get(var_form).array_get(rt.new_string('name'))
		this.package = var_file.array_get(rt.new_string('file'))
		mut var_attachment := rt.create_array([
			rt.ArrayItem{ key: 'post_title', val: this.filename },
			rt.ArrayItem{ key: 'post_content', val: var_file.array_get(rt.new_string('url')) },
			rt.ArrayItem{ key: 'post_mime_type', val: var_file.array_get(rt.new_string('type')) },
			rt.ArrayItem{ key: 'guid', val: var_file.array_get(rt.new_string('url')) },
			rt.ArrayItem{ key: 'context', val: 'upgrader' },
			rt.ArrayItem{ key: 'post_status', val: 'private' },
		])
		this.id = rt.call_function('wp_insert_attachment', [var_attachment.clone(),
			var_file.array_get(rt.new_string('file'))])
		rt.call_function('wp_schedule_single_event', [
			rt.add(rt.call_function('time', []rt.PhpVal{}), rt.mul(rt.new_int(2),
				rt.get_constant('HOUR_IN_SECONDS'))),
			rt.new_string('upgrader_scheduled_cleanup'),
			rt.create_array([rt.ArrayItem{ key: none, val: this.id }]),
		])
	} else if rt.is_true(rt.new_bool(rt.get_superglobal('_GET').array_get(var_urlholder).is_long()
		|| rt.get_superglobal('_GET').array_get(var_urlholder).is_double()))
	{
		this.id = rt.new_int((rt.get_superglobal('_GET').array_get(var_urlholder)).to_i64())
		var_attachment = rt.call_function('get_post', [this.id])
		if !rt.is_true(var_attachment) {
			rt.call_function('wp_die', [
				rt.call_function('__', [rt.new_string('Please select a file')]),
			])
		}
		this.filename = rt.get_property(var_attachment, 'post_title')
		this.package = rt.call_function('get_attached_file', [
			rt.get_property(var_attachment, 'ID'),
		])
	} else {
		mut var_uploads := rt.call_function('wp_upload_dir', []rt.PhpVal{})
		if !(rt.is_true(var_uploads)
			&& rt.is_true(rt.identical(rt.new_bool(false), var_uploads.array_get(rt.new_string('error'))))) {
			rt.call_function('wp_die', [var_uploads.array_get(rt.new_string('error'))])
		}
		this.filename = rt.call_function('sanitize_file_name', [
			rt.get_superglobal('_GET').array_get(var_urlholder),
		])
		this.package =
			(var_uploads.array_get(rt.new_string('basedir'))).str() + '/' + (this.filename).str()
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('str_starts_with', [
			rt.call_function('realpath', [this.package]),
			rt.call_function('realpath', [var_uploads.array_get(rt.new_string('basedir'))]),
		])))))
		{
			rt.call_function('wp_die', [
				rt.call_function('__', [rt.new_string('Please select a file')]),
			])
		}
	}
}

fn (mut this Class_File_Upload_Upgrader) cleanup() bool {
	if rt.is_true(this.id) {
		rt.call_function('wp_delete_attachment', [this.id])
	} else if rt.is_true(rt.call_function('file_exists', [this.package])) {
		return (rt.call_function('unlink', [this.package])).to_bool()
	}
	return true
}

fn create_file_upload_upgrader(arg_0 rt.PhpVal, arg_1 rt.PhpVal) &Class_File_Upload_Upgrader {
	mut obj := &Class_File_Upload_Upgrader{
		PhpObjectBase: rt.PhpObjectBase{}
		package:       rt.new_null()
		filename:      rt.new_null()
		id:            rt.new_int(0)
	}
	obj.construct(arg_0, arg_1)
	return obj
}

fn (mut this Class_File_Upload_Upgrader) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.construct(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'cleanup' {
			return rt.new_bool(this.cleanup())
		}
		else {
			return none
		}
	}
}

fn (this &Class_File_Upload_Upgrader) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'package' { return this.package }
		'filename' { return this.filename }
		'id' { return this.id }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_File_Upload_Upgrader) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'package' {
			this.package = val
			return true
		}
		'filename' {
			this.filename = val
			return true
		}
		'id' {
			this.id = val
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
