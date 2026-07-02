import rt

pub fn Class_WP_REST_Abilities_V1_List_Controller.internal_schema_keywords() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'sanitize_callback', val: true },
		rt.ArrayItem{ key: 'validate_callback', val: true }, rt.ArrayItem{
			key: 'arg_options'
			val: true
		}])
}

struct Class_WP_REST_Abilities_V1_List_Controller {
	rt.PhpObjectBase
pub mut:
	namespace rt.PhpVal = rt.new_string('wp-abilities/v1')
	rest_base rt.PhpVal = rt.new_string('abilities')
}

fn (mut this Class_WP_REST_Abilities_V1_List_Controller) register_routes() {
	rt.call_function('register_rest_route', [this.namespace, rt.new_string('/' +
		(this.rest_base).str()),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() },
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Abilities_V1_List_Controller', [
						'WP_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_items' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Abilities_V1_List_Controller', [
						'WP_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_items_permissions_check' },
				]) },
				rt.ArrayItem{ key: 'args', val: this.get_collection_params() },
			]) },
			rt.ArrayItem{ key: 'schema', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Abilities_V1_List_Controller', [
					'WP_REST_Controller',
				], &this) },
				rt.ArrayItem{ key: none, val: 'get_public_item_schema' },
			]) },
		])])
	rt.call_function('register_rest_route', [this.namespace,
		rt.new_string('/' + (this.rest_base).str() + '/(?P<name>[a-zA-Z0-9\\-\\/]+)'),
		rt.create_array([
			rt.ArrayItem{ key: 'args', val: rt.create_array([
				rt.ArrayItem{ key: 'name', val: rt.create_array([
					rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
						rt.new_string('Unique identifier for the ability.'),
					]) },
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'pattern', val: '^[a-zA-Z0-9\\-\\/]+$' },
				]) },
			]) },
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() },
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Abilities_V1_List_Controller', [
						'WP_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_item' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Abilities_V1_List_Controller', [
						'WP_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_item_permissions_check' },
				]) },
			]) },
			rt.ArrayItem{ key: 'schema', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Abilities_V1_List_Controller', [
					'WP_REST_Controller',
				], &this) },
				rt.ArrayItem{ key: none, val: 'get_public_item_schema' },
			]) },
		])])
}

