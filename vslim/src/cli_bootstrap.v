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
			vslim_cli_debug_file_override = app.config_ref.get_string('cli.debug_file', '').trim_space()
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
	if debug_file != '' {
		line := '[vslim-cli-debug] ' + message + '\n'
		mut file := os.open_append(debug_file) or {
			mut created := os.create(debug_file) or { return }
			created.write_string(line) or {}
			created.close()
			return
		}
		file.write_string(line) or {}
		file.close()
		return
	}
	if !cli_debug_enabled() {
		return
	}
	eprintln('[vslim-cli-debug] ' + message)
}

fn cli_bootstrap_file_apply(mut cli VSlimCliApp, path string) ! {
	clean := path.trim_space()
	if clean == '' {
		return error('CLI bootstrap path must not be empty')
	}
	lower := clean.to_lower()
	if (lower.ends_with('/bootstrap/app.php') || lower.ends_with('\\bootstrap\\app.php')
		|| lower.ends_with('/app.php') || lower.ends_with('\\app.php')) && php_is_file(clean) {
		mut core := ensure_cli_core_app(mut cli)
		core.bootstrap_file(clean)
		cli_debug_sync_from_app(core)
		return
	}
	mut result := vphp.include(clean)
	defer {
		result.release()
	}
	apply_cli_bootstrap_file_result(mut cli, clean, result)!
}

fn cli_bootstrap_dir_apply(mut cli VSlimCliApp, path string) ! {
	clean := normalize_bootstrap_dir_path(path)
	cli_debug_log('bootstrap_dir input="${path}" clean="${clean}"')
	if clean == '' {
		return error('CLI bootstrap directory must not be empty')
	}
	if clean.ends_with('.php') && php_is_file(clean) {
		cli_bootstrap_file_apply(mut cli, clean)!
		return
	}
	project_root := if is_bootstrap_dir_path(clean) { path_dirname(clean) } else { clean }
	cli_debug_log('project_root="${project_root}"')
	if project_root == '' {
		return error('CLI bootstrap directory has no project root')
	}
	cli.project_root = project_root
	mut core := ensure_cli_core_app(mut cli)
	mut shared_applied := false
	app_candidates := [path_join(project_root, 'bootstrap/app.php'),
		path_join(project_root, 'app.php')]
	for candidate in app_candidates {
		cli_debug_log('app_candidate="${candidate}" is_file=${php_is_file(candidate)}')
		if php_is_file(candidate) {
			core.bootstrap_file(candidate)
			shared_applied = true
			break
		}
	}
	if shared_applied && !core.is_booted() {
		core.boot()
	}
	if !shared_applied {
		shared_applied = apply_bootstrap_shared_conventions(mut core, project_root)!
		if shared_applied && !core.is_booted() {
			core.boot()
		}
	}
	cli_debug_sync_from_app(core)
	cli_applied := apply_cli_bootstrap_conventions(mut cli, project_root)!
	if !shared_applied && !cli_applied {
		return error('CLI bootstrap directory "${path}" must contain bootstrap/app.php, app.php, shared conventions, or CLI command conventions')
	}
}

fn cli_bootstrap_has_meta_keys(spec vphp.ZVal) bool {
	if _ := app_bootstrap_lookup(spec, ['commands']) {
		return true
	}
	if _ := app_bootstrap_lookup(spec, ['boot']) {
		return true
	}
	return false
}

fn apply_cli_bootstrap_spec(mut cli VSlimCliApp, spec vphp.ZVal, project_root string) ! {
	normalized := normalize_app_bootstrap_spec(spec)!
	if cli_bootstrap_has_meta_keys(normalized) {
		if commands := app_bootstrap_lookup(normalized, ['commands']) {
			preload_bootstrap_iterable_project_classes(commands, project_root)
			cli.command_many(vphp.borrow_zbox(commands))
		}
		if should_boot := app_bootstrap_bool(normalized, ['boot']) {
			if should_boot {
				mut core := ensure_cli_core_app(mut cli)
				core.boot()
			}
		}
		return
	}
	cli.command_many(vphp.borrow_zbox(normalized))
}

