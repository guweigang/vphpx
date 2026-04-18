module main

import vphp

#include "php_bridge.h"

fn new_cli_core_app() &VSlimApp {
	return &VSlimApp{
		not_found_handler: vphp.PersistentOwnedZBox.new_null()
		error_handler:     vphp.PersistentOwnedZBox.new_null()
		clock_ref:         vphp.PersistentOwnedZBox.new_null()
		view_helpers:      map[string]vphp.PersistentOwnedZBox{}
		providers:         []vphp.RetainedObject{}
		provider_classes:  map[string]bool{}
		modules:           []vphp.RetainedObject{}
		module_classes:    map[string]bool{}
		live_ws_sockets:   map[string]vphp.PersistentOwnedZBox{}
	}
}

fn cli_debug_reset_overrides() {
	unsafe {
		vslim_cli_debug_override_inited = false
		vslim_cli_debug_enabled_override = false
		vslim_cli_debug_file_override = ''
	}
}

fn ensure_cli_core_app(mut cli VSlimCliApp) &VSlimApp {
	if cli.core_app_ref == unsafe { nil } {
		cli.core_app_ref = new_cli_core_app()
		cli_debug_log('ensure_cli_core_app new cli=${usize(&cli)} core=${usize(cli.core_app_ref)}')
	}
	return cli.core_app_ref
}

fn ensure_cli_registry(mut cli VSlimCliApp) {
	if cli.command_handlers.len == 0 {
		cli.command_handlers = map[string]vphp.PersistentOwnedZBox{}
	}
	if cli.command_order.len == 0 {
		cli.command_order = []string{}
	}
	if cli.command_aliases.len == 0 {
		cli.command_aliases = map[string][]string{}
	}
	if cli.command_hidden.len == 0 {
		cli.command_hidden = map[string]bool{}
	}
	if cli.command_canonical.len == 0 {
		cli.command_canonical = map[string]string{}
	}
}

fn cli_trace_label(cli &VSlimCliApp) string {
	if unsafe { isnil(cli) } {
		return 'trace=nil'
	}
	trace := cli.current_trace.trim_space()
	if trace == '' {
		return 'trace=idle cli=${usize(cli)}'
	}
	return trace
}

fn cli_trace_message(cli &VSlimCliApp, message string) string {
	return '[${cli_trace_label(cli)}] ${message}'
}

fn wrap_runtime_cli_zval(cli &VSlimCliApp) vphp.ZVal {
	unsafe {
		if isnil(cli) || C.vslim__cli__app_ce == 0 {
			return vphp.ZVal.new_null()
		}
		cli_debug_log(cli_trace_message(cli, 'wrap_runtime_cli_zval enter cli=${usize(cli)} ce=${usize(C.vslim__cli__app_ce)}'))
		mut payload := vphp.RequestOwnedZBox.new_null().to_zval()
		vphp.return_borrowed_object_raw(payload.raw, cli, C.vslim__cli__app_ce, &C.vphp_class_handlers(vslimcliapp_handlers()))
		cli_debug_log(cli_trace_message(cli, 'wrap_runtime_cli_zval exit cli=${usize(cli)} payload=${usize(payload.raw)} valid=${payload.is_valid()} type=${payload.type_name()}'))
		return payload
	}
}

fn cli_self_zval(cli &VSlimCliApp) vphp.ZVal {
	return wrap_runtime_cli_zval(cli)
}

fn short_class_name(class_name string) string {
	clean := class_name.trim_space()
	last := clean.last_index('\\') or { -1 }
	if last >= 0 && last + 1 < clean.len {
		return clean[last + 1..]
	}
	return clean
}

fn command_name_from_short_name(short_name string) string {
	mut base := short_name.trim_space()
	if base.ends_with('Command') && base.len > 'Command'.len {
		base = base[..base.len - 'Command'.len]
	}
	mut out := []u8{}
	for idx, ch in base {
		is_upper := ch >= `A` && ch <= `Z`
		if idx > 0 && is_upper {
			prev := base[idx - 1]
			next_is_lower := idx + 1 < base.len && base[idx + 1] >= `a` && base[idx + 1] <= `z`
			if (prev >= `a` && prev <= `z`) || (prev >= `0` && prev <= `9`) || next_is_lower {
				out << `-`
			}
		}
		lower := if is_upper { u8(ch + 32) } else { ch }
		out << lower
	}
	return out.bytestr()
}

