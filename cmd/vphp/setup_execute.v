module main

import os
import rand

type SetupRunner = fn ([]string) !

fn elevated_setup_command(args []string, host SetupHost) []string {
	if args[0] in ['apt-get', 'dnf', 'yum', 'pacman', 'zypper', 'apk'] && !host.is_root && host.elevation != '' {
		return [host.elevation, ...args]
	}
	return args
}

fn run_setup_command(args []string) ! {
	mut command := args.clone()
	command[0] = find_program(command[0]) or { command[0] }
	println('Running: ' + command.map(os.quoted_path(it)).join(' '))
	if os.system_args(command) != 0 {
		return error('installation failed: ${args[0]}; fix the reported error and rerun vphp setup')
	}
}

fn bootstrap_homebrew(yes bool, runner SetupRunner) ! {
	directory := os.join_path(os.temp_dir(), 'vphp-homebrew-${rand.uuid_v4()}')
	os.mkdir(directory)!
	defer { os.rmdir_all(directory) or {} }
	script := os.join_path(directory, 'install.sh')
	println('Installing Homebrew and Apple Command Line Tools using the official Homebrew installer.')
	println('Administrator authentication or an Apple installation window may require your interaction. Setup will continue when installation finishes.')
	runner(['curl', '--fail', '--location', '--proto', '=https', '--proto-redir', '=https', '--tlsv1.2',
		'--output', script, homebrew_installer_url])!
	if !os.is_file(script) || os.file_size(script) == 0 {
		return error('Homebrew installer download was empty; no script was executed')
	}
	if yes {
		// Authenticate before NONINTERACTIVE switches the official installer to sudo -n.
		runner(['sudo', '-v'])!
		runner(['/usr/bin/env', 'NONINTERACTIVE=1', '/bin/bash', script])!
	} else {
		runner(['/bin/bash', script])!
	}
}

fn alpine_php_package(catalog string, preferred string) !string {
	mut candidates := []string{}
	for line in catalog.split_into_lines() {
		entry := line.trim_space()
		name := entry.all_before('-')
		if entry != name && (entry.all_after('-') == '' || !entry.all_after('-')[0].is_digit()) {
			continue
		}
		if name.len == 5 && name.starts_with('php') && name[3..].bytes().all(it.is_digit())
			&& name[3..].int() >= 82 && name[3..].int() <= 86 {
			if preferred == '' || name == 'php${preferred}' { candidates << name }
		}
	}
	candidates.sort()
	if candidates.len == 0 {
		return error('Alpine repositories do not provide matching PHP 8.2–8.6 packages; enable the matching official community repository or select VPHP_PHP and VPHP_PHP_CONFIG')
	}
	return candidates.last()
}

fn install_alpine_php(host SetupHost) ! {
	run_setup_command(elevated_setup_command(['apk', 'update'], host))!
	// apk -x treats its argument as an exact package name, not a glob.
	catalog := run_tool(['apk', 'search', '-q', 'php8*'])!
	mut preferred := ''
	metadata := os.exec([selected_php(), '-n', '-r', 'echo PHP_MAJOR_VERSION, PHP_MINOR_VERSION;'])
	if metadata.exit_code == 0 && metadata.output.trim_space().bytes().all(it.is_digit()) {
		preferred = metadata.output.trim_space()
	} else {
		sdk := os.exec([selected_php_config(), '--version'])
		parts := sdk.output.trim_space().split('.')
		if sdk.exit_code == 0 && parts.len >= 2 { preferred = parts[0] + parts[1] }
	}
	package := alpine_php_package(catalog, preferred)!
	// Confirm the dev subpackage exists before installing a different PHP family.
	dev := run_tool(['apk', 'search', '-x', '-q', '${package}-dev'])!
	if !dev.split_into_lines().any(it.trim_space() == '${package}-dev' || it.trim_space().starts_with('${package}-dev-')) {
		return error('Alpine repository is missing ${package}-dev; no PHP packages were installed')
	}
	run_setup_command(elevated_setup_command(['apk', 'add', '--no-cache', package, '${package}-dev'], host))!
}

