import rt

pub fn Class_Automattic_WooCommerce_EmailEditor_Engine_Personalizer.tag_name_pattern() string {
	return '[a-zA-Z0-9\\-\\/]+'
}

struct Class_Automattic_WooCommerce_EmailEditor_Engine_Personalizer {
	rt.PhpObjectBase
pub mut:
	tags_registry rt.PhpVal = rt.new_null()
	context       rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Personalizer) construct(mut var_tags_registry Class_Automattic_WooCommerce_EmailEditor_Engine_PersonalizationTags_Personalization_Tags_Registry) {
	this.tags_registry = var_tags_registry
	this.context = rt.new_array()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Personalizer) set_context(mut var_context Class_Automattic_WooCommerce_EmailEditor_Engine_array) {
	this.context = var_context
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Personalizer) get_context() rt.PhpVal {
	return this.context
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Personalizer) personalize_content(content string) string {
	mut var_matches := rt.new_null()
	mut var_content_processor :=
		create_automattic_woocommerce_emaileditor_engine_personalizationtags_html_tag_processor(rt.new_string(content))
	for rt.is_true(var_content_processor.next_token()) {
		if rt.is_true(rt.identical(var_content_processor.get_token_type(),
			rt.new_string('#comment')))
		{
			mut var_modifiable_text := var_content_processor.get_modifiable_text()
			mut var_token := this.parse_token(var_modifiable_text.str())
			mut var_tag := rt.call_method(this.tags_registry, 'get_by_token', [
				var_token.array_get(rt.new_string('token')),
			])
			if rt.is_true(rt.new_bool(!(rt.is_true(var_tag)))) {
				continue
			}
			mut var_value := rt.call_method(var_tag, 'execute_callback', [this.context,
				var_token.array_get(rt.new_string('arguments'))])
			var_content_processor.replace_token(var_value.clone())
		} else if
			rt.is_true(rt.identical(var_content_processor.get_token_type(), rt.new_string('#tag')))
			&& rt.is_true(rt.identical(var_content_processor.get_tag(), rt.new_string('TITLE'))) {
			var_modifiable_text = var_content_processor.get_modifiable_text()
			mut var_title := rt.new_string(this.personalize_content(var_modifiable_text.str()))
			var_content_processor.set_modifiable_text(var_title.clone())
		} else if
			rt.is_true(rt.identical(var_content_processor.get_token_type(), rt.new_string('#tag')))
			&& rt.is_true(rt.identical(var_content_processor.get_tag(), rt.new_string('A')))
			&& rt.is_true(var_content_processor.get_attribute(rt.new_string('data-link-href'))) {
			mut var_href :=
				rt.new_string((var_content_processor.get_attribute(rt.new_string('data-link-href'))).str())
			var_token = this.parse_token(var_href.str())
			var_tag = rt.call_method(this.tags_registry, 'get_by_token', [
				var_token.array_get(rt.new_string('token')),
			])
			if rt.is_true(rt.new_bool(!(rt.is_true(var_tag)))) {
				continue
			}
			var_value = rt.call_method(var_tag, 'execute_callback', [this.context,
				var_token.array_get(rt.new_string('arguments'))])
			var_value = rt.new_string(this.replace_link_href(var_href.str(), (rt.call_method(var_tag,
				'get_token', []rt.PhpVal{})).str(), var_value.str()))
			if rt.is_true(var_value) {
				var_content_processor.set_attribute(rt.new_string('href'), var_value.clone())
				var_content_processor.remove_attribute(rt.new_string('data-link-href'))
				var_content_processor.remove_attribute(rt.new_string('contenteditable'))
			}
		} else if
			rt.is_true(rt.identical(var_content_processor.get_token_type(), rt.new_string('#tag')))
			&& rt.is_true(rt.identical(var_content_processor.get_tag(), rt.new_string('A'))) {
			var_href = var_content_processor.get_attribute(rt.new_string('href'))
			if !(var_href.clone().is_string()) {
				continue
			}
			mut var_decoded_href := rt.call_function('html_entity_decode', [
				rt.call_function('urldecode', [var_href.clone()]),
				rt.get_constant('ENT_QUOTES'),
				rt.new_string('UTF-8'),
			])
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('preg_match', [
				rt.new_string('/\\[' +
					(Class_Automattic_WooCommerce_EmailEditor_Engine_Automattic_WooCommerce_EmailEditor_Engine_Personalizer.tag_name_pattern()).str() + '(?:\\s+[^\\]]+)?\\]/'),
				var_decoded_href.clone(),
				var_matches.clone(),
			])))))
			{
				continue
			}
			var_token = this.parse_token((var_matches.array_get(rt.new_int(0))).str())
			var_tag = rt.call_method(this.tags_registry, 'get_by_token', [
				var_token.array_get(rt.new_string('token')),
			])
			if rt.is_true(rt.new_bool(!(rt.is_true(var_tag)))) {
				continue
			}
			var_value = rt.call_method(var_tag, 'execute_callback', [this.context,
				var_token.array_get(rt.new_string('arguments'))])
			if rt.is_true(var_value) {
				var_content_processor.set_attribute(rt.new_string('href'), var_value.clone())
			}
		}
	}
	var_content_processor.flush_updates()
	return (var_content_processor.get_updated_html()).str()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Personalizer) parse_token(token string) rt.PhpVal {
	mut var_matches := rt.new_null()
	mut var_attribute_matches := rt.new_null()
	mut token_mutated := token
	mut var_result := rt.create_array([rt.ArrayItem{ key: 'token', val: '' },
		rt.ArrayItem{ key: 'arguments', val: rt.new_array() }])
	if rt.is_true(rt.call_function('preg_match', [
		rt.new_string('/^\\[(' +
			(Class_Automattic_WooCommerce_EmailEditor_Engine_Automattic_WooCommerce_EmailEditor_Engine_Personalizer.tag_name_pattern()).str() + ')\\s*(.*?)\\]$/'),
		rt.new_string(token_mutated.trim_space()),
		var_matches.clone(),
	]))
	{
		var_result.array_set('token', rt.concat(rt.concat(rt.new_string('['),
			var_matches.array_get(rt.new_int(1))), rt.new_string(']')))
		mut var_attributes_string := var_matches.array_get(rt.new_int(2))
		if rt.is_true(rt.call_function('preg_match_all', [
			rt.new_string('/(\\w+)=(?:"([^"]*)"|\'([^\']*)\'|([^\\s\\]]+(?:\\s+(?!\\w+=)[^\\s\\]]+)*))/'),
			var_attributes_string.clone(),
			var_attribute_matches.clone(),
			rt.get_constant('PREG_SET_ORDER'),
		]))
		{
			mut iter_1 := var_attribute_matches.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_attribute := item_1.val
				mut var_double_quoted_value := if !(var_attribute.array_get(rt.new_int(2))).is_null() {
					var_attribute.array_get(rt.new_int(2))
				} else {
					rt.new_string('')
				}
				mut var_single_quoted_value := if !(var_attribute.array_get(rt.new_int(3))).is_null() {
					var_attribute.array_get(rt.new_int(3))
				} else {
					rt.new_string('')
				}
				mut var_unquoted_value := if !(var_attribute.array_get(rt.new_int(4))).is_null() {
					var_attribute.array_get(rt.new_int(4))
				} else {
					rt.new_string('')
				}
				if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''),
					var_double_quoted_value))))
				{
					var_result.array_get_mut('arguments').array_set(var_attribute.array_get(rt.new_int(1)),
						var_double_quoted_value.clone())
				} else if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''),
					var_single_quoted_value))))
				{
					var_result.array_get_mut('arguments').array_set(var_attribute.array_get(rt.new_int(1)),
						var_single_quoted_value.clone())
				} else {
					var_result.array_get_mut('arguments').array_set(var_attribute.array_get(rt.new_int(1)),
						var_unquoted_value.clone())
				}
			}
		}
	}
	return var_result.clone()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Personalizer) replace_link_href(content string, token string, replacement string) string {
	mut token_mutated := token
	mut var_escaped_shortcode := rt.call_function('preg_quote', [
		rt.call_function('substr', [rt.new_string(token_mutated).clone(),
			rt.new_int(1), rt.new_int(token_mutated.len - 2)]),
		rt.new_string('/'),
	])
	mut var_pattern := rt.new_string('/\\[' + var_escaped_shortcode.str() + '(?:\\s+[^\\]]+)?\\]/')
	return (rt.call_function('preg_replace', [var_pattern.clone(),
		rt.new_string(replacement), rt.new_string(content)])).str().trim_space()
}

