import rt

struct Class_wp_xmlrpc_server {
	rt.PhpObjectBase
pub mut:
	methods      rt.PhpVal = rt.new_null()
	blog_options rt.PhpVal = rt.new_null()
	error        rt.PhpVal = rt.new_null()
	auth_failed  bool
	is_enabled   rt.PhpVal = rt.new_null()
}

fn (mut this Class_wp_xmlrpc_server) construct() {
	this.methods = rt.create_array([
		rt.ArrayItem{ key: 'wp.getUsersBlogs', val: 'this:wp_getUsersBlogs' },
		rt.ArrayItem{ key: 'wp.newPost', val: 'this:wp_newPost' },
		rt.ArrayItem{ key: 'wp.editPost', val: 'this:wp_editPost' },
		rt.ArrayItem{ key: 'wp.deletePost', val: 'this:wp_deletePost' },
		rt.ArrayItem{ key: 'wp.getPost', val: 'this:wp_getPost' },
		rt.ArrayItem{ key: 'wp.getPosts', val: 'this:wp_getPosts' },
		rt.ArrayItem{ key: 'wp.newTerm', val: 'this:wp_newTerm' },
		rt.ArrayItem{ key: 'wp.editTerm', val: 'this:wp_editTerm' },
		rt.ArrayItem{ key: 'wp.deleteTerm', val: 'this:wp_deleteTerm' },
		rt.ArrayItem{ key: 'wp.getTerm', val: 'this:wp_getTerm' },
		rt.ArrayItem{ key: 'wp.getTerms', val: 'this:wp_getTerms' },
		rt.ArrayItem{ key: 'wp.getTaxonomy', val: 'this:wp_getTaxonomy' },
		rt.ArrayItem{ key: 'wp.getTaxonomies', val: 'this:wp_getTaxonomies' },
		rt.ArrayItem{ key: 'wp.getUser', val: 'this:wp_getUser' },
		rt.ArrayItem{ key: 'wp.getUsers', val: 'this:wp_getUsers' },
		rt.ArrayItem{ key: 'wp.getProfile', val: 'this:wp_getProfile' },
		rt.ArrayItem{ key: 'wp.editProfile', val: 'this:wp_editProfile' },
		rt.ArrayItem{ key: 'wp.getPage', val: 'this:wp_getPage' },
		rt.ArrayItem{ key: 'wp.getPages', val: 'this:wp_getPages' },
		rt.ArrayItem{ key: 'wp.newPage', val: 'this:wp_newPage' },
		rt.ArrayItem{ key: 'wp.deletePage', val: 'this:wp_deletePage' },
		rt.ArrayItem{ key: 'wp.editPage', val: 'this:wp_editPage' },
		rt.ArrayItem{ key: 'wp.getPageList', val: 'this:wp_getPageList' },
		rt.ArrayItem{ key: 'wp.getAuthors', val: 'this:wp_getAuthors' },
		rt.ArrayItem{ key: 'wp.getCategories', val: 'this:mw_getCategories' },
		rt.ArrayItem{ key: 'wp.getTags', val: 'this:wp_getTags' },
		rt.ArrayItem{ key: 'wp.newCategory', val: 'this:wp_newCategory' },
		rt.ArrayItem{ key: 'wp.deleteCategory', val: 'this:wp_deleteCategory' },
		rt.ArrayItem{ key: 'wp.suggestCategories', val: 'this:wp_suggestCategories' },
		rt.ArrayItem{ key: 'wp.uploadFile', val: 'this:mw_newMediaObject' },
		rt.ArrayItem{ key: 'wp.deleteFile', val: 'this:wp_deletePost' },
		rt.ArrayItem{ key: 'wp.getCommentCount', val: 'this:wp_getCommentCount' },
		rt.ArrayItem{ key: 'wp.getPostStatusList', val: 'this:wp_getPostStatusList' },
		rt.ArrayItem{ key: 'wp.getPageStatusList', val: 'this:wp_getPageStatusList' },
		rt.ArrayItem{ key: 'wp.getPageTemplates', val: 'this:wp_getPageTemplates' },
		rt.ArrayItem{ key: 'wp.getOptions', val: 'this:wp_getOptions' },
		rt.ArrayItem{ key: 'wp.setOptions', val: 'this:wp_setOptions' },
		rt.ArrayItem{ key: 'wp.getComment', val: 'this:wp_getComment' },
		rt.ArrayItem{ key: 'wp.getComments', val: 'this:wp_getComments' },
		rt.ArrayItem{ key: 'wp.deleteComment', val: 'this:wp_deleteComment' },
		rt.ArrayItem{ key: 'wp.editComment', val: 'this:wp_editComment' },
		rt.ArrayItem{ key: 'wp.newComment', val: 'this:wp_newComment' },
		rt.ArrayItem{ key: 'wp.getCommentStatusList', val: 'this:wp_getCommentStatusList' },
		rt.ArrayItem{ key: 'wp.getMediaItem', val: 'this:wp_getMediaItem' },
		rt.ArrayItem{ key: 'wp.getMediaLibrary', val: 'this:wp_getMediaLibrary' },
		rt.ArrayItem{ key: 'wp.getPostFormats', val: 'this:wp_getPostFormats' },
		rt.ArrayItem{ key: 'wp.getPostType', val: 'this:wp_getPostType' },
		rt.ArrayItem{ key: 'wp.getPostTypes', val: 'this:wp_getPostTypes' },
		rt.ArrayItem{ key: 'wp.getRevisions', val: 'this:wp_getRevisions' },
		rt.ArrayItem{ key: 'wp.restoreRevision', val: 'this:wp_restoreRevision' },
		rt.ArrayItem{ key: 'blogger.getUsersBlogs', val: 'this:blogger_getUsersBlogs' },
		rt.ArrayItem{ key: 'blogger.getUserInfo', val: 'this:blogger_getUserInfo' },
		rt.ArrayItem{ key: 'blogger.getPost', val: 'this:blogger_getPost' },
		rt.ArrayItem{ key: 'blogger.getRecentPosts', val: 'this:blogger_getRecentPosts' },
		rt.ArrayItem{ key: 'blogger.newPost', val: 'this:blogger_newPost' },
		rt.ArrayItem{ key: 'blogger.editPost', val: 'this:blogger_editPost' },
		rt.ArrayItem{ key: 'blogger.deletePost', val: 'this:blogger_deletePost' },
		rt.ArrayItem{ key: 'metaWeblog.newPost', val: 'this:mw_newPost' },
		rt.ArrayItem{ key: 'metaWeblog.editPost', val: 'this:mw_editPost' },
		rt.ArrayItem{ key: 'metaWeblog.getPost', val: 'this:mw_getPost' },
		rt.ArrayItem{ key: 'metaWeblog.getRecentPosts', val: 'this:mw_getRecentPosts' },
		rt.ArrayItem{ key: 'metaWeblog.getCategories', val: 'this:mw_getCategories' },
		rt.ArrayItem{ key: 'metaWeblog.newMediaObject', val: 'this:mw_newMediaObject' },
		rt.ArrayItem{ key: 'metaWeblog.deletePost', val: 'this:blogger_deletePost' },
		rt.ArrayItem{ key: 'metaWeblog.getUsersBlogs', val: 'this:blogger_getUsersBlogs' },
		rt.ArrayItem{ key: 'mt.getCategoryList', val: 'this:mt_getCategoryList' },
		rt.ArrayItem{ key: 'mt.getRecentPostTitles', val: 'this:mt_getRecentPostTitles' },
		rt.ArrayItem{ key: 'mt.getPostCategories', val: 'this:mt_getPostCategories' },
		rt.ArrayItem{ key: 'mt.setPostCategories', val: 'this:mt_setPostCategories' },
		rt.ArrayItem{ key: 'mt.supportedMethods', val: 'this:mt_supportedMethods' },
		rt.ArrayItem{ key: 'mt.supportedTextFilters', val: 'this:mt_supportedTextFilters' },
		rt.ArrayItem{ key: 'mt.getTrackbackPings', val: 'this:mt_getTrackbackPings' },
		rt.ArrayItem{ key: 'mt.publishPost', val: 'this:mt_publishPost' },
		rt.ArrayItem{ key: 'pingback.ping', val: 'this:pingback_ping' },
		rt.ArrayItem{
			key: 'pingback.extensions.getPingbacks'
			val: 'this:pingback_extensions_getPingbacks'
		},
		rt.ArrayItem{ key: 'demo.sayHello', val: 'this:sayHello' },
		rt.ArrayItem{ key: 'demo.addTwoNumbers', val: 'this:addTwoNumbers' },
	])
	this.initialise_blog_option_info()
	this.methods = rt.call_function('apply_filters', [rt.new_string('xmlrpc_methods'),
		this.methods])
	this.set_is_enabled()
}

fn (mut this Class_wp_xmlrpc_server) set_is_enabled() {
	mut var_is_enabled := rt.call_function('apply_filters', [
		rt.new_string('pre_option_enable_xmlrpc'),
		rt.new_bool(false),
	])
	if rt.is_true(rt.identical(rt.new_bool(false), var_is_enabled)) {
		var_is_enabled = rt.call_function('apply_filters', [
			rt.new_string('option_enable_xmlrpc'),
			rt.new_bool(true),
		])
	}
	this.is_enabled = rt.call_function('apply_filters', [rt.new_string('xmlrpc_enabled'),
		var_is_enabled.clone()])
}

fn (mut this Class_wp_xmlrpc_server) magic_call(var_name rt.PhpVal, var_arguments rt.PhpVal) bool {
	mut var_name_mutated := var_name
	if rt.is_true(rt.identical(rt.new_string('_multisite_getUsersBlogs'), var_name_mutated)) {
		return (this._multisite_getusersblogs(var_arguments.clone())).to_bool()
	}
	return false
}

fn (mut this Class_wp_xmlrpc_server) serve_request() {
	this.ixr_server(this.methods)
}

fn (mut this Class_wp_xmlrpc_server) sayhello() string {
	return 'Hello!'
}

fn (mut this Class_wp_xmlrpc_server) addtwonumbers(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
	if !(var_args_mutated.clone().is_array())
		|| rt.is_true(rt.new_bool(var_args_mutated.clone().array_count() != 2))
		|| !(var_args_mutated.array_get(rt.new_int(0)).is_long())
		|| !(var_args_mutated.array_get(rt.new_int(1)).is_long()) {
		this.error = create_ixr_error(rt.new_int(400), rt.call_function('__', [
			rt.new_string('Invalid arguments passed to this XML-RPC method. Requires two integers.'),
		]))
		return this.error
	}
	mut var_number1 := var_args_mutated.array_get(rt.new_int(0))
	mut var_number2 := var_args_mutated.array_get(rt.new_int(1))
	return rt.add(var_number1, var_number2)
}

fn (mut this Class_wp_xmlrpc_server) login(var_username rt.PhpVal, var_password rt.PhpVal) bool {
	mut var_username_mutated := var_username
	mut var_password_mutated := var_password
	if rt.is_true(rt.new_bool(!(rt.is_true(this.is_enabled)))) {
		this.error = create_ixr_error(rt.new_int(405), rt.call_function('sprintf', [
			rt.call_function('__', [
				rt.new_string('XML-RPC services are disabled on this site.'),
			]),
		]))
		return false
	}
	if this.auth_failed {
		mut var_user := create_wp_error(rt.new_string('login_prevented'))
	} else {
		var_user = rt.call_function('wp_authenticate', [var_username_mutated.clone(),
			var_password_mutated.clone()])
	}
	if rt.is_true(rt.call_function('is_wp_error', [var_user.clone()])) {
		this.error = create_ixr_error(rt.new_int(403), rt.call_function('__', [
			rt.new_string('Incorrect username or password.'),
		]))
		this.auth_failed = true
		this.error = rt.call_function('apply_filters', [
			rt.new_string('xmlrpc_login_error'),
			this.error,
			var_user.clone(),
		])
		return false
	}
	rt.call_function('wp_set_current_user', [rt.get_property(var_user, 'ID')])
	return var_user.to_bool()
}

fn (mut this Class_wp_xmlrpc_server) login_pass_ok(var_username rt.PhpVal, var_password rt.PhpVal) bool {
	mut var_username_mutated := var_username
	mut var_password_mutated := var_password
	return this.login(var_username_mutated.clone(), var_password_mutated.clone())
}

fn (mut this Class_wp_xmlrpc_server) escape(var_data rt.PhpVal) rt.PhpVal {
	mut var_data_mutated := var_data
	if !(var_data_mutated.clone().is_array()) {
		return rt.call_function('wp_slash', [var_data_mutated.clone()])
	}
	mut iter_1 := var_data_mutated.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_v := item_1.val
		if rt.is_true(rt.new_bool(var_v.clone().is_array())) {
			this.escape(var_v.clone())
		} else if !(var_v.clone().is_object()) {
			var_v = rt.call_function('wp_slash', [var_v.clone()])
		}
	}
	return rt.new_null()
}

fn (mut this Class_wp_xmlrpc_server) error(var_error rt.PhpVal, message bool) {
	mut var_error_mutated := var_error
	if var_message && !(var_error_mutated.clone().is_object()) {
		var_error_mutated = create_ixr_error(var_error_mutated.clone(), rt.new_bool(message))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(this.is_enabled)))) {
		rt.call_function('status_header', [rt.get_property(var_error_mutated, 'code')])
	}
	this.output(rt.call_method(var_error_mutated, 'getXml', []rt.PhpVal{}))
}

fn (mut this Class_wp_xmlrpc_server) get_custom_fields(var_post_id rt.PhpVal) rt.PhpVal {
	mut var_post_id_mutated := var_post_id
	var_post_id_mutated = rt.new_int(var_post_id_mutated.to_i64())
	mut var_custom_fields := []rt.PhpVal{}
	mut iter_2 := rt.cast_array(rt.call_function('has_meta', [
		var_post_id_mutated.clone()])).iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_meta := item_2.val
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
			rt.new_string('edit_post_meta'),
			var_post_id_mutated.clone(),
			var_meta.array_get(rt.new_string('meta_key')),
		])))))
		{
			continue
		}
		var_custom_fields << rt.create_array([
			rt.ArrayItem{ key: 'id', val: var_meta.array_get(rt.new_string('meta_id')) },
			rt.ArrayItem{ key: 'key', val: var_meta.array_get(rt.new_string('meta_key')) },
			rt.ArrayItem{ key: 'value', val: var_meta.array_get(rt.new_string('meta_value')) },
		])
	}
	return var_custom_fields.clone()
}

fn (mut this Class_wp_xmlrpc_server) set_custom_fields(var_post_id rt.PhpVal, var_fields rt.PhpVal) {
	mut var_post_id_mutated := var_post_id
	mut var_fields_mutated := var_fields
	var_post_id_mutated = rt.new_int(var_post_id_mutated.to_i64())
	mut iter_3 := rt.cast_array(var_fields_mutated).iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_meta := item_3.val
		if var_meta.array_isset(rt.new_string('id')) {
			var_meta.array_set('id', rt.new_int((var_meta.array_get(rt.new_string('id'))).to_i64()))
			mut var_pmeta := rt.call_function('get_metadata_by_mid', [
				rt.new_string('post'),
				var_meta.array_get(rt.new_string('id')),
			])
			if rt.is_true(rt.new_bool(!(rt.is_true(var_pmeta))))
				|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int((rt.get_property(var_pmeta, 'post_id')).to_i64()), var_post_id_mutated)))) {
				continue
			}
			if var_meta.array_isset(rt.new_string('key')) {
				var_meta.array_set('key', rt.call_function('wp_unslash', [
					var_meta.array_get(rt.new_string('key')),
				]))
				if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_meta.array_get(rt.new_string('key')), rt.get_property(var_pmeta,
					'meta_key')))))
				{
					continue
				}
				var_meta.array_set('value', rt.call_function('wp_unslash', [
					var_meta.array_get(rt.new_string('value')),
				]))
				if rt.is_true(rt.call_function('current_user_can', [
					rt.new_string('edit_post_meta'),
					var_post_id_mutated.clone(),
					var_meta.array_get(rt.new_string('key')),
				]))
				{
					rt.call_function('update_metadata_by_mid', [
						rt.new_string('post'), var_meta.array_get(rt.new_string('id')),
						var_meta.array_get(rt.new_string('value'))])
				}
			} else if rt.is_true(rt.call_function('current_user_can', [
				rt.new_string('delete_post_meta'),
				var_post_id_mutated.clone(),
				rt.get_property(var_pmeta, 'meta_key'),
			]))
			{
				rt.call_function('delete_metadata_by_mid', [rt.new_string('post'),
					var_meta.array_get(rt.new_string('id'))])
			}
		} else if rt.is_true(rt.call_function('current_user_can', [
			rt.new_string('add_post_meta'),
			var_post_id_mutated.clone(),
			rt.call_function('wp_unslash', [var_meta.array_get(rt.new_string('key'))]),
		]))
		{
			rt.call_function('add_post_meta', [var_post_id_mutated.clone(),
				var_meta.array_get(rt.new_string('key')), var_meta.array_get(rt.new_string('value'))])
		}
	}
}

fn (mut this Class_wp_xmlrpc_server) get_term_custom_fields(var_term_id rt.PhpVal) rt.PhpVal {
	mut var_term_id_mutated := var_term_id
	var_term_id_mutated = rt.new_int(var_term_id_mutated.to_i64())
	mut var_custom_fields := []rt.PhpVal{}
	mut iter_4 := rt.cast_array(rt.call_function('has_term_meta', [
		var_term_id_mutated.clone()])).iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_meta := item_4.val
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
			rt.new_string('edit_term_meta'),
			var_term_id_mutated.clone(),
		])))))
		{
			continue
		}
		var_custom_fields << rt.create_array([
			rt.ArrayItem{ key: 'id', val: var_meta.array_get(rt.new_string('meta_id')) },
			rt.ArrayItem{ key: 'key', val: var_meta.array_get(rt.new_string('meta_key')) },
			rt.ArrayItem{ key: 'value', val: var_meta.array_get(rt.new_string('meta_value')) },
		])
	}
	return var_custom_fields.clone()
}

fn (mut this Class_wp_xmlrpc_server) set_term_custom_fields(var_term_id rt.PhpVal, var_fields rt.PhpVal) {
	mut var_term_id_mutated := var_term_id
	mut var_fields_mutated := var_fields
	var_term_id_mutated = rt.new_int(var_term_id_mutated.to_i64())
	mut iter_5 := rt.cast_array(var_fields_mutated).iterator()
	for {
		item_5 := iter_5.next() or { break }
		mut var_meta := item_5.val
		if var_meta.array_isset(rt.new_string('id')) {
			var_meta.array_set('id', rt.new_int((var_meta.array_get(rt.new_string('id'))).to_i64()))
			mut var_pmeta := rt.call_function('get_metadata_by_mid', [
				rt.new_string('term'),
				var_meta.array_get(rt.new_string('id')),
			])
			if var_meta.array_isset(rt.new_string('key')) {
				var_meta.array_set('key', rt.call_function('wp_unslash', [
					var_meta.array_get(rt.new_string('key')),
				]))
				if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_meta.array_get(rt.new_string('key')), rt.get_property(var_pmeta,
					'meta_key')))))
				{
					continue
				}
				var_meta.array_set('value', rt.call_function('wp_unslash', [
					var_meta.array_get(rt.new_string('value')),
				]))
				if rt.is_true(rt.call_function('current_user_can', [
					rt.new_string('edit_term_meta'),
					var_term_id_mutated.clone(),
				]))
				{
					rt.call_function('update_metadata_by_mid', [
						rt.new_string('term'), var_meta.array_get(rt.new_string('id')),
						var_meta.array_get(rt.new_string('value'))])
				}
			} else if rt.is_true(rt.call_function('current_user_can', [
				rt.new_string('delete_term_meta'),
				var_term_id_mutated.clone(),
			]))
			{
				rt.call_function('delete_metadata_by_mid', [rt.new_string('term'),
					var_meta.array_get(rt.new_string('id'))])
			}
		} else if rt.is_true(rt.call_function('current_user_can', [
			rt.new_string('add_term_meta'),
			var_term_id_mutated.clone(),
		]))
		{
			rt.call_function('add_term_meta', [var_term_id_mutated.clone(),
				var_meta.array_get(rt.new_string('key')), var_meta.array_get(rt.new_string('value'))])
		}
	}
}

fn (mut this Class_wp_xmlrpc_server) initialise_blog_option_info() {
	this.blog_options = rt.create_array([
		rt.ArrayItem{ key: 'software_name', val: rt.create_array([
			rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [
				rt.new_string('Software Name'),
			]) },
			rt.ArrayItem{ key: 'readonly', val: true },
			rt.ArrayItem{ key: 'value', val: 'WordPress' },
		]) },
		rt.ArrayItem{ key: 'software_version', val: rt.create_array([
			rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [
				rt.new_string('Software Version'),
			]) },
			rt.ArrayItem{ key: 'readonly', val: true },
			rt.ArrayItem{ key: 'value', val: rt.call_function('get_bloginfo', [
				rt.new_string('version'),
			]) },
		]) },
		rt.ArrayItem{ key: 'blog_url', val: rt.create_array([
			rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [
				rt.new_string('WordPress Address (URL)'),
			]) },
			rt.ArrayItem{ key: 'readonly', val: true },
			rt.ArrayItem{ key: 'option', val: 'siteurl' },
		]) },
		rt.ArrayItem{ key: 'home_url', val: rt.create_array([
			rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [
				rt.new_string('Site Address (URL)'),
			]) },
			rt.ArrayItem{ key: 'readonly', val: true },
			rt.ArrayItem{ key: 'option', val: 'home' },
		]) },
		rt.ArrayItem{ key: 'login_url', val: rt.create_array([
			rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [
				rt.new_string('Login Address (URL)'),
			]) },
			rt.ArrayItem{ key: 'readonly', val: true },
			rt.ArrayItem{ key: 'value', val: rt.call_function('wp_login_url', []rt.PhpVal{}) },
		]) },
		rt.ArrayItem{ key: 'admin_url', val: rt.create_array([
			rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [
				rt.new_string('The URL to the admin area'),
			]) },
			rt.ArrayItem{ key: 'readonly', val: true },
			rt.ArrayItem{ key: 'value', val: rt.call_function('get_admin_url', []rt.PhpVal{}) },
		]) },
		rt.ArrayItem{ key: 'image_default_link_type', val: rt.create_array([
			rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [
				rt.new_string('Image default link type'),
			]) },
			rt.ArrayItem{ key: 'readonly', val: true },
			rt.ArrayItem{ key: 'option', val: 'image_default_link_type' },
		]) },
		rt.ArrayItem{ key: 'image_default_size', val: rt.create_array([
			rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [
				rt.new_string('Image default size'),
			]) },
			rt.ArrayItem{ key: 'readonly', val: true },
			rt.ArrayItem{ key: 'option', val: 'image_default_size' },
		]) },
		rt.ArrayItem{ key: 'image_default_align', val: rt.create_array([
			rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [
				rt.new_string('Image default align'),
			]) },
			rt.ArrayItem{ key: 'readonly', val: true },
			rt.ArrayItem{ key: 'option', val: 'image_default_align' },
		]) },
		rt.ArrayItem{ key: 'template', val: rt.create_array([
			rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [
				rt.new_string('Template'),
			]) },
			rt.ArrayItem{ key: 'readonly', val: true },
			rt.ArrayItem{ key: 'option', val: 'template' },
		]) },
		rt.ArrayItem{ key: 'stylesheet', val: rt.create_array([
			rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [
				rt.new_string('Stylesheet'),
			]) },
			rt.ArrayItem{ key: 'readonly', val: true },
			rt.ArrayItem{ key: 'option', val: 'stylesheet' },
		]) },
		rt.ArrayItem{ key: 'post_thumbnail', val: rt.create_array([
			rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [
				rt.new_string('Post Thumbnail'),
			]) },
			rt.ArrayItem{ key: 'readonly', val: true },
			rt.ArrayItem{ key: 'value', val: rt.call_function('current_theme_supports', [
				rt.new_string('post-thumbnails'),
			]) },
		]) },
		rt.ArrayItem{ key: 'time_zone', val: rt.create_array([
			rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [
				rt.new_string('Time Zone'),
			]) },
			rt.ArrayItem{ key: 'readonly', val: false },
			rt.ArrayItem{ key: 'option', val: 'gmt_offset' },
		]) },
		rt.ArrayItem{ key: 'blog_title', val: rt.create_array([
			rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [
				rt.new_string('Site Title'),
			]) },
			rt.ArrayItem{ key: 'readonly', val: false },
			rt.ArrayItem{ key: 'option', val: 'blogname' },
		]) },
		rt.ArrayItem{ key: 'blog_tagline', val: rt.create_array([
			rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [
				rt.new_string('Site Tagline'),
			]) },
			rt.ArrayItem{ key: 'readonly', val: false },
			rt.ArrayItem{ key: 'option', val: 'blogdescription' },
		]) },
		rt.ArrayItem{ key: 'date_format', val: rt.create_array([
			rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [
				rt.new_string('Date Format'),
			]) },
			rt.ArrayItem{ key: 'readonly', val: false },
			rt.ArrayItem{ key: 'option', val: 'date_format' },
		]) },
		rt.ArrayItem{ key: 'time_format', val: rt.create_array([
			rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [
				rt.new_string('Time Format'),
			]) },
			rt.ArrayItem{ key: 'readonly', val: false },
			rt.ArrayItem{ key: 'option', val: 'time_format' },
		]) },
		rt.ArrayItem{ key: 'users_can_register', val: rt.create_array([
			rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [
				rt.new_string('Allow new users to sign up'),
			]) },
			rt.ArrayItem{ key: 'readonly', val: false },
			rt.ArrayItem{ key: 'option', val: 'users_can_register' },
		]) },
		rt.ArrayItem{ key: 'thumbnail_size_w', val: rt.create_array([
			rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [
				rt.new_string('Thumbnail Width'),
			]) },
			rt.ArrayItem{ key: 'readonly', val: false },
			rt.ArrayItem{ key: 'option', val: 'thumbnail_size_w' },
		]) },
		rt.ArrayItem{ key: 'thumbnail_size_h', val: rt.create_array([
			rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [
				rt.new_string('Thumbnail Height'),
			]) },
			rt.ArrayItem{ key: 'readonly', val: false },
			rt.ArrayItem{ key: 'option', val: 'thumbnail_size_h' },
		]) },
		rt.ArrayItem{ key: 'thumbnail_crop', val: rt.create_array([
			rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [
				rt.new_string('Crop thumbnail to exact dimensions'),
			]) },
			rt.ArrayItem{ key: 'readonly', val: false },
			rt.ArrayItem{ key: 'option', val: 'thumbnail_crop' },
		]) },
		rt.ArrayItem{ key: 'medium_size_w', val: rt.create_array([
			rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [
				rt.new_string('Medium size image width'),
			]) },
			rt.ArrayItem{ key: 'readonly', val: false },
			rt.ArrayItem{ key: 'option', val: 'medium_size_w' },
		]) },
		rt.ArrayItem{ key: 'medium_size_h', val: rt.create_array([
			rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [
				rt.new_string('Medium size image height'),
			]) },
			rt.ArrayItem{ key: 'readonly', val: false },
			rt.ArrayItem{ key: 'option', val: 'medium_size_h' },
		]) },
		rt.ArrayItem{ key: 'medium_large_size_w', val: rt.create_array([
			rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [
				rt.new_string('Medium-Large size image width'),
			]) },
			rt.ArrayItem{ key: 'readonly', val: false },
			rt.ArrayItem{ key: 'option', val: 'medium_large_size_w' },
		]) },
		rt.ArrayItem{ key: 'medium_large_size_h', val: rt.create_array([
			rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [
				rt.new_string('Medium-Large size image height'),
			]) },
			rt.ArrayItem{ key: 'readonly', val: false },
			rt.ArrayItem{ key: 'option', val: 'medium_large_size_h' },
		]) },
		rt.ArrayItem{ key: 'large_size_w', val: rt.create_array([
			rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [
				rt.new_string('Large size image width'),
			]) },
			rt.ArrayItem{ key: 'readonly', val: false },
			rt.ArrayItem{ key: 'option', val: 'large_size_w' },
		]) },
		rt.ArrayItem{ key: 'large_size_h', val: rt.create_array([
			rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [
				rt.new_string('Large size image height'),
			]) },
			rt.ArrayItem{ key: 'readonly', val: false },
			rt.ArrayItem{ key: 'option', val: 'large_size_h' },
		]) },
		rt.ArrayItem{ key: 'default_comment_status', val: rt.create_array([
			rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [
				rt.new_string('Allow people to submit comments on new posts.'),
			]) },
			rt.ArrayItem{ key: 'readonly', val: false },
			rt.ArrayItem{ key: 'option', val: 'default_comment_status' },
		]) },
		rt.ArrayItem{ key: 'default_ping_status', val: rt.create_array([
			rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [
				rt.new_string('Allow link notifications from other blogs (pingbacks and trackbacks) on new posts.'),
			]) },
			rt.ArrayItem{ key: 'readonly', val: false },
			rt.ArrayItem{ key: 'option', val: 'default_ping_status' },
		]) },
	])
	this.blog_options = rt.call_function('apply_filters', [
		rt.new_string('xmlrpc_blog_options'),
		this.blog_options,
	])
}

fn (mut this Class_wp_xmlrpc_server) wp_getusersblogs(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
	if !(this.minimum_args(var_args_mutated.clone(), rt.new_int(2))) {
		return this.error
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{}))))) {
		rt.call_function('array_unshift', [var_args_mutated.clone(),
			rt.new_int(1)])
		return this.blogger_getusersblogs(var_args_mutated.clone())
	}
	this.escape(var_args_mutated.clone())
	mut var_username := var_args_mutated.array_get(rt.new_int(0))
	mut var_password := var_args_mutated.array_get(rt.new_int(1))
	mut var_user := rt.new_bool(this.login(var_username.clone(), var_password.clone()))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_user)))) {
		return this.error
	}
	rt.call_function('do_action', [rt.new_string('xmlrpc_call'),
		rt.new_string('wp.getUsersBlogs'), var_args_mutated.clone(),
		rt.new_object('wp_xmlrpc_server', ['IXR_Server'], &this)])
	mut var_blogs := rt.cast_array(rt.call_function('get_blogs_of_user', [
		rt.get_property(var_user, 'ID'),
	]))
	mut var_struct := []rt.PhpVal{}
	mut var_primary_blog_id := rt.new_int(0)
	mut var_active_blog := rt.call_function('get_active_blog_for_user', [
		rt.get_property(var_user, 'ID'),
	])
	if rt.is_true(var_active_blog) {
		var_primary_blog_id = rt.new_int((rt.get_property(var_active_blog, 'blog_id')).to_i64())
	}
	mut var_current_network_id := rt.call_function('get_current_network_id', []rt.PhpVal{})
	mut iter_6 := var_blogs.iterator()
	for {
		item_6 := iter_6.next() or { break }
		mut var_blog := item_6.val
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.get_property(var_blog, 'site_id'),
			var_current_network_id))))
		{
			continue
		}
		mut var_blog_id := rt.get_property(var_blog, 'userblog_id')
		rt.call_function('switch_to_blog', [var_blog_id.clone()])
		mut var_is_admin := rt.call_function('current_user_can', [
			rt.new_string('manage_options'),
		])
		mut var_is_primary := rt.identical(rt.new_int(var_blog_id.to_i64()), var_primary_blog_id)
		var_struct.array_push(rt.create_array([
			rt.ArrayItem{ key: 'isAdmin', val: var_is_admin },
			rt.ArrayItem{ key: 'isPrimary', val: var_is_primary },
			rt.ArrayItem{ key: 'url', val: rt.call_function('home_url', [
				rt.new_string('/'),
			]) },
			rt.ArrayItem{ key: 'blogid', val: var_blog_id.str() },
			rt.ArrayItem{ key: 'blogName', val: rt.call_function('get_option', [
				rt.new_string('blogname'),
			]) },
			rt.ArrayItem{ key: 'xmlrpc', val: rt.call_function('site_url', [
				rt.new_string('xmlrpc.php'),
				rt.new_string('rpc'),
			]) },
		]))
		rt.call_function('restore_current_blog', []rt.PhpVal{})
	}
	return var_struct.clone()
}

fn (mut this Class_wp_xmlrpc_server) minimum_args(var_args rt.PhpVal, var_count rt.PhpVal) bool {
	mut var_args_mutated := var_args
	mut var_count_mutated := var_count
	if !(var_args_mutated.clone().is_array())
		|| rt.is_true(rt.less(rt.new_int(var_args_mutated.clone().array_count()), var_count_mutated)) {
		this.error = create_ixr_error(rt.new_int(400), rt.call_function('__', [
			rt.new_string('Insufficient arguments passed to this XML-RPC method.'),
		]))
		return false
	}
	return true
}

fn (mut this Class_wp_xmlrpc_server) _prepare_taxonomy(var_taxonomy rt.PhpVal, var_fields rt.PhpVal) rt.PhpVal {
	mut var_taxonomy_mutated := var_taxonomy
	mut var_fields_mutated := var_fields
	mut var__taxonomy := {
		'name':         rt.get_property(var_taxonomy_mutated, 'name')
		'label':        rt.get_property(var_taxonomy_mutated, 'label')
		'hierarchical': (rt.get_property(var_taxonomy_mutated, 'hierarchical')).to_bool()
		'public':       (rt.get_property(var_taxonomy_mutated, 'public')).to_bool()
		'show_ui':      (rt.get_property(var_taxonomy_mutated, 'show_ui')).to_bool()
		'_builtin':     (rt.get_property(var_taxonomy_mutated, '_builtin')).to_bool()
	}
	if rt.is_true(rt.call_function('in_array', [rt.new_string('labels'),
		var_fields_mutated.clone(), rt.new_bool(true)]))
	{
		var__taxonomy['labels'] = rt.cast_array(rt.get_property(var_taxonomy_mutated, 'labels'))
	}
	if rt.is_true(rt.call_function('in_array', [rt.new_string('cap'),
		var_fields_mutated.clone(), rt.new_bool(true)]))
	{
		var__taxonomy['cap'] = rt.cast_array(rt.get_property(var_taxonomy_mutated, 'cap'))
	}
	if rt.is_true(rt.call_function('in_array', [rt.new_string('menu'),
		var_fields_mutated.clone(), rt.new_bool(true)]))
	{
		var__taxonomy['show_in_menu'] =
			(rt.get_property(var_taxonomy_mutated, 'show_in_menu')).to_bool()
	}
	if rt.is_true(rt.call_function('in_array', [rt.new_string('object_type'),
		var_fields_mutated.clone(), rt.new_bool(true)]))
	{
		var__taxonomy['object_type'] = rt.call_function('array_unique', [
			rt.cast_array(rt.get_property(var_taxonomy_mutated, 'object_type')),
		])
	}
	return rt.call_function('apply_filters', [rt.new_string('xmlrpc_prepare_taxonomy'),
		rt.create_array_from_native_map(var__taxonomy), var_taxonomy_mutated.clone(),
		var_fields_mutated.clone()])
}

fn (mut this Class_wp_xmlrpc_server) _prepare_term(var_term rt.PhpVal) rt.PhpVal {
	mut var_term_mutated := var_term
	mut var__term := var_term_mutated.clone()
	if !(var__term.clone().is_array()) {
		var__term = rt.call_function('get_object_vars', [var__term.clone()])
	}
	var__term.array_set('term_id', (var__term.array_get(rt.new_string('term_id'))).str())
	var__term.array_set('term_group', (var__term.array_get(rt.new_string('term_group'))).str())
	var__term.array_set('term_taxonomy_id',
		(var__term.array_get(rt.new_string('term_taxonomy_id'))).str())
	var__term.array_set('parent', (var__term.array_get(rt.new_string('parent'))).str())
	var__term.array_set('count', rt.new_int((var__term.array_get(rt.new_string('count'))).to_i64()))
	var__term.array_set('custom_fields',
		this.get_term_custom_fields(var__term.array_get(rt.new_string('term_id'))))
	return rt.call_function('apply_filters', [rt.new_string('xmlrpc_prepare_term'),
		var__term.clone(), var_term_mutated.clone()])
}

fn (mut this Class_wp_xmlrpc_server) _convert_date(var_date rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.identical(rt.new_string('0000-00-00 00:00:00'), var_date)) {
		return rt.new_object('IXR_Date', []string{},
			create_ixr_date(rt.new_string('00000000T00:00:00Z')))
	}
	return rt.new_object('IXR_Date', []string{}, create_ixr_date(rt.call_function('mysql2date', [
		rt.new_string('Ymd\\TH:i:s'),
		var_date.clone(),
		rt.new_bool(false),
	])))
}

fn (mut this Class_wp_xmlrpc_server) _convert_date_gmt(var_date_gmt rt.PhpVal, var_date rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('0000-00-00 00:00:00'), var_date))))
		&& rt.is_true(rt.identical(rt.new_string('0000-00-00 00:00:00'), var_date_gmt)) {
		return rt.new_object('IXR_Date', []string{}, create_ixr_date(rt.call_function('get_gmt_from_date', [
			rt.call_function('mysql2date', [rt.new_string('Y-m-d H:i:s'),
				var_date.clone(), rt.new_bool(false)]),
			rt.new_string('Ymd\\TH:i:s'),
		])))
	}
	return this._convert_date(var_date_gmt.clone())
}