fn derive_command_name_from_handler(handler_z vphp.ZVal) !string {
	if handler_z.is_valid() && handler_z.is_string() {
		raw_name := handler_z.to_string().trim_space()
		source := if cli_handler_string_is_function_callable(raw_name) {
			raw_name
		} else {
			short_class_name(raw_name)
		}
		name := command_name_from_short_name(source)
		if name == '' {
			cli_debug_log('derive_command_name_from_handler empty source raw="${raw_name}" source="${source}"')
			return error('command name must not be empty')
		}
		return name
	}
	if handler_z.is_valid() && handler_z.is_object() {
		name := command_name_from_short_name(short_class_name(handler_z.class_name()))
		if name == '' {
			cli_debug_log('derive_command_name_from_handler object empty class="${handler_z.class_name()}"')
			return error('command name must not be empty')
		}
		return name
	}
	return error('command name cannot be derived from anonymous callable; use command(name, handler)')
}

fn cli_handler_string_is_function_callable(name string) bool {
	callable_name := name.trim_space()
	if callable_name == '' {
		return false
	}
	return vphp.with_php_call_result_bool('function_exists', [
		vphp.RequestOwnedZBox.new_string(callable_name).to_zval(),
	])
}

fn normalize_cli_command_handler_input(raw vphp.ZVal) !vphp.ZVal {
	if !raw.is_valid() || raw.is_null() || raw.is_undef() {
		return error('command handler must not be null')
	}
	if raw.is_callable() || raw.is_object() {
		return raw
	}
	if raw.is_string() {
		class_name := raw.to_string().trim_space()
		if class_name == '' {
			return error('command class name must not be empty')
		}
		return vphp.RequestOwnedZBox.new_string(class_name).to_zval()
	}
	return error('command handler must be callable, object, or class-string')
}

fn cli_command_exit_code(mut result vphp.ZVal) int {
	if !result.is_valid() || result.is_null() || result.is_undef() {
		return 0
	}
	if result.is_long() {
		return int(result.to_i64())
	}
	if result.is_bool() {
		return if result.to_bool() { 0 } else { 1 }
	}
	return 0
}

fn cli_args_to_array(raw vphp.ZVal) ![]string {
	normalized := psr16_iterable_to_array(raw)!
	mut out := []string{}
	for idx := 0; idx < normalized.array_count(); idx++ {
		out << normalized.array_get(idx).to_string()
	}
	return out
}

fn resolve_cli_command_runtime(mut cli VSlimCliApp, handler_z vphp.ZVal) !vphp.ZVal {
	if handler_z.is_valid() && handler_z.is_string() {
		class_name := handler_z.to_string().trim_space()
		if class_name == '' {
			return error('command class name must not be empty')
		}
		if cli_handler_string_is_function_callable(class_name) {
			return vphp.RequestOwnedZBox.new_string(class_name).to_zval()
		}
		exists := vphp.with_php_call_result_bool('class_exists', [
			vphp.RequestOwnedZBox.new_string(class_name).to_zval(),
			vphp.RequestOwnedZBox.new_bool(true).to_zval(),
		])
		if !exists {
			return error('command class "${class_name}" does not exist')
		}
		mut core := ensure_cli_core_app(mut cli)
		mut container := core.container()
		if container.has(class_name) {
			return container.get(class_name).to_zval()
		}
		command := vphp.php_class(class_name).construct([])
		if !command.is_valid() || !command.is_object() {
			return error('command class "${class_name}" could not be constructed')
		}
		return command
	}
	return vphp.RequestOwnedZBox.from_zval(handler_z).to_zval()
}

fn lookup_cli_command_handler(cli &VSlimCliApp, name string) !vphp.ZVal {
	command_name := name.trim_space()
	if command_name == '' {
		cli_debug_log('lookup_cli_command_handler empty name raw="${name}"')
		return error('command name must not be empty')
	}
	handler := cli.command_handlers[command_name] or {
		return error('command "${command_name}" is not registered')
	}
	mut out := handler.clone_request_owned()
	return out.take_zval()
}

fn cli_release_command_handler(mut handler vphp.PersistentOwnedZBox) {
	if handler.is_object() {
		return
	}
	handler.release()
}

fn cli_canonical_command_name(cli &VSlimCliApp, name string) string {
	command_name := name.trim_space().clone()
	if command_name == '' {
		return ''
	}
	return (cli.command_canonical[command_name] or { command_name }).clone()
}

