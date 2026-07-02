import rt

struct Class_WP_Taxonomy {
	rt.PhpObjectBase
pub mut:
	name                  rt.PhpVal = rt.new_null()
	label                 rt.PhpVal = rt.new_null()
	labels                rt.PhpVal = rt.new_null()
	description           rt.PhpVal = rt.new_string('')
	public                rt.PhpVal = rt.new_bool(true)
	publicly_queryable    rt.PhpVal = rt.new_bool(true)
	hierarchical          rt.PhpVal = rt.new_bool(false)
	show_ui               rt.PhpVal = rt.new_bool(true)
	show_in_menu          rt.PhpVal = rt.new_bool(true)
	show_in_nav_menus     rt.PhpVal = rt.new_bool(true)
	show_tagcloud         rt.PhpVal = rt.new_bool(true)
	show_in_quick_edit    rt.PhpVal = rt.new_bool(true)
	show_admin_column     rt.PhpVal = rt.new_bool(false)
	meta_box_cb           rt.PhpVal = rt.new_null()
	meta_box_sanitize_cb  rt.PhpVal = rt.new_null()
	object_type           rt.PhpVal = rt.new_null()
	cap                   rt.PhpVal = rt.new_null()
	rewrite               rt.PhpVal = rt.new_null()
	query_var             rt.PhpVal = rt.new_null()
	update_count_callback rt.PhpVal = rt.new_null()
	show_in_rest          rt.PhpVal = rt.new_null()
	rest_base             rt.PhpVal = rt.new_null()
	rest_namespace        rt.PhpVal = rt.new_null()
	rest_controller_class rt.PhpVal = rt.new_null()
	rest_controller       rt.PhpVal = rt.new_null()
	default_term          rt.PhpVal = rt.new_null()
	sort                  rt.PhpVal = rt.new_null()
	args                  rt.PhpVal = rt.new_null()
	_builtin              rt.PhpVal = rt.new_null()
}

fn init_static_wp_taxonomy() {
	rt.init_static_prop('WP_Taxonomy', 'default_labels', rt.new_array())
}

fn (mut this Class_WP_Taxonomy) construct(var_taxonomy rt.PhpVal, var_object_type rt.PhpVal, var_args rt.PhpVal) {
	mut var_taxonomy_mutated := var_taxonomy
	mut var_args_mutated := var_args
	this.name = var_taxonomy_mutated.clone()
	this.set_props(var_object_type.clone(), var_args_mutated.clone())
}