fn (mut this Class_wp_xmlrpc_server) _prepare_post(var_post rt.PhpVal, var_fields rt.PhpVal) rt.PhpVal {
	mut var_post_mutated := var_post
	mut var_fields_mutated := var_fields
	mut var__post := rt.create_array([
		rt.ArrayItem{ key: 'post_id', val: (var_post_mutated.array_get(rt.new_string('ID'))).str() },
	])
	mut var_post_fields := {
		'post_title':        var_post_mutated.array_get(rt.new_string('post_title'))
		'post_date':         this._convert_date(var_post_mutated.array_get(rt.new_string('post_date')))
		'post_date_gmt':     this._convert_date_gmt(var_post_mutated.array_get(rt.new_string('post_date_gmt')),
			var_post_mutated.array_get(rt.new_string('post_date')))
		'post_modified':     this._convert_date(var_post_mutated.array_get(rt.new_string('post_modified')))
		'post_modified_gmt': this._convert_date_gmt(var_post_mutated.array_get(rt.new_string('post_modified_gmt')),
			var_post_mutated.array_get(rt.new_string('post_modified')))
		'post_status':       var_post_mutated.array_get(rt.new_string('post_status'))
		'post_type':         var_post_mutated.array_get(rt.new_string('post_type'))
		'post_name':         var_post_mutated.array_get(rt.new_string('post_name'))
		'post_author':       var_post_mutated.array_get(rt.new_string('post_author'))
		'post_password':     var_post_mutated.array_get(rt.new_string('post_password'))
		'post_excerpt':      var_post_mutated.array_get(rt.new_string('post_excerpt'))
		'post_content':      var_post_mutated.array_get(rt.new_string('post_content'))
		'post_parent':       (var_post_mutated.array_get(rt.new_string('post_parent'))).str()
		'post_mime_type':    var_post_mutated.array_get(rt.new_string('post_mime_type'))
		'link':              rt.call_function('get_permalink', [
			var_post_mutated.array_get(rt.new_string('ID')),
		])
		'guid':              var_post_mutated.array_get(rt.new_string('guid'))
		'menu_order':        rt.new_int((var_post_mutated.array_get(rt.new_string('menu_order'))).to_i64())
		'comment_status':    var_post_mutated.array_get(rt.new_string('comment_status'))
		'ping_status':       var_post_mutated.array_get(rt.new_string('ping_status'))
		'sticky':            rt.new_bool(
			rt.is_true(rt.identical(rt.new_string('post'), var_post_mutated.array_get(rt.new_string('post_type'))))
			&& rt.is_true(rt.call_function('is_sticky', [var_post_mutated.array_get(rt.new_string('ID'))])))
	}
	var_post_fields['post_thumbnail'] = []rt.PhpVal{}
	mut var_thumbnail_id := rt.call_function('get_post_thumbnail_id', [
		var_post_mutated.array_get(rt.new_string('ID')),
	])
	if rt.is_true(var_thumbnail_id) {
		mut var_thumbnail_size := rt.new_string((if rt.is_true(rt.call_function('current_theme_supports', [
			rt.new_string('post-thumbnail'),
		]))
		{ 'post-thumbnail' } else { 'thumbnail' }).str())
		var_post_fields['post_thumbnail'] = this._prepare_media_item(rt.call_function('get_post', [
			var_thumbnail_id.clone(),
		]), var_thumbnail_size.str())
	}
	if rt.is_true(rt.identical(rt.new_string('future'), var_post_fields['post_status'])) {
		var_post_fields['post_status'] = rt.new_string('publish')
	}
	var_post_fields['post_format'] = rt.call_function('get_post_format', [
		var_post_mutated.array_get(rt.new_string('ID')),
	])
	if !rt.is_true(var_post_fields['post_format']) {
		var_post_fields['post_format'] = rt.new_string('standard')
	}
	if rt.is_true(rt.call_function('in_array', [rt.new_string('post'),
		var_fields_mutated.clone(), rt.new_bool(true)]))
	{
		var__post = rt.call_function('array_merge', [var__post.clone(),
			rt.create_array_from_native_map(var_post_fields)])
	} else {
		mut var_requested_fields := rt.call_function('array_intersect_key', [
			rt.create_array_from_native_map(var_post_fields),
			rt.call_function('array_flip', [var_fields_mutated.clone()]),
		])
		var__post = rt.call_function('array_merge', [var__post.clone(),
			var_requested_fields.clone()])
	}
	mut var_all_taxonomy_fields := rt.call_function('in_array', [
		rt.new_string('taxonomies'),
		var_fields_mutated.clone(),
		rt.new_bool(true),
	])
	if rt.is_true(var_all_taxonomy_fields)
		|| rt.is_true(rt.call_function('in_array', [rt.new_string('terms'), var_fields_mutated.clone(), rt.new_bool(true)])) {
		mut var_post_type_taxonomies := rt.call_function('get_object_taxonomies', [
			var_post_mutated.array_get(rt.new_string('post_type')),
			rt.new_string('names'),
		])
		mut var_terms := rt.call_function('wp_get_object_terms', [
			var_post_mutated.array_get(rt.new_string('ID')),
			var_post_type_taxonomies.clone(),
		])
		var__post.array_set('terms', []rt.PhpVal{})
		mut iter_7 := var_terms.iterator()
		for {
			item_7 := iter_7.next() or { break }
			mut var_term := item_7.val
			var__post.array_get_mut('terms').array_push(this._prepare_term(var_term.clone()))
		}
	}
	if rt.is_true(rt.call_function('in_array', [rt.new_string('custom_fields'),
		var_fields_mutated.clone(), rt.new_bool(true)]))
	{
		var__post.array_set('custom_fields',
			this.get_custom_fields(var_post_mutated.array_get(rt.new_string('ID'))))
	}
	if rt.is_true(rt.call_function('in_array', [rt.new_string('enclosure'),
		var_fields_mutated.clone(), rt.new_bool(true)]))
	{
		var__post.array_set('enclosure', []rt.PhpVal{})
		mut var_enclosures := rt.cast_array(rt.call_function('get_post_meta', [
			var_post_mutated.array_get(rt.new_string('ID')),
			rt.new_string('enclosure'),
		]))
		if !(!rt.is_true(var_enclosures)) {
			mut var_encdata := rt.call_function('explode', [rt.new_string('\n'),
				var_enclosures.array_get(rt.new_int(0))])
			var__post.array_get_mut('enclosure').array_set('url', rt.call_function('htmlspecialchars', [
				var_encdata.array_get(rt.new_int(0)),
			]).to_string().trim_space())
			var__post.array_get_mut('enclosure').array_set('length',
				var_encdata.array_get(rt.new_int(1)).to_string().trim_space().i64())
			var__post.array_get_mut('enclosure').array_set('type',
				var_encdata.array_get(rt.new_int(2)).to_string().trim_space())
		}
	}
	return rt.call_function('apply_filters', [rt.new_string('xmlrpc_prepare_post'),
		var__post.clone(), var_post_mutated.clone(), var_fields_mutated.clone()])
}

fn (mut this Class_wp_xmlrpc_server) _prepare_post_type(var_post_type rt.PhpVal, var_fields rt.PhpVal) rt.PhpVal {
	mut var_post_type_mutated := var_post_type
	mut var_fields_mutated := var_fields
	mut var__post_type := {
		'name':         rt.get_property(var_post_type_mutated, 'name')
		'label':        rt.get_property(var_post_type_mutated, 'label')
		'hierarchical': (rt.get_property(var_post_type_mutated, 'hierarchical')).to_bool()
		'public':       (rt.get_property(var_post_type_mutated, 'public')).to_bool()
		'show_ui':      (rt.get_property(var_post_type_mutated, 'show_ui')).to_bool()
		'_builtin':     (rt.get_property(var_post_type_mutated, '_builtin')).to_bool()
		'has_archive':  (rt.get_property(var_post_type_mutated, 'has_archive')).to_bool()
		'supports':     rt.call_function('get_all_post_type_supports', [
			rt.get_property(var_post_type_mutated, 'name'),
		])
	}
	if rt.is_true(rt.call_function('in_array', [rt.new_string('labels'),
		var_fields_mutated.clone(), rt.new_bool(true)]))
	{
		var__post_type['labels'] = rt.cast_array(rt.get_property(var_post_type_mutated, 'labels'))
	}
	if rt.is_true(rt.call_function('in_array', [rt.new_string('cap'),
		var_fields_mutated.clone(), rt.new_bool(true)]))
	{
		var__post_type['cap'] = rt.cast_array(rt.get_property(var_post_type_mutated, 'cap'))
		var__post_type['map_meta_cap'] =
			(rt.get_property(var_post_type_mutated, 'map_meta_cap')).to_bool()
	}
	if rt.is_true(rt.call_function('in_array', [rt.new_string('menu'),
		var_fields_mutated.clone(), rt.new_bool(true)]))
	{
		var__post_type['menu_position'] = rt.new_int((rt.get_property(var_post_type_mutated,
			'menu_position')).to_i64())
		var__post_type['menu_icon'] = rt.get_property(var_post_type_mutated, 'menu_icon')
		var__post_type['show_in_menu'] =
			(rt.get_property(var_post_type_mutated, 'show_in_menu')).to_bool()
	}
	if rt.is_true(rt.call_function('in_array', [rt.new_string('taxonomies'),
		var_fields_mutated.clone(), rt.new_bool(true)]))
	{
		var__post_type['taxonomies'] = rt.call_function('get_object_taxonomies', [
			rt.get_property(var_post_type_mutated, 'name'),
			rt.new_string('names'),
		])
	}
	return rt.call_function('apply_filters', [rt.new_string('xmlrpc_prepare_post_type'),
		rt.create_array_from_native_map(var__post_type), var_post_type_mutated.clone()])
}

fn (mut this Class_wp_xmlrpc_server) _prepare_media_item(var_media_item rt.PhpVal, thumbnail_size string) rt.PhpVal {
	mut thumbnail_size_mutated := thumbnail_size
	mut var__media_item := {
		'attachment_id':    (rt.get_property(var_media_item, 'ID')).str()
		'date_created_gmt': this._convert_date_gmt(rt.get_property(var_media_item, 'post_date_gmt'), rt.get_property(var_media_item,
			'post_date'))
		'parent':           rt.get_property(var_media_item, 'post_parent')
		'link':             rt.call_function('wp_get_attachment_url', [
			rt.get_property(var_media_item, 'ID'),
		])
		'title':            rt.get_property(var_media_item, 'post_title')
		'caption':          rt.get_property(var_media_item, 'post_excerpt')
		'description':      rt.get_property(var_media_item, 'post_content')
		'metadata':         rt.call_function('wp_get_attachment_metadata', [
			rt.get_property(var_media_item, 'ID'),
		])
		'type':             rt.get_property(var_media_item, 'post_mime_type')
		'alt':              rt.call_function('get_post_meta', [
			rt.get_property(var_media_item, 'ID'),
			rt.new_string('_wp_attachment_image_alt'),
			rt.new_bool(true),
		])
	}
	mut var_thumbnail_src := rt.call_function('image_downsize', [
		rt.get_property(var_media_item, 'ID'),
		rt.new_string(thumbnail_size_mutated).clone(),
	])
	if rt.is_true(var_thumbnail_src) {
		var__media_item['thumbnail'] = var_thumbnail_src.array_get(rt.new_int(0))
	} else {
		var__media_item['thumbnail'] = var__media_item['link']
	}
	return rt.call_function('apply_filters', [rt.new_string('xmlrpc_prepare_media_item'),
		rt.create_array_from_native_map(var__media_item), var_media_item.clone(),
		rt.new_string(thumbnail_size_mutated).clone()])
}

fn (mut this Class_wp_xmlrpc_server) _prepare_page(var_page rt.PhpVal) rt.PhpVal {
	mut var_page_mutated := var_page
	mut var_full_page := rt.call_function('get_extended', [
		rt.get_property(var_page_mutated, 'post_content'),
	])
	mut var_link := rt.call_function('get_permalink', [
		rt.get_property(var_page_mutated, 'ID'),
	])
	mut var_parent_title := rt.new_string('')
	if !(!rt.is_true(rt.get_property(var_page_mutated, 'post_parent'))) {
		mut var_parent := rt.call_function('get_post', [
			rt.get_property(var_page_mutated, 'post_parent'),
		])
		var_parent_title = rt.get_property(var_parent, 'post_title')
	}
	mut var_allow_comments := rt.new_int(if rt.is_true(rt.call_function('comments_open', [
		rt.get_property(var_page_mutated, 'ID'),
	]))
	{ 1 } else { 0 })
	mut var_allow_pings := rt.new_int(if rt.is_true(rt.call_function('pings_open', [
		rt.get_property(var_page_mutated, 'ID'),
	]))
	{ 1 } else { 0 })
	mut var_page_date := this._convert_date(rt.get_property(var_page_mutated, 'post_date'))
	mut var_page_date_gmt := this._convert_date_gmt(rt.get_property(var_page_mutated,
		'post_date_gmt'), rt.get_property(var_page_mutated, 'post_date'))
	mut var_categories := []rt.PhpVal{}
	if rt.is_true(rt.call_function('is_object_in_taxonomy', [
		rt.new_string('page'), rt.new_string('category')]))
	{
		mut iter_8 := rt.call_function('wp_get_post_categories', [
			rt.get_property(var_page_mutated, 'ID'),
		]).iterator()
		for {
			item_8 := iter_8.next() or { break }
			mut var_cat_id := item_8.val
			var_categories.array_push(rt.call_function('get_cat_name', [
				var_cat_id.clone()]))
		}
	}
	mut var_author := rt.call_function('get_userdata', [
		rt.get_property(var_page_mutated, 'post_author'),
	])
	mut var_page_template := rt.call_function('get_page_template_slug', [
		rt.get_property(var_page_mutated, 'ID'),
	])
	if !rt.is_true(var_page_template) {
		var_page_template = rt.new_string('default')
	}
	mut var__page := {
		'dateCreated':            var_page_date
		'userid':                 rt.get_property(var_page_mutated, 'post_author')
		'page_id':                rt.get_property(var_page_mutated, 'ID')
		'page_status':            rt.get_property(var_page_mutated, 'post_status')
		'description':            var_full_page.array_get(rt.new_string('main'))
		'title':                  rt.get_property(var_page_mutated, 'post_title')
		'link':                   var_link
		'permaLink':              var_link
		'categories':             var_categories
		'excerpt':                rt.get_property(var_page_mutated, 'post_excerpt')
		'text_more':              var_full_page.array_get(rt.new_string('extended'))
		'mt_allow_comments':      var_allow_comments
		'mt_allow_pings':         var_allow_pings
		'wp_slug':                rt.get_property(var_page_mutated, 'post_name')
		'wp_password':            rt.get_property(var_page_mutated, 'post_password')
		'wp_author':              rt.get_property(var_author, 'display_name')
		'wp_page_parent_id':      rt.get_property(var_page_mutated, 'post_parent')
		'wp_page_parent_title':   var_parent_title
		'wp_page_order':          rt.get_property(var_page_mutated, 'menu_order')
		'wp_author_id':           (rt.get_property(var_author, 'ID')).str()
		'wp_author_display_name': rt.get_property(var_author, 'display_name')
		'date_created_gmt':       var_page_date_gmt
		'custom_fields':          this.get_custom_fields(rt.get_property(var_page_mutated, 'ID'))
		'wp_page_template':       var_page_template
	}
	return rt.call_function('apply_filters', [rt.new_string('xmlrpc_prepare_page'),
		rt.create_array_from_native_map(var__page), var_page_mutated.clone()])
}

fn (mut this Class_wp_xmlrpc_server) _prepare_comment(var_comment rt.PhpVal) rt.PhpVal {
	mut var_comment_mutated := var_comment
	mut var_comment_date_gmt := this._convert_date_gmt(rt.get_property(var_comment_mutated,
		'comment_date_gmt'), rt.get_property(var_comment_mutated, 'comment_date'))
	if rt.is_true(rt.identical(rt.new_string('0'), rt.get_property(var_comment_mutated,
		'comment_approved')))
	{
		mut var_comment_status := rt.new_string('hold')
	} else if rt.is_true(rt.identical(rt.new_string('spam'), rt.get_property(var_comment_mutated,
		'comment_approved')))
	{
		var_comment_status = rt.new_string('spam')
	} else if rt.is_true(rt.identical(rt.new_string('1'), rt.get_property(var_comment_mutated,
		'comment_approved')))
	{
		var_comment_status = rt.new_string('approve')
	} else {
		var_comment_status = rt.get_property(var_comment_mutated, 'comment_approved')
	}
	mut var__comment := {
		'date_created_gmt': var_comment_date_gmt
		'user_id':          rt.get_property(var_comment_mutated, 'user_id')
		'comment_id':       rt.get_property(var_comment_mutated, 'comment_ID')
		'parent':           rt.get_property(var_comment_mutated, 'comment_parent')
		'status':           var_comment_status
		'content':          rt.get_property(var_comment_mutated, 'comment_content')
		'link':             rt.call_function('get_comment_link', [
			var_comment_mutated.clone()])
		'post_id':          rt.get_property(var_comment_mutated, 'comment_post_ID')
		'post_title':       rt.call_function('get_the_title', [
			rt.get_property(var_comment_mutated, 'comment_post_ID'),
		])
		'author':           rt.get_property(var_comment_mutated, 'comment_author')
		'author_url':       rt.get_property(var_comment_mutated, 'comment_author_url')
		'author_email':     rt.get_property(var_comment_mutated, 'comment_author_email')
		'author_ip':        rt.get_property(var_comment_mutated, 'comment_author_IP')
		'type':             rt.get_property(var_comment_mutated, 'comment_type')
	}
	return rt.call_function('apply_filters', [rt.new_string('xmlrpc_prepare_comment'),
		rt.create_array_from_native_map(var__comment), var_comment_mutated.clone()])
}

fn (mut this Class_wp_xmlrpc_server) _prepare_user(var_user rt.PhpVal, var_fields rt.PhpVal) rt.PhpVal {
	mut var_user_mutated := var_user
	mut var_fields_mutated := var_fields
	mut var__user := rt.create_array([
		rt.ArrayItem{ key: 'user_id', val: (rt.get_property(var_user_mutated, 'ID')).str() },
	])
	mut var_user_fields := {
		'username':     rt.get_property(var_user_mutated, 'user_login')
		'first_name':   rt.get_property(var_user_mutated, 'user_firstname')
		'last_name':    rt.get_property(var_user_mutated, 'user_lastname')
		'registered':   this._convert_date(rt.get_property(var_user_mutated, 'user_registered'))
		'bio':          rt.get_property(var_user_mutated, 'user_description')
		'email':        rt.get_property(var_user_mutated, 'user_email')
		'nickname':     rt.get_property(var_user_mutated, 'nickname')
		'nicename':     rt.get_property(var_user_mutated, 'user_nicename')
		'url':          rt.get_property(var_user_mutated, 'user_url')
		'display_name': rt.get_property(var_user_mutated, 'display_name')
		'roles':        rt.get_property(var_user_mutated, 'roles')
	}
	if rt.is_true(rt.call_function('in_array', [rt.new_string('all'),
		var_fields_mutated.clone(), rt.new_bool(true)]))
	{
		var__user = rt.call_function('array_merge', [var__user.clone(),
			rt.create_array_from_native_map(var_user_fields)])
	} else {
		if rt.is_true(rt.call_function('in_array', [rt.new_string('basic'),
			var_fields_mutated.clone(), rt.new_bool(true)]))
		{
			mut var_basic_fields := ['username', 'email', 'registered', 'display_name', 'nicename']
			var_fields_mutated = rt.call_function('array_merge', [
				var_fields_mutated.clone(), rt.create_array_from_list(var_basic_fields)])
		}
		mut var_requested_fields := rt.call_function('array_intersect_key', [
			rt.create_array_from_native_map(var_user_fields),
			rt.call_function('array_flip', [var_fields_mutated.clone()]),
		])
		var__user = rt.call_function('array_merge', [var__user.clone(),
			var_requested_fields.clone()])
	}
	return rt.call_function('apply_filters', [rt.new_string('xmlrpc_prepare_user'),
		var__user.clone(), var_user_mutated.clone(), var_fields_mutated.clone()])
}

fn (mut this Class_wp_xmlrpc_server) wp_newpost(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
	if !(this.minimum_args(var_args_mutated.clone(), rt.new_int(4))) {
		return this.error
	}
	this.escape(var_args_mutated.clone())
	mut var_username := var_args_mutated.array_get(rt.new_int(1))
	mut var_password := var_args_mutated.array_get(rt.new_int(2))
	mut var_content_struct := var_args_mutated.array_get(rt.new_int(3))
	mut var_user := rt.new_bool(this.login(var_username.clone(), var_password.clone()))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_user)))) {
		return this.error
	}
	if var_content_struct.array_isset(rt.new_string('post_date'))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_content_struct.array_get(rt.new_string('post_date')), 'IXR_Date')))))) {
		var_content_struct.array_set('post_date',
			this._convert_date(var_content_struct.array_get(rt.new_string('post_date'))))
	}
	if var_content_struct.array_isset(rt.new_string('post_date_gmt'))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_content_struct.array_get(rt.new_string('post_date_gmt')), 'IXR_Date')))))) {
		if rt.is_true(rt.identical(rt.new_string('0000-00-00 00:00:00'), var_content_struct.array_get(rt.new_string('post_date_gmt'))))
			|| var_content_struct.array_isset(rt.new_string('post_date')) {
			var_content_struct.array_unset(rt.new_string('post_date_gmt'))
		} else {
			var_content_struct.array_set('post_date_gmt',
				this._convert_date(var_content_struct.array_get(rt.new_string('post_date_gmt'))))
		}
	}
	rt.call_function('do_action', [rt.new_string('xmlrpc_call'),
		rt.new_string('wp.newPost'), var_args_mutated.clone(),
		rt.new_object('wp_xmlrpc_server', ['IXR_Server'], &this)])
	var_content_struct.array_unset(rt.new_string('ID'))
	return rt.new_string(this._insert_post(var_user.clone(), var_content_struct.clone()))
}

fn (mut this Class_wp_xmlrpc_server) _is_greater_than_one(var_count rt.PhpVal) rt.PhpVal {
	mut var_count_mutated := var_count
	return rt.greater(var_count_mutated, rt.new_int(1))
}

fn (mut this Class_wp_xmlrpc_server) _toggle_sticky(var_post_data rt.PhpVal, update bool) rt.PhpVal {
	mut var_post_data_mutated := var_post_data
	mut update_mutated := update
	mut var_post_type := rt.call_function('get_post_type_object', [
		var_post_data_mutated.array_get(rt.new_string('post_type')),
	])
	if rt.is_true(rt.identical(rt.new_string('private'), var_post_data_mutated.array_get(rt.new_string('post_status'))))
		|| !(!rt.is_true(var_post_data_mutated.array_get(rt.new_string('post_password')))) {
		if !(!rt.is_true(var_post_data_mutated.array_get(rt.new_string('sticky')))) {
			return rt.new_object('IXR_Error', []string{}, create_ixr_error(rt.new_int(401), rt.call_function('__', [
				rt.new_string('Sorry, you cannot stick a private post.'),
			])))
		}
		if rt.is_true(rt.new_bool(update_mutated)) {
			rt.call_function('unstick_post', [var_post_data_mutated.array_get(rt.new_string('ID'))])
		}
	} else if var_post_data_mutated.array_isset(rt.new_string('sticky')) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
			rt.get_property(rt.get_property(var_post_type, 'cap'), 'edit_others_posts'),
		])))))
		{
			return rt.new_object('IXR_Error', []string{}, create_ixr_error(rt.new_int(401), rt.call_function('__', [
				rt.new_string('Sorry, you are not allowed to make posts sticky.'),
			])))
		}
		mut var_sticky := rt.call_function('wp_validate_boolean', [
			var_post_data_mutated.array_get(rt.new_string('sticky')),
		])
		if rt.is_true(var_sticky) {
			rt.call_function('stick_post', [var_post_data_mutated.array_get(rt.new_string('ID'))])
		} else {
			rt.call_function('unstick_post', [var_post_data_mutated.array_get(rt.new_string('ID'))])
		}
	}
	return rt.new_null()
}

fn (mut this Class_wp_xmlrpc_server) _insert_post(var_user rt.PhpVal, var_content_struct rt.PhpVal) string {
	mut var_user_mutated := var_user
	mut var_content_struct_mutated := var_content_struct
	mut var_defaults := {
		'post_status':    rt.new_string('draft')
		'post_type':      rt.new_string('post')
		'post_author':    rt.new_int(0)
		'post_password':  rt.new_string('')
		'post_excerpt':   rt.new_string('')
		'post_content':   rt.new_string('')
		'post_title':     rt.new_string('')
		'post_date':      rt.new_string('')
		'post_date_gmt':  rt.new_string('')
		'post_format':    rt.new_null()
		'post_name':      rt.new_null()
		'post_thumbnail': rt.new_null()
		'post_parent':    rt.new_int(0)
		'ping_status':    rt.new_string('')
		'comment_status': rt.new_string('')
		'custom_fields':  rt.new_null()
		'terms_names':    rt.new_null()
		'terms':          rt.new_null()
		'sticky':         rt.new_null()
		'enclosure':      rt.new_null()
		'ID':             rt.new_null()
	}
	mut var_post_data := rt.call_function('wp_parse_args', [
		rt.call_function('array_intersect_key', [var_content_struct_mutated.clone(),
			rt.create_array_from_native_map(var_defaults)]),
		rt.create_array_from_native_map(var_defaults),
	])
	mut var_post_type := rt.call_function('get_post_type_object', [
		var_post_data.array_get(rt.new_string('post_type')),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_post_type)))) {
		return (create_ixr_error(rt.new_int(403), rt.call_function('__', [
			rt.new_string('Invalid post type.'),
		]))).str()
	}
	mut var_update := rt.new_bool(!(!rt.is_true(var_post_data.array_get(rt.new_string('ID')))))
	if rt.is_true(var_update) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('get_post', [
			var_post_data.array_get(rt.new_string('ID')),
		])))))
		{
			return (create_ixr_error(rt.new_int(401), rt.call_function('__', [
				rt.new_string('Invalid post ID.'),
			]))).str()
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
			rt.new_string('edit_post'),
			var_post_data.array_get(rt.new_string('ID')),
		])))))
		{
			return (create_ixr_error(rt.new_int(401), rt.call_function('__', [
				rt.new_string('Sorry, you are not allowed to edit this post.'),
			]))).str()
		}
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('get_post_type', [
			var_post_data.array_get(rt.new_string('ID')),
		]), var_post_data.array_get(rt.new_string('post_type'))))))
		{
			return (create_ixr_error(rt.new_int(401), rt.call_function('__', [
				rt.new_string('The post type may not be changed.'),
			]))).str()
		}
	} else {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.get_property(rt.get_property(var_post_type, 'cap'), 'create_posts')])))))
			|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.get_property(rt.get_property(var_post_type, 'cap'), 'edit_posts')]))))) {
			return (create_ixr_error(rt.new_int(401), rt.call_function('__', [
				rt.new_string('Sorry, you are not allowed to post on this site.'),
			]))).str()
		}
	}
	mut switch_val_1 := var_post_data.array_get(rt.new_string('post_status'))
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('draft')))
		|| rt.is_true(rt.equal(switch_val_1, rt.new_string('pending'))) {
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('private'))) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
			rt.get_property(rt.get_property(var_post_type, 'cap'), 'publish_posts'),
		])))))
		{
			return (create_ixr_error(rt.new_int(401), rt.call_function('__', [
				rt.new_string('Sorry, you are not allowed to create private posts in this post type.'),
			]))).str()
		}
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('publish')))
		|| rt.is_true(rt.equal(switch_val_1, rt.new_string('future'))) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
			rt.get_property(rt.get_property(var_post_type, 'cap'), 'publish_posts'),
		])))))
		{
			return (create_ixr_error(rt.new_int(401), rt.call_function('__', [
				rt.new_string('Sorry, you are not allowed to publish posts in this post type.'),
			]))).str()
		}
	} else {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('get_post_status_object', [
			var_post_data.array_get(rt.new_string('post_status')),
		])))))
		{
			var_post_data.array_set('post_status', 'draft')
		}
	}
	if !(!rt.is_true(var_post_data.array_get(rt.new_string('post_password'))))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.get_property(rt.get_property(var_post_type, 'cap'), 'publish_posts')]))))) {
		return (create_ixr_error(rt.new_int(401), rt.call_function('__', [
			rt.new_string('Sorry, you are not allowed to create password protected posts in this post type.'),
		]))).str()
	}
	var_post_data.array_set('post_author', rt.call_function('absint', [
		var_post_data.array_get(rt.new_string('post_author')),
	]))
	if !(!rt.is_true(var_post_data.array_get(rt.new_string('post_author'))))
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_post_data.array_get(rt.new_string('post_author')), rt.get_property(var_user_mutated, 'ID'))))) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
			rt.get_property(rt.get_property(var_post_type, 'cap'), 'edit_others_posts'),
		])))))
		{
			return (create_ixr_error(rt.new_int(401), rt.call_function('__', [
				rt.new_string('Sorry, you are not allowed to create posts as this user.'),
			]))).str()
		}
		mut var_author := rt.call_function('get_userdata', [
			var_post_data.array_get(rt.new_string('post_author')),
		])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_author)))) {
			return (create_ixr_error(rt.new_int(404), rt.call_function('__', [
				rt.new_string('Invalid author ID.'),
			]))).str()
		}
	} else {
		var_post_data.array_set('post_author', rt.get_property(var_user_mutated, 'ID'))
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('open'), var_post_data.array_get(rt.new_string('comment_status'))))))
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('closed'), var_post_data.array_get(rt.new_string('comment_status')))))) {
		var_post_data.array_unset(rt.new_string('comment_status'))
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('open'), var_post_data.array_get(rt.new_string('ping_status'))))))
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('closed'), var_post_data.array_get(rt.new_string('ping_status')))))) {
		var_post_data.array_unset(rt.new_string('ping_status'))
	}
	if !(!rt.is_true(var_post_data.array_get(rt.new_string('post_date_gmt')))) {
		mut var_date_created := rt.new_string((
			rt.call_method(var_post_data.array_get(rt.new_string('post_date_gmt')), 'getIso', []rt.PhpVal{}).to_string().trim_right(' \t\n\r') +
			'Z').str())
	} else if !(!rt.is_true(var_post_data.array_get(rt.new_string('post_date')))) {
		var_date_created = rt.call_method(var_post_data.array_get(rt.new_string('post_date')),
			'getIso', []rt.PhpVal{})
	}
	var_post_data.array_set('edit_date', false)
	if !(!rt.is_true(var_date_created)) {
		var_post_data.array_set('post_date', rt.call_function('iso8601_to_datetime', [
			var_date_created.clone(),
		]))
		var_post_data.array_set('post_date_gmt', rt.call_function('iso8601_to_datetime', [
			var_date_created.clone(),
			rt.new_string('gmt'),
		]))
		var_post_data.array_set('edit_date', true)
	}
	if !(var_post_data.array_isset(rt.new_string('ID'))) {
		var_post_data.array_set('ID', rt.get_property(rt.call_function('get_default_post_to_edit', [
			var_post_data.array_get(rt.new_string('post_type')),
			rt.new_bool(true),
		]), 'ID'))
	}
	mut var_post_id := var_post_data.array_get(rt.new_string('ID'))
	if rt.is_true(rt.identical(rt.new_string('post'),
		var_post_data.array_get(rt.new_string('post_type'))))
	{
		mut var_error := this._toggle_sticky(var_post_data.clone(), var_update.to_bool())
		if rt.is_true(var_error) {
			return var_error.str()
		}
	}
	if var_post_data.array_isset(rt.new_string('post_thumbnail')) {
		if rt.is_true(rt.new_bool(!(rt.is_true(var_post_data.array_get(rt.new_string('post_thumbnail')))))) {
			rt.call_function('delete_post_thumbnail', [var_post_id.clone()])
		} else if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('get_post', [
			rt.call_function('absint', [var_post_data.array_get(rt.new_string('post_thumbnail'))]),
		])))))
		{
			return (create_ixr_error(rt.new_int(404), rt.call_function('__', [
				rt.new_string('Invalid attachment ID.'),
			]))).str()
		}
		rt.call_function('set_post_thumbnail', [var_post_id.clone(),
			var_post_data.array_get(rt.new_string('post_thumbnail'))])
		var_content_struct_mutated.array_unset(rt.new_string('post_thumbnail'))
	}
	if var_post_data.array_isset(rt.new_string('custom_fields')) {
		this.set_custom_fields(var_post_id.clone(),
			var_post_data.array_get(rt.new_string('custom_fields')))
	}
	if var_post_data.array_isset(rt.new_string('terms'))
		|| var_post_data.array_isset(rt.new_string('terms_names')) {
		mut var_post_type_taxonomies := rt.call_function('get_object_taxonomies', [
			var_post_data.array_get(rt.new_string('post_type')),
			rt.new_string('objects'),
		])
		mut var_terms := []rt.PhpVal{}
		if var_post_data.array_isset(rt.new_string('terms'))
			&& var_post_data.array_get(rt.new_string('terms')).is_array() {
			mut var_taxonomies :=
				rt.func_array_keys(var_post_data.array_get(rt.new_string('terms')))
			mut iter_9 := var_taxonomies.iterator()
			for {
				item_9 := iter_9.next() or { break }
				mut var_taxonomy := item_9.val
				if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_post_type_taxonomies.clone().array_isset(var_taxonomy.clone())))))) {
					return (create_ixr_error(rt.new_int(401), rt.call_function('__', [
						rt.new_string('Sorry, one of the given taxonomies is not supported by the post type.'),
					]))).str()
				}
				if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
					rt.get_property(rt.get_property(var_post_type_taxonomies.array_get(var_taxonomy),
						'cap'), 'assign_terms'),
				])))))
				{
					return (create_ixr_error(rt.new_int(401), rt.call_function('__', [
						rt.new_string('Sorry, you are not allowed to assign a term to one of the given taxonomies.'),
					]))).str()
				}
				mut var_term_ids :=
					var_post_data.array_get(rt.new_string('terms')).array_get(var_taxonomy)
				var_terms.array_set(var_taxonomy, []rt.PhpVal{})
				mut iter_10 := var_term_ids.iterator()
				for {
					item_10 := iter_10.next() or { break }
					mut var_term_id := item_10.val
					mut var_term := rt.call_function('get_term_by', [
						rt.new_string('id'), var_term_id.clone(),
						var_taxonomy.clone()])
					if rt.is_true(rt.new_bool(!(rt.is_true(var_term)))) {
						return (create_ixr_error(rt.new_int(403), rt.call_function('__', [
							rt.new_string('Invalid term ID.'),
						]))).str()
					}
					var_terms.array_get_mut(var_taxonomy).array_push(rt.new_int(var_term_id.to_i64()))
				}
			}
		}
		if var_post_data.array_isset(rt.new_string('terms_names'))
			&& var_post_data.array_get(rt.new_string('terms_names')).is_array() {
			var_taxonomies =
				rt.func_array_keys(var_post_data.array_get(rt.new_string('terms_names')))
			mut iter_11 := var_taxonomies.iterator()
			for {
				item_11 := iter_11.next() or { break }
				mut var_taxonomy := item_11.val
				if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_post_type_taxonomies.clone().array_isset(var_taxonomy.clone())))))) {
					return (create_ixr_error(rt.new_int(401), rt.call_function('__', [
						rt.new_string('Sorry, one of the given taxonomies is not supported by the post type.'),
					]))).str()
				}
				if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
					rt.get_property(rt.get_property(var_post_type_taxonomies.array_get(var_taxonomy),
						'cap'), 'assign_terms'),
				])))))
				{
					return (create_ixr_error(rt.new_int(401), rt.call_function('__', [
						rt.new_string('Sorry, you are not allowed to assign a term to one of the given taxonomies.'),
					]))).str()
				}
				mut var_ambiguous_terms := []rt.PhpVal{}
				if rt.is_true(rt.call_function('is_taxonomy_hierarchical', [
					var_taxonomy.clone()]))
				{
					mut var_tax_term_names := rt.call_function('get_terms', [
						rt.create_array([
							rt.ArrayItem{ key: 'taxonomy', val: var_taxonomy },
							rt.ArrayItem{ key: 'fields', val: 'names' },
							rt.ArrayItem{ key: 'hide_empty', val: false },
						]),
					])
					mut var_tax_term_names_count := rt.call_function('array_count_values', [
						var_tax_term_names.clone(),
					])
					mut var_ambiguous_tax_term_counts := rt.call_function('array_filter', [
						var_tax_term_names_count.clone(),
						rt.create_array([
							rt.ArrayItem{ key: none, val: rt.new_object('wp_xmlrpc_server', [
								'IXR_Server',
							], &this) },
							rt.ArrayItem{ key: none, val: '_is_greater_than_one' },
						]),
					])
					var_ambiguous_terms = rt.func_array_keys(var_ambiguous_tax_term_counts.clone())
				}
				mut var_term_names :=
					var_post_data.array_get(rt.new_string('terms_names')).array_get(var_taxonomy)
				mut iter_12 := var_term_names.iterator()
				for {
					item_12 := iter_12.next() or { break }
					mut var_term_name := item_12.val
					if rt.is_true(rt.call_function('in_array', [
						var_term_name.clone(), var_ambiguous_terms.clone(),
						rt.new_bool(true)]))
					{
						return (create_ixr_error(rt.new_int(401), rt.call_function('__', [
							rt.new_string('Ambiguous term name used in a hierarchical taxonomy. Please use term ID instead.'),
						]))).str()
					}
					mut var_term := rt.call_function('get_term_by', [
						rt.new_string('name'),
						var_term_name.clone(),
						var_taxonomy.clone(),
					])
					if rt.is_true(rt.new_bool(!(rt.is_true(var_term)))) {
						if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
							rt.get_property(rt.get_property(var_post_type_taxonomies.array_get(var_taxonomy),
								'cap'), 'edit_terms'),
						])))))
						{
							return (create_ixr_error(rt.new_int(401), rt.call_function('__', [
								rt.new_string('Sorry, you are not allowed to add a term to one of the given taxonomies.'),
							]))).str()
						}
						mut var_term_info := rt.call_function('wp_insert_term', [
							var_term_name.clone(),
							var_taxonomy.clone(),
						])
						if rt.is_true(rt.call_function('is_wp_error', [
							var_term_info.clone()]))
						{
							return (create_ixr_error(rt.new_int(500), rt.call_method(var_term_info,
								'get_error_message', []rt.PhpVal{}))).str()
						}
						var_terms.array_get_mut(var_taxonomy).array_push(rt.new_int((var_term_info.array_get(rt.new_string('term_id'))).to_i64()))
					} else {
						var_terms.array_get_mut(var_taxonomy).array_push(rt.new_int((rt.get_property(var_term,
							'term_id')).to_i64()))
					}
				}
			}
		}
		var_post_data.array_set('tax_input', var_terms.clone())
		var_post_data.array_unset(rt.new_string('terms'))
		var_post_data.array_unset(rt.new_string('terms_names'))
	}
	if var_post_data.array_isset(rt.new_string('post_format')) {
		mut var_format := rt.call_function('set_post_format', [
			var_post_id.clone(), var_post_data.array_get(rt.new_string('post_format'))])
		if rt.is_true(rt.call_function('is_wp_error', [var_format.clone()])) {
			return (create_ixr_error(rt.new_int(500), rt.call_method(var_format,
				'get_error_message', []rt.PhpVal{}))).str()
		}
		var_post_data.array_unset(rt.new_string('post_format'))
	}
	mut var_enclosure := if !(var_post_data.array_get(rt.new_string('enclosure'))).is_null() {
		var_post_data.array_get(rt.new_string('enclosure'))
	} else {
		rt.new_null()
	}
	this.add_enclosure_if_new(var_post_id.clone(), var_enclosure.clone())
	this.attach_uploads(var_post_id.clone(), var_post_data.array_get(rt.new_string('post_content')))
	var_post_data = rt.call_function('apply_filters', [
		rt.new_string('xmlrpc_wp_insert_post_data'),
		var_post_data.clone(),
		var_content_struct_mutated.clone(),
	])
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_value := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_value)))
	}
	var_post_data = rt.call_function('array_filter', [var_post_data.clone(),
		rt.new_closure(closure_1_fn)])
	var_post_id = if rt.is_true(var_update) { rt.call_function('wp_update_post', [
			var_post_data.clone(),
			rt.new_bool(true),
		]) } else { rt.call_function('wp_insert_post', [var_post_data.clone(),
			rt.new_bool(true)]) }
	if rt.is_true(rt.call_function('is_wp_error', [var_post_id.clone()])) {
		return (create_ixr_error(rt.new_int(500), rt.call_method(var_post_id, 'get_error_message',
			[]rt.PhpVal{}))).str()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_post_id)))) {
		if rt.is_true(var_update) {
			return (create_ixr_error(rt.new_int(401), rt.call_function('__', [
				rt.new_string('Sorry, the post could not be updated.'),
			]))).str()
		} else {
			return (create_ixr_error(rt.new_int(401), rt.call_function('__', [
				rt.new_string('Sorry, the post could not be created.'),
			]))).str()
		}
	}
	return var_post_id.str()
}