fn cli_hidden_command(cli &VSlimCliApp, name string) bool {
	canonical := cli_canonical_command_name(cli, name)
	if canonical == '' {
		return false
	}
	return cli.command_hidden[canonical] or { false }
}

fn cli_command_aliases_for_listing(cli &VSlimCliApp, name string) []string {
	canonical := cli_canonical_command_name(cli, name)
	if canonical == '' {
		return []string{}
	}
	aliases := cli.command_aliases[canonical] or { []string{} }
	mut out := []string{}
	for alias in aliases {
		clean := alias.trim_space().clone()
		if clean != '' {
			out << clean
		}
	}
	return out
}

fn clear_cli_command_metadata(mut cli VSlimCliApp, canonical_name string) {
	aliases := cli.command_aliases[canonical_name] or { []string{} }
	for alias in aliases {
		existing_canonical := cli.command_canonical[alias] or { '' }
		if existing_canonical != canonical_name {
			continue
		}
		mut alias_handler := cli.command_handlers[alias] or { continue }
		cli_release_command_handler(mut alias_handler)
		cli.command_handlers.delete(alias)
		cli.command_canonical.delete(alias)
	}
	cli.command_aliases.delete(canonical_name)
	cli.command_hidden.delete(canonical_name)
}

fn cli_command_metadata_aliases(runtime vphp.ZVal) []string {
	mut out := []string{}
	mut seen := map[string]bool{}
	if def := cli_command_definition(runtime) {
		for alias in def.aliases {
			alias_name := alias.trim_space().clone()
			if alias_name == '' || alias_name in seen {
				continue
			}
			seen[alias_name] = true
			out << alias_name
		}
	}
	for alias in cli_runtime_string_list_method(runtime, 'aliases') {
		alias_name := alias.trim_space().clone()
		if alias_name == '' || alias_name in seen {
			continue
		}
		seen[alias_name] = true
		out << alias_name
	}
	return out
}

fn cli_command_metadata_hidden(runtime vphp.ZVal) bool {
	if def := cli_command_definition(runtime) {
		if def.hidden {
			return true
		}
	}
	return cli_runtime_bool_method(runtime, 'hidden', false)
}

fn apply_cli_command_metadata(mut cli VSlimCliApp, canonical_name string, handler_z vphp.ZVal) ! {
	canonical := canonical_name.trim_space().clone()
	clear_cli_command_metadata(mut cli, canonical)
	cli.command_canonical[canonical] = canonical.clone()
	if handler_z.is_valid() && handler_z.is_object() && handler_z.class_name() == 'Closure' {
		cli.command_hidden[canonical] = false
		return
	}
	mut runtime := resolve_cli_command_runtime(mut cli, handler_z)!
	defer {
		runtime.release()
	}
	cli.command_hidden[canonical] = cli_command_metadata_hidden(runtime)
	aliases := cli_command_metadata_aliases(runtime)
	if aliases.len == 0 {
		return
	}
	mut registered_aliases := []string{}
	for alias in aliases {
		alias_name := alias.trim_space().clone()
		if alias_name == '' || alias_name == canonical {
			continue
		}
		existing_canonical := cli.command_canonical[alias_name] or { '' }
		if existing_canonical != '' && existing_canonical != canonical {
			return error('CLI alias "${alias_name}" conflicts with registered command "${existing_canonical}"')
		}
		if alias_name in cli.command_handlers {
			continue
		}
		cli.command_handlers[alias_name] = if handler_z.is_callable() || handler_z.is_object() {
			vphp.PersistentOwnedZBox.from_callable_zval(handler_z)
		} else {
			vphp.PersistentOwnedZBox.from_mixed_zval(handler_z)
		}
		cli.command_canonical[alias_name] = canonical.clone()
		registered_aliases << alias_name.clone()
	}
	if registered_aliases.len > 0 {
		cli.command_aliases[canonical] = registered_aliases
	}
}