fn apply_cli_bootstrap_file_result(mut cli VSlimCliApp, path string, value vphp.ZVal) ! {
	project_root := bootstrap_project_root_from_file(path)
	if !value.is_valid() || value.is_null() || value.is_undef() {
		return error(cli_bootstrap_file_return_error(path))
	}
	if value.is_callable() {
		mut cli_z := cli_self_zval(&cli)
		defer {
			cli_z.release()
		}
		mut result := vphp.call_request_owned_box(value, [cli_z])
		defer {
			result.release()
		}
		result_z := result.to_zval()
		if !result_z.is_valid() || result_z.is_null() || result_z.is_undef() {
			return
		}
		if result_z.is_object() && result_z.is_instance_of('VSlim\\Cli\\App') {
			return
		}
		apply_cli_bootstrap_spec(mut cli, result_z, project_root)!
		return
	}
	if value.is_object() && value.is_instance_of('VSlim\\Cli\\App') {
		return
	}
	apply_cli_bootstrap_spec(mut cli, value, project_root)!
}

fn cli_display_path(path string) string {
	return normalize_bootstrap_dir_path(path).replace('\\', '/')
}

fn apply_cli_command_class_conventions(mut cli VSlimCliApp, project_root string) !bool {
	mut applied := false
	commands_dir := path_join(project_root, 'app/Commands')
	entries := php_scandir_names(commands_dir)
	cli_debug_log('commands_dir="${commands_dir}" entries=${entries}')
	for entry in entries {
		if !entry.ends_with('.php') {
			cli_debug_log('skip_command_entry="${entry}"')
			continue
		}
		entry_name := entry.clone()
		file := path_join(commands_dir, entry_name).clone()
		display_file := cli_display_path(file).clone()
		class_name := ('App\\Commands\\' + path_file_stem(entry_name)).clone()
		cli_debug_log('command_entry_preinclude="${entry_name}" file="${display_file}" class="${class_name}"')
		_ = php_include_once(file)
		class_exists := php_class_exists(class_name)
		cli_debug_log('command_entry="${entry_name}" file="${display_file}" class="${class_name}" class_exists=${class_exists}')
		if !class_exists {
			return error('command convention file "${display_file}" must declare class ${class_name}')
		}
		mut class_name_z := vphp.RequestOwnedZBox.new_string(class_name).to_zval()
		defer {
			class_name_z.release()
		}
		name := derive_command_name_from_handler(class_name_z)!
		cli.command(name, vphp.borrow_zbox(class_name_z))
		applied = true
	}
	return applied
}

fn apply_cli_bootstrap_conventions(mut cli VSlimCliApp, project_root string) !bool {
	mut applied := false
	if apply_cli_command_class_conventions(mut cli, project_root)! {
		applied = true
	}
	cli_bootstrap_path := path_join(project_root, 'bootstrap/cli.php')
	if php_is_file(cli_bootstrap_path) {
		mut raw := vphp.include(cli_bootstrap_path)
		defer {
			raw.release()
		}
		apply_cli_bootstrap_file_result(mut cli, cli_bootstrap_path, raw)!
		applied = true
	}
	return applied
}

@[php_method: 'bootstrapFile']
pub fn (mut cli VSlimCliApp) bootstrap_file(path string) &VSlimCliApp {
	cli_bootstrap_file_apply(mut cli, path) or {
		vphp.throw_exception_class('InvalidArgumentException', err.msg(), 0)
	}
	return &cli
}

@[php_method: 'bootstrapDir']
pub fn (mut cli VSlimCliApp) bootstrap_dir(path string) &VSlimCliApp {
	cli_bootstrap_dir_apply(mut cli, path) or {
		vphp.throw_exception_class('InvalidArgumentException', err.msg(), 0)
	}
	return &cli
}
