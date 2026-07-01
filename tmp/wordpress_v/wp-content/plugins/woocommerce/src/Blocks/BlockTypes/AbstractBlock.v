import rt

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock {
	rt.PhpObjectBase
pub mut:
		namespace rt.PhpVal = rt.new_string('woocommerce')
		block_name rt.PhpVal = rt.new_string('')
		enqueued_assets bool
		asset_api rt.PhpVal = rt.new_null()
		asset_data_registry rt.PhpVal = rt.new_null()
		integration_registry rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock) construct(mut var_asset_api Class_Automattic_WooCommerce_Blocks_Assets_Api, mut var_asset_data_registry Class_Automattic_WooCommerce_Blocks_Assets_AssetDataRegistry, mut var_integration_registry Class_Automattic_WooCommerce_Blocks_Integrations_IntegrationRegistry, block_name string)  {
	this.asset_api = var_asset_api.dup()
	this.asset_data_registry = var_asset_data_registry.dup()
	this.integration_registry = var_integration_registry.dup()
	this.block_name = if var_block_name.len > 0 && var_block_name != '0' { rt.new_string(block_name) } else { this.block_name }
	this.initialize()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock) get_full_block_name() string {
	return (this.namespace).str() + '/' + (this.block_name).str()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock) render_callback(var_attributes rt.PhpVal, content string, var_block rt.PhpVal) rt.PhpVal {
	mut var_render_callback_attributes := this.parse_render_callback_attributes(var_attributes.dup())
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_admin', []rt.PhpVal{}))))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'is_rest_api_request', []rt.PhpVal{}))))))) {
		this.register_block_type_assets()
		this.enqueue_assets(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Blocks_BlockTypes_array](var_render_callback_attributes), rt.new_string(content), var_block.dup())
	}
	return this.render(var_render_callback_attributes.dup(), rt.new_string(content), var_block.dup())
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock) enqueue_editor_assets()  {
	if rt.is_true(this.enqueued_assets) {
		return rt.new_null()
	}
	this.register_block_type_assets()
	this.enqueue_data(rt.new_null())
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock) is_block_editor() bool {
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_admin', []rt.PhpVal{}))))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('get_current_screen')]))))))) {
		return false
	}
	mut var_screen := rt.call_function('get_current_screen', []rt.PhpVal{})
	return rt.is_true(var_screen) && rt.is_true(rt.call_method(var_screen, 'is_block_editor', []rt.PhpVal{}))
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock) initialize() bool {
	if !rt.is_true(this.block_name) {
		rt.call_function('_doing_it_wrong', [rt.new_string(@METHOD), rt.call_function('esc_html__', [rt.new_string('Block name is required.'), rt.new_string('woocommerce')]), rt.new_string('4.5.0')])
		return false
	}
	rt.call_method(this.integration_registry, 'initialize', [(this.block_name).str() + '_block'])
	this.register_block_type()
	rt.call_function('add_action', [rt.new_string('enqueue_block_editor_assets'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'enqueue_editor_assets' }])])
	return false
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock) register_block_type_assets()  {
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		mut var_data := rt.call_method(this.asset_api, 'get_script_data', [this.get_block_type_editor_script(rt.new_string('path'))])
		mut var_has_i18n := rt.call_function('in_array', [rt.new_string('wp-i18n'), var_data.array_get('dependencies'), rt.new_bool(true)])
		rt.call_method(this.asset_api, 'register_script', [this.get_block_type_editor_script(rt.new_string('handle')), this.get_block_type_editor_script(rt.new_string('path')), rt.call_function('array_merge', [this.get_block_type_editor_script(rt.new_string('dependencies')), rt.call_method(this.integration_registry, 'get_all_registered_editor_script_handles', []rt.PhpVal{})]), var_has_i18n.dup()])
	}
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		var_data = rt.call_method(this.asset_api, 'get_script_data', [this.get_block_type_script(rt.new_string('path'))])
		var_has_i18n = rt.call_function('in_array', [rt.new_string('wp-i18n'), var_data.array_get('dependencies'), rt.new_bool(true)])
		rt.call_method(this.asset_api, 'register_script', [this.get_block_type_script(rt.new_string('handle')), this.get_block_type_script(rt.new_string('path')), rt.call_function('array_merge', [this.get_block_type_script(rt.new_string('dependencies')), rt.call_method(this.integration_registry, 'get_all_registered_script_handles', []rt.PhpVal{})]), var_has_i18n.dup()])
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock) register_chunk_translations(var_chunks rt.PhpVal)  {
	mut var_chunks_mutated := var_chunks
	{
		mut iter_1 := var_chunks_mutated.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_chunk := item_1.val
			mut var_handle := rt.new_string('wc-blocks-' + (var_chunk).str() + '-chunk')
			rt.call_method(this.asset_api, 'register_script', [var_handle.dup(), rt.call_method(this.asset_api, 'get_block_asset_build_path', [var_chunk.dup()]), rt.new_array(), rt.new_bool(true)])
			rt.call_function('wp_add_inline_script', [this.get_block_type_script(rt.new_string('handle')), rt.call_method(rt.call_function('wp_scripts', []rt.PhpVal{}), 'print_translations', [var_handle.dup(), rt.new_bool(false)]), rt.new_string('before')])
			rt.call_function('wp_deregister_script', [var_handle.dup()])
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock) get_chunks_paths(var_chunks_folder rt.PhpVal) rt.PhpVal {
	mut var_build_path := rt.new_string((fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Blocks_BlockTypes_Automattic_WooCommerce_Blocks_Package{}; return temp.get_path() }()).str() + 'assets/client/blocks/')
	mut var_blocks := rt.new_array()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_dir', [rt.concat(var_build_path, var_chunks_folder)]))))) {
		return rt.new_array()
	}
	{
		mut iter_1 := create_automattic_woocommerce_blocks_blocktypes_recursiveiteratoriterator(create_automattic_woocommerce_blocks_blocktypes_recursivedirectoryiterator(rt.concat(var_build_path, var_chunks_folder), Class_Automattic_WooCommerce_Blocks_BlockTypes_FilesystemIterator.unix_paths())).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_block_name := item_1.val
			var_blocks.array_push(rt.call_function('str_replace', [var_build_path.dup(), rt.new_string(''), var_block_name.dup()]))
		}
	}
	mut var_chunks := rt.call_function('preg_filter', [rt.new_string('/.js/'), rt.new_string(''), var_blocks.dup()])
	return var_chunks.dup()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock) register_block_type()  {
	mut var_block_settings := rt.create_array([rt.ArrayItem{ key: 'render_callback', val: this.get_block_type_render_callback() }, rt.ArrayItem{ key: 'editor_script', val: this.get_block_type_editor_script(rt.new_string('handle')) }])
	mut var_block_type_style := this.get_block_type_style()
	if rt.is_true(var_block_type_style) {
		var_block_settings.array_set('style', var_block_type_style.dup())
	}
	mut var_block_type_editor_style := rt.new_string(this.get_block_type_editor_style())
	if rt.is_true(var_block_type_editor_style) {
		var_block_settings.array_set('editor_style', var_block_type_editor_style.dup())
	}
	if !(rt.get_property(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock', []string{}, &this), 'api_version')).is_null() {
		var_block_settings.array_set('api_version', rt.get_property(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock', []string{}, &this), 'api_version').to_i64())
	}
	mut var_metadata_path := rt.call_method(this.asset_api, 'get_block_metadata_path', [this.block_name])
	if !(!rt.is_true(var_metadata_path)) {
		rt.call_function('register_block_type_from_metadata', [var_metadata_path.dup(), var_block_settings.dup()])
		return rt.new_null()
	}
	var_block_settings.array_set('attributes', this.get_block_type_attributes())
	var_block_settings.array_set('supports', this.get_block_type_supports())
	var_block_settings.array_set('uses_context', this.get_block_type_uses_context())
	rt.call_function('register_block_type', [this.get_block_type(), var_block_settings.dup()])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock) get_block_type() string {
	return (this.namespace).str() + '/' + (this.block_name).str()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock) get_block_type_render_callback() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'render_callback' }])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock) get_block_type_editor_script(var_key rt.PhpVal) rt.PhpVal {
	mut var_script := rt.create_array([rt.ArrayItem{ key: 'handle', val: 'wc-' + (this.block_name).str() + '-block' }, rt.ArrayItem{ key: 'path', val: rt.call_method(this.asset_api, 'get_block_asset_build_path', [this.block_name]) }, rt.ArrayItem{ key: 'dependencies', val: rt.create_array([rt.ArrayItem{ key: none, val: 'wc-blocks' }]) }])
	return if rt.is_true(var_key) { var_script.array_get(var_key) } else { var_script }
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock) get_block_type_editor_style() string {
	return 'wc-blocks-editor-style'
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock) get_block_type_script(var_key rt.PhpVal) rt.PhpVal {
	mut var_script := rt.create_array([rt.ArrayItem{ key: 'handle', val: 'wc-' + (this.block_name).str() + '-block-frontend' }, rt.ArrayItem{ key: 'path', val: rt.call_method(this.asset_api, 'get_block_asset_build_path', [(this.block_name).str() + '-frontend']) }, rt.ArrayItem{ key: 'dependencies', val: rt.new_array() }])
	return if rt.is_true(var_key) { var_script.array_get(var_key) } else { var_script }
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock) get_block_type_style() rt.PhpVal {
	rt.call_method(this.asset_api, 'register_style', ['wc-blocks-style-' + (this.block_name).str(), rt.call_method(this.asset_api, 'get_block_asset_build_path', [this.block_name, rt.new_string('css')]), rt.new_array(), rt.new_string('all'), rt.new_bool(true)])
	return rt.create_array([rt.ArrayItem{ key: none, val: 'wc-blocks-style' }, rt.ArrayItem{ key: none, val: 'wc-blocks-style-' + (this.block_name).str() }])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock) get_block_type_supports() rt.PhpVal {
	return rt.new_array()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock) get_block_type_attributes() rt.PhpVal {
	return rt.new_array()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock) get_block_type_uses_context() rt.PhpVal {
	return rt.new_array()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock) parse_render_callback_attributes(var_attributes rt.PhpVal) rt.PhpVal {
	return if rt.is_true(rt.call_function('is_a', [var_attributes.dup(), rt.new_string('WP_Block')])) { rt.get_property(var_attributes, 'attributes') } else { var_attributes }
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock) render(var_attributes rt.PhpVal, var_content rt.PhpVal, var_block rt.PhpVal) rt.PhpVal {
	return var_content.dup()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock) enqueue_assets(mut var_attributes Class_Automattic_WooCommerce_Blocks_BlockTypes_array, var_content rt.PhpVal, var_block rt.PhpVal)  {
	if rt.is_true(this.enqueued_assets) {
		return rt.new_null()
	}
	this.enqueue_data(mut var_attributes)
	this.enqueue_scripts(mut var_attributes)
	this.enqueued_assets = true
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock) enqueue_data(mut var_attributes Class_Automattic_WooCommerce_Blocks_BlockTypes_array)  {
	mut var_registered_script_data := rt.call_method(this.integration_registry, 'get_all_registered_script_data', []rt.PhpVal{})
	{
		mut iter_1 := var_registered_script_data.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_asset_data_value := item_1.val
			mut var_asset_data_key := item_1.key
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(this.asset_data_registry, 'exists', [var_asset_data_key.dup()]))))) {
				rt.call_method(this.asset_data_registry, 'add', [var_asset_data_key.dup(), var_asset_data_value.dup()])
			}
		}
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(this.asset_data_registry, 'exists', [rt.new_string('wcBlocksConfig')]))))) {
		mut var_wc_blocks_config := rt.create_array([rt.ArrayItem{ key: 'pluginUrl', val: rt.call_function('plugins_url', [rt.new_string('/'), rt.call_function('dirname', [rt.new_string(@DIR), rt.new_int(2)])]) }, rt.ArrayItem{ key: 'restApiRoutes', val: rt.create_array([rt.ArrayItem{ key: '/wc/store/v1', val: rt.func_array_keys(this.get_routes_from_namespace(rt.new_string('wc/store/v1'))) }]) }, rt.ArrayItem{ key: 'defaultAvatar', val: rt.call_function('get_avatar_url', [rt.new_int(0), rt.create_array([rt.ArrayItem{ key: 'force_default', val: true }])]) }, rt.ArrayItem{ key: 'wordCountType', val: rt.call_function('_x', [rt.new_string('words'), rt.new_string('Word count type. Do not translate!'), rt.new_string('woocommerce')]) }])
		if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('is_admin', []rt.PhpVal{})) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'is_rest_api_request', []rt.PhpVal{}))))))) {
			mut var_product_counts := rt.call_function('wp_count_posts', [rt.new_string('product')])
			mut var_published_products := if !(rt.get_property(var_product_counts, 'publish')).is_null() { rt.get_property(var_product_counts, 'publish') } else { rt.new_int(0) }
			var_wc_blocks_config = rt.call_function('array_merge', [var_wc_blocks_config.dup(), rt.create_array([rt.ArrayItem{ key: 'experimentalBlocksEnabled', val: fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_Features_Features{}; return temp.is_enabled(arg_0) }(rt.new_string('experimental-blocks')) }, rt.ArrayItem{ key: 'productCount', val: var_published_products }])])
		}
		rt.call_method(this.asset_data_registry, 'add', [rt.new_string('wcBlocksConfig'), var_wc_blocks_config.dup()])
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock) get_routes_from_namespace(var_namespace rt.PhpVal) rt.PhpVal {
	mut var_routes := rt.call_function('apply_filters', [rt.new_string('woocommerce_blocks_pre_get_routes_from_namespace'), rt.new_array(), var_namespace.dup(), rt.new_string('view')])
	if !(!rt.is_true(var_routes)) {
		return var_routes.dup()
	}
	mut var_rest_server := rt.call_function('rest_get_server', []rt.PhpVal{})
	mut var_namespace_index := rt.call_method(var_rest_server, 'get_namespace_index', [rt.create_array([rt.ArrayItem{ key: 'namespace', val: var_namespace }, rt.ArrayItem{ key: 'context', val: 'view' }])])
	if rt.is_true(rt.call_function('is_wp_error', [var_namespace_index.dup()])) {
		return rt.new_array()
	}
	mut var_response_data := rt.call_method(var_namespace_index, 'get_data', []rt.PhpVal{})
	return if !(var_response_data.array_get('routes')).is_null() { var_response_data.array_get('routes') } else { rt.new_array() }
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock) enqueue_scripts(mut var_attributes Class_Automattic_WooCommerce_Blocks_BlockTypes_array)  {
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		rt.call_function('wp_enqueue_script', [this.get_block_type_script(rt.new_string('handle'))])
	}
}

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_Automattic_WooCommerce_Blocks_Package {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_RecursiveIteratorIterator {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_RecursiveDirectoryIterator {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_Features_Features {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blocks_blocktypes_abstractblock(arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal, block_name string) &Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock{
		PhpObjectBase: rt.PhpObjectBase{}
		namespace: rt.new_string('woocommerce')
		block_name: rt.new_string('')
		enqueued_assets: false
		asset_api: rt.new_null()
		asset_data_registry: rt.new_null()
		integration_registry: rt.new_null()
	}
	obj.construct(arg_0, arg_1, arg_2, block_name)
	return obj
}

fn create_automattic_woocommerce_blocks_blocktypes_automattic_woocommerce_blocks_package() &Class_Automattic_WooCommerce_Blocks_BlockTypes_Automattic_WooCommerce_Blocks_Package {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_Automattic_WooCommerce_Blocks_Package{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_blocktypes_recursiveiteratoriterator() &Class_Automattic_WooCommerce_Blocks_BlockTypes_RecursiveIteratorIterator {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_RecursiveIteratorIterator{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_blocktypes_recursivedirectoryiterator() &Class_Automattic_WooCommerce_Blocks_BlockTypes_RecursiveDirectoryIterator {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_RecursiveDirectoryIterator{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_features_features() &Class_Automattic_WooCommerce_Admin_Features_Features {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_Features{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Blocks_Assets_Api](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Blocks_Assets_AssetDataRegistry](if args.len > 1 { args[1] } else { rt.new_null() })
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Blocks_Integrations_IntegrationRegistry](if args.len > 2 { args[2] } else { rt.new_null() })
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).str()
			this.construct(mut dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2, dispatch_arg_3)
			return rt.new_null()
		}
		'get_full_block_name' {
			return rt.new_string(this.get_full_block_name())
		}
		'render_callback' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.render_callback(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'enqueue_editor_assets' {
			this.enqueue_editor_assets()
			return rt.new_null()
		}
		'is_block_editor' {
			return rt.new_bool(this.is_block_editor())
		}
		'initialize' {
			return rt.new_bool(this.initialize())
		}
		'register_block_type_assets' {
			this.register_block_type_assets()
			return rt.new_null()
		}
		'register_chunk_translations' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.register_chunk_translations(dispatch_arg_0)
			return rt.new_null()
		}
		'get_chunks_paths' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_chunks_paths(dispatch_arg_0)
		}
		'register_block_type' {
			this.register_block_type()
			return rt.new_null()
		}
		'get_block_type' {
			return rt.new_string(this.get_block_type())
		}
		'get_block_type_render_callback' {
			return this.get_block_type_render_callback()
		}
		'get_block_type_editor_script' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_block_type_editor_script(dispatch_arg_0)
		}
		'get_block_type_editor_style' {
			return rt.new_string(this.get_block_type_editor_style())
		}
		'get_block_type_script' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_block_type_script(dispatch_arg_0)
		}
		'get_block_type_style' {
			return this.get_block_type_style()
		}
		'get_block_type_supports' {
			return this.get_block_type_supports()
		}
		'get_block_type_attributes' {
			return this.get_block_type_attributes()
		}
		'get_block_type_uses_context' {
			return this.get_block_type_uses_context()
		}
		'parse_render_callback_attributes' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.parse_render_callback_attributes(dispatch_arg_0)
		}
		'render' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.render(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'enqueue_assets' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Blocks_BlockTypes_array](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			this.enqueue_assets(mut dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'enqueue_data' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Blocks_BlockTypes_array](if args.len > 0 { args[0] } else { rt.new_null() })
			this.enqueue_data(mut dispatch_arg_0)
			return rt.new_null()
		}
		'get_routes_from_namespace' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_routes_from_namespace(dispatch_arg_0)
		}
		'enqueue_scripts' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Blocks_BlockTypes_array](if args.len > 0 { args[0] } else { rt.new_null() })
			this.enqueue_scripts(mut dispatch_arg_0)
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'namespace' { return this.namespace }
		'block_name' { return this.block_name }
		'enqueued_assets' { return rt.new_bool(this.enqueued_assets) }
		'asset_api' { return this.asset_api }
		'asset_data_registry' { return this.asset_data_registry }
		'integration_registry' { return this.integration_registry }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'namespace' { this.namespace = val; return true }
		'block_name' { this.block_name = val; return true }
		'enqueued_assets' { this.enqueued_assets = (val).to_bool(); return true }
		'asset_api' { this.asset_api = val; return true }
		'asset_data_registry' { this.asset_data_registry = val; return true }
		'integration_registry' { this.integration_registry = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_Automattic_WooCommerce_Blocks_Package) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTypes_Automattic_WooCommerce_Blocks_Package) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_Automattic_WooCommerce_Blocks_Package) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_RecursiveIteratorIterator) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTypes_RecursiveIteratorIterator) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_RecursiveIteratorIterator) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_RecursiveDirectoryIterator) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTypes_RecursiveDirectoryIterator) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_RecursiveDirectoryIterator) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Admin_Features_Features) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_Features) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Features) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_blocks_blocktypes_abstractblock_php() {
}