struct Class_Automattic_WooCommerce_EmailEditor_Engine_PersonalizationTags_HTML_Tag_Processor {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_emaileditor_engine_personalizer(arg_0 rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditor_Engine_Personalizer {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Engine_Personalizer{
		PhpObjectBase: rt.PhpObjectBase{}
		tags_registry: rt.new_null()
		context:       rt.new_null()
	}
	obj.construct(arg_0)
	return obj
}

fn create_automattic_woocommerce_emaileditor_engine_personalizationtags_html_tag_processor(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditor_Engine_PersonalizationTags_HTML_Tag_Processor {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Engine_PersonalizationTags_HTML_Tag_Processor{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Personalizer) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_PersonalizationTags_Personalization_Tags_Registry](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.construct(mut dispatch_arg_0)
			return rt.new_null()
		}
		'set_context' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.set_context(mut dispatch_arg_0)
			return rt.new_null()
		}
		'get_context' {
			return this.get_context()
		}
		'personalize_content' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(this.personalize_content(dispatch_arg_0))
		}
		'parse_token' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.parse_token(dispatch_arg_0)
		}
		'replace_link_href' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			return rt.new_string(this.replace_link_href(dispatch_arg_0, dispatch_arg_1,
				dispatch_arg_2))
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Engine_Personalizer) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'tags_registry' { return this.tags_registry }
		'context' { return this.context }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Personalizer) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'tags_registry' {
			this.tags_registry = val
			return true
		}
		'context' {
			this.context = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_PersonalizationTags_HTML_Tag_Processor) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Engine_PersonalizationTags_HTML_Tag_Processor) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_PersonalizationTags_HTML_Tag_Processor) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
