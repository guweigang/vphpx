module main

import vphp

#include "php_bridge.h"

fn new_cli_core_app() &VSlimApp {
	return &VSlimApp{
		not_found_handler: vphp.PersistentOwnedZVal.new_null()
		error_handler:     vphp.PersistentOwnedZVal.new_null()
		clock_ref:         vphp.PersistentOwnedZVal.new_null()
		view_helpers:      map[string]vphp.PersistentOwnedZVal{}
		providers:         []vphp.PersistentOwnedZVal{}
		provider_classes:  map[string]bool{}
		modules:           []vphp.PersistentOwnedZVal{}
		module_classes:    map[string]bool{}
		live_ws_sockets:   map[string]vphp.PersistentOwnedZVal{}
	}
}

fn ensure_cli_core_app(mut cli VSlimCliApp) &VSlimApp {
	if cli.core_app_ref == unsafe { nil } {
		cli.core_app_ref = new_cli_core_app()
	}
	if !cli.core_app_zref.to_zval().is_valid() && cli.core_app_ref != unsafe { nil } {
		unsafe {
			mut payload := vphp.RequestOwnedZVal.new_null().to_zval()
			vphp.return_owned_object_raw(payload.raw, cli.core_app_ref, C.vslim__app_ce,
				&C.vphp_class_handlers(vslimapp_handlers()))
			cli.core_app_zref = vphp.PersistentOwnedZVal.from_zval(payload)
		}
	}
	return cli.core_app_ref
}

