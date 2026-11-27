module appx

import registrationx
import supportx
import vphp

@[heap]
struct BootstrapInputRun {
	input    vphp.PhpValue
	progress &supportx.BootstrapProgress
mut:
	generator_spec vphp.PhpValue
}

enum BootstrapBootStage {
	configure
	deferred
	runtime
	services
	shared_errors
	http_errors
	finish
}

fn (mut app VSlimApp) save_bootstrap_boot_stage(source string, stage BootstrapBootStage) {
	app.track_bootstrap_boot()
	if app.bootstrap_boot_stages.len == 0 {
		app.bootstrap_boot_stages = map[string]BootstrapBootStage{}
	}
	app.bootstrap_boot_stages[source.clone()] = stage
}

fn (mut app VSlimApp) defer_bootstrap_boot(source string) {
	if !app.booted {
		app.save_bootstrap_boot_stage(source, .deferred)
	}
}

// Web bootstrap can finish configuration before dispatch attempts its first boot.
fn (mut app VSlimApp) settle_deferred_bootstrap() {
	for source in app.bootstrap_boot_stages.keys() {
		if app.bootstrap_boot_stages[source] == .deferred {
			if app.booted {
				app.bootstrap_boot_stages.delete(source)
			} else {
				app.bootstrap_boot_stages[source] = .finish
			}
		}
	}
	if app.booted {
		for input in app.deferred_boot_inputs {
			mut saved := input
			saved.release()
		}
	} else {
		app.bootstrap_boot_inputs << app.deferred_boot_inputs
	}
	app.deferred_boot_inputs.clear()
}

fn (mut app VSlimApp) boot_bootstrap_stage(source string, stage BootstrapBootStage) ! {
	app.apply_boot() or {
		app.save_bootstrap_boot_stage(source, stage)
		return err
	}
	app.track_bootstrap_boot()
	app.bootstrap_boot_stages.delete(source)
}

pub fn (mut app VSlimApp) finish_bootstrap_boot(source string) ! {
	app.boot_bootstrap_stage(source, .finish)!
}

pub fn (mut app VSlimApp) resume_bootstrap_boot(source string) !bool {
	if app.bootstrap_boot_stages[source] != .finish {
		return false
	}
	app.finish_bootstrap_boot(source)!
	return true
}

fn (mut app VSlimApp) apply_bootstrap_iterable(spec vphp.PhpIterable) ! {
	state := app.watch_service_state()
	defer {
		state.close()
	}
	mut input := spec.to_value()
	defer {
		input.release()
	}
	saved_index := bootstrap_input_index(input, app.bootstrap_boot_inputs)
	if saved_index >= 0 {
		app.track_bootstrap_boot()
		app.apply_boot()!
		mut saved := app.bootstrap_boot_inputs[saved_index]
		app.bootstrap_boot_inputs.delete(saved_index)
		saved.release()
		return
	}
	mut run := app.bootstrap_input_run(input)
	mut progress := run.progress
	progress.start()!
	defer {
		progress.stop()
	}
	mut normalized := run.normalize(spec)!
	defer {
		normalized.release()
	}
	boot := app.configure_bootstrap_array_with_progress(normalized, 'inline', mut progress)!
	app.finish_bootstrap_input_run(run)
	if !app.booted && bootstrap_input_index(input, app.deferred_boot_inputs) < 0 {
		app.track_bootstrap_boot()
		app.deferred_boot_inputs << input.retain()
	}
	if boot {
		app.apply_boot()!
	}
}

fn (mut run BootstrapInputRun) normalize(spec vphp.PhpIterable) !vphp.PhpArray {
	if normalized := run.generator_spec.as_array() {
		return normalized
	}
	mut progress := run.progress
	normalized, unchanged := progress.normalize_for_retry('inline:spec', spec)!
	if unchanged && run.input.is_generator() {
		if _ := registrationx.current_registration_scope() {
			// The yielded spec can survive rollback independently of the applied steps.
			mut value := normalized.to_value()
			run.generator_spec = value.retain()
			value.release()
		}
	}
	return normalized
}

