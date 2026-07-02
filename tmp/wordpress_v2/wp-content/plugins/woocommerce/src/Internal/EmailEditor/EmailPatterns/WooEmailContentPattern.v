import rt

struct Class_Automattic_WooCommerce_Internal_EmailEditor_EmailPatterns_WooEmailContentPattern {
	rt.PhpObjectBase
pub mut:
	name           rt.PhpVal = rt.new_string('woo-email-content-pattern')
	block_types    rt.PhpVal = rt.new_array()
	template_types rt.PhpVal = rt.new_array()
	categories     rt.PhpVal = rt.new_array()
	namespace      rt.PhpVal = rt.new_string('woocommerce')
	post_types     rt.PhpVal = rt.new_array()
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_EmailPatterns_WooEmailContentPattern) get_content() string {
	return '<!-- wp:group {"style":{"spacing":{"padding":{"right":"var:preset|spacing|20","left":"var:preset|spacing|20"}}},"layout":{"type":"constrained"}} -->\n<div class="wp-block-group" style="padding-right:var(--wp--preset--spacing--20);padding-left:var(--wp--preset--spacing--20)"><!-- wp:heading -->\n<h2 class="wp-block-heading">Woo Email Content</h2>\n<!-- /wp:heading -->\n\n<!-- wp:paragraph -->\n<p>Here comes content composed of supported core blocks and Woo transactional email block(s).</p>\n<!-- /wp:paragraph -->\n\n<!-- wp:woocommerce/email-content {"lock":{"move":false,"remove":true}} -->\n<div class="wp-block-woocommerce-email-content">##WOO_CONTENT##</div>\n<!-- /wp:woocommerce/email-content -->\n\n<!-- wp:buttons {"layout":{"justifyContent":"center"}} -->\n<div class="wp-block-buttons"><!-- wp:button {"style":{"color":{"background":"#873eff"}}} -->\n<div class="wp-block-button"><a class="wp-block-button__link has-background wp-element-button" style="background-color:#873eff">Shop now</a></div>\n<!-- /wp:button --></div>\n<!-- /wp:buttons --></div>\n<!-- /wp:group -->'
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_EmailPatterns_WooEmailContentPattern) get_title() string {
	return (rt.call_function('__', [rt.new_string('Woo Email Content Pattern'),
		rt.new_string('woocommerce')])).str()
}

struct Class_Automattic_WooCommerce_EmailEditor_Engine_Patterns_Abstract_Pattern {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_emaileditor_emailpatterns_wooemailcontentpattern(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_EmailEditor_EmailPatterns_WooEmailContentPattern {
	mut obj := &Class_Automattic_WooCommerce_Internal_EmailEditor_EmailPatterns_WooEmailContentPattern{
		PhpObjectBase:  rt.PhpObjectBase{}
		name:           rt.new_string('woo-email-content-pattern')
		block_types:    rt.new_array()
		template_types: rt.new_array()
		categories:     rt.new_array()
		namespace:      rt.new_string('woocommerce')
		post_types:     rt.new_array()
	}
	return obj
}

fn create_automattic_woocommerce_emaileditor_engine_patterns_abstract_pattern(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditor_Engine_Patterns_Abstract_Pattern {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Engine_Patterns_Abstract_Pattern{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_EmailPatterns_WooEmailContentPattern) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_content' {
			return rt.new_string(this.get_content())
		}
		'get_title' {
			return rt.new_string(this.get_title())
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_EmailEditor_EmailPatterns_WooEmailContentPattern) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'name' { return this.name }
		'block_types' { return this.block_types }
		'template_types' { return this.template_types }
		'categories' { return this.categories }
		'namespace' { return this.namespace }
		'post_types' { return this.post_types }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_EmailPatterns_WooEmailContentPattern) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'name' {
			this.name = val
			return true
		}
		'block_types' {
			this.block_types = val
			return true
		}
		'template_types' {
			this.template_types = val
			return true
		}
		'categories' {
			this.categories = val
			return true
		}
		'namespace' {
			this.namespace = val
			return true
		}
		'post_types' {
			this.post_types = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Patterns_Abstract_Pattern) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Engine_Patterns_Abstract_Pattern) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Patterns_Abstract_Pattern) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