fn (mut this Class_WP_REST_Abilities_V1_List_Controller) get_items(var_request rt.PhpVal) rt.PhpVal {
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_ability := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.call_method(var_ability, 'get_meta_item', [
			rt.new_string('show_in_rest'),
		])
	}
	mut var_abilities := rt.call_function('array_filter', [
		rt.call_function('wp_get_abilities', []rt.PhpVal{}),
		rt.new_closure(closure_1_fn),
	])
	mut var_category := var_request.array_get(rt.new_string('category'))
	if !(!rt.is_true(var_category)) {
		closure_2_fn := fn [var_category] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_ability := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			return rt.identical(rt.call_method(var_ability, 'get_category', []rt.PhpVal{}),
				var_category)
		}
		var_abilities = rt.call_function('array_filter', [var_abilities.clone(),
			rt.new_closure(closure_2_fn)])
		var_abilities = rt.call_function('array_values', [var_abilities.clone()])
	}
	mut var_page := var_request.array_get(rt.new_string('page'))
	mut var_per_page := var_request.array_get(rt.new_string('per_page'))
	mut var_offset := rt.mul(rt.sub(var_page, rt.new_int(1)), var_per_page)
	mut var_total_abilities := rt.new_int(var_abilities.clone().array_count())
	mut var_max_pages := rt.new_int((rt.call_function('ceil', [
		rt.div(var_total_abilities, var_per_page),
	])).to_i64())
	if rt.is_true(rt.identical(rt.call_method(var_request, 'get_method', []rt.PhpVal{}),
		rt.new_string('HEAD')))
	{
		mut var_response := create_wp_rest_response(rt.new_array())
	} else {
		var_abilities = rt.call_function('array_slice', [var_abilities.clone(),
			var_offset.clone(), var_per_page.clone()])
		mut var_data := rt.new_array()
		mut iter_1 := var_abilities.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_ability := item_1.val
			mut var_item := this.prepare_item_for_response(var_ability.clone(), var_request.clone())
			var_data.array_push(this.prepare_response_for_collection(var_item.clone()))
		}
		var_response = rt.call_function('rest_ensure_response', [
			var_data.clone()])
	}
	rt.call_method(var_response, 'header', [rt.new_string('X-WP-Total'),
		rt.new_string(var_total_abilities.str())])
	rt.call_method(var_response, 'header', [rt.new_string('X-WP-TotalPages'),
		rt.new_string(var_max_pages.str())])
	mut var_query_params := rt.call_method(var_request, 'get_query_params', []rt.PhpVal{})
	mut var_base := rt.call_function('add_query_arg', [
		rt.call_function('urlencode_deep', [var_query_params.clone()]),
		rt.call_function('rest_url', [
			rt.call_function('sprintf', [rt.new_string('%s/%s'), this.namespace, this.rest_base]),
		]),
	])
	if rt.is_true(rt.greater(var_page, rt.new_int(1))) {
		mut var_prev_page := rt.sub(var_page, rt.new_int(1))
		mut var_prev_link := rt.call_function('add_query_arg', [
			rt.new_string('page'), var_prev_page.clone(), var_base.clone()])
		rt.call_method(var_response, 'link_header', [rt.new_string('prev'),
			var_prev_link.clone()])
	}
	if rt.is_true(rt.less(var_page, var_max_pages)) {
		mut var_next_page := rt.add(var_page, rt.new_int(1))
		mut var_next_link := rt.call_function('add_query_arg', [
			rt.new_string('page'), var_next_page.clone(), var_base.clone()])
		rt.call_method(var_response, 'link_header', [rt.new_string('next'),
			var_next_link.clone()])
	}
	return var_response.clone()
}

fn (mut this Class_WP_REST_Abilities_V1_List_Controller) get_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_ability := rt.call_function('wp_get_ability', [
		var_request.array_get(rt.new_string('name')),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_ability))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_ability, 'get_meta_item', [rt.new_string('show_in_rest')]))))) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('rest_ability_not_found'), rt.call_function('__', [
			rt.new_string('Ability not found.'),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 404 }])))
	}
	mut var_data := this.prepare_item_for_response(var_ability.clone(), var_request.clone())
	return rt.call_function('rest_ensure_response', [var_data.clone()])
}

fn (mut this Class_WP_REST_Abilities_V1_List_Controller) get_items_permissions_check(var_request rt.PhpVal) rt.PhpVal {
	return rt.call_function('current_user_can', [rt.new_string('read')])
}

fn (mut this Class_WP_REST_Abilities_V1_List_Controller) get_item_permissions_check(var_request rt.PhpVal) rt.PhpVal {
	return rt.call_function('current_user_can', [rt.new_string('read')])
}

fn (mut this Class_WP_REST_Abilities_V1_List_Controller) normalize_schema_empty_object_defaults(mut var_schema Class_array) rt.PhpVal {
	mut var_schema_mutated := var_schema
	if var_schema_mutated.array_isset(rt.new_string('type'))
		&& rt.is_true(rt.identical(rt.new_string('object'), var_schema_mutated.array_get(rt.new_string('type'))))
		&& var_schema_mutated.array_isset(rt.new_string('default')) {
		mut var_default := var_schema_mutated.array_get(rt.new_string('default'))
		if var_default.clone().is_array() && !rt.is_true(var_default) {
			var_schema_mutated.array_set('default', rt.array_to_object(var_default))
		}
	}
	return rt.new_object('array', []string{}, var_schema_mutated)
}