fn (mut this Class_wp_xmlrpc_server) wp_editpost(var_args rt.PhpVal) bool {
	mut var_args_mutated := var_args
	if !(this.minimum_args(var_args_mutated.clone(), rt.new_int(5))) {
		return (this.error).to_bool()
	}
	this.escape(var_args_mutated.clone())
	mut var_username := var_args_mutated.array_get(rt.new_int(1))
	mut var_password := var_args_mutated.array_get(rt.new_int(2))
	mut var_post_id := rt.new_int((var_args_mutated.array_get(rt.new_int(3))).to_i64())
	mut var_content_struct := var_args_mutated.array_get(rt.new_int(4))
	mut var_user := rt.new_bool(this.login(var_username.clone(), var_password.clone()))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_user)))) {
		return (this.error).to_bool()
	}
	rt.call_function('do_action', [rt.new_string('xmlrpc_call'),
		rt.new_string('wp.editPost'), var_args_mutated.clone(),
		rt.new_object('wp_xmlrpc_server', ['IXR_Server'], &this)])
	mut var_post := rt.call_function('get_post', [var_post_id.clone(),
		rt.get_constant('ARRAY_A')])
	if !rt.is_true(var_post.array_get(rt.new_string('ID'))) {
		return (create_ixr_error(rt.new_int(404), rt.call_function('__', [
			rt.new_string('Invalid post ID.'),
		]))).to_bool()
	}
	if var_content_struct.array_isset(rt.new_string('if_not_modified_since')) {
		if rt.is_true(rt.greater(rt.call_function('mysql2date', [
			rt.new_string('U'), var_post.array_get(rt.new_string('post_modified_gmt'))]), rt.call_method(var_content_struct.array_get(rt.new_string('if_not_modified_since')),
			'getTimestamp', []rt.PhpVal{})))
		{
			return (create_ixr_error(rt.new_int(409), rt.call_function('__', [
				rt.new_string('There is a revision of this post that is more recent.'),
			]))).to_bool()
		}
	}
	var_post.array_set('post_date',
		this._convert_date(var_post.array_get(rt.new_string('post_date'))))
	if rt.is_true(rt.identical(rt.new_string('0000-00-00 00:00:00'), var_post.array_get(rt.new_string('post_date_gmt'))))
		|| var_content_struct.array_isset(rt.new_string('post_date')) {
		var_post.array_unset(rt.new_string('post_date_gmt'))
	} else {
		var_post.array_set('post_date_gmt',
			this._convert_date(var_post.array_get(rt.new_string('post_date_gmt'))))
	}
	if !(var_content_struct.array_isset(rt.new_string('post_date'))) {
		var_post.array_unset(rt.new_string('post_date'))
	}
	this.escape(var_post.clone())
	mut var_merged_content_struct := rt.call_function('array_merge', [
		var_post.clone(), var_content_struct.clone()])
	mut var_retval := rt.new_string(this._insert_post(var_user.clone(),
		var_merged_content_struct.clone()))
	if rt.is_true(rt.new_bool(rt.instance_of(var_retval, 'IXR_Error'))) {
		return var_retval.to_bool()
	}
	return true
}

fn (mut this Class_wp_xmlrpc_server) wp_deletepost(var_args rt.PhpVal) bool {
	mut var_args_mutated := var_args
	if !(this.minimum_args(var_args_mutated.clone(), rt.new_int(4))) {
		return (this.error).to_bool()
	}
	this.escape(var_args_mutated.clone())
	mut var_username := var_args_mutated.array_get(rt.new_int(1))
	mut var_password := var_args_mutated.array_get(rt.new_int(2))
	mut var_post_id := rt.new_int((var_args_mutated.array_get(rt.new_int(3))).to_i64())
	mut var_user := rt.new_bool(this.login(var_username.clone(), var_password.clone()))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_user)))) {
		return (this.error).to_bool()
	}
	rt.call_function('do_action', [rt.new_string('xmlrpc_call'),
		rt.new_string('wp.deletePost'), var_args_mutated.clone(),
		rt.new_object('wp_xmlrpc_server', ['IXR_Server'], &this)])
	mut var_post := rt.call_function('get_post', [var_post_id.clone(),
		rt.get_constant('ARRAY_A')])
	if !rt.is_true(var_post.array_get(rt.new_string('ID'))) {
		return (create_ixr_error(rt.new_int(404), rt.call_function('__', [
			rt.new_string('Invalid post ID.'),
		]))).to_bool()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('delete_post'),
		var_post_id.clone(),
	])))))
	{
		return (create_ixr_error(rt.new_int(401), rt.call_function('__', [
			rt.new_string('Sorry, you are not allowed to delete this post.'),
		]))).to_bool()
	}
	mut var_result := rt.call_function('wp_delete_post', [var_post_id.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_result)))) {
		return (create_ixr_error(rt.new_int(500), rt.call_function('__', [
			rt.new_string('Sorry, the post could not be deleted.'),
		]))).to_bool()
	}
	return true
}

fn (mut this Class_wp_xmlrpc_server) wp_getpost(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
	if !(this.minimum_args(var_args_mutated.clone(), rt.new_int(4))) {
		return this.error
	}
	this.escape(var_args_mutated.clone())
	mut var_username := var_args_mutated.array_get(rt.new_int(1))
	mut var_password := var_args_mutated.array_get(rt.new_int(2))
	mut var_post_id := rt.new_int((var_args_mutated.array_get(rt.new_int(3))).to_i64())
	if var_args_mutated.array_isset(rt.new_int(4)) {
		mut var_fields := var_args_mutated.array_get(rt.new_int(4))
	} else {
		var_fields = rt.call_function('apply_filters', [
			rt.new_string('xmlrpc_default_post_fields'),
			rt.create_array([rt.ArrayItem{ key: none, val: 'post' },
				rt.ArrayItem{ key: none, val: 'terms' }, rt.ArrayItem{
					key: none
					val: 'custom_fields'
				}]),
			rt.new_string('wp.getPost'),
		])
	}
	mut var_user := rt.new_bool(this.login(var_username.clone(), var_password.clone()))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_user)))) {
		return this.error
	}
	rt.call_function('do_action', [rt.new_string('xmlrpc_call'),
		rt.new_string('wp.getPost'), var_args_mutated.clone(),
		rt.new_object('wp_xmlrpc_server', ['IXR_Server'], &this)])
	mut var_post := rt.call_function('get_post', [var_post_id.clone(),
		rt.get_constant('ARRAY_A')])
	if !rt.is_true(var_post.array_get(rt.new_string('ID'))) {
		return rt.new_object('IXR_Error', []string{}, create_ixr_error(rt.new_int(404), rt.call_function('__', [
			rt.new_string('Invalid post ID.'),
		])))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('edit_post'),
		var_post_id.clone(),
	])))))
	{
		return rt.new_object('IXR_Error', []string{}, create_ixr_error(rt.new_int(401), rt.call_function('__', [
			rt.new_string('Sorry, you are not allowed to edit this post.'),
		])))
	}
	return this._prepare_post(var_post.clone(), var_fields.clone())
}

fn (mut this Class_wp_xmlrpc_server) wp_getposts(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
	if !(this.minimum_args(var_args_mutated.clone(), rt.new_int(3))) {
		return this.error
	}
	this.escape(var_args_mutated.clone())
	mut var_username := var_args_mutated.array_get(rt.new_int(1))
	mut var_password := var_args_mutated.array_get(rt.new_int(2))
	mut var_filter := if !(var_args_mutated.array_get(rt.new_int(3))).is_null() {
		var_args_mutated.array_get(rt.new_int(3))
	} else {
		[]rt.PhpVal{}
	}
	if var_args_mutated.array_isset(rt.new_int(4)) {
		mut var_fields := var_args_mutated.array_get(rt.new_int(4))
	} else {
		var_fields = rt.call_function('apply_filters', [
			rt.new_string('xmlrpc_default_post_fields'),
			rt.create_array([rt.ArrayItem{ key: none, val: 'post' },
				rt.ArrayItem{ key: none, val: 'terms' }, rt.ArrayItem{
					key: none
					val: 'custom_fields'
				}]),
			rt.new_string('wp.getPosts'),
		])
	}
	mut var_user := rt.new_bool(this.login(var_username.clone(), var_password.clone()))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_user)))) {
		return this.error
	}
	rt.call_function('do_action', [rt.new_string('xmlrpc_call'),
		rt.new_string('wp.getPosts'), var_args_mutated.clone(),
		rt.new_object('wp_xmlrpc_server', ['IXR_Server'], &this)])
	mut var_query := []rt.PhpVal{}
	if var_filter.array_isset(rt.new_string('post_type')) {
		mut var_post_type := rt.call_function('get_post_type_object', [
			var_filter.array_get(rt.new_string('post_type')),
		])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_post_type.to_bool())))) {
			return create_ixr_error(rt.new_int(403), rt.call_function('__', [
				rt.new_string('Invalid post type.'),
			]))
		}
	} else {
		var_post_type = rt.call_function('get_post_type_object', [
			rt.new_string('post')])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.get_property(rt.get_property(var_post_type, 'cap'), 'edit_posts'),
	])))))
	{
		return create_ixr_error(rt.new_int(401), rt.call_function('__', [
			rt.new_string('Sorry, you are not allowed to edit posts in this post type.'),
		]))
	}
	var_query['post_type'] = rt.get_property(var_post_type, 'name')
	if var_filter.array_isset(rt.new_string('post_status')) {
		var_query['post_status'] = var_filter.array_get(rt.new_string('post_status'))
	}
	if var_filter.array_isset(rt.new_string('number')) {
		var_query['numberposts'] = rt.call_function('absint', [
			var_filter.array_get(rt.new_string('number')),
		])
	}
	if var_filter.array_isset(rt.new_string('offset')) {
		var_query['offset'] = rt.call_function('absint', [
			var_filter.array_get(rt.new_string('offset')),
		])
	}
	if var_filter.array_isset(rt.new_string('orderby')) {
		var_query['orderby'] = var_filter.array_get(rt.new_string('orderby'))
		if var_filter.array_isset(rt.new_string('order')) {
			var_query['order'] = var_filter.array_get(rt.new_string('order'))
		}
	}
	if var_filter.array_isset(rt.new_string('s')) {
		var_query['s'] = var_filter.array_get(rt.new_string('s'))
	}
	mut var_posts_list := rt.call_function('wp_get_recent_posts', [
		rt.create_array_from_native_map(var_query),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_posts_list)))) {
		return []rt.PhpVal{}
	}
	mut var_struct := []rt.PhpVal{}
	mut iter_13 := var_posts_list.iterator()
	for {
		item_13 := iter_13.next() or { break }
		mut var_post := item_13.val
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
			rt.new_string('edit_post'),
			var_post.array_get(rt.new_string('ID')),
		])))))
		{
			continue
		}
		var_struct.array_push(this._prepare_post(var_post.clone(), var_fields.clone()))
	}
	return var_struct.clone()
}

fn (mut this Class_wp_xmlrpc_server) wp_newterm(var_args rt.PhpVal) string {
	mut var_args_mutated := var_args
	if !(this.minimum_args(var_args_mutated.clone(), rt.new_int(4))) {
		return (this.error).str()
	}
	this.escape(var_args_mutated.clone())
	mut var_username := var_args_mutated.array_get(rt.new_int(1))
	mut var_password := var_args_mutated.array_get(rt.new_int(2))
	mut var_content_struct := var_args_mutated.array_get(rt.new_int(3))
	mut var_user := rt.new_bool(this.login(var_username.clone(), var_password.clone()))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_user)))) {
		return (this.error).str()
	}
	rt.call_function('do_action', [rt.new_string('xmlrpc_call'),
		rt.new_string('wp.newTerm'), var_args_mutated.clone(),
		rt.new_object('wp_xmlrpc_server', ['IXR_Server'], &this)])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('taxonomy_exists', [
		var_content_struct.array_get(rt.new_string('taxonomy')),
	])))))
	{
		return (create_ixr_error(rt.new_int(403), rt.call_function('__', [
			rt.new_string('Invalid taxonomy.'),
		]))).str()
	}
	mut var_taxonomy := rt.call_function('get_taxonomy', [
		var_content_struct.array_get(rt.new_string('taxonomy')),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.get_property(rt.get_property(var_taxonomy, 'cap'), 'edit_terms'),
	])))))
	{
		return (create_ixr_error(rt.new_int(401), rt.call_function('__', [
			rt.new_string('Sorry, you are not allowed to create terms in this taxonomy.'),
		]))).str()
	}
	var_taxonomy = rt.cast_array(var_taxonomy)
	mut var_term_data := []rt.PhpVal{}
	var_term_data['name'] =
		rt.new_string(var_content_struct.array_get(rt.new_string('name')).to_string().trim_space())
	if !rt.is_true(var_term_data['name']) {
		return (create_ixr_error(rt.new_int(403), rt.call_function('__', [
			rt.new_string('The term name cannot be empty.'),
		]))).str()
	}
	if var_content_struct.array_isset(rt.new_string('parent')) {
		if rt.is_true(rt.new_bool(!(rt.is_true(var_taxonomy.array_get(rt.new_string('hierarchical')))))) {
			return (create_ixr_error(rt.new_int(403), rt.call_function('__', [
				rt.new_string('This taxonomy is not hierarchical.'),
			]))).str()
		}
		mut var_parent_term_id :=
			rt.new_int((var_content_struct.array_get(rt.new_string('parent'))).to_i64())
		mut var_parent_term := rt.call_function('get_term', [
			var_parent_term_id.clone(), var_taxonomy.array_get(rt.new_string('name'))])
		if rt.is_true(rt.call_function('is_wp_error', [var_parent_term.clone()])) {
			return (create_ixr_error(rt.new_int(500), rt.call_method(var_parent_term,
				'get_error_message', []rt.PhpVal{}))).str()
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(var_parent_term)))) {
			return (create_ixr_error(rt.new_int(403), rt.call_function('__', [
				rt.new_string('Parent term does not exist.'),
			]))).str()
		}
		var_term_data['parent'] = var_content_struct.array_get(rt.new_string('parent'))
	}
	if var_content_struct.array_isset(rt.new_string('description')) {
		var_term_data['description'] = var_content_struct.array_get(rt.new_string('description'))
	}
	if var_content_struct.array_isset(rt.new_string('slug')) {
		var_term_data['slug'] = var_content_struct.array_get(rt.new_string('slug'))
	}
	mut var_term := rt.call_function('wp_insert_term', [var_term_data['name'],
		var_taxonomy.array_get(rt.new_string('name')), rt.create_array_from_native_map(var_term_data)])
	if rt.is_true(rt.call_function('is_wp_error', [var_term.clone()])) {
		return (create_ixr_error(rt.new_int(500), rt.call_method(var_term, 'get_error_message',
			[]rt.PhpVal{}))).str()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_term)))) {
		return (create_ixr_error(rt.new_int(500), rt.call_function('__', [
			rt.new_string('Sorry, the term could not be created.'),
		]))).str()
	}
	if var_content_struct.array_isset(rt.new_string('custom_fields')) {
		this.set_term_custom_fields(var_term.array_get(rt.new_string('term_id')),
			var_content_struct.array_get(rt.new_string('custom_fields')))
	}
	return (var_term.array_get(rt.new_string('term_id'))).str()
}

fn (mut this Class_wp_xmlrpc_server) wp_editterm(var_args rt.PhpVal) bool {
	mut var_args_mutated := var_args
	if !(this.minimum_args(var_args_mutated.clone(), rt.new_int(5))) {
		return (this.error).to_bool()
	}
	this.escape(var_args_mutated.clone())
	mut var_username := var_args_mutated.array_get(rt.new_int(1))
	mut var_password := var_args_mutated.array_get(rt.new_int(2))
	mut var_term_id := rt.new_int((var_args_mutated.array_get(rt.new_int(3))).to_i64())
	mut var_content_struct := var_args_mutated.array_get(rt.new_int(4))
	mut var_user := rt.new_bool(this.login(var_username.clone(), var_password.clone()))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_user)))) {
		return (this.error).to_bool()
	}
	rt.call_function('do_action', [rt.new_string('xmlrpc_call'),
		rt.new_string('wp.editTerm'), var_args_mutated.clone(),
		rt.new_object('wp_xmlrpc_server', ['IXR_Server'], &this)])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('taxonomy_exists', [
		var_content_struct.array_get(rt.new_string('taxonomy')),
	])))))
	{
		return (create_ixr_error(rt.new_int(403), rt.call_function('__', [
			rt.new_string('Invalid taxonomy.'),
		]))).to_bool()
	}
	mut var_taxonomy := rt.call_function('get_taxonomy', [
		var_content_struct.array_get(rt.new_string('taxonomy')),
	])
	var_taxonomy = rt.cast_array(var_taxonomy)
	mut var_term_data := []rt.PhpVal{}
	mut var_term := rt.call_function('get_term', [var_term_id.clone(),
		var_content_struct.array_get(rt.new_string('taxonomy'))])
	if rt.is_true(rt.call_function('is_wp_error', [var_term.clone()])) {
		return (create_ixr_error(rt.new_int(500), rt.call_method(var_term, 'get_error_message',
			[]rt.PhpVal{}))).to_bool()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_term)))) {
		return (create_ixr_error(rt.new_int(404), rt.call_function('__', [
			rt.new_string('Invalid term ID.'),
		]))).to_bool()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('edit_term'),
		var_term_id.clone(),
	])))))
	{
		return (create_ixr_error(rt.new_int(401), rt.call_function('__', [
			rt.new_string('Sorry, you are not allowed to edit this term.'),
		]))).to_bool()
	}
	if var_content_struct.array_isset(rt.new_string('name')) {
		var_term_data['name'] =
			rt.new_string(var_content_struct.array_get(rt.new_string('name')).to_string().trim_space())
		if !rt.is_true(var_term_data['name']) {
			return (create_ixr_error(rt.new_int(403), rt.call_function('__', [
				rt.new_string('The term name cannot be empty.'),
			]))).to_bool()
		}
	}
	if !(!rt.is_true(var_content_struct.array_get(rt.new_string('parent')))) {
		if rt.is_true(rt.new_bool(!(rt.is_true(var_taxonomy.array_get(rt.new_string('hierarchical')))))) {
			return (create_ixr_error(rt.new_int(403), rt.call_function('__', [
				rt.new_string('Cannot set parent term, taxonomy is not hierarchical.'),
			]))).to_bool()
		}
		mut var_parent_term_id :=
			rt.new_int((var_content_struct.array_get(rt.new_string('parent'))).to_i64())
		mut var_parent_term := rt.call_function('get_term', [
			var_parent_term_id.clone(), var_taxonomy.array_get(rt.new_string('name'))])
		if rt.is_true(rt.call_function('is_wp_error', [var_parent_term.clone()])) {
			return (create_ixr_error(rt.new_int(500), rt.call_method(var_parent_term,
				'get_error_message', []rt.PhpVal{}))).to_bool()
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(var_parent_term)))) {
			return (create_ixr_error(rt.new_int(403), rt.call_function('__', [
				rt.new_string('Parent term does not exist.'),
			]))).to_bool()
		}
		var_term_data['parent'] = var_content_struct.array_get(rt.new_string('parent'))
	}
	if var_content_struct.array_isset(rt.new_string('description')) {
		var_term_data['description'] = var_content_struct.array_get(rt.new_string('description'))
	}
	if var_content_struct.array_isset(rt.new_string('slug')) {
		var_term_data['slug'] = var_content_struct.array_get(rt.new_string('slug'))
	}
	var_term = rt.call_function('wp_update_term', [var_term_id.clone(),
		var_taxonomy.array_get(rt.new_string('name')), rt.create_array_from_native_map(var_term_data)])
	if rt.is_true(rt.call_function('is_wp_error', [var_term.clone()])) {
		return (create_ixr_error(rt.new_int(500), rt.call_method(var_term, 'get_error_message',
			[]rt.PhpVal{}))).to_bool()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_term)))) {
		return (create_ixr_error(rt.new_int(500), rt.call_function('__', [
			rt.new_string('Sorry, editing the term failed.'),
		]))).to_bool()
	}
	if var_content_struct.array_isset(rt.new_string('custom_fields')) {
		this.set_term_custom_fields(var_term_id.clone(),
			var_content_struct.array_get(rt.new_string('custom_fields')))
	}
	return true
}

fn (mut this Class_wp_xmlrpc_server) wp_deleteterm(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
	if !(this.minimum_args(var_args_mutated.clone(), rt.new_int(5))) {
		return this.error
	}
	this.escape(var_args_mutated.clone())
	mut var_username := var_args_mutated.array_get(rt.new_int(1))
	mut var_password := var_args_mutated.array_get(rt.new_int(2))
	mut var_taxonomy := var_args_mutated.array_get(rt.new_int(3))
	mut var_term_id := rt.new_int((var_args_mutated.array_get(rt.new_int(4))).to_i64())
	mut var_user := rt.new_bool(this.login(var_username.clone(), var_password.clone()))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_user)))) {
		return this.error
	}
	rt.call_function('do_action', [rt.new_string('xmlrpc_call'),
		rt.new_string('wp.deleteTerm'), var_args_mutated.clone(),
		rt.new_object('wp_xmlrpc_server', ['IXR_Server'], &this)])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('taxonomy_exists', [
		var_taxonomy.clone(),
	])))))
	{
		return rt.new_object('IXR_Error', []string{}, create_ixr_error(rt.new_int(403), rt.call_function('__', [
			rt.new_string('Invalid taxonomy.'),
		])))
	}
	var_taxonomy = rt.call_function('get_taxonomy', [var_taxonomy.clone()])
	mut var_term := rt.call_function('get_term', [var_term_id.clone(),
		rt.get_property(var_taxonomy, 'name')])
	if rt.is_true(rt.call_function('is_wp_error', [var_term.clone()])) {
		return rt.new_object('IXR_Error', []string{}, create_ixr_error(rt.new_int(500), rt.call_method(var_term,
			'get_error_message', []rt.PhpVal{})))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_term)))) {
		return rt.new_object('IXR_Error', []string{}, create_ixr_error(rt.new_int(404), rt.call_function('__', [
			rt.new_string('Invalid term ID.'),
		])))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('delete_term'),
		var_term_id.clone(),
	])))))
	{
		return rt.new_object('IXR_Error', []string{}, create_ixr_error(rt.new_int(401), rt.call_function('__', [
			rt.new_string('Sorry, you are not allowed to delete this term.'),
		])))
	}
	mut var_result := rt.call_function('wp_delete_term', [var_term_id.clone(),
		rt.get_property(var_taxonomy, 'name')])
	if rt.is_true(rt.call_function('is_wp_error', [var_result.clone()])) {
		return rt.new_object('IXR_Error', []string{}, create_ixr_error(rt.new_int(500), rt.call_method(var_result,
			'get_error_message', []rt.PhpVal{})))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_result)))) {
		return rt.new_object('IXR_Error', []string{}, create_ixr_error(rt.new_int(500), rt.call_function('__', [
			rt.new_string('Sorry, deleting the term failed.'),
		])))
	}
	return var_result.clone()
}

fn (mut this Class_wp_xmlrpc_server) wp_getterm(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
	if !(this.minimum_args(var_args_mutated.clone(), rt.new_int(5))) {
		return this.error
	}
	this.escape(var_args_mutated.clone())
	mut var_username := var_args_mutated.array_get(rt.new_int(1))
	mut var_password := var_args_mutated.array_get(rt.new_int(2))
	mut var_taxonomy := var_args_mutated.array_get(rt.new_int(3))
	mut var_term_id := rt.new_int((var_args_mutated.array_get(rt.new_int(4))).to_i64())
	mut var_user := rt.new_bool(this.login(var_username.clone(), var_password.clone()))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_user)))) {
		return this.error
	}
	rt.call_function('do_action', [rt.new_string('xmlrpc_call'),
		rt.new_string('wp.getTerm'), var_args_mutated.clone(),
		rt.new_object('wp_xmlrpc_server', ['IXR_Server'], &this)])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('taxonomy_exists', [
		var_taxonomy.clone(),
	])))))
	{
		return rt.new_object('IXR_Error', []string{}, create_ixr_error(rt.new_int(403), rt.call_function('__', [
			rt.new_string('Invalid taxonomy.'),
		])))
	}
	var_taxonomy = rt.call_function('get_taxonomy', [var_taxonomy.clone()])
	mut var_term := rt.call_function('get_term', [var_term_id.clone(),
		rt.get_property(var_taxonomy, 'name'), rt.get_constant('ARRAY_A')])
	if rt.is_true(rt.call_function('is_wp_error', [var_term.clone()])) {
		return rt.new_object('IXR_Error', []string{}, create_ixr_error(rt.new_int(500), rt.call_method(var_term,
			'get_error_message', []rt.PhpVal{})))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_term)))) {
		return rt.new_object('IXR_Error', []string{}, create_ixr_error(rt.new_int(404), rt.call_function('__', [
			rt.new_string('Invalid term ID.'),
		])))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('assign_term'),
		var_term_id.clone(),
	])))))
	{
		return rt.new_object('IXR_Error', []string{}, create_ixr_error(rt.new_int(401), rt.call_function('__', [
			rt.new_string('Sorry, you are not allowed to assign this term.'),
		])))
	}
	return this._prepare_term(var_term.clone())
}

fn (mut this Class_wp_xmlrpc_server) wp_getterms(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
	if !(this.minimum_args(var_args_mutated.clone(), rt.new_int(4))) {
		return this.error
	}
	this.escape(var_args_mutated.clone())
	mut var_username := var_args_mutated.array_get(rt.new_int(1))
	mut var_password := var_args_mutated.array_get(rt.new_int(2))
	mut var_taxonomy := var_args_mutated.array_get(rt.new_int(3))
	mut var_filter := if !(var_args_mutated.array_get(rt.new_int(4))).is_null() {
		var_args_mutated.array_get(rt.new_int(4))
	} else {
		[]rt.PhpVal{}
	}
	mut var_user := rt.new_bool(this.login(var_username.clone(), var_password.clone()))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_user)))) {
		return this.error
	}
	rt.call_function('do_action', [rt.new_string('xmlrpc_call'),
		rt.new_string('wp.getTerms'), var_args_mutated.clone(),
		rt.new_object('wp_xmlrpc_server', ['IXR_Server'], &this)])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('taxonomy_exists', [
		var_taxonomy.clone(),
	])))))
	{
		return create_ixr_error(rt.new_int(403), rt.call_function('__', [
			rt.new_string('Invalid taxonomy.'),
		]))
	}
	var_taxonomy = rt.call_function('get_taxonomy', [var_taxonomy.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.get_property(rt.get_property(var_taxonomy, 'cap'), 'assign_terms'),
	])))))
	{
		return create_ixr_error(rt.new_int(401), rt.call_function('__', [
			rt.new_string('Sorry, you are not allowed to assign terms in this taxonomy.'),
		]))
	}
	mut var_query := {
		'taxonomy': rt.get_property(var_taxonomy, 'name')
	}
	if var_filter.array_isset(rt.new_string('number')) {
		var_query['number'] = rt.call_function('absint', [
			var_filter.array_get(rt.new_string('number')),
		])
	}
	if var_filter.array_isset(rt.new_string('offset')) {
		var_query['offset'] = rt.call_function('absint', [
			var_filter.array_get(rt.new_string('offset')),
		])
	}
	if var_filter.array_isset(rt.new_string('orderby')) {
		var_query['orderby'] = var_filter.array_get(rt.new_string('orderby'))
		if var_filter.array_isset(rt.new_string('order')) {
			var_query['order'] = var_filter.array_get(rt.new_string('order'))
		}
	}
	if var_filter.array_isset(rt.new_string('hide_empty')) {
		var_query['hide_empty'] = var_filter.array_get(rt.new_string('hide_empty'))
	} else {
		var_query['get'] = rt.new_string('all')
	}
	if var_filter.array_isset(rt.new_string('search')) {
		var_query['search'] = var_filter.array_get(rt.new_string('search'))
	}
	mut var_terms := rt.call_function('get_terms', [
		rt.create_array_from_native_map(var_query),
	])
	if rt.is_true(rt.call_function('is_wp_error', [var_terms.clone()])) {
		return create_ixr_error(rt.new_int(500), rt.call_method(var_terms, 'get_error_message',
			[]rt.PhpVal{}))
	}
	mut var_struct := []rt.PhpVal{}
	mut iter_14 := var_terms.iterator()
	for {
		item_14 := iter_14.next() or { break }
		mut var_term := item_14.val
		var_struct.array_push(this._prepare_term(var_term.clone()))
	}
	return var_struct.clone()
}

fn (mut this Class_wp_xmlrpc_server) wp_gettaxonomy(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
	if !(this.minimum_args(var_args_mutated.clone(), rt.new_int(4))) {
		return this.error
	}
	this.escape(var_args_mutated.clone())
	mut var_username := var_args_mutated.array_get(rt.new_int(1))
	mut var_password := var_args_mutated.array_get(rt.new_int(2))
	mut var_taxonomy := var_args_mutated.array_get(rt.new_int(3))
	if var_args_mutated.array_isset(rt.new_int(4)) {
		mut var_fields := var_args_mutated.array_get(rt.new_int(4))
	} else {
		var_fields = rt.call_function('apply_filters', [
			rt.new_string('xmlrpc_default_taxonomy_fields'),
			rt.create_array([rt.ArrayItem{ key: none, val: 'labels' },
				rt.ArrayItem{ key: none, val: 'cap' }, rt.ArrayItem{ key: none, val: 'object_type' }]),
			rt.new_string('wp.getTaxonomy'),
		])
	}
	mut var_user := rt.new_bool(this.login(var_username.clone(), var_password.clone()))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_user)))) {
		return this.error
	}
	rt.call_function('do_action', [rt.new_string('xmlrpc_call'),
		rt.new_string('wp.getTaxonomy'), var_args_mutated.clone(),
		rt.new_object('wp_xmlrpc_server', ['IXR_Server'], &this)])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('taxonomy_exists', [
		var_taxonomy.clone(),
	])))))
	{
		return rt.new_object('IXR_Error', []string{}, create_ixr_error(rt.new_int(403), rt.call_function('__', [
			rt.new_string('Invalid taxonomy.'),
		])))
	}
	var_taxonomy = rt.call_function('get_taxonomy', [var_taxonomy.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.get_property(rt.get_property(var_taxonomy, 'cap'), 'assign_terms'),
	])))))
	{
		return rt.new_object('IXR_Error', []string{}, create_ixr_error(rt.new_int(401), rt.call_function('__', [
			rt.new_string('Sorry, you are not allowed to assign terms in this taxonomy.'),
		])))
	}
	return this._prepare_taxonomy(var_taxonomy.clone(), var_fields.clone())
}

fn (mut this Class_wp_xmlrpc_server) wp_gettaxonomies(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
	if !(this.minimum_args(var_args_mutated.clone(), rt.new_int(3))) {
		return this.error
	}
	this.escape(var_args_mutated.clone())
	mut var_username := var_args_mutated.array_get(rt.new_int(1))
	mut var_password := var_args_mutated.array_get(rt.new_int(2))
	mut var_filter := if !(var_args_mutated.array_get(rt.new_int(3))).is_null() { var_args_mutated.array_get(rt.new_int(3)) } else { rt.create_array([
			rt.ArrayItem{ key: 'public', val: true },
		]) }
	if var_args_mutated.array_isset(rt.new_int(4)) {
		mut var_fields := var_args_mutated.array_get(rt.new_int(4))
	} else {
		var_fields = rt.call_function('apply_filters', [
			rt.new_string('xmlrpc_default_taxonomy_fields'),
			rt.create_array([rt.ArrayItem{ key: none, val: 'labels' },
				rt.ArrayItem{ key: none, val: 'cap' }, rt.ArrayItem{ key: none, val: 'object_type' }]),
			rt.new_string('wp.getTaxonomies'),
		])
	}
	mut var_user := rt.new_bool(this.login(var_username.clone(), var_password.clone()))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_user)))) {
		return this.error
	}
	rt.call_function('do_action', [rt.new_string('xmlrpc_call'),
		rt.new_string('wp.getTaxonomies'), var_args_mutated.clone(),
		rt.new_object('wp_xmlrpc_server', ['IXR_Server'], &this)])
	mut var_taxonomies := rt.call_function('get_taxonomies', [
		var_filter.clone(), rt.new_string('objects')])
	mut var_struct := []rt.PhpVal{}
	mut iter_15 := var_taxonomies.iterator()
	for {
		item_15 := iter_15.next() or { break }
		mut var_taxonomy := item_15.val
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
			rt.get_property(rt.get_property(var_taxonomy, 'cap'), 'assign_terms'),
		])))))
		{
			continue
		}
		var_struct.array_push(this._prepare_taxonomy(var_taxonomy.clone(), var_fields.clone()))
	}
	return var_struct.clone()
}

