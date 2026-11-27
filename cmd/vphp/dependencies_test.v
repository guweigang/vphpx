module main

import os
import rand

fn test_dependency_command_options() {
	assert parse_command(['doctor'])!.action == 'doctor'
	assert parse_command(['setup'])!.apply
	assert !parse_command(['setup'])!.yes
	assert !parse_command(['setup', '--dry-run'])!.apply
	assert parse_command(['setup', '--yes'])!.apply
	assert parse_command(['setup', '--yes'])!.yes
	for args in [['doctor', '--yes'], ['setup', '--output'], ['setup', '--yes', '--dry-run']] {
		parse_command(args) or { continue }
		assert false, 'accepted invalid dependency command: ${args}'
	}
}

fn dependency_test_checks(missing []int) []DependencyCheck {
	mut checks := []DependencyCheck{}
	for i, key in ['V', 'C compiler', 'PHP CLI', 'PHP SDK', 'PHP headers / ABI'] {
		checks << DependencyCheck{ key: key, ok: i !in missing }
	}
	return checks
}

fn setup_test_host(platform string, manager string) SetupHost {
	return SetupHost{ platform: platform, manager: manager, elevation: 'sudo' }
}

fn setup_test_commands(plan DependencyPlan) [][]string {
	mut commands := [][]string{}
	for step in plan.steps { if step.kind == .command { commands << step.args } }
	return commands
}

fn test_setup_does_not_install_when_environment_is_ready() {
	plan := dependency_plan(dependency_test_checks([]), setup_test_host('unknown', ''), '/tools/v', false)
	assert plan.steps.len == 0
	assert plan.blockers.len == 0
}

fn test_setup_macos_installs_system_prerequisites_before_packages() {
	plan := dependency_plan(dependency_test_checks([0, 1, 2, 3, 4]), setup_test_host('macos', ''), '/tools/v', false)
	assert plan.blockers.len == 0
	assert plan.steps[0].kind == .homebrew
	assert setup_test_commands(plan) == [['brew', 'install', 'vlang', 'php']]
	// Existing brew still needs the official CLT installation phase if cc is missing.
	clt := dependency_plan(dependency_test_checks([1, 4]), setup_test_host('macos', 'brew'), '/tools/v', false)
	assert clt.steps[0].kind == .homebrew
	root := dependency_plan(dependency_test_checks([0]), SetupHost{ platform: 'macos', is_root: true }, '/tools/v', false)
	assert root.blockers.any(it.contains('regular macOS user'))
}

fn test_setup_linux_keeps_v_in_user_directory_and_never_overwrites_it() {
	checks := dependency_test_checks([0, 1, 2, 3, 4])
	host := setup_test_host('linux', 'apt-get')
	plan := dependency_plan(checks, host, '/home/user name/v', false)
	assert plan.blockers.len == 0
	commands := setup_test_commands(plan)
	assert commands[0] == ['apt-get', 'update']
	assert commands[1] == ['apt-get', 'install', '-y', 'build-essential', 'libgc-dev', 'php-cli',
		'php-dev', 'git', 'ca-certificates']
	assert commands[2] == ['git', 'clone', '--depth', '1', 'https://github.com/vlang/v',
		'/home/user name/v']
	assert commands[3] == ['make', '-C', '/home/user name/v', 'VEXE=./v', 'VROOT=.']
	occupied := dependency_plan(checks, host, '/home/user name/v', true)
	assert occupied.blockers.any(it.contains('already exists'))
	assert !setup_test_commands(occupied).any(it[0] == 'git')
	resume := dependency_plan(checks, SetupHost{ ...host, resume_v: true }, '/home/user name/v', true)
	assert resume.blockers.len == 0
	assert !setup_test_commands(resume).any(it[0] == 'git')
	assert setup_test_commands(resume).last() == ['make', '-C', '/home/user name/v', 'VEXE=./v',
		'VROOT=.']
}

fn test_setup_blocks_invalid_overrides_and_abi_mismatch() {
	mut checks := dependency_test_checks([0, 4])
	checks[0] = DependencyCheck{ key: 'V', customized: true }
	plan := dependency_plan(checks, setup_test_host('macos', 'brew'), '/tools/v', false)
	assert plan.blockers.any(it.contains('explicit override'))
	assert plan.blockers.any(it.contains('incompatible'))
}

fn test_setup_rejects_unsupported_package_managers() {
	plan := dependency_plan(dependency_test_checks([0, 2, 3, 4]), setup_test_host('linux', ''), '/tools/v', false)
	assert plan.blockers.len > 0
	assert plan.steps.len == 0
}

fn test_setup_does_not_install_default_sdk_for_custom_php() {
	mut checks := dependency_test_checks([3, 4])
	checks[2] = DependencyCheck{ key: 'PHP CLI', ok: true, customized: true }
	plan := dependency_plan(checks, setup_test_host('macos', 'brew'), '/tools/v', false)
	assert plan.blockers.any(it.contains('Custom PHP'))
}

