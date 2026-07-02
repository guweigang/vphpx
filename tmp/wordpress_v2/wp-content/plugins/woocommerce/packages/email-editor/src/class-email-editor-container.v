import rt

struct Class_Automattic_WooCommerce_EmailEditor_Email_Editor_Container {
	rt.PhpObjectBase
}

fn Class_Automattic_WooCommerce_EmailEditor_Email_Editor_Container.init() {
	rt.call_method(rt.call_method(Class_Automattic_WooCommerce_EmailEditor_Email_Editor_Container.container(),
		'get', [Class_Automattic_WooCommerce_EmailEditor_Bootstrap.class()]), 'init', []rt.PhpVal{})
}

fn Class_Automattic_WooCommerce_EmailEditor_Email_Editor_Container.container(reset bool) rt.PhpVal {
	mut var_container := rt.new_null()
	if var_reset {
		var_container = rt.new_null()
	}
	if rt.is_true(var_container) {
		return var_container.clone()
	}
	var_container = create_automattic_woocommerce_emaileditor_container()
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		return rt.new_object('Automattic_WooCommerce_EmailEditor_Integrations_Core_Initializer',
			[]string{}, create_automattic_woocommerce_emaileditor_integrations_core_initializer())
	}
	rt.call_method(var_container, 'set', [
		Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Initializer.class(),
		rt.new_closure(closure_1_fn),
	])
	closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		return rt.new_object('Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Initializer',
			[]string{},
			create_automattic_woocommerce_emaileditor_integrations_woocommerce_initializer())
	}
	rt.call_method(var_container, 'set', [
		Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Initializer.class(),
		rt.new_closure(closure_2_fn),
	])
	closure_3_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		return rt.new_object('Automattic_WooCommerce_EmailEditor_Engine_Theme_Controller',
			[]string{}, create_automattic_woocommerce_emaileditor_engine_theme_controller())
	}
	rt.call_method(var_container, 'set', [
		Class_Automattic_WooCommerce_EmailEditor_Engine_Theme_Controller.class(),
		rt.new_closure(closure_3_fn),
	])
	closure_4_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		return rt.new_object('Automattic_WooCommerce_EmailEditor_Engine_User_Theme', []string{},
			create_automattic_woocommerce_emaileditor_engine_user_theme())
	}
	rt.call_method(var_container, 'set', [
		Class_Automattic_WooCommerce_EmailEditor_Engine_User_Theme.class(),
		rt.new_closure(closure_4_fn),
	])
	closure_5_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_container := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.new_object('Automattic_WooCommerce_EmailEditor_Engine_Settings_Controller',
			[]string{}, create_automattic_woocommerce_emaileditor_engine_settings_controller(rt.call_method(var_container,
			'get', [
			Class_Automattic_WooCommerce_EmailEditor_Engine_Theme_Controller.class(),
		])))
	}
	rt.call_method(var_container, 'set', [
		Class_Automattic_WooCommerce_EmailEditor_Engine_Settings_Controller.class(),
		rt.new_closure(closure_5_fn),
	])
	closure_6_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		return rt.new_object('Automattic_WooCommerce_EmailEditor_Engine_Templates_Templates_Registry',
			[]string{},
			create_automattic_woocommerce_emaileditor_engine_templates_templates_registry())
	}
	rt.call_method(var_container, 'set', [
		Class_Automattic_WooCommerce_EmailEditor_Engine_Templates_Templates_Registry.class(),
		rt.new_closure(closure_6_fn),
	])
	closure_7_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_container := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.new_object('Automattic_WooCommerce_EmailEditor_Engine_Templates_Templates',
			[]string{}, create_automattic_woocommerce_emaileditor_engine_templates_templates(rt.call_method(var_container,
			'get', [
			Class_Automattic_WooCommerce_EmailEditor_Engine_Templates_Templates_Registry.class(),
		])))
	}
	rt.call_method(var_container, 'set', [
		Class_Automattic_WooCommerce_EmailEditor_Engine_Templates_Templates.class(),
		rt.new_closure(closure_7_fn),
	])
	closure_8_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		return rt.new_object('Automattic_WooCommerce_EmailEditor_Engine_Patterns_Patterns',
			[]string{}, create_automattic_woocommerce_emaileditor_engine_patterns_patterns())
	}
	rt.call_method(var_container, 'set', [
		Class_Automattic_WooCommerce_EmailEditor_Engine_Patterns_Patterns.class(),
		rt.new_closure(closure_8_fn),
	])
	closure_9_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		return rt.new_object('Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_Cleanup_Preprocessor',
			[]string{},
			create_automattic_woocommerce_emaileditor_engine_renderer_contentrenderer_preprocessors_cleanup_preprocessor())
	}
	rt.call_method(var_container, 'set', [
		Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_Cleanup_Preprocessor.class(),
		rt.new_closure(closure_9_fn),
	])
	closure_10_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		return rt.new_object('Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_Blocks_Width_Preprocessor',
			[]string{},
			create_automattic_woocommerce_emaileditor_engine_renderer_contentrenderer_preprocessors_blocks_width_preprocessor())
	}
	rt.call_method(var_container, 'set', [
		Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_Blocks_Width_Preprocessor.class(),
		rt.new_closure(closure_10_fn),
	])
	closure_11_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_container := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.new_object('Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_Typography_Preprocessor',
			[]string{}, create_automattic_woocommerce_emaileditor_engine_renderer_contentrenderer_preprocessors_typography_preprocessor(rt.call_method(var_container,
			'get', [
			Class_Automattic_WooCommerce_EmailEditor_Engine_Settings_Controller.class(),
		])))
	}
	rt.call_method(var_container, 'set', [
		Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_Typography_Preprocessor.class(),
		rt.new_closure(closure_11_fn),
	])
	closure_12_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		return rt.new_object('Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_Spacing_Preprocessor',
			[]string{},
			create_automattic_woocommerce_emaileditor_engine_renderer_contentrenderer_preprocessors_spacing_preprocessor())
	}
	rt.call_method(var_container, 'set', [
		Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_Spacing_Preprocessor.class(),
		rt.new_closure(closure_12_fn),
	])
	closure_13_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		return rt.new_object('Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_Quote_Preprocessor',
			[]string{},
			create_automattic_woocommerce_emaileditor_engine_renderer_contentrenderer_preprocessors_quote_preprocessor())
	}
	rt.call_method(var_container, 'set', [
		Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_Quote_Preprocessor.class(),
		rt.new_closure(closure_13_fn),
	])
	closure_14_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		return rt.new_object('Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Postprocessors_Highlighting_Postprocessor',
			[]string{},
			create_automattic_woocommerce_emaileditor_engine_renderer_contentrenderer_postprocessors_highlighting_postprocessor())
	}
	rt.call_method(var_container, 'set', [
		Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Postprocessors_Highlighting_Postprocessor.class(),
		rt.new_closure(closure_14_fn),
	])
	closure_15_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_container := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.new_object('Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Postprocessors_Variables_Postprocessor',
			[]string{}, create_automattic_woocommerce_emaileditor_engine_renderer_contentrenderer_postprocessors_variables_postprocessor(rt.call_method(var_container,
			'get', [
			Class_Automattic_WooCommerce_EmailEditor_Engine_Theme_Controller.class(),
		])))
	}
	rt.call_method(var_container, 'set', [
		Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Postprocessors_Variables_Postprocessor.class(),
		rt.new_closure(closure_15_fn),
	])
	closure_16_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		return rt.new_object('Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Postprocessors_Border_Style_Postprocessor',
			[]string{},
			create_automattic_woocommerce_emaileditor_engine_renderer_contentrenderer_postprocessors_border_style_postprocessor())
	}
	rt.call_method(var_container, 'set', [
		Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Postprocessors_Border_Style_Postprocessor.class(),
		rt.new_closure(closure_16_fn),
	])
	closure_17_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_container := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.new_object('Automattic_WooCommerce_EmailEditor_Engine_Assets_Manager',
			[]string{}, create_automattic_woocommerce_emaileditor_engine_assets_manager(rt.call_method(var_container,
			'get', [
			Class_Automattic_WooCommerce_EmailEditor_Engine_Settings_Controller.class(),
		]), rt.call_method(var_container, 'get', [
			Class_Automattic_WooCommerce_EmailEditor_Engine_Theme_Controller.class(),
		]), rt.call_method(var_container, 'get', [
			Class_Automattic_WooCommerce_EmailEditor_Engine_User_Theme.class(),
		]), rt.call_method(var_container, 'get', [
			Class_Automattic_WooCommerce_EmailEditor_Engine_Logger_Email_Editor_Logger.class(),
		])))
	}
	rt.call_method(var_container, 'set', [
		Class_Automattic_WooCommerce_EmailEditor_Engine_Assets_Manager.class(),
		rt.new_closure(closure_17_fn),
	])
	closure_18_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_container := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.new_object('Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Process_Manager',
			[]string{}, create_automattic_woocommerce_emaileditor_engine_renderer_contentrenderer_process_manager(rt.call_method(var_container,
			'get', [
			Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_Cleanup_Preprocessor.class(),
		]), rt.call_method(var_container, 'get', [
			Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_Blocks_Width_Preprocessor.class(),
		]), rt.call_method(var_container, 'get', [
			Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_Typography_Preprocessor.class(),
		]), rt.call_method(var_container, 'get', [
			Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_Spacing_Preprocessor.class(),
		]), rt.call_method(var_container, 'get', [
			Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_Quote_Preprocessor.class(),
		]), rt.call_method(var_container, 'get', [
			Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Postprocessors_Highlighting_Postprocessor.class(),
		]), rt.call_method(var_container, 'get', [
			Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Postprocessors_Variables_Postprocessor.class(),
		]), rt.call_method(var_container, 'get', [
			Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Postprocessors_Border_Style_Postprocessor.class(),
		])))
	}
	rt.call_method(var_container, 'set', [
		Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Process_Manager.class(),
		rt.new_closure(closure_18_fn),
	])
	closure_19_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_container := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.new_object('Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Content_Renderer',
			[]string{}, create_automattic_woocommerce_emaileditor_engine_renderer_contentrenderer_content_renderer(rt.call_method(var_container,
			'get', [
			Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Process_Manager.class(),
		]), create_automattic_woocommerce_emaileditor_email_css_inliner(), rt.call_method(var_container,
			'get', [
			Class_Automattic_WooCommerce_EmailEditor_Engine_Theme_Controller.class(),
		]), rt.call_method(var_container, 'get', [
			Class_Automattic_WooCommerce_EmailEditor_Engine_Logger_Email_Editor_Logger.class(),
		])))
	}
	rt.call_method(var_container, 'set', [
		Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Content_Renderer.class(),
		rt.new_closure(closure_19_fn),
	])
	closure_20_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_container := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.new_object('Automattic_WooCommerce_EmailEditor_Engine_Renderer_Renderer',
			[]string{}, create_automattic_woocommerce_emaileditor_engine_renderer_renderer(rt.call_method(var_container,
			'get', [
			Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Content_Renderer.class(),
		]), rt.call_method(var_container, 'get', [
			Class_Automattic_WooCommerce_EmailEditor_Engine_Templates_Templates.class(),
		]), create_automattic_woocommerce_emaileditor_email_css_inliner(), rt.call_method(var_container,
			'get', [
			Class_Automattic_WooCommerce_EmailEditor_Engine_Theme_Controller.class(),
		]), rt.call_method(var_container, 'get', [
			Class_Automattic_WooCommerce_EmailEditor_Engine_PersonalizationTags_Personalization_Tags_Registry.class(),
		]), rt.call_method(var_container, 'get', [
			Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Process_Manager.class(),
		])))
	}
	rt.call_method(var_container, 'set', [
		Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_Renderer.class(),
		rt.new_closure(closure_20_fn),
	])
	closure_21_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_container := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.new_object('Automattic_WooCommerce_EmailEditor_Engine_PersonalizationTags_Personalization_Tags_Registry',
			[]string{}, create_automattic_woocommerce_emaileditor_engine_personalizationtags_personalization_tags_registry(rt.call_method(var_container,
			'get', [
			Class_Automattic_WooCommerce_EmailEditor_Engine_Logger_Email_Editor_Logger.class(),
		])))
	}
	rt.call_method(var_container, 'set', [
		Class_Automattic_WooCommerce_EmailEditor_Engine_PersonalizationTags_Personalization_Tags_Registry.class(),
		rt.new_closure(closure_21_fn),
	])
	closure_22_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_container := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.new_object('Automattic_WooCommerce_EmailEditor_Engine_Personalizer', []string{}, create_automattic_woocommerce_emaileditor_engine_personalizer(rt.call_method(var_container,
			'get', [
			Class_Automattic_WooCommerce_EmailEditor_Engine_PersonalizationTags_Personalization_Tags_Registry.class(),
		])))
	}
	rt.call_method(var_container, 'set', [
		Class_Automattic_WooCommerce_EmailEditor_Engine_Personalizer.class(),
		rt.new_closure(closure_22_fn),
	])
	closure_23_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_container := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.new_object('Automattic_WooCommerce_EmailEditor_Engine_Send_Preview_Email',
			[]string{}, create_automattic_woocommerce_emaileditor_engine_send_preview_email(rt.call_method(var_container,
			'get', [
			Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_Renderer.class(),
		]), rt.call_method(var_container, 'get', [
			Class_Automattic_WooCommerce_EmailEditor_Engine_Personalizer.class(),
		])))
	}
	rt.call_method(var_container, 'set', [
		Class_Automattic_WooCommerce_EmailEditor_Engine_Send_Preview_Email.class(),
		rt.new_closure(closure_23_fn),
	])
	closure_24_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_container := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.new_object('Automattic_WooCommerce_EmailEditor_Engine_Email_Api_Controller',
			[]string{}, create_automattic_woocommerce_emaileditor_engine_email_api_controller(rt.call_method(var_container,
			'get', [
			Class_Automattic_WooCommerce_EmailEditor_Engine_PersonalizationTags_Personalization_Tags_Registry.class(),
		])))
	}
	rt.call_method(var_container, 'set', [
		Class_Automattic_WooCommerce_EmailEditor_Engine_Email_Api_Controller.class(),
		rt.new_closure(closure_24_fn),
	])
	closure_25_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		return rt.new_object('Automattic_WooCommerce_EmailEditor_Engine_Dependency_Check',
			[]string{}, create_automattic_woocommerce_emaileditor_engine_dependency_check())
	}
	rt.call_method(var_container, 'set', [
		Class_Automattic_WooCommerce_EmailEditor_Engine_Dependency_Check.class(),
		rt.new_closure(closure_25_fn),
	])
	closure_26_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		return rt.new_object('Automattic_WooCommerce_EmailEditor_Engine_Logger_Email_Editor_Logger',
			[]string{},
			create_automattic_woocommerce_emaileditor_engine_logger_email_editor_logger())
	}
	rt.call_method(var_container, 'set', [
		Class_Automattic_WooCommerce_EmailEditor_Engine_Logger_Email_Editor_Logger.class(),
		rt.new_closure(closure_26_fn),
	])
	closure_27_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		return rt.new_object('Automattic_WooCommerce_EmailEditor_Engine_Site_Style_Sync_Controller',
			[]string{},
			create_automattic_woocommerce_emaileditor_engine_site_style_sync_controller())
	}
	rt.call_method(var_container, 'set', [
		Class_Automattic_WooCommerce_EmailEditor_Engine_Site_Style_Sync_Controller.class(),
		rt.new_closure(closure_27_fn),
	])
	closure_28_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_container := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.new_object('Automattic_WooCommerce_EmailEditor_Engine_Email_Editor', []string{}, create_automattic_woocommerce_emaileditor_engine_email_editor(rt.call_method(var_container,
			'get', [
			Class_Automattic_WooCommerce_EmailEditor_Engine_Email_Api_Controller.class(),
		]), rt.call_method(var_container, 'get', [
			Class_Automattic_WooCommerce_EmailEditor_Engine_Templates_Templates.class(),
		]), rt.call_method(var_container, 'get', [
			Class_Automattic_WooCommerce_EmailEditor_Engine_Patterns_Patterns.class(),
		]), rt.call_method(var_container, 'get', [
			Class_Automattic_WooCommerce_EmailEditor_Engine_Send_Preview_Email.class(),
		]), rt.call_method(var_container, 'get', [
			Class_Automattic_WooCommerce_EmailEditor_Engine_PersonalizationTags_Personalization_Tags_Registry.class(),
		]), rt.call_method(var_container, 'get', [
			Class_Automattic_WooCommerce_EmailEditor_Engine_Logger_Email_Editor_Logger.class(),
		]), rt.call_method(var_container, 'get', [
			Class_Automattic_WooCommerce_EmailEditor_Engine_Assets_Manager.class(),
		])))
	}
	rt.call_method(var_container, 'set', [
		Class_Automattic_WooCommerce_EmailEditor_Engine_Email_Editor.class(),
		rt.new_closure(closure_28_fn),
	])
	closure_29_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_container := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.new_object('Automattic_WooCommerce_EmailEditor_Bootstrap', []string{}, create_automattic_woocommerce_emaileditor_bootstrap(rt.call_method(var_container,
			'get', [
			Class_Automattic_WooCommerce_EmailEditor_Engine_Email_Editor.class(),
		]), rt.call_method(var_container, 'get', [
			Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Initializer.class(),
		]), rt.call_method(var_container, 'get', [
			Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Initializer.class(),
		])))
	}
	rt.call_method(var_container, 'set', [
		Class_Automattic_WooCommerce_EmailEditor_Bootstrap.class(),
		rt.new_closure(closure_29_fn),
	])
	return var_container.clone()
}