fn (mut this Class_WP_REST_Abilities_V1_List_Controller) strip_internal_schema_keywords(mut var_schema Class_array) rt.PhpVal {
	mut var_schema_mutated := var_schema
	var_schema_mutated = rt.call_function('array_diff_key', [var_schema_mutated,
		Class_WP_REST_Abilities_V1_List_Controller.internal_schema_keywords()])
	mut iter_2 := rt.create_array([rt.ArrayItem{ key: none, val: 'properties' },
		rt.ArrayItem{ key: none, val: 'patternProperties' }, rt.ArrayItem{
			key: none
			val: 'definitions'
		}, rt.ArrayItem{ key: none, val: 'dependencies' }]).iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_keyword := item_2.val
		if var_schema_mutated.array_isset(var_keyword)
			&& var_schema_mutated.array_get(var_keyword).is_array() {
			mut iter_3 := var_schema_mutated.array_get(var_keyword).iterator()
			for {
				item_3 := iter_3.next() or { break }
				mut var_child_schema := item_3.val
				mut var_key := item_3.key
				if var_child_schema.clone().is_array()
					&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_is_numeric_array', [var_child_schema.clone()]))))) {
					var_schema_mutated.array_get_mut(var_keyword).array_set(var_key,
						this.strip_internal_schema_keywords(mut rt.cast_object_ptr[Class_array](var_child_schema)))
				}
			}
		}
	}
	mut iter_4 := rt.create_array([rt.ArrayItem{ key: none, val: 'not' },
		rt.ArrayItem{ key: none, val: 'additionalProperties' },
		rt.ArrayItem{ key: none, val: 'additionalItems' }]).iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_keyword := item_4.val
		if var_schema_mutated.array_isset(var_keyword)
			&& var_schema_mutated.array_get(var_keyword).is_array() {
			var_schema_mutated.array_set(var_keyword,
				this.strip_internal_schema_keywords(mut rt.cast_object_ptr[Class_array](var_schema_mutated.array_get(var_keyword))))
		}
	}
	if var_schema_mutated.array_isset(rt.new_string('items')) {
		if rt.is_true(rt.call_function('wp_is_numeric_array', [
			var_schema_mutated.array_get(rt.new_string('items')),
		]))
		{
			mut iter_5 := var_schema_mutated.array_get(rt.new_string('items')).iterator()
			for {
				item_5 := iter_5.next() or { break }
				mut var_item_schema := item_5.val
				mut var_index := item_5.key
				if rt.is_true(rt.new_bool(var_item_schema.clone().is_array())) {
					var_schema_mutated.array_get_mut('items').array_set(var_index,
						this.strip_internal_schema_keywords(mut rt.cast_object_ptr[Class_array](var_item_schema)))
				}
			}
		} else if rt.is_true(rt.new_bool(var_schema_mutated.array_get(rt.new_string('items')).is_array())) {
			var_schema_mutated.array_set('items',
				this.strip_internal_schema_keywords(mut rt.cast_object_ptr[Class_array](var_schema_mutated.array_get(rt.new_string('items')))))
		}
	}
	mut iter_6 := rt.create_array([rt.ArrayItem{ key: none, val: 'anyOf' },
		rt.ArrayItem{ key: none, val: 'oneOf' }, rt.ArrayItem{ key: none, val: 'allOf' }]).iterator()
	for {
		item_6 := iter_6.next() or { break }
		mut var_keyword := item_6.val
		if var_schema_mutated.array_isset(var_keyword)
			&& var_schema_mutated.array_get(var_keyword).is_array() {
			mut iter_7 := var_schema_mutated.array_get(var_keyword).iterator()
			for {
				item_7 := iter_7.next() or { break }
				mut var_sub_schema := item_7.val
				mut var_index := item_7.key
				if rt.is_true(rt.new_bool(var_sub_schema.clone().is_array())) {
					var_schema_mutated.array_get_mut(var_keyword).array_set(var_index,
						this.strip_internal_schema_keywords(mut rt.cast_object_ptr[Class_array](var_sub_schema)))
				}
			}
		}
	}
	return rt.new_object('array', []string{}, var_schema_mutated)
}

