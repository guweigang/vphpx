import rt

struct Class_wp_xmlrpc_server {
	rt.PhpObjectBase
pub mut:
		methods rt.PhpVal = rt.new_null()
		blog_options rt.PhpVal = rt.new_null()
		error rt.PhpVal = rt.new_null()
		auth_failed bool
		is_enabled rt.PhpVal = rt.new_null()
}

fn (mut this Class_wp_xmlrpc_server) construct()  {
	this.methods = rt.create_array([rt.ArrayItem{ key: 'wp.getUsersBlogs', val: 'this:wp_getUsersBlogs' }, rt.ArrayItem{ key: 'wp.newPost', val: 'this:wp_newPost' }, rt.ArrayItem{ key: 'wp.editPost', val: 'this:wp_editPost' }, rt.ArrayItem{ key: 'wp.deletePost', val: 'this:wp_deletePost' }, rt.ArrayItem{ key: 'wp.getPost', val: 'this:wp_getPost' }, rt.ArrayItem{ key: 'wp.getPosts', val: 'this:wp_getPosts' }, rt.ArrayItem{ key: 'wp.newTerm', val: 'this:wp_newTerm' }, rt.ArrayItem{ key: 'wp.editTerm', val: 'this:wp_editTerm' }, rt.ArrayItem{ key: 'wp.deleteTerm', val: 'this:wp_deleteTerm' }, rt.ArrayItem{ key: 'wp.getTerm', val: 'this:wp_getTerm' }, rt.ArrayItem{ key: 'wp.getTerms', val: 'this:wp_getTerms' }, rt.ArrayItem{ key: 'wp.getTaxonomy', val: 'this:wp_getTaxonomy' }, rt.ArrayItem{ key: 'wp.getTaxonomies', val: 'this:wp_getTaxonomies' }, rt.ArrayItem{ key: 'wp.getUser', val: 'this:wp_getUser' }, rt.ArrayItem{ key: 'wp.getUsers', val: 'this:wp_getUsers' }, rt.ArrayItem{ key: 'wp.getProfile', val: 'this:wp_getProfile' }, rt.ArrayItem{ key: 'wp.editProfile', val: 'this:wp_editProfile' }, rt.ArrayItem{ key: 'wp.getPage', val: 'this:wp_getPage' }, rt.ArrayItem{ key: 'wp.getPages', val: 'this:wp_getPages' }, rt.ArrayItem{ key: 'wp.newPage', val: 'this:wp_newPage' }, rt.ArrayItem{ key: 'wp.deletePage', val: 'this:wp_deletePage' }, rt.ArrayItem{ key: 'wp.editPage', val: 'this:wp_editPage' }, rt.ArrayItem{ key: 'wp.getPageList', val: 'this:wp_getPageList' }, rt.ArrayItem{ key: 'wp.getAuthors', val: 'this:wp_getAuthors' }, rt.ArrayItem{ key: 'wp.getCategories', val: 'this:mw_getCategories' }, rt.ArrayItem{ key: 'wp.getTags', val: 'this:wp_getTags' }, rt.ArrayItem{ key: 'wp.newCategory', val: 'this:wp_newCategory' }, rt.ArrayItem{ key: 'wp.deleteCategory', val: 'this:wp_deleteCategory' }, rt.ArrayItem{ key: 'wp.suggestCategories', val: 'this:wp_suggestCategories' }, rt.ArrayItem{ key: 'wp.uploadFile', val: 'this:mw_newMediaObject' }, rt.ArrayItem{ key: 'wp.deleteFile', val: 'this:wp_deletePost' }, rt.ArrayItem{ key: 'wp.getCommentCount', val: 'this:wp_getCommentCount' }, rt.ArrayItem{ key: 'wp.getPostStatusList', val: 'this:wp_getPostStatusList' }, rt.ArrayItem{ key: 'wp.getPageStatusList', val: 'this:wp_getPageStatusList' }, rt.ArrayItem{ key: 'wp.getPageTemplates', val: 'this:wp_getPageTemplates' }, rt.ArrayItem{ key: 'wp.getOptions', val: 'this:wp_getOptions' }, rt.ArrayItem{ key: 'wp.setOptions', val: 'this:wp_setOptions' }, rt.ArrayItem{ key: 'wp.getComment', val: 'this:wp_getComment' }, rt.ArrayItem{ key: 'wp.getComments', val: 'this:wp_getComments' }, rt.ArrayItem{ key: 'wp.deleteComment', val: 'this:wp_deleteComment' }, rt.ArrayItem{ key: 'wp.editComment', val: 'this:wp_editComment' }, rt.ArrayItem{ key: 'wp.newComment', val: 'this:wp_newComment' }, rt.ArrayItem{ key: 'wp.getCommentStatusList', val: 'this:wp_getCommentStatusList' }, rt.ArrayItem{ key: 'wp.getMediaItem', val: 'this:wp_getMediaItem' }, rt.ArrayItem{ key: 'wp.getMediaLibrary', val: 'this:wp_getMediaLibrary' }, rt.ArrayItem{ key: 'wp.getPostFormats', val: 'this:wp_getPostFormats' }, rt.ArrayItem{ key: 'wp.getPostType', val: 'this:wp_getPostType' }, rt.ArrayItem{ key: 'wp.getPostTypes', val: 'this:wp_getPostTypes' }, rt.ArrayItem{ key: 'wp.getRevisions', val: 'this:wp_getRevisions' }, rt.ArrayItem{ key: 'wp.restoreRevision', val: 'this:wp_restoreRevision' }, rt.ArrayItem{ key: 'blogger.getUsersBlogs', val: 'this:blogger_getUsersBlogs' }, rt.ArrayItem{ key: 'blogger.getUserInfo', val: 'this:blogger_getUserInfo' }, rt.ArrayItem{ key: 'blogger.getPost', val: 'this:blogger_getPost' }, rt.ArrayItem{ key: 'blogger.getRecentPosts', val: 'this:blogger_getRecentPosts' }, rt.ArrayItem{ key: 'blogger.newPost', val: 'this:blogger_newPost' }, rt.ArrayItem{ key: 'blogger.editPost', val: 'this:blogger_editPost' }, rt.ArrayItem{ key: 'blogger.deletePost', val: 'this:blogger_deletePost' }, rt.ArrayItem{ key: 'metaWeblog.newPost', val: 'this:mw_newPost' }, rt.ArrayItem{ key: 'metaWeblog.editPost', val: 'this:mw_editPost' }, rt.ArrayItem{ key: 'metaWeblog.getPost', val: 'this:mw_getPost' }, rt.ArrayItem{ key: 'metaWeblog.getRecentPosts', val: 'this:mw_getRecentPosts' }, rt.ArrayItem{ key: 'metaWeblog.getCategories', val: 'this:mw_getCategories' }, rt.ArrayItem{ key: 'metaWeblog.newMediaObject', val: 'this:mw_newMediaObject' }, rt.ArrayItem{ key: 'metaWeblog.deletePost', val: 'this:blogger_deletePost' }, rt.ArrayItem{ key: 'metaWeblog.getUsersBlogs', val: 'this:blogger_getUsersBlogs' }, rt.ArrayItem{ key: 'mt.getCategoryList', val: 'this:mt_getCategoryList' }, rt.ArrayItem{ key: 'mt.getRecentPostTitles', val: 'this:mt_getRecentPostTitles' }, rt.ArrayItem{ key: 'mt.getPostCategories', val: 'this:mt_getPostCategories' }, rt.ArrayItem{ key: 'mt.setPostCategories', val: 'this:mt_setPostCategories' }, rt.ArrayItem{ key: 'mt.supportedMethods', val: 'this:mt_supportedMethods' }, rt.ArrayItem{ key: 'mt.supportedTextFilters', val: 'this:mt_supportedTextFilters' }, rt.ArrayItem{ key: 'mt.getTrackbackPings', val: 'this:mt_getTrackbackPings' }, rt.ArrayItem{ key: 'mt.publishPost', val: 'this:mt_publishPost' }, rt.ArrayItem{ key: 'pingback.ping', val: 'this:pingback_ping' }, rt.ArrayItem{ key: 'pingback.extensions.getPingbacks', val: 'this:pingback_extensions_getPingbacks' }, rt.ArrayItem{ key: 'demo.sayHello', val: 'this:sayHello' }, rt.ArrayItem{ key: 'demo.addTwoNumbers', val: 'this:addTwoNumbers' }])
	this.initialise_blog_option_info()
	this.methods = rt.call_function('apply_filters', [rt.new_string('xmlrpc_methods'), this.methods])
	this.set_is_enabled()
}

