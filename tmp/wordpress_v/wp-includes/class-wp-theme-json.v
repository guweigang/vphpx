import rt

pub fn Class_WP_Theme_JSON.root_css_properties_selector() string {
	return ':root'
}
pub fn Class_WP_Theme_JSON.root_block_selector() string {
	return 'body'
}
pub fn Class_WP_Theme_JSON.valid_origins() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: none, val: 'default' }, rt.ArrayItem{ key: none, val: 'blocks' }, rt.ArrayItem{ key: none, val: 'theme' }, rt.ArrayItem{ key: none, val: 'custom' }])
}
pub fn Class_WP_Theme_JSON.presets_metadata() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'path', val: rt.create_array([rt.ArrayItem{ key: none, val: 'dimensions' }, rt.ArrayItem{ key: none, val: 'aspectRatios' }]) }, rt.ArrayItem{ key: 'prevent_override', val: rt.create_array([rt.ArrayItem{ key: none, val: 'dimensions' }, rt.ArrayItem{ key: none, val: 'defaultAspectRatios' }]) }, rt.ArrayItem{ key: 'use_default_names', val: false }, rt.ArrayItem{ key: 'value_key', val: 'ratio' }, rt.ArrayItem{ key: 'css_vars', val: '--wp--preset--aspect-ratio--$slug' }, rt.ArrayItem{ key: 'classes', val: rt.new_array() }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: none, val: 'aspect-ratio' }]) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'path', val: rt.create_array([rt.ArrayItem{ key: none, val: 'color' }, rt.ArrayItem{ key: none, val: 'palette' }]) }, rt.ArrayItem{ key: 'prevent_override', val: rt.create_array([rt.ArrayItem{ key: none, val: 'color' }, rt.ArrayItem{ key: none, val: 'defaultPalette' }]) }, rt.ArrayItem{ key: 'use_default_names', val: false }, rt.ArrayItem{ key: 'value_key', val: 'color' }, rt.ArrayItem{ key: 'css_vars', val: '--wp--preset--color--$slug' }, rt.ArrayItem{ key: 'classes', val: rt.create_array([rt.ArrayItem{ key: '.has-$slug-color', val: 'color' }, rt.ArrayItem{ key: '.has-$slug-background-color', val: 'background-color' }, rt.ArrayItem{ key: '.has-$slug-border-color', val: 'border-color' }]) }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: none, val: 'color' }, rt.ArrayItem{ key: none, val: 'background-color' }, rt.ArrayItem{ key: none, val: 'border-color' }]) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'path', val: rt.create_array([rt.ArrayItem{ key: none, val: 'color' }, rt.ArrayItem{ key: none, val: 'gradients' }]) }, rt.ArrayItem{ key: 'prevent_override', val: rt.create_array([rt.ArrayItem{ key: none, val: 'color' }, rt.ArrayItem{ key: none, val: 'defaultGradients' }]) }, rt.ArrayItem{ key: 'use_default_names', val: false }, rt.ArrayItem{ key: 'value_key', val: 'gradient' }, rt.ArrayItem{ key: 'css_vars', val: '--wp--preset--gradient--$slug' }, rt.ArrayItem{ key: 'classes', val: rt.create_array([rt.ArrayItem{ key: '.has-$slug-gradient-background', val: 'background' }]) }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: none, val: 'background' }]) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'path', val: rt.create_array([rt.ArrayItem{ key: none, val: 'color' }, rt.ArrayItem{ key: none, val: 'duotone' }]) }, rt.ArrayItem{ key: 'prevent_override', val: rt.create_array([rt.ArrayItem{ key: none, val: 'color' }, rt.ArrayItem{ key: none, val: 'defaultDuotone' }]) }, rt.ArrayItem{ key: 'use_default_names', val: false }, rt.ArrayItem{ key: 'value_func', val: rt.new_null() }, rt.ArrayItem{ key: 'css_vars', val: rt.new_null() }, rt.ArrayItem{ key: 'classes', val: rt.new_array() }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: none, val: 'filter' }]) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'path', val: rt.create_array([rt.ArrayItem{ key: none, val: 'typography' }, rt.ArrayItem{ key: none, val: 'fontSizes' }]) }, rt.ArrayItem{ key: 'prevent_override', val: rt.create_array([rt.ArrayItem{ key: none, val: 'typography' }, rt.ArrayItem{ key: none, val: 'defaultFontSizes' }]) }, rt.ArrayItem{ key: 'use_default_names', val: true }, rt.ArrayItem{ key: 'value_func', val: 'wp_get_typography_font_size_value' }, rt.ArrayItem{ key: 'css_vars', val: '--wp--preset--font-size--$slug' }, rt.ArrayItem{ key: 'classes', val: rt.create_array([rt.ArrayItem{ key: '.has-$slug-font-size', val: 'font-size' }]) }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: none, val: 'font-size' }]) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'path', val: rt.create_array([rt.ArrayItem{ key: none, val: 'typography' }, rt.ArrayItem{ key: none, val: 'fontFamilies' }]) }, rt.ArrayItem{ key: 'prevent_override', val: false }, rt.ArrayItem{ key: 'use_default_names', val: false }, rt.ArrayItem{ key: 'value_key', val: 'fontFamily' }, rt.ArrayItem{ key: 'css_vars', val: '--wp--preset--font-family--$slug' }, rt.ArrayItem{ key: 'classes', val: rt.create_array([rt.ArrayItem{ key: '.has-$slug-font-family', val: 'font-family' }]) }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: none, val: 'font-family' }]) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'path', val: rt.create_array([rt.ArrayItem{ key: none, val: 'spacing' }, rt.ArrayItem{ key: none, val: 'spacingSizes' }]) }, rt.ArrayItem{ key: 'prevent_override', val: rt.create_array([rt.ArrayItem{ key: none, val: 'spacing' }, rt.ArrayItem{ key: none, val: 'defaultSpacingSizes' }]) }, rt.ArrayItem{ key: 'use_default_names', val: true }, rt.ArrayItem{ key: 'value_key', val: 'size' }, rt.ArrayItem{ key: 'css_vars', val: '--wp--preset--spacing--$slug' }, rt.ArrayItem{ key: 'classes', val: rt.new_array() }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: none, val: 'padding' }, rt.ArrayItem{ key: none, val: 'margin' }]) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'path', val: rt.create_array([rt.ArrayItem{ key: none, val: 'shadow' }, rt.ArrayItem{ key: none, val: 'presets' }]) }, rt.ArrayItem{ key: 'prevent_override', val: rt.create_array([rt.ArrayItem{ key: none, val: 'shadow' }, rt.ArrayItem{ key: none, val: 'defaultPresets' }]) }, rt.ArrayItem{ key: 'use_default_names', val: false }, rt.ArrayItem{ key: 'value_key', val: 'shadow' }, rt.ArrayItem{ key: 'css_vars', val: '--wp--preset--shadow--$slug' }, rt.ArrayItem{ key: 'classes', val: rt.new_array() }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: none, val: 'box-shadow' }]) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'path', val: rt.create_array([rt.ArrayItem{ key: none, val: 'border' }, rt.ArrayItem{ key: none, val: 'radiusSizes' }]) }, rt.ArrayItem{ key: 'prevent_override', val: false }, rt.ArrayItem{ key: 'use_default_names', val: false }, rt.ArrayItem{ key: 'value_key', val: 'size' }, rt.ArrayItem{ key: 'css_vars', val: '--wp--preset--border-radius--$slug' }, rt.ArrayItem{ key: 'classes', val: rt.new_array() }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: none, val: 'border-radius' }]) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'path', val: rt.create_array([rt.ArrayItem{ key: none, val: 'dimensions' }, rt.ArrayItem{ key: none, val: 'dimensionSizes' }]) }, rt.ArrayItem{ key: 'prevent_override', val: false }, rt.ArrayItem{ key: 'use_default_names', val: false }, rt.ArrayItem{ key: 'value_key', val: 'size' }, rt.ArrayItem{ key: 'css_vars', val: '--wp--preset--dimension--$slug' }, rt.ArrayItem{ key: 'classes', val: rt.new_array() }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: none, val: 'width' }, rt.ArrayItem{ key: none, val: 'height' }, rt.ArrayItem{ key: none, val: 'min-height' }]) }]) }])
}
pub fn Class_WP_Theme_JSON.properties_metadata() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'aspect-ratio', val: rt.create_array([rt.ArrayItem{ key: none, val: 'dimensions' }, rt.ArrayItem{ key: none, val: 'aspectRatio' }]) }, rt.ArrayItem{ key: 'background', val: rt.create_array([rt.ArrayItem{ key: none, val: 'color' }, rt.ArrayItem{ key: none, val: 'gradient' }]) }, rt.ArrayItem{ key: 'background-color', val: rt.create_array([rt.ArrayItem{ key: none, val: 'color' }, rt.ArrayItem{ key: none, val: 'background' }]) }, rt.ArrayItem{ key: 'background-image', val: rt.create_array([rt.ArrayItem{ key: none, val: 'background' }, rt.ArrayItem{ key: none, val: 'backgroundImage' }]) }, rt.ArrayItem{ key: 'background-position', val: rt.create_array([rt.ArrayItem{ key: none, val: 'background' }, rt.ArrayItem{ key: none, val: 'backgroundPosition' }]) }, rt.ArrayItem{ key: 'background-repeat', val: rt.create_array([rt.ArrayItem{ key: none, val: 'background' }, rt.ArrayItem{ key: none, val: 'backgroundRepeat' }]) }, rt.ArrayItem{ key: 'background-size', val: rt.create_array([rt.ArrayItem{ key: none, val: 'background' }, rt.ArrayItem{ key: none, val: 'backgroundSize' }]) }, rt.ArrayItem{ key: 'background-attachment', val: rt.create_array([rt.ArrayItem{ key: none, val: 'background' }, rt.ArrayItem{ key: none, val: 'backgroundAttachment' }]) }, rt.ArrayItem{ key: 'border-radius', val: rt.create_array([rt.ArrayItem{ key: none, val: 'border' }, rt.ArrayItem{ key: none, val: 'radius' }]) }, rt.ArrayItem{ key: 'border-top-left-radius', val: rt.create_array([rt.ArrayItem{ key: none, val: 'border' }, rt.ArrayItem{ key: none, val: 'radius' }, rt.ArrayItem{ key: none, val: 'topLeft' }]) }, rt.ArrayItem{ key: 'border-top-right-radius', val: rt.create_array([rt.ArrayItem{ key: none, val: 'border' }, rt.ArrayItem{ key: none, val: 'radius' }, rt.ArrayItem{ key: none, val: 'topRight' }]) }, rt.ArrayItem{ key: 'border-bottom-left-radius', val: rt.create_array([rt.ArrayItem{ key: none, val: 'border' }, rt.ArrayItem{ key: none, val: 'radius' }, rt.ArrayItem{ key: none, val: 'bottomLeft' }]) }, rt.ArrayItem{ key: 'border-bottom-right-radius', val: rt.create_array([rt.ArrayItem{ key: none, val: 'border' }, rt.ArrayItem{ key: none, val: 'radius' }, rt.ArrayItem{ key: none, val: 'bottomRight' }]) }, rt.ArrayItem{ key: 'border-color', val: rt.create_array([rt.ArrayItem{ key: none, val: 'border' }, rt.ArrayItem{ key: none, val: 'color' }]) }, rt.ArrayItem{ key: 'border-width', val: rt.create_array([rt.ArrayItem{ key: none, val: 'border' }, rt.ArrayItem{ key: none, val: 'width' }]) }, rt.ArrayItem{ key: 'border-style', val: rt.create_array([rt.ArrayItem{ key: none, val: 'border' }, rt.ArrayItem{ key: none, val: 'style' }]) }, rt.ArrayItem{ key: 'border-top-color', val: rt.create_array([rt.ArrayItem{ key: none, val: 'border' }, rt.ArrayItem{ key: none, val: 'top' }, rt.ArrayItem{ key: none, val: 'color' }]) }, rt.ArrayItem{ key: 'border-top-width', val: rt.create_array([rt.ArrayItem{ key: none, val: 'border' }, rt.ArrayItem{ key: none, val: 'top' }, rt.ArrayItem{ key: none, val: 'width' }]) }, rt.ArrayItem{ key: 'border-top-style', val: rt.create_array([rt.ArrayItem{ key: none, val: 'border' }, rt.ArrayItem{ key: none, val: 'top' }, rt.ArrayItem{ key: none, val: 'style' }]) }, rt.ArrayItem{ key: 'border-right-color', val: rt.create_array([rt.ArrayItem{ key: none, val: 'border' }, rt.ArrayItem{ key: none, val: 'right' }, rt.ArrayItem{ key: none, val: 'color' }]) }, rt.ArrayItem{ key: 'border-right-width', val: rt.create_array([rt.ArrayItem{ key: none, val: 'border' }, rt.ArrayItem{ key: none, val: 'right' }, rt.ArrayItem{ key: none, val: 'width' }]) }, rt.ArrayItem{ key: 'border-right-style', val: rt.create_array([rt.ArrayItem{ key: none, val: 'border' }, rt.ArrayItem{ key: none, val: 'right' }, rt.ArrayItem{ key: none, val: 'style' }]) }, rt.ArrayItem{ key: 'border-bottom-color', val: rt.create_array([rt.ArrayItem{ key: none, val: 'border' }, rt.ArrayItem{ key: none, val: 'bottom' }, rt.ArrayItem{ key: none, val: 'color' }]) }, rt.ArrayItem{ key: 'border-bottom-width', val: rt.create_array([rt.ArrayItem{ key: none, val: 'border' }, rt.ArrayItem{ key: none, val: 'bottom' }, rt.ArrayItem{ key: none, val: 'width' }]) }, rt.ArrayItem{ key: 'border-bottom-style', val: rt.create_array([rt.ArrayItem{ key: none, val: 'border' }, rt.ArrayItem{ key: none, val: 'bottom' }, rt.ArrayItem{ key: none, val: 'style' }]) }, rt.ArrayItem{ key: 'border-left-color', val: rt.create_array([rt.ArrayItem{ key: none, val: 'border' }, rt.ArrayItem{ key: none, val: 'left' }, rt.ArrayItem{ key: none, val: 'color' }]) }, rt.ArrayItem{ key: 'border-left-width', val: rt.create_array([rt.ArrayItem{ key: none, val: 'border' }, rt.ArrayItem{ key: none, val: 'left' }, rt.ArrayItem{ key: none, val: 'width' }]) }, rt.ArrayItem{ key: 'border-left-style', val: rt.create_array([rt.ArrayItem{ key: none, val: 'border' }, rt.ArrayItem{ key: none, val: 'left' }, rt.ArrayItem{ key: none, val: 'style' }]) }, rt.ArrayItem{ key: 'color', val: rt.create_array([rt.ArrayItem{ key: none, val: 'color' }, rt.ArrayItem{ key: none, val: 'text' }]) }, rt.ArrayItem{ key: 'text-align', val: rt.create_array([rt.ArrayItem{ key: none, val: 'typography' }, rt.ArrayItem{ key: none, val: 'textAlign' }]) }, rt.ArrayItem{ key: 'column-count', val: rt.create_array([rt.ArrayItem{ key: none, val: 'typography' }, rt.ArrayItem{ key: none, val: 'textColumns' }]) }, rt.ArrayItem{ key: 'font-family', val: rt.create_array([rt.ArrayItem{ key: none, val: 'typography' }, rt.ArrayItem{ key: none, val: 'fontFamily' }]) }, rt.ArrayItem{ key: 'font-size', val: rt.create_array([rt.ArrayItem{ key: none, val: 'typography' }, rt.ArrayItem{ key: none, val: 'fontSize' }]) }, rt.ArrayItem{ key: 'font-style', val: rt.create_array([rt.ArrayItem{ key: none, val: 'typography' }, rt.ArrayItem{ key: none, val: 'fontStyle' }]) }, rt.ArrayItem{ key: 'font-weight', val: rt.create_array([rt.ArrayItem{ key: none, val: 'typography' }, rt.ArrayItem{ key: none, val: 'fontWeight' }]) }, rt.ArrayItem{ key: 'letter-spacing', val: rt.create_array([rt.ArrayItem{ key: none, val: 'typography' }, rt.ArrayItem{ key: none, val: 'letterSpacing' }]) }, rt.ArrayItem{ key: 'line-height', val: rt.create_array([rt.ArrayItem{ key: none, val: 'typography' }, rt.ArrayItem{ key: none, val: 'lineHeight' }]) }, rt.ArrayItem{ key: 'margin', val: rt.create_array([rt.ArrayItem{ key: none, val: 'spacing' }, rt.ArrayItem{ key: none, val: 'margin' }]) }, rt.ArrayItem{ key: 'margin-top', val: rt.create_array([rt.ArrayItem{ key: none, val: 'spacing' }, rt.ArrayItem{ key: none, val: 'margin' }, rt.ArrayItem{ key: none, val: 'top' }]) }, rt.ArrayItem{ key: 'margin-right', val: rt.create_array([rt.ArrayItem{ key: none, val: 'spacing' }, rt.ArrayItem{ key: none, val: 'margin' }, rt.ArrayItem{ key: none, val: 'right' }]) }, rt.ArrayItem{ key: 'margin-bottom', val: rt.create_array([rt.ArrayItem{ key: none, val: 'spacing' }, rt.ArrayItem{ key: none, val: 'margin' }, rt.ArrayItem{ key: none, val: 'bottom' }]) }, rt.ArrayItem{ key: 'margin-left', val: rt.create_array([rt.ArrayItem{ key: none, val: 'spacing' }, rt.ArrayItem{ key: none, val: 'margin' }, rt.ArrayItem{ key: none, val: 'left' }]) }, rt.ArrayItem{ key: 'min-height', val: rt.create_array([rt.ArrayItem{ key: none, val: 'dimensions' }, rt.ArrayItem{ key: none, val: 'minHeight' }]) }, rt.ArrayItem{ key: 'outline-color', val: rt.create_array([rt.ArrayItem{ key: none, val: 'outline' }, rt.ArrayItem{ key: none, val: 'color' }]) }, rt.ArrayItem{ key: 'outline-offset', val: rt.create_array([rt.ArrayItem{ key: none, val: 'outline' }, rt.ArrayItem{ key: none, val: 'offset' }]) }, rt.ArrayItem{ key: 'outline-style', val: rt.create_array([rt.ArrayItem{ key: none, val: 'outline' }, rt.ArrayItem{ key: none, val: 'style' }]) }, rt.ArrayItem{ key: 'outline-width', val: rt.create_array([rt.ArrayItem{ key: none, val: 'outline' }, rt.ArrayItem{ key: none, val: 'width' }]) }, rt.ArrayItem{ key: 'padding', val: rt.create_array([rt.ArrayItem{ key: none, val: 'spacing' }, rt.ArrayItem{ key: none, val: 'padding' }]) }, rt.ArrayItem{ key: 'padding-top', val: rt.create_array([rt.ArrayItem{ key: none, val: 'spacing' }, rt.ArrayItem{ key: none, val: 'padding' }, rt.ArrayItem{ key: none, val: 'top' }]) }, rt.ArrayItem{ key: 'padding-right', val: rt.create_array([rt.ArrayItem{ key: none, val: 'spacing' }, rt.ArrayItem{ key: none, val: 'padding' }, rt.ArrayItem{ key: none, val: 'right' }]) }, rt.ArrayItem{ key: 'padding-bottom', val: rt.create_array([rt.ArrayItem{ key: none, val: 'spacing' }, rt.ArrayItem{ key: none, val: 'padding' }, rt.ArrayItem{ key: none, val: 'bottom' }]) }, rt.ArrayItem{ key: 'padding-left', val: rt.create_array([rt.ArrayItem{ key: none, val: 'spacing' }, rt.ArrayItem{ key: none, val: 'padding' }, rt.ArrayItem{ key: none, val: 'left' }]) }, rt.ArrayItem{ key: '--wp--style--root--padding', val: rt.create_array([rt.ArrayItem{ key: none, val: 'spacing' }, rt.ArrayItem{ key: none, val: 'padding' }]) }, rt.ArrayItem{ key: '--wp--style--root--padding-top', val: rt.create_array([rt.ArrayItem{ key: none, val: 'spacing' }, rt.ArrayItem{ key: none, val: 'padding' }, rt.ArrayItem{ key: none, val: 'top' }]) }, rt.ArrayItem{ key: '--wp--style--root--padding-right', val: rt.create_array([rt.ArrayItem{ key: none, val: 'spacing' }, rt.ArrayItem{ key: none, val: 'padding' }, rt.ArrayItem{ key: none, val: 'right' }]) }, rt.ArrayItem{ key: '--wp--style--root--padding-bottom', val: rt.create_array([rt.ArrayItem{ key: none, val: 'spacing' }, rt.ArrayItem{ key: none, val: 'padding' }, rt.ArrayItem{ key: none, val: 'bottom' }]) }, rt.ArrayItem{ key: '--wp--style--root--padding-left', val: rt.create_array([rt.ArrayItem{ key: none, val: 'spacing' }, rt.ArrayItem{ key: none, val: 'padding' }, rt.ArrayItem{ key: none, val: 'left' }]) }, rt.ArrayItem{ key: 'text-decoration', val: rt.create_array([rt.ArrayItem{ key: none, val: 'typography' }, rt.ArrayItem{ key: none, val: 'textDecoration' }]) }, rt.ArrayItem{ key: 'text-transform', val: rt.create_array([rt.ArrayItem{ key: none, val: 'typography' }, rt.ArrayItem{ key: none, val: 'textTransform' }]) }, rt.ArrayItem{ key: 'text-indent', val: rt.create_array([rt.ArrayItem{ key: none, val: 'typography' }, rt.ArrayItem{ key: none, val: 'textIndent' }]) }, rt.ArrayItem{ key: 'filter', val: rt.create_array([rt.ArrayItem{ key: none, val: 'filter' }, rt.ArrayItem{ key: none, val: 'duotone' }]) }, rt.ArrayItem{ key: 'box-shadow', val: rt.create_array([rt.ArrayItem{ key: none, val: 'shadow' }]) }, rt.ArrayItem{ key: 'height', val: rt.create_array([rt.ArrayItem{ key: none, val: 'dimensions' }, rt.ArrayItem{ key: none, val: 'height' }]) }, rt.ArrayItem{ key: 'width', val: rt.create_array([rt.ArrayItem{ key: none, val: 'dimensions' }, rt.ArrayItem{ key: none, val: 'width' }]) }, rt.ArrayItem{ key: 'writing-mode', val: rt.create_array([rt.ArrayItem{ key: none, val: 'typography' }, rt.ArrayItem{ key: none, val: 'writingMode' }]) }])
}
pub fn Class_WP_Theme_JSON.indirect_properties_metadata() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'gap', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: none, val: 'spacing' }, rt.ArrayItem{ key: none, val: 'blockGap' }]) }]) }, rt.ArrayItem{ key: 'column-gap', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: none, val: 'spacing' }, rt.ArrayItem{ key: none, val: 'blockGap' }, rt.ArrayItem{ key: none, val: 'left' }]) }]) }, rt.ArrayItem{ key: 'row-gap', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: none, val: 'spacing' }, rt.ArrayItem{ key: none, val: 'blockGap' }, rt.ArrayItem{ key: none, val: 'top' }]) }]) }, rt.ArrayItem{ key: 'max-width', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: none, val: 'layout' }, rt.ArrayItem{ key: none, val: 'contentSize' }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: none, val: 'layout' }, rt.ArrayItem{ key: none, val: 'wideSize' }]) }]) }, rt.ArrayItem{ key: 'background-image', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: none, val: 'background' }, rt.ArrayItem{ key: none, val: 'backgroundImage' }, rt.ArrayItem{ key: none, val: 'url' }]) }]) }])
}
pub fn Class_WP_Theme_JSON.protected_properties() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'spacing.blockGap', val: rt.create_array([rt.ArrayItem{ key: none, val: 'spacing' }, rt.ArrayItem{ key: none, val: 'blockGap' }]) }])
}
pub fn Class_WP_Theme_JSON.valid_top_level_keys() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: none, val: 'blockTypes' }, rt.ArrayItem{ key: none, val: 'customTemplates' }, rt.ArrayItem{ key: none, val: 'description' }, rt.ArrayItem{ key: none, val: 'patterns' }, rt.ArrayItem{ key: none, val: 'settings' }, rt.ArrayItem{ key: none, val: 'slug' }, rt.ArrayItem{ key: none, val: 'styles' }, rt.ArrayItem{ key: none, val: 'templateParts' }, rt.ArrayItem{ key: none, val: 'title' }, rt.ArrayItem{ key: none, val: 'version' }])
}
pub fn Class_WP_Theme_JSON.valid_settings() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'appearanceTools', val: rt.new_null() }, rt.ArrayItem{ key: 'useRootPaddingAwareAlignments', val: rt.new_null() }, rt.ArrayItem{ key: 'background', val: rt.create_array([rt.ArrayItem{ key: 'backgroundImage', val: rt.new_null() }, rt.ArrayItem{ key: 'backgroundSize', val: rt.new_null() }]) }, rt.ArrayItem{ key: 'border', val: rt.create_array([rt.ArrayItem{ key: 'color', val: rt.new_null() }, rt.ArrayItem{ key: 'radius', val: rt.new_null() }, rt.ArrayItem{ key: 'radiusSizes', val: rt.new_null() }, rt.ArrayItem{ key: 'style', val: rt.new_null() }, rt.ArrayItem{ key: 'width', val: rt.new_null() }]) }, rt.ArrayItem{ key: 'color', val: rt.create_array([rt.ArrayItem{ key: 'background', val: rt.new_null() }, rt.ArrayItem{ key: 'custom', val: rt.new_null() }, rt.ArrayItem{ key: 'customDuotone', val: rt.new_null() }, rt.ArrayItem{ key: 'customGradient', val: rt.new_null() }, rt.ArrayItem{ key: 'defaultDuotone', val: rt.new_null() }, rt.ArrayItem{ key: 'defaultGradients', val: rt.new_null() }, rt.ArrayItem{ key: 'defaultPalette', val: rt.new_null() }, rt.ArrayItem{ key: 'duotone', val: rt.new_null() }, rt.ArrayItem{ key: 'gradients', val: rt.new_null() }, rt.ArrayItem{ key: 'link', val: rt.new_null() }, rt.ArrayItem{ key: 'heading', val: rt.new_null() }, rt.ArrayItem{ key: 'button', val: rt.new_null() }, rt.ArrayItem{ key: 'caption', val: rt.new_null() }, rt.ArrayItem{ key: 'palette', val: rt.new_null() }, rt.ArrayItem{ key: 'text', val: rt.new_null() }]) }, rt.ArrayItem{ key: 'custom', val: rt.new_null() }, rt.ArrayItem{ key: 'dimensions', val: rt.create_array([rt.ArrayItem{ key: 'aspectRatio', val: rt.new_null() }, rt.ArrayItem{ key: 'aspectRatios', val: rt.new_null() }, rt.ArrayItem{ key: 'defaultAspectRatios', val: rt.new_null() }, rt.ArrayItem{ key: 'dimensionSizes', val: rt.new_null() }, rt.ArrayItem{ key: 'height', val: rt.new_null() }, rt.ArrayItem{ key: 'minHeight', val: rt.new_null() }, rt.ArrayItem{ key: 'width', val: rt.new_null() }]) }, rt.ArrayItem{ key: 'layout', val: rt.create_array([rt.ArrayItem{ key: 'contentSize', val: rt.new_null() }, rt.ArrayItem{ key: 'wideSize', val: rt.new_null() }, rt.ArrayItem{ key: 'allowEditing', val: rt.new_null() }, rt.ArrayItem{ key: 'allowCustomContentAndWideSize', val: rt.new_null() }]) }, rt.ArrayItem{ key: 'lightbox', val: rt.create_array([rt.ArrayItem{ key: 'enabled', val: true }, rt.ArrayItem{ key: 'allowEditing', val: true }]) }, rt.ArrayItem{ key: 'position', val: rt.create_array([rt.ArrayItem{ key: 'fixed', val: rt.new_null() }, rt.ArrayItem{ key: 'sticky', val: rt.new_null() }]) }, rt.ArrayItem{ key: 'spacing', val: rt.create_array([rt.ArrayItem{ key: 'customSpacingSize', val: rt.new_null() }, rt.ArrayItem{ key: 'defaultSpacingSizes', val: rt.new_null() }, rt.ArrayItem{ key: 'spacingSizes', val: rt.new_null() }, rt.ArrayItem{ key: 'spacingScale', val: rt.new_null() }, rt.ArrayItem{ key: 'blockGap', val: rt.new_null() }, rt.ArrayItem{ key: 'margin', val: rt.new_null() }, rt.ArrayItem{ key: 'padding', val: rt.new_null() }, rt.ArrayItem{ key: 'units', val: rt.new_null() }]) }, rt.ArrayItem{ key: 'shadow', val: rt.create_array([rt.ArrayItem{ key: 'presets', val: rt.new_null() }, rt.ArrayItem{ key: 'defaultPresets', val: rt.new_null() }]) }, rt.ArrayItem{ key: 'typography', val: rt.create_array([rt.ArrayItem{ key: 'fluid', val: rt.new_null() }, rt.ArrayItem{ key: 'customFontSize', val: rt.new_null() }, rt.ArrayItem{ key: 'defaultFontSizes', val: rt.new_null() }, rt.ArrayItem{ key: 'dropCap', val: rt.new_null() }, rt.ArrayItem{ key: 'fontFamilies', val: rt.new_null() }, rt.ArrayItem{ key: 'fontSizes', val: rt.new_null() }, rt.ArrayItem{ key: 'fontStyle', val: rt.new_null() }, rt.ArrayItem{ key: 'fontWeight', val: rt.new_null() }, rt.ArrayItem{ key: 'letterSpacing', val: rt.new_null() }, rt.ArrayItem{ key: 'lineHeight', val: rt.new_null() }, rt.ArrayItem{ key: 'textAlign', val: rt.new_null() }, rt.ArrayItem{ key: 'textColumns', val: rt.new_null() }, rt.ArrayItem{ key: 'textDecoration', val: rt.new_null() }, rt.ArrayItem{ key: 'textIndent', val: rt.new_null() }, rt.ArrayItem{ key: 'textTransform', val: rt.new_null() }, rt.ArrayItem{ key: 'writingMode', val: rt.new_null() }]) }])
}
pub fn Class_WP_Theme_JSON.font_family_schema() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'fontFamily', val: rt.new_null() }, rt.ArrayItem{ key: 'name', val: rt.new_null() }, rt.ArrayItem{ key: 'slug', val: rt.new_null() }, rt.ArrayItem{ key: 'fontFace', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'ascentOverride', val: rt.new_null() }, rt.ArrayItem{ key: 'descentOverride', val: rt.new_null() }, rt.ArrayItem{ key: 'fontDisplay', val: rt.new_null() }, rt.ArrayItem{ key: 'fontFamily', val: rt.new_null() }, rt.ArrayItem{ key: 'fontFeatureSettings', val: rt.new_null() }, rt.ArrayItem{ key: 'fontStyle', val: rt.new_null() }, rt.ArrayItem{ key: 'fontStretch', val: rt.new_null() }, rt.ArrayItem{ key: 'fontVariationSettings', val: rt.new_null() }, rt.ArrayItem{ key: 'fontWeight', val: rt.new_null() }, rt.ArrayItem{ key: 'lineGapOverride', val: rt.new_null() }, rt.ArrayItem{ key: 'sizeAdjust', val: rt.new_null() }, rt.ArrayItem{ key: 'src', val: rt.new_null() }, rt.ArrayItem{ key: 'unicodeRange', val: rt.new_null() }]) }]) }]) }])
}
pub fn Class_WP_Theme_JSON.valid_styles() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'background', val: rt.create_array([rt.ArrayItem{ key: 'backgroundImage', val: rt.new_null() }, rt.ArrayItem{ key: 'backgroundPosition', val: rt.new_null() }, rt.ArrayItem{ key: 'backgroundRepeat', val: rt.new_null() }, rt.ArrayItem{ key: 'backgroundSize', val: rt.new_null() }, rt.ArrayItem{ key: 'backgroundAttachment', val: rt.new_null() }]) }, rt.ArrayItem{ key: 'border', val: rt.create_array([rt.ArrayItem{ key: 'color', val: rt.new_null() }, rt.ArrayItem{ key: 'radius', val: rt.new_null() }, rt.ArrayItem{ key: 'style', val: rt.new_null() }, rt.ArrayItem{ key: 'width', val: rt.new_null() }, rt.ArrayItem{ key: 'top', val: rt.new_null() }, rt.ArrayItem{ key: 'right', val: rt.new_null() }, rt.ArrayItem{ key: 'bottom', val: rt.new_null() }, rt.ArrayItem{ key: 'left', val: rt.new_null() }]) }, rt.ArrayItem{ key: 'color', val: rt.create_array([rt.ArrayItem{ key: 'background', val: rt.new_null() }, rt.ArrayItem{ key: 'gradient', val: rt.new_null() }, rt.ArrayItem{ key: 'text', val: rt.new_null() }]) }, rt.ArrayItem{ key: 'dimensions', val: rt.create_array([rt.ArrayItem{ key: 'aspectRatio', val: rt.new_null() }, rt.ArrayItem{ key: 'height', val: rt.new_null() }, rt.ArrayItem{ key: 'minHeight', val: rt.new_null() }, rt.ArrayItem{ key: 'width', val: rt.new_null() }]) }, rt.ArrayItem{ key: 'filter', val: rt.create_array([rt.ArrayItem{ key: 'duotone', val: rt.new_null() }]) }, rt.ArrayItem{ key: 'outline', val: rt.create_array([rt.ArrayItem{ key: 'color', val: rt.new_null() }, rt.ArrayItem{ key: 'offset', val: rt.new_null() }, rt.ArrayItem{ key: 'style', val: rt.new_null() }, rt.ArrayItem{ key: 'width', val: rt.new_null() }]) }, rt.ArrayItem{ key: 'shadow', val: rt.new_null() }, rt.ArrayItem{ key: 'spacing', val: rt.create_array([rt.ArrayItem{ key: 'margin', val: rt.new_null() }, rt.ArrayItem{ key: 'padding', val: rt.new_null() }, rt.ArrayItem{ key: 'blockGap', val: rt.new_null() }]) }, rt.ArrayItem{ key: 'typography', val: rt.create_array([rt.ArrayItem{ key: 'fontFamily', val: rt.new_null() }, rt.ArrayItem{ key: 'fontSize', val: rt.new_null() }, rt.ArrayItem{ key: 'fontStyle', val: rt.new_null() }, rt.ArrayItem{ key: 'fontWeight', val: rt.new_null() }, rt.ArrayItem{ key: 'letterSpacing', val: rt.new_null() }, rt.ArrayItem{ key: 'lineHeight', val: rt.new_null() }, rt.ArrayItem{ key: 'textAlign', val: rt.new_null() }, rt.ArrayItem{ key: 'textColumns', val: rt.new_null() }, rt.ArrayItem{ key: 'textDecoration', val: rt.new_null() }, rt.ArrayItem{ key: 'textIndent', val: rt.new_null() }, rt.ArrayItem{ key: 'textTransform', val: rt.new_null() }, rt.ArrayItem{ key: 'writingMode', val: rt.new_null() }]) }, rt.ArrayItem{ key: 'css', val: rt.new_null() }])
}
pub fn Class_WP_Theme_JSON.valid_element_pseudo_selectors() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'link', val: rt.create_array([rt.ArrayItem{ key: none, val: ':link' }, rt.ArrayItem{ key: none, val: ':any-link' }, rt.ArrayItem{ key: none, val: ':visited' }, rt.ArrayItem{ key: none, val: ':hover' }, rt.ArrayItem{ key: none, val: ':focus' }, rt.ArrayItem{ key: none, val: ':focus-visible' }, rt.ArrayItem{ key: none, val: ':active' }]) }, rt.ArrayItem{ key: 'button', val: rt.create_array([rt.ArrayItem{ key: none, val: ':link' }, rt.ArrayItem{ key: none, val: ':any-link' }, rt.ArrayItem{ key: none, val: ':visited' }, rt.ArrayItem{ key: none, val: ':hover' }, rt.ArrayItem{ key: none, val: ':focus' }, rt.ArrayItem{ key: none, val: ':focus-visible' }, rt.ArrayItem{ key: none, val: ':active' }]) }])
}
pub fn Class_WP_Theme_JSON.valid_block_pseudo_selectors() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'core/button', val: rt.create_array([rt.ArrayItem{ key: none, val: ':hover' }, rt.ArrayItem{ key: none, val: ':focus' }, rt.ArrayItem{ key: none, val: ':focus-visible' }, rt.ArrayItem{ key: none, val: ':active' }]) }])
}
pub fn Class_WP_Theme_JSON.elements() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'link', val: 'a:where(:not(.wp-element-button))' }, rt.ArrayItem{ key: 'heading', val: 'h1, h2, h3, h4, h5, h6' }, rt.ArrayItem{ key: 'h1', val: 'h1' }, rt.ArrayItem{ key: 'h2', val: 'h2' }, rt.ArrayItem{ key: 'h3', val: 'h3' }, rt.ArrayItem{ key: 'h4', val: 'h4' }, rt.ArrayItem{ key: 'h5', val: 'h5' }, rt.ArrayItem{ key: 'h6', val: 'h6' }, rt.ArrayItem{ key: 'button', val: '.wp-element-button, .wp-block-button__link' }, rt.ArrayItem{ key: 'caption', val: '.wp-element-caption, .wp-block-audio figcaption, .wp-block-embed figcaption, .wp-block-gallery figcaption, .wp-block-image figcaption, .wp-block-table figcaption, .wp-block-video figcaption' }, rt.ArrayItem{ key: 'cite', val: 'cite' }, rt.ArrayItem{ key: 'textInput', val: 'textarea, input:where([type=email],[type=number],[type=password],[type=search],[type=text],[type=tel],[type=url])' }, rt.ArrayItem{ key: 'select', val: 'select' }])
}
pub fn Class_WP_Theme_JSON.__experimental_element_class_names() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'button', val: 'wp-element-button' }, rt.ArrayItem{ key: 'caption', val: 'wp-element-caption' }])
}
pub fn Class_WP_Theme_JSON.block_support_feature_level_selectors() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: '__experimentalBorder', val: 'border' }, rt.ArrayItem{ key: 'color', val: 'color' }, rt.ArrayItem{ key: 'dimensions', val: 'dimensions' }, rt.ArrayItem{ key: 'spacing', val: 'spacing' }, rt.ArrayItem{ key: 'typography', val: 'typography' }])
}
pub fn Class_WP_Theme_JSON.appearance_tools_opt_ins() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: none, val: 'background' }, rt.ArrayItem{ key: none, val: 'backgroundImage' }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: none, val: 'background' }, rt.ArrayItem{ key: none, val: 'backgroundSize' }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: none, val: 'border' }, rt.ArrayItem{ key: none, val: 'color' }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: none, val: 'border' }, rt.ArrayItem{ key: none, val: 'radius' }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: none, val: 'border' }, rt.ArrayItem{ key: none, val: 'style' }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: none, val: 'border' }, rt.ArrayItem{ key: none, val: 'width' }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: none, val: 'color' }, rt.ArrayItem{ key: none, val: 'link' }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: none, val: 'color' }, rt.ArrayItem{ key: none, val: 'heading' }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: none, val: 'color' }, rt.ArrayItem{ key: none, val: 'button' }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: none, val: 'color' }, rt.ArrayItem{ key: none, val: 'caption' }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: none, val: 'dimensions' }, rt.ArrayItem{ key: none, val: 'aspectRatio' }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: none, val: 'dimensions' }, rt.ArrayItem{ key: none, val: 'height' }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: none, val: 'dimensions' }, rt.ArrayItem{ key: none, val: 'minHeight' }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: none, val: 'dimensions' }, rt.ArrayItem{ key: none, val: 'width' }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: none, val: 'position' }, rt.ArrayItem{ key: none, val: 'sticky' }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: none, val: 'spacing' }, rt.ArrayItem{ key: none, val: 'blockGap' }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: none, val: 'spacing' }, rt.ArrayItem{ key: none, val: 'margin' }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: none, val: 'spacing' }, rt.ArrayItem{ key: none, val: 'padding' }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: none, val: 'typography' }, rt.ArrayItem{ key: none, val: 'lineHeight' }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: none, val: 'typography' }, rt.ArrayItem{ key: none, val: 'textColumns' }]) }])
}
pub fn Class_WP_Theme_JSON.latest_schema() i64 {
	return 3
}
struct Class_WP_Theme_JSON {
	rt.PhpObjectBase
pub mut:
		theme_json rt.PhpVal = rt.new_null()
		blocks_metadata rt.PhpVal = rt.new_array()
}