fn (mut this Class_WP_REST_Abilities_V1_List_Controller) prepare_item_for_response(var_ability rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	mut var_ability_mutated := var_ability
	mut var_data := rt.create_array([
		rt.ArrayItem{ key: 'name', val: rt.call_method(var_ability_mutated, 'get_name',
			[]rt.PhpVal{}) },
		rt.ArrayItem{ key: 'label', val: rt.call_method(var_ability_mutated, 'get_label',
			[]rt.PhpVal{}) },
		rt.ArrayItem{ key: 'description', val: rt.call_method(var_ability_mutated,
			'get_description', []rt.PhpVal{}) },
		rt.ArrayItem{ key: 'category', val: rt.call_method(var_ability_mutated, 'get_category',
			[]rt.PhpVal{}) },
		rt.ArrayItem{ key: 'input_schema', val: this.strip_internal_schema_keywords(mut rt.cast_object_ptr[Class_array](this.normalize_schema_empty_object_defaults(mut rt.cast_object_ptr[Class_array](rt.call_method(var_ability_mutated,
			'get_input_schema', []rt.PhpVal{}))))) },
		rt.ArrayItem{ key: 'output_schema', val: this.strip_internal_schema_keywords(mut rt.cast_object_ptr[Class_array](this.normalize_schema_empty_object_defaults(mut rt.cast_object_ptr[Class_array](rt.call_method(var_ability_mutated,
			'get_output_schema', []rt.PhpVal{}))))) },
		rt.ArrayItem{ key: 'meta', val: rt.call_method(var_ability_mutated, 'get_meta',
			[]rt.PhpVal{}) },
	])
	mut var_context := if !(var_request.array_get(rt.new_string('context'))).is_null() {
		var_request.array_get(rt.new_string('context'))
	} else {
		rt.new_string('view')
	}
	var_data = this.add_additional_fields_to_object(var_data.clone(), var_request.clone())
	var_data = this.filter_response_by_context(var_data.clone(), var_context.clone())
	mut var_response := rt.call_function('rest_ensure_response', [
		var_data.clone()])
	mut var_fields := this.get_fields_for_response(var_request.clone())
	if rt.is_true(rt.call_function('rest_is_field_included', [rt.new_string('_links'), var_fields.clone()]))
		|| rt.is_true(rt.call_function('rest_is_field_included', [rt.new_string('_embedded'), var_fields.clone()])) {
		mut var_links := {
			'self':       {
				'href': rt.call_function('rest_url', [
					rt.call_function('sprintf', [rt.new_string('%s/%s/%s'), this.namespace, this.rest_base,
						rt.call_method(var_ability_mutated, 'get_name', []rt.PhpVal{})]),
				])
			}
			'collection': {
				'href': rt.call_function('rest_url', [
					rt.call_function('sprintf',
						[rt.new_string('%s/%s'), this.namespace, this.rest_base]),
				])
			}
		}
		var_links['wp:action-run'] = rt.create_array([
			rt.ArrayItem{ key: 'href', val: rt.call_function('rest_url', [
				rt.call_function('sprintf', [rt.new_string('%s/%s/%s/run'), this.namespace, this.rest_base,
					rt.call_method(var_ability_mutated, 'get_name', []rt.PhpVal{})]),
			]) },
		])
		rt.call_method(var_response, 'add_links', [
			rt.create_array_from_native_map(var_links),
		])
	}
	return var_response.clone()
}

fn (mut this Class_WP_REST_Abilities_V1_List_Controller) get_item_schema() rt.PhpVal {
	mut var_schema := rt.create_array([
		rt.ArrayItem{ key: '$schema', val: 'http://json-schema.org/draft-04/schema#' },
		rt.ArrayItem{ key: 'title', val: 'ability' },
		rt.ArrayItem{ key: 'type', val: 'object' },
		rt.ArrayItem{ key: 'properties', val: rt.create_array([
			rt.ArrayItem{ key: 'name', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Unique identifier for the ability.'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
					rt.ArrayItem{ key: none, val: 'embed' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
			]) },
			rt.ArrayItem{ key: 'label', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Display label for the ability.'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
					rt.ArrayItem{ key: none, val: 'embed' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
			]) },
			rt.ArrayItem{ key: 'description', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Description of the ability.'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
			]) },
			rt.ArrayItem{ key: 'category', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Ability category this ability belongs to.'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
					rt.ArrayItem{ key: none, val: 'embed' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
			]) },
			rt.ArrayItem{ key: 'input_schema', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('JSON Schema for the ability input.'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'object' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
			]) },
			rt.ArrayItem{ key: 'output_schema', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('JSON Schema for the ability output.'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'object' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
			]) },
			rt.ArrayItem{ key: 'meta', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Meta information about the ability.'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'object' },
				rt.ArrayItem{ key: 'properties', val: rt.create_array([
					rt.ArrayItem{ key: 'annotations', val: rt.create_array([
						rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
							rt.new_string('Annotations for the ability.'),
						]) },
						rt.ArrayItem{ key: 'type', val: rt.create_array([
							rt.ArrayItem{ key: none, val: 'boolean' },
							rt.ArrayItem{ key: none, val: 'null' },
						]) },
						rt.ArrayItem{ key: 'default', val: rt.new_null() },
					]) },
				]) },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
			]) },
		]) },
	])
	return this.add_additional_fields_schema(var_schema.clone())
}

