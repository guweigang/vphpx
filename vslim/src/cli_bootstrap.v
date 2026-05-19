module main

import os
import vphp

__global (
	vslim_cli_debug_override_inited  bool
	vslim_cli_debug_enabled_override bool
	vslim_cli_debug_file_override    string
)

fn cli_bootstrap_file_return_error(path string) string {
	return 'CLI bootstrap file "${path}" must return iterable commands/spec, callable, or VSlim\\Cli\\App'
}

fn cli_debug_sync_from_app(app &VSlimApp) {
	if app == unsafe { nil } || app.config_ref == unsafe { nil } {
		return
	}
	unsafe {
		if app.config_ref.has('cli.debug') {
			vslim_cli_debug_enabled_override = app.config_ref.get_bool('cli.debug', false)
			vslim_cli_debug_override_inited = true
		}
		if app.config_ref.has('cli.debug_file') {
			vslim_cli_debug_file_override =
				app.config_ref.get_string('cli.debug_file', '').trim_space()
			vslim_cli_debug_override_inited = true
		}
	}
}

fn cli_debug_enabled() bool {
	unsafe {
		if vslim_cli_debug_override_inited {
			return vslim_cli_debug_enabled_override
		}
	}
	return os.getenv('VSLIM_CLI_DEBUG').trim_space().to_lower() in ['1', 'true', 'yes', 'on']
}

fn cli_debug_log(message string) {
	mut debug_file := ''
	unsafe {
		if vslim_cli_debug_override_inited {
			debug_file = vslim_cli_debug_file_override.trim_space()
		}
	}
	if debug_file == '' {
		debug_file = os.getenv('VSLIM_CLI_DEBUG_FILE').trim_space()
	}
	if debug_file == '' && !cli_debug_enabled() {
		return
	}
	mut logger := &VSlimLogger{}
	logger.construct()
	logger.set_channel('vslim.cli')
	logger.set_level(VSlimLogLevel.debug())
	if debug_file != '' {
		logger.console_target = ''
		logger.set_output_file(debug_file)
	} else {
		logger.use_stderr()
	}
	logger.debug('[vslim-cli-debug] ' + message)
	logger.close_engine()
}

fn (mut cli VSlimCliApp) bootstrap_file_apply(path string) ! {
	clean := path.trim_space()
	if clean == '' {
		return error('CLI bootstrap path must not be empty')
	}
	lower := clean.to_lower()
	if (lower.ends_with('/bootstrap/app.php') || lower.ends_with('\\bootstrap\\app.php')
		|| lower.ends_with('/app.php') || lower.ends_with('\\app.php')) && path_is_file(clean) {
		mut core := cli.ensure_core_app()
		mut result := vphp.PhpIncludeFile.at(clean).load()
		defer {
			result.release()
		}
		if path_is_file(clean) {
			project_root := if is_bootstrap_dir_path(path_dirname(clean)) {
				path_dirname(path_dirname(clean))
			} else {
				path_dirname(clean)
			}
			if project_root != '' {
				preload_bootstrap_spec_classes(project_root, result)
			}
		}
		core.apply_bootstrap_file_result(clean, result)!
		cli_debug_sync_from_app(core)
		return
	}
	mut result := vphp.PhpIncludeFile.at(clean).load()
	defer {
		result.release()
	}
	cli.apply_bootstrap_file_result(clean, result)!
}