fn Class_WP_Theme_JSON.schema_in_root_and_per_origin(var_schema rt.PhpVal) rt.PhpVal {
	mut var_schema_mutated := var_schema
	mut var_schema_in_root_and_per_origin := var_schema_mutated.dup()
	{
		mut iter_1 := Class_static.valid_origins().iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_origin := item_1.val
			var_schema_in_root_and_per_origin.array_set(var_origin, var_schema_mutated.dup())
		}
	}
	return var_schema_in_root_and_per_origin.dup()
}

fn Class_WP_Theme_JSON.process_pseudo_selectors(var_node rt.PhpVal, var_base_selector rt.PhpVal, var_settings rt.PhpVal, var_block_name rt.PhpVal) rt.PhpVal {
	mut var_node_mutated := var_node
	mut var_settings_mutated := var_settings
	mut var_block_name_mutated := var_block_name
	mut var_pseudo_declarations := rt.new_array()
	if !(Class_static.valid_block_pseudo_selectors().array_isset(var_block_name_mutated)) {
		return var_pseudo_declarations.dup()
	}
	{
		mut iter_1 := Class_static.valid_block_pseudo_selectors().array_get(var_block_name_mutated).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_pseudo_selector := item_1.val
			if var_node_mutated.array_isset(var_pseudo_selector) {
				mut var_combined_selector := Class_WP_Theme_JSON.append_to_selector(var_base_selector.dup(), var_pseudo_selector.dup())
				mut var_declarations := Class_WP_Theme_JSON.compute_style_properties(var_node_mutated.array_get(var_pseudo_selector), var_settings_mutated.dup(), rt.new_null(), rt.new_null())
				var_pseudo_declarations.array_set(var_combined_selector, var_declarations.dup())
			}
		}
	}
	return var_pseudo_declarations.dup()
}