fn (mut this Class_wp_xmlrpc_server) set_is_enabled()  {
	mut var_is_enabled := rt.call_function('apply_filters', [rt.new_string('pre_option_enable_xmlrpc'), rt.new_bool(false)])
	if rt.is_true(rt.identical(rt.new_bool(false), var_is_enabled)) {
		var_is_enabled = rt.call_function('apply_filters', [rt.new_string('option_enable_xmlrpc'), rt.new_bool(true)])
	}
	this.is_enabled = rt.call_function('apply_filters', [rt.new_string('xmlrpc_enabled'), var_is_enabled.dup()])
}

fn (mut this Class_wp_xmlrpc_server) magic_call(var_name rt.PhpVal, var_arguments rt.PhpVal) bool {
	mut var_name_mutated := var_name
	if rt.is_true(rt.identical(rt.new_string('_multisite_getUsersBlogs'), var_name_mutated)) {
		return (this._multisite_getusersblogs(var_arguments.dup())).to_bool()
	}
	return false
}

fn (mut this Class_wp_xmlrpc_server) serve_request()  {
	this.ixr_server(this.methods)
}

fn (mut this Class_wp_xmlrpc_server) sayhello() string {
	return 'Hello!'
}

fn (mut this Class_wp_xmlrpc_server) addtwonumbers(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_args_mutated.dup().is_array()))))) || rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_args_mutated.array_get(0).is_long()))))))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_args_mutated.array_get(1).is_long()))))))) {
		this.error = create_ixr_error(rt.new_int(400), rt.call_function('__', [rt.new_string('Invalid arguments passed to this XML-RPC method. Requires two integers.')]))
		return this.error
	}
	mut var_number1 := var_args_mutated.array_get(0)
	mut var_number2 := var_args_mutated.array_get(1)
	return rt.add(var_number1, var_number2)
}

