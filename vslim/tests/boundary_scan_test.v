module boundary_scan_test

import os

fn vslim_root() string {
	return os.real_path(os.join_path(os.dir(@FILE), '..'))
}

fn vslim_src_files() []string {
	mut files := os.walk_ext(os.join_path(vslim_root(), 'src'), '.v')
	files.sort()
	return files.filter(!it.ends_with('/vphp_bridge.v'))
}

fn service_id_source_files() []string {
	return vslim_src_files().filter(it.ends_with('/service_ids.v'))
}

fn vslim_module_files(module_name string) []string {
	module_root := os.join_path(vslim_root(), 'src', module_name)
	return vslim_src_files().filter(it.starts_with(module_root + os.path_separator))
}

fn repo_root() string {
	return os.real_path(os.join_path(vslim_root(), '..'))
}

fn repo_split_portable_text_files() []string {
	mut files := []string{}
	collect_repo_split_portable_text_files(repo_root(), mut files)
	files << os.join_path(repo_root(), 'README.md')
	files << os.join_path(repo_root(), 'REPO_SPLIT_NOTES.md')
	files << os.join_path(vslim_root(), 'Makefile')
	files << os.join_path(vslim_root(), 'templates/app/Makefile')
	files.sort()
	return files.filter(os.exists(it) && !it.contains('/vendor/') && !it.contains('/dist/')
		&& !it.ends_with('/composer.lock'))
}

fn collect_repo_split_portable_text_files(dir string, mut files []string) {
	names := os.ls(dir) or { return }
	for name in names {
		path := os.join_path(dir, name)
		if path.contains('/vendor/') || path.contains('/dist/') || path.contains('/.git/') {
			continue
		}
		if os.is_dir(path) {
			collect_repo_split_portable_text_files(path, mut files)
			continue
		}
		if !os.is_file(path) {
			continue
		}
		if path.ends_with('.md') || path.ends_with('.phpt') || path.ends_with('.php')
			|| path.ends_with('.sh') {
			files << path
		}
	}
}

fn test_vslim_handwritten_sources_do_not_use_stale_vphp_raw_entries() {
	banned := [
		'Context.from_entry(',
		'Context.from_raw(',
		'ZendExecuteData.new(',
		'.raw_ex()',
		'.raw_zval()',
		'ZVal.from_raw(',
		'ZendObject.from_raw(',
		'ZendClassEntry.from_raw(',
		'C.vphp_',
		'C.ZVAL_',
		'C.zval{}',
		'args_from_zvals(',
		'call_owned_request_zval(',
		'method_owned_request(',
	]
	for file in vslim_src_files() {
		source := os.read_file(file) or { panic('failed to read ${file}: ${err}') }
		for pattern in banned {
			assert !source.contains(pattern), '${file} should not contain ${pattern}'
		}
		for line in source.split_into_lines() {
			trimmed := line.trim_space()
			assert !(trimmed.contains('PhpValue.from_zval(') && trimmed.contains('.to_zval())')), '${file} should not roundtrip semantic values through ${trimmed}'

			assert !(trimmed.contains('RequestBorrowedZBox.from_zval(')
				&& trimmed.contains('.to_zval())')), '${file} should not roundtrip borrowed boxes through ${trimmed}'

			assert !(trimmed.contains('PhpObject.borrowed(') && trimmed.contains('.to_zval())')), '${file} should use PhpObject.borrowed_zbox(...) for ${trimmed}'

			assert !(trimmed.contains('PhpCallable.borrowed(') && trimmed.contains('.to_zval())')), '${file} should use PhpCallable.borrowed_zbox(...) for ${trimmed}'
		}
	}
}

fn test_vslim_domain_identifiers_do_not_reintroduce_php_prefixes() {
	banned := [
		'php_before_middlewares',
		'php_middlewares',
		'php_after_middlewares',
		'php_group_before_middle',
		'php_group_middle',
		'php_group_after_middle',
		'php_handler',
		'dispatch_php_',
		'resolve_php_',
		'apply_php_',
		'finalize_php_',
		'build_php_',
		'add_php_route',
		'to_php_value',
		'from_php_value',
	]
	for file in vslim_src_files() {
		source := os.read_file(file) or { panic('failed to read ${file}: ${err}') }
		for pattern in banned {
			assert !source.contains(pattern), '${file} should not contain VSlim domain identifier ${pattern}'
		}
	}
}

fn test_repo_split_text_files_do_not_use_machine_local_source_paths() {
	local_source_prefix := '/' + os.join_path('Users', 'guweigang', 'Source')
	banned := [
		os.join_path(local_source_prefix, 'vphpx'),
		os.join_path(local_source_prefix, 'vhttpd'),
		'file://' + os.join_path(local_source_prefix, 'vphpx'),
	]
	for file in repo_split_portable_text_files() {
		if !os.exists(file) {
			continue
		}
		source := os.read_file(file) or { panic('failed to read ${file}: ${err}') }
		for pattern in banned {
			assert !source.contains(pattern), '${file} should use repo-relative paths, not ${pattern}'
		}
	}
}

fn test_framework_service_ids_are_owned_by_service_modules() {
	mut seen := map[string]string{}
	for file in service_id_source_files() {
		source := os.read_file(file) or { panic('failed to read ${file}: ${err}') }
		for line in source.split_into_lines() {
			trimmed := line.trim_space()
			if !trimmed.starts_with('pub const service_') || !trimmed.contains('=') {
				continue
			}
			value := trimmed.all_after('=').trim_space().trim('\'"')
			assert value != '', '${file} should not define an empty service id'
			if value in seen {
				assert false, '${file} duplicates service id ${value} already defined in ${seen[value]}'
			}
			seen[value] = file
		}
	}
	assert seen.len > 0, 'service id contracts should live in provider-owned service_ids.v files'
}

fn test_app_and_session_container_service_access_uses_service_id_constants() {
	target_dirs := [
		os.join_path(vslim_root(), 'src', 'appx'),
		os.join_path(vslim_root(), 'src', 'sessionx'),
	]
	for file in vslim_src_files() {
		if !target_dirs.any(file.starts_with(it)) {
			continue
		}
		source := os.read_file(file) or { panic('failed to read ${file}: ${err}') }
		for line in source.split_into_lines() {
			trimmed := line.trim_space()
			if trimmed.contains("container_ref.set('") || trimmed.contains('container_ref.set("')
				|| trimmed.contains(".get_value('") || trimmed.contains('.get_value("') {
				assert false, '${file} should use provider-owned service id constants for ${trimmed}'
			}
		}
	}
}

fn test_container_autowire_resolution_is_owned_by_containerx() {
	source := os.read_file(os.join_path(vslim_root(), 'src', 'appx', 'container_resolution.v')) or {
		panic('failed to read appx/container_resolution.v: ${err}')
	}
	for pattern in [
		'vphp.PhpClass.named',
		'.construct()',
		'container.set(service_id',
	] {
		assert !source.contains(pattern), 'appx container resolution should delegate service lookup/autowiring to containerx, not ${pattern}'
	}
	container_source := os.read_file(os.join_path(vslim_root(), 'src', 'containerx', 'container.v')) or {
		panic('failed to read containerx/container.v: ${err}')
	}
	assert container_source.contains('pub struct ContainerResolvedService'), 'containerx should expose autowire resolution metadata'
	assert container_source.contains('pub fn (mut c VSlimContainer) resolve_or_autowire_class'), 'containerx should own get-or-autowire service resolution'
}

fn test_appx_does_not_reown_cross_module_helpers() {
	banned_appx_files := [
		os.join_path(vslim_root(), 'src', 'appx', 'bootstrap_fs.v'),
		os.join_path(vslim_root(), 'src', 'appx', 'error_mapping.v'),
		os.join_path(vslim_root(), 'src', 'appx', 'response_bridge.v'),
	]
	for file in banned_appx_files {
		assert !os.exists(file), '${file} should live in a theme module, not appx'
	}
	banned_patterns := [
		'vslim_response_to_psr7(',
		'vslim_response_from_route_result(',
		'vslim_response_psr7_from_route_result(',
		'vslim_response_body_from_route_result(',
	]
	for file in vslim_src_files() {
		source := os.read_file(file) or { panic('failed to read ${file}: ${err}') }
		for pattern in banned_patterns {
			assert !source.contains(pattern), '${file} should use httpx response conversion helpers, not ${pattern}'
		}
	}
}

