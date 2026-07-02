import rt

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_NoResults {
	rt.PhpObjectBase
pub mut:
	block_name rt.PhpVal = rt.new_string('product-collection-no-results')
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_NoResults) render(var_attributes rt.PhpVal, var_content rt.PhpVal, var_block rt.PhpVal) string {
	mut var_content_mutated := var_content
	var_content_mutated = rt.new_string(var_content_mutated.clone().to_string().trim_space())
	if !rt.is_true(var_content_mutated) {
		return ''
	}
	mut iife_temp_0 := Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_Utils{}
	mut iife_result_0 := iife_temp_0.prepare_and_execute_query(var_block.clone())
	mut var_query := iife_result_0
	if rt.is_true(rt.greater(rt.get_property(var_query, 'post_count'), rt.new_int(0))) {
		return ''
	}
	mut var_updated_html_content :=
		this.modify_anchor_tag_urls(rt.new_string((var_content_mutated.clone().to_string().trim_space()).str()))
	mut var_wrapper_attributes := rt.call_function('get_block_wrapper_attributes', []rt.PhpVal{})
	return (rt.call_function('sprintf', [rt.new_string('<div %1$s>%2$s</div>'),
		var_wrapper_attributes.clone(), var_updated_html_content.clone()])).str()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_NoResults) get_block_type_script(var_key rt.PhpVal) rt.PhpVal {
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_NoResults) get_block_type_style() rt.PhpVal {
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_NoResults) modify_anchor_tag_urls(var_content rt.PhpVal) rt.PhpVal {
	mut var_content_mutated := var_content
	mut var_processor :=
		create_automattic_woocommerce_blocks_blocktypes_productcollection_wp_html_tag_processor(rt.new_string(var_content_mutated.clone().to_string().trim_space()))
	if rt.is_true(var_processor.next_tag(rt.create_array([
		rt.ArrayItem{ key: 'tag_name', val: 'a' },
		rt.ArrayItem{ key: 'class_name', val: 'wc-link-clear-any-filters' },
	])))
	{
		var_processor.set_attribute(rt.new_string('href'), this.get_current_url_without_filters())
	}
	if rt.is_true(var_processor.next_tag(rt.create_array([
		rt.ArrayItem{ key: 'tag_name', val: 'a' },
		rt.ArrayItem{ key: 'class_name', val: 'wc-link-stores-home' },
	])))
	{
		var_processor.set_attribute(rt.new_string('href'), rt.call_function('home_url',
			[]rt.PhpVal{}))
	}
	return var_processor.get_updated_html()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_NoResults) get_current_url_without_filters() rt.PhpVal {
	mut var_query_params := rt.new_null()
	mut var_protocol := rt.new_string((if rt.is_true(rt.call_function('is_ssl', []rt.PhpVal{})) {
		'https'
	} else {
		'http'
	}).str())
	mut var_http_host := if rt.get_superglobal('_SERVER').array_isset(rt.new_string('HTTP_HOST')) { rt.call_function('wp_unslash', [
			rt.get_superglobal('_SERVER').array_get(rt.new_string('HTTP_HOST')),
		]) } else { rt.new_string('') }
	mut var_request_uri := if rt.get_superglobal('_SERVER').array_isset(rt.new_string('REQUEST_URI')) { rt.call_function('wp_unslash', [
			rt.get_superglobal('_SERVER').array_get(rt.new_string('REQUEST_URI')),
		]) } else { rt.new_string('') }
	var_http_host = rt.call_function('sanitize_text_field', [
		var_http_host.clone()])
	var_request_uri = rt.call_function('esc_url_raw', [var_request_uri.clone()])
	mut var_current_url := rt.new_string(var_protocol.str() + '://' + var_http_host.str() +
		var_request_uri.str())
	mut var_parsed_url := rt.call_function('wp_parse_url', [var_current_url.clone()])
	mut var_query_string := if var_parsed_url.array_isset(rt.new_string('query')) {
		var_parsed_url.array_get(rt.new_string('query'))
	} else {
		rt.new_string('')
	}
	rt.call_function('parse_str', [var_query_string.clone(), var_query_params.clone()])
	mut var_params_to_remove := rt.create_array([
		rt.ArrayItem{ key: none, val: 'min_price' },
		rt.ArrayItem{ key: none, val: 'max_price' },
		rt.ArrayItem{ key: none, val: 'rating_filter' },
		rt.ArrayItem{ key: none, val: 'filter_' },
		rt.ArrayItem{ key: none, val: 'query_type_' },
	])
	mut iter_1 := var_query_params.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_value := item_1.val
		mut var_key := item_1.key
		mut iter_2 := var_params_to_remove.iterator()
		for {
			item_2 := iter_2.next() or { break }
			mut var_param := item_2.val
			if rt.is_true(rt.identical(rt.call_function('strpos', [
				var_key.clone(), var_param.clone()]), rt.new_int(0)))
			{
				var_query_params.array_unset(var_key)
				break
			}
		}
	}
	mut var_new_query_string := rt.call_function('http_build_query', [
		var_query_params.clone()])
	mut var_new_url := rt.new_string((var_parsed_url.array_get(rt.new_string('scheme'))).str() +
		'://' + (var_parsed_url.array_get(rt.new_string('host'))).str())
	var_new_url = rt.concat(var_new_url, if var_parsed_url.array_isset(rt.new_string('path')) {
		var_parsed_url.array_get(rt.new_string('path'))
	} else {
		rt.new_string('')
	})
	var_new_url = rt.concat(var_new_url, if rt.is_true(var_new_query_string) {
		'?' + var_new_query_string.str()
	} else {
		''
	})
	return var_new_url.clone()
}

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_Utils {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_WP_HTML_Tag_Processor {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blocks_blocktypes_productcollection_noresults(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_NoResults {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_NoResults{
		PhpObjectBase: rt.PhpObjectBase{}
		block_name:    rt.new_string('product-collection-no-results')
	}
	return obj
}

fn create_automattic_woocommerce_blocks_blocktypes_abstractblock(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_blocktypes_productcollection_utils(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_Utils {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_Utils{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_blocktypes_productcollection_wp_html_tag_processor(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_WP_HTML_Tag_Processor {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_WP_HTML_Tag_Processor{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_NoResults) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'render' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return rt.new_string(this.render(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2))
		}
		'get_block_type_script' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_block_type_script(dispatch_arg_0)
		}
		'get_block_type_style' {
			return this.get_block_type_style()
		}
		'modify_anchor_tag_urls' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.modify_anchor_tag_urls(dispatch_arg_0)
		}
		'get_current_url_without_filters' {
			return this.get_current_url_without_filters()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_NoResults) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'block_name' { return this.block_name }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_NoResults) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'block_name' {
			this.block_name = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_Utils) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_Utils) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_Utils) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_WP_HTML_Tag_Processor) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_WP_HTML_Tag_Processor) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_WP_HTML_Tag_Processor) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
