module clix

import os
import loggerx
import supportx
import vphp

fn cli_bootstrap_file_return_error(path string) string {
	return 'CLI bootstrap file "${path}" must return iterable commands/spec, callable, or VSlim\\Cli\\App'
}

fn (mut cli VSlimCliApp) bootstrap_file_apply(path string) ! {
	file := supportx.resolve_bootstrap_file(path, 'CLI bootstrap')!
	source := 'cli-file:' + os.real_path(file.resolved_path)
	mut core := cli.ensure_core_app()
	state := core.watch_service_state()
	defer {
		state.close()
	}
	mut progress := supportx.start_bootstrap_progress(mut cli.bootstrap_progress, source)!
	defer {
		progress.stop()
	}
	if core.resume_bootstrap_boot(source)! {
		if file.project_root != '' {
			core.sync_cli_debug_config()
		}
		supportx.finish_bootstrap_progress(mut cli.bootstrap_progress, source)
		return
	}
	cli.apply_cli_bootstrap_file(file, source, mut progress)!
	supportx.finish_bootstrap_progress(mut cli.bootstrap_progress, source)
}

fn (mut cli VSlimCliApp) apply_cli_bootstrap_file(file supportx.BootstrapFile, source string, mut progress supportx.BootstrapProgress) ! {
	mut core := cli.ensure_core_app()
	if file.project_root != '' {
		if core.configure_bootstrap_file(file, mut progress)! {
			core.finish_bootstrap_boot(source)!
		}
		core.sync_cli_debug_config()
		return
	}
	if cli.configure_cli_bootstrap_file(file, mut progress)! {
		core.finish_bootstrap_boot(source)!
	}
}

fn (mut cli VSlimCliApp) configure_cli_bootstrap_file(file supportx.BootstrapFile, mut progress supportx.BootstrapProgress) !bool {
	mut result := progress.load(file.resolved_path)!
	defer {
		result.release()
	}
	return cli.configure_bootstrap_file_result(file.path, result, mut progress)
}

fn (mut cli VSlimCliApp) bootstrap_dir_apply(path string) ! {
	directory := supportx.resolve_bootstrap_directory(path, 'CLI bootstrap directory')!
	loggerx.cli_debug_log('bootstrap_dir input="${path}" clean="${directory.path}"')
	if directory.explicit_file {
		cli.bootstrap_file_apply(directory.path)!
		return
	}
	project_root := directory.project_root
	cli.project_root = project_root
	loggerx.cli_debug_log('project_root="${project_root}"')

	mut core := cli.ensure_core_app()
	source := 'cli-project:' + os.real_path(project_root)
	state := core.watch_service_state()
	defer {
		state.close()
	}
	mut progress := supportx.start_bootstrap_progress(mut cli.bootstrap_progress, source)!
	defer {
		progress.stop()
	}
	if core.resume_bootstrap_boot(source)! {
		supportx.finish_bootstrap_progress(mut cli.bootstrap_progress, source)
		return
	}
	if !progress.done('shared') {
		shared_applied := core.apply_project_bootstrap(project_root, .cli)!
		if vphp.has_exception() {
			return error('shared project bootstrap failed')
		}
		core.sync_cli_debug_config()
		if shared_applied {
			progress.complete('shared:applied')
		}
		progress.complete('shared')
	}
	cli_applied := cli.apply_bootstrap_conventions_with_paths(project_root + '/app/Commands',
		project_root + '/bootstrap/cli.php', source, mut progress)!
	if !progress.done('shared:applied') && !cli_applied {
		supportx.finish_bootstrap_progress(mut cli.bootstrap_progress, source)
		return error('CLI bootstrap directory "${path}" must contain bootstrap/app.php, app.php, shared conventions, or CLI command conventions')
	}
	supportx.finish_bootstrap_progress(mut cli.bootstrap_progress, source)
}