fn test_cli_bootstrap_does_not_depend_on_appx_filesystem_helpers() {
	clix_root := os.join_path(vslim_root(), 'src', 'clix')
	banned_patterns := [
		'appx.is_file(',
		'appx.is_dir(',
		'appx.glob_paths(',
		'appx.scandir_names(',
		'appx.include_once_file(',
		'appx.normalize_dir_path(',
		'appx.join_path(',
		'appx.dirname(',
		'appx.file_stem(',
		'appx.is_bootstrap_dir_path(',
	]
	for file in vslim_src_files() {
		if !file.starts_with(clix_root) {
			continue
		}
		source := os.read_file(file) or { panic('failed to read ${file}: ${err}') }
		for pattern in banned_patterns {
			assert !source.contains(pattern), '${file} should import supportx for filesystem helpers, not ${pattern}'
		}
	}
}

fn test_cli_debug_logging_is_owned_by_logger_module() {
	banned_patterns := [
		'appx.cli_debug_log(',
		'appx.cli_debug_reset_overrides(',
		'appx.cli_debug_sync_from_app(',
	]
	for file in vslim_src_files() {
		source := os.read_file(file) or { panic('failed to read ${file}: ${err}') }
		for pattern in banned_patterns {
			assert !source.contains(pattern), '${file} should use logger-owned CLI debug helpers, not ${pattern}'
		}
	}
}

fn test_cli_command_class_resolution_is_centralized() {
	source := os.read_file(os.join_path(vslim_root(), 'src', 'clix', 'app.v')) or {
		panic('failed to read clix/app.v: ${err}')
	}
	resolve_body :=
		source.all_after('fn (mut cli VSlimCliApp) resolve_command_runtime').all_before('fn (mut cli VSlimCliApp) resolve_command_class_runtime')
	assert resolve_body.contains('resolve_command_class_runtime'), 'CLI command runtime resolution should delegate class construction'
	assert !resolve_body.contains('vphp.PhpClass.named'), 'CLI command runtime resolution should not construct classes directly'
	assert source.contains('fn (mut cli VSlimCliApp) resolve_command_class_runtime'), 'CLI command class resolution should be centralized'
}

fn test_auth_config_conventions_are_owned_by_sessionx() {
	for file in vslim_module_files('appx') {
		source := os.read_file(file) or { panic('failed to read ${file}: ${err}') }
		for pattern in [
			"config.has('auth.redirect_to')",
			"config.has('auth.redirectTo')",
			"config.get_string('auth.redirect_to'",
			"config.get_string('auth.redirectTo'",
		] {
			assert !source.contains(pattern), '${file} should delegate auth config conventions to sessionx, not ${pattern}'
		}
	}
	source := os.read_file(os.join_path(vslim_root(), 'src', 'sessionx', 'auth_config.v')) or {
		panic('failed to read sessionx/auth_config.v: ${err}')
	}
	assert source.contains('pub fn auth_redirect_path_from_config'), 'auth redirect config conventions should be owned by sessionx'
}

fn test_session_diagnostics_are_owned_by_sessionx() {
	for file in vslim_module_files('appx') {
		source := os.read_file(file) or { panic('failed to read ${file}: ${err}') }
		for pattern in [
			"get_string('session.cookie'",
			"get_string('session.secret'",
			"get_string('app.key'",
			"'change-me'",
			'session_secret_configured :=',
			'session_secret_placeholder :=',
			'session_configured :=',
		] {
			assert !source.contains(pattern), '${file} should delegate session diagnostics to sessionx, not ${pattern}'
		}
	}
	source := os.read_file(os.join_path(vslim_root(), 'src', 'sessionx', 'diagnostics.v')) or {
		panic('failed to read sessionx/diagnostics.v: ${err}')
	}
	assert source.contains('pub fn session_diagnostics'), 'session doctor diagnostics should be owned by sessionx'
}

fn test_database_diagnostics_are_owned_by_databasex() {
	for file in vslim_module_files('appx') {
		source := os.read_file(file) or { panic('failed to read ${file}: ${err}') }
		for pattern in [
			"config.has('database.upstream.socket')",
			"os.getenv_opt('VHTTPD_DB_SOCKET')",
			"upstream_socket_source := 'none'",
			"upstream_socket_source = 'config'",
			"upstream_socket_source = 'env'",
		] {
			assert !source.contains(pattern), '${file} should delegate database diagnostics to databasex, not ${pattern}'
		}
	}
	source := os.read_file(os.join_path(vslim_root(), 'src', 'databasex', 'config.v')) or {
		panic('failed to read databasex/config.v: ${err}')
	}
	assert source.contains('pub fn empty_database_diagnostics'), 'empty database doctor diagnostics should be owned by databasex'
	assert source.contains('pub fn (mut db VSlimDatabaseManager) diagnostics'), 'database doctor diagnostics should be owned by databasex'
}

fn test_appx_uses_theme_default_service_constructors() {
	source := os.read_file(os.join_path(vslim_root(), 'src', 'appx', 'service_registry.v')) or {
		panic('failed to read appx/service_registry.v: ${err}')
	}
	assert !source.contains('vphp.bind_borrowed_object_value'), 'appx service registry should let containerx bind borrowed objects'
	assert !source.contains('vphp.bind_owned_object_value'), 'appx service registry should let containerx bind owned objects'
	container_source := os.read_file(os.join_path(vslim_root(), 'src', 'containerx', 'container.v')) or {
		panic('failed to read containerx/container.v: ${err}')
	}
	assert container_source.contains('pub fn (mut c VSlimContainer) set_borrowed_object'), 'containerx should own borrowed object service binding'
	assert container_source.contains('pub fn (mut c VSlimContainer) set_owned_object'), 'containerx should own owned object service binding'
	for pattern in [
		'&cfgx.VSlimConfig{}',
		'&loggerx.VSlimLogger{}',
		'&loggerx.VSlimPsrLogger{}',
		'&eventx.VSlimPsr14ListenerProvider{}',
		'&eventx.VSlimPsr14EventDispatcher{}',
		'&cachex.VSlimPsr16Cache{}',
		'&cachex.VSlimPsr6CacheItemPool{}',
		'&httpx.VSlimPsr18Client{}',
		'&databasex.VSlimDatabaseManager{}',
		'&jobx.VSlimJobDispatcher{}',
		'&jobx.VSlimJobWorker{}',
		'&databasex.VSlimDatabaseMigrator{}',
		'&mcp.VSlimMcpApp{}',
	] {
		assert !source.contains(pattern), 'appx service registry should use theme-owned default constructors, not ${pattern}'
	}
	services_source := os.read_file(os.join_path(vslim_root(), 'src', 'appx', 'services.v')) or {
		panic('failed to read appx/services.v: ${err}')
	}
	assert !services_source.contains('&cfgx.VSlimConfig{}'), 'appx services should use configx default constructor'
	config_source := os.read_file(os.join_path(vslim_root(), 'src', 'configx', 'config.v')) or {
		panic('failed to read configx/config.v: ${err}')
	}
	assert config_source.contains('pub fn VSlimConfig.new_default'), 'config default construction should be owned by configx'
	logger_source := os.read_file(os.join_path(vslim_root(), 'src', 'logger', 'logger.v')) or {
		panic('failed to read logger/logger.v: ${err}')
	}
	assert logger_source.contains('pub fn VSlimLogger.app_default'), 'app logger default construction should be owned by logger'
	assert logger_source.contains('pub fn VSlimPsrLogger.from_logger'), 'PSR logger construction should be owned by logger'
	event_source := os.read_file(os.join_path(vslim_root(), 'src', 'eventx', 'dispatcher.v')) or {
		panic('failed to read eventx/dispatcher.v: ${err}')
	}
	assert event_source.contains('pub fn VSlimPsr14ListenerProvider.new_default'), 'event provider default construction should be owned by eventx'
	assert event_source.contains('pub fn VSlimPsr14EventDispatcher.from_provider'), 'event dispatcher construction should be owned by eventx'
	cache_source := os.read_file(os.join_path(vslim_root(), 'src', 'cachex', 'psr16.v')) or {
		panic('failed to read cachex/psr16.v: ${err}')
	}
	pool_source := os.read_file(os.join_path(vslim_root(), 'src', 'cachex', 'psr6.v')) or {
		panic('failed to read cachex/psr6.v: ${err}')
	}
	assert cache_source.contains('pub fn VSlimPsr16Cache.from_clock_and_config'), 'PSR-16 cache default construction should be owned by cachex'
	assert pool_source.contains('pub fn VSlimPsr6CacheItemPool.from_clock_and_config'), 'PSR-6 pool default construction should be owned by cachex'
	http_source := os.read_file(os.join_path(vslim_root(), 'src', 'httpx', 'psr_http_client.v')) or {
		panic('failed to read httpx/psr_http_client.v: ${err}')
	}
	database_source := os.read_file(os.join_path(vslim_root(), 'src', 'databasex', 'config.v')) or {
		panic('failed to read databasex/config.v: ${err}')
	}
	job_source := os.read_file(os.join_path(vslim_root(), 'src', 'job', 'runtime.v')) or {
		panic('failed to read job/runtime.v: ${err}')
	}
	migration_source := os.read_file(os.join_path(vslim_root(), 'src', 'databasex', 'migration.v')) or {
		panic('failed to read databasex/migration.v: ${err}')
	}
	assert http_source.contains('pub fn VSlimPsr18Client.from_config'), 'PSR-18 client default construction should be owned by httpx'
	assert database_source.contains('pub fn VSlimDatabaseManager.from_config'), 'database manager default construction should be owned by databasex'
	assert job_source.contains('pub fn VSlimJobDispatcher.from_manager'), 'job dispatcher default construction should be owned by job'
	assert job_source.contains('pub fn VSlimJobWorker.from_manager'), 'job worker default construction should be owned by job'
	assert migration_source.contains('pub fn VSlimDatabaseMigrator.from_manager'), 'database migrator default construction should be owned by databasex'
	assert migration_source.contains('pub fn (mut migrator VSlimDatabaseMigrator) configure_project_paths'), 'database migrator project path setup should be owned by databasex'
	mcp_source := os.read_file(os.join_path(vslim_root(), 'src', 'mcpx', 'app.v')) or {
		panic('failed to read mcpx/app.v: ${err}')
	}
	assert mcp_source.contains('pub fn VSlimMcpApp.new_default'), 'MCP app default construction should be owned by mcpx'
	clock_source := os.read_file(os.join_path(vslim_root(), 'src', 'supportx', 'clock.v')) or {
		panic('failed to read supportx/clock.v: ${err}')
	}
	assert clock_source.contains('pub fn VSlimPsr20Clock.new_object'), 'PSR-20 clock PHP object construction should be owned by supportx static constructor'
	assert !clock_source.contains("new_psr20_system_clock_ref() vphp.PhpObject {\n\tclock := vphp.PhpClass.named('VSlim\\\\Psr20\\\\Clock').construct()"), 'clock ref helper should delegate PHP object construction to VSlimPsr20Clock.new_object'
}

