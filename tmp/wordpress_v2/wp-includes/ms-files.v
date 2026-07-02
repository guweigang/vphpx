import rt
import crypto.md5

const global_const_ms_files_request = true
const global_const_shortinit = true

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_current_blog := rt.new_null()
	rt.include_file((rt.call_function('dirname', [rt.new_string(@DIR)])).str() + '/wp-load.php',
		'4')
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{}))))) {
		fn () {
			print((rt.new_string('Multisite support not enabled')).str())
			exit(0)
		}()
	}
	rt.call_function('ms_file_constants', []rt.PhpVal{})
	if rt.is_true(rt.identical(rt.new_string('1'), rt.get_property(var_current_blog, 'archived')))
		|| rt.is_true(rt.identical(rt.new_string('1'), rt.get_property(var_current_blog, 'spam')))
		|| rt.is_true(rt.identical(rt.new_string('1'), rt.get_property(var_current_blog, 'deleted'))) {
		rt.call_function('status_header', [rt.new_int(404)])
		fn () {
			print((rt.new_string('404 &#8212; File not found.')).str())
			exit(0)
		}()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('BLOGUPLOADDIR'),
	])))))
	{
		rt.call_function('status_header', [rt.new_int(500)])
		fn () {
			print((rt.new_string('500 &#8212; Directory not configured.')).str())
			exit(0)
		}()
	}
	mut var_file := rt.new_string((
		rt.get_constant('BLOGUPLOADDIR').to_string().trim_right(' \t\n\r') + '/' +(rt.call_function('str_replace', [rt.new_string('..'), rt.new_string(''), rt.get_superglobal('_GET').array_get(rt.new_string('file'))])).str()).str())
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_file', [
		var_file.clone()])))))
	{
		rt.call_function('status_header', [rt.new_int(404)])
		fn () {
			print((rt.new_string('404 &#8212; File not found.')).str())
			exit(0)
		}()
	}
	mut var_mime := rt.call_function('wp_check_filetype', [var_file.clone()])
	if rt.is_true(rt.identical(rt.new_bool(false), var_mime.array_get(rt.new_string('type'))))
		&& rt.is_true(rt.call_function('function_exists', [rt.new_string('mime_content_type')])) {
		var_mime.array_set('type', rt.call_function('mime_content_type', [
			var_file.clone()]))
	}
	if rt.is_true(var_mime.array_get(rt.new_string('type'))) {
		mut var_mimetype := var_mime.array_get(rt.new_string('type'))
	} else {
		var_mimetype =
			rt.new_string('image/' +(rt.call_function('substr', [var_file.clone(), rt.add(rt.call_function('strrpos', [var_file.clone(), rt.new_string('.')]), rt.new_int(1))])).str())
	}
	rt.call_function('header', [rt.new_string('Content-Type: ' + var_mimetype.str())])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('str_contains', [
		rt.get_superglobal('_SERVER').array_get(rt.new_string('SERVER_SOFTWARE')),
		rt.new_string('Microsoft-IIS'),
	])))))
	{
		rt.call_function('header', [
			rt.new_string('Content-Length: ' +
				(rt.call_function('filesize', [var_file.clone()])).str()),
		])
	}
	if rt.is_true(rt.get_constant('WPMU_ACCEL_REDIRECT')) {
		rt.call_function('header', [
			rt.new_string('X-Accel-Redirect: ' +(rt.call_function('str_replace', [rt.get_constant('WP_CONTENT_DIR'), rt.new_string(''), var_file.clone()])).str()),
		])
		exit(0)
	} else if rt.is_true(rt.get_constant('WPMU_SENDFILE')) {
		rt.call_function('header', [rt.new_string('X-Sendfile: ' + var_file.str())])
		exit(0)
	}
	mut var_wp_last_modified := rt.call_function('gmdate', [
		rt.new_string('D, d M Y H:i:s'),
		rt.call_function('filemtime', [var_file.clone()]),
	])
	mut var_wp_etag := rt.new_string('"' + md5.hexhash(var_wp_last_modified.clone().to_string()) +
		'"')
	rt.call_function('header', [
		rt.new_string('Last-Modified: ${var_wp_last_modified.to_string()} GMT'),
	])
	rt.call_function('header', [rt.new_string('ETag: ' + var_wp_etag.str())])
	rt.call_function('header', [
		rt.new_string('Expires: ' +
			(rt.call_function('gmdate', [rt.new_string('D, d M Y H:i:s'), rt.add(rt.call_function('time', []rt.PhpVal{}), rt.new_int(100000000))])).str() +
			' GMT'),
	])
	if rt.get_superglobal('_SERVER').array_isset(rt.new_string('HTTP_IF_NONE_MATCH')) {
		mut var_client_etag := rt.call_function('stripslashes', [
			rt.get_superglobal('_SERVER').array_get(rt.new_string('HTTP_IF_NONE_MATCH')),
		])
	} else {
		var_client_etag = rt.new_string('')
	}
	if rt.get_superglobal('_SERVER').array_isset(rt.new_string('HTTP_IF_MODIFIED_SINCE')) {
		mut var_client_last_modified :=
			rt.get_superglobal('_SERVER').array_get(rt.new_string('HTTP_IF_MODIFIED_SINCE')).to_string().trim_space()
	} else {
		var_client_last_modified = ''
	}
	mut var_client_modified_timestamp := if var_client_last_modified.len > 0 && var_client_last_modified != '0' { rt.call_function('strtotime', [
			rt.new_string(var_client_last_modified.str()).clone(),
		]) } else { rt.new_int(0) }
	mut var_wp_modified_timestamp := rt.call_function('strtotime', [
		var_wp_last_modified.clone()])
	if rt.is_true(if var_client_last_modified.len > 0 && var_client_last_modified != '0'
		&& rt.is_true(var_client_etag) {
		rt.is_true(rt.greater_equal(var_client_modified_timestamp, var_wp_modified_timestamp))
			&& rt.is_true(rt.identical(var_client_etag, var_wp_etag))
	} else {
		rt.is_true(rt.greater_equal(var_client_modified_timestamp, var_wp_modified_timestamp))
			|| rt.is_true(rt.identical(var_client_etag, var_wp_etag))
	})
	{
		rt.call_function('status_header', [rt.new_int(304)])
		exit(0)
	}
	rt.call_function('readfile', [var_file.clone()])
	rt.call_function('flush', []rt.PhpVal{})
}
