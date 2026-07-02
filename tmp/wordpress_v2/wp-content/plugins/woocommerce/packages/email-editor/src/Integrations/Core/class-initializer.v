import rt

pub fn Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Initializer.allowed_block_types() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: none, val: 'core/button' }, rt.ArrayItem{ key: none, val: 'core/buttons' }, rt.ArrayItem{ key: none, val: 'core/column' }, rt.ArrayItem{ key: none, val: 'core/columns' }, rt.ArrayItem{ key: none, val: 'core/group' }, rt.ArrayItem{ key: none, val: 'core/heading' }, rt.ArrayItem{ key: none, val: 'core/image' }, rt.ArrayItem{ key: none, val: 'core/list' }, rt.ArrayItem{ key: none, val: 'core/list-item' }, rt.ArrayItem{ key: none, val: 'core/paragraph' }, rt.ArrayItem{ key: none, val: 'core/quote' }, rt.ArrayItem{ key: none, val: 'core/spacer' }, rt.ArrayItem{ key: none, val: 'core/social-link' }, rt.ArrayItem{ key: none, val: 'core/social-links' }, rt.ArrayItem{ key: none, val: 'core/site-logo' }, rt.ArrayItem{ key: none, val: 'core/site-title' }, rt.ArrayItem{ key: none, val: 'core/table' }])
}
pub fn Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Initializer.render_only_block_types() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: none, val: 'core/gallery' }, rt.ArrayItem{ key: none, val: 'core/media-text' }, rt.ArrayItem{ key: none, val: 'core/audio' }, rt.ArrayItem{ key: none, val: 'core/embed' }, rt.ArrayItem{ key: none, val: 'core/cover' }, rt.ArrayItem{ key: none, val: 'core/video' }, rt.ArrayItem{ key: none, val: 'core/post-title' }])
}
struct Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Initializer {
	rt.PhpObjectBase
pub mut:
		renderers rt.PhpVal = rt.new_array()
		initialized bool
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Initializer) initialize() {
	if this.initialized {
		return
	}
	this.initialized = true
	rt.call_function('add_filter', [rt.new_string('woocommerce_email_editor_theme_json'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_EmailEditor_Integrations_Core_Initializer', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'adjust_theme_json' }]), rt.new_int(10), rt.new_int(1)])
	rt.call_function('add_filter', [rt.new_string('safe_style_css'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_EmailEditor_Integrations_Core_Initializer', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'allow_styles' }])])
	rt.call_function('add_action', [rt.new_string('woocommerce_email_editor_render_start'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_EmailEditor_Integrations_Core_Initializer', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'reset_renderers' }])])
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Initializer) reset_renderers() {
	this.renderers = rt.new_array()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Initializer) adjust_theme_json(mut var_editor_theme_json Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_WP_Theme_JSON) rt.PhpVal {
	mut var_theme_json := rt.new_string((rt.call_function('file_get_contents', [rt.new_string(@DIR + '/theme.json')])).str())
	var_theme_json = rt.call_function('json_decode', [var_theme_json.clone(), rt.new_bool(true)])
	var_editor_theme_json.merge(create_automattic_woocommerce_emaileditor_integrations_core_wp_theme_json(var_theme_json.clone(), rt.new_string('default')))
	return rt.new_object('Automattic_WooCommerce_EmailEditor_Integrations_Core_WP_Theme_JSON', []string{}, var_editor_theme_json)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Initializer) allow_styles(mut var_allowed_styles Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_?array) rt.PhpVal {
	mut var_allowed_styles_mutated := var_allowed_styles
	if !(var_allowed_styles_mutated.is_array()) {
	var_allowed_styles_mutated = rt.new_array()
	}
	var_allowed_styles_mutated.array_push('display')
	var_allowed_styles_mutated.array_push('mso-padding-alt')
	var_allowed_styles_mutated.array_push('mso-font-width')
	var_allowed_styles_mutated.array_push('mso-text-raise')
	return rt.new_object('Automattic_WooCommerce_EmailEditor_Integrations_Core_?array', []string{}, var_allowed_styles_mutated)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Initializer) update_block_settings(mut var_settings Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_array) rt.PhpVal {
	mut var_settings_mutated := var_settings
	if rt.is_true(rt.call_function('in_array', [var_settings_mutated.array_get(rt.new_string('name')), Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Automattic_WooCommerce_EmailEditor_Integrations_Core_Initializer.allowed_block_types(), rt.new_bool(true)])) {
		var_settings_mutated.array_get_mut('supports').array_set('email', true)
		var_settings_mutated.array_set('render_email_callback', rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_EmailEditor_Integrations_Core_Initializer', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'render_block' }]))
	}
	if rt.is_true(rt.call_function('in_array', [var_settings_mutated.array_get(rt.new_string('name')), Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Automattic_WooCommerce_EmailEditor_Integrations_Core_Initializer.render_only_block_types(), rt.new_bool(true)])) {
		var_settings_mutated.array_set('render_email_callback', rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_EmailEditor_Integrations_Core_Initializer', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'render_block' }]))
	}
	return rt.new_object('Automattic_WooCommerce_EmailEditor_Integrations_Core_array', []string{}, var_settings_mutated)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Initializer) render_block(block_content string, mut var_parsed_block Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_array, mut var_rendering_context Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context) string {
	if var_parsed_block.array_isset(rt.new_string('blockName')) {
		mut var_block_renderer := this.get_block_renderer((var_parsed_block.array_get(rt.new_string('blockName'))).str())
		return (rt.call_method(var_block_renderer, 'render', [rt.new_string(block_content), var_parsed_block, var_rendering_context])).str()
	}
	return block_content
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Initializer) get_block_renderer(block_name string) rt.PhpVal {
	if this.renderers.array_isset(rt.new_string(block_name)) {
		return this.renderers.array_get(rt.new_string(block_name))
	}
	mut switch_val_1 := rt.new_string(block_name)
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('core/heading'))) || rt.is_true(rt.equal(switch_val_1, rt.new_string('core/paragraph'))) || rt.is_true(rt.equal(switch_val_1, rt.new_string('core/site-title'))) || rt.is_true(rt.equal(switch_val_1, rt.new_string('core/post-title'))) {
	mut var_renderer := create_automattic_woocommerce_emaileditor_integrations_core_renderer_blocks_text()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('core/column'))) {
	var_renderer = create_automattic_woocommerce_emaileditor_integrations_core_renderer_blocks_column()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('core/columns'))) {
	var_renderer = create_automattic_woocommerce_emaileditor_integrations_core_renderer_blocks_columns()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('core/list'))) {
	var_renderer = create_automattic_woocommerce_emaileditor_integrations_core_renderer_blocks_list_block()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('core/list-item'))) {
	var_renderer = create_automattic_woocommerce_emaileditor_integrations_core_renderer_blocks_list_item()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('core/image'))) {
	var_renderer = create_automattic_woocommerce_emaileditor_integrations_core_renderer_blocks_image()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('core/button'))) {
	var_renderer = create_automattic_woocommerce_emaileditor_integrations_core_renderer_blocks_button()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('core/buttons'))) {
	var_renderer = create_automattic_woocommerce_emaileditor_integrations_core_renderer_blocks_buttons(create_automattic_woocommerce_emaileditor_engine_renderer_contentrenderer_layout_flex_layout_renderer())
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('core/group'))) {
	var_renderer = create_automattic_woocommerce_emaileditor_integrations_core_renderer_blocks_group()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('core/quote'))) {
	var_renderer = create_automattic_woocommerce_emaileditor_integrations_core_renderer_blocks_quote()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('core/social-link'))) {
	var_renderer = create_automattic_woocommerce_emaileditor_integrations_core_renderer_blocks_social_link()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('core/social-links'))) {
	var_renderer = create_automattic_woocommerce_emaileditor_integrations_core_renderer_blocks_social_links()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('core/table'))) {
	var_renderer = create_automattic_woocommerce_emaileditor_integrations_core_renderer_blocks_table()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('core/gallery'))) {
	var_renderer = create_automattic_woocommerce_emaileditor_integrations_core_renderer_blocks_gallery()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('core/media-text'))) {
	var_renderer = create_automattic_woocommerce_emaileditor_integrations_core_renderer_blocks_media_text()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('core/audio'))) {
	var_renderer = create_automattic_woocommerce_emaileditor_integrations_core_renderer_blocks_audio()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('core/embed'))) {
	var_renderer = create_automattic_woocommerce_emaileditor_integrations_core_renderer_blocks_embed()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('core/cover'))) {
	var_renderer = create_automattic_woocommerce_emaileditor_integrations_core_renderer_blocks_cover()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('core/video'))) {
	var_renderer = create_automattic_woocommerce_emaileditor_integrations_core_renderer_blocks_video()
	} else {
	var_renderer = create_automattic_woocommerce_emaileditor_integrations_core_renderer_blocks_fallback()
	}
	this.renderers.array_set(block_name, var_renderer.clone())
	return var_renderer.clone()
}