fn test_job_worker_delegates_userland_job_dispatch() {
	source := os.read_file(os.join_path(vslim_root(), 'src', 'job', 'runtime.v')) or {
		panic('failed to read job/runtime.v: ${err}')
	}
	perform_body :=
		source.all_after('fn (mut worker VSlimJobWorker) perform').all_before('fn dispatch_job_class')
	assert perform_body.contains('dispatch_job_class'), 'job worker perform should delegate userland job construction and handle dispatch'
	assert !perform_body.contains('vphp.PhpClass.named'), 'job worker perform should not construct job classes directly'
	assert !perform_body.contains("method_exists('handle')"), 'job worker perform should not inspect job handler methods directly'
	assert source.contains('fn dispatch_job_class'), 'userland job dispatch should be centralized in job runtime'
}

fn test_routing_module_stays_pure_and_below_route_domain() {
	banned_imports := [
		'import appx',
		'import routex',
		'import httpx',
		'import clix',
		'import liveviewx',
		'import viewx',
		'import sessionx',
		'import containerx',
		'import configx',
		'import loggerx',
		'import supportx',
	]
	for file in vslim_module_files('routingx') {
		source := os.read_file(file) or { panic('failed to read ${file}: ${err}') }
		for pattern in banned_imports {
			assert !source.contains(pattern), '${file} should keep routing as pure path/query/pattern algorithms, not ${pattern}'
		}
	}
}

fn test_routex_does_not_depend_on_app_lifecycle_modules() {
	banned_imports := [
		'import appx',
		'import clix',
		'import sessionx',
		'import viewx',
		'import liveviewx',
		'import supportx',
	]
	for file in vslim_module_files('routex') {
		source := os.read_file(file) or { panic('failed to read ${file}: ${err}') }
		for pattern in banned_imports {
			assert !source.contains(pattern), '${file} should keep route domain below app lifecycle modules, not ${pattern}'
		}
	}
}

fn test_appx_does_not_reown_routing_algorithms() {
	banned_patterns := [
		'import routingx',
		'routingx.',
		'fn (subject PhpValueSubject) normalized_methods()',
	]
	for file in vslim_module_files('appx') {
		source := os.read_file(file) or { panic('failed to read ${file}: ${err}') }
		for pattern in banned_patterns {
			assert !source.contains(pattern), '${file} should route through routex/httpx boundaries, not ${pattern}'
		}
	}
}

fn test_appx_does_not_reown_websocket_handler_dispatch() {
	banned_patterns := [
		'fn websocket_handler_args(',
		'dispatch_websocket_container_service(',
		'service.method_exists(',
		'service_obj.call_method(',
		'websocketx.handler_args(',
		"method_exists('onOpen')",
		"method_exists('onMessage')",
		"method_exists('onClose')",
	]
	for file in vslim_module_files('appx') {
		source := os.read_file(file) or { panic('failed to read ${file}: ${err}') }
		for pattern in banned_patterns {
			assert !source.contains(pattern), '${file} should delegate WebSocket handler conventions to websocket module, not ${pattern}'
		}
	}
	source := os.read_file(os.join_path(vslim_root(), 'src', 'websocket', 'dispatch.v')) or {
		panic('failed to read websocket/dispatch.v: ${err}')
	}
	assert source.contains('pub fn dispatch_service_handler'), 'WebSocket service handler dispatch should be owned by websocket module'
}

fn test_testing_harness_does_not_depend_on_vslim_app_type() {
	assert !os.exists(os.join_path(vslim_root(), 'src', 'appx', 'testing_types.v')), 'VSlimTestingHarness should live in testingx, not appx'
	assert !os.exists(os.join_path(vslim_root(), 'src', 'appx', 'testing_runtime.v')), 'VSlimTestingHarness runtime should live in testingx, not appx'
	for file in vslim_module_files('testingx') {
		source := os.read_file(file) or { panic('failed to read ${file}: ${err}') }
		assert !source.contains('import appx'), '${file} should depend on container services, not appx'
		assert !source.contains('&VSlimApp'), '${file} should not hold VSlimApp directly'
	}
}

fn test_controller_does_not_depend_on_appx_type() {
	assert !os.exists(os.join_path(vslim_root(), 'src', 'appx', 'mvc.v')), 'VSlimController should live in controllerx, not appx'
	assert !os.exists(os.join_path(vslim_root(), 'src', 'appx', 'controller.v')), 'VSlimController runtime should live in controllerx, not appx'
	for file in vslim_module_files('controllerx') {
		source := os.read_file(file) or { panic('failed to read ${file}: ${err}') }
		assert !source.contains('import appx'), '${file} should depend on container services, not appx'
		assert !source.contains('&VSlimApp'), '${file} should not hold VSlimApp directly'
		assert !source.contains('current_runtime_dispatch_app'), '${file} should not use appx runtime dispatch globals'
	}
	assembly_source := os.read_file(os.join_path(vslim_root(), 'src', 'appx', 'assembly.v')) or {
		panic('failed to read appx/assembly.v: ${err}')
	}
	for pattern in [
		"is_subclass_of('VSlim\\\\Controller')",
		'bootstrap_controller_declares_own_constructor(',
		'vphp.PhpClass.named(class_name).construct(app_value)',
	] {
		assert !assembly_source.contains(pattern), 'appx assembly should delegate controller convention instantiation to controllerx, not ${pattern}'
	}
	source := os.read_file(os.join_path(vslim_root(), 'src', 'controllerx', 'controller.v')) or {
		panic('failed to read controllerx/controller.v: ${err}')
	}
	assert source.contains('pub fn register_convention_controller'), 'controller convention instantiation should be owned by controllerx'
	assert !source.contains('httpx.VSlimResponse{}'), 'controllerx should use httpx response constructors'
	assert !source.contains('.construct(200,'), 'controllerx should not construct HTTP responses directly'
	assert !source.contains("set_header('location'"), 'controllerx should use httpx redirect constructors'
	http_source := os.read_file(os.join_path(vslim_root(), 'src', 'httpx', 'response.v')) or {
		panic('failed to read httpx/response.v: ${err}')
	}
	assert http_source.contains('pub fn VSlimResponse.html'), 'HTML response construction should be owned by httpx'
	assert http_source.contains('pub fn VSlimResponse.redirect_to_status'), 'redirect response construction with status should be owned by httpx'
}

