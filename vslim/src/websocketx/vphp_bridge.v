module websocketx

import vphp
import vphp.object

#include "php_bridge.h"

__global C.vslim__websocket__app_ce &C.zend_class_entry

@[export: 'vslim_web_socket_app_new_raw']
pub fn vslim_web_socket_app_new_raw() voidptr {
    return vphp.generic_new_raw[VSlimWebSocketApp]()
}
@[export: 'vslim_web_socket_app_free_raw']
pub fn vslim_web_socket_app_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[VSlimWebSocketApp](ptr)
}
@[export: 'vslim_web_socket_app_cleanup_raw']
pub fn vslim_web_socket_app_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    unsafe {
        mut obj := &VSlimWebSocketApp(ptr)
        obj.free()
    }
}
@[export: 'vslim_web_socket_app_get_prop']
pub fn vslim_web_socket_app_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = rv
}
@[export: 'vslim_web_socket_app_set_prop']
pub fn vslim_web_socket_app_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = value
}
@[export: 'vslim_web_socket_app_sync_props']
pub fn vslim_web_socket_app_sync_props(ptr voidptr, zv &C.zval) {
    _ = ptr
    _ = zv
}
@[export: 'vphp_wrap_vslim_web_socket_app_construct']
pub fn vphp_wrap_vslim_web_socket_app_construct(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimWebSocketApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_php_defaults([
        vphp.PhpArgMeta{ index: 0, name: 'onOpen', use_php_default: true },
        vphp.PhpArgMeta{ index: 1, name: 'onMessage', use_php_default: true },
        vphp.PhpArgMeta{ index: 2, name: 'onClose', use_php_default: true },
    ]) or {
        return
    }
    arg_0 := php_args.at(0).callable()
    arg_1 := php_args.at(1).callable()
    arg_2 := php_args.at(2).callable()
    res := recv.construct(arg_0, arg_1, arg_2)
    ctx.return().return_v_object[VSlimWebSocketApp](res, .borrowed)
}
@[export: 'vphp_wrap_vslim_web_socket_app_on_open']
pub fn vphp_wrap_vslim_web_socket_app_on_open(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimWebSocketApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'handler' },
    ])
    arg_0 := php_args.at(0).callable() or {
        vphp.throw_exception('argument 0 must be callable', 0)
        return unsafe { nil }
    }
    res := recv.on_open(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_web_socket_app_on_message']
pub fn vphp_wrap_vslim_web_socket_app_on_message(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimWebSocketApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'handler' },
    ])
    arg_0 := php_args.at(0).callable() or {
        vphp.throw_exception('argument 0 must be callable', 0)
        return unsafe { nil }
    }
    res := recv.on_message(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_web_socket_app_on_close']
pub fn vphp_wrap_vslim_web_socket_app_on_close(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimWebSocketApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'handler' },
    ])
    arg_0 := php_args.at(0).callable() or {
        vphp.throw_exception('argument 0 must be callable', 0)
        return unsafe { nil }
    }
    res := recv.on_close(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_web_socket_app_has_on_open']
pub fn vphp_wrap_vslim_web_socket_app_has_on_open(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimWebSocketApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.has_on_open()
    ctx.return().v[bool](res)
}
@[export: 'vphp_wrap_vslim_web_socket_app_has_on_message']
pub fn vphp_wrap_vslim_web_socket_app_has_on_message(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimWebSocketApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.has_on_message()
    ctx.return().v[bool](res)
}
@[export: 'vphp_wrap_vslim_web_socket_app_has_on_close']
pub fn vphp_wrap_vslim_web_socket_app_has_on_close(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimWebSocketApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.has_on_close()
    ctx.return().v[bool](res)
}
@[export: 'vphp_wrap_vslim_web_socket_app_remember']
pub fn vphp_wrap_vslim_web_socket_app_remember(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimWebSocketApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'conn' },
    ])
    arg_0 := php_args.at(0).object() or {
        vphp.throw_exception('argument 0 must be object', 0)
        return unsafe { nil }
    }
    res := recv.remember(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_web_socket_app_forget']
pub fn vphp_wrap_vslim_web_socket_app_forget(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimWebSocketApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'connOrId' },
    ])
    arg_0 := php_args.at(0).value
    res := recv.forget(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_web_socket_app_has_connection']
pub fn vphp_wrap_vslim_web_socket_app_has_connection(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimWebSocketApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'connOrId' },
    ])
    arg_0 := php_args.at(0).value
    res := recv.has_connection(arg_0)
    ctx.return().v[bool](res)
}
@[export: 'vphp_wrap_vslim_web_socket_app_join']
pub fn vphp_wrap_vslim_web_socket_app_join(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimWebSocketApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'room' },
        vphp.PhpArgMeta{ index: 1, name: 'connOrId' },
    ])
    arg_0 := php_args.at(0).as_v[string]()
    arg_1 := php_args.at(1).value
    res := recv.join(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_web_socket_app_leave']
pub fn vphp_wrap_vslim_web_socket_app_leave(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimWebSocketApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'room' },
        vphp.PhpArgMeta{ index: 1, name: 'connOrId' },
    ])
    arg_0 := php_args.at(0).as_v[string]()
    arg_1 := php_args.at(1).value
    res := recv.leave(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_web_socket_app_members']
pub fn vphp_wrap_vslim_web_socket_app_members(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimWebSocketApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'room' },
    ])
    arg_0 := php_args.at(0).as_v[string]()
    res := recv.members(arg_0)
    ctx.return().v[[]string](res)
}
@[export: 'vphp_wrap_vslim_web_socket_app_connection_ids']
pub fn vphp_wrap_vslim_web_socket_app_connection_ids(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimWebSocketApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.connection_ids()
    ctx.return().v[[]string](res)
}
@[export: 'vphp_wrap_vslim_web_socket_app_rooms_for']
pub fn vphp_wrap_vslim_web_socket_app_rooms_for(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimWebSocketApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'connOrId' },
    ])
    arg_0 := php_args.at(0).value
    res := recv.rooms_for(arg_0)
    ctx.return().v[[]string](res)
}
@[export: 'vphp_wrap_vslim_web_socket_app_send_to']
pub fn vphp_wrap_vslim_web_socket_app_send_to(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimWebSocketApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'connOrId' },
        vphp.PhpArgMeta{ index: 1, name: 'data' },
    ])
    arg_0 := php_args.at(0).value
    arg_1 := php_args.at(1).as_v[string]()
    res := recv.send_to(arg_0, arg_1)
    ctx.return().v[bool](res)
}
@[export: 'vphp_wrap_vslim_web_socket_app_broadcast']
pub fn vphp_wrap_vslim_web_socket_app_broadcast(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimWebSocketApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'data' },
        vphp.PhpArgMeta{ index: 1, name: 'room' },
        vphp.PhpArgMeta{ index: 2, name: 'exceptId' },
    ])
    arg_0 := php_args.at(0).as_v[string]()
    arg_1 := php_args.at(1).as_v[string]()
    arg_2 := php_args.at(2).as_v[string]()
    res := recv.broadcast(arg_0, arg_1, arg_2)
    ctx.return().v[int](res)
}
@[export: 'vphp_wrap_vslim_web_socket_app_handle']
pub fn vphp_wrap_vslim_web_socket_app_handle(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimWebSocketApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'frame' },
        vphp.PhpArgMeta{ index: 1, name: 'conn' },
    ])
    arg_0 := php_args.at(0).array() or {
        vphp.throw_exception('argument 0 must be array', 0)
        return
    }
    arg_1 := php_args.at(1).object() or {
        vphp.throw_exception('argument 1 must be object', 0)
        return
    }
    res := recv.handle(arg_0, arg_1)
    ctx.return().v[vphp.PhpValue](res)
}
@[export: 'vphp_wrap_vslim_web_socket_app_handle_websocket']
pub fn vphp_wrap_vslim_web_socket_app_handle_websocket(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimWebSocketApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'frame' },
        vphp.PhpArgMeta{ index: 1, name: 'conn' },
    ])
    arg_0 := php_args.at(0).array() or {
        vphp.throw_exception('argument 0 must be array', 0)
        return
    }
    arg_1 := php_args.at(1).object() or {
        vphp.throw_exception('argument 1 must be object', 0)
        return
    }
    res := recv.handle_websocket(arg_0, arg_1)
    ctx.return().v[vphp.PhpValue](res)
}
@[export: 'vslim_web_socket_app_handlers']
pub fn vslim_web_socket_app_handlers() voidptr {
    return vphp.ZendClassHandlers.new_typed(
        prop_handler: vslim_web_socket_app_get_prop,
        write_handler: vslim_web_socket_app_set_prop,
        sync_handler: vslim_web_socket_app_sync_props,
        new_raw: vslim_web_socket_app_new_raw,
        cleanup_raw: vslim_web_socket_app_cleanup_raw,
        free_raw: vslim_web_socket_app_free_raw,
        init_php_state: vslim_web_socket_app_init_php_state
    )
}
fn vslim_web_socket_app_init_php_state(ptr voidptr) {
    unsafe {
        mut obj := &VSlimWebSocketApp(ptr)
        obj.init_php_state()
    }
}
pub fn VSlimWebSocketApp.php_class_entry() vphp.ZendClassEntry {
    return vphp.ZendClassEntry.from_ptr(C.vslim__websocket__app_ce)
}