fn (mut this Class_WP_Taxonomy) set_props(var_object_type rt.PhpVal, var_args rt.PhpVal) {
	mut var_args_mutated := var_args
	var_args_mutated = rt.call_function('wp_parse_args', [var_args_mutated.clone()])
	var_args_mutated = rt.call_function('apply_filters', [
		rt.new_string('register_taxonomy_args'),
		var_args_mutated.clone(),
		this.name,
		rt.cast_array(var_object_type),
	])
	mut var_taxonomy := this.name
	var_args_mutated = rt.call_function('apply_filters', [
		rt.new_string('register_${var_taxonomy.to_string()}_taxonomy_args'),
		var_args_mutated.clone(),
		this.name,
		rt.cast_array(var_object_type),
	])
	mut var_defaults := {
		'labels':                rt.new_array()
		'description':           rt.new_string('')
		'public':                rt.new_bool(true)
		'publicly_queryable':    rt.new_null()
		'hierarchical':          rt.new_bool(false)
		'show_ui':               rt.new_null()
		'show_in_menu':          rt.new_null()
		'show_in_nav_menus':     rt.new_null()
		'show_tagcloud':         rt.new_null()
		'show_in_quick_edit':    rt.new_null()
		'show_admin_column':     rt.new_bool(false)
		'meta_box_cb':           rt.new_null()
		'meta_box_sanitize_cb':  rt.new_null()
		'capabilities':          rt.new_array()
		'rewrite':               rt.new_bool(true)
		'query_var':             this.name
		'update_count_callback': rt.new_string('')
		'show_in_rest':          rt.new_bool(false)
		'rest_base':             rt.new_bool(false)
		'rest_namespace':        rt.new_bool(false)
		'rest_controller_class': rt.new_bool(false)
		'default_term':          rt.new_null()
		'sort':                  rt.new_null()
		'args':                  rt.new_null()
		'_builtin':              rt.new_bool(false)
	}
	var_args_mutated = rt.call_function('array_merge', [
		rt.create_array_from_native_map(var_defaults),
		var_args_mutated.clone(),
	])
	if rt.is_true(rt.identical(rt.new_null(),
		var_args_mutated.array_get(rt.new_string('publicly_queryable'))))
	{
		var_args_mutated.array_set('publicly_queryable',
			var_args_mutated.array_get(rt.new_string('public')))
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_args_mutated.array_get(rt.new_string('query_var'))))))
		&& rt.is_true(rt.call_function('is_admin', []rt.PhpVal{}))
		|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_args_mutated.array_get(rt.new_string('publicly_queryable')))))) {
		if rt.is_true(rt.identical(rt.new_bool(true),
			var_args_mutated.array_get(rt.new_string('query_var'))))
		{
			var_args_mutated.array_set('query_var', this.name)
		} else {
			var_args_mutated.array_set('query_var', rt.call_function('sanitize_title_with_dashes', [
				var_args_mutated.array_get(rt.new_string('query_var')),
			]))
		}
	} else {
		var_args_mutated.array_set('query_var', false)
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_args_mutated.array_get(rt.new_string('rewrite'))))))
		&& rt.is_true(rt.call_function('is_admin', []rt.PhpVal{}))
		|| rt.is_true(rt.call_function('get_option', [rt.new_string('permalink_structure')])) {
		var_args_mutated.array_set('rewrite', rt.call_function('wp_parse_args', [
			var_args_mutated.array_get(rt.new_string('rewrite')),
			rt.create_array([rt.ArrayItem{ key: 'with_front', val: true },
				rt.ArrayItem{ key: 'hierarchical', val: false },
				rt.ArrayItem{ key: 'ep_mask', val: rt.get_constant('EP_NONE') }]),
		]))
		if !rt.is_true(var_args_mutated.array_get(rt.new_string('rewrite')).array_get(rt.new_string('slug'))) {
			var_args_mutated.array_get_mut('rewrite').array_set('slug', rt.call_function('sanitize_title_with_dashes', [
				this.name,
			]))
		}
	}
	if rt.is_true(rt.identical(rt.new_null(), var_args_mutated.array_get(rt.new_string('show_ui')))) {
		var_args_mutated.array_set('show_ui', var_args_mutated.array_get(rt.new_string('public')))
	}
	if rt.is_true(rt.identical(rt.new_null(), var_args_mutated.array_get(rt.new_string('show_in_menu'))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(var_args_mutated.array_get(rt.new_string('show_ui')))))) {
		var_args_mutated.array_set('show_in_menu',
			var_args_mutated.array_get(rt.new_string('show_ui')))
	}
	if rt.is_true(rt.identical(rt.new_null(),
		var_args_mutated.array_get(rt.new_string('show_in_nav_menus'))))
	{
		var_args_mutated.array_set('show_in_nav_menus',
			var_args_mutated.array_get(rt.new_string('public')))
	}
	if rt.is_true(rt.identical(rt.new_null(),
		var_args_mutated.array_get(rt.new_string('show_tagcloud'))))
	{
		var_args_mutated.array_set('show_tagcloud',
			var_args_mutated.array_get(rt.new_string('show_ui')))
	}
	if rt.is_true(rt.identical(rt.new_null(),
		var_args_mutated.array_get(rt.new_string('show_in_quick_edit'))))
	{
		var_args_mutated.array_set('show_in_quick_edit',
			var_args_mutated.array_get(rt.new_string('show_ui')))
	}
	if rt.is_true(rt.identical(rt.new_bool(false), var_args_mutated.array_get(rt.new_string('rest_namespace'))))
		&& !(!rt.is_true(var_args_mutated.array_get(rt.new_string('show_in_rest')))) {
		var_args_mutated.array_set('rest_namespace', 'wp/v2')
	}
	mut var_default_caps := {
		'manage_terms': 'manage_categories'
		'edit_terms':   'manage_categories'
		'delete_terms': 'manage_categories'
		'assign_terms': 'edit_posts'
	}
	var_args_mutated.array_set('cap', rt.array_to_object(rt.call_function('array_merge', [
		rt.create_array_from_native_map(var_default_caps),
		var_args_mutated.array_get(rt.new_string('capabilities')),
	])))
	var_args_mutated.array_unset(rt.new_string('capabilities'))
	var_args_mutated.array_set('object_type', rt.call_function('array_unique', [
		rt.cast_array(var_object_type),
	]))
	if rt.is_true(rt.identical(rt.new_null(),
		var_args_mutated.array_get(rt.new_string('meta_box_cb'))))
	{
		if rt.is_true(var_args_mutated.array_get(rt.new_string('hierarchical'))) {
			var_args_mutated.array_set('meta_box_cb', 'post_categories_meta_box')
		} else {
			var_args_mutated.array_set('meta_box_cb', 'post_tags_meta_box')
		}
	}
	var_args_mutated.array_set('name', this.name)
	if rt.is_true(rt.identical(rt.new_null(),
		var_args_mutated.array_get(rt.new_string('meta_box_sanitize_cb'))))
	{
		mut switch_val_1 := var_args_mutated.array_get(rt.new_string('meta_box_cb'))
		if rt.is_true(rt.equal(switch_val_1, rt.new_string('post_categories_meta_box'))) {
			var_args_mutated.array_set('meta_box_sanitize_cb',
				'taxonomy_meta_box_sanitize_cb_checkboxes')
		} else {
			var_args_mutated.array_set('meta_box_sanitize_cb',
				'taxonomy_meta_box_sanitize_cb_input')
		}
	}
	if !(!rt.is_true(var_args_mutated.array_get(rt.new_string('default_term')))) {
		if !(var_args_mutated.array_get(rt.new_string('default_term')).is_array()) {
			var_args_mutated.array_set('default_term', rt.create_array([
				rt.ArrayItem{
					key: 'name'
					val: var_args_mutated.array_get(rt.new_string('default_term'))
				},
			]))
		}
		var_args_mutated.array_set('default_term', rt.call_function('wp_parse_args', [
			var_args_mutated.array_get(rt.new_string('default_term')),
			rt.create_array([rt.ArrayItem{ key: 'name', val: '' },
				rt.ArrayItem{ key: 'slug', val: '' }, rt.ArrayItem{ key: 'description', val: '' }]),
		]))
	}
	mut iter_1 := var_args_mutated.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_property_value := item_1.val
		mut var_property_name := item_1.key
		this.dispatch_set_prop('{"nodeType":"Expr_Variable","line":483,"name":"property_name"}',
			var_property_value.clone())
	}
	this.labels = rt.call_function('get_taxonomy_labels', [
		rt.new_object('WP_Taxonomy', []string{}, &this),
	])
	this.label = rt.get_property(this.labels, 'name')
}