fn test_route_group_does_not_depend_on_appx_type() {
	assert !os.exists(os.join_path(vslim_root(), 'src', 'appx', 'route_group_types.v')), 'VSlim RouteGroup should live in routex, not appx'
	assert !os.exists(os.join_path(vslim_root(), 'src', 'appx', 'route_group_builder.v')), 'VSlim RouteGroup builder methods should live in routex, not appx'
	assert !os.exists(os.join_path(vslim_root(), 'src', 'appx', 'route.v')), 'VSlim RouteGroup path helpers should live in routex, not appx'
	source := os.read_file(os.join_path(vslim_root(), 'src', 'routex', 'route_group.v')) or {
		panic('failed to read routex/route_group.v: ${err}')
	}
	assert !source.contains('import appx'), 'routex RouteGroup should call app object services, not import appx'
	assert !source.contains('&VSlimApp'), 'routex RouteGroup should not hold VSlimApp directly'
	assert source.contains('pub fn RouteGroup.empty'), 'RouteGroup empty construction should be owned by routex'
	app_source := os.read_file(os.join_path(vslim_root(), 'src', 'appx', 'route_builder.v')) or {
		panic('failed to read appx/route_builder.v: ${err}')
	}
	assert !app_source.contains('&routex.RouteGroup{}'), 'appx route builder should use routex RouteGroup constructors'
}

fn test_liveview_protocol_helpers_are_owned_by_liveviewx() {
	banned_appx_patterns := [
		'fn decode_live_message(',
		'fn live_json_payload(',
		'fn live_patch_response(',
		'fn live_protocol_error(',
		'fn live_info_payload(',
		'fn live_heartbeat_response(',
		'fn dispatch_live_route_handler(',
		"method_exists('mount')",
		"method_exists('render')",
	]
	for file in vslim_module_files('appx') {
		source := os.read_file(file) or { panic('failed to read ${file}: ${err}') }
		for pattern in banned_appx_patterns {
			assert !source.contains(pattern), '${file} should keep LiveView protocol helpers in liveviewx, not ${pattern}'
		}
	}
	protocol_file := os.join_path(vslim_root(), 'src', 'liveviewx', 'protocol.v')
	assert os.exists(protocol_file), 'LiveView protocol helpers should be owned by liveviewx/protocol.v'
	dispatch_source := os.read_file(os.join_path(vslim_root(), 'src', 'liveviewx', 'dispatch.v')) or {
		panic('failed to read liveviewx/dispatch.v: ${err}')
	}
	assert dispatch_source.contains('pub fn is_live_route_handler_object'), 'Live route handler predicates should be owned by liveviewx'
	assert dispatch_source.contains('pub fn dispatch_live_route_handler'), 'Live route handler dispatch should be owned by liveviewx'
}

fn test_liveview_view_and_component_do_not_depend_on_vslim_app() {
	target_files := [
		os.join_path(vslim_root(), 'src', 'liveviewx', 'types_live.v'),
		os.join_path(vslim_root(), 'src', 'liveviewx', 'liveview.v'),
		os.join_path(vslim_root(), 'src', 'liveviewx', 'host.v'),
	]
	banned_patterns := [
		'&VSlimApp',
		'set_app(',
		"@[php_method: 'setApp']",
		'@[php_method: "setApp"]',
		'.set_app(',
	]
	for file in target_files {
		source := os.read_file(file) or { panic('failed to read ${file}: ${err}') }
		for pattern in banned_patterns {
			assert !source.contains(pattern), '${file} should bind LiveView services through containerx, not ${pattern}'
		}
	}
	assert !os.exists(os.join_path(vslim_root(), 'src', 'appx', 'live_types.v')), 'VSlim LiveView types should live in liveviewx, not appx'

	assert !os.exists(os.join_path(vslim_root(), 'src', 'appx', 'liveview.v')), 'VSlim LiveView methods should live in liveviewx, not appx'
}

fn test_liveview_runtime_is_owned_by_liveviewx() {
	assert !os.exists(os.join_path(vslim_root(), 'src', 'appx', 'live_components.v')), 'LiveView component dispatch should live in liveviewx, not appx'
	assert !os.exists(os.join_path(vslim_root(), 'src', 'appx', 'live_runtime.v')), 'LiveView socket runtime should live in liveviewx, not appx'

	for file in [
		os.join_path(vslim_root(), 'src', 'liveviewx', 'component_dispatch.v'),
		os.join_path(vslim_root(), 'src', 'liveviewx', 'dispatch.v'),
		os.join_path(vslim_root(), 'src', 'liveviewx', 'runtime_dispatch.v'),
	] {
		source := os.read_file(file) or { panic('failed to read ${file}: ${err}') }
		assert !source.contains('import appx'), '${file} should not import appx'
		assert !source.contains('VSlimApp'), '${file} should not use VSlimApp directly'
	}
}

fn test_liveview_socket_object_construction_is_centralized() {
	for file in [
		os.join_path(vslim_root(), 'src', 'liveviewx', 'dispatch.v'),
		os.join_path(vslim_root(), 'src', 'liveviewx', 'runtime_dispatch.v'),
	] {
		source := os.read_file(file) or { panic('failed to read ${file}: ${err}') }
		assert !source.contains("vphp.PhpClass.named('VSlim\\\\Live\\\\Socket').construct()"), '${file} should use VSlimLiveSocket.new_object()'
	}
	source := os.read_file(os.join_path(vslim_root(), 'src', 'liveviewx', 'socket_form.v')) or {
		panic('failed to read liveviewx/socket_form.v: ${err}')
	}
	assert source.contains('pub fn VSlimLiveSocket.new_object'), 'Live socket PHP object construction should be owned by VSlimLiveSocket'
}

fn test_appx_does_not_reown_psr15_http_conversions() {
	assert !os.exists(os.join_path(vslim_root(), 'src', 'appx', 'psr_bridge.v')), 'appx should not keep a PSR bridge helper file'
	for pattern in [
		'fn route_params_from_payload(',
		'fn normalize_psr15_server_request',
		'fn vslim_request_build_value(',
		'fn vslim_response_to_value(',
		'fn vslim_response_ref_to_value(',
		'fn vslim_request_from_psr_server_request',
		'fn persistent_array_value(',
		'fn object_from_owned_value(',
	] {
		for file in vslim_module_files('appx') {
			source := os.read_file(file) or { panic('failed to read ${file}: ${err}') }
			assert !source.contains(pattern), '${file} should delegate HTTP/PSR conversions to httpx, not ${pattern}'
		}
	}
	http_bridge := os.read_file(os.join_path(vslim_root(), 'src', 'httpx', 'psr15_bridge.v')) or {
		panic('failed to read httpx/psr15_bridge.v: ${err}')
	}
	assert http_bridge.contains('pub fn normalize_psr15_server_request'), 'HTTP/PSR request normalization should be owned by httpx/psr15_bridge.v'
	assert http_bridge.contains('pub fn vslim_response_to_value'), 'VSlim response value conversion should be owned by httpx/psr15_bridge.v'
}