fn ensure_cli_registry(mut cli VSlimCliApp) {
	if cli.command_handlers.len == 0 {
		cli.command_handlers = map[string]vphp.PersistentOwnedZVal{}
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

fn wrap_runtime_cli_zval(cli &VSlimCliApp) vphp.ZVal {
	unsafe {
		if isnil(cli) || C.vslim__cli__app_ce == 0 {
			return vphp.ZVal.new_null()
		}
		cli_debug_log('wrap_runtime_cli_zval enter cli=${usize(cli)} ce=${usize(C.vslim__cli__app_ce)}')
		mut payload := vphp.RequestOwnedZVal.new_null().to_zval()
		vphp.return_borrowed_object_raw(payload.raw, cli, C.vslim__cli__app_ce, &C.vphp_class_handlers(vslimcliapp_handlers()))
		cli_debug_log('wrap_runtime_cli_zval exit cli=${usize(cli)} payload=${usize(payload.raw)} valid=${payload.is_valid()} type=${payload.type_name()}')
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
		name := command_name_from_short_name(short_class_name(handler_z.to_string()))
		if name == '' {
			return error('command name must not be empty')
		}
		return name
	}
	if handler_z.is_valid() && handler_z.is_object() {
		name := command_name_from_short_name(short_class_name(handler_z.class_name()))
		if name == '' {
			return error('command name must not be empty')
		}
		return name
	}
	return error('command name cannot be derived from anonymous callable; use command(name, handler)')
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
		return vphp.RequestOwnedZVal.new_string(class_name).to_zval()
	}
	return error('command handler must be callable, object, or class-string')
}

fn cli_command_exit_code(result vphp.ZVal) int {
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

fn cli_args_zval(args []string) vphp.ZVal {
	return vphp.new_zval_from[[]string](args) or { vphp.ZVal.new_null() }
}

fn resolve_cli_command_runtime(mut cli VSlimCliApp, handler_z vphp.ZVal) !vphp.ZVal {
	if handler_z.is_valid() && handler_z.is_string() {
		class_name := handler_z.to_string().trim_space()
		if class_name == '' {
			return error('command class name must not be empty')
		}
		exists := vphp.call_php('class_exists', [
			vphp.RequestOwnedZVal.new_string(class_name).to_zval(),
			vphp.RequestOwnedZVal.new_bool(true).to_zval(),
		])
		if !exists.is_valid() || !exists.to_bool() {
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
	return handler_z
}

fn lookup_cli_command_handler(cli &VSlimCliApp, name string) !vphp.ZVal {
	command_name := name.trim_space()
	if command_name == '' {
		return error('command name must not be empty')
	}
	handler := cli.command_handlers[command_name] or {
		return error('command "${command_name}" is not registered')
	}
	raw := handler.to_zval()
	if raw.is_valid() && raw.is_object() && raw.is_callable() {
		return raw
	}
	return handler.clone_request_owned().to_zval()
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
		alias_handler.release()
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
	runtime := resolve_cli_command_runtime(mut cli, handler_z)!
	cli.command_canonical[canonical] = canonical.clone()
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
		cli.command_handlers[alias_name] = vphp.PersistentOwnedZVal.from_zval(handler_z)
		cli.command_canonical[alias_name] = canonical.clone()
		registered_aliases << alias_name.clone()
	}
	if registered_aliases.len > 0 {
		cli.command_aliases[canonical] = registered_aliases
	}
}

fn run_registered_cli_command_with_program(mut cli VSlimCliApp, name string, args []string, program string) !int {
	cli_debug_log('run_registered_cli_command start name="${name}" args=${args.len}')
	handler_z := lookup_cli_command_handler(&cli, name)!
	reset_cli_command_input(mut cli)
	cli.last_command_name = name.trim_space()
	runtime := resolve_cli_command_runtime(mut cli, handler_z)!
	cli_debug_log('run_registered_cli_command runtime_ready name="${name}"')
	input := resolve_cli_command_input(mut cli, runtime, args) or {
		return cli_command_input_error(runtime, program, name.trim_space(), err.msg())
	}
	cli_debug_log('run_registered_cli_command input_ready name="${name}" parsed=${input.parsed} positional=${input.positional_args.len}')
	set_cli_command_input(mut cli, name.trim_space(), input)
	cli_debug_log('invoke_cli_command start args=${input.positional_args.len}')
	args_z := cli_args_zval(input.positional_args)
	cli_debug_log('invoke_cli_command args_ready raw=${usize(args_z.raw)} valid=${args_z.is_valid()} type=${args_z.type_name()}')
	cli_z := cli_self_zval(&cli)
	cli_debug_log('invoke_cli_command cli_ready raw=${usize(cli_z.raw)} valid=${cli_z.is_valid()} type=${cli_z.type_name()}')
	runtime_is_command_object := input.parsed && runtime.is_object() && runtime.method_exists('handle')
	mut code := 0
	if runtime_is_command_object {
		cli_debug_log('invoke_cli_command runtime=object')
		bind_cli_runtime_to_command(mut cli, runtime)
		cli_debug_log('invoke_cli_command object_handle enter')
		code = cli_command_exit_code(runtime.method_owned_request('handle', [
			args_z,
			cli_z,
		]))
		cli_debug_log('invoke_cli_command object_handle exit code=${code}')
		cli_debug_log('run_registered_cli_command exit name="${name}" code=${code}')
		return code
	}
	if !input.parsed {
		cli_debug_log('invoke_cli_command runtime=callable')
		result := runtime.call_owned_request([args_z, cli_z])
		cli_debug_log('invoke_cli_command callable_result raw=${usize(result.raw)} valid=${result.is_valid()} type=${result.type_name()}')
		if !result.is_valid() {
			return error('command handler must be callable or expose handle(array \$args, VSlim\\Cli\\App \$cli)')
		}
		code = cli_command_exit_code(result)
		cli_debug_log('invoke_cli_command callable exit code=${code}')
		cli_debug_log('run_registered_cli_command exit name="${name}" code=${code}')
		return code
	}
	return error('command handler must be callable or expose handle(array \$args, VSlim\\Cli\\App \$cli)')
}

fn run_registered_cli_command(mut cli VSlimCliApp, name string, args []string) !int {
	return run_registered_cli_command_with_program(mut cli, name, args, '')
}

@[php_method]
pub fn (mut cli VSlimCliApp) construct() &VSlimCliApp {
	ensure_cli_core_app(mut cli)
	ensure_cli_registry(mut cli)
	cli.project_root = ''
	reset_cli_command_input(mut cli)
	return &cli
}

@[php_return_type: 'VSlim\\App']
@[php_method]
pub fn (mut cli VSlimCliApp) app() vphp.Value {
	return vphp.Value.from_zval(wrap_runtime_app_zval(ensure_cli_core_app(mut cli)))
}

@[php_method]
pub fn (mut cli VSlimCliApp) command(name string, handler vphp.BorrowedValue) &VSlimCliApp {
	ensure_cli_registry(mut cli)
	command_name := name.trim_space().clone()
	if command_name == '' {
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
	clear_cli_command_metadata(mut cli, command_name)
	cli.command_handlers[command_name] = vphp.PersistentOwnedZVal.from_zval(handler_z)
	cli.command_canonical[command_name] = command_name.clone()
	apply_cli_command_metadata(mut cli, command_name, handler_z) or {
		vphp.throw_exception_class('InvalidArgumentException', err.msg(), 0)
		return &cli
	}
	return &cli
}

@[php_arg_type: 'commands=iterable']
@[php_method: 'commandMany']
pub fn (mut cli VSlimCliApp) command_many(commands vphp.BorrowedValue) &VSlimCliApp {
	ensure_cli_registry(mut cli)
	normalized := psr16_iterable_to_array(commands.to_zval()) or {
		vphp.throw_exception_class('InvalidArgumentException', 'commands must be iterable',
			0)
		return &cli
	}
	for key in normalized.assoc_keys() {
		handler := normalized.get(key) or { continue }
		cli.command(key, vphp.BorrowedValue.from_zval(handler))
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
			cli.command(name, vphp.BorrowedValue.from_zval(handler))
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
pub fn (cli &VSlimCliApp) options() vphp.Value {
	return cli_dyn_value_to_value(vphp.dyn_value_map(cli.last_options.clone()))
}

@[php_method]
pub fn (cli &VSlimCliApp) arguments() vphp.Value {
	return cli_dyn_value_to_value(vphp.dyn_value_map(cli.last_arguments.clone()))
}

@[php_optional_args: 'default_value']
@[php_method]
pub fn (cli &VSlimCliApp) option(name string, default_value vphp.BorrowedValue) vphp.Value {
	key := name.trim_space()
	if key != '' {
		if value := cli.last_options[key] {
			return cli_dyn_value_to_value(value)
		}
	}
	raw_default := default_value.to_zval()
	if raw_default.is_valid() {
		return vphp.Value.from_zval(raw_default)
	}
	return vphp.Value.new_null()
}

@[php_optional_args: 'default_value']
@[php_method]
pub fn (cli &VSlimCliApp) argument(name string, default_value vphp.BorrowedValue) vphp.Value {
	key := name.trim_space()
	if key != '' {
		if value := cli.last_arguments[key] {
			return cli_dyn_value_to_value(value)
		}
	}
	raw_default := default_value.to_zval()
	if raw_default.is_valid() {
		return vphp.Value.from_zval(raw_default)
	}
	return vphp.Value.new_null()
}

@[php_arg_type: 'args=iterable']
@[php_method]
pub fn (mut cli VSlimCliApp) run(name string, args vphp.BorrowedValue) int {
	arg_list := cli_args_to_array(args.to_zval()) or {
		vphp.throw_exception_class('InvalidArgumentException', 'command args must be iterable',
			0)
		return 1
	}
	return run_registered_cli_command(mut cli, name, arg_list) or {
		error_class := if name.trim_space() == '' || err.msg().contains('must not be empty') {
			'InvalidArgumentException'
		} else {
			'RuntimeException'
		}
		vphp.throw_exception_class(error_class, err.msg(), 0)
		return 1
	}
}

fn (mut cli VSlimCliApp) free() {
	cli_debug_log('cli.free enter handlers=${cli.command_handlers.len} core_valid=${cli.core_app_zref.is_valid()} core_raw=${usize(cli.core_app_zref.to_zval().raw)}')
	mut handler_names := []string{}
	for key, _ in cli.command_handlers {
		handler_names << key.clone()
	}
	for key in handler_names {
		mut handler := cli.command_handlers[key] or { continue }
		handler.release()
		cli.command_handlers.delete(key)
	}
	cli_debug_log('cli.free handlers_released')
	cli.core_app_ref = unsafe { nil }
	mut core_app_zref := cli.core_app_zref
	cli.core_app_zref = vphp.PersistentOwnedZVal.invalid()
	core_app_zref.release()
	cli_debug_log('cli.free core_app_released')
	unsafe {
		handler_names.free()
		cli.command_handlers.free()
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
	cli_debug_log('cli.free exit')
}
