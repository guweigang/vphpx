module main

import vphp

fn cli_bootstrap_file_return_error(path string) string {
	return 'CLI bootstrap file "${path}" must return iterable commands/spec, callable, or VSlim\\Cli\\App'
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
		return
	}
	result := vphp.include(clean)
	apply_cli_bootstrap_file_result(mut cli, clean, result)!
}

fn cli_bootstrap_dir_apply(mut cli VSlimCliApp, path string) ! {
	clean := normalize_bootstrap_dir_path(path)
	if clean == '' {
		return error('CLI bootstrap directory must not be empty')
	}
	if clean.ends_with('.php') && php_is_file(clean) {
		cli_bootstrap_file_apply(mut cli, clean)!
		return
	}
	project_root := if is_bootstrap_dir_path(clean) { path_dirname(clean) } else { clean }
	if project_root == '' {
		return error('CLI bootstrap directory has no project root')
	}
	cli.project_root = project_root
	mut core := ensure_cli_core_app(mut cli)
	mut shared_applied := false
	app_candidates := [path_join(project_root, 'bootstrap/app.php'),
		path_join(project_root, 'app.php')]
	for candidate in app_candidates {
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

fn apply_cli_bootstrap_spec(mut cli VSlimCliApp, spec vphp.ZVal) ! {
	normalized := normalize_app_bootstrap_spec(spec)!
	if cli_bootstrap_has_meta_keys(normalized) {
		if commands := app_bootstrap_lookup(normalized, ['commands']) {
			cli.command_many(vphp.BorrowedValue.from_zval(commands))
		}
		if should_boot := app_bootstrap_bool(normalized, ['boot']) {
			if should_boot {
				mut core := ensure_cli_core_app(mut cli)
				core.boot()
			}
		}
		return
	}
	cli.command_many(vphp.BorrowedValue.from_zval(normalized))
}

fn apply_cli_bootstrap_file_result(mut cli VSlimCliApp, path string, value vphp.ZVal) ! {
	if !value.is_valid() || value.is_null() || value.is_undef() {
		return error(cli_bootstrap_file_return_error(path))
	}
	if value.is_callable() {
		_ = value.call_owned_request([cli_self_zval(&cli)])
		return
	}
	if value.is_object() && value.is_instance_of('VSlim\\Cli\\App') {
		return
	}
	apply_cli_bootstrap_spec(mut cli, value)!
}

fn apply_cli_command_class_conventions(mut cli VSlimCliApp, project_root string) !bool {
	mut applied := false
	for file in php_glob_paths(path_join(project_root, 'app/Commands/*.php')) {
		_ = php_include_once(file)
		class_name := 'App\\Commands\\' + path_file_stem(file)
		if !php_class_exists(class_name) {
			return error('command convention file "${file}" must declare class ${class_name}')
		}
		name := derive_command_name_from_handler(vphp.RequestOwnedZVal.new_string(class_name).to_zval())!
		cli.command(name, vphp.BorrowedValue.from_zval(vphp.RequestOwnedZVal.new_string(class_name).to_zval()))
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
		raw := vphp.include(cli_bootstrap_path)
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