fn Class_WP_Theme_JSON.get_element_class_name(var_element rt.PhpVal) rt.PhpVal {
	mut var_class_name := rt.new_string(rt.new_string(''))
	if Class_static.__experimental_element_class_names().array_isset(var_element) {
		var_class_name = Class_static.__experimental_element_class_names().array_get(var_element)
	}
	return var_class_name.dup()
}

fn (mut this Class_WP_Theme_JSON) construct(var_theme_json rt.PhpVal, origin string)  {
	mut var_theme_json_mutated := var_theme_json
	mut origin_mutated := origin
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [rt.new_string(origin_mutated).dup(), Class_static.valid_origins(), rt.new_bool(true)]))))) {
		origin_mutated = 'theme'
	}
	this.theme_json = fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_WP_Theme_JSON_Schema{}; return temp.migrate(arg_0, arg_1) }(var_theme_json_mutated.dup(), rt.new_string(origin_mutated))
	mut var_blocks_metadata := Class_WP_Theme_JSON.get_blocks_metadata()
	mut var_valid_block_names := rt.func_array_keys(var_blocks_metadata.dup())
	mut var_valid_element_names := rt.func_array_keys(Class_static.elements())
	mut var_valid_variations := Class_WP_Theme_JSON.get_valid_block_style_variations(var_blocks_metadata.dup())
	this.theme_json = Class_WP_Theme_JSON.unwrap_shared_block_style_variations(this.theme_json, var_valid_variations.dup())
	this.theme_json = Class_WP_Theme_JSON.sanitize(this.theme_json, var_valid_block_names.dup(), var_valid_element_names.dup(), var_valid_variations.dup())
	this.theme_json = Class_WP_Theme_JSON.maybe_opt_in_into_settings(this.theme_json)
	mut var_nodes := Class_WP_Theme_JSON.get_setting_nodes(this.theme_json)
	{
		mut iter_1 := var_nodes.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_node := item_1.val
			{
				mut iter_2 := Class_static.presets_metadata().iterator()
				for {
					item_2 := iter_2.next() or { break }
					mut var_preset_metadata := item_2.val
					mut var_path := var_node.array_get('path')
					{
						mut iter_3 := var_preset_metadata.array_get('path').iterator()
						for {
							item_3 := iter_3.next() or { break }
							mut var_subpath := item_3.val
							var_path.array_push(var_subpath.dup())
						}
					}
					mut var_preset := rt.call_function('_wp_array_get', [this.theme_json, var_path.dup(), rt.new_null()])
					if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
						if var_preset.array_isset(rt.new_int(0)) || !rt.is_true(var_preset) {
							rt.call_function('_wp_array_set', [this.theme_json, var_path.dup(), rt.create_array([rt.ArrayItem{ key: origin_mutated, val: var_preset }])])
						}
					}
				}
			}
		}
	}
	mut var_scale_path := [rt.new_string('settings'), rt.new_string('spacing'), rt.new_string('spacingScale')]
	mut var_spacing_scale := rt.call_function('_wp_array_get', [this.theme_json, var_scale_path.dup(), rt.new_null()])
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		if !rt.is_true(rt.call_function('array_intersect', [rt.func_array_keys(var_spacing_scale.dup()), Class_static.valid_origins()])) {
			rt.call_function('_wp_array_set', [this.theme_json, var_scale_path.dup(), rt.create_array([rt.ArrayItem{ key: origin_mutated, val: var_spacing_scale }])])
		}
	}
	var_scale_path = [rt.new_string('settings'), rt.new_string('spacing'), rt.new_string('spacingScale'), rt.new_string(origin_mutated)]
	var_spacing_scale = rt.call_function('_wp_array_get', [this.theme_json, var_scale_path.dup(), rt.new_null()])
	if !(var_spacing_scale).is_null() {
		mut var_sizes_path := [rt.new_string('settings'), rt.new_string('spacing'), rt.new_string('spacingSizes'), rt.new_string(origin_mutated)]
		mut var_spacing_sizes := rt.call_function('_wp_array_get', [this.theme_json, var_sizes_path.dup(), rt.new_array()])
		mut var_spacing_scale_sizes := Class_WP_Theme_JSON.compute_spacing_sizes(var_spacing_scale.dup())
		mut var_merged_spacing_sizes := Class_WP_Theme_JSON.merge_spacing_sizes(var_spacing_scale_sizes.dup(), var_spacing_sizes.dup())
		rt.call_function('_wp_array_set', [this.theme_json, var_sizes_path.dup(), var_merged_spacing_sizes.dup()])
	}
}

