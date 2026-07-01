import rt

pub fn Class_WC_SmoothGenerator_Generator_OrderAttribution.campaign_probability() i64 {
	return 15
}
struct Class_WC_SmoothGenerator_Generator_OrderAttribution {
	rt.PhpObjectBase
}

fn Class_WC_SmoothGenerator_Generator_OrderAttribution.add_order_attribution_meta(var_order rt.PhpVal, var_assoc_args rt.PhpVal)  {
	if var_assoc_args.array_isset(rt.new_string('skip-order-attribution')) {
		return rt.new_null()
	}
	mut var_order_products := rt.call_method(var_order, 'get_items', []rt.PhpVal{})
	mut var_device_type := Class_WC_SmoothGenerator_Generator_OrderAttribution.get_random_device_type()
	mut var_source := rt.new_string(rt.new_string('woocommerce.com'))
	mut var_source_type := Class_WC_SmoothGenerator_Generator_OrderAttribution.get_source_type()
	mut var_origin := Class_WC_SmoothGenerator_Generator_OrderAttribution.get_origin((var_source_type).str(), (var_source).str())
	mut var_product_url := if !rt.is_true(var_order_products) { rt.new_string('') } else { rt.call_function('get_permalink', [rt.call_method(var_order_products.array_get(rt.call_function('array_rand', [var_order_products.dup()])), 'get_id', []rt.PhpVal{})]) }
	mut var_utm_content := rt.create_array([rt.ArrayItem{ key: none, val: '/' }, rt.ArrayItem{ key: none, val: 'campaign_a' }, rt.ArrayItem{ key: none, val: 'campaign_b' }])
	var_utm_content = var_utm_content.array_get(rt.call_function('array_rand', [var_utm_content.dup()]))
	mut var_meta := rt.new_array()
	if rt.is_true(rt.call_function('in_array', [var_source_type.dup(), rt.create_array([rt.ArrayItem{ key: none, val: 'admin' }, rt.ArrayItem{ key: none, val: 'mobile_app' }, rt.ArrayItem{ key: none, val: 'unknown' }]), rt.new_bool(true)])) {
		var_meta = rt.create_array([rt.ArrayItem{ key: '_wc_order_attribution_source_type', val: var_source_type }])
	} else {
		var_meta = rt.create_array([rt.ArrayItem{ key: '_wc_order_attribution_origin', val: var_origin }, rt.ArrayItem{ key: '_wc_order_attribution_device_type', val: var_device_type }, rt.ArrayItem{ key: '_wc_order_attribution_user_agent', val: Class_WC_SmoothGenerator_Generator_OrderAttribution.get_random_user_agent_for_device(var_device_type.dup()) }, rt.ArrayItem{ key: '_wc_order_attribution_session_count', val: rt.call_function('wp_rand', [rt.new_int(1), rt.new_int(10)]) }, rt.ArrayItem{ key: '_wc_order_attribution_session_pages', val: rt.call_function('wp_rand', [rt.new_int(1), rt.new_int(10)]) }, rt.ArrayItem{ key: '_wc_order_attribution_session_start_time', val: Class_WC_SmoothGenerator_Generator_OrderAttribution.get_random_session_start_time(var_order.dup()) }, rt.ArrayItem{ key: '_wc_order_attribution_session_entry', val: var_product_url }, rt.ArrayItem{ key: '_wc_order_attribution_utm_content', val: var_utm_content }, rt.ArrayItem{ key: '_wc_order_attribution_utm_source', val: Class_WC_SmoothGenerator_Generator_OrderAttribution.get_source(var_source_type.dup()) }, rt.ArrayItem{ key: '_wc_order_attribution_referrer', val: Class_WC_SmoothGenerator_Generator_OrderAttribution.get_referrer((var_source_type).str()) }, rt.ArrayItem{ key: '_wc_order_attribution_source_type', val: var_source_type }])
		if rt.is_true(rt.less_equal(rt.call_function('wp_rand', [rt.new_int(1), rt.new_int(100)]), Class_WC_SmoothGenerator_Generator_WC_SmoothGenerator_Generator_OrderAttribution.campaign_probability())) {
			mut var_campaign_data := Class_WC_SmoothGenerator_Generator_OrderAttribution.get_campaign_data()
			var_meta = rt.call_function('array_merge', [var_meta.dup(), var_campaign_data.dup()])
		}
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_source_type.dup(), rt.create_array([rt.ArrayItem{ key: none, val: 'typein' }, rt.ArrayItem{ key: none, val: 'admin' }, rt.ArrayItem{ key: none, val: 'mobile_app' }, rt.ArrayItem{ key: none, val: 'unknown' }]), rt.new_bool(true)]))))) {
		var_meta.array_set('_wc_order_attribution_utm_medium', Class_WC_SmoothGenerator_Generator_OrderAttribution.get_random_utm_medium())
	}
	{
		mut iter_1 := var_meta.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_value := item_1.val
			mut var_key := item_1.key
			rt.call_method(var_order, 'add_meta_data', [var_key.dup(), var_value.dup()])
		}
	}
}