fn (mut this Class_WP_Taxonomy) add_rewrite_rules() {
	mut var_wp := rt.new_null()
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), this.query_var))))
		&& rt.is_true(var_wp) {
		rt.call_method(var_wp, 'add_query_var', [this.query_var])
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), this.rewrite))))
		&& rt.is_true(rt.call_function('is_admin', []rt.PhpVal{}))
		|| rt.is_true(rt.call_function('get_option', [rt.new_string('permalink_structure')])) {
		if rt.is_true(this.hierarchical)
			&& rt.is_true(this.rewrite.array_get(rt.new_string('hierarchical'))) {
			mut var_tag := rt.new_string('(.+?)')
		} else {
			var_tag = rt.new_string('([^/]+)')
		}
		rt.call_function('add_rewrite_tag', [
			rt.concat(rt.concat(rt.new_string('%'), this.name), rt.new_string('%')),
			var_tag.clone(),
			rt.new_string((if rt.is_true(this.query_var) {
				rt.concat(this.query_var, rt.new_string('='))
			} else {
				rt.concat(rt.concat(rt.new_string('taxonomy='), this.name), rt.new_string('&term='))
			}).str()),
		])
		rt.call_function('add_permastruct', [this.name,
			rt.concat(rt.concat(rt.concat(this.rewrite.array_get(rt.new_string('slug')),
				rt.new_string('/%')), this.name), rt.new_string('%')),
			this.rewrite])
	}
}

fn (mut this Class_WP_Taxonomy) remove_rewrite_rules() {
	mut var_wp := rt.new_null()
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), this.query_var)))) {
		rt.call_method(var_wp, 'remove_query_var', [this.query_var])
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), this.rewrite)))) {
		rt.call_function('remove_rewrite_tag', [
			rt.concat(rt.concat(rt.new_string('%'), this.name), rt.new_string('%')),
		])
		rt.call_function('remove_permastruct', [this.name])
	}
}

