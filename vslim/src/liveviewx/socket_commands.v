module liveviewx

import vphp

@[php_arg_name: 'target_id=targetId']
@[php_method]
pub fn (mut socket VSlimLiveSocket) patch(target_id string, html string) &VSlimLiveSocket {
	id := target_id.trim_space()
	if id == '' {
		return &socket
	}
	socket.patches << {
		'op':   'replace'
		'id':   id
		'html': html
	}
	return &socket
}

@[php_arg_name: 'target_id=targetId']
@[php_method]
pub fn (mut socket VSlimLiveSocket) append(target_id string, html string) &VSlimLiveSocket {
	id := target_id.trim_space()
	if id == '' {
		return &socket
	}
	socket.patches << {
		'op':   'append'
		'id':   id
		'html': html
	}
	return &socket
}

@[php_arg_name: 'target_id=targetId']
@[php_method]
pub fn (mut socket VSlimLiveSocket) prepend(target_id string, html string) &VSlimLiveSocket {
	id := target_id.trim_space()
	if id == '' {
		return &socket
	}
	socket.patches << {
		'op':   'prepend'
		'id':   id
		'html': html
	}
	return &socket
}

@[php_arg_name: 'target_id=targetId']
@[php_method: 'setText']
pub fn (mut socket VSlimLiveSocket) set_text(target_id string, text string) &VSlimLiveSocket {
	id := target_id.trim_space()
	if id == '' {
		return &socket
	}
	socket.patches << {
		'op':   'set_text'
		'id':   id
		'text': text
	}
	return &socket
}

@[php_arg_name: 'target_id=targetId']
@[php_method: 'setAttr']
pub fn (mut socket VSlimLiveSocket) set_attr(target_id string, name string, value string) &VSlimLiveSocket {
	id := target_id.trim_space()
	attr_name := name.trim_space()
	if id == '' || attr_name == '' {
		return &socket
	}
	socket.patches << {
		'op':    'set_attr'
		'id':    id
		'name':  attr_name
		'value': value
	}
	return &socket
}

@[php_arg_name: 'target_id=targetId']
@[php_method]
pub fn (mut socket VSlimLiveSocket) remove(target_id string) &VSlimLiveSocket {
	id := target_id.trim_space()
	if id == '' {
		return &socket
	}
	socket.patches << {
		'op': 'remove'
		'id': id
	}
	return &socket
}

@[php_method]
pub fn (socket &VSlimLiveSocket) patches() []map[string]string {
	return clone_entries(socket.patches)
}

@[php_method: 'clearPatches']
pub fn (mut socket VSlimLiveSocket) clear_patches() &VSlimLiveSocket {
	socket.patches = []map[string]string{}
	return &socket
}

@[php_method: 'pushEvent']
pub fn (mut socket VSlimLiveSocket) push_event(event string, payload string) &VSlimLiveSocket {
	name := event.trim_space()
	if name == '' {
		return &socket
	}
	socket.events << {
		'event':   name
		'payload': payload
	}
	return &socket
}

@[php_method]
pub fn (socket &VSlimLiveSocket) events() []map[string]string {
	return clone_entries(socket.events)
}

@[php_method: 'clearEvents']
pub fn (mut socket VSlimLiveSocket) clear_events() &VSlimLiveSocket {
	socket.events = []map[string]string{}
	return &socket
}

@[php_method]
pub fn (mut socket VSlimLiveSocket) flash(kind string, message string) &VSlimLiveSocket {
	level := kind.trim_space()
	body := message.trim_space()
	if level == '' || body == '' {
		return &socket
	}
	socket.flashes << {
		'kind':    level
		'message': body
	}
	return &socket
}

@[php_method]
pub fn (socket &VSlimLiveSocket) flashes() []map[string]string {
	return clone_entries(socket.flashes)
}

@[php_method: 'clearFlashes']
pub fn (mut socket VSlimLiveSocket) clear_flashes() &VSlimLiveSocket {
	socket.flashes = []map[string]string{}
	return &socket
}

@[php_method: 'joinTopic']
pub fn (mut socket VSlimLiveSocket) join_topic(room string) &VSlimLiveSocket {
	topic := room.trim_space()
	if topic == '' {
		return &socket
	}
	socket.pubsub << {
		'op':   'join'
		'room': topic
	}
	return &socket
}

@[php_method: 'leaveTopic']
pub fn (mut socket VSlimLiveSocket) leave_topic(room string) &VSlimLiveSocket {
	topic := room.trim_space()
	if topic == '' {
		return &socket
	}
	socket.pubsub << {
		'op':   'leave'
		'room': topic
	}
	return &socket
}

@[php_arg_name: 'include_self=includeSelf']
@[php_method: 'broadcastInfo']
pub fn (mut socket VSlimLiveSocket) broadcast_info(room string, event string, payload vphp.PhpValue, include_self bool) &VSlimLiveSocket {
	topic := room.trim_space()
	name := event.trim_space()
	if topic == '' || name == '' {
		return &socket
	}
	socket.pubsub << {
		'op':           'broadcast_info'
		'room':         topic
		'event':        name
		'payload':      json_payload(payload)
		'include_self': if include_self { 'true' } else { 'false' }
	}
	return &socket
}

@[php_method: 'pubsubCommands']
pub fn (socket &VSlimLiveSocket) pubsub_commands() []map[string]string {
	return clone_entries(socket.pubsub)
}

@[php_method: 'clearPubsub']
pub fn (mut socket VSlimLiveSocket) clear_pubsub() &VSlimLiveSocket {
	socket.pubsub = []map[string]string{}
	return &socket
}

@[php_method]
pub fn (mut socket VSlimLiveSocket) redirect(location string) &VSlimLiveSocket {
	socket.redirect_to = location.trim_space()
	socket.navigate_to = ''
	return &socket
}

@[php_method: 'redirectTo']
pub fn (socket &VSlimLiveSocket) redirect_to() string {
	return socket.redirect_to
}

@[php_method: 'clearRedirect']
pub fn (mut socket VSlimLiveSocket) clear_redirect() &VSlimLiveSocket {
	socket.redirect_to = ''
	return &socket
}

@[php_method]
pub fn (mut socket VSlimLiveSocket) navigate(location string) &VSlimLiveSocket {
	socket.navigate_to = location.trim_space()
	socket.redirect_to = ''
	return &socket
}

@[php_method: 'navigateTo']
pub fn (socket &VSlimLiveSocket) navigate_to() string {
	return socket.navigate_to
}

@[php_method: 'clearNavigate']
pub fn (mut socket VSlimLiveSocket) clear_navigate() &VSlimLiveSocket {
	socket.navigate_to = ''
	return &socket
}
