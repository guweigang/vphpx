module clix

import appx
import vphp

fn (cli &VSlimCliApp) bind_core_app(state vphp.PhpArray) {
	mut value := vphp.bind_owned_object_value[appx.VSlimApp](cli.core_app_ref)
	state.set('core_app', value)
	value.release()
}

pub fn (mut cli VSlimCliApp) init_php_state() {
	state := vphp.owned_object_php_state(cli) or { return }
	if cli.core_app_ref != unsafe { nil } {
		cli.bind_core_app(state)
	}
	if cli.command_handlers.len > 0 {
		stored := cli.php_command_handlers() or { return }
		for name, entry in cli.command_handlers {
			mut handler := entry
			stored.set_value(name, handler)
			handler.release()
		}
		cli.command_handlers.clear()
	}
}

fn (cli &VSlimCliApp) php_command_handlers() ?vphp.PhpArray {
	state := vphp.owned_object_php_state(cli)?
	if handlers := state.value_at('command_handlers').as_array() {
		return handlers
	}
	mut handlers := vphp.PhpArray.new()
	state.set('command_handlers', handlers)
	handlers.release()
	return state.value_at('command_handlers').as_array()
}

fn (cli &VSlimCliApp) find_command_handler(name string) ?vphp.PhpValue {
	if stored := cli.php_command_handlers() {
		return stored.find(name)
	}
	return cli.command_handlers[name] or { return none }
}

fn (mut cli VSlimCliApp) take_command_handler(name string) ?vphp.PhpValue {
	if stored := cli.php_command_handlers() {
		value := stored.find(name)?
		saved := value.retain()
		stored.remove(name)
		return saved
	}
	saved := cli.command_handlers[name] or { return none }
	cli.command_handlers.delete(name)
	return saved
}

// Consumes the retained handler passed by registration or rollback.
fn (mut cli VSlimCliApp) store_command_handler(name string, handler vphp.PhpValue) {
	if stored := cli.php_command_handlers() {
		mut retained := handler
		stored.set_value(name, retained)
		retained.release()
		return
	}
	previous := cli.command_handlers[name]
	cli.command_handlers[name] = handler
	mut released := previous
	released.release()
}
