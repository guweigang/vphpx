module eventx

import vphp

#include "php_bridge.h"

__global C.vslim__psr14__listenerprovider_ce &C.zend_class_entry
__global C.vslim__psr14__eventdispatcher_ce &C.zend_class_entry

@[export: 'vslim_psr14_listener_provider_new_raw']
pub fn vslim_psr14_listener_provider_new_raw() voidptr {
    return vphp.generic_new_raw[VSlimPsr14ListenerProvider]()
}
@[export: 'vslim_psr14_listener_provider_free_raw']
pub fn vslim_psr14_listener_provider_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[VSlimPsr14ListenerProvider](ptr)
}
@[export: 'vslim_psr14_listener_provider_cleanup_raw']
pub fn vslim_psr14_listener_provider_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    unsafe {
        mut obj := &VSlimPsr14ListenerProvider(ptr)
        obj.free()
    }
}
@[export: 'vslim_psr14_listener_provider_get_prop']
pub fn vslim_psr14_listener_provider_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = rv
}
@[export: 'vslim_psr14_listener_provider_set_prop']
pub fn vslim_psr14_listener_provider_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = value
}
@[export: 'vslim_psr14_listener_provider_sync_props']
pub fn vslim_psr14_listener_provider_sync_props(ptr voidptr, zv &C.zval) {
    _ = ptr
    _ = zv
}
@[export: 'vphp_wrap_vslim_psr14_listener_provider_construct']
pub fn vphp_wrap_vslim_psr14_listener_provider_construct(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsr14ListenerProvider(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.construct()
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_psr14_listener_provider_listen']
pub fn vphp_wrap_vslim_psr14_listener_provider_listen(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsr14ListenerProvider(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'eventClass', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'listener', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'eventClass').as_v[string]()
    arg_1 := php_args.at_named_or_index(1, 'listener').callable() or {
        vphp.throw_exception('argument 1 must be callable', 0)
        return unsafe { nil }
    }
    res := recv.listen(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_psr14_listener_provider_listen_any']
pub fn vphp_wrap_vslim_psr14_listener_provider_listen_any(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsr14ListenerProvider(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'listener', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'listener').callable() or {
        vphp.throw_exception('argument 0 must be callable', 0)
        return unsafe { nil }
    }
    res := recv.listen_any(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_psr14_listener_provider_listener_count']
pub fn vphp_wrap_vslim_psr14_listener_provider_listener_count(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsr14ListenerProvider(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.listener_count()
    ctx.return().v[int](res)
}
@[export: 'vphp_wrap_vslim_psr14_listener_provider_get_listeners_for_event']
pub fn vphp_wrap_vslim_psr14_listener_provider_get_listeners_for_event(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsr14ListenerProvider(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'event', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'event').object() or {
        vphp.throw_exception('argument 0 must be object', 0)
        return
    }
    res := recv.get_listeners_for_event(arg_0)
    ctx.return().v[vphp.PhpValue](res)
}
@[export: 'vslim_psr14_listener_provider_handlers']
pub fn vslim_psr14_listener_provider_handlers() voidptr {
    return vphp.ZendClassHandlers.new(
        prop_handler: voidptr(vslim_psr14_listener_provider_get_prop),
        write_handler: voidptr(vslim_psr14_listener_provider_set_prop),
        sync_handler: voidptr(vslim_psr14_listener_provider_sync_props),
        new_raw: voidptr(vslim_psr14_listener_provider_new_raw),
        cleanup_raw: voidptr(vslim_psr14_listener_provider_cleanup_raw),
        free_raw: voidptr(vslim_psr14_listener_provider_free_raw)
    )
}
pub fn VSlimPsr14ListenerProvider.php_class_entry() vphp.ZendClassEntry {
    return vphp.ZendClassEntry.from_ptr(C.vslim__psr14__listenerprovider_ce)
}

pub fn VSlimPsr14ListenerProvider.php_object_handlers() voidptr {
    return vslim_psr14_listener_provider_handlers()
}

pub fn VSlimPsr14ListenerProvider.php_object_zval(v_ptr voidptr, ownership vphp.OwnershipKind) vphp.ZVal {
    return vphp.bind_object_zval[VSlimPsr14ListenerProvider](v_ptr, ownership)
}

pub fn (obj &VSlimPsr14ListenerProvider) bind_php_object() vphp.ZVal {
    return vphp.bind_borrowed_object_zval[VSlimPsr14ListenerProvider](obj)
}

pub fn (obj &VSlimPsr14ListenerProvider) bind_php_object_value() vphp.PhpValue {
    return vphp.bind_borrowed_object_value[VSlimPsr14ListenerProvider](obj)
}

pub fn (obj &VSlimPsr14ListenerProvider) bind_owned_php_object() vphp.ZVal {
    return vphp.bind_owned_object_zval[VSlimPsr14ListenerProvider](obj)
}

pub fn (obj &VSlimPsr14ListenerProvider) bind_owned_php_object_value() vphp.PhpValue {
    return vphp.bind_owned_object_value[VSlimPsr14ListenerProvider](obj)
}

pub fn (val VSlimPsr14ListenerProvider) php_class_name() string {
    return 'VSlim\\Psr14\\ListenerProvider'
}

@[export: 'vslim_psr14_event_dispatcher_new_raw']
pub fn vslim_psr14_event_dispatcher_new_raw() voidptr {
    return vphp.generic_new_raw[VSlimPsr14EventDispatcher]()
}
@[export: 'vslim_psr14_event_dispatcher_free_raw']
pub fn vslim_psr14_event_dispatcher_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[VSlimPsr14EventDispatcher](ptr)
}
@[export: 'vslim_psr14_event_dispatcher_cleanup_raw']
pub fn vslim_psr14_event_dispatcher_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
}
@[export: 'vslim_psr14_event_dispatcher_get_prop']
pub fn vslim_psr14_event_dispatcher_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = rv
}
@[export: 'vslim_psr14_event_dispatcher_set_prop']
pub fn vslim_psr14_event_dispatcher_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = value
}
@[export: 'vslim_psr14_event_dispatcher_sync_props']
pub fn vslim_psr14_event_dispatcher_sync_props(ptr voidptr, zv &C.zval) {
    _ = ptr
    _ = zv
}
@[export: 'vphp_wrap_vslim_psr14_event_dispatcher_construct']
pub fn vphp_wrap_vslim_psr14_event_dispatcher_construct(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsr14EventDispatcher(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.construct()
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_psr14_event_dispatcher_set_provider']
pub fn vphp_wrap_vslim_psr14_event_dispatcher_set_provider(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsr14EventDispatcher(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'provider', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := unsafe { &eventx.VSlimPsr14ListenerProvider(php_args.at_named_or_index(0, 'provider').raw_obj()) }
    res := recv.set_provider(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_psr14_event_dispatcher_provider']
pub fn vphp_wrap_vslim_psr14_event_dispatcher_provider(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsr14EventDispatcher(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.provider()
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_psr14_event_dispatcher_listen']
pub fn vphp_wrap_vslim_psr14_event_dispatcher_listen(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsr14EventDispatcher(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'eventClass', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'listener', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'eventClass').as_v[string]()
    arg_1 := php_args.at_named_or_index(1, 'listener').callable() or {
        vphp.throw_exception('argument 1 must be callable', 0)
        return unsafe { nil }
    }
    res := recv.listen(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_psr14_event_dispatcher_listen_any']
pub fn vphp_wrap_vslim_psr14_event_dispatcher_listen_any(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsr14EventDispatcher(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'listener', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'listener').callable() or {
        vphp.throw_exception('argument 0 must be callable', 0)
        return unsafe { nil }
    }
    res := recv.listen_any(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_psr14_event_dispatcher_dispatch']
pub fn vphp_wrap_vslim_psr14_event_dispatcher_dispatch(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsr14EventDispatcher(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'event', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'event').object() or {
        vphp.throw_exception('argument 0 must be object', 0)
        return
    }
    res := recv.dispatch(arg_0)
    ctx.return().v[vphp.PhpObject](res)
}
@[export: 'vslim_psr14_event_dispatcher_handlers']
pub fn vslim_psr14_event_dispatcher_handlers() voidptr {
    return vphp.ZendClassHandlers.new(
        prop_handler: voidptr(vslim_psr14_event_dispatcher_get_prop),
        write_handler: voidptr(vslim_psr14_event_dispatcher_set_prop),
        sync_handler: voidptr(vslim_psr14_event_dispatcher_sync_props),
        new_raw: voidptr(vslim_psr14_event_dispatcher_new_raw),
        cleanup_raw: voidptr(vslim_psr14_event_dispatcher_cleanup_raw),
        free_raw: voidptr(vslim_psr14_event_dispatcher_free_raw)
    )
}
pub fn VSlimPsr14EventDispatcher.php_class_entry() vphp.ZendClassEntry {
    return vphp.ZendClassEntry.from_ptr(C.vslim__psr14__eventdispatcher_ce)
}

pub fn VSlimPsr14EventDispatcher.php_object_handlers() voidptr {
    return vslim_psr14_event_dispatcher_handlers()
}

pub fn VSlimPsr14EventDispatcher.php_object_zval(v_ptr voidptr, ownership vphp.OwnershipKind) vphp.ZVal {
    return vphp.bind_object_zval[VSlimPsr14EventDispatcher](v_ptr, ownership)
}

pub fn (obj &VSlimPsr14EventDispatcher) bind_php_object() vphp.ZVal {
    return vphp.bind_borrowed_object_zval[VSlimPsr14EventDispatcher](obj)
}

pub fn (obj &VSlimPsr14EventDispatcher) bind_php_object_value() vphp.PhpValue {
    return vphp.bind_borrowed_object_value[VSlimPsr14EventDispatcher](obj)
}

pub fn (obj &VSlimPsr14EventDispatcher) bind_owned_php_object() vphp.ZVal {
    return vphp.bind_owned_object_zval[VSlimPsr14EventDispatcher](obj)
}

pub fn (obj &VSlimPsr14EventDispatcher) bind_owned_php_object_value() vphp.PhpValue {
    return vphp.bind_owned_object_value[VSlimPsr14EventDispatcher](obj)
}

pub fn (val VSlimPsr14EventDispatcher) php_class_name() string {
    return 'VSlim\\Psr14\\EventDispatcher'
}