fn (mut this Class_wp_xmlrpc_server) login(var_username rt.PhpVal, var_password rt.PhpVal) bool {
	mut var_username_mutated := var_username
	mut var_password_mutated := var_password
	if rt.is_true(rt.new_bool(!(rt.is_true(this.is_enabled)))) {
		this.error = create_ixr_error(rt.new_int(405), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('XML-RPC services are disabled on this site.')])]))
		return false
	}
	if rt.is_true(this.auth_failed) {
		mut var_user := create_wp_error(rt.new_string('login_prevented'))
	} else {
		var_user = rt.call_function('wp_authenticate', [var_username_mutated.dup(), var_password_mutated.dup()])
	}
	if rt.is_true(rt.call_function('is_wp_error', [var_user.dup()])) {
		this.error = create_ixr_error(rt.new_int(403), rt.call_function('__', [rt.new_string('Incorrect username or password.')]))
		this.auth_failed = true
		this.error = rt.call_function('apply_filters', [rt.new_string('xmlrpc_login_error'), this.error, var_user.dup()])
		return false
	}
	rt.call_function('wp_set_current_user', [rt.get_property(var_user, 'ID')])
	return (var_user).to_bool()
}

fn (mut this Class_wp_xmlrpc_server) login_pass_ok(var_username rt.PhpVal, var_password rt.PhpVal) rt.PhpVal {
	mut var_username_mutated := var_username
	mut var_password_mutated := var_password
	return // unsupported expression: Expr_Cast_Bool
}

fn (mut this Class_wp_xmlrpc_server) escape(var_data rt.PhpVal) rt.PhpVal {
	mut var_data_mutated := var_data
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_data_mutated.dup().is_array()))))) {
		return rt.call_function('wp_slash', [var_data_mutated.dup()])
	}
	{
		mut iter_1 := var_data_mutated.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_v := item_1.val
			if rt.is_true(rt.new_bool(var_v.dup().is_array())) {
				this.escape(var_v.dup())
			} else if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_v.dup().is_object()))))) {
				var_v = rt.call_function('wp_slash', [var_v.dup()])
			}
		}
	}
	return rt.new_null()
}

fn (mut this Class_wp_xmlrpc_server) error(var_error rt.PhpVal, message bool)  {
	mut var_error_mutated := var_error
	if rt.is_true(rt.new_bool(var_message && rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_error_mutated.dup().is_object()))))))) {
		var_error_mutated = create_ixr_error(var_error_mutated.dup(), rt.new_bool(message).dup())
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(this.is_enabled)))) {
		rt.call_function('status_header', [rt.get_property(var_error_mutated, 'code')])
	}
	this.output(rt.call_method(var_error_mutated, 'getXml', []rt.PhpVal{}))
}

fn (mut this Class_wp_xmlrpc_server) get_custom_fields(var_post_id rt.PhpVal) rt.PhpVal {
	mut var_post_id_mutated := var_post_id
	var_post_id_mutated = // unsupported expression: Expr_Cast_Int
	mut var_custom_fields := []rt.PhpVal{}
	{
		mut iter_1 := rt.cast_array(rt.call_function('has_meta', [var_post_id_mutated.dup()])).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_meta := item_1.val
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_post_meta'), var_post_id_mutated.dup(), var_meta.array_get('meta_key')]))))) {
				continue
			}
			var_custom_fields << rt.create_array([rt.ArrayItem{ key: 'id', val: var_meta.array_get('meta_id') }, rt.ArrayItem{ key: 'key', val: var_meta.array_get('meta_key') }, rt.ArrayItem{ key: 'value', val: var_meta.array_get('meta_value') }])
		}
	}
	return var_custom_fields.dup()
}

fn (mut this Class_wp_xmlrpc_server) set_custom_fields(var_post_id rt.PhpVal, var_fields rt.PhpVal)  {
	mut var_post_id_mutated := var_post_id
	mut var_fields_mutated := var_fields
	var_post_id_mutated = // unsupported expression: Expr_Cast_Int
	{
		mut iter_1 := rt.cast_array(var_fields_mutated).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_meta := item_1.val
			if var_meta.array_isset(rt.new_string('id')) {
				var_meta.array_set('id', // unsupported expression: Expr_Cast_Int)
				mut var_pmeta := rt.call_function('get_metadata_by_mid', [rt.new_string('post'), var_meta.array_get('id')])
				if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_pmeta)))) || rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
					continue
				}
				if var_meta.array_isset(rt.new_string('key')) {
					var_meta.array_set('key', rt.call_function('wp_unslash', [var_meta.array_get('key')]))
					if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
						continue
					}
					var_meta.array_set('value', rt.call_function('wp_unslash', [var_meta.array_get('value')]))
					if rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_post_meta'), var_post_id_mutated.dup(), var_meta.array_get('key')])) {
						rt.call_function('update_metadata_by_mid', [rt.new_string('post'), var_meta.array_get('id'), var_meta.array_get('value')])
					}
				} else if rt.is_true(rt.call_function('current_user_can', [rt.new_string('delete_post_meta'), var_post_id_mutated.dup(), rt.get_property(var_pmeta, 'meta_key')])) {
					rt.call_function('delete_metadata_by_mid', [rt.new_string('post'), var_meta.array_get('id')])
				}
			} else if rt.is_true(rt.call_function('current_user_can', [rt.new_string('add_post_meta'), var_post_id_mutated.dup(), rt.call_function('wp_unslash', [var_meta.array_get('key')])])) {
				rt.call_function('add_post_meta', [var_post_id_mutated.dup(), var_meta.array_get('key'), var_meta.array_get('value')])
			}
		}
	}
}

