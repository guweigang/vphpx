import rt

pub fn Class_Automattic_WooCommerce_EmailEditor_Engine_Email_Editor.woocommerce_email_meta_theme_type() string {
	return 'woocommerce_email_theme'
}

struct Class_Automattic_WooCommerce_EmailEditor_Engine_Email_Editor {
	rt.PhpObjectBase
pub mut:
	email_api_controller          rt.PhpVal = rt.new_null()
	templates                     rt.PhpVal = rt.new_null()
	patterns                      rt.PhpVal = rt.new_null()
	send_preview_email            rt.PhpVal = rt.new_null()
	personalization_tags_registry rt.PhpVal = rt.new_null()
	logger                        rt.PhpVal = rt.new_null()
	assets_manager                rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Email_Editor) construct(mut var_email_api_controller Class_Automattic_WooCommerce_EmailEditor_Engine_Email_Api_Controller, mut var_templates Class_Automattic_WooCommerce_EmailEditor_Engine_Templates_Templates, mut var_patterns Class_Automattic_WooCommerce_EmailEditor_Engine_Patterns_Patterns, mut var_send_preview_email Class_Automattic_WooCommerce_EmailEditor_Engine_Send_Preview_Email, mut var_personalization_tags_controller Class_Automattic_WooCommerce_EmailEditor_Engine_PersonalizationTags_Personalization_Tags_Registry, mut var_logger Class_Automattic_WooCommerce_EmailEditor_Engine_Logger_Email_Editor_Logger, mut var_assets_manager Class_Automattic_WooCommerce_EmailEditor_Engine_Assets_Manager) {
	this.email_api_controller = var_email_api_controller
	this.templates = var_templates
	this.patterns = var_patterns
	this.send_preview_email = var_send_preview_email
	this.personalization_tags_registry = var_personalization_tags_controller
	this.logger = var_logger
	this.assets_manager = var_assets_manager
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Email_Editor) initialize() {
	rt.call_method(this.logger, 'info', [rt.new_string('Initializing email editor')])
	rt.call_function('do_action', [rt.new_string('woocommerce_email_editor_initialized')])
	rt.call_function('add_filter', [
		rt.new_string('woocommerce_email_editor_rendering_theme_styles'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_EmailEditor_Engine_Email_Editor',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'extend_email_theme_styles' },
		]),
		rt.new_int(10),
		rt.new_int(2),
	])
	this.register_block_patterns()
	this.register_email_post_types()
	this.register_block_templates()
	this.register_email_post_sent_status()
	this.register_personalization_tags()
	mut var_is_editor_page := rt.call_function('apply_filters', [
		rt.new_string('woocommerce_is_email_editor_page'),
		rt.new_bool(false),
	])
	if rt.is_true(var_is_editor_page) {
		this.extend_email_post_api()
		rt.call_method(this.assets_manager, 'initialize', []rt.PhpVal{})
	}
	rt.call_function('add_action', [rt.new_string('rest_api_init'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_EmailEditor_Engine_Email_Editor',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'register_email_editor_api_routes' },
		])])
	rt.call_function('add_filter', [
		rt.new_string('woocommerce_email_editor_send_preview_email'),
		rt.create_array([rt.ArrayItem{ key: none, val: this.send_preview_email },
			rt.ArrayItem{ key: none, val: 'send_preview_email' }]),
		rt.new_int(11),
		rt.new_int(1),
	])
	rt.call_function('add_filter', [rt.new_string('single_template'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_EmailEditor_Engine_Email_Editor',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'load_email_preview_template' },
		])])
	rt.call_function('add_filter', [rt.new_string('preview_post_link'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_EmailEditor_Engine_Email_Editor',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'update_preview_post_link' },
		]),
		rt.new_int(10), rt.new_int(2)])
	rt.call_method(this.logger, 'info', [
		rt.new_string('Email editor initialized successfully'),
	])
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Email_Editor) register_block_templates() {
	mut var_request_uri := rt.new_string('')
	if rt.get_superglobal('_SERVER').array_isset(rt.new_string('REQUEST_URI'))
		&& rt.get_superglobal('_SERVER').array_get(rt.new_string('REQUEST_URI')).is_string() {
		var_request_uri = rt.call_function('sanitize_text_field', [
			rt.call_function('wp_unslash',
				[rt.get_superglobal('_SERVER').array_get(rt.new_string('REQUEST_URI'))]),
		])
	}
	if rt.is_true(rt.identical(rt.call_function('strstr', [var_request_uri.clone(),
		rt.new_string('site-editor.php')]), rt.new_bool(false)))
	{
		mut var_post_types := rt.call_function('array_column', [
			this.get_post_types(), rt.new_string('name')])
		rt.call_method(this.templates, 'initialize', [var_post_types.clone()])
	}
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Email_Editor) register_block_patterns() {
	rt.call_method(this.patterns, 'initialize', []rt.PhpVal{})
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Email_Editor) register_email_post_types() {
	mut iter_1 := this.get_post_types().iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_post_type := item_1.val
		rt.call_function('register_post_type', [var_post_type.array_get(rt.new_string('name')),
			rt.call_function('array_merge', [this.get_default_email_post_args(),
				var_post_type.array_get(rt.new_string('args'))])])
	}
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Email_Editor) register_personalization_tags() {
	rt.call_method(this.personalization_tags_registry, 'initialize', []rt.PhpVal{})
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Email_Editor) get_post_types() rt.PhpVal {
	mut var_post_types := rt.new_array()
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_email_editor_post_types'),
		var_post_types.clone(),
	])
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Email_Editor) get_default_email_post_args() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'public', val: false },
		rt.ArrayItem{ key: 'hierarchical', val: false }, rt.ArrayItem{ key: 'show_ui', val: true },
		rt.ArrayItem{ key: 'show_in_menu', val: false }, rt.ArrayItem{
			key: 'show_in_nav_menus'
			val: false
		}, rt.ArrayItem{ key: 'supports', val: rt.create_array([
			rt.ArrayItem{ key: 'editor', val: rt.create_array([
				rt.ArrayItem{ key: 'default-mode', val: 'template-locked' },
			]) },
			rt.ArrayItem{ key: none, val: 'title' },
			rt.ArrayItem{ key: none, val: 'custom-fields' },
		]) }, rt.ArrayItem{ key: 'has_archive', val: true }, rt.ArrayItem{
			key: 'show_in_rest'
			val: true
		}, rt.ArrayItem{ key: 'default_rendering_mode', val: 'template-locked' },
		rt.ArrayItem{ key: 'publicly_queryable', val: true }])
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Email_Editor) register_email_post_sent_status() {
	mut var_default_args := rt.create_array([rt.ArrayItem{ key: 'public', val: false },
		rt.ArrayItem{ key: 'exclude_from_search', val: true },
		rt.ArrayItem{ key: 'internal', val: true }, rt.ArrayItem{
			key: 'show_in_admin_all_list'
			val: false
		}, rt.ArrayItem{ key: 'show_in_admin_status_list', val: false },
		rt.ArrayItem{ key: 'private', val: true }])
	mut var_args := rt.call_function('apply_filters', [
		rt.new_string('woocommerce_email_editor_post_sent_status_args'),
		var_default_args.clone(),
	])
	rt.call_function('register_post_status', [rt.new_string('sent'),
		var_args.clone()])
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Email_Editor) extend_email_post_api() {
	mut var_email_post_types := rt.call_function('array_column', [
		this.get_post_types(), rt.new_string('name')])
	rt.call_function('register_rest_field', [var_email_post_types.clone(),
		rt.new_string('email_data'),
		rt.create_array([
			rt.ArrayItem{ key: 'get_callback', val: rt.create_array([
				rt.ArrayItem{ key: none, val: this.email_api_controller },
				rt.ArrayItem{ key: none, val: 'get_email_data' },
			]) },
			rt.ArrayItem{ key: 'update_callback', val: rt.create_array([
				rt.ArrayItem{ key: none, val: this.email_api_controller },
				rt.ArrayItem{ key: none, val: 'save_email_data' },
			]) },
			rt.ArrayItem{ key: 'schema', val: rt.call_method(this.email_api_controller,
				'get_email_data_schema', []rt.PhpVal{}) },
		])])
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Email_Editor) register_email_editor_api_routes() {
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_request := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
			rt.new_string('edit_posts'),
		])))))
		{
			return
		}
		mut var_post_id := rt.call_method(var_request, 'get_param', [
			rt.new_string('postId'),
		])
		if !(var_post_id.clone().is_long() || var_post_id.clone().is_double())
			|| rt.new_int(var_post_id.to_i64()) <= 0 {
			return
		}
		return
	}
	rt.call_function('register_rest_route', [
		rt.new_string('woocommerce-email-editor/v1'),
		rt.new_string('/send_preview_email'),
		rt.create_array([rt.ArrayItem{ key: 'methods', val: 'POST' },
			rt.ArrayItem{ key: 'callback', val: rt.create_array([
				rt.ArrayItem{ key: none, val: this.email_api_controller },
				rt.ArrayItem{ key: none, val: 'send_preview_email_data' },
			]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.new_closure(closure_1_fn) }]),
	])
	closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		return
	}
	rt.call_function('register_rest_route', [
		rt.new_string('woocommerce-email-editor/v1'),
		rt.new_string('/get_personalization_tags'),
		rt.create_array([rt.ArrayItem{ key: 'methods', val: 'GET' },
			rt.ArrayItem{ key: 'callback', val: rt.create_array([
				rt.ArrayItem{ key: none, val: this.email_api_controller },
				rt.ArrayItem{ key: none, val: 'get_personalization_tags' },
			]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.new_closure(closure_2_fn) }]),
	])
	closure_3_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		return
	}
	rt.call_function('register_rest_route', [
		rt.new_string('woocommerce-email-editor/v1'),
		rt.new_string('/personalization_tags'),
		rt.create_array([rt.ArrayItem{ key: 'methods', val: 'GET' },
			rt.ArrayItem{ key: 'callback', val: rt.create_array([
				rt.ArrayItem{ key: none, val: this.email_api_controller },
				rt.ArrayItem{ key: none, val: 'get_personalization_tags_collection' },
			]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.new_closure(closure_3_fn) },
			rt.ArrayItem{ key: 'args', val: rt.create_array([
				rt.ArrayItem{ key: 'post_id', val: rt.create_array([
					rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
						rt.new_string('The post ID for context-aware tag filtering.'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'type', val: 'integer' },
					rt.ArrayItem{ key: 'required', val: false },
					rt.ArrayItem{ key: 'sanitize_callback', val: 'absint' },
				]) },
			]) }]),
	])
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Email_Editor) extend_email_theme_styles(mut var_theme Class_WP_Theme_JSON, mut var_post Class_WP_Post) rt.PhpVal {
	mut var_post_mutated := var_post
	mut var_email_theme := rt.call_function('get_post_meta', [
		rt.get_property(var_post_mutated, 'ID'),
		Class_Automattic_WooCommerce_EmailEditor_Engine_Automattic_WooCommerce_EmailEditor_Engine_Email_Editor.woocommerce_email_meta_theme_type(),
		rt.new_bool(true),
	])
	if rt.is_true(var_email_theme) && var_email_theme.clone().is_array() {
		var_theme.merge(create_wp_theme_json(var_email_theme.clone()))
	}
	return rt.new_object('WP_Theme_JSON', []string{}, var_theme)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Email_Editor) get_current_post() rt.PhpVal {
	mut var_GLOBALS := rt.new_null()
	if rt.get_superglobal('_GET').array_isset(rt.new_string('post')) {
		mut var_post_id := rt.new_int(0)
		if rt.is_true(rt.new_bool(rt.get_superglobal('_GET').array_get(rt.new_string('post')).is_string())) {
			var_post_id =
				rt.new_int(rt.get_superglobal('_GET').array_get(rt.new_string('post')).to_i64())
		}
		mut var_current_post := rt.call_function('get_post', [
			var_post_id.clone()])
	} else {
		var_current_post = var_GLOBALS.array_get(rt.new_string('post'))
	}
	return var_current_post.clone()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Email_Editor) current_post_is_email_post_type(var_current_post_type rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(var_current_post_type)))) {
		return false
	}
	mut var_email_post_types := rt.call_function('array_column', [
		this.get_post_types(), rt.new_string('name')])
	return (rt.call_function('in_array', [var_current_post_type.clone(),
		var_email_post_types.clone(), rt.new_bool(true)])).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Email_Editor) load_email_preview_template(var_template rt.PhpVal) string {
	mut var_post := this.get_current_post()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_post, 'WP_Post')))))) {
		return var_template.str()
	}
	if !(this.current_post_is_email_post_type(rt.get_property(var_post, 'post_type'))) {
		return var_template.str()
	}
	closure_4_fn := fn [var_post] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		return (rt.call_method(this.send_preview_email, 'render_html', [
			var_post.clone()])).str()
	}
	rt.call_function('add_filter', [
		rt.new_string('woocommerce_email_editor_preview_post_template_html'),
		rt.new_closure(closure_4_fn),
	])
	return @DIR + '/Templates/single-email-post-template.php'
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Email_Editor) update_preview_post_link(var_preview_link rt.PhpVal, var_post rt.PhpVal) rt.PhpVal {
	mut var_post_mutated := var_post
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_post_mutated, 'WP_Post')))))) {
		return var_preview_link.clone()
	}
	if !(this.current_post_is_email_post_type(rt.get_property(var_post_mutated, 'post_type'))) {
		return var_preview_link.clone()
	}
	return rt.call_function('remove_query_arg', [rt.new_string('preview_nonce'),
		var_preview_link.clone()])
}