fn (mut this Class_wp_xmlrpc_server) wp_getuser(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
	if !(this.minimum_args(var_args_mutated.clone(), rt.new_int(4))) {
		return this.error
	}
	this.escape(var_args_mutated.clone())
	mut var_username := var_args_mutated.array_get(rt.new_int(1))
	mut var_password := var_args_mutated.array_get(rt.new_int(2))
	mut var_user_id := rt.new_int((var_args_mutated.array_get(rt.new_int(3))).to_i64())
	if var_args_mutated.array_isset(rt.new_int(4)) {
		mut var_fields := var_args_mutated.array_get(rt.new_int(4))
	} else {
		var_fields = rt.call_function('apply_filters', [
			rt.new_string('xmlrpc_default_user_fields'),
			rt.create_array([rt.ArrayItem{ key: none, val: 'all' }]),
			rt.new_string('wp.getUser'),
		])
	}
	mut var_user := rt.new_bool(this.login(var_username.clone(), var_password.clone()))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_user)))) {
		return this.error
	}
	rt.call_function('do_action', [rt.new_string('xmlrpc_call'),
		rt.new_string('wp.getUser'), var_args_mutated.clone(),
		rt.new_object('wp_xmlrpc_server', ['IXR_Server'], &this)])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('edit_user'),
		var_user_id.clone(),
	])))))
	{
		return rt.new_object('IXR_Error', []string{}, create_ixr_error(rt.new_int(401), rt.call_function('__', [
			rt.new_string('Sorry, you are not allowed to edit this user.'),
		])))
	}
	mut var_user_data := rt.call_function('get_userdata', [var_user_id.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_user_data)))) {
		return rt.new_object('IXR_Error', []string{}, create_ixr_error(rt.new_int(404), rt.call_function('__', [
			rt.new_string('Invalid user ID.'),
		])))
	}
	return this._prepare_user(var_user_data.clone(), var_fields.clone())
}

fn (mut this Class_wp_xmlrpc_server) wp_getusers(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
	if !(this.minimum_args(var_args_mutated.clone(), rt.new_int(3))) {
		return this.error
	}
	this.escape(var_args_mutated.clone())
	mut var_username := var_args_mutated.array_get(rt.new_int(1))
	mut var_password := var_args_mutated.array_get(rt.new_int(2))
	mut var_filter := if !(var_args_mutated.array_get(rt.new_int(3))).is_null() {
		var_args_mutated.array_get(rt.new_int(3))
	} else {
		[]rt.PhpVal{}
	}
	if var_args_mutated.array_isset(rt.new_int(4)) {
		mut var_fields := var_args_mutated.array_get(rt.new_int(4))
	} else {
		var_fields = rt.call_function('apply_filters', [
			rt.new_string('xmlrpc_default_user_fields'),
			rt.create_array([rt.ArrayItem{ key: none, val: 'all' }]),
			rt.new_string('wp.getUsers'),
		])
	}
	mut var_user := rt.new_bool(this.login(var_username.clone(), var_password.clone()))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_user)))) {
		return this.error
	}
	rt.call_function('do_action', [rt.new_string('xmlrpc_call'),
		rt.new_string('wp.getUsers'), var_args_mutated.clone(),
		rt.new_object('wp_xmlrpc_server', ['IXR_Server'], &this)])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('list_users'),
	])))))
	{
		return create_ixr_error(rt.new_int(401), rt.call_function('__', [
			rt.new_string('Sorry, you are not allowed to list users.'),
		]))
	}
	mut var_query := {
		'fields': rt.new_string('all_with_meta')
	}
	var_query['number'] = if var_filter.array_isset(rt.new_string('number')) { rt.call_function('absint', [
			var_filter.array_get(rt.new_string('number')),
		]) } else { rt.new_int(50) }
	var_query['offset'] = if var_filter.array_isset(rt.new_string('offset')) { rt.call_function('absint', [
			var_filter.array_get(rt.new_string('offset')),
		]) } else { rt.new_int(0) }
	if var_filter.array_isset(rt.new_string('orderby')) {
		var_query['orderby'] = var_filter.array_get(rt.new_string('orderby'))
		if var_filter.array_isset(rt.new_string('order')) {
			var_query['order'] = var_filter.array_get(rt.new_string('order'))
		}
	}
	if var_filter.array_isset(rt.new_string('role')) {
		if rt.is_true(rt.identical(rt.call_function('get_role', [
			var_filter.array_get(rt.new_string('role')),
		]), rt.new_null()))
		{
			return create_ixr_error(rt.new_int(403), rt.call_function('__', [
				rt.new_string('Invalid role.'),
			]))
		}
		var_query['role'] = var_filter.array_get(rt.new_string('role'))
	}
	if var_filter.array_isset(rt.new_string('who')) {
		var_query['who'] = var_filter.array_get(rt.new_string('who'))
	}
	mut var_users := rt.call_function('get_users', [
		rt.create_array_from_native_map(var_query),
	])
	mut var__users := []rt.PhpVal{}
	mut iter_16 := var_users.iterator()
	for {
		item_16 := iter_16.next() or { break }
		mut var_user_data := item_16.val
		if rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_user'),
			rt.get_property(var_user_data, 'ID')]))
		{
			var__users << this._prepare_user(var_user_data.clone(), var_fields.clone())
		}
	}
	return var__users.clone()
}

fn (mut this Class_wp_xmlrpc_server) wp_getprofile(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
	if !(this.minimum_args(var_args_mutated.clone(), rt.new_int(3))) {
		return this.error
	}
	this.escape(var_args_mutated.clone())
	mut var_username := var_args_mutated.array_get(rt.new_int(1))
	mut var_password := var_args_mutated.array_get(rt.new_int(2))
	if var_args_mutated.array_isset(rt.new_int(3)) {
		mut var_fields := var_args_mutated.array_get(rt.new_int(3))
	} else {
		var_fields = rt.call_function('apply_filters', [
			rt.new_string('xmlrpc_default_user_fields'),
			rt.create_array([rt.ArrayItem{ key: none, val: 'all' }]),
			rt.new_string('wp.getProfile'),
		])
	}
	mut var_user := rt.new_bool(this.login(var_username.clone(), var_password.clone()))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_user)))) {
		return this.error
	}
	rt.call_function('do_action', [rt.new_string('xmlrpc_call'),
		rt.new_string('wp.getProfile'), var_args_mutated.clone(),
		rt.new_object('wp_xmlrpc_server', ['IXR_Server'], &this)])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('edit_user'),
		rt.get_property(var_user, 'ID'),
	])))))
	{
		return rt.new_object('IXR_Error', []string{}, create_ixr_error(rt.new_int(401), rt.call_function('__', [
			rt.new_string('Sorry, you are not allowed to edit your profile.'),
		])))
	}
	mut var_user_data := rt.call_function('get_userdata', [
		rt.get_property(var_user, 'ID'),
	])
	return this._prepare_user(var_user_data.clone(), var_fields.clone())
}

fn (mut this Class_wp_xmlrpc_server) wp_editprofile(var_args rt.PhpVal) bool {
	mut var_args_mutated := var_args
	if !(this.minimum_args(var_args_mutated.clone(), rt.new_int(4))) {
		return (this.error).to_bool()
	}
	this.escape(var_args_mutated.clone())
	mut var_username := var_args_mutated.array_get(rt.new_int(1))
	mut var_password := var_args_mutated.array_get(rt.new_int(2))
	mut var_content_struct := var_args_mutated.array_get(rt.new_int(3))
	mut var_user := rt.new_bool(this.login(var_username.clone(), var_password.clone()))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_user)))) {
		return (this.error).to_bool()
	}
	rt.call_function('do_action', [rt.new_string('xmlrpc_call'),
		rt.new_string('wp.editProfile'), var_args_mutated.clone(),
		rt.new_object('wp_xmlrpc_server', ['IXR_Server'], &this)])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('edit_user'),
		rt.get_property(var_user, 'ID'),
	])))))
	{
		return (create_ixr_error(rt.new_int(401), rt.call_function('__', [
			rt.new_string('Sorry, you are not allowed to edit your profile.'),
		]))).to_bool()
	}
	mut var_user_data := []rt.PhpVal{}
	var_user_data.array_set('ID', rt.get_property(var_user, 'ID'))
	if var_content_struct.array_isset(rt.new_string('first_name')) {
		var_user_data.array_set('first_name',
			var_content_struct.array_get(rt.new_string('first_name')))
	}
	if var_content_struct.array_isset(rt.new_string('last_name')) {
		var_user_data.array_set('last_name',
			var_content_struct.array_get(rt.new_string('last_name')))
	}
	if var_content_struct.array_isset(rt.new_string('url')) {
		var_user_data.array_set('user_url', var_content_struct.array_get(rt.new_string('url')))
	}
	if var_content_struct.array_isset(rt.new_string('display_name')) {
		var_user_data.array_set('display_name',
			var_content_struct.array_get(rt.new_string('display_name')))
	}
	if var_content_struct.array_isset(rt.new_string('nickname')) {
		var_user_data.array_set('nickname', var_content_struct.array_get(rt.new_string('nickname')))
	}
	if var_content_struct.array_isset(rt.new_string('nicename')) {
		var_user_data.array_set('user_nicename',
			var_content_struct.array_get(rt.new_string('nicename')))
	}
	if var_content_struct.array_isset(rt.new_string('bio')) {
		var_user_data.array_set('description', var_content_struct.array_get(rt.new_string('bio')))
	}
	mut var_result := rt.call_function('wp_update_user', [var_user_data.clone()])
	if rt.is_true(rt.call_function('is_wp_error', [var_result.clone()])) {
		return (create_ixr_error(rt.new_int(500), rt.call_method(var_result, 'get_error_message',
			[]rt.PhpVal{}))).to_bool()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_result)))) {
		return (create_ixr_error(rt.new_int(500), rt.call_function('__', [
			rt.new_string('Sorry, the user could not be updated.'),
		]))).to_bool()
	}
	return true
}

fn (mut this Class_wp_xmlrpc_server) wp_getpage(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
	this.escape(var_args_mutated.clone())
	mut var_page_id := rt.new_int((var_args_mutated.array_get(rt.new_int(1))).to_i64())
	mut var_username := var_args_mutated.array_get(rt.new_int(2))
	mut var_password := var_args_mutated.array_get(rt.new_int(3))
	mut var_user := rt.new_bool(this.login(var_username.clone(), var_password.clone()))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_user)))) {
		return this.error
	}
	mut var_page := rt.call_function('get_post', [var_page_id.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_page)))) {
		return rt.new_object('IXR_Error', []string{}, create_ixr_error(rt.new_int(404), rt.call_function('__', [
			rt.new_string('Invalid post ID.'),
		])))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('edit_page'),
		var_page_id.clone(),
	])))))
	{
		return rt.new_object('IXR_Error', []string{}, create_ixr_error(rt.new_int(401), rt.call_function('__', [
			rt.new_string('Sorry, you are not allowed to edit this page.'),
		])))
	}
	rt.call_function('do_action', [rt.new_string('xmlrpc_call'),
		rt.new_string('wp.getPage'), var_args_mutated.clone(),
		rt.new_object('wp_xmlrpc_server', ['IXR_Server'], &this)])
	if rt.is_true(rt.get_property(var_page, 'ID'))
		&& rt.is_true(rt.identical(rt.new_string('page'), rt.get_property(var_page, 'post_type'))) {
		return this._prepare_page(var_page.clone())
	} else {
		return rt.new_object('IXR_Error', []string{}, create_ixr_error(rt.new_int(404), rt.call_function('__', [
			rt.new_string('Sorry, no such page.'),
		])))
	}
	return rt.new_null()
}

fn (mut this Class_wp_xmlrpc_server) wp_getpages(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
	this.escape(var_args_mutated.clone())
	mut var_username := var_args_mutated.array_get(rt.new_int(1))
	mut var_password := var_args_mutated.array_get(rt.new_int(2))
	mut var_num_pages := rt.new_int(if var_args_mutated.array_isset(rt.new_int(3)) {
		rt.new_int((var_args_mutated.array_get(rt.new_int(3))).to_i64())
	} else {
		10
	})
	mut var_user := rt.new_bool(this.login(var_username.clone(), var_password.clone()))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_user)))) {
		return this.error
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('edit_pages'),
	])))))
	{
		return rt.new_object('IXR_Error', []string{}, create_ixr_error(rt.new_int(401), rt.call_function('__', [
			rt.new_string('Sorry, you are not allowed to edit pages.'),
		])))
	}
	rt.call_function('do_action', [rt.new_string('xmlrpc_call'),
		rt.new_string('wp.getPages'), var_args_mutated.clone(),
		rt.new_object('wp_xmlrpc_server', ['IXR_Server'], &this)])
	mut var_pages := rt.call_function('get_posts', [
		rt.create_array([rt.ArrayItem{ key: 'post_type', val: 'page' },
			rt.ArrayItem{ key: 'post_status', val: 'any' }, rt.ArrayItem{
				key: 'numberposts'
				val: var_num_pages
			}]),
	])
	var_num_pages = rt.new_int(var_pages.clone().array_count())
	if rt.is_true(rt.greater_equal(var_num_pages, rt.new_int(1))) {
		mut var_pages_struct := []rt.PhpVal{}
		mut iter_17 := var_pages.iterator()
		for {
			item_17 := iter_17.next() or { break }
			mut var_page := item_17.val
			if rt.is_true(rt.call_function('current_user_can', [
				rt.new_string('edit_page'),
				rt.get_property(var_page, 'ID'),
			]))
			{
				var_pages_struct << this._prepare_page(var_page.clone())
			}
		}
		return var_pages_struct.clone()
	}
	return []rt.PhpVal{}
}

fn (mut this Class_wp_xmlrpc_server) wp_newpage(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
	mut var_username := this.escape(var_args_mutated.array_get(rt.new_int(1)))
	mut var_password := this.escape(var_args_mutated.array_get(rt.new_int(2)))
	mut var_user := rt.new_bool(this.login(var_username.clone(), var_password.clone()))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_user)))) {
		return this.error
	}
	rt.call_function('do_action', [rt.new_string('xmlrpc_call'),
		rt.new_string('wp.newPage'), var_args_mutated.clone(),
		rt.new_object('wp_xmlrpc_server', ['IXR_Server'], &this)])
	var_args_mutated.array_get_mut(3).array_set('post_type', 'page')
	return rt.new_string(this.mw_newpost(var_args_mutated.clone()))
}

fn (mut this Class_wp_xmlrpc_server) wp_deletepage(var_args rt.PhpVal) bool {
	mut var_args_mutated := var_args
	this.escape(var_args_mutated.clone())
	mut var_username := var_args_mutated.array_get(rt.new_int(1))
	mut var_password := var_args_mutated.array_get(rt.new_int(2))
	mut var_page_id := rt.new_int((var_args_mutated.array_get(rt.new_int(3))).to_i64())
	mut var_user := rt.new_bool(this.login(var_username.clone(), var_password.clone()))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_user)))) {
		return (this.error).to_bool()
	}
	rt.call_function('do_action', [rt.new_string('xmlrpc_call'),
		rt.new_string('wp.deletePage'), var_args_mutated.clone(),
		rt.new_object('wp_xmlrpc_server', ['IXR_Server'], &this)])
	mut var_actual_page := rt.call_function('get_post', [var_page_id.clone(),
		rt.get_constant('ARRAY_A')])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_actual_page))))
		|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('page'), var_actual_page.array_get(rt.new_string('post_type')))))) {
		return (create_ixr_error(rt.new_int(404), rt.call_function('__', [
			rt.new_string('Sorry, no such page.'),
		]))).to_bool()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('delete_page'),
		var_page_id.clone(),
	])))))
	{
		return (create_ixr_error(rt.new_int(401), rt.call_function('__', [
			rt.new_string('Sorry, you are not allowed to delete this page.'),
		]))).to_bool()
	}
	mut var_result := rt.call_function('wp_delete_post', [var_page_id.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_result)))) {
		return (create_ixr_error(rt.new_int(500), rt.call_function('__', [
			rt.new_string('Failed to delete the page.'),
		]))).to_bool()
	}
	rt.call_function('do_action', [rt.new_string('xmlrpc_call_success_wp_deletePage'),
		var_page_id.clone(), var_args_mutated.clone()])
	return true
}

fn (mut this Class_wp_xmlrpc_server) wp_editpage(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
	mut var_page_id := rt.new_int((var_args_mutated.array_get(rt.new_int(1))).to_i64())
	mut var_username := var_args_mutated.array_get(rt.new_int(2))
	mut var_password := var_args_mutated.array_get(rt.new_int(3))
	mut var_content := var_args_mutated.array_get(rt.new_int(4))
	mut var_publish := var_args_mutated.array_get(rt.new_int(5))
	mut var_escaped_username := this.escape(var_username.clone())
	mut var_escaped_password := this.escape(var_password.clone())
	mut var_user := rt.new_bool(this.login(var_escaped_username.clone(),
		var_escaped_password.clone()))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_user)))) {
		return this.error
	}
	rt.call_function('do_action', [rt.new_string('xmlrpc_call'),
		rt.new_string('wp.editPage'), var_args_mutated.clone(),
		rt.new_object('wp_xmlrpc_server', ['IXR_Server'], &this)])
	mut var_actual_page := rt.call_function('get_post', [var_page_id.clone(),
		rt.get_constant('ARRAY_A')])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_actual_page))))
		|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('page'), var_actual_page.array_get(rt.new_string('post_type')))))) {
		return rt.new_object('IXR_Error', []string{}, create_ixr_error(rt.new_int(404), rt.call_function('__', [
			rt.new_string('Sorry, no such page.'),
		])))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('edit_page'),
		var_page_id.clone(),
	])))))
	{
		return rt.new_object('IXR_Error', []string{}, create_ixr_error(rt.new_int(401), rt.call_function('__', [
			rt.new_string('Sorry, you are not allowed to edit this page.'),
		])))
	}
	var_content.array_set('post_type', 'page')
	var_args_mutated = rt.create_array([rt.ArrayItem{ key: none, val: var_page_id },
		rt.ArrayItem{ key: none, val: var_username }, rt.ArrayItem{ key: none, val: var_password },
		rt.ArrayItem{ key: none, val: var_content }, rt.ArrayItem{ key: none, val: var_publish }])
	return rt.new_bool(this.mw_editpost(var_args_mutated.clone()))
}

fn (mut this Class_wp_xmlrpc_server) wp_getpagelist(var_args rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_args_mutated := var_args
	this.escape(var_args_mutated.clone())
	mut var_username := var_args_mutated.array_get(rt.new_int(1))
	mut var_password := var_args_mutated.array_get(rt.new_int(2))
	mut var_user := rt.new_bool(this.login(var_username.clone(), var_password.clone()))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_user)))) {
		return this.error
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('edit_pages'),
	])))))
	{
		return rt.new_object('IXR_Error', []string{}, create_ixr_error(rt.new_int(401), rt.call_function('__', [
			rt.new_string('Sorry, you are not allowed to edit pages.'),
		])))
	}
	rt.call_function('do_action', [rt.new_string('xmlrpc_call'),
		rt.new_string('wp.getPageList'), var_args_mutated.clone(),
		rt.new_object('wp_xmlrpc_server', ['IXR_Server'], &this)])
	mut var_page_list := rt.call_method(var_wpdb, 'get_results', [
		rt.concat(rt.concat(rt.new_string('\n\t\t\tSELECT ID page_id,\n\t\t\t\tpost_title page_title,\n\t\t\t\tpost_parent page_parent_id,\n\t\t\t\tpost_date_gmt,\n\t\t\t\tpost_date,\n\t\t\t\tpost_status\n\t\t\tFROM '), rt.get_property(var_wpdb,
			'posts')), rt.new_string("\n\t\t\tWHERE post_type = 'page'\n\t\t\tORDER BY ID\n\t\t")),
	])
	mut var_num_pages := rt.new_int(var_page_list.clone().array_count())
	mut var_i := rt.new_int(0)
	for {
		if !(rt.is_true(rt.less(var_i, var_num_pages))) { break
		 }
		rt.set_property(var_page_list.array_get(var_i), 'dateCreated', this._convert_date(rt.get_property(var_page_list.array_get(var_i),
			'post_date')))
		rt.set_property(var_page_list.array_get(var_i), 'date_created_gmt', this._convert_date_gmt(rt.get_property(var_page_list.array_get(var_i),
			'post_date_gmt'), rt.get_property(var_page_list.array_get(var_i), 'post_date')))
		rt.get_property(var_page_list.array_get(var_i), 'post_date_gmt') = rt.new_null()
		rt.get_property(var_page_list.array_get(var_i), 'post_date') = rt.new_null()
		rt.get_property(var_page_list.array_get(var_i), 'post_status') = rt.new_null()
		rt.post_inc(var_i)
	}
	return var_page_list.clone()
}

fn (mut this Class_wp_xmlrpc_server) wp_getauthors(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
	this.escape(var_args_mutated.clone())
	mut var_username := var_args_mutated.array_get(rt.new_int(1))
	mut var_password := var_args_mutated.array_get(rt.new_int(2))
	mut var_user := rt.new_bool(this.login(var_username.clone(), var_password.clone()))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_user)))) {
		return this.error
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('edit_posts'),
	])))))
	{
		return create_ixr_error(rt.new_int(401), rt.call_function('__', [
			rt.new_string('Sorry, you are not allowed to edit posts.'),
		]))
	}
	rt.call_function('do_action', [rt.new_string('xmlrpc_call'),
		rt.new_string('wp.getAuthors'), var_args_mutated.clone(),
		rt.new_object('wp_xmlrpc_server', ['IXR_Server'], &this)])
	mut var_authors := []rt.PhpVal{}
	mut iter_18 := rt.call_function('get_users', [
		rt.create_array([
			rt.ArrayItem{ key: 'fields', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'ID' },
				rt.ArrayItem{ key: none, val: 'user_login' },
				rt.ArrayItem{ key: none, val: 'display_name' },
			]) },
		]),
	]).iterator()
	for {
		item_18 := iter_18.next() or { break }
		mut var_user_shadow := item_18.val
		var_authors << rt.create_array([
			rt.ArrayItem{ key: 'user_id', val: rt.get_property(var_user_shadow, 'ID') },
			rt.ArrayItem{ key: 'user_login', val: rt.get_property(var_user_shadow, 'user_login') },
			rt.ArrayItem{ key: 'display_name', val: rt.get_property(var_user_shadow, 'display_name') },
		])
	}
	return var_authors.clone()
}

fn (mut this Class_wp_xmlrpc_server) wp_gettags(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
	this.escape(var_args_mutated.clone())
	mut var_username := var_args_mutated.array_get(rt.new_int(1))
	mut var_password := var_args_mutated.array_get(rt.new_int(2))
	mut var_user := rt.new_bool(this.login(var_username.clone(), var_password.clone()))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_user)))) {
		return this.error
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('edit_posts'),
	])))))
	{
		return create_ixr_error(rt.new_int(401), rt.call_function('__', [
			rt.new_string('Sorry, you must be able to edit posts on this site in order to view tags.'),
		]))
	}
	rt.call_function('do_action', [rt.new_string('xmlrpc_call'),
		rt.new_string('wp.getKeywords'), var_args_mutated.clone(),
		rt.new_object('wp_xmlrpc_server', ['IXR_Server'], &this)])
	mut var_tags := []rt.PhpVal{}
	mut var_all_tags := rt.call_function('get_tags', []rt.PhpVal{})
	if rt.is_true(var_all_tags) {
		mut iter_19 := rt.cast_array(var_all_tags).iterator()
		for {
			item_19 := iter_19.next() or { break }
			mut var_tag := item_19.val
			mut var_struct := []rt.PhpVal{}
			var_struct.array_set('tag_id', rt.get_property(var_tag, 'term_id'))
			var_struct.array_set('name', rt.get_property(var_tag, 'name'))
			var_struct.array_set('count', rt.get_property(var_tag, 'count'))
			var_struct.array_set('slug', rt.get_property(var_tag, 'slug'))
			var_struct.array_set('html_url', rt.call_function('esc_html', [
				rt.call_function('get_tag_link', [rt.get_property(var_tag, 'term_id')]),
			]))
			var_struct.array_set('rss_url', rt.call_function('esc_html', [
				rt.call_function('get_tag_feed_link', [
					rt.get_property(var_tag, 'term_id'),
				]),
			]))
			var_tags.array_push(var_struct.clone())
		}
	}
	return var_tags.clone()
}

fn (mut this Class_wp_xmlrpc_server) wp_newcategory(var_args rt.PhpVal) i64 {
	mut var_args_mutated := var_args
	this.escape(var_args_mutated.clone())
	mut var_username := var_args_mutated.array_get(rt.new_int(1))
	mut var_password := var_args_mutated.array_get(rt.new_int(2))
	mut var_category := var_args_mutated.array_get(rt.new_int(3))
	mut var_user := rt.new_bool(this.login(var_username.clone(), var_password.clone()))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_user)))) {
		return (this.error).to_i64()
	}
	rt.call_function('do_action', [rt.new_string('xmlrpc_call'),
		rt.new_string('wp.newCategory'), var_args_mutated.clone(),
		rt.new_object('wp_xmlrpc_server', ['IXR_Server'], &this)])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('manage_categories'),
	])))))
	{
		return (create_ixr_error(rt.new_int(401), rt.call_function('__', [
			rt.new_string('Sorry, you are not allowed to add a category.'),
		]))).to_i64()
	}
	if !rt.is_true(var_category.array_get(rt.new_string('slug'))) {
		var_category.array_set('slug', '')
	}
	if !(var_category.array_isset(rt.new_string('parent_id'))) {
		var_category.array_set('parent_id', '')
	}
	if !rt.is_true(var_category.array_get(rt.new_string('description'))) {
		var_category.array_set('description', '')
	}
	mut var_new_category := {
		'cat_name':             var_category.array_get(rt.new_string('name'))
		'category_nicename':    var_category.array_get(rt.new_string('slug'))
		'category_parent':      var_category.array_get(rt.new_string('parent_id'))
		'category_description': var_category.array_get(rt.new_string('description'))
	}
	mut var_cat_id := rt.call_function('wp_insert_category', [
		rt.create_array_from_native_map(var_new_category),
		rt.new_bool(true),
	])
	if rt.is_true(rt.call_function('is_wp_error', [var_cat_id.clone()])) {
		if rt.is_true(rt.identical(rt.new_string('term_exists'), rt.call_method(var_cat_id,
			'get_error_code', []rt.PhpVal{})))
		{
			return rt.new_int((rt.call_method(var_cat_id, 'get_error_data', []rt.PhpVal{})).to_i64())
		} else {
			return (create_ixr_error(rt.new_int(500), rt.call_function('__', [
				rt.new_string('Sorry, the category could not be created.'),
			]))).to_i64()
		}
	} else if rt.is_true(rt.new_bool(!(rt.is_true(var_cat_id)))) {
		return (create_ixr_error(rt.new_int(500), rt.call_function('__', [
			rt.new_string('Sorry, the category could not be created.'),
		]))).to_i64()
	}
	rt.call_function('do_action', [rt.new_string('xmlrpc_call_success_wp_newCategory'),
		var_cat_id.clone(), var_args_mutated.clone()])
	return var_cat_id.to_i64()
}

fn (mut this Class_wp_xmlrpc_server) wp_deletecategory(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
	this.escape(var_args_mutated.clone())
	mut var_username := var_args_mutated.array_get(rt.new_int(1))
	mut var_password := var_args_mutated.array_get(rt.new_int(2))
	mut var_category_id := rt.new_int((var_args_mutated.array_get(rt.new_int(3))).to_i64())
	mut var_user := rt.new_bool(this.login(var_username.clone(), var_password.clone()))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_user)))) {
		return this.error
	}
	rt.call_function('do_action', [rt.new_string('xmlrpc_call'),
		rt.new_string('wp.deleteCategory'), var_args_mutated.clone(),
		rt.new_object('wp_xmlrpc_server', ['IXR_Server'], &this)])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('delete_term'),
		var_category_id.clone(),
	])))))
	{
		return rt.new_object('IXR_Error', []string{}, create_ixr_error(rt.new_int(401), rt.call_function('__', [
			rt.new_string('Sorry, you are not allowed to delete this category.'),
		])))
	}
	mut var_status := rt.call_function('wp_delete_term', [var_category_id.clone(),
		rt.new_string('category')])
	if rt.is_true(rt.identical(rt.new_bool(true), var_status)) {
		rt.call_function('do_action', [
			rt.new_string('xmlrpc_call_success_wp_deleteCategory'),
			var_category_id.clone(),
			var_args_mutated.clone(),
		])
	}
	return var_status.clone()
}

fn (mut this Class_wp_xmlrpc_server) wp_suggestcategories(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
	this.escape(var_args_mutated.clone())
	mut var_username := var_args_mutated.array_get(rt.new_int(1))
	mut var_password := var_args_mutated.array_get(rt.new_int(2))
	mut var_category := var_args_mutated.array_get(rt.new_int(3))
	mut var_max_results := rt.new_int((var_args_mutated.array_get(rt.new_int(4))).to_i64())
	mut var_user := rt.new_bool(this.login(var_username.clone(), var_password.clone()))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_user)))) {
		return this.error
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('edit_posts'),
	])))))
	{
		return create_ixr_error(rt.new_int(401), rt.call_function('__', [
			rt.new_string('Sorry, you must be able to edit posts on this site in order to view categories.'),
		]))
	}
	rt.call_function('do_action', [rt.new_string('xmlrpc_call'),
		rt.new_string('wp.suggestCategories'), var_args_mutated.clone(),
		rt.new_object('wp_xmlrpc_server', ['IXR_Server'], &this)])
	mut var_category_suggestions := []rt.PhpVal{}
	var_args_mutated = rt.create_array([rt.ArrayItem{ key: 'get', val: 'all' },
		rt.ArrayItem{ key: 'number', val: var_max_results }, rt.ArrayItem{
			key: 'name__like'
			val: var_category
		}])
	mut iter_20 := rt.cast_array(rt.call_function('get_categories', [
		var_args_mutated.clone()])).iterator()
	for {
		item_20 := iter_20.next() or { break }
		mut var_cat := item_20.val
		var_category_suggestions << rt.create_array([
			rt.ArrayItem{ key: 'category_id', val: rt.get_property(var_cat, 'term_id') },
			rt.ArrayItem{ key: 'category_name', val: rt.get_property(var_cat, 'name') },
		])
	}
	return var_category_suggestions.clone()
}

fn (mut this Class_wp_xmlrpc_server) wp_getcomment(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
	this.escape(var_args_mutated.clone())
	mut var_username := var_args_mutated.array_get(rt.new_int(1))
	mut var_password := var_args_mutated.array_get(rt.new_int(2))
	mut var_comment_id := rt.new_int((var_args_mutated.array_get(rt.new_int(3))).to_i64())
	mut var_user := rt.new_bool(this.login(var_username.clone(), var_password.clone()))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_user)))) {
		return this.error
	}
	rt.call_function('do_action', [rt.new_string('xmlrpc_call'),
		rt.new_string('wp.getComment'), var_args_mutated.clone(),
		rt.new_object('wp_xmlrpc_server', ['IXR_Server'], &this)])
	mut var_comment := rt.call_function('get_comment', [var_comment_id.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_comment)))) {
		return rt.new_object('IXR_Error', []string{}, create_ixr_error(rt.new_int(404), rt.call_function('__', [
			rt.new_string('Invalid comment ID.'),
		])))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('edit_comment'),
		var_comment_id.clone(),
	])))))
	{
		return rt.new_object('IXR_Error', []string{}, create_ixr_error(rt.new_int(403), rt.call_function('__', [
			rt.new_string('Sorry, you are not allowed to moderate or edit this comment.'),
		])))
	}
	return this._prepare_comment(var_comment.clone())
}

fn (mut this Class_wp_xmlrpc_server) wp_getcomments(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
	this.escape(var_args_mutated.clone())
	mut var_username := var_args_mutated.array_get(rt.new_int(1))
	mut var_password := var_args_mutated.array_get(rt.new_int(2))
	mut var_struct := if !(var_args_mutated.array_get(rt.new_int(3))).is_null() {
		var_args_mutated.array_get(rt.new_int(3))
	} else {
		[]rt.PhpVal{}
	}
	mut var_user := rt.new_bool(this.login(var_username.clone(), var_password.clone()))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_user)))) {
		return this.error
	}
	rt.call_function('do_action', [rt.new_string('xmlrpc_call'),
		rt.new_string('wp.getComments'), var_args_mutated.clone(),
		rt.new_object('wp_xmlrpc_server', ['IXR_Server'], &this)])
	mut var_status := if !(var_struct.array_get(rt.new_string('status'))).is_null() {
		var_struct.array_get(rt.new_string('status'))
	} else {
		rt.new_string('')
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('moderate_comments')])))))
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('approve'), var_status)))) {
		return create_ixr_error(rt.new_int(401), rt.call_function('__', [
			rt.new_string('Invalid comment status.'),
		]))
	}
	mut var_post_id := rt.new_string('')
	if var_struct.array_isset(rt.new_string('post_id')) {
		var_post_id = rt.call_function('absint', [var_struct.array_get(rt.new_string('post_id'))])
	}
	mut var_post_type := rt.new_string('')
	if var_struct.array_isset(rt.new_string('post_type')) {
		mut var_post_type_object := rt.call_function('get_post_type_object', [
			var_struct.array_get(rt.new_string('post_type')),
		])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_post_type_object))))
			|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('post_type_supports', [rt.get_property(var_post_type_object, 'name'), rt.new_string('comments')]))))) {
			return create_ixr_error(rt.new_int(404), rt.call_function('__', [
				rt.new_string('Invalid post type.'),
			]))
		}
		var_post_type = var_struct.array_get(rt.new_string('post_type'))
	}
	mut var_offset := rt.new_int(0)
	if var_struct.array_isset(rt.new_string('offset')) {
		var_offset = rt.call_function('absint', [var_struct.array_get(rt.new_string('offset'))])
	}
	mut var_number := rt.new_int(10)
	if var_struct.array_isset(rt.new_string('number')) {
		var_number = rt.call_function('absint', [var_struct.array_get(rt.new_string('number'))])
	}
	mut var_comments := rt.call_function('get_comments', [
		rt.create_array([rt.ArrayItem{ key: 'status', val: var_status },
			rt.ArrayItem{ key: 'post_id', val: var_post_id },
			rt.ArrayItem{ key: 'offset', val: var_offset }, rt.ArrayItem{
				key: 'number'
				val: var_number
			}, rt.ArrayItem{ key: 'post_type', val: var_post_type }]),
	])
	mut var_comments_struct := []rt.PhpVal{}
	if rt.is_true(rt.new_bool(var_comments.clone().is_array())) {
		mut iter_21 := var_comments.iterator()
		for {
			item_21 := iter_21.next() or { break }
			mut var_comment := item_21.val
			var_comments_struct << this._prepare_comment(var_comment.clone())
		}
	}
	return var_comments_struct.clone()
}

fn (mut this Class_wp_xmlrpc_server) wp_deletecomment(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
	this.escape(var_args_mutated.clone())
	mut var_username := var_args_mutated.array_get(rt.new_int(1))
	mut var_password := var_args_mutated.array_get(rt.new_int(2))
	mut var_comment_id := rt.new_int((var_args_mutated.array_get(rt.new_int(3))).to_i64())
	mut var_user := rt.new_bool(this.login(var_username.clone(), var_password.clone()))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_user)))) {
		return this.error
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('get_comment', [
		var_comment_id.clone()])))))
	{
		return rt.new_object('IXR_Error', []string{}, create_ixr_error(rt.new_int(404), rt.call_function('__', [
			rt.new_string('Invalid comment ID.'),
		])))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('edit_comment'),
		var_comment_id.clone(),
	])))))
	{
		return rt.new_object('IXR_Error', []string{}, create_ixr_error(rt.new_int(403), rt.call_function('__', [
			rt.new_string('Sorry, you are not allowed to delete this comment.'),
		])))
	}
	rt.call_function('do_action', [rt.new_string('xmlrpc_call'),
		rt.new_string('wp.deleteComment'), var_args_mutated.clone(),
		rt.new_object('wp_xmlrpc_server', ['IXR_Server'], &this)])
	mut var_status := rt.call_function('wp_delete_comment', [
		var_comment_id.clone()])
	if rt.is_true(rt.identical(rt.new_bool(true), var_status)) {
		rt.call_function('do_action', [
			rt.new_string('xmlrpc_call_success_wp_deleteComment'),
			var_comment_id.clone(),
			var_args_mutated.clone(),
		])
	}
	return var_status.clone()
}

