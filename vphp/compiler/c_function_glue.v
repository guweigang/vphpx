module compiler

import compiler.repr

fn (g CGenerator) gen_func_c(f &repr.PhpFuncRepr) []string {
	mut r := []string{}
	func_builder := g.build_func(f)
	return_type := f.return_spec.effective_v_type()
	r << func_builder.render_arginfo()
	target_func := f.wrapper_symbol()
	// The V glue exposes a single wrapper symbol that
	// performs any necessary argument marshaling and return handling. The C
	// emitter simply forwards the PHP entry point to that V glue. Closure
	// wrapping is handled by generated V bridge code.
	r << 'extern void ${target_func}(vphp_context_internal ctx);'
	r << 'PHP_FUNCTION(${f.symbol()}) {'
	if !f.uses_context {
		r << '    if (!vphp_validate_internal_call(execute_data)) {'
		r << '        return;'
		r << '    }'
	}
	r << '    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);'
	r << '    ${target_func}(ctx);'
	if f.uses_context && !return_type.trim_left('!?').starts_with('&') {
		r << '}'
		return r
	}
	if return_type == 'void' || f.return_spec.declares_fallible_void() {
		r << '    if (!EG(exception)) {'
		r << '        vphp_mark_void_return(return_value);'
		r << '    }'
	}
	r << '    if (!vphp_validate_internal_return(execute_data, return_value)) {'
	r << '        return;'
	r << '    }'
	r << '}'
	return r
}