fn (mut this Class_WP_Taxonomy) add_hooks() {
	rt.call_function('add_filter', [rt.new_string('wp_ajax_add-' + (this.name).str()),
		rt.new_string('_wp_ajax_add_hierarchical_term')])
}

fn (mut this Class_WP_Taxonomy) remove_hooks() {
	rt.call_function('remove_filter', [rt.new_string('wp_ajax_add-' + (this.name).str()),
		rt.new_string('_wp_ajax_add_hierarchical_term')])
}

fn (mut this Class_WP_Taxonomy) get_rest_controller() rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(this.show_in_rest)))) {
		return rt.new_null()
	}
	mut var_class := if rt.is_true(this.rest_controller_class) {
		this.rest_controller_class
	} else {
		Class_WP_REST_Terms_Controller.class()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [
		var_class.clone()])))))
	{
		return rt.new_null()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_subclass_of', [
		var_class.clone(),
		Class_WP_REST_Controller.class(),
	])))))
	{
		return rt.new_null()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(this.rest_controller)))) {
		this.rest_controller = rt.create_object_dynamically(var_class, [this.name])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(this.rest_controller,
		'{"nodeType":"Expr_Variable","line":588,"name":"class"}'))))))
	{
		return rt.new_null()
	}
	return this.rest_controller
}