fn (mut cli VSlimCliApp) run_registered_cli_command_with_program(name string, args []string, program string) !int {
	command_name := name.trim_space().clone()
	cli.current_trace = 'trace=cmd:${command_name} cli=${usize(&cli)} core=${usize(cli.core_app_ref)}'
	defer {
		cli.current_trace = ''
	}
	cli_debug_log(cli_trace_message(&cli, 'run_registered_cli_command start name="${command_name}" args=${args.len}'))
	mut handler_z := lookup_cli_command_handler(&cli, command_name)!
	defer {
		cli_debug_log(cli_trace_message(&cli, 'run_registered_cli_command handler_release begin raw=${usize(handler_z.raw)}'))
		handler_z.release()
		cli_debug_log(cli_trace_message(&cli, 'run_registered_cli_command handler_release done'))
	}
	reset_cli_command_input(mut cli)
	cli.last_command_name = command_name.clone()
	mut runtime := resolve_cli_command_runtime(mut cli, handler_z)!
	defer {
		cli_debug_log(cli_trace_message(&cli, 'run_registered_cli_command runtime_release begin raw=${usize(runtime.raw)}'))
		runtime.release()
		cli_debug_log(cli_trace_message(&cli, 'run_registered_cli_command runtime_release done'))
	}
	cli_debug_log(cli_trace_message(&cli, 'run_registered_cli_command runtime_ready name="${command_name}" raw=${usize(runtime.raw)} valid=${runtime.is_valid()} type=${runtime.type_name()} class=${runtime.class_name()}'))
	input := resolve_cli_command_input(mut cli, runtime, args) or {
		return cli_command_input_error(runtime, program, command_name, err.msg())
	}
	cli_debug_log(cli_trace_message(&cli, 'run_registered_cli_command input_ready name="${command_name}" parsed=${input.parsed} positional=${input.positional_args.len}'))
	args_copy := clone_cli_string_slice(input.positional_args)
	cli_debug_log(cli_trace_message(&cli, 'invoke_cli_command args_copy_pre_set len=${args_copy.len}'))
	set_cli_command_input(mut cli, command_name, input)
	cli_debug_log(cli_trace_message(&cli, 'invoke_cli_command start args=${input.positional_args.len}'))
	cli_debug_log(cli_trace_message(&cli, 'invoke_cli_command args_copy len=${args_copy.len}'))
	trace := cli_trace_label(&cli)
	mut args_z := vphp.ZVal.new_null()
	args_z.array_init()
	cli_debug_log('[${trace}] invoke_cli_command args_array_init raw=${usize(args_z.raw)}')
	mut arg_idx := 0
	for arg_raw in args_copy {
		cli_debug_log('[${trace}] invoke_cli_command args_iter_begin idx=${arg_idx}')
		cli_debug_log('[${trace}] invoke_cli_command args_read_done idx=${arg_idx} len=${arg_raw.len}')
		arg := arg_raw.clone()
		cli_debug_log('[${trace}] invoke_cli_command args_clone_done idx=${arg_idx} value="${arg}"')
		cli_debug_log('[${trace}] invoke_cli_command args_push_begin idx=${arg_idx}')
		args_z.push_string(arg)
		cli_debug_log('[${trace}] invoke_cli_command args_push_done idx=${arg_idx} raw=${usize(args_z.raw)}')
		arg_idx++
	}
	defer {
		cli_debug_log(cli_trace_message(&cli, 'invoke_cli_command args_release begin raw=${usize(args_z.raw)}'))
		args_z.release()
		cli_debug_log(cli_trace_message(&cli, 'invoke_cli_command args_release done'))
	}
	cli_debug_log(cli_trace_message(&cli, 'invoke_cli_command args_ready raw=${usize(args_z.raw)} valid=${args_z.is_valid()} type=${args_z.type_name()}'))
	mut cli_z := cli_self_zval(&cli)
	defer {
		cli_debug_log(cli_trace_message(&cli, 'invoke_cli_command cli_release begin raw=${usize(cli_z.raw)}'))
		cli_z.release()
		cli_debug_log(cli_trace_message(&cli, 'invoke_cli_command cli_release done'))
	}
	cli_debug_log(cli_trace_message(&cli, 'invoke_cli_command cli_ready raw=${usize(cli_z.raw)} valid=${cli_z.is_valid()} type=${cli_z.type_name()}'))
	runtime_is_command_object := input.parsed && runtime.is_object() && runtime.method_exists('handle')
	cli_debug_log(cli_trace_message(&cli, 'invoke_cli_command runtime_state raw=${usize(runtime.raw)} valid=${runtime.is_valid()} type=${runtime.type_name()} class=${runtime.class_name()} parsed=${input.parsed} object_path=${runtime_is_command_object}'))
	mut code := 0
	if runtime_is_command_object {
		cli_debug_log(cli_trace_message(&cli, 'invoke_cli_command runtime=object'))
		bind_cli_runtime_to_command(mut cli, runtime)
		cli_debug_log(cli_trace_message(&cli, 'invoke_cli_command object_handle enter'))
		mut handle_result := vphp.method_request_owned_box(runtime, 'handle', [
			args_z,
			cli_z,
		])
		defer {
			cli_debug_log(cli_trace_message(&cli, 'invoke_cli_command object_handle_result_release begin raw=${usize(handle_result.to_zval().raw)}'))
			handle_result.release()
			cli_debug_log(cli_trace_message(&cli, 'invoke_cli_command object_handle_result_release done'))
		}
		mut handle_result_z := handle_result.to_zval()
		code = cli_command_exit_code(mut handle_result_z)
		cli_debug_log(cli_trace_message(&cli, 'invoke_cli_command object_handle exit code=${code}'))
	cli_debug_log(cli_trace_message(&cli, 'run_registered_cli_command exit name="${command_name}" code=${code}'))
		return code
	}
	if !input.parsed {
		cli_debug_log(cli_trace_message(&cli, 'invoke_cli_command callable enter runtime_raw=${usize(runtime.raw)} runtime_type=${runtime.type_name()} runtime_class=${runtime.class_name()} args_raw=${usize(args_z.raw)} cli_raw=${usize(cli_z.raw)}'))
		mut result := vphp.call_request_owned_box(runtime, [args_z, cli_z])
		defer {
			cli_debug_log(cli_trace_message(&cli, 'invoke_cli_command callable_result_release begin raw=${usize(result.to_zval().raw)}'))
			result.release()
			cli_debug_log(cli_trace_message(&cli, 'invoke_cli_command callable_result_release done'))
		}
		result_z := result.to_zval()
		cli_debug_log(cli_trace_message(&cli, 'invoke_cli_command callable_result raw=${usize(result_z.raw)} valid=${result.is_valid()} type=${result_z.type_name()}'))
		if !result.is_valid() {
			return error('command handler must be callable or expose handle(array \$args, VSlim\\Cli\\App \$cli)')
		}
		mut exit_result_z := result.to_zval()
		code = cli_command_exit_code(mut exit_result_z)
		cli_debug_log(cli_trace_message(&cli, 'invoke_cli_command callable exit code=${code}'))
		cli_debug_log(cli_trace_message(&cli, 'run_registered_cli_command exit name="${command_name}" code=${code}'))
		return code
	}
	return error('command handler must be callable or expose handle(array \$args, VSlim\\Cli\\App \$cli)')
}



