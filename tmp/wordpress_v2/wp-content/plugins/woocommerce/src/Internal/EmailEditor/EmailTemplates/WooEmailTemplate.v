import rt

pub fn Class_Automattic_WooCommerce_Internal_EmailEditor_EmailTemplates_WooEmailTemplate.template_slug() string {
	return 'wooemailtemplate'
}

struct Class_Automattic_WooCommerce_Internal_EmailEditor_EmailTemplates_WooEmailTemplate {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_EmailTemplates_WooEmailTemplate) get_slug() string {
	return (Class_Automattic_WooCommerce_Internal_EmailEditor_EmailTemplates_Automattic_WooCommerce_Internal_EmailEditor_EmailTemplates_WooEmailTemplate.template_slug()).str()
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_EmailTemplates_WooEmailTemplate) get_title() string {
	return (rt.call_function('__', [rt.new_string('Woo Email Template'),
		rt.new_string('woocommerce')])).str()
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_EmailTemplates_WooEmailTemplate) get_description() string {
	return (rt.call_function('__', [
		rt.new_string('Basic template for WooCommerce transactional emails used in the email editor'),
		rt.new_string('woocommerce'),
	])).str()
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_EmailTemplates_WooEmailTemplate) get_content() string {
	return
		'\n<!-- wp:group {"style":{"spacing":{"padding":{"top":"var:preset|spacing|10","bottom":"var:preset|spacing|10","left":"var:preset|spacing|20","right":"var:preset|spacing|20"}}},"layout":{"type":"constrained"}} -->\n<div class="wp-block-group" style="padding-top:var(--wp--preset--spacing--10);padding-right:var(--wp--preset--spacing--20);padding-bottom:var(--wp--preset--spacing--10);padding-left:var(--wp--preset--spacing--20)">\n' +
		this.get_site_logo_or_title() +
		'\n\n<!-- wp:group {"layout":{"type":"constrained"}} -->\n<div class="wp-block-group">\n<!-- wp:post-content {"lock":{"move":true,"remove":true},"layout":{"type":"default"}} /-->\n</div>\n<!-- /wp:group -->\n\n<!-- wp:group {"style":{"spacing":{"padding":{"right":"0","left":"0","top":"var:preset|spacing|10","bottom":"var:preset|spacing|10"}}}} -->\n<div class="wp-block-group" style="padding-top:var(--wp--preset--spacing--10);padding-right:0;padding-bottom:var(--wp--preset--spacing--10);padding-left:0"><!-- wp:paragraph {"align":"center","style":{"border":{"top":{"color":"var:preset|color|cyan-bluish-gray","width":"1px","style":"solid"},"right":[],"bottom":[],"left":[]},"spacing":{"padding":{"top":"var:preset|spacing|20","bottom":"var:preset|spacing|20"}},"color":{"text":"#787c82"},"elements":{"link":{"color":{"text":"#787c82"}}}},"fontSize":"small"} -->\n<p class="has-text-align-center has-text-color has-link-color has-small-font-size" style="border-top-color:var(--wp--preset--color--cyan-bluish-gray);border-top-style:solid;border-top-width:1px;color:#787c82;padding-top:var(--wp--preset--spacing--20);padding-bottom:var(--wp--preset--spacing--20)">© <!--[woocommerce/store-name]-->. ' +
		(rt.call_function('esc_html__', [rt.new_string('All Rights Reserved.'), rt.new_string('woocommerce')])).str() +
		'<br><!--[woocommerce/store-address]--> </p>\n<!-- /wp:paragraph --></div>\n<!-- /wp:group -->\n</div>\n<!-- /wp:group -->\n\t\t'
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_EmailTemplates_WooEmailTemplate) get_site_logo_or_title() string {
	mut var_custom_logo := rt.call_function('get_custom_logo', []rt.PhpVal{})
	if !(!rt.is_true(var_custom_logo)) {
		return '<!-- wp:site-logo {"width":130,"isLink":false,"align":"center","style":{"spacing":{"padding":{"top":"var:preset|spacing|10","bottom":"var:preset|spacing|10"}}}} /-->'
	}
	return '<!-- wp:site-title {"level":2,"style":{"spacing":{"padding":{"top":"var:preset|spacing|10","bottom":"var:preset|spacing|10"}}}} /-->'
}

fn create_automattic_woocommerce_internal_emaileditor_emailtemplates_wooemailtemplate(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_EmailEditor_EmailTemplates_WooEmailTemplate {
	mut obj := &Class_Automattic_WooCommerce_Internal_EmailEditor_EmailTemplates_WooEmailTemplate{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_EmailTemplates_WooEmailTemplate) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_slug' {
			return rt.new_string(this.get_slug())
		}
		'get_title' {
			return rt.new_string(this.get_title())
		}
		'get_description' {
			return rt.new_string(this.get_description())
		}
		'get_content' {
			return rt.new_string(this.get_content())
		}
		'get_site_logo_or_title' {
			return rt.new_string(this.get_site_logo_or_title())
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_EmailEditor_EmailTemplates_WooEmailTemplate) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_EmailTemplates_WooEmailTemplate) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