fn (mut this Class_WP_REST_Abilities_V1_List_Controller) get_collection_params() rt.PhpVal {
	return rt.create_array([
		rt.ArrayItem{ key: 'context', val: this.get_context_param(rt.create_array([
			rt.ArrayItem{ key: 'default', val: 'view' },
		])) },
		rt.ArrayItem{ key: 'page', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Current page of the collection.'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'integer' },
			rt.ArrayItem{ key: 'default', val: 1 },
			rt.ArrayItem{ key: 'minimum', val: 1 },
		]) },
		rt.ArrayItem{ key: 'per_page', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Maximum number of items to be returned in result set.'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'integer' },
			rt.ArrayItem{ key: 'default', val: 50 },
			rt.ArrayItem{ key: 'minimum', val: 1 },
			rt.ArrayItem{ key: 'maximum', val: 100 },
		]) },
		rt.ArrayItem{ key: 'category', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Limit results to abilities in specific ability category.'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'string' },
			rt.ArrayItem{ key: 'sanitize_callback', val: 'sanitize_key' },
			rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' },
		]) },
	])
}

struct Class_WP_REST_Controller {
	rt.PhpObjectBase
}

struct Class_WP_REST_Response {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

fn create_wp_rest_abilities_v1_list_controller(_args ...rt.PhpVal) &Class_WP_REST_Abilities_V1_List_Controller {
	mut obj := &Class_WP_REST_Abilities_V1_List_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
		namespace:     rt.new_string('wp-abilities/v1')
		rest_base:     rt.new_string('abilities')
	}
	return obj
}

fn create_wp_rest_controller(_args ...rt.PhpVal) &Class_WP_REST_Controller {
	mut obj := &Class_WP_REST_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_rest_response(_args ...rt.PhpVal) &Class_WP_REST_Response {
	mut obj := &Class_WP_REST_Response{
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

fn (mut this Class_WP_REST_Abilities_V1_List_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'register_routes' {
			this.register_routes()
			return rt.new_null()
		}
		'get_items' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_items(dispatch_arg_0)
		}
		'get_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_item(dispatch_arg_0)
		}
		'get_items_permissions_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_items_permissions_check(dispatch_arg_0)
		}
		'get_item_permissions_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_item_permissions_check(dispatch_arg_0)
		}
		'normalize_schema_empty_object_defaults' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.normalize_schema_empty_object_defaults(mut dispatch_arg_0)
		}
		'strip_internal_schema_keywords' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.strip_internal_schema_keywords(mut dispatch_arg_0)
		}
		'prepare_item_for_response' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.prepare_item_for_response(dispatch_arg_0, dispatch_arg_1)
		}
		'get_item_schema' {
			return this.get_item_schema()
		}
		'get_collection_params' {
			return this.get_collection_params()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WP_REST_Abilities_V1_List_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'namespace' { return this.namespace }
		'rest_base' { return this.rest_base }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_REST_Abilities_V1_List_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'namespace' {
			this.namespace = val
			return true
		}
		'rest_base' {
			this.rest_base = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_WP_REST_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_REST_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_REST_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WP_REST_Response) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_REST_Response) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_REST_Response) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn main() {
	defer {
		rt.shutdown()
	}
}