struct Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_WP_Theme_JSON {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Text {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Column {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Columns {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_List_Block {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_List_Item {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Image {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Button {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Buttons {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Layout_Flex_Layout_Renderer {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Group {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Quote {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Social_Link {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Social_Links {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Table {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Gallery {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Media_Text {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Audio {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Embed {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Cover {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Video {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Fallback {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_emaileditor_integrations_core_initializer(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Initializer {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Initializer{
		PhpObjectBase: rt.PhpObjectBase{}
		renderers: rt.new_array()
		initialized: false
	}
	return obj
}

fn create_automattic_woocommerce_emaileditor_integrations_core_wp_theme_json(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_WP_Theme_JSON {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_WP_Theme_JSON{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditor_integrations_core_renderer_blocks_text(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Text {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Text{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditor_integrations_core_renderer_blocks_column(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Column {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Column{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditor_integrations_core_renderer_blocks_columns(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Columns {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Columns{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditor_integrations_core_renderer_blocks_list_block(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_List_Block {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_List_Block{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditor_integrations_core_renderer_blocks_list_item(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_List_Item {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_List_Item{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditor_integrations_core_renderer_blocks_image(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Image {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Image{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditor_integrations_core_renderer_blocks_button(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Button {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Button{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditor_integrations_core_renderer_blocks_buttons(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Buttons {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Buttons{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditor_engine_renderer_contentrenderer_layout_flex_layout_renderer(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Layout_Flex_Layout_Renderer {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Layout_Flex_Layout_Renderer{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditor_integrations_core_renderer_blocks_group(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Group {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Group{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditor_integrations_core_renderer_blocks_quote(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Quote {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Quote{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditor_integrations_core_renderer_blocks_social_link(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Social_Link {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Social_Link{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditor_integrations_core_renderer_blocks_social_links(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Social_Links {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Social_Links{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditor_integrations_core_renderer_blocks_table(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Table {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Table{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditor_integrations_core_renderer_blocks_gallery(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Gallery {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Gallery{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditor_integrations_core_renderer_blocks_media_text(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Media_Text {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Media_Text{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditor_integrations_core_renderer_blocks_audio(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Audio {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Audio{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditor_integrations_core_renderer_blocks_embed(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Embed {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Embed{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditor_integrations_core_renderer_blocks_cover(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Cover {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Cover{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditor_integrations_core_renderer_blocks_video(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Video {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Video{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditor_integrations_core_renderer_blocks_fallback(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Fallback {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Fallback{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Initializer) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'initialize' {
			this.initialize()
			return rt.new_null()
		}
		'reset_renderers' {
			this.reset_renderers()
			return rt.new_null()
		}
		'adjust_theme_json' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_WP_Theme_JSON](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.adjust_theme_json(mut dispatch_arg_0)
		}
		'allow_styles' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_?array](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.allow_styles(mut dispatch_arg_0)
		}
		'update_block_settings' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.update_block_settings(mut dispatch_arg_0)
		}
		'render_block' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_array](if args.len > 1 { args[1] } else { rt.new_null() })
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context](if args.len > 2 { args[2] } else { rt.new_null() })
			return rt.new_string(this.render_block(dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2))
		}
		'get_block_renderer' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_block_renderer(dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Initializer) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'renderers' { return this.renderers }
		'initialized' { return rt.new_bool(this.initialized) }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Initializer) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'renderers' { this.renderers = val; return true }
		'initialized' { this.initialized = (val).to_bool(); return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_WP_Theme_JSON) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_WP_Theme_JSON) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_WP_Theme_JSON) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Text) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Text) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Text) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Column) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Column) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Column) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Columns) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Columns) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Columns) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_List_Block) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_List_Block) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_List_Block) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_List_Item) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_List_Item) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_List_Item) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Image) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Image) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Image) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Button) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Button) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Button) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Buttons) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Buttons) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Buttons) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Layout_Flex_Layout_Renderer) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Layout_Flex_Layout_Renderer) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Layout_Flex_Layout_Renderer) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Group) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Group) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Group) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Quote) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Quote) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Quote) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Social_Link) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Social_Link) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Social_Link) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Social_Links) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Social_Links) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Social_Links) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Table) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Table) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Table) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Gallery) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Gallery) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Gallery) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Media_Text) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Media_Text) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Media_Text) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Audio) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Audio) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Audio) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Embed) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Embed) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Embed) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Cover) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Cover) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Cover) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Video) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Video) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Video) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Fallback) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Fallback) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Fallback) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}



fn main() {
	defer {
		rt.shutdown()
	}

}