struct Class_Automattic_WooCommerce_EmailEditor_Container {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Initializer {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Initializer {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditor_Engine_Theme_Controller {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditor_Engine_User_Theme {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditor_Engine_Settings_Controller {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditor_Engine_Templates_Templates_Registry {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditor_Engine_Templates_Templates {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditor_Engine_Patterns_Patterns {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_Cleanup_Preprocessor {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_Blocks_Width_Preprocessor {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_Typography_Preprocessor {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_Spacing_Preprocessor {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_Quote_Preprocessor {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Postprocessors_Highlighting_Postprocessor {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Postprocessors_Variables_Postprocessor {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Postprocessors_Border_Style_Postprocessor {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditor_Engine_Assets_Manager {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Process_Manager {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Content_Renderer {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditor_Email_Css_Inliner {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_Renderer {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditor_Engine_PersonalizationTags_Personalization_Tags_Registry {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditor_Engine_Personalizer {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditor_Engine_Send_Preview_Email {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditor_Engine_Email_Api_Controller {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditor_Engine_Dependency_Check {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditor_Engine_Logger_Email_Editor_Logger {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditor_Engine_Site_Style_Sync_Controller {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditor_Engine_Email_Editor {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditor_Bootstrap {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_emaileditor_email_editor_container(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditor_Email_Editor_Container {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Email_Editor_Container{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditor_container(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditor_Container {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Container{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditor_integrations_core_initializer(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Initializer {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Initializer{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditor_integrations_woocommerce_initializer(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Initializer {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Initializer{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditor_engine_theme_controller(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditor_Engine_Theme_Controller {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Engine_Theme_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditor_engine_user_theme(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditor_Engine_User_Theme {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Engine_User_Theme{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditor_engine_settings_controller(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditor_Engine_Settings_Controller {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Engine_Settings_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditor_engine_templates_templates_registry(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditor_Engine_Templates_Templates_Registry {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Engine_Templates_Templates_Registry{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditor_engine_templates_templates(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditor_Engine_Templates_Templates {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Engine_Templates_Templates{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditor_engine_patterns_patterns(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditor_Engine_Patterns_Patterns {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Engine_Patterns_Patterns{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditor_engine_renderer_contentrenderer_preprocessors_cleanup_preprocessor(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_Cleanup_Preprocessor {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_Cleanup_Preprocessor{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditor_engine_renderer_contentrenderer_preprocessors_blocks_width_preprocessor(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_Blocks_Width_Preprocessor {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_Blocks_Width_Preprocessor{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditor_engine_renderer_contentrenderer_preprocessors_typography_preprocessor(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_Typography_Preprocessor {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_Typography_Preprocessor{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditor_engine_renderer_contentrenderer_preprocessors_spacing_preprocessor(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_Spacing_Preprocessor {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_Spacing_Preprocessor{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditor_engine_renderer_contentrenderer_preprocessors_quote_preprocessor(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_Quote_Preprocessor {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_Quote_Preprocessor{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditor_engine_renderer_contentrenderer_postprocessors_highlighting_postprocessor(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Postprocessors_Highlighting_Postprocessor {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Postprocessors_Highlighting_Postprocessor{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditor_engine_renderer_contentrenderer_postprocessors_variables_postprocessor(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Postprocessors_Variables_Postprocessor {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Postprocessors_Variables_Postprocessor{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditor_engine_renderer_contentrenderer_postprocessors_border_style_postprocessor(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Postprocessors_Border_Style_Postprocessor {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Postprocessors_Border_Style_Postprocessor{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditor_engine_assets_manager(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditor_Engine_Assets_Manager {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Engine_Assets_Manager{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditor_engine_renderer_contentrenderer_process_manager(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Process_Manager {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Process_Manager{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditor_engine_renderer_contentrenderer_content_renderer(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Content_Renderer {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Content_Renderer{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditor_email_css_inliner(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditor_Email_Css_Inliner {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Email_Css_Inliner{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditor_engine_renderer_renderer(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_Renderer {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_Renderer{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditor_engine_personalizationtags_personalization_tags_registry(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditor_Engine_PersonalizationTags_Personalization_Tags_Registry {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Engine_PersonalizationTags_Personalization_Tags_Registry{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditor_engine_personalizer(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditor_Engine_Personalizer {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Engine_Personalizer{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditor_engine_send_preview_email(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditor_Engine_Send_Preview_Email {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Engine_Send_Preview_Email{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditor_engine_email_api_controller(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditor_Engine_Email_Api_Controller {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Engine_Email_Api_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditor_engine_dependency_check(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditor_Engine_Dependency_Check {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Engine_Dependency_Check{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditor_engine_logger_email_editor_logger(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditor_Engine_Logger_Email_Editor_Logger {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Engine_Logger_Email_Editor_Logger{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditor_engine_site_style_sync_controller(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditor_Engine_Site_Style_Sync_Controller {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Engine_Site_Style_Sync_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditor_engine_email_editor(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditor_Engine_Email_Editor {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Engine_Email_Editor{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditor_bootstrap(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditor_Bootstrap {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Bootstrap{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Email_Editor_Container) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'init' {
			Class_Automattic_WooCommerce_EmailEditor_Email_Editor_Container.init()
			return rt.new_null()
		}
		'container' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			return Class_Automattic_WooCommerce_EmailEditor_Email_Editor_Container.container(dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Email_Editor_Container) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Email_Editor_Container) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Container) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Container) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Container) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Initializer) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Initializer) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Initializer) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Initializer) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Initializer) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Initializer) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Theme_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Engine_Theme_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Theme_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_User_Theme) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Engine_User_Theme) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_User_Theme) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Settings_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Engine_Settings_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Settings_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Templates_Templates_Registry) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Engine_Templates_Templates_Registry) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Templates_Templates_Registry) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Templates_Templates) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Engine_Templates_Templates) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Templates_Templates) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Patterns_Patterns) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Engine_Patterns_Patterns) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Patterns_Patterns) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_Cleanup_Preprocessor) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_Cleanup_Preprocessor) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_Cleanup_Preprocessor) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_Blocks_Width_Preprocessor) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_Blocks_Width_Preprocessor) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_Blocks_Width_Preprocessor) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_Typography_Preprocessor) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_Typography_Preprocessor) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_Typography_Preprocessor) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_Spacing_Preprocessor) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_Spacing_Preprocessor) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_Spacing_Preprocessor) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_Quote_Preprocessor) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_Quote_Preprocessor) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preprocessors_Quote_Preprocessor) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Postprocessors_Highlighting_Postprocessor) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Postprocessors_Highlighting_Postprocessor) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Postprocessors_Highlighting_Postprocessor) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Postprocessors_Variables_Postprocessor) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Postprocessors_Variables_Postprocessor) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Postprocessors_Variables_Postprocessor) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Postprocessors_Border_Style_Postprocessor) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Postprocessors_Border_Style_Postprocessor) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Postprocessors_Border_Style_Postprocessor) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Assets_Manager) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Engine_Assets_Manager) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Assets_Manager) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Process_Manager) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Process_Manager) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Process_Manager) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Content_Renderer) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Content_Renderer) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Content_Renderer) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Email_Css_Inliner) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Email_Css_Inliner) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Email_Css_Inliner) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_Renderer) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_Renderer) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_Renderer) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_PersonalizationTags_Personalization_Tags_Registry) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Engine_PersonalizationTags_Personalization_Tags_Registry) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_PersonalizationTags_Personalization_Tags_Registry) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Personalizer) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Engine_Personalizer) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Personalizer) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Send_Preview_Email) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Engine_Send_Preview_Email) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Send_Preview_Email) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Email_Api_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Engine_Email_Api_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Email_Api_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Dependency_Check) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Engine_Dependency_Check) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Dependency_Check) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Logger_Email_Editor_Logger) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Engine_Logger_Email_Editor_Logger) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Logger_Email_Editor_Logger) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Site_Style_Sync_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Engine_Site_Style_Sync_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Site_Style_Sync_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Email_Editor) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Engine_Email_Editor) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Email_Editor) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Bootstrap) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Bootstrap) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Bootstrap) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}