fn (mut this Class_wp_xmlrpc_server) get_term_custom_fields(var_term_id rt.PhpVal) rt.PhpVal {
	mut var_term_id_mutated := var_term_id
	var_term_id_mutated = // unsupported expression: Expr_Cast_Int
	mut var_custom_fields := []rt.PhpVal{}
	{
		mut iter_1 := rt.cast_array(rt.call_function('has_term_meta', [var_term_id_mutated.dup()])).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_meta := item_1.val
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_term_meta'), var_term_id_mutated.dup()]))))) {
				continue
			}
			var_custom_fields << rt.create_array([rt.ArrayItem{ key: 'id', val: var_meta.array_get('meta_id') }, rt.ArrayItem{ key: 'key', val: var_meta.array_get('meta_key') }, rt.ArrayItem{ key: 'value', val: var_meta.array_get('meta_value') }])
		}
	}
	return var_custom_fields.dup()
}

fn (mut this Class_wp_xmlrpc_server) set_term_custom_fields(var_term_id rt.PhpVal, var_fields rt.PhpVal)  {
	mut var_term_id_mutated := var_term_id
	mut var_fields_mutated := var_fields
	var_term_id_mutated = // unsupported expression: Expr_Cast_Int
	{
		mut iter_1 := rt.cast_array(var_fields_mutated).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_meta := item_1.val
			if var_meta.array_isset(rt.new_string('id')) {
				var_meta.array_set('id', // unsupported expression: Expr_Cast_Int)
				mut var_pmeta := rt.call_function('get_metadata_by_mid', [rt.new_string('term'), var_meta.array_get('id')])
				if var_meta.array_isset(rt.new_string('key')) {
					var_meta.array_set('key', rt.call_function('wp_unslash', [var_meta.array_get('key')]))
					if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
						continue
					}
					var_meta.array_set('value', rt.call_function('wp_unslash', [var_meta.array_get('value')]))
					if rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_term_meta'), var_term_id_mutated.dup()])) {
						rt.call_function('update_metadata_by_mid', [rt.new_string('term'), var_meta.array_get('id'), var_meta.array_get('value')])
					}
				} else if rt.is_true(rt.call_function('current_user_can', [rt.new_string('delete_term_meta'), var_term_id_mutated.dup()])) {
					rt.call_function('delete_metadata_by_mid', [rt.new_string('term'), var_meta.array_get('id')])
				}
			} else if rt.is_true(rt.call_function('current_user_can', [rt.new_string('add_term_meta'), var_term_id_mutated.dup()])) {
				rt.call_function('add_term_meta', [var_term_id_mutated.dup(), var_meta.array_get('key'), var_meta.array_get('value')])
			}
		}
	}
}