fn Class_WP_Taxonomy.get_default_labels() rt.PhpVal {
	if !(!rt.is_true(rt.get_static_prop('WP_Taxonomy', 'default_labels'))) {
		return rt.get_static_prop('WP_Taxonomy', 'default_labels')
	}
	mut var_name_field_description := rt.call_function('__', [
		rt.new_string('The name is how it appears on your site.'),
	])
	mut var_slug_field_description := rt.call_function('__', [
		rt.new_string('The &#8220;slug&#8221; is the URL-friendly version of the name. It is usually all lowercase and contains only letters, numbers, and hyphens.'),
	])
	mut var_parent_field_description := rt.call_function('__', [
		rt.new_string('Assign a parent term to create a hierarchy. The term Jazz, for example, would be the parent of Bebop and Big Band.'),
	])
	mut var_desc_field_description := rt.call_function('__', [
		rt.new_string('The description is not prominent by default; however, some themes may show it.'),
	])
	rt.set_static_prop('WP_Taxonomy', 'default_labels', rt.create_array([
		rt.ArrayItem{ key: 'name', val: rt.create_array([
			rt.ArrayItem{ key: none, val: rt.call_function('_x', [
				rt.new_string('Tags'), rt.new_string('taxonomy general name')]) },
			rt.ArrayItem{ key: none, val: rt.call_function('_x', [
				rt.new_string('Categories'), rt.new_string('taxonomy general name')]) },
		]) },
		rt.ArrayItem{ key: 'singular_name', val: rt.create_array([
			rt.ArrayItem{ key: none, val: rt.call_function('_x', [
				rt.new_string('Tag'), rt.new_string('taxonomy singular name')]) },
			rt.ArrayItem{ key: none, val: rt.call_function('_x', [
				rt.new_string('Category'), rt.new_string('taxonomy singular name')]) },
		]) },
		rt.ArrayItem{ key: 'search_items', val: rt.create_array([
			rt.ArrayItem{ key: none, val: rt.call_function('__', [
				rt.new_string('Search Tags')]) },
			rt.ArrayItem{ key: none, val: rt.call_function('__', [
				rt.new_string('Search Categories')]) },
		]) },
		rt.ArrayItem{ key: 'popular_items', val: rt.create_array([
			rt.ArrayItem{ key: none, val: rt.call_function('__', [
				rt.new_string('Popular Tags')]) },
			rt.ArrayItem{ key: none, val: rt.new_null() },
		]) },
		rt.ArrayItem{ key: 'all_items', val: rt.create_array([
			rt.ArrayItem{ key: none, val: rt.call_function('__', [
				rt.new_string('All Tags')]) },
			rt.ArrayItem{ key: none, val: rt.call_function('__', [
				rt.new_string('All Categories')]) },
		]) },
		rt.ArrayItem{ key: 'parent_item', val: rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_null() },
			rt.ArrayItem{ key: none, val: rt.call_function('__', [
				rt.new_string('Parent Category')]) },
		]) },
		rt.ArrayItem{ key: 'parent_item_colon', val: rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_null() },
			rt.ArrayItem{ key: none, val: rt.call_function('__', [
				rt.new_string('Parent Category:')]) },
		]) },
		rt.ArrayItem{ key: 'name_field_description', val: rt.create_array([
			rt.ArrayItem{ key: none, val: var_name_field_description },
			rt.ArrayItem{ key: none, val: var_name_field_description },
		]) },
		rt.ArrayItem{ key: 'slug_field_description', val: rt.create_array([
			rt.ArrayItem{ key: none, val: var_slug_field_description },
			rt.ArrayItem{ key: none, val: var_slug_field_description },
		]) },
		rt.ArrayItem{ key: 'parent_field_description', val: rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_null() },
			rt.ArrayItem{ key: none, val: var_parent_field_description },
		]) },
		rt.ArrayItem{ key: 'desc_field_description', val: rt.create_array([
			rt.ArrayItem{ key: none, val: var_desc_field_description },
			rt.ArrayItem{ key: none, val: var_desc_field_description },
		]) },
		rt.ArrayItem{ key: 'edit_item', val: rt.create_array([
			rt.ArrayItem{ key: none, val: rt.call_function('__', [
				rt.new_string('Edit Tag')]) },
			rt.ArrayItem{ key: none, val: rt.call_function('__', [
				rt.new_string('Edit Category')]) },
		]) },
		rt.ArrayItem{ key: 'view_item', val: rt.create_array([
			rt.ArrayItem{ key: none, val: rt.call_function('__', [
				rt.new_string('View Tag')]) },
			rt.ArrayItem{ key: none, val: rt.call_function('__', [
				rt.new_string('View Category')]) },
		]) },
		rt.ArrayItem{ key: 'update_item', val: rt.create_array([
			rt.ArrayItem{ key: none, val: rt.call_function('__', [
				rt.new_string('Update Tag')]) },
			rt.ArrayItem{ key: none, val: rt.call_function('__', [
				rt.new_string('Update Category')]) },
		]) },
		rt.ArrayItem{ key: 'add_new_item', val: rt.create_array([
			rt.ArrayItem{ key: none, val: rt.call_function('__', [
				rt.new_string('Add Tag')]) },
			rt.ArrayItem{ key: none, val: rt.call_function('__', [
				rt.new_string('Add Category')]) },
		]) },
		rt.ArrayItem{ key: 'new_item_name', val: rt.create_array([
			rt.ArrayItem{ key: none, val: rt.call_function('__', [
				rt.new_string('New Tag Name')]) },
			rt.ArrayItem{ key: none, val: rt.call_function('__', [
				rt.new_string('New Category Name')]) },
		]) },
		rt.ArrayItem{ key: 'separate_items_with_commas', val: rt.create_array([
			rt.ArrayItem{ key: none, val: rt.call_function('__', [
				rt.new_string('Separate tags with commas')]) },
			rt.ArrayItem{ key: none, val: rt.new_null() },
		]) },
		rt.ArrayItem{ key: 'add_or_remove_items', val: rt.create_array([
			rt.ArrayItem{ key: none, val: rt.call_function('__', [
				rt.new_string('Add or remove tags')]) },
			rt.ArrayItem{ key: none, val: rt.new_null() },
		]) },
		rt.ArrayItem{ key: 'choose_from_most_used', val: rt.create_array([
			rt.ArrayItem{ key: none, val: rt.call_function('__', [
				rt.new_string('Choose from the most used tags')]) },
			rt.ArrayItem{ key: none, val: rt.new_null() },
		]) },
		rt.ArrayItem{ key: 'not_found', val: rt.create_array([
			rt.ArrayItem{ key: none, val: rt.call_function('__', [
				rt.new_string('No tags found.')]) },
			rt.ArrayItem{ key: none, val: rt.call_function('__', [
				rt.new_string('No categories found.')]) },
		]) },
		rt.ArrayItem{ key: 'no_terms', val: rt.create_array([
			rt.ArrayItem{ key: none, val: rt.call_function('__', [
				rt.new_string('No tags')]) },
			rt.ArrayItem{ key: none, val: rt.call_function('__', [
				rt.new_string('No categories')]) },
		]) },
		rt.ArrayItem{ key: 'filter_by_item', val: rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_null() },
			rt.ArrayItem{ key: none, val: rt.call_function('__', [
				rt.new_string('Filter by category')]) },
		]) },
		rt.ArrayItem{ key: 'items_list_navigation', val: rt.create_array([
			rt.ArrayItem{ key: none, val: rt.call_function('__', [
				rt.new_string('Tags list navigation')]) },
			rt.ArrayItem{ key: none, val: rt.call_function('__', [
				rt.new_string('Categories list navigation')]) },
		]) },
		rt.ArrayItem{ key: 'items_list', val: rt.create_array([
			rt.ArrayItem{ key: none, val: rt.call_function('__', [
				rt.new_string('Tags list')]) },
			rt.ArrayItem{ key: none, val: rt.call_function('__', [
				rt.new_string('Categories list')]) },
		]) },
		rt.ArrayItem{ key: 'most_used', val: rt.create_array([
			rt.ArrayItem{ key: none, val: rt.call_function('_x', [
				rt.new_string('Most Used'), rt.new_string('tags')]) },
			rt.ArrayItem{ key: none, val: rt.call_function('_x', [
				rt.new_string('Most Used'), rt.new_string('categories')]) },
		]) },
		rt.ArrayItem{ key: 'back_to_items', val: rt.create_array([
			rt.ArrayItem{ key: none, val: rt.call_function('__', [
				rt.new_string('&larr; Go to Tags')]) },
			rt.ArrayItem{ key: none, val: rt.call_function('__', [
				rt.new_string('&larr; Go to Categories')]) },
		]) },
		rt.ArrayItem{ key: 'item_link', val: rt.create_array([
			rt.ArrayItem{ key: none, val: rt.call_function('_x', [
				rt.new_string('Tag Link'), rt.new_string('navigation link block title')]) },
			rt.ArrayItem{ key: none, val: rt.call_function('_x', [
				rt.new_string('Category Link'), rt.new_string('navigation link block title')]) },
		]) },
		rt.ArrayItem{ key: 'item_link_description', val: rt.create_array([
			rt.ArrayItem{
				key: none
				val: rt.call_function('_x', [rt.new_string('A link to a tag.'),
					rt.new_string('navigation link block description')])
			},
			rt.ArrayItem{ key: none, val: rt.call_function('_x', [
				rt.new_string('A link to a category.'),
				rt.new_string('navigation link block description')]) },
		]) },
	]))
	return rt.get_static_prop('WP_Taxonomy', 'default_labels')
}