fn (mut this Class_wp_xmlrpc_server) wp_editcomment(var_args rt.PhpVal) bool {
	mut var_args_mutated := var_args
	this.escape(var_args_mutated.clone())
	mut var_username := var_args_mutated.array_get(rt.new_int(1))
	mut var_password := var_args_mutated.array_get(rt.new_int(2))
	mut var_comment_id := rt.new_int((var_args_mutated.array_get(rt.new_int(3))).to_i64())
	mut var_content_struct := var_args_mutated.array_get(rt.new_int(4))
	mut var_user := rt.new_bool(this.login(var_username.clone(), var_password.clone()))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_user)))) {
		return (this.error).to_bool()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('get_comment', [
		var_comment_id.clone()])))))
	{
		return (create_ixr_error(rt.new_int(404), rt.call_function('__', [
			rt.new_string('Invalid comment ID.'),
		]))).to_bool()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('edit_comment'),
		var_comment_id.clone(),
	])))))
	{
		return (create_ixr_error(rt.new_int(403), rt.call_function('__', [
			rt.new_string('Sorry, you are not allowed to moderate or edit this comment.'),
		]))).to_bool()
	}
	rt.call_function('do_action', [rt.new_string('xmlrpc_call'),
		rt.new_string('wp.editComment'), var_args_mutated.clone(),
		rt.new_object('wp_xmlrpc_server', ['IXR_Server'], &this)])
	mut var_comment := rt.create_array([
		rt.ArrayItem{ key: 'comment_ID', val: var_comment_id },
	])
	if var_content_struct.array_isset(rt.new_string('status')) {
		mut var_statuses := rt.call_function('get_comment_statuses', []rt.PhpVal{})
		var_statuses = rt.func_array_keys(var_statuses.clone())
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
			var_content_struct.array_get(rt.new_string('status')),
			var_statuses.clone(),
			rt.new_bool(true),
		])))))
		{
			return (create_ixr_error(rt.new_int(401), rt.call_function('__', [
				rt.new_string('Invalid comment status.'),
			]))).to_bool()
		}
		var_comment.array_set('comment_approved',
			var_content_struct.array_get(rt.new_string('status')))
	}
	if !(!rt.is_true(var_content_struct.array_get(rt.new_string('date_created_gmt')))) {
		mut var_date_created := rt.new_string((
			rt.call_method(var_content_struct.array_get(rt.new_string('date_created_gmt')), 'getIso', []rt.PhpVal{}).to_string().trim_right(' \t\n\r') +
			'Z').str())
		var_comment.array_set('comment_date', rt.call_function('get_date_from_gmt', [
			var_date_created.clone(),
		]))
		var_comment.array_set('comment_date_gmt', rt.call_function('iso8601_to_datetime', [
			var_date_created.clone(),
			rt.new_string('gmt'),
		]))
	}
	if var_content_struct.array_isset(rt.new_string('content')) {
		var_comment.array_set('comment_content',
			var_content_struct.array_get(rt.new_string('content')))
	}
	if var_content_struct.array_isset(rt.new_string('author')) {
		var_comment.array_set('comment_author',
			var_content_struct.array_get(rt.new_string('author')))
	}
	if var_content_struct.array_isset(rt.new_string('author_url')) {
		var_comment.array_set('comment_author_url',
			var_content_struct.array_get(rt.new_string('author_url')))
	}
	if var_content_struct.array_isset(rt.new_string('author_email')) {
		var_comment.array_set('comment_author_email',
			var_content_struct.array_get(rt.new_string('author_email')))
	}
	mut var_result := rt.call_function('wp_update_comment', [
		var_comment.clone(), rt.new_bool(true)])
	if rt.is_true(rt.call_function('is_wp_error', [var_result.clone()])) {
		return (create_ixr_error(rt.new_int(500), rt.call_method(var_result, 'get_error_message',
			[]rt.PhpVal{}))).to_bool()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_result)))) {
		return (create_ixr_error(rt.new_int(500), rt.call_function('__', [
			rt.new_string('Sorry, the comment could not be updated.'),
		]))).to_bool()
	}
	rt.call_function('do_action', [rt.new_string('xmlrpc_call_success_wp_editComment'),
		var_comment_id.clone(), var_args_mutated.clone()])
	return true
}

fn (mut this Class_wp_xmlrpc_server) wp_newcomment(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
	this.escape(var_args_mutated.clone())
	mut var_username := var_args_mutated.array_get(rt.new_int(1))
	mut var_password := var_args_mutated.array_get(rt.new_int(2))
	mut var_post := var_args_mutated.array_get(rt.new_int(3))
	mut var_content_struct := var_args_mutated.array_get(rt.new_int(4))
	mut var_allow_anon := rt.call_function('apply_filters', [
		rt.new_string('xmlrpc_allow_anonymous_comments'),
		rt.new_bool(false),
	])
	mut var_user := rt.new_bool(this.login(var_username.clone(), var_password.clone()))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_user)))) {
		mut var_logged_in := rt.new_bool(false)
		if rt.is_true(var_allow_anon)
			&& rt.is_true(rt.call_function('get_option', [rt.new_string('comment_registration')])) {
			return rt.new_object('IXR_Error', []string{}, create_ixr_error(rt.new_int(403), rt.call_function('__', [
				rt.new_string('Sorry, you must be logged in to comment.'),
			])))
		} else if rt.is_true(rt.new_bool(!(rt.is_true(var_allow_anon)))) {
			return this.error
		}
	} else {
		var_logged_in = rt.new_bool(true)
	}
	if rt.is_true(rt.new_bool(var_post.clone().is_long() || var_post.clone().is_double())) {
		mut var_post_id := rt.call_function('absint', [var_post.clone()])
	} else {
		var_post_id = rt.call_function('url_to_postid', [var_post.clone()])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_post_id)))) {
		return rt.new_object('IXR_Error', []string{}, create_ixr_error(rt.new_int(404), rt.call_function('__', [
			rt.new_string('Invalid post ID.'),
		])))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('get_post', [
		var_post_id.clone()])))))
	{
		return rt.new_object('IXR_Error', []string{}, create_ixr_error(rt.new_int(404), rt.call_function('__', [
			rt.new_string('Invalid post ID.'),
		])))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('comments_open', [
		var_post_id.clone()])))))
	{
		return rt.new_object('IXR_Error', []string{}, create_ixr_error(rt.new_int(403), rt.call_function('__', [
			rt.new_string('Sorry, comments are closed for this item.'),
		])))
	}
	if rt.is_true(rt.identical(rt.new_string('publish'), rt.call_function('get_post_status', [var_post_id.clone()])))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_post'), var_post_id.clone()])))))
		&& rt.is_true(rt.call_function('post_password_required', [var_post_id.clone()])) {
		return rt.new_object('IXR_Error', []string{}, create_ixr_error(rt.new_int(403), rt.call_function('__', [
			rt.new_string('Sorry, you are not allowed to comment on this post.'),
		])))
	}
	if rt.is_true(rt.identical(rt.new_string('private'), rt.call_function('get_post_status', [var_post_id.clone()])))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('read_post'), var_post_id.clone()]))))) {
		return rt.new_object('IXR_Error', []string{}, create_ixr_error(rt.new_int(403), rt.call_function('__', [
			rt.new_string('Sorry, you are not allowed to comment on this post.'),
		])))
	}
	mut var_comment := rt.create_array([
		rt.ArrayItem{ key: 'comment_post_ID', val: var_post_id },
		rt.ArrayItem{
			key: 'comment_content'
			val: var_content_struct.array_get(rt.new_string('content')).to_string().trim_space()
		},
	])
	if rt.is_true(var_logged_in) {
		mut var_display_name := rt.get_property(var_user, 'display_name')
		mut var_user_email := rt.get_property(var_user, 'user_email')
		mut var_user_url := rt.get_property(var_user, 'user_url')
		var_comment.array_set('comment_author', this.escape(var_display_name.clone()))
		var_comment.array_set('comment_author_email', this.escape(var_user_email.clone()))
		var_comment.array_set('comment_author_url', this.escape(var_user_url.clone()))
		var_comment.array_set('user_id', rt.get_property(var_user, 'ID'))
	} else {
		var_comment.array_set('comment_author', '')
		if var_content_struct.array_isset(rt.new_string('author')) {
			var_comment.array_set('comment_author',
				var_content_struct.array_get(rt.new_string('author')))
		}
		var_comment.array_set('comment_author_email', '')
		if var_content_struct.array_isset(rt.new_string('author_email')) {
			var_comment.array_set('comment_author_email',
				var_content_struct.array_get(rt.new_string('author_email')))
		}
		var_comment.array_set('comment_author_url', '')
		if var_content_struct.array_isset(rt.new_string('author_url')) {
			var_comment.array_set('comment_author_url',
				var_content_struct.array_get(rt.new_string('author_url')))
		}
		var_comment.array_set('user_id', 0)
		if rt.is_true(rt.call_function('get_option', [
			rt.new_string('require_name_email'),
		]))
		{
			if var_comment.array_get(rt.new_string('comment_author_email')).to_string().len < 6
				|| rt.is_true(rt.identical(rt.new_string(''), var_comment.array_get(rt.new_string('comment_author')))) {
				return rt.new_object('IXR_Error', []string{}, create_ixr_error(rt.new_int(403), rt.call_function('__', [
					rt.new_string('Comment author name and email are required.'),
				])))
			} else if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_email', [
				var_comment.array_get(rt.new_string('comment_author_email')),
			])))))
			{
				return rt.new_object('IXR_Error', []string{}, create_ixr_error(rt.new_int(403), rt.call_function('__', [
					rt.new_string('A valid email address is required.'),
				])))
			}
		}
	}
	var_comment.array_set('comment_parent', if var_content_struct.array_isset(rt.new_string('comment_parent')) { rt.call_function('absint', [
			var_content_struct.array_get(rt.new_string('comment_parent')),
		]) } else { rt.new_int(0) })
	mut var_allow_empty := rt.call_function('apply_filters', [
		rt.new_string('allow_empty_comment'),
		rt.new_bool(false),
		var_comment.clone(),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_allow_empty))))
		&& rt.is_true(rt.identical(rt.new_string(''), var_comment.array_get(rt.new_string('comment_content')))) {
		return rt.new_object('IXR_Error', []string{}, create_ixr_error(rt.new_int(403), rt.call_function('__', [
			rt.new_string('Comment is required.'),
		])))
	}
	rt.call_function('do_action', [rt.new_string('xmlrpc_call'),
		rt.new_string('wp.newComment'), var_args_mutated.clone(),
		rt.new_object('wp_xmlrpc_server', ['IXR_Server'], &this)])
	mut var_comment_id := rt.call_function('wp_new_comment', [
		var_comment.clone(), rt.new_bool(true)])
	if rt.is_true(rt.call_function('is_wp_error', [var_comment_id.clone()])) {
		return rt.new_object('IXR_Error', []string{}, create_ixr_error(rt.new_int(403), rt.call_method(var_comment_id,
			'get_error_message', []rt.PhpVal{})))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_comment_id)))) {
		return rt.new_object('IXR_Error', []string{}, create_ixr_error(rt.new_int(403), rt.call_function('__', [
			rt.new_string('An error occurred while processing your comment. Please ensure all fields are filled correctly and try again.'),
		])))
	}
	rt.call_function('do_action', [rt.new_string('xmlrpc_call_success_wp_newComment'),
		var_comment_id.clone(), var_args_mutated.clone()])
	return var_comment_id.clone()
}

fn (mut this Class_wp_xmlrpc_server) wp_getcommentstatuslist(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
	this.escape(var_args_mutated.clone())
	mut var_username := var_args_mutated.array_get(rt.new_int(1))
	mut var_password := var_args_mutated.array_get(rt.new_int(2))
	mut var_user := rt.new_bool(this.login(var_username.clone(), var_password.clone()))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_user)))) {
		return this.error
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('publish_posts'),
	])))))
	{
		return rt.new_object('IXR_Error', []string{}, create_ixr_error(rt.new_int(403), rt.call_function('__', [
			rt.new_string('Sorry, you are not allowed to access details about this site.'),
		])))
	}
	rt.call_function('do_action', [rt.new_string('xmlrpc_call'),
		rt.new_string('wp.getCommentStatusList'), var_args_mutated.clone(),
		rt.new_object('wp_xmlrpc_server', ['IXR_Server'], &this)])
	return rt.call_function('get_comment_statuses', []rt.PhpVal{})
}

fn (mut this Class_wp_xmlrpc_server) wp_getcommentcount(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
	this.escape(var_args_mutated.clone())
	mut var_username := var_args_mutated.array_get(rt.new_int(1))
	mut var_password := var_args_mutated.array_get(rt.new_int(2))
	mut var_post_id := rt.new_int((var_args_mutated.array_get(rt.new_int(3))).to_i64())
	mut var_user := rt.new_bool(this.login(var_username.clone(), var_password.clone()))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_user)))) {
		return this.error
	}
	mut var_post := rt.call_function('get_post', [var_post_id.clone(),
		rt.get_constant('ARRAY_A')])
	if !rt.is_true(var_post.array_get(rt.new_string('ID'))) {
		return create_ixr_error(rt.new_int(404), rt.call_function('__', [
			rt.new_string('Invalid post ID.'),
		]))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('edit_post'),
		var_post_id.clone(),
	])))))
	{
		return create_ixr_error(rt.new_int(403), rt.call_function('__', [
			rt.new_string('Sorry, you are not allowed to access details of this post.'),
		]))
	}
	rt.call_function('do_action', [rt.new_string('xmlrpc_call'),
		rt.new_string('wp.getCommentCount'), var_args_mutated.clone(),
		rt.new_object('wp_xmlrpc_server', ['IXR_Server'], &this)])
	mut var_count := rt.call_function('wp_count_comments', [var_post_id.clone()])
	return rt.create_array([
		rt.ArrayItem{ key: 'approved', val: rt.get_property(var_count, 'approved') },
		rt.ArrayItem{ key: 'awaiting_moderation', val: rt.get_property(var_count, 'moderated') },
		rt.ArrayItem{ key: 'spam', val: rt.get_property(var_count, 'spam') },
		rt.ArrayItem{ key: 'total_comments', val: rt.get_property(var_count, 'total_comments') },
	])
}

fn (mut this Class_wp_xmlrpc_server) wp_getpoststatuslist(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
	this.escape(var_args_mutated.clone())
	mut var_username := var_args_mutated.array_get(rt.new_int(1))
	mut var_password := var_args_mutated.array_get(rt.new_int(2))
	mut var_user := rt.new_bool(this.login(var_username.clone(), var_password.clone()))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_user)))) {
		return this.error
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('edit_posts'),
	])))))
	{
		return rt.new_object('IXR_Error', []string{}, create_ixr_error(rt.new_int(403), rt.call_function('__', [
			rt.new_string('Sorry, you are not allowed to access details about this site.'),
		])))
	}
	rt.call_function('do_action', [rt.new_string('xmlrpc_call'),
		rt.new_string('wp.getPostStatusList'), var_args_mutated.clone(),
		rt.new_object('wp_xmlrpc_server', ['IXR_Server'], &this)])
	return rt.call_function('get_post_statuses', []rt.PhpVal{})
}

fn (mut this Class_wp_xmlrpc_server) wp_getpagestatuslist(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
	this.escape(var_args_mutated.clone())
	mut var_username := var_args_mutated.array_get(rt.new_int(1))
	mut var_password := var_args_mutated.array_get(rt.new_int(2))
	mut var_user := rt.new_bool(this.login(var_username.clone(), var_password.clone()))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_user)))) {
		return this.error
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('edit_pages'),
	])))))
	{
		return rt.new_object('IXR_Error', []string{}, create_ixr_error(rt.new_int(403), rt.call_function('__', [
			rt.new_string('Sorry, you are not allowed to access details about this site.'),
		])))
	}
	rt.call_function('do_action', [rt.new_string('xmlrpc_call'),
		rt.new_string('wp.getPageStatusList'), var_args_mutated.clone(),
		rt.new_object('wp_xmlrpc_server', ['IXR_Server'], &this)])
	return rt.call_function('get_page_statuses', []rt.PhpVal{})
}

fn (mut this Class_wp_xmlrpc_server) wp_getpagetemplates(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
	this.escape(var_args_mutated.clone())
	mut var_username := var_args_mutated.array_get(rt.new_int(1))
	mut var_password := var_args_mutated.array_get(rt.new_int(2))
	mut var_user := rt.new_bool(this.login(var_username.clone(), var_password.clone()))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_user)))) {
		return this.error
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('edit_pages'),
	])))))
	{
		return create_ixr_error(rt.new_int(403), rt.call_function('__', [
			rt.new_string('Sorry, you are not allowed to access details about this site.'),
		]))
	}
	mut var_templates := rt.call_function('get_page_templates', []rt.PhpVal{})
	var_templates.array_set('Default', 'default')
	return var_templates.clone()
}

fn (mut this Class_wp_xmlrpc_server) wp_getoptions(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
	this.escape(var_args_mutated.clone())
	mut var_username := var_args_mutated.array_get(rt.new_int(1))
	mut var_password := var_args_mutated.array_get(rt.new_int(2))
	mut var_options := if var_args_mutated.array_isset(rt.new_int(3)) {
		rt.cast_array(var_args_mutated.array_get(rt.new_int(3)))
	} else {
		[]rt.PhpVal{}
	}
	mut var_user := rt.new_bool(this.login(var_username.clone(), var_password.clone()))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_user)))) {
		return this.error
	}
	if var_options.clone().array_count() == 0 {
		var_options = rt.func_array_keys(this.blog_options)
	}
	return this._getoptions(var_options.clone())
}

fn (mut this Class_wp_xmlrpc_server) _getoptions(var_options rt.PhpVal) rt.PhpVal {
	mut var_options_mutated := var_options
	mut var_data := []rt.PhpVal{}
	mut var_can_manage := rt.call_function('current_user_can', [
		rt.new_string('manage_options'),
	])
	mut iter_22 := var_options_mutated.iterator()
	for {
		item_22 := iter_22.next() or { break }
		mut var_option := item_22.val
		if rt.is_true(rt.new_bool(this.blog_options.array_isset(var_option.clone()))) {
			var_data.array_set(var_option, this.blog_options.array_get(var_option))
			if var_data.array_get(var_option).array_isset(rt.new_string('option')) {
				var_data.array_get_mut(var_option).array_set('value', rt.call_function('get_option', [
					var_data.array_get(var_option).array_get(rt.new_string('option')),
				]))
				var_data.array_get(var_option).array_unset(rt.new_string('option'))
			}
			if rt.is_true(rt.new_bool(!(rt.is_true(var_can_manage)))) {
				var_data.array_get_mut(var_option).array_set('readonly', true)
			}
		}
	}
	return var_data.clone()
}

fn (mut this Class_wp_xmlrpc_server) wp_setoptions(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
	this.escape(var_args_mutated.clone())
	mut var_username := var_args_mutated.array_get(rt.new_int(1))
	mut var_password := var_args_mutated.array_get(rt.new_int(2))
	mut var_options := rt.cast_array(var_args_mutated.array_get(rt.new_int(3)))
	mut var_user := rt.new_bool(this.login(var_username.clone(), var_password.clone()))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_user)))) {
		return this.error
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('manage_options'),
	])))))
	{
		return rt.new_object('IXR_Error', []string{}, create_ixr_error(rt.new_int(403), rt.call_function('__', [
			rt.new_string('Sorry, you are not allowed to update options.'),
		])))
	}
	mut var_option_names := []rt.PhpVal{}
	mut iter_23 := var_options.iterator()
	for {
		item_23 := iter_23.next() or { break }
		mut var_o_value := item_23.val
		mut var_o_name := item_23.key
		var_option_names << var_o_name.clone()
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(this.blog_options.array_isset(var_o_name.clone())))))) {
			continue
		}
		if rt.is_true(this.blog_options.array_get(var_o_name).array_get(rt.new_string('readonly'))) {
			continue
		}
		rt.call_function('update_option', [this.blog_options.array_get(var_o_name).array_get(rt.new_string('option')),
			rt.call_function('wp_unslash', [var_o_value.clone()])])
	}
	return this._getoptions(var_option_names.clone())
}

fn (mut this Class_wp_xmlrpc_server) wp_getmediaitem(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
	this.escape(var_args_mutated.clone())
	mut var_username := var_args_mutated.array_get(rt.new_int(1))
	mut var_password := var_args_mutated.array_get(rt.new_int(2))
	mut var_attachment_id := rt.new_int((var_args_mutated.array_get(rt.new_int(3))).to_i64())
	mut var_user := rt.new_bool(this.login(var_username.clone(), var_password.clone()))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_user)))) {
		return this.error
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('upload_files'),
	])))))
	{
		return rt.new_object('IXR_Error', []string{}, create_ixr_error(rt.new_int(403), rt.call_function('__', [
			rt.new_string('Sorry, you are not allowed to upload files.'),
		])))
	}
	rt.call_function('do_action', [rt.new_string('xmlrpc_call'),
		rt.new_string('wp.getMediaItem'), var_args_mutated.clone(),
		rt.new_object('wp_xmlrpc_server', ['IXR_Server'], &this)])
	mut var_attachment := rt.call_function('get_post', [var_attachment_id.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_attachment))))
		|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('attachment'), rt.get_property(var_attachment, 'post_type'))))) {
		return rt.new_object('IXR_Error', []string{}, create_ixr_error(rt.new_int(404), rt.call_function('__', [
			rt.new_string('Invalid attachment ID.'),
		])))
	}
	return this._prepare_media_item(var_attachment.clone(), '')
}

fn (mut this Class_wp_xmlrpc_server) wp_getmedialibrary(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
	this.escape(var_args_mutated.clone())
	mut var_username := var_args_mutated.array_get(rt.new_int(1))
	mut var_password := var_args_mutated.array_get(rt.new_int(2))
	mut var_struct := if !(var_args_mutated.array_get(rt.new_int(3))).is_null() {
		var_args_mutated.array_get(rt.new_int(3))
	} else {
		[]rt.PhpVal{}
	}
	mut var_user := rt.new_bool(this.login(var_username.clone(), var_password.clone()))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_user)))) {
		return this.error
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('upload_files'),
	])))))
	{
		return create_ixr_error(rt.new_int(401), rt.call_function('__', [
			rt.new_string('Sorry, you are not allowed to upload files.'),
		]))
	}
	rt.call_function('do_action', [rt.new_string('xmlrpc_call'),
		rt.new_string('wp.getMediaLibrary'), var_args_mutated.clone(),
		rt.new_object('wp_xmlrpc_server', ['IXR_Server'], &this)])
	mut var_parent_id := if var_struct.array_isset(rt.new_string('parent_id')) { rt.call_function('absint', [
			var_struct.array_get(rt.new_string('parent_id')),
		]) } else { rt.new_string('') }
	mut var_mime_type := if !(var_struct.array_get(rt.new_string('mime_type'))).is_null() {
		var_struct.array_get(rt.new_string('mime_type'))
	} else {
		rt.new_string('')
	}
	mut var_offset := if var_struct.array_isset(rt.new_string('offset')) { rt.call_function('absint', [
			var_struct.array_get(rt.new_string('offset')),
		]) } else { rt.new_int(0) }
	mut var_number := if var_struct.array_isset(rt.new_string('number')) { rt.call_function('absint', [
			var_struct.array_get(rt.new_string('number')),
		]) } else { -1 }
	mut var_attachments := rt.call_function('get_posts', [
		rt.create_array([rt.ArrayItem{ key: 'post_type', val: 'attachment' },
			rt.ArrayItem{ key: 'post_parent', val: var_parent_id },
			rt.ArrayItem{ key: 'offset', val: var_offset }, rt.ArrayItem{
				key: 'numberposts'
				val: var_number
			}, rt.ArrayItem{ key: 'post_mime_type', val: var_mime_type }]),
	])
	mut var_attachments_struct := []rt.PhpVal{}
	mut iter_24 := var_attachments.iterator()
	for {
		item_24 := iter_24.next() or { break }
		mut var_attachment := item_24.val
		var_attachments_struct << this._prepare_media_item(var_attachment.clone(), '')
	}
	return var_attachments_struct.clone()
}

fn (mut this Class_wp_xmlrpc_server) wp_getpostformats(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
	this.escape(var_args_mutated.clone())
	mut var_username := var_args_mutated.array_get(rt.new_int(1))
	mut var_password := var_args_mutated.array_get(rt.new_int(2))
	mut var_user := rt.new_bool(this.login(var_username.clone(), var_password.clone()))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_user)))) {
		return this.error
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('edit_posts'),
	])))))
	{
		return rt.new_object('IXR_Error', []string{}, create_ixr_error(rt.new_int(403), rt.call_function('__', [
			rt.new_string('Sorry, you are not allowed to access details about this site.'),
		])))
	}
	rt.call_function('do_action', [rt.new_string('xmlrpc_call'),
		rt.new_string('wp.getPostFormats'), var_args_mutated.clone(),
		rt.new_object('wp_xmlrpc_server', ['IXR_Server'], &this)])
	mut var_formats := rt.call_function('get_post_format_strings', []rt.PhpVal{})
	if var_args_mutated.array_isset(rt.new_int(3))
		&& var_args_mutated.array_get(rt.new_int(3)).is_array() {
		if rt.is_true(var_args_mutated.array_get(rt.new_int(3)).array_get(rt.new_string('show-supported'))) {
			if rt.is_true(rt.call_function('current_theme_supports', [
				rt.new_string('post-formats'),
			]))
			{
				mut var_supported := rt.call_function('get_theme_support', [
					rt.new_string('post-formats'),
				])
				mut var_data := []rt.PhpVal{}
				var_data.array_set('all', var_formats.clone())
				var_data.array_set('supported', var_supported.array_get(rt.new_int(0)))
				var_formats = var_data.clone()
			}
		}
	}
	return var_formats.clone()
}

fn (mut this Class_wp_xmlrpc_server) wp_getposttype(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
	if !(this.minimum_args(var_args_mutated.clone(), rt.new_int(4))) {
		return this.error
	}
	this.escape(var_args_mutated.clone())
	mut var_username := var_args_mutated.array_get(rt.new_int(1))
	mut var_password := var_args_mutated.array_get(rt.new_int(2))
	mut var_post_type_name := var_args_mutated.array_get(rt.new_int(3))
	if var_args_mutated.array_isset(rt.new_int(4)) {
		mut var_fields := var_args_mutated.array_get(rt.new_int(4))
	} else {
		var_fields = rt.call_function('apply_filters', [
			rt.new_string('xmlrpc_default_posttype_fields'),
			rt.create_array([rt.ArrayItem{ key: none, val: 'labels' },
				rt.ArrayItem{ key: none, val: 'cap' }, rt.ArrayItem{ key: none, val: 'taxonomies' }]),
			rt.new_string('wp.getPostType'),
		])
	}
	mut var_user := rt.new_bool(this.login(var_username.clone(), var_password.clone()))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_user)))) {
		return this.error
	}
	rt.call_function('do_action', [rt.new_string('xmlrpc_call'),
		rt.new_string('wp.getPostType'), var_args_mutated.clone(),
		rt.new_object('wp_xmlrpc_server', ['IXR_Server'], &this)])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('post_type_exists', [
		var_post_type_name.clone(),
	])))))
	{
		return rt.new_object('IXR_Error', []string{}, create_ixr_error(rt.new_int(403), rt.call_function('__', [
			rt.new_string('Invalid post type.'),
		])))
	}
	mut var_post_type := rt.call_function('get_post_type_object', [
		var_post_type_name.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.get_property(rt.get_property(var_post_type, 'cap'), 'edit_posts'),
	])))))
	{
		return rt.new_object('IXR_Error', []string{}, create_ixr_error(rt.new_int(401), rt.call_function('__', [
			rt.new_string('Sorry, you are not allowed to edit posts in this post type.'),
		])))
	}
	return this._prepare_post_type(var_post_type.clone(), var_fields.clone())
}

fn (mut this Class_wp_xmlrpc_server) wp_getposttypes(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
	if !(this.minimum_args(var_args_mutated.clone(), rt.new_int(3))) {
		return this.error
	}
	this.escape(var_args_mutated.clone())
	mut var_username := var_args_mutated.array_get(rt.new_int(1))
	mut var_password := var_args_mutated.array_get(rt.new_int(2))
	mut var_filter := if !(var_args_mutated.array_get(rt.new_int(3))).is_null() { var_args_mutated.array_get(rt.new_int(3)) } else { rt.create_array([
			rt.ArrayItem{ key: 'public', val: true },
		]) }
	if var_args_mutated.array_isset(rt.new_int(4)) {
		mut var_fields := var_args_mutated.array_get(rt.new_int(4))
	} else {
		var_fields = rt.call_function('apply_filters', [
			rt.new_string('xmlrpc_default_posttype_fields'),
			rt.create_array([rt.ArrayItem{ key: none, val: 'labels' },
				rt.ArrayItem{ key: none, val: 'cap' }, rt.ArrayItem{ key: none, val: 'taxonomies' }]),
			rt.new_string('wp.getPostTypes'),
		])
	}
	mut var_user := rt.new_bool(this.login(var_username.clone(), var_password.clone()))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_user)))) {
		return this.error
	}
	rt.call_function('do_action', [rt.new_string('xmlrpc_call'),
		rt.new_string('wp.getPostTypes'), var_args_mutated.clone(),
		rt.new_object('wp_xmlrpc_server', ['IXR_Server'], &this)])
	mut var_post_types := rt.call_function('get_post_types', [
		var_filter.clone(), rt.new_string('objects')])
	mut var_struct := []rt.PhpVal{}
	mut iter_25 := var_post_types.iterator()
	for {
		item_25 := iter_25.next() or { break }
		mut var_post_type := item_25.val
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
			rt.get_property(rt.get_property(var_post_type, 'cap'), 'edit_posts'),
		])))))
		{
			continue
		}
		var_struct.array_set(rt.get_property(var_post_type, 'name'), this._prepare_post_type(var_post_type.clone(),
			var_fields.clone()))
	}
	return var_struct.clone()
}

fn (mut this Class_wp_xmlrpc_server) wp_getrevisions(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
	if !(this.minimum_args(var_args_mutated.clone(), rt.new_int(4))) {
		return this.error
	}
	this.escape(var_args_mutated.clone())
	mut var_username := var_args_mutated.array_get(rt.new_int(1))
	mut var_password := var_args_mutated.array_get(rt.new_int(2))
	mut var_post_id := rt.new_int((var_args_mutated.array_get(rt.new_int(3))).to_i64())
	if var_args_mutated.array_isset(rt.new_int(4)) {
		mut var_fields := var_args_mutated.array_get(rt.new_int(4))
	} else {
		var_fields = rt.call_function('apply_filters', [
			rt.new_string('xmlrpc_default_revision_fields'),
			rt.create_array([rt.ArrayItem{ key: none, val: 'post_date' },
				rt.ArrayItem{ key: none, val: 'post_date_gmt' }]),
			rt.new_string('wp.getRevisions'),
		])
	}
	mut var_user := rt.new_bool(this.login(var_username.clone(), var_password.clone()))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_user)))) {
		return this.error
	}
	rt.call_function('do_action', [rt.new_string('xmlrpc_call'),
		rt.new_string('wp.getRevisions'), var_args_mutated.clone(),
		rt.new_object('wp_xmlrpc_server', ['IXR_Server'], &this)])
	mut var_post := rt.call_function('get_post', [var_post_id.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_post)))) {
		return create_ixr_error(rt.new_int(404), rt.call_function('__', [
			rt.new_string('Invalid post ID.'),
		]))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('edit_post'),
		var_post_id.clone(),
	])))))
	{
		return create_ixr_error(rt.new_int(401), rt.call_function('__', [
			rt.new_string('Sorry, you are not allowed to edit posts.'),
		]))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_revisions_enabled', [
		var_post.clone(),
	])))))
	{
		return create_ixr_error(rt.new_int(401), rt.call_function('__', [
			rt.new_string('Sorry, revisions are disabled.'),
		]))
	}
	mut var_revisions := rt.call_function('wp_get_post_revisions', [
		var_post_id.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_revisions)))) {
		return []rt.PhpVal{}
	}
	mut var_struct := []rt.PhpVal{}
	mut iter_26 := var_revisions.iterator()
	for {
		item_26 := iter_26.next() or { break }
		mut var_revision := item_26.val
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
			rt.new_string('read_post'),
			rt.get_property(var_revision, 'ID'),
		])))))
		{
			continue
		}
		if rt.is_true(rt.call_function('wp_is_post_autosave', [
			var_revision.clone()]))
		{
			continue
		}
		var_struct.array_push(this._prepare_post(rt.call_function('get_object_vars', [
			var_revision.clone(),
		]), var_fields.clone()))
	}
	return var_struct.clone()
}

fn (mut this Class_wp_xmlrpc_server) wp_restorerevision(var_args rt.PhpVal) bool {
	mut var_args_mutated := var_args
	if !(this.minimum_args(var_args_mutated.clone(), rt.new_int(3))) {
		return (this.error).to_bool()
	}
	this.escape(var_args_mutated.clone())
	mut var_username := var_args_mutated.array_get(rt.new_int(1))
	mut var_password := var_args_mutated.array_get(rt.new_int(2))
	mut var_revision_id := rt.new_int((var_args_mutated.array_get(rt.new_int(3))).to_i64())
	mut var_user := rt.new_bool(this.login(var_username.clone(), var_password.clone()))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_user)))) {
		return (this.error).to_bool()
	}
	rt.call_function('do_action', [rt.new_string('xmlrpc_call'),
		rt.new_string('wp.restoreRevision'), var_args_mutated.clone(),
		rt.new_object('wp_xmlrpc_server', ['IXR_Server'], &this)])
	mut var_revision := rt.call_function('wp_get_post_revision', [
		var_revision_id.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_revision)))) {
		return (create_ixr_error(rt.new_int(404), rt.call_function('__', [
			rt.new_string('Invalid post ID.'),
		]))).to_bool()
	}
	if rt.is_true(rt.call_function('wp_is_post_autosave', [var_revision.clone()])) {
		return (create_ixr_error(rt.new_int(404), rt.call_function('__', [
			rt.new_string('Invalid post ID.'),
		]))).to_bool()
	}
	mut var_post := rt.call_function('get_post', [
		rt.get_property(var_revision, 'post_parent'),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_post)))) {
		return (create_ixr_error(rt.new_int(404), rt.call_function('__', [
			rt.new_string('Invalid post ID.'),
		]))).to_bool()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('edit_post'),
		rt.get_property(var_revision, 'post_parent'),
	])))))
	{
		return (create_ixr_error(rt.new_int(401), rt.call_function('__', [
			rt.new_string('Sorry, you are not allowed to edit this post.'),
		]))).to_bool()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_revisions_enabled', [
		var_post.clone(),
	])))))
	{
		return (create_ixr_error(rt.new_int(401), rt.call_function('__', [
			rt.new_string('Sorry, revisions are disabled.'),
		]))).to_bool()
	}
	var_post = rt.call_function('wp_restore_post_revision', [
		var_revision_id.clone()])
	return var_post.to_bool()
}

fn (mut this Class_wp_xmlrpc_server) blogger_getusersblogs(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
	if !(this.minimum_args(var_args_mutated.clone(), rt.new_int(3))) {
		return this.error
	}
	if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) {
		return this._multisite_getusersblogs(var_args_mutated.clone())
	}
	this.escape(var_args_mutated.clone())
	mut var_username := var_args_mutated.array_get(rt.new_int(1))
	mut var_password := var_args_mutated.array_get(rt.new_int(2))
	mut var_user := rt.new_bool(this.login(var_username.clone(), var_password.clone()))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_user)))) {
		return this.error
	}
	rt.call_function('do_action', [rt.new_string('xmlrpc_call'),
		rt.new_string('blogger.getUsersBlogs'), var_args_mutated.clone(),
		rt.new_object('wp_xmlrpc_server', ['IXR_Server'], &this)])
	mut var_is_admin := rt.call_function('current_user_can', [
		rt.new_string('manage_options'),
	])
	mut var_struct := rt.create_array([rt.ArrayItem{ key: 'isAdmin', val: var_is_admin },
		rt.ArrayItem{ key: 'url', val:
			(rt.call_function('get_option', [rt.new_string('home')])).str() + '/' },
		rt.ArrayItem{ key: 'blogid', val: '1' }, rt.ArrayItem{ key: 'blogName', val: rt.call_function('get_option', [
			rt.new_string('blogname'),
		]) }, rt.ArrayItem{ key: 'xmlrpc', val: rt.call_function('site_url', [
			rt.new_string('xmlrpc.php'),
			rt.new_string('rpc'),
		]) }])
	return rt.create_array([rt.ArrayItem{ key: none, val: var_struct }])
}

fn (mut this Class_wp_xmlrpc_server) _multisite_getusersblogs(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
	mut var_current_blog := rt.call_function('get_site', []rt.PhpVal{})
	mut var_domain := rt.get_property(var_current_blog, 'domain')
	mut var_path := rt.new_string((rt.get_property(var_current_blog, 'path')).str() + 'xmlrpc.php')
	mut var_blogs := this.wp_getusersblogs(var_args_mutated.clone())
	if rt.is_true(rt.new_bool(rt.instance_of(var_blogs, 'IXR_Error'))) {
		return var_blogs.clone()
	}
	if rt.is_true(rt.identical(rt.get_superglobal('_SERVER').array_get(rt.new_string('HTTP_HOST')), var_domain))
		&& rt.is_true(rt.identical(rt.get_superglobal('_SERVER').array_get(rt.new_string('REQUEST_URI')), var_path)) {
		return var_blogs.clone()
	} else {
		mut iter_27 := rt.cast_array(var_blogs).iterator()
		for {
			item_27 := iter_27.next() or { break }
			mut var_blog := item_27.val
			if rt.is_true(rt.call_function('str_contains', [
				var_blog.array_get(rt.new_string('url')),
				rt.get_superglobal('_SERVER').array_get(rt.new_string('HTTP_HOST')),
			]))
			{
				return rt.create_array([rt.ArrayItem{ key: none, val: var_blog }])
			}
		}
		return []rt.PhpVal{}
	}
	return rt.new_null()
}

fn (mut this Class_wp_xmlrpc_server) blogger_getuserinfo(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
	this.escape(var_args_mutated.clone())
	mut var_username := var_args_mutated.array_get(rt.new_int(1))
	mut var_password := var_args_mutated.array_get(rt.new_int(2))
	mut var_user := rt.new_bool(this.login(var_username.clone(), var_password.clone()))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_user)))) {
		return this.error
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('edit_posts'),
	])))))
	{
		return create_ixr_error(rt.new_int(401), rt.call_function('__', [
			rt.new_string('Sorry, you are not allowed to access user data on this site.'),
		]))
	}
	rt.call_function('do_action', [rt.new_string('xmlrpc_call'),
		rt.new_string('blogger.getUserInfo'), var_args_mutated.clone(),
		rt.new_object('wp_xmlrpc_server', ['IXR_Server'], &this)])
	mut var_struct := rt.create_array([
		rt.ArrayItem{ key: 'nickname', val: rt.get_property(var_user, 'nickname') },
		rt.ArrayItem{ key: 'userid', val: rt.get_property(var_user, 'ID') },
		rt.ArrayItem{ key: 'url', val: rt.get_property(var_user, 'user_url') },
		rt.ArrayItem{ key: 'lastname', val: rt.get_property(var_user, 'last_name') },
		rt.ArrayItem{ key: 'firstname', val: rt.get_property(var_user, 'first_name') },
	])
	return var_struct.clone()
}

