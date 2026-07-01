import rt

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCategories {
	rt.PhpObjectBase
pub mut:
	block_name rt.PhpVal = rt.new_string('product-categories')
	defaults   rt.PhpVal = rt.new_array()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCategories) get_block_type_attributes() rt.PhpVal {
	return rt.call_function('array_merge', [this.Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractDynamicBlock.get_block_type_attributes(),
		rt.create_array([rt.ArrayItem{ key: 'align', val: this.get_schema_align() },
			rt.ArrayItem{ key: 'className', val: this.get_schema_string() },
			rt.ArrayItem{ key: 'hasCount', val: this.get_schema_boolean(rt.new_bool(true)) },
			rt.ArrayItem{ key: 'hasImage', val: this.get_schema_boolean(rt.new_bool(false)) },
			rt.ArrayItem{ key: 'hasEmpty', val: this.get_schema_boolean(rt.new_bool(false)) },
			rt.ArrayItem{ key: 'isDropdown', val: this.get_schema_boolean(rt.new_bool(false)) },
			rt.ArrayItem{ key: 'isHierarchical', val: this.get_schema_boolean(rt.new_bool(true)) },
			rt.ArrayItem{ key: 'showChildrenOnly', val: this.get_schema_boolean(rt.new_bool(false)) },
			rt.ArrayItem{ key: 'textColor', val: this.get_schema_string() },
			rt.ArrayItem{ key: 'fontSize', val: this.get_schema_string() },
			rt.ArrayItem{ key: 'lineHeight', val: this.get_schema_string() },
			rt.ArrayItem{ key: 'style', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'object' },
			]) }])])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCategories) render(var_attributes rt.PhpVal, var_content rt.PhpVal, var_block rt.PhpVal) string {
	mut var_attributes_mutated := var_attributes
	mut var_uid := rt.call_function('uniqid', [rt.new_string('product-categories-')])
	mut var_categories := this.get_categories(var_attributes_mutated.dup())
	if !rt.is_true(var_categories) {
		return ''
	}
	if !(!rt.is_true(var_content)) {
		if rt.is_true(rt.call_function('strstr', [var_content.dup(),
			rt.new_string('data-has-count="false"')]))
		{
			var_attributes_mutated.array_set('hasCount', false)
		}
		if rt.is_true(rt.call_function('strstr', [var_content.dup(),
			rt.new_string('data-is-dropdown="true"')]))
		{
			var_attributes_mutated.array_set('isDropdown', true)
		}
		if rt.is_true(rt.call_function('strstr', [var_content.dup(),
			rt.new_string('data-is-hierarchical="false"')]))
		{
			var_attributes_mutated.array_set('isHierarchical', false)
		}
		if rt.is_true(rt.call_function('strstr', [var_content.dup(),
			rt.new_string('data-has-empty="true"')]))
		{
			var_attributes_mutated.array_set('hasEmpty', true)
		}
	}
	mut var_classes_and_styles := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal {
		mut temp := Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils{}
		return temp.get_classes_and_styles_by_attributes(arg_0, arg_1)
	}(var_attributes_mutated.dup(), rt.create_array([
		rt.ArrayItem{ key: none, val: 'line_height' },
		rt.ArrayItem{ key: none, val: 'text_color' },
		rt.ArrayItem{ key: none, val: 'font_size' },
		rt.ArrayItem{ key: none, val: 'extra_classes' },
	]))
	mut var_classes := rt.new_string(
		(this.get_container_classes(var_attributes_mutated.dup())).str() + ' ' +
		(var_classes_and_styles.array_get('classes')).str())
	mut var_styles := var_classes_and_styles.array_get('styles')
	mut var_output := rt.new_string('<div class="wp-block-woocommerce-product-categories ' +
		(rt.call_function('esc_attr', [var_classes.dup()])).str() + '" style="' +
		(rt.call_function('esc_attr', [var_styles.dup()])).str() + '">')
	// unsupported expression: Expr_AssignOp_Concat
	// unsupported expression: Expr_AssignOp_Concat
	return var_output.str()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCategories) get_container_classes(var_attributes rt.PhpVal) rt.PhpVal {
	mut var_attributes_mutated := var_attributes
	mut var_classes := rt.create_array([
		rt.ArrayItem{ key: none, val: 'wc-block-product-categories' },
	])
	if var_attributes_mutated.array_isset(rt.new_string('align')) {
		var_classes.array_push(rt.concat(rt.new_string('align'),
			var_attributes_mutated.array_get('align')))
	}
	if rt.is_true(var_attributes_mutated.array_get('isDropdown')) {
		var_classes.array_push('is-dropdown')
	} else {
		var_classes.array_push('is-list')
	}
	return rt.call_function('implode', [rt.new_string(' '), var_classes.dup()])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCategories) get_categories(var_attributes rt.PhpVal) rt.PhpVal {
	mut var_attributes_mutated := var_attributes
	mut var_hierarchical := rt.call_function('wc_string_to_bool', [
		var_attributes_mutated.array_get('isHierarchical'),
	])
	mut var_children_only := rt.new_bool(rt.new_bool(
		rt.is_true(rt.call_function('wc_string_to_bool', [var_attributes_mutated.array_get('showChildrenOnly')]))
		&& rt.is_true(rt.call_function('is_product_category', []rt.PhpVal{}))))
	if rt.is_true(var_children_only) {
		mut var_term_id := rt.call_function('get_queried_object_id', []rt.PhpVal{})
		mut var_categories := rt.call_function('get_terms', [
			rt.new_string('product_cat'),
			rt.create_array([
				rt.ArrayItem{
					key: 'hide_empty'
					val: !(rt.is_true(var_attributes_mutated.array_get('hasEmpty')))
				},
				rt.ArrayItem{ key: 'pad_counts', val: true },
				rt.ArrayItem{ key: 'hierarchical', val: true },
				rt.ArrayItem{ key: 'child_of', val: var_term_id },
			]),
		])
	} else {
		var_categories = rt.call_function('get_terms', [rt.new_string('product_cat'),
			rt.create_array([
				rt.ArrayItem{
					key: 'hide_empty'
					val: !(rt.is_true(var_attributes_mutated.array_get('hasEmpty')))
				},
				rt.ArrayItem{ key: 'pad_counts', val: true },
				rt.ArrayItem{ key: 'hierarchical', val: true },
			])])
	}
	if rt.is_true(rt.new_bool(
		rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_categories.dup().is_array())))))
		|| !rt.is_true(var_categories)))
	{
		return rt.new_array()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_attributes_mutated.array_get('hasEmpty'))))) {
		closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_category := if args.len > 0 { args[0].dup() } else { rt.new_null() }
			return
		}
		var_categories = rt.call_function('array_filter', [var_categories.dup(),
			rt.new_closure(closure_1_fn)])
	}
	return if rt.is_true(var_hierarchical) {
		this.build_category_tree(var_categories.dup(), var_children_only.dup())
	} else {
		var_categories
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCategories) build_category_tree(var_categories rt.PhpVal, var_children_only rt.PhpVal) rt.PhpVal {
	mut var_categories_mutated := var_categories
	mut var_children_only_mutated := var_children_only
	mut var_categories_by_parent := rt.new_array()
	{
		mut iter_1 := var_categories_mutated.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_category := item_1.val
			if !(var_categories_by_parent.array_isset('cat-' +
				(rt.get_property(var_category, 'parent')).str())) {
				var_categories_by_parent.array_set('cat-' +
					(rt.get_property(var_category, 'parent')).str(), rt.new_array())
			}
			var_categories_by_parent.array_get_mut('cat-' +
				(rt.get_property(var_category, 'parent')).str()).array_push(var_category.dup())
		}
	}
	mut var_parent_id := if rt.is_true(var_children_only_mutated) {
		rt.call_function('get_queried_object_id', []rt.PhpVal{})
	} else {
		rt.new_int(0)
	}
	mut var_tree := var_categories_by_parent.array_get('cat-' + var_parent_id.str())
	var_categories_by_parent.array_unset('cat-' + var_parent_id.str())
	{
		mut iter_1 := var_tree.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_category := item_1.val
			if !(!rt.is_true(var_categories_by_parent.array_get('cat-' +
				(rt.get_property(var_category, 'term_id')).str()))) {
				rt.set_property(var_category, 'children', this.fill_category_children(var_categories_by_parent.array_get(
					'cat-' + (rt.get_property(var_category, 'term_id')).str()),
					var_categories_by_parent.dup()))
			}
		}
	}
	return var_tree.dup()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCategories) fill_category_children(var_categories rt.PhpVal, var_categories_by_parent rt.PhpVal) rt.PhpVal {
	mut var_categories_mutated := var_categories
	mut var_categories_by_parent_mutated := var_categories_by_parent
	{
		mut iter_1 := var_categories_mutated.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_category := item_1.val
			if !(!rt.is_true(var_categories_by_parent_mutated.array_get('cat-' +
				(rt.get_property(var_category, 'term_id')).str()))) {
				rt.set_property(var_category, 'children', this.fill_category_children(var_categories_by_parent_mutated.array_get(
					'cat-' + (rt.get_property(var_category, 'term_id')).str()),
					var_categories_by_parent_mutated.dup()))
			}
		}
	}
	return var_categories_mutated.dup()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCategories) renderdropdown(var_categories rt.PhpVal, var_attributes rt.PhpVal, var_uid rt.PhpVal) rt.PhpVal {
	mut var_categories_mutated := var_categories
	mut var_attributes_mutated := var_attributes
	mut var_uid_mutated := var_uid
	mut var_aria_label := if !rt.is_true(var_attributes_mutated.array_get('hasCount')) { rt.call_function('__', [
			rt.new_string('List of categories'),
			rt.new_string('woocommerce'),
		]) } else { rt.call_function('__', [
			rt.new_string('List of categories with their product counts'),
			rt.new_string('woocommerce'),
		]) }
	mut var_output := rt.new_string(
		'\n\t\t\t<div class="wc-block-product-categories__dropdown">\n\t\t\t\t<label\n\t\t\t\tclass="screen-reader-text"\n\t\t\t\t\tfor="' +
		(rt.call_function('esc_attr', [var_uid_mutated.dup()])).str() +
		'-select"\n\t\t\t\t>\n\t\t\t\t\t' +
		(rt.call_function('esc_html__', [rt.new_string('Select a category'), rt.new_string('woocommerce')])).str() +
		'\n\t\t\t\t</label>\n\t\t\t\t<select aria-label="' +
		(rt.call_function('esc_attr', [var_aria_label.dup()])).str() + '" id="' +
		(rt.call_function('esc_attr', [var_uid_mutated.dup()])).str() +
		'-select">\n\t\t\t\t\t<option value="false" hidden>\n\t\t\t\t\t\t' +
		(rt.call_function('esc_html__', [rt.new_string('Select a category'), rt.new_string('woocommerce')])).str() +
		'\n\t\t\t\t\t</option>\n\t\t\t\t\t' +
		(this.renderdropdownoptions(var_categories_mutated.dup(), var_attributes_mutated.dup(), var_uid_mutated.dup(), 0)).str() +
		'\n\t\t\t\t</select>\n\t\t\t</div>\n\t\t\t<button\n\t\t\t\ttype="button"\n\t\t\t\tclass="wc-block-product-categories__button"\n\t\t\t\taria-label="' +
		(rt.call_function('esc_html__', [rt.new_string('Go to category'), rt.new_string('woocommerce')])).str() +
		'"\n\t\t\t\tonclick="const url = document.getElementById( \'' +
		(rt.call_function('esc_attr', [var_uid_mutated.dup()])).str() +
		'-select\' ).value; if ( \'false\' !== url ) document.location.href = url;"\n\t\t\t>\n\t\t\t\t<svg\n\t\t\t\t\taria-hidden="true"\n\t\t\t\t\trole="img"\n\t\t\t\t\tfocusable="false"\n\t\t\t\t\tclass="dashicon dashicons-arrow-right-alt2"\n\t\t\t\t\txmlns="http://www.w3.org/2000/svg"\n\t\t\t\t\twidth="20"\n\t\t\t\t\theight="20"\n\t\t\t\t\tviewBox="0 0 20 20"\n\t\t\t\t>\n\t\t\t\t\t<path d="M6 15l5-5-5-5 1-2 7 7-7 7z" />\n\t\t\t\t</svg>\n\t\t\t</button>\n\t\t')
	return var_output.dup()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCategories) renderdropdownoptions(var_categories rt.PhpVal, var_attributes rt.PhpVal, var_uid rt.PhpVal, depth i64) rt.PhpVal {
	mut var_categories_mutated := var_categories
	mut var_attributes_mutated := var_attributes
	mut var_uid_mutated := var_uid
	mut var_output := rt.new_string(rt.new_string(''))
	{
		mut iter_1 := var_categories_mutated.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_category := item_1.val
			// unsupported expression: Expr_AssignOp_Concat
		}
	}
	return var_output.dup()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCategories) renderlist(var_categories rt.PhpVal, var_attributes rt.PhpVal, var_uid rt.PhpVal, depth i64) rt.PhpVal {
	mut var_categories_mutated := var_categories
	mut var_attributes_mutated := var_attributes
	mut var_uid_mutated := var_uid
	mut var_classes := rt.create_array([
		rt.ArrayItem{ key: none, val: 'wc-block-product-categories-list' },
		rt.ArrayItem{ key: none, val: 'wc-block-product-categories-list--depth-' +
			(rt.call_function('absint', [rt.new_int(depth)])).str() },
	])
	if !(!rt.is_true(var_attributes_mutated.array_get('hasImage'))) {
		var_classes.array_push('wc-block-product-categories-list--has-images')
	}
	mut var_output := rt.new_string('<ul class="' +
		(rt.call_function('esc_attr', [rt.call_function('implode', [rt.new_string(' '), var_classes.dup()])])).str() +
		'">' +
		(this.renderlistitems(var_categories_mutated.dup(), var_attributes_mutated.dup(), var_uid_mutated.dup(), depth)).str() +
		'</ul>')
	return var_output.dup()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCategories) renderlistitems(var_categories rt.PhpVal, var_attributes rt.PhpVal, var_uid rt.PhpVal, depth i64) rt.PhpVal {
	mut var_categories_mutated := var_categories
	mut var_attributes_mutated := var_attributes
	mut var_uid_mutated := var_uid
	mut var_output := rt.new_string(rt.new_string(''))
	mut var_link_color_class_and_style := fn (arg_0 rt.PhpVal) rt.PhpVal {
		mut temp := Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils{}
		return temp.get_link_color_class_and_style(arg_0)
	}(var_attributes_mutated.dup())
	mut var_link_color_style := if var_link_color_class_and_style.array_isset(rt.new_string('style')) {
		var_link_color_class_and_style.array_get('style')
	} else {
		rt.new_string('')
	}
	{
		mut iter_1 := var_categories_mutated.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_category := item_1.val
			// unsupported expression: Expr_AssignOp_Concat
		}
	}
	return rt.call_function('preg_replace', [rt.new_string('/\\r|\\n/'),
		rt.new_string(''), var_output.dup()])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCategories) get_image_html(var_category rt.PhpVal, var_attributes rt.PhpVal, size string) string {
	mut var_category_mutated := var_category
	mut var_attributes_mutated := var_attributes
	if !rt.is_true(var_attributes_mutated.array_get('hasImage')) {
		return ''
	}
	mut var_image_id := rt.call_function('get_term_meta', [
		rt.get_property(var_category_mutated, 'term_id'),
		rt.new_string('thumbnail_id'),
		rt.new_bool(true),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_image_id)))) {
		return
			'<span class="wc-block-product-categories-list-item__image wc-block-product-categories-list-item__image--placeholder">' +
			(rt.call_function('wc_placeholder_img', [rt.new_string('woocommerce_thumbnail')])).str() +
			'</span>'
	}
	return '<span class="wc-block-product-categories-list-item__image">' +
		(rt.call_function('wp_get_attachment_image', [var_image_id.dup(), rt.new_string('woocommerce_thumbnail')])).str() +
		'</span>'
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCategories) getcount(var_category rt.PhpVal, var_attributes rt.PhpVal) string {
	mut var_category_mutated := var_category
	mut var_attributes_mutated := var_attributes
	if !rt.is_true(var_attributes_mutated.array_get('hasCount')) {
		return ''
	}
	if rt.is_true(var_attributes_mutated.array_get('isDropdown')) {
		return '(' +
			(rt.call_function('absint', [rt.get_property(var_category_mutated, 'count')])).str() +
			')'
	}
	mut var_screen_reader_text := rt.call_function('sprintf', [
		rt.call_function('_n', [rt.new_string('%d product'), rt.new_string('%d products'),
			rt.call_function('absint', [rt.get_property(var_category_mutated, 'count')]),
			rt.new_string('woocommerce')]),
		rt.call_function('absint', [rt.get_property(var_category_mutated, 'count')]),
	])
	return '<span class="wc-block-product-categories-list-item-count">' +
		'<span aria-hidden="true">' +
		(rt.call_function('absint', [rt.get_property(var_category_mutated, 'count')])).str() +
		'</span>' + '<span class="screen-reader-text">' +
		(rt.call_function('esc_html', [var_screen_reader_text.dup()])).str() + '</span>' + '</span>'
}

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractDynamicBlock {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blocks_blocktypes_productcategories() &Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCategories {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCategories{
		PhpObjectBase: rt.PhpObjectBase{}
		block_name:    rt.new_string('product-categories')
		defaults:      rt.new_array()
	}
	return obj
}

fn create_automattic_woocommerce_blocks_blocktypes_abstractdynamicblock() &Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractDynamicBlock {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractDynamicBlock{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_utils_styleattributesutils() &Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCategories) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_block_type_attributes' {
			return this.get_block_type_attributes()
		}
		'render' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return rt.new_string(this.render(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2))
		}
		'get_container_classes' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_container_classes(dispatch_arg_0)
		}
		'get_categories' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_categories(dispatch_arg_0)
		}
		'build_category_tree' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.build_category_tree(dispatch_arg_0, dispatch_arg_1)
		}
		'fill_category_children' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.fill_category_children(dispatch_arg_0, dispatch_arg_1)
		}
		'renderDropdown' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.renderdropdown(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'renderDropdownOptions' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).to_i64()
			return this.renderdropdownoptions(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2,
				dispatch_arg_3)
		}
		'renderList' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).to_i64()
			return this.renderlist(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
		}
		'renderListItems' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).to_i64()
			return this.renderlistitems(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2,
				dispatch_arg_3)
		}
		'get_image_html' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			return rt.new_string(this.get_image_html(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2))
		}
		'getCount' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_string(this.getcount(dispatch_arg_0, dispatch_arg_1))
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCategories) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'block_name' { return this.block_name }
		'defaults' { return this.defaults }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCategories) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'block_name' {
			this.block_name = val
			return true
		}
		'defaults' {
			this.defaults = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractDynamicBlock) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractDynamicBlock) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractDynamicBlock) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_woocommerce_src_blocks_blocktypes_productcategories_php() {
}
