module feishux

import vphp

const bot_adapter = 'VSlim\\App\\Feishu\\BotAdapter'
const feishu_namespace = 'VHttpd\\Upstream\\WebSocket\\Feishu'

@[vphp.PhpExportClass(name: 'VSlim\\App\\Feishu\\BotApp')]
@[vphp.PhpFinalClass]
@[vphp.PhpZendPropertyCopy]
@[vphp.PhpClassAttribute(name: 'VHttpd\\Attribute\\Dispatchable', args: '"websocket_upstream"')]
@[heap]
pub struct VSlimFeishuBotApp {}

const bot_app_properties = vphp.PhpDeclaredProperties[VSlimFeishuBotApp]{
	properties: [vphp.PhpDeclaredPropertySpec{
		name:        'handler'
		php_type:    'VSlim\\App\\Feishu\\BotHandler'
		visibility:  .private
		is_readonly: true
	}]
}

@[vphp.PhpExportMethod(name: '')]
@[vphp.PhpArgType(v_name: 'handler', php_type: 'VSlim\\App\\Feishu\\BotHandler')]
pub fn (app &VSlimFeishuBotApp) construct(handler vphp.PhpObject) {
	vphp.ZendObject.current().set_prop_input('handler', handler)
}

@[vphp.PhpExportMethod(name: '')]
pub fn (app &VSlimFeishuBotApp) handle(frame vphp.PhpArray) vphp.PhpArray {
	return app.handle_websocket_upstream(frame)
}

@[vphp.PhpExportMethod(name: 'handle_websocket_upstream')]
pub fn (app &VSlimFeishuBotApp) handle_websocket_upstream(frame vphp.PhpArray) vphp.PhpArray {
	adapter := vphp.PhpClass.named(bot_adapter)
	mut message := adapter.call_static('parseMessageObject', frame)
	defer {
		message.release()
	}
	if vphp.has_exception() {
		return unhandled()
	}
	if message.is_object() {
		callback := message_callback(message.to_zval().class_name())
		return if callback == '' { unhandled() } else { dispatch(callback, message) }
	}

	mut event := adapter.call_static('parseEventObject', frame)
	defer {
		event.release()
	}
	if !event.is_instance_of(feishu_namespace + '\\Event\\CardActionEvent') {
		return unhandled()
	}
	return dispatch('onCardAction', event)
}

@[vphp.PhpExportMethod(name: 'handleWebSocketUpstream')]
pub fn (app &VSlimFeishuBotApp) handle_websocket_upstream_camel(frame vphp.PhpArray) vphp.PhpArray {
	return app.handle_websocket_upstream(frame)
}

fn message_callback(class_name string) string {
	return match class_name {
		feishu_namespace + '\\Message\\TextMessage' { 'onTextMessage' }
		feishu_namespace + '\\Message\\ImageMessage' { 'onImageMessage' }
		feishu_namespace + '\\Message\\PostMessage' { 'onPostMessage' }
		feishu_namespace + '\\Message\\FileMessage' { 'onFileMessage' }
		feishu_namespace + '\\Message\\AudioMessage' { 'onAudioMessage' }
		feishu_namespace + '\\Message\\MediaMessage' { 'onMediaMessage' }
		feishu_namespace + '\\Message\\StickerMessage' { 'onStickerMessage' }
		else { '' }
	}
}

fn dispatch(callback string, event vphp.PhpValue) vphp.PhpArray {
	handler := vphp.ZendObject.current().prop_borrowed('handler')
	if !handler.is_object() {
		return unhandled()
	}
	mut result := vphp.PhpObject.borrowed(handler).call_method(callback, event)
	defer {
		result.release()
	}
	if !result.is_instance_of(feishu_namespace + '\\Command') {
		return unhandled()
	}

	mut command := result.call_method('toArray')
	defer {
		command.release()
	}
	mut commands := vphp.PhpArray.new()
	defer {
		commands.release()
	}
	commands.push_value(command)
	mut response := vphp.PhpArray.new()
	response.bool('handled', true)
	response.set('commands', commands)
	return response
}

fn unhandled() vphp.PhpArray {
	mut commands := vphp.PhpArray.new()
	defer {
		commands.release()
	}
	mut response := vphp.PhpArray.new()
	response.bool('handled', false)
	response.set('commands', commands)
	return response
}