fn (mut this Class_wp_xmlrpc_server) blogger_getpost(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
	this.escape(var_args_mutated.clone())
	mut var_post_id := rt.new_int((var_args_mutated.array_get(rt.new_int(1))).to_i64())
	mut var_username := var_args_mutated.array_get(rt.new_int(2))
	mut var_password := var_args_mutated.array_get(rt.new_int(3))
	mut var_user := rt.new_bool(this.login(var_username.clone(), var_password.clone()))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_user)))) {
		return this.error
	}
	mut var_post_data := rt.call_function('get_post', [var_post_id.clone(),
		rt.get_constant('ARRAY_A')])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_post_data)))) {
		return create_ixr_error(rt.new_int(404), rt.call_function('__', [
			rt.new_string('Invalid post ID.'),
		]))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('edit_post'),
		var_post_id.clone(),
	])))))
	{
		return create_ixr_error(rt.new_int(401), rt.call_function('__', [
			rt.new_string('Sorry, you are not allowed to edit this post.'),
		]))
	}
	rt.call_function('do_action', [rt.new_string('xmlrpc_call'),
		rt.new_string('blogger.getPost'), var_args_mutated.clone(),
		rt.new_object('wp_xmlrpc_server', ['IXR_Server'], &this)])
	mut var_categories := rt.call_function('implode', [rt.new_string(','),
		rt.call_function('wp_get_post_categories', [var_post_id.clone()])])
	mut var_content := rt.new_string('<title>' +
		(rt.call_function('wp_unslash', [var_post_data.array_get(rt.new_string('post_title'))])).str() +
		'</title>')
	var_content = rt.concat(var_content, rt.new_string('<category>' + var_categories.str() +
		'</category>'))
	var_content = rt.concat(var_content, rt.call_function('wp_unslash', [
		var_post_data.array_get(rt.new_string('post_content')),
	]))
	mut var_struct := rt.create_array([
		rt.ArrayItem{ key: 'userid', val: var_post_data.array_get(rt.new_string('post_author')) },
		rt.ArrayItem{
			key: 'dateCreated'
			val: this._convert_date(var_post_data.array_get(rt.new_string('post_date')))
		},
		rt.ArrayItem{ key: 'content', val: var_content },
		rt.ArrayItem{ key: 'postid', val: (var_post_data.array_get(rt.new_string('ID'))).str() },
	])
	return var_struct.clone()
}

fn (mut this Class_wp_xmlrpc_server) blogger_getrecentposts(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
	this.escape(var_args_mutated.clone())
	mut var_username := var_args_mutated.array_get(rt.new_int(2))
	mut var_password := var_args_mutated.array_get(rt.new_int(3))
	if var_args_mutated.array_isset(rt.new_int(4)) {
		mut var_query := {
			'numberposts': rt.call_function('absint', [var_args_mutated.array_get(rt.new_int(4))])
		}
	} else {
		var_query = []rt.PhpVal{}
	}
	mut var_user := rt.new_bool(this.login(var_username.clone(), var_password.clone()))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_user)))) {
		return this.error
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('edit_posts'),
	])))))
	{
		return create_ixr_error(rt.new_int(401), rt.call_function('__', [
			rt.new_string('Sorry, you are not allowed to edit posts.'),
		]))
	}
	rt.call_function('do_action', [rt.new_string('xmlrpc_call'),
		rt.new_string('blogger.getRecentPosts'), var_args_mutated.clone(),
		rt.new_object('wp_xmlrpc_server', ['IXR_Server'], &this)])
	mut var_posts_list := rt.call_function('wp_get_recent_posts', [
		rt.create_array_from_native_map(var_query),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_posts_list)))) {
		this.error = create_ixr_error(rt.new_int(500), rt.call_function('__', [
			rt.new_string('No posts found or an error occurred while retrieving posts.'),
		]))
		return this.error
	}
	mut var_recent_posts := []rt.PhpVal{}
	mut iter_28 := var_posts_list.iterator()
	for {
		item_28 := iter_28.next() or { break }
		mut var_entry := item_28.val
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
			rt.new_string('edit_post'),
			var_entry.array_get(rt.new_string('ID')),
		])))))
		{
			continue
		}
		mut var_post_date := this._convert_date(var_entry.array_get(rt.new_string('post_date')))
		mut var_categories := rt.call_function('implode', [rt.new_string(','),
			rt.call_function('wp_get_post_categories', [
				var_entry.array_get(rt.new_string('ID')),
			])])
		mut var_content := rt.new_string('<title>' +
			(rt.call_function('wp_unslash', [var_entry.array_get(rt.new_string('post_title'))])).str() +
			'</title>')
		var_content = rt.concat(var_content, rt.new_string('<category>' + var_categories.str() +
			'</category>'))
		var_content = rt.concat(var_content, rt.call_function('wp_unslash', [
			var_entry.array_get(rt.new_string('post_content')),
		]))
		var_recent_posts << rt.create_array([
			rt.ArrayItem{ key: 'userid', val: var_entry.array_get(rt.new_string('post_author')) },
			rt.ArrayItem{ key: 'dateCreated', val: var_post_date },
			rt.ArrayItem{ key: 'content', val: var_content },
			rt.ArrayItem{ key: 'postid', val: (var_entry.array_get(rt.new_string('ID'))).str() },
		])
	}
	return var_recent_posts.clone()
}

fn (mut this Class_wp_xmlrpc_server) blogger_gettemplate(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
	return rt.new_object('IXR_Error', []string{}, create_ixr_error(rt.new_int(403), rt.call_function('__', [
		rt.new_string('Sorry, this method is not supported.'),
	])))
}

fn (mut this Class_wp_xmlrpc_server) blogger_settemplate(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
	return rt.new_object('IXR_Error', []string{}, create_ixr_error(rt.new_int(403), rt.call_function('__', [
		rt.new_string('Sorry, this method is not supported.'),
	])))
}

fn (mut this Class_wp_xmlrpc_server) blogger_newpost(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
	this.escape(var_args_mutated.clone())
	mut var_username := var_args_mutated.array_get(rt.new_int(2))
	mut var_password := var_args_mutated.array_get(rt.new_int(3))
	mut var_content := var_args_mutated.array_get(rt.new_int(4))
	mut var_publish := var_args_mutated.array_get(rt.new_int(5))
	mut var_user := rt.new_bool(this.login(var_username.clone(), var_password.clone()))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_user)))) {
		return this.error
	}
	rt.call_function('do_action', [rt.new_string('xmlrpc_call'),
		rt.new_string('blogger.newPost'), var_args_mutated.clone(),
		rt.new_object('wp_xmlrpc_server', ['IXR_Server'], &this)])
	mut var_cap := rt.new_string((if rt.is_true(var_publish) {
		'publish_posts'
	} else {
		'edit_posts'
	}).str())
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.get_property(rt.get_property(rt.call_function('get_post_type_object', [rt.new_string('post')]), 'cap'), 'create_posts')])))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [var_cap.clone()]))))) {
		return rt.new_object('IXR_Error', []string{}, create_ixr_error(rt.new_int(401), rt.call_function('__', [
			rt.new_string('Sorry, you are not allowed to post on this site.'),
		])))
	}
	mut var_post_status :=
		rt.new_string((if rt.is_true(var_publish) { 'publish' } else { 'draft' }).str())
	mut var_post_author := rt.get_property(var_user, 'ID')
	mut var_post_title := rt.call_function('xmlrpc_getposttitle', [
		var_content.clone()])
	mut var_post_category := rt.call_function('xmlrpc_getpostcategory', [
		var_content.clone()])
	mut var_post_content := rt.call_function('xmlrpc_removepostdata', [
		var_content.clone()])
	mut var_post_date := rt.call_function('current_time', [rt.new_string('mysql')])
	mut var_post_date_gmt := rt.call_function('current_time', [
		rt.new_string('mysql'), rt.new_bool(true)])
	mut var_post_data := rt.call_function('compact', [rt.new_string('post_author'),
		rt.new_string('post_date'), rt.new_string('post_date_gmt'),
		rt.new_string('post_content'), rt.new_string('post_title'),
		rt.new_string('post_category'), rt.new_string('post_status')])
	mut var_post_id := rt.call_function('wp_insert_post', [var_post_data.clone()])
	if rt.is_true(rt.call_function('is_wp_error', [var_post_id.clone()])) {
		return rt.new_object('IXR_Error', []string{}, create_ixr_error(rt.new_int(500), rt.call_method(var_post_id,
			'get_error_message', []rt.PhpVal{})))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_post_id)))) {
		return rt.new_object('IXR_Error', []string{}, create_ixr_error(rt.new_int(500), rt.call_function('__', [
			rt.new_string('Sorry, the post could not be created.'),
		])))
	}
	this.attach_uploads(var_post_id.clone(), var_post_content.clone())
	rt.call_function('do_action', [rt.new_string('xmlrpc_call_success_blogger_newPost'),
		var_post_id.clone(), var_args_mutated.clone()])
	return var_post_id.clone()
}

fn (mut this Class_wp_xmlrpc_server) blogger_editpost(var_args rt.PhpVal) bool {
	mut var_args_mutated := var_args
	this.escape(var_args_mutated.clone())
	mut var_post_id := rt.new_int((var_args_mutated.array_get(rt.new_int(1))).to_i64())
	mut var_username := var_args_mutated.array_get(rt.new_int(2))
	mut var_password := var_args_mutated.array_get(rt.new_int(3))
	mut var_content := var_args_mutated.array_get(rt.new_int(4))
	mut var_publish := var_args_mutated.array_get(rt.new_int(5))
	mut var_user := rt.new_bool(this.login(var_username.clone(), var_password.clone()))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_user)))) {
		return (this.error).to_bool()
	}
	rt.call_function('do_action', [rt.new_string('xmlrpc_call'),
		rt.new_string('blogger.editPost'), var_args_mutated.clone(),
		rt.new_object('wp_xmlrpc_server', ['IXR_Server'], &this)])
	mut var_actual_post := rt.call_function('get_post', [var_post_id.clone(),
		rt.get_constant('ARRAY_A')])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_actual_post))))
		|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('post'), var_actual_post.array_get(rt.new_string('post_type')))))) {
		return (create_ixr_error(rt.new_int(404), rt.call_function('__', [
			rt.new_string('Sorry, no such post.'),
		]))).to_bool()
	}
	this.escape(var_actual_post.clone())
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('edit_post'),
		var_post_id.clone(),
	])))))
	{
		return (create_ixr_error(rt.new_int(401), rt.call_function('__', [
			rt.new_string('Sorry, you are not allowed to edit this post.'),
		]))).to_bool()
	}
	if rt.is_true(rt.identical(rt.new_string('publish'), var_actual_post.array_get(rt.new_string('post_status'))))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('publish_posts')]))))) {
		return (create_ixr_error(rt.new_int(401), rt.call_function('__', [
			rt.new_string('Sorry, you are not allowed to publish this post.'),
		]))).to_bool()
	}
	mut var_postdata := []rt.PhpVal{}
	var_postdata.array_set('ID', var_actual_post.array_get(rt.new_string('ID')))
	var_postdata.array_set('post_content', rt.call_function('xmlrpc_removepostdata', [
		var_content.clone(),
	]))
	var_postdata.array_set('post_title', rt.call_function('xmlrpc_getposttitle', [
		var_content.clone(),
	]))
	var_postdata.array_set('post_category', rt.call_function('xmlrpc_getpostcategory', [
		var_content.clone(),
	]))
	var_postdata.array_set('post_status', var_actual_post.array_get(rt.new_string('post_status')))
	var_postdata.array_set('post_excerpt', var_actual_post.array_get(rt.new_string('post_excerpt')))
	var_postdata.array_set('post_status', if rt.is_true(var_publish) { 'publish' } else { 'draft' })
	mut var_result := rt.call_function('wp_update_post', [var_postdata.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_result)))) {
		return (create_ixr_error(rt.new_int(500), rt.call_function('__', [
			rt.new_string('Sorry, the post could not be updated.'),
		]))).to_bool()
	}
	this.attach_uploads(var_actual_post.array_get(rt.new_string('ID')),
		var_postdata.array_get(rt.new_string('post_content')))
	rt.call_function('do_action', [rt.new_string('xmlrpc_call_success_blogger_editPost'),
		var_post_id.clone(), var_args_mutated.clone()])
	return true
}

fn (mut this Class_wp_xmlrpc_server) blogger_deletepost(var_args rt.PhpVal) bool {
	mut var_args_mutated := var_args
	this.escape(var_args_mutated.clone())
	mut var_post_id := rt.new_int((var_args_mutated.array_get(rt.new_int(1))).to_i64())
	mut var_username := var_args_mutated.array_get(rt.new_int(2))
	mut var_password := var_args_mutated.array_get(rt.new_int(3))
	mut var_user := rt.new_bool(this.login(var_username.clone(), var_password.clone()))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_user)))) {
		return (this.error).to_bool()
	}
	rt.call_function('do_action', [rt.new_string('xmlrpc_call'),
		rt.new_string('blogger.deletePost'), var_args_mutated.clone(),
		rt.new_object('wp_xmlrpc_server', ['IXR_Server'], &this)])
	mut var_actual_post := rt.call_function('get_post', [var_post_id.clone(),
		rt.get_constant('ARRAY_A')])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_actual_post))))
		|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('post'), var_actual_post.array_get(rt.new_string('post_type')))))) {
		return (create_ixr_error(rt.new_int(404), rt.call_function('__', [
			rt.new_string('Sorry, no such post.'),
		]))).to_bool()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('delete_post'),
		var_post_id.clone(),
	])))))
	{
		return (create_ixr_error(rt.new_int(401), rt.call_function('__', [
			rt.new_string('Sorry, you are not allowed to delete this post.'),
		]))).to_bool()
	}
	mut var_result := rt.call_function('wp_delete_post', [var_post_id.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_result)))) {
		return (create_ixr_error(rt.new_int(500), rt.call_function('__', [
			rt.new_string('Sorry, the post could not be deleted.'),
		]))).to_bool()
	}
	rt.call_function('do_action', [
		rt.new_string('xmlrpc_call_success_blogger_deletePost'),
		var_post_id.clone(),
		var_args_mutated.clone(),
	])
	return true
}

fn (mut this Class_wp_xmlrpc_server) mw_newpost(var_args rt.PhpVal) string {
	mut var_args_mutated := var_args
	this.escape(var_args_mutated.clone())
	mut var_username := var_args_mutated.array_get(rt.new_int(1))
	mut var_password := var_args_mutated.array_get(rt.new_int(2))
	mut var_content_struct := var_args_mutated.array_get(rt.new_int(3))
	mut var_publish := if !(var_args_mutated.array_get(rt.new_int(4))).is_null() {
		var_args_mutated.array_get(rt.new_int(4))
	} else {
		rt.new_int(0)
	}
	mut var_user := rt.new_bool(this.login(var_username.clone(), var_password.clone()))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_user)))) {
		return (this.error).str()
	}
	rt.call_function('do_action', [rt.new_string('xmlrpc_call'),
		rt.new_string('metaWeblog.newPost'), var_args_mutated.clone(),
		rt.new_object('wp_xmlrpc_server', ['IXR_Server'], &this)])
	mut var_page_template := rt.new_string('')
	if !(!rt.is_true(var_content_struct.array_get(rt.new_string('post_type')))) {
		if rt.is_true(rt.identical(rt.new_string('page'),
			var_content_struct.array_get(rt.new_string('post_type'))))
		{
			if rt.is_true(var_publish) {
				mut var_cap := rt.new_string('publish_pages')
			} else if var_content_struct.array_isset(rt.new_string('page_status'))
				&& rt.is_true(rt.identical(rt.new_string('publish'), var_content_struct.array_get(rt.new_string('page_status')))) {
				var_cap = rt.new_string('publish_pages')
			} else {
				var_cap = rt.new_string('edit_pages')
			}
			mut var_error_message := rt.call_function('__', [
				rt.new_string('Sorry, you are not allowed to publish pages on this site.'),
			])
			mut var_post_type := rt.new_string('page')
			if !(!rt.is_true(var_content_struct.array_get(rt.new_string('wp_page_template')))) {
				var_page_template = var_content_struct.array_get(rt.new_string('wp_page_template'))
			}
		} else if rt.is_true(rt.identical(rt.new_string('post'),
			var_content_struct.array_get(rt.new_string('post_type'))))
		{
			if rt.is_true(var_publish) {
				var_cap = rt.new_string('publish_posts')
			} else if var_content_struct.array_isset(rt.new_string('post_status'))
				&& rt.is_true(rt.identical(rt.new_string('publish'), var_content_struct.array_get(rt.new_string('post_status')))) {
				var_cap = rt.new_string('publish_posts')
			} else {
				var_cap = rt.new_string('edit_posts')
			}
			var_error_message = rt.call_function('__', [
				rt.new_string('Sorry, you are not allowed to publish posts on this site.'),
			])
			var_post_type = rt.new_string('post')
		} else {
			return (create_ixr_error(rt.new_int(401), rt.call_function('__', [
				rt.new_string('Invalid post type.'),
			]))).str()
		}
	} else {
		if rt.is_true(var_publish) {
			var_cap = rt.new_string('publish_posts')
		} else if var_content_struct.array_isset(rt.new_string('post_status'))
			&& rt.is_true(rt.identical(rt.new_string('publish'), var_content_struct.array_get(rt.new_string('post_status')))) {
			var_cap = rt.new_string('publish_posts')
		} else {
			var_cap = rt.new_string('edit_posts')
		}
		var_error_message = rt.call_function('__', [
			rt.new_string('Sorry, you are not allowed to publish posts on this site.'),
		])
		var_post_type = rt.new_string('post')
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.get_property(rt.get_property(rt.call_function('get_post_type_object', [
			var_post_type.clone(),
		]), 'cap'), 'create_posts'),
	])))))
	{
		return (create_ixr_error(rt.new_int(401), rt.call_function('__', [
			rt.new_string('Sorry, you are not allowed to publish posts on this site.'),
		]))).str()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		var_cap.clone(),
	])))))
	{
		return (create_ixr_error(rt.new_int(401), var_error_message.clone())).str()
	}
	if var_content_struct.array_isset(rt.new_string('wp_post_format')) {
		var_content_struct.array_set('wp_post_format', rt.call_function('sanitize_key', [
			var_content_struct.array_get(rt.new_string('wp_post_format')),
		]))
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.call_function('get_post_format_strings',
			[]rt.PhpVal{}).array_isset(var_content_struct.array_get(rt.new_string('wp_post_format'))))))))
		{
			return (create_ixr_error(rt.new_int(404), rt.call_function('__', [
				rt.new_string('Invalid post format.'),
			]))).str()
		}
	}
	mut var_post_name := rt.new_null()
	if var_content_struct.array_isset(rt.new_string('wp_slug')) {
		var_post_name = var_content_struct.array_get(rt.new_string('wp_slug'))
	}
	mut var_post_password := rt.new_string('')
	if var_content_struct.array_isset(rt.new_string('wp_password')) {
		var_post_password = var_content_struct.array_get(rt.new_string('wp_password'))
	}
	mut var_post_parent := rt.new_int(0)
	if var_content_struct.array_isset(rt.new_string('wp_page_parent_id')) {
		var_post_parent = var_content_struct.array_get(rt.new_string('wp_page_parent_id'))
	}
	mut var_menu_order := rt.new_int(0)
	if var_content_struct.array_isset(rt.new_string('wp_page_order')) {
		var_menu_order = var_content_struct.array_get(rt.new_string('wp_page_order'))
	}
	mut var_post_author := rt.get_property(var_user, 'ID')
	if var_content_struct.array_isset(rt.new_string('wp_author_id'))
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.get_property(var_user, 'ID'), rt.new_int((var_content_struct.array_get(rt.new_string('wp_author_id'))).to_i64()))))) {
		mut switch_val_2 := var_post_type
		if rt.is_true(rt.equal(switch_val_2, rt.new_string('post'))) {
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
				rt.new_string('edit_others_posts'),
			])))))
			{
				return (create_ixr_error(rt.new_int(401), rt.call_function('__', [
					rt.new_string('Sorry, you are not allowed to create posts as this user.'),
				]))).str()
			}
		} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('page'))) {
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
				rt.new_string('edit_others_pages'),
			])))))
			{
				return (create_ixr_error(rt.new_int(401), rt.call_function('__', [
					rt.new_string('Sorry, you are not allowed to create pages as this user.'),
				]))).str()
			}
		} else {
			return (create_ixr_error(rt.new_int(401), rt.call_function('__', [
				rt.new_string('Invalid post type.'),
			]))).str()
		}
		mut var_author := rt.call_function('get_userdata', [
			var_content_struct.array_get(rt.new_string('wp_author_id')),
		])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_author)))) {
			return (create_ixr_error(rt.new_int(404), rt.call_function('__', [
				rt.new_string('Invalid author ID.'),
			]))).str()
		}
		var_post_author = var_content_struct.array_get(rt.new_string('wp_author_id'))
	}
	mut var_post_title := if !(var_content_struct.array_get(rt.new_string('title'))).is_null() {
		var_content_struct.array_get(rt.new_string('title'))
	} else {
		rt.new_string('')
	}
	mut var_post_content := if !(var_content_struct.array_get(rt.new_string('description'))).is_null() {
		var_content_struct.array_get(rt.new_string('description'))
	} else {
		rt.new_string('')
	}
	mut var_post_status :=
		rt.new_string((if rt.is_true(var_publish) { 'publish' } else { 'draft' }).str())
	if var_content_struct.array_isset(rt.new_string('${var_post_type.to_string()}_status')) {
		mut switch_val_3 :=
			var_content_struct.array_get(rt.new_string('${var_post_type.to_string()}_status'))
		if rt.is_true(rt.equal(switch_val_3, rt.new_string('draft')))
			|| rt.is_true(rt.equal(switch_val_3, rt.new_string('pending')))
			|| rt.is_true(rt.equal(switch_val_3, rt.new_string('private')))
			|| rt.is_true(rt.equal(switch_val_3, rt.new_string('publish'))) {
			var_post_status =
				var_content_struct.array_get(rt.new_string('${var_post_type.to_string()}_status'))
		} else {
		}
	}
	mut var_post_excerpt := if !(var_content_struct.array_get(rt.new_string('mt_excerpt'))).is_null() {
		var_content_struct.array_get(rt.new_string('mt_excerpt'))
	} else {
		rt.new_string('')
	}
	mut var_post_more := if !(var_content_struct.array_get(rt.new_string('mt_text_more'))).is_null() {
		var_content_struct.array_get(rt.new_string('mt_text_more'))
	} else {
		rt.new_string('')
	}
	mut var_tags_input := if !(var_content_struct.array_get(rt.new_string('mt_keywords'))).is_null() {
		var_content_struct.array_get(rt.new_string('mt_keywords'))
	} else {
		[]rt.PhpVal{}
	}
	if var_content_struct.array_isset(rt.new_string('mt_allow_comments')) {
		if !(var_content_struct.array_get(rt.new_string('mt_allow_comments')).is_long()
			|| var_content_struct.array_get(rt.new_string('mt_allow_comments')).is_double()) {
			mut switch_val_4 := var_content_struct.array_get(rt.new_string('mt_allow_comments'))
			if rt.is_true(rt.equal(switch_val_4, rt.new_string('closed'))) {
				mut var_comment_status := rt.new_string('closed')
			} else if rt.is_true(rt.equal(switch_val_4, rt.new_string('open'))) {
				var_comment_status = rt.new_string('open')
			} else {
				var_comment_status = rt.call_function('get_default_comment_status', [
					var_post_type.clone(),
				])
			}
		} else {
			match rt.new_int((var_content_struct.array_get(rt.new_string('mt_allow_comments'))).to_i64()) {
				0, 2 {
					var_comment_status = rt.new_string('closed')
				}
				1 {
					var_comment_status = rt.new_string('open')
				}
				else {
					var_comment_status = rt.call_function('get_default_comment_status', [
						var_post_type.clone(),
					])
				}
			}
		}
	} else {
		var_comment_status = rt.call_function('get_default_comment_status', [
			var_post_type.clone()])
	}
	if var_content_struct.array_isset(rt.new_string('mt_allow_pings')) {
		if !(var_content_struct.array_get(rt.new_string('mt_allow_pings')).is_long()
			|| var_content_struct.array_get(rt.new_string('mt_allow_pings')).is_double()) {
			mut switch_val_6 := var_content_struct.array_get(rt.new_string('mt_allow_pings'))
			if rt.is_true(rt.equal(switch_val_6, rt.new_string('closed'))) {
				mut var_ping_status := rt.new_string('closed')
			} else if rt.is_true(rt.equal(switch_val_6, rt.new_string('open'))) {
				var_ping_status = rt.new_string('open')
			} else {
				var_ping_status = rt.call_function('get_default_comment_status', [
					var_post_type.clone(),
					rt.new_string('pingback'),
				])
			}
		} else {
			match rt.new_int((var_content_struct.array_get(rt.new_string('mt_allow_pings'))).to_i64()) {
				0 {
					var_ping_status = rt.new_string('closed')
				}
				1 {
					var_ping_status = rt.new_string('open')
				}
				else {
					var_ping_status = rt.call_function('get_default_comment_status', [
						var_post_type.clone(),
						rt.new_string('pingback'),
					])
				}
			}
		}
	} else {
		var_ping_status = rt.call_function('get_default_comment_status', [
			var_post_type.clone(), rt.new_string('pingback')])
	}
	if rt.is_true(var_post_more) {
		var_post_content = rt.concat(var_post_content, rt.new_string('<!--more-->' +
			var_post_more.str()))
	}
	mut var_to_ping := rt.new_string('')
	if var_content_struct.array_isset(rt.new_string('mt_tb_ping_urls')) {
		var_to_ping = var_content_struct.array_get(rt.new_string('mt_tb_ping_urls'))
		if rt.is_true(rt.new_bool(var_to_ping.clone().is_array())) {
			var_to_ping = rt.call_function('implode', [rt.new_string(' '),
				var_to_ping.clone()])
		}
	}
	if !(!rt.is_true(var_content_struct.array_get(rt.new_string('date_created_gmt')))) {
		mut var_date_created := rt.new_string((
			rt.call_method(var_content_struct.array_get(rt.new_string('date_created_gmt')), 'getIso', []rt.PhpVal{}).to_string().trim_right(' \t\n\r') +
			'Z').str())
	} else if !(!rt.is_true(var_content_struct.array_get(rt.new_string('dateCreated')))) {
		var_date_created = rt.call_method(var_content_struct.array_get(rt.new_string('dateCreated')),
			'getIso', []rt.PhpVal{})
	}
	mut var_post_date := rt.new_string('')
	mut var_post_date_gmt := rt.new_string('')
	if !(!rt.is_true(var_date_created)) {
		var_post_date = rt.call_function('iso8601_to_datetime', [
			var_date_created.clone()])
		var_post_date_gmt = rt.call_function('iso8601_to_datetime', [
			var_date_created.clone(), rt.new_string('gmt')])
	}
	mut var_post_category := []rt.PhpVal{}
	if var_content_struct.array_isset(rt.new_string('categories')) {
		mut var_catnames := var_content_struct.array_get(rt.new_string('categories'))
		if rt.is_true(rt.new_bool(var_catnames.clone().is_array())) {
			mut iter_29 := var_catnames.iterator()
			for {
				item_29 := iter_29.next() or { break }
				mut var_cat := item_29.val
				var_post_category.array_push(rt.call_function('get_cat_ID', [
					var_cat.clone()]))
			}
		}
	}
	mut var_postdata := rt.call_function('compact', [rt.new_string('post_author'),
		rt.new_string('post_date'), rt.new_string('post_date_gmt'),
		rt.new_string('post_content'), rt.new_string('post_title'),
		rt.new_string('post_category'), rt.new_string('post_status'),
		rt.new_string('post_excerpt'), rt.new_string('comment_status'),
		rt.new_string('ping_status'), rt.new_string('to_ping'),
		rt.new_string('post_type'), rt.new_string('post_name'),
		rt.new_string('post_password'), rt.new_string('post_parent'),
		rt.new_string('menu_order'), rt.new_string('tags_input'),
		rt.new_string('page_template')])
	mut var_post_id := rt.get_property(rt.call_function('get_default_post_to_edit', [
		var_post_type.clone(),
		rt.new_bool(true),
	]), 'ID')
	var_postdata.array_set('ID', var_post_id.clone())
	if rt.is_true(rt.identical(rt.new_string('post'), var_post_type))
		&& var_content_struct.array_isset(rt.new_string('sticky')) {
		mut var_data := var_postdata.clone()
		var_data.array_set('sticky', var_content_struct.array_get(rt.new_string('sticky')))
		mut var_error := this._toggle_sticky(var_data.clone(), false)
		if rt.is_true(var_error) {
			return var_error.str()
		}
	}
	if var_content_struct.array_isset(rt.new_string('custom_fields')) {
		this.set_custom_fields(var_post_id.clone(),
			var_content_struct.array_get(rt.new_string('custom_fields')))
	}
	if var_content_struct.array_isset(rt.new_string('wp_post_thumbnail')) {
		if rt.is_true(rt.identical(rt.call_function('set_post_thumbnail', [
			var_post_id.clone(), var_content_struct.array_get(rt.new_string('wp_post_thumbnail'))]),
			rt.new_bool(false)))
		{
			return (create_ixr_error(rt.new_int(404), rt.call_function('__', [
				rt.new_string('Invalid attachment ID.'),
			]))).str()
		}
		var_content_struct.array_unset(rt.new_string('wp_post_thumbnail'))
	}
	mut var_enclosure := if !(var_content_struct.array_get(rt.new_string('enclosure'))).is_null() {
		var_content_struct.array_get(rt.new_string('enclosure'))
	} else {
		rt.new_null()
	}
	this.add_enclosure_if_new(var_post_id.clone(), var_enclosure.clone())
	this.attach_uploads(var_post_id.clone(), var_post_content.clone())
	if var_content_struct.array_isset(rt.new_string('wp_post_format')) {
		rt.call_function('set_post_format', [var_post_id.clone(),
			var_content_struct.array_get(rt.new_string('wp_post_format'))])
	}
	var_post_id = rt.call_function('wp_insert_post', [var_postdata.clone(),
		rt.new_bool(true)])
	if rt.is_true(rt.call_function('is_wp_error', [var_post_id.clone()])) {
		return (create_ixr_error(rt.new_int(500), rt.call_method(var_post_id, 'get_error_message',
			[]rt.PhpVal{}))).str()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_post_id)))) {
		return (create_ixr_error(rt.new_int(500), rt.call_function('__', [
			rt.new_string('Sorry, the post could not be created.'),
		]))).str()
	}
	rt.call_function('do_action', [rt.new_string('xmlrpc_call_success_mw_newPost'),
		var_post_id.clone(), var_args_mutated.clone()])
	return var_post_id.str()
}

fn (mut this Class_wp_xmlrpc_server) add_enclosure_if_new(var_post_id rt.PhpVal, var_enclosure rt.PhpVal) {
	mut var_post_id_mutated := var_post_id
	mut var_enclosure_mutated := var_enclosure
	if var_enclosure_mutated.clone().is_array()
		&& var_enclosure_mutated.array_isset(rt.new_string('url'))
		&& var_enclosure_mutated.array_isset(rt.new_string('length'))
		&& var_enclosure_mutated.array_isset(rt.new_string('type')) {
		mut var_encstring := rt.new_string(
			(var_enclosure_mutated.array_get(rt.new_string('url'))).str() + '\n' + (var_enclosure_mutated.array_get(rt.new_string('length'))).str() + '\n' + (var_enclosure_mutated.array_get(rt.new_string('type'))).str() + '\n')
		mut var_found := rt.new_bool(false)
		mut var_enclosures := rt.call_function('get_post_meta', [
			var_post_id_mutated.clone(), rt.new_string('enclosure')])
		if rt.is_true(var_enclosures) {
			mut iter_30 := var_enclosures.iterator()
			for {
				item_30 := iter_30.next() or { break }
				mut var_enc := item_30.val
				if rt.is_true(rt.identical(rt.new_string(var_enc.clone().to_string().trim_right(' \t\n\r')),
					rt.new_string(var_encstring.clone().to_string().trim_right(' \t\n\r'))))
				{
					var_found = rt.new_bool(true)
					break
				}
			}
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(var_found)))) {
			rt.call_function('add_post_meta', [var_post_id_mutated.clone(),
				rt.new_string('enclosure'), var_encstring.clone()])
		}
	}
}

fn (mut this Class_wp_xmlrpc_server) attach_uploads(var_post_id rt.PhpVal, var_post_content rt.PhpVal) {
	mut var_wpdb := rt.new_null()
	mut var_post_id_mutated := var_post_id
	mut var_post_content_mutated := var_post_content
	mut var_attachments := rt.call_method(var_wpdb, 'get_results', [
		rt.concat(rt.concat(rt.new_string('SELECT ID, guid FROM '), rt.get_property(var_wpdb,
			'posts')), rt.new_string(" WHERE post_parent = '0' AND post_type = 'attachment'")),
	])
	if rt.is_true(rt.new_bool(var_attachments.clone().is_array())) {
		mut iter_31 := var_attachments.iterator()
		for {
			item_31 := iter_31.next() or { break }
			mut var_file := item_31.val
			if !(!rt.is_true(rt.get_property(var_file, 'guid')))
				&& rt.is_true(rt.call_function('str_contains', [var_post_content_mutated.clone(), rt.get_property(var_file, 'guid')])) {
				rt.call_method(var_wpdb, 'update', [rt.get_property(var_wpdb, 'posts'),
					rt.create_array([
						rt.ArrayItem{ key: 'post_parent', val: var_post_id_mutated },
					]),
					rt.create_array([
						rt.ArrayItem{ key: 'ID', val: rt.get_property(var_file, 'ID') },
					])])
			}
		}
	}
}