struct Class_WP_Theme_JSON {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_emaileditor_engine_email_editor(arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal, arg_3 rt.PhpVal, arg_4 rt.PhpVal, arg_5 rt.PhpVal, arg_6 rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditor_Engine_Email_Editor {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Engine_Email_Editor{
		PhpObjectBase:                 rt.PhpObjectBase{}
		email_api_controller:          rt.new_null()
		templates:                     rt.new_null()
		patterns:                      rt.new_null()
		send_preview_email:            rt.new_null()
		personalization_tags_registry: rt.new_null()
		logger:                        rt.new_null()
		assets_manager:                rt.new_null()
	}
	obj.construct(arg_0, arg_1, arg_2, arg_3, arg_4, arg_5, arg_6)
	return obj
}

fn create_wp_theme_json(_args ...rt.PhpVal) &Class_WP_Theme_JSON {
	mut obj := &Class_WP_Theme_JSON{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Email_Editor) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Email_Api_Controller](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Templates_Templates](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Patterns_Patterns](if args.len > 2 {
				args[2]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_3 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Send_Preview_Email](if args.len > 3 {
				args[3]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_4 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_PersonalizationTags_Personalization_Tags_Registry](if args.len > 4 {
				args[4]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_5 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Logger_Email_Editor_Logger](if args.len > 5 {
				args[5]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_6 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Assets_Manager](if args.len > 6 {
				args[6]
			} else {
				rt.new_null()
			})
			this.construct(mut dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2, mut
				dispatch_arg_3, mut dispatch_arg_4, mut dispatch_arg_5, mut dispatch_arg_6)
			return rt.new_null()
		}
		'initialize' {
			this.initialize()
			return rt.new_null()
		}
		'register_block_templates' {
			this.register_block_templates()
			return rt.new_null()
		}
		'register_block_patterns' {
			this.register_block_patterns()
			return rt.new_null()
		}
		'register_email_post_types' {
			this.register_email_post_types()
			return rt.new_null()
		}
		'register_personalization_tags' {
			this.register_personalization_tags()
			return rt.new_null()
		}
		'get_post_types' {
			return this.get_post_types()
		}
		'get_default_email_post_args' {
			return this.get_default_email_post_args()
		}
		'register_email_post_sent_status' {
			this.register_email_post_sent_status()
			return rt.new_null()
		}
		'extend_email_post_api' {
			this.extend_email_post_api()
			return rt.new_null()
		}
		'register_email_editor_api_routes' {
			this.register_email_editor_api_routes()
			return rt.new_null()
		}
		'extend_email_theme_styles' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_Theme_JSON](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_WP_Post](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			return this.extend_email_theme_styles(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		'get_current_post' {
			return this.get_current_post()
		}
		'current_post_is_email_post_type' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.current_post_is_email_post_type(dispatch_arg_0))
		}
		'load_email_preview_template' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.load_email_preview_template(dispatch_arg_0))
		}
		'update_preview_post_link' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.update_preview_post_link(dispatch_arg_0, dispatch_arg_1)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Engine_Email_Editor) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'email_api_controller' { return this.email_api_controller }
		'templates' { return this.templates }
		'patterns' { return this.patterns }
		'send_preview_email' { return this.send_preview_email }
		'personalization_tags_registry' { return this.personalization_tags_registry }
		'logger' { return this.logger }
		'assets_manager' { return this.assets_manager }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Email_Editor) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'email_api_controller' {
			this.email_api_controller = val
			return true
		}
		'templates' {
			this.templates = val
			return true
		}
		'patterns' {
			this.patterns = val
			return true
		}
		'send_preview_email' {
			this.send_preview_email = val
			return true
		}
		'personalization_tags_registry' {
			this.personalization_tags_registry = val
			return true
		}
		'logger' {
			this.logger = val
			return true
		}
		'assets_manager' {
			this.assets_manager = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_WP_Theme_JSON) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Theme_JSON) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Theme_JSON) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