fn print_setup_plan(plan DependencyPlan, host SetupHost) {
	for step in plan.steps {
		match step.kind {
			.homebrew {
				println('  Download ${homebrew_installer_url}; run its official Homebrew / Apple CLT installer')
			}
			.alpine_php {
				println('  apk update; select matching PHP 8.2–8.6 CLI and development packages from configured repositories')
			}
			.command {
				println('  ' + elevated_setup_command(step.args, host).map(os.quoted_path(it)).join(' '))
			}
		}
	}
	println('  Verify PHP headers, then compile and load a sample PHP extension')
}

fn verify_setup_build() ! {
	directory := os.join_path(os.temp_dir(), 'vphp-setup-${rand.uuid_v4()}')
	os.mkdir(directory)!
	defer { os.rmdir_all(directory) or {} }
	project := os.join_path(directory, 'setup_probe')
	println('Verifying extension compilation and PHP loading...')
	create_project(project)!
	entry := os.join_path(project, 'extension.v')
	os.write_file(entry, os.read_file(entry)! + "\n@[vphp.PhpExportClass(name: 'VphpSetupProbeException')]\n@[vphp.PhpExtends(name: 'RuntimeException')]\npub struct SetupProbeException {}\n")!
	probe_script := os.join_path(project, 'tests', 'smoke.php')
	os.write_file(probe_script, os.read_file(probe_script)! + "\nif (!is_subclass_of('VphpSetupProbeException', RuntimeException::class)) {\n    throw new RuntimeException('Internal parent reflection failed');\n}\n")!
	run(Command{ action: 'build', project: project })!
	output := run_tool([selected_php(), '-n', '-d',
		'extension=${os.join_path(project, 'build', 'setup_probe.so')}',
		os.join_path(project, 'tests', 'smoke.php')])!
	if output.trim_space() != 'OK' {
		return error('sample PHP extension did not pass its smoke test: ${output.trim_space()}')
	}
	println('Compiled and loaded a PHP extension successfully.')
}

fn setup_dependencies(apply bool, yes bool) ! {
	host := detect_setup_host()
	if host.platform == 'windows' {
		println('Windows setup is manual: install V, PHP x64 NTS, MSVC, and the matching PHP devel pack; set VPHP_PHP_SDK to the devel pack directory.')
		return doctor()
	}
	if host.platform !in ['macos', 'linux'] {
		return error('setup currently supports macOS and Linux')
	}
	println('Setup platform: ${host.platform}${if host.distribution != '' {
		' / ' + host.distribution
	} else {
		''
	}}')
	checks := inspect_dependencies()!
	print_dependency_checks(checks)
	v_directory := managed_v_directory()
	plan := dependency_plan(checks, host, v_directory, os.exists(v_directory) || os.is_link(v_directory))
	if checks.all(it.ok) { println('Dependencies are ready; nothing to install.') }
	print_setup_plan(plan, host)
	if plan.blockers.len > 0 { return error(plan.blockers.join('\n')) }
	if !apply {
		println('Preview only. Run vphp setup to install dependencies and verify the build. System authentication may be required.')
		return
	}
	for step in plan.steps {
		match step.kind {
			.homebrew { bootstrap_homebrew(yes, run_setup_command)! }
			.alpine_php { install_alpine_php(host)! }
			.command {
				if step.args[0] == 'git' { os.mkdir_all(os.dir(v_directory))! }
				run_setup_command(elevated_setup_command(step.args, host))!
				if step.args[0] == 'git' && step.args[1] == 'clone' {
					os.write_file(os.join_path(v_directory, '.vphp-managed'), 'https://github.com/guweigang/vlang.git\n')!
				}
			}
		}
	}
	doctor()!
	verify_setup_build()!
	println('Setup complete. You can now run vphp new <extension>.')
}