fn (mut this Class_wp_xmlrpc_server) mw_editpost(var_args rt.PhpVal) bool {
	mut var_args_mutated := var_args
	this.escape(var_args_mutated.clone())
	mut var_post_id := rt.new_int((var_args_mutated.array_get(rt.new_int(0))).to_i64())
	mut var_username := var_args_mutated.array_get(rt.new_int(1))
	mut var_password := var_args_mutated.array_get(rt.new_int(2))
	mut var_content_struct := var_args_mutated.array_get(rt.new_int(3))
	mut var_publish := if !(var_args_mutated.array_get(rt.new_int(4))).is_null() {
		var_args_mutated.array_get(rt.new_int(4))
	} else {
		rt.new_int(0)
	}
	mut var_user := rt.new_bool(this.login(var_username.clone(), var_password.clone()))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_user)))) {
		return (this.error).to_bool()
	}
	rt.call_function('do_action', [rt.new_string('xmlrpc_call'),
		rt.new_string('metaWeblog.editPost'), var_args_mutated.clone(),
		rt.new_object('wp_xmlrpc_server', ['IXR_Server'], &this)])
	mut var_postdata := rt.call_function('get_post', [var_post_id.clone(),
		rt.get_constant('ARRAY_A')])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_postdata))))
		|| !rt.is_true(var_postdata.array_get(rt.new_string('ID'))) {
		return (create_ixr_error(rt.new_int(404), rt.call_function('__', [
			rt.new_string('Invalid post ID.'),
		]))).to_bool()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('edit_post'),
		var_post_id.clone(),
	])))))
	{
		return (create_ixr_error(rt.new_int(401), rt.call_function('__', [
			rt.new_string('Sorry, you are not allowed to edit this post.'),
		]))).to_bool()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
		var_postdata.array_get(rt.new_string('post_type')),
		rt.create_array([rt.ArrayItem{ key: none, val: 'post' },
			rt.ArrayItem{ key: none, val: 'page' }]),
		rt.new_bool(true),
	])))))
	{
		return (create_ixr_error(rt.new_int(401), rt.call_function('__', [
			rt.new_string('Invalid post type.'),
		]))).to_bool()
	}
	if !(!rt.is_true(var_content_struct.array_get(rt.new_string('post_type'))))
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_content_struct.array_get(rt.new_string('post_type')), var_postdata.array_get(rt.new_string('post_type')))))) {
		return (create_ixr_error(rt.new_int(401), rt.call_function('__', [
			rt.new_string('The post type may not be changed.'),
		]))).to_bool()
	}
	if var_content_struct.array_isset(rt.new_string('wp_post_format')) {
		var_content_struct.array_set('wp_post_format', rt.call_function('sanitize_key', [
			var_content_struct.array_get(rt.new_string('wp_post_format')),
		]))
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.call_function('get_post_format_strings',
			[]rt.PhpVal{}).array_isset(var_content_struct.array_get(rt.new_string('wp_post_format'))))))))
		{
			return (create_ixr_error(rt.new_int(404), rt.call_function('__', [
				rt.new_string('Invalid post format.'),
			]))).to_bool()
		}
	}
	this.escape(var_postdata.clone())
	var_post_id = var_postdata.array_get(rt.new_string('ID'))
	mut var_post_content := var_postdata.array_get(rt.new_string('post_content'))
	mut var_post_title := var_postdata.array_get(rt.new_string('post_title'))
	mut var_post_excerpt := var_postdata.array_get(rt.new_string('post_excerpt'))
	mut var_post_password := var_postdata.array_get(rt.new_string('post_password'))
	mut var_post_parent := var_postdata.array_get(rt.new_string('post_parent'))
	mut var_post_type := var_postdata.array_get(rt.new_string('post_type'))
	mut var_menu_order := var_postdata.array_get(rt.new_string('menu_order'))
	mut var_ping_status := var_postdata.array_get(rt.new_string('ping_status'))
	mut var_comment_status := var_postdata.array_get(rt.new_string('comment_status'))
	mut var_post_name := var_postdata.array_get(rt.new_string('post_name'))
	if var_content_struct.array_isset(rt.new_string('wp_slug')) {
		var_post_name = var_content_struct.array_get(rt.new_string('wp_slug'))
	}
	if var_content_struct.array_isset(rt.new_string('wp_password')) {
		var_post_password = var_content_struct.array_get(rt.new_string('wp_password'))
	}
	if var_content_struct.array_isset(rt.new_string('wp_page_parent_id')) {
		var_post_parent = var_content_struct.array_get(rt.new_string('wp_page_parent_id'))
	}
	if var_content_struct.array_isset(rt.new_string('wp_page_order')) {
		var_menu_order = var_content_struct.array_get(rt.new_string('wp_page_order'))
	}
	mut var_page_template := rt.new_string('')
	if !(!rt.is_true(var_content_struct.array_get(rt.new_string('wp_page_template'))))
		&& rt.is_true(rt.identical(rt.new_string('page'), var_post_type)) {
		var_page_template = var_content_struct.array_get(rt.new_string('wp_page_template'))
	}
	mut var_post_author := var_postdata.array_get(rt.new_string('post_author'))
	if var_content_struct.array_isset(rt.new_string('wp_author_id')) {
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.get_property(var_user, 'ID'), rt.new_int((var_content_struct.array_get(rt.new_string('wp_author_id'))).to_i64())))))
			|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.get_property(var_user, 'ID'), rt.new_int(var_post_author.to_i64()))))) {
			mut switch_val_8 := var_post_type
			if rt.is_true(rt.equal(switch_val_8, rt.new_string('post'))) {
				if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
					rt.new_string('edit_others_posts'),
				])))))
				{
					return (create_ixr_error(rt.new_int(401), rt.call_function('__', [
						rt.new_string('Sorry, you are not allowed to change the post author as this user.'),
					]))).to_bool()
				}
			} else if rt.is_true(rt.equal(switch_val_8, rt.new_string('page'))) {
				if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
					rt.new_string('edit_others_pages'),
				])))))
				{
					return (create_ixr_error(rt.new_int(401), rt.call_function('__', [
						rt.new_string('Sorry, you are not allowed to change the page author as this user.'),
					]))).to_bool()
				}
			} else {
				return (create_ixr_error(rt.new_int(401), rt.call_function('__', [
					rt.new_string('Invalid post type.'),
				]))).to_bool()
			}
			var_post_author = var_content_struct.array_get(rt.new_string('wp_author_id'))
		}
	}
	if var_content_struct.array_isset(rt.new_string('mt_allow_comments')) {
		if !(var_content_struct.array_get(rt.new_string('mt_allow_comments')).is_long()
			|| var_content_struct.array_get(rt.new_string('mt_allow_comments')).is_double()) {
			mut switch_val_9 := var_content_struct.array_get(rt.new_string('mt_allow_comments'))
			if rt.is_true(rt.equal(switch_val_9, rt.new_string('closed'))) {
				var_comment_status = rt.new_string('closed')
			} else if rt.is_true(rt.equal(switch_val_9, rt.new_string('open'))) {
				var_comment_status = rt.new_string('open')
			} else {
				var_comment_status = rt.call_function('get_default_comment_status', [
					var_post_type.clone(),
				])
			}
		} else {
			match rt.new_int((var_content_struct.array_get(rt.new_string('mt_allow_comments'))).to_i64()) {
				0, 2 {
					var_comment_status = rt.new_string('closed')
				}
				1 {
					var_comment_status = rt.new_string('open')
				}
				else {
					var_comment_status = rt.call_function('get_default_comment_status', [
						var_post_type.clone(),
					])
				}
			}
		}
	}
	if var_content_struct.array_isset(rt.new_string('mt_allow_pings')) {
		if !(var_content_struct.array_get(rt.new_string('mt_allow_pings')).is_long()
			|| var_content_struct.array_get(rt.new_string('mt_allow_pings')).is_double()) {
			mut switch_val_11 := var_content_struct.array_get(rt.new_string('mt_allow_pings'))
			if rt.is_true(rt.equal(switch_val_11, rt.new_string('closed'))) {
				var_ping_status = rt.new_string('closed')
			} else if rt.is_true(rt.equal(switch_val_11, rt.new_string('open'))) {
				var_ping_status = rt.new_string('open')
			} else {
				var_ping_status = rt.call_function('get_default_comment_status', [
					var_post_type.clone(),
					rt.new_string('pingback'),
				])
			}
		} else {
			match rt.new_int((var_content_struct.array_get(rt.new_string('mt_allow_pings'))).to_i64()) {
				0 {
					var_ping_status = rt.new_string('closed')
				}
				1 {
					var_ping_status = rt.new_string('open')
				}
				else {
					var_ping_status = rt.call_function('get_default_comment_status', [
						var_post_type.clone(),
						rt.new_string('pingback'),
					])
				}
			}
		}
	}
	if var_content_struct.array_isset(rt.new_string('title')) {
		var_post_title = var_content_struct.array_get(rt.new_string('title'))
	}
	if var_content_struct.array_isset(rt.new_string('description')) {
		var_post_content = var_content_struct.array_get(rt.new_string('description'))
	}
	mut var_post_category := []rt.PhpVal{}
	if var_content_struct.array_isset(rt.new_string('categories')) {
		mut var_catnames := var_content_struct.array_get(rt.new_string('categories'))
		if rt.is_true(rt.new_bool(var_catnames.clone().is_array())) {
			mut iter_32 := var_catnames.iterator()
			for {
				item_32 := iter_32.next() or { break }
				mut var_cat := item_32.val
				var_post_category.array_push(rt.call_function('get_cat_ID', [
					var_cat.clone()]))
			}
		}
	}
	if var_content_struct.array_isset(rt.new_string('mt_excerpt')) {
		var_post_excerpt = var_content_struct.array_get(rt.new_string('mt_excerpt'))
	}
	mut var_post_more := if !(var_content_struct.array_get(rt.new_string('mt_text_more'))).is_null() {
		var_content_struct.array_get(rt.new_string('mt_text_more'))
	} else {
		rt.new_string('')
	}
	mut var_post_status :=
		rt.new_string((if rt.is_true(var_publish) { 'publish' } else { 'draft' }).str())
	if var_content_struct.array_isset(rt.new_string('${var_post_type.to_string()}_status')) {
		mut switch_val_13 :=
			var_content_struct.array_get(rt.new_string('${var_post_type.to_string()}_status'))
		if rt.is_true(rt.equal(switch_val_13, rt.new_string('draft')))
			|| rt.is_true(rt.equal(switch_val_13, rt.new_string('pending')))
			|| rt.is_true(rt.equal(switch_val_13, rt.new_string('private')))
			|| rt.is_true(rt.equal(switch_val_13, rt.new_string('publish'))) {
			var_post_status =
				var_content_struct.array_get(rt.new_string('${var_post_type.to_string()}_status'))
		} else {
			var_post_status = rt.new_string((if rt.is_true(var_publish) {
				'publish'
			} else {
				'draft'
			}).str())
		}
	}
	mut var_tags_input := if !(var_content_struct.array_get(rt.new_string('mt_keywords'))).is_null() {
		var_content_struct.array_get(rt.new_string('mt_keywords'))
	} else {
		[]rt.PhpVal{}
	}
	if rt.is_true(rt.identical(rt.new_string('publish'), var_post_status))
		|| rt.is_true(rt.identical(rt.new_string('private'), var_post_status)) {
		if rt.is_true(rt.identical(rt.new_string('page'), var_post_type))
			&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('publish_pages')]))))) {
			return (create_ixr_error(rt.new_int(401), rt.call_function('__', [
				rt.new_string('Sorry, you are not allowed to publish this page.'),
			]))).to_bool()
		} else if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
			rt.new_string('publish_posts'),
		])))))
		{
			return (create_ixr_error(rt.new_int(401), rt.call_function('__', [
				rt.new_string('Sorry, you are not allowed to publish this post.'),
			]))).to_bool()
		}
	}
	if rt.is_true(var_post_more) {
		var_post_content = rt.new_string(var_post_content.str() + '<!--more-->' +
			var_post_more.str())
	}
	mut var_to_ping := rt.new_string('')
	if var_content_struct.array_isset(rt.new_string('mt_tb_ping_urls')) {
		var_to_ping = var_content_struct.array_get(rt.new_string('mt_tb_ping_urls'))
		if rt.is_true(rt.new_bool(var_to_ping.clone().is_array())) {
			var_to_ping = rt.call_function('implode', [rt.new_string(' '),
				var_to_ping.clone()])
		}
	}
	if !(!rt.is_true(var_content_struct.array_get(rt.new_string('date_created_gmt')))) {
		mut var_date_created := rt.new_string((
			rt.call_method(var_content_struct.array_get(rt.new_string('date_created_gmt')), 'getIso', []rt.PhpVal{}).to_string().trim_right(' \t\n\r') +
			'Z').str())
	} else if !(!rt.is_true(var_content_struct.array_get(rt.new_string('dateCreated')))) {
		var_date_created = rt.call_method(var_content_struct.array_get(rt.new_string('dateCreated')),
			'getIso', []rt.PhpVal{})
	}
	mut var_edit_date := rt.new_bool(false)
	if !(!rt.is_true(var_date_created)) {
		mut var_post_date := rt.call_function('iso8601_to_datetime', [
			var_date_created.clone()])
		mut var_post_date_gmt := rt.call_function('iso8601_to_datetime', [
			var_date_created.clone(), rt.new_string('gmt')])
		var_edit_date = rt.new_bool(true)
	} else {
		var_post_date = var_postdata.array_get(rt.new_string('post_date'))
		var_post_date_gmt = var_postdata.array_get(rt.new_string('post_date_gmt'))
	}
	mut var_newpost := {
		'ID': var_post_id
	}
	var_newpost = rt.add(var_newpost, rt.call_function('compact', [
		rt.new_string('post_content'),
		rt.new_string('post_title'),
		rt.new_string('post_category'),
		rt.new_string('post_status'),
		rt.new_string('post_excerpt'),
		rt.new_string('comment_status'),
		rt.new_string('ping_status'),
		rt.new_string('edit_date'),
		rt.new_string('post_date'),
		rt.new_string('post_date_gmt'),
		rt.new_string('to_ping'),
		rt.new_string('post_name'),
		rt.new_string('post_password'),
		rt.new_string('post_parent'),
		rt.new_string('menu_order'),
		rt.new_string('post_author'),
		rt.new_string('tags_input'),
		rt.new_string('page_template'),
	]))
	mut var_result := rt.call_function('wp_update_post', [
		rt.create_array_from_native_map(var_newpost),
		rt.new_bool(true),
	])
	if rt.is_true(rt.call_function('is_wp_error', [var_result.clone()])) {
		return (create_ixr_error(rt.new_int(500), rt.call_method(var_result, 'get_error_message',
			[]rt.PhpVal{}))).to_bool()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_result)))) {
		return (create_ixr_error(rt.new_int(500), rt.call_function('__', [
			rt.new_string('Sorry, the post could not be updated.'),
		]))).to_bool()
	}
	if rt.is_true(rt.identical(rt.new_string('post'), var_post_type))
		&& var_content_struct.array_isset(rt.new_string('sticky')) {
		mut var_data := var_newpost.clone()
		var_data.array_set('sticky', var_content_struct.array_get(rt.new_string('sticky')))
		var_data.array_set('post_type', 'post')
		mut var_error := this._toggle_sticky(var_data.clone(), true)
		if rt.is_true(var_error) {
			return var_error.to_bool()
		}
	}
	if var_content_struct.array_isset(rt.new_string('custom_fields')) {
		this.set_custom_fields(var_post_id.clone(),
			var_content_struct.array_get(rt.new_string('custom_fields')))
	}
	if var_content_struct.array_isset(rt.new_string('wp_post_thumbnail')) {
		if !rt.is_true(var_content_struct.array_get(rt.new_string('wp_post_thumbnail'))) {
			rt.call_function('delete_post_thumbnail', [var_post_id.clone()])
		} else {
			if rt.is_true(rt.identical(rt.call_function('set_post_thumbnail', [
				var_post_id.clone(),
				var_content_struct.array_get(rt.new_string('wp_post_thumbnail')),
			]), rt.new_bool(false)))
			{
				return (create_ixr_error(rt.new_int(404), rt.call_function('__', [
					rt.new_string('Invalid attachment ID.'),
				]))).to_bool()
			}
		}
		var_content_struct.array_unset(rt.new_string('wp_post_thumbnail'))
	}
	mut var_enclosure := if !(var_content_struct.array_get(rt.new_string('enclosure'))).is_null() {
		var_content_struct.array_get(rt.new_string('enclosure'))
	} else {
		rt.new_null()
	}
	this.add_enclosure_if_new(var_post_id.clone(), var_enclosure.clone())
	this.attach_uploads(var_post_id.clone(), var_post_content.clone())
	if var_content_struct.array_isset(rt.new_string('wp_post_format')) {
		rt.call_function('set_post_format', [var_post_id.clone(),
			var_content_struct.array_get(rt.new_string('wp_post_format'))])
	}
	rt.call_function('do_action', [rt.new_string('xmlrpc_call_success_mw_editPost'),
		var_post_id.clone(), var_args_mutated.clone()])
	return true
}

fn (mut this Class_wp_xmlrpc_server) mw_getpost(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
	this.escape(var_args_mutated.clone())
	mut var_post_id := rt.new_int((var_args_mutated.array_get(rt.new_int(0))).to_i64())
	mut var_username := var_args_mutated.array_get(rt.new_int(1))
	mut var_password := var_args_mutated.array_get(rt.new_int(2))
	mut var_user := rt.new_bool(this.login(var_username.clone(), var_password.clone()))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_user)))) {
		return this.error
	}
	mut var_postdata := rt.call_function('get_post', [var_post_id.clone(),
		rt.get_constant('ARRAY_A')])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_postdata)))) {
		return create_ixr_error(rt.new_int(404), rt.call_function('__', [
			rt.new_string('Invalid post ID.'),
		]))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('edit_post'),
		var_post_id.clone(),
	])))))
	{
		return create_ixr_error(rt.new_int(401), rt.call_function('__', [
			rt.new_string('Sorry, you are not allowed to edit this post.'),
		]))
	}
	rt.call_function('do_action', [rt.new_string('xmlrpc_call'),
		rt.new_string('metaWeblog.getPost'), var_args_mutated.clone(),
		rt.new_object('wp_xmlrpc_server', ['IXR_Server'], &this)])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''),
		var_postdata.array_get(rt.new_string('post_date'))))))
	{
		mut var_post_date := this._convert_date(var_postdata.array_get(rt.new_string('post_date')))
		mut var_post_date_gmt := this._convert_date_gmt(var_postdata.array_get(rt.new_string('post_date_gmt')),
			var_postdata.array_get(rt.new_string('post_date')))
		mut var_post_modified :=
			this._convert_date(var_postdata.array_get(rt.new_string('post_modified')))
		mut var_post_modified_gmt := this._convert_date_gmt(var_postdata.array_get(rt.new_string('post_modified_gmt')),
			var_postdata.array_get(rt.new_string('post_modified')))
		mut var_categories := []rt.PhpVal{}
		mut var_cat_ids := rt.call_function('wp_get_post_categories', [
			var_post_id.clone()])
		mut iter_33 := var_cat_ids.iterator()
		for {
			item_33 := iter_33.next() or { break }
			mut var_cat_id := item_33.val
			var_categories.array_push(rt.call_function('get_cat_name', [
				var_cat_id.clone()]))
		}
		mut var_tagnames := []rt.PhpVal{}
		mut var_tags := rt.call_function('wp_get_post_tags', [
			var_post_id.clone()])
		if !(!rt.is_true(var_tags)) {
			mut iter_34 := var_tags.iterator()
			for {
				item_34 := iter_34.next() or { break }
				mut var_tag := item_34.val
				var_tagnames.array_push(rt.get_property(var_tag, 'name'))
			}
			var_tagnames = rt.call_function('implode', [rt.new_string(', '),
				var_tagnames.clone()])
		} else {
			var_tagnames = rt.new_string('')
		}
		mut var_post := rt.call_function('get_extended', [
			var_postdata.array_get(rt.new_string('post_content')),
		])
		mut var_link := rt.call_function('get_permalink', [
			var_postdata.array_get(rt.new_string('ID')),
		])
		mut var_author := rt.call_function('get_userdata', [
			var_postdata.array_get(rt.new_string('post_author')),
		])
		mut var_allow_comments := rt.new_int(if rt.is_true(rt.identical(rt.new_string('open'),
			var_postdata.array_get(rt.new_string('comment_status'))))
		{
			1
		} else {
			0
		})
		mut var_allow_pings := rt.new_int(if rt.is_true(rt.identical(rt.new_string('open'),
			var_postdata.array_get(rt.new_string('ping_status'))))
		{
			1
		} else {
			0
		})
		if rt.is_true(rt.identical(rt.new_string('future'),
			var_postdata.array_get(rt.new_string('post_status'))))
		{
			var_postdata.array_set('post_status', 'publish')
		}
		mut var_post_format := rt.call_function('get_post_format', [
			var_post_id.clone()])
		if !rt.is_true(var_post_format) {
			var_post_format = rt.new_string('standard')
		}
		mut var_sticky := rt.new_bool(false)
		if rt.is_true(rt.call_function('is_sticky', [var_post_id.clone()])) {
			var_sticky = rt.new_bool(true)
		}
		mut var_enclosure := []rt.PhpVal{}
		mut iter_35 := rt.cast_array(rt.call_function('get_post_custom', [
			var_post_id.clone()])).iterator()
		for {
			item_35 := iter_35.next() or { break }
			mut var_val := item_35.val
			mut var_key := item_35.key
			if rt.is_true(rt.identical(rt.new_string('enclosure'), var_key)) {
				mut iter_36 := rt.cast_array(var_val).iterator()
				for {
					item_36 := iter_36.next() or { break }
					mut var_enc := item_36.val
					mut var_encdata := rt.call_function('explode', [
						rt.new_string('\n'), var_enc.clone()])
					var_enclosure.array_set('url', rt.call_function('htmlspecialchars', [
						var_encdata.array_get(rt.new_int(0)),
					]).to_string().trim_space())
					var_enclosure.array_set('length',
						var_encdata.array_get(rt.new_int(1)).to_string().trim_space().i64())
					var_enclosure.array_set('type',
						var_encdata.array_get(rt.new_int(2)).to_string().trim_space())
					break
				}
			}
		}
		mut var_resp := {
			'dateCreated':            var_post_date
			'userid':                 var_postdata.array_get(rt.new_string('post_author'))
			'postid':                 var_postdata.array_get(rt.new_string('ID'))
			'description':            var_post.array_get(rt.new_string('main'))
			'title':                  var_postdata.array_get(rt.new_string('post_title'))
			'link':                   var_link
			'permaLink':              var_link
			'categories':             var_categories
			'mt_excerpt':             var_postdata.array_get(rt.new_string('post_excerpt'))
			'mt_text_more':           var_post.array_get(rt.new_string('extended'))
			'wp_more_text':           var_post.array_get(rt.new_string('more_text'))
			'mt_allow_comments':      var_allow_comments
			'mt_allow_pings':         var_allow_pings
			'mt_keywords':            var_tagnames
			'wp_slug':                var_postdata.array_get(rt.new_string('post_name'))
			'wp_password':            var_postdata.array_get(rt.new_string('post_password'))
			'wp_author_id':           (rt.get_property(var_author, 'ID')).str()
			'wp_author_display_name': rt.get_property(var_author, 'display_name')
			'date_created_gmt':       var_post_date_gmt
			'post_status':            var_postdata.array_get(rt.new_string('post_status'))
			'custom_fields':          this.get_custom_fields(var_post_id.clone())
			'wp_post_format':         var_post_format
			'sticky':                 var_sticky
			'date_modified':          var_post_modified
			'date_modified_gmt':      var_post_modified_gmt
		}
		if !(!rt.is_true(var_enclosure)) {
			var_resp['enclosure'] = var_enclosure.clone()
		}
		var_resp['wp_post_thumbnail'] = rt.call_function('get_post_thumbnail_id', [
			var_postdata.array_get(rt.new_string('ID')),
		])
		return var_resp.clone()
	} else {
		return create_ixr_error(rt.new_int(404), rt.call_function('__', [
			rt.new_string('Sorry, no such post.'),
		]))
	}
	return rt.new_null()
}

fn (mut this Class_wp_xmlrpc_server) mw_getrecentposts(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
	this.escape(var_args_mutated.clone())
	mut var_username := var_args_mutated.array_get(rt.new_int(1))
	mut var_password := var_args_mutated.array_get(rt.new_int(2))
	if var_args_mutated.array_isset(rt.new_int(3)) {
		mut var_query := {
			'numberposts': rt.call_function('absint', [var_args_mutated.array_get(rt.new_int(3))])
		}
	} else {
		var_query = []rt.PhpVal{}
	}
	mut var_user := rt.new_bool(this.login(var_username.clone(), var_password.clone()))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_user)))) {
		return this.error
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('edit_posts'),
	])))))
	{
		return rt.new_object('IXR_Error', []string{}, create_ixr_error(rt.new_int(401), rt.call_function('__', [
			rt.new_string('Sorry, you are not allowed to edit posts.'),
		])))
	}
	rt.call_function('do_action', [rt.new_string('xmlrpc_call'),
		rt.new_string('metaWeblog.getRecentPosts'), var_args_mutated.clone(),
		rt.new_object('wp_xmlrpc_server', ['IXR_Server'], &this)])
	mut var_posts_list := rt.call_function('wp_get_recent_posts', [
		rt.create_array_from_native_map(var_query),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_posts_list)))) {
		return []rt.PhpVal{}
	}
	mut var_recent_posts := []rt.PhpVal{}
	mut iter_37 := var_posts_list.iterator()
	for {
		item_37 := iter_37.next() or { break }
		mut var_entry := item_37.val
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
			rt.new_string('edit_post'),
			var_entry.array_get(rt.new_string('ID')),
		])))))
		{
			continue
		}
		mut var_post_date := this._convert_date(var_entry.array_get(rt.new_string('post_date')))
		mut var_post_date_gmt := this._convert_date_gmt(var_entry.array_get(rt.new_string('post_date_gmt')),
			var_entry.array_get(rt.new_string('post_date')))
		mut var_post_modified :=
			this._convert_date(var_entry.array_get(rt.new_string('post_modified')))
		mut var_post_modified_gmt := this._convert_date_gmt(var_entry.array_get(rt.new_string('post_modified_gmt')),
			var_entry.array_get(rt.new_string('post_modified')))
		mut var_categories := []rt.PhpVal{}
		mut var_cat_ids := rt.call_function('wp_get_post_categories', [
			var_entry.array_get(rt.new_string('ID')),
		])
		mut iter_38 := var_cat_ids.iterator()
		for {
			item_38 := iter_38.next() or { break }
			mut var_cat_id := item_38.val
			var_categories.array_push(rt.call_function('get_cat_name', [
				var_cat_id.clone()]))
		}
		mut var_tagnames := []rt.PhpVal{}
		mut var_tags := rt.call_function('wp_get_post_tags', [
			var_entry.array_get(rt.new_string('ID')),
		])
		if !(!rt.is_true(var_tags)) {
			mut iter_39 := var_tags.iterator()
			for {
				item_39 := iter_39.next() or { break }
				mut var_tag := item_39.val
				var_tagnames.array_push(rt.get_property(var_tag, 'name'))
			}
			var_tagnames = rt.call_function('implode', [rt.new_string(', '),
				var_tagnames.clone()])
		} else {
			var_tagnames = rt.new_string('')
		}
		mut var_post := rt.call_function('get_extended', [
			var_entry.array_get(rt.new_string('post_content')),
		])
		mut var_link := rt.call_function('get_permalink', [
			var_entry.array_get(rt.new_string('ID')),
		])
		mut var_author := rt.call_function('get_userdata', [
			var_entry.array_get(rt.new_string('post_author')),
		])
		mut var_allow_comments := rt.new_int(if rt.is_true(rt.identical(rt.new_string('open'),
			var_entry.array_get(rt.new_string('comment_status'))))
		{
			1
		} else {
			0
		})
		mut var_allow_pings := rt.new_int(if rt.is_true(rt.identical(rt.new_string('open'),
			var_entry.array_get(rt.new_string('ping_status'))))
		{
			1
		} else {
			0
		})
		if rt.is_true(rt.identical(rt.new_string('future'),
			var_entry.array_get(rt.new_string('post_status'))))
		{
			var_entry.array_set('post_status', 'publish')
		}
		mut var_post_format := rt.call_function('get_post_format', [
			var_entry.array_get(rt.new_string('ID')),
		])
		if !rt.is_true(var_post_format) {
			var_post_format = rt.new_string('standard')
		}
		var_recent_posts << rt.create_array([
			rt.ArrayItem{ key: 'dateCreated', val: var_post_date },
			rt.ArrayItem{ key: 'userid', val: var_entry.array_get(rt.new_string('post_author')) },
			rt.ArrayItem{ key: 'postid', val: (var_entry.array_get(rt.new_string('ID'))).str() },
			rt.ArrayItem{ key: 'description', val: var_post.array_get(rt.new_string('main')) },
			rt.ArrayItem{ key: 'title', val: var_entry.array_get(rt.new_string('post_title')) },
			rt.ArrayItem{ key: 'link', val: var_link },
			rt.ArrayItem{ key: 'permaLink', val: var_link },
			rt.ArrayItem{ key: 'categories', val: var_categories },
			rt.ArrayItem{ key: 'mt_excerpt', val: var_entry.array_get(rt.new_string('post_excerpt')) },
			rt.ArrayItem{ key: 'mt_text_more', val: var_post.array_get(rt.new_string('extended')) },
			rt.ArrayItem{ key: 'wp_more_text', val: var_post.array_get(rt.new_string('more_text')) },
			rt.ArrayItem{ key: 'mt_allow_comments', val: var_allow_comments },
			rt.ArrayItem{ key: 'mt_allow_pings', val: var_allow_pings },
			rt.ArrayItem{ key: 'mt_keywords', val: var_tagnames },
			rt.ArrayItem{ key: 'wp_slug', val: var_entry.array_get(rt.new_string('post_name')) },
			rt.ArrayItem{
				key: 'wp_password'
				val: var_entry.array_get(rt.new_string('post_password'))
			},
			rt.ArrayItem{ key: 'wp_author_id', val: (rt.get_property(var_author, 'ID')).str() },
			rt.ArrayItem{ key: 'wp_author_display_name', val: rt.get_property(var_author,
				'display_name') },
			rt.ArrayItem{ key: 'date_created_gmt', val: var_post_date_gmt },
			rt.ArrayItem{ key: 'post_status', val: var_entry.array_get(rt.new_string('post_status')) },
			rt.ArrayItem{
				key: 'custom_fields'
				val: this.get_custom_fields(var_entry.array_get(rt.new_string('ID')))
			},
			rt.ArrayItem{ key: 'wp_post_format', val: var_post_format },
			rt.ArrayItem{ key: 'date_modified', val: var_post_modified },
			rt.ArrayItem{ key: 'date_modified_gmt', val: var_post_modified_gmt },
			rt.ArrayItem{
				key: 'sticky'
				val:
					rt.is_true(rt.identical(rt.new_string('post'), var_entry.array_get(rt.new_string('post_type'))))
					&& rt.is_true(rt.call_function('is_sticky', [var_entry.array_get(rt.new_string('ID'))]))
			},
			rt.ArrayItem{ key: 'wp_post_thumbnail', val: rt.call_function('get_post_thumbnail_id', [
				var_entry.array_get(rt.new_string('ID')),
			]) },
		])
	}
	return var_recent_posts.clone()
}

fn (mut this Class_wp_xmlrpc_server) mw_getcategories(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
	this.escape(var_args_mutated.clone())
	mut var_username := var_args_mutated.array_get(rt.new_int(1))
	mut var_password := var_args_mutated.array_get(rt.new_int(2))
	mut var_user := rt.new_bool(this.login(var_username.clone(), var_password.clone()))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_user)))) {
		return this.error
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('edit_posts'),
	])))))
	{
		return create_ixr_error(rt.new_int(401), rt.call_function('__', [
			rt.new_string('Sorry, you must be able to edit posts on this site in order to view categories.'),
		]))
	}
	rt.call_function('do_action', [rt.new_string('xmlrpc_call'),
		rt.new_string('metaWeblog.getCategories'), var_args_mutated.clone(),
		rt.new_object('wp_xmlrpc_server', ['IXR_Server'], &this)])
	mut var_categories_struct := []rt.PhpVal{}
	mut var_cats := rt.call_function('get_categories', [
		rt.create_array([rt.ArrayItem{ key: 'get', val: 'all' }]),
	])
	if rt.is_true(var_cats) {
		mut iter_40 := var_cats.iterator()
		for {
			item_40 := iter_40.next() or { break }
			mut var_cat := item_40.val
			mut var_struct := []rt.PhpVal{}
			var_struct.array_set('categoryId', rt.get_property(var_cat, 'term_id'))
			var_struct.array_set('parentId', rt.get_property(var_cat, 'parent'))
			var_struct.array_set('description', rt.get_property(var_cat, 'name'))
			var_struct.array_set('categoryDescription', rt.get_property(var_cat, 'description'))
			var_struct.array_set('categoryName', rt.get_property(var_cat, 'name'))
			var_struct.array_set('htmlUrl', rt.call_function('esc_html', [
				rt.call_function('get_category_link', [
					rt.get_property(var_cat, 'term_id'),
				]),
			]))
			var_struct.array_set('rssUrl', rt.call_function('esc_html', [
				rt.call_function('get_category_feed_link', [
					rt.get_property(var_cat, 'term_id'),
					rt.new_string('rss2'),
				]),
			]))
			var_categories_struct << var_struct.clone()
		}
	}
	return var_categories_struct.clone()
}

fn (mut this Class_wp_xmlrpc_server) mw_newmediaobject(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
	mut var_username := this.escape(var_args_mutated.array_get(rt.new_int(1)))
	mut var_password := this.escape(var_args_mutated.array_get(rt.new_int(2)))
	mut var_data := var_args_mutated.array_get(rt.new_int(3))
	mut var_name := rt.call_function('sanitize_file_name', [
		var_data.array_get(rt.new_string('name')),
	])
	mut var_type := var_data.array_get(rt.new_string('type'))
	mut var_bits := var_data.array_get(rt.new_string('bits'))
	mut var_user := rt.new_bool(this.login(var_username.clone(), var_password.clone()))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_user)))) {
		return this.error
	}
	rt.call_function('do_action', [rt.new_string('xmlrpc_call'),
		rt.new_string('metaWeblog.newMediaObject'), var_args_mutated.clone(),
		rt.new_object('wp_xmlrpc_server', ['IXR_Server'], &this)])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('upload_files'),
	])))))
	{
		this.error = create_ixr_error(rt.new_int(401), rt.call_function('__', [
			rt.new_string('Sorry, you are not allowed to upload files.'),
		]))
		return this.error
	}
	if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{}))
		&& rt.is_true(rt.call_function('upload_is_user_over_quota', [rt.new_bool(false)])) {
		this.error = create_ixr_error(rt.new_int(401), rt.call_function('sprintf', [
			rt.call_function('__', [
				rt.new_string('Sorry, you have used your space allocation of %s. Please delete some files to upload more files.'),
			]),
			rt.call_function('size_format', [
				rt.mul(rt.call_function('get_space_allowed', []rt.PhpVal{}),
					rt.get_constant('MB_IN_BYTES')),
			]),
		]))
		return this.error
	}
	mut var_upload_err := rt.call_function('apply_filters', [
		rt.new_string('pre_upload_error'),
		rt.new_bool(false),
	])
	if rt.is_true(var_upload_err) {
		return create_ixr_error(rt.new_int(500), var_upload_err.clone())
	}
	mut var_upload := rt.call_function('wp_upload_bits', [var_name.clone(),
		rt.new_null(), var_bits.clone()])
	if !(!rt.is_true(var_upload.array_get(rt.new_string('error')))) {
		mut var_error_string := rt.call_function('sprintf', [
			rt.call_function('__', [rt.new_string('Could not write file %1$s (%2$s).')]),
			var_name.clone(),
			var_upload.array_get(rt.new_string('error')),
		])
		return create_ixr_error(rt.new_int(500), var_error_string.clone())
	}
	mut var_post_id := rt.new_int(0)
	if !(!rt.is_true(var_data.array_get(rt.new_string('post_id')))) {
		var_post_id = rt.new_int((var_data.array_get(rt.new_string('post_id'))).to_i64())
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
			rt.new_string('edit_post'),
			var_post_id.clone(),
		])))))
		{
			return create_ixr_error(rt.new_int(401), rt.call_function('__', [
				rt.new_string('Sorry, you are not allowed to edit this post.'),
			]))
		}
	}
	mut var_attachment := rt.create_array([
		rt.ArrayItem{ key: 'post_title', val: var_name },
		rt.ArrayItem{ key: 'post_content', val: '' },
		rt.ArrayItem{ key: 'post_type', val: 'attachment' },
		rt.ArrayItem{ key: 'post_parent', val: var_post_id },
		rt.ArrayItem{ key: 'post_mime_type', val: var_type },
		rt.ArrayItem{ key: 'guid', val: var_upload.array_get(rt.new_string('url')) },
	])
	mut var_attachment_id := rt.call_function('wp_insert_attachment', [
		var_attachment.clone(), var_upload.array_get(rt.new_string('file')),
		var_post_id.clone()])
	rt.call_function('wp_update_attachment_metadata', [var_attachment_id.clone(),
		rt.call_function('wp_generate_attachment_metadata', [
			var_attachment_id.clone(), var_upload.array_get(rt.new_string('file'))])])
	rt.call_function('do_action', [
		rt.new_string('xmlrpc_call_success_mw_newMediaObject'),
		var_attachment_id.clone(),
		var_args_mutated.clone(),
	])
	mut var_struct := this._prepare_media_item(rt.call_function('get_post', [
		var_attachment_id.clone()]), '')
	var_struct.array_set('id', var_struct.array_get(rt.new_string('attachment_id')))
	var_struct.array_set('file', var_struct.array_get(rt.new_string('title')))
	var_struct.array_set('url', var_struct.array_get(rt.new_string('link')))
	return var_struct.clone()
}

fn (mut this Class_wp_xmlrpc_server) mt_getrecentposttitles(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
	this.escape(var_args_mutated.clone())
	mut var_username := var_args_mutated.array_get(rt.new_int(1))
	mut var_password := var_args_mutated.array_get(rt.new_int(2))
	if var_args_mutated.array_isset(rt.new_int(3)) {
		mut var_query := {
			'numberposts': rt.call_function('absint', [var_args_mutated.array_get(rt.new_int(3))])
		}
	} else {
		var_query = []rt.PhpVal{}
	}
	mut var_user := rt.new_bool(this.login(var_username.clone(), var_password.clone()))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_user)))) {
		return this.error
	}
	rt.call_function('do_action', [rt.new_string('xmlrpc_call'),
		rt.new_string('mt.getRecentPostTitles'), var_args_mutated.clone(),
		rt.new_object('wp_xmlrpc_server', ['IXR_Server'], &this)])
	mut var_posts_list := rt.call_function('wp_get_recent_posts', [
		rt.create_array_from_native_map(var_query),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_posts_list)))) {
		this.error = create_ixr_error(rt.new_int(500), rt.call_function('__', [
			rt.new_string('No posts found or an error occurred while retrieving posts.'),
		]))
		return this.error
	}
	mut var_recent_posts := []rt.PhpVal{}
	mut iter_41 := var_posts_list.iterator()
	for {
		item_41 := iter_41.next() or { break }
		mut var_entry := item_41.val
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
			rt.new_string('edit_post'),
			var_entry.array_get(rt.new_string('ID')),
		])))))
		{
			continue
		}
		mut var_post_date := this._convert_date(var_entry.array_get(rt.new_string('post_date')))
		mut var_post_date_gmt := this._convert_date_gmt(var_entry.array_get(rt.new_string('post_date_gmt')),
			var_entry.array_get(rt.new_string('post_date')))
		var_recent_posts << rt.create_array([
			rt.ArrayItem{ key: 'dateCreated', val: var_post_date },
			rt.ArrayItem{ key: 'userid', val: var_entry.array_get(rt.new_string('post_author')) },
			rt.ArrayItem{ key: 'postid', val: (var_entry.array_get(rt.new_string('ID'))).str() },
			rt.ArrayItem{ key: 'title', val: var_entry.array_get(rt.new_string('post_title')) },
			rt.ArrayItem{ key: 'post_status', val: var_entry.array_get(rt.new_string('post_status')) },
			rt.ArrayItem{ key: 'date_created_gmt', val: var_post_date_gmt },
		])
	}
	return var_recent_posts.clone()
}