fn Class_WC_SmoothGenerator_Generator_OrderAttribution.get_referrer(source_type string)  {
	mut source_type_mutated := source_type
	mut switch_val_1 := rt.new_string(source_type_mutated)
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('utm'))) {
		mut var_utm := rt.create_array([rt.ArrayItem{ key: none, val: 'https://woocommerce.com/' }, rt.ArrayItem{ key: none, val: 'https://twitter.com' }])
		return var_utm.array_get(rt.call_function('array_rand', [var_utm.dup()]))
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('organic'))) {
		mut var_organic := rt.create_array([rt.ArrayItem{ key: none, val: 'https://google.com' }, rt.ArrayItem{ key: none, val: 'https://bing.com' }])
		return var_organic.array_get(rt.call_function('array_rand', [var_organic.dup()]))
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('referral'))) {
		mut var_refferal := rt.create_array([rt.ArrayItem{ key: none, val: 'https://woocommerce.com/' }, rt.ArrayItem{ key: none, val: 'https://facebook.com' }, rt.ArrayItem{ key: none, val: 'https://twitter.com' }, rt.ArrayItem{ key: none, val: 'https://chatgpt.com' }, rt.ArrayItem{ key: none, val: 'https://claude.ai' }])
		return var_refferal.array_get(rt.call_function('array_rand', [var_refferal.dup()]))
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('typein'))) {
		return rt.new_string('')
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('admin'))) {
		return rt.new_string('')
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('mobile_app'))) {
		return rt.new_string('')
	} else {
		return rt.new_string('')
	}
}

fn Class_WC_SmoothGenerator_Generator_OrderAttribution.get_random_utm_medium() rt.PhpVal {
	mut var_utm_mediums := rt.create_array([rt.ArrayItem{ key: none, val: 'referral' }, rt.ArrayItem{ key: none, val: 'cpc' }, rt.ArrayItem{ key: none, val: 'email' }, rt.ArrayItem{ key: none, val: 'social' }, rt.ArrayItem{ key: none, val: 'organic' }, rt.ArrayItem{ key: none, val: 'unknown' }])
	return var_utm_mediums.array_get(rt.call_function('array_rand', [var_utm_mediums.dup()]))
}

fn Class_WC_SmoothGenerator_Generator_OrderAttribution.get_origin(source_type string, source string)  {
	mut source_type_mutated := source_type
	mut source_mutated := source
	mut switch_val_2 := rt.new_string(source_type_mutated)
	if rt.is_true(rt.equal(switch_val_2, rt.new_string('utm'))) {
		return rt.new_string('Source: ' + source_mutated)
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('organic'))) {
		return rt.new_string('Organic: ' + source_mutated)
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('referral'))) {
		return rt.new_string('Referral: ' + source_mutated)
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('typein'))) {
		return rt.new_string('Direct')
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('admin'))) {
		return rt.new_string('Web admin')
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('mobile_app'))) {
		return rt.new_string('Mobile app')
	} else {
		return rt.new_string('Unknown')
	}
}

