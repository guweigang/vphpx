module clix

import appx
import loggerx
import vphp

fn (mut cli VSlimCliApp) ensure_core_app() &appx.VSlimApp {
	if cli.core_app_ref == unsafe { nil } {
		cli.core_app_ref = appx.VSlimApp.new_core()
		loggerx.cli_debug_log('ensure_cli_core_app new cli=${usize(cli)} core=${usize(cli.core_app_ref)}')
	}
	return cli.core_app_ref
}

fn (mut cli VSlimCliApp) ensure_registry() {
	if cli.command_handlers.len == 0 {
		cli.command_handlers = map[string]vphp.PhpValue{}
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

fn (cli &VSlimCliApp) trace_label() string {
	if unsafe { isnil(cli) } {
		return 'trace=nil'
	}
	trace := cli.current_trace.trim_space()
	if trace == '' {
		return 'trace=idle cli=${usize(cli)}'
	}
	return trace
}

fn (cli &VSlimCliApp) trace_message(message string) string {
	return '[${cli.trace_label()}] ${message}'
}

fn (cli &VSlimCliApp) wrap_runtime_value() vphp.PhpValue {
	unsafe {
		if isnil(cli) {
			return vphp.PhpValue.null()
		}
		loggerx.cli_debug_log(cli.trace_message('wrap_runtime_cli_value enter cli=${usize(cli)}'))
		payload := vphp.bind_borrowed_object_value[VSlimCliApp](cli)
		loggerx.cli_debug_log(cli.trace_message('wrap_runtime_cli_value exit cli=${usize(cli)} valid=${payload.is_valid()} type=${payload.type_name()}'))
		return payload
	}
}

fn (cli &VSlimCliApp) self_value() vphp.PhpValue {
	return cli.wrap_runtime_value()
}

fn derive_command_name_from_handler(handler vphp.PhpValue) !string {
	if handler.is_valid() && handler.is_string() {
		return derive_command_name_from_handler_name(handler.to_string())
	}
	if handler.is_valid() && handler.is_object() {
		name := command_name_from_short_name(short_class_name(handler.class_name()))
		if name == '' {
			loggerx.cli_debug_log('derive_command_name_from_handler object empty class="${handler.class_name()}"')
			return error('command name must not be empty')
		}
		return name
	}
	return error('command name cannot be derived from anonymous callable; use command(name, handler)')
}

struct CliPhpValueSubject {
	value vphp.PhpValue
}

fn cli_value_subject(value vphp.PhpValue) CliPhpValueSubject {
	return CliPhpValueSubject{
		value: value
	}
}

fn (subject CliPhpValueSubject) cli_command_handler_input() !vphp.PhpValue {
	raw := subject.value
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
		mut out := vphp.PhpString.of(class_name)
		return out.take_value()
	}
	return error('command handler must be callable, object, or class-string')
}

fn cli_command_exit_code(result vphp.PhpValue) int {
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

fn cli_args_to_array(raw vphp.PhpIterable) ![]string {
	mut normalized := raw.to_array()!
	defer {
		normalized.release()
	}
	mut out := []string{}
	for idx := 0; idx < normalized.count(); idx++ {
		out << normalized.index_value(idx).to_string()
	}
	return out
}

fn (mut cli VSlimCliApp) resolve_command_runtime(handler vphp.PhpValue) !vphp.PhpValue {
	if handler.is_valid() && handler.is_string() {
		class_name := handler.to_string().trim_space()
		if class_name == '' {
			return error('command class name must not be empty')
		}
		if handler_string_is_function_callable(class_name) {
			mut out := vphp.PhpString.of(class_name)
			return out.take_value()
		}
		return cli.resolve_command_class_runtime(class_name)
	}
	return handler.owned()
}

fn (mut cli VSlimCliApp) resolve_command_class_runtime(class_name string) !vphp.PhpValue {
	mut class_arg := vphp.PhpString.of(class_name)
	mut autoload_arg := vphp.PhpBool.of(true)
	defer {
		class_arg.release()
		autoload_arg.release()
	}
	exists := vphp.PhpFunction.named('class_exists').result_bool(class_arg, autoload_arg)
	if !exists {
		return error('command class "${class_name}" does not exist')
	}
	mut core := cli.ensure_core_app()
	mut container := core.container()
	if container.has(class_name) {
		return container.get(class_name).owned()
	}
	mut command := vphp.PhpClass.named(class_name).construct() or {
		return error('command class "${class_name}" could not be constructed')
	}
	return command.take_value()
}

fn (cli &VSlimCliApp) lookup_command_handler(name string) !vphp.PhpValue {
	command_name := name.trim_space()
	if command_name == '' {
		loggerx.cli_debug_log('lookup_cli_command_handler empty name raw="${name}"')
		return error('command name must not be empty')
	}
	handler := cli.command_handlers[command_name] or {
		return error('command "${command_name}" is not registered')
	}
	return handler.owned()
}

fn cli_release_command_handler(mut handler vphp.PhpValue) {
	if handler.is_object() {
		return
	}
	handler.release()
}

fn (cli &VSlimCliApp) canonical_command_name(name string) string {
	command_name := name.trim_space().clone()
	if command_name == '' {
		return ''
	}
	return (cli.command_canonical[command_name] or { command_name }).clone()
}

fn (cli &VSlimCliApp) hidden_command(name string) bool {
	canonical := cli.canonical_command_name(name)
	if canonical == '' {
		return false
	}
	return cli.command_hidden[canonical] or { false }
}

fn (cli &VSlimCliApp) command_aliases_for_listing(name string) []string {
	canonical := cli.canonical_command_name(name)
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

fn (mut cli VSlimCliApp) clear_command_metadata(canonical_name string) {
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

fn (mut cli VSlimCliApp) apply_command_metadata(canonical_name string, handler vphp.PhpValue) ! {
	canonical := canonical_name.trim_space().clone()
	cli.clear_command_metadata(canonical)
	cli.command_canonical[canonical] = canonical.clone()
	if handler.is_valid() && handler.is_object() && handler.class_name() == 'Closure' {
		cli.command_hidden[canonical] = false
		return
	}
	mut runtime := cli.resolve_command_runtime(handler)!
	defer {
		runtime.release()
	}
	cli.command_hidden[canonical] = command_metadata_hidden(runtime)
	aliases := command_metadata_aliases(runtime)
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
		cli.command_handlers[alias_name] = handler.retain()
		cli.command_canonical[alias_name] = canonical.clone()
		registered_aliases << alias_name.clone()
	}
	if registered_aliases.len > 0 {
		cli.command_aliases[canonical] = registered_aliases
	}
}

fn (mut cli VSlimCliApp) run_registered_cli_command_with_program(name string, args []string, program string) !int {
	command_name := name.trim_space().clone()
	cli.current_trace = 'trace=cmd:${command_name} cli=${usize(cli)} core=${usize(cli.core_app_ref)}'
	defer {
		cli.current_trace = ''
	}
	loggerx.cli_debug_log(cli.trace_message('run_registered_cli_command start name="${command_name}" args=${args.len}'))
	mut handler := cli.lookup_command_handler(command_name)!
	defer {
		handler.release()
	}
	cli.reset_command_input()
	cli.last_command_name = command_name.clone()
	mut runtime := cli.resolve_command_runtime(handler)!
	defer {
		runtime.release()
	}
	input := cli.resolve_command_input(runtime, args) or {
		return cli_command_input_error(runtime, program, command_name, err.msg())
	}
	args_copy := clone_string_slice(input.positional_args)
	cli.set_command_input(command_name, input)
	mut args_arr := vphp.PhpArray.new()
	for arg in args_copy {
		args_arr.push_string(arg)
	}
	defer {
		args_arr.release()
	}
	mut cli_value := cli.self_value()
	defer {
		cli_value.release()
	}
	runtime_is_command_object := runtime.is_object() && runtime.method_exists('handle')
	mut code := 0
	if runtime_is_command_object {
		mut result := runtime.require_object() or { vphp.PhpObject.invalid() }.call_method('handle',
			args_arr, cli_value)
		defer {
			result.release()
		}
		code = cli_command_exit_code(result)
	} else {
		mut result := runtime.require_callable() or { vphp.PhpCallable.invalid() }.invoke(args_arr,
			cli_value)
		defer {
			result.release()
		}
		code = cli_command_exit_code(result)
	}
	loggerx.cli_debug_log(cli.trace_message('run_registered_cli_command exit name="${command_name}" code=${code}'))
	return code
}

fn (mut cli VSlimCliApp) run_registered_cli_command(name string, args []string) !int {
	return cli.run_registered_cli_command_with_program(name, args, '')
}

@[php_method]
pub fn (mut cli VSlimCliApp) construct() &VSlimCliApp {
	loggerx.cli_debug_reset_overrides()
	cli.ensure_core_app()
	cli.ensure_registry()
	cli.project_root = ''
	cli.reset_command_input()
	loggerx.cli_debug_log('cli.construct cli=${usize(&cli)} core=${usize(cli.core_app_ref)}')
	return &cli
}

@[php_return_type: 'VSlim\\App']
@[php_method]
pub fn (mut cli VSlimCliApp) app() vphp.PhpValue {
	return cli.ensure_core_app().self_value()
}

@[php_method: 'projectRoot']
pub fn (cli &VSlimCliApp) project_root_value() string {
	return cli.project_root
}

@[php_method: 'debugBridgePath']
pub fn (cli &VSlimCliApp) debug_bridge_path(path string) vphp.PhpValue {
	mut path_arg := vphp.PhpString.of(path)
	defer {
		path_arg.release()
	}
	echoed := vphp.PhpFunction.named('strval').result_string(path_arg)
	mut format_arg := vphp.PhpString.of('%s/%s')
	mut bootstrap_arg := vphp.PhpString.of('bootstrap/app.php')
	defer {
		format_arg.release()
		bootstrap_arg.release()
	}
	joined := vphp.PhpFunction.named('sprintf').result_string(format_arg, path_arg, bootstrap_arg)
	mut echoed_arg := vphp.PhpString.of(echoed)
	defer {
		echoed_arg.release()
	}
	echoed_joined := vphp.PhpFunction.named('sprintf').result_string(format_arg, echoed_arg,
		bootstrap_arg)
	return vphp.DynValue.of_map({
		'original':     vphp.DynValue.of_string(path)
		'strval':       vphp.DynValue.of_string(echoed)
		'sprintf':      vphp.DynValue.of_string(joined)
		'sprintf_echo': vphp.DynValue.of_string(echoed_joined)
	}).to_value() or { vphp.PhpValue.null() }
}

@[php_method]
pub fn (mut cli VSlimCliApp) command(name string, handler vphp.PhpValue) &VSlimCliApp {
	cli.ensure_registry()
	loggerx.cli_debug_log('command enter cli=${usize(&cli)} raw_name="${name}" raw_len=${name.len} handler_type=${handler.kind_name()}')
	command_name := name.trim_space().clone()
	loggerx.cli_debug_log('command normalized cli=${usize(&cli)} command_name="${command_name}" len=${command_name.len}')
	if command_name == '' {
		loggerx.cli_debug_log('command empty raw_name="${name}" raw_len=${name.len}')
		vphp.PhpException.raise_class('InvalidArgumentException', 'command name must not be empty',
			0)
		return &cli
	}
	mut handler_value := cli_value_subject(handler).cli_command_handler_input() or {
		vphp.PhpException.raise_class('InvalidArgumentException', err.msg(), 0)
		return &cli
	}
	defer {
		handler_value.release()
	}
	existing_canonical := cli.command_canonical[command_name] or { command_name }
	if command_name in cli.command_handlers && existing_canonical != command_name {
		vphp.PhpException.raise_class('InvalidArgumentException',
			'command name "${command_name}" is already registered as an alias for "${existing_canonical}"',
			0)
		return &cli
	}
	if command_name !in cli.command_handlers {
		cli.command_order << command_name.clone()
	}
	loggerx.cli_debug_log('command register cli=${usize(&cli)} command_name="${command_name}" order_len=${cli.command_order.len} handlers_len=${cli.command_handlers.len}')
	cli.clear_command_metadata(command_name)
	cli.command_handlers[command_name] = handler_value.retain()
	cli.command_canonical[command_name] = command_name.clone()
	cli.apply_command_metadata(command_name, handler_value) or {
		vphp.PhpException.raise_class('InvalidArgumentException', err.msg(), 0)
		return &cli
	}
	loggerx.cli_debug_log('command exit cli=${usize(&cli)} command_name="${command_name}" order=${cli.command_order}')
	return &cli
}

fn (mut cli VSlimCliApp) command_class(name string, class_name string) &VSlimCliApp {
	mut handler := vphp.PhpString.of(class_name)
	mut handler_value := handler.take_value()
	defer {
		handler_value.release()
	}
	return cli.command(name, handler_value)
}

@[php_method: 'commandMany']
pub fn (mut cli VSlimCliApp) command_many(commands vphp.PhpIterable) &VSlimCliApp {
	cli.ensure_registry()
	mut normalized := commands.to_array() or {
		vphp.PhpException.raise_class('InvalidArgumentException', 'commands must be iterable', 0)
		return &cli
	}
	defer {
		normalized.release()
	}
	for key in normalized.assoc_keys() {
		handler := normalized.value(key) or { continue }
		cli.command(key, handler)
	}
	if normalized.is_list() {
		for idx := 0; idx < normalized.count(); idx++ {
			handler := normalized.index_value(idx)
			if !handler.is_valid() || handler.is_null() || handler.is_undef() {
				continue
			}
			name := derive_command_name_from_handler(handler) or {
				vphp.PhpException.raise_class('InvalidArgumentException', err.msg(), 0)
				return &cli
			}.clone()
			cli.command(name, handler)
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
pub fn (cli &VSlimCliApp) options() vphp.PhpValue {
	return vphp.DynValue.of_map(cli.last_options.clone()).to_value() or { vphp.PhpValue.null() }
}

@[php_method]
pub fn (cli &VSlimCliApp) arguments() vphp.PhpValue {
	return vphp.DynValue.of_map(cli.last_arguments.clone()).to_value() or { vphp.PhpValue.null() }
}

@[php_arg_name: 'default_value=defaultValue']
@[php_method]
pub fn (cli &VSlimCliApp) option(name string, default_value ?vphp.PhpValue) vphp.PhpValue {
	key := name.trim_space()
	if key != '' {
		if value := cli.last_options[key] {
			return value.to_value() or { vphp.PhpValue.null() }
		}
	}
	if actual_default := default_value {
		return actual_default.to_request_owned()
	}
	return vphp.PhpValue.null()
}

@[php_arg_name: 'default_value=defaultValue']
@[php_method]
pub fn (cli &VSlimCliApp) argument(name string, default_value ?vphp.PhpValue) vphp.PhpValue {
	key := name.trim_space()
	if key != '' {
		if value := cli.last_arguments[key] {
			return value.to_value() or { vphp.PhpValue.null() }
		}
	}
	if actual_default := default_value {
		return actual_default.to_request_owned()
	}
	return vphp.PhpValue.null()
}

@[php_method]
pub fn (mut cli VSlimCliApp) run(name string, args vphp.PhpIterable) int {
	arg_list := cli_args_to_array(args) or {
		vphp.PhpException.raise_class('InvalidArgumentException', 'command args must be iterable', 0)
		return 1
	}
	cli.last_command_name = name.trim_space().clone()
	return cli.run_registered_cli_command(name, arg_list) or {
		error_class := if name.trim_space() == '' || err.msg().contains('must not be empty') {
			'InvalidArgumentException'
		} else {
			'RuntimeException'
		}
		vphp.PhpException.raise_class(error_class, err.msg(), 0)
		return 1
	}
}

pub fn (mut cli VSlimCliApp) cleanup() {
	loggerx.cli_debug_log('cli.cleanup auto-release entry cli=${usize(&cli)} handlers=${cli.command_handlers.len}')
	// command_handlers is a direct bridge-owned field, so generic_free_raw() will
	// release it after cleanup() returns.
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
	loggerx.cli_debug_reset_overrides()
	loggerx.cli_debug_log('cli.cleanup native done')
}
