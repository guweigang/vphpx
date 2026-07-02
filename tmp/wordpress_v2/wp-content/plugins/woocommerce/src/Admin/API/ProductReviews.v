import rt

struct Class_Automattic_WooCommerce_Admin_API_ProductReviews {
	rt.PhpObjectBase
pub mut:
	namespace rt.PhpVal = rt.new_string('wc-analytics')
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_ProductReviews) prepare_links(var_review rt.PhpVal) rt.PhpVal {
	mut var_links := rt.create_array([
		rt.ArrayItem{ key: 'self', val: rt.create_array([
			rt.ArrayItem{ key: 'href', val: rt.call_function('rest_url', [
				rt.call_function('sprintf', [rt.new_string('/%s/%s/%d'), this.namespace,
					rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_ProductReviews', [
						'Automattic_WooCommerce_Admin_API_WC_REST_Product_Reviews_Controller',
					], &this), 'rest_base'),
					rt.get_property(var_review, 'comment_ID')]),
			]) },
		]) },
		rt.ArrayItem{ key: 'collection', val: rt.create_array([
			rt.ArrayItem{ key: 'href', val: rt.call_function('rest_url', [
				rt.call_function('sprintf', [rt.new_string('/%s/%s'), this.namespace,
					rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_ProductReviews', [
						'Automattic_WooCommerce_Admin_API_WC_REST_Product_Reviews_Controller',
					], &this), 'rest_base')]),
			]) },
		]) },
	])
	if rt.is_true(rt.new_bool(0 != rt.new_int((rt.get_property(var_review, 'comment_post_ID')).to_i64()))) {
		var_links.array_set('up', rt.create_array([
			rt.ArrayItem{ key: 'href', val: rt.call_function('rest_url', [
				rt.call_function('sprintf', [rt.new_string('/%s/products/%d'), this.namespace,
					rt.get_property(var_review, 'comment_post_ID')]),
			]) },
			rt.ArrayItem{ key: 'embeddable', val: true },
		]))
	}
	if rt.is_true(rt.new_bool(0 != rt.new_int((rt.get_property(var_review, 'user_id')).to_i64()))) {
		var_links.array_set('reviewer', rt.create_array([
			rt.ArrayItem{ key: 'href', val: rt.call_function('rest_url', [
				rt.new_string('wp/v2/users/' + (rt.get_property(var_review, 'user_id')).str()),
			]) },
			rt.ArrayItem{ key: 'embeddable', val: true },
		]))
	}
	return var_links.clone()
}

struct Class_Automattic_WooCommerce_Admin_API_WC_REST_Product_Reviews_Controller {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_api_productreviews(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_API_ProductReviews {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_ProductReviews{
		PhpObjectBase: rt.PhpObjectBase{}
		namespace:     rt.new_string('wc-analytics')
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_wc_rest_product_reviews_controller(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_API_WC_REST_Product_Reviews_Controller {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_WC_REST_Product_Reviews_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_ProductReviews) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'prepare_links' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.prepare_links(dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_API_ProductReviews) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'namespace' { return this.namespace }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_ProductReviews) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'namespace' {
			this.namespace = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_WC_REST_Product_Reviews_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_API_WC_REST_Product_Reviews_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_WC_REST_Product_Reviews_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}