fn (mut cli VSlimCliApp) bootstrap_dir_apply(path string) ! {
	clean := normalize_bootstrap_dir_path(path)
	cli_debug_log('bootstrap_dir input="${path}" clean="${clean}"')
	if clean == '' {
		return error('CLI bootstrap directory must not be empty')
	}
	if clean.ends_with('.php') && path_is_file(clean) {
		cli.bootstrap_file_apply(clean)!
		return
	}
	project_root := if is_bootstrap_dir_path(clean) { path_dirname(clean) } else { clean }
	cli_debug_log('project_root="${project_root}"')
	if project_root == '' {
		return error('CLI bootstrap directory has no project root')
	}
	cli.project_root = project_root
	mut project_root_arg := vphp.PhpString.of(project_root)
	defer {
		project_root_arg.release()
	}
	project_root_echo := vphp.PhpFunction.named('strval').result_string(project_root_arg)
	mut format_arg := vphp.PhpString.of('%s/%s')
	mut bootstrap_arg := vphp.PhpString.of('bootstrap/app.php')
	defer {
		format_arg.release()
		bootstrap_arg.release()
	}
	bootstrap_candidate_probe := vphp.PhpFunction.named('sprintf').result_string(format_arg,
		project_root_arg, bootstrap_arg)
	cli_debug_log('project_root_echo="${project_root_echo}"')
	cli_debug_log('bootstrap_candidate_probe="${bootstrap_candidate_probe}"')
	bootstrap_candidate := bootstrap_candidate_probe
	mut app_arg := vphp.PhpString.of('app.php')
	defer {
		app_arg.release()
	}
	app_candidate_fallback := vphp.PhpFunction.named('sprintf').result_string(format_arg,
		project_root_arg, app_arg)
	mut shared_applied := false
	cli_debug_log('app_candidate="${bootstrap_candidate}" is_file=${path_is_file(bootstrap_candidate)}')
	if path_is_file(bootstrap_candidate) {
		mut core := cli.ensure_core_app()
		preload_bootstrap_project_classes(project_root)
		mut result := vphp.PhpIncludeFile.at(bootstrap_candidate).load()
		defer {
			result.release()
		}
		project_root_for_candidate := if is_bootstrap_dir_path(path_dirname(bootstrap_candidate)) {
			path_dirname(path_dirname(bootstrap_candidate))
		} else {
			path_dirname(bootstrap_candidate)
		}
		if project_root_for_candidate != '' {
			preload_bootstrap_spec_classes(project_root_for_candidate, result)
		}
		core.apply_bootstrap_file_result(bootstrap_candidate, result)!
		shared_applied = true
	} else {
		app_candidate := app_candidate_fallback
		cli_debug_log('app_candidate="${app_candidate}" is_file=${path_is_file(app_candidate)}')
		if path_is_file(app_candidate) {
			mut core := cli.ensure_core_app()
			preload_bootstrap_project_classes(project_root)
			mut result := vphp.PhpIncludeFile.at(app_candidate).load()
			defer {
				result.release()
			}
			project_root_for_candidate := if is_bootstrap_dir_path(path_dirname(app_candidate)) {
				path_dirname(path_dirname(app_candidate))
			} else {
				path_dirname(app_candidate)
			}
			if project_root_for_candidate != '' {
				preload_bootstrap_spec_classes(project_root_for_candidate, result)
			}
			core.apply_bootstrap_file_result(app_candidate, result)!
			shared_applied = true
		}
	}
	mut core := cli.ensure_core_app()
	if shared_applied && !core.is_booted() {
		core.boot()
	}
	if !shared_applied {
		shared_applied = core.apply_bootstrap_shared_conventions(project_root)!
		if shared_applied && !core.is_booted() {
			core.boot()
		}
	}
	cli_debug_sync_from_app(core)
	mut cli_applied := false
	commands_dir := project_root + '/app/Commands'
	if cli.apply_command_class_conventions_with_paths(commands_dir)! {
		cli_applied = true
	}
	cli_bootstrap_path := project_root + '/bootstrap/cli.php'
	if path_is_file(cli_bootstrap_path) {
		mut raw := vphp.PhpIncludeFile.at(cli_bootstrap_path).load()
		defer {
			raw.release()
		}
		cli.apply_bootstrap_file_result(cli_bootstrap_path, raw)!
		cli_applied = true
	}
	if !shared_applied && !cli_applied {
		return error('CLI bootstrap directory "${path}" must contain bootstrap/app.php, app.php, shared conventions, or CLI command conventions')
	}
}

fn cli_bootstrap_has_meta_keys(spec vphp.PhpArray) bool {
	if _ := app_bootstrap_spec(spec).lookup(['commands']) {
		return true
	}
	if _ := app_bootstrap_spec(spec).lookup(['boot']) {
		return true
	}
	return false
}

fn (mut cli VSlimCliApp) apply_bootstrap_spec(spec vphp.PhpValue) ! {
	normalized := normalize_app_bootstrap_spec(spec)!
	defer {
		normalized.release()
	}
	if cli_bootstrap_has_meta_keys(normalized) {
		if commands := app_bootstrap_spec(normalized).lookup(['commands']) {
			command_iter := commands.as_iterable() or {
				return error('bootstrap commands must be iterable')
			}
			cli.command_many(command_iter)
		}
		if should_boot := app_bootstrap_spec(normalized).bool(['boot']) {
			if should_boot {
				mut core := cli.ensure_core_app()
				core.boot()
			}
		}
		return
	}
	cli.command_many(normalized.to_iterable())
}