fn (mut this Class_wp_xmlrpc_server) mt_getcategorylist(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
	this.escape(var_args_mutated.clone())
	mut var_username := var_args_mutated.array_get(rt.new_int(1))
	mut var_password := var_args_mutated.array_get(rt.new_int(2))
	mut var_user := rt.new_bool(this.login(var_username.clone(), var_password.clone()))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_user)))) {
		return this.error
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('edit_posts'),
	])))))
	{
		return create_ixr_error(rt.new_int(401), rt.call_function('__', [
			rt.new_string('Sorry, you must be able to edit posts on this site in order to view categories.'),
		]))
	}
	rt.call_function('do_action', [rt.new_string('xmlrpc_call'),
		rt.new_string('mt.getCategoryList'), var_args_mutated.clone(),
		rt.new_object('wp_xmlrpc_server', ['IXR_Server'], &this)])
	mut var_categories_struct := []rt.PhpVal{}
	mut var_cats := rt.call_function('get_categories', [
		rt.create_array([rt.ArrayItem{ key: 'hide_empty', val: 0 },
			rt.ArrayItem{ key: 'hierarchical', val: 0 }]),
	])
	if rt.is_true(var_cats) {
		mut iter_42 := var_cats.iterator()
		for {
			item_42 := iter_42.next() or { break }
			mut var_cat := item_42.val
			mut var_struct := []rt.PhpVal{}
			var_struct.array_set('categoryId', rt.get_property(var_cat, 'term_id'))
			var_struct.array_set('categoryName', rt.get_property(var_cat, 'name'))
			var_categories_struct << var_struct.clone()
		}
	}
	return var_categories_struct.clone()
}

fn (mut this Class_wp_xmlrpc_server) mt_getpostcategories(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
	this.escape(var_args_mutated.clone())
	mut var_post_id := rt.new_int((var_args_mutated.array_get(rt.new_int(0))).to_i64())
	mut var_username := var_args_mutated.array_get(rt.new_int(1))
	mut var_password := var_args_mutated.array_get(rt.new_int(2))
	mut var_user := rt.new_bool(this.login(var_username.clone(), var_password.clone()))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_user)))) {
		return this.error
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('get_post', [
		var_post_id.clone()])))))
	{
		return create_ixr_error(rt.new_int(404), rt.call_function('__', [
			rt.new_string('Invalid post ID.'),
		]))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('edit_post'),
		var_post_id.clone(),
	])))))
	{
		return create_ixr_error(rt.new_int(401), rt.call_function('__', [
			rt.new_string('Sorry, you are not allowed to edit this post.'),
		]))
	}
	rt.call_function('do_action', [rt.new_string('xmlrpc_call'),
		rt.new_string('mt.getPostCategories'), var_args_mutated.clone(),
		rt.new_object('wp_xmlrpc_server', ['IXR_Server'], &this)])
	mut var_categories := []rt.PhpVal{}
	mut var_cat_ids := rt.call_function('wp_get_post_categories', [
		rt.new_int(var_post_id.to_i64()),
	])
	mut var_is_primary := rt.new_bool(true)
	mut iter_43 := var_cat_ids.iterator()
	for {
		item_43 := iter_43.next() or { break }
		mut var_cat_id := item_43.val
		var_categories.array_push(rt.create_array([
			rt.ArrayItem{ key: 'categoryName', val: rt.call_function('get_cat_name', [
				var_cat_id.clone(),
			]) },
			rt.ArrayItem{ key: 'categoryId', val: var_cat_id.str() },
			rt.ArrayItem{ key: 'isPrimary', val: var_is_primary },
		]))
		var_is_primary = rt.new_bool(false)
	}
	return var_categories.clone()
}

fn (mut this Class_wp_xmlrpc_server) mt_setpostcategories(var_args rt.PhpVal) bool {
	mut var_args_mutated := var_args
	this.escape(var_args_mutated.clone())
	mut var_post_id := rt.new_int((var_args_mutated.array_get(rt.new_int(0))).to_i64())
	mut var_username := var_args_mutated.array_get(rt.new_int(1))
	mut var_password := var_args_mutated.array_get(rt.new_int(2))
	mut var_categories := var_args_mutated.array_get(rt.new_int(3))
	mut var_user := rt.new_bool(this.login(var_username.clone(), var_password.clone()))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_user)))) {
		return (this.error).to_bool()
	}
	rt.call_function('do_action', [rt.new_string('xmlrpc_call'),
		rt.new_string('mt.setPostCategories'), var_args_mutated.clone(),
		rt.new_object('wp_xmlrpc_server', ['IXR_Server'], &this)])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('get_post', [
		var_post_id.clone()])))))
	{
		return (create_ixr_error(rt.new_int(404), rt.call_function('__', [
			rt.new_string('Invalid post ID.'),
		]))).to_bool()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('edit_post'),
		var_post_id.clone(),
	])))))
	{
		return (create_ixr_error(rt.new_int(401), rt.call_function('__', [
			rt.new_string('Sorry, you are not allowed to edit this post.'),
		]))).to_bool()
	}
	mut var_cat_ids := []rt.PhpVal{}
	mut iter_44 := var_categories.iterator()
	for {
		item_44 := iter_44.next() or { break }
		mut var_cat := item_44.val
		var_cat_ids.array_push(var_cat.array_get(rt.new_string('categoryId')))
	}
	rt.call_function('wp_set_post_categories', [var_post_id.clone(),
		var_cat_ids.clone()])
	return true
}

fn (mut this Class_wp_xmlrpc_server) mt_supportedmethods() rt.PhpVal {
	rt.call_function('do_action', [rt.new_string('xmlrpc_call'),
		rt.new_string('mt.supportedMethods'), []rt.PhpVal{},
		rt.new_object('wp_xmlrpc_server', [
			'IXR_Server',
		], &this)])
	return rt.func_array_keys(this.methods)
}

fn (mut this Class_wp_xmlrpc_server) mt_supportedtextfilters() rt.PhpVal {
	rt.call_function('do_action', [rt.new_string('xmlrpc_call'),
		rt.new_string('mt.supportedTextFilters'), []rt.PhpVal{},
		rt.new_object('wp_xmlrpc_server', ['IXR_Server'], &this)])
	return rt.call_function('apply_filters', [rt.new_string('xmlrpc_text_filters'),
		[]rt.PhpVal{}])
}

fn (mut this Class_wp_xmlrpc_server) mt_gettrackbackpings(var_post_id rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_post_id_mutated := var_post_id
	rt.call_function('do_action', [rt.new_string('xmlrpc_call'),
		rt.new_string('mt.getTrackbackPings'), var_post_id_mutated.clone(),
		rt.new_object('wp_xmlrpc_server', ['IXR_Server'], &this)])
	mut var_actual_post := rt.call_function('get_post', [var_post_id_mutated.clone(),
		rt.get_constant('ARRAY_A')])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_actual_post)))) {
		return rt.new_object('IXR_Error', []string{}, create_ixr_error(rt.new_int(404), rt.call_function('__', [
			rt.new_string('Sorry, no such post.'),
		])))
	}
	mut var_comments := rt.call_method(var_wpdb, 'get_results', [
		rt.call_method(var_wpdb, 'prepare', [
			rt.concat(rt.concat(rt.new_string('SELECT comment_author_url, comment_content, comment_author_IP, comment_type FROM '), rt.get_property(var_wpdb,
				'comments')), rt.new_string(' WHERE comment_post_ID = %d')),
			var_post_id_mutated.clone(),
		]),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_comments)))) {
		return []rt.PhpVal{}
	}
	mut var_trackback_pings := []rt.PhpVal{}
	mut iter_45 := var_comments.iterator()
	for {
		item_45 := iter_45.next() or { break }
		mut var_comment := item_45.val
		if rt.is_true(rt.identical(rt.new_string('trackback'), rt.get_property(var_comment,
			'comment_type')))
		{
			mut var_content := rt.get_property(var_comment, 'comment_content')
			mut var_title := rt.call_function('substr', [var_content.clone(),
				rt.new_int(8),
				rt.sub(rt.call_function('strpos', [
					var_content.clone(), rt.new_string('</strong>')]), rt.new_int(8))])
			var_trackback_pings << rt.create_array([
				rt.ArrayItem{ key: 'pingTitle', val: var_title },
				rt.ArrayItem{ key: 'pingURL', val: rt.get_property(var_comment,
					'comment_author_url') },
				rt.ArrayItem{ key: 'pingIP', val: rt.get_property(var_comment, 'comment_author_IP') },
			])
		}
	}
	return var_trackback_pings.clone()
}

fn (mut this Class_wp_xmlrpc_server) mt_publishpost(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
	this.escape(var_args_mutated.clone())
	mut var_post_id := rt.new_int((var_args_mutated.array_get(rt.new_int(0))).to_i64())
	mut var_username := var_args_mutated.array_get(rt.new_int(1))
	mut var_password := var_args_mutated.array_get(rt.new_int(2))
	mut var_user := rt.new_bool(this.login(var_username.clone(), var_password.clone()))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_user)))) {
		return this.error
	}
	rt.call_function('do_action', [rt.new_string('xmlrpc_call'),
		rt.new_string('mt.publishPost'), var_args_mutated.clone(),
		rt.new_object('wp_xmlrpc_server', ['IXR_Server'], &this)])
	mut var_postdata := rt.call_function('get_post', [var_post_id.clone(),
		rt.get_constant('ARRAY_A')])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_postdata)))) {
		return rt.new_object('IXR_Error', []string{}, create_ixr_error(rt.new_int(404), rt.call_function('__', [
			rt.new_string('Invalid post ID.'),
		])))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('publish_posts')])))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_post'), var_post_id.clone()]))))) {
		return rt.new_object('IXR_Error', []string{}, create_ixr_error(rt.new_int(401), rt.call_function('__', [
			rt.new_string('Sorry, you are not allowed to publish this post.'),
		])))
	}
	var_postdata.array_set('post_status', 'publish')
	var_postdata.array_set('post_category', rt.call_function('wp_get_post_categories', [
		var_post_id.clone(),
	]))
	this.escape(var_postdata.clone())
	return rt.call_function('wp_update_post', [var_postdata.clone()])
}

fn (mut this Class_wp_xmlrpc_server) pingback_ping(var_args rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_match := []rt.PhpVal{}
	mut var_matchtitle := []rt.PhpVal{}
	mut var_args_mutated := var_args
	rt.call_function('do_action', [rt.new_string('xmlrpc_call'),
		rt.new_string('pingback.ping'), var_args_mutated.clone(),
		rt.new_object('wp_xmlrpc_server', ['IXR_Server'], &this)])
	this.escape(var_args_mutated.clone())
	mut var_pagelinkedfrom := rt.call_function('str_replace', [
		rt.new_string('&amp;'), rt.new_string('&'), var_args_mutated.array_get(rt.new_int(0))])
	mut var_pagelinkedto := rt.call_function('str_replace', [
		rt.new_string('&amp;'), rt.new_string('&'), var_args_mutated.array_get(rt.new_int(1))])
	var_pagelinkedto = rt.call_function('str_replace', [rt.new_string('&'),
		rt.new_string('&amp;'), var_pagelinkedto.clone()])
	var_pagelinkedfrom = rt.call_function('apply_filters', [
		rt.new_string('pingback_ping_source_uri'),
		var_pagelinkedfrom.clone(),
		var_pagelinkedto.clone(),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_pagelinkedfrom)))) {
		return this.pingback_error(rt.new_int(0), rt.call_function('__', [
			rt.new_string('A valid URL was not provided.'),
		]))
	}
	mut var_pos1 := rt.call_function('strpos', [var_pagelinkedto.clone(),
		rt.call_function('str_replace', [
			rt.create_array([rt.ArrayItem{ key: none, val: 'http://www.' },
				rt.ArrayItem{ key: none, val: 'http://' }, rt.ArrayItem{
					key: none
					val: 'https://www.'
				}, rt.ArrayItem{ key: none, val: 'https://' }]),
			rt.new_string(''),
			rt.call_function('get_option', [rt.new_string('home')]),
		])])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_pos1)))) {
		return this.pingback_error(rt.new_int(0), rt.call_function('__', [
			rt.new_string('Is there no link to us?'),
		]))
	}
	mut var_urltest := rt.call_function('parse_url', [var_pagelinkedto.clone()])
	mut var_post_id := rt.call_function('url_to_postid', [var_pagelinkedto.clone()])
	if rt.is_true(var_post_id) {
	} else if var_urltest.array_isset(rt.new_string('path'))
		&& rt.is_true(rt.call_function('preg_match', [rt.new_string('#p/[0-9]{1,}#'), var_urltest.array_get(rt.new_string('path')), rt.create_array_from_list(var_match)])) {
		mut var_blah := rt.call_function('explode', [rt.new_string('/'),
			var_match.array_get(rt.new_int(0))])
		var_post_id = rt.new_int((var_blah.array_get(rt.new_int(1))).to_i64())
	} else if var_urltest.array_isset(rt.new_string('query'))
		&& rt.is_true(rt.call_function('preg_match', [rt.new_string('#p=[0-9]{1,}#'), var_urltest.array_get(rt.new_string('query')), rt.create_array_from_list(var_match)])) {
		var_blah = rt.call_function('explode', [rt.new_string('='),
			var_match.array_get(rt.new_int(0))])
		var_post_id = rt.new_int((var_blah.array_get(rt.new_int(1))).to_i64())
	} else if var_urltest.array_isset(rt.new_string('fragment')) {
		if rt.is_true(rt.new_int((var_urltest.array_get(rt.new_string('fragment'))).to_i64())) {
			var_post_id = rt.new_int((var_urltest.array_get(rt.new_string('fragment'))).to_i64())
		} else if rt.is_true(rt.call_function('preg_match', [
			rt.new_string('/post-[0-9]+/'),
			var_urltest.array_get(rt.new_string('fragment')),
		]))
		{
			var_post_id = rt.call_function('preg_replace', [rt.new_string('/[^0-9]+/'),
				rt.new_string(''), var_urltest.array_get(rt.new_string('fragment'))])
		} else if rt.is_true(rt.new_bool(var_urltest.array_get(rt.new_string('fragment')).is_string())) {
			mut var_title := rt.call_function('preg_replace', [
				rt.new_string('/[^a-z0-9]/i'),
				rt.new_string('.'),
				var_urltest.array_get(rt.new_string('fragment')),
			])
			mut var_sql := rt.call_method(var_wpdb, 'prepare', [
				rt.concat(rt.concat(rt.new_string('SELECT ID FROM '), rt.get_property(var_wpdb,
					'posts')), rt.new_string(' WHERE post_title RLIKE %s')),
				var_title.clone(),
			])
			var_post_id = rt.call_method(var_wpdb, 'get_var', [
				var_sql.clone()])
			if rt.is_true(rt.new_bool(!(rt.is_true(var_post_id)))) {
				return this.pingback_error(rt.new_int(0), rt.new_string(''))
			}
		}
	} else {
		return this.pingback_error(rt.new_int(33), rt.call_function('__', [
			rt.new_string('The specified target URL cannot be used as a target. It either does not exist, or it is not a pingback-enabled resource.'),
		]))
	}
	var_post_id = rt.new_int(var_post_id.to_i64())
	mut var_post := rt.call_function('get_post', [var_post_id.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_post)))) {
		return this.pingback_error(rt.new_int(33), rt.call_function('__', [
			rt.new_string('The specified target URL cannot be used as a target. It either does not exist, or it is not a pingback-enabled resource.'),
		]))
	}
	if rt.is_true(rt.identical(rt.call_function('url_to_postid', [
		var_pagelinkedfrom.clone()]), var_post_id))
	{
		return this.pingback_error(rt.new_int(0), rt.call_function('__', [
			rt.new_string('The source URL and the target URL cannot both point to the same resource.'),
		]))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('pings_open', [
		var_post.clone()])))))
	{
		return this.pingback_error(rt.new_int(33), rt.call_function('__', [
			rt.new_string('The specified target URL cannot be used as a target. It either does not exist, or it is not a pingback-enabled resource.'),
		]))
	}
	if rt.is_true(rt.call_method(var_wpdb, 'get_results', [
		rt.call_method(var_wpdb, 'prepare', [
			rt.concat(rt.concat(rt.new_string('SELECT * FROM '), rt.get_property(var_wpdb,
				'comments')),
				rt.new_string(' WHERE comment_post_ID = %d AND comment_author_url = %s')),
			var_post_id.clone(),
			var_pagelinkedfrom.clone(),
		]),
	]))
	{
		return this.pingback_error(rt.new_int(48), rt.call_function('__', [
			rt.new_string('The pingback has already been registered.'),
		]))
	}
	rt.call_function('sleep', [rt.new_int(1)])
	mut var_remote_ip := rt.call_function('preg_replace', [
		rt.new_string('/[^0-9a-fA-F:., ]/'),
		rt.new_string(''),
		rt.get_superglobal('_SERVER').array_get(rt.new_string('REMOTE_ADDR')),
	])
	mut var_user_agent := rt.call_function('apply_filters', [
		rt.new_string('http_headers_useragent'),
		rt.new_string('WordPress/' +
			(rt.call_function('get_bloginfo', [rt.new_string('version')])).str() + '; ' +
			(rt.call_function('get_bloginfo', [rt.new_string('url')])).str()),
		var_pagelinkedfrom.clone(),
	])
	mut var_http_api_args := {
		'timeout':             rt.new_int(10)
		'redirection':         rt.new_int(0)
		'limit_response_size': rt.new_int(153600)
		'user-agent':          rt.new_string('${var_user_agent.to_string()}; verifying pingback from ${var_remote_ip.to_string()}')
		'headers':             {
			'X-Pingback-Forwarded-For': var_remote_ip
		}
	}
	mut var_request := rt.call_function('wp_safe_remote_get', [
		var_pagelinkedfrom.clone(), rt.create_array_from_native_map(var_http_api_args)])
	mut var_remote_source := rt.call_function('wp_remote_retrieve_body', [
		var_request.clone()])
	mut var_remote_source_original := var_remote_source.clone()
	if rt.is_true(rt.new_bool(!(rt.is_true(var_remote_source)))) {
		return this.pingback_error(rt.new_int(16), rt.call_function('__', [
			rt.new_string('The source URL does not exist.'),
		]))
	}
	var_remote_source = rt.call_function('apply_filters', [
		rt.new_string('pre_remote_source'),
		var_remote_source.clone(),
		var_pagelinkedto.clone(),
	])
	var_remote_source = rt.call_function('str_replace', [rt.new_string('<!DOC'),
		rt.new_string('<DOC'), var_remote_source.clone()])
	var_remote_source = rt.call_function('preg_replace', [
		rt.new_string('/[\\r\\n\\t ]+/'),
		rt.new_string(' '),
		var_remote_source.clone(),
	])
	var_remote_source = rt.call_function('preg_replace', [
		rt.new_string('/<\\/*(h1|h2|h3|h4|h5|h6|p|th|td|li|dt|dd|pre|caption|input|textarea|button|body)[^>]*>/'),
		rt.new_string('\n\n'),
		var_remote_source.clone(),
	])
	rt.call_function('preg_match', [rt.new_string('|<title>([^<]*?)</title>|is'),
		var_remote_source.clone(), rt.create_array_from_list(var_matchtitle)])
	var_title = if !(var_matchtitle.array_get(rt.new_int(1))).is_null() {
		var_matchtitle.array_get(rt.new_int(1))
	} else {
		rt.new_string('')
	}
	if !rt.is_true(var_title) {
		return this.pingback_error(rt.new_int(32), rt.call_function('__', [
			rt.new_string('A title on that page cannot be found.'),
		]))
	}
	var_remote_source = rt.call_function('preg_replace', [
		rt.new_string('@<(script|style)[^>]*?>.*?</\\1>@si'),
		rt.new_string(''),
		var_remote_source.clone(),
	])
	var_remote_source = rt.call_function('strip_tags', [var_remote_source.clone(),
		rt.new_string('<a>')])
	mut var_p := rt.call_function('explode', [rt.new_string('\n\n'),
		var_remote_source.clone()])
	mut var_preg_target := rt.call_function('preg_quote', [var_pagelinkedto.clone(),
		rt.new_string('|')])
	mut iter_46 := var_p.iterator()
	for {
		item_46 := iter_46.next() or { break }
		mut var_para := item_46.val
		if rt.is_true(rt.call_function('str_contains', [var_para.clone(),
			var_pagelinkedto.clone()]))
		{
			rt.call_function('preg_match', [
				rt.new_string('|<a[^>]+?' + var_preg_target.str() + '[^>]*>([^>]+?)</a>|'),
				var_para.clone(),
				var_context.clone(),
			])
			if !rt.is_true(var_context) {
				continue
			}
			mut var_excerpt := rt.call_function('preg_replace', [
				rt.new_string('|\\</?wpcontext\\>|'),
				rt.new_string(''),
				var_para.clone(),
			])
			if var_context.array_get(rt.new_int(1)).to_string().len > 100 {
				var_context.array_set(1,
					(rt.call_function('substr', [var_context.array_get(rt.new_int(1)), rt.new_int(0), rt.new_int(100)])).str() +
					'&#8230;')
			}
			mut var_marker := rt.new_string('<wpcontext>' +
				(var_context.array_get(rt.new_int(1))).str() + '</wpcontext>')
			var_excerpt = rt.call_function('str_replace', [var_context.array_get(rt.new_int(0)),
				var_marker.clone(), var_excerpt.clone()])
			var_excerpt = rt.call_function('strip_tags', [var_excerpt.clone(),
				rt.new_string('<wpcontext>')])
			var_excerpt = rt.new_string(var_excerpt.clone().to_string().trim_space())
			mut var_preg_marker := rt.call_function('preg_quote', [
				var_marker.clone(), rt.new_string('|')])
			var_excerpt = rt.call_function('preg_replace', [
				rt.new_string('|.*?\\s(.{0,100}${var_preg_marker.to_string()}.{0,100})\\s.*|s'),
				rt.new_string('$1'),
				var_excerpt.clone(),
			])
			var_excerpt = rt.call_function('strip_tags', [var_excerpt.clone()])
			break
		}
	}
	if !rt.is_true(var_context) {
		return this.pingback_error(rt.new_int(17), rt.call_function('__', [
			rt.new_string('The source URL does not contain a link to the target URL, and so cannot be used as a source.'),
		]))
	}
	var_pagelinkedfrom = rt.call_function('str_replace', [rt.new_string('&'),
		rt.new_string('&amp;'), var_pagelinkedfrom.clone()])
	mut var_context := rt.new_string('[&#8230;] ' +
		(rt.call_function('esc_html', [var_excerpt.clone()])).str() + ' [&#8230;]')
	var_pagelinkedfrom = this.escape(var_pagelinkedfrom.clone())
	mut var_comment_post_id := rt.new_int(var_post_id.to_i64())
	mut var_comment_author := var_title.clone()
	mut var_comment_author_email := rt.new_string('')
	this.escape(var_comment_author.clone())
	mut var_comment_author_url := var_pagelinkedfrom.clone()
	mut var_comment_content := var_context.clone()
	this.escape(var_comment_content.clone())
	mut var_comment_type := rt.new_string('pingback')
	mut var_commentdata := {
		'comment_post_ID': var_comment_post_id
	}
	var_commentdata = rt.add(var_commentdata, rt.call_function('compact', [
		rt.new_string('comment_author'),
		rt.new_string('comment_author_url'),
		rt.new_string('comment_author_email'),
		rt.new_string('comment_content'),
		rt.new_string('comment_type'),
		rt.new_string('remote_source'),
		rt.new_string('remote_source_original'),
	]))
	mut var_comment_id := rt.call_function('wp_new_comment', [
		rt.create_array_from_native_map(var_commentdata),
	])
	if rt.is_true(rt.call_function('is_wp_error', [var_comment_id.clone()])) {
		return this.pingback_error(rt.new_int(0), rt.call_method(var_comment_id,
			'get_error_message', []rt.PhpVal{}))
	}
	rt.call_function('do_action', [rt.new_string('pingback_post'),
		var_comment_id.clone()])
	return rt.call_function('sprintf', [
		rt.call_function('__', [
			rt.new_string('Pingback from %1$s to %2$s registered. Keep the web talking! :-)'),
		]),
		var_pagelinkedfrom.clone(),
		var_pagelinkedto.clone(),
	])
}

fn (mut this Class_wp_xmlrpc_server) pingback_extensions_getpingbacks(var_url rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_url_mutated := var_url
	rt.call_function('do_action', [rt.new_string('xmlrpc_call'),
		rt.new_string('pingback.extensions.getPingbacks'), var_url_mutated.clone(),
		rt.new_object('wp_xmlrpc_server', ['IXR_Server'], &this)])
	var_url_mutated = this.escape(var_url_mutated.clone())
	mut var_post_id := rt.call_function('url_to_postid', [var_url_mutated.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_post_id)))) {
		return this.pingback_error(rt.new_int(33), rt.call_function('__', [
			rt.new_string('The specified target URL cannot be used as a target. It either does not exist, or it is not a pingback-enabled resource.'),
		]))
	}
	mut var_actual_post := rt.call_function('get_post', [var_post_id.clone(),
		rt.get_constant('ARRAY_A')])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_actual_post)))) {
		return this.pingback_error(rt.new_int(32), rt.call_function('__', [
			rt.new_string('The specified target URL does not exist.'),
		]))
	}
	mut var_comments := rt.call_method(var_wpdb, 'get_results', [
		rt.call_method(var_wpdb, 'prepare', [
			rt.concat(rt.concat(rt.new_string('SELECT comment_author_url, comment_content, comment_author_IP, comment_type FROM '), rt.get_property(var_wpdb,
				'comments')), rt.new_string(' WHERE comment_post_ID = %d')),
			var_post_id.clone(),
		]),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_comments)))) {
		return []rt.PhpVal{}
	}
	mut var_pingbacks := []rt.PhpVal{}
	mut iter_47 := var_comments.iterator()
	for {
		item_47 := iter_47.next() or { break }
		mut var_comment := item_47.val
		if rt.is_true(rt.identical(rt.new_string('pingback'), rt.get_property(var_comment,
			'comment_type')))
		{
			var_pingbacks << rt.get_property(var_comment, 'comment_author_url')
		}
	}
	return var_pingbacks.clone()
}

fn (mut this Class_wp_xmlrpc_server) pingback_error(var_code rt.PhpVal, var_message rt.PhpVal) rt.PhpVal {
	return rt.call_function('apply_filters', [rt.new_string('xmlrpc_pingback_error'),
		create_ixr_error(var_code.clone(), var_message.clone())])
}

struct Class_IXR_Server {
	rt.PhpObjectBase
}

struct Class_IXR_Error {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

struct Class_IXR_Date {
	rt.PhpObjectBase
}

fn create_wp_xmlrpc_server() &Class_wp_xmlrpc_server {
	mut obj := &Class_wp_xmlrpc_server{
		PhpObjectBase: rt.PhpObjectBase{}
		methods:       rt.new_null()
		blog_options:  rt.new_null()
		error:         rt.new_null()
		auth_failed:   false
		is_enabled:    rt.new_null()
	}
	obj.construct()
	return obj
}

fn create_ixr_server(_args ...rt.PhpVal) &Class_IXR_Server {
	mut obj := &Class_IXR_Server{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_ixr_error(_args ...rt.PhpVal) &Class_IXR_Error {
	mut obj := &Class_IXR_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_error(_args ...rt.PhpVal) &Class_WP_Error {
	mut obj := &Class_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_ixr_date(_args ...rt.PhpVal) &Class_IXR_Date {
	mut obj := &Class_IXR_Date{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_wp_xmlrpc_server) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'set_is_enabled' {
			this.set_is_enabled()
			return rt.new_null()
		}
		'__call' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(this.magic_call(dispatch_arg_0, dispatch_arg_1))
		}
		'serve_request' {
			this.serve_request()
			return rt.new_null()
		}
		'sayHello' {
			return rt.new_string(this.sayhello())
		}
		'addTwoNumbers' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.addtwonumbers(dispatch_arg_0)
		}
		'login' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(this.login(dispatch_arg_0, dispatch_arg_1))
		}
		'login_pass_ok' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(this.login_pass_ok(dispatch_arg_0, dispatch_arg_1))
		}
		'escape' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.escape(dispatch_arg_0)
		}
		'error' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			this.error(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'get_custom_fields' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_custom_fields(dispatch_arg_0)
		}
		'set_custom_fields' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.set_custom_fields(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'get_term_custom_fields' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_term_custom_fields(dispatch_arg_0)
		}
		'set_term_custom_fields' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.set_term_custom_fields(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'initialise_blog_option_info' {
			this.initialise_blog_option_info()
			return rt.new_null()
		}
		'wp_getUsersBlogs' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.wp_getusersblogs(dispatch_arg_0)
		}
		'minimum_args' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(this.minimum_args(dispatch_arg_0, dispatch_arg_1))
		}
		'_prepare_taxonomy' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this._prepare_taxonomy(dispatch_arg_0, dispatch_arg_1)
		}
		'_prepare_term' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this._prepare_term(dispatch_arg_0)
		}
		'_convert_date' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this._convert_date(dispatch_arg_0)
		}
		'_convert_date_gmt' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this._convert_date_gmt(dispatch_arg_0, dispatch_arg_1)
		}
		'_prepare_post' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this._prepare_post(dispatch_arg_0, dispatch_arg_1)
		}
		'_prepare_post_type' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this._prepare_post_type(dispatch_arg_0, dispatch_arg_1)
		}
		'_prepare_media_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return this._prepare_media_item(dispatch_arg_0, dispatch_arg_1)
		}
		'_prepare_page' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this._prepare_page(dispatch_arg_0)
		}
		'_prepare_comment' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this._prepare_comment(dispatch_arg_0)
		}
		'_prepare_user' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this._prepare_user(dispatch_arg_0, dispatch_arg_1)
		}
		'wp_newPost' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.wp_newpost(dispatch_arg_0)
		}
		'_is_greater_than_one' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this._is_greater_than_one(dispatch_arg_0)
		}
		'_toggle_sticky' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			return this._toggle_sticky(dispatch_arg_0, dispatch_arg_1)
		}
		'_insert_post' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_string(this._insert_post(dispatch_arg_0, dispatch_arg_1))
		}
		'wp_editPost' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.wp_editpost(dispatch_arg_0))
		}
		'wp_deletePost' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.wp_deletepost(dispatch_arg_0))
		}
		'wp_getPost' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.wp_getpost(dispatch_arg_0)
		}
		'wp_getPosts' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.wp_getposts(dispatch_arg_0)
		}
		'wp_newTerm' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.wp_newterm(dispatch_arg_0))
		}
		'wp_editTerm' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.wp_editterm(dispatch_arg_0))
		}
		'wp_deleteTerm' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.wp_deleteterm(dispatch_arg_0)
		}
		'wp_getTerm' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.wp_getterm(dispatch_arg_0)
		}
		'wp_getTerms' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.wp_getterms(dispatch_arg_0)
		}
		'wp_getTaxonomy' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.wp_gettaxonomy(dispatch_arg_0)
		}
		'wp_getTaxonomies' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.wp_gettaxonomies(dispatch_arg_0)
		}
		'wp_getUser' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.wp_getuser(dispatch_arg_0)
		}
		'wp_getUsers' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.wp_getusers(dispatch_arg_0)
		}
		'wp_getProfile' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.wp_getprofile(dispatch_arg_0)
		}
		'wp_editProfile' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.wp_editprofile(dispatch_arg_0))
		}
		'wp_getPage' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.wp_getpage(dispatch_arg_0)
		}
		'wp_getPages' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.wp_getpages(dispatch_arg_0)
		}
		'wp_newPage' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.wp_newpage(dispatch_arg_0)
		}
		'wp_deletePage' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.wp_deletepage(dispatch_arg_0))
		}
		'wp_editPage' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.wp_editpage(dispatch_arg_0)
		}
		'wp_getPageList' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.wp_getpagelist(dispatch_arg_0)
		}
		'wp_getAuthors' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.wp_getauthors(dispatch_arg_0)
		}
		'wp_getTags' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.wp_gettags(dispatch_arg_0)
		}
		'wp_newCategory' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_int(this.wp_newcategory(dispatch_arg_0))
		}
		'wp_deleteCategory' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.wp_deletecategory(dispatch_arg_0)
		}
		'wp_suggestCategories' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.wp_suggestcategories(dispatch_arg_0)
		}
		'wp_getComment' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.wp_getcomment(dispatch_arg_0)
		}
		'wp_getComments' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.wp_getcomments(dispatch_arg_0)
		}
		'wp_deleteComment' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.wp_deletecomment(dispatch_arg_0)
		}
		'wp_editComment' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.wp_editcomment(dispatch_arg_0))
		}
		'wp_newComment' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.wp_newcomment(dispatch_arg_0)
		}
		'wp_getCommentStatusList' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.wp_getcommentstatuslist(dispatch_arg_0)
		}
		'wp_getCommentCount' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.wp_getcommentcount(dispatch_arg_0)
		}
		'wp_getPostStatusList' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.wp_getpoststatuslist(dispatch_arg_0)
		}
		'wp_getPageStatusList' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.wp_getpagestatuslist(dispatch_arg_0)
		}
		'wp_getPageTemplates' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.wp_getpagetemplates(dispatch_arg_0)
		}
		'wp_getOptions' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.wp_getoptions(dispatch_arg_0)
		}
		'_getOptions' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this._getoptions(dispatch_arg_0)
		}
		'wp_setOptions' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.wp_setoptions(dispatch_arg_0)
		}
		'wp_getMediaItem' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.wp_getmediaitem(dispatch_arg_0)
		}
		'wp_getMediaLibrary' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.wp_getmedialibrary(dispatch_arg_0)
		}
		'wp_getPostFormats' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.wp_getpostformats(dispatch_arg_0)
		}
		'wp_getPostType' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.wp_getposttype(dispatch_arg_0)
		}
		'wp_getPostTypes' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.wp_getposttypes(dispatch_arg_0)
		}
		'wp_getRevisions' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.wp_getrevisions(dispatch_arg_0)
		}
		'wp_restoreRevision' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.wp_restorerevision(dispatch_arg_0))
		}
		'blogger_getUsersBlogs' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.blogger_getusersblogs(dispatch_arg_0)
		}
		'_multisite_getUsersBlogs' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this._multisite_getusersblogs(dispatch_arg_0)
		}
		'blogger_getUserInfo' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.blogger_getuserinfo(dispatch_arg_0)
		}
		'blogger_getPost' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.blogger_getpost(dispatch_arg_0)
		}
		'blogger_getRecentPosts' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.blogger_getrecentposts(dispatch_arg_0)
		}
		'blogger_getTemplate' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.blogger_gettemplate(dispatch_arg_0)
		}
		'blogger_setTemplate' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.blogger_settemplate(dispatch_arg_0)
		}
		'blogger_newPost' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.blogger_newpost(dispatch_arg_0)
		}
		'blogger_editPost' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.blogger_editpost(dispatch_arg_0))
		}
		'blogger_deletePost' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.blogger_deletepost(dispatch_arg_0))
		}
		'mw_newPost' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.mw_newpost(dispatch_arg_0))
		}
		'add_enclosure_if_new' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.add_enclosure_if_new(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'attach_uploads' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.attach_uploads(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'mw_editPost' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.mw_editpost(dispatch_arg_0))
		}
		'mw_getPost' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.mw_getpost(dispatch_arg_0)
		}
		'mw_getRecentPosts' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.mw_getrecentposts(dispatch_arg_0)
		}
		'mw_getCategories' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.mw_getcategories(dispatch_arg_0)
		}
		'mw_newMediaObject' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.mw_newmediaobject(dispatch_arg_0)
		}
		'mt_getRecentPostTitles' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.mt_getrecentposttitles(dispatch_arg_0)
		}
		'mt_getCategoryList' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.mt_getcategorylist(dispatch_arg_0)
		}
		'mt_getPostCategories' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.mt_getpostcategories(dispatch_arg_0)
		}
		'mt_setPostCategories' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.mt_setpostcategories(dispatch_arg_0))
		}
		'mt_supportedMethods' {
			return this.mt_supportedmethods()
		}
		'mt_supportedTextFilters' {
			return this.mt_supportedtextfilters()
		}
		'mt_getTrackbackPings' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.mt_gettrackbackpings(dispatch_arg_0)
		}
		'mt_publishPost' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.mt_publishpost(dispatch_arg_0)
		}
		'pingback_ping' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.pingback_ping(dispatch_arg_0)
		}
		'pingback_extensions_getPingbacks' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.pingback_extensions_getpingbacks(dispatch_arg_0)
		}
		'pingback_error' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.pingback_error(dispatch_arg_0, dispatch_arg_1)
		}
		else {
			return none
		}
	}
}

fn (this &Class_wp_xmlrpc_server) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'methods' { return this.methods }
		'blog_options' { return this.blog_options }
		'error' { return this.error }
		'auth_failed' { return rt.new_bool(this.auth_failed) }
		'is_enabled' { return this.is_enabled }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_wp_xmlrpc_server) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'methods' {
			this.methods = val
			return true
		}
		'blog_options' {
			this.blog_options = val
			return true
		}
		'error' {
			this.error = val
			return true
		}
		'auth_failed' {
			this.auth_failed = val.to_bool()
			return true
		}
		'is_enabled' {
			this.is_enabled = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_IXR_Server) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_IXR_Server) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_IXR_Server) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_IXR_Error) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_IXR_Error) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_IXR_Error) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_IXR_Date) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_IXR_Date) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_IXR_Date) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