fn Class_WP_Taxonomy.reset_default_labels() {
	rt.set_static_prop('WP_Taxonomy', 'default_labels', rt.new_array())
}

fn create_wp_taxonomy(arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) &Class_WP_Taxonomy {
	mut obj := &Class_WP_Taxonomy{
		PhpObjectBase:         rt.PhpObjectBase{}
		name:                  rt.new_null()
		label:                 rt.new_null()
		labels:                rt.new_null()
		description:           rt.new_string('')
		public:                rt.new_bool(true)
		publicly_queryable:    rt.new_bool(true)
		hierarchical:          rt.new_bool(false)
		show_ui:               rt.new_bool(true)
		show_in_menu:          rt.new_bool(true)
		show_in_nav_menus:     rt.new_bool(true)
		show_tagcloud:         rt.new_bool(true)
		show_in_quick_edit:    rt.new_bool(true)
		show_admin_column:     rt.new_bool(false)
		meta_box_cb:           rt.new_null()
		meta_box_sanitize_cb:  rt.new_null()
		object_type:           rt.new_null()
		cap:                   rt.new_null()
		rewrite:               rt.new_null()
		query_var:             rt.new_null()
		update_count_callback: rt.new_null()
		show_in_rest:          rt.new_null()
		rest_base:             rt.new_null()
		rest_namespace:        rt.new_null()
		rest_controller_class: rt.new_null()
		rest_controller:       rt.new_null()
		default_term:          rt.new_null()
		sort:                  rt.new_null()
		args:                  rt.new_null()
		_builtin:              rt.new_null()
	}
	obj.construct(arg_0, arg_1, arg_2)
	return obj
}