fn (mut cli VSlimCliApp) apply_bootstrap_file_result(path string, value vphp.PhpValue) ! {
	if !value.is_valid() || value.is_null() || value.is_undef() {
		return error(cli_bootstrap_file_return_error(path))
	}
	if value.is_callable() {
		handlers_before := cli.command_handlers.len
		cli_debug_log("bootstrap_file_result callable path=\"${path}\" handlers_before=${handlers_before}")
		mut cli_value := cli.self_value()
		defer {
			cli_value.release()
		}
		cli_debug_log('bootstrap_file_result cli_value valid=${cli_value.is_valid()} type=${cli_value.type_name()}')
		callable := value.as_callable() or { return error(cli_bootstrap_file_return_error(path)) }
		mut result := callable.invoke(cli_value)
		defer {
			result.release()
		}
		handlers_after := cli.command_handlers.len
		cli_debug_log('bootstrap_file_result closure_done handlers_before=${handlers_before} handlers_after=${handlers_after} order=${cli.command_order}')
		if !result.is_valid() || result.is_null() || result.is_undef() {
			return
		}
		if result.is_object() && result.is_instance_of('VSlim\\Cli\\App') {
			return
		}
		cli.apply_bootstrap_spec(result)!
		return
	}
	if value.is_object() && value.is_instance_of('VSlim\\Cli\\App') {
		return
	}
	cli.apply_bootstrap_spec(value)!
}

fn cli_display_path(path string) string {
	return normalize_bootstrap_dir_path(path).replace('\\', '/')
}

fn (mut cli VSlimCliApp) apply_command_class_conventions_with_paths(commands_dir string) !bool {
	mut applied := false
	entries := scandir_names(commands_dir)
	cli_debug_log('commands_dir="${commands_dir}" entries=${entries}')
	for entry in entries {
		if !entry.ends_with('.php') {
			cli_debug_log('skip_command_entry="${entry}"')
			continue
		}
		entry_name_for_log := entry.clone()
		file_for_log := (commands_dir + '/' + entry_name_for_log).clone()
		display_file_for_log := cli_display_path(file_for_log).clone()
		class_name_for_log := ('App\\Commands\\' + path_file_stem(entry_name_for_log)).clone()
		cli_debug_log('command_entry_preinclude="${entry_name_for_log}" file="${display_file_for_log}" class="${class_name_for_log}"')
		mut class_name_arg := vphp.PhpString.of(class_name_for_log)
		defer {
			class_name_arg.release()
		}
		_ = include_once_file(commands_dir + '/' + entry)
		mut autoload_arg := vphp.PhpBool.of(true)
		defer {
			autoload_arg.release()
		}
		class_exists := vphp.PhpFunction.named('class_exists').result_bool(class_name_arg,
			autoload_arg)
		cli_debug_log('command_entry="${entry_name_for_log}" file="${display_file_for_log}" class="${class_name_for_log}" class_exists=${class_exists}')
		if !class_exists {
			return error('command convention file "${display_file_for_log}" must declare class ${class_name_for_log}')
		}
		name := derive_command_name_from_handler_name(class_name_for_log)!
		cli.command_class(name, class_name_for_log)
		applied = true
	}
	return applied
}

fn (mut cli VSlimCliApp) apply_bootstrap_conventions_with_paths(commands_dir string, cli_bootstrap_path string) !bool {
	mut applied := false
	if cli.apply_command_class_conventions_with_paths(commands_dir)! {
		applied = true
	}
	if path_is_file(cli_bootstrap_path) {
		mut raw := vphp.PhpIncludeFile.at(cli_bootstrap_path).load()
		defer {
			raw.release()
		}
		cli.apply_bootstrap_file_result(cli_bootstrap_path, raw)!
		applied = true
	}
	return applied
}

@[php_method: 'bootstrapFile']
pub fn (mut cli VSlimCliApp) bootstrap_file(path string) &VSlimCliApp {
	cli.bootstrap_file_apply(path) or {
		vphp.PhpException.raise_class('InvalidArgumentException', err.msg(), 0)
	}
	return &cli
}

@[php_method: 'bootstrapDir']
pub fn (mut cli VSlimCliApp) bootstrap_dir(path string) &VSlimCliApp {
	cli.bootstrap_dir_apply(path) or {
		vphp.PhpException.raise_class('InvalidArgumentException', err.msg(), 0)
	}
	return &cli
}
