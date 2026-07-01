import rt
import crypto.md5

fn get_importers() rt.PhpVal {
	mut var_wp_importers := rt.new_null()
	// unsupported statement: Stmt_Global
	if rt.is_true(rt.new_bool(var_wp_importers.dup().is_array())) {
		rt.call_function('uasort', [var_wp_importers.dup(), rt.new_string('_usort_by_first_member')])
	}
	return var_wp_importers.dup()
}

fn _usort_by_first_member(var_a rt.PhpVal, var_b rt.PhpVal) rt.PhpVal {
	return rt.call_function('strnatcasecmp', [var_a.array_get(0), var_b.array_get(0)])
}

fn register_importer(var_id rt.PhpVal, var_name rt.PhpVal, var_description rt.PhpVal, var_callback rt.PhpVal) rt.PhpVal {
	mut var_wp_importers := rt.new_null()
	// unsupported statement: Stmt_Global
	if rt.is_true(rt.call_function('is_wp_error', [var_callback.dup()])) {
		return var_callback.dup()
	}
	var_wp_importers.array_set(var_id, rt.create_array([rt.ArrayItem{ key: none, val: var_name }, rt.ArrayItem{ key: none, val: var_description }, rt.ArrayItem{ key: none, val: var_callback }]))
	return rt.new_null()
}

fn wp_import_cleanup(var_id rt.PhpVal) {
	rt.call_function('wp_delete_attachment', [var_id.dup()])
}

fn wp_import_handle_upload() rt.PhpVal {
	mut var__FILES := rt.new_null()
	if !(var__FILES.array_isset(rt.new_string('import'))) {
		return rt.create_array([rt.ArrayItem{ key: 'error', val: rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('File is empty. Please upload something more substantial. This error could also be caused by uploads being disabled in your %1$s file or by %2$s being defined as smaller than %3$s in %1$s.')]), rt.new_string('php.ini'), rt.new_string('post_max_size'), rt.new_string('upload_max_filesize')]) }])
	}
	mut var_overrides := { 'test_form': false, 'test_type': false }
	// unsupported expression: Expr_AssignOp_Concat
	mut var_upload := rt.call_function('wp_handle_upload', [var__FILES.array_get('import'), var_overrides.dup()])
	if var_upload.array_isset(rt.new_string('error')) {
		return var_upload.dup()
	}
	mut var_attachment := { 'post_title': rt.call_function('wp_basename', [var_upload.array_get('file')]), 'post_content': var_upload.array_get('url'), 'post_mime_type': var_upload.array_get('type'), 'guid': var_upload.array_get('url'), 'context': rt.new_string('import'), 'post_status': rt.new_string('private') }
	mut var_id := rt.call_function('wp_insert_attachment', [var_attachment.dup(), var_upload.array_get('file')])
	rt.call_function('wp_schedule_single_event', [rt.add(rt.call_function('time', []rt.PhpVal{}), rt.get_constant('DAY_IN_SECONDS')), rt.new_string('importer_scheduled_cleanup'), rt.create_array([rt.ArrayItem{ key: none, val: var_id }])])
	return rt.create_array([rt.ArrayItem{ key: 'file', val: var_upload.array_get('file') }, rt.ArrayItem{ key: 'id', val: var_id }])
}