fn (mut this Class_WP_Taxonomy) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			this.construct(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'set_props' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.set_props(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'add_rewrite_rules' {
			this.add_rewrite_rules()
			return rt.new_null()
		}
		'remove_rewrite_rules' {
			this.remove_rewrite_rules()
			return rt.new_null()
		}
		'add_hooks' {
			this.add_hooks()
			return rt.new_null()
		}
		'remove_hooks' {
			this.remove_hooks()
			return rt.new_null()
		}
		'get_rest_controller' {
			return this.get_rest_controller()
		}
		'get_default_labels' {
			return Class_WP_Taxonomy.get_default_labels()
		}
		'reset_default_labels' {
			Class_WP_Taxonomy.reset_default_labels()
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WP_Taxonomy) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'name' { return this.name }
		'label' { return this.label }
		'labels' { return this.labels }
		'description' { return this.description }
		'public' { return this.public }
		'publicly_queryable' { return this.publicly_queryable }
		'hierarchical' { return this.hierarchical }
		'show_ui' { return this.show_ui }
		'show_in_menu' { return this.show_in_menu }
		'show_in_nav_menus' { return this.show_in_nav_menus }
		'show_tagcloud' { return this.show_tagcloud }
		'show_in_quick_edit' { return this.show_in_quick_edit }
		'show_admin_column' { return this.show_admin_column }
		'meta_box_cb' { return this.meta_box_cb }
		'meta_box_sanitize_cb' { return this.meta_box_sanitize_cb }
		'object_type' { return this.object_type }
		'cap' { return this.cap }
		'rewrite' { return this.rewrite }
		'query_var' { return this.query_var }
		'update_count_callback' { return this.update_count_callback }
		'show_in_rest' { return this.show_in_rest }
		'rest_base' { return this.rest_base }
		'rest_namespace' { return this.rest_namespace }
		'rest_controller_class' { return this.rest_controller_class }
		'rest_controller' { return this.rest_controller }
		'default_term' { return this.default_term }
		'sort' { return this.sort }
		'args' { return this.args }
		'_builtin' { return this._builtin }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_Taxonomy) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'name' {
			this.name = val
			return true
		}
		'label' {
			this.label = val
			return true
		}
		'labels' {
			this.labels = val
			return true
		}
		'description' {
			this.description = val
			return true
		}
		'public' {
			this.public = val
			return true
		}
		'publicly_queryable' {
			this.publicly_queryable = val
			return true
		}
		'hierarchical' {
			this.hierarchical = val
			return true
		}
		'show_ui' {
			this.show_ui = val
			return true
		}
		'show_in_menu' {
			this.show_in_menu = val
			return true
		}
		'show_in_nav_menus' {
			this.show_in_nav_menus = val
			return true
		}
		'show_tagcloud' {
			this.show_tagcloud = val
			return true
		}
		'show_in_quick_edit' {
			this.show_in_quick_edit = val
			return true
		}
		'show_admin_column' {
			this.show_admin_column = val
			return true
		}
		'meta_box_cb' {
			this.meta_box_cb = val
			return true
		}
		'meta_box_sanitize_cb' {
			this.meta_box_sanitize_cb = val
			return true
		}
		'object_type' {
			this.object_type = val
			return true
		}
		'cap' {
			this.cap = val
			return true
		}
		'rewrite' {
			this.rewrite = val
			return true
		}
		'query_var' {
			this.query_var = val
			return true
		}
		'update_count_callback' {
			this.update_count_callback = val
			return true
		}
		'show_in_rest' {
			this.show_in_rest = val
			return true
		}
		'rest_base' {
			this.rest_base = val
			return true
		}
		'rest_namespace' {
			this.rest_namespace = val
			return true
		}
		'rest_controller_class' {
			this.rest_controller_class = val
			return true
		}
		'rest_controller' {
			this.rest_controller = val
			return true
		}
		'default_term' {
			this.default_term = val
			return true
		}
		'sort' {
			this.sort = val
			return true
		}
		'args' {
			this.args = val
			return true
		}
		'_builtin' {
			this._builtin = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn init_registry() {
	rt.register_class_factory('WP_Taxonomy', fn (args []rt.PhpVal) rt.PhpVal {
		c_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		c_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		c_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
		obj := create_wp_taxonomy(c_arg_0, c_arg_1, c_arg_2)
		return rt.new_object('WP_Taxonomy', []string{}, obj)
	})
}

fn init() {
	init_registry()
}

fn main() {
	defer {
		rt.shutdown()
	}
}