fn Class_WP_Theme_JSON.unwrap_shared_block_style_variations(var_theme_json rt.PhpVal, var_valid_variations rt.PhpVal) rt.PhpVal {
	mut var_theme_json_mutated := var_theme_json
	mut var_valid_variations_mutated := var_valid_variations
	if !rt.is_true(var_theme_json_mutated.array_get('styles').array_get('variations')) || !rt.is_true(var_valid_variations_mutated) {
		return var_theme_json_mutated.dup()
	}
	mut var_new_theme_json := var_theme_json_mutated.dup()
	mut var_variations := var_new_theme_json.array_get('styles').array_get('variations')
	{
		mut iter_1 := var_valid_variations_mutated.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_registered_variations := item_1.val
			mut var_block_type := item_1.key
			{
				mut iter_2 := var_registered_variations.iterator()
				for {
					item_2 := iter_2.next() or { break }
					mut var_variation_name := item_2.val
					mut var_block_level_data := if !(var_new_theme_json.array_get('styles').array_get('blocks').array_get(var_block_type).array_get('variations').array_get(var_variation_name)).is_null() { var_new_theme_json.array_get('styles').array_get('blocks').array_get(var_block_type).array_get('variations').array_get(var_variation_name) } else { rt.new_array() }
					mut var_top_level_data := if !(var_variations.array_get(var_variation_name)).is_null() { var_variations.array_get(var_variation_name) } else { rt.new_array() }
					mut var_merged_data := rt.call_function('array_replace_recursive', [var_top_level_data.dup(), var_block_level_data.dup()])
					if !(!rt.is_true(var_merged_data)) {
						rt.call_function('_wp_array_set', [var_new_theme_json.dup(), rt.create_array([rt.ArrayItem{ key: none, val: 'styles' }, rt.ArrayItem{ key: none, val: 'blocks' }, rt.ArrayItem{ key: none, val: var_block_type }, rt.ArrayItem{ key: none, val: 'variations' }, rt.ArrayItem{ key: none, val: var_variation_name }]), var_merged_data.dup()])
					}
				}
			}
		}
	}
	var_new_theme_json.array_get('styles').array_unset(rt.new_string('variations'))
	return var_new_theme_json.dup()
}