fn test_appx_does_not_reown_psr15_predicates() {
	for file in vslim_module_files('appx') {
		source := os.read_file(file) or { panic('failed to read ${file}: ${err}') }
		for pattern in [
			'fn (subject PhpValueSubject) is_supported_middleware_handler',
			'fn (subject PhpValueSubject) is_supported_middleware_registration',
			'fn (subject PhpValueSubject) is_supported_phase_middleware_registration',
			'fn (subject PhpValueSubject) is_psr15_middleware_handler',
			'fn (subject PhpValueSubject) is_psr15_request_handler',
			'fn (subject PhpValueSubject) is_psr_server_request_payload',
			'fn is_psr_server_request_object(',
			'fn (subject PhpValueSubject) middleware_target_method',
			"target.method_exists('process')",
			"target_obj.call_method('process'",
		] {
			assert !source.contains(pattern), '${file} should delegate PSR-15/HTTP predicate checks to httpx, not ${pattern}'
		}
	}
	source := os.read_file(os.join_path(vslim_root(), 'src', 'httpx', 'psr15_predicates.v')) or {
		panic('failed to read httpx/psr15_predicates.v: ${err}')
	}
	assert source.contains('pub fn is_psr15_middleware_handler'), 'PSR-15 middleware predicates should be owned by httpx'
	assert source.contains('pub fn is_psr15_request_handler'), 'PSR-15 request handler predicates should be owned by httpx'
	assert source.contains('pub fn is_psr_server_request_payload'), 'PSR server request predicates should be owned by httpx'
	dispatch_source := os.read_file(os.join_path(vslim_root(), 'src', 'middlewarex', 'dispatch.v')) or {
		panic('failed to read middlewarex/dispatch.v: ${err}')
	}
	assert dispatch_source.contains('pub fn is_phase_middleware_target'), 'phase middleware target checks should be owned by middlewarex'
	assert dispatch_source.contains('pub fn dispatch_phase_process'), 'phase middleware process dispatch should be owned by middlewarex'
}

fn test_appx_does_not_reown_error_json_helpers() {
	for file in vslim_module_files('appx') {
		source := os.read_file(file) or { panic('failed to read ${file}: ${err}') }
		assert !source.contains('fn json_escape('), '${file} should use httpx for JSON escaping'
		assert !source.contains('fn error_json_body('), '${file} should use httpx for error JSON bodies'
		assert !source.contains('"Validation failed","errors"'), '${file} should use httpx for validation error JSON bodies'
		assert !source.contains('php_value_json_fragment(errors)'), '${file} should use httpx for validation error JSON bodies'
		assert !source.contains('httpx.VSlimResponse.json(status, errorx.error_json_body'), '${file} should use httpx default response builders'
		assert !source.contains('httpx.VSlimPsr7Response.json(status, errorx.error_json_body'), '${file} should use httpx default PSR response builders'
	}
	source := os.read_file(os.join_path(vslim_root(), 'src', 'httpx', 'error_mapping.v')) or {
		panic('failed to read httpx/error_mapping.v: ${err}')
	}
	assert source.contains('pub fn error_json_body'), 'error JSON body construction should be owned by httpx'
	assert source.contains('pub fn validation_error_json_body'), 'validation error JSON body construction should be owned by httpx'
	assert source.contains('pub fn default_response'), 'default error response construction should be owned by httpx'
}

fn test_appx_does_not_reown_http_allow_header_response_mutation() {
	source := os.read_file(os.join_path(vslim_root(), 'src', 'appx', 'terminal.v')) or {
		panic('failed to read appx/terminal.v: ${err}')
	}
	for pattern in [
		"res.headers['allow']",
		"headers['allow']",
		"header_names['allow']",
	] {
		assert !source.contains(pattern), 'appx terminal should delegate Allow header response mutation to httpx, not ${pattern}'
	}
	http_source := os.read_file(os.join_path(vslim_root(), 'src', 'httpx', 'psr7_response_bridge.v')) or {
		panic('failed to read httpx/psr7_response_bridge.v: ${err}')
	}
	assert http_source.contains('with_allowed_methods'), 'Allow header response mutation should be owned by httpx'
}

fn test_appx_uses_http_response_constructors_for_empty_responses() {
	for file in [
		os.join_path(vslim_root(), 'src', 'appx', 'kernel.v'),
		os.join_path(vslim_root(), 'src', 'appx', 'route_dispatch.v'),
		os.join_path(vslim_root(), 'src', 'appx', 'dispatch_api.v'),
	] {
		source := os.read_file(file) or { panic('failed to read ${file}: ${err}') }
		assert !source.contains('&httpx.VSlimResponse{}'), '${file} should use httpx response constructors for empty responses'
		assert !source.contains('httpx.VSlimResponse{}'), '${file} should use httpx response constructors for empty responses'
	}
	http_source := os.read_file(os.join_path(vslim_root(), 'src', 'httpx', 'response.v')) or {
		panic('failed to read httpx/response.v: ${err}')
	}
	assert http_source.contains('pub fn VSlimResponse.empty'), 'empty response construction should be owned by httpx'
}

fn test_feature_modules_use_http_response_constructors() {
	for file in [
		os.join_path(vslim_root(), 'src', 'viewx', 'render.v'),
		os.join_path(vslim_root(), 'src', 'liveviewx', 'dispatch.v'),
		os.join_path(vslim_root(), 'src', 'testingx', 'runtime.v'),
	] {
		source := os.read_file(file) or { panic('failed to read ${file}: ${err}') }
		assert !source.contains('httpx.VSlimResponse{}'), '${file} should use httpx response constructors'
		assert !source.contains('httpx.VSlimResponse{'), '${file} should use httpx response constructors'
		assert !source.contains('.construct(200,'), '${file} should use httpx response constructors'
	}
}

fn test_appx_uses_request_receiver_for_method_snapshots() {
	for file in vslim_module_files('appx') {
		source := os.read_file(file) or { panic('failed to read ${file}: ${err}') }
		assert !source.contains('fn vslim_request_with_method('), '${file} should use VSlimRequest.with_method_snapshot instead of an appx helper'
		assert !source.contains('vslim_request_with_method('), '${file} should use VSlimRequest.with_method_snapshot call shape'
	}
	source := os.read_file(os.join_path(vslim_root(), 'src', 'httpx', 'request.v')) or {
		panic('failed to read httpx/request.v: ${err}')
	}
	assert source.contains('pub fn (req &VSlimRequest) with_method_snapshot'), 'VSlimRequest method snapshots should be a receiver method'
}

fn test_appx_uses_http_receivers_for_dispatch_shapes() {
	for file in vslim_module_files('appx') {
		source := os.read_file(file) or { panic('failed to read ${file}: ${err}') }
		for pattern in [
			'fn vslim_response_as_dispatch_map(',
			'fn vslim_response_propagate_request_trace_headers(',
			'fn vslim_request_sync_from_snapshot(',
		] {
			assert !source.contains(pattern), '${file} should use httpx receiver methods for dispatch shapes, not ${pattern}'
		}
	}
	response_source := os.read_file(os.join_path(vslim_root(), 'src', 'httpx', 'response.v')) or {
		panic('failed to read httpx/response.v: ${err}')
	}
	request_source := os.read_file(os.join_path(vslim_root(), 'src', 'httpx', 'request.v')) or {
		panic('failed to read httpx/request.v: ${err}')
	}
	assert response_source.contains('pub fn (res &VSlimResponse) dispatch_map'), 'dispatch response map shape should be a VSlimResponse receiver'
	assert response_source.contains('pub fn (mut res VSlimResponse) propagate_request_trace_headers'), 'request trace header propagation should be a VSlimResponse receiver'
	assert request_source.contains('pub fn (mut target VSlimRequest) sync_from_snapshot'), 'request snapshot sync should be a VSlimRequest receiver'
}

fn test_appx_does_not_reown_route_url_lookup() {
	source := os.read_file(os.join_path(vslim_root(), 'src', 'appx', 'route_urls.v')) or {
		panic('failed to read appx/route_urls.v: ${err}')
	}
	for pattern in [
		'for route in app.routes',
		'routex.render_route_url',
		'routex.apply_base_path',
		'routex.absolute_url',
		'httpx.VSlimResponse{}',
		'.construct(302',
	] {
		assert !source.contains(pattern), 'appx route URL API should delegate route URL and redirect details to theme modules, not ${pattern}'
	}
	routex_source := os.read_file(os.join_path(vslim_root(), 'src', 'routex', 'url_lookup.v')) or {
		panic('failed to read routex/url_lookup.v: ${err}')
	}
	assert routex_source.contains('pub fn url_for('), 'route URL lookup should be owned by routex'
	assert routex_source.contains('pub fn url_for_abs('), 'absolute route URL lookup should be owned by routex'
	http_source := os.read_file(os.join_path(vslim_root(), 'src', 'httpx', 'response.v')) or {
		panic('failed to read httpx/response.v: ${err}')
	}
	assert http_source.contains('pub fn VSlimResponse.redirect_to'), 'redirect response construction should be owned by httpx'
}