fn (mut this Class_wp_xmlrpc_server) initialise_blog_option_info()  {
	this.blog_options = rt.create_array([rt.ArrayItem{ key: 'software_name', val: rt.create_array([rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [rt.new_string('Software Name')]) }, rt.ArrayItem{ key: 'readonly', val: true }, rt.ArrayItem{ key: 'value', val: 'WordPress' }]) }, rt.ArrayItem{ key: 'software_version', val: rt.create_array([rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [rt.new_string('Software Version')]) }, rt.ArrayItem{ key: 'readonly', val: true }, rt.ArrayItem{ key: 'value', val: rt.call_function('get_bloginfo', [rt.new_string('version')]) }]) }, rt.ArrayItem{ key: 'blog_url', val: rt.create_array([rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [rt.new_string('WordPress Address (URL)')]) }, rt.ArrayItem{ key: 'readonly', val: true }, rt.ArrayItem{ key: 'option', val: 'siteurl' }]) }, rt.ArrayItem{ key: 'home_url', val: rt.create_array([rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [rt.new_string('Site Address (URL)')]) }, rt.ArrayItem{ key: 'readonly', val: true }, rt.ArrayItem{ key: 'option', val: 'home' }]) }, rt.ArrayItem{ key: 'login_url', val: rt.create_array([rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [rt.new_string('Login Address (URL)')]) }, rt.ArrayItem{ key: 'readonly', val: true }, rt.ArrayItem{ key: 'value', val: rt.call_function('wp_login_url', []rt.PhpVal{}) }]) }, rt.ArrayItem{ key: 'admin_url', val: rt.create_array([rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [rt.new_string('The URL to the admin area')]) }, rt.ArrayItem{ key: 'readonly', val: true }, rt.ArrayItem{ key: 'value', val: rt.call_function('get_admin_url', []rt.PhpVal{}) }]) }, rt.ArrayItem{ key: 'image_default_link_type', val: rt.create_array([rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [rt.new_string('Image default link type')]) }, rt.ArrayItem{ key: 'readonly', val: true }, rt.ArrayItem{ key: 'option', val: 'image_default_link_type' }]) }, rt.ArrayItem{ key: 'image_default_size', val: rt.create_array([rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [rt.new_string('Image default size')]) }, rt.ArrayItem{ key: 'readonly', val: true }, rt.ArrayItem{ key: 'option', val: 'image_default_size' }]) }, rt.ArrayItem{ key: 'image_default_align', val: rt.create_array([rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [rt.new_string('Image default align')]) }, rt.ArrayItem{ key: 'readonly', val: true }, rt.ArrayItem{ key: 'option', val: 'image_default_align' }]) }, rt.ArrayItem{ key: 'template', val: rt.create_array([rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [rt.new_string('Template')]) }, rt.ArrayItem{ key: 'readonly', val: true }, rt.ArrayItem{ key: 'option', val: 'template' }]) }, rt.ArrayItem{ key: 'stylesheet', val: rt.create_array([rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [rt.new_string('Stylesheet')]) }, rt.ArrayItem{ key: 'readonly', val: true }, rt.ArrayItem{ key: 'option', val: 'stylesheet' }]) }, rt.ArrayItem{ key: 'post_thumbnail', val: rt.create_array([rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [rt.new_string('Post Thumbnail')]) }, rt.ArrayItem{ key: 'readonly', val: true }, rt.ArrayItem{ key: 'value', val: rt.call_function('current_theme_supports', [rt.new_string('post-thumbnails')]) }]) }, rt.ArrayItem{ key: 'time_zone', val: rt.create_array([rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [rt.new_string('Time Zone')]) }, rt.ArrayItem{ key: 'readonly', val: false }, rt.ArrayItem{ key: 'option', val: 'gmt_offset' }]) }, rt.ArrayItem{ key: 'blog_title', val: rt.create_array([rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [rt.new_string('Site Title')]) }, rt.ArrayItem{ key: 'readonly', val: false }, rt.ArrayItem{ key: 'option', val: 'blogname' }]) }, rt.ArrayItem{ key: 'blog_tagline', val: rt.create_array([rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [rt.new_string('Site Tagline')]) }, rt.ArrayItem{ key: 'readonly', val: false }, rt.ArrayItem{ key: 'option', val: 'blogdescription' }]) }, rt.ArrayItem{ key: 'date_format', val: rt.create_array([rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [rt.new_string('Date Format')]) }, rt.ArrayItem{ key: 'readonly', val: false }, rt.ArrayItem{ key: 'option', val: 'date_format' }]) }, rt.ArrayItem{ key: 'time_format', val: rt.create_array([rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [rt.new_string('Time Format')]) }, rt.ArrayItem{ key: 'readonly', val: false }, rt.ArrayItem{ key: 'option', val: 'time_format' }]) }, rt.ArrayItem{ key: 'users_can_register', val: rt.create_array([rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [rt.new_string('Allow new users to sign up')]) }, rt.ArrayItem{ key: 'readonly', val: false }, rt.ArrayItem{ key: 'option', val: 'users_can_register' }]) }, rt.ArrayItem{ key: 'thumbnail_size_w', val: rt.create_array([rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [rt.new_string('Thumbnail Width')]) }, rt.ArrayItem{ key: 'readonly', val: false }, rt.ArrayItem{ key: 'option', val: 'thumbnail_size_w' }]) }, rt.ArrayItem{ key: 'thumbnail_size_h', val: rt.create_array([rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [rt.new_string('Thumbnail Height')]) }, rt.ArrayItem{ key: 'readonly', val: false }, rt.ArrayItem{ key: 'option', val: 'thumbnail_size_h' }]) }, rt.ArrayItem{ key: 'thumbnail_crop', val: rt.create_array([rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [rt.new_string('Crop thumbnail to exact dimensions')]) }, rt.ArrayItem{ key: 'readonly', val: false }, rt.ArrayItem{ key: 'option', val: 'thumbnail_crop' }]) }, rt.ArrayItem{ key: 'medium_size_w', val: rt.create_array([rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [rt.new_string('Medium size image width')]) }, rt.ArrayItem{ key: 'readonly', val: false }, rt.ArrayItem{ key: 'option', val: 'medium_size_w' }]) }, rt.ArrayItem{ key: 'medium_size_h', val: rt.create_array([rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [rt.new_string('Medium size image height')]) }, rt.ArrayItem{ key: 'readonly', val: false }, rt.ArrayItem{ key: 'option', val: 'medium_size_h' }]) }, rt.ArrayItem{ key: 'medium_large_size_w', val: rt.create_array([rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [rt.new_string('Medium-Large size image width')]) }, rt.ArrayItem{ key: 'readonly', val: false }, rt.ArrayItem{ key: 'option', val: 'medium_large_size_w' }]) }, rt.ArrayItem{ key: 'medium_large_size_h', val: rt.create_array([rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [rt.new_string('Medium-Large size image height')]) }, rt.ArrayItem{ key: 'readonly', val: false }, rt.ArrayItem{ key: 'option', val: 'medium_large_size_h' }]) }, rt.ArrayItem{ key: 'large_size_w', val: rt.create_array([rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [rt.new_string('Large size image width')]) }, rt.ArrayItem{ key: 'readonly', val: false }, rt.ArrayItem{ key: 'option', val: 'large_size_w' }]) }, rt.ArrayItem{ key: 'large_size_h', val: rt.create_array([rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [rt.new_string('Large size image height')]) }, rt.ArrayItem{ key: 'readonly', val: false }, rt.ArrayItem{ key: 'option', val: 'large_size_h' }]) }, rt.ArrayItem{ key: 'default_comment_status', val: rt.create_array([rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [rt.new_string('Allow people to submit comments on new posts.')]) }, rt.ArrayItem{ key: 'readonly', val: false }, rt.ArrayItem{ key: 'option', val: 'default_comment_status' }]) }, rt.ArrayItem{ key: 'default_ping_status', val: rt.create_array([rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [rt.new_string('Allow link notifications from other blogs (pingbacks and trackbacks) on new posts.')]) }, rt.ArrayItem{ key: 'readonly', val: false }, rt.ArrayItem{ key: 'option', val: 'default_ping_status' }]) }])
	this.blog_options = rt.call_function('apply_filters', [rt.new_string('xmlrpc_blog_options'), this.blog_options])
}