fn wp_get_popular_importers() rt.PhpVal {
	mut var_locale := rt.call_function('get_user_locale', []rt.PhpVal{})
	mut var_cache_key := rt.new_string('popular_importers_' + md5.hexhash((var_locale).str() + (rt.call_function('wp_get_wp_version', []rt.PhpVal{})).str()))
	mut var_popular_importers := rt.call_function('get_site_transient', [var_cache_key.dup()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_popular_importers)))) {
		mut var_url := rt.call_function('add_query_arg', [rt.create_array([rt.ArrayItem{ key: 'locale', val: var_locale }, rt.ArrayItem{ key: 'version', val: rt.call_function('wp_get_wp_version', []rt.PhpVal{}) }]), rt.new_string('http://api.wordpress.org/core/importers/1.1/')])
		mut var_options := { 'user-agent': 'WordPress/' + (rt.call_function('wp_get_wp_version', []rt.PhpVal{})).str() + '; ' + (rt.call_function('home_url', [rt.new_string('/')])).str() }
		if rt.is_true(rt.call_function('wp_http_supports', [rt.create_array([rt.ArrayItem{ key: none, val: 'ssl' }])])) {
			var_url = rt.call_function('set_url_scheme', [var_url.dup(), rt.new_string('https')])
		}
		mut var_response := rt.call_function('wp_remote_get', [var_url.dup(), var_options.dup()])
		var_popular_importers = rt.call_function('json_decode', [rt.call_function('wp_remote_retrieve_body', [var_response.dup()]), rt.new_bool(true)])
		if rt.is_true(rt.new_bool(var_popular_importers.dup().is_array())) {
			rt.call_function('set_site_transient', [var_cache_key.dup(), var_popular_importers.dup(), rt.mul(rt.new_int(2), rt.get_constant('DAY_IN_SECONDS'))])
		} else {
			var_popular_importers = rt.new_bool(rt.new_bool(false))
		}
	}
	if rt.is_true(rt.new_bool(var_popular_importers.dup().is_array())) {
		if rt.is_true(var_popular_importers.array_get('translated')) {
			return var_popular_importers.array_get('importers')
		}
		{
			mut iter_1 := var_popular_importers.array_get('importers').iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_importer := item_1.val
				var_importer.array_set('description', rt.call_function('translate', [var_importer.array_get('description')]))
				if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
					var_importer.array_set('name', rt.call_function('translate', [var_importer.array_get('name')]))
				}
			}
		}
		return var_popular_importers.array_get('importers')
	}
	return rt.create_array([rt.ArrayItem{ key: 'blogger', val: rt.create_array([rt.ArrayItem{ key: 'name', val: rt.call_function('__', [rt.new_string('Blogger')]) }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Import posts, comments, and users from a Blogger blog.')]) }, rt.ArrayItem{ key: 'plugin-slug', val: 'blogger-importer' }, rt.ArrayItem{ key: 'importer-id', val: 'blogger' }]) }, rt.ArrayItem{ key: 'wpcat2tag', val: rt.create_array([rt.ArrayItem{ key: 'name', val: rt.call_function('__', [rt.new_string('Categories and Tags Converter')]) }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Convert existing categories to tags or tags to categories, selectively.')]) }, rt.ArrayItem{ key: 'plugin-slug', val: 'wpcat2tag-importer' }, rt.ArrayItem{ key: 'importer-id', val: 'wp-cat2tag' }]) }, rt.ArrayItem{ key: 'livejournal', val: rt.create_array([rt.ArrayItem{ key: 'name', val: rt.call_function('__', [rt.new_string('LiveJournal')]) }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Import posts from LiveJournal using their API.')]) }, rt.ArrayItem{ key: 'plugin-slug', val: 'livejournal-importer' }, rt.ArrayItem{ key: 'importer-id', val: 'livejournal' }]) }, rt.ArrayItem{ key: 'movabletype', val: rt.create_array([rt.ArrayItem{ key: 'name', val: rt.call_function('__', [rt.new_string('Movable Type and TypePad')]) }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Import posts and comments from a Movable Type or TypePad blog.')]) }, rt.ArrayItem{ key: 'plugin-slug', val: 'movabletype-importer' }, rt.ArrayItem{ key: 'importer-id', val: 'mt' }]) }, rt.ArrayItem{ key: 'rss', val: rt.create_array([rt.ArrayItem{ key: 'name', val: rt.call_function('__', [rt.new_string('RSS')]) }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Import posts from an RSS feed.')]) }, rt.ArrayItem{ key: 'plugin-slug', val: 'rss-importer' }, rt.ArrayItem{ key: 'importer-id', val: 'rss' }]) }, rt.ArrayItem{ key: 'tumblr', val: rt.create_array([rt.ArrayItem{ key: 'name', val: rt.call_function('__', [rt.new_string('Tumblr')]) }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Import posts &amp; media from Tumblr using their API.')]) }, rt.ArrayItem{ key: 'plugin-slug', val: 'tumblr-importer' }, rt.ArrayItem{ key: 'importer-id', val: 'tumblr' }]) }, rt.ArrayItem{ key: 'wordpress', val: rt.create_array([rt.ArrayItem{ key: 'name', val: 'WordPress' }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Import posts, pages, comments, custom fields, categories, and tags from a WordPress export file.')]) }, rt.ArrayItem{ key: 'plugin-slug', val: 'wordpress-importer' }, rt.ArrayItem{ key: 'importer-id', val: 'wordpress' }]) }])
}



pub fn init_wp_admin_includes_import_php() {
}
