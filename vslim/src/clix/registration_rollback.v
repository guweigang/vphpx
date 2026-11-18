module clix

import registrationx
import vphp

struct CliCommandRegistration {
	handler        vphp.PhpValue
	hidden         bool
	aliases        []string
	alias_handlers map[string]vphp.PhpValue
}

fn (mut cli VSlimCliApp) take_command_registration(name string) CliCommandRegistration {
	handler := cli.command_handlers[name] or { vphp.PhpValue.invalid() }
	hidden := cli.command_hidden[name] or { false }
	aliases := cli.command_aliases[name] or { []string{} }
	mut alias_handlers := map[string]vphp.PhpValue{}
	for alias in aliases {
		if cli.command_canonical[alias] != name {
			continue
		}
		if value := cli.command_handlers[alias] {
			alias_handlers[alias] = value
			cli.command_handlers.delete(alias)
			cli.command_canonical.delete(alias)
		}
	}
	cli.command_handlers.delete(name)
	cli.command_canonical.delete(name)
	cli.command_hidden.delete(name)
	cli.command_aliases.delete(name)
	return CliCommandRegistration{
		handler:        handler
		hidden:         hidden
		aliases:        aliases
		alias_handlers: alias_handlers
	}
}

fn (mut cli VSlimCliApp) restore_command_registration(name string, saved CliCommandRegistration) {
	if !saved.handler.is_valid() {
		index := cli.command_order.index(name)
		if index >= 0 {
			cli.command_order.delete(index)
		}
		return
	}
	cli.command_handlers[name] = saved.handler
	cli.command_canonical[name] = name
	cli.command_hidden[name] = saved.hidden
	if saved.aliases.len > 0 {
		cli.command_aliases[name] = saved.aliases
	}
	for alias, handler in saved.alias_handlers {
		cli.command_handlers[alias] = handler
		cli.command_canonical[alias] = name
	}
}

fn (saved CliCommandRegistration) release_handlers() {
	mut handler := saved.handler
	handler.release()
	for _, value in saved.alias_handlers {
		mut alias_handler := value
		alias_handler.release()
	}
}

fn (mut cli VSlimCliApp) replace_command_registration(name string) {
	mut scope := registrationx.current_registration_scope() or {
		cli.clear_command_metadata(name)
		return
	}
	stable_name := name.clone()
	saved := cli.take_command_registration(name)
	receiver := &cli
	scope.add_change(fn [receiver, stable_name, saved] (commit bool) {
		if commit {
			saved.release_handlers()
		} else {
			mut target := receiver
			failed := target.take_command_registration(stable_name)
			target.restore_command_registration(stable_name, saved)
			failed.release_handlers()
		}
	})
}