fn (mut this Class_wp_xmlrpc_server) wp_getusersblogs(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
	if !(this.minimum_args(var_args_mutated.dup(), rt.new_int(2))) {
		return this.error
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{}))))) {
		rt.call_function('array_unshift', [var_args_mutated.dup(), rt.new_int(1)])
		return this.blogger_getusersblogs(var_args_mutated.dup())
	}
	this.escape(var_args_mutated.dup())
	mut var_username := var_args_mutated.array_get(0)
	mut var_password := var_args_mutated.array_get(1)
	mut var_user := rt.new_bool(this.login(var_username.dup(), var_password.dup()))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_user)))) {
		return this.error
	}
	rt.call_function('do_action', [rt.new_string('xmlrpc_call'), rt.new_string('wp.getUsersBlogs'), var_args_mutated.dup(), rt.new_object('wp_xmlrpc_server', ['IXR_Server'], &this)])
	mut var_blogs := rt.cast_array(rt.call_function('get_blogs_of_user', [rt.get_property(var_user, 'ID')]))
	mut var_struct := []rt.PhpVal{}
	mut var_primary_blog_id := rt.new_int(rt.new_int(0))
	mut var_active_blog := rt.call_function('get_active_blog_for_user', [rt.get_property(var_user, 'ID')])
	if rt.is_true(var_active_blog) {
		var_primary_blog_id = // unsupported expression: Expr_Cast_Int
	}
	mut var_current_network_id := rt.call_function('get_current_network_id', []rt.PhpVal{})
	{
		mut iter_1 := var_blogs.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_blog := item_1.val
			if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
				continue
			}
			mut var_blog_id := rt.get_property(var_blog, 'userblog_id')
			rt.call_function('switch_to_blog', [var_blog_id.dup()])
			mut var_is_admin := rt.call_function('current_user_can', [rt.new_string('manage_options')])
			mut var_is_primary := rt.identical(// unsupported expression: Expr_Cast_Int, var_primary_blog_id)
			var_struct.array_push(rt.create_array([rt.ArrayItem{ key: 'isAdmin', val: var_is_admin }, rt.ArrayItem{ key: 'isPrimary', val: var_is_primary }, rt.ArrayItem{ key: 'url', val: rt.call_function('home_url', [rt.new_string('/')]) }, rt.ArrayItem{ key: 'blogid', val: // unsupported expression: Expr_Cast_String }, rt.ArrayItem{ key: 'blogName', val: rt.call_function('get_option', [rt.new_string('blogname')]) }, rt.ArrayItem{ key: 'xmlrpc', val: rt.call_function('site_url', [rt.new_string('xmlrpc.php'), rt.new_string('rpc')]) }]))
			rt.call_function('restore_current_blog', []rt.PhpVal{})
		}
	}
	return var_struct.dup()
}

fn (mut this Class_wp_xmlrpc_server) minimum_args(var_args rt.PhpVal, var_count rt.PhpVal) bool {
	mut var_args_mutated := var_args
	mut var_count_mutated := var_count
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_args_mutated.dup().is_array()))))) || rt.is_true(rt.less(rt.new_int(var_args_mutated.dup().array_count()), var_count_mutated)))) {
		this.error = create_ixr_error(rt.new_int(400), rt.call_function('__', [rt.new_string('Insufficient arguments passed to this XML-RPC method.')]))
		return false
	}
	return true
}

fn (mut this Class_wp_xmlrpc_server) _prepare_taxonomy(var_taxonomy rt.PhpVal, var_fields rt.PhpVal) rt.PhpVal {
	mut var_taxonomy_mutated := var_taxonomy
	mut var_fields_mutated := var_fields
	mut var__taxonomy := { : , : , : , : , : , :  }
	if rt.is_true(rt.call_function('in_array', [, .dup(), ])) {
		
	}
	if rt.is_true() {
	}
	if rt.is_true() {
	}
	if rt.is_true() {
	}
	return 
}

fn (mut this Class_wp_xmlrpc_server) _prepare_term(var_term rt.PhpVal) rt.PhpVal {
	mut var_term_mutated := var_term
}

fn (mut this Class_wp_xmlrpc_server) _convert_date(var_date rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_wp_xmlrpc_server) _convert_date_gmt(var_date_gmt rt.PhpVal, var_date rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_wp_xmlrpc_server) _prepare_post(var_post rt.PhpVal, var_fields rt.PhpVal) rt.PhpVal {
	mut var_post_mutated := var_post
	mut var_fields_mutated := var_fields
}

fn (mut this Class_wp_xmlrpc_server) _prepare_post_type(var_post_type rt.PhpVal, var_fields rt.PhpVal) rt.PhpVal {
	mut var_post_type_mutated := var_post_type
	mut var_fields_mutated := var_fields
}

fn (mut this Class_wp_xmlrpc_server) _prepare_media_item(var_media_item rt.PhpVal, thumbnail_size string) rt.PhpVal {
	mut thumbnail_size_mutated := thumbnail_size
}