fn (mut cli VSlimCliApp) run_registered_cli_command(name string, args []string) !int {
	return cli.run_registered_cli_command_with_program(name, args, '')
}

@[php_method]
pub fn (mut cli VSlimCliApp) construct() &VSlimCliApp {
	cli_debug_reset_overrides()
	ensure_cli_core_app(mut cli)
	ensure_cli_registry(mut cli)
	cli.project_root = ''
	reset_cli_command_input(mut cli)
	cli_debug_log('cli.construct cli=${usize(&cli)} core=${usize(cli.core_app_ref)}')
	return &cli
}

@[php_return_type: 'VSlim\\App']
@[php_method]
pub fn (mut cli VSlimCliApp) app() vphp.RequestOwnedZBox {
	return vphp.RequestOwnedZBox.adopt_zval(wrap_runtime_app_zval(ensure_cli_core_app(mut cli)))
}

@[php_method: 'projectRoot']
pub fn (cli &VSlimCliApp) project_root_value() string {
	return cli.project_root
}

@[php_method: 'debugBridgePath']
pub fn (cli &VSlimCliApp) debug_bridge_path(path string) vphp.RequestOwnedZBox {
	echoed := vphp.with_php_call_result_string('strval', [
		vphp.RequestOwnedZBox.new_string(path).to_zval(),
	])
	joined := vphp.with_php_call_result_string('sprintf', [
		vphp.RequestOwnedZBox.new_string('%s/%s').to_zval(),
		vphp.RequestOwnedZBox.new_string(path).to_zval(),
		vphp.RequestOwnedZBox.new_string('bootstrap/app.php').to_zval(),
	])
	echoed_joined := vphp.with_php_call_result_string('sprintf', [
		vphp.RequestOwnedZBox.new_string('%s/%s').to_zval(),
		vphp.RequestOwnedZBox.new_string(echoed).to_zval(),
		vphp.RequestOwnedZBox.new_string('bootstrap/app.php').to_zval(),
	])
	return vphp.RequestOwnedZBox.adopt_zval(vphp.new_zval_from_dyn_value(vphp.dyn_value_map({
		'original':      vphp.dyn_value_string(path)
		'strval':        vphp.dyn_value_string(echoed)
		'sprintf':       vphp.dyn_value_string(joined)
		'sprintf_echo':  vphp.dyn_value_string(echoed_joined)
	})) or {
		vphp.ZVal.new_null()
	})
}

