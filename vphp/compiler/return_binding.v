module compiler

enum ReturnBindingKind {
	void_
	value
	result
	option
	closure
}

struct ReturnBinding {
	return_type      string
	effective_return string
	kind             ReturnBindingKind
	struct_closure   ?StructClosureBinding
	borrowed_object  bool
}

fn ReturnBinding.new(return_type string, struct_closure ?StructClosureBinding, borrowed_object bool) ReturnBinding {
	is_result := return_type.starts_with('!')
	is_option := return_type.starts_with('?')
	effective_return := if is_result {
		return_type[1..]
	} else if is_option {
		return_type[1..]
	} else {
		return_type
	}
	kind := if is_result {
		ReturnBindingKind.result
	} else if is_option {
		ReturnBindingKind.option
	} else if return_type == 'void' {
		ReturnBindingKind.void_
	} else if ReturnBinding.is_closure_type(effective_return) {
		ReturnBindingKind.closure
	} else {
		ReturnBindingKind.value
	}
	return ReturnBinding{
		return_type:      return_type
		effective_return: effective_return
		kind:             kind
		struct_closure:   struct_closure
		borrowed_object:  borrowed_object
	}
}

fn ReturnBinding.is_closure_type(effective_return string) bool {
	return effective_return.starts_with('fn (')
}

fn ReturnBinding.capture_list(names []string) string {
	return names.map(it.trim_string_left('...')).join(', ')
}

fn (binding ReturnBinding) render_function_lines(v_call_name string, call_args string, arg_names []string) []string {
	match binding.kind {
		.result, .option {
			return binding.render_fallible_call_lines('${v_call_name}(${call_args})',
				ReturnBinding.capture_list(arg_names), [])
		}
		.void_ {
			return ['    ${v_call_name}(${call_args})']
		}
		.closure {
			return binding.render_closure_lines('${v_call_name}(${call_args})', false)
		}
		.value {
			return binding.render_value_call_lines('${v_call_name}(${call_args})')
		}
	}
}

fn (binding ReturnBinding) render_value_call_lines(call_expr string) []string {
	mut lines := []string{}
	lines << '    res := ${call_expr}'
	lines << binding.render_value_result_line('res')
	return lines
}

fn (binding ReturnBinding) render_value_result_line(result_name string) string {
	if binding.effective_return.starts_with('&') {
		return '    ctx.return().return_v_object[${binding.effective_return[1..]}](${result_name}, .${binding.object_ownership()})'
	}
	return '    ctx.return().v[${binding.effective_return}](${result_name})'
}

fn (binding ReturnBinding) render_fallible_call_lines(call_expr string, capture_list string, setup []string) []string {
	wrapper, prefix, propagate := if binding.kind == .result {
		'result', '!', '!'
	} else {
		'option', '?', ''
	}
	if binding.effective_return in ['', 'void'] {
		return [
			'    ctx.return().from_${wrapper}_void(fn [${capture_list}] () ${prefix} {',
			...setup,
			'        ${call_expr}${propagate}',
			'    })',
		]
	}
	if binding.effective_return.starts_with('&') {
		target := binding.effective_return[1..]
		return [
			'    ctx.return().from_${wrapper}_object[${target}](fn [${capture_list}] () ${prefix}&${target} {',
			...setup,
			'        return ${call_expr}${propagate}',
			'    }, .${binding.object_ownership()})',
		]
	}
	return [
		'    ctx.return().from_${wrapper}[${binding.effective_return}](fn [${capture_list}] () ${prefix}${binding.effective_return} {',
		...setup,
		'        return ${call_expr}${propagate}',
		'    })',
	]
}

fn (binding ReturnBinding) object_ownership() string {
	return if binding.borrowed_object { 'borrowed' } else { 'owned_request' }
}

fn (binding ReturnBinding) render_closure_lines(call_expr string, include_method_comment bool) []string {
	if struct_closure := binding.struct_closure {
		mut lines := []string{}
		lines << '    res := ${call_expr}'
		if include_method_comment {
			lines << '    // Returned value is a struct-param closure: wrap using generated bridge'
		}
		lines << '    ${struct_closure.wrap}(ctx, res)'
		return lines
	}
	mut lines := []string{}
	lines << '    _ := ${call_expr}'
	lines << "    vphp.throw_exception('unsupported closure return type: ${binding.effective_return}', 0)"
	return lines
}

fn (binding ReturnBinding) render_closure_value_lines(include_method_comment bool) []string {
	if struct_closure := binding.struct_closure {
		mut lines := []string{}
		if include_method_comment {
			lines << '    // Returned value is a struct-param closure: wrap using generated bridge'
		}
		lines << '    ${struct_closure.wrap}(ctx, res)'
		return lines
	}
	mut lines := []string{}
	lines << "    vphp.throw_exception('unsupported closure return type: ${binding.effective_return}', 0)"
	return lines
}