fn (mut app VSlimApp) bootstrap_input_run(input vphp.PhpValue) &BootstrapInputRun {
	if app.bootstrap_input_runs.len > 0 {
		index := bootstrap_input_index(input, app.bootstrap_input_runs.map(it.input))
		if index >= 0 {
			return app.bootstrap_input_runs[index]
		}
	}
	run := &BootstrapInputRun{
		input: input.retain()
		progress: supportx.BootstrapProgress.tracked()
	}
	app.bootstrap_input_runs << run
	if mut scope := registrationx.current_registration_scope() {
		receiver := &app
		scope.add_change(fn [receiver, run] (commit bool) {
			if !commit && !run.generator_spec.is_valid() {
				mut target := receiver
				target.remove_bootstrap_input_run(run)
				run.release()
			}
		})
	}
	return run
}

fn (mut app VSlimApp) remove_bootstrap_input_run(target &BootstrapInputRun) {
	for index, run in app.bootstrap_input_runs {
		if run == target {
			app.bootstrap_input_runs.delete(index)
			return
		}
	}
}

fn (mut app VSlimApp) finish_bootstrap_input_run(run &BootstrapInputRun) {
	app.remove_bootstrap_input_run(run)
	if mut scope := registrationx.current_registration_scope() {
		receiver := &app
		scope.add_change(fn [receiver, run] (commit bool) {
			if commit {
				run.release()
			} else {
				mut target := receiver
				target.bootstrap_input_runs << run
			}
		})
	} else {
		run.release()
	}
}

fn (run &BootstrapInputRun) release() {
	mut input := run.input
	input.release()
	mut generator_spec := run.generator_spec
	generator_spec.release()
	mut progress := run.progress
	progress.release()
}

fn (mut app VSlimApp) release_bootstrap_inputs() {
	for run in app.bootstrap_input_runs {
		run.release()
	}
	release_boot_inputs(mut app.bootstrap_boot_inputs)
	release_boot_inputs(mut app.deferred_boot_inputs)
	unsafe {
		app.bootstrap_input_runs.free()
	}
}

fn release_boot_inputs(mut inputs []vphp.PhpValue) {
	for input in inputs {
		mut saved := input
		saved.release()
	}
	unsafe {
		inputs.free()
	}
}

@[heap]
struct BootstrapBootState {
	booted   bool
	provider ComponentBootProgress
	module_  ComponentBootProgress
mut:
	stages   map[string]BootstrapBootStage
	pending  []vphp.PhpValue
	deferred []vphp.PhpValue
}

fn (mut app VSlimApp) track_bootstrap_boot() {
	mut scope := registrationx.current_registration_scope() or { return }
	if !scope.needs_snapshot(usize(&app.bootstrap_boot_stages)) {
		return
	}
	mut saved := &BootstrapBootState{
		booted: app.booted
		provider: app.provider_boot
		module_: app.module_boot
		stages: app.bootstrap_boot_stages.clone()
		pending: app.bootstrap_boot_inputs.map(it.retain())
		deferred: app.deferred_boot_inputs.map(it.retain())
	}
	receiver := &app
	scope.add_change(fn [receiver, mut saved] (commit bool) {
		mut target := receiver
		if !commit {
			target.restore_bootstrap_boot(mut saved)
		}
		release_boot_inputs(mut saved.pending)
		release_boot_inputs(mut saved.deferred)
		unsafe {
			saved.stages.free()
		}
	})
}

fn (mut app VSlimApp) restore_bootstrap_boot(mut saved BootstrapBootState) {
	app.booted = saved.booted
	app.provider_boot = saved.provider
	app.module_boot = saved.module_
	unsafe {
		saved.stages, app.bootstrap_boot_stages = app.bootstrap_boot_stages, saved.stages
		saved.pending, app.bootstrap_boot_inputs = app.bootstrap_boot_inputs, saved.pending
		saved.deferred, app.deferred_boot_inputs = app.deferred_boot_inputs, saved.deferred
	}
}

fn bootstrap_input_index(input vphp.PhpValue, inputs []vphp.PhpValue) int {
	if inputs.len == 0 {
		return -1
	}
	mut saved := vphp.PhpArray.new()
	mut strict := vphp.PhpBool.of(true)
	defer {
		saved.release()
		strict.release()
	}
	for item in inputs {
		saved.push_value(item)
	}
	return vphp.PhpFunction.named('array_search').with_result[vphp.PhpValue, int](fn (index vphp.PhpValue) int {
		return if index.is_long() { int(index.to_i64()) } else { -1 }
	}, input, saved, strict) or { -1 }
}