@[php_method]
pub fn (mut cli VSlimCliApp) command(name string, handler vphp.RequestBorrowedZBox) &VSlimCliApp {
	ensure_cli_registry(mut cli)
	handler_view := handler.to_zval()
	cli_debug_log('command enter cli=${usize(&cli)} raw_name="${name}" raw_len=${name.len} handler_type=${handler_view.type_name()}')
	command_name := name.trim_space().clone()
	cli_debug_log('command normalized cli=${usize(&cli)} command_name="${command_name}" len=${command_name.len}')
	if command_name == '' {
		cli_debug_log('command empty raw_name="${name}" raw_len=${name.len}')
		vphp.throw_exception_class('InvalidArgumentException', 'command name must not be empty',
			0)
		return &cli
	}
	handler_z := normalize_cli_command_handler_input(handler.to_zval()) or {
		vphp.throw_exception_class('InvalidArgumentException', err.msg(), 0)
		return &cli
	}
	existing_canonical := cli.command_canonical[command_name] or { command_name }
	if command_name in cli.command_handlers && existing_canonical != command_name {
		vphp.throw_exception_class('InvalidArgumentException', 'command name "${command_name}" is already registered as an alias for "${existing_canonical}"',
			0)
		return &cli
	}
	if command_name !in cli.command_handlers {
		cli.command_order << command_name.clone()
	}
	cli_debug_log('command register cli=${usize(&cli)} command_name="${command_name}" order_len=${cli.command_order.len} handlers_len=${cli.command_handlers.len}')
	clear_cli_command_metadata(mut cli, command_name)
	cli.command_handlers[command_name] = if handler_z.is_callable() || handler_z.is_object() {
		vphp.PersistentOwnedZBox.from_callable_zval(handler_z)
	} else {
		vphp.PersistentOwnedZBox.from_mixed_zval(handler_z)
	}
	cli.command_canonical[command_name] = command_name.clone()
	apply_cli_command_metadata(mut cli, command_name, handler_z) or {
		vphp.throw_exception_class('InvalidArgumentException', err.msg(), 0)
		return &cli
	}
	cli_debug_log('command exit cli=${usize(&cli)} command_name="${command_name}" order=${cli.command_order}')
	return &cli
}

@[php_arg_type: 'commands=iterable']
@[php_method: 'commandMany']
pub fn (mut cli VSlimCliApp) command_many(commands vphp.RequestBorrowedZBox) &VSlimCliApp {
	ensure_cli_registry(mut cli)
	normalized := psr16_iterable_to_array(commands.to_zval()) or {
		vphp.throw_exception_class('InvalidArgumentException', 'commands must be iterable',
			0)
		return &cli
	}
	for key in normalized.assoc_keys() {
		handler := normalized.get(key) or { continue }
		cli.command(key, vphp.borrow_zbox(handler))
	}
	if normalized.is_list() {
		for idx := 0; idx < normalized.array_count(); idx++ {
			handler := normalized.array_get(idx)
			if !handler.is_valid() || handler.is_null() || handler.is_undef() {
				continue
			}
			name := derive_command_name_from_handler(handler) or {
				vphp.throw_exception_class('InvalidArgumentException', err.msg(), 0)
				return &cli
			}.clone()
			cli.command(name, vphp.borrow_zbox(handler))
		}
	}
	return &cli
}

@[php_method: 'commandNames']
pub fn (cli &VSlimCliApp) command_names() []string {
	mut out := []string{}
	for name in cli.command_order {
		clean := name.trim_space().clone()
		if clean != '' {
			out << clean
		}
	}
	return out
}

