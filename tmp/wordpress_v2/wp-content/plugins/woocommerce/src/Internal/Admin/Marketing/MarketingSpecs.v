import rt

pub fn Class_Automattic_WooCommerce_Internal_Admin_Marketing_MarketingSpecs.knowledge_base_transient() string {
	return 'wc_marketing_knowledge_base'
}
struct Class_Automattic_WooCommerce_Internal_Admin_Marketing_MarketingSpecs {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Marketing_MarketingSpecs) get_knowledge_base_posts(mut var_topic Class_Automattic_WooCommerce_Internal_Admin_Marketing_?string) rt.PhpVal {
	mut var_topic_mutated := var_topic
	if !rt.is_true(var_topic_mutated) {
	var_topic_mutated = rt.new_string('marketing')
	}
	mut var_kb_transient := rt.new_string((Class_Automattic_WooCommerce_Internal_Admin_Marketing_Automattic_WooCommerce_Internal_Admin_Marketing_MarketingSpecs.knowledge_base_transient()).str() + '_' + var_topic_mutated.to_string().to_lower())
	mut var_posts := rt.call_function('get_transient', [var_kb_transient.clone()])
	if rt.is_true(rt.identical(rt.new_bool(false), var_posts)) {
		mut var_request_url := rt.call_function('add_query_arg', [rt.create_array([rt.ArrayItem{ key: 'page', val: 1 }, rt.ArrayItem{ key: 'per_page', val: 8 }, rt.ArrayItem{ key: '_embed', val: 1 }]), rt.new_string('https://woocommerce.com/wp-json/wccom/marketing-knowledgebase/v1/posts/' + (var_topic_mutated).str())])
		mut var_request := rt.call_function('wp_remote_get', [var_request_url.clone(), rt.create_array([rt.ArrayItem{ key: 'user-agent', val: 'WooCommerce/' + (rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'version')).str() + '; ' + (rt.call_function('get_bloginfo', [rt.new_string('url')])).str() }])])
		var_posts = rt.new_array()
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_request.clone()]))))) && rt.is_true(rt.identical(rt.new_int(200), var_request.array_get(rt.new_string('response')).array_get(rt.new_string('code')))) {
			mut var_raw_posts := rt.call_function('json_decode', [var_request.array_get(rt.new_string('body')), rt.new_bool(true)])
			mut iter_1 := var_raw_posts.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_raw_post := item_1.val
				mut var_post := rt.create_array([rt.ArrayItem{ key: 'title', val: rt.call_function('html_entity_decode', [var_raw_post.array_get(rt.new_string('title')).array_get(rt.new_string('rendered'))]) }, rt.ArrayItem{ key: 'date', val: var_raw_post.array_get(rt.new_string('date_gmt')) }, rt.ArrayItem{ key: 'link', val: var_raw_post.array_get(rt.new_string('link')) }, rt.ArrayItem{ key: 'author_name', val: if var_raw_post.array_isset(rt.new_string('author_name')) { rt.call_function('html_entity_decode', [var_raw_post.array_get(rt.new_string('author_name'))]) } else { rt.new_string('') } }, rt.ArrayItem{ key: 'author_avatar', val: if var_raw_post.array_isset(rt.new_string('author_avatar_url')) { var_raw_post.array_get(rt.new_string('author_avatar_url')) } else { rt.new_string('') } }])
				mut var_featured_media := if var_raw_post.array_get(rt.new_string('_embedded')).array_isset(rt.new_string('wp:featuredmedia')) && var_raw_post.array_get(rt.new_string('_embedded')).array_get(rt.new_string('wp:featuredmedia')).is_array() { var_raw_post.array_get(rt.new_string('_embedded')).array_get(rt.new_string('wp:featuredmedia')) } else { rt.new_array() }
				if var_featured_media.clone().array_count() > 0 {
					mut var_image := rt.call_function('current', [var_featured_media.clone()])
					var_post.array_set('image', rt.call_function('add_query_arg', [rt.create_array([rt.ArrayItem{ key: 'resize', val: '650,340' }, rt.ArrayItem{ key: 'crop', val: 1 }]), var_image.array_get(rt.new_string('source_url'))]))
				}
				var_posts.array_push(var_post.clone())
			}
		}
		rt.call_function('set_transient', [var_kb_transient.clone(), var_posts.clone(), if !rt.is_true(var_posts) { rt.new_int(900) } else { rt.get_constant('DAY_IN_SECONDS') }])
	}
	return var_posts.clone()
}

fn create_automattic_woocommerce_internal_admin_marketing_marketingspecs(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_Marketing_MarketingSpecs {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Marketing_MarketingSpecs{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Marketing_MarketingSpecs) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_knowledge_base_posts' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Marketing_?string](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.get_knowledge_base_posts(mut dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Marketing_MarketingSpecs) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Marketing_MarketingSpecs) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}



fn main() {
	defer {
		rt.shutdown()
	}

}
