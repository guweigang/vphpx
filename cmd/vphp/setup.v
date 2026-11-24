module main

import os

const homebrew_installer_url = 'https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh'

enum SetupStepKind {
	command
	homebrew
	alpine_php
}

struct SetupStep {
	kind SetupStepKind
	args []string
}

struct DependencyPlan {
mut:
	steps    []SetupStep
	blockers []string
}

struct SetupHost {
	platform     string
	distribution string
	manager      string
	is_root      bool
	elevation    string
	resume_v     bool
}

fn parse_os_release(content string) map[string]string {
	mut fields := map[string]string{}
	for line in content.split_into_lines() {
		entry := line.trim_space()
		if entry.starts_with('#') || !entry.contains('=') { continue }
		key := entry.all_before('=').trim_space()
		mut value := entry.all_after('=').trim_space()
		if value.len >= 2 && ((value[0] == `"` && value[value.len - 1] == `"`)
			|| (value[0] == `'` && value[value.len - 1] == `'`)) {
			value = value[1..value.len - 1]
		}
		fields[key] = value
	}
	return fields
}

fn linux_manager(release map[string]string, available []string) string {
	for family in [release['ID'], ...release['ID_LIKE'].fields()] {
		candidates := match family {
			'debian', 'ubuntu', 'linuxmint', 'pop', 'kali', 'raspbian' { ['apt-get'] }
			'fedora', 'rhel', 'centos', 'rocky', 'almalinux', 'amzn', 'ol' { ['dnf', 'yum'] }
			'arch', 'manjaro', 'endeavouros' { ['pacman'] }
			'opensuse', 'opensuse-leap', 'opensuse-tumbleweed', 'suse', 'sles' { ['zypper'] }
			'alpine' { ['apk'] }
			else { []string{} }
		}
		for manager in candidates {
			if manager in available { return manager }
		}
	}
	return ''
}

fn detect_setup_host() SetupHost {
	platform := os.user_os()
	mut available := []string{}
	for name in ['apt-get', 'dnf', 'yum', 'pacman', 'zypper', 'apk'] {
		if _ := os.find_abs_path_of_executable(name) { available << name }
	}
	content := os.read_file('/etc/os-release') or { os.read_file('/usr/lib/os-release') or { '' } }
	release := parse_os_release(content)
	manager := if platform == 'macos' {
		if _ := find_program('brew') { 'brew' } else { '' }
	} else {
		linux_manager(release, available)
	}
	root := os.geteuid() == 0
	elevation := if root {
		''
	} else if _ := os.find_abs_path_of_executable('sudo') {
		'sudo'
	} else if _ := os.find_abs_path_of_executable('doas') {
		'doas'
	} else {
		''
	}
	directory := managed_v_directory()
	mut resume := false
	if os.is_file(os.join_path(directory, '.vphp-managed')) && os.is_file(os.join_path(directory, 'Makefile')) {
		remote := os.exec(['git', '-C', directory, 'remote', 'get-url', 'origin'])
		resume = remote.exit_code == 0 && remote.output.trim_space().trim_right('/') in [
			'https://github.com/vlang/v',
			'https://github.com/vlang/v.git',
		]
	}
	return SetupHost{
		platform:     platform
		distribution: release['ID']
		manager:      manager
		is_root:      root
		elevation:    elevation
		resume_v:     resume
	}
}