@[php_method: 'hasCommand']
pub fn (cli &VSlimCliApp) has_command(name string) bool {
	return name.trim_space() in cli.command_handlers
}

@[php_method: 'commandName']
pub fn (cli &VSlimCliApp) command_name() string {
	return cli.last_command_name
}

@[php_method: 'rawArgs']
pub fn (cli &VSlimCliApp) raw_args() []string {
	return cli.last_raw_args.clone()
}

@[php_method: 'inputParsed']
pub fn (cli &VSlimCliApp) input_parsed() bool {
	return cli.last_input_parsed
}

@[php_method: 'hasOption']
pub fn (cli &VSlimCliApp) has_option(name string) bool {
	return name.trim_space() in cli.last_option_seen
}

@[php_method: 'warnings']
pub fn (cli &VSlimCliApp) warnings() []string {
	return cli.last_warnings.clone()
}

@[php_method]
pub fn (cli &VSlimCliApp) options() vphp.RequestOwnedZBox {
	return vphp.RequestOwnedZBox.adopt_zval(vphp.new_zval_from_dyn_value(vphp.dyn_value_map(cli.last_options.clone())) or {
		vphp.ZVal.new_null()
	})
}

@[php_method]
pub fn (cli &VSlimCliApp) arguments() vphp.RequestOwnedZBox {
	return vphp.RequestOwnedZBox.adopt_zval(vphp.new_zval_from_dyn_value(vphp.dyn_value_map(cli.last_arguments.clone())) or {
		vphp.ZVal.new_null()
	})
}

@[php_optional_args: 'default_value']
@[php_method]
pub fn (cli &VSlimCliApp) option(name string, default_value vphp.RequestBorrowedZBox) vphp.RequestOwnedZBox {
	key := name.trim_space()
	if key != '' {
		if value := cli.last_options[key] {
			return vphp.RequestOwnedZBox.adopt_zval(vphp.new_zval_from_dyn_value(value) or {
				vphp.ZVal.new_null()
			})
		}
	}
	raw_default := default_value.to_zval()
	if raw_default.is_valid() {
		return vphp.own_request_zbox(raw_default)
	}
	return vphp.RequestOwnedZBox.new_null()
}

@[php_optional_args: 'default_value']
@[php_method]
pub fn (cli &VSlimCliApp) argument(name string, default_value vphp.RequestBorrowedZBox) vphp.RequestOwnedZBox {
	key := name.trim_space()
	if key != '' {
		if value := cli.last_arguments[key] {
			return vphp.RequestOwnedZBox.adopt_zval(vphp.new_zval_from_dyn_value(value) or {
				vphp.ZVal.new_null()
			})
		}
	}
	raw_default := default_value.to_zval()
	if raw_default.is_valid() {
		return vphp.own_request_zbox(raw_default)
	}
	return vphp.RequestOwnedZBox.new_null()
}

@[php_arg_type: 'args=iterable']
@[php_method]
pub fn (mut cli VSlimCliApp) run(name string, args vphp.RequestBorrowedZBox) int {
	arg_list := cli_args_to_array(args.to_zval()) or {
		vphp.throw_exception_class('InvalidArgumentException', 'command args must be iterable',
			0)
		return 1
	}
	cli.last_command_name = name.trim_space().clone()
	return cli.run_registered_cli_command(name, arg_list) or {
		error_class := if name.trim_space() == '' || err.msg().contains('must not be empty') {
			'InvalidArgumentException'
		} else {
			'RuntimeException'
		}
		vphp.throw_exception_class(error_class, err.msg(), 0)
		return 1
	}
}

pub fn (mut cli VSlimCliApp) cleanup() {
	cli_debug_log('cli.cleanup auto-release entry cli=${usize(&cli)} handlers=${cli.command_handlers.len}')
	// command_handlers and core_app_zref are direct bridge-owned fields, so
	// generic_free_raw() will release them after cleanup() returns.
	unsafe {
		cli.command_order.free()
		cli.command_aliases.free()
		cli.command_hidden.free()
		cli.command_canonical.free()
		cli.project_root.free()
		cli.last_command_name.free()
		cli.last_raw_args.free()
		cli.last_arguments.free()
		cli.last_options.free()
		cli.last_option_seen.free()
		cli.last_warnings.free()
	}
	cli_debug_reset_overrides()
	cli_debug_log('cli.cleanup native done')
}
