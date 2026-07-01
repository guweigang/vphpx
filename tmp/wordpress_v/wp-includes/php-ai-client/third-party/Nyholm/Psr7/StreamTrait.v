import rt

struct Class_WordPress_AiClientDependencies_Nyholm_Psr7_ReflectionMethod {
	rt.PhpObjectBase
}

fn create_wordpress_aiclientdependencies_nyholm_psr7_reflectionmethod() &Class_WordPress_AiClientDependencies_Nyholm_Psr7_ReflectionMethod {
	mut obj := &Class_WordPress_AiClientDependencies_Nyholm_Psr7_ReflectionMethod{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WordPress_AiClientDependencies_Nyholm_Psr7_ReflectionMethod) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WordPress_AiClientDependencies_Nyholm_Psr7_ReflectionMethod) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClientDependencies_Nyholm_Psr7_ReflectionMethod) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_includes_php_ai_client_third_party_nyholm_psr7_streamtrait_php() {
	// unsupported statement: Stmt_Declare
	if rt.is_true(rt.new_bool(
		rt.is_true(rt.greater_equal(rt.get_constant('PHP_VERSION_ID'), rt.new_int(70400)))
		|| rt.is_true(rt.call_method(create_wordpress_aiclientdependencies_nyholm_psr7_reflectionmethod(Class_WordPress_AiClientDependencies_Psr_Http_Message_StreamInterface.class(), rt.new_string('__toString')), 'hasReturnType', []rt.PhpVal{}))))
	{
		// unsupported statement: Stmt_Trait
	} else {
		// unsupported statement: Stmt_Trait
	}
}