fn Class_WP_Theme_JSON.maybe_opt_in_into_settings(var_theme_json rt.PhpVal) rt.PhpVal {
	mut var_theme_json_mutated := var_theme_json
	mut var_new_theme_json := var_theme_json_mutated.dup()
	if rt.is_true(rt.new_bool(var_new_theme_json.array_get('settings').array_isset(rt.new_string('appearanceTools')) && rt.is_true(rt.identical(rt.new_bool(true), var_new_theme_json.array_get('settings').array_get('appearanceTools'))))) {
		Class_WP_Theme_JSON.do_opt_in_into_settings(var_new_theme_json.array_get('settings'))
	}
	if rt.is_true(rt.new_bool(var_new_theme_json.array_get('settings').array_isset(rt.new_string('blocks')) && rt.is_true(rt.new_bool(var_new_theme_json.array_get('settings').array_get('blocks').is_array())))) {
		{
			mut iter_1 := var_new_theme_json.array_get('settings').array_get('blocks').iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_block := item_1.val
				if rt.is_true(rt.new_bool(var_block.array_isset(rt.new_string('appearanceTools')) && rt.is_true(rt.identical(rt.new_bool(true), var_block.array_get('appearanceTools'))))) {
					Class_WP_Theme_JSON.do_opt_in_into_settings(var_block.dup())
				}
			}
		}
	}
	return var_new_theme_json.dup()
}

