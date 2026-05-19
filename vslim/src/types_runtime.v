module main

import toml
import vphp

@[php_implements: 'Psr\\Clock\\ClockInterface']
@[php_class: 'VSlim\\Psr20\\Clock']
@[heap]
struct VSlimPsr20Clock {}

@[php_implements: 'Psr\\EventDispatcher\\ListenerProviderInterface']
@[php_class: 'VSlim\\Psr14\\ListenerProvider']
@[heap]
struct VSlimPsr14ListenerProvider {
mut:
	listeners map[string][]vphp.PhpCallable
}

@[php_implements: 'Psr\\EventDispatcher\\EventDispatcherInterface']
@[php_class: 'VSlim\\Psr14\\EventDispatcher']
@[heap]
struct VSlimPsr14EventDispatcher {
mut:
	provider_ref &VSlimPsr14ListenerProvider = unsafe { nil } @[php_ignore]
}

@[php_class: 'VSlim\\Dev\\PhpSignatureProbe']
@[heap]
struct VSlimPhpSignatureProbe {
mut:
	provider_ref &VSlimPsr14ListenerProvider = unsafe { nil } @[php_ignore]
}

struct VSlimLogLevelConsts {
	disabled string
	fatal    string
	error    string
	warn     string
	info     string
	debug    string
}

@[php_class: 'VSlim\\Live\\Socket']
@[heap]
struct VSlimLiveSocket {
mut:
	id          string
	connected   bool
	redirect_to string @[php_prop: redirectTo]
	navigate_to string @[php_prop: navigateTo]
	raw_path    string @[php_prop: rawPath]
	root_id     string @[php_prop: rootId]
	assigns     map[string]string
	patches     []map[string]string
	events      []map[string]string
	flashes     []map[string]string
	pubsub      []map[string]string
}

@[php_class: 'VSlim\\Live\\Form']
@[heap]
struct VSlimLiveForm {
mut:
	name             string
	socket_ref       &VSlimLiveSocket = unsafe { nil } @[php_ignore]
	fields           []string
	last_error_count int @[php_prop: lastErrorCount]
	validated        bool
}

@[php_class: 'VSlim\\Live\\View']
@[heap]
struct VSlimLiveView {
mut:
	host    VSlimViewHost
	root_id string @[php_prop: rootId]
	sockets map[string]&VSlimLiveSocket
}

@[php_class: 'VSlim\\Live\\Component']
@[heap]
struct VSlimLiveComponent {
mut:
	host       VSlimViewHost
	id         string
	assigns    map[string]string
	socket_ref &VSlimLiveSocket = unsafe { nil } @[php_ignore]
}

@[php_class: 'VSlim\\Live\\ComponentState']
@[heap]
struct VSlimLiveComponentState {
mut:
	component_id string           @[php_prop: componentId]
	socket_ref   &VSlimLiveSocket = unsafe { nil } @[php_ignore]
}

@[php_class: 'VSlim\\Validate\\Validator']
@[heap]
struct VSlimValidator {
mut:
	input_data     map[string]vphp.DynValue @[php_prop: inputData]
	rule_map       map[string][]string      @[php_prop: ruleMap]
	error_map      map[string][]string      @[php_prop: errorMap]
	validated_data map[string]vphp.DynValue @[php_prop: validatedData]
	validation_ran bool                     @[php_prop: validationRan]
}

@[php_class: 'VSlim\\EnvLoader']
@[heap]
struct VSlimEnvLoader {}

@[php_class: 'VSlim\\Task']
@[heap]
struct VSlimTask {}

@[php_class: 'VSlim\\TaskHandle']
@[heap]
struct VSlimTaskHandle {
mut:
	async_ref vphp.PhpTaskHandle = vphp.PhpTaskHandle.null() @[php_ignore]
	// Task handles are request-scoped PHP objects, but the callable / params /
	// cached result must outlive the spawn() stack frame and survive until a
	// later wait() or object cleanup(). We therefore retain them with
	// explicit handle ownership and release them from
	// cleanup()/generic_free_raw(), rather than borrowing transient request zvals.
	callable   vphp.PhpCallable = vphp.PhpCallable.invalid()
	params     []vphp.PhpValue
	resolved   bool
	result_box vphp.PhpValue = vphp.PhpValue.invalid() @[php_ignore]
}

@[php_class: 'VSlim\\Job\\Dispatcher']
@[heap]
struct VSlimJobDispatcher {
mut:
	manager_ref &VSlimDatabaseManager = unsafe { nil } @[php_ignore]
}

@[php_class: 'VSlim\\Job\\Worker']
@[heap]
struct VSlimJobWorker {
mut:
	manager_ref          &VSlimDatabaseManager = unsafe { nil } @[php_ignore]
	worker_id            string                = 'default'                @[php_prop: workerId]
	retry_delay_seconds  int                   = 60                   @[php_prop: retryDelaySeconds]
	reserve_timeout_secs int                   = 300                   @[php_prop: reserveTimeoutSeconds]
}

@[php_class: 'VSlim\\Config']
@[heap]
struct VSlimConfig {
mut:
	path   string
	loaded bool
	root   toml.Any = toml.null
}
