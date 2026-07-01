import rt

pub fn init_wp_includes_blocks_blocks_json_php() {
	return rt.create_array([
		rt.ArrayItem{ key: 'accordion', val: rt.create_array([
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: 'name', val: 'core/accordion' },
			rt.ArrayItem{ key: 'title', val: 'Accordion' },
			rt.ArrayItem{ key: 'category', val: 'design' },
			rt.ArrayItem{
				key: 'description'
				val: 'Displays a foldable layout that groups content in collapsible sections.'
			},
			rt.ArrayItem{ key: 'example', val: rt.new_array() },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'anchor', val: true },
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'align', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'wide' },
					rt.ArrayItem{ key: none, val: 'full' },
				]) },
				rt.ArrayItem{ key: 'background', val: rt.create_array([
					rt.ArrayItem{ key: 'backgroundImage', val: true },
					rt.ArrayItem{ key: 'backgroundSize', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'backgroundImage', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'color', val: rt.create_array([
					rt.ArrayItem{ key: 'background', val: true },
					rt.ArrayItem{ key: 'gradients', val: true },
				]) },
				rt.ArrayItem{ key: '__experimentalBorder', val: rt.create_array([
					rt.ArrayItem{ key: 'color', val: true },
					rt.ArrayItem{ key: 'radius', val: true },
					rt.ArrayItem{ key: 'style', val: true },
					rt.ArrayItem{ key: 'width', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'color', val: true },
						rt.ArrayItem{ key: 'radius', val: true },
						rt.ArrayItem{ key: 'style', val: true },
						rt.ArrayItem{ key: 'width', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'spacing', val: rt.create_array([
					rt.ArrayItem{ key: 'padding', val: true },
					rt.ArrayItem{ key: 'margin', val: rt.create_array([
						rt.ArrayItem{ key: none, val: 'top' },
						rt.ArrayItem{ key: none, val: 'bottom' },
					]) },
					rt.ArrayItem{ key: 'blockGap', val: true },
				]) },
				rt.ArrayItem{ key: 'shadow', val: true },
				rt.ArrayItem{ key: 'layout', val: true },
				rt.ArrayItem{ key: 'ariaLabel', val: true },
				rt.ArrayItem{ key: 'interactivity', val: true },
				rt.ArrayItem{ key: 'typography', val: rt.create_array([
					rt.ArrayItem{ key: 'fontSize', val: true },
					rt.ArrayItem{ key: 'lineHeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontFamily', val: true },
					rt.ArrayItem{ key: '__experimentalFontWeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontStyle', val: true },
					rt.ArrayItem{ key: '__experimentalTextTransform', val: true },
					rt.ArrayItem{ key: '__experimentalTextDecoration', val: true },
					rt.ArrayItem{ key: '__experimentalLetterSpacing', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'fontSize', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'contentRole', val: true },
				rt.ArrayItem{ key: 'listView', val: true },
			]) },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'iconPosition', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: 'right' },
				]) },
				rt.ArrayItem{ key: 'showIcon', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: true },
				]) },
				rt.ArrayItem{ key: 'autoclose', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: false },
				]) },
				rt.ArrayItem{ key: 'headingLevel', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'number' },
					rt.ArrayItem{ key: 'default', val: 3 },
				]) },
				rt.ArrayItem{ key: 'levelOptions', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'array' },
				]) },
			]) },
			rt.ArrayItem{ key: 'providesContext', val: rt.create_array([
				rt.ArrayItem{ key: 'core/accordion-icon-position', val: 'iconPosition' },
				rt.ArrayItem{ key: 'core/accordion-show-icon', val: 'showIcon' },
				rt.ArrayItem{ key: 'core/accordion-heading-level', val: 'headingLevel' },
			]) },
			rt.ArrayItem{ key: 'allowedBlocks', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'core/accordion-item' },
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'default' },
			rt.ArrayItem{ key: 'viewScriptModule', val: '@wordpress/block-library/accordion/view' },
		]) },
		rt.ArrayItem{ key: 'accordion-heading', val: rt.create_array([
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: 'name', val: 'core/accordion-heading' },
			rt.ArrayItem{ key: 'title', val: 'Accordion Heading' },
			rt.ArrayItem{ key: 'category', val: 'design' },
			rt.ArrayItem{
				key: 'description'
				val: 'Displays a heading that toggles the accordion panel.'
			},
			rt.ArrayItem{ key: 'parent', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'core/accordion-item' },
			]) },
			rt.ArrayItem{ key: 'usesContext', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'core/accordion-icon-position' },
				rt.ArrayItem{ key: none, val: 'core/accordion-show-icon' },
				rt.ArrayItem{ key: none, val: 'core/accordion-heading-level' },
			]) },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'anchor', val: true },
				rt.ArrayItem{ key: 'color', val: rt.create_array([
					rt.ArrayItem{ key: 'background', val: true },
					rt.ArrayItem{ key: 'gradients', val: true },
				]) },
				rt.ArrayItem{ key: 'align', val: false },
				rt.ArrayItem{ key: 'interactivity', val: true },
				rt.ArrayItem{ key: 'spacing', val: rt.create_array([
					rt.ArrayItem{ key: 'padding', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'padding', val: true },
					]) },
					rt.ArrayItem{ key: '__experimentalSkipSerialization', val: true },
					rt.ArrayItem{
						key: '__experimentalSelector'
						val: '.wp-block-accordion-heading__toggle'
					},
				]) },
				rt.ArrayItem{ key: '__experimentalBorder', val: rt.create_array([
					rt.ArrayItem{ key: 'color', val: true },
					rt.ArrayItem{ key: 'radius', val: true },
					rt.ArrayItem{ key: 'style', val: true },
					rt.ArrayItem{ key: 'width', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'color', val: true },
						rt.ArrayItem{ key: 'radius', val: true },
						rt.ArrayItem{ key: 'style', val: true },
						rt.ArrayItem{ key: 'width', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'typography', val: rt.create_array([
					rt.ArrayItem{ key: '__experimentalSkipSerialization', val: rt.create_array([
						rt.ArrayItem{ key: none, val: 'textDecoration' },
						rt.ArrayItem{ key: none, val: 'letterSpacing' },
					]) },
					rt.ArrayItem{ key: 'fontSize', val: true },
					rt.ArrayItem{ key: '__experimentalFontFamily', val: true },
					rt.ArrayItem{ key: '__experimentalFontWeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontStyle', val: true },
					rt.ArrayItem{ key: '__experimentalTextTransform', val: true },
					rt.ArrayItem{ key: '__experimentalTextDecoration', val: true },
					rt.ArrayItem{ key: '__experimentalLetterSpacing', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'fontSize', val: true },
						rt.ArrayItem{ key: 'fontFamily', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'shadow', val: true },
				rt.ArrayItem{ key: 'visibility', val: false },
				rt.ArrayItem{ key: 'lock', val: false },
			]) },
			rt.ArrayItem{ key: 'selectors', val: rt.create_array([
				rt.ArrayItem{ key: 'typography', val: rt.create_array([
					rt.ArrayItem{
						key: 'letterSpacing'
						val: '.wp-block-accordion-heading .wp-block-accordion-heading__toggle-title'
					},
					rt.ArrayItem{
						key: 'textDecoration'
						val: '.wp-block-accordion-heading .wp-block-accordion-heading__toggle-title'
					},
				]) },
			]) },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'openByDefault', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: false },
				]) },
				rt.ArrayItem{ key: 'title', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'rich-text' },
					rt.ArrayItem{ key: 'source', val: 'rich-text' },
					rt.ArrayItem{ key: 'selector', val: '.wp-block-accordion-heading__toggle-title' },
					rt.ArrayItem{ key: 'role', val: 'content' },
				]) },
				rt.ArrayItem{ key: 'level', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'number' },
				]) },
				rt.ArrayItem{ key: 'iconPosition', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'enum', val: rt.create_array([
						rt.ArrayItem{ key: none, val: 'left' },
						rt.ArrayItem{ key: none, val: 'right' },
					]) },
					rt.ArrayItem{ key: 'default', val: 'right' },
				]) },
				rt.ArrayItem{ key: 'showIcon', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: true },
				]) },
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'default' },
		]) },
		rt.ArrayItem{ key: 'accordion-item', val: rt.create_array([
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: 'name', val: 'core/accordion-item' },
			rt.ArrayItem{ key: 'title', val: 'Accordion Item' },
			rt.ArrayItem{ key: 'category', val: 'design' },
			rt.ArrayItem{ key: 'description', val: 'Wraps the heading and panel in one unit.' },
			rt.ArrayItem{ key: 'parent', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'core/accordion' },
			]) },
			rt.ArrayItem{ key: 'allowedBlocks', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'core/accordion-heading' },
				rt.ArrayItem{ key: none, val: 'core/accordion-panel' },
			]) },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'color', val: rt.create_array([
					rt.ArrayItem{ key: 'background', val: true },
					rt.ArrayItem{ key: 'gradients', val: true },
				]) },
				rt.ArrayItem{ key: 'interactivity', val: true },
				rt.ArrayItem{ key: 'spacing', val: rt.create_array([
					rt.ArrayItem{ key: 'margin', val: rt.create_array([
						rt.ArrayItem{ key: none, val: 'top' },
						rt.ArrayItem{ key: none, val: 'bottom' },
					]) },
					rt.ArrayItem{ key: 'blockGap', val: true },
				]) },
				rt.ArrayItem{ key: '__experimentalBorder', val: rt.create_array([
					rt.ArrayItem{ key: 'color', val: true },
					rt.ArrayItem{ key: 'radius', val: true },
					rt.ArrayItem{ key: 'style', val: true },
					rt.ArrayItem{ key: 'width', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'color', val: true },
						rt.ArrayItem{ key: 'radius', val: true },
						rt.ArrayItem{ key: 'style', val: true },
						rt.ArrayItem{ key: 'width', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'shadow', val: true },
				rt.ArrayItem{ key: 'layout', val: rt.create_array([
					rt.ArrayItem{ key: 'allowEditing', val: false },
				]) },
				rt.ArrayItem{ key: 'typography', val: rt.create_array([
					rt.ArrayItem{ key: 'fontSize', val: true },
					rt.ArrayItem{ key: 'lineHeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontFamily', val: true },
					rt.ArrayItem{ key: '__experimentalFontWeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontStyle', val: true },
					rt.ArrayItem{ key: '__experimentalTextTransform', val: true },
					rt.ArrayItem{ key: '__experimentalTextDecoration', val: true },
					rt.ArrayItem{ key: '__experimentalLetterSpacing', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'fontSize', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'contentRole', val: true },
			]) },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'openByDefault', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: false },
				]) },
			]) },
			rt.ArrayItem{ key: 'providesContext', val: rt.create_array([
				rt.ArrayItem{ key: 'core/accordion-open-by-default', val: 'openByDefault' },
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'default' },
			rt.ArrayItem{ key: 'style', val: 'wp-block-accordion-item' },
		]) },
		rt.ArrayItem{ key: 'accordion-panel', val: rt.create_array([
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: 'name', val: 'core/accordion-panel' },
			rt.ArrayItem{ key: 'title', val: 'Accordion Panel' },
			rt.ArrayItem{ key: 'category', val: 'design' },
			rt.ArrayItem{
				key: 'description'
				val: 'Contains the hidden or revealed content beneath the heading.'
			},
			rt.ArrayItem{ key: 'parent', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'core/accordion-item' },
			]) },
			rt.ArrayItem{ key: 'usesContext', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'core/accordion-open-by-default' },
			]) },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'color', val: rt.create_array([
					rt.ArrayItem{ key: 'background', val: true },
					rt.ArrayItem{ key: 'gradients', val: true },
				]) },
				rt.ArrayItem{ key: 'interactivity', val: true },
				rt.ArrayItem{ key: 'spacing', val: rt.create_array([
					rt.ArrayItem{ key: 'padding', val: true },
					rt.ArrayItem{ key: 'blockGap', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'padding', val: true },
						rt.ArrayItem{ key: 'blockGap', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: '__experimentalBorder', val: rt.create_array([
					rt.ArrayItem{ key: 'color', val: true },
					rt.ArrayItem{ key: 'radius', val: true },
					rt.ArrayItem{ key: 'style', val: true },
					rt.ArrayItem{ key: 'width', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'color', val: true },
						rt.ArrayItem{ key: 'radius', val: true },
						rt.ArrayItem{ key: 'style', val: true },
						rt.ArrayItem{ key: 'width', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'typography', val: rt.create_array([
					rt.ArrayItem{ key: 'fontSize', val: true },
					rt.ArrayItem{ key: 'lineHeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontFamily', val: true },
					rt.ArrayItem{ key: '__experimentalFontWeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontStyle', val: true },
					rt.ArrayItem{ key: '__experimentalTextTransform', val: true },
					rt.ArrayItem{ key: '__experimentalTextDecoration', val: true },
					rt.ArrayItem{ key: '__experimentalLetterSpacing', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'fontSize', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'shadow', val: true },
				rt.ArrayItem{ key: 'layout', val: rt.create_array([
					rt.ArrayItem{ key: 'allowEditing', val: false },
				]) },
				rt.ArrayItem{ key: 'visibility', val: false },
				rt.ArrayItem{ key: 'contentRole', val: true },
				rt.ArrayItem{ key: 'allowedBlocks', val: true },
				rt.ArrayItem{ key: 'lock', val: false },
			]) },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'templateLock', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: rt.create_array([
						rt.ArrayItem{ key: none, val: 'string' },
						rt.ArrayItem{ key: none, val: 'boolean' },
					]) },
					rt.ArrayItem{ key: 'enum', val: rt.create_array([
						rt.ArrayItem{ key: none, val: 'all' },
						rt.ArrayItem{ key: none, val: 'insert' },
						rt.ArrayItem{ key: none, val: 'contentOnly' },
						rt.ArrayItem{ key: none, val: false },
					]) },
					rt.ArrayItem{ key: 'default', val: false },
				]) },
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'default' },
			rt.ArrayItem{ key: 'style', val: 'wp-block-accordion-panel' },
		]) },
		rt.ArrayItem{ key: 'archives', val: rt.create_array([
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: 'name', val: 'core/archives' },
			rt.ArrayItem{ key: 'title', val: 'Archives' },
			rt.ArrayItem{ key: 'category', val: 'widgets' },
			rt.ArrayItem{ key: 'description', val: 'Display a date archive of your posts.' },
			rt.ArrayItem{ key: 'textdomain', val: 'default' },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'displayAsDropdown', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: false },
				]) },
				rt.ArrayItem{ key: 'showLabel', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: true },
				]) },
				rt.ArrayItem{ key: 'showPostCounts', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: false },
				]) },
				rt.ArrayItem{ key: 'type', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: 'monthly' },
				]) },
			]) },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'anchor', val: true },
				rt.ArrayItem{ key: 'align', val: true },
				rt.ArrayItem{ key: '__experimentalBorder', val: rt.create_array([
					rt.ArrayItem{ key: 'radius', val: true },
					rt.ArrayItem{ key: 'color', val: true },
					rt.ArrayItem{ key: 'width', val: true },
					rt.ArrayItem{ key: 'style', val: true },
				]) },
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'spacing', val: rt.create_array([
					rt.ArrayItem{ key: 'margin', val: true },
					rt.ArrayItem{ key: 'padding', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'margin', val: false },
						rt.ArrayItem{ key: 'padding', val: false },
					]) },
				]) },
				rt.ArrayItem{ key: 'typography', val: rt.create_array([
					rt.ArrayItem{ key: 'fontSize', val: true },
					rt.ArrayItem{ key: 'lineHeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontFamily', val: true },
					rt.ArrayItem{ key: '__experimentalFontWeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontStyle', val: true },
					rt.ArrayItem{ key: '__experimentalTextTransform', val: true },
					rt.ArrayItem{ key: '__experimentalTextDecoration', val: true },
					rt.ArrayItem{ key: '__experimentalLetterSpacing', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'fontSize', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'color', val: rt.create_array([
					rt.ArrayItem{ key: 'gradients', val: true },
					rt.ArrayItem{ key: 'link', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'background', val: true },
						rt.ArrayItem{ key: 'text', val: true },
						rt.ArrayItem{ key: 'link', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'interactivity', val: rt.create_array([
					rt.ArrayItem{ key: 'clientNavigation', val: true },
				]) },
			]) },
		]) },
		rt.ArrayItem{ key: 'audio', val: rt.create_array([
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: 'name', val: 'core/audio' },
			rt.ArrayItem{ key: 'title', val: 'Audio' },
			rt.ArrayItem{ key: 'category', val: 'media' },
			rt.ArrayItem{ key: 'description', val: 'Embed a simple audio player.' },
			rt.ArrayItem{ key: 'keywords', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'music' },
				rt.ArrayItem{ key: none, val: 'sound' },
				rt.ArrayItem{ key: none, val: 'podcast' },
				rt.ArrayItem{ key: none, val: 'recording' },
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'default' },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'blob', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'role', val: 'local' },
				]) },
				rt.ArrayItem{ key: 'src', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'source', val: 'attribute' },
					rt.ArrayItem{ key: 'selector', val: 'audio' },
					rt.ArrayItem{ key: 'attribute', val: 'src' },
					rt.ArrayItem{ key: 'role', val: 'content' },
				]) },
				rt.ArrayItem{ key: 'caption', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'rich-text' },
					rt.ArrayItem{ key: 'source', val: 'rich-text' },
					rt.ArrayItem{ key: 'selector', val: 'figcaption' },
					rt.ArrayItem{ key: 'role', val: 'content' },
				]) },
				rt.ArrayItem{ key: 'id', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'number' },
					rt.ArrayItem{ key: 'role', val: 'content' },
				]) },
				rt.ArrayItem{ key: 'autoplay', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'source', val: 'attribute' },
					rt.ArrayItem{ key: 'selector', val: 'audio' },
					rt.ArrayItem{ key: 'attribute', val: 'autoplay' },
				]) },
				rt.ArrayItem{ key: 'loop', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'source', val: 'attribute' },
					rt.ArrayItem{ key: 'selector', val: 'audio' },
					rt.ArrayItem{ key: 'attribute', val: 'loop' },
				]) },
				rt.ArrayItem{ key: 'preload', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'source', val: 'attribute' },
					rt.ArrayItem{ key: 'selector', val: 'audio' },
					rt.ArrayItem{ key: 'attribute', val: 'preload' },
				]) },
			]) },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'anchor', val: true },
				rt.ArrayItem{ key: 'align', val: true },
				rt.ArrayItem{ key: 'spacing', val: rt.create_array([
					rt.ArrayItem{ key: 'margin', val: true },
					rt.ArrayItem{ key: 'padding', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'margin', val: false },
						rt.ArrayItem{ key: 'padding', val: false },
					]) },
				]) },
				rt.ArrayItem{ key: 'interactivity', val: rt.create_array([
					rt.ArrayItem{ key: 'clientNavigation', val: true },
				]) },
			]) },
			rt.ArrayItem{ key: 'editorStyle', val: 'wp-block-audio-editor' },
			rt.ArrayItem{ key: 'style', val: 'wp-block-audio' },
		]) },
		rt.ArrayItem{ key: 'avatar', val: rt.create_array([
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: 'name', val: 'core/avatar' },
			rt.ArrayItem{ key: 'title', val: 'Avatar' },
			rt.ArrayItem{ key: 'category', val: 'theme' },
			rt.ArrayItem{ key: 'description', val: 'Add a user’s avatar.' },
			rt.ArrayItem{ key: 'textdomain', val: 'default' },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'userId', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'number' },
				]) },
				rt.ArrayItem{ key: 'size', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'number' },
					rt.ArrayItem{ key: 'default', val: 96 },
				]) },
				rt.ArrayItem{ key: 'isLink', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: false },
				]) },
				rt.ArrayItem{ key: 'linkTarget', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: '_self' },
				]) },
			]) },
			rt.ArrayItem{ key: 'usesContext', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'postType' },
				rt.ArrayItem{ key: none, val: 'postId' },
				rt.ArrayItem{ key: none, val: 'commentId' },
			]) },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'anchor', val: true },
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'align', val: true },
				rt.ArrayItem{ key: 'alignWide', val: false },
				rt.ArrayItem{ key: 'spacing', val: rt.create_array([
					rt.ArrayItem{ key: 'margin', val: true },
					rt.ArrayItem{ key: 'padding', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'margin', val: false },
						rt.ArrayItem{ key: 'padding', val: false },
					]) },
				]) },
				rt.ArrayItem{ key: '__experimentalBorder', val: rt.create_array([
					rt.ArrayItem{ key: '__experimentalSkipSerialization', val: true },
					rt.ArrayItem{ key: 'radius', val: true },
					rt.ArrayItem{ key: 'width', val: true },
					rt.ArrayItem{ key: 'color', val: true },
					rt.ArrayItem{ key: 'style', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'radius', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'color', val: rt.create_array([
					rt.ArrayItem{ key: 'text', val: false },
					rt.ArrayItem{ key: 'background', val: false },
				]) },
				rt.ArrayItem{ key: 'filter', val: rt.create_array([
					rt.ArrayItem{ key: 'duotone', val: true },
				]) },
				rt.ArrayItem{ key: 'interactivity', val: rt.create_array([
					rt.ArrayItem{ key: 'clientNavigation', val: true },
				]) },
			]) },
			rt.ArrayItem{ key: 'selectors', val: rt.create_array([
				rt.ArrayItem{ key: 'border', val: '.wp-block-avatar img' },
				rt.ArrayItem{ key: 'filter', val: rt.create_array([
					rt.ArrayItem{ key: 'duotone', val: '.wp-block-avatar img' },
				]) },
			]) },
			rt.ArrayItem{ key: 'editorStyle', val: 'wp-block-avatar-editor' },
			rt.ArrayItem{ key: 'style', val: 'wp-block-avatar' },
		]) },
		rt.ArrayItem{ key: 'block', val: rt.create_array([
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: 'name', val: 'core/block' },
			rt.ArrayItem{ key: 'title', val: 'Pattern' },
			rt.ArrayItem{ key: 'category', val: 'reusable' },
			rt.ArrayItem{ key: 'description', val: 'Reuse this design across your site.' },
			rt.ArrayItem{ key: 'keywords', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'reusable' },
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'default' },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'ref', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'number' },
				]) },
				rt.ArrayItem{ key: 'content', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'object' },
					rt.ArrayItem{ key: 'default', val: rt.new_array() },
				]) },
			]) },
			rt.ArrayItem{ key: 'providesContext', val: rt.create_array([
				rt.ArrayItem{ key: 'pattern/overrides', val: 'content' },
			]) },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'customClassName', val: false },
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'inserter', val: false },
				rt.ArrayItem{ key: 'renaming', val: false },
				rt.ArrayItem{ key: 'interactivity', val: rt.create_array([
					rt.ArrayItem{ key: 'clientNavigation', val: true },
				]) },
				rt.ArrayItem{ key: 'customCSS', val: false },
			]) },
		]) },
		rt.ArrayItem{ key: 'breadcrumbs', val: rt.create_array([
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: 'name', val: 'core/breadcrumbs' },
			rt.ArrayItem{ key: 'title', val: 'Breadcrumbs' },
			rt.ArrayItem{ key: 'category', val: 'theme' },
			rt.ArrayItem{
				key: 'description'
				val: 'Display a breadcrumb trail showing the path to the current page.'
			},
			rt.ArrayItem{ key: 'textdomain', val: 'default' },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'prefersTaxonomy', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: false },
				]) },
				rt.ArrayItem{ key: 'separator', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: '/' },
				]) },
				rt.ArrayItem{ key: 'showHomeItem', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: true },
				]) },
				rt.ArrayItem{ key: 'showCurrentItem', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: true },
				]) },
				rt.ArrayItem{ key: 'showOnHomePage', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: false },
				]) },
			]) },
			rt.ArrayItem{ key: 'usesContext', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'postId' },
				rt.ArrayItem{ key: none, val: 'postType' },
				rt.ArrayItem{ key: none, val: 'templateSlug' },
			]) },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'anchor', val: true },
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'align', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'wide' },
					rt.ArrayItem{ key: none, val: 'full' },
				]) },
				rt.ArrayItem{ key: 'spacing', val: rt.create_array([
					rt.ArrayItem{ key: 'margin', val: true },
					rt.ArrayItem{ key: 'padding', val: true },
				]) },
				rt.ArrayItem{ key: 'color', val: rt.create_array([
					rt.ArrayItem{ key: 'gradients', val: true },
					rt.ArrayItem{ key: 'link', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'background', val: true },
						rt.ArrayItem{ key: 'text', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: '__experimentalBorder', val: rt.create_array([
					rt.ArrayItem{ key: 'radius', val: true },
					rt.ArrayItem{ key: 'color', val: true },
					rt.ArrayItem{ key: 'width', val: true },
					rt.ArrayItem{ key: 'style', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'radius', val: false },
						rt.ArrayItem{ key: 'color', val: true },
						rt.ArrayItem{ key: 'width', val: true },
						rt.ArrayItem{ key: 'style', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'typography', val: rt.create_array([
					rt.ArrayItem{ key: 'fontSize', val: true },
					rt.ArrayItem{ key: 'lineHeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontFamily', val: true },
					rt.ArrayItem{ key: '__experimentalFontWeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontStyle', val: true },
					rt.ArrayItem{ key: '__experimentalTextTransform', val: true },
					rt.ArrayItem{ key: '__experimentalTextDecoration', val: true },
					rt.ArrayItem{ key: '__experimentalLetterSpacing', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'fontSize', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'interactivity', val: rt.create_array([
					rt.ArrayItem{ key: 'clientNavigation', val: true },
				]) },
			]) },
			rt.ArrayItem{ key: 'style', val: 'wp-block-breadcrumbs' },
		]) },
		rt.ArrayItem{ key: 'button', val: rt.create_array([
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: 'name', val: 'core/button' },
			rt.ArrayItem{ key: 'title', val: 'Button' },
			rt.ArrayItem{ key: 'category', val: 'design' },
			rt.ArrayItem{ key: 'parent', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'core/buttons' },
			]) },
			rt.ArrayItem{
				key: 'description'
				val: 'Prompt visitors to take action with a button-style link.'
			},
			rt.ArrayItem{ key: 'keywords', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'link' },
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'default' },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'tagName', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'enum', val: rt.create_array([
						rt.ArrayItem{ key: none, val: 'a' },
						rt.ArrayItem{ key: none, val: 'button' },
					]) },
					rt.ArrayItem{ key: 'default', val: 'a' },
				]) },
				rt.ArrayItem{ key: 'type', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: 'button' },
				]) },
				rt.ArrayItem{ key: 'url', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'source', val: 'attribute' },
					rt.ArrayItem{ key: 'selector', val: 'a' },
					rt.ArrayItem{ key: 'attribute', val: 'href' },
					rt.ArrayItem{ key: 'role', val: 'content' },
				]) },
				rt.ArrayItem{ key: 'title', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'source', val: 'attribute' },
					rt.ArrayItem{ key: 'selector', val: 'a,button' },
					rt.ArrayItem{ key: 'attribute', val: 'title' },
					rt.ArrayItem{ key: 'role', val: 'content' },
				]) },
				rt.ArrayItem{ key: 'text', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'rich-text' },
					rt.ArrayItem{ key: 'source', val: 'rich-text' },
					rt.ArrayItem{ key: 'selector', val: 'a,button' },
					rt.ArrayItem{ key: 'role', val: 'content' },
				]) },
				rt.ArrayItem{ key: 'linkTarget', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'source', val: 'attribute' },
					rt.ArrayItem{ key: 'selector', val: 'a' },
					rt.ArrayItem{ key: 'attribute', val: 'target' },
					rt.ArrayItem{ key: 'role', val: 'content' },
				]) },
				rt.ArrayItem{ key: 'rel', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'source', val: 'attribute' },
					rt.ArrayItem{ key: 'selector', val: 'a' },
					rt.ArrayItem{ key: 'attribute', val: 'rel' },
					rt.ArrayItem{ key: 'role', val: 'content' },
				]) },
				rt.ArrayItem{ key: 'placeholder', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
				rt.ArrayItem{ key: 'backgroundColor', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
				rt.ArrayItem{ key: 'textColor', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
				rt.ArrayItem{ key: 'gradient', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
				rt.ArrayItem{ key: 'width', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'number' },
				]) },
			]) },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'anchor', val: true },
				rt.ArrayItem{ key: 'splitting', val: true },
				rt.ArrayItem{ key: 'align', val: false },
				rt.ArrayItem{ key: 'alignWide', val: false },
				rt.ArrayItem{ key: 'color', val: rt.create_array([
					rt.ArrayItem{ key: '__experimentalSkipSerialization', val: true },
					rt.ArrayItem{ key: 'gradients', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'background', val: true },
						rt.ArrayItem{ key: 'text', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'typography', val: rt.create_array([
					rt.ArrayItem{ key: '__experimentalSkipSerialization', val: rt.create_array([
						rt.ArrayItem{ key: none, val: 'fontSize' },
						rt.ArrayItem{ key: none, val: 'lineHeight' },
						rt.ArrayItem{ key: none, val: 'textAlign' },
						rt.ArrayItem{ key: none, val: 'fontFamily' },
						rt.ArrayItem{ key: none, val: 'fontWeight' },
						rt.ArrayItem{ key: none, val: 'fontStyle' },
						rt.ArrayItem{ key: none, val: 'textTransform' },
						rt.ArrayItem{ key: none, val: 'textDecoration' },
						rt.ArrayItem{ key: none, val: 'letterSpacing' },
					]) },
					rt.ArrayItem{ key: 'fontSize', val: true },
					rt.ArrayItem{ key: 'lineHeight', val: true },
					rt.ArrayItem{ key: 'textAlign', val: true },
					rt.ArrayItem{ key: '__experimentalFontFamily', val: true },
					rt.ArrayItem{ key: '__experimentalFontWeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontStyle', val: true },
					rt.ArrayItem{ key: '__experimentalTextTransform', val: true },
					rt.ArrayItem{ key: '__experimentalTextDecoration', val: true },
					rt.ArrayItem{ key: '__experimentalLetterSpacing', val: true },
					rt.ArrayItem{ key: '__experimentalWritingMode', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'fontSize', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'reusable', val: false },
				rt.ArrayItem{ key: 'shadow', val: rt.create_array([
					rt.ArrayItem{ key: '__experimentalSkipSerialization', val: true },
				]) },
				rt.ArrayItem{ key: 'spacing', val: rt.create_array([
					rt.ArrayItem{ key: '__experimentalSkipSerialization', val: true },
					rt.ArrayItem{ key: 'padding', val: rt.create_array([
						rt.ArrayItem{ key: none, val: 'horizontal' },
						rt.ArrayItem{ key: none, val: 'vertical' },
					]) },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'padding', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: '__experimentalBorder', val: rt.create_array([
					rt.ArrayItem{ key: 'color', val: true },
					rt.ArrayItem{ key: 'radius', val: true },
					rt.ArrayItem{ key: 'style', val: true },
					rt.ArrayItem{ key: 'width', val: true },
					rt.ArrayItem{ key: '__experimentalSkipSerialization', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'color', val: true },
						rt.ArrayItem{ key: 'radius', val: true },
						rt.ArrayItem{ key: 'style', val: true },
						rt.ArrayItem{ key: 'width', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'interactivity', val: rt.create_array([
					rt.ArrayItem{ key: 'clientNavigation', val: true },
				]) },
			]) },
			rt.ArrayItem{ key: 'styles', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.create_array([
					rt.ArrayItem{ key: 'name', val: 'fill' },
					rt.ArrayItem{ key: 'label', val: 'Fill' },
					rt.ArrayItem{ key: 'isDefault', val: true },
				]) },
				rt.ArrayItem{ key: none, val: rt.create_array([
					rt.ArrayItem{ key: 'name', val: 'outline' },
					rt.ArrayItem{ key: 'label', val: 'Outline' },
				]) },
			]) },
			rt.ArrayItem{ key: 'editorStyle', val: 'wp-block-button-editor' },
			rt.ArrayItem{ key: 'style', val: 'wp-block-button' },
			rt.ArrayItem{ key: 'selectors', val: rt.create_array([
				rt.ArrayItem{ key: 'root', val: '.wp-block-button .wp-block-button__link' },
				rt.ArrayItem{ key: 'typography', val: rt.create_array([
					rt.ArrayItem{ key: 'writingMode', val: '.wp-block-button' },
				]) },
			]) },
		]) },
		rt.ArrayItem{ key: 'buttons', val: rt.create_array([
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: 'name', val: 'core/buttons' },
			rt.ArrayItem{ key: 'title', val: 'Buttons' },
			rt.ArrayItem{ key: 'category', val: 'design' },
			rt.ArrayItem{ key: 'allowedBlocks', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'core/button' },
			]) },
			rt.ArrayItem{
				key: 'description'
				val: 'Prompt visitors to take action with a group of button-style links.'
			},
			rt.ArrayItem{ key: 'keywords', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'link' },
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'default' },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'anchor', val: true },
				rt.ArrayItem{ key: 'align', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'wide' },
					rt.ArrayItem{ key: none, val: 'full' },
				]) },
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: '__experimentalExposeControlsToChildren', val: true },
				rt.ArrayItem{ key: 'color', val: rt.create_array([
					rt.ArrayItem{ key: 'gradients', val: true },
					rt.ArrayItem{ key: 'text', val: false },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'background', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'spacing', val: rt.create_array([
					rt.ArrayItem{ key: 'blockGap', val: rt.create_array([
						rt.ArrayItem{ key: none, val: 'horizontal' },
						rt.ArrayItem{ key: none, val: 'vertical' },
					]) },
					rt.ArrayItem{ key: 'padding', val: true },
					rt.ArrayItem{ key: 'margin', val: rt.create_array([
						rt.ArrayItem{ key: none, val: 'top' },
						rt.ArrayItem{ key: none, val: 'bottom' },
					]) },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'blockGap', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'typography', val: rt.create_array([
					rt.ArrayItem{ key: 'fontSize', val: true },
					rt.ArrayItem{ key: 'lineHeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontFamily', val: true },
					rt.ArrayItem{ key: '__experimentalFontWeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontStyle', val: true },
					rt.ArrayItem{ key: '__experimentalTextTransform', val: true },
					rt.ArrayItem{ key: '__experimentalTextDecoration', val: true },
					rt.ArrayItem{ key: '__experimentalLetterSpacing', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'fontSize', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: '__experimentalBorder', val: rt.create_array([
					rt.ArrayItem{ key: 'color', val: true },
					rt.ArrayItem{ key: 'radius', val: true },
					rt.ArrayItem{ key: 'style', val: true },
					rt.ArrayItem{ key: 'width', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'color', val: true },
						rt.ArrayItem{ key: 'radius', val: true },
						rt.ArrayItem{ key: 'style', val: true },
						rt.ArrayItem{ key: 'width', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'layout', val: rt.create_array([
					rt.ArrayItem{ key: 'allowSwitching', val: false },
					rt.ArrayItem{ key: 'allowInheriting', val: false },
					rt.ArrayItem{ key: 'default', val: rt.create_array([
						rt.ArrayItem{ key: 'type', val: 'flex' },
					]) },
				]) },
				rt.ArrayItem{ key: 'interactivity', val: rt.create_array([
					rt.ArrayItem{ key: 'clientNavigation', val: true },
				]) },
				rt.ArrayItem{ key: 'listView', val: true },
				rt.ArrayItem{ key: 'contentRole', val: true },
			]) },
			rt.ArrayItem{ key: 'editorStyle', val: 'wp-block-buttons-editor' },
			rt.ArrayItem{ key: 'style', val: 'wp-block-buttons' },
		]) },
		rt.ArrayItem{ key: 'calendar', val: rt.create_array([
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: 'name', val: 'core/calendar' },
			rt.ArrayItem{ key: 'title', val: 'Calendar' },
			rt.ArrayItem{ key: 'category', val: 'widgets' },
			rt.ArrayItem{ key: 'description', val: 'A calendar of your site’s posts.' },
			rt.ArrayItem{ key: 'keywords', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'posts' },
				rt.ArrayItem{ key: none, val: 'archive' },
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'default' },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'month', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'integer' },
				]) },
				rt.ArrayItem{ key: 'year', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'integer' },
				]) },
			]) },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'anchor', val: true },
				rt.ArrayItem{ key: 'align', val: true },
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'color', val: rt.create_array([
					rt.ArrayItem{ key: 'link', val: true },
					rt.ArrayItem{ key: '__experimentalSkipSerialization', val: rt.create_array([
						rt.ArrayItem{ key: none, val: 'text' },
						rt.ArrayItem{ key: none, val: 'background' },
					]) },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'background', val: true },
						rt.ArrayItem{ key: 'text', val: true },
					]) },
					rt.ArrayItem{ key: '__experimentalSelector', val: 'table, th' },
				]) },
				rt.ArrayItem{ key: 'typography', val: rt.create_array([
					rt.ArrayItem{ key: 'fontSize', val: true },
					rt.ArrayItem{ key: 'lineHeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontFamily', val: true },
					rt.ArrayItem{ key: '__experimentalFontWeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontStyle', val: true },
					rt.ArrayItem{ key: '__experimentalTextTransform', val: true },
					rt.ArrayItem{ key: '__experimentalLetterSpacing', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'fontSize', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'interactivity', val: rt.create_array([
					rt.ArrayItem{ key: 'clientNavigation', val: true },
				]) },
			]) },
			rt.ArrayItem{ key: 'style', val: 'wp-block-calendar' },
		]) },
		rt.ArrayItem{ key: 'categories', val: rt.create_array([
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: 'name', val: 'core/categories' },
			rt.ArrayItem{ key: 'title', val: 'Terms List' },
			rt.ArrayItem{ key: 'category', val: 'widgets' },
			rt.ArrayItem{
				key: 'description'
				val: 'Display a list of all terms of a given taxonomy.'
			},
			rt.ArrayItem{ key: 'keywords', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'categories' },
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'default' },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'taxonomy', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: 'category' },
				]) },
				rt.ArrayItem{ key: 'displayAsDropdown', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: false },
				]) },
				rt.ArrayItem{ key: 'showHierarchy', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: false },
				]) },
				rt.ArrayItem{ key: 'showPostCounts', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: false },
				]) },
				rt.ArrayItem{ key: 'showOnlyTopLevel', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: false },
				]) },
				rt.ArrayItem{ key: 'showEmpty', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: false },
				]) },
				rt.ArrayItem{ key: 'label', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'role', val: 'content' },
				]) },
				rt.ArrayItem{ key: 'showLabel', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: true },
				]) },
			]) },
			rt.ArrayItem{ key: 'usesContext', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'enhancedPagination' },
			]) },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'anchor', val: true },
				rt.ArrayItem{ key: 'align', val: true },
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'spacing', val: rt.create_array([
					rt.ArrayItem{ key: 'margin', val: true },
					rt.ArrayItem{ key: 'padding', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'margin', val: false },
						rt.ArrayItem{ key: 'padding', val: false },
					]) },
				]) },
				rt.ArrayItem{ key: 'typography', val: rt.create_array([
					rt.ArrayItem{ key: 'fontSize', val: true },
					rt.ArrayItem{ key: 'lineHeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontFamily', val: true },
					rt.ArrayItem{ key: '__experimentalFontWeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontStyle', val: true },
					rt.ArrayItem{ key: '__experimentalTextTransform', val: true },
					rt.ArrayItem{ key: '__experimentalTextDecoration', val: true },
					rt.ArrayItem{ key: '__experimentalLetterSpacing', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'fontSize', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'color', val: rt.create_array([
					rt.ArrayItem{ key: 'gradients', val: true },
					rt.ArrayItem{ key: 'link', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'background', val: true },
						rt.ArrayItem{ key: 'text', val: true },
						rt.ArrayItem{ key: 'link', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'interactivity', val: rt.create_array([
					rt.ArrayItem{ key: 'clientNavigation', val: true },
				]) },
				rt.ArrayItem{ key: '__experimentalBorder', val: rt.create_array([
					rt.ArrayItem{ key: 'radius', val: true },
					rt.ArrayItem{ key: 'color', val: true },
					rt.ArrayItem{ key: 'width', val: true },
					rt.ArrayItem{ key: 'style', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'radius', val: true },
						rt.ArrayItem{ key: 'color', val: true },
						rt.ArrayItem{ key: 'width', val: true },
						rt.ArrayItem{ key: 'style', val: true },
					]) },
				]) },
			]) },
			rt.ArrayItem{ key: 'editorStyle', val: 'wp-block-categories-editor' },
			rt.ArrayItem{ key: 'style', val: 'wp-block-categories' },
		]) },
		rt.ArrayItem{ key: 'code', val: rt.create_array([
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: 'name', val: 'core/code' },
			rt.ArrayItem{ key: 'title', val: 'Code' },
			rt.ArrayItem{ key: 'category', val: 'text' },
			rt.ArrayItem{
				key: 'description'
				val: 'Display code snippets that respect your spacing and tabs.'
			},
			rt.ArrayItem{ key: 'textdomain', val: 'default' },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'content', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'rich-text' },
					rt.ArrayItem{ key: 'source', val: 'rich-text' },
					rt.ArrayItem{ key: 'selector', val: 'code' },
					rt.ArrayItem{ key: '__unstablePreserveWhiteSpace', val: true },
					rt.ArrayItem{ key: 'role', val: 'content' },
				]) },
			]) },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'align', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'wide' },
				]) },
				rt.ArrayItem{ key: 'anchor', val: true },
				rt.ArrayItem{ key: 'typography', val: rt.create_array([
					rt.ArrayItem{ key: 'fontSize', val: true },
					rt.ArrayItem{ key: 'lineHeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontFamily', val: true },
					rt.ArrayItem{ key: '__experimentalFontWeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontStyle', val: true },
					rt.ArrayItem{ key: '__experimentalTextTransform', val: true },
					rt.ArrayItem{ key: '__experimentalTextDecoration', val: true },
					rt.ArrayItem{ key: '__experimentalLetterSpacing', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'fontSize', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'spacing', val: rt.create_array([
					rt.ArrayItem{ key: 'margin', val: rt.create_array([
						rt.ArrayItem{ key: none, val: 'top' },
						rt.ArrayItem{ key: none, val: 'bottom' },
					]) },
					rt.ArrayItem{ key: 'padding', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'margin', val: false },
						rt.ArrayItem{ key: 'padding', val: false },
					]) },
				]) },
				rt.ArrayItem{ key: '__experimentalBorder', val: rt.create_array([
					rt.ArrayItem{ key: 'radius', val: true },
					rt.ArrayItem{ key: 'color', val: true },
					rt.ArrayItem{ key: 'width', val: true },
					rt.ArrayItem{ key: 'style', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'width', val: true },
						rt.ArrayItem{ key: 'color', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'color', val: rt.create_array([
					rt.ArrayItem{ key: 'text', val: true },
					rt.ArrayItem{ key: 'background', val: true },
					rt.ArrayItem{ key: 'gradients', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'background', val: true },
						rt.ArrayItem{ key: 'text', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'interactivity', val: rt.create_array([
					rt.ArrayItem{ key: 'clientNavigation', val: true },
				]) },
			]) },
			rt.ArrayItem{ key: 'style', val: 'wp-block-code' },
		]) },
		rt.ArrayItem{ key: 'column', val: rt.create_array([
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: 'name', val: 'core/column' },
			rt.ArrayItem{ key: 'title', val: 'Column' },
			rt.ArrayItem{ key: 'category', val: 'design' },
			rt.ArrayItem{ key: 'parent', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'core/columns' },
			]) },
			rt.ArrayItem{ key: 'description', val: 'A single column within a columns block.' },
			rt.ArrayItem{ key: 'textdomain', val: 'default' },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'verticalAlignment', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
				rt.ArrayItem{ key: 'width', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
				rt.ArrayItem{ key: 'templateLock', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: rt.create_array([
						rt.ArrayItem{ key: none, val: 'string' },
						rt.ArrayItem{ key: none, val: 'boolean' },
					]) },
					rt.ArrayItem{ key: 'enum', val: rt.create_array([
						rt.ArrayItem{ key: none, val: 'all' },
						rt.ArrayItem{ key: none, val: 'insert' },
						rt.ArrayItem{ key: none, val: 'contentOnly' },
						rt.ArrayItem{ key: none, val: false },
					]) },
				]) },
			]) },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: '__experimentalOnEnter', val: true },
				rt.ArrayItem{ key: 'anchor', val: true },
				rt.ArrayItem{ key: 'reusable', val: false },
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'color', val: rt.create_array([
					rt.ArrayItem{ key: 'gradients', val: true },
					rt.ArrayItem{ key: 'heading', val: true },
					rt.ArrayItem{ key: 'button', val: true },
					rt.ArrayItem{ key: 'link', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'background', val: true },
						rt.ArrayItem{ key: 'text', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'shadow', val: true },
				rt.ArrayItem{ key: 'spacing', val: rt.create_array([
					rt.ArrayItem{ key: 'blockGap', val: true },
					rt.ArrayItem{ key: 'padding', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'padding', val: true },
						rt.ArrayItem{ key: 'blockGap', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: '__experimentalBorder', val: rt.create_array([
					rt.ArrayItem{ key: 'color', val: true },
					rt.ArrayItem{ key: 'radius', val: true },
					rt.ArrayItem{ key: 'style', val: true },
					rt.ArrayItem{ key: 'width', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'color', val: true },
						rt.ArrayItem{ key: 'radius', val: true },
						rt.ArrayItem{ key: 'style', val: true },
						rt.ArrayItem{ key: 'width', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'typography', val: rt.create_array([
					rt.ArrayItem{ key: 'fontSize', val: true },
					rt.ArrayItem{ key: 'lineHeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontFamily', val: true },
					rt.ArrayItem{ key: '__experimentalFontWeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontStyle', val: true },
					rt.ArrayItem{ key: '__experimentalTextTransform', val: true },
					rt.ArrayItem{ key: '__experimentalTextDecoration', val: true },
					rt.ArrayItem{ key: '__experimentalLetterSpacing', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'fontSize', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'layout', val: true },
				rt.ArrayItem{ key: 'interactivity', val: rt.create_array([
					rt.ArrayItem{ key: 'clientNavigation', val: true },
				]) },
				rt.ArrayItem{ key: 'allowedBlocks', val: true },
			]) },
		]) },
		rt.ArrayItem{ key: 'columns', val: rt.create_array([
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: 'name', val: 'core/columns' },
			rt.ArrayItem{ key: 'title', val: 'Columns' },
			rt.ArrayItem{ key: 'category', val: 'design' },
			rt.ArrayItem{ key: 'allowedBlocks', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'core/column' },
			]) },
			rt.ArrayItem{
				key: 'description'
				val: 'Display content in multiple columns, with blocks added to each column.'
			},
			rt.ArrayItem{ key: 'textdomain', val: 'default' },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'verticalAlignment', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
				rt.ArrayItem{ key: 'isStackedOnMobile', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: true },
				]) },
				rt.ArrayItem{ key: 'templateLock', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: rt.create_array([
						rt.ArrayItem{ key: none, val: 'string' },
						rt.ArrayItem{ key: none, val: 'boolean' },
					]) },
					rt.ArrayItem{ key: 'enum', val: rt.create_array([
						rt.ArrayItem{ key: none, val: 'all' },
						rt.ArrayItem{ key: none, val: 'insert' },
						rt.ArrayItem{ key: none, val: 'contentOnly' },
						rt.ArrayItem{ key: none, val: false },
					]) },
				]) },
			]) },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'anchor', val: true },
				rt.ArrayItem{ key: 'align', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'wide' },
					rt.ArrayItem{ key: none, val: 'full' },
				]) },
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'color', val: rt.create_array([
					rt.ArrayItem{ key: 'gradients', val: true },
					rt.ArrayItem{ key: 'link', val: true },
					rt.ArrayItem{ key: 'heading', val: true },
					rt.ArrayItem{ key: 'button', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'background', val: true },
						rt.ArrayItem{ key: 'text', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'spacing', val: rt.create_array([
					rt.ArrayItem{ key: 'blockGap', val: rt.create_array([
						rt.ArrayItem{ key: '__experimentalDefault', val: '2em' },
						rt.ArrayItem{ key: 'sides', val: rt.create_array([
							rt.ArrayItem{ key: none, val: 'horizontal' },
							rt.ArrayItem{ key: none, val: 'vertical' },
						]) },
					]) },
					rt.ArrayItem{ key: 'margin', val: rt.create_array([
						rt.ArrayItem{ key: none, val: 'top' },
						rt.ArrayItem{ key: none, val: 'bottom' },
					]) },
					rt.ArrayItem{ key: 'padding', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'padding', val: true },
						rt.ArrayItem{ key: 'blockGap', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'layout', val: rt.create_array([
					rt.ArrayItem{ key: 'allowSwitching', val: false },
					rt.ArrayItem{ key: 'allowInheriting', val: false },
					rt.ArrayItem{ key: 'allowEditing', val: false },
					rt.ArrayItem{ key: 'default', val: rt.create_array([
						rt.ArrayItem{ key: 'type', val: 'flex' },
						rt.ArrayItem{ key: 'flexWrap', val: 'nowrap' },
					]) },
				]) },
				rt.ArrayItem{ key: '__experimentalBorder', val: rt.create_array([
					rt.ArrayItem{ key: 'color', val: true },
					rt.ArrayItem{ key: 'radius', val: true },
					rt.ArrayItem{ key: 'style', val: true },
					rt.ArrayItem{ key: 'width', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'color', val: true },
						rt.ArrayItem{ key: 'radius', val: true },
						rt.ArrayItem{ key: 'style', val: true },
						rt.ArrayItem{ key: 'width', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'typography', val: rt.create_array([
					rt.ArrayItem{ key: 'fontSize', val: true },
					rt.ArrayItem{ key: 'lineHeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontFamily', val: true },
					rt.ArrayItem{ key: '__experimentalFontWeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontStyle', val: true },
					rt.ArrayItem{ key: '__experimentalTextTransform', val: true },
					rt.ArrayItem{ key: '__experimentalTextDecoration', val: true },
					rt.ArrayItem{ key: '__experimentalLetterSpacing', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'fontSize', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'interactivity', val: rt.create_array([
					rt.ArrayItem{ key: 'clientNavigation', val: true },
				]) },
				rt.ArrayItem{ key: 'shadow', val: true },
			]) },
			rt.ArrayItem{ key: 'editorStyle', val: 'wp-block-columns-editor' },
			rt.ArrayItem{ key: 'style', val: 'wp-block-columns' },
		]) },
		rt.ArrayItem{ key: 'comment-author-name', val: rt.create_array([
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: 'name', val: 'core/comment-author-name' },
			rt.ArrayItem{ key: 'title', val: 'Comment Author Name' },
			rt.ArrayItem{ key: 'category', val: 'theme' },
			rt.ArrayItem{ key: 'ancestor', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'core/comment-template' },
			]) },
			rt.ArrayItem{ key: 'description', val: 'Displays the name of the author of the comment.' },
			rt.ArrayItem{ key: 'textdomain', val: 'default' },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'isLink', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: true },
				]) },
				rt.ArrayItem{ key: 'linkTarget', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: '_self' },
				]) },
			]) },
			rt.ArrayItem{ key: 'usesContext', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'commentId' },
			]) },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'anchor', val: true },
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'spacing', val: rt.create_array([
					rt.ArrayItem{ key: 'margin', val: true },
					rt.ArrayItem{ key: 'padding', val: true },
				]) },
				rt.ArrayItem{ key: 'color', val: rt.create_array([
					rt.ArrayItem{ key: 'gradients', val: true },
					rt.ArrayItem{ key: 'link', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'background', val: true },
						rt.ArrayItem{ key: 'text', val: true },
						rt.ArrayItem{ key: 'link', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'typography', val: rt.create_array([
					rt.ArrayItem{ key: 'fontSize', val: true },
					rt.ArrayItem{ key: 'lineHeight', val: true },
					rt.ArrayItem{ key: 'textAlign', val: true },
					rt.ArrayItem{ key: '__experimentalFontFamily', val: true },
					rt.ArrayItem{ key: '__experimentalFontWeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontStyle', val: true },
					rt.ArrayItem{ key: '__experimentalTextTransform', val: true },
					rt.ArrayItem{ key: '__experimentalTextDecoration', val: true },
					rt.ArrayItem{ key: '__experimentalLetterSpacing', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'fontSize', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'interactivity', val: rt.create_array([
					rt.ArrayItem{ key: 'clientNavigation', val: true },
				]) },
				rt.ArrayItem{ key: '__experimentalBorder', val: rt.create_array([
					rt.ArrayItem{ key: 'radius', val: true },
					rt.ArrayItem{ key: 'color', val: true },
					rt.ArrayItem{ key: 'width', val: true },
					rt.ArrayItem{ key: 'style', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'radius', val: true },
						rt.ArrayItem{ key: 'color', val: true },
						rt.ArrayItem{ key: 'width', val: true },
						rt.ArrayItem{ key: 'style', val: true },
					]) },
				]) },
			]) },
			rt.ArrayItem{ key: 'style', val: 'wp-block-comment-author-name' },
		]) },
		rt.ArrayItem{ key: 'comment-content', val: rt.create_array([
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: 'name', val: 'core/comment-content' },
			rt.ArrayItem{ key: 'title', val: 'Comment Content' },
			rt.ArrayItem{ key: 'category', val: 'theme' },
			rt.ArrayItem{ key: 'ancestor', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'core/comment-template' },
			]) },
			rt.ArrayItem{ key: 'description', val: 'Displays the contents of a comment.' },
			rt.ArrayItem{ key: 'textdomain', val: 'default' },
			rt.ArrayItem{ key: 'usesContext', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'commentId' },
			]) },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'anchor', val: true },
				rt.ArrayItem{ key: 'color', val: rt.create_array([
					rt.ArrayItem{ key: 'gradients', val: true },
					rt.ArrayItem{ key: 'link', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'background', val: true },
						rt.ArrayItem{ key: 'text', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'typography', val: rt.create_array([
					rt.ArrayItem{ key: 'fontSize', val: true },
					rt.ArrayItem{ key: 'lineHeight', val: true },
					rt.ArrayItem{ key: 'textAlign', val: true },
					rt.ArrayItem{ key: '__experimentalFontFamily', val: true },
					rt.ArrayItem{ key: '__experimentalFontWeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontStyle', val: true },
					rt.ArrayItem{ key: '__experimentalTextTransform', val: true },
					rt.ArrayItem{ key: '__experimentalTextDecoration', val: true },
					rt.ArrayItem{ key: '__experimentalLetterSpacing', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'fontSize', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: '__experimentalBorder', val: rt.create_array([
					rt.ArrayItem{ key: 'radius', val: true },
					rt.ArrayItem{ key: 'color', val: true },
					rt.ArrayItem{ key: 'width', val: true },
					rt.ArrayItem{ key: 'style', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'radius', val: true },
						rt.ArrayItem{ key: 'color', val: true },
						rt.ArrayItem{ key: 'width', val: true },
						rt.ArrayItem{ key: 'style', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'spacing', val: rt.create_array([
					rt.ArrayItem{ key: 'padding', val: rt.create_array([
						rt.ArrayItem{ key: none, val: 'horizontal' },
						rt.ArrayItem{ key: none, val: 'vertical' },
					]) },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'padding', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'html', val: false },
			]) },
			rt.ArrayItem{ key: 'style', val: 'wp-block-comment-content' },
		]) },
		rt.ArrayItem{ key: 'comment-date', val: rt.create_array([
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: 'name', val: 'core/comment-date' },
			rt.ArrayItem{ key: 'title', val: 'Comment Date' },
			rt.ArrayItem{ key: 'category', val: 'theme' },
			rt.ArrayItem{ key: 'ancestor', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'core/comment-template' },
			]) },
			rt.ArrayItem{
				key: 'description'
				val: 'Displays the date on which the comment was posted.'
			},
			rt.ArrayItem{ key: 'textdomain', val: 'default' },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'format', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
				rt.ArrayItem{ key: 'isLink', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: true },
				]) },
			]) },
			rt.ArrayItem{ key: 'usesContext', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'commentId' },
			]) },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'anchor', val: true },
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'color', val: rt.create_array([
					rt.ArrayItem{ key: 'gradients', val: true },
					rt.ArrayItem{ key: 'link', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'background', val: true },
						rt.ArrayItem{ key: 'text', val: true },
						rt.ArrayItem{ key: 'link', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'spacing', val: rt.create_array([
					rt.ArrayItem{ key: 'margin', val: true },
					rt.ArrayItem{ key: 'padding', val: true },
				]) },
				rt.ArrayItem{ key: 'typography', val: rt.create_array([
					rt.ArrayItem{ key: 'fontSize', val: true },
					rt.ArrayItem{ key: 'lineHeight', val: true },
					rt.ArrayItem{ key: 'textAlign', val: true },
					rt.ArrayItem{ key: '__experimentalFontFamily', val: true },
					rt.ArrayItem{ key: '__experimentalFontWeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontStyle', val: true },
					rt.ArrayItem{ key: '__experimentalTextTransform', val: true },
					rt.ArrayItem{ key: '__experimentalTextDecoration', val: true },
					rt.ArrayItem{ key: '__experimentalLetterSpacing', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'fontSize', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'interactivity', val: rt.create_array([
					rt.ArrayItem{ key: 'clientNavigation', val: true },
				]) },
				rt.ArrayItem{ key: '__experimentalBorder', val: rt.create_array([
					rt.ArrayItem{ key: 'radius', val: true },
					rt.ArrayItem{ key: 'color', val: true },
					rt.ArrayItem{ key: 'width', val: true },
					rt.ArrayItem{ key: 'style', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'radius', val: true },
						rt.ArrayItem{ key: 'color', val: true },
						rt.ArrayItem{ key: 'width', val: true },
						rt.ArrayItem{ key: 'style', val: true },
					]) },
				]) },
			]) },
			rt.ArrayItem{ key: 'style', val: 'wp-block-comment-date' },
		]) },
		rt.ArrayItem{ key: 'comment-edit-link', val: rt.create_array([
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: 'name', val: 'core/comment-edit-link' },
			rt.ArrayItem{ key: 'title', val: 'Comment Edit Link' },
			rt.ArrayItem{ key: 'category', val: 'theme' },
			rt.ArrayItem{ key: 'ancestor', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'core/comment-template' },
			]) },
			rt.ArrayItem{
				key: 'description'
				val: 'Displays a link to edit the comment in the WordPress Dashboard. This link is only visible to users with the edit comment capability.'
			},
			rt.ArrayItem{ key: 'textdomain', val: 'default' },
			rt.ArrayItem{ key: 'usesContext', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'commentId' },
			]) },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'linkTarget', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: '_self' },
				]) },
			]) },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'anchor', val: true },
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'color', val: rt.create_array([
					rt.ArrayItem{ key: 'link', val: true },
					rt.ArrayItem{ key: 'gradients', val: true },
					rt.ArrayItem{ key: 'text', val: false },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'background', val: true },
						rt.ArrayItem{ key: 'link', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'spacing', val: rt.create_array([
					rt.ArrayItem{ key: 'margin', val: true },
					rt.ArrayItem{ key: 'padding', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'margin', val: false },
						rt.ArrayItem{ key: 'padding', val: false },
					]) },
				]) },
				rt.ArrayItem{ key: 'typography', val: rt.create_array([
					rt.ArrayItem{ key: 'fontSize', val: true },
					rt.ArrayItem{ key: 'lineHeight', val: true },
					rt.ArrayItem{ key: 'textAlign', val: true },
					rt.ArrayItem{ key: '__experimentalFontFamily', val: true },
					rt.ArrayItem{ key: '__experimentalFontWeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontStyle', val: true },
					rt.ArrayItem{ key: '__experimentalTextTransform', val: true },
					rt.ArrayItem{ key: '__experimentalTextDecoration', val: true },
					rt.ArrayItem{ key: '__experimentalLetterSpacing', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'fontSize', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'interactivity', val: rt.create_array([
					rt.ArrayItem{ key: 'clientNavigation', val: true },
				]) },
				rt.ArrayItem{ key: '__experimentalBorder', val: rt.create_array([
					rt.ArrayItem{ key: 'radius', val: true },
					rt.ArrayItem{ key: 'color', val: true },
					rt.ArrayItem{ key: 'width', val: true },
					rt.ArrayItem{ key: 'style', val: true },
				]) },
			]) },
			rt.ArrayItem{ key: 'style', val: 'wp-block-comment-edit-link' },
		]) },
		rt.ArrayItem{ key: 'comment-reply-link', val: rt.create_array([
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: 'name', val: 'core/comment-reply-link' },
			rt.ArrayItem{ key: 'title', val: 'Comment Reply Link' },
			rt.ArrayItem{ key: 'category', val: 'theme' },
			rt.ArrayItem{ key: 'ancestor', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'core/comment-template' },
			]) },
			rt.ArrayItem{ key: 'description', val: 'Displays a link to reply to a comment.' },
			rt.ArrayItem{ key: 'textdomain', val: 'default' },
			rt.ArrayItem{ key: 'usesContext', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'commentId' },
			]) },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'anchor', val: true },
				rt.ArrayItem{ key: 'color', val: rt.create_array([
					rt.ArrayItem{ key: 'gradients', val: true },
					rt.ArrayItem{ key: 'link', val: true },
					rt.ArrayItem{ key: 'text', val: false },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'background', val: true },
						rt.ArrayItem{ key: 'link', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'spacing', val: rt.create_array([
					rt.ArrayItem{ key: 'margin', val: true },
					rt.ArrayItem{ key: 'padding', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'margin', val: false },
						rt.ArrayItem{ key: 'padding', val: false },
					]) },
				]) },
				rt.ArrayItem{ key: 'typography', val: rt.create_array([
					rt.ArrayItem{ key: 'fontSize', val: true },
					rt.ArrayItem{ key: 'lineHeight', val: true },
					rt.ArrayItem{ key: 'textAlign', val: true },
					rt.ArrayItem{ key: '__experimentalFontFamily', val: true },
					rt.ArrayItem{ key: '__experimentalFontWeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontStyle', val: true },
					rt.ArrayItem{ key: '__experimentalTextTransform', val: true },
					rt.ArrayItem{ key: '__experimentalTextDecoration', val: true },
					rt.ArrayItem{ key: '__experimentalLetterSpacing', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'fontSize', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: '__experimentalBorder', val: rt.create_array([
					rt.ArrayItem{ key: 'radius', val: true },
					rt.ArrayItem{ key: 'color', val: true },
					rt.ArrayItem{ key: 'width', val: true },
					rt.ArrayItem{ key: 'style', val: true },
				]) },
				rt.ArrayItem{ key: 'html', val: false },
			]) },
			rt.ArrayItem{ key: 'style', val: 'wp-block-comment-reply-link' },
		]) },
		rt.ArrayItem{ key: 'comment-template', val: rt.create_array([
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: 'name', val: 'core/comment-template' },
			rt.ArrayItem{ key: 'title', val: 'Comment Template' },
			rt.ArrayItem{ key: 'category', val: 'design' },
			rt.ArrayItem{ key: 'parent', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'core/comments' },
			]) },
			rt.ArrayItem{
				key: 'description'
				val: 'Contains the block elements used to display a comment, like the title, date, author, avatar and more.'
			},
			rt.ArrayItem{ key: 'textdomain', val: 'default' },
			rt.ArrayItem{ key: 'usesContext', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'postId' },
			]) },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'anchor', val: true },
				rt.ArrayItem{ key: 'align', val: true },
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'reusable', val: false },
				rt.ArrayItem{ key: 'spacing', val: rt.create_array([
					rt.ArrayItem{ key: 'margin', val: true },
					rt.ArrayItem{ key: 'padding', val: true },
				]) },
				rt.ArrayItem{ key: 'typography', val: rt.create_array([
					rt.ArrayItem{ key: 'fontSize', val: true },
					rt.ArrayItem{ key: 'lineHeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontFamily', val: true },
					rt.ArrayItem{ key: '__experimentalFontWeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontStyle', val: true },
					rt.ArrayItem{ key: '__experimentalTextTransform', val: true },
					rt.ArrayItem{ key: '__experimentalTextDecoration', val: true },
					rt.ArrayItem{ key: '__experimentalLetterSpacing', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'fontSize', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'interactivity', val: rt.create_array([
					rt.ArrayItem{ key: 'clientNavigation', val: true },
				]) },
				rt.ArrayItem{ key: '__experimentalBorder', val: rt.create_array([
					rt.ArrayItem{ key: 'radius', val: true },
					rt.ArrayItem{ key: 'color', val: true },
					rt.ArrayItem{ key: 'width', val: true },
					rt.ArrayItem{ key: 'style', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'radius', val: true },
						rt.ArrayItem{ key: 'color', val: true },
						rt.ArrayItem{ key: 'width', val: true },
						rt.ArrayItem{ key: 'style', val: true },
					]) },
				]) },
			]) },
			rt.ArrayItem{ key: 'style', val: 'wp-block-comment-template' },
		]) },
		rt.ArrayItem{ key: 'comments', val: rt.create_array([
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: 'name', val: 'core/comments' },
			rt.ArrayItem{ key: 'title', val: 'Comments' },
			rt.ArrayItem{ key: 'category', val: 'theme' },
			rt.ArrayItem{
				key: 'description'
				val: 'An advanced block that allows displaying post comments using different visual configurations.'
			},
			rt.ArrayItem{ key: 'textdomain', val: 'default' },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'tagName', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: 'div' },
				]) },
				rt.ArrayItem{ key: 'legacy', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: false },
				]) },
			]) },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'anchor', val: true },
				rt.ArrayItem{ key: 'align', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'wide' },
					rt.ArrayItem{ key: none, val: 'full' },
				]) },
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'color', val: rt.create_array([
					rt.ArrayItem{ key: 'gradients', val: true },
					rt.ArrayItem{ key: 'heading', val: true },
					rt.ArrayItem{ key: 'link', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'background', val: true },
						rt.ArrayItem{ key: 'text', val: true },
						rt.ArrayItem{ key: 'link', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'spacing', val: rt.create_array([
					rt.ArrayItem{ key: 'margin', val: true },
					rt.ArrayItem{ key: 'padding', val: true },
				]) },
				rt.ArrayItem{ key: 'typography', val: rt.create_array([
					rt.ArrayItem{ key: 'fontSize', val: true },
					rt.ArrayItem{ key: 'lineHeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontFamily', val: true },
					rt.ArrayItem{ key: '__experimentalFontWeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontStyle', val: true },
					rt.ArrayItem{ key: '__experimentalTextTransform', val: true },
					rt.ArrayItem{ key: '__experimentalTextDecoration', val: true },
					rt.ArrayItem{ key: '__experimentalLetterSpacing', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'fontSize', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: '__experimentalBorder', val: rt.create_array([
					rt.ArrayItem{ key: 'radius', val: true },
					rt.ArrayItem{ key: 'color', val: true },
					rt.ArrayItem{ key: 'width', val: true },
					rt.ArrayItem{ key: 'style', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'radius', val: true },
						rt.ArrayItem{ key: 'color', val: true },
						rt.ArrayItem{ key: 'width', val: true },
						rt.ArrayItem{ key: 'style', val: true },
					]) },
				]) },
			]) },
			rt.ArrayItem{ key: 'editorStyle', val: 'wp-block-comments-editor' },
			rt.ArrayItem{ key: 'usesContext', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'postId' },
				rt.ArrayItem{ key: none, val: 'postType' },
			]) },
		]) },
		rt.ArrayItem{ key: 'comments-pagination', val: rt.create_array([
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: 'name', val: 'core/comments-pagination' },
			rt.ArrayItem{ key: 'title', val: 'Comments Pagination' },
			rt.ArrayItem{ key: 'category', val: 'theme' },
			rt.ArrayItem{ key: 'parent', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'core/comments' },
			]) },
			rt.ArrayItem{ key: 'allowedBlocks', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'core/comments-pagination-previous' },
				rt.ArrayItem{ key: none, val: 'core/comments-pagination-numbers' },
				rt.ArrayItem{ key: none, val: 'core/comments-pagination-next' },
			]) },
			rt.ArrayItem{
				key: 'description'
				val: 'Displays a paginated navigation to next/previous set of comments, when applicable.'
			},
			rt.ArrayItem{ key: 'textdomain', val: 'default' },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'paginationArrow', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: 'none' },
				]) },
			]) },
			rt.ArrayItem{ key: 'example', val: rt.create_array([
				rt.ArrayItem{ key: 'attributes', val: rt.create_array([
					rt.ArrayItem{ key: 'paginationArrow', val: 'none' },
				]) },
			]) },
			rt.ArrayItem{ key: 'providesContext', val: rt.create_array([
				rt.ArrayItem{ key: 'comments/paginationArrow', val: 'paginationArrow' },
			]) },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'anchor', val: true },
				rt.ArrayItem{ key: 'align', val: true },
				rt.ArrayItem{ key: 'reusable', val: false },
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'color', val: rt.create_array([
					rt.ArrayItem{ key: 'gradients', val: true },
					rt.ArrayItem{ key: 'link', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'background', val: true },
						rt.ArrayItem{ key: 'text', val: true },
						rt.ArrayItem{ key: 'link', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'layout', val: rt.create_array([
					rt.ArrayItem{ key: 'allowSwitching', val: false },
					rt.ArrayItem{ key: 'allowInheriting', val: false },
					rt.ArrayItem{ key: 'default', val: rt.create_array([
						rt.ArrayItem{ key: 'type', val: 'flex' },
					]) },
				]) },
				rt.ArrayItem{ key: 'typography', val: rt.create_array([
					rt.ArrayItem{ key: 'fontSize', val: true },
					rt.ArrayItem{ key: 'lineHeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontFamily', val: true },
					rt.ArrayItem{ key: '__experimentalFontWeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontStyle', val: true },
					rt.ArrayItem{ key: '__experimentalTextTransform', val: true },
					rt.ArrayItem{ key: '__experimentalTextDecoration', val: true },
					rt.ArrayItem{ key: '__experimentalLetterSpacing', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'fontSize', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'interactivity', val: rt.create_array([
					rt.ArrayItem{ key: 'clientNavigation', val: true },
				]) },
			]) },
			rt.ArrayItem{ key: 'editorStyle', val: 'wp-block-comments-pagination-editor' },
			rt.ArrayItem{ key: 'style', val: 'wp-block-comments-pagination' },
		]) },
		rt.ArrayItem{ key: 'comments-pagination-next', val: rt.create_array([
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: 'name', val: 'core/comments-pagination-next' },
			rt.ArrayItem{ key: 'title', val: 'Comments Next Page' },
			rt.ArrayItem{ key: 'category', val: 'theme' },
			rt.ArrayItem{ key: 'parent', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'core/comments-pagination' },
			]) },
			rt.ArrayItem{ key: 'description', val: "Displays the next comment's page link." },
			rt.ArrayItem{ key: 'textdomain', val: 'default' },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'label', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
			]) },
			rt.ArrayItem{ key: 'usesContext', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'postId' },
				rt.ArrayItem{ key: none, val: 'comments/paginationArrow' },
			]) },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'anchor', val: true },
				rt.ArrayItem{ key: 'reusable', val: false },
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'color', val: rt.create_array([
					rt.ArrayItem{ key: 'gradients', val: true },
					rt.ArrayItem{ key: 'text', val: false },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'background', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'typography', val: rt.create_array([
					rt.ArrayItem{ key: 'fontSize', val: true },
					rt.ArrayItem{ key: 'lineHeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontFamily', val: true },
					rt.ArrayItem{ key: '__experimentalFontWeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontStyle', val: true },
					rt.ArrayItem{ key: '__experimentalTextTransform', val: true },
					rt.ArrayItem{ key: '__experimentalTextDecoration', val: true },
					rt.ArrayItem{ key: '__experimentalLetterSpacing', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'fontSize', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'interactivity', val: rt.create_array([
					rt.ArrayItem{ key: 'clientNavigation', val: true },
				]) },
			]) },
		]) },
		rt.ArrayItem{ key: 'comments-pagination-numbers', val: rt.create_array([
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: 'name', val: 'core/comments-pagination-numbers' },
			rt.ArrayItem{ key: 'title', val: 'Comments Page Numbers' },
			rt.ArrayItem{ key: 'category', val: 'theme' },
			rt.ArrayItem{ key: 'parent', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'core/comments-pagination' },
			]) },
			rt.ArrayItem{
				key: 'description'
				val: 'Displays a list of page numbers for comments pagination.'
			},
			rt.ArrayItem{ key: 'textdomain', val: 'default' },
			rt.ArrayItem{ key: 'usesContext', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'postId' },
			]) },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'anchor', val: true },
				rt.ArrayItem{ key: 'reusable', val: false },
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'color', val: rt.create_array([
					rt.ArrayItem{ key: 'gradients', val: true },
					rt.ArrayItem{ key: 'text', val: false },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'background', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'typography', val: rt.create_array([
					rt.ArrayItem{ key: 'fontSize', val: true },
					rt.ArrayItem{ key: 'lineHeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontFamily', val: true },
					rt.ArrayItem{ key: '__experimentalFontWeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontStyle', val: true },
					rt.ArrayItem{ key: '__experimentalTextTransform', val: true },
					rt.ArrayItem{ key: '__experimentalTextDecoration', val: true },
					rt.ArrayItem{ key: '__experimentalLetterSpacing', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'fontSize', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'interactivity', val: rt.create_array([
					rt.ArrayItem{ key: 'clientNavigation', val: true },
				]) },
				rt.ArrayItem{ key: 'spacing', val: rt.create_array([
					rt.ArrayItem{ key: 'margin', val: true },
					rt.ArrayItem{ key: 'padding', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'padding', val: true },
					]) },
				]) },
			]) },
		]) },
		rt.ArrayItem{ key: 'comments-pagination-previous', val: rt.create_array([
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: 'name', val: 'core/comments-pagination-previous' },
			rt.ArrayItem{ key: 'title', val: 'Comments Previous Page' },
			rt.ArrayItem{ key: 'category', val: 'theme' },
			rt.ArrayItem{ key: 'parent', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'core/comments-pagination' },
			]) },
			rt.ArrayItem{ key: 'description', val: "Displays the previous comment's page link." },
			rt.ArrayItem{ key: 'textdomain', val: 'default' },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'label', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
			]) },
			rt.ArrayItem{ key: 'usesContext', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'postId' },
				rt.ArrayItem{ key: none, val: 'comments/paginationArrow' },
			]) },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'anchor', val: true },
				rt.ArrayItem{ key: 'reusable', val: false },
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'color', val: rt.create_array([
					rt.ArrayItem{ key: 'gradients', val: true },
					rt.ArrayItem{ key: 'text', val: false },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'background', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'typography', val: rt.create_array([
					rt.ArrayItem{ key: 'fontSize', val: true },
					rt.ArrayItem{ key: 'lineHeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontFamily', val: true },
					rt.ArrayItem{ key: '__experimentalFontWeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontStyle', val: true },
					rt.ArrayItem{ key: '__experimentalTextTransform', val: true },
					rt.ArrayItem{ key: '__experimentalTextDecoration', val: true },
					rt.ArrayItem{ key: '__experimentalLetterSpacing', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'fontSize', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'interactivity', val: rt.create_array([
					rt.ArrayItem{ key: 'clientNavigation', val: true },
				]) },
			]) },
		]) },
		rt.ArrayItem{ key: 'comments-title', val: rt.create_array([
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: 'name', val: 'core/comments-title' },
			rt.ArrayItem{ key: 'title', val: 'Comments Title' },
			rt.ArrayItem{ key: 'category', val: 'theme' },
			rt.ArrayItem{ key: 'ancestor', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'core/comments' },
			]) },
			rt.ArrayItem{ key: 'description', val: 'Displays a title with the number of comments.' },
			rt.ArrayItem{ key: 'textdomain', val: 'default' },
			rt.ArrayItem{ key: 'usesContext', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'postId' },
				rt.ArrayItem{ key: none, val: 'postType' },
			]) },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'showPostTitle', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: true },
				]) },
				rt.ArrayItem{ key: 'showCommentsCount', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: true },
				]) },
				rt.ArrayItem{ key: 'level', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'number' },
					rt.ArrayItem{ key: 'default', val: 2 },
				]) },
				rt.ArrayItem{ key: 'levelOptions', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'array' },
				]) },
			]) },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'anchor', val: true },
				rt.ArrayItem{ key: 'align', val: true },
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: '__experimentalBorder', val: rt.create_array([
					rt.ArrayItem{ key: 'radius', val: true },
					rt.ArrayItem{ key: 'color', val: true },
					rt.ArrayItem{ key: 'width', val: true },
					rt.ArrayItem{ key: 'style', val: true },
				]) },
				rt.ArrayItem{ key: 'color', val: rt.create_array([
					rt.ArrayItem{ key: 'gradients', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'background', val: true },
						rt.ArrayItem{ key: 'text', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'spacing', val: rt.create_array([
					rt.ArrayItem{ key: 'margin', val: true },
					rt.ArrayItem{ key: 'padding', val: true },
				]) },
				rt.ArrayItem{ key: 'typography', val: rt.create_array([
					rt.ArrayItem{ key: 'fontSize', val: true },
					rt.ArrayItem{ key: 'lineHeight', val: true },
					rt.ArrayItem{ key: 'textAlign', val: true },
					rt.ArrayItem{ key: '__experimentalFontFamily', val: true },
					rt.ArrayItem{ key: '__experimentalFontWeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontStyle', val: true },
					rt.ArrayItem{ key: '__experimentalTextTransform', val: true },
					rt.ArrayItem{ key: '__experimentalTextDecoration', val: true },
					rt.ArrayItem{ key: '__experimentalLetterSpacing', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'fontSize', val: true },
						rt.ArrayItem{ key: '__experimentalFontFamily', val: true },
						rt.ArrayItem{ key: '__experimentalFontStyle', val: true },
						rt.ArrayItem{ key: '__experimentalFontWeight', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'interactivity', val: rt.create_array([
					rt.ArrayItem{ key: 'clientNavigation', val: true },
				]) },
			]) },
		]) },
		rt.ArrayItem{ key: 'cover', val: rt.create_array([
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: 'name', val: 'core/cover' },
			rt.ArrayItem{ key: 'title', val: 'Cover' },
			rt.ArrayItem{ key: 'category', val: 'media' },
			rt.ArrayItem{ key: 'description', val: 'Add an image or video with a text overlay.' },
			rt.ArrayItem{ key: 'textdomain', val: 'default' },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'url', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'role', val: 'content' },
				]) },
				rt.ArrayItem{ key: 'useFeaturedImage', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: false },
				]) },
				rt.ArrayItem{ key: 'id', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'number' },
				]) },
				rt.ArrayItem{ key: 'alt', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: '' },
				]) },
				rt.ArrayItem{ key: 'hasParallax', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: false },
				]) },
				rt.ArrayItem{ key: 'isRepeated', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: false },
				]) },
				rt.ArrayItem{ key: 'dimRatio', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'number' },
					rt.ArrayItem{ key: 'default', val: 100 },
				]) },
				rt.ArrayItem{ key: 'overlayColor', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
				rt.ArrayItem{ key: 'customOverlayColor', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
				rt.ArrayItem{ key: 'isUserOverlayColor', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
				]) },
				rt.ArrayItem{ key: 'backgroundType', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: 'image' },
				]) },
				rt.ArrayItem{ key: 'focalPoint', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'object' },
				]) },
				rt.ArrayItem{ key: 'minHeight', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'number' },
				]) },
				rt.ArrayItem{ key: 'minHeightUnit', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
				rt.ArrayItem{ key: 'gradient', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
				rt.ArrayItem{ key: 'customGradient', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
				rt.ArrayItem{ key: 'contentPosition', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
				rt.ArrayItem{ key: 'isDark', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: true },
				]) },
				rt.ArrayItem{ key: 'templateLock', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: rt.create_array([
						rt.ArrayItem{ key: none, val: 'string' },
						rt.ArrayItem{ key: none, val: 'boolean' },
					]) },
					rt.ArrayItem{ key: 'enum', val: rt.create_array([
						rt.ArrayItem{ key: none, val: 'all' },
						rt.ArrayItem{ key: none, val: 'insert' },
						rt.ArrayItem{ key: none, val: 'contentOnly' },
						rt.ArrayItem{ key: none, val: false },
					]) },
				]) },
				rt.ArrayItem{ key: 'tagName', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: 'div' },
				]) },
				rt.ArrayItem{ key: 'sizeSlug', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
				rt.ArrayItem{ key: 'poster', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'source', val: 'attribute' },
					rt.ArrayItem{ key: 'selector', val: 'video' },
					rt.ArrayItem{ key: 'attribute', val: 'poster' },
				]) },
			]) },
			rt.ArrayItem{ key: 'usesContext', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'postId' },
				rt.ArrayItem{ key: none, val: 'postType' },
			]) },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'anchor', val: true },
				rt.ArrayItem{ key: 'align', val: true },
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'shadow', val: true },
				rt.ArrayItem{ key: 'spacing', val: rt.create_array([
					rt.ArrayItem{ key: 'padding', val: true },
					rt.ArrayItem{ key: 'margin', val: rt.create_array([
						rt.ArrayItem{ key: none, val: 'top' },
						rt.ArrayItem{ key: none, val: 'bottom' },
					]) },
					rt.ArrayItem{ key: 'blockGap', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'padding', val: true },
						rt.ArrayItem{ key: 'blockGap', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: '__experimentalBorder', val: rt.create_array([
					rt.ArrayItem{ key: 'color', val: true },
					rt.ArrayItem{ key: 'radius', val: true },
					rt.ArrayItem{ key: 'style', val: true },
					rt.ArrayItem{ key: 'width', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'color', val: true },
						rt.ArrayItem{ key: 'radius', val: true },
						rt.ArrayItem{ key: 'style', val: true },
						rt.ArrayItem{ key: 'width', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'color', val: rt.create_array([
					rt.ArrayItem{ key: 'heading', val: true },
					rt.ArrayItem{ key: 'text', val: true },
					rt.ArrayItem{ key: 'background', val: false },
					rt.ArrayItem{ key: '__experimentalSkipSerialization', val: rt.create_array([
						rt.ArrayItem{ key: none, val: 'gradients' },
					]) },
					rt.ArrayItem{ key: 'enableContrastChecker', val: false },
				]) },
				rt.ArrayItem{ key: 'dimensions', val: rt.create_array([
					rt.ArrayItem{ key: 'aspectRatio', val: true },
				]) },
				rt.ArrayItem{ key: 'typography', val: rt.create_array([
					rt.ArrayItem{ key: 'fontSize', val: true },
					rt.ArrayItem{ key: 'lineHeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontFamily', val: true },
					rt.ArrayItem{ key: '__experimentalFontWeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontStyle', val: true },
					rt.ArrayItem{ key: '__experimentalTextTransform', val: true },
					rt.ArrayItem{ key: '__experimentalTextDecoration', val: true },
					rt.ArrayItem{ key: '__experimentalLetterSpacing', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'fontSize', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'layout', val: rt.create_array([
					rt.ArrayItem{ key: 'allowJustification', val: false },
				]) },
				rt.ArrayItem{ key: 'interactivity', val: rt.create_array([
					rt.ArrayItem{ key: 'clientNavigation', val: true },
				]) },
				rt.ArrayItem{ key: 'filter', val: rt.create_array([
					rt.ArrayItem{ key: 'duotone', val: true },
				]) },
				rt.ArrayItem{ key: 'allowedBlocks', val: true },
			]) },
			rt.ArrayItem{ key: 'selectors', val: rt.create_array([
				rt.ArrayItem{ key: 'filter', val: rt.create_array([
					rt.ArrayItem{
						key: 'duotone'
						val: '.wp-block-cover > .wp-block-cover__image-background, .wp-block-cover > .wp-block-cover__video-background'
					},
				]) },
			]) },
			rt.ArrayItem{ key: 'editorStyle', val: 'wp-block-cover-editor' },
			rt.ArrayItem{ key: 'style', val: 'wp-block-cover' },
		]) },
		rt.ArrayItem{ key: 'details', val: rt.create_array([
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: 'name', val: 'core/details' },
			rt.ArrayItem{ key: 'title', val: 'Details' },
			rt.ArrayItem{ key: 'category', val: 'text' },
			rt.ArrayItem{ key: 'description', val: 'Hide and show additional content.' },
			rt.ArrayItem{ key: 'keywords', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'summary' },
				rt.ArrayItem{ key: none, val: 'toggle' },
				rt.ArrayItem{ key: none, val: 'disclosure' },
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'default' },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'showContent', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: false },
				]) },
				rt.ArrayItem{ key: 'summary', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'rich-text' },
					rt.ArrayItem{ key: 'source', val: 'rich-text' },
					rt.ArrayItem{ key: 'selector', val: 'summary' },
					rt.ArrayItem{ key: 'role', val: 'content' },
				]) },
				rt.ArrayItem{ key: 'name', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'source', val: 'attribute' },
					rt.ArrayItem{ key: 'attribute', val: 'name' },
					rt.ArrayItem{ key: 'selector', val: '.wp-block-details' },
				]) },
				rt.ArrayItem{ key: 'placeholder', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
			]) },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: '__experimentalOnEnter', val: true },
				rt.ArrayItem{ key: 'align', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'wide' },
					rt.ArrayItem{ key: none, val: 'full' },
				]) },
				rt.ArrayItem{ key: 'anchor', val: true },
				rt.ArrayItem{ key: 'color', val: rt.create_array([
					rt.ArrayItem{ key: 'gradients', val: true },
					rt.ArrayItem{ key: 'link', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'background', val: true },
						rt.ArrayItem{ key: 'text', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: '__experimentalBorder', val: rt.create_array([
					rt.ArrayItem{ key: 'color', val: true },
					rt.ArrayItem{ key: 'width', val: true },
					rt.ArrayItem{ key: 'style', val: true },
				]) },
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'spacing', val: rt.create_array([
					rt.ArrayItem{ key: 'margin', val: true },
					rt.ArrayItem{ key: 'padding', val: true },
					rt.ArrayItem{ key: 'blockGap', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'margin', val: false },
						rt.ArrayItem{ key: 'padding', val: false },
					]) },
				]) },
				rt.ArrayItem{ key: 'typography', val: rt.create_array([
					rt.ArrayItem{ key: 'fontSize', val: true },
					rt.ArrayItem{ key: 'lineHeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontFamily', val: true },
					rt.ArrayItem{ key: '__experimentalFontWeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontStyle', val: true },
					rt.ArrayItem{ key: '__experimentalTextTransform', val: true },
					rt.ArrayItem{ key: '__experimentalTextDecoration', val: true },
					rt.ArrayItem{ key: '__experimentalLetterSpacing', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'fontSize', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'layout', val: rt.create_array([
					rt.ArrayItem{ key: 'allowEditing', val: false },
				]) },
				rt.ArrayItem{ key: 'interactivity', val: rt.create_array([
					rt.ArrayItem{ key: 'clientNavigation', val: true },
				]) },
				rt.ArrayItem{ key: 'allowedBlocks', val: true },
			]) },
			rt.ArrayItem{ key: 'editorStyle', val: 'wp-block-details-editor' },
			rt.ArrayItem{ key: 'style', val: 'wp-block-details' },
		]) },
		rt.ArrayItem{ key: 'embed', val: rt.create_array([
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: 'name', val: 'core/embed' },
			rt.ArrayItem{ key: 'title', val: 'Embed' },
			rt.ArrayItem{ key: 'category', val: 'embed' },
			rt.ArrayItem{
				key: 'description'
				val: 'Add a block that displays content pulled from other sites, like Twitter or YouTube.'
			},
			rt.ArrayItem{ key: 'textdomain', val: 'default' },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'url', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'role', val: 'content' },
				]) },
				rt.ArrayItem{ key: 'caption', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'rich-text' },
					rt.ArrayItem{ key: 'source', val: 'rich-text' },
					rt.ArrayItem{ key: 'selector', val: 'figcaption' },
					rt.ArrayItem{ key: 'role', val: 'content' },
				]) },
				rt.ArrayItem{ key: 'type', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'role', val: 'content' },
				]) },
				rt.ArrayItem{ key: 'providerNameSlug', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'role', val: 'content' },
				]) },
				rt.ArrayItem{ key: 'allowResponsive', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: true },
				]) },
				rt.ArrayItem{ key: 'responsive', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: false },
					rt.ArrayItem{ key: 'role', val: 'content' },
				]) },
				rt.ArrayItem{ key: 'previewable', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: true },
					rt.ArrayItem{ key: 'role', val: 'content' },
				]) },
			]) },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'anchor', val: true },
				rt.ArrayItem{ key: 'align', val: true },
				rt.ArrayItem{ key: 'spacing', val: rt.create_array([
					rt.ArrayItem{ key: 'margin', val: true },
				]) },
				rt.ArrayItem{ key: 'interactivity', val: rt.create_array([
					rt.ArrayItem{ key: 'clientNavigation', val: true },
				]) },
			]) },
			rt.ArrayItem{ key: 'editorStyle', val: 'wp-block-embed-editor' },
			rt.ArrayItem{ key: 'style', val: 'wp-block-embed' },
		]) },
		rt.ArrayItem{ key: 'file', val: rt.create_array([
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: 'name', val: 'core/file' },
			rt.ArrayItem{ key: 'title', val: 'File' },
			rt.ArrayItem{ key: 'category', val: 'media' },
			rt.ArrayItem{ key: 'description', val: 'Add a link to a downloadable file.' },
			rt.ArrayItem{ key: 'keywords', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'document' },
				rt.ArrayItem{ key: none, val: 'pdf' },
				rt.ArrayItem{ key: none, val: 'download' },
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'default' },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'id', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'number' },
				]) },
				rt.ArrayItem{ key: 'blob', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'role', val: 'local' },
				]) },
				rt.ArrayItem{ key: 'href', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'role', val: 'content' },
				]) },
				rt.ArrayItem{ key: 'fileId', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'source', val: 'attribute' },
					rt.ArrayItem{ key: 'selector', val: 'a:not([download])' },
					rt.ArrayItem{ key: 'attribute', val: 'id' },
				]) },
				rt.ArrayItem{ key: 'fileName', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'rich-text' },
					rt.ArrayItem{ key: 'source', val: 'rich-text' },
					rt.ArrayItem{ key: 'selector', val: 'a:not([download])' },
					rt.ArrayItem{ key: 'role', val: 'content' },
				]) },
				rt.ArrayItem{ key: 'textLinkHref', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'source', val: 'attribute' },
					rt.ArrayItem{ key: 'selector', val: 'a:not([download])' },
					rt.ArrayItem{ key: 'attribute', val: 'href' },
					rt.ArrayItem{ key: 'role', val: 'content' },
				]) },
				rt.ArrayItem{ key: 'textLinkTarget', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'source', val: 'attribute' },
					rt.ArrayItem{ key: 'selector', val: 'a:not([download])' },
					rt.ArrayItem{ key: 'attribute', val: 'target' },
				]) },
				rt.ArrayItem{ key: 'showDownloadButton', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: true },
				]) },
				rt.ArrayItem{ key: 'downloadButtonText', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'rich-text' },
					rt.ArrayItem{ key: 'source', val: 'rich-text' },
					rt.ArrayItem{ key: 'selector', val: 'a[download]' },
					rt.ArrayItem{ key: 'role', val: 'content' },
				]) },
				rt.ArrayItem{ key: 'displayPreview', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
				]) },
				rt.ArrayItem{ key: 'previewHeight', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'number' },
					rt.ArrayItem{ key: 'default', val: 600 },
				]) },
			]) },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'anchor', val: true },
				rt.ArrayItem{ key: 'align', val: true },
				rt.ArrayItem{ key: 'spacing', val: rt.create_array([
					rt.ArrayItem{ key: 'margin', val: true },
					rt.ArrayItem{ key: 'padding', val: true },
				]) },
				rt.ArrayItem{ key: 'color', val: rt.create_array([
					rt.ArrayItem{ key: 'gradients', val: true },
					rt.ArrayItem{ key: 'link', val: true },
					rt.ArrayItem{ key: 'text', val: false },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'background', val: true },
						rt.ArrayItem{ key: 'link', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: '__experimentalBorder', val: rt.create_array([
					rt.ArrayItem{ key: 'radius', val: true },
					rt.ArrayItem{ key: 'color', val: true },
					rt.ArrayItem{ key: 'width', val: true },
					rt.ArrayItem{ key: 'style', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'radius', val: true },
						rt.ArrayItem{ key: 'color', val: true },
						rt.ArrayItem{ key: 'width', val: true },
						rt.ArrayItem{ key: 'style', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'interactivity', val: true },
			]) },
			rt.ArrayItem{ key: 'editorStyle', val: 'wp-block-file-editor' },
			rt.ArrayItem{ key: 'style', val: 'wp-block-file' },
		]) },
		rt.ArrayItem{ key: 'footnotes', val: rt.create_array([
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: 'name', val: 'core/footnotes' },
			rt.ArrayItem{ key: 'title', val: 'Footnotes' },
			rt.ArrayItem{ key: 'category', val: 'text' },
			rt.ArrayItem{ key: 'description', val: 'Display footnotes added to the page.' },
			rt.ArrayItem{ key: 'keywords', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'references' },
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'default' },
			rt.ArrayItem{ key: 'usesContext', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'postId' },
				rt.ArrayItem{ key: none, val: 'postType' },
			]) },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'anchor', val: true },
				rt.ArrayItem{ key: '__experimentalBorder', val: rt.create_array([
					rt.ArrayItem{ key: 'radius', val: true },
					rt.ArrayItem{ key: 'color', val: true },
					rt.ArrayItem{ key: 'width', val: true },
					rt.ArrayItem{ key: 'style', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'radius', val: false },
						rt.ArrayItem{ key: 'color', val: false },
						rt.ArrayItem{ key: 'width', val: false },
						rt.ArrayItem{ key: 'style', val: false },
					]) },
				]) },
				rt.ArrayItem{ key: 'color', val: rt.create_array([
					rt.ArrayItem{ key: 'background', val: true },
					rt.ArrayItem{ key: 'link', val: true },
					rt.ArrayItem{ key: 'text', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'link', val: true },
						rt.ArrayItem{ key: 'text', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'multiple', val: false },
				rt.ArrayItem{ key: 'reusable', val: false },
				rt.ArrayItem{ key: 'inserter', val: false },
				rt.ArrayItem{ key: 'spacing', val: rt.create_array([
					rt.ArrayItem{ key: 'margin', val: true },
					rt.ArrayItem{ key: 'padding', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'margin', val: false },
						rt.ArrayItem{ key: 'padding', val: false },
					]) },
				]) },
				rt.ArrayItem{ key: 'typography', val: rt.create_array([
					rt.ArrayItem{ key: 'fontSize', val: true },
					rt.ArrayItem{ key: 'lineHeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontFamily', val: true },
					rt.ArrayItem{ key: '__experimentalTextDecoration', val: true },
					rt.ArrayItem{ key: '__experimentalFontStyle', val: true },
					rt.ArrayItem{ key: '__experimentalFontWeight', val: true },
					rt.ArrayItem{ key: '__experimentalLetterSpacing', val: true },
					rt.ArrayItem{ key: '__experimentalTextTransform', val: true },
					rt.ArrayItem{ key: '__experimentalWritingMode', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'fontSize', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'interactivity', val: rt.create_array([
					rt.ArrayItem{ key: 'clientNavigation', val: true },
				]) },
			]) },
			rt.ArrayItem{ key: 'style', val: 'wp-block-footnotes' },
		]) },
		rt.ArrayItem{ key: 'freeform', val: rt.create_array([
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: 'name', val: 'core/freeform' },
			rt.ArrayItem{ key: 'title', val: 'Classic' },
			rt.ArrayItem{ key: 'category', val: 'text' },
			rt.ArrayItem{ key: 'description', val: 'Use the classic WordPress editor.' },
			rt.ArrayItem{ key: 'textdomain', val: 'default' },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'content', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'source', val: 'raw' },
				]) },
			]) },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'className', val: false },
				rt.ArrayItem{ key: 'customClassName', val: false },
				rt.ArrayItem{ key: 'lock', val: false },
				rt.ArrayItem{ key: 'reusable', val: false },
				rt.ArrayItem{ key: 'renaming', val: false },
				rt.ArrayItem{ key: 'visibility', val: false },
				rt.ArrayItem{ key: 'customCSS', val: false },
			]) },
			rt.ArrayItem{ key: 'editorStyle', val: 'wp-block-freeform-editor' },
		]) },
		rt.ArrayItem{ key: 'gallery', val: rt.create_array([
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: 'name', val: 'core/gallery' },
			rt.ArrayItem{ key: 'title', val: 'Gallery' },
			rt.ArrayItem{ key: 'category', val: 'media' },
			rt.ArrayItem{ key: 'usesContext', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'galleryId' },
			]) },
			rt.ArrayItem{ key: 'allowedBlocks', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'core/image' },
			]) },
			rt.ArrayItem{ key: 'description', val: 'Display multiple images in a rich gallery.' },
			rt.ArrayItem{ key: 'keywords', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'images' },
				rt.ArrayItem{ key: none, val: 'photos' },
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'default' },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'images', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'array' },
					rt.ArrayItem{ key: 'default', val: rt.new_array() },
					rt.ArrayItem{ key: 'source', val: 'query' },
					rt.ArrayItem{ key: 'selector', val: '.blocks-gallery-item' },
					rt.ArrayItem{ key: 'query', val: rt.create_array([
						rt.ArrayItem{ key: 'url', val: rt.create_array([
							rt.ArrayItem{ key: 'type', val: 'string' },
							rt.ArrayItem{ key: 'source', val: 'attribute' },
							rt.ArrayItem{ key: 'selector', val: 'img' },
							rt.ArrayItem{ key: 'attribute', val: 'src' },
						]) },
						rt.ArrayItem{ key: 'fullUrl', val: rt.create_array([
							rt.ArrayItem{ key: 'type', val: 'string' },
							rt.ArrayItem{ key: 'source', val: 'attribute' },
							rt.ArrayItem{ key: 'selector', val: 'img' },
							rt.ArrayItem{ key: 'attribute', val: 'data-full-url' },
						]) },
						rt.ArrayItem{ key: 'link', val: rt.create_array([
							rt.ArrayItem{ key: 'type', val: 'string' },
							rt.ArrayItem{ key: 'source', val: 'attribute' },
							rt.ArrayItem{ key: 'selector', val: 'img' },
							rt.ArrayItem{ key: 'attribute', val: 'data-link' },
						]) },
						rt.ArrayItem{ key: 'alt', val: rt.create_array([
							rt.ArrayItem{ key: 'type', val: 'string' },
							rt.ArrayItem{ key: 'source', val: 'attribute' },
							rt.ArrayItem{ key: 'selector', val: 'img' },
							rt.ArrayItem{ key: 'attribute', val: 'alt' },
							rt.ArrayItem{ key: 'default', val: '' },
						]) },
						rt.ArrayItem{ key: 'id', val: rt.create_array([
							rt.ArrayItem{ key: 'type', val: 'string' },
							rt.ArrayItem{ key: 'source', val: 'attribute' },
							rt.ArrayItem{ key: 'selector', val: 'img' },
							rt.ArrayItem{ key: 'attribute', val: 'data-id' },
						]) },
						rt.ArrayItem{ key: 'caption', val: rt.create_array([
							rt.ArrayItem{ key: 'type', val: 'rich-text' },
							rt.ArrayItem{ key: 'source', val: 'rich-text' },
							rt.ArrayItem{ key: 'selector', val: '.blocks-gallery-item__caption' },
						]) },
					]) },
				]) },
				rt.ArrayItem{ key: 'ids', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'array' },
					rt.ArrayItem{ key: 'items', val: rt.create_array([
						rt.ArrayItem{ key: 'type', val: 'number' },
					]) },
					rt.ArrayItem{ key: 'default', val: rt.new_array() },
				]) },
				rt.ArrayItem{ key: 'navigationButtonType', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: 'icon' },
					rt.ArrayItem{ key: 'enum', val: rt.create_array([
						rt.ArrayItem{ key: none, val: 'icon' },
						rt.ArrayItem{ key: none, val: 'text' },
						rt.ArrayItem{ key: none, val: 'both' },
					]) },
				]) },
				rt.ArrayItem{ key: 'shortCodeTransforms', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'array' },
					rt.ArrayItem{ key: 'items', val: rt.create_array([
						rt.ArrayItem{ key: 'type', val: 'object' },
					]) },
					rt.ArrayItem{ key: 'default', val: rt.new_array() },
				]) },
				rt.ArrayItem{ key: 'columns', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'number' },
					rt.ArrayItem{ key: 'minimum', val: 1 },
					rt.ArrayItem{ key: 'maximum', val: 8 },
				]) },
				rt.ArrayItem{ key: 'caption', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'rich-text' },
					rt.ArrayItem{ key: 'source', val: 'rich-text' },
					rt.ArrayItem{ key: 'selector', val: '.blocks-gallery-caption' },
					rt.ArrayItem{ key: 'role', val: 'content' },
				]) },
				rt.ArrayItem{ key: 'imageCrop', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: true },
				]) },
				rt.ArrayItem{ key: 'randomOrder', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: false },
				]) },
				rt.ArrayItem{ key: 'fixedHeight', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: true },
				]) },
				rt.ArrayItem{ key: 'linkTarget', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
				rt.ArrayItem{ key: 'linkTo', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
				rt.ArrayItem{ key: 'sizeSlug', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: 'large' },
				]) },
				rt.ArrayItem{ key: 'allowResize', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: false },
				]) },
				rt.ArrayItem{ key: 'aspectRatio', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: 'auto' },
				]) },
			]) },
			rt.ArrayItem{ key: 'providesContext', val: rt.create_array([
				rt.ArrayItem{ key: 'allowResize', val: 'allowResize' },
				rt.ArrayItem{ key: 'imageCrop', val: 'imageCrop' },
				rt.ArrayItem{ key: 'fixedHeight', val: 'fixedHeight' },
				rt.ArrayItem{ key: 'navigationButtonType', val: 'navigationButtonType' },
			]) },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'anchor', val: true },
				rt.ArrayItem{ key: 'align', val: true },
				rt.ArrayItem{ key: '__experimentalBorder', val: rt.create_array([
					rt.ArrayItem{ key: 'radius', val: true },
					rt.ArrayItem{ key: 'color', val: true },
					rt.ArrayItem{ key: 'width', val: true },
					rt.ArrayItem{ key: 'style', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'color', val: true },
						rt.ArrayItem{ key: 'radius', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'units', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'px' },
					rt.ArrayItem{ key: none, val: 'em' },
					rt.ArrayItem{ key: none, val: 'rem' },
					rt.ArrayItem{ key: none, val: 'vh' },
					rt.ArrayItem{ key: none, val: 'vw' },
				]) },
				rt.ArrayItem{ key: 'spacing', val: rt.create_array([
					rt.ArrayItem{ key: 'margin', val: true },
					rt.ArrayItem{ key: 'padding', val: true },
					rt.ArrayItem{ key: 'blockGap', val: rt.create_array([
						rt.ArrayItem{ key: none, val: 'horizontal' },
						rt.ArrayItem{ key: none, val: 'vertical' },
					]) },
					rt.ArrayItem{ key: '__experimentalSkipSerialization', val: rt.create_array([
						rt.ArrayItem{ key: none, val: 'blockGap' },
					]) },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'blockGap', val: true },
						rt.ArrayItem{ key: 'margin', val: false },
						rt.ArrayItem{ key: 'padding', val: false },
					]) },
				]) },
				rt.ArrayItem{ key: 'color', val: rt.create_array([
					rt.ArrayItem{ key: 'text', val: false },
					rt.ArrayItem{ key: 'background', val: true },
					rt.ArrayItem{ key: 'gradients', val: true },
				]) },
				rt.ArrayItem{ key: 'layout', val: rt.create_array([
					rt.ArrayItem{ key: 'allowSwitching', val: false },
					rt.ArrayItem{ key: 'allowInheriting', val: false },
					rt.ArrayItem{ key: 'allowEditing', val: false },
					rt.ArrayItem{ key: 'default', val: rt.create_array([
						rt.ArrayItem{ key: 'type', val: 'flex' },
					]) },
				]) },
				rt.ArrayItem{ key: 'interactivity', val: rt.create_array([
					rt.ArrayItem{ key: 'clientNavigation', val: true },
				]) },
				rt.ArrayItem{ key: 'listView', val: true },
			]) },
			rt.ArrayItem{ key: 'editorStyle', val: 'wp-block-gallery-editor' },
			rt.ArrayItem{ key: 'style', val: 'wp-block-gallery' },
		]) },
		rt.ArrayItem{ key: 'group', val: rt.create_array([
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: 'name', val: 'core/group' },
			rt.ArrayItem{ key: 'title', val: 'Group' },
			rt.ArrayItem{ key: 'category', val: 'design' },
			rt.ArrayItem{ key: 'description', val: 'Gather blocks in a layout container.' },
			rt.ArrayItem{ key: 'keywords', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'container' },
				rt.ArrayItem{ key: none, val: 'wrapper' },
				rt.ArrayItem{ key: none, val: 'row' },
				rt.ArrayItem{ key: none, val: 'section' },
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'default' },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'tagName', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: 'div' },
				]) },
				rt.ArrayItem{ key: 'templateLock', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: rt.create_array([
						rt.ArrayItem{ key: none, val: 'string' },
						rt.ArrayItem{ key: none, val: 'boolean' },
					]) },
					rt.ArrayItem{ key: 'enum', val: rt.create_array([
						rt.ArrayItem{ key: none, val: 'all' },
						rt.ArrayItem{ key: none, val: 'insert' },
						rt.ArrayItem{ key: none, val: 'contentOnly' },
						rt.ArrayItem{ key: none, val: false },
					]) },
				]) },
			]) },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: '__experimentalOnEnter', val: true },
				rt.ArrayItem{ key: '__experimentalOnMerge', val: true },
				rt.ArrayItem{ key: '__experimentalSettings', val: true },
				rt.ArrayItem{ key: 'align', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'wide' },
					rt.ArrayItem{ key: none, val: 'full' },
				]) },
				rt.ArrayItem{ key: 'anchor', val: true },
				rt.ArrayItem{ key: 'ariaLabel', val: true },
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'background', val: rt.create_array([
					rt.ArrayItem{ key: 'backgroundImage', val: true },
					rt.ArrayItem{ key: 'backgroundSize', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'backgroundImage', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'color', val: rt.create_array([
					rt.ArrayItem{ key: 'gradients', val: true },
					rt.ArrayItem{ key: 'heading', val: true },
					rt.ArrayItem{ key: 'button', val: true },
					rt.ArrayItem{ key: 'link', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'background', val: true },
						rt.ArrayItem{ key: 'text', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'shadow', val: true },
				rt.ArrayItem{ key: 'spacing', val: rt.create_array([
					rt.ArrayItem{ key: 'margin', val: rt.create_array([
						rt.ArrayItem{ key: none, val: 'top' },
						rt.ArrayItem{ key: none, val: 'bottom' },
					]) },
					rt.ArrayItem{ key: 'padding', val: true },
					rt.ArrayItem{ key: 'blockGap', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'padding', val: true },
						rt.ArrayItem{ key: 'blockGap', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'dimensions', val: rt.create_array([
					rt.ArrayItem{ key: 'minHeight', val: true },
				]) },
				rt.ArrayItem{ key: '__experimentalBorder', val: rt.create_array([
					rt.ArrayItem{ key: 'color', val: true },
					rt.ArrayItem{ key: 'radius', val: true },
					rt.ArrayItem{ key: 'style', val: true },
					rt.ArrayItem{ key: 'width', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'color', val: true },
						rt.ArrayItem{ key: 'radius', val: true },
						rt.ArrayItem{ key: 'style', val: true },
						rt.ArrayItem{ key: 'width', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'position', val: rt.create_array([
					rt.ArrayItem{ key: 'sticky', val: true },
				]) },
				rt.ArrayItem{ key: 'typography', val: rt.create_array([
					rt.ArrayItem{ key: 'fontSize', val: true },
					rt.ArrayItem{ key: 'lineHeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontFamily', val: true },
					rt.ArrayItem{ key: '__experimentalFontWeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontStyle', val: true },
					rt.ArrayItem{ key: '__experimentalTextTransform', val: true },
					rt.ArrayItem{ key: '__experimentalTextDecoration', val: true },
					rt.ArrayItem{ key: '__experimentalLetterSpacing', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'fontSize', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'layout', val: rt.create_array([
					rt.ArrayItem{ key: 'allowSizingOnChildren', val: true },
				]) },
				rt.ArrayItem{ key: 'interactivity', val: rt.create_array([
					rt.ArrayItem{ key: 'clientNavigation', val: true },
				]) },
				rt.ArrayItem{ key: 'allowedBlocks', val: true },
			]) },
			rt.ArrayItem{ key: 'editorStyle', val: 'wp-block-group-editor' },
			rt.ArrayItem{ key: 'style', val: 'wp-block-group' },
		]) },
		rt.ArrayItem{ key: 'heading', val: rt.create_array([
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: 'name', val: 'core/heading' },
			rt.ArrayItem{ key: 'title', val: 'Heading' },
			rt.ArrayItem{ key: 'category', val: 'text' },
			rt.ArrayItem{
				key: 'description'
				val: 'Introduce new sections and organize content to help visitors (and search engines) understand the structure of your content.'
			},
			rt.ArrayItem{ key: 'keywords', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'title' },
				rt.ArrayItem{ key: none, val: 'subtitle' },
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'default' },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'content', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'rich-text' },
					rt.ArrayItem{ key: 'source', val: 'rich-text' },
					rt.ArrayItem{ key: 'selector', val: 'h1,h2,h3,h4,h5,h6' },
					rt.ArrayItem{ key: 'role', val: 'content' },
				]) },
				rt.ArrayItem{ key: 'level', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'number' },
					rt.ArrayItem{ key: 'default', val: 2 },
				]) },
				rt.ArrayItem{ key: 'levelOptions', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'array' },
				]) },
				rt.ArrayItem{ key: 'placeholder', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
			]) },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'align', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'wide' },
					rt.ArrayItem{ key: none, val: 'full' },
				]) },
				rt.ArrayItem{ key: 'anchor', val: true },
				rt.ArrayItem{ key: 'className', val: true },
				rt.ArrayItem{ key: 'splitting', val: true },
				rt.ArrayItem{ key: '__experimentalBorder', val: rt.create_array([
					rt.ArrayItem{ key: 'color', val: true },
					rt.ArrayItem{ key: 'radius', val: true },
					rt.ArrayItem{ key: 'style', val: true },
					rt.ArrayItem{ key: 'width', val: true },
				]) },
				rt.ArrayItem{ key: 'color', val: rt.create_array([
					rt.ArrayItem{ key: 'gradients', val: true },
					rt.ArrayItem{ key: 'link', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'background', val: true },
						rt.ArrayItem{ key: 'text', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'spacing', val: rt.create_array([
					rt.ArrayItem{ key: 'margin', val: true },
					rt.ArrayItem{ key: 'padding', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'margin', val: false },
						rt.ArrayItem{ key: 'padding', val: false },
					]) },
				]) },
				rt.ArrayItem{ key: 'typography', val: rt.create_array([
					rt.ArrayItem{ key: 'fontSize', val: true },
					rt.ArrayItem{ key: 'lineHeight', val: true },
					rt.ArrayItem{ key: 'textAlign', val: true },
					rt.ArrayItem{ key: '__experimentalFontFamily', val: true },
					rt.ArrayItem{ key: '__experimentalFontStyle', val: true },
					rt.ArrayItem{ key: '__experimentalFontWeight', val: true },
					rt.ArrayItem{ key: '__experimentalLetterSpacing', val: true },
					rt.ArrayItem{ key: '__experimentalTextTransform', val: true },
					rt.ArrayItem{ key: '__experimentalTextDecoration', val: true },
					rt.ArrayItem{ key: '__experimentalWritingMode', val: true },
					rt.ArrayItem{ key: 'fitText', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'fontSize', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: '__unstablePasteTextInline', val: true },
				rt.ArrayItem{ key: '__experimentalSlashInserter', val: true },
				rt.ArrayItem{ key: 'interactivity', val: rt.create_array([
					rt.ArrayItem{ key: 'clientNavigation', val: true },
				]) },
			]) },
			rt.ArrayItem{ key: 'editorStyle', val: 'wp-block-heading-editor' },
			rt.ArrayItem{ key: 'style', val: 'wp-block-heading' },
		]) },
		rt.ArrayItem{ key: 'home-link', val: rt.create_array([
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: 'name', val: 'core/home-link' },
			rt.ArrayItem{ key: 'category', val: 'design' },
			rt.ArrayItem{ key: 'parent', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'core/navigation' },
			]) },
			rt.ArrayItem{ key: 'title', val: 'Home Link' },
			rt.ArrayItem{
				key: 'description'
				val: 'Create a link that always points to the homepage of the site. Usually not necessary if there is already a site title link present in the header.'
			},
			rt.ArrayItem{ key: 'textdomain', val: 'default' },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'label', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'role', val: 'content' },
				]) },
			]) },
			rt.ArrayItem{ key: 'usesContext', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'textColor' },
				rt.ArrayItem{ key: none, val: 'customTextColor' },
				rt.ArrayItem{ key: none, val: 'backgroundColor' },
				rt.ArrayItem{ key: none, val: 'customBackgroundColor' },
				rt.ArrayItem{ key: none, val: 'fontSize' },
				rt.ArrayItem{ key: none, val: 'customFontSize' },
				rt.ArrayItem{ key: none, val: 'style' },
			]) },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'anchor', val: true },
				rt.ArrayItem{ key: 'reusable', val: false },
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'typography', val: rt.create_array([
					rt.ArrayItem{ key: 'fontSize', val: true },
					rt.ArrayItem{ key: 'lineHeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontFamily', val: true },
					rt.ArrayItem{ key: '__experimentalFontWeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontStyle', val: true },
					rt.ArrayItem{ key: '__experimentalTextTransform', val: true },
					rt.ArrayItem{ key: '__experimentalTextDecoration', val: true },
					rt.ArrayItem{ key: '__experimentalLetterSpacing', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'fontSize', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'interactivity', val: rt.create_array([
					rt.ArrayItem{ key: 'clientNavigation', val: true },
				]) },
			]) },
			rt.ArrayItem{ key: 'editorStyle', val: 'wp-block-home-link-editor' },
			rt.ArrayItem{ key: 'style', val: 'wp-block-home-link' },
		]) },
		rt.ArrayItem{ key: 'html', val: rt.create_array([
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: 'name', val: 'core/html' },
			rt.ArrayItem{ key: 'title', val: 'Custom HTML' },
			rt.ArrayItem{ key: 'category', val: 'widgets' },
			rt.ArrayItem{
				key: 'description'
				val: 'Add custom HTML code and preview it as you edit.'
			},
			rt.ArrayItem{ key: 'keywords', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'embed' },
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'default' },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'content', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'source', val: 'raw' },
					rt.ArrayItem{ key: 'role', val: 'content' },
				]) },
			]) },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'customClassName', val: false },
				rt.ArrayItem{ key: 'className', val: false },
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'interactivity', val: rt.create_array([
					rt.ArrayItem{ key: 'clientNavigation', val: true },
				]) },
				rt.ArrayItem{ key: 'customCSS', val: false },
				rt.ArrayItem{ key: 'visibility', val: false },
			]) },
			rt.ArrayItem{ key: 'editorStyle', val: 'wp-block-html-editor' },
		]) },
		rt.ArrayItem{ key: 'icon', val: rt.create_array([
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'name', val: 'core/icon' },
			rt.ArrayItem{ key: 'title', val: 'Icon' },
			rt.ArrayItem{ key: 'category', val: 'media' },
			rt.ArrayItem{ key: 'description', val: 'Insert an SVG icon.' },
			rt.ArrayItem{ key: 'keywords', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'icon' },
				rt.ArrayItem{ key: none, val: 'svg' },
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'default' },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'icon', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'role', val: 'content' },
				]) },
			]) },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'anchor', val: true },
				rt.ArrayItem{ key: 'ariaLabel', val: rt.create_array([
					rt.ArrayItem{ key: '__experimentalSkipSerialization', val: true },
				]) },
				rt.ArrayItem{ key: 'align', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'left' },
					rt.ArrayItem{ key: none, val: 'center' },
					rt.ArrayItem{ key: none, val: 'right' },
				]) },
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'color', val: rt.create_array([
					rt.ArrayItem{ key: 'background', val: true },
					rt.ArrayItem{ key: 'text', val: true },
					rt.ArrayItem{ key: '__experimentalSkipSerialization', val: true },
				]) },
				rt.ArrayItem{ key: 'interactivity', val: rt.create_array([
					rt.ArrayItem{ key: 'clientNavigation', val: true },
				]) },
				rt.ArrayItem{ key: '__experimentalBorder', val: rt.create_array([
					rt.ArrayItem{ key: 'color', val: true },
					rt.ArrayItem{ key: 'radius', val: true },
					rt.ArrayItem{ key: 'style', val: true },
					rt.ArrayItem{ key: 'width', val: true },
					rt.ArrayItem{ key: '__experimentalSkipSerialization', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'color', val: false },
						rt.ArrayItem{ key: 'radius', val: false },
						rt.ArrayItem{ key: 'style', val: false },
						rt.ArrayItem{ key: 'width', val: false },
					]) },
				]) },
				rt.ArrayItem{ key: 'spacing', val: rt.create_array([
					rt.ArrayItem{ key: 'padding', val: true },
					rt.ArrayItem{ key: 'margin', val: true },
					rt.ArrayItem{ key: '__experimentalSkipSerialization', val: rt.create_array([
						rt.ArrayItem{ key: none, val: 'padding' },
					]) },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'margin', val: false },
						rt.ArrayItem{ key: 'padding', val: false },
					]) },
				]) },
				rt.ArrayItem{ key: 'dimensions', val: rt.create_array([
					rt.ArrayItem{ key: 'width', val: true },
					rt.ArrayItem{ key: '__experimentalSkipSerialization', val: rt.create_array([
						rt.ArrayItem{ key: none, val: 'width' },
					]) },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'width', val: true },
					]) },
				]) },
			]) },
			rt.ArrayItem{ key: 'selectors', val: rt.create_array([
				rt.ArrayItem{ key: 'root', val: '.wp-block-icon svg' },
				rt.ArrayItem{ key: 'css', val: '.wp-block-icon' },
				rt.ArrayItem{ key: 'spacing', val: rt.create_array([
					rt.ArrayItem{ key: 'margin', val: '.wp-block-icon' },
				]) },
			]) },
			rt.ArrayItem{ key: 'style', val: 'wp-block-icon' },
			rt.ArrayItem{ key: 'editorStyle', val: 'wp-block-icon-editor' },
		]) },
		rt.ArrayItem{ key: 'image', val: rt.create_array([
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: 'name', val: 'core/image' },
			rt.ArrayItem{ key: 'title', val: 'Image' },
			rt.ArrayItem{ key: 'category', val: 'media' },
			rt.ArrayItem{ key: 'usesContext', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'allowResize' },
				rt.ArrayItem{ key: none, val: 'imageCrop' },
				rt.ArrayItem{ key: none, val: 'fixedHeight' },
				rt.ArrayItem{ key: none, val: 'navigationButtonType' },
				rt.ArrayItem{ key: none, val: 'postId' },
				rt.ArrayItem{ key: none, val: 'postType' },
				rt.ArrayItem{ key: none, val: 'queryId' },
				rt.ArrayItem{ key: none, val: 'galleryId' },
			]) },
			rt.ArrayItem{ key: 'description', val: 'Insert an image to make a visual statement.' },
			rt.ArrayItem{ key: 'keywords', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'img' },
				rt.ArrayItem{ key: none, val: 'photo' },
				rt.ArrayItem{ key: none, val: 'picture' },
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'default' },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'blob', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'role', val: 'local' },
				]) },
				rt.ArrayItem{ key: 'url', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'source', val: 'attribute' },
					rt.ArrayItem{ key: 'selector', val: 'img' },
					rt.ArrayItem{ key: 'attribute', val: 'src' },
					rt.ArrayItem{ key: 'role', val: 'content' },
				]) },
				rt.ArrayItem{ key: 'alt', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'source', val: 'attribute' },
					rt.ArrayItem{ key: 'selector', val: 'img' },
					rt.ArrayItem{ key: 'attribute', val: 'alt' },
					rt.ArrayItem{ key: 'default', val: '' },
					rt.ArrayItem{ key: 'role', val: 'content' },
				]) },
				rt.ArrayItem{ key: 'caption', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'rich-text' },
					rt.ArrayItem{ key: 'source', val: 'rich-text' },
					rt.ArrayItem{ key: 'selector', val: 'figcaption' },
					rt.ArrayItem{ key: 'role', val: 'content' },
				]) },
				rt.ArrayItem{ key: 'lightbox', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'object' },
					rt.ArrayItem{ key: 'enabled', val: rt.create_array([
						rt.ArrayItem{ key: 'type', val: 'boolean' },
					]) },
				]) },
				rt.ArrayItem{ key: 'title', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'source', val: 'attribute' },
					rt.ArrayItem{ key: 'selector', val: 'img' },
					rt.ArrayItem{ key: 'attribute', val: 'title' },
					rt.ArrayItem{ key: 'role', val: 'content' },
				]) },
				rt.ArrayItem{ key: 'href', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'source', val: 'attribute' },
					rt.ArrayItem{ key: 'selector', val: 'figure > a' },
					rt.ArrayItem{ key: 'attribute', val: 'href' },
					rt.ArrayItem{ key: 'role', val: 'content' },
				]) },
				rt.ArrayItem{ key: 'rel', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'source', val: 'attribute' },
					rt.ArrayItem{ key: 'selector', val: 'figure > a' },
					rt.ArrayItem{ key: 'attribute', val: 'rel' },
				]) },
				rt.ArrayItem{ key: 'linkClass', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'source', val: 'attribute' },
					rt.ArrayItem{ key: 'selector', val: 'figure > a' },
					rt.ArrayItem{ key: 'attribute', val: 'class' },
				]) },
				rt.ArrayItem{ key: 'id', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'number' },
					rt.ArrayItem{ key: 'role', val: 'content' },
				]) },
				rt.ArrayItem{ key: 'width', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
				rt.ArrayItem{ key: 'height', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
				rt.ArrayItem{ key: 'aspectRatio', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
				rt.ArrayItem{ key: 'scale', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
				rt.ArrayItem{ key: 'focalPoint', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'object' },
				]) },
				rt.ArrayItem{ key: 'sizeSlug', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
				rt.ArrayItem{ key: 'linkDestination', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
				rt.ArrayItem{ key: 'linkTarget', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'source', val: 'attribute' },
					rt.ArrayItem{ key: 'selector', val: 'figure > a' },
					rt.ArrayItem{ key: 'attribute', val: 'target' },
				]) },
			]) },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'interactivity', val: true },
				rt.ArrayItem{ key: 'align', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'left' },
					rt.ArrayItem{ key: none, val: 'center' },
					rt.ArrayItem{ key: none, val: 'right' },
					rt.ArrayItem{ key: none, val: 'wide' },
					rt.ArrayItem{ key: none, val: 'full' },
				]) },
				rt.ArrayItem{ key: 'anchor', val: true },
				rt.ArrayItem{ key: 'color', val: rt.create_array([
					rt.ArrayItem{ key: 'text', val: false },
					rt.ArrayItem{ key: 'background', val: false },
				]) },
				rt.ArrayItem{ key: 'filter', val: rt.create_array([
					rt.ArrayItem{ key: 'duotone', val: true },
				]) },
				rt.ArrayItem{ key: 'spacing', val: rt.create_array([
					rt.ArrayItem{ key: 'margin', val: true },
				]) },
				rt.ArrayItem{ key: '__experimentalBorder', val: rt.create_array([
					rt.ArrayItem{ key: 'color', val: true },
					rt.ArrayItem{ key: 'radius', val: true },
					rt.ArrayItem{ key: 'width', val: true },
					rt.ArrayItem{ key: '__experimentalSkipSerialization', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'color', val: true },
						rt.ArrayItem{ key: 'radius', val: true },
						rt.ArrayItem{ key: 'width', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'shadow', val: rt.create_array([
					rt.ArrayItem{ key: '__experimentalSkipSerialization', val: true },
				]) },
			]) },
			rt.ArrayItem{ key: 'selectors', val: rt.create_array([
				rt.ArrayItem{
					key: 'border'
					val: '.wp-block-image img, .wp-block-image .wp-block-image__crop-area, .wp-block-image .components-placeholder'
				},
				rt.ArrayItem{
					key: 'shadow'
					val: '.wp-block-image img, .wp-block-image .wp-block-image__crop-area, .wp-block-image .components-placeholder'
				},
				rt.ArrayItem{ key: 'filter', val: rt.create_array([
					rt.ArrayItem{
						key: 'duotone'
						val: '.wp-block-image img, .wp-block-image .components-placeholder'
					},
				]) },
			]) },
			rt.ArrayItem{ key: 'styles', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.create_array([
					rt.ArrayItem{ key: 'name', val: 'default' },
					rt.ArrayItem{ key: 'label', val: 'Default' },
					rt.ArrayItem{ key: 'isDefault', val: true },
				]) },
				rt.ArrayItem{ key: none, val: rt.create_array([
					rt.ArrayItem{ key: 'name', val: 'rounded' },
					rt.ArrayItem{ key: 'label', val: 'Rounded' },
				]) },
			]) },
			rt.ArrayItem{ key: 'editorStyle', val: 'wp-block-image-editor' },
			rt.ArrayItem{ key: 'style', val: 'wp-block-image' },
		]) },
		rt.ArrayItem{ key: 'latest-comments', val: rt.create_array([
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: 'name', val: 'core/latest-comments' },
			rt.ArrayItem{ key: 'title', val: 'Latest Comments' },
			rt.ArrayItem{ key: 'category', val: 'widgets' },
			rt.ArrayItem{ key: 'description', val: 'Display a list of your most recent comments.' },
			rt.ArrayItem{ key: 'keywords', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'recent comments' },
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'default' },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'commentsToShow', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'number' },
					rt.ArrayItem{ key: 'default', val: 5 },
					rt.ArrayItem{ key: 'minimum', val: 1 },
					rt.ArrayItem{ key: 'maximum', val: 100 },
				]) },
				rt.ArrayItem{ key: 'displayAvatar', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: true },
				]) },
				rt.ArrayItem{ key: 'displayDate', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: true },
				]) },
				rt.ArrayItem{ key: 'displayContent', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: 'excerpt' },
					rt.ArrayItem{ key: 'enum', val: rt.create_array([
						rt.ArrayItem{ key: none, val: 'none' },
						rt.ArrayItem{ key: none, val: 'excerpt' },
						rt.ArrayItem{ key: none, val: 'full' },
					]) },
				]) },
			]) },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'anchor', val: true },
				rt.ArrayItem{ key: 'align', val: true },
				rt.ArrayItem{ key: 'color', val: rt.create_array([
					rt.ArrayItem{ key: 'gradients', val: true },
					rt.ArrayItem{ key: 'link', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'background', val: true },
						rt.ArrayItem{ key: 'text', val: true },
						rt.ArrayItem{ key: 'link', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'spacing', val: rt.create_array([
					rt.ArrayItem{ key: 'margin', val: true },
					rt.ArrayItem{ key: 'padding', val: true },
				]) },
				rt.ArrayItem{ key: 'typography', val: rt.create_array([
					rt.ArrayItem{ key: 'fontSize', val: true },
					rt.ArrayItem{ key: 'lineHeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontFamily', val: true },
					rt.ArrayItem{ key: '__experimentalFontWeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontStyle', val: true },
					rt.ArrayItem{ key: '__experimentalTextTransform', val: true },
					rt.ArrayItem{ key: '__experimentalTextDecoration', val: true },
					rt.ArrayItem{ key: '__experimentalLetterSpacing', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'fontSize', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'interactivity', val: rt.create_array([
					rt.ArrayItem{ key: 'clientNavigation', val: true },
				]) },
			]) },
			rt.ArrayItem{ key: 'style', val: 'wp-block-latest-comments' },
		]) },
		rt.ArrayItem{ key: 'latest-posts', val: rt.create_array([
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: 'name', val: 'core/latest-posts' },
			rt.ArrayItem{ key: 'title', val: 'Latest Posts' },
			rt.ArrayItem{ key: 'category', val: 'widgets' },
			rt.ArrayItem{ key: 'description', val: 'Display a list of your most recent posts.' },
			rt.ArrayItem{ key: 'keywords', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'recent posts' },
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'default' },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'categories', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'array' },
					rt.ArrayItem{ key: 'items', val: rt.create_array([
						rt.ArrayItem{ key: 'type', val: 'object' },
					]) },
				]) },
				rt.ArrayItem{ key: 'selectedAuthor', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'number' },
				]) },
				rt.ArrayItem{ key: 'postsToShow', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'number' },
					rt.ArrayItem{ key: 'default', val: 5 },
				]) },
				rt.ArrayItem{ key: 'displayPostContent', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: false },
				]) },
				rt.ArrayItem{ key: 'displayPostContentRadio', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: 'excerpt' },
				]) },
				rt.ArrayItem{ key: 'excerptLength', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'number' },
					rt.ArrayItem{ key: 'default', val: 55 },
				]) },
				rt.ArrayItem{ key: 'displayAuthor', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: false },
				]) },
				rt.ArrayItem{ key: 'displayPostDate', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: false },
				]) },
				rt.ArrayItem{ key: 'postLayout', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: 'list' },
				]) },
				rt.ArrayItem{ key: 'columns', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'number' },
					rt.ArrayItem{ key: 'default', val: 3 },
				]) },
				rt.ArrayItem{ key: 'order', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: 'desc' },
				]) },
				rt.ArrayItem{ key: 'orderBy', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: 'date' },
				]) },
				rt.ArrayItem{ key: 'displayFeaturedImage', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: false },
				]) },
				rt.ArrayItem{ key: 'featuredImageAlign', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'enum', val: rt.create_array([
						rt.ArrayItem{ key: none, val: 'left' },
						rt.ArrayItem{ key: none, val: 'center' },
						rt.ArrayItem{ key: none, val: 'right' },
					]) },
				]) },
				rt.ArrayItem{ key: 'featuredImageSizeSlug', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: 'thumbnail' },
				]) },
				rt.ArrayItem{ key: 'featuredImageSizeWidth', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'number' },
					rt.ArrayItem{ key: 'default', val: rt.new_null() },
				]) },
				rt.ArrayItem{ key: 'featuredImageSizeHeight', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'number' },
					rt.ArrayItem{ key: 'default', val: rt.new_null() },
				]) },
				rt.ArrayItem{ key: 'addLinkToFeaturedImage', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: false },
				]) },
			]) },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'anchor', val: true },
				rt.ArrayItem{ key: 'align', val: true },
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'color', val: rt.create_array([
					rt.ArrayItem{ key: 'gradients', val: true },
					rt.ArrayItem{ key: 'link', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'background', val: true },
						rt.ArrayItem{ key: 'text', val: true },
						rt.ArrayItem{ key: 'link', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'spacing', val: rt.create_array([
					rt.ArrayItem{ key: 'margin', val: true },
					rt.ArrayItem{ key: 'padding', val: true },
				]) },
				rt.ArrayItem{ key: 'typography', val: rt.create_array([
					rt.ArrayItem{ key: 'fontSize', val: true },
					rt.ArrayItem{ key: 'lineHeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontFamily', val: true },
					rt.ArrayItem{ key: '__experimentalFontWeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontStyle', val: true },
					rt.ArrayItem{ key: '__experimentalTextTransform', val: true },
					rt.ArrayItem{ key: '__experimentalTextDecoration', val: true },
					rt.ArrayItem{ key: '__experimentalLetterSpacing', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'fontSize', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: '__experimentalBorder', val: rt.create_array([
					rt.ArrayItem{ key: 'radius', val: true },
					rt.ArrayItem{ key: 'color', val: true },
					rt.ArrayItem{ key: 'width', val: true },
					rt.ArrayItem{ key: 'style', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'radius', val: true },
						rt.ArrayItem{ key: 'color', val: true },
						rt.ArrayItem{ key: 'width', val: true },
						rt.ArrayItem{ key: 'style', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'interactivity', val: rt.create_array([
					rt.ArrayItem{ key: 'clientNavigation', val: true },
				]) },
			]) },
			rt.ArrayItem{ key: 'editorStyle', val: 'wp-block-latest-posts-editor' },
			rt.ArrayItem{ key: 'style', val: 'wp-block-latest-posts' },
		]) },
		rt.ArrayItem{ key: 'legacy-widget', val: rt.create_array([
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: 'name', val: 'core/legacy-widget' },
			rt.ArrayItem{ key: 'title', val: 'Legacy Widget' },
			rt.ArrayItem{ key: 'category', val: 'widgets' },
			rt.ArrayItem{ key: 'description', val: 'Display a legacy widget.' },
			rt.ArrayItem{ key: 'textdomain', val: 'default' },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'id', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: rt.new_null() },
				]) },
				rt.ArrayItem{ key: 'idBase', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: rt.new_null() },
				]) },
				rt.ArrayItem{ key: 'instance', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'object' },
					rt.ArrayItem{ key: 'default', val: rt.new_null() },
				]) },
			]) },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'customClassName', val: false },
				rt.ArrayItem{ key: 'reusable', val: false },
			]) },
			rt.ArrayItem{ key: 'editorStyle', val: 'wp-block-legacy-widget-editor' },
		]) },
		rt.ArrayItem{ key: 'list', val: rt.create_array([
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: 'name', val: 'core/list' },
			rt.ArrayItem{ key: 'title', val: 'List' },
			rt.ArrayItem{ key: 'category', val: 'text' },
			rt.ArrayItem{ key: 'allowedBlocks', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'core/list-item' },
			]) },
			rt.ArrayItem{
				key: 'description'
				val: 'An organized collection of items displayed in a specific order.'
			},
			rt.ArrayItem{ key: 'keywords', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'bullet list' },
				rt.ArrayItem{ key: none, val: 'ordered list' },
				rt.ArrayItem{ key: none, val: 'numbered list' },
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'default' },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'ordered', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: false },
					rt.ArrayItem{ key: 'role', val: 'content' },
				]) },
				rt.ArrayItem{ key: 'values', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'source', val: 'html' },
					rt.ArrayItem{ key: 'selector', val: 'ol,ul' },
					rt.ArrayItem{ key: 'multiline', val: 'li' },
					rt.ArrayItem{ key: 'default', val: '' },
					rt.ArrayItem{ key: 'role', val: 'content' },
				]) },
				rt.ArrayItem{ key: 'type', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
				rt.ArrayItem{ key: 'start', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'number' },
				]) },
				rt.ArrayItem{ key: 'reversed', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
				]) },
				rt.ArrayItem{ key: 'placeholder', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
			]) },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'anchor', val: true },
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: '__experimentalBorder', val: rt.create_array([
					rt.ArrayItem{ key: 'color', val: true },
					rt.ArrayItem{ key: 'radius', val: true },
					rt.ArrayItem{ key: 'style', val: true },
					rt.ArrayItem{ key: 'width', val: true },
				]) },
				rt.ArrayItem{ key: 'typography', val: rt.create_array([
					rt.ArrayItem{ key: 'fontSize', val: true },
					rt.ArrayItem{ key: 'lineHeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontFamily', val: true },
					rt.ArrayItem{ key: '__experimentalFontWeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontStyle', val: true },
					rt.ArrayItem{ key: '__experimentalTextTransform', val: true },
					rt.ArrayItem{ key: '__experimentalTextDecoration', val: true },
					rt.ArrayItem{ key: '__experimentalLetterSpacing', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'fontSize', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'color', val: rt.create_array([
					rt.ArrayItem{ key: 'gradients', val: true },
					rt.ArrayItem{ key: 'link', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'background', val: true },
						rt.ArrayItem{ key: 'text', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'spacing', val: rt.create_array([
					rt.ArrayItem{ key: 'margin', val: true },
					rt.ArrayItem{ key: 'padding', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'margin', val: false },
						rt.ArrayItem{ key: 'padding', val: false },
					]) },
				]) },
				rt.ArrayItem{ key: '__unstablePasteTextInline', val: true },
				rt.ArrayItem{ key: '__experimentalOnMerge', val: true },
				rt.ArrayItem{ key: '__experimentalSlashInserter', val: true },
				rt.ArrayItem{ key: 'interactivity', val: rt.create_array([
					rt.ArrayItem{ key: 'clientNavigation', val: true },
				]) },
				rt.ArrayItem{ key: 'listView', val: true },
			]) },
			rt.ArrayItem{ key: 'selectors', val: rt.create_array([
				rt.ArrayItem{
					key: 'border'
					val: '.wp-block-list:not(.wp-block-list .wp-block-list)'
				},
			]) },
			rt.ArrayItem{ key: 'editorStyle', val: 'wp-block-list-editor' },
			rt.ArrayItem{ key: 'style', val: 'wp-block-list' },
		]) },
		rt.ArrayItem{ key: 'list-item', val: rt.create_array([
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: 'name', val: 'core/list-item' },
			rt.ArrayItem{ key: 'title', val: 'List Item' },
			rt.ArrayItem{ key: 'category', val: 'text' },
			rt.ArrayItem{ key: 'parent', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'core/list' },
			]) },
			rt.ArrayItem{ key: 'allowedBlocks', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'core/list' },
			]) },
			rt.ArrayItem{ key: 'description', val: 'An individual item within a list.' },
			rt.ArrayItem{ key: 'textdomain', val: 'default' },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'placeholder', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
				rt.ArrayItem{ key: 'content', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'rich-text' },
					rt.ArrayItem{ key: 'source', val: 'rich-text' },
					rt.ArrayItem{ key: 'selector', val: 'li' },
					rt.ArrayItem{ key: 'role', val: 'content' },
				]) },
			]) },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'anchor', val: true },
				rt.ArrayItem{ key: 'className', val: false },
				rt.ArrayItem{ key: 'splitting', val: true },
				rt.ArrayItem{ key: '__experimentalBorder', val: rt.create_array([
					rt.ArrayItem{ key: 'color', val: true },
					rt.ArrayItem{ key: 'radius', val: true },
					rt.ArrayItem{ key: 'style', val: true },
					rt.ArrayItem{ key: 'width', val: true },
				]) },
				rt.ArrayItem{ key: 'color', val: rt.create_array([
					rt.ArrayItem{ key: 'gradients', val: true },
					rt.ArrayItem{ key: 'link', val: true },
					rt.ArrayItem{ key: 'background', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'text', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'spacing', val: rt.create_array([
					rt.ArrayItem{ key: 'margin', val: true },
					rt.ArrayItem{ key: 'padding', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'margin', val: false },
						rt.ArrayItem{ key: 'padding', val: false },
					]) },
				]) },
				rt.ArrayItem{ key: 'typography', val: rt.create_array([
					rt.ArrayItem{ key: 'fontSize', val: true },
					rt.ArrayItem{ key: 'lineHeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontFamily', val: true },
					rt.ArrayItem{ key: '__experimentalFontWeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontStyle', val: true },
					rt.ArrayItem{ key: '__experimentalTextTransform', val: true },
					rt.ArrayItem{ key: '__experimentalTextDecoration', val: true },
					rt.ArrayItem{ key: '__experimentalLetterSpacing', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'fontSize', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'interactivity', val: rt.create_array([
					rt.ArrayItem{ key: 'clientNavigation', val: true },
				]) },
			]) },
			rt.ArrayItem{ key: 'selectors', val: rt.create_array([
				rt.ArrayItem{ key: 'root', val: '.wp-block-list > li' },
				rt.ArrayItem{
					key: 'border'
					val: '.wp-block-list:not(.wp-block-list .wp-block-list) > li'
				},
			]) },
		]) },
		rt.ArrayItem{ key: 'loginout', val: rt.create_array([
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: 'name', val: 'core/loginout' },
			rt.ArrayItem{ key: 'title', val: 'Login/out' },
			rt.ArrayItem{ key: 'category', val: 'theme' },
			rt.ArrayItem{ key: 'description', val: 'Show login & logout links.' },
			rt.ArrayItem{ key: 'keywords', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'login' },
				rt.ArrayItem{ key: none, val: 'logout' },
				rt.ArrayItem{ key: none, val: 'form' },
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'default' },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'displayLoginAsForm', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: false },
				]) },
				rt.ArrayItem{ key: 'redirectToCurrent', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: true },
				]) },
			]) },
			rt.ArrayItem{ key: 'example', val: rt.create_array([
				rt.ArrayItem{ key: 'viewportWidth', val: 350 },
			]) },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'anchor', val: true },
				rt.ArrayItem{ key: 'className', val: true },
				rt.ArrayItem{ key: 'color', val: rt.create_array([
					rt.ArrayItem{ key: 'background', val: true },
					rt.ArrayItem{ key: 'text', val: false },
					rt.ArrayItem{ key: 'gradients', val: true },
					rt.ArrayItem{ key: 'link', val: true },
				]) },
				rt.ArrayItem{ key: 'spacing', val: rt.create_array([
					rt.ArrayItem{ key: 'margin', val: true },
					rt.ArrayItem{ key: 'padding', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'margin', val: false },
						rt.ArrayItem{ key: 'padding', val: false },
					]) },
				]) },
				rt.ArrayItem{ key: 'typography', val: rt.create_array([
					rt.ArrayItem{ key: 'fontSize', val: true },
					rt.ArrayItem{ key: 'lineHeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontFamily', val: true },
					rt.ArrayItem{ key: '__experimentalFontWeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontStyle', val: true },
					rt.ArrayItem{ key: '__experimentalTextTransform', val: true },
					rt.ArrayItem{ key: '__experimentalTextDecoration', val: true },
					rt.ArrayItem{ key: '__experimentalLetterSpacing', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'fontSize', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: '__experimentalBorder', val: rt.create_array([
					rt.ArrayItem{ key: 'radius', val: true },
					rt.ArrayItem{ key: 'color', val: true },
					rt.ArrayItem{ key: 'width', val: true },
					rt.ArrayItem{ key: 'style', val: true },
				]) },
				rt.ArrayItem{ key: 'interactivity', val: rt.create_array([
					rt.ArrayItem{ key: 'clientNavigation', val: true },
				]) },
			]) },
			rt.ArrayItem{ key: 'style', val: 'wp-block-loginout' },
		]) },
		rt.ArrayItem{ key: 'math', val: rt.create_array([
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: 'name', val: 'core/math' },
			rt.ArrayItem{ key: 'title', val: 'Math' },
			rt.ArrayItem{ key: 'category', val: 'text' },
			rt.ArrayItem{ key: 'description', val: 'Display mathematical notation using LaTeX.' },
			rt.ArrayItem{ key: 'keywords', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'equation' },
				rt.ArrayItem{ key: none, val: 'formula' },
				rt.ArrayItem{ key: none, val: 'latex' },
				rt.ArrayItem{ key: none, val: 'mathematics' },
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'default' },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'anchor', val: true },
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: '__experimentalBorder', val: rt.create_array([
					rt.ArrayItem{ key: 'color', val: true },
					rt.ArrayItem{ key: 'radius', val: true },
					rt.ArrayItem{ key: 'style', val: true },
					rt.ArrayItem{ key: 'width', val: true },
				]) },
				rt.ArrayItem{ key: 'color', val: rt.create_array([
					rt.ArrayItem{ key: 'gradients', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'background', val: true },
						rt.ArrayItem{ key: 'text', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'spacing', val: rt.create_array([
					rt.ArrayItem{ key: 'margin', val: true },
					rt.ArrayItem{ key: 'padding', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'margin', val: false },
						rt.ArrayItem{ key: 'padding', val: false },
					]) },
				]) },
				rt.ArrayItem{ key: 'typography', val: rt.create_array([
					rt.ArrayItem{ key: 'fontSize', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'fontSize', val: true },
					]) },
				]) },
			]) },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'latex', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'role', val: 'content' },
				]) },
				rt.ArrayItem{ key: 'mathML', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'source', val: 'html' },
					rt.ArrayItem{ key: 'selector', val: 'math' },
				]) },
			]) },
		]) },
		rt.ArrayItem{ key: 'media-text', val: rt.create_array([
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: 'name', val: 'core/media-text' },
			rt.ArrayItem{ key: 'title', val: 'Media & Text' },
			rt.ArrayItem{ key: 'category', val: 'media' },
			rt.ArrayItem{
				key: 'description'
				val: 'Set media and words side-by-side for a richer layout.'
			},
			rt.ArrayItem{ key: 'keywords', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'image' },
				rt.ArrayItem{ key: none, val: 'video' },
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'default' },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'align', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: 'none' },
				]) },
				rt.ArrayItem{ key: 'mediaAlt', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'source', val: 'attribute' },
					rt.ArrayItem{ key: 'selector', val: 'figure img' },
					rt.ArrayItem{ key: 'attribute', val: 'alt' },
					rt.ArrayItem{ key: 'default', val: '' },
					rt.ArrayItem{ key: 'role', val: 'content' },
				]) },
				rt.ArrayItem{ key: 'mediaPosition', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: 'left' },
				]) },
				rt.ArrayItem{ key: 'mediaId', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'number' },
					rt.ArrayItem{ key: 'role', val: 'content' },
				]) },
				rt.ArrayItem{ key: 'mediaUrl', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'source', val: 'attribute' },
					rt.ArrayItem{ key: 'selector', val: 'figure video,figure img' },
					rt.ArrayItem{ key: 'attribute', val: 'src' },
					rt.ArrayItem{ key: 'role', val: 'content' },
				]) },
				rt.ArrayItem{ key: 'mediaLink', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
				rt.ArrayItem{ key: 'linkDestination', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
				rt.ArrayItem{ key: 'linkTarget', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'source', val: 'attribute' },
					rt.ArrayItem{ key: 'selector', val: 'figure a' },
					rt.ArrayItem{ key: 'attribute', val: 'target' },
				]) },
				rt.ArrayItem{ key: 'href', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'source', val: 'attribute' },
					rt.ArrayItem{ key: 'selector', val: 'figure a' },
					rt.ArrayItem{ key: 'attribute', val: 'href' },
					rt.ArrayItem{ key: 'role', val: 'content' },
				]) },
				rt.ArrayItem{ key: 'rel', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'source', val: 'attribute' },
					rt.ArrayItem{ key: 'selector', val: 'figure a' },
					rt.ArrayItem{ key: 'attribute', val: 'rel' },
				]) },
				rt.ArrayItem{ key: 'linkClass', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'source', val: 'attribute' },
					rt.ArrayItem{ key: 'selector', val: 'figure a' },
					rt.ArrayItem{ key: 'attribute', val: 'class' },
				]) },
				rt.ArrayItem{ key: 'mediaType', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'role', val: 'content' },
				]) },
				rt.ArrayItem{ key: 'mediaWidth', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'number' },
					rt.ArrayItem{ key: 'default', val: 50 },
				]) },
				rt.ArrayItem{ key: 'mediaSizeSlug', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
				rt.ArrayItem{ key: 'isStackedOnMobile', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: true },
				]) },
				rt.ArrayItem{ key: 'verticalAlignment', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
				rt.ArrayItem{ key: 'imageFill', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
				]) },
				rt.ArrayItem{ key: 'focalPoint', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'object' },
				]) },
				rt.ArrayItem{ key: 'useFeaturedImage', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: false },
				]) },
			]) },
			rt.ArrayItem{ key: 'usesContext', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'postId' },
				rt.ArrayItem{ key: none, val: 'postType' },
			]) },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'anchor', val: true },
				rt.ArrayItem{ key: 'align', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'wide' },
					rt.ArrayItem{ key: none, val: 'full' },
				]) },
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: '__experimentalBorder', val: rt.create_array([
					rt.ArrayItem{ key: 'color', val: true },
					rt.ArrayItem{ key: 'radius', val: true },
					rt.ArrayItem{ key: 'style', val: true },
					rt.ArrayItem{ key: 'width', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'color', val: true },
						rt.ArrayItem{ key: 'radius', val: true },
						rt.ArrayItem{ key: 'style', val: true },
						rt.ArrayItem{ key: 'width', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'color', val: rt.create_array([
					rt.ArrayItem{ key: 'gradients', val: true },
					rt.ArrayItem{ key: 'heading', val: true },
					rt.ArrayItem{ key: 'link', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'background', val: true },
						rt.ArrayItem{ key: 'text', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'spacing', val: rt.create_array([
					rt.ArrayItem{ key: 'margin', val: true },
					rt.ArrayItem{ key: 'padding', val: true },
				]) },
				rt.ArrayItem{ key: 'typography', val: rt.create_array([
					rt.ArrayItem{ key: 'fontSize', val: true },
					rt.ArrayItem{ key: 'lineHeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontFamily', val: true },
					rt.ArrayItem{ key: '__experimentalFontWeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontStyle', val: true },
					rt.ArrayItem{ key: '__experimentalTextTransform', val: true },
					rt.ArrayItem{ key: '__experimentalTextDecoration', val: true },
					rt.ArrayItem{ key: '__experimentalLetterSpacing', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'fontSize', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'interactivity', val: rt.create_array([
					rt.ArrayItem{ key: 'clientNavigation', val: true },
				]) },
				rt.ArrayItem{ key: 'allowedBlocks', val: true },
			]) },
			rt.ArrayItem{ key: 'editorStyle', val: 'wp-block-media-text-editor' },
			rt.ArrayItem{ key: 'style', val: 'wp-block-media-text' },
		]) },
		rt.ArrayItem{ key: 'missing', val: rt.create_array([
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: 'name', val: 'core/missing' },
			rt.ArrayItem{ key: 'title', val: 'Unsupported' },
			rt.ArrayItem{ key: 'category', val: 'text' },
			rt.ArrayItem{
				key: 'description'
				val: 'Your site doesn’t include support for this block.'
			},
			rt.ArrayItem{ key: 'textdomain', val: 'default' },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'originalName', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
				rt.ArrayItem{ key: 'originalUndelimitedContent', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
				rt.ArrayItem{ key: 'originalContent', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'source', val: 'raw' },
				]) },
			]) },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'className', val: false },
				rt.ArrayItem{ key: 'customClassName', val: false },
				rt.ArrayItem{ key: 'inserter', val: false },
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'lock', val: false },
				rt.ArrayItem{ key: 'reusable', val: false },
				rt.ArrayItem{ key: 'renaming', val: false },
				rt.ArrayItem{ key: 'visibility', val: false },
				rt.ArrayItem{ key: 'interactivity', val: rt.create_array([
					rt.ArrayItem{ key: 'clientNavigation', val: true },
				]) },
				rt.ArrayItem{ key: 'customCSS', val: false },
			]) },
		]) },
		rt.ArrayItem{ key: 'more', val: rt.create_array([
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: 'name', val: 'core/more' },
			rt.ArrayItem{ key: 'title', val: 'More' },
			rt.ArrayItem{ key: 'category', val: 'design' },
			rt.ArrayItem{
				key: 'description'
				val: 'Content before this block will be shown in the excerpt on your archives page.'
			},
			rt.ArrayItem{ key: 'keywords', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'read more' },
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'default' },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'customText', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: '' },
					rt.ArrayItem{ key: 'role', val: 'content' },
				]) },
				rt.ArrayItem{ key: 'noTeaser', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: false },
				]) },
			]) },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'customClassName', val: false },
				rt.ArrayItem{ key: 'className', val: false },
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'multiple', val: false },
				rt.ArrayItem{ key: 'visibility', val: false },
				rt.ArrayItem{ key: 'interactivity', val: rt.create_array([
					rt.ArrayItem{ key: 'clientNavigation', val: true },
				]) },
				rt.ArrayItem{ key: 'customCSS', val: false },
			]) },
			rt.ArrayItem{ key: 'editorStyle', val: 'wp-block-more-editor' },
		]) },
		rt.ArrayItem{ key: 'navigation', val: rt.create_array([
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: 'name', val: 'core/navigation' },
			rt.ArrayItem{ key: 'title', val: 'Navigation' },
			rt.ArrayItem{ key: 'category', val: 'theme' },
			rt.ArrayItem{ key: 'allowedBlocks', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'core/navigation-link' },
				rt.ArrayItem{ key: none, val: 'core/search' },
				rt.ArrayItem{ key: none, val: 'core/social-links' },
				rt.ArrayItem{ key: none, val: 'core/page-list' },
				rt.ArrayItem{ key: none, val: 'core/spacer' },
				rt.ArrayItem{ key: none, val: 'core/home-link' },
				rt.ArrayItem{ key: none, val: 'core/icon' },
				rt.ArrayItem{ key: none, val: 'core/site-title' },
				rt.ArrayItem{ key: none, val: 'core/site-logo' },
				rt.ArrayItem{ key: none, val: 'core/navigation-submenu' },
				rt.ArrayItem{ key: none, val: 'core/loginout' },
				rt.ArrayItem{ key: none, val: 'core/buttons' },
			]) },
			rt.ArrayItem{
				key: 'description'
				val: 'A collection of blocks that allow visitors to get around your site.'
			},
			rt.ArrayItem{ key: 'keywords', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'menu' },
				rt.ArrayItem{ key: none, val: 'navigation' },
				rt.ArrayItem{ key: none, val: 'links' },
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'default' },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'ref', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'number' },
				]) },
				rt.ArrayItem{ key: 'textColor', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
				rt.ArrayItem{ key: 'customTextColor', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
				rt.ArrayItem{ key: 'rgbTextColor', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
				rt.ArrayItem{ key: 'backgroundColor', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
				rt.ArrayItem{ key: 'customBackgroundColor', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
				rt.ArrayItem{ key: 'rgbBackgroundColor', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
				rt.ArrayItem{ key: 'showSubmenuIcon', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: true },
				]) },
				rt.ArrayItem{ key: 'submenuVisibility', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'enum', val: rt.create_array([
						rt.ArrayItem{ key: none, val: 'hover' },
						rt.ArrayItem{ key: none, val: 'click' },
						rt.ArrayItem{ key: none, val: 'always' },
					]) },
					rt.ArrayItem{ key: 'default', val: 'hover' },
				]) },
				rt.ArrayItem{ key: 'overlayMenu', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: 'mobile' },
				]) },
				rt.ArrayItem{ key: 'overlay', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
				rt.ArrayItem{ key: 'icon', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: 'handle' },
				]) },
				rt.ArrayItem{ key: 'hasIcon', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: true },
				]) },
				rt.ArrayItem{ key: '__unstableLocation', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
				rt.ArrayItem{ key: 'overlayBackgroundColor', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
				rt.ArrayItem{ key: 'customOverlayBackgroundColor', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
				rt.ArrayItem{ key: 'overlayTextColor', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
				rt.ArrayItem{ key: 'customOverlayTextColor', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
				rt.ArrayItem{ key: 'maxNestingLevel', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'number' },
					rt.ArrayItem{ key: 'default', val: 5 },
				]) },
				rt.ArrayItem{ key: 'templateLock', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: rt.create_array([
						rt.ArrayItem{ key: none, val: 'string' },
						rt.ArrayItem{ key: none, val: 'boolean' },
					]) },
					rt.ArrayItem{ key: 'enum', val: rt.create_array([
						rt.ArrayItem{ key: none, val: 'all' },
						rt.ArrayItem{ key: none, val: 'insert' },
						rt.ArrayItem{ key: none, val: 'contentOnly' },
						rt.ArrayItem{ key: none, val: false },
					]) },
				]) },
			]) },
			rt.ArrayItem{ key: 'providesContext', val: rt.create_array([
				rt.ArrayItem{ key: 'textColor', val: 'textColor' },
				rt.ArrayItem{ key: 'customTextColor', val: 'customTextColor' },
				rt.ArrayItem{ key: 'backgroundColor', val: 'backgroundColor' },
				rt.ArrayItem{ key: 'customBackgroundColor', val: 'customBackgroundColor' },
				rt.ArrayItem{ key: 'overlayTextColor', val: 'overlayTextColor' },
				rt.ArrayItem{ key: 'customOverlayTextColor', val: 'customOverlayTextColor' },
				rt.ArrayItem{ key: 'overlayBackgroundColor', val: 'overlayBackgroundColor' },
				rt.ArrayItem{
					key: 'customOverlayBackgroundColor'
					val: 'customOverlayBackgroundColor'
				},
				rt.ArrayItem{ key: 'fontSize', val: 'fontSize' },
				rt.ArrayItem{ key: 'customFontSize', val: 'customFontSize' },
				rt.ArrayItem{ key: 'showSubmenuIcon', val: 'showSubmenuIcon' },
				rt.ArrayItem{ key: 'submenuVisibility', val: 'submenuVisibility' },
				rt.ArrayItem{ key: 'openSubmenusOnClick', val: 'openSubmenusOnClick' },
				rt.ArrayItem{ key: 'style', val: 'style' },
				rt.ArrayItem{ key: 'maxNestingLevel', val: 'maxNestingLevel' },
			]) },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'anchor', val: true },
				rt.ArrayItem{ key: 'align', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'wide' },
					rt.ArrayItem{ key: none, val: 'full' },
				]) },
				rt.ArrayItem{ key: 'ariaLabel', val: true },
				rt.ArrayItem{ key: 'contentRole', val: true },
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'inserter', val: true },
				rt.ArrayItem{ key: 'typography', val: rt.create_array([
					rt.ArrayItem{ key: 'fontSize', val: true },
					rt.ArrayItem{ key: 'lineHeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontStyle', val: true },
					rt.ArrayItem{ key: '__experimentalFontWeight', val: true },
					rt.ArrayItem{ key: '__experimentalTextTransform', val: true },
					rt.ArrayItem{ key: '__experimentalFontFamily', val: true },
					rt.ArrayItem{ key: '__experimentalLetterSpacing', val: true },
					rt.ArrayItem{ key: '__experimentalTextDecoration', val: true },
					rt.ArrayItem{ key: '__experimentalSkipSerialization', val: rt.create_array([
						rt.ArrayItem{ key: none, val: 'textDecoration' },
					]) },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'fontSize', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'spacing', val: rt.create_array([
					rt.ArrayItem{ key: 'blockGap', val: true },
					rt.ArrayItem{ key: 'units', val: rt.create_array([
						rt.ArrayItem{ key: none, val: 'px' },
						rt.ArrayItem{ key: none, val: 'em' },
						rt.ArrayItem{ key: none, val: 'rem' },
						rt.ArrayItem{ key: none, val: 'vh' },
						rt.ArrayItem{ key: none, val: 'vw' },
					]) },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'blockGap', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'layout', val: rt.create_array([
					rt.ArrayItem{ key: 'allowSwitching', val: false },
					rt.ArrayItem{ key: 'allowInheriting', val: false },
					rt.ArrayItem{ key: 'allowVerticalAlignment', val: false },
					rt.ArrayItem{ key: 'allowSizingOnChildren', val: true },
					rt.ArrayItem{ key: 'default', val: rt.create_array([
						rt.ArrayItem{ key: 'type', val: 'flex' },
					]) },
				]) },
				rt.ArrayItem{ key: 'interactivity', val: true },
				rt.ArrayItem{ key: 'renaming', val: false },
			]) },
			rt.ArrayItem{ key: 'editorStyle', val: 'wp-block-navigation-editor' },
			rt.ArrayItem{ key: 'style', val: 'wp-block-navigation' },
		]) },
		rt.ArrayItem{ key: 'navigation-link', val: rt.create_array([
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: 'name', val: 'core/navigation-link' },
			rt.ArrayItem{ key: 'title', val: 'Custom Link' },
			rt.ArrayItem{ key: 'category', val: 'design' },
			rt.ArrayItem{ key: 'parent', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'core/navigation' },
			]) },
			rt.ArrayItem{ key: 'allowedBlocks', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'core/navigation-link' },
				rt.ArrayItem{ key: none, val: 'core/navigation-submenu' },
				rt.ArrayItem{ key: none, val: 'core/page-list' },
			]) },
			rt.ArrayItem{
				key: 'description'
				val: 'Add a page, link, or another item to your navigation.'
			},
			rt.ArrayItem{ key: 'textdomain', val: 'default' },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'label', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'role', val: 'content' },
				]) },
				rt.ArrayItem{ key: 'type', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
				rt.ArrayItem{ key: 'description', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
				rt.ArrayItem{ key: 'rel', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
				rt.ArrayItem{ key: 'id', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'number' },
				]) },
				rt.ArrayItem{ key: 'opensInNewTab', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: false },
				]) },
				rt.ArrayItem{ key: 'url', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'role', val: 'content' },
				]) },
				rt.ArrayItem{ key: 'title', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
				rt.ArrayItem{ key: 'kind', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
				rt.ArrayItem{ key: 'isTopLevelLink', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
				]) },
			]) },
			rt.ArrayItem{ key: 'usesContext', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'textColor' },
				rt.ArrayItem{ key: none, val: 'customTextColor' },
				rt.ArrayItem{ key: none, val: 'backgroundColor' },
				rt.ArrayItem{ key: none, val: 'customBackgroundColor' },
				rt.ArrayItem{ key: none, val: 'overlayTextColor' },
				rt.ArrayItem{ key: none, val: 'customOverlayTextColor' },
				rt.ArrayItem{ key: none, val: 'overlayBackgroundColor' },
				rt.ArrayItem{ key: none, val: 'customOverlayBackgroundColor' },
				rt.ArrayItem{ key: none, val: 'fontSize' },
				rt.ArrayItem{ key: none, val: 'customFontSize' },
				rt.ArrayItem{ key: none, val: 'showSubmenuIcon' },
				rt.ArrayItem{ key: none, val: 'maxNestingLevel' },
				rt.ArrayItem{ key: none, val: 'style' },
			]) },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'anchor', val: true },
				rt.ArrayItem{ key: 'reusable', val: false },
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: '__experimentalSlashInserter', val: true },
				rt.ArrayItem{ key: 'typography', val: rt.create_array([
					rt.ArrayItem{ key: 'fontSize', val: true },
					rt.ArrayItem{ key: 'lineHeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontFamily', val: true },
					rt.ArrayItem{ key: '__experimentalFontWeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontStyle', val: true },
					rt.ArrayItem{ key: '__experimentalTextTransform', val: true },
					rt.ArrayItem{ key: '__experimentalTextDecoration', val: true },
					rt.ArrayItem{ key: '__experimentalLetterSpacing', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'fontSize', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'renaming', val: false },
				rt.ArrayItem{ key: 'interactivity', val: rt.create_array([
					rt.ArrayItem{ key: 'clientNavigation', val: true },
				]) },
			]) },
			rt.ArrayItem{ key: 'editorStyle', val: 'wp-block-navigation-link-editor' },
			rt.ArrayItem{ key: 'style', val: 'wp-block-navigation-link' },
		]) },
		rt.ArrayItem{ key: 'navigation-overlay-close', val: rt.create_array([
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: 'name', val: 'core/navigation-overlay-close' },
			rt.ArrayItem{ key: 'title', val: 'Navigation Overlay Close' },
			rt.ArrayItem{ key: 'category', val: 'design' },
			rt.ArrayItem{ key: 'description', val: 'A customizable button to close overlays.' },
			rt.ArrayItem{ key: 'keywords', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'close' },
				rt.ArrayItem{ key: none, val: 'overlay' },
				rt.ArrayItem{ key: none, val: 'navigation' },
				rt.ArrayItem{ key: none, val: 'menu' },
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'default' },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'displayMode', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'enum', val: rt.create_array([
						rt.ArrayItem{ key: none, val: 'icon' },
						rt.ArrayItem{ key: none, val: 'text' },
						rt.ArrayItem{ key: none, val: 'both' },
					]) },
					rt.ArrayItem{ key: 'default', val: 'icon' },
				]) },
				rt.ArrayItem{ key: 'text', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
			]) },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'color', val: rt.create_array([
					rt.ArrayItem{ key: 'gradients', val: false },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'background', val: true },
						rt.ArrayItem{ key: 'text', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'spacing', val: rt.create_array([
					rt.ArrayItem{ key: 'padding', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'padding', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'typography', val: rt.create_array([
					rt.ArrayItem{ key: 'fontSize', val: true },
					rt.ArrayItem{ key: 'lineHeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontFamily', val: true },
					rt.ArrayItem{ key: '__experimentalFontWeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontStyle', val: true },
					rt.ArrayItem{ key: '__experimentalTextTransform', val: true },
					rt.ArrayItem{ key: '__experimentalTextDecoration', val: true },
					rt.ArrayItem{ key: '__experimentalLetterSpacing', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'fontSize', val: true },
					]) },
				]) },
			]) },
			rt.ArrayItem{ key: 'style', val: 'wp-block-navigation-overlay-close' },
		]) },
		rt.ArrayItem{ key: 'navigation-submenu', val: rt.create_array([
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: 'name', val: 'core/navigation-submenu' },
			rt.ArrayItem{ key: 'title', val: 'Submenu' },
			rt.ArrayItem{ key: 'category', val: 'design' },
			rt.ArrayItem{ key: 'parent', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'core/navigation' },
			]) },
			rt.ArrayItem{ key: 'description', val: 'Add a submenu to your navigation.' },
			rt.ArrayItem{ key: 'textdomain', val: 'default' },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'label', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'role', val: 'content' },
				]) },
				rt.ArrayItem{ key: 'type', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
				rt.ArrayItem{ key: 'description', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
				rt.ArrayItem{ key: 'rel', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
				rt.ArrayItem{ key: 'id', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'number' },
				]) },
				rt.ArrayItem{ key: 'opensInNewTab', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: false },
				]) },
				rt.ArrayItem{ key: 'url', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'role', val: 'content' },
				]) },
				rt.ArrayItem{ key: 'title', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
				rt.ArrayItem{ key: 'kind', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
				rt.ArrayItem{ key: 'isTopLevelItem', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
				]) },
			]) },
			rt.ArrayItem{ key: 'usesContext', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'textColor' },
				rt.ArrayItem{ key: none, val: 'customTextColor' },
				rt.ArrayItem{ key: none, val: 'backgroundColor' },
				rt.ArrayItem{ key: none, val: 'customBackgroundColor' },
				rt.ArrayItem{ key: none, val: 'overlayTextColor' },
				rt.ArrayItem{ key: none, val: 'customOverlayTextColor' },
				rt.ArrayItem{ key: none, val: 'overlayBackgroundColor' },
				rt.ArrayItem{ key: none, val: 'customOverlayBackgroundColor' },
				rt.ArrayItem{ key: none, val: 'fontSize' },
				rt.ArrayItem{ key: none, val: 'customFontSize' },
				rt.ArrayItem{ key: none, val: 'showSubmenuIcon' },
				rt.ArrayItem{ key: none, val: 'maxNestingLevel' },
				rt.ArrayItem{ key: none, val: 'openSubmenusOnClick' },
				rt.ArrayItem{ key: none, val: 'submenuVisibility' },
				rt.ArrayItem{ key: none, val: 'style' },
			]) },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'anchor', val: true },
				rt.ArrayItem{ key: 'reusable', val: false },
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'typography', val: rt.create_array([
					rt.ArrayItem{ key: 'fontSize', val: true },
					rt.ArrayItem{ key: 'lineHeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontFamily', val: true },
					rt.ArrayItem{ key: '__experimentalFontWeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontStyle', val: true },
					rt.ArrayItem{ key: '__experimentalTextTransform', val: true },
					rt.ArrayItem{ key: '__experimentalTextDecoration', val: true },
					rt.ArrayItem{ key: '__experimentalLetterSpacing', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'fontSize', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'interactivity', val: rt.create_array([
					rt.ArrayItem{ key: 'clientNavigation', val: true },
				]) },
			]) },
			rt.ArrayItem{ key: 'editorStyle', val: 'wp-block-navigation-submenu-editor' },
			rt.ArrayItem{ key: 'style', val: 'wp-block-navigation-submenu' },
		]) },
		rt.ArrayItem{ key: 'nextpage', val: rt.create_array([
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: 'name', val: 'core/nextpage' },
			rt.ArrayItem{ key: 'title', val: 'Page Break' },
			rt.ArrayItem{ key: 'category', val: 'design' },
			rt.ArrayItem{
				key: 'description'
				val: 'Separate your content into a multi-page experience.'
			},
			rt.ArrayItem{ key: 'keywords', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'next page' },
				rt.ArrayItem{ key: none, val: 'pagination' },
			]) },
			rt.ArrayItem{ key: 'parent', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'core/post-content' },
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'default' },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'customClassName', val: false },
				rt.ArrayItem{ key: 'className', val: false },
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'visibility', val: false },
				rt.ArrayItem{ key: 'interactivity', val: rt.create_array([
					rt.ArrayItem{ key: 'clientNavigation', val: true },
				]) },
				rt.ArrayItem{ key: 'customCSS', val: false },
			]) },
			rt.ArrayItem{ key: 'editorStyle', val: 'wp-block-nextpage-editor' },
		]) },
		rt.ArrayItem{ key: 'page-list', val: rt.create_array([
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: 'name', val: 'core/page-list' },
			rt.ArrayItem{ key: 'title', val: 'Page List' },
			rt.ArrayItem{ key: 'category', val: 'widgets' },
			rt.ArrayItem{ key: 'allowedBlocks', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'core/page-list-item' },
			]) },
			rt.ArrayItem{ key: 'description', val: 'Display a list of all pages.' },
			rt.ArrayItem{ key: 'keywords', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'menu' },
				rt.ArrayItem{ key: none, val: 'navigation' },
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'default' },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'parentPageID', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'integer' },
					rt.ArrayItem{ key: 'default', val: 0 },
				]) },
				rt.ArrayItem{ key: 'isNested', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: false },
				]) },
			]) },
			rt.ArrayItem{ key: 'usesContext', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'textColor' },
				rt.ArrayItem{ key: none, val: 'customTextColor' },
				rt.ArrayItem{ key: none, val: 'backgroundColor' },
				rt.ArrayItem{ key: none, val: 'customBackgroundColor' },
				rt.ArrayItem{ key: none, val: 'overlayTextColor' },
				rt.ArrayItem{ key: none, val: 'customOverlayTextColor' },
				rt.ArrayItem{ key: none, val: 'overlayBackgroundColor' },
				rt.ArrayItem{ key: none, val: 'customOverlayBackgroundColor' },
				rt.ArrayItem{ key: none, val: 'fontSize' },
				rt.ArrayItem{ key: none, val: 'customFontSize' },
				rt.ArrayItem{ key: none, val: 'showSubmenuIcon' },
				rt.ArrayItem{ key: none, val: 'style' },
				rt.ArrayItem{ key: none, val: 'openSubmenusOnClick' },
				rt.ArrayItem{ key: none, val: 'submenuVisibility' },
			]) },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'anchor', val: true },
				rt.ArrayItem{ key: 'reusable', val: false },
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'typography', val: rt.create_array([
					rt.ArrayItem{ key: 'fontSize', val: true },
					rt.ArrayItem{ key: 'lineHeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontFamily', val: true },
					rt.ArrayItem{ key: '__experimentalFontWeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontStyle', val: true },
					rt.ArrayItem{ key: '__experimentalTextTransform', val: true },
					rt.ArrayItem{ key: '__experimentalTextDecoration', val: true },
					rt.ArrayItem{ key: '__experimentalLetterSpacing', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'fontSize', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'interactivity', val: rt.create_array([
					rt.ArrayItem{ key: 'clientNavigation', val: true },
				]) },
				rt.ArrayItem{ key: 'color', val: rt.create_array([
					rt.ArrayItem{ key: 'text', val: true },
					rt.ArrayItem{ key: 'background', val: true },
					rt.ArrayItem{ key: 'link', val: true },
					rt.ArrayItem{ key: 'gradients', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'background', val: true },
						rt.ArrayItem{ key: 'text', val: true },
						rt.ArrayItem{ key: 'link', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: '__experimentalBorder', val: rt.create_array([
					rt.ArrayItem{ key: 'radius', val: true },
					rt.ArrayItem{ key: 'color', val: true },
					rt.ArrayItem{ key: 'width', val: true },
					rt.ArrayItem{ key: 'style', val: true },
				]) },
				rt.ArrayItem{ key: 'spacing', val: rt.create_array([
					rt.ArrayItem{ key: 'padding', val: true },
					rt.ArrayItem{ key: 'margin', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'padding', val: false },
						rt.ArrayItem{ key: 'margin', val: false },
					]) },
				]) },
				rt.ArrayItem{ key: 'contentRole', val: true },
			]) },
			rt.ArrayItem{ key: 'editorStyle', val: 'wp-block-page-list-editor' },
			rt.ArrayItem{ key: 'style', val: 'wp-block-page-list' },
		]) },
		rt.ArrayItem{ key: 'page-list-item', val: rt.create_array([
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: 'name', val: 'core/page-list-item' },
			rt.ArrayItem{ key: 'title', val: 'Page List Item' },
			rt.ArrayItem{ key: 'category', val: 'widgets' },
			rt.ArrayItem{ key: 'parent', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'core/page-list' },
			]) },
			rt.ArrayItem{ key: 'description', val: 'Displays a page inside a list of all pages.' },
			rt.ArrayItem{ key: 'keywords', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'page' },
				rt.ArrayItem{ key: none, val: 'menu' },
				rt.ArrayItem{ key: none, val: 'navigation' },
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'default' },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'id', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'number' },
				]) },
				rt.ArrayItem{ key: 'label', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
				rt.ArrayItem{ key: 'title', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
				rt.ArrayItem{ key: 'link', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
				rt.ArrayItem{ key: 'hasChildren', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
				]) },
			]) },
			rt.ArrayItem{ key: 'usesContext', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'textColor' },
				rt.ArrayItem{ key: none, val: 'customTextColor' },
				rt.ArrayItem{ key: none, val: 'backgroundColor' },
				rt.ArrayItem{ key: none, val: 'customBackgroundColor' },
				rt.ArrayItem{ key: none, val: 'overlayTextColor' },
				rt.ArrayItem{ key: none, val: 'customOverlayTextColor' },
				rt.ArrayItem{ key: none, val: 'overlayBackgroundColor' },
				rt.ArrayItem{ key: none, val: 'customOverlayBackgroundColor' },
				rt.ArrayItem{ key: none, val: 'fontSize' },
				rt.ArrayItem{ key: none, val: 'customFontSize' },
				rt.ArrayItem{ key: none, val: 'showSubmenuIcon' },
				rt.ArrayItem{ key: none, val: 'style' },
				rt.ArrayItem{ key: none, val: 'openSubmenusOnClick' },
				rt.ArrayItem{ key: none, val: 'submenuVisibility' },
			]) },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'anchor', val: true },
				rt.ArrayItem{ key: 'reusable', val: false },
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'lock', val: false },
				rt.ArrayItem{ key: 'inserter', val: false },
				rt.ArrayItem{ key: '__experimentalToolbar', val: false },
				rt.ArrayItem{ key: 'interactivity', val: rt.create_array([
					rt.ArrayItem{ key: 'clientNavigation', val: true },
				]) },
			]) },
			rt.ArrayItem{ key: 'editorStyle', val: 'wp-block-page-list-editor' },
			rt.ArrayItem{ key: 'style', val: 'wp-block-page-list' },
		]) },
		rt.ArrayItem{ key: 'paragraph', val: rt.create_array([
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: 'name', val: 'core/paragraph' },
			rt.ArrayItem{ key: 'title', val: 'Paragraph' },
			rt.ArrayItem{ key: 'category', val: 'text' },
			rt.ArrayItem{
				key: 'description'
				val: 'Start with the basic building block of all narrative.'
			},
			rt.ArrayItem{ key: 'keywords', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'text' },
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'default' },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'content', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'rich-text' },
					rt.ArrayItem{ key: 'source', val: 'rich-text' },
					rt.ArrayItem{ key: 'selector', val: 'p' },
					rt.ArrayItem{ key: 'role', val: 'content' },
				]) },
				rt.ArrayItem{ key: 'dropCap', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: false },
				]) },
				rt.ArrayItem{ key: 'placeholder', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
				rt.ArrayItem{ key: 'direction', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'enum', val: rt.create_array([
						rt.ArrayItem{ key: none, val: 'ltr' },
						rt.ArrayItem{ key: none, val: 'rtl' },
					]) },
				]) },
			]) },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'align', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'wide' },
					rt.ArrayItem{ key: none, val: 'full' },
				]) },
				rt.ArrayItem{ key: 'splitting', val: true },
				rt.ArrayItem{ key: 'anchor', val: true },
				rt.ArrayItem{ key: 'className', val: false },
				rt.ArrayItem{ key: '__experimentalBorder', val: rt.create_array([
					rt.ArrayItem{ key: 'color', val: true },
					rt.ArrayItem{ key: 'radius', val: true },
					rt.ArrayItem{ key: 'style', val: true },
					rt.ArrayItem{ key: 'width', val: true },
				]) },
				rt.ArrayItem{ key: 'color', val: rt.create_array([
					rt.ArrayItem{ key: 'gradients', val: true },
					rt.ArrayItem{ key: 'link', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'background', val: true },
						rt.ArrayItem{ key: 'text', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'spacing', val: rt.create_array([
					rt.ArrayItem{ key: 'margin', val: true },
					rt.ArrayItem{ key: 'padding', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'margin', val: false },
						rt.ArrayItem{ key: 'padding', val: false },
					]) },
				]) },
				rt.ArrayItem{ key: 'typography', val: rt.create_array([
					rt.ArrayItem{ key: 'fontSize', val: true },
					rt.ArrayItem{ key: 'lineHeight', val: true },
					rt.ArrayItem{ key: 'textAlign', val: true },
					rt.ArrayItem{ key: 'textColumns', val: true },
					rt.ArrayItem{ key: 'textIndent', val: true },
					rt.ArrayItem{ key: '__experimentalFontFamily', val: true },
					rt.ArrayItem{ key: '__experimentalTextDecoration', val: true },
					rt.ArrayItem{ key: '__experimentalFontStyle', val: true },
					rt.ArrayItem{ key: '__experimentalFontWeight', val: true },
					rt.ArrayItem{ key: '__experimentalLetterSpacing', val: true },
					rt.ArrayItem{ key: '__experimentalTextTransform', val: true },
					rt.ArrayItem{ key: '__experimentalWritingMode', val: true },
					rt.ArrayItem{ key: 'fitText', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'fontSize', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: '__experimentalSelector', val: 'p' },
				rt.ArrayItem{ key: '__unstablePasteTextInline', val: true },
				rt.ArrayItem{ key: 'interactivity', val: rt.create_array([
					rt.ArrayItem{ key: 'clientNavigation', val: true },
				]) },
			]) },
			rt.ArrayItem{ key: 'selectors', val: rt.create_array([
				rt.ArrayItem{ key: 'root', val: 'p' },
				rt.ArrayItem{ key: 'typography', val: rt.create_array([
					rt.ArrayItem{
						key: 'textIndent'
						val: '.wp-block-paragraph + .wp-block-paragraph'
					},
				]) },
			]) },
			rt.ArrayItem{ key: 'editorStyle', val: 'wp-block-paragraph-editor' },
			rt.ArrayItem{ key: 'style', val: 'wp-block-paragraph' },
		]) },
		rt.ArrayItem{ key: 'pattern', val: rt.create_array([
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: 'name', val: 'core/pattern' },
			rt.ArrayItem{ key: 'title', val: 'Pattern Placeholder' },
			rt.ArrayItem{ key: 'category', val: 'theme' },
			rt.ArrayItem{ key: 'description', val: 'Show a block pattern.' },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'inserter', val: false },
				rt.ArrayItem{ key: 'renaming', val: false },
				rt.ArrayItem{ key: 'visibility', val: false },
				rt.ArrayItem{ key: 'interactivity', val: rt.create_array([
					rt.ArrayItem{ key: 'clientNavigation', val: true },
				]) },
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'default' },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'slug', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
			]) },
		]) },
		rt.ArrayItem{ key: 'post-author', val: rt.create_array([
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: 'name', val: 'core/post-author' },
			rt.ArrayItem{ key: 'title', val: 'Author (deprecated)' },
			rt.ArrayItem{ key: 'category', val: 'theme' },
			rt.ArrayItem{
				key: 'description'
				val: 'This block is deprecated. Please use the Avatar block, the Author Name block, and the Author Biography block instead.'
			},
			rt.ArrayItem{ key: 'textdomain', val: 'default' },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'textAlign', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
				rt.ArrayItem{ key: 'avatarSize', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'number' },
					rt.ArrayItem{ key: 'default', val: 48 },
				]) },
				rt.ArrayItem{ key: 'showAvatar', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: true },
				]) },
				rt.ArrayItem{ key: 'showBio', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
				]) },
				rt.ArrayItem{ key: 'byline', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
				rt.ArrayItem{ key: 'isLink', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: false },
					rt.ArrayItem{ key: 'role', val: 'content' },
				]) },
				rt.ArrayItem{ key: 'linkTarget', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: '_self' },
					rt.ArrayItem{ key: 'role', val: 'content' },
				]) },
			]) },
			rt.ArrayItem{ key: 'usesContext', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'postType' },
				rt.ArrayItem{ key: none, val: 'postId' },
				rt.ArrayItem{ key: none, val: 'queryId' },
			]) },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'inserter', val: false },
				rt.ArrayItem{ key: 'anchor', val: true },
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'spacing', val: rt.create_array([
					rt.ArrayItem{ key: 'margin', val: true },
					rt.ArrayItem{ key: 'padding', val: true },
				]) },
				rt.ArrayItem{ key: 'typography', val: rt.create_array([
					rt.ArrayItem{ key: 'fontSize', val: true },
					rt.ArrayItem{ key: 'lineHeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontFamily', val: true },
					rt.ArrayItem{ key: '__experimentalFontWeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontStyle', val: true },
					rt.ArrayItem{ key: '__experimentalTextTransform', val: true },
					rt.ArrayItem{ key: '__experimentalTextDecoration', val: true },
					rt.ArrayItem{ key: '__experimentalLetterSpacing', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'fontSize', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'color', val: rt.create_array([
					rt.ArrayItem{ key: 'gradients', val: true },
					rt.ArrayItem{ key: 'link', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'background', val: true },
						rt.ArrayItem{ key: 'text', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'interactivity', val: rt.create_array([
					rt.ArrayItem{ key: 'clientNavigation', val: true },
				]) },
				rt.ArrayItem{ key: '__experimentalBorder', val: rt.create_array([
					rt.ArrayItem{ key: 'radius', val: true },
					rt.ArrayItem{ key: 'color', val: true },
					rt.ArrayItem{ key: 'width', val: true },
					rt.ArrayItem{ key: 'style', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'radius', val: true },
						rt.ArrayItem{ key: 'color', val: true },
						rt.ArrayItem{ key: 'width', val: true },
						rt.ArrayItem{ key: 'style', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'filter', val: rt.create_array([
					rt.ArrayItem{ key: 'duotone', val: true },
				]) },
			]) },
			rt.ArrayItem{ key: 'selectors', val: rt.create_array([
				rt.ArrayItem{ key: 'filter', val: rt.create_array([
					rt.ArrayItem{
						key: 'duotone'
						val: '.wp-block-post-author .wp-block-post-author__avatar img'
					},
				]) },
			]) },
			rt.ArrayItem{ key: 'editorStyle', val: 'wp-block-post-author-editor' },
			rt.ArrayItem{ key: 'style', val: 'wp-block-post-author' },
		]) },
		rt.ArrayItem{ key: 'post-author-biography', val: rt.create_array([
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: 'name', val: 'core/post-author-biography' },
			rt.ArrayItem{ key: 'title', val: 'Author Biography' },
			rt.ArrayItem{ key: 'category', val: 'theme' },
			rt.ArrayItem{ key: 'description', val: 'The author biography.' },
			rt.ArrayItem{ key: 'textdomain', val: 'default' },
			rt.ArrayItem{ key: 'usesContext', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'postType' },
				rt.ArrayItem{ key: none, val: 'postId' },
			]) },
			rt.ArrayItem{ key: 'example', val: rt.create_array([
				rt.ArrayItem{ key: 'viewportWidth', val: 350 },
			]) },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'anchor', val: true },
				rt.ArrayItem{ key: 'spacing', val: rt.create_array([
					rt.ArrayItem{ key: 'margin', val: true },
					rt.ArrayItem{ key: 'padding', val: true },
				]) },
				rt.ArrayItem{ key: 'color', val: rt.create_array([
					rt.ArrayItem{ key: 'gradients', val: true },
					rt.ArrayItem{ key: 'link', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'background', val: true },
						rt.ArrayItem{ key: 'text', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'typography', val: rt.create_array([
					rt.ArrayItem{ key: 'fontSize', val: true },
					rt.ArrayItem{ key: 'lineHeight', val: true },
					rt.ArrayItem{ key: 'textAlign', val: true },
					rt.ArrayItem{ key: '__experimentalFontFamily', val: true },
					rt.ArrayItem{ key: '__experimentalFontWeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontStyle', val: true },
					rt.ArrayItem{ key: '__experimentalTextTransform', val: true },
					rt.ArrayItem{ key: '__experimentalTextDecoration', val: true },
					rt.ArrayItem{ key: '__experimentalLetterSpacing', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'fontSize', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'interactivity', val: rt.create_array([
					rt.ArrayItem{ key: 'clientNavigation', val: true },
				]) },
				rt.ArrayItem{ key: '__experimentalBorder', val: rt.create_array([
					rt.ArrayItem{ key: 'radius', val: true },
					rt.ArrayItem{ key: 'color', val: true },
					rt.ArrayItem{ key: 'width', val: true },
					rt.ArrayItem{ key: 'style', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'radius', val: true },
						rt.ArrayItem{ key: 'color', val: true },
						rt.ArrayItem{ key: 'width', val: true },
						rt.ArrayItem{ key: 'style', val: true },
					]) },
				]) },
			]) },
			rt.ArrayItem{ key: 'style', val: 'wp-block-post-author-biography' },
		]) },
		rt.ArrayItem{ key: 'post-author-name', val: rt.create_array([
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: 'name', val: 'core/post-author-name' },
			rt.ArrayItem{ key: 'title', val: 'Author Name' },
			rt.ArrayItem{ key: 'category', val: 'theme' },
			rt.ArrayItem{ key: 'description', val: 'The author name.' },
			rt.ArrayItem{ key: 'textdomain', val: 'default' },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'isLink', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: false },
					rt.ArrayItem{ key: 'role', val: 'content' },
				]) },
				rt.ArrayItem{ key: 'linkTarget', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: '_self' },
					rt.ArrayItem{ key: 'role', val: 'content' },
				]) },
			]) },
			rt.ArrayItem{ key: 'usesContext', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'postType' },
				rt.ArrayItem{ key: none, val: 'postId' },
			]) },
			rt.ArrayItem{ key: 'example', val: rt.create_array([
				rt.ArrayItem{ key: 'viewportWidth', val: 350 },
			]) },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'anchor', val: true },
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'spacing', val: rt.create_array([
					rt.ArrayItem{ key: 'margin', val: true },
					rt.ArrayItem{ key: 'padding', val: true },
				]) },
				rt.ArrayItem{ key: 'color', val: rt.create_array([
					rt.ArrayItem{ key: 'gradients', val: true },
					rt.ArrayItem{ key: 'link', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'background', val: true },
						rt.ArrayItem{ key: 'text', val: true },
						rt.ArrayItem{ key: 'link', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'typography', val: rt.create_array([
					rt.ArrayItem{ key: 'fontSize', val: true },
					rt.ArrayItem{ key: 'lineHeight', val: true },
					rt.ArrayItem{ key: 'textAlign', val: true },
					rt.ArrayItem{ key: '__experimentalFontFamily', val: true },
					rt.ArrayItem{ key: '__experimentalFontWeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontStyle', val: true },
					rt.ArrayItem{ key: '__experimentalTextTransform', val: true },
					rt.ArrayItem{ key: '__experimentalTextDecoration', val: true },
					rt.ArrayItem{ key: '__experimentalLetterSpacing', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'fontSize', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'interactivity', val: rt.create_array([
					rt.ArrayItem{ key: 'clientNavigation', val: true },
				]) },
				rt.ArrayItem{ key: '__experimentalBorder', val: rt.create_array([
					rt.ArrayItem{ key: 'radius', val: true },
					rt.ArrayItem{ key: 'color', val: true },
					rt.ArrayItem{ key: 'width', val: true },
					rt.ArrayItem{ key: 'style', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'radius', val: true },
						rt.ArrayItem{ key: 'color', val: true },
						rt.ArrayItem{ key: 'width', val: true },
						rt.ArrayItem{ key: 'style', val: true },
					]) },
				]) },
			]) },
			rt.ArrayItem{ key: 'style', val: 'wp-block-post-author-name' },
		]) },
		rt.ArrayItem{ key: 'post-comments-count', val: rt.create_array([
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: 'name', val: 'core/post-comments-count' },
			rt.ArrayItem{ key: 'title', val: 'Comments Count' },
			rt.ArrayItem{ key: 'category', val: 'theme' },
			rt.ArrayItem{ key: 'description', val: "Display a post's comments count." },
			rt.ArrayItem{ key: 'textdomain', val: 'default' },
			rt.ArrayItem{ key: 'usesContext', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'postId' },
			]) },
			rt.ArrayItem{ key: 'example', val: rt.create_array([
				rt.ArrayItem{ key: 'viewportWidth', val: 350 },
			]) },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'anchor', val: true },
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'color', val: rt.create_array([
					rt.ArrayItem{ key: 'gradients', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'background', val: true },
						rt.ArrayItem{ key: 'text', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'spacing', val: rt.create_array([
					rt.ArrayItem{ key: 'margin', val: true },
					rt.ArrayItem{ key: 'padding', val: true },
				]) },
				rt.ArrayItem{ key: 'typography', val: rt.create_array([
					rt.ArrayItem{ key: 'fontSize', val: true },
					rt.ArrayItem{ key: 'lineHeight', val: true },
					rt.ArrayItem{ key: 'textAlign', val: true },
					rt.ArrayItem{ key: '__experimentalFontFamily', val: true },
					rt.ArrayItem{ key: '__experimentalFontWeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontStyle', val: true },
					rt.ArrayItem{ key: '__experimentalTextTransform', val: true },
					rt.ArrayItem{ key: '__experimentalTextDecoration', val: true },
					rt.ArrayItem{ key: '__experimentalLetterSpacing', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'fontSize', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: '__experimentalBorder', val: rt.create_array([
					rt.ArrayItem{ key: 'radius', val: true },
					rt.ArrayItem{ key: 'color', val: true },
					rt.ArrayItem{ key: 'width', val: true },
					rt.ArrayItem{ key: 'style', val: true },
				]) },
				rt.ArrayItem{ key: 'interactivity', val: rt.create_array([
					rt.ArrayItem{ key: 'clientNavigation', val: true },
				]) },
			]) },
			rt.ArrayItem{ key: 'style', val: 'wp-block-post-comments-count' },
		]) },
		rt.ArrayItem{ key: 'post-comments-form', val: rt.create_array([
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: 'name', val: 'core/post-comments-form' },
			rt.ArrayItem{ key: 'title', val: 'Comments Form' },
			rt.ArrayItem{ key: 'category', val: 'theme' },
			rt.ArrayItem{ key: 'description', val: "Display a post's comments form." },
			rt.ArrayItem{ key: 'textdomain', val: 'default' },
			rt.ArrayItem{ key: 'usesContext', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'postId' },
				rt.ArrayItem{ key: none, val: 'postType' },
			]) },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'anchor', val: true },
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'color', val: rt.create_array([
					rt.ArrayItem{ key: 'gradients', val: true },
					rt.ArrayItem{ key: 'heading', val: true },
					rt.ArrayItem{ key: 'link', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'background', val: true },
						rt.ArrayItem{ key: 'text', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'spacing', val: rt.create_array([
					rt.ArrayItem{ key: 'margin', val: true },
					rt.ArrayItem{ key: 'padding', val: true },
				]) },
				rt.ArrayItem{ key: 'typography', val: rt.create_array([
					rt.ArrayItem{ key: 'fontSize', val: true },
					rt.ArrayItem{ key: 'lineHeight', val: true },
					rt.ArrayItem{ key: 'textAlign', val: true },
					rt.ArrayItem{ key: '__experimentalFontStyle', val: true },
					rt.ArrayItem{ key: '__experimentalFontWeight', val: true },
					rt.ArrayItem{ key: '__experimentalLetterSpacing', val: true },
					rt.ArrayItem{ key: '__experimentalTextTransform', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'fontSize', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: '__experimentalBorder', val: rt.create_array([
					rt.ArrayItem{ key: 'radius', val: true },
					rt.ArrayItem{ key: 'color', val: true },
					rt.ArrayItem{ key: 'width', val: true },
					rt.ArrayItem{ key: 'style', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'radius', val: true },
						rt.ArrayItem{ key: 'color', val: true },
						rt.ArrayItem{ key: 'width', val: true },
						rt.ArrayItem{ key: 'style', val: true },
					]) },
				]) },
			]) },
			rt.ArrayItem{ key: 'editorStyle', val: 'wp-block-post-comments-form-editor' },
			rt.ArrayItem{ key: 'style', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'wp-block-post-comments-form' },
				rt.ArrayItem{ key: none, val: 'wp-block-buttons' },
				rt.ArrayItem{ key: none, val: 'wp-block-button' },
			]) },
			rt.ArrayItem{ key: 'example', val: rt.create_array([
				rt.ArrayItem{ key: 'attributes', val: rt.create_array([
					rt.ArrayItem{ key: 'style', val: rt.create_array([
						rt.ArrayItem{ key: 'typography', val: rt.create_array([
							rt.ArrayItem{ key: 'textAlign', val: 'center' },
						]) },
					]) },
				]) },
			]) },
		]) },
		rt.ArrayItem{ key: 'post-comments-link', val: rt.create_array([
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: 'name', val: 'core/post-comments-link' },
			rt.ArrayItem{ key: 'title', val: 'Comments Link' },
			rt.ArrayItem{ key: 'category', val: 'theme' },
			rt.ArrayItem{ key: 'description', val: 'Displays the link to the current post comments.' },
			rt.ArrayItem{ key: 'textdomain', val: 'default' },
			rt.ArrayItem{ key: 'usesContext', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'postType' },
				rt.ArrayItem{ key: none, val: 'postId' },
			]) },
			rt.ArrayItem{ key: 'example', val: rt.create_array([
				rt.ArrayItem{ key: 'viewportWidth', val: 350 },
			]) },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'anchor', val: true },
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'color', val: rt.create_array([
					rt.ArrayItem{ key: 'link', val: true },
					rt.ArrayItem{ key: 'text', val: false },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'background', val: true },
						rt.ArrayItem{ key: 'link', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'spacing', val: rt.create_array([
					rt.ArrayItem{ key: 'margin', val: true },
					rt.ArrayItem{ key: 'padding', val: true },
				]) },
				rt.ArrayItem{ key: 'typography', val: rt.create_array([
					rt.ArrayItem{ key: 'fontSize', val: true },
					rt.ArrayItem{ key: 'lineHeight', val: true },
					rt.ArrayItem{ key: 'textAlign', val: true },
					rt.ArrayItem{ key: '__experimentalFontFamily', val: true },
					rt.ArrayItem{ key: '__experimentalFontWeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontStyle', val: true },
					rt.ArrayItem{ key: '__experimentalTextTransform', val: true },
					rt.ArrayItem{ key: '__experimentalTextDecoration', val: true },
					rt.ArrayItem{ key: '__experimentalLetterSpacing', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'fontSize', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'interactivity', val: rt.create_array([
					rt.ArrayItem{ key: 'clientNavigation', val: true },
				]) },
				rt.ArrayItem{ key: '__experimentalBorder', val: rt.create_array([
					rt.ArrayItem{ key: 'radius', val: true },
					rt.ArrayItem{ key: 'color', val: true },
					rt.ArrayItem{ key: 'width', val: true },
					rt.ArrayItem{ key: 'style', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'radius', val: true },
						rt.ArrayItem{ key: 'color', val: true },
						rt.ArrayItem{ key: 'width', val: true },
						rt.ArrayItem{ key: 'style', val: true },
					]) },
				]) },
			]) },
			rt.ArrayItem{ key: 'style', val: 'wp-block-post-comments-link' },
		]) },
		rt.ArrayItem{ key: 'post-content', val: rt.create_array([
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: 'name', val: 'core/post-content' },
			rt.ArrayItem{ key: 'title', val: 'Content' },
			rt.ArrayItem{ key: 'category', val: 'theme' },
			rt.ArrayItem{ key: 'description', val: 'Displays the contents of a post or page.' },
			rt.ArrayItem{ key: 'textdomain', val: 'default' },
			rt.ArrayItem{ key: 'usesContext', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'postId' },
				rt.ArrayItem{ key: none, val: 'postType' },
				rt.ArrayItem{ key: none, val: 'queryId' },
			]) },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'tagName', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: 'div' },
				]) },
			]) },
			rt.ArrayItem{ key: 'example', val: rt.create_array([
				rt.ArrayItem{ key: 'viewportWidth', val: 350 },
			]) },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'anchor', val: true },
				rt.ArrayItem{ key: 'align', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'wide' },
					rt.ArrayItem{ key: none, val: 'full' },
				]) },
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'layout', val: true },
				rt.ArrayItem{ key: 'background', val: rt.create_array([
					rt.ArrayItem{ key: 'backgroundImage', val: true },
					rt.ArrayItem{ key: 'backgroundSize', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'backgroundImage', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'dimensions', val: rt.create_array([
					rt.ArrayItem{ key: 'minHeight', val: true },
				]) },
				rt.ArrayItem{ key: 'spacing', val: rt.create_array([
					rt.ArrayItem{ key: 'blockGap', val: true },
					rt.ArrayItem{ key: 'padding', val: true },
					rt.ArrayItem{ key: 'margin', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'margin', val: false },
						rt.ArrayItem{ key: 'padding', val: false },
					]) },
				]) },
				rt.ArrayItem{ key: 'color', val: rt.create_array([
					rt.ArrayItem{ key: 'gradients', val: true },
					rt.ArrayItem{ key: 'heading', val: true },
					rt.ArrayItem{ key: 'link', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'background', val: false },
						rt.ArrayItem{ key: 'text', val: false },
					]) },
				]) },
				rt.ArrayItem{ key: 'typography', val: rt.create_array([
					rt.ArrayItem{ key: 'fontSize', val: true },
					rt.ArrayItem{ key: 'lineHeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontFamily', val: true },
					rt.ArrayItem{ key: '__experimentalFontWeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontStyle', val: true },
					rt.ArrayItem{ key: '__experimentalTextTransform', val: true },
					rt.ArrayItem{ key: '__experimentalTextDecoration', val: true },
					rt.ArrayItem{ key: '__experimentalLetterSpacing', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'fontSize', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'interactivity', val: rt.create_array([
					rt.ArrayItem{ key: 'clientNavigation', val: true },
				]) },
				rt.ArrayItem{ key: '__experimentalBorder', val: rt.create_array([
					rt.ArrayItem{ key: 'radius', val: true },
					rt.ArrayItem{ key: 'color', val: true },
					rt.ArrayItem{ key: 'width', val: true },
					rt.ArrayItem{ key: 'style', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'radius', val: true },
						rt.ArrayItem{ key: 'color', val: true },
						rt.ArrayItem{ key: 'width', val: true },
						rt.ArrayItem{ key: 'style', val: true },
					]) },
				]) },
			]) },
			rt.ArrayItem{ key: 'style', val: 'wp-block-post-content' },
			rt.ArrayItem{ key: 'editorStyle', val: 'wp-block-post-content-editor' },
		]) },
		rt.ArrayItem{ key: 'post-date', val: rt.create_array([
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: 'name', val: 'core/post-date' },
			rt.ArrayItem{ key: 'title', val: 'Date' },
			rt.ArrayItem{ key: 'category', val: 'theme' },
			rt.ArrayItem{ key: 'description', val: 'Display a custom date.' },
			rt.ArrayItem{ key: 'textdomain', val: 'default' },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'datetime', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'role', val: 'content' },
				]) },
				rt.ArrayItem{ key: 'textAlign', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
				rt.ArrayItem{ key: 'format', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
				rt.ArrayItem{ key: 'isLink', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: false },
					rt.ArrayItem{ key: 'role', val: 'content' },
				]) },
			]) },
			rt.ArrayItem{ key: 'usesContext', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'postId' },
				rt.ArrayItem{ key: none, val: 'postType' },
				rt.ArrayItem{ key: none, val: 'queryId' },
			]) },
			rt.ArrayItem{ key: 'example', val: rt.create_array([
				rt.ArrayItem{ key: 'viewportWidth', val: 350 },
			]) },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'anchor', val: true },
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'color', val: rt.create_array([
					rt.ArrayItem{ key: 'gradients', val: true },
					rt.ArrayItem{ key: 'link', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'background', val: true },
						rt.ArrayItem{ key: 'text', val: true },
						rt.ArrayItem{ key: 'link', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'spacing', val: rt.create_array([
					rt.ArrayItem{ key: 'margin', val: true },
					rt.ArrayItem{ key: 'padding', val: true },
				]) },
				rt.ArrayItem{ key: 'typography', val: rt.create_array([
					rt.ArrayItem{ key: 'fontSize', val: true },
					rt.ArrayItem{ key: 'lineHeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontFamily', val: true },
					rt.ArrayItem{ key: '__experimentalFontWeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontStyle', val: true },
					rt.ArrayItem{ key: '__experimentalTextTransform', val: true },
					rt.ArrayItem{ key: '__experimentalTextDecoration', val: true },
					rt.ArrayItem{ key: '__experimentalLetterSpacing', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'fontSize', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'interactivity', val: rt.create_array([
					rt.ArrayItem{ key: 'clientNavigation', val: true },
				]) },
				rt.ArrayItem{ key: '__experimentalBorder', val: rt.create_array([
					rt.ArrayItem{ key: 'radius', val: true },
					rt.ArrayItem{ key: 'color', val: true },
					rt.ArrayItem{ key: 'width', val: true },
					rt.ArrayItem{ key: 'style', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'radius', val: true },
						rt.ArrayItem{ key: 'color', val: true },
						rt.ArrayItem{ key: 'width', val: true },
						rt.ArrayItem{ key: 'style', val: true },
					]) },
				]) },
			]) },
		]) },
		rt.ArrayItem{ key: 'post-excerpt', val: rt.create_array([
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: 'name', val: 'core/post-excerpt' },
			rt.ArrayItem{ key: 'title', val: 'Excerpt' },
			rt.ArrayItem{ key: 'category', val: 'theme' },
			rt.ArrayItem{ key: 'description', val: 'Display the excerpt.' },
			rt.ArrayItem{ key: 'textdomain', val: 'default' },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'textAlign', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
				rt.ArrayItem{ key: 'moreText', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'role', val: 'content' },
				]) },
				rt.ArrayItem{ key: 'showMoreOnNewLine', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: true },
				]) },
				rt.ArrayItem{ key: 'excerptLength', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'number' },
					rt.ArrayItem{ key: 'default', val: 55 },
				]) },
			]) },
			rt.ArrayItem{ key: 'usesContext', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'postId' },
				rt.ArrayItem{ key: none, val: 'postType' },
				rt.ArrayItem{ key: none, val: 'queryId' },
			]) },
			rt.ArrayItem{ key: 'example', val: rt.create_array([
				rt.ArrayItem{ key: 'viewportWidth', val: 350 },
			]) },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'anchor', val: true },
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'color', val: rt.create_array([
					rt.ArrayItem{ key: 'gradients', val: true },
					rt.ArrayItem{ key: 'link', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'background', val: true },
						rt.ArrayItem{ key: 'text', val: true },
						rt.ArrayItem{ key: 'link', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'spacing', val: rt.create_array([
					rt.ArrayItem{ key: 'margin', val: true },
					rt.ArrayItem{ key: 'padding', val: true },
				]) },
				rt.ArrayItem{ key: 'typography', val: rt.create_array([
					rt.ArrayItem{ key: 'fontSize', val: true },
					rt.ArrayItem{ key: 'lineHeight', val: true },
					rt.ArrayItem{ key: 'textColumns', val: true },
					rt.ArrayItem{ key: '__experimentalFontFamily', val: true },
					rt.ArrayItem{ key: '__experimentalFontWeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontStyle', val: true },
					rt.ArrayItem{ key: '__experimentalTextTransform', val: true },
					rt.ArrayItem{ key: '__experimentalTextDecoration', val: true },
					rt.ArrayItem{ key: '__experimentalLetterSpacing', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'fontSize', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'interactivity', val: rt.create_array([
					rt.ArrayItem{ key: 'clientNavigation', val: true },
				]) },
				rt.ArrayItem{ key: '__experimentalBorder', val: rt.create_array([
					rt.ArrayItem{ key: 'radius', val: true },
					rt.ArrayItem{ key: 'color', val: true },
					rt.ArrayItem{ key: 'width', val: true },
					rt.ArrayItem{ key: 'style', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'radius', val: true },
						rt.ArrayItem{ key: 'color', val: true },
						rt.ArrayItem{ key: 'width', val: true },
						rt.ArrayItem{ key: 'style', val: true },
					]) },
				]) },
			]) },
			rt.ArrayItem{ key: 'editorStyle', val: 'wp-block-post-excerpt-editor' },
			rt.ArrayItem{ key: 'style', val: 'wp-block-post-excerpt' },
		]) },
		rt.ArrayItem{ key: 'post-featured-image', val: rt.create_array([
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: 'name', val: 'core/post-featured-image' },
			rt.ArrayItem{ key: 'title', val: 'Featured Image' },
			rt.ArrayItem{ key: 'category', val: 'theme' },
			rt.ArrayItem{ key: 'description', val: "Display a post's featured image." },
			rt.ArrayItem{ key: 'textdomain', val: 'default' },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'isLink', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: false },
					rt.ArrayItem{ key: 'role', val: 'content' },
				]) },
				rt.ArrayItem{ key: 'aspectRatio', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
				rt.ArrayItem{ key: 'width', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
				rt.ArrayItem{ key: 'height', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
				rt.ArrayItem{ key: 'scale', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: 'cover' },
				]) },
				rt.ArrayItem{ key: 'sizeSlug', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
				rt.ArrayItem{ key: 'rel', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'attribute', val: 'rel' },
					rt.ArrayItem{ key: 'default', val: '' },
					rt.ArrayItem{ key: 'role', val: 'content' },
				]) },
				rt.ArrayItem{ key: 'linkTarget', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: '_self' },
					rt.ArrayItem{ key: 'role', val: 'content' },
				]) },
				rt.ArrayItem{ key: 'overlayColor', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
				rt.ArrayItem{ key: 'customOverlayColor', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
				rt.ArrayItem{ key: 'dimRatio', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'number' },
					rt.ArrayItem{ key: 'default', val: 0 },
				]) },
				rt.ArrayItem{ key: 'gradient', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
				rt.ArrayItem{ key: 'customGradient', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
				rt.ArrayItem{ key: 'useFirstImageFromPost', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: false },
				]) },
			]) },
			rt.ArrayItem{ key: 'usesContext', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'postId' },
				rt.ArrayItem{ key: none, val: 'postType' },
				rt.ArrayItem{ key: none, val: 'queryId' },
			]) },
			rt.ArrayItem{ key: 'example', val: rt.create_array([
				rt.ArrayItem{ key: 'viewportWidth', val: 350 },
			]) },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'anchor', val: true },
				rt.ArrayItem{ key: 'align', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'left' },
					rt.ArrayItem{ key: none, val: 'right' },
					rt.ArrayItem{ key: none, val: 'center' },
					rt.ArrayItem{ key: none, val: 'wide' },
					rt.ArrayItem{ key: none, val: 'full' },
				]) },
				rt.ArrayItem{ key: 'color', val: rt.create_array([
					rt.ArrayItem{ key: 'text', val: false },
					rt.ArrayItem{ key: 'background', val: false },
				]) },
				rt.ArrayItem{ key: '__experimentalBorder', val: rt.create_array([
					rt.ArrayItem{ key: 'color', val: true },
					rt.ArrayItem{ key: 'radius', val: true },
					rt.ArrayItem{ key: 'width', val: true },
					rt.ArrayItem{ key: '__experimentalSkipSerialization', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'color', val: true },
						rt.ArrayItem{ key: 'radius', val: true },
						rt.ArrayItem{ key: 'width', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'filter', val: rt.create_array([
					rt.ArrayItem{ key: 'duotone', val: true },
				]) },
				rt.ArrayItem{ key: 'shadow', val: rt.create_array([
					rt.ArrayItem{ key: '__experimentalSkipSerialization', val: true },
				]) },
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'spacing', val: rt.create_array([
					rt.ArrayItem{ key: 'margin', val: true },
					rt.ArrayItem{ key: 'padding', val: true },
				]) },
				rt.ArrayItem{ key: 'interactivity', val: rt.create_array([
					rt.ArrayItem{ key: 'clientNavigation', val: true },
				]) },
			]) },
			rt.ArrayItem{ key: 'selectors', val: rt.create_array([
				rt.ArrayItem{
					key: 'border'
					val: '.wp-block-post-featured-image img, .wp-block-post-featured-image .block-editor-media-placeholder, .wp-block-post-featured-image .wp-block-post-featured-image__overlay'
				},
				rt.ArrayItem{
					key: 'shadow'
					val: '.wp-block-post-featured-image img, .wp-block-post-featured-image .components-placeholder'
				},
				rt.ArrayItem{ key: 'filter', val: rt.create_array([
					rt.ArrayItem{
						key: 'duotone'
						val: '.wp-block-post-featured-image img, .wp-block-post-featured-image .wp-block-post-featured-image__placeholder, .wp-block-post-featured-image .components-placeholder__illustration, .wp-block-post-featured-image .components-placeholder::before'
					},
				]) },
			]) },
			rt.ArrayItem{ key: 'editorStyle', val: 'wp-block-post-featured-image-editor' },
			rt.ArrayItem{ key: 'style', val: 'wp-block-post-featured-image' },
		]) },
		rt.ArrayItem{ key: 'post-navigation-link', val: rt.create_array([
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: 'name', val: 'core/post-navigation-link' },
			rt.ArrayItem{ key: 'title', val: 'Post Navigation Link' },
			rt.ArrayItem{ key: 'category', val: 'theme' },
			rt.ArrayItem{
				key: 'description'
				val: 'Displays the next or previous post link that is adjacent to the current post.'
			},
			rt.ArrayItem{ key: 'textdomain', val: 'default' },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'textAlign', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
				rt.ArrayItem{ key: 'type', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: 'next' },
				]) },
				rt.ArrayItem{ key: 'label', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'role', val: 'content' },
				]) },
				rt.ArrayItem{ key: 'showTitle', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: false },
				]) },
				rt.ArrayItem{ key: 'linkLabel', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: false },
				]) },
				rt.ArrayItem{ key: 'arrow', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: 'none' },
				]) },
				rt.ArrayItem{ key: 'taxonomy', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: '' },
				]) },
			]) },
			rt.ArrayItem{ key: 'usesContext', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'postType' },
			]) },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'anchor', val: true },
				rt.ArrayItem{ key: 'reusable', val: false },
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'color', val: rt.create_array([
					rt.ArrayItem{ key: 'link', val: true },
				]) },
				rt.ArrayItem{ key: 'typography', val: rt.create_array([
					rt.ArrayItem{ key: 'fontSize', val: true },
					rt.ArrayItem{ key: 'lineHeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontFamily', val: true },
					rt.ArrayItem{ key: '__experimentalFontWeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontStyle', val: true },
					rt.ArrayItem{ key: '__experimentalTextTransform', val: true },
					rt.ArrayItem{ key: '__experimentalTextDecoration', val: true },
					rt.ArrayItem{ key: '__experimentalLetterSpacing', val: true },
					rt.ArrayItem{ key: '__experimentalWritingMode', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'fontSize', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'interactivity', val: rt.create_array([
					rt.ArrayItem{ key: 'clientNavigation', val: true },
				]) },
			]) },
			rt.ArrayItem{ key: 'style', val: 'wp-block-post-navigation-link' },
		]) },
		rt.ArrayItem{ key: 'post-template', val: rt.create_array([
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: 'name', val: 'core/post-template' },
			rt.ArrayItem{ key: 'title', val: 'Post Template' },
			rt.ArrayItem{ key: 'category', val: 'theme' },
			rt.ArrayItem{ key: 'ancestor', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'core/query' },
			]) },
			rt.ArrayItem{
				key: 'description'
				val: 'Contains the block elements used to render a post, like the title, date, featured image, content or excerpt, and more.'
			},
			rt.ArrayItem{ key: 'textdomain', val: 'default' },
			rt.ArrayItem{ key: 'usesContext', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'queryId' },
				rt.ArrayItem{ key: none, val: 'query' },
				rt.ArrayItem{ key: none, val: 'displayLayout' },
				rt.ArrayItem{ key: none, val: 'templateSlug' },
				rt.ArrayItem{ key: none, val: 'previewPostType' },
				rt.ArrayItem{ key: none, val: 'enhancedPagination' },
				rt.ArrayItem{ key: none, val: 'postType' },
			]) },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'anchor', val: true },
				rt.ArrayItem{ key: 'reusable', val: false },
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'align', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'wide' },
					rt.ArrayItem{ key: none, val: 'full' },
				]) },
				rt.ArrayItem{ key: 'layout', val: true },
				rt.ArrayItem{ key: 'color', val: rt.create_array([
					rt.ArrayItem{ key: 'gradients', val: true },
					rt.ArrayItem{ key: 'link', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'background', val: true },
						rt.ArrayItem{ key: 'text', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'typography', val: rt.create_array([
					rt.ArrayItem{ key: 'fontSize', val: true },
					rt.ArrayItem{ key: 'lineHeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontFamily', val: true },
					rt.ArrayItem{ key: '__experimentalFontWeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontStyle', val: true },
					rt.ArrayItem{ key: '__experimentalTextTransform', val: true },
					rt.ArrayItem{ key: '__experimentalTextDecoration', val: true },
					rt.ArrayItem{ key: '__experimentalLetterSpacing', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'fontSize', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'spacing', val: rt.create_array([
					rt.ArrayItem{ key: 'margin', val: true },
					rt.ArrayItem{ key: 'padding', val: true },
					rt.ArrayItem{ key: 'blockGap', val: rt.create_array([
						rt.ArrayItem{ key: '__experimentalDefault', val: '1.25em' },
					]) },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'blockGap', val: true },
						rt.ArrayItem{ key: 'padding', val: false },
						rt.ArrayItem{ key: 'margin', val: false },
					]) },
				]) },
				rt.ArrayItem{ key: 'interactivity', val: rt.create_array([
					rt.ArrayItem{ key: 'clientNavigation', val: true },
				]) },
				rt.ArrayItem{ key: '__experimentalBorder', val: rt.create_array([
					rt.ArrayItem{ key: 'radius', val: true },
					rt.ArrayItem{ key: 'color', val: true },
					rt.ArrayItem{ key: 'width', val: true },
					rt.ArrayItem{ key: 'style', val: true },
				]) },
			]) },
			rt.ArrayItem{ key: 'style', val: 'wp-block-post-template' },
			rt.ArrayItem{ key: 'editorStyle', val: 'wp-block-post-template-editor' },
		]) },
		rt.ArrayItem{ key: 'post-terms', val: rt.create_array([
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: 'name', val: 'core/post-terms' },
			rt.ArrayItem{ key: 'title', val: 'Post Terms' },
			rt.ArrayItem{ key: 'category', val: 'theme' },
			rt.ArrayItem{ key: 'description', val: 'Post terms.' },
			rt.ArrayItem{ key: 'textdomain', val: 'default' },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'term', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
				rt.ArrayItem{ key: 'separator', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: ', ' },
				]) },
				rt.ArrayItem{ key: 'prefix', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: '' },
					rt.ArrayItem{ key: 'role', val: 'content' },
				]) },
				rt.ArrayItem{ key: 'suffix', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: '' },
					rt.ArrayItem{ key: 'role', val: 'content' },
				]) },
			]) },
			rt.ArrayItem{ key: 'usesContext', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'postId' },
				rt.ArrayItem{ key: none, val: 'postType' },
			]) },
			rt.ArrayItem{ key: 'example', val: rt.create_array([
				rt.ArrayItem{ key: 'viewportWidth', val: 350 },
			]) },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'anchor', val: true },
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'color', val: rt.create_array([
					rt.ArrayItem{ key: 'gradients', val: true },
					rt.ArrayItem{ key: 'link', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'background', val: true },
						rt.ArrayItem{ key: 'text', val: true },
						rt.ArrayItem{ key: 'link', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'spacing', val: rt.create_array([
					rt.ArrayItem{ key: 'margin', val: true },
					rt.ArrayItem{ key: 'padding', val: true },
				]) },
				rt.ArrayItem{ key: 'typography', val: rt.create_array([
					rt.ArrayItem{ key: 'fontSize', val: true },
					rt.ArrayItem{ key: 'lineHeight', val: true },
					rt.ArrayItem{ key: 'textAlign', val: true },
					rt.ArrayItem{ key: '__experimentalFontFamily', val: true },
					rt.ArrayItem{ key: '__experimentalFontWeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontStyle', val: true },
					rt.ArrayItem{ key: '__experimentalTextTransform', val: true },
					rt.ArrayItem{ key: '__experimentalTextDecoration', val: true },
					rt.ArrayItem{ key: '__experimentalLetterSpacing', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'fontSize', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'interactivity', val: rt.create_array([
					rt.ArrayItem{ key: 'clientNavigation', val: true },
				]) },
				rt.ArrayItem{ key: '__experimentalBorder', val: rt.create_array([
					rt.ArrayItem{ key: 'radius', val: true },
					rt.ArrayItem{ key: 'color', val: true },
					rt.ArrayItem{ key: 'width', val: true },
					rt.ArrayItem{ key: 'style', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'radius', val: true },
						rt.ArrayItem{ key: 'color', val: true },
						rt.ArrayItem{ key: 'width', val: true },
						rt.ArrayItem{ key: 'style', val: true },
					]) },
				]) },
			]) },
			rt.ArrayItem{ key: 'style', val: 'wp-block-post-terms' },
		]) },
		rt.ArrayItem{ key: 'post-time-to-read', val: rt.create_array([
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: 'name', val: 'core/post-time-to-read' },
			rt.ArrayItem{ key: 'title', val: 'Time to Read' },
			rt.ArrayItem{ key: 'category', val: 'theme' },
			rt.ArrayItem{
				key: 'description'
				val: 'Show minutes required to finish reading the post. Can also show a word count.'
			},
			rt.ArrayItem{ key: 'textdomain', val: 'default' },
			rt.ArrayItem{ key: 'usesContext', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'postId' },
				rt.ArrayItem{ key: none, val: 'postType' },
			]) },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'displayAsRange', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: true },
				]) },
				rt.ArrayItem{ key: 'displayMode', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: 'time' },
				]) },
				rt.ArrayItem{ key: 'averageReadingSpeed', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'number' },
					rt.ArrayItem{ key: 'default', val: 189 },
				]) },
			]) },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'anchor', val: true },
				rt.ArrayItem{ key: 'color', val: rt.create_array([
					rt.ArrayItem{ key: 'gradients', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'background', val: true },
						rt.ArrayItem{ key: 'text', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'spacing', val: rt.create_array([
					rt.ArrayItem{ key: 'margin', val: true },
					rt.ArrayItem{ key: 'padding', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'margin', val: false },
						rt.ArrayItem{ key: 'padding', val: false },
					]) },
				]) },
				rt.ArrayItem{ key: 'typography', val: rt.create_array([
					rt.ArrayItem{ key: 'fontSize', val: true },
					rt.ArrayItem{ key: 'lineHeight', val: true },
					rt.ArrayItem{ key: 'textAlign', val: true },
					rt.ArrayItem{ key: '__experimentalFontFamily', val: true },
					rt.ArrayItem{ key: '__experimentalFontWeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontStyle', val: true },
					rt.ArrayItem{ key: '__experimentalTextTransform', val: true },
					rt.ArrayItem{ key: '__experimentalTextDecoration', val: true },
					rt.ArrayItem{ key: '__experimentalLetterSpacing', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'fontSize', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'interactivity', val: rt.create_array([
					rt.ArrayItem{ key: 'clientNavigation', val: true },
				]) },
				rt.ArrayItem{ key: '__experimentalBorder', val: rt.create_array([
					rt.ArrayItem{ key: 'radius', val: true },
					rt.ArrayItem{ key: 'color', val: true },
					rt.ArrayItem{ key: 'width', val: true },
					rt.ArrayItem{ key: 'style', val: true },
				]) },
			]) },
		]) },
		rt.ArrayItem{ key: 'post-title', val: rt.create_array([
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: 'name', val: 'core/post-title' },
			rt.ArrayItem{ key: 'title', val: 'Title' },
			rt.ArrayItem{ key: 'category', val: 'theme' },
			rt.ArrayItem{
				key: 'description'
				val: 'Displays the title of a post, page, or any other content-type.'
			},
			rt.ArrayItem{ key: 'textdomain', val: 'default' },
			rt.ArrayItem{ key: 'usesContext', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'postId' },
				rt.ArrayItem{ key: none, val: 'postType' },
				rt.ArrayItem{ key: none, val: 'queryId' },
			]) },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'textAlign', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
				rt.ArrayItem{ key: 'level', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'number' },
					rt.ArrayItem{ key: 'default', val: 2 },
				]) },
				rt.ArrayItem{ key: 'levelOptions', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'array' },
				]) },
				rt.ArrayItem{ key: 'isLink', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: false },
					rt.ArrayItem{ key: 'role', val: 'content' },
				]) },
				rt.ArrayItem{ key: 'rel', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'attribute', val: 'rel' },
					rt.ArrayItem{ key: 'default', val: '' },
					rt.ArrayItem{ key: 'role', val: 'content' },
				]) },
				rt.ArrayItem{ key: 'linkTarget', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: '_self' },
					rt.ArrayItem{ key: 'role', val: 'content' },
				]) },
			]) },
			rt.ArrayItem{ key: 'example', val: rt.create_array([
				rt.ArrayItem{ key: 'viewportWidth', val: 350 },
			]) },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'anchor', val: true },
				rt.ArrayItem{ key: 'align', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'wide' },
					rt.ArrayItem{ key: none, val: 'full' },
				]) },
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'color', val: rt.create_array([
					rt.ArrayItem{ key: 'gradients', val: true },
					rt.ArrayItem{ key: 'link', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'background', val: true },
						rt.ArrayItem{ key: 'text', val: true },
						rt.ArrayItem{ key: 'link', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'spacing', val: rt.create_array([
					rt.ArrayItem{ key: 'margin', val: true },
					rt.ArrayItem{ key: 'padding', val: true },
				]) },
				rt.ArrayItem{ key: 'typography', val: rt.create_array([
					rt.ArrayItem{ key: 'fontSize', val: true },
					rt.ArrayItem{ key: 'lineHeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontFamily', val: true },
					rt.ArrayItem{ key: '__experimentalFontWeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontStyle', val: true },
					rt.ArrayItem{ key: '__experimentalTextTransform', val: true },
					rt.ArrayItem{ key: '__experimentalTextDecoration', val: true },
					rt.ArrayItem{ key: '__experimentalLetterSpacing', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'fontSize', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'interactivity', val: rt.create_array([
					rt.ArrayItem{ key: 'clientNavigation', val: true },
				]) },
				rt.ArrayItem{ key: '__experimentalBorder', val: rt.create_array([
					rt.ArrayItem{ key: 'radius', val: true },
					rt.ArrayItem{ key: 'color', val: true },
					rt.ArrayItem{ key: 'width', val: true },
					rt.ArrayItem{ key: 'style', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'radius', val: true },
						rt.ArrayItem{ key: 'color', val: true },
						rt.ArrayItem{ key: 'width', val: true },
						rt.ArrayItem{ key: 'style', val: true },
					]) },
				]) },
			]) },
			rt.ArrayItem{ key: 'style', val: 'wp-block-post-title' },
		]) },
		rt.ArrayItem{ key: 'preformatted', val: rt.create_array([
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: 'name', val: 'core/preformatted' },
			rt.ArrayItem{ key: 'title', val: 'Preformatted' },
			rt.ArrayItem{ key: 'category', val: 'text' },
			rt.ArrayItem{
				key: 'description'
				val: 'Add text that respects your spacing and tabs, and also allows styling.'
			},
			rt.ArrayItem{ key: 'textdomain', val: 'default' },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'content', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'rich-text' },
					rt.ArrayItem{ key: 'source', val: 'rich-text' },
					rt.ArrayItem{ key: 'selector', val: 'pre' },
					rt.ArrayItem{ key: '__unstablePreserveWhiteSpace', val: true },
					rt.ArrayItem{ key: 'role', val: 'content' },
				]) },
			]) },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'anchor', val: true },
				rt.ArrayItem{ key: 'color', val: rt.create_array([
					rt.ArrayItem{ key: 'gradients', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'background', val: true },
						rt.ArrayItem{ key: 'text', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'spacing', val: rt.create_array([
					rt.ArrayItem{ key: 'padding', val: true },
					rt.ArrayItem{ key: 'margin', val: true },
				]) },
				rt.ArrayItem{ key: 'typography', val: rt.create_array([
					rt.ArrayItem{ key: 'fontSize', val: true },
					rt.ArrayItem{ key: 'lineHeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontFamily', val: true },
					rt.ArrayItem{ key: '__experimentalFontWeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontStyle', val: true },
					rt.ArrayItem{ key: '__experimentalTextTransform', val: true },
					rt.ArrayItem{ key: '__experimentalTextDecoration', val: true },
					rt.ArrayItem{ key: '__experimentalLetterSpacing', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'fontSize', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'interactivity', val: rt.create_array([
					rt.ArrayItem{ key: 'clientNavigation', val: true },
				]) },
				rt.ArrayItem{ key: '__experimentalBorder', val: rt.create_array([
					rt.ArrayItem{ key: 'radius', val: true },
					rt.ArrayItem{ key: 'color', val: true },
					rt.ArrayItem{ key: 'width', val: true },
					rt.ArrayItem{ key: 'style', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'radius', val: true },
						rt.ArrayItem{ key: 'color', val: true },
						rt.ArrayItem{ key: 'width', val: true },
						rt.ArrayItem{ key: 'style', val: true },
					]) },
				]) },
			]) },
			rt.ArrayItem{ key: 'style', val: 'wp-block-preformatted' },
		]) },
		rt.ArrayItem{ key: 'pullquote', val: rt.create_array([
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: 'name', val: 'core/pullquote' },
			rt.ArrayItem{ key: 'title', val: 'Pullquote' },
			rt.ArrayItem{ key: 'category', val: 'text' },
			rt.ArrayItem{
				key: 'description'
				val: 'Give special visual emphasis to a quote from your text.'
			},
			rt.ArrayItem{ key: 'textdomain', val: 'default' },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'value', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'rich-text' },
					rt.ArrayItem{ key: 'source', val: 'rich-text' },
					rt.ArrayItem{ key: 'selector', val: 'p' },
					rt.ArrayItem{ key: 'role', val: 'content' },
				]) },
				rt.ArrayItem{ key: 'citation', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'rich-text' },
					rt.ArrayItem{ key: 'source', val: 'rich-text' },
					rt.ArrayItem{ key: 'selector', val: 'cite' },
					rt.ArrayItem{ key: 'role', val: 'content' },
				]) },
				rt.ArrayItem{ key: 'textAlign', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
			]) },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'anchor', val: true },
				rt.ArrayItem{ key: 'align', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'left' },
					rt.ArrayItem{ key: none, val: 'right' },
					rt.ArrayItem{ key: none, val: 'wide' },
					rt.ArrayItem{ key: none, val: 'full' },
				]) },
				rt.ArrayItem{ key: 'background', val: rt.create_array([
					rt.ArrayItem{ key: 'backgroundImage', val: true },
					rt.ArrayItem{ key: 'backgroundSize', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'backgroundImage', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'color', val: rt.create_array([
					rt.ArrayItem{ key: 'gradients', val: true },
					rt.ArrayItem{ key: 'background', val: true },
					rt.ArrayItem{ key: 'link', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'background', val: true },
						rt.ArrayItem{ key: 'text', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'dimensions', val: rt.create_array([
					rt.ArrayItem{ key: 'minHeight', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'minHeight', val: false },
					]) },
				]) },
				rt.ArrayItem{ key: 'spacing', val: rt.create_array([
					rt.ArrayItem{ key: 'margin', val: true },
					rt.ArrayItem{ key: 'padding', val: true },
				]) },
				rt.ArrayItem{ key: 'typography', val: rt.create_array([
					rt.ArrayItem{ key: 'fontSize', val: true },
					rt.ArrayItem{ key: 'lineHeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontFamily', val: true },
					rt.ArrayItem{ key: '__experimentalFontWeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontStyle', val: true },
					rt.ArrayItem{ key: '__experimentalTextTransform', val: true },
					rt.ArrayItem{ key: '__experimentalTextDecoration', val: true },
					rt.ArrayItem{ key: '__experimentalLetterSpacing', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'fontSize', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: '__experimentalBorder', val: rt.create_array([
					rt.ArrayItem{ key: 'color', val: true },
					rt.ArrayItem{ key: 'radius', val: true },
					rt.ArrayItem{ key: 'style', val: true },
					rt.ArrayItem{ key: 'width', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'color', val: true },
						rt.ArrayItem{ key: 'radius', val: true },
						rt.ArrayItem{ key: 'style', val: true },
						rt.ArrayItem{ key: 'width', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: '__experimentalStyle', val: rt.create_array([
					rt.ArrayItem{ key: 'typography', val: rt.create_array([
						rt.ArrayItem{ key: 'fontSize', val: '1.5em' },
						rt.ArrayItem{ key: 'lineHeight', val: '1.6' },
					]) },
				]) },
				rt.ArrayItem{ key: 'interactivity', val: rt.create_array([
					rt.ArrayItem{ key: 'clientNavigation', val: true },
				]) },
			]) },
			rt.ArrayItem{ key: 'editorStyle', val: 'wp-block-pullquote-editor' },
			rt.ArrayItem{ key: 'style', val: 'wp-block-pullquote' },
		]) },
		rt.ArrayItem{ key: 'query', val: rt.create_array([
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: 'name', val: 'core/query' },
			rt.ArrayItem{ key: 'title', val: 'Query Loop' },
			rt.ArrayItem{ key: 'category', val: 'theme' },
			rt.ArrayItem{
				key: 'description'
				val: 'An advanced block that allows displaying post types based on different query parameters and visual configurations.'
			},
			rt.ArrayItem{ key: 'keywords', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'posts' },
				rt.ArrayItem{ key: none, val: 'list' },
				rt.ArrayItem{ key: none, val: 'blog' },
				rt.ArrayItem{ key: none, val: 'blogs' },
				rt.ArrayItem{ key: none, val: 'custom post types' },
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'default' },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'queryId', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'number' },
				]) },
				rt.ArrayItem{ key: 'query', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'object' },
					rt.ArrayItem{ key: 'default', val: rt.create_array([
						rt.ArrayItem{ key: 'perPage', val: rt.new_null() },
						rt.ArrayItem{ key: 'pages', val: 0 },
						rt.ArrayItem{ key: 'offset', val: 0 },
						rt.ArrayItem{ key: 'postType', val: 'post' },
						rt.ArrayItem{ key: 'order', val: 'desc' },
						rt.ArrayItem{ key: 'orderBy', val: 'date' },
						rt.ArrayItem{ key: 'author', val: '' },
						rt.ArrayItem{ key: 'search', val: '' },
						rt.ArrayItem{ key: 'exclude', val: rt.new_array() },
						rt.ArrayItem{ key: 'sticky', val: '' },
						rt.ArrayItem{ key: 'inherit', val: true },
						rt.ArrayItem{ key: 'taxQuery', val: rt.new_null() },
						rt.ArrayItem{ key: 'parents', val: rt.new_array() },
						rt.ArrayItem{ key: 'format', val: rt.new_array() },
					]) },
				]) },
				rt.ArrayItem{ key: 'tagName', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: 'div' },
				]) },
				rt.ArrayItem{ key: 'namespace', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
				rt.ArrayItem{ key: 'enhancedPagination', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: false },
				]) },
			]) },
			rt.ArrayItem{ key: 'usesContext', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'templateSlug' },
			]) },
			rt.ArrayItem{ key: 'providesContext', val: rt.create_array([
				rt.ArrayItem{ key: 'queryId', val: 'queryId' },
				rt.ArrayItem{ key: 'query', val: 'query' },
				rt.ArrayItem{ key: 'displayLayout', val: 'displayLayout' },
				rt.ArrayItem{ key: 'enhancedPagination', val: 'enhancedPagination' },
			]) },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'anchor', val: true },
				rt.ArrayItem{ key: 'align', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'wide' },
					rt.ArrayItem{ key: none, val: 'full' },
				]) },
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'layout', val: true },
				rt.ArrayItem{ key: 'interactivity', val: true },
			]) },
			rt.ArrayItem{ key: 'editorStyle', val: 'wp-block-query-editor' },
		]) },
		rt.ArrayItem{ key: 'query-no-results', val: rt.create_array([
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: 'name', val: 'core/query-no-results' },
			rt.ArrayItem{ key: 'title', val: 'No Results' },
			rt.ArrayItem{ key: 'category', val: 'theme' },
			rt.ArrayItem{
				key: 'description'
				val: 'Contains the block elements used to render content when no query results are found.'
			},
			rt.ArrayItem{ key: 'ancestor', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'core/query' },
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'default' },
			rt.ArrayItem{ key: 'usesContext', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'queryId' },
				rt.ArrayItem{ key: none, val: 'query' },
			]) },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'anchor', val: true },
				rt.ArrayItem{ key: 'align', val: true },
				rt.ArrayItem{ key: 'reusable', val: false },
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'color', val: rt.create_array([
					rt.ArrayItem{ key: 'gradients', val: true },
					rt.ArrayItem{ key: 'link', val: true },
				]) },
				rt.ArrayItem{ key: 'typography', val: rt.create_array([
					rt.ArrayItem{ key: 'fontSize', val: true },
					rt.ArrayItem{ key: 'lineHeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontFamily', val: true },
					rt.ArrayItem{ key: '__experimentalFontWeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontStyle', val: true },
					rt.ArrayItem{ key: '__experimentalTextTransform', val: true },
					rt.ArrayItem{ key: '__experimentalTextDecoration', val: true },
					rt.ArrayItem{ key: '__experimentalLetterSpacing', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'fontSize', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'interactivity', val: rt.create_array([
					rt.ArrayItem{ key: 'clientNavigation', val: true },
				]) },
			]) },
		]) },
		rt.ArrayItem{ key: 'query-pagination', val: rt.create_array([
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: 'name', val: 'core/query-pagination' },
			rt.ArrayItem{ key: 'title', val: 'Pagination' },
			rt.ArrayItem{ key: 'category', val: 'theme' },
			rt.ArrayItem{ key: 'ancestor', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'core/query' },
			]) },
			rt.ArrayItem{ key: 'allowedBlocks', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'core/query-pagination-previous' },
				rt.ArrayItem{ key: none, val: 'core/query-pagination-numbers' },
				rt.ArrayItem{ key: none, val: 'core/query-pagination-next' },
			]) },
			rt.ArrayItem{
				key: 'description'
				val: 'Displays a paginated navigation to next/previous set of posts, when applicable.'
			},
			rt.ArrayItem{ key: 'textdomain', val: 'default' },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'paginationArrow', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: 'none' },
				]) },
				rt.ArrayItem{ key: 'showLabel', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: true },
				]) },
			]) },
			rt.ArrayItem{ key: 'usesContext', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'queryId' },
				rt.ArrayItem{ key: none, val: 'query' },
			]) },
			rt.ArrayItem{ key: 'providesContext', val: rt.create_array([
				rt.ArrayItem{ key: 'paginationArrow', val: 'paginationArrow' },
				rt.ArrayItem{ key: 'showLabel', val: 'showLabel' },
			]) },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'anchor', val: true },
				rt.ArrayItem{ key: 'align', val: true },
				rt.ArrayItem{ key: 'reusable', val: false },
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'color', val: rt.create_array([
					rt.ArrayItem{ key: 'gradients', val: true },
					rt.ArrayItem{ key: 'link', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'background', val: true },
						rt.ArrayItem{ key: 'text', val: true },
						rt.ArrayItem{ key: 'link', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'layout', val: rt.create_array([
					rt.ArrayItem{ key: 'allowSwitching', val: false },
					rt.ArrayItem{ key: 'allowInheriting', val: false },
					rt.ArrayItem{ key: 'default', val: rt.create_array([
						rt.ArrayItem{ key: 'type', val: 'flex' },
					]) },
				]) },
				rt.ArrayItem{ key: 'typography', val: rt.create_array([
					rt.ArrayItem{ key: 'fontSize', val: true },
					rt.ArrayItem{ key: 'lineHeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontFamily', val: true },
					rt.ArrayItem{ key: '__experimentalFontWeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontStyle', val: true },
					rt.ArrayItem{ key: '__experimentalTextTransform', val: true },
					rt.ArrayItem{ key: '__experimentalTextDecoration', val: true },
					rt.ArrayItem{ key: '__experimentalLetterSpacing', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'fontSize', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'interactivity', val: rt.create_array([
					rt.ArrayItem{ key: 'clientNavigation', val: true },
				]) },
			]) },
			rt.ArrayItem{ key: 'editorStyle', val: 'wp-block-query-pagination-editor' },
			rt.ArrayItem{ key: 'style', val: 'wp-block-query-pagination' },
		]) },
		rt.ArrayItem{ key: 'query-pagination-next', val: rt.create_array([
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: 'name', val: 'core/query-pagination-next' },
			rt.ArrayItem{ key: 'title', val: 'Next Page' },
			rt.ArrayItem{ key: 'category', val: 'theme' },
			rt.ArrayItem{ key: 'parent', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'core/query-pagination' },
			]) },
			rt.ArrayItem{ key: 'description', val: 'Displays the next posts page link.' },
			rt.ArrayItem{ key: 'textdomain', val: 'default' },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'label', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
			]) },
			rt.ArrayItem{ key: 'usesContext', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'queryId' },
				rt.ArrayItem{ key: none, val: 'query' },
				rt.ArrayItem{ key: none, val: 'paginationArrow' },
				rt.ArrayItem{ key: none, val: 'showLabel' },
				rt.ArrayItem{ key: none, val: 'enhancedPagination' },
			]) },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'anchor', val: true },
				rt.ArrayItem{ key: 'reusable', val: false },
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'color', val: rt.create_array([
					rt.ArrayItem{ key: 'gradients', val: true },
					rt.ArrayItem{ key: 'text', val: false },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'background', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'typography', val: rt.create_array([
					rt.ArrayItem{ key: 'fontSize', val: true },
					rt.ArrayItem{ key: 'lineHeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontFamily', val: true },
					rt.ArrayItem{ key: '__experimentalFontWeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontStyle', val: true },
					rt.ArrayItem{ key: '__experimentalTextTransform', val: true },
					rt.ArrayItem{ key: '__experimentalTextDecoration', val: true },
					rt.ArrayItem{ key: '__experimentalLetterSpacing', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'fontSize', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'interactivity', val: rt.create_array([
					rt.ArrayItem{ key: 'clientNavigation', val: true },
				]) },
			]) },
		]) },
		rt.ArrayItem{ key: 'query-pagination-numbers', val: rt.create_array([
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: 'name', val: 'core/query-pagination-numbers' },
			rt.ArrayItem{ key: 'title', val: 'Page Numbers' },
			rt.ArrayItem{ key: 'category', val: 'theme' },
			rt.ArrayItem{ key: 'parent', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'core/query-pagination' },
			]) },
			rt.ArrayItem{ key: 'description', val: 'Displays a list of page numbers for pagination.' },
			rt.ArrayItem{ key: 'textdomain', val: 'default' },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'midSize', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'number' },
					rt.ArrayItem{ key: 'default', val: 2 },
				]) },
			]) },
			rt.ArrayItem{ key: 'usesContext', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'queryId' },
				rt.ArrayItem{ key: none, val: 'query' },
				rt.ArrayItem{ key: none, val: 'enhancedPagination' },
			]) },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'anchor', val: true },
				rt.ArrayItem{ key: 'reusable', val: false },
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'color', val: rt.create_array([
					rt.ArrayItem{ key: 'gradients', val: true },
					rt.ArrayItem{ key: 'text', val: false },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'background', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'typography', val: rt.create_array([
					rt.ArrayItem{ key: 'fontSize', val: true },
					rt.ArrayItem{ key: 'lineHeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontFamily', val: true },
					rt.ArrayItem{ key: '__experimentalFontWeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontStyle', val: true },
					rt.ArrayItem{ key: '__experimentalTextTransform', val: true },
					rt.ArrayItem{ key: '__experimentalTextDecoration', val: true },
					rt.ArrayItem{ key: '__experimentalLetterSpacing', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'fontSize', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'interactivity', val: rt.create_array([
					rt.ArrayItem{ key: 'clientNavigation', val: true },
				]) },
			]) },
			rt.ArrayItem{ key: 'editorStyle', val: 'wp-block-query-pagination-numbers-editor' },
		]) },
		rt.ArrayItem{ key: 'query-pagination-previous', val: rt.create_array([
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: 'name', val: 'core/query-pagination-previous' },
			rt.ArrayItem{ key: 'title', val: 'Previous Page' },
			rt.ArrayItem{ key: 'category', val: 'theme' },
			rt.ArrayItem{ key: 'parent', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'core/query-pagination' },
			]) },
			rt.ArrayItem{ key: 'description', val: 'Displays the previous posts page link.' },
			rt.ArrayItem{ key: 'textdomain', val: 'default' },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'label', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
			]) },
			rt.ArrayItem{ key: 'usesContext', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'queryId' },
				rt.ArrayItem{ key: none, val: 'query' },
				rt.ArrayItem{ key: none, val: 'paginationArrow' },
				rt.ArrayItem{ key: none, val: 'showLabel' },
				rt.ArrayItem{ key: none, val: 'enhancedPagination' },
			]) },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'anchor', val: true },
				rt.ArrayItem{ key: 'reusable', val: false },
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'color', val: rt.create_array([
					rt.ArrayItem{ key: 'gradients', val: true },
					rt.ArrayItem{ key: 'text', val: false },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'background', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'typography', val: rt.create_array([
					rt.ArrayItem{ key: 'fontSize', val: true },
					rt.ArrayItem{ key: 'lineHeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontFamily', val: true },
					rt.ArrayItem{ key: '__experimentalFontWeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontStyle', val: true },
					rt.ArrayItem{ key: '__experimentalTextTransform', val: true },
					rt.ArrayItem{ key: '__experimentalTextDecoration', val: true },
					rt.ArrayItem{ key: '__experimentalLetterSpacing', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'fontSize', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'interactivity', val: rt.create_array([
					rt.ArrayItem{ key: 'clientNavigation', val: true },
				]) },
			]) },
		]) },
		rt.ArrayItem{ key: 'query-title', val: rt.create_array([
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: 'name', val: 'core/query-title' },
			rt.ArrayItem{ key: 'title', val: 'Query Title' },
			rt.ArrayItem{ key: 'category', val: 'theme' },
			rt.ArrayItem{ key: 'description', val: 'Display the query title.' },
			rt.ArrayItem{ key: 'textdomain', val: 'default' },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
				rt.ArrayItem{ key: 'textAlign', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
				rt.ArrayItem{ key: 'level', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'number' },
					rt.ArrayItem{ key: 'default', val: 1 },
				]) },
				rt.ArrayItem{ key: 'levelOptions', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'array' },
				]) },
				rt.ArrayItem{ key: 'showPrefix', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: true },
				]) },
				rt.ArrayItem{ key: 'showSearchTerm', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: true },
				]) },
			]) },
			rt.ArrayItem{ key: 'example', val: rt.create_array([
				rt.ArrayItem{ key: 'attributes', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'search' },
				]) },
			]) },
			rt.ArrayItem{ key: 'usesContext', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'query' },
			]) },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'anchor', val: true },
				rt.ArrayItem{ key: 'align', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'wide' },
					rt.ArrayItem{ key: none, val: 'full' },
				]) },
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'color', val: rt.create_array([
					rt.ArrayItem{ key: 'gradients', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'background', val: true },
						rt.ArrayItem{ key: 'text', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'spacing', val: rt.create_array([
					rt.ArrayItem{ key: 'margin', val: true },
					rt.ArrayItem{ key: 'padding', val: true },
				]) },
				rt.ArrayItem{ key: 'typography', val: rt.create_array([
					rt.ArrayItem{ key: 'fontSize', val: true },
					rt.ArrayItem{ key: 'lineHeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontFamily', val: true },
					rt.ArrayItem{ key: '__experimentalFontStyle', val: true },
					rt.ArrayItem{ key: '__experimentalFontWeight', val: true },
					rt.ArrayItem{ key: '__experimentalLetterSpacing', val: true },
					rt.ArrayItem{ key: '__experimentalTextTransform', val: true },
					rt.ArrayItem{ key: '__experimentalTextDecoration', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'fontSize', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'interactivity', val: rt.create_array([
					rt.ArrayItem{ key: 'clientNavigation', val: true },
				]) },
				rt.ArrayItem{ key: '__experimentalBorder', val: rt.create_array([
					rt.ArrayItem{ key: 'radius', val: true },
					rt.ArrayItem{ key: 'color', val: true },
					rt.ArrayItem{ key: 'width', val: true },
					rt.ArrayItem{ key: 'style', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'radius', val: true },
						rt.ArrayItem{ key: 'color', val: true },
						rt.ArrayItem{ key: 'width', val: true },
						rt.ArrayItem{ key: 'style', val: true },
					]) },
				]) },
			]) },
			rt.ArrayItem{ key: 'style', val: 'wp-block-query-title' },
		]) },
		rt.ArrayItem{ key: 'query-total', val: rt.create_array([
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: 'name', val: 'core/query-total' },
			rt.ArrayItem{ key: 'title', val: 'Query Total' },
			rt.ArrayItem{ key: 'category', val: 'theme' },
			rt.ArrayItem{ key: 'ancestor', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'core/query' },
			]) },
			rt.ArrayItem{ key: 'description', val: 'Display the total number of results in a query.' },
			rt.ArrayItem{ key: 'textdomain', val: 'default' },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'displayType', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: 'total-results' },
				]) },
			]) },
			rt.ArrayItem{ key: 'usesContext', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'queryId' },
				rt.ArrayItem{ key: none, val: 'query' },
			]) },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'anchor', val: true },
				rt.ArrayItem{ key: 'align', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'wide' },
					rt.ArrayItem{ key: none, val: 'full' },
				]) },
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'spacing', val: rt.create_array([
					rt.ArrayItem{ key: 'margin', val: true },
					rt.ArrayItem{ key: 'padding', val: true },
				]) },
				rt.ArrayItem{ key: 'color', val: rt.create_array([
					rt.ArrayItem{ key: 'gradients', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'background', val: true },
						rt.ArrayItem{ key: 'text', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'typography', val: rt.create_array([
					rt.ArrayItem{ key: 'fontSize', val: true },
					rt.ArrayItem{ key: 'lineHeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontFamily', val: true },
					rt.ArrayItem{ key: '__experimentalFontWeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontStyle', val: true },
					rt.ArrayItem{ key: '__experimentalTextTransform', val: true },
					rt.ArrayItem{ key: '__experimentalTextDecoration', val: true },
					rt.ArrayItem{ key: '__experimentalLetterSpacing', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'fontSize', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: '__experimentalBorder', val: rt.create_array([
					rt.ArrayItem{ key: 'radius', val: true },
					rt.ArrayItem{ key: 'color', val: true },
					rt.ArrayItem{ key: 'width', val: true },
					rt.ArrayItem{ key: 'style', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'radius', val: true },
						rt.ArrayItem{ key: 'color', val: true },
						rt.ArrayItem{ key: 'width', val: true },
						rt.ArrayItem{ key: 'style', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'interactivity', val: rt.create_array([
					rt.ArrayItem{ key: 'clientNavigation', val: true },
				]) },
			]) },
			rt.ArrayItem{ key: 'style', val: 'wp-block-query-total' },
		]) },
		rt.ArrayItem{ key: 'quote', val: rt.create_array([
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: 'name', val: 'core/quote' },
			rt.ArrayItem{ key: 'title', val: 'Quote' },
			rt.ArrayItem{ key: 'category', val: 'text' },
			rt.ArrayItem{
				key: 'description'
				val: 'Give quoted text visual emphasis. "In quoting others, we cite ourselves." — Julio Cortázar'
			},
			rt.ArrayItem{ key: 'keywords', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'blockquote' },
				rt.ArrayItem{ key: none, val: 'cite' },
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'default' },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'value', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'source', val: 'html' },
					rt.ArrayItem{ key: 'selector', val: 'blockquote' },
					rt.ArrayItem{ key: 'multiline', val: 'p' },
					rt.ArrayItem{ key: 'default', val: '' },
					rt.ArrayItem{ key: 'role', val: 'content' },
				]) },
				rt.ArrayItem{ key: 'citation', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'rich-text' },
					rt.ArrayItem{ key: 'source', val: 'rich-text' },
					rt.ArrayItem{ key: 'selector', val: 'cite' },
					rt.ArrayItem{ key: 'role', val: 'content' },
				]) },
				rt.ArrayItem{ key: 'textAlign', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
			]) },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'anchor', val: true },
				rt.ArrayItem{ key: 'align', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'left' },
					rt.ArrayItem{ key: none, val: 'right' },
					rt.ArrayItem{ key: none, val: 'wide' },
					rt.ArrayItem{ key: none, val: 'full' },
				]) },
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'background', val: rt.create_array([
					rt.ArrayItem{ key: 'backgroundImage', val: true },
					rt.ArrayItem{ key: 'backgroundSize', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'backgroundImage', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: '__experimentalBorder', val: rt.create_array([
					rt.ArrayItem{ key: 'color', val: true },
					rt.ArrayItem{ key: 'radius', val: true },
					rt.ArrayItem{ key: 'style', val: true },
					rt.ArrayItem{ key: 'width', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'color', val: true },
						rt.ArrayItem{ key: 'radius', val: true },
						rt.ArrayItem{ key: 'style', val: true },
						rt.ArrayItem{ key: 'width', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'dimensions', val: rt.create_array([
					rt.ArrayItem{ key: 'minHeight', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'minHeight', val: false },
					]) },
				]) },
				rt.ArrayItem{ key: '__experimentalOnEnter', val: true },
				rt.ArrayItem{ key: '__experimentalOnMerge', val: true },
				rt.ArrayItem{ key: 'typography', val: rt.create_array([
					rt.ArrayItem{ key: 'fontSize', val: true },
					rt.ArrayItem{ key: 'lineHeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontFamily', val: true },
					rt.ArrayItem{ key: '__experimentalFontWeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontStyle', val: true },
					rt.ArrayItem{ key: '__experimentalTextTransform', val: true },
					rt.ArrayItem{ key: '__experimentalTextDecoration', val: true },
					rt.ArrayItem{ key: '__experimentalLetterSpacing', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'fontSize', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'color', val: rt.create_array([
					rt.ArrayItem{ key: 'gradients', val: true },
					rt.ArrayItem{ key: 'heading', val: true },
					rt.ArrayItem{ key: 'link', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'background', val: true },
						rt.ArrayItem{ key: 'text', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'layout', val: rt.create_array([
					rt.ArrayItem{ key: 'allowEditing', val: false },
				]) },
				rt.ArrayItem{ key: 'spacing', val: rt.create_array([
					rt.ArrayItem{ key: 'blockGap', val: true },
					rt.ArrayItem{ key: 'padding', val: true },
					rt.ArrayItem{ key: 'margin', val: true },
				]) },
				rt.ArrayItem{ key: 'interactivity', val: rt.create_array([
					rt.ArrayItem{ key: 'clientNavigation', val: true },
				]) },
				rt.ArrayItem{ key: 'allowedBlocks', val: true },
			]) },
			rt.ArrayItem{ key: 'styles', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.create_array([
					rt.ArrayItem{ key: 'name', val: 'default' },
					rt.ArrayItem{ key: 'label', val: 'Default' },
					rt.ArrayItem{ key: 'isDefault', val: true },
				]) },
				rt.ArrayItem{ key: none, val: rt.create_array([
					rt.ArrayItem{ key: 'name', val: 'plain' },
					rt.ArrayItem{ key: 'label', val: 'Plain' },
				]) },
			]) },
			rt.ArrayItem{ key: 'editorStyle', val: 'wp-block-quote-editor' },
			rt.ArrayItem{ key: 'style', val: 'wp-block-quote' },
		]) },
		rt.ArrayItem{ key: 'read-more', val: rt.create_array([
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: 'name', val: 'core/read-more' },
			rt.ArrayItem{ key: 'title', val: 'Read More' },
			rt.ArrayItem{ key: 'category', val: 'theme' },
			rt.ArrayItem{
				key: 'description'
				val: 'Displays the link of a post, page, or any other content-type.'
			},
			rt.ArrayItem{ key: 'textdomain', val: 'default' },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'content', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'role', val: 'content' },
				]) },
				rt.ArrayItem{ key: 'linkTarget', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: '_self' },
				]) },
			]) },
			rt.ArrayItem{ key: 'usesContext', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'postId' },
			]) },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'anchor', val: true },
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'color', val: rt.create_array([
					rt.ArrayItem{ key: 'gradients', val: true },
					rt.ArrayItem{ key: 'text', val: true },
				]) },
				rt.ArrayItem{ key: 'typography', val: rt.create_array([
					rt.ArrayItem{ key: 'fontSize', val: true },
					rt.ArrayItem{ key: 'lineHeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontFamily', val: true },
					rt.ArrayItem{ key: '__experimentalFontWeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontStyle', val: true },
					rt.ArrayItem{ key: '__experimentalTextTransform', val: true },
					rt.ArrayItem{ key: '__experimentalLetterSpacing', val: true },
					rt.ArrayItem{ key: '__experimentalTextDecoration', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'fontSize', val: true },
						rt.ArrayItem{ key: 'textDecoration', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'spacing', val: rt.create_array([
					rt.ArrayItem{ key: 'margin', val: rt.create_array([
						rt.ArrayItem{ key: none, val: 'top' },
						rt.ArrayItem{ key: none, val: 'bottom' },
					]) },
					rt.ArrayItem{ key: 'padding', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'padding', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: '__experimentalBorder', val: rt.create_array([
					rt.ArrayItem{ key: 'color', val: true },
					rt.ArrayItem{ key: 'radius', val: true },
					rt.ArrayItem{ key: 'width', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'width', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'interactivity', val: rt.create_array([
					rt.ArrayItem{ key: 'clientNavigation', val: true },
				]) },
			]) },
			rt.ArrayItem{ key: 'style', val: 'wp-block-read-more' },
		]) },
		rt.ArrayItem{ key: 'rss', val: rt.create_array([
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: 'name', val: 'core/rss' },
			rt.ArrayItem{ key: 'title', val: 'RSS' },
			rt.ArrayItem{ key: 'category', val: 'widgets' },
			rt.ArrayItem{ key: 'description', val: 'Display entries from any RSS or Atom feed.' },
			rt.ArrayItem{ key: 'keywords', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'atom' },
				rt.ArrayItem{ key: none, val: 'feed' },
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'default' },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'columns', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'number' },
					rt.ArrayItem{ key: 'default', val: 2 },
				]) },
				rt.ArrayItem{ key: 'blockLayout', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: 'list' },
				]) },
				rt.ArrayItem{ key: 'feedURL', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: '' },
					rt.ArrayItem{ key: 'role', val: 'content' },
				]) },
				rt.ArrayItem{ key: 'itemsToShow', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'number' },
					rt.ArrayItem{ key: 'default', val: 5 },
				]) },
				rt.ArrayItem{ key: 'displayExcerpt', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: false },
				]) },
				rt.ArrayItem{ key: 'displayAuthor', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: false },
				]) },
				rt.ArrayItem{ key: 'displayDate', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: false },
				]) },
				rt.ArrayItem{ key: 'excerptLength', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'number' },
					rt.ArrayItem{ key: 'default', val: 55 },
				]) },
				rt.ArrayItem{ key: 'openInNewTab', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: false },
				]) },
				rt.ArrayItem{ key: 'rel', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
			]) },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'anchor', val: true },
				rt.ArrayItem{ key: 'align', val: true },
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'interactivity', val: rt.create_array([
					rt.ArrayItem{ key: 'clientNavigation', val: true },
				]) },
				rt.ArrayItem{ key: '__experimentalBorder', val: rt.create_array([
					rt.ArrayItem{ key: 'radius', val: true },
					rt.ArrayItem{ key: 'color', val: true },
					rt.ArrayItem{ key: 'width', val: true },
					rt.ArrayItem{ key: 'style', val: true },
				]) },
				rt.ArrayItem{ key: 'spacing', val: rt.create_array([
					rt.ArrayItem{ key: 'margin', val: true },
					rt.ArrayItem{ key: 'padding', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'padding', val: false },
						rt.ArrayItem{ key: 'margin', val: false },
					]) },
				]) },
				rt.ArrayItem{ key: 'color', val: rt.create_array([
					rt.ArrayItem{ key: 'background', val: true },
					rt.ArrayItem{ key: 'text', val: true },
					rt.ArrayItem{ key: 'gradients', val: true },
					rt.ArrayItem{ key: 'link', val: true },
				]) },
			]) },
			rt.ArrayItem{ key: 'editorStyle', val: 'wp-block-rss-editor' },
			rt.ArrayItem{ key: 'style', val: 'wp-block-rss' },
		]) },
		rt.ArrayItem{ key: 'search', val: rt.create_array([
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: 'name', val: 'core/search' },
			rt.ArrayItem{ key: 'title', val: 'Search' },
			rt.ArrayItem{ key: 'category', val: 'widgets' },
			rt.ArrayItem{ key: 'description', val: 'Help visitors find your content.' },
			rt.ArrayItem{ key: 'keywords', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'find' },
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'default' },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'label', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'role', val: 'content' },
				]) },
				rt.ArrayItem{ key: 'showLabel', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: true },
				]) },
				rt.ArrayItem{ key: 'placeholder', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: '' },
					rt.ArrayItem{ key: 'role', val: 'content' },
				]) },
				rt.ArrayItem{ key: 'width', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'number' },
				]) },
				rt.ArrayItem{ key: 'widthUnit', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
				rt.ArrayItem{ key: 'buttonText', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'role', val: 'content' },
				]) },
				rt.ArrayItem{ key: 'buttonPosition', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: 'button-outside' },
				]) },
				rt.ArrayItem{ key: 'buttonUseIcon', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: false },
				]) },
				rt.ArrayItem{ key: 'query', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'object' },
					rt.ArrayItem{ key: 'default', val: rt.new_array() },
				]) },
				rt.ArrayItem{ key: 'isSearchFieldHidden', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: false },
				]) },
			]) },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'anchor', val: true },
				rt.ArrayItem{ key: 'align', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'left' },
					rt.ArrayItem{ key: none, val: 'center' },
					rt.ArrayItem{ key: none, val: 'right' },
				]) },
				rt.ArrayItem{ key: 'color', val: rt.create_array([
					rt.ArrayItem{ key: 'gradients', val: true },
					rt.ArrayItem{ key: '__experimentalSkipSerialization', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'background', val: true },
						rt.ArrayItem{ key: 'text', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'interactivity', val: true },
				rt.ArrayItem{ key: 'typography', val: rt.create_array([
					rt.ArrayItem{ key: '__experimentalSkipSerialization', val: true },
					rt.ArrayItem{
						key: '__experimentalSelector'
						val: '.wp-block-search__label, .wp-block-search__input, .wp-block-search__button'
					},
					rt.ArrayItem{ key: 'fontSize', val: true },
					rt.ArrayItem{ key: 'lineHeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontFamily', val: true },
					rt.ArrayItem{ key: '__experimentalFontWeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontStyle', val: true },
					rt.ArrayItem{ key: '__experimentalTextTransform', val: true },
					rt.ArrayItem{ key: '__experimentalTextDecoration', val: true },
					rt.ArrayItem{ key: '__experimentalLetterSpacing', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'fontSize', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: '__experimentalBorder', val: rt.create_array([
					rt.ArrayItem{ key: 'color', val: true },
					rt.ArrayItem{ key: 'radius', val: true },
					rt.ArrayItem{ key: 'width', val: true },
					rt.ArrayItem{ key: '__experimentalSkipSerialization', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'color', val: true },
						rt.ArrayItem{ key: 'radius', val: true },
						rt.ArrayItem{ key: 'width', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'spacing', val: rt.create_array([
					rt.ArrayItem{ key: 'margin', val: true },
				]) },
				rt.ArrayItem{ key: 'html', val: false },
			]) },
			rt.ArrayItem{ key: 'editorStyle', val: 'wp-block-search-editor' },
			rt.ArrayItem{ key: 'style', val: 'wp-block-search' },
		]) },
		rt.ArrayItem{ key: 'separator', val: rt.create_array([
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: 'name', val: 'core/separator' },
			rt.ArrayItem{ key: 'title', val: 'Separator' },
			rt.ArrayItem{ key: 'category', val: 'design' },
			rt.ArrayItem{
				key: 'description'
				val: 'Create a break between ideas or sections with a horizontal separator.'
			},
			rt.ArrayItem{ key: 'keywords', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'horizontal-line' },
				rt.ArrayItem{ key: none, val: 'hr' },
				rt.ArrayItem{ key: none, val: 'divider' },
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'default' },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'opacity', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: 'alpha-channel' },
				]) },
				rt.ArrayItem{ key: 'tagName', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'enum', val: rt.create_array([
						rt.ArrayItem{ key: none, val: 'hr' },
						rt.ArrayItem{ key: none, val: 'div' },
					]) },
					rt.ArrayItem{ key: 'default', val: 'hr' },
				]) },
			]) },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'anchor', val: true },
				rt.ArrayItem{ key: 'align', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'center' },
					rt.ArrayItem{ key: none, val: 'wide' },
					rt.ArrayItem{ key: none, val: 'full' },
				]) },
				rt.ArrayItem{ key: 'color', val: rt.create_array([
					rt.ArrayItem{ key: 'enableContrastChecker', val: false },
					rt.ArrayItem{ key: '__experimentalSkipSerialization', val: true },
					rt.ArrayItem{ key: 'gradients', val: true },
					rt.ArrayItem{ key: 'background', val: true },
					rt.ArrayItem{ key: 'text', val: false },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'background', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'spacing', val: rt.create_array([
					rt.ArrayItem{ key: 'margin', val: rt.create_array([
						rt.ArrayItem{ key: none, val: 'top' },
						rt.ArrayItem{ key: none, val: 'bottom' },
					]) },
				]) },
				rt.ArrayItem{ key: 'interactivity', val: rt.create_array([
					rt.ArrayItem{ key: 'clientNavigation', val: true },
				]) },
			]) },
			rt.ArrayItem{ key: 'styles', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.create_array([
					rt.ArrayItem{ key: 'name', val: 'default' },
					rt.ArrayItem{ key: 'label', val: 'Default' },
					rt.ArrayItem{ key: 'isDefault', val: true },
				]) },
				rt.ArrayItem{ key: none, val: rt.create_array([
					rt.ArrayItem{ key: 'name', val: 'wide' },
					rt.ArrayItem{ key: 'label', val: 'Wide Line' },
				]) },
				rt.ArrayItem{ key: none, val: rt.create_array([
					rt.ArrayItem{ key: 'name', val: 'dots' },
					rt.ArrayItem{ key: 'label', val: 'Dots' },
				]) },
			]) },
			rt.ArrayItem{ key: 'editorStyle', val: 'wp-block-separator-editor' },
			rt.ArrayItem{ key: 'style', val: 'wp-block-separator' },
		]) },
		rt.ArrayItem{ key: 'shortcode', val: rt.create_array([
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: 'name', val: 'core/shortcode' },
			rt.ArrayItem{ key: 'title', val: 'Shortcode' },
			rt.ArrayItem{ key: 'category', val: 'widgets' },
			rt.ArrayItem{
				key: 'description'
				val: 'Insert additional custom elements with a WordPress shortcode.'
			},
			rt.ArrayItem{ key: 'textdomain', val: 'default' },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'text', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'source', val: 'raw' },
					rt.ArrayItem{ key: 'role', val: 'content' },
				]) },
			]) },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'className', val: false },
				rt.ArrayItem{ key: 'customClassName', val: false },
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'customCSS', val: false },
				rt.ArrayItem{ key: 'visibility', val: false },
			]) },
			rt.ArrayItem{ key: 'editorStyle', val: 'wp-block-shortcode-editor' },
		]) },
		rt.ArrayItem{ key: 'site-logo', val: rt.create_array([
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: 'name', val: 'core/site-logo' },
			rt.ArrayItem{ key: 'title', val: 'Site Logo' },
			rt.ArrayItem{ key: 'category', val: 'theme' },
			rt.ArrayItem{
				key: 'description'
				val: 'Display an image to represent this site. Update this block and the changes apply everywhere.'
			},
			rt.ArrayItem{ key: 'textdomain', val: 'default' },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'width', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'number' },
				]) },
				rt.ArrayItem{ key: 'isLink', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: true },
					rt.ArrayItem{ key: 'role', val: 'content' },
				]) },
				rt.ArrayItem{ key: 'linkTarget', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: '_self' },
					rt.ArrayItem{ key: 'role', val: 'content' },
				]) },
				rt.ArrayItem{ key: 'shouldSyncIcon', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
				]) },
			]) },
			rt.ArrayItem{ key: 'example', val: rt.create_array([
				rt.ArrayItem{ key: 'viewportWidth', val: 500 },
				rt.ArrayItem{ key: 'attributes', val: rt.create_array([
					rt.ArrayItem{ key: 'width', val: 350 },
					rt.ArrayItem{
						key: 'className'
						val: 'block-editor-block-types-list__site-logo-example'
					},
				]) },
			]) },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'anchor', val: true },
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'align', val: true },
				rt.ArrayItem{ key: 'alignWide', val: false },
				rt.ArrayItem{ key: 'color', val: rt.create_array([
					rt.ArrayItem{ key: 'text', val: false },
					rt.ArrayItem{ key: 'background', val: false },
				]) },
				rt.ArrayItem{ key: 'spacing', val: rt.create_array([
					rt.ArrayItem{ key: 'margin', val: true },
					rt.ArrayItem{ key: 'padding', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'margin', val: false },
						rt.ArrayItem{ key: 'padding', val: false },
					]) },
				]) },
				rt.ArrayItem{ key: 'interactivity', val: rt.create_array([
					rt.ArrayItem{ key: 'clientNavigation', val: true },
				]) },
				rt.ArrayItem{ key: 'filter', val: rt.create_array([
					rt.ArrayItem{ key: 'duotone', val: true },
				]) },
			]) },
			rt.ArrayItem{ key: 'styles', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.create_array([
					rt.ArrayItem{ key: 'name', val: 'default' },
					rt.ArrayItem{ key: 'label', val: 'Default' },
					rt.ArrayItem{ key: 'isDefault', val: true },
				]) },
				rt.ArrayItem{ key: none, val: rt.create_array([
					rt.ArrayItem{ key: 'name', val: 'rounded' },
					rt.ArrayItem{ key: 'label', val: 'Rounded' },
				]) },
			]) },
			rt.ArrayItem{ key: 'selectors', val: rt.create_array([
				rt.ArrayItem{ key: 'filter', val: rt.create_array([
					rt.ArrayItem{
						key: 'duotone'
						val: '.wp-block-site-logo img, .wp-block-site-logo .components-placeholder__illustration, .wp-block-site-logo .components-placeholder::before'
					},
				]) },
			]) },
			rt.ArrayItem{ key: 'editorStyle', val: 'wp-block-site-logo-editor' },
			rt.ArrayItem{ key: 'style', val: 'wp-block-site-logo' },
		]) },
		rt.ArrayItem{ key: 'site-tagline', val: rt.create_array([
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: 'name', val: 'core/site-tagline' },
			rt.ArrayItem{ key: 'title', val: 'Site Tagline' },
			rt.ArrayItem{ key: 'category', val: 'theme' },
			rt.ArrayItem{
				key: 'description'
				val: 'Describe in a few words what this site is about. This is important for search results, sharing on social media, and gives overall clarity to visitors.'
			},
			rt.ArrayItem{ key: 'keywords', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'description' },
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'default' },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'textAlign', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
				rt.ArrayItem{ key: 'level', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'number' },
					rt.ArrayItem{ key: 'default', val: 0 },
				]) },
				rt.ArrayItem{ key: 'levelOptions', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'array' },
					rt.ArrayItem{ key: 'default', val: rt.create_array([
						rt.ArrayItem{ key: none, val: 0 },
						rt.ArrayItem{ key: none, val: 1 },
						rt.ArrayItem{ key: none, val: 2 },
						rt.ArrayItem{ key: none, val: 3 },
						rt.ArrayItem{ key: none, val: 4 },
						rt.ArrayItem{ key: none, val: 5 },
						rt.ArrayItem{ key: none, val: 6 },
					]) },
				]) },
			]) },
			rt.ArrayItem{ key: 'example', val: rt.create_array([
				rt.ArrayItem{ key: 'viewportWidth', val: 350 },
				rt.ArrayItem{ key: 'attributes', val: rt.create_array([
					rt.ArrayItem{ key: 'textAlign', val: 'center' },
				]) },
			]) },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'anchor', val: true },
				rt.ArrayItem{ key: 'align', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'wide' },
					rt.ArrayItem{ key: none, val: 'full' },
				]) },
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'color', val: rt.create_array([
					rt.ArrayItem{ key: 'gradients', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'background', val: true },
						rt.ArrayItem{ key: 'text', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'contentRole', val: true },
				rt.ArrayItem{ key: 'spacing', val: rt.create_array([
					rt.ArrayItem{ key: 'margin', val: true },
					rt.ArrayItem{ key: 'padding', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'margin', val: false },
						rt.ArrayItem{ key: 'padding', val: false },
					]) },
				]) },
				rt.ArrayItem{ key: 'typography', val: rt.create_array([
					rt.ArrayItem{ key: 'fontSize', val: true },
					rt.ArrayItem{ key: 'lineHeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontFamily', val: true },
					rt.ArrayItem{ key: '__experimentalTextTransform', val: true },
					rt.ArrayItem{ key: '__experimentalTextDecoration', val: true },
					rt.ArrayItem{ key: '__experimentalFontStyle', val: true },
					rt.ArrayItem{ key: '__experimentalFontWeight', val: true },
					rt.ArrayItem{ key: '__experimentalLetterSpacing', val: true },
					rt.ArrayItem{ key: '__experimentalWritingMode', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'fontSize', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'interactivity', val: rt.create_array([
					rt.ArrayItem{ key: 'clientNavigation', val: true },
				]) },
				rt.ArrayItem{ key: '__experimentalBorder', val: rt.create_array([
					rt.ArrayItem{ key: 'radius', val: true },
					rt.ArrayItem{ key: 'color', val: true },
					rt.ArrayItem{ key: 'width', val: true },
					rt.ArrayItem{ key: 'style', val: true },
				]) },
			]) },
			rt.ArrayItem{ key: 'editorStyle', val: 'wp-block-site-tagline-editor' },
			rt.ArrayItem{ key: 'style', val: 'wp-block-site-tagline' },
		]) },
		rt.ArrayItem{ key: 'site-title', val: rt.create_array([
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: 'name', val: 'core/site-title' },
			rt.ArrayItem{ key: 'title', val: 'Site Title' },
			rt.ArrayItem{ key: 'category', val: 'theme' },
			rt.ArrayItem{
				key: 'description'
				val: 'Displays the name of this site. Update the block, and the changes apply everywhere it’s used. This will also appear in the browser title bar and in search results.'
			},
			rt.ArrayItem{ key: 'textdomain', val: 'default' },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'level', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'number' },
					rt.ArrayItem{ key: 'default', val: 1 },
				]) },
				rt.ArrayItem{ key: 'levelOptions', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'array' },
					rt.ArrayItem{ key: 'default', val: rt.create_array([
						rt.ArrayItem{ key: none, val: 0 },
						rt.ArrayItem{ key: none, val: 1 },
						rt.ArrayItem{ key: none, val: 2 },
						rt.ArrayItem{ key: none, val: 3 },
						rt.ArrayItem{ key: none, val: 4 },
						rt.ArrayItem{ key: none, val: 5 },
						rt.ArrayItem{ key: none, val: 6 },
					]) },
				]) },
				rt.ArrayItem{ key: 'textAlign', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
				rt.ArrayItem{ key: 'isLink', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: true },
					rt.ArrayItem{ key: 'role', val: 'content' },
				]) },
				rt.ArrayItem{ key: 'linkTarget', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: '_self' },
					rt.ArrayItem{ key: 'role', val: 'content' },
				]) },
			]) },
			rt.ArrayItem{ key: 'example', val: rt.create_array([
				rt.ArrayItem{ key: 'viewportWidth', val: 500 },
			]) },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'anchor', val: true },
				rt.ArrayItem{ key: 'align', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'wide' },
					rt.ArrayItem{ key: none, val: 'full' },
				]) },
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'color', val: rt.create_array([
					rt.ArrayItem{ key: 'gradients', val: true },
					rt.ArrayItem{ key: 'link', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'background', val: true },
						rt.ArrayItem{ key: 'text', val: true },
						rt.ArrayItem{ key: 'link', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'spacing', val: rt.create_array([
					rt.ArrayItem{ key: 'padding', val: true },
					rt.ArrayItem{ key: 'margin', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'margin', val: false },
						rt.ArrayItem{ key: 'padding', val: false },
					]) },
				]) },
				rt.ArrayItem{ key: 'typography', val: rt.create_array([
					rt.ArrayItem{ key: 'fontSize', val: true },
					rt.ArrayItem{ key: 'lineHeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontFamily', val: true },
					rt.ArrayItem{ key: '__experimentalTextTransform', val: true },
					rt.ArrayItem{ key: '__experimentalTextDecoration', val: true },
					rt.ArrayItem{ key: '__experimentalFontStyle', val: true },
					rt.ArrayItem{ key: '__experimentalFontWeight', val: true },
					rt.ArrayItem{ key: '__experimentalLetterSpacing', val: true },
					rt.ArrayItem{ key: '__experimentalWritingMode', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'fontSize', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'interactivity', val: rt.create_array([
					rt.ArrayItem{ key: 'clientNavigation', val: true },
				]) },
				rt.ArrayItem{ key: '__experimentalBorder', val: rt.create_array([
					rt.ArrayItem{ key: 'radius', val: true },
					rt.ArrayItem{ key: 'color', val: true },
					rt.ArrayItem{ key: 'width', val: true },
					rt.ArrayItem{ key: 'style', val: true },
				]) },
			]) },
			rt.ArrayItem{ key: 'editorStyle', val: 'wp-block-site-title-editor' },
			rt.ArrayItem{ key: 'style', val: 'wp-block-site-title' },
		]) },
		rt.ArrayItem{ key: 'social-link', val: rt.create_array([
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: 'name', val: 'core/social-link' },
			rt.ArrayItem{ key: 'title', val: 'Social Icon' },
			rt.ArrayItem{ key: 'category', val: 'widgets' },
			rt.ArrayItem{ key: 'parent', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'core/social-links' },
			]) },
			rt.ArrayItem{
				key: 'description'
				val: 'Display an icon linking to a social profile or site.'
			},
			rt.ArrayItem{ key: 'textdomain', val: 'default' },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'url', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'role', val: 'content' },
				]) },
				rt.ArrayItem{ key: 'service', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
				rt.ArrayItem{ key: 'label', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'role', val: 'content' },
				]) },
				rt.ArrayItem{ key: 'rel', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
			]) },
			rt.ArrayItem{ key: 'usesContext', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'openInNewTab' },
				rt.ArrayItem{ key: none, val: 'showLabels' },
				rt.ArrayItem{ key: none, val: 'iconColor' },
				rt.ArrayItem{ key: none, val: 'iconColorValue' },
				rt.ArrayItem{ key: none, val: 'iconBackgroundColor' },
				rt.ArrayItem{ key: none, val: 'iconBackgroundColorValue' },
			]) },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'anchor', val: true },
				rt.ArrayItem{ key: 'reusable', val: false },
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'interactivity', val: rt.create_array([
					rt.ArrayItem{ key: 'clientNavigation', val: true },
				]) },
			]) },
			rt.ArrayItem{ key: 'editorStyle', val: 'wp-block-social-link-editor' },
		]) },
		rt.ArrayItem{ key: 'social-links', val: rt.create_array([
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: 'name', val: 'core/social-links' },
			rt.ArrayItem{ key: 'title', val: 'Social Icons' },
			rt.ArrayItem{ key: 'category', val: 'widgets' },
			rt.ArrayItem{ key: 'allowedBlocks', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'core/social-link' },
			]) },
			rt.ArrayItem{
				key: 'description'
				val: 'Display icons linking to your social profiles or sites.'
			},
			rt.ArrayItem{ key: 'keywords', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'links' },
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'default' },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'iconColor', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
				rt.ArrayItem{ key: 'customIconColor', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
				rt.ArrayItem{ key: 'iconColorValue', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
				rt.ArrayItem{ key: 'iconBackgroundColor', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
				rt.ArrayItem{ key: 'customIconBackgroundColor', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
				rt.ArrayItem{ key: 'iconBackgroundColorValue', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
				rt.ArrayItem{ key: 'openInNewTab', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: false },
				]) },
				rt.ArrayItem{ key: 'showLabels', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: false },
				]) },
				rt.ArrayItem{ key: 'size', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
			]) },
			rt.ArrayItem{ key: 'providesContext', val: rt.create_array([
				rt.ArrayItem{ key: 'openInNewTab', val: 'openInNewTab' },
				rt.ArrayItem{ key: 'showLabels', val: 'showLabels' },
				rt.ArrayItem{ key: 'iconColor', val: 'iconColor' },
				rt.ArrayItem{ key: 'iconColorValue', val: 'iconColorValue' },
				rt.ArrayItem{ key: 'iconBackgroundColor', val: 'iconBackgroundColor' },
				rt.ArrayItem{ key: 'iconBackgroundColorValue', val: 'iconBackgroundColorValue' },
			]) },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'align', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'left' },
					rt.ArrayItem{ key: none, val: 'center' },
					rt.ArrayItem{ key: none, val: 'right' },
				]) },
				rt.ArrayItem{ key: 'anchor', val: true },
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: '__experimentalExposeControlsToChildren', val: true },
				rt.ArrayItem{ key: 'layout', val: rt.create_array([
					rt.ArrayItem{ key: 'allowSwitching', val: false },
					rt.ArrayItem{ key: 'allowInheriting', val: false },
					rt.ArrayItem{ key: 'allowVerticalAlignment', val: false },
					rt.ArrayItem{ key: 'default', val: rt.create_array([
						rt.ArrayItem{ key: 'type', val: 'flex' },
					]) },
				]) },
				rt.ArrayItem{ key: 'color', val: rt.create_array([
					rt.ArrayItem{ key: 'enableContrastChecker', val: false },
					rt.ArrayItem{ key: 'background', val: true },
					rt.ArrayItem{ key: 'gradients', val: true },
					rt.ArrayItem{ key: 'text', val: false },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'background', val: false },
					]) },
				]) },
				rt.ArrayItem{ key: 'spacing', val: rt.create_array([
					rt.ArrayItem{ key: 'blockGap', val: rt.create_array([
						rt.ArrayItem{ key: none, val: 'horizontal' },
						rt.ArrayItem{ key: none, val: 'vertical' },
					]) },
					rt.ArrayItem{ key: 'margin', val: true },
					rt.ArrayItem{ key: 'padding', val: true },
					rt.ArrayItem{ key: 'units', val: rt.create_array([
						rt.ArrayItem{ key: none, val: 'px' },
						rt.ArrayItem{ key: none, val: 'em' },
						rt.ArrayItem{ key: none, val: 'rem' },
						rt.ArrayItem{ key: none, val: 'vh' },
						rt.ArrayItem{ key: none, val: 'vw' },
					]) },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'blockGap', val: true },
						rt.ArrayItem{ key: 'margin', val: true },
						rt.ArrayItem{ key: 'padding', val: false },
					]) },
				]) },
				rt.ArrayItem{ key: 'interactivity', val: rt.create_array([
					rt.ArrayItem{ key: 'clientNavigation', val: true },
				]) },
				rt.ArrayItem{ key: '__experimentalBorder', val: rt.create_array([
					rt.ArrayItem{ key: 'radius', val: true },
					rt.ArrayItem{ key: 'color', val: true },
					rt.ArrayItem{ key: 'width', val: true },
					rt.ArrayItem{ key: 'style', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'radius', val: true },
						rt.ArrayItem{ key: 'color', val: true },
						rt.ArrayItem{ key: 'width', val: true },
						rt.ArrayItem{ key: 'style', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'contentRole', val: true },
				rt.ArrayItem{ key: 'listView', val: true },
			]) },
			rt.ArrayItem{ key: 'styles', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.create_array([
					rt.ArrayItem{ key: 'name', val: 'default' },
					rt.ArrayItem{ key: 'label', val: 'Default' },
					rt.ArrayItem{ key: 'isDefault', val: true },
				]) },
				rt.ArrayItem{ key: none, val: rt.create_array([
					rt.ArrayItem{ key: 'name', val: 'logos-only' },
					rt.ArrayItem{ key: 'label', val: 'Logos Only' },
				]) },
				rt.ArrayItem{ key: none, val: rt.create_array([
					rt.ArrayItem{ key: 'name', val: 'pill-shape' },
					rt.ArrayItem{ key: 'label', val: 'Pill Shape' },
				]) },
			]) },
			rt.ArrayItem{ key: 'editorStyle', val: 'wp-block-social-links-editor' },
			rt.ArrayItem{ key: 'style', val: 'wp-block-social-links' },
		]) },
		rt.ArrayItem{ key: 'spacer', val: rt.create_array([
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: 'name', val: 'core/spacer' },
			rt.ArrayItem{ key: 'title', val: 'Spacer' },
			rt.ArrayItem{ key: 'category', val: 'design' },
			rt.ArrayItem{
				key: 'description'
				val: 'Add white space between blocks and customize its height.'
			},
			rt.ArrayItem{ key: 'textdomain', val: 'default' },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'height', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: '100px' },
				]) },
				rt.ArrayItem{ key: 'width', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
			]) },
			rt.ArrayItem{ key: 'usesContext', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'orientation' },
			]) },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'anchor', val: true },
				rt.ArrayItem{ key: 'spacing', val: rt.create_array([
					rt.ArrayItem{ key: 'margin', val: rt.create_array([
						rt.ArrayItem{ key: none, val: 'top' },
						rt.ArrayItem{ key: none, val: 'bottom' },
					]) },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'margin', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'interactivity', val: rt.create_array([
					rt.ArrayItem{ key: 'clientNavigation', val: true },
				]) },
			]) },
			rt.ArrayItem{ key: 'editorStyle', val: 'wp-block-spacer-editor' },
			rt.ArrayItem{ key: 'style', val: 'wp-block-spacer' },
		]) },
		rt.ArrayItem{ key: 'table', val: rt.create_array([
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: 'name', val: 'core/table' },
			rt.ArrayItem{ key: 'title', val: 'Table' },
			rt.ArrayItem{ key: 'category', val: 'text' },
			rt.ArrayItem{
				key: 'description'
				val: 'Create structured content in rows and columns to display information.'
			},
			rt.ArrayItem{ key: 'textdomain', val: 'default' },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'hasFixedLayout', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: true },
				]) },
				rt.ArrayItem{ key: 'caption', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'rich-text' },
					rt.ArrayItem{ key: 'source', val: 'rich-text' },
					rt.ArrayItem{ key: 'selector', val: 'figcaption' },
					rt.ArrayItem{ key: 'role', val: 'content' },
				]) },
				rt.ArrayItem{ key: 'head', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'array' },
					rt.ArrayItem{ key: 'default', val: rt.new_array() },
					rt.ArrayItem{ key: 'source', val: 'query' },
					rt.ArrayItem{ key: 'selector', val: 'thead tr' },
					rt.ArrayItem{ key: 'query', val: rt.create_array([
						rt.ArrayItem{ key: 'cells', val: rt.create_array([
							rt.ArrayItem{ key: 'type', val: 'array' },
							rt.ArrayItem{ key: 'default', val: rt.new_array() },
							rt.ArrayItem{ key: 'source', val: 'query' },
							rt.ArrayItem{ key: 'selector', val: 'td,th' },
							rt.ArrayItem{ key: 'query', val: rt.create_array([
								rt.ArrayItem{ key: 'content', val: rt.create_array([
									rt.ArrayItem{ key: 'type', val: 'rich-text' },
									rt.ArrayItem{ key: 'source', val: 'rich-text' },
									rt.ArrayItem{ key: 'role', val: 'content' },
								]) },
								rt.ArrayItem{ key: 'tag', val: rt.create_array([
									rt.ArrayItem{ key: 'type', val: 'string' },
									rt.ArrayItem{ key: 'default', val: 'td' },
									rt.ArrayItem{ key: 'source', val: 'tag' },
								]) },
								rt.ArrayItem{ key: 'scope', val: rt.create_array([
									rt.ArrayItem{ key: 'type', val: 'string' },
									rt.ArrayItem{ key: 'source', val: 'attribute' },
									rt.ArrayItem{ key: 'attribute', val: 'scope' },
								]) },
								rt.ArrayItem{ key: 'align', val: rt.create_array([
									rt.ArrayItem{ key: 'type', val: 'string' },
									rt.ArrayItem{ key: 'source', val: 'attribute' },
									rt.ArrayItem{ key: 'attribute', val: 'data-align' },
								]) },
								rt.ArrayItem{ key: 'colspan', val: rt.create_array([
									rt.ArrayItem{ key: 'type', val: 'string' },
									rt.ArrayItem{ key: 'source', val: 'attribute' },
									rt.ArrayItem{ key: 'attribute', val: 'colspan' },
								]) },
								rt.ArrayItem{ key: 'rowspan', val: rt.create_array([
									rt.ArrayItem{ key: 'type', val: 'string' },
									rt.ArrayItem{ key: 'source', val: 'attribute' },
									rt.ArrayItem{ key: 'attribute', val: 'rowspan' },
								]) },
							]) },
						]) },
					]) },
				]) },
				rt.ArrayItem{ key: 'body', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'array' },
					rt.ArrayItem{ key: 'default', val: rt.new_array() },
					rt.ArrayItem{ key: 'source', val: 'query' },
					rt.ArrayItem{ key: 'selector', val: 'tbody tr' },
					rt.ArrayItem{ key: 'query', val: rt.create_array([
						rt.ArrayItem{ key: 'cells', val: rt.create_array([
							rt.ArrayItem{ key: 'type', val: 'array' },
							rt.ArrayItem{ key: 'default', val: rt.new_array() },
							rt.ArrayItem{ key: 'source', val: 'query' },
							rt.ArrayItem{ key: 'selector', val: 'td,th' },
							rt.ArrayItem{ key: 'query', val: rt.create_array([
								rt.ArrayItem{ key: 'content', val: rt.create_array([
									rt.ArrayItem{ key: 'type', val: 'rich-text' },
									rt.ArrayItem{ key: 'source', val: 'rich-text' },
									rt.ArrayItem{ key: 'role', val: 'content' },
								]) },
								rt.ArrayItem{ key: 'tag', val: rt.create_array([
									rt.ArrayItem{ key: 'type', val: 'string' },
									rt.ArrayItem{ key: 'default', val: 'td' },
									rt.ArrayItem{ key: 'source', val: 'tag' },
								]) },
								rt.ArrayItem{ key: 'scope', val: rt.create_array([
									rt.ArrayItem{ key: 'type', val: 'string' },
									rt.ArrayItem{ key: 'source', val: 'attribute' },
									rt.ArrayItem{ key: 'attribute', val: 'scope' },
								]) },
								rt.ArrayItem{ key: 'align', val: rt.create_array([
									rt.ArrayItem{ key: 'type', val: 'string' },
									rt.ArrayItem{ key: 'source', val: 'attribute' },
									rt.ArrayItem{ key: 'attribute', val: 'data-align' },
								]) },
								rt.ArrayItem{ key: 'colspan', val: rt.create_array([
									rt.ArrayItem{ key: 'type', val: 'string' },
									rt.ArrayItem{ key: 'source', val: 'attribute' },
									rt.ArrayItem{ key: 'attribute', val: 'colspan' },
								]) },
								rt.ArrayItem{ key: 'rowspan', val: rt.create_array([
									rt.ArrayItem{ key: 'type', val: 'string' },
									rt.ArrayItem{ key: 'source', val: 'attribute' },
									rt.ArrayItem{ key: 'attribute', val: 'rowspan' },
								]) },
							]) },
						]) },
					]) },
				]) },
				rt.ArrayItem{ key: 'foot', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'array' },
					rt.ArrayItem{ key: 'default', val: rt.new_array() },
					rt.ArrayItem{ key: 'source', val: 'query' },
					rt.ArrayItem{ key: 'selector', val: 'tfoot tr' },
					rt.ArrayItem{ key: 'query', val: rt.create_array([
						rt.ArrayItem{ key: 'cells', val: rt.create_array([
							rt.ArrayItem{ key: 'type', val: 'array' },
							rt.ArrayItem{ key: 'default', val: rt.new_array() },
							rt.ArrayItem{ key: 'source', val: 'query' },
							rt.ArrayItem{ key: 'selector', val: 'td,th' },
							rt.ArrayItem{ key: 'query', val: rt.create_array([
								rt.ArrayItem{ key: 'content', val: rt.create_array([
									rt.ArrayItem{ key: 'type', val: 'rich-text' },
									rt.ArrayItem{ key: 'source', val: 'rich-text' },
									rt.ArrayItem{ key: 'role', val: 'content' },
								]) },
								rt.ArrayItem{ key: 'tag', val: rt.create_array([
									rt.ArrayItem{ key: 'type', val: 'string' },
									rt.ArrayItem{ key: 'default', val: 'td' },
									rt.ArrayItem{ key: 'source', val: 'tag' },
								]) },
								rt.ArrayItem{ key: 'scope', val: rt.create_array([
									rt.ArrayItem{ key: 'type', val: 'string' },
									rt.ArrayItem{ key: 'source', val: 'attribute' },
									rt.ArrayItem{ key: 'attribute', val: 'scope' },
								]) },
								rt.ArrayItem{ key: 'align', val: rt.create_array([
									rt.ArrayItem{ key: 'type', val: 'string' },
									rt.ArrayItem{ key: 'source', val: 'attribute' },
									rt.ArrayItem{ key: 'attribute', val: 'data-align' },
								]) },
								rt.ArrayItem{ key: 'colspan', val: rt.create_array([
									rt.ArrayItem{ key: 'type', val: 'string' },
									rt.ArrayItem{ key: 'source', val: 'attribute' },
									rt.ArrayItem{ key: 'attribute', val: 'colspan' },
								]) },
								rt.ArrayItem{ key: 'rowspan', val: rt.create_array([
									rt.ArrayItem{ key: 'type', val: 'string' },
									rt.ArrayItem{ key: 'source', val: 'attribute' },
									rt.ArrayItem{ key: 'attribute', val: 'rowspan' },
								]) },
							]) },
						]) },
					]) },
				]) },
			]) },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'anchor', val: true },
				rt.ArrayItem{ key: 'align', val: true },
				rt.ArrayItem{ key: 'color', val: rt.create_array([
					rt.ArrayItem{ key: '__experimentalSkipSerialization', val: true },
					rt.ArrayItem{ key: 'gradients', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'background', val: true },
						rt.ArrayItem{ key: 'text', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'spacing', val: rt.create_array([
					rt.ArrayItem{ key: 'margin', val: true },
					rt.ArrayItem{ key: 'padding', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'margin', val: false },
						rt.ArrayItem{ key: 'padding', val: false },
					]) },
				]) },
				rt.ArrayItem{ key: 'typography', val: rt.create_array([
					rt.ArrayItem{ key: 'fontSize', val: true },
					rt.ArrayItem{ key: 'lineHeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontFamily', val: true },
					rt.ArrayItem{ key: '__experimentalFontStyle', val: true },
					rt.ArrayItem{ key: '__experimentalFontWeight', val: true },
					rt.ArrayItem{ key: '__experimentalLetterSpacing', val: true },
					rt.ArrayItem{ key: '__experimentalTextTransform', val: true },
					rt.ArrayItem{ key: '__experimentalTextDecoration', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'fontSize', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: '__experimentalBorder', val: rt.create_array([
					rt.ArrayItem{ key: '__experimentalSkipSerialization', val: true },
					rt.ArrayItem{ key: 'color', val: true },
					rt.ArrayItem{ key: 'style', val: true },
					rt.ArrayItem{ key: 'width', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'color', val: true },
						rt.ArrayItem{ key: 'style', val: true },
						rt.ArrayItem{ key: 'width', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'interactivity', val: rt.create_array([
					rt.ArrayItem{ key: 'clientNavigation', val: true },
				]) },
			]) },
			rt.ArrayItem{ key: 'selectors', val: rt.create_array([
				rt.ArrayItem{ key: 'root', val: '.wp-block-table > table' },
				rt.ArrayItem{ key: 'spacing', val: '.wp-block-table' },
			]) },
			rt.ArrayItem{ key: 'styles', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.create_array([
					rt.ArrayItem{ key: 'name', val: 'regular' },
					rt.ArrayItem{ key: 'label', val: 'Default' },
					rt.ArrayItem{ key: 'isDefault', val: true },
				]) },
				rt.ArrayItem{ key: none, val: rt.create_array([
					rt.ArrayItem{ key: 'name', val: 'stripes' },
					rt.ArrayItem{ key: 'label', val: 'Stripes' },
				]) },
			]) },
			rt.ArrayItem{ key: 'editorStyle', val: 'wp-block-table-editor' },
			rt.ArrayItem{ key: 'style', val: 'wp-block-table' },
		]) },
		rt.ArrayItem{ key: 'tag-cloud', val: rt.create_array([
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: 'name', val: 'core/tag-cloud' },
			rt.ArrayItem{ key: 'title', val: 'Tag Cloud' },
			rt.ArrayItem{ key: 'category', val: 'widgets' },
			rt.ArrayItem{
				key: 'description'
				val: 'A cloud of popular keywords, each sized by how often it appears.'
			},
			rt.ArrayItem{ key: 'textdomain', val: 'default' },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'numberOfTags', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'number' },
					rt.ArrayItem{ key: 'default', val: 45 },
					rt.ArrayItem{ key: 'minimum', val: 1 },
					rt.ArrayItem{ key: 'maximum', val: 100 },
				]) },
				rt.ArrayItem{ key: 'taxonomy', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: 'post_tag' },
				]) },
				rt.ArrayItem{ key: 'showTagCounts', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: false },
				]) },
				rt.ArrayItem{ key: 'smallestFontSize', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: '8pt' },
				]) },
				rt.ArrayItem{ key: 'largestFontSize', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: '22pt' },
				]) },
			]) },
			rt.ArrayItem{ key: 'styles', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.create_array([
					rt.ArrayItem{ key: 'name', val: 'default' },
					rt.ArrayItem{ key: 'label', val: 'Default' },
					rt.ArrayItem{ key: 'isDefault', val: true },
				]) },
				rt.ArrayItem{ key: none, val: rt.create_array([
					rt.ArrayItem{ key: 'name', val: 'outline' },
					rt.ArrayItem{ key: 'label', val: 'Outline' },
				]) },
			]) },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'anchor', val: true },
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'align', val: true },
				rt.ArrayItem{ key: 'spacing', val: rt.create_array([
					rt.ArrayItem{ key: 'margin', val: true },
					rt.ArrayItem{ key: 'padding', val: true },
				]) },
				rt.ArrayItem{ key: 'typography', val: rt.create_array([
					rt.ArrayItem{ key: 'lineHeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontFamily', val: true },
					rt.ArrayItem{ key: '__experimentalFontWeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontStyle', val: true },
					rt.ArrayItem{ key: '__experimentalTextTransform', val: true },
					rt.ArrayItem{ key: '__experimentalLetterSpacing', val: true },
				]) },
				rt.ArrayItem{ key: 'interactivity', val: rt.create_array([
					rt.ArrayItem{ key: 'clientNavigation', val: true },
				]) },
				rt.ArrayItem{ key: '__experimentalBorder', val: rt.create_array([
					rt.ArrayItem{ key: 'radius', val: true },
					rt.ArrayItem{ key: 'color', val: true },
					rt.ArrayItem{ key: 'width', val: true },
					rt.ArrayItem{ key: 'style', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'radius', val: true },
						rt.ArrayItem{ key: 'color', val: true },
						rt.ArrayItem{ key: 'width', val: true },
						rt.ArrayItem{ key: 'style', val: true },
					]) },
				]) },
			]) },
		]) },
		rt.ArrayItem{ key: 'template-part', val: rt.create_array([
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: 'name', val: 'core/template-part' },
			rt.ArrayItem{ key: 'title', val: 'Template Part' },
			rt.ArrayItem{ key: 'category', val: 'theme' },
			rt.ArrayItem{
				key: 'description'
				val: 'Edit the different global regions of your site, like the header, footer, sidebar, or create your own.'
			},
			rt.ArrayItem{ key: 'textdomain', val: 'default' },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'slug', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
				rt.ArrayItem{ key: 'theme', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
				rt.ArrayItem{ key: 'tagName', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
				rt.ArrayItem{ key: 'area', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
			]) },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'align', val: true },
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'reusable', val: false },
				rt.ArrayItem{ key: 'renaming', val: false },
				rt.ArrayItem{ key: 'interactivity', val: rt.create_array([
					rt.ArrayItem{ key: 'clientNavigation', val: true },
				]) },
			]) },
			rt.ArrayItem{ key: 'editorStyle', val: 'wp-block-template-part-editor' },
		]) },
		rt.ArrayItem{ key: 'term-count', val: rt.create_array([
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: 'name', val: 'core/term-count' },
			rt.ArrayItem{ key: 'title', val: 'Term Count' },
			rt.ArrayItem{ key: 'category', val: 'theme' },
			rt.ArrayItem{ key: 'description', val: 'Displays the post count of a taxonomy term.' },
			rt.ArrayItem{ key: 'textdomain', val: 'default' },
			rt.ArrayItem{ key: 'usesContext', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'termId' },
				rt.ArrayItem{ key: none, val: 'taxonomy' },
			]) },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'bracketType', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'enum', val: rt.create_array([
						rt.ArrayItem{ key: none, val: 'none' },
						rt.ArrayItem{ key: none, val: 'round' },
						rt.ArrayItem{ key: none, val: 'square' },
						rt.ArrayItem{ key: none, val: 'curly' },
						rt.ArrayItem{ key: none, val: 'angle' },
					]) },
					rt.ArrayItem{ key: 'default', val: 'round' },
				]) },
			]) },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'anchor', val: true },
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'color', val: rt.create_array([
					rt.ArrayItem{ key: 'gradients', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'background', val: true },
						rt.ArrayItem{ key: 'text', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'spacing', val: rt.create_array([
					rt.ArrayItem{ key: 'padding', val: true },
				]) },
				rt.ArrayItem{ key: 'typography', val: rt.create_array([
					rt.ArrayItem{ key: 'fontSize', val: true },
					rt.ArrayItem{ key: 'lineHeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontFamily', val: true },
					rt.ArrayItem{ key: '__experimentalFontWeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontStyle', val: true },
					rt.ArrayItem{ key: '__experimentalTextTransform', val: true },
					rt.ArrayItem{ key: '__experimentalTextDecoration', val: true },
					rt.ArrayItem{ key: '__experimentalLetterSpacing', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'fontSize', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'interactivity', val: rt.create_array([
					rt.ArrayItem{ key: 'clientNavigation', val: true },
				]) },
				rt.ArrayItem{ key: '__experimentalBorder', val: rt.create_array([
					rt.ArrayItem{ key: 'radius', val: true },
					rt.ArrayItem{ key: 'color', val: true },
					rt.ArrayItem{ key: 'width', val: true },
					rt.ArrayItem{ key: 'style', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'color', val: true },
						rt.ArrayItem{ key: 'width', val: true },
						rt.ArrayItem{ key: 'style', val: true },
					]) },
				]) },
			]) },
			rt.ArrayItem{ key: 'style', val: 'wp-block-term-count' },
		]) },
		rt.ArrayItem{ key: 'term-description', val: rt.create_array([
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: 'name', val: 'core/term-description' },
			rt.ArrayItem{ key: 'title', val: 'Term Description' },
			rt.ArrayItem{ key: 'category', val: 'theme' },
			rt.ArrayItem{
				key: 'description'
				val: 'Display the description of categories, tags and custom taxonomies when viewing an archive.'
			},
			rt.ArrayItem{ key: 'textdomain', val: 'default' },
			rt.ArrayItem{ key: 'usesContext', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'termId' },
				rt.ArrayItem{ key: none, val: 'taxonomy' },
			]) },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'anchor', val: true },
				rt.ArrayItem{ key: 'align', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'wide' },
					rt.ArrayItem{ key: none, val: 'full' },
				]) },
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'color', val: rt.create_array([
					rt.ArrayItem{ key: 'link', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'background', val: true },
						rt.ArrayItem{ key: 'text', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'spacing', val: rt.create_array([
					rt.ArrayItem{ key: 'padding', val: true },
					rt.ArrayItem{ key: 'margin', val: true },
				]) },
				rt.ArrayItem{ key: 'typography', val: rt.create_array([
					rt.ArrayItem{ key: 'fontSize', val: true },
					rt.ArrayItem{ key: 'lineHeight', val: true },
					rt.ArrayItem{ key: 'textAlign', val: true },
					rt.ArrayItem{ key: '__experimentalFontFamily', val: true },
					rt.ArrayItem{ key: '__experimentalFontWeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontStyle', val: true },
					rt.ArrayItem{ key: '__experimentalTextTransform', val: true },
					rt.ArrayItem{ key: '__experimentalTextDecoration', val: true },
					rt.ArrayItem{ key: '__experimentalLetterSpacing', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'fontSize', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'interactivity', val: rt.create_array([
					rt.ArrayItem{ key: 'clientNavigation', val: true },
				]) },
				rt.ArrayItem{ key: '__experimentalBorder', val: rt.create_array([
					rt.ArrayItem{ key: 'radius', val: true },
					rt.ArrayItem{ key: 'color', val: true },
					rt.ArrayItem{ key: 'width', val: true },
					rt.ArrayItem{ key: 'style', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'radius', val: true },
						rt.ArrayItem{ key: 'color', val: true },
						rt.ArrayItem{ key: 'width', val: true },
						rt.ArrayItem{ key: 'style', val: true },
					]) },
				]) },
			]) },
		]) },
		rt.ArrayItem{ key: 'term-name', val: rt.create_array([
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: 'name', val: 'core/term-name' },
			rt.ArrayItem{ key: 'title', val: 'Term Name' },
			rt.ArrayItem{ key: 'category', val: 'theme' },
			rt.ArrayItem{ key: 'description', val: 'Displays the name of a taxonomy term.' },
			rt.ArrayItem{ key: 'keywords', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'term title' },
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'default' },
			rt.ArrayItem{ key: 'usesContext', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'termId' },
				rt.ArrayItem{ key: none, val: 'taxonomy' },
			]) },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'textAlign', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
				rt.ArrayItem{ key: 'level', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'number' },
					rt.ArrayItem{ key: 'default', val: 0 },
				]) },
				rt.ArrayItem{ key: 'isLink', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: false },
				]) },
				rt.ArrayItem{ key: 'levelOptions', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'array' },
				]) },
			]) },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'anchor', val: true },
				rt.ArrayItem{ key: 'align', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'wide' },
					rt.ArrayItem{ key: none, val: 'full' },
				]) },
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'color', val: rt.create_array([
					rt.ArrayItem{ key: 'gradients', val: true },
					rt.ArrayItem{ key: 'link', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'background', val: true },
						rt.ArrayItem{ key: 'text', val: true },
						rt.ArrayItem{ key: 'link', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'spacing', val: rt.create_array([
					rt.ArrayItem{ key: 'padding', val: true },
				]) },
				rt.ArrayItem{ key: 'typography', val: rt.create_array([
					rt.ArrayItem{ key: 'fontSize', val: true },
					rt.ArrayItem{ key: 'lineHeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontFamily', val: true },
					rt.ArrayItem{ key: '__experimentalFontWeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontStyle', val: true },
					rt.ArrayItem{ key: '__experimentalTextTransform', val: true },
					rt.ArrayItem{ key: '__experimentalTextDecoration', val: true },
					rt.ArrayItem{ key: '__experimentalLetterSpacing', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'fontSize', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'interactivity', val: rt.create_array([
					rt.ArrayItem{ key: 'clientNavigation', val: true },
				]) },
				rt.ArrayItem{ key: '__experimentalBorder', val: rt.create_array([
					rt.ArrayItem{ key: 'radius', val: true },
					rt.ArrayItem{ key: 'color', val: true },
					rt.ArrayItem{ key: 'width', val: true },
					rt.ArrayItem{ key: 'style', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'color', val: true },
						rt.ArrayItem{ key: 'width', val: true },
						rt.ArrayItem{ key: 'style', val: true },
					]) },
				]) },
			]) },
			rt.ArrayItem{ key: 'style', val: 'wp-block-term-name' },
		]) },
		rt.ArrayItem{ key: 'term-template', val: rt.create_array([
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: 'name', val: 'core/term-template' },
			rt.ArrayItem{ key: 'title', val: 'Term Template' },
			rt.ArrayItem{ key: 'category', val: 'theme' },
			rt.ArrayItem{ key: 'ancestor', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'core/terms-query' },
			]) },
			rt.ArrayItem{
				key: 'description'
				val: 'Contains the block elements used to render a taxonomy term, like the name, description, and more.'
			},
			rt.ArrayItem{ key: 'textdomain', val: 'default' },
			rt.ArrayItem{ key: 'usesContext', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'termQuery' },
			]) },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'anchor', val: true },
				rt.ArrayItem{ key: 'reusable', val: false },
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'align', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'wide' },
					rt.ArrayItem{ key: none, val: 'full' },
				]) },
				rt.ArrayItem{ key: 'layout', val: true },
				rt.ArrayItem{ key: 'color', val: rt.create_array([
					rt.ArrayItem{ key: 'gradients', val: true },
					rt.ArrayItem{ key: 'link', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'background', val: true },
						rt.ArrayItem{ key: 'text', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'typography', val: rt.create_array([
					rt.ArrayItem{ key: 'fontSize', val: true },
					rt.ArrayItem{ key: 'lineHeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontFamily', val: true },
					rt.ArrayItem{ key: '__experimentalFontWeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontStyle', val: true },
					rt.ArrayItem{ key: '__experimentalTextTransform', val: true },
					rt.ArrayItem{ key: '__experimentalTextDecoration', val: true },
					rt.ArrayItem{ key: '__experimentalLetterSpacing', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'fontSize', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'spacing', val: rt.create_array([
					rt.ArrayItem{ key: 'margin', val: true },
					rt.ArrayItem{ key: 'padding', val: true },
					rt.ArrayItem{ key: 'blockGap', val: rt.create_array([
						rt.ArrayItem{ key: '__experimentalDefault', val: '1.25em' },
					]) },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'blockGap', val: true },
						rt.ArrayItem{ key: 'padding', val: false },
						rt.ArrayItem{ key: 'margin', val: false },
					]) },
				]) },
				rt.ArrayItem{ key: 'interactivity', val: rt.create_array([
					rt.ArrayItem{ key: 'clientNavigation', val: true },
				]) },
				rt.ArrayItem{ key: '__experimentalBorder', val: rt.create_array([
					rt.ArrayItem{ key: 'radius', val: true },
					rt.ArrayItem{ key: 'color', val: true },
					rt.ArrayItem{ key: 'width', val: true },
					rt.ArrayItem{ key: 'style', val: true },
				]) },
			]) },
			rt.ArrayItem{ key: 'style', val: 'wp-block-term-template' },
			rt.ArrayItem{ key: 'editorStyle', val: 'wp-block-term-template-editor' },
		]) },
		rt.ArrayItem{ key: 'terms-query', val: rt.create_array([
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: 'name', val: 'core/terms-query' },
			rt.ArrayItem{ key: 'title', val: 'Terms Query' },
			rt.ArrayItem{ key: 'category', val: 'theme' },
			rt.ArrayItem{
				key: 'description'
				val: 'An advanced block that allows displaying taxonomy terms based on different query parameters and visual configurations.'
			},
			rt.ArrayItem{ key: 'keywords', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'terms' },
				rt.ArrayItem{ key: none, val: 'taxonomy' },
				rt.ArrayItem{ key: none, val: 'categories' },
				rt.ArrayItem{ key: none, val: 'tags' },
				rt.ArrayItem{ key: none, val: 'list' },
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'default' },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'termQuery', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'object' },
					rt.ArrayItem{ key: 'default', val: rt.create_array([
						rt.ArrayItem{ key: 'perPage', val: 10 },
						rt.ArrayItem{ key: 'taxonomy', val: 'category' },
						rt.ArrayItem{ key: 'order', val: 'asc' },
						rt.ArrayItem{ key: 'orderBy', val: 'name' },
						rt.ArrayItem{ key: 'include', val: rt.new_array() },
						rt.ArrayItem{ key: 'hideEmpty', val: true },
						rt.ArrayItem{ key: 'showNested', val: false },
						rt.ArrayItem{ key: 'inherit', val: false },
					]) },
				]) },
				rt.ArrayItem{ key: 'tagName', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: 'div' },
				]) },
			]) },
			rt.ArrayItem{ key: 'usesContext', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'templateSlug' },
			]) },
			rt.ArrayItem{ key: 'providesContext', val: rt.create_array([
				rt.ArrayItem{ key: 'termQuery', val: 'termQuery' },
			]) },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'anchor', val: true },
				rt.ArrayItem{ key: 'align', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'wide' },
					rt.ArrayItem{ key: none, val: 'full' },
				]) },
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'layout', val: true },
				rt.ArrayItem{ key: 'interactivity', val: true },
			]) },
		]) },
		rt.ArrayItem{ key: 'text-columns', val: rt.create_array([
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: 'name', val: 'core/text-columns' },
			rt.ArrayItem{ key: 'title', val: 'Text Columns (deprecated)' },
			rt.ArrayItem{ key: 'icon', val: 'columns' },
			rt.ArrayItem{ key: 'category', val: 'design' },
			rt.ArrayItem{
				key: 'description'
				val: 'This block is deprecated. Please use the Columns block instead.'
			},
			rt.ArrayItem{ key: 'textdomain', val: 'default' },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'content', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'array' },
					rt.ArrayItem{ key: 'source', val: 'query' },
					rt.ArrayItem{ key: 'selector', val: 'p' },
					rt.ArrayItem{ key: 'query', val: rt.create_array([
						rt.ArrayItem{ key: 'children', val: rt.create_array([
							rt.ArrayItem{ key: 'type', val: 'string' },
							rt.ArrayItem{ key: 'source', val: 'html' },
						]) },
					]) },
					rt.ArrayItem{ key: 'default', val: rt.create_array([
						rt.ArrayItem{ key: none, val: rt.new_array() },
						rt.ArrayItem{ key: none, val: rt.new_array() },
					]) },
				]) },
				rt.ArrayItem{ key: 'columns', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'number' },
					rt.ArrayItem{ key: 'default', val: 2 },
				]) },
				rt.ArrayItem{ key: 'width', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
			]) },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'inserter', val: false },
				rt.ArrayItem{ key: 'interactivity', val: rt.create_array([
					rt.ArrayItem{ key: 'clientNavigation', val: true },
				]) },
			]) },
			rt.ArrayItem{ key: 'editorStyle', val: 'wp-block-text-columns-editor' },
			rt.ArrayItem{ key: 'style', val: 'wp-block-text-columns' },
		]) },
		rt.ArrayItem{ key: 'verse', val: rt.create_array([
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: 'name', val: 'core/verse' },
			rt.ArrayItem{ key: 'title', val: 'Poetry' },
			rt.ArrayItem{ key: 'category', val: 'text' },
			rt.ArrayItem{
				key: 'description'
				val: 'Insert poetry. Use special spacing formats. Or quote song lyrics.'
			},
			rt.ArrayItem{ key: 'keywords', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'poetry' },
				rt.ArrayItem{ key: none, val: 'poem' },
				rt.ArrayItem{ key: none, val: 'verse' },
				rt.ArrayItem{ key: none, val: 'stanza' },
				rt.ArrayItem{ key: none, val: 'song' },
				rt.ArrayItem{ key: none, val: 'lyrics' },
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'default' },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'content', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'rich-text' },
					rt.ArrayItem{ key: 'source', val: 'rich-text' },
					rt.ArrayItem{ key: 'selector', val: 'pre' },
					rt.ArrayItem{ key: '__unstablePreserveWhiteSpace', val: true },
					rt.ArrayItem{ key: 'role', val: 'content' },
				]) },
			]) },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'anchor', val: true },
				rt.ArrayItem{ key: 'background', val: rt.create_array([
					rt.ArrayItem{ key: 'backgroundImage', val: true },
					rt.ArrayItem{ key: 'backgroundSize', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'backgroundImage', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'color', val: rt.create_array([
					rt.ArrayItem{ key: 'gradients', val: true },
					rt.ArrayItem{ key: 'link', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'background', val: true },
						rt.ArrayItem{ key: 'text', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'dimensions', val: rt.create_array([
					rt.ArrayItem{ key: 'minHeight', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'minHeight', val: false },
					]) },
				]) },
				rt.ArrayItem{ key: 'typography', val: rt.create_array([
					rt.ArrayItem{ key: 'fontSize', val: true },
					rt.ArrayItem{ key: '__experimentalFontFamily', val: true },
					rt.ArrayItem{ key: 'lineHeight', val: true },
					rt.ArrayItem{ key: 'textAlign', val: true },
					rt.ArrayItem{ key: '__experimentalFontStyle', val: true },
					rt.ArrayItem{ key: '__experimentalFontWeight', val: true },
					rt.ArrayItem{ key: '__experimentalLetterSpacing', val: true },
					rt.ArrayItem{ key: '__experimentalTextTransform', val: true },
					rt.ArrayItem{ key: '__experimentalTextDecoration', val: true },
					rt.ArrayItem{ key: '__experimentalWritingMode', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'fontSize', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'spacing', val: rt.create_array([
					rt.ArrayItem{ key: 'margin', val: true },
					rt.ArrayItem{ key: 'padding', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'margin', val: false },
						rt.ArrayItem{ key: 'padding', val: false },
					]) },
				]) },
				rt.ArrayItem{ key: '__experimentalBorder', val: rt.create_array([
					rt.ArrayItem{ key: 'radius', val: true },
					rt.ArrayItem{ key: 'width', val: true },
					rt.ArrayItem{ key: 'color', val: true },
					rt.ArrayItem{ key: 'style', val: true },
				]) },
				rt.ArrayItem{ key: 'interactivity', val: rt.create_array([
					rt.ArrayItem{ key: 'clientNavigation', val: true },
				]) },
			]) },
			rt.ArrayItem{ key: 'style', val: 'wp-block-verse' },
			rt.ArrayItem{ key: 'editorStyle', val: 'wp-block-verse-editor' },
		]) },
		rt.ArrayItem{ key: 'video', val: rt.create_array([
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: 'name', val: 'core/video' },
			rt.ArrayItem{ key: 'title', val: 'Video' },
			rt.ArrayItem{ key: 'category', val: 'media' },
			rt.ArrayItem{
				key: 'description'
				val: 'Embed a video from your media library or upload a new one.'
			},
			rt.ArrayItem{ key: 'keywords', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'movie' },
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'default' },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'autoplay', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'source', val: 'attribute' },
					rt.ArrayItem{ key: 'selector', val: 'video' },
					rt.ArrayItem{ key: 'attribute', val: 'autoplay' },
				]) },
				rt.ArrayItem{ key: 'caption', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'rich-text' },
					rt.ArrayItem{ key: 'source', val: 'rich-text' },
					rt.ArrayItem{ key: 'selector', val: 'figcaption' },
					rt.ArrayItem{ key: 'role', val: 'content' },
				]) },
				rt.ArrayItem{ key: 'controls', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'source', val: 'attribute' },
					rt.ArrayItem{ key: 'selector', val: 'video' },
					rt.ArrayItem{ key: 'attribute', val: 'controls' },
					rt.ArrayItem{ key: 'default', val: true },
				]) },
				rt.ArrayItem{ key: 'id', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'number' },
					rt.ArrayItem{ key: 'role', val: 'content' },
				]) },
				rt.ArrayItem{ key: 'loop', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'source', val: 'attribute' },
					rt.ArrayItem{ key: 'selector', val: 'video' },
					rt.ArrayItem{ key: 'attribute', val: 'loop' },
				]) },
				rt.ArrayItem{ key: 'muted', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'source', val: 'attribute' },
					rt.ArrayItem{ key: 'selector', val: 'video' },
					rt.ArrayItem{ key: 'attribute', val: 'muted' },
				]) },
				rt.ArrayItem{ key: 'poster', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'source', val: 'attribute' },
					rt.ArrayItem{ key: 'selector', val: 'video' },
					rt.ArrayItem{ key: 'attribute', val: 'poster' },
				]) },
				rt.ArrayItem{ key: 'preload', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'source', val: 'attribute' },
					rt.ArrayItem{ key: 'selector', val: 'video' },
					rt.ArrayItem{ key: 'attribute', val: 'preload' },
					rt.ArrayItem{ key: 'default', val: 'metadata' },
				]) },
				rt.ArrayItem{ key: 'blob', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'role', val: 'local' },
				]) },
				rt.ArrayItem{ key: 'src', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'source', val: 'attribute' },
					rt.ArrayItem{ key: 'selector', val: 'video' },
					rt.ArrayItem{ key: 'attribute', val: 'src' },
					rt.ArrayItem{ key: 'role', val: 'content' },
				]) },
				rt.ArrayItem{ key: 'playsInline', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'source', val: 'attribute' },
					rt.ArrayItem{ key: 'selector', val: 'video' },
					rt.ArrayItem{ key: 'attribute', val: 'playsinline' },
				]) },
				rt.ArrayItem{ key: 'tracks', val: rt.create_array([
					rt.ArrayItem{ key: 'role', val: 'content' },
					rt.ArrayItem{ key: 'type', val: 'array' },
					rt.ArrayItem{ key: 'items', val: rt.create_array([
						rt.ArrayItem{ key: 'type', val: 'object' },
					]) },
					rt.ArrayItem{ key: 'default', val: rt.new_array() },
				]) },
			]) },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'anchor', val: true },
				rt.ArrayItem{ key: 'align', val: true },
				rt.ArrayItem{ key: 'spacing', val: rt.create_array([
					rt.ArrayItem{ key: 'margin', val: true },
					rt.ArrayItem{ key: 'padding', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'margin', val: false },
						rt.ArrayItem{ key: 'padding', val: false },
					]) },
				]) },
				rt.ArrayItem{ key: 'interactivity', val: rt.create_array([
					rt.ArrayItem{ key: 'clientNavigation', val: true },
				]) },
			]) },
			rt.ArrayItem{ key: 'editorStyle', val: 'wp-block-video-editor' },
			rt.ArrayItem{ key: 'style', val: 'wp-block-video' },
		]) },
		rt.ArrayItem{ key: 'widget-group', val: rt.create_array([
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: 'name', val: 'core/widget-group' },
			rt.ArrayItem{ key: 'title', val: 'Widget Group' },
			rt.ArrayItem{ key: 'category', val: 'widgets' },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'title', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
			]) },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'inserter', val: true },
				rt.ArrayItem{ key: 'customClassName', val: true },
				rt.ArrayItem{ key: 'reusable', val: false },
			]) },
			rt.ArrayItem{ key: 'editorStyle', val: 'wp-block-widget-group-editor' },
			rt.ArrayItem{ key: 'style', val: 'wp-block-widget-group' },
		]) },
	])
}