fn Class_WP_Theme_JSON.do_opt_in_into_settings(var_context rt.PhpVal)  {
	{
		mut iter_1 := Class_static.appearance_tools_opt_ins().iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_path := item_1.val
			if rt.is_true(rt.identical(rt.new_string('unset prop'), rt.call_function('_wp_array_get', [var_context.dup(), var_path.dup(), rt.new_string('unset prop')]))) {
				rt.call_function('_wp_array_set', [var_context.dup(), var_path.dup(), rt.new_bool(true)])
			}
		}
	}
	var_context.array_unset(rt.new_string('appearanceTools'))
}

fn Class_WP_Theme_JSON.sanitize(var_input rt.PhpVal, var_valid_block_names rt.PhpVal, var_valid_element_names rt.PhpVal, var_valid_variations rt.PhpVal) rt.PhpVal {
	mut var_input_mutated := var_input
	mut var_valid_block_names_mutated := var_valid_block_names
	mut var_valid_element_names_mutated := var_valid_element_names
	mut var_valid_variations_mutated := var_valid_variations
	mut var_output := rt.new_array()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_input_mutated.dup().is_array()))))) {
		return var_output.dup()
	}
	var_output = rt.call_function('array_intersect_key', [var_input_mutated.dup(), rt.call_function('array_flip', [Class_static.valid_top_level_keys()])])
	mut var_styles_non_top_level := Class_static.valid_styles()
	{
		mut iter_1 := rt.func_array_keys(var_styles_non_top_level.dup()).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_section := item_1.val
			if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_styles_non_top_level.dup().array_isset(var_section.dup()))) && rt.is_true(rt.new_bool(var_styles_non_top_level.array_get(var_section).is_array())))) {
				{
					mut iter_2 := rt.func_array_keys(var_styles_non_top_level.array_get(var_section)).iterator()
					for {
						item_2 := iter_2.next() or { break }
						mut var_prop := item_2.val
						if rt.is_true(rt.identical(rt.new_string('top'), var_styles_non_top_level.array_get(var_section).array_get(var_prop))) {
							var_styles_non_top_level.array_get(var_section).array_unset(var_prop)
						}
					}
				}
			}
		}
	}
	mut var_schema := rt.new_array()
	mut var_schema_styles_elements := rt.new_array()
	{
		mut iter_1 := var_valid_element_names_mutated.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_element := item_1.val
			var_schema_styles_elements.array_set(var_element, var_styles_non_top_level.dup())
			if Class_static.valid_element_pseudo_selectors().array_isset(var_element) {
				{
					mut iter_2 := Class_static.valid_element_pseudo_selectors().array_get(var_element).iterator()
					for {
						item_2 := iter_2.next() or { break }
						mut var_pseudo_selector := item_2.val
						var_schema_styles_elements.array_get_mut(var_element).array_set(var_pseudo_selector, var_styles_non_top_level.dup())
					}
				}
			}
		}
	}
	mut var_schema_styles_blocks := rt.new_array()
	mut var_schema_settings_blocks := rt.new_array()
	{
		mut iter_1 := var_valid_block_names_mutated.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_block := item_1.val
			var_schema_settings_blocks.array_set(var_block, Class_static.valid_settings())
			var_schema_styles_blocks.array_set(var_block, var_styles_non_top_level.dup())
			var_schema_styles_blocks.array_get_mut(var_block).array_set('elements', var_schema_styles_elements.dup())
			if Class_static.valid_block_pseudo_selectors().array_isset(var_block) {
				{
					mut iter_2 := Class_static.valid_block_pseudo_selectors().array_get(var_block).iterator()
					for {
						item_2 := iter_2.next() or { break }
						mut var_pseudo_selector := item_2.val
						var_schema_styles_blocks.array_get_mut(var_block).array_set(var_pseudo_selector, var_styles_non_top_level.dup())
					}
				}
			}
		}
	}
	mut var_block_style_variation_styles := Class_static.valid_styles()
	var_block_style_variation_styles.array_set('blocks', var_schema_styles_blocks.dup())
	var_block_style_variation_styles.array_set('elements', var_schema_styles_elements.dup())
	{
		mut iter_1 := var_valid_block_names_mutated.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_block := item_1.val
			mut var_style_variation_names := rt.new_array()
			if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(!rt.is_true(var_input_mutated.array_get('styles').array_get('blocks').array_get(var_block).array_get('variations'))) && rt.is_true(rt.new_bool(var_input_mutated.array_get('styles').array_get('blocks').array_get(var_block).array_get('variations').is_array())))) && var_valid_variations_mutated.array_isset(var_block))) {
				var_style_variation_names = rt.call_function('array_intersect', [rt.func_array_keys(var_input_mutated.array_get('styles').array_get('blocks').array_get(var_block).array_get('variations')), var_valid_variations_mutated.array_get(var_block)])
			}
			mut var_schema_styles_variations := rt.new_array()
			if !(!rt.is_true(var_style_variation_names)) {
				{
					mut iter_2 := var_style_variation_names.iterator()
					for {
						item_2 := iter_2.next() or { break }
						mut var_variation_name := item_2.val
						mut var_variation_schema := var_block_style_variation_styles.dup()
						if Class_static.valid_block_pseudo_selectors().array_isset(var_block) {
							{
								mut iter_3 := Class_static.valid_block_pseudo_selectors().array_get(var_block).iterator()
								for {
									item_3 := iter_3.next() or { break }
									mut var_pseudo_selector := item_3.val
									var_variation_schema.array_set(var_pseudo_selector, var_styles_non_top_level.dup())
								}
							}
						}
						var_schema_styles_variations.array_set(var_variation_name, var_variation_schema.dup())
					}
				}
			}
			var_schema_styles_blocks.array_get_mut(var_block).array_set('variations', var_schema_styles_variations.dup())
		}
	}
	var_schema.array_set('styles', Class_static.valid_styles())
	var_schema.array_get_mut('styles').array_set('blocks', var_schema_styles_blocks.dup())
	var_schema.array_get_mut('styles').array_set('elements', var_schema_styles_elements.dup())
	.array_set(, )
	
}

fn Class_WP_Theme_JSON.append_to_selector(var_selector rt.PhpVal, var_to_append rt.PhpVal) string {
	mut var_selector_mutated := var_selector
}

fn Class_WP_Theme_JSON.prepend_to_selector(var_selector rt.PhpVal, var_to_prepend rt.PhpVal) string {
	mut var_selector_mutated := var_selector
}

fn Class_WP_Theme_JSON.get_blocks_metadata() rt.PhpVal {
}

fn Class_WP_Theme_JSON.remove_keys_not_in_schema(var_tree rt.PhpVal, var_schema rt.PhpVal) rt.PhpVal {
	mut var_tree_mutated := var_tree
	mut var_schema_mutated := var_schema
}

fn (mut this Class_WP_Theme_JSON) get_settings() rt.PhpVal {
	return rt.new_null()
}

fn (mut this Class_WP_Theme_JSON) get_stylesheet(var_types rt.PhpVal, var_origins rt.PhpVal, var_options rt.PhpVal) rt.PhpVal {
	mut var_types_mutated := var_types
	mut var_origins_mutated := var_origins
}

fn Class_WP_Theme_JSON.process_blocks_custom_css(var_css rt.PhpVal, var_selector rt.PhpVal) rt.PhpVal {
	mut var_css_mutated := var_css
	mut var_selector_mutated := var_selector
}

fn (mut this Class_WP_Theme_JSON) get_custom_css() rt.PhpVal {
}

fn (mut this Class_WP_Theme_JSON) get_custom_templates() rt.PhpVal {
}

fn (mut this Class_WP_Theme_JSON) get_template_parts() rt.PhpVal {
}

fn (mut this Class_WP_Theme_JSON) get_block_classes(var_style_nodes rt.PhpVal) rt.PhpVal {
	mut var_style_nodes_mutated := var_style_nodes
}

fn (mut this Class_WP_Theme_JSON) get_layout_styles(var_block_metadata rt.PhpVal, var_options rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_WP_Theme_JSON) get_preset_classes(var_setting_nodes rt.PhpVal, var_origins rt.PhpVal) rt.PhpVal {
	mut var_setting_nodes_mutated := var_setting_nodes
	mut var_origins_mutated := var_origins
}

fn (mut this Class_WP_Theme_JSON) get_css_variables(var_nodes rt.PhpVal, var_origins rt.PhpVal) rt.PhpVal {
	mut var_nodes_mutated := var_nodes
	mut var_origins_mutated := var_origins
}

fn Class_WP_Theme_JSON.to_ruleset(var_selector rt.PhpVal, var_declarations rt.PhpVal) string {
	mut var_selector_mutated := var_selector
	mut var_declarations_mutated := var_declarations
}