fn (mut this Class_wp_xmlrpc_server) _prepare_page(var_page rt.PhpVal) rt.PhpVal {
	mut var_page_mutated := var_page
}

fn (mut this Class_wp_xmlrpc_server) _prepare_comment(var_comment rt.PhpVal) rt.PhpVal {
	mut var_comment_mutated := var_comment
}

fn (mut this Class_wp_xmlrpc_server) _prepare_user(var_user rt.PhpVal, var_fields rt.PhpVal) rt.PhpVal {
	mut var_user_mutated := var_user
	mut var_fields_mutated := var_fields
}

fn (mut this Class_wp_xmlrpc_server) wp_newpost(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
}

fn (mut this Class_wp_xmlrpc_server) _is_greater_than_one(var_count rt.PhpVal) rt.PhpVal {
	mut var_count_mutated := var_count
}

fn (mut this Class_wp_xmlrpc_server) _toggle_sticky(var_post_data rt.PhpVal, update bool) rt.PhpVal {
	mut var_post_data_mutated := var_post_data
	mut update_mutated := update
	return rt.new_null()
}

fn (mut this Class_wp_xmlrpc_server) _insert_post(var_user rt.PhpVal, var_content_struct rt.PhpVal) rt.PhpVal {
	mut var_user_mutated := var_user
	mut var_content_struct_mutated := var_content_struct
}

fn (mut this Class_wp_xmlrpc_server) wp_editpost(var_args rt.PhpVal) bool {
	mut var_args_mutated := var_args
}

fn (mut this Class_wp_xmlrpc_server) wp_deletepost(var_args rt.PhpVal) bool {
	mut var_args_mutated := var_args
}

fn (mut this Class_wp_xmlrpc_server) wp_getpost(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
}

fn (mut this Class_wp_xmlrpc_server) wp_getposts(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
}

fn (mut this Class_wp_xmlrpc_server) wp_newterm(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
}

fn (mut this Class_wp_xmlrpc_server) wp_editterm(var_args rt.PhpVal) bool {
	mut var_args_mutated := var_args
}

fn (mut this Class_wp_xmlrpc_server) wp_deleteterm(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
}

fn (mut this Class_wp_xmlrpc_server) wp_getterm(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
}

fn (mut this Class_wp_xmlrpc_server) wp_getterms(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
}

fn (mut this Class_wp_xmlrpc_server) wp_gettaxonomy(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
}

fn (mut this Class_wp_xmlrpc_server) wp_gettaxonomies(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
}

fn (mut this Class_wp_xmlrpc_server) wp_getuser(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
}

fn (mut this Class_wp_xmlrpc_server) wp_getusers(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
}

fn (mut this Class_wp_xmlrpc_server) wp_getprofile(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
}

fn (mut this Class_wp_xmlrpc_server) wp_editprofile(var_args rt.PhpVal) bool {
	mut var_args_mutated := var_args
}

fn (mut this Class_wp_xmlrpc_server) wp_getpage(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
	return rt.new_null()
}

fn (mut this Class_wp_xmlrpc_server) wp_getpages(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
}

fn (mut this Class_wp_xmlrpc_server) wp_newpage(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
}

fn (mut this Class_wp_xmlrpc_server) wp_deletepage(var_args rt.PhpVal) bool {
	mut var_args_mutated := var_args
}

fn (mut this Class_wp_xmlrpc_server) wp_editpage(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
}

fn (mut this Class_wp_xmlrpc_server) wp_getpagelist(var_args rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_args_mutated := var_args
}

fn (mut this Class_wp_xmlrpc_server) wp_getauthors(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
}

fn (mut this Class_wp_xmlrpc_server) wp_gettags(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
}

fn (mut this Class_wp_xmlrpc_server) wp_newcategory(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
}

fn (mut this Class_wp_xmlrpc_server) wp_deletecategory(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
}

fn (mut this Class_wp_xmlrpc_server) wp_suggestcategories(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
}

fn (mut this Class_wp_xmlrpc_server) wp_getcomment(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
}

fn (mut this Class_wp_xmlrpc_server) wp_getcomments(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
}

fn (mut this Class_wp_xmlrpc_server) wp_deletecomment(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
}

fn (mut this Class_wp_xmlrpc_server) wp_editcomment(var_args rt.PhpVal) bool {
	mut var_args_mutated := var_args
}

fn (mut this Class_wp_xmlrpc_server) wp_newcomment(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
}

fn (mut this Class_wp_xmlrpc_server) wp_getcommentstatuslist(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
}

fn (mut this Class_wp_xmlrpc_server) wp_getcommentcount(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
}

fn (mut this Class_wp_xmlrpc_server) wp_getpoststatuslist(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
}

fn (mut this Class_wp_xmlrpc_server) wp_getpagestatuslist(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
}

fn (mut this Class_wp_xmlrpc_server) wp_getpagetemplates(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
}

fn (mut this Class_wp_xmlrpc_server) wp_getoptions(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
}

fn (mut this Class_wp_xmlrpc_server) _getoptions(var_options rt.PhpVal) rt.PhpVal {
	mut var_options_mutated := var_options
}

fn (mut this Class_wp_xmlrpc_server) wp_setoptions(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
}

fn (mut this Class_wp_xmlrpc_server) wp_getmediaitem(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
}

fn (mut this Class_wp_xmlrpc_server) wp_getmedialibrary(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
}