fn Class_WC_SmoothGenerator_Generator_OrderAttribution.get_source_type() rt.PhpVal {
	mut var_source_types := rt.create_array([rt.ArrayItem{ key: none, val: 'typein' }, rt.ArrayItem{ key: none, val: 'organic' }, rt.ArrayItem{ key: none, val: 'referral' }, rt.ArrayItem{ key: none, val: 'utm' }, rt.ArrayItem{ key: none, val: 'admin' }, rt.ArrayItem{ key: none, val: 'mobile_app' }, rt.ArrayItem{ key: none, val: 'unknown' }])
	return var_source_types.array_get(rt.call_function('array_rand', [var_source_types.dup()]))
}

fn Class_WC_SmoothGenerator_Generator_OrderAttribution.get_source(var_source_type rt.PhpVal)  {
	mut var_source_type_mutated := var_source_type
	mut switch_val_3 := var_source_type_mutated
	if rt.is_true(rt.equal(switch_val_3, rt.new_string('typein'))) {
		return rt.new_string('(direct)')
	} else if rt.is_true(rt.equal(switch_val_3, rt.new_string('organic'))) {
		mut var_organic := rt.create_array([rt.ArrayItem{ key: none, val: 'google' }, rt.ArrayItem{ key: none, val: 'bing' }, rt.ArrayItem{ key: none, val: 'yahoo' }])
		return var_organic.array_get(rt.call_function('array_rand', [var_organic.dup()]))
	} else if rt.is_true(rt.equal(switch_val_3, rt.new_string('referral'))) {
		mut var_refferal := rt.create_array([rt.ArrayItem{ key: none, val: 'woocommerce.com' }, rt.ArrayItem{ key: none, val: 'facebook.com' }, rt.ArrayItem{ key: none, val: 'twitter.com' }, rt.ArrayItem{ key: none, val: 'chatgpt.com' }, rt.ArrayItem{ key: none, val: 'claude.ai' }])
		return var_refferal.array_get(rt.call_function('array_rand', [var_refferal.dup()]))
	} else if rt.is_true(rt.equal(switch_val_3, rt.new_string('social'))) {
		mut var_social := rt.create_array([rt.ArrayItem{ key: none, val: 'facebook.com' }, rt.ArrayItem{ key: none, val: 'twitter.com' }, rt.ArrayItem{ key: none, val: 'instagram.com' }, rt.ArrayItem{ key: none, val: 'pinterest.com' }])
		return var_social.array_get(rt.call_function('array_rand', [var_social.dup()]))
	} else if rt.is_true(rt.equal(switch_val_3, rt.new_string('utm'))) {
		mut var_utm := rt.create_array([rt.ArrayItem{ key: none, val: 'mailchimp' }, rt.ArrayItem{ key: none, val: 'google' }, rt.ArrayItem{ key: none, val: 'newsletter' }])
		return var_utm.array_get(rt.call_function('array_rand', [var_utm.dup()]))
	} else {
		return rt.new_string('Unknown')
	}
}

fn Class_WC_SmoothGenerator_Generator_OrderAttribution.get_random_device_type() string {
	mut var_randomNumber := rt.call_function('wp_rand', [rt.new_int(1), rt.new_int(100)])
	if rt.is_true(rt.less_equal(var_randomNumber, rt.new_int(50))) {
		return 'Mobile'
	} else if rt.is_true(rt.less_equal(var_randomNumber, rt.new_int(85))) {
		return 'Desktop'
	} else {
		return 'Tablet'
	}
	return ''
}

fn Class_WC_SmoothGenerator_Generator_OrderAttribution.get_random_user_agent_for_device(var_device_type rt.PhpVal)  {
	mut var_device_type_mutated := var_device_type
	mut switch_val_4 := var_device_type_mutated
	if rt.is_true(rt.equal(switch_val_4, rt.new_string('Mobile'))) {
		return Class_WC_SmoothGenerator_Generator_OrderAttribution.get_random_mobile_user_agent()
	} else if rt.is_true(rt.equal(switch_val_4, rt.new_string('Tablet'))) {
		return Class_WC_SmoothGenerator_Generator_OrderAttribution.get_random_tablet_user_agent()
	} else if rt.is_true(rt.equal(switch_val_4, rt.new_string('Desktop'))) {
		return Class_WC_SmoothGenerator_Generator_OrderAttribution.get_random_desktop_user_agent()
	} else {
		return rt.new_string('')
	}
}