fn Class_WP_Theme_JSON.compute_preset_classes(var_settings rt.PhpVal, var_selector rt.PhpVal, var_origins rt.PhpVal) rt.PhpVal {
	mut var_settings_mutated := var_settings
	mut var_selector_mutated := var_selector
	mut var_origins_mutated := var_origins
}

fn Class_WP_Theme_JSON.scope_selector(var_scope rt.PhpVal, var_selector rt.PhpVal) rt.PhpVal {
	mut var_selector_mutated := var_selector
}

fn Class_WP_Theme_JSON.scope_style_node_selectors(var_scope rt.PhpVal, var_node rt.PhpVal) rt.PhpVal {
	mut var_node_mutated := var_node
}

fn Class_WP_Theme_JSON.get_settings_values_by_slug(var_settings rt.PhpVal, var_preset_metadata rt.PhpVal, var_origins rt.PhpVal) rt.PhpVal {
	mut var_settings_mutated := var_settings
	mut var_origins_mutated := var_origins
}

fn Class_WP_Theme_JSON.get_settings_slugs(var_settings rt.PhpVal, var_preset_metadata rt.PhpVal, var_origins rt.PhpVal) rt.PhpVal {
	mut var_settings_mutated := var_settings
	mut var_origins_mutated := var_origins
}

fn Class_WP_Theme_JSON.replace_slug_in_string(var_input rt.PhpVal, var_slug rt.PhpVal) rt.PhpVal {
	mut var_input_mutated := var_input
	mut var_slug_mutated := var_slug
}

fn Class_WP_Theme_JSON.compute_preset_vars(var_settings rt.PhpVal, var_origins rt.PhpVal) rt.PhpVal {
	mut var_settings_mutated := var_settings
	mut var_origins_mutated := var_origins
}

fn Class_WP_Theme_JSON.compute_theme_vars(var_settings rt.PhpVal) rt.PhpVal {
	mut var_settings_mutated := var_settings
}

fn Class_WP_Theme_JSON.flatten_tree(var_tree rt.PhpVal, prefix string, token string) rt.PhpVal {
	mut var_tree_mutated := var_tree
	mut prefix_mutated := prefix
}

fn Class_WP_Theme_JSON.compute_style_properties(var_styles rt.PhpVal, var_settings rt.PhpVal, var_properties rt.PhpVal, var_theme_json rt.PhpVal, var_selector rt.PhpVal, var_use_root_padding rt.PhpVal) rt.PhpVal {
	mut var_styles_mutated := var_styles
	mut var_settings_mutated := var_settings
	mut var_properties_mutated := var_properties
	mut var_theme_json_mutated := var_theme_json
	mut var_selector_mutated := var_selector
	mut var_use_root_padding_mutated := var_use_root_padding
}

fn Class_WP_Theme_JSON.get_property_value(var_styles rt.PhpVal, var_path rt.PhpVal, var_theme_json rt.PhpVal) rt.PhpVal {
	mut var_styles_mutated := var_styles
	mut var_path_mutated := var_path
	mut var_theme_json_mutated := var_theme_json
}

fn Class_WP_Theme_JSON.get_setting_nodes(var_theme_json rt.PhpVal, var_selectors rt.PhpVal) rt.PhpVal {
	mut var_theme_json_mutated := var_theme_json
	mut var_selectors_mutated := var_selectors
}

fn Class_WP_Theme_JSON.get_style_nodes(var_theme_json rt.PhpVal, var_selectors rt.PhpVal, var_options rt.PhpVal) rt.PhpVal {
	mut var_theme_json_mutated := var_theme_json
	mut var_selectors_mutated := var_selectors
}

fn (mut this Class_WP_Theme_JSON) get_styles_block_nodes() rt.PhpVal {
}

fn Class_WP_Theme_JSON.update_separator_declarations(var_declarations rt.PhpVal) rt.PhpVal {
	mut var_declarations_mutated := var_declarations
}

fn Class_WP_Theme_JSON.update_paragraph_text_indent_selector(var_feature_declarations rt.PhpVal, var_settings rt.PhpVal, var_block_name rt.PhpVal) rt.PhpVal {
	mut var_feature_declarations_mutated := var_feature_declarations
	mut var_settings_mutated := var_settings
	mut var_block_name_mutated := var_block_name
}

fn Class_WP_Theme_JSON.get_block_nodes(var_theme_json rt.PhpVal, var_selectors rt.PhpVal, var_options rt.PhpVal) rt.PhpVal {
	mut var_theme_json_mutated := var_theme_json
	mut var_selectors_mutated := var_selectors
}

fn (mut this Class_WP_Theme_JSON) get_styles_for_block(var_block_metadata rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_WP_Theme_JSON) get_root_layout_rules(var_selector rt.PhpVal, var_block_metadata rt.PhpVal, var_options rt.PhpVal) rt.PhpVal {
	mut var_selector_mutated := var_selector
}

fn Class_WP_Theme_JSON.get_metadata_boolean(var_data rt.PhpVal, var_path rt.PhpVal, default_value bool) rt.PhpVal {
	mut var_path_mutated := var_path
}

fn (mut this Class_WP_Theme_JSON) merge(var_incoming rt.PhpVal)  {
}

fn (mut this Class_WP_Theme_JSON) get_svg_filters(var_origins rt.PhpVal) rt.PhpVal {
	mut var_origins_mutated := var_origins
}

fn Class_WP_Theme_JSON.should_override_preset(var_theme_json rt.PhpVal, var_path rt.PhpVal, var_override rt.PhpVal) rt.PhpVal {
	mut var_theme_json_mutated := var_theme_json
	mut var_path_mutated := var_path
}

fn Class_WP_Theme_JSON.get_default_slugs(var_data rt.PhpVal, var_node_path rt.PhpVal) rt.PhpVal {
	mut var_node_path_mutated := var_node_path
}

fn (mut this Class_WP_Theme_JSON) get_name_from_defaults(var_slug rt.PhpVal, var_base_path rt.PhpVal) rt.PhpVal {
	mut var_slug_mutated := var_slug
	mut var_base_path_mutated := var_base_path
}

fn Class_WP_Theme_JSON.filter_slugs(var_node rt.PhpVal, var_slugs rt.PhpVal) rt.PhpVal {
	mut var_node_mutated := var_node
	mut var_slugs_mutated := var_slugs
}

fn Class_WP_Theme_JSON.remove_insecure_properties(var_theme_json rt.PhpVal, origin string) rt.PhpVal {
	mut var_theme_json_mutated := var_theme_json
	mut origin_mutated := origin
}

fn Class_WP_Theme_JSON.remove_insecure_element_styles(var_elements rt.PhpVal) rt.PhpVal {
	mut var_elements_mutated := var_elements
}

fn Class_WP_Theme_JSON.remove_insecure_inner_block_styles(var_blocks rt.PhpVal) rt.PhpVal {
	mut var_blocks_mutated := var_blocks
}

fn Class_WP_Theme_JSON.preserve_valid_typed_settings(var_input rt.PhpVal, var_output rt.PhpVal, var_schema rt.PhpVal, var_path rt.PhpVal)  {
	mut var_input_mutated := var_input
	mut var_output_mutated := var_output
	mut var_schema_mutated := var_schema
	mut var_path_mutated := var_path
}

fn Class_WP_Theme_JSON.remove_insecure_settings(var_input rt.PhpVal) rt.PhpVal {
	mut var_input_mutated := var_input
}

fn Class_WP_Theme_JSON.remove_insecure_styles(var_input rt.PhpVal) rt.PhpVal {
	mut var_input_mutated := var_input
}

fn Class_WP_Theme_JSON.is_safe_css_declaration(var_property_name rt.PhpVal, var_property_value rt.PhpVal) bool {
}

fn Class_WP_Theme_JSON.remove_indirect_properties(var_input rt.PhpVal, var_output rt.PhpVal)  {
	mut var_input_mutated := var_input
	mut var_output_mutated := var_output
}

fn (mut this Class_WP_Theme_JSON) get_raw_data() rt.PhpVal {
}

fn Class_WP_Theme_JSON.get_from_editor_settings(var_settings rt.PhpVal) rt.PhpVal {
	mut var_settings_mutated := var_settings
}

fn (mut this Class_WP_Theme_JSON) get_patterns() rt.PhpVal {
}

fn (mut this Class_WP_Theme_JSON) get_data() rt.PhpVal {
}

fn (mut this Class_WP_Theme_JSON) set_spacing_sizes() rt.PhpVal {
	return rt.new_null()
}

fn Class_WP_Theme_JSON.merge_spacing_sizes(var_base rt.PhpVal, var_incoming rt.PhpVal) rt.PhpVal {
}

fn Class_WP_Theme_JSON.compute_spacing_sizes(var_spacing_scale rt.PhpVal) rt.PhpVal {
	mut var_spacing_scale_mutated := var_spacing_scale
}

fn Class_WP_Theme_JSON.convert_custom_properties(var_value rt.PhpVal) rt.PhpVal {
	mut var_value_mutated := var_value
}

fn Class_WP_Theme_JSON.resolve_custom_css_format(var_tree rt.PhpVal) rt.PhpVal {
	mut var_tree_mutated := var_tree
}

fn Class_WP_Theme_JSON.get_block_selectors(var_block_type rt.PhpVal, var_root_selector rt.PhpVal) rt.PhpVal {
	mut var_block_type_mutated := var_block_type
	mut var_root_selector_mutated := var_root_selector
}

fn Class_WP_Theme_JSON.get_block_element_selectors(var_root_selector rt.PhpVal) rt.PhpVal {
	mut var_root_selector_mutated := var_root_selector
}

fn (mut this Class_WP_Theme_JSON) get_feature_declarations_for_node(var_metadata rt.PhpVal, var_node rt.PhpVal) rt.PhpVal {
	mut var_node_mutated := var_node
}

fn Class_WP_Theme_JSON.convert_variables_to_value(var_styles rt.PhpVal, var_values rt.PhpVal) rt.PhpVal {
	mut var_var_parts := []rt.PhpVal{}
	mut var_styles_mutated := var_styles
}