pub fn VSlimWebSocketApp.php_object_handlers() object.ObjectHandlers {
    return object.ObjectHandlers.from_ptr(vslim_web_socket_app_handlers())
}

pub fn VSlimWebSocketApp.php_object_zval(v_ptr voidptr, ownership vphp.OwnershipKind) vphp.ZVal {
    return vphp.bind_object_zval[VSlimWebSocketApp](v_ptr, ownership)
}

pub fn (obj &VSlimWebSocketApp) bind_php_object() vphp.ZVal {
    return vphp.bind_borrowed_object_zval[VSlimWebSocketApp](obj)
}

pub fn (obj &VSlimWebSocketApp) bind_php_object_value() vphp.PhpValue {
    return vphp.bind_borrowed_object_value[VSlimWebSocketApp](obj)
}

pub fn (obj &VSlimWebSocketApp) bind_owned_php_object() vphp.ZVal {
    return vphp.bind_owned_object_zval[VSlimWebSocketApp](obj)
}

pub fn (obj &VSlimWebSocketApp) bind_owned_php_object_value() vphp.PhpValue {
    return vphp.bind_owned_object_value[VSlimWebSocketApp](obj)
}

pub fn (val VSlimWebSocketApp) php_class_name() string {
    return 'VSlim\\WebSocket\\App'
}