fn Class_WC_SmoothGenerator_Generator_OrderAttribution.get_random_mobile_user_agent() rt.PhpVal {
	mut var_user_agents := rt.create_array([rt.ArrayItem{ key: none, val: 'Mozilla/5.0 (iPhone; CPU iPhone OS 16_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/16.5 Mobile/15E148 Safari/604.1' }, rt.ArrayItem{ key: none, val: 'Mozilla/5.0 (iPhone; CPU iPhone OS 16_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) CriOS/114.0.5735.99 Mobile/15E148 Safari/604.1' }, rt.ArrayItem{ key: none, val: 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.0.0 Mobile Safari/537.36' }, rt.ArrayItem{ key: none, val: 'Mozilla/5.0 (Linux; Android 13; SAMSUNG SM-S918B) AppleWebKit/537.36 (KHTML, like Gecko) SamsungBrowser/21.0 Chrome/110.0.5481.154 Mobile Safari/537.36' }])
	return var_user_agents.array_get(rt.call_function('array_rand', [var_user_agents.dup()]))
}

fn Class_WC_SmoothGenerator_Generator_OrderAttribution.get_random_tablet_user_agent() rt.PhpVal {
	mut var_user_agents := rt.create_array([rt.ArrayItem{ key: none, val: 'Mozilla/5.0 (iPad; CPU OS 16_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) CriOS/114.0.5735.124 Mobile/15E148 Safari/604.1' }, rt.ArrayItem{ key: none, val: 'Mozilla/5.0 (Linux; Android 12; SM-X906C Build/QP1A.190711.020; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/80.0.3987.119 Mobile Safari/537.36' }])
	return var_user_agents.array_get(rt.call_function('array_rand', [var_user_agents.dup()]))
}

fn Class_WC_SmoothGenerator_Generator_OrderAttribution.get_random_desktop_user_agent() rt.PhpVal {
	mut var_user_agents := rt.create_array([rt.ArrayItem{ key: none, val: 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/42.0.2311.135 Safari/537.36 Edge/12.246' }, rt.ArrayItem{ key: none, val: 'Mozilla/5.0 (X11; CrOS x86_64 8172.45.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/51.0.2704.64 Safari/537.36' }, rt.ArrayItem{ key: none, val: 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_2) AppleWebKit/601.3.9 (KHTML, like Gecko) Version/9.0.2 Safari/601.3.9' }])
	return var_user_agents.array_get(rt.call_function('array_rand', [var_user_agents.dup()]))
}

fn Class_WC_SmoothGenerator_Generator_OrderAttribution.get_random_session_start_time(var_order rt.PhpVal) rt.PhpVal {
	mut var_order_created_date := // unsupported expression: Expr_Clone
	mut var_random_interval := create_wc_smoothgenerator_generator_dateinterval('PT' + (// unsupported expression: Expr_Cast_String).str() + 'M')
	rt.call_method(var_order_created_date, 'sub', [var_random_interval])
	return rt.call_method(var_order_created_date, 'format', [rt.new_string('Y-m-d H:i:s')])
}

fn Class_WC_SmoothGenerator_Generator_OrderAttribution.get_campaign_data()  {
	mut var_campaign_type := Class_WC_SmoothGenerator_Generator_OrderAttribution.get_campaign_type()
	mut switch_val_5 := var_campaign_type
	if rt.is_true(rt.equal(switch_val_5, rt.new_string('seasonal'))) {
		return Class_WC_SmoothGenerator_Generator_OrderAttribution.get_seasonal_campaign_data()
	} else if rt.is_true(rt.equal(switch_val_5, rt.new_string('promotional'))) {
		return Class_WC_SmoothGenerator_Generator_OrderAttribution.get_promotional_campaign_data()
	} else if rt.is_true(rt.equal(switch_val_5, rt.new_string('product'))) {
		return Class_WC_SmoothGenerator_Generator_OrderAttribution.get_product_campaign_data()
	} else {
		return Class_WC_SmoothGenerator_Generator_OrderAttribution.get_general_campaign_data()
	}
}

fn Class_WC_SmoothGenerator_Generator_OrderAttribution.get_campaign_type() string {
	mut var_random := rt.call_function('wp_rand', [rt.new_int(1), rt.new_int(100)])
	if rt.is_true(rt.less_equal(var_random, rt.new_int(40))) {
		return 'seasonal'
		// unsupported statement: Stmt_Nop
	} else if rt.is_true(rt.less_equal(var_random, rt.new_int(70))) {
		return 'promotional'
		// unsupported statement: Stmt_Nop
	} else if rt.is_true(rt.less_equal(var_random, rt.new_int(90))) {
		return 'product'
		// unsupported statement: Stmt_Nop
	} else {
		return 'general'
		// unsupported statement: Stmt_Nop
	}
	return ''
}

fn Class_WC_SmoothGenerator_Generator_OrderAttribution.get_seasonal_campaign_data() rt.PhpVal {
	mut var_campaigns := rt.create_array([rt.ArrayItem{ key: 'summer_sale', val: rt.create_array([rt.ArrayItem{ key: 'content', val: 'summer_deals' }, rt.ArrayItem{ key: 'term', val: 'seasonal_discount' }]) }, rt.ArrayItem{ key: 'black_friday', val: rt.create_array([rt.ArrayItem{ key: 'content', val: 'bf_deals' }, rt.ArrayItem{ key: 'term', val: 'black_friday_sale' }]) }, rt.ArrayItem{ key: 'holiday_special', val: rt.create_array([rt.ArrayItem{ key: 'content', val: 'holiday_deals' }, rt.ArrayItem{ key: 'term', val: 'christmas_sale' }]) }])
	mut var_campaign_name := rt.call_function('array_rand', [var_campaigns.dup()])
	mut var_campaign := var_campaigns.array_get(var_campaign_name)
	return rt.create_array([rt.ArrayItem{ key: '_wc_order_attribution_utm_campaign', val: var_campaign_name }, rt.ArrayItem{ key: '_wc_order_attribution_utm_content', val: var_campaign.array_get('content') }, rt.ArrayItem{ key: '_wc_order_attribution_utm_term', val: var_campaign.array_get('term') }])
}

fn Class_WC_SmoothGenerator_Generator_OrderAttribution.get_promotional_campaign_data() rt.PhpVal {
	mut var_campaigns := rt.create_array([rt.ArrayItem{ key: 'flash_sale', val: rt.create_array([rt.ArrayItem{ key: 'content', val: '24hr_sale' }, rt.ArrayItem{ key: 'term', val: 'limited_time' }]) }, rt.ArrayItem{ key: 'membership_promo', val: rt.create_array([rt.ArrayItem{ key: 'content', val: 'member_exclusive' }, rt.ArrayItem{ key: 'term', val: 'join_now' }]) }])
	mut var_campaign_name := rt.call_function('array_rand', [var_campaigns.dup()])
	mut var_campaign := var_campaigns.array_get(var_campaign_name)
	return rt.create_array([rt.ArrayItem{ key: '_wc_order_attribution_utm_campaign', val: var_campaign_name }, rt.ArrayItem{ key: '_wc_order_attribution_utm_content', val: var_campaign.array_get('content') }, rt.ArrayItem{ key: '_wc_order_attribution_utm_term', val: var_campaign.array_get('term') }])
}

fn Class_WC_SmoothGenerator_Generator_OrderAttribution.get_product_campaign_data() rt.PhpVal {
	mut var_campaigns := rt.create_array([rt.ArrayItem{ key: 'new_product_launch', val: rt.create_array([rt.ArrayItem{ key: 'content', val: 'product_launch' }, rt.ArrayItem{ key: 'term', val: 'new_arrival' }]) }, rt.ArrayItem{ key: 'spring_collection', val: rt.create_array([rt.ArrayItem{ key: 'content', val: 'spring' }, rt.ArrayItem{ key: 'term', val: 'new_collection' }]) }])
	mut var_campaign_name := rt.call_function('array_rand', [var_campaigns.dup()])
	mut var_campaign := .array_get()
	return rt.create_array([rt.ArrayItem{ key: , val:  }, rt.ArrayItem{ key: , val:  }, rt.ArrayItem{ key: , val:  }])
}

fn Class_WC_SmoothGenerator_Generator_OrderAttribution.get_general_campaign_data() rt.PhpVal {
	
}

struct Class_WC_SmoothGenerator_Generator_DateInterval {
	rt.PhpObjectBase
}

fn create_wc_smoothgenerator_generator_orderattribution() &Class_WC_SmoothGenerator_Generator_OrderAttribution {
	mut obj := &Class_WC_SmoothGenerator_Generator_OrderAttribution{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_smoothgenerator_generator_dateinterval() &Class_WC_SmoothGenerator_Generator_DateInterval {
	mut obj := &Class_WC_SmoothGenerator_Generator_DateInterval{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_SmoothGenerator_Generator_OrderAttribution) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'add_order_attribution_meta' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			Class_WC_SmoothGenerator_Generator_OrderAttribution.add_order_attribution_meta(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'get_referrer' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			Class_WC_SmoothGenerator_Generator_OrderAttribution.get_referrer(dispatch_arg_0)
			return rt.new_null()
		}
		'get_random_utm_medium' {
			return Class_WC_SmoothGenerator_Generator_OrderAttribution.get_random_utm_medium()
		}
		'get_origin' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			Class_WC_SmoothGenerator_Generator_OrderAttribution.get_origin(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'get_source_type' {
			return Class_WC_SmoothGenerator_Generator_OrderAttribution.get_source_type()
		}
		'get_source' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			Class_WC_SmoothGenerator_Generator_OrderAttribution.get_source(dispatch_arg_0)
			return rt.new_null()
		}
		'get_random_device_type' {
			return rt.new_string(Class_WC_SmoothGenerator_Generator_OrderAttribution.get_random_device_type())
		}
		'get_random_user_agent_for_device' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			Class_WC_SmoothGenerator_Generator_OrderAttribution.get_random_user_agent_for_device(dispatch_arg_0)
			return rt.new_null()
		}
		'get_random_mobile_user_agent' {
			return Class_WC_SmoothGenerator_Generator_OrderAttribution.get_random_mobile_user_agent()
		}
		'get_random_tablet_user_agent' {
			return Class_WC_SmoothGenerator_Generator_OrderAttribution.get_random_tablet_user_agent()
		}
		'get_random_desktop_user_agent' {
			return Class_WC_SmoothGenerator_Generator_OrderAttribution.get_random_desktop_user_agent()
		}
		'get_random_session_start_time' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_SmoothGenerator_Generator_OrderAttribution.get_random_session_start_time(dispatch_arg_0)
		}
		'get_campaign_data' {
			Class_WC_SmoothGenerator_Generator_OrderAttribution.get_campaign_data()
			return rt.new_null()
		}
		'get_campaign_type' {
			return rt.new_string(Class_WC_SmoothGenerator_Generator_OrderAttribution.get_campaign_type())
		}
		'get_seasonal_campaign_data' {
			return Class_WC_SmoothGenerator_Generator_OrderAttribution.get_seasonal_campaign_data()
		}
		'get_promotional_campaign_data' {
			return Class_WC_SmoothGenerator_Generator_OrderAttribution.get_promotional_campaign_data()
		}
		'get_product_campaign_data' {
			return Class_WC_SmoothGenerator_Generator_OrderAttribution.get_product_campaign_data()
		}
		'get_general_campaign_data' {
			return Class_WC_SmoothGenerator_Generator_OrderAttribution.get_general_campaign_data()
		}
		else { return none }
	}
}

fn (this &Class_WC_SmoothGenerator_Generator_OrderAttribution) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_SmoothGenerator_Generator_OrderAttribution) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_SmoothGenerator_Generator_DateInterval) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_SmoothGenerator_Generator_DateInterval) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_SmoothGenerator_Generator_DateInterval) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_wc_smooth_generator_includes_generator_orderattribution_php() {
}
