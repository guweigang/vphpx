module feishux

import vphp
import vphp.object

#include "php_bridge.h"

__global C.vslim__app__feishu__botapp_ce &C.zend_class_entry

@[export: 'vslim_feishu_bot_app_new_raw']
pub fn vslim_feishu_bot_app_new_raw() voidptr {
    return vphp.generic_new_raw[VSlimFeishuBotApp]()
}
@[export: 'vslim_feishu_bot_app_free_raw']
pub fn vslim_feishu_bot_app_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[VSlimFeishuBotApp](ptr)
}
@[export: 'vslim_feishu_bot_app_cleanup_raw']
pub fn vslim_feishu_bot_app_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
}
@[export: 'vslim_feishu_bot_app_get_prop']
pub fn vslim_feishu_bot_app_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = rv
}
@[export: 'vslim_feishu_bot_app_set_prop']
pub fn vslim_feishu_bot_app_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = value
}
@[export: 'vslim_feishu_bot_app_sync_props']
pub fn vslim_feishu_bot_app_sync_props(ptr voidptr, zv &C.zval) {
    _ = ptr
    _ = zv
}
@[export: 'vphp_wrap_vslim_feishu_bot_app_construct']
pub fn vphp_wrap_vslim_feishu_bot_app_construct(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimFeishuBotApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'handler' },
    ])
    arg_0 := php_args.at(0).object() or {
        vphp.throw_exception('argument 0 must be object', 0)
        return unsafe { nil }
    }
    recv.construct(arg_0)
    return ptr
}
@[export: 'vphp_wrap_vslim_feishu_bot_app_handle']
pub fn vphp_wrap_vslim_feishu_bot_app_handle(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimFeishuBotApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'frame' },
    ])
    arg_0 := php_args.at(0).array() or {
        vphp.throw_exception('argument 0 must be array', 0)
        return
    }
    res := recv.handle(arg_0)
    ctx.return().v[vphp.PhpArray](res)
}
@[export: 'vphp_wrap_vslim_feishu_bot_app_handle_websocket_upstream']
pub fn vphp_wrap_vslim_feishu_bot_app_handle_websocket_upstream(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimFeishuBotApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'frame' },
    ])
    arg_0 := php_args.at(0).array() or {
        vphp.throw_exception('argument 0 must be array', 0)
        return
    }
    res := recv.handle_websocket_upstream(arg_0)
    ctx.return().v[vphp.PhpArray](res)
}
@[export: 'vphp_wrap_vslim_feishu_bot_app_handle_websocket_upstream_camel']
pub fn vphp_wrap_vslim_feishu_bot_app_handle_websocket_upstream_camel(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimFeishuBotApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'frame' },
    ])
    arg_0 := php_args.at(0).array() or {
        vphp.throw_exception('argument 0 must be array', 0)
        return
    }
    res := recv.handle_websocket_upstream_camel(arg_0)
    ctx.return().v[vphp.PhpArray](res)
}
@[export: 'vslim_feishu_bot_app_handlers']
pub fn vslim_feishu_bot_app_handlers() voidptr {
    return vphp.ZendClassHandlers.new_typed(
        prop_handler: vslim_feishu_bot_app_get_prop,
        write_handler: vslim_feishu_bot_app_set_prop,
        sync_handler: vslim_feishu_bot_app_sync_props,
        new_raw: vslim_feishu_bot_app_new_raw,
        cleanup_raw: vslim_feishu_bot_app_cleanup_raw,
        free_raw: vslim_feishu_bot_app_free_raw
    )
}
pub fn VSlimFeishuBotApp.php_class_entry() vphp.ZendClassEntry {
    return vphp.ZendClassEntry.from_ptr(C.vslim__app__feishu__botapp_ce)
}

pub fn VSlimFeishuBotApp.php_object_handlers() object.ObjectHandlers {
    return object.ObjectHandlers.from_ptr(vslim_feishu_bot_app_handlers())
}

pub fn VSlimFeishuBotApp.php_object_zval(v_ptr voidptr, ownership vphp.OwnershipKind) vphp.ZVal {
    return vphp.bind_object_zval[VSlimFeishuBotApp](v_ptr, ownership)
}

pub fn (obj &VSlimFeishuBotApp) bind_php_object() vphp.ZVal {
    return vphp.bind_borrowed_object_zval[VSlimFeishuBotApp](obj)
}

pub fn (obj &VSlimFeishuBotApp) bind_php_object_value() vphp.PhpValue {
    return vphp.bind_borrowed_object_value[VSlimFeishuBotApp](obj)
}

pub fn (obj &VSlimFeishuBotApp) bind_owned_php_object() vphp.ZVal {
    return vphp.bind_owned_object_zval[VSlimFeishuBotApp](obj)
}

pub fn (obj &VSlimFeishuBotApp) bind_owned_php_object_value() vphp.PhpValue {
    return vphp.bind_owned_object_value[VSlimFeishuBotApp](obj)
}

pub fn (val VSlimFeishuBotApp) php_class_name() string {
    return 'VSlim\\App\\Feishu\\BotApp'
}