fn (mut cli VSlimCliApp) configure_bootstrap_spec(spec vphp.PhpValue, mut progress supportx.BootstrapProgress) !bool {
	iterable := spec.as_iterable() or { return error('bootstrap spec must be iterable') }
	mut normalized := progress.normalize('cli:spec', iterable)!
	defer {
		normalized.release()
	}
	if vphp.has_exception() {
		return error('CLI bootstrap spec evaluation failed')
	}
	config := supportx.app_bootstrap_spec(normalized)
	boot := config.boot_option()
	if commands := config.lookup(['commands']) {
		command_iter := commands.as_iterable() or {
			return error('bootstrap commands must be iterable')
		}
		cli.apply_bootstrap_command_many(command_iter, mut progress)!
	} else if !boot.is_present() {
		cli.apply_command_array(normalized, mut progress)!
		return false
	}
	enabled := boot.enabled()
	if vphp.has_exception() {
		return error('CLI bootstrap boot option evaluation failed')
	}
	return enabled
}

fn (mut cli VSlimCliApp) configure_bootstrap_file_result(path string, value vphp.PhpValue, mut progress supportx.BootstrapProgress) !bool {
	receiver := &cli
	mut spec := progress.evaluate_file_spec(value, 'VSlim\\Cli\\App',
		cli_bootstrap_file_return_error(path), fn [receiver] () vphp.PhpValue {
			return receiver.self_value()
		})!
	defer {
		spec.release()
	}
	if spec.is_valid() {
		return cli.configure_bootstrap_spec(spec, mut progress)
	}
	return false
}

fn cli_display_path(path string) string {
	return supportx.normalize_dir_path(path).replace('\\', '/')
}

fn (mut cli VSlimCliApp) apply_command_class_conventions_with_paths(commands_dir string, mut progress supportx.BootstrapProgress) !bool {
	mut applied := false
	entries := progress.directory_entries(commands_dir)!
	loggerx.cli_debug_log('commands_dir="${commands_dir}" entries=${entries}')
	for entry in entries {
		if !entry.ends_with('.php') {
			loggerx.cli_debug_log('skip_command_entry="${entry}"')
			continue
		}
		entry_name_for_log := entry.clone()
		file_for_log := (commands_dir + '/' + entry_name_for_log).clone()
		step := 'command:file:' + file_for_log
		if progress.done(step) {
			applied = true
			continue
		}
		display_file_for_log := cli_display_path(file_for_log).clone()
		class_name_for_log := ('App\\Commands\\' + file_stem(entry_name_for_log)).clone()
		loggerx.cli_debug_log('command_entry_preinclude="${entry_name_for_log}" file="${display_file_for_log}" class="${class_name_for_log}"')
		mut included := supportx.include_once_file(file_for_log)
		included.release()
		if vphp.has_exception() {
			return error('CLI command convention file evaluation failed')
		}
		class_exists := supportx.class_exists(class_name_for_log)
		if vphp.has_exception() {
			return error('CLI command convention class lookup failed')
		}
		loggerx.cli_debug_log('command_entry="${entry_name_for_log}" file="${display_file_for_log}" class="${class_name_for_log}" class_exists=${class_exists}')
		if !class_exists {
			return error('command convention file "${display_file_for_log}" must declare class ${class_name_for_log}')
		}
		name := derive_command_name_from_handler_name(class_name_for_log)!
		cli.apply_command_class(name, class_name_for_log)!
		progress.complete(step)
		applied = true
	}
	return applied
}

fn (mut cli VSlimCliApp) apply_bootstrap_conventions_with_paths(commands_dir string, cli_bootstrap_path string, source string, mut progress supportx.BootstrapProgress) !bool {
	mut applied := false
	if cli.apply_command_class_conventions_with_paths(commands_dir, mut progress)! {
		applied = true
	}
	if supportx.is_file(cli_bootstrap_path) {
		file := supportx.resolve_bootstrap_file(cli_bootstrap_path, 'CLI bootstrap')!
		cli.apply_cli_bootstrap_file(file, source, mut progress)!
		applied = true
	}
	return applied
}

@[php_method: 'bootstrapFile']
pub fn (mut cli VSlimCliApp) bootstrap_file(path string) &VSlimCliApp {
	cli.bootstrap_file_apply(path) or { raise_cli_argument_error(err) }
	return &cli
}

@[php_method: 'bootstrapDir']
pub fn (mut cli VSlimCliApp) bootstrap_dir(path string) &VSlimCliApp {
	cli.bootstrap_dir_apply(path) or { raise_cli_argument_error(err) }
	return &cli
}