fn (mut this Class_wp_xmlrpc_server) wp_getpostformats(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
}

fn (mut this Class_wp_xmlrpc_server) wp_getposttype(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
}

fn (mut this Class_wp_xmlrpc_server) wp_getposttypes(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
}

fn (mut this Class_wp_xmlrpc_server) wp_getrevisions(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
}

fn (mut this Class_wp_xmlrpc_server) wp_restorerevision(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
}

fn (mut this Class_wp_xmlrpc_server) blogger_getusersblogs(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
}

fn (mut this Class_wp_xmlrpc_server) _multisite_getusersblogs(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
	return rt.new_null()
}

fn (mut this Class_wp_xmlrpc_server) blogger_getuserinfo(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
}

fn (mut this Class_wp_xmlrpc_server) blogger_getpost(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
}

fn (mut this Class_wp_xmlrpc_server) blogger_getrecentposts(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
}

fn (mut this Class_wp_xmlrpc_server) blogger_gettemplate(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
}

fn (mut this Class_wp_xmlrpc_server) blogger_settemplate(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
}

fn (mut this Class_wp_xmlrpc_server) blogger_newpost(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
}

fn (mut this Class_wp_xmlrpc_server) blogger_editpost(var_args rt.PhpVal) bool {
	mut var_args_mutated := var_args
}

fn (mut this Class_wp_xmlrpc_server) blogger_deletepost(var_args rt.PhpVal) bool {
	mut var_args_mutated := var_args
}

fn (mut this Class_wp_xmlrpc_server) mw_newpost(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
}

fn (mut this Class_wp_xmlrpc_server) add_enclosure_if_new(var_post_id rt.PhpVal, var_enclosure rt.PhpVal)  {
	mut var_post_id_mutated := var_post_id
	mut var_enclosure_mutated := var_enclosure
}

fn (mut this Class_wp_xmlrpc_server) attach_uploads(var_post_id rt.PhpVal, var_post_content rt.PhpVal)  {
	mut var_wpdb := rt.new_null()
	mut var_post_id_mutated := var_post_id
	mut var_post_content_mutated := var_post_content
}

fn (mut this Class_wp_xmlrpc_server) mw_editpost(var_args rt.PhpVal) bool {
	mut var_args_mutated := var_args
}

fn (mut this Class_wp_xmlrpc_server) mw_getpost(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
	return rt.new_null()
}

fn (mut this Class_wp_xmlrpc_server) mw_getrecentposts(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
}

fn (mut this Class_wp_xmlrpc_server) mw_getcategories(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
}

fn (mut this Class_wp_xmlrpc_server) mw_newmediaobject(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
}

fn (mut this Class_wp_xmlrpc_server) mt_getrecentposttitles(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
}

fn (mut this Class_wp_xmlrpc_server) mt_getcategorylist(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
}

fn (mut this Class_wp_xmlrpc_server) mt_getpostcategories(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
}

fn (mut this Class_wp_xmlrpc_server) mt_setpostcategories(var_args rt.PhpVal) bool {
	mut var_args_mutated := var_args
}

fn (mut this Class_wp_xmlrpc_server) mt_supportedmethods() rt.PhpVal {
}

fn (mut this Class_wp_xmlrpc_server) mt_supportedtextfilters() rt.PhpVal {
}

fn (mut this Class_wp_xmlrpc_server) mt_gettrackbackpings(var_post_id rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_post_id_mutated := var_post_id
}

fn (mut this Class_wp_xmlrpc_server) mt_publishpost(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
}

fn (mut this Class_wp_xmlrpc_server) pingback_ping(var_args rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_match := []rt.PhpVal{}
	mut var_matchtitle := []rt.PhpVal{}
	mut var_args_mutated := var_args
}

fn (mut this Class_wp_xmlrpc_server) pingback_extensions_getpingbacks(var_url rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_url_mutated := var_url
}

fn (mut this Class_wp_xmlrpc_server) pingback_error(var_code rt.PhpVal, var_message rt.PhpVal) rt.PhpVal {
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

fn create_wp_xmlrpc_server() &Class_wp_xmlrpc_server {
	mut obj := &Class_wp_xmlrpc_server{
		PhpObjectBase: rt.PhpObjectBase{}
		methods: rt.new_null()
		blog_options: rt.new_null()
		error: rt.new_null()
		auth_failed: false
		is_enabled: rt.new_null()
	}
	obj.construct()
	return obj
}

fn create_ixr_server() &Class_IXR_Server {
	mut obj := &Class_IXR_Server{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_ixr_error() &Class_IXR_Error {
	mut obj := &Class_IXR_Error{
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
			return this.login_pass_ok(dispatch_arg_0, dispatch_arg_1)
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
			return this._insert_post(dispatch_arg_0, dispatch_arg_1)
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
			return this.wp_newterm(dispatch_arg_0)
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
			return this.wp_newcategory(dispatch_arg_0)
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
			return this.wp_restorerevision(dispatch_arg_0)
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
			return this.mw_newpost(dispatch_arg_0)
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
		else { return none }
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
		'methods' { this.methods = val; return true }
		'blog_options' { this.blog_options = val; return true }
		'error' { this.error = val; return true }
		'auth_failed' { this.auth_failed = (val).to_bool(); return true }
		'is_enabled' { this.is_enabled = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
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




pub fn init_wp_includes_class_wp_xmlrpc_server_php() {
}