fn test_linux_distribution_detection_prefers_id_over_other_installed_managers() {
	available := ['apt-get', 'dnf', 'yum', 'pacman', 'zypper', 'apk']
	for id, expected in {
		'ubuntu':              'apt-get'
		'debian':              'apt-get'
		'fedora':              'dnf'
		'rocky':               'dnf'
		'amzn':                'dnf'
		'arch':                'pacman'
		'manjaro':             'pacman'
		'opensuse-tumbleweed': 'zypper'
		'sles':                'zypper'
		'alpine':              'apk'
	} {
		assert linux_manager(parse_os_release('ID="${id}"\nID_LIKE="debian"'), available) == expected
	}
	assert linux_manager(parse_os_release('ID=\'derivative\'\nID_LIKE="rhel fedora"'), available) == 'dnf'
	assert linux_manager({
		'ID': 'centos'
	}, ['yum']) == 'yum'
	assert linux_manager({
		'ID': 'unrecognized'
	}, available) == ''
	assert parse_os_release('ID="\u0024(not-a-command)"')['ID'] == '\u0024(not-a-command)'
}

fn test_linux_package_recipes_and_privilege_boundaries() {
	checks := dependency_test_checks([0, 1, 2, 3, 4])
	for manager, expected_php in {
		'dnf':    'php-devel'
		'yum':    'php-devel'
		'pacman': 'php'
		'zypper': 'php8-devel'
	} {
		plan := dependency_plan(checks, setup_test_host('linux', manager), '/tools/v', false)
		assert plan.blockers.len == 0
		assert setup_test_commands(plan).any(expected_php in it)
	}
	alpine := dependency_plan(checks, SetupHost{ platform: 'linux', manager: 'apk', elevation: 'doas' }, '/tools/v', false)
	assert alpine.blockers.len == 0
	assert alpine.steps.any(it.kind == .alpine_php)
	assert setup_test_commands(alpine)[0] == ['apk', 'add', '--no-cache', 'build-base', 'gc-dev',
		'git', 'ca-certificates']
	assert elevated_setup_command(['apk', 'update'], SetupHost{ elevation: 'doas' }) == [
		'doas',
		'apk',
		'update',
	]
	assert elevated_setup_command(['dnf', 'install', '-y', 'php-devel'], setup_test_host('linux', 'dnf'))[0] == 'sudo'
	assert elevated_setup_command(['apk', 'update'], SetupHost{ is_root: true }) == [
		'apk',
		'update',
	]
	no_privilege := dependency_plan(checks, SetupHost{ platform: 'linux', manager: 'apt-get' }, '/tools/v', false)
	assert no_privilege.blockers.any(it.contains('administrator access'))
	// Avoid pacman -Sy and an unsolicited whole-system upgrade.
	arch := setup_test_commands(dependency_plan(checks, setup_test_host('linux', 'pacman'), '/tools/v', false))[0]
	assert arch == ['pacman', '-S', '--needed', '--noconfirm', 'base-devel', 'gc', 'php', 'git',
		'ca-certificates']
}

fn test_alpine_php_selection_preserves_existing_php_family() {
	catalog := 'php81-8.1.0\nphp82\nphp84-8.4.1\nphp85\nnotphp86\nphp99'
	assert alpine_php_package(catalog, '')! == 'php85'
	assert alpine_php_package(catalog, '84')! == 'php84'
	assert alpine_php_package('php84\nphp86-dev\nphp85-pecl-redis', '')! == 'php84'
	for preferred in ['83', '81'] {
		alpine_php_package(catalog, preferred) or { continue }
		assert false, 'installed another PHP family instead of the selected one'
	}
}

fn setup_test_installer_runner(args []string) ! {
	log := os.getenv('VPHP_TEST_BOOTSTRAP_LOG')
	previous := os.read_file(log) or { '' }
	os.write_file(log, previous + args.join('\t') + '\n')!
	if args[0] == 'curl' {
		if os.getenv('VPHP_TEST_BOOTSTRAP_FAIL') == '1' { return error('mock download failure') }
		index := args.index('--output')
		os.write_file(args[index + 1], '#!/bin/bash\nexit 0\n')!
	}
}

fn test_homebrew_bootstrap_uses_tls_and_never_executes_a_failed_download() {
	directory := os.join_path(os.temp_dir(), 'vphp-bootstrap-test-${rand.uuid_v4()}')
	os.mkdir(directory)!
	defer {
		os.unsetenv('VPHP_TEST_BOOTSTRAP_LOG')
		os.unsetenv('VPHP_TEST_BOOTSTRAP_FAIL')
		os.rmdir_all(directory) or {}
	}
	log := os.join_path(directory, 'calls')
	os.setenv('VPHP_TEST_BOOTSTRAP_LOG', log, true)
	bootstrap_homebrew(false, setup_test_installer_runner)!
	calls := os.read_file(log)!
	assert calls.contains('--proto\t=https') && calls.contains('--proto-redir\t=https')
	assert calls.contains(homebrew_installer_url)
	assert calls.contains('/bin/bash\t')
	assert !calls.contains('NONINTERACTIVE=1')
	os.write_file(log, '')!
	bootstrap_homebrew(true, setup_test_installer_runner)!
	noninteractive := os.read_file(log)!
	assert noninteractive.contains('sudo\t-v')
	assert noninteractive.contains('NONINTERACTIVE=1')
	os.write_file(log, '')!
	os.setenv('VPHP_TEST_BOOTSTRAP_FAIL', '1', true)
	mut failed := false
	bootstrap_homebrew(false, setup_test_installer_runner) or { failed = true }
	assert failed
	assert !os.read_file(log)!.contains('/bin/bash\t')
}