fn Class_WP_Theme_JSON.resolve_variables(var_theme_json rt.PhpVal) rt.PhpVal {
	mut var_theme_json_mutated := var_theme_json
}

fn Class_WP_Theme_JSON.get_block_style_variation_selector(var_variation_name rt.PhpVal, var_block_selector rt.PhpVal) rt.PhpVal {
}

fn Class_WP_Theme_JSON.get_valid_block_style_variations(var_blocks_metadata rt.PhpVal) rt.PhpVal {
	mut var_blocks_metadata_mutated := var_blocks_metadata
}

struct Class_WP_Theme_JSON_Schema {
	rt.PhpObjectBase
}

fn create_wp_theme_json(arg_0 rt.PhpVal, origin string) &Class_WP_Theme_JSON {
	mut obj := &Class_WP_Theme_JSON{
		PhpObjectBase: rt.PhpObjectBase{}
		theme_json: rt.new_null()
		blocks_metadata: rt.new_array()
	}
	obj.construct(arg_0, origin)
	return obj
}

fn create_wp_theme_json_schema() &Class_WP_Theme_JSON_Schema {
	mut obj := &Class_WP_Theme_JSON_Schema{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Theme_JSON) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'schema_in_root_and_per_origin' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WP_Theme_JSON.schema_in_root_and_per_origin(dispatch_arg_0)
		}
		'process_pseudo_selectors' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			return Class_WP_Theme_JSON.process_pseudo_selectors(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
		}
		'get_element_class_name' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WP_Theme_JSON.get_element_class_name(dispatch_arg_0)
		}
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			this.construct(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'unwrap_shared_block_style_variations' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_WP_Theme_JSON.unwrap_shared_block_style_variations(dispatch_arg_0, dispatch_arg_1)
		}
		'maybe_opt_in_into_settings' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WP_Theme_JSON.maybe_opt_in_into_settings(dispatch_arg_0)
		}
		'do_opt_in_into_settings' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			Class_WP_Theme_JSON.do_opt_in_into_settings(dispatch_arg_0)
			return rt.new_null()
		}
		'sanitize' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			return Class_WP_Theme_JSON.sanitize(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
		}
		'append_to_selector' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_string(Class_WP_Theme_JSON.append_to_selector(dispatch_arg_0, dispatch_arg_1))
		}
		'prepend_to_selector' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_string(Class_WP_Theme_JSON.prepend_to_selector(dispatch_arg_0, dispatch_arg_1))
		}
		'get_blocks_metadata' {
			return Class_WP_Theme_JSON.get_blocks_metadata()
		}
		'remove_keys_not_in_schema' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_WP_Theme_JSON.remove_keys_not_in_schema(dispatch_arg_0, dispatch_arg_1)
		}
		'get_settings' {
			return this.get_settings()
		}
		'get_stylesheet' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.get_stylesheet(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'process_blocks_custom_css' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_WP_Theme_JSON.process_blocks_custom_css(dispatch_arg_0, dispatch_arg_1)
		}
		'get_custom_css' {
			return this.get_custom_css()
		}
		'get_custom_templates' {
			return this.get_custom_templates()
		}
		'get_template_parts' {
			return this.get_template_parts()
		}
		'get_block_classes' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_block_classes(dispatch_arg_0)
		}
		'get_layout_styles' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.get_layout_styles(dispatch_arg_0, dispatch_arg_1)
		}
		'get_preset_classes' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.get_preset_classes(dispatch_arg_0, dispatch_arg_1)
		}
		'get_css_variables' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.get_css_variables(dispatch_arg_0, dispatch_arg_1)
		}
		'to_ruleset' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_string(Class_WP_Theme_JSON.to_ruleset(dispatch_arg_0, dispatch_arg_1))
		}
		'compute_preset_classes' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return Class_WP_Theme_JSON.compute_preset_classes(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'scope_selector' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_WP_Theme_JSON.scope_selector(dispatch_arg_0, dispatch_arg_1)
		}
		'scope_style_node_selectors' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_WP_Theme_JSON.scope_style_node_selectors(dispatch_arg_0, dispatch_arg_1)
		}
		'get_settings_values_by_slug' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return Class_WP_Theme_JSON.get_settings_values_by_slug(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'get_settings_slugs' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return Class_WP_Theme_JSON.get_settings_slugs(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'replace_slug_in_string' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_WP_Theme_JSON.replace_slug_in_string(dispatch_arg_0, dispatch_arg_1)
		}
		'compute_preset_vars' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_WP_Theme_JSON.compute_preset_vars(dispatch_arg_0, dispatch_arg_1)
		}
		'compute_theme_vars' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WP_Theme_JSON.compute_theme_vars(dispatch_arg_0)
		}
		'flatten_tree' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			return Class_WP_Theme_JSON.flatten_tree(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'compute_style_properties' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			dispatch_arg_4 := if args.len > 4 { args[4] } else { rt.new_null() }
			dispatch_arg_5 := if args.len > 5 { args[5] } else { rt.new_null() }
			return Class_WP_Theme_JSON.compute_style_properties(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3, dispatch_arg_4, dispatch_arg_5)
		}
		'get_property_value' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return Class_WP_Theme_JSON.get_property_value(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'get_setting_nodes' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_WP_Theme_JSON.get_setting_nodes(dispatch_arg_0, dispatch_arg_1)
		}
		'get_style_nodes' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return Class_WP_Theme_JSON.get_style_nodes(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'get_styles_block_nodes' {
			return this.get_styles_block_nodes()
		}
		'update_separator_declarations' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WP_Theme_JSON.update_separator_declarations(dispatch_arg_0)
		}
		'update_paragraph_text_indent_selector' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return Class_WP_Theme_JSON.update_paragraph_text_indent_selector(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'get_block_nodes' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return Class_WP_Theme_JSON.get_block_nodes(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'get_styles_for_block' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_styles_for_block(dispatch_arg_0)
		}
		'get_root_layout_rules' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.get_root_layout_rules(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'get_metadata_boolean' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
			return Class_WP_Theme_JSON.get_metadata_boolean(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'merge' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.merge(dispatch_arg_0)
			return rt.new_null()
		}
		'get_svg_filters' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_svg_filters(dispatch_arg_0)
		}
		'should_override_preset' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return Class_WP_Theme_JSON.should_override_preset(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'get_default_slugs' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_WP_Theme_JSON.get_default_slugs(dispatch_arg_0, dispatch_arg_1)
		}
		'get_name_from_defaults' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.get_name_from_defaults(dispatch_arg_0, dispatch_arg_1)
		}
		'filter_slugs' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_WP_Theme_JSON.filter_slugs(dispatch_arg_0, dispatch_arg_1)
		}
		'remove_insecure_properties' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return Class_WP_Theme_JSON.remove_insecure_properties(dispatch_arg_0, dispatch_arg_1)
		}
		'remove_insecure_element_styles' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WP_Theme_JSON.remove_insecure_element_styles(dispatch_arg_0)
		}
		'remove_insecure_inner_block_styles' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WP_Theme_JSON.remove_insecure_inner_block_styles(dispatch_arg_0)
		}
		'preserve_valid_typed_settings' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			Class_WP_Theme_JSON.preserve_valid_typed_settings(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
			return rt.new_null()
		}
		'remove_insecure_settings' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WP_Theme_JSON.remove_insecure_settings(dispatch_arg_0)
		}
		'remove_insecure_styles' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WP_Theme_JSON.remove_insecure_styles(dispatch_arg_0)
		}
		'is_safe_css_declaration' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(Class_WP_Theme_JSON.is_safe_css_declaration(dispatch_arg_0, dispatch_arg_1))
		}
		'remove_indirect_properties' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			Class_WP_Theme_JSON.remove_indirect_properties(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'get_raw_data' {
			return this.get_raw_data()
		}
		'get_from_editor_settings' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WP_Theme_JSON.get_from_editor_settings(dispatch_arg_0)
		}
		'get_patterns' {
			return this.get_patterns()
		}
		'get_data' {
			return this.get_data()
		}
		'set_spacing_sizes' {
			return this.set_spacing_sizes()
		}
		'merge_spacing_sizes' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_WP_Theme_JSON.merge_spacing_sizes(dispatch_arg_0, dispatch_arg_1)
		}
		'compute_spacing_sizes' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WP_Theme_JSON.compute_spacing_sizes(dispatch_arg_0)
		}
		'convert_custom_properties' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WP_Theme_JSON.convert_custom_properties(dispatch_arg_0)
		}
		'resolve_custom_css_format' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WP_Theme_JSON.resolve_custom_css_format(dispatch_arg_0)
		}
		'get_block_selectors' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_WP_Theme_JSON.get_block_selectors(dispatch_arg_0, dispatch_arg_1)
		}
		'get_block_element_selectors' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WP_Theme_JSON.get_block_element_selectors(dispatch_arg_0)
		}
		'get_feature_declarations_for_node' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.get_feature_declarations_for_node(dispatch_arg_0, dispatch_arg_1)
		}
		'convert_variables_to_value' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_WP_Theme_JSON.convert_variables_to_value(dispatch_arg_0, dispatch_arg_1)
		}
		'resolve_variables' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WP_Theme_JSON.resolve_variables(dispatch_arg_0)
		}
		'get_block_style_variation_selector' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_WP_Theme_JSON.get_block_style_variation_selector(dispatch_arg_0, dispatch_arg_1)
		}
		'get_valid_block_style_variations' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WP_Theme_JSON.get_valid_block_style_variations(dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_WP_Theme_JSON) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'theme_json' { return this.theme_json }
		'blocks_metadata' { return this.blocks_metadata }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_Theme_JSON) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'theme_json' { this.theme_json = val; return true }
		'blocks_metadata' { this.blocks_metadata = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_WP_Theme_JSON_Schema) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Theme_JSON_Schema) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Theme_JSON_Schema) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_includes_class_wp_theme_json_php() {
}