fn dependency_plan(checks []DependencyCheck, host SetupHost, v_directory string, v_directory_exists bool) DependencyPlan {
	mut plan := DependencyPlan{}
	if checks.all(it.ok) { return plan }
	for check in checks {
		if !check.ok && check.customized {
			plan.blockers << '${check.key} has an invalid explicit override; fix or unset its VPHP_* variable first'
		}
	}
	if (!checks[2].ok || !checks[3].ok) && (checks[2].customized || checks[3].customized) {
		plan.blockers << 'Custom PHP needs its matching CLI and php-config; set both VPHP_PHP and VPHP_PHP_CONFIG instead of installing the default PHP'
	}
	if checks[1].ok && checks[2].ok && checks[3].ok && !checks[4].ok {
		plan.blockers << 'PHP headers are incompatible or incomplete; select matching VPHP_PHP and VPHP_PHP_CONFIG before installing'
	}
	if host.platform == 'macos' {
		if host.is_root {
			plan.blockers << 'Run setup as your regular macOS user; Homebrew cannot run as root. Its installer will request administrator access when needed.'
		}
		if host.manager != 'brew' || !checks[1].ok {
			plan.steps << SetupStep{ kind: .homebrew }
		}
		mut packages := []string{}
		if !checks[0].ok { packages << 'vlang' }
		if !checks[2].ok || !checks[3].ok { packages << 'php' }
		if packages.len > 0 { plan.steps << SetupStep{ args: ['brew', 'install', ...packages] } }
		return plan
	}
	if host.platform != 'linux' || host.manager !in ['apt-get', 'dnf', 'yum', 'pacman', 'zypper',
		'apk'] {
		plan.blockers << 'Unsupported distribution/package manager. Supported: Debian/Ubuntu (apt), Fedora/RHEL (dnf/yum), Arch (pacman), openSUSE (zypper), Alpine (apk).'
		return plan
	}
	if !host.is_root && host.elevation == '' {
		plan.blockers << 'Installing system packages requires root, sudo or doas; rerun setup with administrator access.'
	}
	mut packages := []string{}
	if !checks[0].ok || !checks[1].ok {
		packages << match host.manager {
			'apt-get' { ['build-essential', 'libgc-dev'] }
			'dnf', 'yum', 'zypper' { ['gcc', 'gcc-c++', 'make', 'gc-devel'] }
			'pacman' { ['base-devel', 'gc'] }
			else { ['build-base', 'gc-dev'] }
		}
	}
	if host.manager == 'pacman' {
		if !checks[2].ok || !checks[3].ok { packages << 'php' }
	} else if host.manager != 'apk' {
		if !checks[2].ok {
			packages << if host.manager == 'zypper' { 'php8-cli' } else { 'php-cli' }
		}
		if !checks[3].ok {
			packages << if host.manager == 'apt-get' {
				'php-dev'
			} else if host.manager == 'zypper' {
				'php8-devel'
			} else {
				'php-devel'
			}
		}
	}
	if !checks[0].ok { packages << ['git', 'ca-certificates'] }
	if packages.len > 0 {
		if host.manager == 'apt-get' { plan.steps << SetupStep{ args: ['apt-get', 'update'] } }
		if host.manager == 'zypper' {
			plan.steps << SetupStep{ args: ['zypper', '--non-interactive', 'refresh'] }
		}
		args := match host.manager {
			'apt-get', 'dnf', 'yum' { [host.manager, 'install', '-y', ...packages] }
			'pacman' { ['pacman', '-S', '--needed', '--noconfirm', ...packages] }
			'zypper' { ['zypper', '--non-interactive', 'install', ...packages] }
			else { ['apk', 'add', '--no-cache', ...packages] }
		}
		plan.steps << SetupStep{ args: args }
	}
	if host.manager == 'apk' && (!checks[2].ok || !checks[3].ok) {
		plan.steps << SetupStep{ kind: .alpine_php }
	}
	if !checks[0].ok {
		if v_directory_exists && !host.resume_v {
			plan.blockers << 'V toolchain directory already exists but V is unavailable; repair it or set VPHP_V: ${v_directory}'
		} else {
			if !host.resume_v {
				plan.steps << SetupStep{
					args: ['git', 'clone', '--depth', '1', 'https://github.com/vlang/v', v_directory]
				}
			}
			plan.steps << SetupStep{ args: ['make', '-C', v_directory, 'VEXE=./v', 'VROOT=.'] }
		}
	}
	return plan
}
