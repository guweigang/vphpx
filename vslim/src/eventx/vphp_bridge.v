module eventx

import vphp

#include "php_bridge.h"

__global C.vslim__psr14__listenerprovider_ce &C.zend_class_entry
__global C.vslim__psr14__eventdispatcher_ce &C.zend_class_entry

@[export: 'VSlimPsr14ListenerProvider_new_raw']
pub fn vslimpsr14listenerprovider_new_raw() voidptr {
    return vphp.generic_new_raw[VSlimPsr14ListenerProvider]()
}
@[export: 'VSlimPsr14ListenerProvider_free_raw']
pub fn vslimpsr14listenerprovider_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[VSlimPsr14ListenerProvider](ptr)
}
@[export: 'VSlimPsr14ListenerProvider_cleanup_raw']
pub fn vslimpsr14listenerprovider_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    unsafe {
        mut obj := &VSlimPsr14ListenerProvider(ptr)
        obj.free()
    }
}
@[export: 'VSlimPsr14ListenerProvider_get_prop']
pub fn vslimpsr14listenerprovider_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = rv
}
@[export: 'VSlimPsr14ListenerProvider_set_prop']
pub fn vslimpsr14listenerprovider_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = value
}
@[export: 'VSlimPsr14ListenerProvider_sync_props']
pub fn vslimpsr14listenerprovider_sync_props(ptr voidptr, zv &C.zval) {
    _ = ptr
    _ = zv
}
@[export: 'vphp_wrap_VSlimPsr14ListenerProvider_construct']
pub fn vphp_wrap_vslimpsr14listenerprovider_construct(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsr14ListenerProvider(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.construct()
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimPsr14ListenerProvider_listen']
pub fn vphp_wrap_vslimpsr14listenerprovider_listen(ptr voidptr, ctx vphp.Context) voidptr {
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
@[export: 'vphp_wrap_VSlimPsr14ListenerProvider_listen_any']
pub fn vphp_wrap_vslimpsr14listenerprovider_listen_any(ptr voidptr, ctx vphp.Context) voidptr {
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
@[export: 'vphp_wrap_VSlimPsr14ListenerProvider_listener_count']
pub fn vphp_wrap_vslimpsr14listenerprovider_listener_count(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsr14ListenerProvider(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.listener_count()
    ctx.return().v[int](res)
}
@[export: 'vphp_wrap_VSlimPsr14ListenerProvider_get_listeners_for_event']
pub fn vphp_wrap_vslimpsr14listenerprovider_get_listeners_for_event(ptr voidptr, ctx vphp.Context)  {
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
@[export: 'VSlimPsr14ListenerProvider_handlers']
pub fn vslimpsr14listenerprovider_handlers() voidptr {
    return vphp.ZendClassHandlers.new(
        prop_handler: voidptr(vslimpsr14listenerprovider_get_prop),
        write_handler: voidptr(vslimpsr14listenerprovider_set_prop),
        sync_handler: voidptr(vslimpsr14listenerprovider_sync_props),
        new_raw: voidptr(vslimpsr14listenerprovider_new_raw),
        cleanup_raw: voidptr(vslimpsr14listenerprovider_cleanup_raw),
        free_raw: voidptr(vslimpsr14listenerprovider_free_raw)
    )
}
pub fn VSlimPsr14ListenerProvider.php_class_entry() vphp.ZendClassEntry {
    return vphp.ZendClassEntry.from_ptr(C.vslim__psr14__listenerprovider_ce)
}

pub fn VSlimPsr14ListenerProvider.php_object_handlers() voidptr {
    return vslimpsr14listenerprovider_handlers()
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

@[export: 'VSlimPsr14EventDispatcher_new_raw']
pub fn vslimpsr14eventdispatcher_new_raw() voidptr {
    return vphp.generic_new_raw[VSlimPsr14EventDispatcher]()
}
@[export: 'VSlimPsr14EventDispatcher_free_raw']
pub fn vslimpsr14eventdispatcher_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[VSlimPsr14EventDispatcher](ptr)
}
@[export: 'VSlimPsr14EventDispatcher_cleanup_raw']
pub fn vslimpsr14eventdispatcher_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
}
@[export: 'VSlimPsr14EventDispatcher_get_prop']
pub fn vslimpsr14eventdispatcher_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = rv
}
@[export: 'VSlimPsr14EventDispatcher_set_prop']
pub fn vslimpsr14eventdispatcher_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = value
}
@[export: 'VSlimPsr14EventDispatcher_sync_props']
pub fn vslimpsr14eventdispatcher_sync_props(ptr voidptr, zv &C.zval) {
    _ = ptr
    _ = zv
}
@[export: 'vphp_wrap_VSlimPsr14EventDispatcher_construct']
pub fn vphp_wrap_vslimpsr14eventdispatcher_construct(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsr14EventDispatcher(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.construct()
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimPsr14EventDispatcher_set_provider']
pub fn vphp_wrap_vslimpsr14eventdispatcher_set_provider(ptr voidptr, ctx vphp.Context) voidptr {
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
@[export: 'vphp_wrap_VSlimPsr14EventDispatcher_provider']
pub fn vphp_wrap_vslimpsr14eventdispatcher_provider(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsr14EventDispatcher(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.provider()
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimPsr14EventDispatcher_listen']
pub fn vphp_wrap_vslimpsr14eventdispatcher_listen(ptr voidptr, ctx vphp.Context) voidptr {
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
@[export: 'vphp_wrap_VSlimPsr14EventDispatcher_listen_any']
pub fn vphp_wrap_vslimpsr14eventdispatcher_listen_any(ptr voidptr, ctx vphp.Context) voidptr {
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
@[export: 'vphp_wrap_VSlimPsr14EventDispatcher_dispatch']
pub fn vphp_wrap_vslimpsr14eventdispatcher_dispatch(ptr voidptr, ctx vphp.Context)  {
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
@[export: 'VSlimPsr14EventDispatcher_handlers']
pub fn vslimpsr14eventdispatcher_handlers() voidptr {
    return vphp.ZendClassHandlers.new(
        prop_handler: voidptr(vslimpsr14eventdispatcher_get_prop),
        write_handler: voidptr(vslimpsr14eventdispatcher_set_prop),
        sync_handler: voidptr(vslimpsr14eventdispatcher_sync_props),
        new_raw: voidptr(vslimpsr14eventdispatcher_new_raw),
        cleanup_raw: voidptr(vslimpsr14eventdispatcher_cleanup_raw),
        free_raw: voidptr(vslimpsr14eventdispatcher_free_raw)
    )
}
pub fn VSlimPsr14EventDispatcher.php_class_entry() vphp.ZendClassEntry {
    return vphp.ZendClassEntry.from_ptr(C.vslim__psr14__eventdispatcher_ce)
}

pub fn VSlimPsr14EventDispatcher.php_object_handlers() voidptr {
    return vslimpsr14eventdispatcher_handlers()
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