fn test_appx_does_not_reown_route_collection_lookup() {
	source := os.read_file(os.join_path(vslim_root(), 'src', 'appx', 'route_runtime.v')) or {
		panic('failed to read appx/route_runtime.v: ${err}')
	}
	for pattern in [
		'for route in app.routes',
		'for i, route in app.websocket_routes',
		'route.matches(path)',
	] {
		assert !source.contains(pattern), 'appx route runtime should delegate route collection lookup to routex, not ${pattern}'
	}
	routex_source := os.read_file(os.join_path(vslim_root(), 'src', 'routex', 'introspection.v')) or {
		panic('failed to read routex/introspection.v: ${err}')
	}
	assert routex_source.contains('pub fn has_route_name('), 'route name lookup should be owned by routex'
	assert routex_source.contains('pub fn route_index_for_path('), 'route path index lookup should be owned by routex'
}

fn test_websocket_route_state_is_owned_by_websocket_module() {
	source := os.read_file(os.join_path(vslim_root(), 'src', 'appx', 'route_runtime.v')) or {
		panic('failed to read appx/route_runtime.v: ${err}')
	}
	for pattern in [
		"frame.string_at('event'",
		"frame.string_at('id'",
		'routex.normalize_route_path',
		'routex.route_index_for_path',
		'websocket_conn_route[',
		'websocket_conn_route.delete',
	] {
		assert !source.contains(pattern), 'appx websocket route runtime should delegate connection route state to websocket, not ${pattern}'
	}
	websocket_source := os.read_file(os.join_path(vslim_root(), 'src', 'websocket', 'route_state.v')) or {
		panic('failed to read websocket/route_state.v: ${err}')
	}
	assert websocket_source.contains('pub struct WebSocketRouteFrame'), 'websocket route frame state should be owned by websocket'
	assert websocket_source.contains('pub fn select_route_frame'), 'websocket route selection should be owned by websocket'
	assert websocket_source.contains('pub fn finish_route_frame'), 'websocket route cleanup should be owned by websocket'
}

fn test_appx_does_not_reown_route_dispatch_lookup() {
	source := os.read_file(os.join_path(vslim_root(), 'src', 'appx', 'route_dispatch.v')) or {
		panic('failed to read appx/route_dispatch.v: ${err}')
	}
	for pattern in [
		'struct RouteDispatchResolution',
		'for route in app.routes',
		'route.matches(path)',
		'collect_allowed_methods(',
		'method_not_allowed :=',
	] {
		assert !source.contains(pattern), 'appx route dispatch should delegate matching and method resolution to routex, not ${pattern}'
	}
	routex_source := os.read_file(os.join_path(vslim_root(), 'src', 'routex', 'dispatch_lookup.v')) or {
		panic('failed to read routex/dispatch_lookup.v: ${err}')
	}
	assert routex_source.contains('pub fn resolve_dispatch_match'), 'route dispatch lookup should be owned by routex'
	resolution_source := os.read_file(os.join_path(vslim_root(), 'src', 'routex',
		'dispatch_resolution.v')) or {
		panic('failed to read routex/dispatch_resolution.v: ${err}')
	}
	assert resolution_source.contains('pub struct RouteDispatchResolution'), 'route dispatch resolution should be owned by routex'
}

fn test_terminal_meta_uses_static_constructors() {
	for file in vslim_module_files('appx') {
		source := os.read_file(file) or { panic('failed to read ${file}: ${err}') }
		assert !source.contains('fn vslim_response_fixed_terminal_meta('), '${file} should use MiddlewareTerminalMeta static constructors, not a free terminal helper'
		assert !source.contains('vslim_response_fixed_terminal_meta('), '${file} should call MiddlewareTerminalMeta.fixed_response'
	}
	source := os.read_file(os.join_path(vslim_root(), 'src', 'appx', 'terminal.v')) or {
		panic('failed to read appx/terminal.v: ${err}')
	}
	assert source.contains('fn MiddlewareTerminalMeta.fixed_response'), 'fixed terminal response construction should be a MiddlewareTerminalMeta static constructor'
}

fn test_appx_does_not_reown_route_cleanup_loops() {
	source := os.read_file(os.join_path(vslim_root(), 'src', 'appx', 'memory.v')) or {
		panic('failed to read appx/memory.v: ${err}')
	}
	for pattern in [
		'for mut route in app.routes',
		'for mut route in app.websocket_routes',
		'route.release_owned_refs()',
	] {
		assert !source.contains(pattern), 'appx cleanup should delegate route ref cleanup to routex, not ${pattern}'
	}
	routex_source := os.read_file(os.join_path(vslim_root(), 'src', 'routex', 'cleanup.v')) or {
		panic('failed to read routex/cleanup.v: ${err}')
	}
	assert routex_source.contains('pub fn release_owned_routes'), 'route ref cleanup should be owned by routex'
}

fn test_appx_does_not_reown_middleware_hook_collection() {
	source := os.read_file(os.join_path(vslim_root(), 'src', 'appx', 'middleware_registration.v')) or {
		panic('failed to read appx/middleware_registration.v: ${err}')
	}
	for pattern in [
		'hooks[i].release()',
		'hooks.free()',
		'for hook in app.before_middlewares',
		'for hook in app.after_middlewares',
		'for idx, hook in app.middlewares',
		'for hook in group_hooks',
		'fn middleware_registration_error(',
		'fn middleware_supports_registration(',
		'httpx.is_psr15_middleware_registration',
	] {
		assert !source.contains(pattern), 'appx middleware registration should delegate hook collection mechanics to middlewarex, not ${pattern}'
	}
	middleware_source := os.read_file(os.join_path(vslim_root(), 'src', 'middlewarex', 'hooks.v')) or {
		panic('failed to read middlewarex/hooks.v: ${err}')
	}
	assert middleware_source.contains('pub fn release_hooks'), 'middleware hook release should be owned by middlewarex'
	assert middleware_source.contains('pub fn clone_combined_hooks'), 'middleware hook cloning should be owned by middlewarex'
	types_source := os.read_file(os.join_path(vslim_root(), 'src', 'middlewarex', 'types.v')) or {
		panic('failed to read middlewarex/types.v: ${err}')
	}
	assert types_source.contains('pub fn registration_error'), 'middleware registration errors should be owned by middlewarex'
	assert types_source.contains('pub fn supports_registration'), 'middleware registration support checks should be owned by middlewarex'
}

fn test_appx_does_not_reown_middleware_phase_continue_response() {
	for file in vslim_module_files('appx') {
		source := os.read_file(file) or { panic('failed to read ${file}: ${err}') }
		assert !source.contains('fn psr7_response_internal_phase_continue('), '${file} should use middlewarex for phase continue response construction'
		assert !source.contains("'x-vslim-continue': ['1']"), '${file} should not construct phase continue response headers directly'
	}
	source := os.read_file(os.join_path(vslim_root(), 'src', 'middlewarex', 'continue_response.v')) or {
		panic('failed to read middlewarex/continue_response.v: ${err}')
	}
	assert source.contains('pub fn phase_continue_response'), 'phase continue response construction should be owned by middlewarex'
}

fn test_middleware_types_are_owned_by_middlewarex() {
	assert !os.exists(os.join_path(vslim_root(), 'src', 'appx', 'middleware_types.v')), 'middleware types should live in middlewarex, not appx'
	for file in vslim_module_files('appx') {
		source := os.read_file(file) or { panic('failed to read ${file}: ${err}') }
		for pattern in [
			'pub struct VSlimPsr15NextHandler',
			'pub struct VSlimPsr15ContinueHandler',
			'struct Psr15NextHandlerState',
			'struct VSlimBeforeMiddlewareResult',
			'struct PhaseMiddlewareDispatchResult',
			'enum Psr15NextHandlerMode',
			'enum MiddlewareRegistrationKind',
			'type MiddlewareRegistrationKind =',
			'fn is_internal_phase_continue_response(',
			'fn psr7_response_build_psr15_fixed_response_handler_object(',
			'&middlewarex.VSlimPsr15NextHandler{',
			'&middlewarex.VSlimPsr15ContinueHandler{',
			'vphp.bind_owned_object_value[middlewarex.VSlimPsr15NextHandler]',
			'vphp.bind_owned_object_value[middlewarex.VSlimPsr15ContinueHandler]',
		] {
			assert !source.contains(pattern), '${file} should not own middleware type definitions: ${pattern}'
		}
	}
	for file in vslim_module_files('middlewarex') {
		source := os.read_file(file) or { panic('failed to read ${file}: ${err}') }
		assert !source.contains('import appx'), '${file} should not import appx'
	}
	source := os.read_file(os.join_path(vslim_root(), 'src', 'middlewarex', 'types.v')) or {
		panic('failed to read middlewarex/types.v: ${err}')
	}
	assert source.contains('pub struct VSlimPsr15NextHandler'), 'PSR-15 next handler should be owned by middlewarex'
	assert source.contains('pub struct VSlimPsr15ContinueHandler'), 'PSR-15 continue handler should be owned by middlewarex'
	assert source.contains('pub enum MiddlewareRegistrationKind'), 'middleware registration kind should be owned by middlewarex'
	assert source.contains('pub fn VSlimPsr15NextHandler.for_chain'), 'PSR-15 next handler chain construction should be owned by middlewarex'
	assert source.contains('pub fn VSlimPsr15NextHandler.fixed_response'), 'PSR-15 fixed response handler construction should be owned by middlewarex'
	assert source.contains('pub fn VSlimPsr15ContinueHandler.with_dispatcher'), 'PSR-15 continue handler construction should be owned by middlewarex'
	assert source.contains('request_handler_object'), 'PSR-15 handler object binding should be owned by middlewarex'
	assert source.contains('pub fn fixed_response_request_handler_object'), 'PSR-15 fixed response handler object construction should be owned by middlewarex'
	phase_source := os.read_file(os.join_path(vslim_root(), 'src', 'middlewarex', 'phase_result.v')) or {
		panic('failed to read middlewarex/phase_result.v: ${err}')
	}
	assert phase_source.contains('pub struct VSlimBeforeMiddlewareResult'), 'before middleware result should be owned by middlewarex'
	assert phase_source.contains('pub struct PhaseMiddlewareDispatchResult'), 'phase middleware result should be owned by middlewarex'
}

fn test_forwarded_request_snapshots_are_owned_by_middlewarex() {
	assert !os.exists(os.join_path(vslim_root(), 'src', 'appx', 'psr_bridge.v')), 'forwarded request bridge helpers should live in middlewarex, not appx'
	for file in vslim_module_files('appx') {
		source := os.read_file(file) or { panic('failed to read ${file}: ${err}') }
		for pattern in [
			'struct PhaseForwardedServerRequestSnapshot',
			'forwarded_requests map[',
			'fn snapshot_phase_forwarded_request(',
			'fn store_forwarded_request_snapshot(',
			'fn take_forwarded_request_snapshot(',
			'fn request_with_forwarded_snapshot(',
			'fn continued_phase_request_value(',
			'fn forwarded_request_key(',
		] {
			assert !source.contains(pattern), '${file} should delegate forwarded request snapshot ownership to middlewarex, not ${pattern}'
		}
	}
	source := os.read_file(os.join_path(vslim_root(), 'src', 'middlewarex', 'forwarded_request.v')) or {
		panic('failed to read middlewarex/forwarded_request.v: ${err}')
	}
	for pattern in [
		'pub struct PhaseForwardedServerRequestSnapshot',
		'pub fn snapshot_phase_forwarded_request(',
		'pub fn store_forwarded_request_snapshot(',
		'pub fn take_forwarded_request_snapshot(',
		'pub fn request_with_forwarded_snapshot(',
		'pub fn continued_phase_request_value(',
		'pub fn forwarded_request_key(',
	] {
		assert source.contains(pattern), 'middlewarex should own forwarded request snapshot API: ${pattern}'
	}
}

fn test_appx_does_not_reown_view_helper_lifecycle_or_constructor_details() {
	source := os.read_file(os.join_path(vslim_root(), 'src', 'appx', 'view.v')) or {
		panic('failed to read appx/view.v: ${err}')
	}
	for pattern in [
		'viewx.ensure_view_helper_map(',
		'viewx.release_view_helper(',
		'viewx.clone_view_helper_map(',
		'&viewx.VSlimView{',
	] {
		assert !source.contains(pattern), 'appx view API should delegate view helper lifecycle and construction to viewx, not ${pattern}'
	}
	view_source := os.read_file(os.join_path(vslim_root(), 'src', 'viewx', 'view.v')) or {
		panic('failed to read viewx/view.v: ${err}')
	}
	cache_source := os.read_file(os.join_path(vslim_root(), 'src', 'viewx', 'cache_parse.v')) or {
		panic('failed to read viewx/cache_parse.v: ${err}')
	}
	assert view_source.contains('pub fn VSlimView.from_settings'), 'VSlimView construction from app settings should be owned by viewx'
	assert cache_source.contains('pub fn register_view_helper'), 'view helper lifecycle should be owned by viewx'
}

fn test_appx_does_not_reown_session_auth_provider_resolution() {
	source := os.read_file(os.join_path(vslim_root(), 'src', 'appx', 'auth_services.v')) or {
		panic('failed to read appx/auth_services.v: ${err}')
	}
	for pattern in [
		'&sessionx.VSlimSessionStore{}',
		'&sessionx.VSlimAuthSessionGuard{}',
		'.construct()',
		"method_exists('findById')",
		"method_exists('resolve')",
		'with_callable[vphp.PhpValue]',
		'fn (subject PhpObjectSubject) resolve_auth_user',
	] {
		assert !source.contains(pattern), 'appx auth API should delegate auth provider resolution to sessionx, not ${pattern}'
	}
	source_session := os.read_file(os.join_path(vslim_root(), 'src', 'sessionx', 'auth_provider.v')) or {
		panic('failed to read sessionx/auth_provider.v: ${err}')
	}
	assert source_session.contains('pub fn is_auth_user_provider'), 'auth user provider validation should be owned by sessionx'
	assert source_session.contains('pub fn resolve_auth_user'), 'auth user provider resolution should be owned by sessionx'
	store_source := os.read_file(os.join_path(vslim_root(), 'src', 'sessionx', 'store.v')) or {
		panic('failed to read sessionx/store.v: ${err}')
	}
	auth_source := os.read_file(os.join_path(vslim_root(), 'src', 'sessionx', 'auth.v')) or {
		panic('failed to read sessionx/auth.v: ${err}')
	}
	assert store_source.contains('pub fn VSlimSessionStore.from_config_and_request'), 'session store request construction should be owned by sessionx'
	assert auth_source.contains('pub fn VSlimAuthSessionGuard.from_store_and_config'), 'auth guard construction should be owned by sessionx'
}

fn test_appx_does_not_reown_http_dispatch_payload_conversion() {
	for file in vslim_module_files('appx') {
		source := os.read_file(file) or { panic('failed to read ${file}: ${err}') }
		for pattern in [
			'fn build_route_dispatch_payload(',
			'fn vslim_request_from_payload(',
		] {
			assert !source.contains(pattern), '${file} should delegate dispatch payload conversion to httpx, not ${pattern}'
		}
	}
	source := os.read_file(os.join_path(vslim_root(), 'src', 'httpx', 'dispatch_payload.v')) or {
		panic('failed to read httpx/dispatch_payload.v: ${err}')
	}
	assert source.contains('pub fn route_dispatch_payload'), 'route dispatch payload conversion should be owned by httpx'
}

fn test_appx_does_not_reown_legacy_or_resource_missing_payload_helpers() {
	for file in vslim_module_files('appx') {
		source := os.read_file(file) or { panic('failed to read ${file}: ${err}') }
		for pattern in [
			'fn (subject PhpValueSubject) legacy_middleware_payload',
			'fn dispatch_resource_missing_meta(',
			'fn (subject PhpValueSubject) call_route_target_method',
			'fn (subject PhpValueSubject) route_handler_response',
			'target_value.method_exists(',
			"call_method('handle'",
			"method_exists('handle')",
		] {
			assert !source.contains(pattern), '${file} should delegate legacy/resource payload helpers to theme modules, not ${pattern}'
		}
	}
	http_source := os.read_file(os.join_path(vslim_root(), 'src', 'httpx', 'legacy_payload.v')) or {
		panic('failed to read httpx/legacy_payload.v: ${err}')
	}
	assert http_source.contains('pub fn legacy_middleware_payload'), 'legacy middleware payload conversion should be owned by httpx'
	predicate_source := os.read_file(os.join_path(vslim_root(), 'src', 'httpx',
		'psr15_predicates.v')) or { panic('failed to read httpx/psr15_predicates.v: ${err}') }
	assert predicate_source.contains('pub fn is_psr15_request_handler_like_object'), 'PSR request handler-like object checks should be owned by httpx'
	route_source := os.read_file(os.join_path(vslim_root(), 'src', 'routex', 'resource_missing.v')) or {
		panic('failed to read routex/resource_missing.v: ${err}')
	}
	assert route_source.contains('pub fn dispatch_resource_missing'), 'resource missing callback dispatch should be owned by routex'
	handler_source := os.read_file(os.join_path(vslim_root(), 'src', 'routex', 'handler_dispatch.v')) or {
		panic('failed to read routex/handler_dispatch.v: ${err}')
	}
	assert handler_source.contains('pub fn call_route_target_method'), 'route target method dispatch should be owned by routex'
	assert handler_source.contains('pub fn call_psr_request_handler'), 'PSR request handler dispatch should be owned by routex'
	assert handler_source.contains('pub fn route_handler_response'), 'route handler response normalization should be owned by routex'
	assert handler_source.contains('pub fn validate_route_service_method'), 'route service method validation should be owned by routex'
}

fn test_appx_uses_route_static_constructors() {
	source := os.read_file(os.join_path(vslim_root(), 'src', 'appx', 'route_runtime.v')) or {
		panic('failed to read appx/route_runtime.v: ${err}')
	}
	assert !source.contains('routex.VSlimRoute{'), 'appx should construct routes through routex.VSlimRoute static constructors'
	resource_source := os.read_file(os.join_path(vslim_root(), 'src', 'appx', 'route_resource.v')) or {
		panic('failed to read appx/route_resource.v: ${err}')
	}
	assert !resource_source.contains('routex.ResourceRouteOptions{}'), 'appx should construct resource route options through routex static constructors'
	routex_source := os.read_file(os.join_path(vslim_root(), 'src', 'routex', 'route.v')) or {
		panic('failed to read routex/route.v: ${err}')
	}
	assert routex_source.contains('pub fn VSlimRoute.from_callable_handler'), 'route PHP handler construction should be a routex static constructor'
	assert routex_source.contains('pub fn VSlimRoute.websocket'), 'websocket route construction should be a routex static constructor'
	assert routex_source.contains('pub fn VSlimRoute.with_resource_meta'), 'resource route construction should be a routex static constructor'
	options_source := os.read_file(os.join_path(vslim_root(), 'src', 'routex', 'resource_options.v')) or {
		panic('failed to read routex/resource_options.v: ${err}')
	}
	assert options_source.contains('pub fn ResourceRouteOptions.default'), 'resource route option defaults should be owned by routex'
}

fn test_support_classes_do_not_depend_on_appx_type() {
	assert !os.exists(os.join_path(vslim_root(), 'src', 'appx', 'support_types.v')), 'VSlim Support classes should live in supportx, not appx'
	assert !os.exists(os.join_path(vslim_root(), 'src', 'appx', 'service_provider.v')), 'VSlim ServiceProvider methods should live in supportx, not appx'
	assert !os.exists(os.join_path(vslim_root(), 'src', 'appx', 'module_support.v')), 'VSlim Module methods should live in supportx, not appx'
	for file in vslim_module_files('supportx') {
		source := os.read_file(file) or { panic('failed to read ${file}: ${err}') }
		assert !source.contains('import appx'), '${file} should bind app objects without importing appx'
		assert !source.contains('&VSlimApp'), '${file} should not hold VSlimApp directly'
	}
}

fn test_appx_does_not_reown_support_lifecycle_reflection() {
	assert !os.exists(os.join_path(vslim_root(), 'src', 'appx', 'subjects.v')), 'generic PHP value subjects should not remain in appx'
	assert !os.exists(os.join_path(vslim_root(), 'src', 'appx', 'value_subject_log.v')), 'generic PHP value subject logging should not remain in appx'
	for file in [
		os.join_path(vslim_root(), 'src', 'appx', 'bootstrap.v'),
		os.join_path(vslim_root(), 'src', 'appx', 'modules.v'),
	] {
		source := os.read_file(file) or { panic('failed to read ${file}: ${err}') }
		for pattern in [
			"vphp.PhpFunction.named('class_exists')",
			"vphp.PhpClass.named('ReflectionMethod')",
			'vphp.PhpClass.named(class_name).construct()',
			'fn object_method_required_params(',
			'fn bootstrap_debug_included_hits(',
			'fn log_bootstrap_class_visibility(',
			'fn (subject PhpValueSubject)',
			'value_subject(',
		] {
			assert !source.contains(pattern), '${file} should delegate provider/module lifecycle reflection to supportx, not ${pattern}'
		}
	}
	source := os.read_file(os.join_path(vslim_root(), 'src', 'supportx', 'lifecycle.v')) or {
		panic('failed to read supportx/lifecycle.v: ${err}')
	}
	assert source.contains('pub fn input_value'), 'support lifecycle input normalization should be owned by supportx'
	assert source.contains('pub fn call_lifecycle'), 'support lifecycle calls should be owned by supportx'
	assert source.contains('pub fn call_value_method'), 'support lifecycle value-returning calls should be owned by supportx'
}

fn test_bootstrap_spec_and_conventions_are_owned_by_supportx() {
	assert !os.exists(os.join_path(vslim_root(), 'src', 'appx', 'bootstrap_spec.v')), 'bootstrap spec parsing should live in supportx, not appx'
	assert !os.exists(os.join_path(vslim_root(), 'src', 'appx', 'bootstrap_conventions.v')), 'bootstrap convention helpers should live in supportx, not appx'
	for file in vslim_module_files('appx') {
		source := os.read_file(file) or { panic('failed to read ${file}: ${err}') }
		for pattern in [
			'pub struct AppBootstrapSpec',
			'pub struct BootstrapConventionHookFile',
			'fn normalize_app_bootstrap_spec(',
			'fn bootstrap_convention_hook_file(',
			'fn bootstrap_controller_declares_own_constructor(',
			'fn is_bootstrap_callable_pair(',
		] {
			assert !source.contains(pattern), '${file} should delegate bootstrap spec/convention helpers to supportx, not ${pattern}'
		}
	}
	spec_source := os.read_file(os.join_path(vslim_root(), 'src', 'supportx', 'bootstrap_spec.v')) or {
		panic('failed to read supportx/bootstrap_spec.v: ${err}')
	}
	convention_source := os.read_file(os.join_path(vslim_root(), 'src', 'supportx',
		'bootstrap_conventions.v')) or {
		panic('failed to read supportx/bootstrap_conventions.v: ${err}')
	}
	assert spec_source.contains('pub struct AppBootstrapSpec'), 'bootstrap spec wrapper should be owned by supportx'
	assert spec_source.contains('pub fn normalize_app_bootstrap_spec'), 'bootstrap spec normalization should be owned by supportx'
	assert convention_source.contains('pub struct BootstrapConventionHookFile'), 'bootstrap convention hook file should be owned by supportx'
	assert convention_source.contains('pub fn bootstrap_controller_declares_own_constructor'), 'bootstrap convention reflection should be owned by supportx'
	assert convention_source.contains('pub fn is_bootstrap_callable_pair'), 'bootstrap callable pair shape should be owned by supportx'
}

fn test_appx_does_not_reown_set_app_binding_details() {
	for file in [
		os.join_path(vslim_root(), 'src', 'appx', 'middleware_registration.v'),
		os.join_path(vslim_root(), 'src', 'appx', 'route_handler_dispatch.v'),
	] {
		source := os.read_file(file) or { panic('failed to read ${file}: ${err}') }
		for pattern in [
			"method_exists('setApp')",
			"call_method('setApp'",
		] {
			assert !source.contains(pattern), '${file} should delegate setApp binding details to supportx, not ${pattern}'
		}
	}
	source := os.read_file(os.join_path(vslim_root(), 'src', 'supportx', 'lifecycle.v')) or {
		panic('failed to read supportx/lifecycle.v: ${err}')
	}
	assert source.contains('pub fn bind_to_app'), 'setApp binding details should be owned by supportx'
}
