module main

import vphp

#include "php_bridge.h"

@[export: 'VSlimCliApp_new_raw']
pub fn vslimcliapp_new_raw() voidptr {
    return vphp.generic_new_raw[VSlimCliApp]()
}
@[export: 'VSlimCliApp_free_raw']
pub fn vslimcliapp_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[VSlimCliApp](ptr)
}
@[export: 'VSlimCliApp_cleanup_raw']
pub fn vslimcliapp_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    unsafe {
        mut obj := &VSlimCliApp(ptr)
        obj.free()
    }
}
@[export: 'VSlimCliApp_get_prop']
pub fn vslimcliapp_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = rv
}
@[export: 'VSlimCliApp_set_prop']
pub fn vslimcliapp_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = value
}
@[export: 'VSlimCliApp_sync_props']
pub fn vslimcliapp_sync_props(ptr voidptr, zv &C.zval) {
    _ = ptr
    _ = zv
}
@[export: 'vphp_wrap_VSlimCliApp_bootstrap_file']
pub fn vphp_wrap_vslimcliapp_bootstrap_file(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimCliApp(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    res := recv.bootstrap_file(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimCliApp_bootstrap_dir']
pub fn vphp_wrap_vslimcliapp_bootstrap_dir(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimCliApp(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    res := recv.bootstrap_dir(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimCliApp_help_text']
pub fn vphp_wrap_vslimcliapp_help_text(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimCliApp(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.help_text()
    ctx.return_val[string](res)
}
@[export: 'vphp_wrap_VSlimCliApp_command_help']
pub fn vphp_wrap_vslimcliapp_command_help(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimCliApp(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    res := recv.command_help(arg_0)
    ctx.return_val[string](res)
}
@[export: 'vphp_wrap_VSlimCliApp_run_argv']
pub fn vphp_wrap_vslimcliapp_run_argv(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimCliApp(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    res := recv.run_argv(arg_0)
    ctx.return_val[int](res)
}
@[export: 'vphp_wrap_VSlimCliApp_construct']
pub fn vphp_wrap_vslimcliapp_construct(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimCliApp(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.construct()
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimCliApp_app']
pub fn vphp_wrap_vslimcliapp_app(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimCliApp(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.app()
    ctx.return_val[vphp.RequestOwnedZBox](res)
}
@[export: 'vphp_wrap_VSlimCliApp_command']
pub fn vphp_wrap_vslimcliapp_command(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimCliApp(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    arg_1 := ctx.arg_borrowed_zbox(1)
    res := recv.command(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimCliApp_command_many']
pub fn vphp_wrap_vslimcliapp_command_many(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimCliApp(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    res := recv.command_many(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimCliApp_command_names']
pub fn vphp_wrap_vslimcliapp_command_names(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimCliApp(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.command_names()
    ctx.return_val[[]string](res)
}
@[export: 'vphp_wrap_VSlimCliApp_has_command']
pub fn vphp_wrap_vslimcliapp_has_command(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimCliApp(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    res := recv.has_command(arg_0)
    ctx.return_val[bool](res)
}
@[export: 'vphp_wrap_VSlimCliApp_command_name']
pub fn vphp_wrap_vslimcliapp_command_name(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimCliApp(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.command_name()
    ctx.return_val[string](res)
}
@[export: 'vphp_wrap_VSlimCliApp_raw_args']
pub fn vphp_wrap_vslimcliapp_raw_args(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimCliApp(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.raw_args()
    ctx.return_val[[]string](res)
}
@[export: 'vphp_wrap_VSlimCliApp_input_parsed']
pub fn vphp_wrap_vslimcliapp_input_parsed(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimCliApp(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.input_parsed()
    ctx.return_val[bool](res)
}
@[export: 'vphp_wrap_VSlimCliApp_has_option']
pub fn vphp_wrap_vslimcliapp_has_option(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimCliApp(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    res := recv.has_option(arg_0)
    ctx.return_val[bool](res)
}
@[export: 'vphp_wrap_VSlimCliApp_warnings']
pub fn vphp_wrap_vslimcliapp_warnings(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimCliApp(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.warnings()
    ctx.return_val[[]string](res)
}
@[export: 'vphp_wrap_VSlimCliApp_options']
pub fn vphp_wrap_vslimcliapp_options(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimCliApp(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.options()
    ctx.return_val[vphp.RequestOwnedZBox](res)
}
@[export: 'vphp_wrap_VSlimCliApp_arguments']
pub fn vphp_wrap_vslimcliapp_arguments(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimCliApp(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.arguments()
    ctx.return_val[vphp.RequestOwnedZBox](res)
}
@[export: 'vphp_wrap_VSlimCliApp_option']
pub fn vphp_wrap_vslimcliapp_option(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimCliApp(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    arg_1 := ctx.arg_borrowed_zbox(1)
    res := recv.option(arg_0, arg_1)
    ctx.return_val[vphp.RequestOwnedZBox](res)
}
@[export: 'vphp_wrap_VSlimCliApp_argument']
pub fn vphp_wrap_vslimcliapp_argument(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimCliApp(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    arg_1 := ctx.arg_borrowed_zbox(1)
    res := recv.argument(arg_0, arg_1)
    ctx.return_val[vphp.RequestOwnedZBox](res)
}
@[export: 'vphp_wrap_VSlimCliApp_run']
pub fn vphp_wrap_vslimcliapp_run(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimCliApp(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    arg_1 := ctx.arg_borrowed_zbox(1)
    res := recv.run(arg_0, arg_1)
    ctx.return_val[int](res)
}
@[export: 'VSlimCliApp_handlers']
pub fn vslimcliapp_handlers() voidptr {
    return unsafe { &C.vphp_class_handlers{
        prop_handler:  voidptr(vslimcliapp_get_prop)
        write_handler: voidptr(vslimcliapp_set_prop)
        sync_handler:  voidptr(vslimcliapp_sync_props)
        new_raw:       voidptr(vslimcliapp_new_raw)
        cleanup_raw:   voidptr(vslimcliapp_cleanup_raw)
        free_raw:      voidptr(vslimcliapp_free_raw)
    } }
}

@[export: 'VSlimView_new_raw']
pub fn vslimview_new_raw() voidptr {
    return vphp.generic_new_raw[VSlimView]()
}
@[export: 'VSlimView_free_raw']
pub fn vslimview_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[VSlimView](ptr)
}
@[export: 'VSlimView_cleanup_raw']
pub fn vslimview_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    unsafe {
        mut obj := &VSlimView(ptr)
        obj.free()
    }
}
@[export: 'VSlimView_get_prop']
pub fn vslimview_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = rv
}
@[export: 'VSlimView_set_prop']
pub fn vslimview_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = value
}
@[export: 'VSlimView_sync_props']
pub fn vslimview_sync_props(ptr voidptr, zv &C.zval) {
    _ = ptr
    _ = zv
}
@[export: 'vphp_wrap_VSlimView_construct']
pub fn vphp_wrap_vslimview_construct(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimView(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    arg_1 := ctx.arg[string](1)
    res := recv.construct(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimView_set_base_path']
pub fn vphp_wrap_vslimview_set_base_path(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimView(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    res := recv.set_base_path(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimView_base_path']
pub fn vphp_wrap_vslimview_base_path(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimView(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.base_path()
    ctx.return_val[string](res)
}
@[export: 'vphp_wrap_VSlimView_set_assets_prefix']
pub fn vphp_wrap_vslimview_set_assets_prefix(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimView(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    res := recv.set_assets_prefix(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimView_assets_prefix']
pub fn vphp_wrap_vslimview_assets_prefix(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimView(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.assets_prefix()
    ctx.return_val[string](res)
}
@[export: 'vphp_wrap_VSlimView_set_cache_enabled']
pub fn vphp_wrap_vslimview_set_cache_enabled(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimView(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[bool](0)
    res := recv.set_cache_enabled(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimView_cache_enabled']
pub fn vphp_wrap_vslimview_cache_enabled(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimView(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.cache_enabled()
    ctx.return_val[bool](res)
}
@[export: 'vphp_wrap_VSlimView_clear_cache']
pub fn vphp_wrap_vslimview_clear_cache(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimView(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.clear_cache()
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimView_helper']
pub fn vphp_wrap_vslimview_helper(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimView(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    arg_1 := ctx.arg_borrowed_zbox(1)
    res := recv.helper(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimView_asset']
pub fn vphp_wrap_vslimview_asset(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimView(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    res := recv.asset(arg_0)
    ctx.return_val[string](res)
}
@[export: 'vphp_wrap_VSlimView_render']
pub fn vphp_wrap_vslimview_render(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimView(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    arg_1 := ctx.arg_borrowed_zbox(1)
    res := recv.render(arg_0, arg_1)
    ctx.return_val[string](res)
}
@[export: 'vphp_wrap_VSlimView_render_with_layout']
pub fn vphp_wrap_vslimview_render_with_layout(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimView(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    arg_1 := ctx.arg[string](1)
    arg_2 := ctx.arg_borrowed_zbox(2)
    res := recv.render_with_layout(arg_0, arg_1, arg_2)
    ctx.return_val[string](res)
}
@[export: 'vphp_wrap_VSlimView_render_response']
pub fn vphp_wrap_vslimview_render_response(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimView(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    arg_1 := ctx.arg_borrowed_zbox(1)
    res := recv.render_response(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimView_render_response_with_layout']
pub fn vphp_wrap_vslimview_render_response_with_layout(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimView(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    arg_1 := ctx.arg[string](1)
    arg_2 := ctx.arg_borrowed_zbox(2)
    res := recv.render_response_with_layout(arg_0, arg_1, arg_2)
    return voidptr(res)
}
@[export: 'VSlimView_handlers']
pub fn vslimview_handlers() voidptr {
    return unsafe { &C.vphp_class_handlers{
        prop_handler:  voidptr(vslimview_get_prop)
        write_handler: voidptr(vslimview_set_prop)
        sync_handler:  voidptr(vslimview_sync_props)
        new_raw:       voidptr(vslimview_new_raw)
        cleanup_raw:   voidptr(vslimview_cleanup_raw)
        free_raw:      voidptr(vslimview_free_raw)
    } }
}

@[export: 'VSlimController_new_raw']
pub fn vslimcontroller_new_raw() voidptr {
    return vphp.generic_new_raw[VSlimController]()
}
@[export: 'VSlimController_free_raw']
pub fn vslimcontroller_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[VSlimController](ptr)
}
@[export: 'VSlimController_cleanup_raw']
pub fn vslimcontroller_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
}
@[export: 'VSlimController_get_prop']
pub fn vslimcontroller_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = rv
}
@[export: 'VSlimController_set_prop']
pub fn vslimcontroller_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = value
}
@[export: 'VSlimController_sync_props']
pub fn vslimcontroller_sync_props(ptr voidptr, zv &C.zval) {
    _ = ptr
    _ = zv
}
@[export: 'vphp_wrap_VSlimController_construct']
pub fn vphp_wrap_vslimcontroller_construct(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimController(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := unsafe { &VSlimApp(ctx.arg_raw_obj(0)) }
    res := recv.construct(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimController_set_app']
pub fn vphp_wrap_vslimcontroller_set_app(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimController(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := unsafe { &VSlimApp(ctx.arg_raw_obj(0)) }
    res := recv.set_app(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimController_set_view']
pub fn vphp_wrap_vslimcontroller_set_view(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimController(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := unsafe { &VSlimView(ctx.arg_raw_obj(0)) }
    res := recv.set_view(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimController_view']
pub fn vphp_wrap_vslimcontroller_view(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimController(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.view()
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimController_render']
pub fn vphp_wrap_vslimcontroller_render(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimController(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    arg_1 := ctx.arg_borrowed_zbox(1)
    res := recv.render(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimController_render_with_layout']
pub fn vphp_wrap_vslimcontroller_render_with_layout(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimController(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    arg_1 := ctx.arg[string](1)
    arg_2 := ctx.arg_borrowed_zbox(2)
    res := recv.render_with_layout(arg_0, arg_1, arg_2)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimController_url_for']
pub fn vphp_wrap_vslimcontroller_url_for(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimController(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    arg_1 := ctx.arg_borrowed_zbox(1)
    res := recv.url_for(arg_0, arg_1)
    ctx.return_val[string](res)
}
@[export: 'vphp_wrap_VSlimController_url_for_query']
pub fn vphp_wrap_vslimcontroller_url_for_query(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimController(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    arg_1 := ctx.arg_borrowed_zbox(1)
    arg_2 := ctx.arg_borrowed_zbox(2)
    res := recv.url_for_query(arg_0, arg_1, arg_2)
    ctx.return_val[string](res)
}
@[export: 'vphp_wrap_VSlimController_text']
pub fn vphp_wrap_vslimcontroller_text(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimController(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    arg_1 := ctx.arg[int](1)
    res := recv.text(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimController_json']
pub fn vphp_wrap_vslimcontroller_json(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimController(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    arg_1 := ctx.arg[int](1)
    res := recv.json(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimController_redirect']
pub fn vphp_wrap_vslimcontroller_redirect(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimController(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    arg_1 := ctx.arg[int](1)
    res := recv.redirect(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimController_redirect_to']
pub fn vphp_wrap_vslimcontroller_redirect_to(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimController(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    arg_1 := ctx.arg_borrowed_zbox(1)
    arg_2 := ctx.arg[int](2)
    res := recv.redirect_to(arg_0, arg_1, arg_2)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimController_redirect_to_query']
pub fn vphp_wrap_vslimcontroller_redirect_to_query(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimController(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    arg_1 := ctx.arg_borrowed_zbox(1)
    arg_2 := ctx.arg_borrowed_zbox(2)
    arg_3 := ctx.arg[int](3)
    res := recv.redirect_to_query(arg_0, arg_1, arg_2, arg_3)
    return voidptr(res)
}
@[export: 'VSlimController_handlers']
pub fn vslimcontroller_handlers() voidptr {
    return unsafe { &C.vphp_class_handlers{
        prop_handler:  voidptr(vslimcontroller_get_prop)
        write_handler: voidptr(vslimcontroller_set_prop)
        sync_handler:  voidptr(vslimcontroller_sync_props)
        new_raw:       voidptr(vslimcontroller_new_raw)
        cleanup_raw:   voidptr(vslimcontroller_cleanup_raw)
        free_raw:      voidptr(vslimcontroller_free_raw)
    } }
}

@[export: 'VSlimApp_new_raw']
pub fn vslimapp_new_raw() voidptr {
    return vphp.generic_new_raw[VSlimApp]()
}
@[export: 'VSlimApp_free_raw']
pub fn vslimapp_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[VSlimApp](ptr)
}
@[export: 'VSlimApp_cleanup_raw']
pub fn vslimapp_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    unsafe {
        mut obj := &VSlimApp(ptr)
        obj.free()
    }
}
@[export: 'VSlimApp_get_prop']
pub fn vslimapp_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = rv
}
@[export: 'VSlimApp_set_prop']
pub fn vslimapp_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = value
}
@[export: 'VSlimApp_sync_props']
pub fn vslimapp_sync_props(ptr voidptr, zv &C.zval) {
    _ = ptr
    _ = zv
}
@[export: 'vphp_wrap_VSlimApp_middleware']
pub fn vphp_wrap_vslimapp_middleware(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    res := recv.middleware(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimApp_before']
pub fn vphp_wrap_vslimapp_before(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    res := recv.before(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimApp_after']
pub fn vphp_wrap_vslimapp_after(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    res := recv.after(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimApp_set_not_found_handler']
pub fn vphp_wrap_vslimapp_set_not_found_handler(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    res := recv.set_not_found_handler(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimApp_not_found']
pub fn vphp_wrap_vslimapp_not_found(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    res := recv.not_found(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimApp_set_error_handler']
pub fn vphp_wrap_vslimapp_set_error_handler(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    res := recv.set_error_handler(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimApp_error']
pub fn vphp_wrap_vslimapp_error(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    res := recv.error(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimApp_set_error_response_json']
pub fn vphp_wrap_vslimapp_set_error_response_json(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[bool](0)
    res := recv.set_error_response_json(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimApp_error_response_json_enabled']
pub fn vphp_wrap_vslimapp_error_response_json_enabled(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimApp(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.error_response_json_enabled()
    ctx.return_val[bool](res)
}
@[export: 'vphp_wrap_VSlimApp_group']
pub fn vphp_wrap_vslimapp_group(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    res := recv.group(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimApp_get']
pub fn vphp_wrap_vslimapp_get(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    arg_1 := ctx.arg_borrowed_zbox(1)
    res := recv.get(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimApp_post']
pub fn vphp_wrap_vslimapp_post(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    arg_1 := ctx.arg_borrowed_zbox(1)
    res := recv.post(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimApp_put']
pub fn vphp_wrap_vslimapp_put(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    arg_1 := ctx.arg_borrowed_zbox(1)
    res := recv.put(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimApp_head']
pub fn vphp_wrap_vslimapp_head(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    arg_1 := ctx.arg_borrowed_zbox(1)
    res := recv.head(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimApp_options']
pub fn vphp_wrap_vslimapp_options(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    arg_1 := ctx.arg_borrowed_zbox(1)
    res := recv.options(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimApp_patch']
pub fn vphp_wrap_vslimapp_patch(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    arg_1 := ctx.arg_borrowed_zbox(1)
    res := recv.patch(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimApp_delete']
pub fn vphp_wrap_vslimapp_delete(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    arg_1 := ctx.arg_borrowed_zbox(1)
    res := recv.delete(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimApp_any']
pub fn vphp_wrap_vslimapp_any(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    arg_1 := ctx.arg_borrowed_zbox(1)
    res := recv.any(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimApp_live']
pub fn vphp_wrap_vslimapp_live(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    arg_1 := ctx.arg_borrowed_zbox(1)
    res := recv.live(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimApp_live_ws']
pub fn vphp_wrap_vslimapp_live_ws(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimApp(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    arg_1 := ctx.arg_borrowed_zbox(1)
    arg_2 := ctx.arg_borrowed_zbox(2)
    res := recv.live_ws(arg_0, arg_1, arg_2)
    ctx.return_val[vphp.RequestOwnedZBox](res)
}
@[export: 'vphp_wrap_VSlimApp_websocket']
pub fn vphp_wrap_vslimapp_websocket(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    arg_1 := ctx.arg_borrowed_zbox(1)
    res := recv.websocket(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimApp_websocket_named']
pub fn vphp_wrap_vslimapp_websocket_named(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    arg_1 := ctx.arg[string](1)
    arg_2 := ctx.arg_borrowed_zbox(2)
    res := recv.websocket_named(arg_0, arg_1, arg_2)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimApp_map']
pub fn vphp_wrap_vslimapp_map(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    arg_1 := ctx.arg[string](1)
    arg_2 := ctx.arg_borrowed_zbox(2)
    res := recv.map(arg_0, arg_1, arg_2)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimApp_resource']
pub fn vphp_wrap_vslimapp_resource(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    arg_1 := ctx.arg[string](1)
    res := recv.resource(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimApp_api_resource']
pub fn vphp_wrap_vslimapp_api_resource(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    arg_1 := ctx.arg[string](1)
    res := recv.api_resource(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimApp_singleton']
pub fn vphp_wrap_vslimapp_singleton(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    arg_1 := ctx.arg[string](1)
    res := recv.singleton(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimApp_api_singleton']
pub fn vphp_wrap_vslimapp_api_singleton(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    arg_1 := ctx.arg[string](1)
    res := recv.api_singleton(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimApp_resource_opts']
pub fn vphp_wrap_vslimapp_resource_opts(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    arg_1 := ctx.arg[string](1)
    arg_2 := ctx.arg_borrowed_zbox(2)
    res := recv.resource_opts(arg_0, arg_1, arg_2)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimApp_api_resource_opts']
pub fn vphp_wrap_vslimapp_api_resource_opts(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    arg_1 := ctx.arg[string](1)
    arg_2 := ctx.arg_borrowed_zbox(2)
    res := recv.api_resource_opts(arg_0, arg_1, arg_2)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimApp_singleton_opts']
pub fn vphp_wrap_vslimapp_singleton_opts(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    arg_1 := ctx.arg[string](1)
    arg_2 := ctx.arg_borrowed_zbox(2)
    res := recv.singleton_opts(arg_0, arg_1, arg_2)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimApp_api_singleton_opts']
pub fn vphp_wrap_vslimapp_api_singleton_opts(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    arg_1 := ctx.arg[string](1)
    arg_2 := ctx.arg_borrowed_zbox(2)
    res := recv.api_singleton_opts(arg_0, arg_1, arg_2)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimApp_get_named']
pub fn vphp_wrap_vslimapp_get_named(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    arg_1 := ctx.arg[string](1)
    arg_2 := ctx.arg_borrowed_zbox(2)
    res := recv.get_named(arg_0, arg_1, arg_2)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimApp_post_named']
pub fn vphp_wrap_vslimapp_post_named(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    arg_1 := ctx.arg[string](1)
    arg_2 := ctx.arg_borrowed_zbox(2)
    res := recv.post_named(arg_0, arg_1, arg_2)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimApp_put_named']
pub fn vphp_wrap_vslimapp_put_named(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    arg_1 := ctx.arg[string](1)
    arg_2 := ctx.arg_borrowed_zbox(2)
    res := recv.put_named(arg_0, arg_1, arg_2)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimApp_head_named']
pub fn vphp_wrap_vslimapp_head_named(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    arg_1 := ctx.arg[string](1)
    arg_2 := ctx.arg_borrowed_zbox(2)
    res := recv.head_named(arg_0, arg_1, arg_2)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimApp_options_named']
pub fn vphp_wrap_vslimapp_options_named(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    arg_1 := ctx.arg[string](1)
    arg_2 := ctx.arg_borrowed_zbox(2)
    res := recv.options_named(arg_0, arg_1, arg_2)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimApp_patch_named']
pub fn vphp_wrap_vslimapp_patch_named(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    arg_1 := ctx.arg[string](1)
    arg_2 := ctx.arg_borrowed_zbox(2)
    res := recv.patch_named(arg_0, arg_1, arg_2)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimApp_delete_named']
pub fn vphp_wrap_vslimapp_delete_named(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    arg_1 := ctx.arg[string](1)
    arg_2 := ctx.arg_borrowed_zbox(2)
    res := recv.delete_named(arg_0, arg_1, arg_2)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimApp_any_named']
pub fn vphp_wrap_vslimapp_any_named(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    arg_1 := ctx.arg[string](1)
    arg_2 := ctx.arg_borrowed_zbox(2)
    res := recv.any_named(arg_0, arg_1, arg_2)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimApp_map_named']
pub fn vphp_wrap_vslimapp_map_named(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    arg_1 := ctx.arg[string](1)
    arg_2 := ctx.arg[string](2)
    arg_3 := ctx.arg_borrowed_zbox(3)
    res := recv.map_named(arg_0, arg_1, arg_2, arg_3)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimApp_url_for']
pub fn vphp_wrap_vslimapp_url_for(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimApp(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    arg_1 := ctx.arg_borrowed_zbox(1)
    res := recv.url_for(arg_0, arg_1)
    ctx.return_val[string](res)
}
@[export: 'vphp_wrap_VSlimApp_url_for_query']
pub fn vphp_wrap_vslimapp_url_for_query(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimApp(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    arg_1 := ctx.arg_borrowed_zbox(1)
    arg_2 := ctx.arg_borrowed_zbox(2)
    res := recv.url_for_query(arg_0, arg_1, arg_2)
    ctx.return_val[string](res)
}
@[export: 'vphp_wrap_VSlimApp_url_for_abs']
pub fn vphp_wrap_vslimapp_url_for_abs(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimApp(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    arg_1 := ctx.arg_borrowed_zbox(1)
    arg_2 := ctx.arg[string](2)
    arg_3 := ctx.arg[string](3)
    res := recv.url_for_abs(arg_0, arg_1, arg_2, arg_3)
    ctx.return_val[string](res)
}
@[export: 'vphp_wrap_VSlimApp_url_for_query_abs']
pub fn vphp_wrap_vslimapp_url_for_query_abs(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimApp(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    arg_1 := ctx.arg_borrowed_zbox(1)
    arg_2 := ctx.arg_borrowed_zbox(2)
    arg_3 := ctx.arg[string](3)
    arg_4 := ctx.arg[string](4)
    res := recv.url_for_query_abs(arg_0, arg_1, arg_2, arg_3, arg_4)
    ctx.return_val[string](res)
}
@[export: 'vphp_wrap_VSlimApp_redirect_to']
pub fn vphp_wrap_vslimapp_redirect_to(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    arg_1 := ctx.arg_borrowed_zbox(1)
    res := recv.redirect_to(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimApp_redirect_to_query']
pub fn vphp_wrap_vslimapp_redirect_to_query(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    arg_1 := ctx.arg_borrowed_zbox(1)
    arg_2 := ctx.arg_borrowed_zbox(2)
    res := recv.redirect_to_query(arg_0, arg_1, arg_2)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimApp_register']
pub fn vphp_wrap_vslimapp_register(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    res := recv.register(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimApp_register_many']
pub fn vphp_wrap_vslimapp_register_many(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    res := recv.register_many(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimApp_boot']
pub fn vphp_wrap_vslimapp_boot(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.boot()
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimApp_is_booted']
pub fn vphp_wrap_vslimapp_is_booted(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimApp(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.is_booted()
    ctx.return_val[bool](res)
}
@[export: 'vphp_wrap_VSlimApp_provider_count']
pub fn vphp_wrap_vslimapp_provider_count(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimApp(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.provider_count()
    ctx.return_val[int](res)
}
@[export: 'vphp_wrap_VSlimApp_has_provider']
pub fn vphp_wrap_vslimapp_has_provider(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimApp(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    res := recv.has_provider(arg_0)
    ctx.return_val[bool](res)
}
@[export: 'vphp_wrap_VSlimApp_dispatch']
pub fn vphp_wrap_vslimapp_dispatch(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    arg_1 := ctx.arg[string](1)
    res := recv.dispatch(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimApp_dispatch_body']
pub fn vphp_wrap_vslimapp_dispatch_body(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    arg_1 := ctx.arg[string](1)
    arg_2 := ctx.arg[string](2)
    res := recv.dispatch_body(arg_0, arg_1, arg_2)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimApp_dispatch_request']
pub fn vphp_wrap_vslimapp_dispatch_request(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := unsafe { &VSlimRequest(ctx.arg_raw_obj(0)) }
    res := recv.dispatch_request(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimApp_handle']
pub fn vphp_wrap_vslimapp_handle(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    res := recv.handle(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimApp_dispatch_envelope']
pub fn vphp_wrap_vslimapp_dispatch_envelope(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    res := recv.dispatch_envelope(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimApp_dispatch_envelope_worker']
pub fn vphp_wrap_vslimapp_dispatch_envelope_worker(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimApp(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    res := recv.dispatch_envelope_worker(arg_0)
    ctx.return_val[vphp.RequestOwnedZBox](res)
}
@[export: 'vphp_wrap_VSlimApp_dispatch_envelope_map']
pub fn vphp_wrap_vslimapp_dispatch_envelope_map(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimApp(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    res := recv.dispatch_envelope_map(arg_0)
    ctx.return_val[map[string]string](res)
}
@[export: 'vphp_wrap_VSlimApp_handle_websocket']
pub fn vphp_wrap_vslimapp_handle_websocket(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimApp(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    arg_1 := ctx.arg_borrowed_zbox(1)
    res := recv.handle_websocket(arg_0, arg_1)
    ctx.return_val[vphp.RequestOwnedZBox](res)
}
@[export: 'vphp_wrap_VSlimApp_route_count']
pub fn vphp_wrap_vslimapp_route_count(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimApp(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.route_count()
    ctx.return_val[int](res)
}
@[export: 'vphp_wrap_VSlimApp_route_names']
pub fn vphp_wrap_vslimapp_route_names(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimApp(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.route_names()
    ctx.return_val[[]string](res)
}
@[export: 'vphp_wrap_VSlimApp_has_route_name']
pub fn vphp_wrap_vslimapp_has_route_name(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimApp(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    res := recv.has_route_name(arg_0)
    ctx.return_val[bool](res)
}
@[export: 'vphp_wrap_VSlimApp_route_manifest_lines']
pub fn vphp_wrap_vslimapp_route_manifest_lines(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimApp(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.route_manifest_lines()
    ctx.return_val[[]string](res)
}
@[export: 'vphp_wrap_VSlimApp_route_conflict_keys']
pub fn vphp_wrap_vslimapp_route_conflict_keys(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimApp(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.route_conflict_keys()
    ctx.return_val[[]string](res)
}
@[export: 'vphp_wrap_VSlimApp_route_manifest']
pub fn vphp_wrap_vslimapp_route_manifest(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimApp(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.route_manifest()
    ctx.return_val[[]map[string]string](res)
}
@[export: 'vphp_wrap_VSlimApp_route_conflicts']
pub fn vphp_wrap_vslimapp_route_conflicts(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimApp(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.route_conflicts()
    ctx.return_val[[]map[string]string](res)
}
@[export: 'vphp_wrap_VSlimApp_allowed_methods_for']
pub fn vphp_wrap_vslimapp_allowed_methods_for(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimApp(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    res := recv.allowed_methods_for(arg_0)
    ctx.return_val[[]string](res)
}
@[export: 'vphp_wrap_VSlimApp_set_base_path']
pub fn vphp_wrap_vslimapp_set_base_path(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    res := recv.set_base_path(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimApp_has_container']
pub fn vphp_wrap_vslimapp_has_container(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimApp(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.has_container()
    ctx.return_val[bool](res)
}
@[export: 'vphp_wrap_VSlimApp_set_container']
pub fn vphp_wrap_vslimapp_set_container(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := unsafe { &VSlimContainer(ctx.arg_raw_obj(0)) }
    res := recv.set_container(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimApp_container']
pub fn vphp_wrap_vslimapp_container(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.container()
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimApp_has_config']
pub fn vphp_wrap_vslimapp_has_config(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimApp(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.has_config()
    ctx.return_val[bool](res)
}
@[export: 'vphp_wrap_VSlimApp_set_config']
pub fn vphp_wrap_vslimapp_set_config(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := unsafe { &VSlimConfig(ctx.arg_raw_obj(0)) }
    res := recv.set_config(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimApp_config']
pub fn vphp_wrap_vslimapp_config(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.config()
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimApp_load_config']
pub fn vphp_wrap_vslimapp_load_config(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    res := recv.load_config(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimApp_load_config_text']
pub fn vphp_wrap_vslimapp_load_config_text(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    res := recv.load_config_text(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimApp_has_mcp']
pub fn vphp_wrap_vslimapp_has_mcp(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimApp(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.has_mcp()
    ctx.return_val[bool](res)
}
@[export: 'vphp_wrap_VSlimApp_set_mcp']
pub fn vphp_wrap_vslimapp_set_mcp(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := unsafe { &VSlimMcpApp(ctx.arg_raw_obj(0)) }
    res := recv.set_mcp(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimApp_mcp']
pub fn vphp_wrap_vslimapp_mcp(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.mcp()
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimApp_handle_mcp_dispatch']
pub fn vphp_wrap_vslimapp_handle_mcp_dispatch(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimApp(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    res := recv.handle_mcp_dispatch(arg_0)
    ctx.return_val[vphp.RequestOwnedZBox](res)
}
@[export: 'vphp_wrap_VSlimApp_has_logger']
pub fn vphp_wrap_vslimapp_has_logger(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimApp(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.has_logger()
    ctx.return_val[bool](res)
}
@[export: 'vphp_wrap_VSlimApp_set_clock']
pub fn vphp_wrap_vslimapp_set_clock(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    res := recv.set_clock(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimApp_clock']
pub fn vphp_wrap_vslimapp_clock(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimApp(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.clock()
    ctx.return_val[vphp.RequestOwnedZBox](res)
}
@[export: 'vphp_wrap_VSlimApp_set_logger']
pub fn vphp_wrap_vslimapp_set_logger(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := unsafe { &VSlimLogger(ctx.arg_raw_obj(0)) }
    res := recv.set_logger(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimApp_logger']
pub fn vphp_wrap_vslimapp_logger(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.logger()
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimApp_psr_logger']
pub fn vphp_wrap_vslimapp_psr_logger(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.psr_logger()
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimApp_set_listener_provider']
pub fn vphp_wrap_vslimapp_set_listener_provider(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := unsafe { &VSlimPsr14ListenerProvider(ctx.arg_raw_obj(0)) }
    res := recv.set_listener_provider(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimApp_listener_provider']
pub fn vphp_wrap_vslimapp_listener_provider(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.listener_provider()
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimApp_set_dispatcher']
pub fn vphp_wrap_vslimapp_set_dispatcher(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := unsafe { &VSlimPsr14EventDispatcher(ctx.arg_raw_obj(0)) }
    res := recv.set_dispatcher(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimApp_dispatcher']
pub fn vphp_wrap_vslimapp_dispatcher(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.dispatcher()
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimApp_events']
pub fn vphp_wrap_vslimapp_events(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.events()
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimApp_set_cache']
pub fn vphp_wrap_vslimapp_set_cache(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := unsafe { &VSlimPsr16Cache(ctx.arg_raw_obj(0)) }
    res := recv.set_cache(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimApp_cache']
pub fn vphp_wrap_vslimapp_cache(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.cache()
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimApp_set_cache_pool']
pub fn vphp_wrap_vslimapp_set_cache_pool(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := unsafe { &VSlimPsr6CacheItemPool(ctx.arg_raw_obj(0)) }
    res := recv.set_cache_pool(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimApp_cache_pool']
pub fn vphp_wrap_vslimapp_cache_pool(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.cache_pool()
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimApp_set_http_client']
pub fn vphp_wrap_vslimapp_set_http_client(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := unsafe { &VSlimPsr18Client(ctx.arg_raw_obj(0)) }
    res := recv.set_http_client(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimApp_http_client']
pub fn vphp_wrap_vslimapp_http_client(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.http_client()
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimApp_bootstrap']
pub fn vphp_wrap_vslimapp_bootstrap(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    res := recv.bootstrap(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimApp_bootstrap_file']
pub fn vphp_wrap_vslimapp_bootstrap_file(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    res := recv.bootstrap_file(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimApp_bootstrap_dir']
pub fn vphp_wrap_vslimapp_bootstrap_dir(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    res := recv.bootstrap_dir(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimApp_mount_module']
pub fn vphp_wrap_vslimapp_mount_module(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    res := recv.mount_module(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimApp_module_many']
pub fn vphp_wrap_vslimapp_module_many(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    res := recv.module_many(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimApp_module_count']
pub fn vphp_wrap_vslimapp_module_count(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimApp(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.module_count()
    ctx.return_val[int](res)
}
@[export: 'vphp_wrap_VSlimApp_has_module']
pub fn vphp_wrap_vslimapp_has_module(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimApp(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    res := recv.has_module(arg_0)
    ctx.return_val[bool](res)
}
@[export: 'vphp_wrap_VSlimApp_set_view_base_path']
pub fn vphp_wrap_vslimapp_set_view_base_path(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    res := recv.set_view_base_path(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimApp_view_base_path']
pub fn vphp_wrap_vslimapp_view_base_path(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimApp(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.view_base_path()
    ctx.return_val[string](res)
}
@[export: 'vphp_wrap_VSlimApp_set_assets_prefix']
pub fn vphp_wrap_vslimapp_set_assets_prefix(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    res := recv.set_assets_prefix(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimApp_assets_prefix']
pub fn vphp_wrap_vslimapp_assets_prefix(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimApp(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.assets_prefix()
    ctx.return_val[string](res)
}
@[export: 'vphp_wrap_VSlimApp_set_view_cache']
pub fn vphp_wrap_vslimapp_set_view_cache(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[bool](0)
    res := recv.set_view_cache(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimApp_view_cache_enabled']
pub fn vphp_wrap_vslimapp_view_cache_enabled(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimApp(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.view_cache_enabled()
    ctx.return_val[bool](res)
}
@[export: 'vphp_wrap_VSlimApp_clear_view_cache']
pub fn vphp_wrap_vslimapp_clear_view_cache(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.clear_view_cache()
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimApp_helper']
pub fn vphp_wrap_vslimapp_helper(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    arg_1 := ctx.arg_borrowed_zbox(1)
    res := recv.helper(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimApp_make_view']
pub fn vphp_wrap_vslimapp_make_view(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.make_view()
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimApp_view']
pub fn vphp_wrap_vslimapp_view(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    arg_1 := ctx.arg_borrowed_zbox(1)
    res := recv.view(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimApp_view_with_layout']
pub fn vphp_wrap_vslimapp_view_with_layout(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    arg_1 := ctx.arg[string](1)
    arg_2 := ctx.arg_borrowed_zbox(2)
    res := recv.view_with_layout(arg_0, arg_1, arg_2)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimApp_demo']
pub fn vphp_wrap_vslimapp_demo(ctx vphp.Context) voidptr {
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := VSlimApp.demo()
    return voidptr(res)
}
@[export: 'VSlimApp_handlers']
pub fn vslimapp_handlers() voidptr {
    return unsafe { &C.vphp_class_handlers{
        prop_handler:  voidptr(vslimapp_get_prop)
        write_handler: voidptr(vslimapp_set_prop)
        sync_handler:  voidptr(vslimapp_sync_props)
        new_raw:       voidptr(vslimapp_new_raw)
        cleanup_raw:   voidptr(vslimapp_cleanup_raw)
        free_raw:      voidptr(vslimapp_free_raw)
    } }
}

@[export: 'VSlimPsr15NextHandler_new_raw']
pub fn vslimpsr15nexthandler_new_raw() voidptr {
    return vphp.generic_new_raw[VSlimPsr15NextHandler]()
}
@[export: 'VSlimPsr15NextHandler_free_raw']
pub fn vslimpsr15nexthandler_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[VSlimPsr15NextHandler](ptr)
}
@[export: 'VSlimPsr15NextHandler_cleanup_raw']
pub fn vslimpsr15nexthandler_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
}
@[export: 'VSlimPsr15NextHandler_get_prop']
pub fn vslimpsr15nexthandler_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = rv
}
@[export: 'VSlimPsr15NextHandler_set_prop']
pub fn vslimpsr15nexthandler_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = value
}
@[export: 'VSlimPsr15NextHandler_sync_props']
pub fn vslimpsr15nexthandler_sync_props(ptr voidptr, zv &C.zval) {
    _ = ptr
    _ = zv
}
@[export: 'vphp_wrap_VSlimPsr15NextHandler_handle']
pub fn vphp_wrap_vslimpsr15nexthandler_handle(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsr15NextHandler(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    res := recv.handle(arg_0)
    return voidptr(res)
}
@[export: 'VSlimPsr15NextHandler_handlers']
pub fn vslimpsr15nexthandler_handlers() voidptr {
    return unsafe { &C.vphp_class_handlers{
        prop_handler:  voidptr(vslimpsr15nexthandler_get_prop)
        write_handler: voidptr(vslimpsr15nexthandler_set_prop)
        sync_handler:  voidptr(vslimpsr15nexthandler_sync_props)
        new_raw:       voidptr(vslimpsr15nexthandler_new_raw)
        cleanup_raw:   voidptr(vslimpsr15nexthandler_cleanup_raw)
        free_raw:      voidptr(vslimpsr15nexthandler_free_raw)
    } }
}

@[export: 'VSlimPsr15ContinueHandler_new_raw']
pub fn vslimpsr15continuehandler_new_raw() voidptr {
    return vphp.generic_new_raw[VSlimPsr15ContinueHandler]()
}
@[export: 'VSlimPsr15ContinueHandler_free_raw']
pub fn vslimpsr15continuehandler_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[VSlimPsr15ContinueHandler](ptr)
}
@[export: 'VSlimPsr15ContinueHandler_cleanup_raw']
pub fn vslimpsr15continuehandler_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
}
@[export: 'VSlimPsr15ContinueHandler_get_prop']
pub fn vslimpsr15continuehandler_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = rv
}
@[export: 'VSlimPsr15ContinueHandler_set_prop']
pub fn vslimpsr15continuehandler_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = value
}
@[export: 'VSlimPsr15ContinueHandler_sync_props']
pub fn vslimpsr15continuehandler_sync_props(ptr voidptr, zv &C.zval) {
    _ = ptr
    _ = zv
}
@[export: 'vphp_wrap_VSlimPsr15ContinueHandler_handle']
pub fn vphp_wrap_vslimpsr15continuehandler_handle(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsr15ContinueHandler(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    res := recv.handle(arg_0)
    return voidptr(res)
}
@[export: 'VSlimPsr15ContinueHandler_handlers']
pub fn vslimpsr15continuehandler_handlers() voidptr {
    return unsafe { &C.vphp_class_handlers{
        prop_handler:  voidptr(vslimpsr15continuehandler_get_prop)
        write_handler: voidptr(vslimpsr15continuehandler_set_prop)
        sync_handler:  voidptr(vslimpsr15continuehandler_sync_props)
        new_raw:       voidptr(vslimpsr15continuehandler_new_raw)
        cleanup_raw:   voidptr(vslimpsr15continuehandler_cleanup_raw)
        free_raw:      voidptr(vslimpsr15continuehandler_free_raw)
    } }
}

@[export: 'VSlimServiceProvider_new_raw']
pub fn vslimserviceprovider_new_raw() voidptr {
    return vphp.generic_new_raw[VSlimServiceProvider]()
}
@[export: 'VSlimServiceProvider_free_raw']
pub fn vslimserviceprovider_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[VSlimServiceProvider](ptr)
}
@[export: 'VSlimServiceProvider_cleanup_raw']
pub fn vslimserviceprovider_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
}
@[export: 'VSlimServiceProvider_get_prop']
pub fn vslimserviceprovider_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = rv
}
@[export: 'VSlimServiceProvider_set_prop']
pub fn vslimserviceprovider_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = value
}
@[export: 'VSlimServiceProvider_sync_props']
pub fn vslimserviceprovider_sync_props(ptr voidptr, zv &C.zval) {
    _ = ptr
    _ = zv
}
@[export: 'vphp_wrap_VSlimServiceProvider_construct']
pub fn vphp_wrap_vslimserviceprovider_construct(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimServiceProvider(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.construct()
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimServiceProvider_set_app']
pub fn vphp_wrap_vslimserviceprovider_set_app(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimServiceProvider(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := unsafe { &VSlimApp(ctx.arg_raw_obj(0)) }
    res := recv.set_app(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimServiceProvider_has_app']
pub fn vphp_wrap_vslimserviceprovider_has_app(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimServiceProvider(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.has_app()
    ctx.return_val[bool](res)
}
@[export: 'vphp_wrap_VSlimServiceProvider_app']
pub fn vphp_wrap_vslimserviceprovider_app(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimServiceProvider(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.app()
    return voidptr(res)
}
@[export: 'VSlimServiceProvider_handlers']
pub fn vslimserviceprovider_handlers() voidptr {
    return unsafe { &C.vphp_class_handlers{
        prop_handler:  voidptr(vslimserviceprovider_get_prop)
        write_handler: voidptr(vslimserviceprovider_set_prop)
        sync_handler:  voidptr(vslimserviceprovider_sync_props)
        new_raw:       voidptr(vslimserviceprovider_new_raw)
        cleanup_raw:   voidptr(vslimserviceprovider_cleanup_raw)
        free_raw:      voidptr(vslimserviceprovider_free_raw)
    } }
}

@[export: 'VSlimModule_new_raw']
pub fn vslimmodule_new_raw() voidptr {
    return vphp.generic_new_raw[VSlimModule]()
}
@[export: 'VSlimModule_free_raw']
pub fn vslimmodule_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[VSlimModule](ptr)
}
@[export: 'VSlimModule_cleanup_raw']
pub fn vslimmodule_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
}
@[export: 'VSlimModule_get_prop']
pub fn vslimmodule_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = rv
}
@[export: 'VSlimModule_set_prop']
pub fn vslimmodule_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = value
}
@[export: 'VSlimModule_sync_props']
pub fn vslimmodule_sync_props(ptr voidptr, zv &C.zval) {
    _ = ptr
    _ = zv
}
@[export: 'vphp_wrap_VSlimModule_construct']
pub fn vphp_wrap_vslimmodule_construct(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimModule(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.construct()
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimModule_set_app']
pub fn vphp_wrap_vslimmodule_set_app(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimModule(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := unsafe { &VSlimApp(ctx.arg_raw_obj(0)) }
    res := recv.set_app(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimModule_has_app']
pub fn vphp_wrap_vslimmodule_has_app(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimModule(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.has_app()
    ctx.return_val[bool](res)
}
@[export: 'vphp_wrap_VSlimModule_app']
pub fn vphp_wrap_vslimmodule_app(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimModule(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.app()
    return voidptr(res)
}
@[export: 'VSlimModule_handlers']
pub fn vslimmodule_handlers() voidptr {
    return unsafe { &C.vphp_class_handlers{
        prop_handler:  voidptr(vslimmodule_get_prop)
        write_handler: voidptr(vslimmodule_set_prop)
        sync_handler:  voidptr(vslimmodule_sync_props)
        new_raw:       voidptr(vslimmodule_new_raw)
        cleanup_raw:   voidptr(vslimmodule_cleanup_raw)
        free_raw:      voidptr(vslimmodule_free_raw)
    } }
}

@[export: 'RouteGroup_new_raw']
pub fn routegroup_new_raw() voidptr {
    return vphp.generic_new_raw[RouteGroup]()
}
@[export: 'RouteGroup_free_raw']
pub fn routegroup_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[RouteGroup](ptr)
}
@[export: 'RouteGroup_cleanup_raw']
pub fn routegroup_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
}
@[export: 'RouteGroup_get_prop']
pub fn routegroup_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = rv
}
@[export: 'RouteGroup_set_prop']
pub fn routegroup_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = value
}
@[export: 'RouteGroup_sync_props']
pub fn routegroup_sync_props(ptr voidptr, zv &C.zval) {
    _ = ptr
    _ = zv
}
@[export: 'vphp_wrap_RouteGroup_group']
pub fn vphp_wrap_routegroup_group(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &RouteGroup(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    res := recv.group(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_RouteGroup_middleware']
pub fn vphp_wrap_routegroup_middleware(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &RouteGroup(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    res := recv.middleware(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_RouteGroup_before']
pub fn vphp_wrap_routegroup_before(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &RouteGroup(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    res := recv.before(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_RouteGroup_after']
pub fn vphp_wrap_routegroup_after(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &RouteGroup(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    res := recv.after(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_RouteGroup_get']
pub fn vphp_wrap_routegroup_get(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &RouteGroup(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    arg_1 := ctx.arg_borrowed_zbox(1)
    res := recv.get(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_RouteGroup_post']
pub fn vphp_wrap_routegroup_post(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &RouteGroup(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    arg_1 := ctx.arg_borrowed_zbox(1)
    res := recv.post(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_RouteGroup_put']
pub fn vphp_wrap_routegroup_put(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &RouteGroup(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    arg_1 := ctx.arg_borrowed_zbox(1)
    res := recv.put(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_RouteGroup_head']
pub fn vphp_wrap_routegroup_head(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &RouteGroup(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    arg_1 := ctx.arg_borrowed_zbox(1)
    res := recv.head(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_RouteGroup_options']
pub fn vphp_wrap_routegroup_options(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &RouteGroup(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    arg_1 := ctx.arg_borrowed_zbox(1)
    res := recv.options(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_RouteGroup_patch']
pub fn vphp_wrap_routegroup_patch(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &RouteGroup(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    arg_1 := ctx.arg_borrowed_zbox(1)
    res := recv.patch(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_RouteGroup_delete']
pub fn vphp_wrap_routegroup_delete(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &RouteGroup(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    arg_1 := ctx.arg_borrowed_zbox(1)
    res := recv.delete(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_RouteGroup_any']
pub fn vphp_wrap_routegroup_any(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &RouteGroup(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    arg_1 := ctx.arg_borrowed_zbox(1)
    res := recv.any(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_RouteGroup_live']
pub fn vphp_wrap_routegroup_live(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &RouteGroup(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    arg_1 := ctx.arg_borrowed_zbox(1)
    res := recv.live(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_RouteGroup_websocket']
pub fn vphp_wrap_routegroup_websocket(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &RouteGroup(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    arg_1 := ctx.arg_borrowed_zbox(1)
    res := recv.websocket(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_RouteGroup_map']
pub fn vphp_wrap_routegroup_map(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &RouteGroup(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    arg_1 := ctx.arg[string](1)
    arg_2 := ctx.arg_borrowed_zbox(2)
    res := recv.map(arg_0, arg_1, arg_2)
    return voidptr(res)
}
@[export: 'vphp_wrap_RouteGroup_resource']
pub fn vphp_wrap_routegroup_resource(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &RouteGroup(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    arg_1 := ctx.arg[string](1)
    res := recv.resource(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_RouteGroup_api_resource']
pub fn vphp_wrap_routegroup_api_resource(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &RouteGroup(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    arg_1 := ctx.arg[string](1)
    res := recv.api_resource(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_RouteGroup_singleton']
pub fn vphp_wrap_routegroup_singleton(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &RouteGroup(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    arg_1 := ctx.arg[string](1)
    res := recv.singleton(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_RouteGroup_api_singleton']
pub fn vphp_wrap_routegroup_api_singleton(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &RouteGroup(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    arg_1 := ctx.arg[string](1)
    res := recv.api_singleton(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_RouteGroup_resource_opts']
pub fn vphp_wrap_routegroup_resource_opts(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &RouteGroup(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    arg_1 := ctx.arg[string](1)
    arg_2 := ctx.arg_borrowed_zbox(2)
    res := recv.resource_opts(arg_0, arg_1, arg_2)
    return voidptr(res)
}
@[export: 'vphp_wrap_RouteGroup_api_resource_opts']
pub fn vphp_wrap_routegroup_api_resource_opts(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &RouteGroup(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    arg_1 := ctx.arg[string](1)
    arg_2 := ctx.arg_borrowed_zbox(2)
    res := recv.api_resource_opts(arg_0, arg_1, arg_2)
    return voidptr(res)
}
@[export: 'vphp_wrap_RouteGroup_singleton_opts']
pub fn vphp_wrap_routegroup_singleton_opts(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &RouteGroup(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    arg_1 := ctx.arg[string](1)
    arg_2 := ctx.arg_borrowed_zbox(2)
    res := recv.singleton_opts(arg_0, arg_1, arg_2)
    return voidptr(res)
}
@[export: 'vphp_wrap_RouteGroup_api_singleton_opts']
pub fn vphp_wrap_routegroup_api_singleton_opts(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &RouteGroup(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    arg_1 := ctx.arg[string](1)
    arg_2 := ctx.arg_borrowed_zbox(2)
    res := recv.api_singleton_opts(arg_0, arg_1, arg_2)
    return voidptr(res)
}
@[export: 'vphp_wrap_RouteGroup_get_named']
pub fn vphp_wrap_routegroup_get_named(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &RouteGroup(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    arg_1 := ctx.arg[string](1)
    arg_2 := ctx.arg_borrowed_zbox(2)
    res := recv.get_named(arg_0, arg_1, arg_2)
    return voidptr(res)
}
@[export: 'vphp_wrap_RouteGroup_post_named']
pub fn vphp_wrap_routegroup_post_named(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &RouteGroup(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    arg_1 := ctx.arg[string](1)
    arg_2 := ctx.arg_borrowed_zbox(2)
    res := recv.post_named(arg_0, arg_1, arg_2)
    return voidptr(res)
}
@[export: 'vphp_wrap_RouteGroup_put_named']
pub fn vphp_wrap_routegroup_put_named(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &RouteGroup(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    arg_1 := ctx.arg[string](1)
    arg_2 := ctx.arg_borrowed_zbox(2)
    res := recv.put_named(arg_0, arg_1, arg_2)
    return voidptr(res)
}
@[export: 'vphp_wrap_RouteGroup_head_named']
pub fn vphp_wrap_routegroup_head_named(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &RouteGroup(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    arg_1 := ctx.arg[string](1)
    arg_2 := ctx.arg_borrowed_zbox(2)
    res := recv.head_named(arg_0, arg_1, arg_2)
    return voidptr(res)
}
@[export: 'vphp_wrap_RouteGroup_options_named']
pub fn vphp_wrap_routegroup_options_named(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &RouteGroup(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    arg_1 := ctx.arg[string](1)
    arg_2 := ctx.arg_borrowed_zbox(2)
    res := recv.options_named(arg_0, arg_1, arg_2)
    return voidptr(res)
}
@[export: 'vphp_wrap_RouteGroup_patch_named']
pub fn vphp_wrap_routegroup_patch_named(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &RouteGroup(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    arg_1 := ctx.arg[string](1)
    arg_2 := ctx.arg_borrowed_zbox(2)
    res := recv.patch_named(arg_0, arg_1, arg_2)
    return voidptr(res)
}
@[export: 'vphp_wrap_RouteGroup_delete_named']
pub fn vphp_wrap_routegroup_delete_named(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &RouteGroup(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    arg_1 := ctx.arg[string](1)
    arg_2 := ctx.arg_borrowed_zbox(2)
    res := recv.delete_named(arg_0, arg_1, arg_2)
    return voidptr(res)
}
@[export: 'vphp_wrap_RouteGroup_any_named']
pub fn vphp_wrap_routegroup_any_named(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &RouteGroup(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    arg_1 := ctx.arg[string](1)
    arg_2 := ctx.arg_borrowed_zbox(2)
    res := recv.any_named(arg_0, arg_1, arg_2)
    return voidptr(res)
}
@[export: 'vphp_wrap_RouteGroup_websocket_named']
pub fn vphp_wrap_routegroup_websocket_named(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &RouteGroup(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    arg_1 := ctx.arg[string](1)
    arg_2 := ctx.arg_borrowed_zbox(2)
    res := recv.websocket_named(arg_0, arg_1, arg_2)
    return voidptr(res)
}
@[export: 'vphp_wrap_RouteGroup_map_named']
pub fn vphp_wrap_routegroup_map_named(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &RouteGroup(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    arg_1 := ctx.arg[string](1)
    arg_2 := ctx.arg[string](2)
    arg_3 := ctx.arg_borrowed_zbox(3)
    res := recv.map_named(arg_0, arg_1, arg_2, arg_3)
    return voidptr(res)
}
@[export: 'RouteGroup_handlers']
pub fn routegroup_handlers() voidptr {
    return unsafe { &C.vphp_class_handlers{
        prop_handler:  voidptr(routegroup_get_prop)
        write_handler: voidptr(routegroup_set_prop)
        sync_handler:  voidptr(routegroup_sync_props)
        new_raw:       voidptr(routegroup_new_raw)
        cleanup_raw:   voidptr(routegroup_cleanup_raw)
        free_raw:      voidptr(routegroup_free_raw)
    } }
}

@[export: 'VSlimRequest_new_raw']
pub fn vslimrequest_new_raw() voidptr {
    return vphp.generic_new_raw[VSlimRequest]()
}
@[export: 'VSlimRequest_free_raw']
pub fn vslimrequest_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[VSlimRequest](ptr)
}
@[export: 'VSlimRequest_cleanup_raw']
pub fn vslimrequest_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    unsafe {
        mut obj := &VSlimRequest(ptr)
        obj.free()
    }
}
@[export: 'VSlimRequest_get_prop']
pub fn vslimrequest_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    unsafe {
        name := name_ptr.vstring_with_len(name_len).clone()
        obj := &VSlimRequest(ptr)
        if name == 'method' {
            vphp.return_val_raw(rv, obj.method)
            return
        }
        if name == 'raw_path' {
            vphp.return_val_raw(rv, obj.raw_path)
            return
        }
        if name == 'path' {
            vphp.return_val_raw(rv, obj.path)
            return
        }
        if name == 'body' {
            vphp.return_val_raw(rv, obj.body)
            return
        }
        if name == 'query_string' {
            vphp.return_val_raw(rv, obj.query_string)
            return
        }
        if name == 'scheme' {
            vphp.return_val_raw(rv, obj.scheme)
            return
        }
        if name == 'host' {
            vphp.return_val_raw(rv, obj.host)
            return
        }
        if name == 'port' {
            vphp.return_val_raw(rv, obj.port)
            return
        }
        if name == 'protocol_version' {
            vphp.return_val_raw(rv, obj.protocol_version)
            return
        }
        if name == 'remote_addr' {
            vphp.return_val_raw(rv, obj.remote_addr)
            return
        }
    }
}
@[export: 'VSlimRequest_set_prop']
pub fn vslimrequest_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    unsafe {
        name := name_ptr.vstring_with_len(name_len).clone()
        mut obj := &VSlimRequest(ptr)
        arg := vphp.ZVal{ raw: value }
        if name == 'method' {
            obj.method = arg.get_string()
            return
        }
        if name == 'raw_path' {
            obj.raw_path = arg.get_string()
            return
        }
        if name == 'path' {
            obj.path = arg.get_string()
            return
        }
        if name == 'body' {
            obj.body = arg.get_string()
            return
        }
        if name == 'query_string' {
            obj.query_string = arg.get_string()
            return
        }
        if name == 'scheme' {
            obj.scheme = arg.get_string()
            return
        }
        if name == 'host' {
            obj.host = arg.get_string()
            return
        }
        if name == 'port' {
            obj.port = arg.get_string()
            return
        }
        if name == 'protocol_version' {
            obj.protocol_version = arg.get_string()
            return
        }
        if name == 'remote_addr' {
            obj.remote_addr = arg.get_string()
            return
        }
    }
}
@[export: 'VSlimRequest_sync_props']
pub fn vslimrequest_sync_props(ptr voidptr, zv &C.zval) {
    unsafe {
        obj := &VSlimRequest(ptr)
        out := vphp.ZVal{ raw: zv }
        out.add_property_string('method', obj.method)
        out.add_property_string('raw_path', obj.raw_path)
        out.add_property_string('path', obj.path)
        out.add_property_string('body', obj.body)
        out.add_property_string('query_string', obj.query_string)
        out.add_property_string('scheme', obj.scheme)
        out.add_property_string('host', obj.host)
        out.add_property_string('port', obj.port)
        out.add_property_string('protocol_version', obj.protocol_version)
        out.add_property_string('remote_addr', obj.remote_addr)
    }
}
@[export: 'vphp_wrap_VSlimRequest_construct']
pub fn vphp_wrap_vslimrequest_construct(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimRequest(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    arg_1 := ctx.arg[string](1)
    arg_2 := ctx.arg[string](2)
    res := recv.construct(arg_0, arg_1, arg_2)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimRequest_str']
pub fn vphp_wrap_vslimrequest_str(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimRequest(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.str()
    ctx.return_val[string](res)
}
@[export: 'vphp_wrap_VSlimRequest_set_query']
pub fn vphp_wrap_vslimrequest_set_query(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimRequest(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    res := recv.set_query(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimRequest_set_method']
pub fn vphp_wrap_vslimrequest_set_method(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimRequest(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    res := recv.set_method(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimRequest_set_target']
pub fn vphp_wrap_vslimrequest_set_target(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimRequest(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    res := recv.set_target(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimRequest_set_body']
pub fn vphp_wrap_vslimrequest_set_body(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimRequest(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    res := recv.set_body(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimRequest_set_scheme']
pub fn vphp_wrap_vslimrequest_set_scheme(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimRequest(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    res := recv.set_scheme(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimRequest_set_host']
pub fn vphp_wrap_vslimrequest_set_host(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimRequest(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    res := recv.set_host(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimRequest_set_port']
pub fn vphp_wrap_vslimrequest_set_port(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimRequest(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    res := recv.set_port(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimRequest_set_protocol_version']
pub fn vphp_wrap_vslimrequest_set_protocol_version(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimRequest(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    res := recv.set_protocol_version(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimRequest_set_remote_addr']
pub fn vphp_wrap_vslimrequest_set_remote_addr(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimRequest(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    res := recv.set_remote_addr(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimRequest_set_headers']
pub fn vphp_wrap_vslimrequest_set_headers(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimRequest(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    res := recv.set_headers(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimRequest_set_cookies']
pub fn vphp_wrap_vslimrequest_set_cookies(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimRequest(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    res := recv.set_cookies(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimRequest_set_attributes']
pub fn vphp_wrap_vslimrequest_set_attributes(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimRequest(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    res := recv.set_attributes(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimRequest_set_server']
pub fn vphp_wrap_vslimrequest_set_server(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimRequest(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    res := recv.set_server(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimRequest_set_uploaded_files']
pub fn vphp_wrap_vslimrequest_set_uploaded_files(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimRequest(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    res := recv.set_uploaded_files(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimRequest_set_params']
pub fn vphp_wrap_vslimrequest_set_params(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimRequest(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    res := recv.set_params(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimRequest_query']
pub fn vphp_wrap_vslimrequest_query(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimRequest(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    res := recv.query(arg_0)
    ctx.return_val[string](res)
}
@[export: 'vphp_wrap_VSlimRequest_query_params']
pub fn vphp_wrap_vslimrequest_query_params(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimRequest(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.query_params()
    ctx.return_val[map[string]string](res)
}
@[export: 'vphp_wrap_VSlimRequest_has_query']
pub fn vphp_wrap_vslimrequest_has_query(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimRequest(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    res := recv.has_query(arg_0)
    ctx.return_val[bool](res)
}
@[export: 'vphp_wrap_VSlimRequest_input']
pub fn vphp_wrap_vslimrequest_input(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimRequest(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    res := recv.input(arg_0)
    ctx.return_val[string](res)
}
@[export: 'vphp_wrap_VSlimRequest_input_or']
pub fn vphp_wrap_vslimrequest_input_or(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimRequest(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    arg_1 := ctx.arg[string](1)
    res := recv.input_or(arg_0, arg_1)
    ctx.return_val[string](res)
}
@[export: 'vphp_wrap_VSlimRequest_has_input']
pub fn vphp_wrap_vslimrequest_has_input(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimRequest(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    res := recv.has_input(arg_0)
    ctx.return_val[bool](res)
}
@[export: 'vphp_wrap_VSlimRequest_all_inputs']
pub fn vphp_wrap_vslimrequest_all_inputs(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimRequest(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.all_inputs()
    ctx.return_val[map[string]string](res)
}
@[export: 'vphp_wrap_VSlimRequest_parsed_body']
pub fn vphp_wrap_vslimrequest_parsed_body(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimRequest(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.parsed_body()
    ctx.return_val[map[string]string](res)
}
@[export: 'vphp_wrap_VSlimRequest_body_format']
pub fn vphp_wrap_vslimrequest_body_format(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimRequest(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.body_format()
    ctx.return_val[string](res)
}
@[export: 'vphp_wrap_VSlimRequest_is_json_body']
pub fn vphp_wrap_vslimrequest_is_json_body(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimRequest(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.is_json_body()
    ctx.return_val[bool](res)
}
@[export: 'vphp_wrap_VSlimRequest_is_form_body']
pub fn vphp_wrap_vslimrequest_is_form_body(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimRequest(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.is_form_body()
    ctx.return_val[bool](res)
}
@[export: 'vphp_wrap_VSlimRequest_is_multipart_body']
pub fn vphp_wrap_vslimrequest_is_multipart_body(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimRequest(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.is_multipart_body()
    ctx.return_val[bool](res)
}
@[export: 'vphp_wrap_VSlimRequest_json_body']
pub fn vphp_wrap_vslimrequest_json_body(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimRequest(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.json_body()
    ctx.return_val[map[string]string](res)
}
@[export: 'vphp_wrap_VSlimRequest_form_body']
pub fn vphp_wrap_vslimrequest_form_body(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimRequest(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.form_body()
    ctx.return_val[map[string]string](res)
}
@[export: 'vphp_wrap_VSlimRequest_multipart_body']
pub fn vphp_wrap_vslimrequest_multipart_body(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimRequest(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.multipart_body()
    ctx.return_val[map[string]string](res)
}
@[export: 'vphp_wrap_VSlimRequest_parse_error']
pub fn vphp_wrap_vslimrequest_parse_error(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimRequest(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.parse_error()
    ctx.return_val[string](res)
}
@[export: 'vphp_wrap_VSlimRequest_query_all']
pub fn vphp_wrap_vslimrequest_query_all(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimRequest(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.query_all()
    ctx.return_val[map[string]string](res)
}
@[export: 'vphp_wrap_VSlimRequest_header']
pub fn vphp_wrap_vslimrequest_header(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimRequest(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    res := recv.header(arg_0)
    ctx.return_val[string](res)
}
@[export: 'vphp_wrap_VSlimRequest_headers']
pub fn vphp_wrap_vslimrequest_headers(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimRequest(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.headers()
    ctx.return_val[map[string]string](res)
}
@[export: 'vphp_wrap_VSlimRequest_has_header']
pub fn vphp_wrap_vslimrequest_has_header(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimRequest(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    res := recv.has_header(arg_0)
    ctx.return_val[bool](res)
}
@[export: 'vphp_wrap_VSlimRequest_content_type']
pub fn vphp_wrap_vslimrequest_content_type(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimRequest(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.content_type()
    ctx.return_val[string](res)
}
@[export: 'vphp_wrap_VSlimRequest_request_id']
pub fn vphp_wrap_vslimrequest_request_id(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimRequest(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.request_id()
    ctx.return_val[string](res)
}
@[export: 'vphp_wrap_VSlimRequest_trace_id']
pub fn vphp_wrap_vslimrequest_trace_id(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimRequest(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.trace_id()
    ctx.return_val[string](res)
}
@[export: 'vphp_wrap_VSlimRequest_cookie']
pub fn vphp_wrap_vslimrequest_cookie(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimRequest(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    res := recv.cookie(arg_0)
    ctx.return_val[string](res)
}
@[export: 'vphp_wrap_VSlimRequest_cookies']
pub fn vphp_wrap_vslimrequest_cookies(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimRequest(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.cookies()
    ctx.return_val[map[string]string](res)
}
@[export: 'vphp_wrap_VSlimRequest_has_cookie']
pub fn vphp_wrap_vslimrequest_has_cookie(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimRequest(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    res := recv.has_cookie(arg_0)
    ctx.return_val[bool](res)
}
@[export: 'vphp_wrap_VSlimRequest_param']
pub fn vphp_wrap_vslimrequest_param(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimRequest(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    res := recv.param(arg_0)
    ctx.return_val[string](res)
}
@[export: 'vphp_wrap_VSlimRequest_route_params']
pub fn vphp_wrap_vslimrequest_route_params(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimRequest(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.route_params()
    ctx.return_val[map[string]string](res)
}
@[export: 'vphp_wrap_VSlimRequest_has_param']
pub fn vphp_wrap_vslimrequest_has_param(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimRequest(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    res := recv.has_param(arg_0)
    ctx.return_val[bool](res)
}
@[export: 'vphp_wrap_VSlimRequest_attribute']
pub fn vphp_wrap_vslimrequest_attribute(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimRequest(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    res := recv.attribute(arg_0)
    ctx.return_val[string](res)
}
@[export: 'vphp_wrap_VSlimRequest_attributes']
pub fn vphp_wrap_vslimrequest_attributes(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimRequest(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.attributes()
    ctx.return_val[map[string]string](res)
}
@[export: 'vphp_wrap_VSlimRequest_has_attribute']
pub fn vphp_wrap_vslimrequest_has_attribute(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimRequest(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    res := recv.has_attribute(arg_0)
    ctx.return_val[bool](res)
}
@[export: 'vphp_wrap_VSlimRequest_server_value']
pub fn vphp_wrap_vslimrequest_server_value(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimRequest(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    res := recv.server_value(arg_0)
    ctx.return_val[string](res)
}
@[export: 'vphp_wrap_VSlimRequest_server_params']
pub fn vphp_wrap_vslimrequest_server_params(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimRequest(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.server_params()
    ctx.return_val[map[string]string](res)
}
@[export: 'vphp_wrap_VSlimRequest_has_server']
pub fn vphp_wrap_vslimrequest_has_server(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimRequest(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    res := recv.has_server(arg_0)
    ctx.return_val[bool](res)
}
@[export: 'vphp_wrap_VSlimRequest_uploaded_file_count']
pub fn vphp_wrap_vslimrequest_uploaded_file_count(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimRequest(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.uploaded_file_count()
    ctx.return_val[int](res)
}
@[export: 'vphp_wrap_VSlimRequest_uploaded_files']
pub fn vphp_wrap_vslimrequest_uploaded_files(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimRequest(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.uploaded_files()
    ctx.return_val[[]string](res)
}
@[export: 'vphp_wrap_VSlimRequest_has_uploaded_files']
pub fn vphp_wrap_vslimrequest_has_uploaded_files(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimRequest(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.has_uploaded_files()
    ctx.return_val[bool](res)
}
@[export: 'vphp_wrap_VSlimRequest_is_secure']
pub fn vphp_wrap_vslimrequest_is_secure(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimRequest(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.is_secure()
    ctx.return_val[bool](res)
}
@[export: 'vphp_wrap_VSlimRequest_headers_all']
pub fn vphp_wrap_vslimrequest_headers_all(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimRequest(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.headers_all()
    ctx.return_val[map[string]string](res)
}
@[export: 'vphp_wrap_VSlimRequest_cookies_all']
pub fn vphp_wrap_vslimrequest_cookies_all(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimRequest(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.cookies_all()
    ctx.return_val[map[string]string](res)
}
@[export: 'vphp_wrap_VSlimRequest_params_all']
pub fn vphp_wrap_vslimrequest_params_all(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimRequest(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.params_all()
    ctx.return_val[map[string]string](res)
}
@[export: 'vphp_wrap_VSlimRequest_attributes_all']
pub fn vphp_wrap_vslimrequest_attributes_all(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimRequest(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.attributes_all()
    ctx.return_val[map[string]string](res)
}
@[export: 'vphp_wrap_VSlimRequest_server_all']
pub fn vphp_wrap_vslimrequest_server_all(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimRequest(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.server_all()
    ctx.return_val[map[string]string](res)
}
@[export: 'vphp_wrap_VSlimRequest_uploaded_files_all']
pub fn vphp_wrap_vslimrequest_uploaded_files_all(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimRequest(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.uploaded_files_all()
    ctx.return_val[[]string](res)
}
@[export: 'VSlimRequest_handlers']
pub fn vslimrequest_handlers() voidptr {
    return unsafe { &C.vphp_class_handlers{
        prop_handler:  voidptr(vslimrequest_get_prop)
        write_handler: voidptr(vslimrequest_set_prop)
        sync_handler:  voidptr(vslimrequest_sync_props)
        new_raw:       voidptr(vslimrequest_new_raw)
        cleanup_raw:   voidptr(vslimrequest_cleanup_raw)
        free_raw:      voidptr(vslimrequest_free_raw)
    } }
}

@[export: 'VSlimResponse_new_raw']
pub fn vslimresponse_new_raw() voidptr {
    return vphp.generic_new_raw[VSlimResponse]()
}
@[export: 'VSlimResponse_free_raw']
pub fn vslimresponse_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[VSlimResponse](ptr)
}
@[export: 'VSlimResponse_cleanup_raw']
pub fn vslimresponse_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    unsafe {
        mut obj := &VSlimResponse(ptr)
        obj.free()
    }
}
@[export: 'VSlimResponse_get_prop']
pub fn vslimresponse_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    unsafe {
        name := name_ptr.vstring_with_len(name_len).clone()
        obj := &VSlimResponse(ptr)
        if name == 'status' {
            vphp.return_val_raw(rv, i64(obj.status))
            return
        }
        if name == 'body' {
            vphp.return_val_raw(rv, obj.body)
            return
        }
        if name == 'content_type' {
            vphp.return_val_raw(rv, obj.content_type)
            return
        }
    }
}
@[export: 'VSlimResponse_set_prop']
pub fn vslimresponse_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    unsafe {
        name := name_ptr.vstring_with_len(name_len).clone()
        mut obj := &VSlimResponse(ptr)
        arg := vphp.ZVal{ raw: value }
        if name == 'status' {
            obj.status = int(arg.get_int())
            return
        }
        if name == 'body' {
            obj.body = arg.get_string()
            return
        }
        if name == 'content_type' {
            obj.content_type = arg.get_string()
            return
        }
    }
}
@[export: 'VSlimResponse_sync_props']
pub fn vslimresponse_sync_props(ptr voidptr, zv &C.zval) {
    unsafe {
        obj := &VSlimResponse(ptr)
        out := vphp.ZVal{ raw: zv }
        out.add_property_long('status', i64(obj.status))
        out.add_property_string('body', obj.body)
        out.add_property_string('content_type', obj.content_type)
    }
}
@[export: 'vphp_wrap_VSlimResponse_construct']
pub fn vphp_wrap_vslimresponse_construct(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimResponse(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[int](0)
    arg_1 := ctx.arg[string](1)
    arg_2 := ctx.arg[string](2)
    res := recv.construct(arg_0, arg_1, arg_2)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimResponse_header']
pub fn vphp_wrap_vslimresponse_header(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimResponse(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    res := recv.header(arg_0)
    ctx.return_val[string](res)
}
@[export: 'vphp_wrap_VSlimResponse_headers']
pub fn vphp_wrap_vslimresponse_headers(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimResponse(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.headers()
    ctx.return_val[map[string]string](res)
}
@[export: 'vphp_wrap_VSlimResponse_has_header']
pub fn vphp_wrap_vslimresponse_has_header(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimResponse(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    res := recv.has_header(arg_0)
    ctx.return_val[bool](res)
}
@[export: 'vphp_wrap_VSlimResponse_set_header']
pub fn vphp_wrap_vslimresponse_set_header(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimResponse(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    arg_1 := ctx.arg[string](1)
    res := recv.set_header(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimResponse_with_request_id']
pub fn vphp_wrap_vslimresponse_with_request_id(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimResponse(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    res := recv.with_request_id(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimResponse_with_trace_id']
pub fn vphp_wrap_vslimresponse_with_trace_id(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimResponse(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    res := recv.with_trace_id(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimResponse_set_content_type']
pub fn vphp_wrap_vslimresponse_set_content_type(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimResponse(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    res := recv.set_content_type(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimResponse_cookie_header']
pub fn vphp_wrap_vslimresponse_cookie_header(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimResponse(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.cookie_header()
    ctx.return_val[string](res)
}
@[export: 'vphp_wrap_VSlimResponse_set_cookie']
pub fn vphp_wrap_vslimresponse_set_cookie(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimResponse(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    arg_1 := ctx.arg[string](1)
    res := recv.set_cookie(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimResponse_set_cookie_opts']
pub fn vphp_wrap_vslimresponse_set_cookie_opts(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimResponse(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    arg_1 := ctx.arg[string](1)
    arg_2 := ctx.arg[string](2)
    res := recv.set_cookie_opts(arg_0, arg_1, arg_2)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimResponse_set_cookie_full']
pub fn vphp_wrap_vslimresponse_set_cookie_full(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimResponse(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    arg_1 := ctx.arg[string](1)
    arg_2 := ctx.arg[string](2)
    arg_3 := ctx.arg[string](3)
    arg_4 := ctx.arg[int](4)
    arg_5 := ctx.arg[bool](5)
    arg_6 := ctx.arg[bool](6)
    arg_7 := ctx.arg[string](7)
    res := recv.set_cookie_full(arg_0, arg_1, arg_2, arg_3, arg_4, arg_5, arg_6, arg_7)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimResponse_delete_cookie']
pub fn vphp_wrap_vslimresponse_delete_cookie(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimResponse(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    res := recv.delete_cookie(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimResponse_set_status']
pub fn vphp_wrap_vslimresponse_set_status(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimResponse(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[int](0)
    res := recv.set_status(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimResponse_with_status']
pub fn vphp_wrap_vslimresponse_with_status(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimResponse(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[int](0)
    res := recv.with_status(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimResponse_text']
pub fn vphp_wrap_vslimresponse_text(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimResponse(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    res := recv.text(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimResponse_json']
pub fn vphp_wrap_vslimresponse_json(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimResponse(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    res := recv.json(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimResponse_html']
pub fn vphp_wrap_vslimresponse_html(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimResponse(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    res := recv.html(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimResponse_redirect']
pub fn vphp_wrap_vslimresponse_redirect(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimResponse(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    res := recv.redirect(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimResponse_redirect_with_status']
pub fn vphp_wrap_vslimresponse_redirect_with_status(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimResponse(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    arg_1 := ctx.arg[int](1)
    res := recv.redirect_with_status(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimResponse_headers_all']
pub fn vphp_wrap_vslimresponse_headers_all(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimResponse(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.headers_all()
    ctx.return_val[map[string]string](res)
}
@[export: 'vphp_wrap_VSlimResponse_str']
pub fn vphp_wrap_vslimresponse_str(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimResponse(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.str()
    ctx.return_val[string](res)
}
@[export: 'vphp_wrap_VSlimResponse_content_length']
pub fn vphp_wrap_vslimresponse_content_length(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimResponse(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.content_length()
    ctx.return_val[int](res)
}
@[export: 'VSlimResponse_handlers']
pub fn vslimresponse_handlers() voidptr {
    return unsafe { &C.vphp_class_handlers{
        prop_handler:  voidptr(vslimresponse_get_prop)
        write_handler: voidptr(vslimresponse_set_prop)
        sync_handler:  voidptr(vslimresponse_sync_props)
        new_raw:       voidptr(vslimresponse_new_raw)
        cleanup_raw:   voidptr(vslimresponse_cleanup_raw)
        free_raw:      voidptr(vslimresponse_free_raw)
    } }
}

@[export: 'VPhpVSlimPsr7Adapter_new_raw']
pub fn vphpvslimpsr7adapter_new_raw() voidptr {
    return vphp.generic_new_raw[VPhpVSlimPsr7Adapter]()
}
@[export: 'VPhpVSlimPsr7Adapter_free_raw']
pub fn vphpvslimpsr7adapter_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[VPhpVSlimPsr7Adapter](ptr)
}
@[export: 'VPhpVSlimPsr7Adapter_cleanup_raw']
pub fn vphpvslimpsr7adapter_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
}
@[export: 'VPhpVSlimPsr7Adapter_get_prop']
pub fn vphpvslimpsr7adapter_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = rv
}
@[export: 'VPhpVSlimPsr7Adapter_set_prop']
pub fn vphpvslimpsr7adapter_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = value
}
@[export: 'VPhpVSlimPsr7Adapter_sync_props']
pub fn vphpvslimpsr7adapter_sync_props(ptr voidptr, zv &C.zval) {
    _ = ptr
    _ = zv
}
@[export: 'vphp_wrap_VPhpVSlimPsr7Adapter_dispatch']
pub fn vphp_wrap_vphpvslimpsr7adapter_dispatch(ctx vphp.Context) voidptr {
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := unsafe { &VSlimApp(ctx.arg_raw_obj(0)) }
    arg_1 := ctx.arg_borrowed_zbox(1)
    res := VPhpVSlimPsr7Adapter.dispatch(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_VPhpVSlimPsr7Adapter_to_vslim_request']
pub fn vphp_wrap_vphpvslimpsr7adapter_to_vslim_request(ctx vphp.Context) voidptr {
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    res := VPhpVSlimPsr7Adapter.to_vslim_request(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VPhpVSlimPsr7Adapter_to_worker_envelope']
pub fn vphp_wrap_vphpvslimpsr7adapter_to_worker_envelope(ctx vphp.Context)  {
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    res := VPhpVSlimPsr7Adapter.to_worker_envelope(arg_0)
    ctx.return_val[vphp.RequestOwnedZBox](res)
}
@[export: 'VPhpVSlimPsr7Adapter_handlers']
pub fn vphpvslimpsr7adapter_handlers() voidptr {
    return unsafe { &C.vphp_class_handlers{
        prop_handler:  voidptr(vphpvslimpsr7adapter_get_prop)
        write_handler: voidptr(vphpvslimpsr7adapter_set_prop)
        sync_handler:  voidptr(vphpvslimpsr7adapter_sync_props)
        new_raw:       voidptr(vphpvslimpsr7adapter_new_raw)
        cleanup_raw:   voidptr(vphpvslimpsr7adapter_cleanup_raw)
        free_raw:      voidptr(vphpvslimpsr7adapter_free_raw)
    } }
}

@[export: 'VSlimStreamResponse_new_raw']
pub fn vslimstreamresponse_new_raw() voidptr {
    return vphp.generic_new_raw[VSlimStreamResponse]()
}
@[export: 'VSlimStreamResponse_free_raw']
pub fn vslimstreamresponse_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[VSlimStreamResponse](ptr)
}
@[export: 'VSlimStreamResponse_cleanup_raw']
pub fn vslimstreamresponse_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    unsafe {
        mut obj := &VSlimStreamResponse(ptr)
        obj.free()
    }
}
@[export: 'VSlimStreamResponse_get_prop']
pub fn vslimstreamresponse_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    unsafe {
        name := name_ptr.vstring_with_len(name_len).clone()
        obj := &VSlimStreamResponse(ptr)
        if name == 'stream_type' {
            vphp.return_val_raw(rv, obj.stream_type)
            return
        }
        if name == 'status' {
            vphp.return_val_raw(rv, i64(obj.status))
            return
        }
        if name == 'content_type' {
            vphp.return_val_raw(rv, obj.content_type)
            return
        }
    }
}
@[export: 'VSlimStreamResponse_set_prop']
pub fn vslimstreamresponse_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    unsafe {
        name := name_ptr.vstring_with_len(name_len).clone()
        mut obj := &VSlimStreamResponse(ptr)
        arg := vphp.ZVal{ raw: value }
        if name == 'stream_type' {
            obj.stream_type = arg.get_string()
            return
        }
        if name == 'status' {
            obj.status = int(arg.get_int())
            return
        }
        if name == 'content_type' {
            obj.content_type = arg.get_string()
            return
        }
    }
}
@[export: 'VSlimStreamResponse_sync_props']
pub fn vslimstreamresponse_sync_props(ptr voidptr, zv &C.zval) {
    unsafe {
        obj := &VSlimStreamResponse(ptr)
        out := vphp.ZVal{ raw: zv }
        out.add_property_string('stream_type', obj.stream_type)
        out.add_property_long('status', i64(obj.status))
        out.add_property_string('content_type', obj.content_type)
    }
}
@[export: 'vphp_wrap_VSlimStreamResponse_construct']
pub fn vphp_wrap_vslimstreamresponse_construct(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimStreamResponse(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    arg_1 := ctx.arg_borrowed_zbox(1)
    arg_2 := ctx.arg[int](2)
    arg_3 := ctx.arg[string](3)
    arg_4 := ctx.arg_borrowed_zbox(4)
    res := recv.construct(arg_0, arg_1, arg_2, arg_3, arg_4)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimStreamResponse_text']
pub fn vphp_wrap_vslimstreamresponse_text(ctx vphp.Context) voidptr {
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    res := VSlimStreamResponse.text(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimStreamResponse_text_with']
pub fn vphp_wrap_vslimstreamresponse_text_with(ctx vphp.Context) voidptr {
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    arg_1 := ctx.arg[int](1)
    arg_2 := ctx.arg[string](2)
    arg_3 := ctx.arg_borrowed_zbox(3)
    res := VSlimStreamResponse.text_with(arg_0, arg_1, arg_2, arg_3)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimStreamResponse_sse']
pub fn vphp_wrap_vslimstreamresponse_sse(ctx vphp.Context) voidptr {
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    res := VSlimStreamResponse.sse(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimStreamResponse_sse_with']
pub fn vphp_wrap_vslimstreamresponse_sse_with(ctx vphp.Context) voidptr {
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    arg_1 := ctx.arg[int](1)
    arg_2 := ctx.arg_borrowed_zbox(2)
    res := VSlimStreamResponse.sse_with(arg_0, arg_1, arg_2)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimStreamResponse_header']
pub fn vphp_wrap_vslimstreamresponse_header(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimStreamResponse(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    res := recv.header(arg_0)
    ctx.return_val[string](res)
}
@[export: 'vphp_wrap_VSlimStreamResponse_headers']
pub fn vphp_wrap_vslimstreamresponse_headers(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimStreamResponse(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.headers()
    ctx.return_val[map[string]string](res)
}
@[export: 'vphp_wrap_VSlimStreamResponse_has_header']
pub fn vphp_wrap_vslimstreamresponse_has_header(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimStreamResponse(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    res := recv.has_header(arg_0)
    ctx.return_val[bool](res)
}
@[export: 'vphp_wrap_VSlimStreamResponse_set_header']
pub fn vphp_wrap_vslimstreamresponse_set_header(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimStreamResponse(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    arg_1 := ctx.arg[string](1)
    res := recv.set_header(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimStreamResponse_set_status']
pub fn vphp_wrap_vslimstreamresponse_set_status(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimStreamResponse(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[int](0)
    res := recv.set_status(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimStreamResponse_set_content_type']
pub fn vphp_wrap_vslimstreamresponse_set_content_type(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimStreamResponse(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    res := recv.set_content_type(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimStreamResponse_set_chunks']
pub fn vphp_wrap_vslimstreamresponse_set_chunks(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimStreamResponse(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    res := recv.set_chunks(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimStreamResponse_chunks']
pub fn vphp_wrap_vslimstreamresponse_chunks(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimStreamResponse(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.chunks()
    ctx.return_val[vphp.RequestOwnedZBox](res)
}
@[export: 'VSlimStreamResponse_handlers']
pub fn vslimstreamresponse_handlers() voidptr {
    return unsafe { &C.vphp_class_handlers{
        prop_handler:  voidptr(vslimstreamresponse_get_prop)
        write_handler: voidptr(vslimstreamresponse_set_prop)
        sync_handler:  voidptr(vslimstreamresponse_sync_props)
        new_raw:       voidptr(vslimstreamresponse_new_raw)
        cleanup_raw:   voidptr(vslimstreamresponse_cleanup_raw)
        free_raw:      voidptr(vslimstreamresponse_free_raw)
    } }
}

@[export: 'VSlimStreamNdjsonDecoder_new_raw']
pub fn vslimstreamndjsondecoder_new_raw() voidptr {
    return vphp.generic_new_raw[VSlimStreamNdjsonDecoder]()
}
@[export: 'VSlimStreamNdjsonDecoder_free_raw']
pub fn vslimstreamndjsondecoder_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[VSlimStreamNdjsonDecoder](ptr)
}
@[export: 'VSlimStreamNdjsonDecoder_cleanup_raw']
pub fn vslimstreamndjsondecoder_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
}
@[export: 'VSlimStreamNdjsonDecoder_get_prop']
pub fn vslimstreamndjsondecoder_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = rv
}
@[export: 'VSlimStreamNdjsonDecoder_set_prop']
pub fn vslimstreamndjsondecoder_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = value
}
@[export: 'VSlimStreamNdjsonDecoder_sync_props']
pub fn vslimstreamndjsondecoder_sync_props(ptr voidptr, zv &C.zval) {
    _ = ptr
    _ = zv
}
@[export: 'vphp_wrap_VSlimStreamNdjsonDecoder_decode']
pub fn vphp_wrap_vslimstreamndjsondecoder_decode(ctx vphp.Context)  {
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    res := VSlimStreamNdjsonDecoder.decode(arg_0)
    ctx.return_val[vphp.RequestOwnedZBox](res)
}
@[export: 'VSlimStreamNdjsonDecoder_handlers']
pub fn vslimstreamndjsondecoder_handlers() voidptr {
    return unsafe { &C.vphp_class_handlers{
        prop_handler:  voidptr(vslimstreamndjsondecoder_get_prop)
        write_handler: voidptr(vslimstreamndjsondecoder_set_prop)
        sync_handler:  voidptr(vslimstreamndjsondecoder_sync_props)
        new_raw:       voidptr(vslimstreamndjsondecoder_new_raw)
        cleanup_raw:   voidptr(vslimstreamndjsondecoder_cleanup_raw)
        free_raw:      voidptr(vslimstreamndjsondecoder_free_raw)
    } }
}

@[export: 'VSlimStreamSseEncoder_new_raw']
pub fn vslimstreamsseencoder_new_raw() voidptr {
    return vphp.generic_new_raw[VSlimStreamSseEncoder]()
}
@[export: 'VSlimStreamSseEncoder_free_raw']
pub fn vslimstreamsseencoder_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[VSlimStreamSseEncoder](ptr)
}
@[export: 'VSlimStreamSseEncoder_cleanup_raw']
pub fn vslimstreamsseencoder_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
}
@[export: 'VSlimStreamSseEncoder_get_prop']
pub fn vslimstreamsseencoder_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = rv
}
@[export: 'VSlimStreamSseEncoder_set_prop']
pub fn vslimstreamsseencoder_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = value
}
@[export: 'VSlimStreamSseEncoder_sync_props']
pub fn vslimstreamsseencoder_sync_props(ptr voidptr, zv &C.zval) {
    _ = ptr
    _ = zv
}
@[export: 'vphp_wrap_VSlimStreamSseEncoder_from_ollama']
pub fn vphp_wrap_vslimstreamsseencoder_from_ollama(ctx vphp.Context)  {
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    arg_1 := ctx.arg[string](1)
    res := VSlimStreamSseEncoder.from_ollama(arg_0, arg_1)
    ctx.return_val[vphp.RequestOwnedZBox](res)
}
@[export: 'VSlimStreamSseEncoder_handlers']
pub fn vslimstreamsseencoder_handlers() voidptr {
    return unsafe { &C.vphp_class_handlers{
        prop_handler:  voidptr(vslimstreamsseencoder_get_prop)
        write_handler: voidptr(vslimstreamsseencoder_set_prop)
        sync_handler:  voidptr(vslimstreamsseencoder_sync_props)
        new_raw:       voidptr(vslimstreamsseencoder_new_raw)
        cleanup_raw:   voidptr(vslimstreamsseencoder_cleanup_raw)
        free_raw:      voidptr(vslimstreamsseencoder_free_raw)
    } }
}

@[export: 'VSlimStreamOllamaClient_new_raw']
pub fn vslimstreamollamaclient_new_raw() voidptr {
    return vphp.generic_new_raw[VSlimStreamOllamaClient]()
}
@[export: 'VSlimStreamOllamaClient_free_raw']
pub fn vslimstreamollamaclient_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[VSlimStreamOllamaClient](ptr)
}
@[export: 'VSlimStreamOllamaClient_cleanup_raw']
pub fn vslimstreamollamaclient_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    unsafe {
        mut obj := &VSlimStreamOllamaClient(ptr)
        obj.free()
    }
}
@[export: 'VSlimStreamOllamaClient_get_prop']
pub fn vslimstreamollamaclient_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = rv
}
@[export: 'VSlimStreamOllamaClient_set_prop']
pub fn vslimstreamollamaclient_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = value
}
@[export: 'VSlimStreamOllamaClient_sync_props']
pub fn vslimstreamollamaclient_sync_props(ptr voidptr, zv &C.zval) {
    _ = ptr
    _ = zv
}
@[export: 'vphp_wrap_VSlimStreamOllamaClient_construct']
pub fn vphp_wrap_vslimstreamollamaclient_construct(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimStreamOllamaClient(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    arg_1 := ctx.arg[string](1)
    arg_2 := ctx.arg[string](2)
    arg_3 := ctx.arg[string](3)
    res := recv.construct(arg_0, arg_1, arg_2, arg_3)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimStreamOllamaClient_from_env']
pub fn vphp_wrap_vslimstreamollamaclient_from_env(ctx vphp.Context) voidptr {
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := VSlimStreamOllamaClient.from_env()
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimStreamOllamaClient_from_options']
pub fn vphp_wrap_vslimstreamollamaclient_from_options(ctx vphp.Context) voidptr {
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    res := VSlimStreamOllamaClient.from_options(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimStreamOllamaClient_chat_url']
pub fn vphp_wrap_vslimstreamollamaclient_chat_url(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimStreamOllamaClient(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.chat_url()
    ctx.return_val[string](res)
}
@[export: 'vphp_wrap_VSlimStreamOllamaClient_default_model']
pub fn vphp_wrap_vslimstreamollamaclient_default_model(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimStreamOllamaClient(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.default_model()
    ctx.return_val[string](res)
}
@[export: 'vphp_wrap_VSlimStreamOllamaClient_api_key']
pub fn vphp_wrap_vslimstreamollamaclient_api_key(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimStreamOllamaClient(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.api_key()
    ctx.return_val[string](res)
}
@[export: 'vphp_wrap_VSlimStreamOllamaClient_fixture_path']
pub fn vphp_wrap_vslimstreamollamaclient_fixture_path(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimStreamOllamaClient(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.fixture_path()
    ctx.return_val[string](res)
}
@[export: 'vphp_wrap_VSlimStreamOllamaClient_payload']
pub fn vphp_wrap_vslimstreamollamaclient_payload(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimStreamOllamaClient(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    res := recv.payload(arg_0)
    ctx.return_val[vphp.RequestOwnedZBox](res)
}
@[export: 'vphp_wrap_VSlimStreamOllamaClient_payload_from_request']
pub fn vphp_wrap_vslimstreamollamaclient_payload_from_request(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimStreamOllamaClient(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    res := recv.payload_from_request(arg_0)
    ctx.return_val[vphp.RequestOwnedZBox](res)
}
@[export: 'vphp_wrap_VSlimStreamOllamaClient_open_stream']
pub fn vphp_wrap_vslimstreamollamaclient_open_stream(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimStreamOllamaClient(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    res := recv.open_stream(arg_0)
    ctx.return_val[vphp.RequestOwnedZBox](res)
}
@[export: 'vphp_wrap_VSlimStreamOllamaClient_text_response_from_request']
pub fn vphp_wrap_vslimstreamollamaclient_text_response_from_request(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimStreamOllamaClient(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    res := recv.text_response_from_request(arg_0)
    ctx.return_val[vphp.RequestOwnedZBox](res)
}
@[export: 'vphp_wrap_VSlimStreamOllamaClient_sse_response_from_request']
pub fn vphp_wrap_vslimstreamollamaclient_sse_response_from_request(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimStreamOllamaClient(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    res := recv.sse_response_from_request(arg_0)
    ctx.return_val[vphp.RequestOwnedZBox](res)
}
@[export: 'VSlimStreamOllamaClient_handlers']
pub fn vslimstreamollamaclient_handlers() voidptr {
    return unsafe { &C.vphp_class_handlers{
        prop_handler:  voidptr(vslimstreamollamaclient_get_prop)
        write_handler: voidptr(vslimstreamollamaclient_set_prop)
        sync_handler:  voidptr(vslimstreamollamaclient_sync_props)
        new_raw:       voidptr(vslimstreamollamaclient_new_raw)
        cleanup_raw:   voidptr(vslimstreamollamaclient_cleanup_raw)
        free_raw:      voidptr(vslimstreamollamaclient_free_raw)
    } }
}

@[export: 'VSlimStreamFactory_new_raw']
pub fn vslimstreamfactory_new_raw() voidptr {
    return vphp.generic_new_raw[VSlimStreamFactory]()
}
@[export: 'VSlimStreamFactory_free_raw']
pub fn vslimstreamfactory_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[VSlimStreamFactory](ptr)
}
@[export: 'VSlimStreamFactory_cleanup_raw']
pub fn vslimstreamfactory_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
}
@[export: 'VSlimStreamFactory_get_prop']
pub fn vslimstreamfactory_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = rv
}
@[export: 'VSlimStreamFactory_set_prop']
pub fn vslimstreamfactory_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = value
}
@[export: 'VSlimStreamFactory_sync_props']
pub fn vslimstreamfactory_sync_props(ptr voidptr, zv &C.zval) {
    _ = ptr
    _ = zv
}
@[export: 'vphp_wrap_VSlimStreamFactory_text']
pub fn vphp_wrap_vslimstreamfactory_text(ctx vphp.Context)  {
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    res := VSlimStreamFactory.text(arg_0)
    ctx.return_val[vphp.RequestOwnedZBox](res)
}
@[export: 'vphp_wrap_VSlimStreamFactory_text_with']
pub fn vphp_wrap_vslimstreamfactory_text_with(ctx vphp.Context)  {
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    arg_1 := ctx.arg[int](1)
    arg_2 := ctx.arg[string](2)
    arg_3 := ctx.arg_borrowed_zbox(3)
    res := VSlimStreamFactory.text_with(arg_0, arg_1, arg_2, arg_3)
    ctx.return_val[vphp.RequestOwnedZBox](res)
}
@[export: 'vphp_wrap_VSlimStreamFactory_sse']
pub fn vphp_wrap_vslimstreamfactory_sse(ctx vphp.Context)  {
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    res := VSlimStreamFactory.sse(arg_0)
    ctx.return_val[vphp.RequestOwnedZBox](res)
}
@[export: 'vphp_wrap_VSlimStreamFactory_sse_with']
pub fn vphp_wrap_vslimstreamfactory_sse_with(ctx vphp.Context)  {
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    arg_1 := ctx.arg[int](1)
    arg_2 := ctx.arg_borrowed_zbox(2)
    res := VSlimStreamFactory.sse_with(arg_0, arg_1, arg_2)
    ctx.return_val[vphp.RequestOwnedZBox](res)
}
@[export: 'vphp_wrap_VSlimStreamFactory_ollama_text']
pub fn vphp_wrap_vslimstreamfactory_ollama_text(ctx vphp.Context)  {
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    res := VSlimStreamFactory.ollama_text(arg_0)
    ctx.return_val[vphp.RequestOwnedZBox](res)
}
@[export: 'vphp_wrap_VSlimStreamFactory_ollama_text_with']
pub fn vphp_wrap_vslimstreamfactory_ollama_text_with(ctx vphp.Context)  {
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    arg_1 := ctx.arg_borrowed_zbox(1)
    res := VSlimStreamFactory.ollama_text_with(arg_0, arg_1)
    ctx.return_val[vphp.RequestOwnedZBox](res)
}
@[export: 'vphp_wrap_VSlimStreamFactory_ollama_sse']
pub fn vphp_wrap_vslimstreamfactory_ollama_sse(ctx vphp.Context)  {
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    res := VSlimStreamFactory.ollama_sse(arg_0)
    ctx.return_val[vphp.RequestOwnedZBox](res)
}
@[export: 'vphp_wrap_VSlimStreamFactory_ollama_sse_with']
pub fn vphp_wrap_vslimstreamfactory_ollama_sse_with(ctx vphp.Context)  {
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    arg_1 := ctx.arg_borrowed_zbox(1)
    res := VSlimStreamFactory.ollama_sse_with(arg_0, arg_1)
    ctx.return_val[vphp.RequestOwnedZBox](res)
}
@[export: 'VSlimStreamFactory_handlers']
pub fn vslimstreamfactory_handlers() voidptr {
    return unsafe { &C.vphp_class_handlers{
        prop_handler:  voidptr(vslimstreamfactory_get_prop)
        write_handler: voidptr(vslimstreamfactory_set_prop)
        sync_handler:  voidptr(vslimstreamfactory_sync_props)
        new_raw:       voidptr(vslimstreamfactory_new_raw)
        cleanup_raw:   voidptr(vslimstreamfactory_cleanup_raw)
        free_raw:      voidptr(vslimstreamfactory_free_raw)
    } }
}

@[export: 'VSlimWebSocketApp_new_raw']
pub fn vslimwebsocketapp_new_raw() voidptr {
    return vphp.generic_new_raw[VSlimWebSocketApp]()
}
@[export: 'VSlimWebSocketApp_free_raw']
pub fn vslimwebsocketapp_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[VSlimWebSocketApp](ptr)
}
@[export: 'VSlimWebSocketApp_cleanup_raw']
pub fn vslimwebsocketapp_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    unsafe {
        mut obj := &VSlimWebSocketApp(ptr)
        obj.free()
    }
}
@[export: 'VSlimWebSocketApp_get_prop']
pub fn vslimwebsocketapp_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = rv
}
@[export: 'VSlimWebSocketApp_set_prop']
pub fn vslimwebsocketapp_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = value
}
@[export: 'VSlimWebSocketApp_sync_props']
pub fn vslimwebsocketapp_sync_props(ptr voidptr, zv &C.zval) {
    _ = ptr
    _ = zv
}
@[export: 'vphp_wrap_VSlimWebSocketApp_construct']
pub fn vphp_wrap_vslimwebsocketapp_construct(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimWebSocketApp(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.construct()
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimWebSocketApp_on_open']
pub fn vphp_wrap_vslimwebsocketapp_on_open(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimWebSocketApp(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    res := recv.on_open(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimWebSocketApp_on_message']
pub fn vphp_wrap_vslimwebsocketapp_on_message(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimWebSocketApp(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    res := recv.on_message(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimWebSocketApp_on_close']
pub fn vphp_wrap_vslimwebsocketapp_on_close(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimWebSocketApp(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    res := recv.on_close(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimWebSocketApp_has_on_open']
pub fn vphp_wrap_vslimwebsocketapp_has_on_open(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimWebSocketApp(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.has_on_open()
    ctx.return_val[bool](res)
}
@[export: 'vphp_wrap_VSlimWebSocketApp_has_on_message']
pub fn vphp_wrap_vslimwebsocketapp_has_on_message(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimWebSocketApp(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.has_on_message()
    ctx.return_val[bool](res)
}
@[export: 'vphp_wrap_VSlimWebSocketApp_has_on_close']
pub fn vphp_wrap_vslimwebsocketapp_has_on_close(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimWebSocketApp(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.has_on_close()
    ctx.return_val[bool](res)
}
@[export: 'vphp_wrap_VSlimWebSocketApp_remember']
pub fn vphp_wrap_vslimwebsocketapp_remember(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimWebSocketApp(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    res := recv.remember(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimWebSocketApp_forget']
pub fn vphp_wrap_vslimwebsocketapp_forget(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimWebSocketApp(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    res := recv.forget(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimWebSocketApp_has_connection']
pub fn vphp_wrap_vslimwebsocketapp_has_connection(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimWebSocketApp(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    res := recv.has_connection(arg_0)
    ctx.return_val[bool](res)
}
@[export: 'vphp_wrap_VSlimWebSocketApp_join']
pub fn vphp_wrap_vslimwebsocketapp_join(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimWebSocketApp(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    arg_1 := ctx.arg_borrowed_zbox(1)
    res := recv.join(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimWebSocketApp_leave']
pub fn vphp_wrap_vslimwebsocketapp_leave(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimWebSocketApp(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    arg_1 := ctx.arg_borrowed_zbox(1)
    res := recv.leave(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimWebSocketApp_members']
pub fn vphp_wrap_vslimwebsocketapp_members(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimWebSocketApp(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    res := recv.members(arg_0)
    ctx.return_val[[]string](res)
}
@[export: 'vphp_wrap_VSlimWebSocketApp_connection_ids']
pub fn vphp_wrap_vslimwebsocketapp_connection_ids(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimWebSocketApp(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.connection_ids()
    ctx.return_val[[]string](res)
}
@[export: 'vphp_wrap_VSlimWebSocketApp_rooms_for']
pub fn vphp_wrap_vslimwebsocketapp_rooms_for(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimWebSocketApp(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    res := recv.rooms_for(arg_0)
    ctx.return_val[[]string](res)
}
@[export: 'vphp_wrap_VSlimWebSocketApp_send_to']
pub fn vphp_wrap_vslimwebsocketapp_send_to(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimWebSocketApp(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    arg_1 := ctx.arg[string](1)
    res := recv.send_to(arg_0, arg_1)
    ctx.return_val[bool](res)
}
@[export: 'vphp_wrap_VSlimWebSocketApp_broadcast']
pub fn vphp_wrap_vslimwebsocketapp_broadcast(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimWebSocketApp(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    arg_1 := ctx.arg[string](1)
    arg_2 := ctx.arg[string](2)
    res := recv.broadcast(arg_0, arg_1, arg_2)
    ctx.return_val[int](res)
}
@[export: 'vphp_wrap_VSlimWebSocketApp_handle_websocket']
pub fn vphp_wrap_vslimwebsocketapp_handle_websocket(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimWebSocketApp(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    arg_1 := ctx.arg_borrowed_zbox(1)
    res := recv.handle_websocket(arg_0, arg_1)
    ctx.return_val[vphp.RequestOwnedZBox](res)
}
@[export: 'VSlimWebSocketApp_handlers']
pub fn vslimwebsocketapp_handlers() voidptr {
    return unsafe { &C.vphp_class_handlers{
        prop_handler:  voidptr(vslimwebsocketapp_get_prop)
        write_handler: voidptr(vslimwebsocketapp_set_prop)
        sync_handler:  voidptr(vslimwebsocketapp_sync_props)
        new_raw:       voidptr(vslimwebsocketapp_new_raw)
        cleanup_raw:   voidptr(vslimwebsocketapp_cleanup_raw)
        free_raw:      voidptr(vslimwebsocketapp_free_raw)
    } }
}

@[export: 'VSlimMcpApp_new_raw']
pub fn vslimmcpapp_new_raw() voidptr {
    return vphp.generic_new_raw[VSlimMcpApp]()
}
@[export: 'VSlimMcpApp_free_raw']
pub fn vslimmcpapp_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[VSlimMcpApp](ptr)
}
@[export: 'VSlimMcpApp_cleanup_raw']
pub fn vslimmcpapp_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    unsafe {
        mut obj := &VSlimMcpApp(ptr)
        obj.free()
    }
}
@[export: 'VSlimMcpApp_get_prop']
pub fn vslimmcpapp_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = rv
}
@[export: 'VSlimMcpApp_set_prop']
pub fn vslimmcpapp_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = value
}
@[export: 'VSlimMcpApp_sync_props']
pub fn vslimmcpapp_sync_props(ptr voidptr, zv &C.zval) {
    _ = ptr
    _ = zv
}
@[export: 'vphp_wrap_VSlimMcpApp_construct']
pub fn vphp_wrap_vslimmcpapp_construct(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimMcpApp(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.construct()
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimMcpApp_server_info']
pub fn vphp_wrap_vslimmcpapp_server_info(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimMcpApp(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    res := recv.server_info(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimMcpApp_capability']
pub fn vphp_wrap_vslimmcpapp_capability(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimMcpApp(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    arg_1 := ctx.arg_borrowed_zbox(1)
    res := recv.capability(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimMcpApp_capabilities']
pub fn vphp_wrap_vslimmcpapp_capabilities(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimMcpApp(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    res := recv.capabilities(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimMcpApp_register']
pub fn vphp_wrap_vslimmcpapp_register(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimMcpApp(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    arg_1 := ctx.arg_borrowed_zbox(1)
    res := recv.register(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimMcpApp_tool']
pub fn vphp_wrap_vslimmcpapp_tool(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimMcpApp(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    arg_1 := ctx.arg[string](1)
    arg_2 := ctx.arg_borrowed_zbox(2)
    arg_3 := ctx.arg_borrowed_zbox(3)
    res := recv.tool(arg_0, arg_1, arg_2, arg_3)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimMcpApp_resource']
pub fn vphp_wrap_vslimmcpapp_resource(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimMcpApp(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    arg_1 := ctx.arg[string](1)
    arg_2 := ctx.arg[string](2)
    arg_3 := ctx.arg[string](3)
    arg_4 := ctx.arg_borrowed_zbox(4)
    res := recv.resource(arg_0, arg_1, arg_2, arg_3, arg_4)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimMcpApp_prompt']
pub fn vphp_wrap_vslimmcpapp_prompt(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimMcpApp(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    arg_1 := ctx.arg[string](1)
    arg_2 := ctx.arg_borrowed_zbox(2)
    arg_3 := ctx.arg_borrowed_zbox(3)
    res := recv.prompt(arg_0, arg_1, arg_2, arg_3)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimMcpApp_notification']
pub fn vphp_wrap_vslimmcpapp_notification(ctx vphp.Context)  {
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    arg_1 := ctx.arg_borrowed_zbox(1)
    res := VSlimMcpApp.notification(arg_0, arg_1)
    ctx.return_val[string](res)
}
@[export: 'vphp_wrap_VSlimMcpApp_request']
pub fn vphp_wrap_vslimmcpapp_request(ctx vphp.Context)  {
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    arg_1 := ctx.arg[string](1)
    arg_2 := ctx.arg_borrowed_zbox(2)
    res := VSlimMcpApp.request(arg_0, arg_1, arg_2)
    ctx.return_val[string](res)
}
@[export: 'vphp_wrap_VSlimMcpApp_sampling_request']
pub fn vphp_wrap_vslimmcpapp_sampling_request(ctx vphp.Context)  {
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    arg_1 := ctx.arg_borrowed_zbox(1)
    arg_2 := ctx.arg_borrowed_zbox(2)
    arg_3 := ctx.arg[string](3)
    arg_4 := ctx.arg[int](4)
    arg_5 := ctx.arg_borrowed_zbox(5)
    arg_6 := ctx.arg_borrowed_zbox(6)
    arg_7 := ctx.arg_borrowed_zbox(7)
    res := VSlimMcpApp.sampling_request(arg_0, arg_1, arg_2, arg_3, arg_4, arg_5, arg_6, arg_7)
    ctx.return_val[string](res)
}
@[export: 'vphp_wrap_VSlimMcpApp_queued_result']
pub fn vphp_wrap_vslimmcpapp_queued_result(ctx vphp.Context)  {
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    arg_1 := ctx.arg_borrowed_zbox(1)
    arg_2 := ctx.arg_borrowed_zbox(2)
    arg_3 := ctx.arg[int](3)
    arg_4 := ctx.arg[string](4)
    arg_5 := ctx.arg[string](5)
    arg_6 := ctx.arg_borrowed_zbox(6)
    res := VSlimMcpApp.queued_result(arg_0, arg_1, arg_2, arg_3, arg_4, arg_5, arg_6)
    ctx.return_val[vphp.RequestOwnedZBox](res)
}
@[export: 'vphp_wrap_VSlimMcpApp_queue_messages']
pub fn vphp_wrap_vslimmcpapp_queue_messages(ctx vphp.Context)  {
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    arg_1 := ctx.arg_borrowed_zbox(1)
    arg_2 := ctx.arg_borrowed_zbox(2)
    arg_3 := ctx.arg[int](3)
    arg_4 := ctx.arg[string](4)
    arg_5 := ctx.arg[string](5)
    arg_6 := ctx.arg_borrowed_zbox(6)
    res := VSlimMcpApp.queue_messages(arg_0, arg_1, arg_2, arg_3, arg_4, arg_5, arg_6)
    ctx.return_val[vphp.RequestOwnedZBox](res)
}
@[export: 'vphp_wrap_VSlimMcpApp_notify']
pub fn vphp_wrap_vslimmcpapp_notify(ctx vphp.Context)  {
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    arg_1 := ctx.arg[string](1)
    arg_2 := ctx.arg_borrowed_zbox(2)
    arg_3 := ctx.arg[string](3)
    arg_4 := ctx.arg[string](4)
    res := VSlimMcpApp.notify(arg_0, arg_1, arg_2, arg_3, arg_4)
    ctx.return_val[vphp.RequestOwnedZBox](res)
}
@[export: 'vphp_wrap_VSlimMcpApp_queue_notification']
pub fn vphp_wrap_vslimmcpapp_queue_notification(ctx vphp.Context)  {
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    arg_1 := ctx.arg[string](1)
    arg_2 := ctx.arg_borrowed_zbox(2)
    arg_3 := ctx.arg[string](3)
    arg_4 := ctx.arg[string](4)
    res := VSlimMcpApp.queue_notification(arg_0, arg_1, arg_2, arg_3, arg_4)
    ctx.return_val[vphp.RequestOwnedZBox](res)
}
@[export: 'vphp_wrap_VSlimMcpApp_queue_request']
pub fn vphp_wrap_vslimmcpapp_queue_request(ctx vphp.Context)  {
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    arg_1 := ctx.arg_borrowed_zbox(1)
    arg_2 := ctx.arg[string](2)
    arg_3 := ctx.arg_borrowed_zbox(3)
    arg_4 := ctx.arg[string](4)
    arg_5 := ctx.arg[string](5)
    res := VSlimMcpApp.queue_request(arg_0, arg_1, arg_2, arg_3, arg_4, arg_5)
    ctx.return_val[vphp.RequestOwnedZBox](res)
}
@[export: 'vphp_wrap_VSlimMcpApp_queue_progress']
pub fn vphp_wrap_vslimmcpapp_queue_progress(ctx vphp.Context)  {
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    arg_1 := ctx.arg_borrowed_zbox(1)
    arg_2 := ctx.arg_borrowed_zbox(2)
    arg_3 := ctx.arg_borrowed_zbox(3)
    arg_4 := ctx.arg[string](4)
    arg_5 := ctx.arg[string](5)
    arg_6 := ctx.arg[string](6)
    res := VSlimMcpApp.queue_progress(arg_0, arg_1, arg_2, arg_3, arg_4, arg_5, arg_6)
    ctx.return_val[vphp.RequestOwnedZBox](res)
}
@[export: 'vphp_wrap_VSlimMcpApp_queue_log']
pub fn vphp_wrap_vslimmcpapp_queue_log(ctx vphp.Context)  {
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    arg_1 := ctx.arg[string](1)
    arg_2 := ctx.arg[string](2)
    arg_3 := ctx.arg_borrowed_zbox(3)
    arg_4 := ctx.arg[string](4)
    arg_5 := ctx.arg[string](5)
    arg_6 := ctx.arg[string](6)
    res := VSlimMcpApp.queue_log(arg_0, arg_1, arg_2, arg_3, arg_4, arg_5, arg_6)
    ctx.return_val[vphp.RequestOwnedZBox](res)
}
@[export: 'vphp_wrap_VSlimMcpApp_queue_sampling']
pub fn vphp_wrap_vslimmcpapp_queue_sampling(ctx vphp.Context)  {
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    arg_1 := ctx.arg_borrowed_zbox(1)
    arg_2 := ctx.arg_borrowed_zbox(2)
    arg_3 := ctx.arg[string](3)
    arg_4 := ctx.arg[string](4)
    arg_5 := ctx.arg_borrowed_zbox(5)
    arg_6 := ctx.arg[string](6)
    arg_7 := ctx.arg[int](7)
    res := VSlimMcpApp.queue_sampling(arg_0, arg_1, arg_2, arg_3, arg_4, arg_5, arg_6, arg_7)
    ctx.return_val[vphp.RequestOwnedZBox](res)
}
@[export: 'vphp_wrap_VSlimMcpApp_client_capabilities']
pub fn vphp_wrap_vslimmcpapp_client_capabilities(ctx vphp.Context)  {
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    res := VSlimMcpApp.client_capabilities(arg_0)
    ctx.return_val[vphp.RequestOwnedZBox](res)
}
@[export: 'vphp_wrap_VSlimMcpApp_client_supports']
pub fn vphp_wrap_vslimmcpapp_client_supports(ctx vphp.Context)  {
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    arg_1 := ctx.arg[string](1)
    res := VSlimMcpApp.client_supports(arg_0, arg_1)
    ctx.return_val[bool](res)
}
@[export: 'vphp_wrap_VSlimMcpApp_capability_error']
pub fn vphp_wrap_vslimmcpapp_capability_error(ctx vphp.Context)  {
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    arg_1 := ctx.arg[string](1)
    arg_2 := ctx.arg[int](2)
    res := VSlimMcpApp.capability_error(arg_0, arg_1, arg_2)
    ctx.return_val[vphp.RequestOwnedZBox](res)
}
@[export: 'vphp_wrap_VSlimMcpApp_require_capability']
pub fn vphp_wrap_vslimmcpapp_require_capability(ctx vphp.Context)  {
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    arg_1 := ctx.arg[string](1)
    arg_2 := ctx.arg[string](2)
    arg_3 := ctx.arg[int](3)
    res := VSlimMcpApp.require_capability(arg_0, arg_1, arg_2, arg_3)
    ctx.return_val[vphp.RequestOwnedZBox](res)
}
@[export: 'vphp_wrap_VSlimMcpApp_handle_mcp_dispatch']
pub fn vphp_wrap_vslimmcpapp_handle_mcp_dispatch(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimMcpApp(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    res := recv.handle_mcp_dispatch(arg_0)
    ctx.return_val[vphp.RequestOwnedZBox](res)
}
@[export: 'VSlimMcpApp_handlers']
pub fn vslimmcpapp_handlers() voidptr {
    return unsafe { &C.vphp_class_handlers{
        prop_handler:  voidptr(vslimmcpapp_get_prop)
        write_handler: voidptr(vslimmcpapp_set_prop)
        sync_handler:  voidptr(vslimmcpapp_sync_props)
        new_raw:       voidptr(vslimmcpapp_new_raw)
        cleanup_raw:   voidptr(vslimmcpapp_cleanup_raw)
        free_raw:      voidptr(vslimmcpapp_free_raw)
    } }
}

@[export: 'VSlimLogger_new_raw']
pub fn vslimlogger_new_raw() voidptr {
    return vphp.generic_new_raw[VSlimLogger]()
}
@[export: 'VSlimLogger_free_raw']
pub fn vslimlogger_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[VSlimLogger](ptr)
}
@[export: 'VSlimLogger_cleanup_raw']
pub fn vslimlogger_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
}
@[export: 'VSlimLogger_get_prop']
pub fn vslimlogger_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = rv
}
@[export: 'VSlimLogger_set_prop']
pub fn vslimlogger_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = value
}
@[export: 'VSlimLogger_sync_props']
pub fn vslimlogger_sync_props(ptr voidptr, zv &C.zval) {
    _ = ptr
    _ = zv
}
@[export: 'vphp_wrap_VSlimLogger_construct']
pub fn vphp_wrap_vslimlogger_construct(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLogger(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.construct()
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimLogger_disabled_level']
pub fn vphp_wrap_vslimlogger_disabled_level(ctx vphp.Context)  {
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := VSlimLogger.disabled_level()
    ctx.return_val[string](res)
}
@[export: 'vphp_wrap_VSlimLogger_fatal_level']
pub fn vphp_wrap_vslimlogger_fatal_level(ctx vphp.Context)  {
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := VSlimLogger.fatal_level()
    ctx.return_val[string](res)
}
@[export: 'vphp_wrap_VSlimLogger_error_level']
pub fn vphp_wrap_vslimlogger_error_level(ctx vphp.Context)  {
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := VSlimLogger.error_level()
    ctx.return_val[string](res)
}
@[export: 'vphp_wrap_VSlimLogger_warn_level']
pub fn vphp_wrap_vslimlogger_warn_level(ctx vphp.Context)  {
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := VSlimLogger.warn_level()
    ctx.return_val[string](res)
}
@[export: 'vphp_wrap_VSlimLogger_info_level']
pub fn vphp_wrap_vslimlogger_info_level(ctx vphp.Context)  {
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := VSlimLogger.info_level()
    ctx.return_val[string](res)
}
@[export: 'vphp_wrap_VSlimLogger_debug_level']
pub fn vphp_wrap_vslimlogger_debug_level(ctx vphp.Context)  {
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := VSlimLogger.debug_level()
    ctx.return_val[string](res)
}
@[export: 'vphp_wrap_VSlimLogger_set_level']
pub fn vphp_wrap_vslimlogger_set_level(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLogger(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    res := recv.set_level(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimLogger_level']
pub fn vphp_wrap_vslimlogger_level(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimLogger(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.level()
    ctx.return_val[string](res)
}
@[export: 'vphp_wrap_VSlimLogger_set_channel']
pub fn vphp_wrap_vslimlogger_set_channel(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLogger(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    res := recv.set_channel(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimLogger_channel']
pub fn vphp_wrap_vslimlogger_channel(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimLogger(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.channel()
    ctx.return_val[string](res)
}
@[export: 'vphp_wrap_VSlimLogger_set_context']
pub fn vphp_wrap_vslimlogger_set_context(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLogger(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    res := recv.set_context(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimLogger_context']
pub fn vphp_wrap_vslimlogger_context(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimLogger(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.context()
    ctx.return_val[map[string]string](res)
}
@[export: 'vphp_wrap_VSlimLogger_with_context']
pub fn vphp_wrap_vslimlogger_with_context(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLogger(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    arg_1 := ctx.arg[string](1)
    res := recv.with_context(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimLogger_clear_context']
pub fn vphp_wrap_vslimlogger_clear_context(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLogger(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.clear_context()
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimLogger_set_local_time']
pub fn vphp_wrap_vslimlogger_set_local_time(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLogger(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[bool](0)
    res := recv.set_local_time(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimLogger_set_short_tag']
pub fn vphp_wrap_vslimlogger_set_short_tag(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLogger(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[bool](0)
    res := recv.set_short_tag(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimLogger_set_output_file']
pub fn vphp_wrap_vslimlogger_set_output_file(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLogger(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    res := recv.set_output_file(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimLogger_output_file']
pub fn vphp_wrap_vslimlogger_output_file(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimLogger(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.output_file()
    ctx.return_val[string](res)
}
@[export: 'vphp_wrap_VSlimLogger_use_stdout']
pub fn vphp_wrap_vslimlogger_use_stdout(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLogger(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.use_stdout()
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimLogger_use_stderr']
pub fn vphp_wrap_vslimlogger_use_stderr(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLogger(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.use_stderr()
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimLogger_output_target']
pub fn vphp_wrap_vslimlogger_output_target(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimLogger(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.output_target()
    ctx.return_val[string](res)
}
@[export: 'vphp_wrap_VSlimLogger_log']
pub fn vphp_wrap_vslimlogger_log(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLogger(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    arg_1 := ctx.arg[string](1)
    res := recv.log(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimLogger_log_context']
pub fn vphp_wrap_vslimlogger_log_context(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLogger(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    arg_1 := ctx.arg[string](1)
    arg_2 := ctx.arg_borrowed_zbox(2)
    res := recv.log_context(arg_0, arg_1, arg_2)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimLogger_debug']
pub fn vphp_wrap_vslimlogger_debug(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLogger(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    res := recv.debug(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimLogger_debug_context']
pub fn vphp_wrap_vslimlogger_debug_context(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLogger(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    arg_1 := ctx.arg_borrowed_zbox(1)
    res := recv.debug_context(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimLogger_info']
pub fn vphp_wrap_vslimlogger_info(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLogger(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    res := recv.info(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimLogger_info_context']
pub fn vphp_wrap_vslimlogger_info_context(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLogger(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    arg_1 := ctx.arg_borrowed_zbox(1)
    res := recv.info_context(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimLogger_warn']
pub fn vphp_wrap_vslimlogger_warn(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLogger(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    res := recv.warn(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimLogger_warn_context']
pub fn vphp_wrap_vslimlogger_warn_context(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLogger(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    arg_1 := ctx.arg_borrowed_zbox(1)
    res := recv.warn_context(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimLogger_error']
pub fn vphp_wrap_vslimlogger_error(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLogger(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    res := recv.error(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimLogger_error_context']
pub fn vphp_wrap_vslimlogger_error_context(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLogger(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    arg_1 := ctx.arg_borrowed_zbox(1)
    res := recv.error_context(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimLogger_warning']
pub fn vphp_wrap_vslimlogger_warning(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLogger(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    res := recv.warning(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimLogger_warning_context']
pub fn vphp_wrap_vslimlogger_warning_context(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLogger(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    arg_1 := ctx.arg_borrowed_zbox(1)
    res := recv.warning_context(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimLogger_notice']
pub fn vphp_wrap_vslimlogger_notice(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLogger(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    res := recv.notice(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimLogger_notice_context']
pub fn vphp_wrap_vslimlogger_notice_context(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLogger(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    arg_1 := ctx.arg_borrowed_zbox(1)
    res := recv.notice_context(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimLogger_critical']
pub fn vphp_wrap_vslimlogger_critical(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLogger(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    res := recv.critical(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimLogger_critical_context']
pub fn vphp_wrap_vslimlogger_critical_context(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLogger(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    arg_1 := ctx.arg_borrowed_zbox(1)
    res := recv.critical_context(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimLogger_alert']
pub fn vphp_wrap_vslimlogger_alert(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLogger(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    res := recv.alert(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimLogger_alert_context']
pub fn vphp_wrap_vslimlogger_alert_context(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLogger(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    arg_1 := ctx.arg_borrowed_zbox(1)
    res := recv.alert_context(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimLogger_emergency']
pub fn vphp_wrap_vslimlogger_emergency(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLogger(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    res := recv.emergency(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimLogger_emergency_context']
pub fn vphp_wrap_vslimlogger_emergency_context(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLogger(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    arg_1 := ctx.arg_borrowed_zbox(1)
    res := recv.emergency_context(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimLogger_str']
pub fn vphp_wrap_vslimlogger_str(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimLogger(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.str()
    ctx.return_val[string](res)
}
@[export: 'VSlimLogger_handlers']
pub fn vslimlogger_handlers() voidptr {
    return unsafe { &C.vphp_class_handlers{
        prop_handler:  voidptr(vslimlogger_get_prop)
        write_handler: voidptr(vslimlogger_set_prop)
        sync_handler:  voidptr(vslimlogger_sync_props)
        new_raw:       voidptr(vslimlogger_new_raw)
        cleanup_raw:   voidptr(vslimlogger_cleanup_raw)
        free_raw:      voidptr(vslimlogger_free_raw)
    } }
}

@[export: 'VSlimPsrLogger_new_raw']
pub fn vslimpsrlogger_new_raw() voidptr {
    return vphp.generic_new_raw[VSlimPsrLogger]()
}
@[export: 'VSlimPsrLogger_free_raw']
pub fn vslimpsrlogger_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[VSlimPsrLogger](ptr)
}
@[export: 'VSlimPsrLogger_cleanup_raw']
pub fn vslimpsrlogger_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
}
@[export: 'VSlimPsrLogger_get_prop']
pub fn vslimpsrlogger_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = rv
}
@[export: 'VSlimPsrLogger_set_prop']
pub fn vslimpsrlogger_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = value
}
@[export: 'VSlimPsrLogger_sync_props']
pub fn vslimpsrlogger_sync_props(ptr voidptr, zv &C.zval) {
    _ = ptr
    _ = zv
}
@[export: 'vphp_wrap_VSlimPsrLogger_construct']
pub fn vphp_wrap_vslimpsrlogger_construct(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsrLogger(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.construct()
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimPsrLogger_set_logger']
pub fn vphp_wrap_vslimpsrlogger_set_logger(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsrLogger(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := unsafe { &VSlimLogger(ctx.arg_raw_obj(0)) }
    res := recv.set_logger(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimPsrLogger_logger']
pub fn vphp_wrap_vslimpsrlogger_logger(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsrLogger(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.logger()
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimPsrLogger_set_level']
pub fn vphp_wrap_vslimpsrlogger_set_level(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsrLogger(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    res := recv.set_level(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimPsrLogger_set_channel']
pub fn vphp_wrap_vslimpsrlogger_set_channel(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsrLogger(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    res := recv.set_channel(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimPsrLogger_set_context']
pub fn vphp_wrap_vslimpsrlogger_set_context(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsrLogger(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    res := recv.set_context(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimPsrLogger_with_context']
pub fn vphp_wrap_vslimpsrlogger_with_context(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsrLogger(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    arg_1 := ctx.arg[string](1)
    res := recv.with_context(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimPsrLogger_clear_context']
pub fn vphp_wrap_vslimpsrlogger_clear_context(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsrLogger(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.clear_context()
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimPsrLogger_set_output_file']
pub fn vphp_wrap_vslimpsrlogger_set_output_file(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsrLogger(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    res := recv.set_output_file(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimPsrLogger_use_stdout']
pub fn vphp_wrap_vslimpsrlogger_use_stdout(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsrLogger(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.use_stdout()
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimPsrLogger_use_stderr']
pub fn vphp_wrap_vslimpsrlogger_use_stderr(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsrLogger(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.use_stderr()
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimPsrLogger_log']
pub fn vphp_wrap_vslimpsrlogger_log(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsrLogger(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    arg_1 := ctx.arg_borrowed_zbox(1)
    arg_2 := ctx.arg_borrowed_zbox(2)
    recv.log(arg_0, arg_1, arg_2)
}
@[export: 'vphp_wrap_VSlimPsrLogger_emergency']
pub fn vphp_wrap_vslimpsrlogger_emergency(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsrLogger(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    arg_1 := ctx.arg_borrowed_zbox(1)
    recv.emergency(arg_0, arg_1)
}
@[export: 'vphp_wrap_VSlimPsrLogger_alert']
pub fn vphp_wrap_vslimpsrlogger_alert(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsrLogger(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    arg_1 := ctx.arg_borrowed_zbox(1)
    recv.alert(arg_0, arg_1)
}
@[export: 'vphp_wrap_VSlimPsrLogger_critical']
pub fn vphp_wrap_vslimpsrlogger_critical(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsrLogger(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    arg_1 := ctx.arg_borrowed_zbox(1)
    recv.critical(arg_0, arg_1)
}
@[export: 'vphp_wrap_VSlimPsrLogger_error']
pub fn vphp_wrap_vslimpsrlogger_error(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsrLogger(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    arg_1 := ctx.arg_borrowed_zbox(1)
    recv.error(arg_0, arg_1)
}
@[export: 'vphp_wrap_VSlimPsrLogger_warning']
pub fn vphp_wrap_vslimpsrlogger_warning(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsrLogger(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    arg_1 := ctx.arg_borrowed_zbox(1)
    recv.warning(arg_0, arg_1)
}
@[export: 'vphp_wrap_VSlimPsrLogger_notice']
pub fn vphp_wrap_vslimpsrlogger_notice(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsrLogger(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    arg_1 := ctx.arg_borrowed_zbox(1)
    recv.notice(arg_0, arg_1)
}
@[export: 'vphp_wrap_VSlimPsrLogger_info']
pub fn vphp_wrap_vslimpsrlogger_info(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsrLogger(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    arg_1 := ctx.arg_borrowed_zbox(1)
    recv.info(arg_0, arg_1)
}
@[export: 'vphp_wrap_VSlimPsrLogger_debug']
pub fn vphp_wrap_vslimpsrlogger_debug(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsrLogger(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    arg_1 := ctx.arg_borrowed_zbox(1)
    recv.debug(arg_0, arg_1)
}
@[export: 'vphp_wrap_VSlimPsrLogger_str']
pub fn vphp_wrap_vslimpsrlogger_str(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsrLogger(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.str()
    ctx.return_val[string](res)
}
@[export: 'VSlimPsrLogger_handlers']
pub fn vslimpsrlogger_handlers() voidptr {
    return unsafe { &C.vphp_class_handlers{
        prop_handler:  voidptr(vslimpsrlogger_get_prop)
        write_handler: voidptr(vslimpsrlogger_set_prop)
        sync_handler:  voidptr(vslimpsrlogger_sync_props)
        new_raw:       voidptr(vslimpsrlogger_new_raw)
        cleanup_raw:   voidptr(vslimpsrlogger_cleanup_raw)
        free_raw:      voidptr(vslimpsrlogger_free_raw)
    } }
}

@[export: 'VSlimLogLevel_new_raw']
pub fn vslimloglevel_new_raw() voidptr {
    return vphp.generic_new_raw[VSlimLogLevel]()
}
@[export: 'VSlimLogLevel_free_raw']
pub fn vslimloglevel_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[VSlimLogLevel](ptr)
}
@[export: 'VSlimLogLevel_cleanup_raw']
pub fn vslimloglevel_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
}
@[export: 'VSlimLogLevel_get_prop']
pub fn vslimloglevel_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = rv
}
@[export: 'VSlimLogLevel_set_prop']
pub fn vslimloglevel_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = value
}
@[export: 'VSlimLogLevel_sync_props']
pub fn vslimloglevel_sync_props(ptr voidptr, zv &C.zval) {
    _ = ptr
    _ = zv
}
pub fn VSlimLogLevel.consts() VSlimLogLevelConsts {
    return vslim_log_level_consts
}
@[export: 'vphp_wrap_VSlimLogLevel_disabled']
pub fn vphp_wrap_vslimloglevel_disabled(ctx vphp.Context)  {
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := VSlimLogLevel.disabled()
    ctx.return_val[string](res)
}
@[export: 'vphp_wrap_VSlimLogLevel_fatal']
pub fn vphp_wrap_vslimloglevel_fatal(ctx vphp.Context)  {
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := VSlimLogLevel.fatal()
    ctx.return_val[string](res)
}
@[export: 'vphp_wrap_VSlimLogLevel_error']
pub fn vphp_wrap_vslimloglevel_error(ctx vphp.Context)  {
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := VSlimLogLevel.error()
    ctx.return_val[string](res)
}
@[export: 'vphp_wrap_VSlimLogLevel_warn']
pub fn vphp_wrap_vslimloglevel_warn(ctx vphp.Context)  {
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := VSlimLogLevel.warn()
    ctx.return_val[string](res)
}
@[export: 'vphp_wrap_VSlimLogLevel_info']
pub fn vphp_wrap_vslimloglevel_info(ctx vphp.Context)  {
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := VSlimLogLevel.info()
    ctx.return_val[string](res)
}
@[export: 'vphp_wrap_VSlimLogLevel_debug']
pub fn vphp_wrap_vslimloglevel_debug(ctx vphp.Context)  {
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := VSlimLogLevel.debug()
    ctx.return_val[string](res)
}
@[export: 'vphp_wrap_VSlimLogLevel_all']
pub fn vphp_wrap_vslimloglevel_all(ctx vphp.Context)  {
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := VSlimLogLevel.all()
    ctx.return_val[map[string]string](res)
}
@[export: 'VSlimLogLevel_handlers']
pub fn vslimloglevel_handlers() voidptr {
    return unsafe { &C.vphp_class_handlers{
        prop_handler:  voidptr(vslimloglevel_get_prop)
        write_handler: voidptr(vslimloglevel_set_prop)
        sync_handler:  voidptr(vslimloglevel_sync_props)
        new_raw:       voidptr(vslimloglevel_new_raw)
        cleanup_raw:   voidptr(vslimloglevel_cleanup_raw)
        free_raw:      voidptr(vslimloglevel_free_raw)
    } }
}

@[export: 'VSlimPsr7Stream_new_raw']
pub fn vslimpsr7stream_new_raw() voidptr {
    return vphp.generic_new_raw[VSlimPsr7Stream]()
}
@[export: 'VSlimPsr7Stream_free_raw']
pub fn vslimpsr7stream_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[VSlimPsr7Stream](ptr)
}
@[export: 'VSlimPsr7Stream_cleanup_raw']
pub fn vslimpsr7stream_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
}
@[export: 'VSlimPsr7Stream_get_prop']
pub fn vslimpsr7stream_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = rv
}
@[export: 'VSlimPsr7Stream_set_prop']
pub fn vslimpsr7stream_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = value
}
@[export: 'VSlimPsr7Stream_sync_props']
pub fn vslimpsr7stream_sync_props(ptr voidptr, zv &C.zval) {
    _ = ptr
    _ = zv
}
@[export: 'vphp_wrap_VSlimPsr7Stream_construct']
pub fn vphp_wrap_vslimpsr7stream_construct(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsr7Stream(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    res := recv.construct(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimPsr7Stream_str']
pub fn vphp_wrap_vslimpsr7stream_str(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsr7Stream(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.str()
    ctx.return_val[string](res)
}
@[export: 'vphp_wrap_VSlimPsr7Stream_close']
pub fn vphp_wrap_vslimpsr7stream_close(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsr7Stream(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    recv.close()
}
@[export: 'vphp_wrap_VSlimPsr7Stream_detach']
pub fn vphp_wrap_vslimpsr7stream_detach(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsr7Stream(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.detach()
    ctx.return_val[vphp.RequestOwnedZBox](res)
}
@[export: 'vphp_wrap_VSlimPsr7Stream_get_size']
pub fn vphp_wrap_vslimpsr7stream_get_size(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsr7Stream(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    vphp.call_or_null_val[int](fn [recv] () ?int {
        return recv.get_size()
    }, ctx)
}
@[export: 'vphp_wrap_VSlimPsr7Stream_tell']
pub fn vphp_wrap_vslimpsr7stream_tell(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsr7Stream(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.tell()
    ctx.return_val[int](res)
}
@[export: 'vphp_wrap_VSlimPsr7Stream_eof']
pub fn vphp_wrap_vslimpsr7stream_eof(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsr7Stream(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.eof()
    ctx.return_val[bool](res)
}
@[export: 'vphp_wrap_VSlimPsr7Stream_is_seekable']
pub fn vphp_wrap_vslimpsr7stream_is_seekable(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsr7Stream(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.is_seekable()
    ctx.return_val[bool](res)
}
@[export: 'vphp_wrap_VSlimPsr7Stream_seek']
pub fn vphp_wrap_vslimpsr7stream_seek(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsr7Stream(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    arg_1 := ctx.arg_borrowed_zbox(1)
    recv.seek(arg_0, arg_1)
}
@[export: 'vphp_wrap_VSlimPsr7Stream_rewind']
pub fn vphp_wrap_vslimpsr7stream_rewind(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsr7Stream(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    recv.rewind()
}
@[export: 'vphp_wrap_VSlimPsr7Stream_is_writable']
pub fn vphp_wrap_vslimpsr7stream_is_writable(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsr7Stream(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.is_writable()
    ctx.return_val[bool](res)
}
@[export: 'vphp_wrap_VSlimPsr7Stream_write']
pub fn vphp_wrap_vslimpsr7stream_write(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsr7Stream(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    res := recv.write(arg_0)
    ctx.return_val[int](res)
}
@[export: 'vphp_wrap_VSlimPsr7Stream_is_readable']
pub fn vphp_wrap_vslimpsr7stream_is_readable(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsr7Stream(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.is_readable()
    ctx.return_val[bool](res)
}
@[export: 'vphp_wrap_VSlimPsr7Stream_read']
pub fn vphp_wrap_vslimpsr7stream_read(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsr7Stream(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    res := recv.read(arg_0)
    ctx.return_val[string](res)
}
@[export: 'vphp_wrap_VSlimPsr7Stream_get_contents']
pub fn vphp_wrap_vslimpsr7stream_get_contents(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsr7Stream(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.get_contents()
    ctx.return_val[string](res)
}
@[export: 'vphp_wrap_VSlimPsr7Stream_get_metadata']
pub fn vphp_wrap_vslimpsr7stream_get_metadata(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsr7Stream(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    res := recv.get_metadata(arg_0)
    ctx.return_val[vphp.RequestOwnedZBox](res)
}
@[export: 'VSlimPsr7Stream_handlers']
pub fn vslimpsr7stream_handlers() voidptr {
    return unsafe { &C.vphp_class_handlers{
        prop_handler:  voidptr(vslimpsr7stream_get_prop)
        write_handler: voidptr(vslimpsr7stream_set_prop)
        sync_handler:  voidptr(vslimpsr7stream_sync_props)
        new_raw:       voidptr(vslimpsr7stream_new_raw)
        cleanup_raw:   voidptr(vslimpsr7stream_cleanup_raw)
        free_raw:      voidptr(vslimpsr7stream_free_raw)
    } }
}

@[export: 'VSlimPsr7UploadedFile_new_raw']
pub fn vslimpsr7uploadedfile_new_raw() voidptr {
    return vphp.generic_new_raw[VSlimPsr7UploadedFile]()
}
@[export: 'VSlimPsr7UploadedFile_free_raw']
pub fn vslimpsr7uploadedfile_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[VSlimPsr7UploadedFile](ptr)
}
@[export: 'VSlimPsr7UploadedFile_cleanup_raw']
pub fn vslimpsr7uploadedfile_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
}
@[export: 'VSlimPsr7UploadedFile_get_prop']
pub fn vslimpsr7uploadedfile_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = rv
}
@[export: 'VSlimPsr7UploadedFile_set_prop']
pub fn vslimpsr7uploadedfile_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = value
}
@[export: 'VSlimPsr7UploadedFile_sync_props']
pub fn vslimpsr7uploadedfile_sync_props(ptr voidptr, zv &C.zval) {
    _ = ptr
    _ = zv
}
@[export: 'vphp_wrap_VSlimPsr7UploadedFile_construct']
pub fn vphp_wrap_vslimpsr7uploadedfile_construct(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsr7UploadedFile(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    arg_1 := ctx.arg_opt[int](1)
    arg_2 := ctx.arg[int](2)
    arg_3 := ctx.arg_opt[string](3)
    arg_4 := ctx.arg_opt[string](4)
    res := recv.construct(arg_0, arg_1, arg_2, arg_3, arg_4)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimPsr7UploadedFile_get_stream']
pub fn vphp_wrap_vslimpsr7uploadedfile_get_stream(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsr7UploadedFile(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.get_stream()
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimPsr7UploadedFile_move_to']
pub fn vphp_wrap_vslimpsr7uploadedfile_move_to(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsr7UploadedFile(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    recv.move_to(arg_0)
}
@[export: 'vphp_wrap_VSlimPsr7UploadedFile_get_size']
pub fn vphp_wrap_vslimpsr7uploadedfile_get_size(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsr7UploadedFile(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    vphp.call_or_null_val[int](fn [recv] () ?int {
        return recv.get_size()
    }, ctx)
}
@[export: 'vphp_wrap_VSlimPsr7UploadedFile_get_error']
pub fn vphp_wrap_vslimpsr7uploadedfile_get_error(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsr7UploadedFile(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.get_error()
    ctx.return_val[int](res)
}
@[export: 'vphp_wrap_VSlimPsr7UploadedFile_get_client_filename']
pub fn vphp_wrap_vslimpsr7uploadedfile_get_client_filename(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsr7UploadedFile(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    vphp.call_or_null_val[string](fn [recv] () ?string {
        return recv.get_client_filename()
    }, ctx)
}
@[export: 'vphp_wrap_VSlimPsr7UploadedFile_get_client_media_type']
pub fn vphp_wrap_vslimpsr7uploadedfile_get_client_media_type(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsr7UploadedFile(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    vphp.call_or_null_val[string](fn [recv] () ?string {
        return recv.get_client_media_type()
    }, ctx)
}
@[export: 'vphp_wrap_VSlimPsr7UploadedFile_str']
pub fn vphp_wrap_vslimpsr7uploadedfile_str(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsr7UploadedFile(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.str()
    ctx.return_val[string](res)
}
@[export: 'VSlimPsr7UploadedFile_handlers']
pub fn vslimpsr7uploadedfile_handlers() voidptr {
    return unsafe { &C.vphp_class_handlers{
        prop_handler:  voidptr(vslimpsr7uploadedfile_get_prop)
        write_handler: voidptr(vslimpsr7uploadedfile_set_prop)
        sync_handler:  voidptr(vslimpsr7uploadedfile_sync_props)
        new_raw:       voidptr(vslimpsr7uploadedfile_new_raw)
        cleanup_raw:   voidptr(vslimpsr7uploadedfile_cleanup_raw)
        free_raw:      voidptr(vslimpsr7uploadedfile_free_raw)
    } }
}

@[export: 'VSlimPsr7Response_new_raw']
pub fn vslimpsr7response_new_raw() voidptr {
    return vphp.generic_new_raw[VSlimPsr7Response]()
}
@[export: 'VSlimPsr7Response_free_raw']
pub fn vslimpsr7response_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[VSlimPsr7Response](ptr)
}
@[export: 'VSlimPsr7Response_cleanup_raw']
pub fn vslimpsr7response_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
}
@[export: 'VSlimPsr7Response_get_prop']
pub fn vslimpsr7response_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = rv
}
@[export: 'VSlimPsr7Response_set_prop']
pub fn vslimpsr7response_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = value
}
@[export: 'VSlimPsr7Response_sync_props']
pub fn vslimpsr7response_sync_props(ptr voidptr, zv &C.zval) {
    _ = ptr
    _ = zv
}
@[export: 'vphp_wrap_VSlimPsr7Response_construct']
pub fn vphp_wrap_vslimpsr7response_construct(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsr7Response(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[int](0)
    arg_1 := ctx.arg[string](1)
    res := recv.construct(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimPsr7Response_get_protocol_version']
pub fn vphp_wrap_vslimpsr7response_get_protocol_version(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsr7Response(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.get_protocol_version()
    ctx.return_val[string](res)
}
@[export: 'vphp_wrap_VSlimPsr7Response_with_protocol_version']
pub fn vphp_wrap_vslimpsr7response_with_protocol_version(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsr7Response(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    res := recv.with_protocol_version(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimPsr7Response_get_headers']
pub fn vphp_wrap_vslimpsr7response_get_headers(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsr7Response(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.get_headers()
    ctx.return_val[map[string][]string](res)
}
@[export: 'vphp_wrap_VSlimPsr7Response_has_header']
pub fn vphp_wrap_vslimpsr7response_has_header(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsr7Response(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    res := recv.has_header(arg_0)
    ctx.return_val[bool](res)
}
@[export: 'vphp_wrap_VSlimPsr7Response_get_header']
pub fn vphp_wrap_vslimpsr7response_get_header(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsr7Response(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    res := recv.get_header(arg_0)
    ctx.return_val[[]string](res)
}
@[export: 'vphp_wrap_VSlimPsr7Response_get_header_line']
pub fn vphp_wrap_vslimpsr7response_get_header_line(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsr7Response(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    res := recv.get_header_line(arg_0)
    ctx.return_val[string](res)
}
@[export: 'vphp_wrap_VSlimPsr7Response_with_header']
pub fn vphp_wrap_vslimpsr7response_with_header(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsr7Response(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    arg_1 := ctx.arg_borrowed_zbox(1)
    res := recv.with_header(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimPsr7Response_with_added_header']
pub fn vphp_wrap_vslimpsr7response_with_added_header(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsr7Response(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    arg_1 := ctx.arg_borrowed_zbox(1)
    res := recv.with_added_header(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimPsr7Response_without_header']
pub fn vphp_wrap_vslimpsr7response_without_header(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsr7Response(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    res := recv.without_header(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimPsr7Response_get_body']
pub fn vphp_wrap_vslimpsr7response_get_body(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsr7Response(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.get_body()
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimPsr7Response_with_body']
pub fn vphp_wrap_vslimpsr7response_with_body(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsr7Response(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    res := recv.with_body(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimPsr7Response_get_status_code']
pub fn vphp_wrap_vslimpsr7response_get_status_code(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsr7Response(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.get_status_code()
    ctx.return_val[int](res)
}
@[export: 'vphp_wrap_VSlimPsr7Response_with_status']
pub fn vphp_wrap_vslimpsr7response_with_status(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsr7Response(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    arg_1 := ctx.arg_borrowed_zbox(1)
    res := recv.with_status(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimPsr7Response_get_reason_phrase']
pub fn vphp_wrap_vslimpsr7response_get_reason_phrase(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsr7Response(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.get_reason_phrase()
    ctx.return_val[string](res)
}
@[export: 'vphp_wrap_VSlimPsr7Response_str']
pub fn vphp_wrap_vslimpsr7response_str(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsr7Response(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.str()
    ctx.return_val[string](res)
}
@[export: 'VSlimPsr7Response_handlers']
pub fn vslimpsr7response_handlers() voidptr {
    return unsafe { &C.vphp_class_handlers{
        prop_handler:  voidptr(vslimpsr7response_get_prop)
        write_handler: voidptr(vslimpsr7response_set_prop)
        sync_handler:  voidptr(vslimpsr7response_sync_props)
        new_raw:       voidptr(vslimpsr7response_new_raw)
        cleanup_raw:   voidptr(vslimpsr7response_cleanup_raw)
        free_raw:      voidptr(vslimpsr7response_free_raw)
    } }
}

@[export: 'VSlimPsr7Uri_new_raw']
pub fn vslimpsr7uri_new_raw() voidptr {
    return vphp.generic_new_raw[VSlimPsr7Uri]()
}
@[export: 'VSlimPsr7Uri_free_raw']
pub fn vslimpsr7uri_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[VSlimPsr7Uri](ptr)
}
@[export: 'VSlimPsr7Uri_cleanup_raw']
pub fn vslimpsr7uri_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
}
@[export: 'VSlimPsr7Uri_get_prop']
pub fn vslimpsr7uri_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = rv
}
@[export: 'VSlimPsr7Uri_set_prop']
pub fn vslimpsr7uri_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = value
}
@[export: 'VSlimPsr7Uri_sync_props']
pub fn vslimpsr7uri_sync_props(ptr voidptr, zv &C.zval) {
    _ = ptr
    _ = zv
}
@[export: 'vphp_wrap_VSlimPsr7Uri_construct']
pub fn vphp_wrap_vslimpsr7uri_construct(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsr7Uri(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    res := recv.construct(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimPsr7Uri_str']
pub fn vphp_wrap_vslimpsr7uri_str(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsr7Uri(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.str()
    ctx.return_val[string](res)
}
@[export: 'vphp_wrap_VSlimPsr7Uri_get_scheme']
pub fn vphp_wrap_vslimpsr7uri_get_scheme(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsr7Uri(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.get_scheme()
    ctx.return_val[string](res)
}
@[export: 'vphp_wrap_VSlimPsr7Uri_get_authority']
pub fn vphp_wrap_vslimpsr7uri_get_authority(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsr7Uri(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.get_authority()
    ctx.return_val[string](res)
}
@[export: 'vphp_wrap_VSlimPsr7Uri_get_user_info']
pub fn vphp_wrap_vslimpsr7uri_get_user_info(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsr7Uri(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.get_user_info()
    ctx.return_val[string](res)
}
@[export: 'vphp_wrap_VSlimPsr7Uri_get_host']
pub fn vphp_wrap_vslimpsr7uri_get_host(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsr7Uri(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.get_host()
    ctx.return_val[string](res)
}
@[export: 'vphp_wrap_VSlimPsr7Uri_get_port']
pub fn vphp_wrap_vslimpsr7uri_get_port(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsr7Uri(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    vphp.call_or_null_val[int](fn [recv] () ?int {
        return recv.get_port()
    }, ctx)
}
@[export: 'vphp_wrap_VSlimPsr7Uri_get_path']
pub fn vphp_wrap_vslimpsr7uri_get_path(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsr7Uri(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.get_path()
    ctx.return_val[string](res)
}
@[export: 'vphp_wrap_VSlimPsr7Uri_get_query']
pub fn vphp_wrap_vslimpsr7uri_get_query(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsr7Uri(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.get_query()
    ctx.return_val[string](res)
}
@[export: 'vphp_wrap_VSlimPsr7Uri_get_fragment']
pub fn vphp_wrap_vslimpsr7uri_get_fragment(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsr7Uri(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.get_fragment()
    ctx.return_val[string](res)
}
@[export: 'vphp_wrap_VSlimPsr7Uri_with_scheme']
pub fn vphp_wrap_vslimpsr7uri_with_scheme(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsr7Uri(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    res := recv.with_scheme(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimPsr7Uri_with_user_info']
pub fn vphp_wrap_vslimpsr7uri_with_user_info(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsr7Uri(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    arg_1 := ctx.arg_borrowed_zbox(1)
    res := recv.with_user_info(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimPsr7Uri_with_host']
pub fn vphp_wrap_vslimpsr7uri_with_host(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsr7Uri(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    res := recv.with_host(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimPsr7Uri_with_port']
pub fn vphp_wrap_vslimpsr7uri_with_port(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsr7Uri(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    res := recv.with_port(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimPsr7Uri_with_path']
pub fn vphp_wrap_vslimpsr7uri_with_path(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsr7Uri(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    res := recv.with_path(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimPsr7Uri_with_query']
pub fn vphp_wrap_vslimpsr7uri_with_query(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsr7Uri(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    res := recv.with_query(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimPsr7Uri_with_fragment']
pub fn vphp_wrap_vslimpsr7uri_with_fragment(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsr7Uri(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    res := recv.with_fragment(arg_0)
    return voidptr(res)
}
@[export: 'VSlimPsr7Uri_handlers']
pub fn vslimpsr7uri_handlers() voidptr {
    return unsafe { &C.vphp_class_handlers{
        prop_handler:  voidptr(vslimpsr7uri_get_prop)
        write_handler: voidptr(vslimpsr7uri_set_prop)
        sync_handler:  voidptr(vslimpsr7uri_sync_props)
        new_raw:       voidptr(vslimpsr7uri_new_raw)
        cleanup_raw:   voidptr(vslimpsr7uri_cleanup_raw)
        free_raw:      voidptr(vslimpsr7uri_free_raw)
    } }
}

@[export: 'VSlimPsr7Request_new_raw']
pub fn vslimpsr7request_new_raw() voidptr {
    return vphp.generic_new_raw[VSlimPsr7Request]()
}
@[export: 'VSlimPsr7Request_free_raw']
pub fn vslimpsr7request_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[VSlimPsr7Request](ptr)
}
@[export: 'VSlimPsr7Request_cleanup_raw']
pub fn vslimpsr7request_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
}
@[export: 'VSlimPsr7Request_get_prop']
pub fn vslimpsr7request_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = rv
}
@[export: 'VSlimPsr7Request_set_prop']
pub fn vslimpsr7request_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = value
}
@[export: 'VSlimPsr7Request_sync_props']
pub fn vslimpsr7request_sync_props(ptr voidptr, zv &C.zval) {
    _ = ptr
    _ = zv
}
@[export: 'vphp_wrap_VSlimPsr7Request_construct']
pub fn vphp_wrap_vslimpsr7request_construct(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsr7Request(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.construct()
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimPsr7Request_get_protocol_version']
pub fn vphp_wrap_vslimpsr7request_get_protocol_version(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsr7Request(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.get_protocol_version()
    ctx.return_val[string](res)
}
@[export: 'vphp_wrap_VSlimPsr7Request_with_protocol_version']
pub fn vphp_wrap_vslimpsr7request_with_protocol_version(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsr7Request(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    res := recv.with_protocol_version(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimPsr7Request_get_headers']
pub fn vphp_wrap_vslimpsr7request_get_headers(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsr7Request(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.get_headers()
    ctx.return_val[map[string][]string](res)
}
@[export: 'vphp_wrap_VSlimPsr7Request_has_header']
pub fn vphp_wrap_vslimpsr7request_has_header(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsr7Request(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    res := recv.has_header(arg_0)
    ctx.return_val[bool](res)
}
@[export: 'vphp_wrap_VSlimPsr7Request_get_header']
pub fn vphp_wrap_vslimpsr7request_get_header(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsr7Request(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    res := recv.get_header(arg_0)
    ctx.return_val[[]string](res)
}
@[export: 'vphp_wrap_VSlimPsr7Request_get_header_line']
pub fn vphp_wrap_vslimpsr7request_get_header_line(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsr7Request(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    res := recv.get_header_line(arg_0)
    ctx.return_val[string](res)
}
@[export: 'vphp_wrap_VSlimPsr7Request_with_header']
pub fn vphp_wrap_vslimpsr7request_with_header(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsr7Request(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    arg_1 := ctx.arg_borrowed_zbox(1)
    res := recv.with_header(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimPsr7Request_with_added_header']
pub fn vphp_wrap_vslimpsr7request_with_added_header(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsr7Request(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    arg_1 := ctx.arg_borrowed_zbox(1)
    res := recv.with_added_header(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimPsr7Request_without_header']
pub fn vphp_wrap_vslimpsr7request_without_header(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsr7Request(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    res := recv.without_header(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimPsr7Request_get_body']
pub fn vphp_wrap_vslimpsr7request_get_body(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsr7Request(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.get_body()
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimPsr7Request_with_body']
pub fn vphp_wrap_vslimpsr7request_with_body(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsr7Request(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    res := recv.with_body(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimPsr7Request_get_request_target']
pub fn vphp_wrap_vslimpsr7request_get_request_target(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsr7Request(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.get_request_target()
    ctx.return_val[string](res)
}
@[export: 'vphp_wrap_VSlimPsr7Request_with_request_target']
pub fn vphp_wrap_vslimpsr7request_with_request_target(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsr7Request(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    res := recv.with_request_target(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimPsr7Request_get_method']
pub fn vphp_wrap_vslimpsr7request_get_method(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsr7Request(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.get_method()
    ctx.return_val[string](res)
}
@[export: 'vphp_wrap_VSlimPsr7Request_with_method']
pub fn vphp_wrap_vslimpsr7request_with_method(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsr7Request(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    res := recv.with_method(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimPsr7Request_get_uri']
pub fn vphp_wrap_vslimpsr7request_get_uri(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsr7Request(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.get_uri()
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimPsr7Request_with_uri']
pub fn vphp_wrap_vslimpsr7request_with_uri(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsr7Request(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    arg_1 := ctx.arg_borrowed_zbox(1)
    res := recv.with_uri(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimPsr7Request_str']
pub fn vphp_wrap_vslimpsr7request_str(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsr7Request(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.str()
    ctx.return_val[string](res)
}
@[export: 'VSlimPsr7Request_handlers']
pub fn vslimpsr7request_handlers() voidptr {
    return unsafe { &C.vphp_class_handlers{
        prop_handler:  voidptr(vslimpsr7request_get_prop)
        write_handler: voidptr(vslimpsr7request_set_prop)
        sync_handler:  voidptr(vslimpsr7request_sync_props)
        new_raw:       voidptr(vslimpsr7request_new_raw)
        cleanup_raw:   voidptr(vslimpsr7request_cleanup_raw)
        free_raw:      voidptr(vslimpsr7request_free_raw)
    } }
}

@[export: 'VSlimPsr7ServerRequest_new_raw']
pub fn vslimpsr7serverrequest_new_raw() voidptr {
    return vphp.generic_new_raw[VSlimPsr7ServerRequest]()
}
@[export: 'VSlimPsr7ServerRequest_free_raw']
pub fn vslimpsr7serverrequest_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[VSlimPsr7ServerRequest](ptr)
}
@[export: 'VSlimPsr7ServerRequest_cleanup_raw']
pub fn vslimpsr7serverrequest_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    unsafe {
        mut obj := &VSlimPsr7ServerRequest(ptr)
        obj.free()
    }
}
@[export: 'VSlimPsr7ServerRequest_get_prop']
pub fn vslimpsr7serverrequest_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = rv
}
@[export: 'VSlimPsr7ServerRequest_set_prop']
pub fn vslimpsr7serverrequest_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = value
}
@[export: 'VSlimPsr7ServerRequest_sync_props']
pub fn vslimpsr7serverrequest_sync_props(ptr voidptr, zv &C.zval) {
    _ = ptr
    _ = zv
}
@[export: 'vphp_wrap_VSlimPsr7ServerRequest_construct']
pub fn vphp_wrap_vslimpsr7serverrequest_construct(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsr7ServerRequest(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.construct()
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimPsr7ServerRequest_get_protocol_version']
pub fn vphp_wrap_vslimpsr7serverrequest_get_protocol_version(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsr7ServerRequest(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.get_protocol_version()
    ctx.return_val[string](res)
}
@[export: 'vphp_wrap_VSlimPsr7ServerRequest_with_protocol_version']
pub fn vphp_wrap_vslimpsr7serverrequest_with_protocol_version(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsr7ServerRequest(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    res := recv.with_protocol_version(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimPsr7ServerRequest_get_headers']
pub fn vphp_wrap_vslimpsr7serverrequest_get_headers(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsr7ServerRequest(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.get_headers()
    ctx.return_val[map[string][]string](res)
}
@[export: 'vphp_wrap_VSlimPsr7ServerRequest_has_header']
pub fn vphp_wrap_vslimpsr7serverrequest_has_header(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsr7ServerRequest(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    res := recv.has_header(arg_0)
    ctx.return_val[bool](res)
}
@[export: 'vphp_wrap_VSlimPsr7ServerRequest_get_header']
pub fn vphp_wrap_vslimpsr7serverrequest_get_header(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsr7ServerRequest(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    res := recv.get_header(arg_0)
    ctx.return_val[[]string](res)
}
@[export: 'vphp_wrap_VSlimPsr7ServerRequest_get_header_line']
pub fn vphp_wrap_vslimpsr7serverrequest_get_header_line(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsr7ServerRequest(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    res := recv.get_header_line(arg_0)
    ctx.return_val[string](res)
}
@[export: 'vphp_wrap_VSlimPsr7ServerRequest_with_header']
pub fn vphp_wrap_vslimpsr7serverrequest_with_header(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsr7ServerRequest(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    arg_1 := ctx.arg_borrowed_zbox(1)
    res := recv.with_header(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimPsr7ServerRequest_with_added_header']
pub fn vphp_wrap_vslimpsr7serverrequest_with_added_header(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsr7ServerRequest(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    arg_1 := ctx.arg_borrowed_zbox(1)
    res := recv.with_added_header(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimPsr7ServerRequest_without_header']
pub fn vphp_wrap_vslimpsr7serverrequest_without_header(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsr7ServerRequest(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    res := recv.without_header(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimPsr7ServerRequest_get_body']
pub fn vphp_wrap_vslimpsr7serverrequest_get_body(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsr7ServerRequest(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.get_body()
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimPsr7ServerRequest_with_body']
pub fn vphp_wrap_vslimpsr7serverrequest_with_body(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsr7ServerRequest(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    res := recv.with_body(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimPsr7ServerRequest_get_request_target']
pub fn vphp_wrap_vslimpsr7serverrequest_get_request_target(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsr7ServerRequest(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.get_request_target()
    ctx.return_val[string](res)
}
@[export: 'vphp_wrap_VSlimPsr7ServerRequest_with_request_target']
pub fn vphp_wrap_vslimpsr7serverrequest_with_request_target(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsr7ServerRequest(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    res := recv.with_request_target(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimPsr7ServerRequest_get_method']
pub fn vphp_wrap_vslimpsr7serverrequest_get_method(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsr7ServerRequest(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.get_method()
    ctx.return_val[string](res)
}
@[export: 'vphp_wrap_VSlimPsr7ServerRequest_with_method']
pub fn vphp_wrap_vslimpsr7serverrequest_with_method(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsr7ServerRequest(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    res := recv.with_method(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimPsr7ServerRequest_get_uri']
pub fn vphp_wrap_vslimpsr7serverrequest_get_uri(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsr7ServerRequest(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.get_uri()
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimPsr7ServerRequest_with_uri']
pub fn vphp_wrap_vslimpsr7serverrequest_with_uri(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsr7ServerRequest(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    arg_1 := ctx.arg_borrowed_zbox(1)
    res := recv.with_uri(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimPsr7ServerRequest_get_server_params']
pub fn vphp_wrap_vslimpsr7serverrequest_get_server_params(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsr7ServerRequest(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.get_server_params()
    ctx.return_val[vphp.RequestOwnedZBox](res)
}
@[export: 'vphp_wrap_VSlimPsr7ServerRequest_get_cookie_params']
pub fn vphp_wrap_vslimpsr7serverrequest_get_cookie_params(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsr7ServerRequest(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.get_cookie_params()
    ctx.return_val[vphp.RequestOwnedZBox](res)
}
@[export: 'vphp_wrap_VSlimPsr7ServerRequest_with_cookie_params']
pub fn vphp_wrap_vslimpsr7serverrequest_with_cookie_params(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsr7ServerRequest(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    res := recv.with_cookie_params(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimPsr7ServerRequest_get_query_params']
pub fn vphp_wrap_vslimpsr7serverrequest_get_query_params(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsr7ServerRequest(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.get_query_params()
    ctx.return_val[vphp.RequestOwnedZBox](res)
}
@[export: 'vphp_wrap_VSlimPsr7ServerRequest_with_query_params']
pub fn vphp_wrap_vslimpsr7serverrequest_with_query_params(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsr7ServerRequest(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    res := recv.with_query_params(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimPsr7ServerRequest_get_uploaded_files']
pub fn vphp_wrap_vslimpsr7serverrequest_get_uploaded_files(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsr7ServerRequest(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.get_uploaded_files()
    ctx.return_val[vphp.RequestOwnedZBox](res)
}
@[export: 'vphp_wrap_VSlimPsr7ServerRequest_with_uploaded_files']
pub fn vphp_wrap_vslimpsr7serverrequest_with_uploaded_files(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsr7ServerRequest(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    res := recv.with_uploaded_files(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimPsr7ServerRequest_get_parsed_body']
pub fn vphp_wrap_vslimpsr7serverrequest_get_parsed_body(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsr7ServerRequest(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.get_parsed_body()
    ctx.return_val[vphp.RequestOwnedZBox](res)
}
@[export: 'vphp_wrap_VSlimPsr7ServerRequest_with_parsed_body']
pub fn vphp_wrap_vslimpsr7serverrequest_with_parsed_body(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsr7ServerRequest(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    res := recv.with_parsed_body(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimPsr7ServerRequest_get_attributes']
pub fn vphp_wrap_vslimpsr7serverrequest_get_attributes(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsr7ServerRequest(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.get_attributes()
    ctx.return_val[vphp.RequestOwnedZBox](res)
}
@[export: 'vphp_wrap_VSlimPsr7ServerRequest_get_attribute']
pub fn vphp_wrap_vslimpsr7serverrequest_get_attribute(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsr7ServerRequest(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    arg_1 := ctx.arg_borrowed_zbox(1)
    res := recv.get_attribute(arg_0, arg_1)
    ctx.return_val[vphp.RequestOwnedZBox](res)
}
@[export: 'vphp_wrap_VSlimPsr7ServerRequest_with_attribute']
pub fn vphp_wrap_vslimpsr7serverrequest_with_attribute(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsr7ServerRequest(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    arg_1 := ctx.arg_borrowed_zbox(1)
    res := recv.with_attribute(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimPsr7ServerRequest_without_attribute']
pub fn vphp_wrap_vslimpsr7serverrequest_without_attribute(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsr7ServerRequest(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    res := recv.without_attribute(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimPsr7ServerRequest_str']
pub fn vphp_wrap_vslimpsr7serverrequest_str(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsr7ServerRequest(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.str()
    ctx.return_val[string](res)
}
@[export: 'VSlimPsr7ServerRequest_handlers']
pub fn vslimpsr7serverrequest_handlers() voidptr {
    return unsafe { &C.vphp_class_handlers{
        prop_handler:  voidptr(vslimpsr7serverrequest_get_prop)
        write_handler: voidptr(vslimpsr7serverrequest_set_prop)
        sync_handler:  voidptr(vslimpsr7serverrequest_sync_props)
        new_raw:       voidptr(vslimpsr7serverrequest_new_raw)
        cleanup_raw:   voidptr(vslimpsr7serverrequest_cleanup_raw)
        free_raw:      voidptr(vslimpsr7serverrequest_free_raw)
    } }
}

@[export: 'VSlimPsr17ResponseFactory_new_raw']
pub fn vslimpsr17responsefactory_new_raw() voidptr {
    return vphp.generic_new_raw[VSlimPsr17ResponseFactory]()
}
@[export: 'VSlimPsr17ResponseFactory_free_raw']
pub fn vslimpsr17responsefactory_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[VSlimPsr17ResponseFactory](ptr)
}
@[export: 'VSlimPsr17ResponseFactory_cleanup_raw']
pub fn vslimpsr17responsefactory_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
}
@[export: 'VSlimPsr17ResponseFactory_get_prop']
pub fn vslimpsr17responsefactory_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = rv
}
@[export: 'VSlimPsr17ResponseFactory_set_prop']
pub fn vslimpsr17responsefactory_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = value
}
@[export: 'VSlimPsr17ResponseFactory_sync_props']
pub fn vslimpsr17responsefactory_sync_props(ptr voidptr, zv &C.zval) {
    _ = ptr
    _ = zv
}
@[export: 'vphp_wrap_VSlimPsr17ResponseFactory_construct']
pub fn vphp_wrap_vslimpsr17responsefactory_construct(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsr17ResponseFactory(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.construct()
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimPsr17ResponseFactory_create_response']
pub fn vphp_wrap_vslimpsr17responsefactory_create_response(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsr17ResponseFactory(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    arg_1 := ctx.arg_borrowed_zbox(1)
    res := recv.create_response(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'VSlimPsr17ResponseFactory_handlers']
pub fn vslimpsr17responsefactory_handlers() voidptr {
    return unsafe { &C.vphp_class_handlers{
        prop_handler:  voidptr(vslimpsr17responsefactory_get_prop)
        write_handler: voidptr(vslimpsr17responsefactory_set_prop)
        sync_handler:  voidptr(vslimpsr17responsefactory_sync_props)
        new_raw:       voidptr(vslimpsr17responsefactory_new_raw)
        cleanup_raw:   voidptr(vslimpsr17responsefactory_cleanup_raw)
        free_raw:      voidptr(vslimpsr17responsefactory_free_raw)
    } }
}

@[export: 'VSlimPsr17RequestFactory_new_raw']
pub fn vslimpsr17requestfactory_new_raw() voidptr {
    return vphp.generic_new_raw[VSlimPsr17RequestFactory]()
}
@[export: 'VSlimPsr17RequestFactory_free_raw']
pub fn vslimpsr17requestfactory_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[VSlimPsr17RequestFactory](ptr)
}
@[export: 'VSlimPsr17RequestFactory_cleanup_raw']
pub fn vslimpsr17requestfactory_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
}
@[export: 'VSlimPsr17RequestFactory_get_prop']
pub fn vslimpsr17requestfactory_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = rv
}
@[export: 'VSlimPsr17RequestFactory_set_prop']
pub fn vslimpsr17requestfactory_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = value
}
@[export: 'VSlimPsr17RequestFactory_sync_props']
pub fn vslimpsr17requestfactory_sync_props(ptr voidptr, zv &C.zval) {
    _ = ptr
    _ = zv
}
@[export: 'vphp_wrap_VSlimPsr17RequestFactory_construct']
pub fn vphp_wrap_vslimpsr17requestfactory_construct(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsr17RequestFactory(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.construct()
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimPsr17RequestFactory_create_request']
pub fn vphp_wrap_vslimpsr17requestfactory_create_request(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsr17RequestFactory(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    arg_1 := ctx.arg_borrowed_zbox(1)
    res := recv.create_request(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'VSlimPsr17RequestFactory_handlers']
pub fn vslimpsr17requestfactory_handlers() voidptr {
    return unsafe { &C.vphp_class_handlers{
        prop_handler:  voidptr(vslimpsr17requestfactory_get_prop)
        write_handler: voidptr(vslimpsr17requestfactory_set_prop)
        sync_handler:  voidptr(vslimpsr17requestfactory_sync_props)
        new_raw:       voidptr(vslimpsr17requestfactory_new_raw)
        cleanup_raw:   voidptr(vslimpsr17requestfactory_cleanup_raw)
        free_raw:      voidptr(vslimpsr17requestfactory_free_raw)
    } }
}

@[export: 'VSlimPsr17StreamFactory_new_raw']
pub fn vslimpsr17streamfactory_new_raw() voidptr {
    return vphp.generic_new_raw[VSlimPsr17StreamFactory]()
}
@[export: 'VSlimPsr17StreamFactory_free_raw']
pub fn vslimpsr17streamfactory_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[VSlimPsr17StreamFactory](ptr)
}
@[export: 'VSlimPsr17StreamFactory_cleanup_raw']
pub fn vslimpsr17streamfactory_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
}
@[export: 'VSlimPsr17StreamFactory_get_prop']
pub fn vslimpsr17streamfactory_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = rv
}
@[export: 'VSlimPsr17StreamFactory_set_prop']
pub fn vslimpsr17streamfactory_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = value
}
@[export: 'VSlimPsr17StreamFactory_sync_props']
pub fn vslimpsr17streamfactory_sync_props(ptr voidptr, zv &C.zval) {
    _ = ptr
    _ = zv
}
@[export: 'vphp_wrap_VSlimPsr17StreamFactory_construct']
pub fn vphp_wrap_vslimpsr17streamfactory_construct(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsr17StreamFactory(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.construct()
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimPsr17StreamFactory_create_stream']
pub fn vphp_wrap_vslimpsr17streamfactory_create_stream(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsr17StreamFactory(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    res := recv.create_stream(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimPsr17StreamFactory_create_stream_from_file']
pub fn vphp_wrap_vslimpsr17streamfactory_create_stream_from_file(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsr17StreamFactory(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    arg_1 := ctx.arg_borrowed_zbox(1)
    res := recv.create_stream_from_file(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimPsr17StreamFactory_create_stream_from_resource']
pub fn vphp_wrap_vslimpsr17streamfactory_create_stream_from_resource(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsr17StreamFactory(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    res := recv.create_stream_from_resource(arg_0)
    return voidptr(res)
}
@[export: 'VSlimPsr17StreamFactory_handlers']
pub fn vslimpsr17streamfactory_handlers() voidptr {
    return unsafe { &C.vphp_class_handlers{
        prop_handler:  voidptr(vslimpsr17streamfactory_get_prop)
        write_handler: voidptr(vslimpsr17streamfactory_set_prop)
        sync_handler:  voidptr(vslimpsr17streamfactory_sync_props)
        new_raw:       voidptr(vslimpsr17streamfactory_new_raw)
        cleanup_raw:   voidptr(vslimpsr17streamfactory_cleanup_raw)
        free_raw:      voidptr(vslimpsr17streamfactory_free_raw)
    } }
}

@[export: 'VSlimPsr17UploadedFileFactory_new_raw']
pub fn vslimpsr17uploadedfilefactory_new_raw() voidptr {
    return vphp.generic_new_raw[VSlimPsr17UploadedFileFactory]()
}
@[export: 'VSlimPsr17UploadedFileFactory_free_raw']
pub fn vslimpsr17uploadedfilefactory_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[VSlimPsr17UploadedFileFactory](ptr)
}
@[export: 'VSlimPsr17UploadedFileFactory_cleanup_raw']
pub fn vslimpsr17uploadedfilefactory_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
}
@[export: 'VSlimPsr17UploadedFileFactory_get_prop']
pub fn vslimpsr17uploadedfilefactory_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = rv
}
@[export: 'VSlimPsr17UploadedFileFactory_set_prop']
pub fn vslimpsr17uploadedfilefactory_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = value
}
@[export: 'VSlimPsr17UploadedFileFactory_sync_props']
pub fn vslimpsr17uploadedfilefactory_sync_props(ptr voidptr, zv &C.zval) {
    _ = ptr
    _ = zv
}
@[export: 'vphp_wrap_VSlimPsr17UploadedFileFactory_construct']
pub fn vphp_wrap_vslimpsr17uploadedfilefactory_construct(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsr17UploadedFileFactory(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.construct()
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimPsr17UploadedFileFactory_create_uploaded_file']
pub fn vphp_wrap_vslimpsr17uploadedfilefactory_create_uploaded_file(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsr17UploadedFileFactory(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    arg_1 := ctx.arg_borrowed_zbox(1)
    arg_2 := ctx.arg_borrowed_zbox(2)
    arg_3 := ctx.arg_borrowed_zbox(3)
    arg_4 := ctx.arg_borrowed_zbox(4)
    res := recv.create_uploaded_file(arg_0, arg_1, arg_2, arg_3, arg_4)
    return voidptr(res)
}
@[export: 'VSlimPsr17UploadedFileFactory_handlers']
pub fn vslimpsr17uploadedfilefactory_handlers() voidptr {
    return unsafe { &C.vphp_class_handlers{
        prop_handler:  voidptr(vslimpsr17uploadedfilefactory_get_prop)
        write_handler: voidptr(vslimpsr17uploadedfilefactory_set_prop)
        sync_handler:  voidptr(vslimpsr17uploadedfilefactory_sync_props)
        new_raw:       voidptr(vslimpsr17uploadedfilefactory_new_raw)
        cleanup_raw:   voidptr(vslimpsr17uploadedfilefactory_cleanup_raw)
        free_raw:      voidptr(vslimpsr17uploadedfilefactory_free_raw)
    } }
}

@[export: 'VSlimPsr17UriFactory_new_raw']
pub fn vslimpsr17urifactory_new_raw() voidptr {
    return vphp.generic_new_raw[VSlimPsr17UriFactory]()
}
@[export: 'VSlimPsr17UriFactory_free_raw']
pub fn vslimpsr17urifactory_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[VSlimPsr17UriFactory](ptr)
}
@[export: 'VSlimPsr17UriFactory_cleanup_raw']
pub fn vslimpsr17urifactory_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
}
@[export: 'VSlimPsr17UriFactory_get_prop']
pub fn vslimpsr17urifactory_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = rv
}
@[export: 'VSlimPsr17UriFactory_set_prop']
pub fn vslimpsr17urifactory_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = value
}
@[export: 'VSlimPsr17UriFactory_sync_props']
pub fn vslimpsr17urifactory_sync_props(ptr voidptr, zv &C.zval) {
    _ = ptr
    _ = zv
}
@[export: 'vphp_wrap_VSlimPsr17UriFactory_construct']
pub fn vphp_wrap_vslimpsr17urifactory_construct(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsr17UriFactory(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.construct()
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimPsr17UriFactory_create_uri']
pub fn vphp_wrap_vslimpsr17urifactory_create_uri(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsr17UriFactory(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    res := recv.create_uri(arg_0)
    return voidptr(res)
}
@[export: 'VSlimPsr17UriFactory_handlers']
pub fn vslimpsr17urifactory_handlers() voidptr {
    return unsafe { &C.vphp_class_handlers{
        prop_handler:  voidptr(vslimpsr17urifactory_get_prop)
        write_handler: voidptr(vslimpsr17urifactory_set_prop)
        sync_handler:  voidptr(vslimpsr17urifactory_sync_props)
        new_raw:       voidptr(vslimpsr17urifactory_new_raw)
        cleanup_raw:   voidptr(vslimpsr17urifactory_cleanup_raw)
        free_raw:      voidptr(vslimpsr17urifactory_free_raw)
    } }
}

@[export: 'VSlimPsr17ServerRequestFactory_new_raw']
pub fn vslimpsr17serverrequestfactory_new_raw() voidptr {
    return vphp.generic_new_raw[VSlimPsr17ServerRequestFactory]()
}
@[export: 'VSlimPsr17ServerRequestFactory_free_raw']
pub fn vslimpsr17serverrequestfactory_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[VSlimPsr17ServerRequestFactory](ptr)
}
@[export: 'VSlimPsr17ServerRequestFactory_cleanup_raw']
pub fn vslimpsr17serverrequestfactory_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
}
@[export: 'VSlimPsr17ServerRequestFactory_get_prop']
pub fn vslimpsr17serverrequestfactory_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = rv
}
@[export: 'VSlimPsr17ServerRequestFactory_set_prop']
pub fn vslimpsr17serverrequestfactory_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = value
}
@[export: 'VSlimPsr17ServerRequestFactory_sync_props']
pub fn vslimpsr17serverrequestfactory_sync_props(ptr voidptr, zv &C.zval) {
    _ = ptr
    _ = zv
}
@[export: 'vphp_wrap_VSlimPsr17ServerRequestFactory_construct']
pub fn vphp_wrap_vslimpsr17serverrequestfactory_construct(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsr17ServerRequestFactory(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.construct()
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimPsr17ServerRequestFactory_create_server_request']
pub fn vphp_wrap_vslimpsr17serverrequestfactory_create_server_request(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsr17ServerRequestFactory(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    arg_1 := ctx.arg_borrowed_zbox(1)
    arg_2 := ctx.arg_borrowed_zbox(2)
    res := recv.create_server_request(arg_0, arg_1, arg_2)
    return voidptr(res)
}
@[export: 'VSlimPsr17ServerRequestFactory_handlers']
pub fn vslimpsr17serverrequestfactory_handlers() voidptr {
    return unsafe { &C.vphp_class_handlers{
        prop_handler:  voidptr(vslimpsr17serverrequestfactory_get_prop)
        write_handler: voidptr(vslimpsr17serverrequestfactory_set_prop)
        sync_handler:  voidptr(vslimpsr17serverrequestfactory_sync_props)
        new_raw:       voidptr(vslimpsr17serverrequestfactory_new_raw)
        cleanup_raw:   voidptr(vslimpsr17serverrequestfactory_cleanup_raw)
        free_raw:      voidptr(vslimpsr17serverrequestfactory_free_raw)
    } }
}

@[export: 'VSlimPsr16CacheException_new_raw']
pub fn vslimpsr16cacheexception_new_raw() voidptr {
    return vphp.generic_new_raw[VSlimPsr16CacheException]()
}
@[export: 'VSlimPsr16CacheException_free_raw']
pub fn vslimpsr16cacheexception_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[VSlimPsr16CacheException](ptr)
}
@[export: 'VSlimPsr16CacheException_cleanup_raw']
pub fn vslimpsr16cacheexception_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
}
fn vslimpsr16cacheexception_load_from_php(obj &C.zend_object) VSlimPsr16CacheException {
    mut recv := VSlimPsr16CacheException{}
    if obj == 0 {
        return recv
    }
    return recv
}
fn vslimpsr16cacheexception_sync_to_php(obj &C.zend_object, recv VSlimPsr16CacheException) {
    if obj == 0 {
        return
    }
}
@[export: 'VSlimPsr16CacheException_get_prop']
pub fn vslimpsr16cacheexception_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = rv
}
@[export: 'VSlimPsr16CacheException_set_prop']
pub fn vslimpsr16cacheexception_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = value
}
@[export: 'VSlimPsr16CacheException_sync_props']
pub fn vslimpsr16cacheexception_sync_props(ptr voidptr, zv &C.zval) {
    _ = ptr
    _ = zv
}
@[export: 'VSlimPsr16CacheException_handlers']
pub fn vslimpsr16cacheexception_handlers() voidptr {
    return unsafe { &C.vphp_class_handlers{
        prop_handler:  voidptr(vslimpsr16cacheexception_get_prop)
        write_handler: voidptr(vslimpsr16cacheexception_set_prop)
        sync_handler:  voidptr(vslimpsr16cacheexception_sync_props)
        new_raw:       voidptr(vslimpsr16cacheexception_new_raw)
        cleanup_raw:   voidptr(vslimpsr16cacheexception_cleanup_raw)
        free_raw:      voidptr(vslimpsr16cacheexception_free_raw)
    } }
}

@[export: 'VSlimPsr16InvalidArgumentException_new_raw']
pub fn vslimpsr16invalidargumentexception_new_raw() voidptr {
    return vphp.generic_new_raw[VSlimPsr16InvalidArgumentException]()
}
@[export: 'VSlimPsr16InvalidArgumentException_free_raw']
pub fn vslimpsr16invalidargumentexception_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[VSlimPsr16InvalidArgumentException](ptr)
}
@[export: 'VSlimPsr16InvalidArgumentException_cleanup_raw']
pub fn vslimpsr16invalidargumentexception_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
}
fn vslimpsr16invalidargumentexception_load_from_php(obj &C.zend_object) VSlimPsr16InvalidArgumentException {
    mut recv := VSlimPsr16InvalidArgumentException{}
    if obj == 0 {
        return recv
    }
    return recv
}
fn vslimpsr16invalidargumentexception_sync_to_php(obj &C.zend_object, recv VSlimPsr16InvalidArgumentException) {
    if obj == 0 {
        return
    }
}
@[export: 'VSlimPsr16InvalidArgumentException_get_prop']
pub fn vslimpsr16invalidargumentexception_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = rv
}
@[export: 'VSlimPsr16InvalidArgumentException_set_prop']
pub fn vslimpsr16invalidargumentexception_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = value
}
@[export: 'VSlimPsr16InvalidArgumentException_sync_props']
pub fn vslimpsr16invalidargumentexception_sync_props(ptr voidptr, zv &C.zval) {
    _ = ptr
    _ = zv
}
@[export: 'VSlimPsr16InvalidArgumentException_handlers']
pub fn vslimpsr16invalidargumentexception_handlers() voidptr {
    return unsafe { &C.vphp_class_handlers{
        prop_handler:  voidptr(vslimpsr16invalidargumentexception_get_prop)
        write_handler: voidptr(vslimpsr16invalidargumentexception_set_prop)
        sync_handler:  voidptr(vslimpsr16invalidargumentexception_sync_props)
        new_raw:       voidptr(vslimpsr16invalidargumentexception_new_raw)
        cleanup_raw:   voidptr(vslimpsr16invalidargumentexception_cleanup_raw)
        free_raw:      voidptr(vslimpsr16invalidargumentexception_free_raw)
    } }
}

@[export: 'VSlimPsr16Cache_new_raw']
pub fn vslimpsr16cache_new_raw() voidptr {
    return vphp.generic_new_raw[VSlimPsr16Cache]()
}
@[export: 'VSlimPsr16Cache_free_raw']
pub fn vslimpsr16cache_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[VSlimPsr16Cache](ptr)
}
@[export: 'VSlimPsr16Cache_cleanup_raw']
pub fn vslimpsr16cache_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    unsafe {
        mut obj := &VSlimPsr16Cache(ptr)
        obj.free()
    }
}
@[export: 'VSlimPsr16Cache_get_prop']
pub fn vslimpsr16cache_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = rv
}
@[export: 'VSlimPsr16Cache_set_prop']
pub fn vslimpsr16cache_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = value
}
@[export: 'VSlimPsr16Cache_sync_props']
pub fn vslimpsr16cache_sync_props(ptr voidptr, zv &C.zval) {
    _ = ptr
    _ = zv
}
@[export: 'vphp_wrap_VSlimPsr16Cache_construct']
pub fn vphp_wrap_vslimpsr16cache_construct(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsr16Cache(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.construct()
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimPsr16Cache_set_clock']
pub fn vphp_wrap_vslimpsr16cache_set_clock(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsr16Cache(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    res := recv.set_clock(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimPsr16Cache_clock']
pub fn vphp_wrap_vslimpsr16cache_clock(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsr16Cache(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.clock()
    ctx.return_val[vphp.RequestOwnedZBox](res)
}
@[export: 'vphp_wrap_VSlimPsr16Cache_get']
pub fn vphp_wrap_vslimpsr16cache_get(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsr16Cache(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    arg_1 := ctx.arg_borrowed_zbox(1)
    res := recv.get(arg_0, arg_1)
    ctx.return_val[vphp.RequestOwnedZBox](res)
}
@[export: 'vphp_wrap_VSlimPsr16Cache_set']
pub fn vphp_wrap_vslimpsr16cache_set(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsr16Cache(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    arg_1 := ctx.arg_borrowed_zbox(1)
    arg_2 := ctx.arg_borrowed_zbox(2)
    res := recv.set(arg_0, arg_1, arg_2)
    ctx.return_val[bool](res)
}
@[export: 'vphp_wrap_VSlimPsr16Cache_delete']
pub fn vphp_wrap_vslimpsr16cache_delete(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsr16Cache(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    res := recv.delete(arg_0)
    ctx.return_val[bool](res)
}
@[export: 'vphp_wrap_VSlimPsr16Cache_clear']
pub fn vphp_wrap_vslimpsr16cache_clear(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsr16Cache(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.clear()
    ctx.return_val[bool](res)
}
@[export: 'vphp_wrap_VSlimPsr16Cache_get_multiple']
pub fn vphp_wrap_vslimpsr16cache_get_multiple(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsr16Cache(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    arg_1 := ctx.arg_borrowed_zbox(1)
    res := recv.get_multiple(arg_0, arg_1)
    ctx.return_val[vphp.RequestOwnedZBox](res)
}
@[export: 'vphp_wrap_VSlimPsr16Cache_set_multiple']
pub fn vphp_wrap_vslimpsr16cache_set_multiple(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsr16Cache(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    arg_1 := ctx.arg_borrowed_zbox(1)
    res := recv.set_multiple(arg_0, arg_1)
    ctx.return_val[bool](res)
}
@[export: 'vphp_wrap_VSlimPsr16Cache_delete_multiple']
pub fn vphp_wrap_vslimpsr16cache_delete_multiple(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsr16Cache(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    res := recv.delete_multiple(arg_0)
    ctx.return_val[bool](res)
}
@[export: 'vphp_wrap_VSlimPsr16Cache_has']
pub fn vphp_wrap_vslimpsr16cache_has(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsr16Cache(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    res := recv.has(arg_0)
    ctx.return_val[bool](res)
}
@[export: 'VSlimPsr16Cache_handlers']
pub fn vslimpsr16cache_handlers() voidptr {
    return unsafe { &C.vphp_class_handlers{
        prop_handler:  voidptr(vslimpsr16cache_get_prop)
        write_handler: voidptr(vslimpsr16cache_set_prop)
        sync_handler:  voidptr(vslimpsr16cache_sync_props)
        new_raw:       voidptr(vslimpsr16cache_new_raw)
        cleanup_raw:   voidptr(vslimpsr16cache_cleanup_raw)
        free_raw:      voidptr(vslimpsr16cache_free_raw)
    } }
}

@[export: 'VSlimPsr6CacheException_new_raw']
pub fn vslimpsr6cacheexception_new_raw() voidptr {
    return vphp.generic_new_raw[VSlimPsr6CacheException]()
}
@[export: 'VSlimPsr6CacheException_free_raw']
pub fn vslimpsr6cacheexception_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[VSlimPsr6CacheException](ptr)
}
@[export: 'VSlimPsr6CacheException_cleanup_raw']
pub fn vslimpsr6cacheexception_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
}
fn vslimpsr6cacheexception_load_from_php(obj &C.zend_object) VSlimPsr6CacheException {
    mut recv := VSlimPsr6CacheException{}
    if obj == 0 {
        return recv
    }
    return recv
}
fn vslimpsr6cacheexception_sync_to_php(obj &C.zend_object, recv VSlimPsr6CacheException) {
    if obj == 0 {
        return
    }
}
@[export: 'VSlimPsr6CacheException_get_prop']
pub fn vslimpsr6cacheexception_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = rv
}
@[export: 'VSlimPsr6CacheException_set_prop']
pub fn vslimpsr6cacheexception_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = value
}
@[export: 'VSlimPsr6CacheException_sync_props']
pub fn vslimpsr6cacheexception_sync_props(ptr voidptr, zv &C.zval) {
    _ = ptr
    _ = zv
}
@[export: 'VSlimPsr6CacheException_handlers']
pub fn vslimpsr6cacheexception_handlers() voidptr {
    return unsafe { &C.vphp_class_handlers{
        prop_handler:  voidptr(vslimpsr6cacheexception_get_prop)
        write_handler: voidptr(vslimpsr6cacheexception_set_prop)
        sync_handler:  voidptr(vslimpsr6cacheexception_sync_props)
        new_raw:       voidptr(vslimpsr6cacheexception_new_raw)
        cleanup_raw:   voidptr(vslimpsr6cacheexception_cleanup_raw)
        free_raw:      voidptr(vslimpsr6cacheexception_free_raw)
    } }
}

@[export: 'VSlimPsr6InvalidArgumentException_new_raw']
pub fn vslimpsr6invalidargumentexception_new_raw() voidptr {
    return vphp.generic_new_raw[VSlimPsr6InvalidArgumentException]()
}
@[export: 'VSlimPsr6InvalidArgumentException_free_raw']
pub fn vslimpsr6invalidargumentexception_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[VSlimPsr6InvalidArgumentException](ptr)
}
@[export: 'VSlimPsr6InvalidArgumentException_cleanup_raw']
pub fn vslimpsr6invalidargumentexception_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
}
fn vslimpsr6invalidargumentexception_load_from_php(obj &C.zend_object) VSlimPsr6InvalidArgumentException {
    mut recv := VSlimPsr6InvalidArgumentException{}
    if obj == 0 {
        return recv
    }
    return recv
}
fn vslimpsr6invalidargumentexception_sync_to_php(obj &C.zend_object, recv VSlimPsr6InvalidArgumentException) {
    if obj == 0 {
        return
    }
}
@[export: 'VSlimPsr6InvalidArgumentException_get_prop']
pub fn vslimpsr6invalidargumentexception_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = rv
}
@[export: 'VSlimPsr6InvalidArgumentException_set_prop']
pub fn vslimpsr6invalidargumentexception_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = value
}
@[export: 'VSlimPsr6InvalidArgumentException_sync_props']
pub fn vslimpsr6invalidargumentexception_sync_props(ptr voidptr, zv &C.zval) {
    _ = ptr
    _ = zv
}
@[export: 'VSlimPsr6InvalidArgumentException_handlers']
pub fn vslimpsr6invalidargumentexception_handlers() voidptr {
    return unsafe { &C.vphp_class_handlers{
        prop_handler:  voidptr(vslimpsr6invalidargumentexception_get_prop)
        write_handler: voidptr(vslimpsr6invalidargumentexception_set_prop)
        sync_handler:  voidptr(vslimpsr6invalidargumentexception_sync_props)
        new_raw:       voidptr(vslimpsr6invalidargumentexception_new_raw)
        cleanup_raw:   voidptr(vslimpsr6invalidargumentexception_cleanup_raw)
        free_raw:      voidptr(vslimpsr6invalidargumentexception_free_raw)
    } }
}

@[export: 'VSlimPsr6CacheItem_new_raw']
pub fn vslimpsr6cacheitem_new_raw() voidptr {
    return vphp.generic_new_raw[VSlimPsr6CacheItem]()
}
@[export: 'VSlimPsr6CacheItem_free_raw']
pub fn vslimpsr6cacheitem_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[VSlimPsr6CacheItem](ptr)
}
@[export: 'VSlimPsr6CacheItem_cleanup_raw']
pub fn vslimpsr6cacheitem_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    unsafe {
        mut obj := &VSlimPsr6CacheItem(ptr)
        obj.free()
    }
}
@[export: 'VSlimPsr6CacheItem_get_prop']
pub fn vslimpsr6cacheitem_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = rv
}
@[export: 'VSlimPsr6CacheItem_set_prop']
pub fn vslimpsr6cacheitem_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = value
}
@[export: 'VSlimPsr6CacheItem_sync_props']
pub fn vslimpsr6cacheitem_sync_props(ptr voidptr, zv &C.zval) {
    _ = ptr
    _ = zv
}
@[export: 'vphp_wrap_VSlimPsr6CacheItem_get_key']
pub fn vphp_wrap_vslimpsr6cacheitem_get_key(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsr6CacheItem(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.get_key()
    ctx.return_val[string](res)
}
@[export: 'vphp_wrap_VSlimPsr6CacheItem_get']
pub fn vphp_wrap_vslimpsr6cacheitem_get(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsr6CacheItem(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.get()
    ctx.return_val[vphp.RequestOwnedZBox](res)
}
@[export: 'vphp_wrap_VSlimPsr6CacheItem_is_hit']
pub fn vphp_wrap_vslimpsr6cacheitem_is_hit(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsr6CacheItem(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.is_hit()
    ctx.return_val[bool](res)
}
@[export: 'vphp_wrap_VSlimPsr6CacheItem_set']
pub fn vphp_wrap_vslimpsr6cacheitem_set(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsr6CacheItem(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    res := recv.set(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimPsr6CacheItem_expires_at']
pub fn vphp_wrap_vslimpsr6cacheitem_expires_at(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsr6CacheItem(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    res := recv.expires_at(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimPsr6CacheItem_expires_after']
pub fn vphp_wrap_vslimpsr6cacheitem_expires_after(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsr6CacheItem(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    res := recv.expires_after(arg_0)
    return voidptr(res)
}
@[export: 'VSlimPsr6CacheItem_handlers']
pub fn vslimpsr6cacheitem_handlers() voidptr {
    return unsafe { &C.vphp_class_handlers{
        prop_handler:  voidptr(vslimpsr6cacheitem_get_prop)
        write_handler: voidptr(vslimpsr6cacheitem_set_prop)
        sync_handler:  voidptr(vslimpsr6cacheitem_sync_props)
        new_raw:       voidptr(vslimpsr6cacheitem_new_raw)
        cleanup_raw:   voidptr(vslimpsr6cacheitem_cleanup_raw)
        free_raw:      voidptr(vslimpsr6cacheitem_free_raw)
    } }
}

@[export: 'VSlimPsr6CacheItemPool_new_raw']
pub fn vslimpsr6cacheitempool_new_raw() voidptr {
    return vphp.generic_new_raw[VSlimPsr6CacheItemPool]()
}
@[export: 'VSlimPsr6CacheItemPool_free_raw']
pub fn vslimpsr6cacheitempool_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[VSlimPsr6CacheItemPool](ptr)
}
@[export: 'VSlimPsr6CacheItemPool_cleanup_raw']
pub fn vslimpsr6cacheitempool_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    unsafe {
        mut obj := &VSlimPsr6CacheItemPool(ptr)
        obj.free()
    }
}
@[export: 'VSlimPsr6CacheItemPool_get_prop']
pub fn vslimpsr6cacheitempool_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = rv
}
@[export: 'VSlimPsr6CacheItemPool_set_prop']
pub fn vslimpsr6cacheitempool_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = value
}
@[export: 'VSlimPsr6CacheItemPool_sync_props']
pub fn vslimpsr6cacheitempool_sync_props(ptr voidptr, zv &C.zval) {
    _ = ptr
    _ = zv
}
@[export: 'vphp_wrap_VSlimPsr6CacheItemPool_construct']
pub fn vphp_wrap_vslimpsr6cacheitempool_construct(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsr6CacheItemPool(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.construct()
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimPsr6CacheItemPool_set_clock']
pub fn vphp_wrap_vslimpsr6cacheitempool_set_clock(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsr6CacheItemPool(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    res := recv.set_clock(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimPsr6CacheItemPool_clock']
pub fn vphp_wrap_vslimpsr6cacheitempool_clock(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsr6CacheItemPool(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.clock()
    ctx.return_val[vphp.RequestOwnedZBox](res)
}
@[export: 'vphp_wrap_VSlimPsr6CacheItemPool_get_item']
pub fn vphp_wrap_vslimpsr6cacheitempool_get_item(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsr6CacheItemPool(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    res := recv.get_item(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimPsr6CacheItemPool_get_items']
pub fn vphp_wrap_vslimpsr6cacheitempool_get_items(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsr6CacheItemPool(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    res := recv.get_items(arg_0)
    ctx.return_val[vphp.RequestOwnedZBox](res)
}
@[export: 'vphp_wrap_VSlimPsr6CacheItemPool_has_item']
pub fn vphp_wrap_vslimpsr6cacheitempool_has_item(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsr6CacheItemPool(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    res := recv.has_item(arg_0)
    ctx.return_val[bool](res)
}
@[export: 'vphp_wrap_VSlimPsr6CacheItemPool_clear']
pub fn vphp_wrap_vslimpsr6cacheitempool_clear(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsr6CacheItemPool(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.clear()
    ctx.return_val[bool](res)
}
@[export: 'vphp_wrap_VSlimPsr6CacheItemPool_delete_item']
pub fn vphp_wrap_vslimpsr6cacheitempool_delete_item(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsr6CacheItemPool(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    res := recv.delete_item(arg_0)
    ctx.return_val[bool](res)
}
@[export: 'vphp_wrap_VSlimPsr6CacheItemPool_delete_items']
pub fn vphp_wrap_vslimpsr6cacheitempool_delete_items(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsr6CacheItemPool(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    res := recv.delete_items(arg_0)
    ctx.return_val[bool](res)
}
@[export: 'vphp_wrap_VSlimPsr6CacheItemPool_save']
pub fn vphp_wrap_vslimpsr6cacheitempool_save(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsr6CacheItemPool(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    res := recv.save(arg_0)
    ctx.return_val[bool](res)
}
@[export: 'vphp_wrap_VSlimPsr6CacheItemPool_save_deferred']
pub fn vphp_wrap_vslimpsr6cacheitempool_save_deferred(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsr6CacheItemPool(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    res := recv.save_deferred(arg_0)
    ctx.return_val[bool](res)
}
@[export: 'vphp_wrap_VSlimPsr6CacheItemPool_commit']
pub fn vphp_wrap_vslimpsr6cacheitempool_commit(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsr6CacheItemPool(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.commit()
    ctx.return_val[bool](res)
}
@[export: 'VSlimPsr6CacheItemPool_handlers']
pub fn vslimpsr6cacheitempool_handlers() voidptr {
    return unsafe { &C.vphp_class_handlers{
        prop_handler:  voidptr(vslimpsr6cacheitempool_get_prop)
        write_handler: voidptr(vslimpsr6cacheitempool_set_prop)
        sync_handler:  voidptr(vslimpsr6cacheitempool_sync_props)
        new_raw:       voidptr(vslimpsr6cacheitempool_new_raw)
        cleanup_raw:   voidptr(vslimpsr6cacheitempool_cleanup_raw)
        free_raw:      voidptr(vslimpsr6cacheitempool_free_raw)
    } }
}

@[export: 'VSlimPsr18ClientException_new_raw']
pub fn vslimpsr18clientexception_new_raw() voidptr {
    return vphp.generic_new_raw[VSlimPsr18ClientException]()
}
@[export: 'VSlimPsr18ClientException_free_raw']
pub fn vslimpsr18clientexception_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[VSlimPsr18ClientException](ptr)
}
@[export: 'VSlimPsr18ClientException_cleanup_raw']
pub fn vslimpsr18clientexception_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
}
fn vslimpsr18clientexception_load_from_php(obj &C.zend_object) VSlimPsr18ClientException {
    mut recv := VSlimPsr18ClientException{}
    if obj == 0 {
        return recv
    }
    return recv
}
fn vslimpsr18clientexception_sync_to_php(obj &C.zend_object, recv VSlimPsr18ClientException) {
    if obj == 0 {
        return
    }
}
@[export: 'VSlimPsr18ClientException_get_prop']
pub fn vslimpsr18clientexception_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = rv
}
@[export: 'VSlimPsr18ClientException_set_prop']
pub fn vslimpsr18clientexception_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = value
}
@[export: 'VSlimPsr18ClientException_sync_props']
pub fn vslimpsr18clientexception_sync_props(ptr voidptr, zv &C.zval) {
    _ = ptr
    _ = zv
}
@[export: 'VSlimPsr18ClientException_handlers']
pub fn vslimpsr18clientexception_handlers() voidptr {
    return unsafe { &C.vphp_class_handlers{
        prop_handler:  voidptr(vslimpsr18clientexception_get_prop)
        write_handler: voidptr(vslimpsr18clientexception_set_prop)
        sync_handler:  voidptr(vslimpsr18clientexception_sync_props)
        new_raw:       voidptr(vslimpsr18clientexception_new_raw)
        cleanup_raw:   voidptr(vslimpsr18clientexception_cleanup_raw)
        free_raw:      voidptr(vslimpsr18clientexception_free_raw)
    } }
}

@[export: 'VSlimPsr18RequestException_new_raw']
pub fn vslimpsr18requestexception_new_raw() voidptr {
    return vphp.generic_new_raw[VSlimPsr18RequestException]()
}
@[export: 'VSlimPsr18RequestException_free_raw']
pub fn vslimpsr18requestexception_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[VSlimPsr18RequestException](ptr)
}
@[export: 'VSlimPsr18RequestException_cleanup_raw']
pub fn vslimpsr18requestexception_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
}
fn vslimpsr18requestexception_load_from_php(obj &C.zend_object) VSlimPsr18RequestException {
    mut recv := VSlimPsr18RequestException{}
    if obj == 0 {
        return recv
    }
    return recv
}
fn vslimpsr18requestexception_sync_to_php(obj &C.zend_object, recv VSlimPsr18RequestException) {
    if obj == 0 {
        return
    }
}
@[export: 'VSlimPsr18RequestException_get_prop']
pub fn vslimpsr18requestexception_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = rv
}
@[export: 'VSlimPsr18RequestException_set_prop']
pub fn vslimpsr18requestexception_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = value
}
@[export: 'VSlimPsr18RequestException_sync_props']
pub fn vslimpsr18requestexception_sync_props(ptr voidptr, zv &C.zval) {
    _ = ptr
    _ = zv
}
@[export: 'vphp_wrap_VSlimPsr18RequestException_attach_request']
pub fn vphp_wrap_vslimpsr18requestexception_attach_request(ptr voidptr, ctx vphp.Context)  {
    this_obj := unsafe { &C.zend_object(ptr) }
    mut recv := vslimpsr18requestexception_load_from_php(this_obj)
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    recv.attach_request(arg_0)
    vslimpsr18requestexception_sync_to_php(this_obj, recv)
}
@[export: 'vphp_wrap_VSlimPsr18RequestException_get_request']
pub fn vphp_wrap_vslimpsr18requestexception_get_request(ptr voidptr, ctx vphp.Context)  {
    this_obj := unsafe { &C.zend_object(ptr) }
    mut recv := vslimpsr18requestexception_load_from_php(this_obj)
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.get_request()
    vslimpsr18requestexception_sync_to_php(this_obj, recv)
    ctx.return_val[vphp.RequestOwnedZBox](res)
}
@[export: 'VSlimPsr18RequestException_handlers']
pub fn vslimpsr18requestexception_handlers() voidptr {
    return unsafe { &C.vphp_class_handlers{
        prop_handler:  voidptr(vslimpsr18requestexception_get_prop)
        write_handler: voidptr(vslimpsr18requestexception_set_prop)
        sync_handler:  voidptr(vslimpsr18requestexception_sync_props)
        new_raw:       voidptr(vslimpsr18requestexception_new_raw)
        cleanup_raw:   voidptr(vslimpsr18requestexception_cleanup_raw)
        free_raw:      voidptr(vslimpsr18requestexception_free_raw)
    } }
}

@[export: 'VSlimPsr18NetworkException_new_raw']
pub fn vslimpsr18networkexception_new_raw() voidptr {
    return vphp.generic_new_raw[VSlimPsr18NetworkException]()
}
@[export: 'VSlimPsr18NetworkException_free_raw']
pub fn vslimpsr18networkexception_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[VSlimPsr18NetworkException](ptr)
}
@[export: 'VSlimPsr18NetworkException_cleanup_raw']
pub fn vslimpsr18networkexception_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
}
fn vslimpsr18networkexception_load_from_php(obj &C.zend_object) VSlimPsr18NetworkException {
    mut recv := VSlimPsr18NetworkException{}
    if obj == 0 {
        return recv
    }
    return recv
}
fn vslimpsr18networkexception_sync_to_php(obj &C.zend_object, recv VSlimPsr18NetworkException) {
    if obj == 0 {
        return
    }
}
@[export: 'VSlimPsr18NetworkException_get_prop']
pub fn vslimpsr18networkexception_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = rv
}
@[export: 'VSlimPsr18NetworkException_set_prop']
pub fn vslimpsr18networkexception_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = value
}
@[export: 'VSlimPsr18NetworkException_sync_props']
pub fn vslimpsr18networkexception_sync_props(ptr voidptr, zv &C.zval) {
    _ = ptr
    _ = zv
}
@[export: 'vphp_wrap_VSlimPsr18NetworkException_attach_request']
pub fn vphp_wrap_vslimpsr18networkexception_attach_request(ptr voidptr, ctx vphp.Context)  {
    this_obj := unsafe { &C.zend_object(ptr) }
    mut recv := vslimpsr18networkexception_load_from_php(this_obj)
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    recv.attach_request(arg_0)
    vslimpsr18networkexception_sync_to_php(this_obj, recv)
}
@[export: 'vphp_wrap_VSlimPsr18NetworkException_get_request']
pub fn vphp_wrap_vslimpsr18networkexception_get_request(ptr voidptr, ctx vphp.Context)  {
    this_obj := unsafe { &C.zend_object(ptr) }
    mut recv := vslimpsr18networkexception_load_from_php(this_obj)
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.get_request()
    vslimpsr18networkexception_sync_to_php(this_obj, recv)
    ctx.return_val[vphp.RequestOwnedZBox](res)
}
@[export: 'VSlimPsr18NetworkException_handlers']
pub fn vslimpsr18networkexception_handlers() voidptr {
    return unsafe { &C.vphp_class_handlers{
        prop_handler:  voidptr(vslimpsr18networkexception_get_prop)
        write_handler: voidptr(vslimpsr18networkexception_set_prop)
        sync_handler:  voidptr(vslimpsr18networkexception_sync_props)
        new_raw:       voidptr(vslimpsr18networkexception_new_raw)
        cleanup_raw:   voidptr(vslimpsr18networkexception_cleanup_raw)
        free_raw:      voidptr(vslimpsr18networkexception_free_raw)
    } }
}

@[export: 'VSlimPsr18Client_new_raw']
pub fn vslimpsr18client_new_raw() voidptr {
    return vphp.generic_new_raw[VSlimPsr18Client]()
}
@[export: 'VSlimPsr18Client_free_raw']
pub fn vslimpsr18client_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[VSlimPsr18Client](ptr)
}
@[export: 'VSlimPsr18Client_cleanup_raw']
pub fn vslimpsr18client_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
}
@[export: 'VSlimPsr18Client_get_prop']
pub fn vslimpsr18client_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = rv
}
@[export: 'VSlimPsr18Client_set_prop']
pub fn vslimpsr18client_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = value
}
@[export: 'VSlimPsr18Client_sync_props']
pub fn vslimpsr18client_sync_props(ptr voidptr, zv &C.zval) {
    _ = ptr
    _ = zv
}
@[export: 'vphp_wrap_VSlimPsr18Client_construct']
pub fn vphp_wrap_vslimpsr18client_construct(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsr18Client(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.construct()
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimPsr18Client_timeout']
pub fn vphp_wrap_vslimpsr18client_timeout(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsr18Client(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[int](0)
    res := recv.timeout(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimPsr18Client_ignore_php_warning']
pub fn vphp_wrap_vslimpsr18client_ignore_php_warning(ctx vphp.Context)  {
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[int](0)
    arg_1 := ctx.arg[string](1)
    arg_2 := ctx.arg[string](2)
    arg_3 := ctx.arg[int](3)
    res := VSlimPsr18Client.ignore_php_warning(arg_0, arg_1, arg_2, arg_3)
    ctx.return_val[bool](res)
}
@[export: 'vphp_wrap_VSlimPsr18Client_timeout_seconds_value']
pub fn vphp_wrap_vslimpsr18client_timeout_seconds_value(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsr18Client(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.timeout_seconds_value()
    ctx.return_val[int](res)
}
@[export: 'vphp_wrap_VSlimPsr18Client_send_request']
pub fn vphp_wrap_vslimpsr18client_send_request(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsr18Client(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    res := recv.send_request(arg_0)
    return voidptr(res)
}
@[export: 'VSlimPsr18Client_handlers']
pub fn vslimpsr18client_handlers() voidptr {
    return unsafe { &C.vphp_class_handlers{
        prop_handler:  voidptr(vslimpsr18client_get_prop)
        write_handler: voidptr(vslimpsr18client_set_prop)
        sync_handler:  voidptr(vslimpsr18client_sync_props)
        new_raw:       voidptr(vslimpsr18client_new_raw)
        cleanup_raw:   voidptr(vslimpsr18client_cleanup_raw)
        free_raw:      voidptr(vslimpsr18client_free_raw)
    } }
}

@[export: 'VSlimPsr20Clock_new_raw']
pub fn vslimpsr20clock_new_raw() voidptr {
    return vphp.generic_new_raw[VSlimPsr20Clock]()
}
@[export: 'VSlimPsr20Clock_free_raw']
pub fn vslimpsr20clock_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[VSlimPsr20Clock](ptr)
}
@[export: 'VSlimPsr20Clock_cleanup_raw']
pub fn vslimpsr20clock_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
}
@[export: 'VSlimPsr20Clock_get_prop']
pub fn vslimpsr20clock_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = rv
}
@[export: 'VSlimPsr20Clock_set_prop']
pub fn vslimpsr20clock_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = value
}
@[export: 'VSlimPsr20Clock_sync_props']
pub fn vslimpsr20clock_sync_props(ptr voidptr, zv &C.zval) {
    _ = ptr
    _ = zv
}
@[export: 'vphp_wrap_VSlimPsr20Clock_construct']
pub fn vphp_wrap_vslimpsr20clock_construct(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsr20Clock(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.construct()
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimPsr20Clock_now']
pub fn vphp_wrap_vslimpsr20clock_now(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsr20Clock(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.now()
    ctx.return_val[vphp.RequestOwnedZBox](res)
}
@[export: 'VSlimPsr20Clock_handlers']
pub fn vslimpsr20clock_handlers() voidptr {
    return unsafe { &C.vphp_class_handlers{
        prop_handler:  voidptr(vslimpsr20clock_get_prop)
        write_handler: voidptr(vslimpsr20clock_set_prop)
        sync_handler:  voidptr(vslimpsr20clock_sync_props)
        new_raw:       voidptr(vslimpsr20clock_new_raw)
        cleanup_raw:   voidptr(vslimpsr20clock_cleanup_raw)
        free_raw:      voidptr(vslimpsr20clock_free_raw)
    } }
}

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
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.construct()
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimPsr14ListenerProvider_listen']
pub fn vphp_wrap_vslimpsr14listenerprovider_listen(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsr14ListenerProvider(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    arg_1 := ctx.arg_borrowed_zbox(1)
    res := recv.listen(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimPsr14ListenerProvider_listen_any']
pub fn vphp_wrap_vslimpsr14listenerprovider_listen_any(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsr14ListenerProvider(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    res := recv.listen_any(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimPsr14ListenerProvider_listener_count']
pub fn vphp_wrap_vslimpsr14listenerprovider_listener_count(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsr14ListenerProvider(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.listener_count()
    ctx.return_val[int](res)
}
@[export: 'vphp_wrap_VSlimPsr14ListenerProvider_get_listeners_for_event']
pub fn vphp_wrap_vslimpsr14listenerprovider_get_listeners_for_event(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsr14ListenerProvider(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    res := recv.get_listeners_for_event(arg_0)
    ctx.return_val[vphp.RequestOwnedZBox](res)
}
@[export: 'VSlimPsr14ListenerProvider_handlers']
pub fn vslimpsr14listenerprovider_handlers() voidptr {
    return unsafe { &C.vphp_class_handlers{
        prop_handler:  voidptr(vslimpsr14listenerprovider_get_prop)
        write_handler: voidptr(vslimpsr14listenerprovider_set_prop)
        sync_handler:  voidptr(vslimpsr14listenerprovider_sync_props)
        new_raw:       voidptr(vslimpsr14listenerprovider_new_raw)
        cleanup_raw:   voidptr(vslimpsr14listenerprovider_cleanup_raw)
        free_raw:      voidptr(vslimpsr14listenerprovider_free_raw)
    } }
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
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.construct()
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimPsr14EventDispatcher_set_provider']
pub fn vphp_wrap_vslimpsr14eventdispatcher_set_provider(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsr14EventDispatcher(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := unsafe { &VSlimPsr14ListenerProvider(ctx.arg_raw_obj(0)) }
    res := recv.set_provider(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimPsr14EventDispatcher_provider']
pub fn vphp_wrap_vslimpsr14eventdispatcher_provider(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsr14EventDispatcher(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.provider()
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimPsr14EventDispatcher_listen']
pub fn vphp_wrap_vslimpsr14eventdispatcher_listen(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsr14EventDispatcher(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    arg_1 := ctx.arg_borrowed_zbox(1)
    res := recv.listen(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimPsr14EventDispatcher_listen_any']
pub fn vphp_wrap_vslimpsr14eventdispatcher_listen_any(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsr14EventDispatcher(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    res := recv.listen_any(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimPsr14EventDispatcher_dispatch']
pub fn vphp_wrap_vslimpsr14eventdispatcher_dispatch(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsr14EventDispatcher(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    res := recv.dispatch(arg_0)
    ctx.return_val[vphp.RequestOwnedZBox](res)
}
@[export: 'VSlimPsr14EventDispatcher_handlers']
pub fn vslimpsr14eventdispatcher_handlers() voidptr {
    return unsafe { &C.vphp_class_handlers{
        prop_handler:  voidptr(vslimpsr14eventdispatcher_get_prop)
        write_handler: voidptr(vslimpsr14eventdispatcher_set_prop)
        sync_handler:  voidptr(vslimpsr14eventdispatcher_sync_props)
        new_raw:       voidptr(vslimpsr14eventdispatcher_new_raw)
        cleanup_raw:   voidptr(vslimpsr14eventdispatcher_cleanup_raw)
        free_raw:      voidptr(vslimpsr14eventdispatcher_free_raw)
    } }
}

@[export: 'VSlimPhpSignatureProbe_new_raw']
pub fn vslimphpsignatureprobe_new_raw() voidptr {
    return vphp.generic_new_raw[VSlimPhpSignatureProbe]()
}
@[export: 'VSlimPhpSignatureProbe_free_raw']
pub fn vslimphpsignatureprobe_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[VSlimPhpSignatureProbe](ptr)
}
@[export: 'VSlimPhpSignatureProbe_cleanup_raw']
pub fn vslimphpsignatureprobe_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
}
@[export: 'VSlimPhpSignatureProbe_get_prop']
pub fn vslimphpsignatureprobe_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = rv
}
@[export: 'VSlimPhpSignatureProbe_set_prop']
pub fn vslimphpsignatureprobe_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = value
}
@[export: 'VSlimPhpSignatureProbe_sync_props']
pub fn vslimphpsignatureprobe_sync_props(ptr voidptr, zv &C.zval) {
    _ = ptr
    _ = zv
}
@[export: 'vphp_wrap_VSlimPhpSignatureProbe_construct']
pub fn vphp_wrap_vslimphpsignatureprobe_construct(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPhpSignatureProbe(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.construct()
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimPhpSignatureProbe_always_true']
pub fn vphp_wrap_vslimphpsignatureprobe_always_true(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPhpSignatureProbe(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.always_true()
    ctx.return_val[bool](res)
}
@[export: 'vphp_wrap_VSlimPhpSignatureProbe_always_false']
pub fn vphp_wrap_vslimphpsignatureprobe_always_false(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPhpSignatureProbe(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.always_false()
    ctx.return_val[bool](res)
}
@[export: 'vphp_wrap_VSlimPhpSignatureProbe_always_null']
pub fn vphp_wrap_vslimphpsignatureprobe_always_null(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPhpSignatureProbe(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.always_null()
    ctx.return_val[vphp.RequestOwnedZBox](res)
}
@[export: 'vphp_wrap_VSlimPhpSignatureProbe_always_throw']
pub fn vphp_wrap_vslimphpsignatureprobe_always_throw(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPhpSignatureProbe(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.always_throw()
    ctx.return_val[vphp.RequestOwnedZBox](res)
}
@[export: 'vphp_wrap_VSlimPhpSignatureProbe_accept_true']
pub fn vphp_wrap_vslimphpsignatureprobe_accept_true(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPhpSignatureProbe(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    res := recv.accept_true(arg_0)
    ctx.return_val[bool](res)
}
@[export: 'vphp_wrap_VSlimPhpSignatureProbe_accept_false']
pub fn vphp_wrap_vslimphpsignatureprobe_accept_false(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPhpSignatureProbe(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    res := recv.accept_false(arg_0)
    ctx.return_val[bool](res)
}
@[export: 'vphp_wrap_VSlimPhpSignatureProbe_accept_null']
pub fn vphp_wrap_vslimphpsignatureprobe_accept_null(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPhpSignatureProbe(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    res := recv.accept_null(arg_0)
    ctx.return_val[bool](res)
}
@[export: 'vphp_wrap_VSlimPhpSignatureProbe_accept_callable']
pub fn vphp_wrap_vslimphpsignatureprobe_accept_callable(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPhpSignatureProbe(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    res := recv.accept_callable(arg_0)
    ctx.return_val[bool](res)
}
@[export: 'vphp_wrap_VSlimPhpSignatureProbe_optional_tail']
pub fn vphp_wrap_vslimphpsignatureprobe_optional_tail(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPhpSignatureProbe(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    arg_1 := ctx.arg[string](1)
    res := recv.optional_tail(arg_0, arg_1)
    ctx.return_val[string](res)
}
@[export: 'vphp_wrap_VSlimPhpSignatureProbe_make_psr_response']
pub fn vphp_wrap_vslimphpsignatureprobe_make_psr_response(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPhpSignatureProbe(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.make_psr_response()
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimPhpSignatureProbe_make_static_psr_response']
pub fn vphp_wrap_vslimphpsignatureprobe_make_static_psr_response(ctx vphp.Context) voidptr {
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := VSlimPhpSignatureProbe.make_static_psr_response()
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimPhpSignatureProbe_accept_psr_request']
pub fn vphp_wrap_vslimphpsignatureprobe_accept_psr_request(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPhpSignatureProbe(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    res := recv.accept_psr_request(arg_0)
    ctx.return_val[bool](res)
}
@[export: 'vphp_wrap_VSlimPhpSignatureProbe_accept_datetime_interface']
pub fn vphp_wrap_vslimphpsignatureprobe_accept_datetime_interface(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPhpSignatureProbe(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    res := recv.accept_datetime_interface(arg_0)
    ctx.return_val[bool](res)
}
@[export: 'vphp_wrap_VSlimPhpSignatureProbe_set_provider']
pub fn vphp_wrap_vslimphpsignatureprobe_set_provider(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPhpSignatureProbe(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := unsafe { &VSlimPsr14ListenerProvider(ctx.arg_raw_obj(0)) }
    res := recv.set_provider(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimPhpSignatureProbe_borrowed_provider']
pub fn vphp_wrap_vslimphpsignatureprobe_borrowed_provider(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPhpSignatureProbe(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.borrowed_provider()
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimPhpSignatureProbe_borrowed_provider_alias']
pub fn vphp_wrap_vslimphpsignatureprobe_borrowed_provider_alias(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPhpSignatureProbe(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.borrowed_provider_alias()
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimPhpSignatureProbe_borrowed_provider_from_guard']
pub fn vphp_wrap_vslimphpsignatureprobe_borrowed_provider_from_guard(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPhpSignatureProbe(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.borrowed_provider_from_guard()
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimPhpSignatureProbe_borrowed_provider_from_if_expr']
pub fn vphp_wrap_vslimphpsignatureprobe_borrowed_provider_from_if_expr(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPhpSignatureProbe(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[bool](0)
    res := recv.borrowed_provider_from_if_expr(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimPhpSignatureProbe_borrowed_provider_from_if_expr_alias']
pub fn vphp_wrap_vslimphpsignatureprobe_borrowed_provider_from_if_expr_alias(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPhpSignatureProbe(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[bool](0)
    res := recv.borrowed_provider_from_if_expr_alias(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimPhpSignatureProbe_borrowed_provider_from_match_expr']
pub fn vphp_wrap_vslimphpsignatureprobe_borrowed_provider_from_match_expr(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPhpSignatureProbe(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[bool](0)
    res := recv.borrowed_provider_from_match_expr(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimPhpSignatureProbe_borrowed_provider_from_match_expr_alias']
pub fn vphp_wrap_vslimphpsignatureprobe_borrowed_provider_from_match_expr_alias(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPhpSignatureProbe(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[bool](0)
    res := recv.borrowed_provider_from_match_expr_alias(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimPhpSignatureProbe_borrowed_provider_from_or_block']
pub fn vphp_wrap_vslimphpsignatureprobe_borrowed_provider_from_or_block(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPhpSignatureProbe(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.borrowed_provider_from_or_block()
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimPhpSignatureProbe_borrowed_provider_from_or_block_alias']
pub fn vphp_wrap_vslimphpsignatureprobe_borrowed_provider_from_or_block_alias(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPhpSignatureProbe(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.borrowed_provider_from_or_block_alias()
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimPhpSignatureProbe_fresh_provider']
pub fn vphp_wrap_vslimphpsignatureprobe_fresh_provider(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPhpSignatureProbe(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.fresh_provider()
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimPhpSignatureProbe_fresh_provider_alias']
pub fn vphp_wrap_vslimphpsignatureprobe_fresh_provider_alias(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPhpSignatureProbe(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.fresh_provider_alias()
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimPhpSignatureProbe_fresh_provider_from_if_expr']
pub fn vphp_wrap_vslimphpsignatureprobe_fresh_provider_from_if_expr(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPhpSignatureProbe(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[bool](0)
    res := recv.fresh_provider_from_if_expr(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimPhpSignatureProbe_fresh_provider_from_if_expr_alias']
pub fn vphp_wrap_vslimphpsignatureprobe_fresh_provider_from_if_expr_alias(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPhpSignatureProbe(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[bool](0)
    res := recv.fresh_provider_from_if_expr_alias(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimPhpSignatureProbe_fresh_provider_from_match_expr']
pub fn vphp_wrap_vslimphpsignatureprobe_fresh_provider_from_match_expr(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPhpSignatureProbe(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[bool](0)
    res := recv.fresh_provider_from_match_expr(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimPhpSignatureProbe_fresh_provider_from_match_expr_alias']
pub fn vphp_wrap_vslimphpsignatureprobe_fresh_provider_from_match_expr_alias(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPhpSignatureProbe(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[bool](0)
    res := recv.fresh_provider_from_match_expr_alias(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimPhpSignatureProbe_fresh_provider_from_or_block']
pub fn vphp_wrap_vslimphpsignatureprobe_fresh_provider_from_or_block(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPhpSignatureProbe(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.fresh_provider_from_or_block()
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimPhpSignatureProbe_fresh_provider_from_or_block_alias']
pub fn vphp_wrap_vslimphpsignatureprobe_fresh_provider_from_or_block_alias(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPhpSignatureProbe(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.fresh_provider_from_or_block_alias()
    return voidptr(res)
}
@[export: 'VSlimPhpSignatureProbe_handlers']
pub fn vslimphpsignatureprobe_handlers() voidptr {
    return unsafe { &C.vphp_class_handlers{
        prop_handler:  voidptr(vslimphpsignatureprobe_get_prop)
        write_handler: voidptr(vslimphpsignatureprobe_set_prop)
        sync_handler:  voidptr(vslimphpsignatureprobe_sync_props)
        new_raw:       voidptr(vslimphpsignatureprobe_new_raw)
        cleanup_raw:   voidptr(vslimphpsignatureprobe_cleanup_raw)
        free_raw:      voidptr(vslimphpsignatureprobe_free_raw)
    } }
}

@[export: 'VSlimLiveSocket_new_raw']
pub fn vslimlivesocket_new_raw() voidptr {
    return vphp.generic_new_raw[VSlimLiveSocket]()
}
@[export: 'VSlimLiveSocket_free_raw']
pub fn vslimlivesocket_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[VSlimLiveSocket](ptr)
}
@[export: 'VSlimLiveSocket_cleanup_raw']
pub fn vslimlivesocket_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
}
@[export: 'VSlimLiveSocket_get_prop']
pub fn vslimlivesocket_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = rv
}
@[export: 'VSlimLiveSocket_set_prop']
pub fn vslimlivesocket_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = value
}
@[export: 'VSlimLiveSocket_sync_props']
pub fn vslimlivesocket_sync_props(ptr voidptr, zv &C.zval) {
    _ = ptr
    _ = zv
}
@[export: 'vphp_wrap_VSlimLiveSocket_construct']
pub fn vphp_wrap_vslimlivesocket_construct(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLiveSocket(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.construct()
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimLiveSocket_set_id']
pub fn vphp_wrap_vslimlivesocket_set_id(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLiveSocket(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    res := recv.set_id(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimLiveSocket_id']
pub fn vphp_wrap_vslimlivesocket_id(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimLiveSocket(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.id()
    ctx.return_val[string](res)
}
@[export: 'vphp_wrap_VSlimLiveSocket_set_connected']
pub fn vphp_wrap_vslimlivesocket_set_connected(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLiveSocket(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[bool](0)
    res := recv.set_connected(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimLiveSocket_connected']
pub fn vphp_wrap_vslimlivesocket_connected(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimLiveSocket(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.connected()
    ctx.return_val[bool](res)
}
@[export: 'vphp_wrap_VSlimLiveSocket_set_target']
pub fn vphp_wrap_vslimlivesocket_set_target(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLiveSocket(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    res := recv.set_target(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimLiveSocket_target']
pub fn vphp_wrap_vslimlivesocket_target(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimLiveSocket(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.target()
    ctx.return_val[string](res)
}
@[export: 'vphp_wrap_VSlimLiveSocket_set_root_id']
pub fn vphp_wrap_vslimlivesocket_set_root_id(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLiveSocket(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    res := recv.set_root_id(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimLiveSocket_root_id']
pub fn vphp_wrap_vslimlivesocket_root_id(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimLiveSocket(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.root_id()
    ctx.return_val[string](res)
}
@[export: 'vphp_wrap_VSlimLiveSocket_assign']
pub fn vphp_wrap_vslimlivesocket_assign(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLiveSocket(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    arg_1 := ctx.arg_borrowed_zbox(1)
    res := recv.assign(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimLiveSocket_assign_many']
pub fn vphp_wrap_vslimlivesocket_assign_many(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLiveSocket(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    res := recv.assign_many(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimLiveSocket_assign_form']
pub fn vphp_wrap_vslimlivesocket_assign_form(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLiveSocket(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    res := recv.assign_form(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimLiveSocket_reset_form']
pub fn vphp_wrap_vslimlivesocket_reset_form(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLiveSocket(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    res := recv.reset_form(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimLiveSocket_forget']
pub fn vphp_wrap_vslimlivesocket_forget(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLiveSocket(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    res := recv.forget(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimLiveSocket_forget_input']
pub fn vphp_wrap_vslimlivesocket_forget_input(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLiveSocket(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    res := recv.forget_input(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimLiveSocket_forget_inputs']
pub fn vphp_wrap_vslimlivesocket_forget_inputs(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLiveSocket(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    res := recv.forget_inputs(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimLiveSocket_clear_assigns']
pub fn vphp_wrap_vslimlivesocket_clear_assigns(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLiveSocket(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.clear_assigns()
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimLiveSocket_assign_component_state']
pub fn vphp_wrap_vslimlivesocket_assign_component_state(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLiveSocket(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    arg_1 := ctx.arg[string](1)
    arg_2 := ctx.arg_borrowed_zbox(2)
    res := recv.assign_component_state(arg_0, arg_1, arg_2)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimLiveSocket_component_state']
pub fn vphp_wrap_vslimlivesocket_component_state(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimLiveSocket(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    arg_1 := ctx.arg[string](1)
    res := recv.component_state(arg_0, arg_1)
    ctx.return_val[string](res)
}
@[export: 'vphp_wrap_VSlimLiveSocket_component_state_or']
pub fn vphp_wrap_vslimlivesocket_component_state_or(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimLiveSocket(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    arg_1 := ctx.arg[string](1)
    arg_2 := ctx.arg[string](2)
    res := recv.component_state_or(arg_0, arg_1, arg_2)
    ctx.return_val[string](res)
}
@[export: 'vphp_wrap_VSlimLiveSocket_clear_component_state']
pub fn vphp_wrap_vslimlivesocket_clear_component_state(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLiveSocket(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    arg_1 := ctx.arg[string](1)
    res := recv.clear_component_state(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimLiveSocket_assign_error']
pub fn vphp_wrap_vslimlivesocket_assign_error(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLiveSocket(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    arg_1 := ctx.arg[string](1)
    res := recv.assign_error(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimLiveSocket_assign_errors']
pub fn vphp_wrap_vslimlivesocket_assign_errors(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLiveSocket(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    res := recv.assign_errors(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimLiveSocket_clear_error']
pub fn vphp_wrap_vslimlivesocket_clear_error(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLiveSocket(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    res := recv.clear_error(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimLiveSocket_clear_errors']
pub fn vphp_wrap_vslimlivesocket_clear_errors(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLiveSocket(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.clear_errors()
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimLiveSocket_input']
pub fn vphp_wrap_vslimlivesocket_input(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimLiveSocket(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    res := recv.input(arg_0)
    ctx.return_val[string](res)
}
@[export: 'vphp_wrap_VSlimLiveSocket_input_or']
pub fn vphp_wrap_vslimlivesocket_input_or(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimLiveSocket(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    arg_1 := ctx.arg[string](1)
    res := recv.input_or(arg_0, arg_1)
    ctx.return_val[string](res)
}
@[export: 'vphp_wrap_VSlimLiveSocket_old']
pub fn vphp_wrap_vslimlivesocket_old(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimLiveSocket(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    res := recv.old(arg_0)
    ctx.return_val[string](res)
}
@[export: 'vphp_wrap_VSlimLiveSocket_old_or']
pub fn vphp_wrap_vslimlivesocket_old_or(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimLiveSocket(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    arg_1 := ctx.arg[string](1)
    res := recv.old_or(arg_0, arg_1)
    ctx.return_val[string](res)
}
@[export: 'vphp_wrap_VSlimLiveSocket_error']
pub fn vphp_wrap_vslimlivesocket_error(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimLiveSocket(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    res := recv.error(arg_0)
    ctx.return_val[string](res)
}
@[export: 'vphp_wrap_VSlimLiveSocket_has_error']
pub fn vphp_wrap_vslimlivesocket_has_error(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimLiveSocket(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    res := recv.has_error(arg_0)
    ctx.return_val[bool](res)
}
@[export: 'vphp_wrap_VSlimLiveSocket_form']
pub fn vphp_wrap_vslimlivesocket_form(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLiveSocket(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    res := recv.form(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimLiveSocket_get']
pub fn vphp_wrap_vslimlivesocket_get(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimLiveSocket(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    res := recv.get(arg_0)
    ctx.return_val[string](res)
}
@[export: 'vphp_wrap_VSlimLiveSocket_has']
pub fn vphp_wrap_vslimlivesocket_has(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimLiveSocket(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    res := recv.has(arg_0)
    ctx.return_val[bool](res)
}
@[export: 'vphp_wrap_VSlimLiveSocket_assigns']
pub fn vphp_wrap_vslimlivesocket_assigns(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimLiveSocket(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.assigns()
    ctx.return_val[map[string]string](res)
}
@[export: 'vphp_wrap_VSlimLiveSocket_patch']
pub fn vphp_wrap_vslimlivesocket_patch(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLiveSocket(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    arg_1 := ctx.arg[string](1)
    res := recv.patch(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimLiveSocket_append']
pub fn vphp_wrap_vslimlivesocket_append(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLiveSocket(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    arg_1 := ctx.arg[string](1)
    res := recv.append(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimLiveSocket_prepend']
pub fn vphp_wrap_vslimlivesocket_prepend(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLiveSocket(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    arg_1 := ctx.arg[string](1)
    res := recv.prepend(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimLiveSocket_set_text']
pub fn vphp_wrap_vslimlivesocket_set_text(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLiveSocket(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    arg_1 := ctx.arg[string](1)
    res := recv.set_text(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimLiveSocket_set_attr']
pub fn vphp_wrap_vslimlivesocket_set_attr(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLiveSocket(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    arg_1 := ctx.arg[string](1)
    arg_2 := ctx.arg[string](2)
    res := recv.set_attr(arg_0, arg_1, arg_2)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimLiveSocket_remove']
pub fn vphp_wrap_vslimlivesocket_remove(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLiveSocket(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    res := recv.remove(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimLiveSocket_patches']
pub fn vphp_wrap_vslimlivesocket_patches(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimLiveSocket(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.patches()
    ctx.return_val[[]map[string]string](res)
}
@[export: 'vphp_wrap_VSlimLiveSocket_clear_patches']
pub fn vphp_wrap_vslimlivesocket_clear_patches(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLiveSocket(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.clear_patches()
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimLiveSocket_push_event']
pub fn vphp_wrap_vslimlivesocket_push_event(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLiveSocket(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    arg_1 := ctx.arg[string](1)
    res := recv.push_event(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimLiveSocket_events']
pub fn vphp_wrap_vslimlivesocket_events(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimLiveSocket(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.events()
    ctx.return_val[[]map[string]string](res)
}
@[export: 'vphp_wrap_VSlimLiveSocket_clear_events']
pub fn vphp_wrap_vslimlivesocket_clear_events(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLiveSocket(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.clear_events()
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimLiveSocket_flash']
pub fn vphp_wrap_vslimlivesocket_flash(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLiveSocket(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    arg_1 := ctx.arg[string](1)
    res := recv.flash(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimLiveSocket_flashes']
pub fn vphp_wrap_vslimlivesocket_flashes(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimLiveSocket(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.flashes()
    ctx.return_val[[]map[string]string](res)
}
@[export: 'vphp_wrap_VSlimLiveSocket_clear_flashes']
pub fn vphp_wrap_vslimlivesocket_clear_flashes(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLiveSocket(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.clear_flashes()
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimLiveSocket_join_topic']
pub fn vphp_wrap_vslimlivesocket_join_topic(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLiveSocket(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    res := recv.join_topic(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimLiveSocket_leave_topic']
pub fn vphp_wrap_vslimlivesocket_leave_topic(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLiveSocket(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    res := recv.leave_topic(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimLiveSocket_broadcast_info']
pub fn vphp_wrap_vslimlivesocket_broadcast_info(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLiveSocket(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    arg_1 := ctx.arg[string](1)
    arg_2 := ctx.arg_borrowed_zbox(2)
    arg_3 := ctx.arg[bool](3)
    res := recv.broadcast_info(arg_0, arg_1, arg_2, arg_3)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimLiveSocket_pubsub_commands']
pub fn vphp_wrap_vslimlivesocket_pubsub_commands(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimLiveSocket(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.pubsub_commands()
    ctx.return_val[[]map[string]string](res)
}
@[export: 'vphp_wrap_VSlimLiveSocket_clear_pubsub']
pub fn vphp_wrap_vslimlivesocket_clear_pubsub(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLiveSocket(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.clear_pubsub()
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimLiveSocket_redirect']
pub fn vphp_wrap_vslimlivesocket_redirect(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLiveSocket(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    res := recv.redirect(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimLiveSocket_redirect_to']
pub fn vphp_wrap_vslimlivesocket_redirect_to(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimLiveSocket(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.redirect_to()
    ctx.return_val[string](res)
}
@[export: 'vphp_wrap_VSlimLiveSocket_clear_redirect']
pub fn vphp_wrap_vslimlivesocket_clear_redirect(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLiveSocket(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.clear_redirect()
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimLiveSocket_navigate']
pub fn vphp_wrap_vslimlivesocket_navigate(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLiveSocket(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    res := recv.navigate(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimLiveSocket_navigate_to']
pub fn vphp_wrap_vslimlivesocket_navigate_to(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimLiveSocket(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.navigate_to()
    ctx.return_val[string](res)
}
@[export: 'vphp_wrap_VSlimLiveSocket_clear_navigate']
pub fn vphp_wrap_vslimlivesocket_clear_navigate(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLiveSocket(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.clear_navigate()
    return voidptr(res)
}
@[export: 'VSlimLiveSocket_handlers']
pub fn vslimlivesocket_handlers() voidptr {
    return unsafe { &C.vphp_class_handlers{
        prop_handler:  voidptr(vslimlivesocket_get_prop)
        write_handler: voidptr(vslimlivesocket_set_prop)
        sync_handler:  voidptr(vslimlivesocket_sync_props)
        new_raw:       voidptr(vslimlivesocket_new_raw)
        cleanup_raw:   voidptr(vslimlivesocket_cleanup_raw)
        free_raw:      voidptr(vslimlivesocket_free_raw)
    } }
}

@[export: 'VSlimLiveForm_new_raw']
pub fn vslimliveform_new_raw() voidptr {
    return vphp.generic_new_raw[VSlimLiveForm]()
}
@[export: 'VSlimLiveForm_free_raw']
pub fn vslimliveform_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[VSlimLiveForm](ptr)
}
@[export: 'VSlimLiveForm_cleanup_raw']
pub fn vslimliveform_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
}
@[export: 'VSlimLiveForm_get_prop']
pub fn vslimliveform_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = rv
}
@[export: 'VSlimLiveForm_set_prop']
pub fn vslimliveform_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = value
}
@[export: 'VSlimLiveForm_sync_props']
pub fn vslimliveform_sync_props(ptr voidptr, zv &C.zval) {
    _ = ptr
    _ = zv
}
@[export: 'vphp_wrap_VSlimLiveForm_name']
pub fn vphp_wrap_vslimliveform_name(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimLiveForm(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.name()
    ctx.return_val[string](res)
}
@[export: 'vphp_wrap_VSlimLiveForm_available']
pub fn vphp_wrap_vslimliveform_available(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimLiveForm(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.available()
    ctx.return_val[bool](res)
}
@[export: 'vphp_wrap_VSlimLiveForm_fill']
pub fn vphp_wrap_vslimliveform_fill(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLiveForm(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    res := recv.fill(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimLiveForm_reset']
pub fn vphp_wrap_vslimliveform_reset(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLiveForm(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    res := recv.reset(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimLiveForm_validate']
pub fn vphp_wrap_vslimliveform_validate(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLiveForm(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    res := recv.validate(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimLiveForm_errors']
pub fn vphp_wrap_vslimliveform_errors(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLiveForm(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    res := recv.errors(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimLiveForm_clear_errors']
pub fn vphp_wrap_vslimliveform_clear_errors(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLiveForm(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.clear_errors()
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimLiveForm_clear_error']
pub fn vphp_wrap_vslimliveform_clear_error(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLiveForm(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    res := recv.clear_error(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimLiveForm_forget']
pub fn vphp_wrap_vslimliveform_forget(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLiveForm(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    res := recv.forget(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimLiveForm_forget_many']
pub fn vphp_wrap_vslimliveform_forget_many(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLiveForm(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    res := recv.forget_many(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimLiveForm_input']
pub fn vphp_wrap_vslimliveform_input(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimLiveForm(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    res := recv.input(arg_0)
    ctx.return_val[string](res)
}
@[export: 'vphp_wrap_VSlimLiveForm_input_or']
pub fn vphp_wrap_vslimliveform_input_or(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimLiveForm(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    arg_1 := ctx.arg[string](1)
    res := recv.input_or(arg_0, arg_1)
    ctx.return_val[string](res)
}
@[export: 'vphp_wrap_VSlimLiveForm_error']
pub fn vphp_wrap_vslimliveform_error(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimLiveForm(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    res := recv.error(arg_0)
    ctx.return_val[string](res)
}
@[export: 'vphp_wrap_VSlimLiveForm_has_error']
pub fn vphp_wrap_vslimliveform_has_error(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimLiveForm(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    res := recv.has_error(arg_0)
    ctx.return_val[bool](res)
}
@[export: 'vphp_wrap_VSlimLiveForm_valid']
pub fn vphp_wrap_vslimliveform_valid(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimLiveForm(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.valid()
    ctx.return_val[bool](res)
}
@[export: 'vphp_wrap_VSlimLiveForm_invalid']
pub fn vphp_wrap_vslimliveform_invalid(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimLiveForm(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.invalid()
    ctx.return_val[bool](res)
}
@[export: 'vphp_wrap_VSlimLiveForm_error_count']
pub fn vphp_wrap_vslimliveform_error_count(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimLiveForm(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.error_count()
    ctx.return_val[int](res)
}
@[export: 'vphp_wrap_VSlimLiveForm_data']
pub fn vphp_wrap_vslimliveform_data(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimLiveForm(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.data()
    ctx.return_val[vphp.RequestOwnedZBox](res)
}
@[export: 'VSlimLiveForm_handlers']
pub fn vslimliveform_handlers() voidptr {
    return unsafe { &C.vphp_class_handlers{
        prop_handler:  voidptr(vslimliveform_get_prop)
        write_handler: voidptr(vslimliveform_set_prop)
        sync_handler:  voidptr(vslimliveform_sync_props)
        new_raw:       voidptr(vslimliveform_new_raw)
        cleanup_raw:   voidptr(vslimliveform_cleanup_raw)
        free_raw:      voidptr(vslimliveform_free_raw)
    } }
}

@[export: 'VSlimLiveView_new_raw']
pub fn vslimliveview_new_raw() voidptr {
    return vphp.generic_new_raw[VSlimLiveView]()
}
@[export: 'VSlimLiveView_free_raw']
pub fn vslimliveview_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[VSlimLiveView](ptr)
}
@[export: 'VSlimLiveView_cleanup_raw']
pub fn vslimliveview_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
}
@[export: 'VSlimLiveView_get_prop']
pub fn vslimliveview_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = rv
}
@[export: 'VSlimLiveView_set_prop']
pub fn vslimliveview_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = value
}
@[export: 'VSlimLiveView_sync_props']
pub fn vslimliveview_sync_props(ptr voidptr, zv &C.zval) {
    _ = ptr
    _ = zv
}
@[export: 'vphp_wrap_VSlimLiveView_construct']
pub fn vphp_wrap_vslimliveview_construct(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLiveView(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.construct()
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimLiveView_set_app']
pub fn vphp_wrap_vslimliveview_set_app(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLiveView(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := unsafe { &VSlimApp(ctx.arg_raw_obj(0)) }
    res := recv.set_app(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimLiveView_set_view']
pub fn vphp_wrap_vslimliveview_set_view(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLiveView(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := unsafe { &VSlimView(ctx.arg_raw_obj(0)) }
    res := recv.set_view(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimLiveView_view']
pub fn vphp_wrap_vslimliveview_view(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLiveView(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.view()
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimLiveView_set_template']
pub fn vphp_wrap_vslimliveview_set_template(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLiveView(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    res := recv.set_template(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimLiveView_template']
pub fn vphp_wrap_vslimliveview_template(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimLiveView(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.template()
    ctx.return_val[string](res)
}
@[export: 'vphp_wrap_VSlimLiveView_set_layout']
pub fn vphp_wrap_vslimliveview_set_layout(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLiveView(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    res := recv.set_layout(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimLiveView_layout']
pub fn vphp_wrap_vslimliveview_layout(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimLiveView(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.layout()
    ctx.return_val[string](res)
}
@[export: 'vphp_wrap_VSlimLiveView_set_root_id']
pub fn vphp_wrap_vslimliveview_set_root_id(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLiveView(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    res := recv.set_root_id(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimLiveView_root_id']
pub fn vphp_wrap_vslimliveview_root_id(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimLiveView(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.root_id()
    ctx.return_val[string](res)
}
@[export: 'vphp_wrap_VSlimLiveView_live_marker']
pub fn vphp_wrap_vslimliveview_live_marker(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimLiveView(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.live_marker()
    ctx.return_val[bool](res)
}
@[export: 'vphp_wrap_VSlimLiveView_attr_prefix']
pub fn vphp_wrap_vslimliveview_attr_prefix(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimLiveView(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.attr_prefix()
    ctx.return_val[string](res)
}
@[export: 'vphp_wrap_VSlimLiveView_attr_name']
pub fn vphp_wrap_vslimliveview_attr_name(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimLiveView(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    res := recv.attr_name(arg_0)
    ctx.return_val[string](res)
}
@[export: 'vphp_wrap_VSlimLiveView_runtime_asset']
pub fn vphp_wrap_vslimliveview_runtime_asset(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimLiveView(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.runtime_asset()
    ctx.return_val[string](res)
}
@[export: 'vphp_wrap_VSlimLiveView_runtime_script_tag']
pub fn vphp_wrap_vslimliveview_runtime_script_tag(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimLiveView(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.runtime_script_tag()
    ctx.return_val[string](res)
}
@[export: 'vphp_wrap_VSlimLiveView_bootstrap_attrs']
pub fn vphp_wrap_vslimliveview_bootstrap_attrs(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimLiveView(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := unsafe { &VSlimLiveSocket(ctx.arg_raw_obj(0)) }
    arg_1 := ctx.arg[string](1)
    res := recv.bootstrap_attrs(arg_0, arg_1)
    ctx.return_val[string](res)
}
@[export: 'vphp_wrap_VSlimLiveView_render_template']
pub fn vphp_wrap_vslimliveview_render_template(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimLiveView(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    arg_1 := ctx.arg_borrowed_zbox(1)
    res := recv.render_template(arg_0, arg_1)
    ctx.return_val[string](res)
}
@[export: 'vphp_wrap_VSlimLiveView_render_template_with_layout']
pub fn vphp_wrap_vslimliveview_render_template_with_layout(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimLiveView(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    arg_1 := ctx.arg[string](1)
    arg_2 := ctx.arg_borrowed_zbox(2)
    res := recv.render_template_with_layout(arg_0, arg_1, arg_2)
    ctx.return_val[string](res)
}
@[export: 'vphp_wrap_VSlimLiveView_render_socket']
pub fn vphp_wrap_vslimliveview_render_socket(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimLiveView(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    arg_1 := unsafe { &VSlimLiveSocket(ctx.arg_raw_obj(1)) }
    res := recv.render_socket(arg_0, arg_1)
    ctx.return_val[string](res)
}
@[export: 'vphp_wrap_VSlimLiveView_render_socket_with_layout']
pub fn vphp_wrap_vslimliveview_render_socket_with_layout(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimLiveView(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    arg_1 := ctx.arg[string](1)
    arg_2 := unsafe { &VSlimLiveSocket(ctx.arg_raw_obj(2)) }
    res := recv.render_socket_with_layout(arg_0, arg_1, arg_2)
    ctx.return_val[string](res)
}
@[export: 'vphp_wrap_VSlimLiveView_html']
pub fn vphp_wrap_vslimliveview_html(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimLiveView(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := unsafe { &VSlimLiveSocket(ctx.arg_raw_obj(0)) }
    res := recv.html(arg_0)
    ctx.return_val[string](res)
}
@[export: 'vphp_wrap_VSlimLiveView_response']
pub fn vphp_wrap_vslimliveview_response(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLiveView(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := unsafe { &VSlimLiveSocket(ctx.arg_raw_obj(0)) }
    res := recv.response(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimLiveView_patch']
pub fn vphp_wrap_vslimliveview_patch(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLiveView(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := unsafe { &VSlimLiveSocket(ctx.arg_raw_obj(0)) }
    arg_1 := ctx.arg[string](1)
    res := recv.patch(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimLiveView_patch_template']
pub fn vphp_wrap_vslimliveview_patch_template(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLiveView(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := unsafe { &VSlimLiveSocket(ctx.arg_raw_obj(0)) }
    arg_1 := ctx.arg[string](1)
    arg_2 := ctx.arg[string](2)
    res := recv.patch_template(arg_0, arg_1, arg_2)
    return voidptr(res)
}
@[export: 'VSlimLiveView_handlers']
pub fn vslimliveview_handlers() voidptr {
    return unsafe { &C.vphp_class_handlers{
        prop_handler:  voidptr(vslimliveview_get_prop)
        write_handler: voidptr(vslimliveview_set_prop)
        sync_handler:  voidptr(vslimliveview_sync_props)
        new_raw:       voidptr(vslimliveview_new_raw)
        cleanup_raw:   voidptr(vslimliveview_cleanup_raw)
        free_raw:      voidptr(vslimliveview_free_raw)
    } }
}

@[export: 'VSlimLiveComponent_new_raw']
pub fn vslimlivecomponent_new_raw() voidptr {
    return vphp.generic_new_raw[VSlimLiveComponent]()
}
@[export: 'VSlimLiveComponent_free_raw']
pub fn vslimlivecomponent_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[VSlimLiveComponent](ptr)
}
@[export: 'VSlimLiveComponent_cleanup_raw']
pub fn vslimlivecomponent_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
}
@[export: 'VSlimLiveComponent_get_prop']
pub fn vslimlivecomponent_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = rv
}
@[export: 'VSlimLiveComponent_set_prop']
pub fn vslimlivecomponent_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = value
}
@[export: 'VSlimLiveComponent_sync_props']
pub fn vslimlivecomponent_sync_props(ptr voidptr, zv &C.zval) {
    _ = ptr
    _ = zv
}
@[export: 'vphp_wrap_VSlimLiveComponent_construct']
pub fn vphp_wrap_vslimlivecomponent_construct(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLiveComponent(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.construct()
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimLiveComponent_set_app']
pub fn vphp_wrap_vslimlivecomponent_set_app(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLiveComponent(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := unsafe { &VSlimApp(ctx.arg_raw_obj(0)) }
    res := recv.set_app(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimLiveComponent_set_view']
pub fn vphp_wrap_vslimlivecomponent_set_view(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLiveComponent(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := unsafe { &VSlimView(ctx.arg_raw_obj(0)) }
    res := recv.set_view(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimLiveComponent_view']
pub fn vphp_wrap_vslimlivecomponent_view(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLiveComponent(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.view()
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimLiveComponent_set_template']
pub fn vphp_wrap_vslimlivecomponent_set_template(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLiveComponent(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    res := recv.set_template(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimLiveComponent_template']
pub fn vphp_wrap_vslimlivecomponent_template(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimLiveComponent(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.template()
    ctx.return_val[string](res)
}
@[export: 'vphp_wrap_VSlimLiveComponent_set_layout']
pub fn vphp_wrap_vslimlivecomponent_set_layout(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLiveComponent(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    res := recv.set_layout(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimLiveComponent_layout']
pub fn vphp_wrap_vslimlivecomponent_layout(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimLiveComponent(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.layout()
    ctx.return_val[string](res)
}
@[export: 'vphp_wrap_VSlimLiveComponent_set_id']
pub fn vphp_wrap_vslimlivecomponent_set_id(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLiveComponent(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    res := recv.set_id(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimLiveComponent_id']
pub fn vphp_wrap_vslimlivecomponent_id(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimLiveComponent(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.id()
    ctx.return_val[string](res)
}
@[export: 'vphp_wrap_VSlimLiveComponent_bind_socket']
pub fn vphp_wrap_vslimlivecomponent_bind_socket(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLiveComponent(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := unsafe { &VSlimLiveSocket(ctx.arg_raw_obj(0)) }
    res := recv.bind_socket(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimLiveComponent_has_socket']
pub fn vphp_wrap_vslimlivecomponent_has_socket(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimLiveComponent(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.has_socket()
    ctx.return_val[bool](res)
}
@[export: 'vphp_wrap_VSlimLiveComponent_state']
pub fn vphp_wrap_vslimlivecomponent_state(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLiveComponent(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.state()
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimLiveComponent_assign']
pub fn vphp_wrap_vslimlivecomponent_assign(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLiveComponent(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    arg_1 := ctx.arg_borrowed_zbox(1)
    res := recv.assign(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimLiveComponent_assign_many']
pub fn vphp_wrap_vslimlivecomponent_assign_many(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLiveComponent(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    res := recv.assign_many(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimLiveComponent_assigns']
pub fn vphp_wrap_vslimlivecomponent_assigns(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimLiveComponent(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.assigns()
    ctx.return_val[map[string]string](res)
}
@[export: 'vphp_wrap_VSlimLiveComponent_clear_assigns']
pub fn vphp_wrap_vslimlivecomponent_clear_assigns(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLiveComponent(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.clear_assigns()
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimLiveComponent_render_template']
pub fn vphp_wrap_vslimlivecomponent_render_template(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimLiveComponent(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    arg_1 := ctx.arg_borrowed_zbox(1)
    res := recv.render_template(arg_0, arg_1)
    ctx.return_val[string](res)
}
@[export: 'vphp_wrap_VSlimLiveComponent_html']
pub fn vphp_wrap_vslimlivecomponent_html(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimLiveComponent(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.html()
    ctx.return_val[string](res)
}
@[export: 'vphp_wrap_VSlimLiveComponent_patch']
pub fn vphp_wrap_vslimlivecomponent_patch(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLiveComponent(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := unsafe { &VSlimLiveSocket(ctx.arg_raw_obj(0)) }
    res := recv.patch(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimLiveComponent_patch_bound']
pub fn vphp_wrap_vslimlivecomponent_patch_bound(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLiveComponent(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.patch_bound()
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimLiveComponent_component_marker']
pub fn vphp_wrap_vslimlivecomponent_component_marker(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimLiveComponent(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.component_marker()
    ctx.return_val[bool](res)
}
@[export: 'vphp_wrap_VSlimLiveComponent_append_to']
pub fn vphp_wrap_vslimlivecomponent_append_to(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLiveComponent(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := unsafe { &VSlimLiveSocket(ctx.arg_raw_obj(0)) }
    arg_1 := ctx.arg[string](1)
    res := recv.append_to(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimLiveComponent_append_to_bound']
pub fn vphp_wrap_vslimlivecomponent_append_to_bound(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLiveComponent(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    res := recv.append_to_bound(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimLiveComponent_prepend_to']
pub fn vphp_wrap_vslimlivecomponent_prepend_to(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLiveComponent(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := unsafe { &VSlimLiveSocket(ctx.arg_raw_obj(0)) }
    arg_1 := ctx.arg[string](1)
    res := recv.prepend_to(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimLiveComponent_prepend_to_bound']
pub fn vphp_wrap_vslimlivecomponent_prepend_to_bound(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLiveComponent(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    res := recv.prepend_to_bound(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimLiveComponent_remove']
pub fn vphp_wrap_vslimlivecomponent_remove(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLiveComponent(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := unsafe { &VSlimLiveSocket(ctx.arg_raw_obj(0)) }
    res := recv.remove(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimLiveComponent_remove_bound']
pub fn vphp_wrap_vslimlivecomponent_remove_bound(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLiveComponent(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.remove_bound()
    return voidptr(res)
}
@[export: 'VSlimLiveComponent_handlers']
pub fn vslimlivecomponent_handlers() voidptr {
    return unsafe { &C.vphp_class_handlers{
        prop_handler:  voidptr(vslimlivecomponent_get_prop)
        write_handler: voidptr(vslimlivecomponent_set_prop)
        sync_handler:  voidptr(vslimlivecomponent_sync_props)
        new_raw:       voidptr(vslimlivecomponent_new_raw)
        cleanup_raw:   voidptr(vslimlivecomponent_cleanup_raw)
        free_raw:      voidptr(vslimlivecomponent_free_raw)
    } }
}

@[export: 'VSlimLiveComponentState_new_raw']
pub fn vslimlivecomponentstate_new_raw() voidptr {
    return vphp.generic_new_raw[VSlimLiveComponentState]()
}
@[export: 'VSlimLiveComponentState_free_raw']
pub fn vslimlivecomponentstate_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[VSlimLiveComponentState](ptr)
}
@[export: 'VSlimLiveComponentState_cleanup_raw']
pub fn vslimlivecomponentstate_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
}
@[export: 'VSlimLiveComponentState_get_prop']
pub fn vslimlivecomponentstate_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = rv
}
@[export: 'VSlimLiveComponentState_set_prop']
pub fn vslimlivecomponentstate_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = value
}
@[export: 'VSlimLiveComponentState_sync_props']
pub fn vslimlivecomponentstate_sync_props(ptr voidptr, zv &C.zval) {
    _ = ptr
    _ = zv
}
@[export: 'vphp_wrap_VSlimLiveComponentState_set']
pub fn vphp_wrap_vslimlivecomponentstate_set(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLiveComponentState(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    arg_1 := ctx.arg_borrowed_zbox(1)
    res := recv.set(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimLiveComponentState_get']
pub fn vphp_wrap_vslimlivecomponentstate_get(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimLiveComponentState(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    res := recv.get(arg_0)
    ctx.return_val[string](res)
}
@[export: 'vphp_wrap_VSlimLiveComponentState_get_or']
pub fn vphp_wrap_vslimlivecomponentstate_get_or(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimLiveComponentState(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    arg_1 := ctx.arg[string](1)
    res := recv.get_or(arg_0, arg_1)
    ctx.return_val[string](res)
}
@[export: 'vphp_wrap_VSlimLiveComponentState_clear']
pub fn vphp_wrap_vslimlivecomponentstate_clear(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLiveComponentState(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    res := recv.clear(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimLiveComponentState_available']
pub fn vphp_wrap_vslimlivecomponentstate_available(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimLiveComponentState(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.available()
    ctx.return_val[bool](res)
}
@[export: 'VSlimLiveComponentState_handlers']
pub fn vslimlivecomponentstate_handlers() voidptr {
    return unsafe { &C.vphp_class_handlers{
        prop_handler:  voidptr(vslimlivecomponentstate_get_prop)
        write_handler: voidptr(vslimlivecomponentstate_set_prop)
        sync_handler:  voidptr(vslimlivecomponentstate_sync_props)
        new_raw:       voidptr(vslimlivecomponentstate_new_raw)
        cleanup_raw:   voidptr(vslimlivecomponentstate_cleanup_raw)
        free_raw:      voidptr(vslimlivecomponentstate_free_raw)
    } }
}

@[export: 'VSlimConfig_new_raw']
pub fn vslimconfig_new_raw() voidptr {
    return vphp.generic_new_raw[VSlimConfig]()
}
@[export: 'VSlimConfig_free_raw']
pub fn vslimconfig_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[VSlimConfig](ptr)
}
@[export: 'VSlimConfig_cleanup_raw']
pub fn vslimconfig_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    unsafe {
        mut obj := &VSlimConfig(ptr)
        obj.free()
    }
}
@[export: 'VSlimConfig_get_prop']
pub fn vslimconfig_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = rv
}
@[export: 'VSlimConfig_set_prop']
pub fn vslimconfig_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = value
}
@[export: 'VSlimConfig_sync_props']
pub fn vslimconfig_sync_props(ptr voidptr, zv &C.zval) {
    _ = ptr
    _ = zv
}
@[export: 'vphp_wrap_VSlimConfig_construct']
pub fn vphp_wrap_vslimconfig_construct(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimConfig(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.construct()
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimConfig_load']
pub fn vphp_wrap_vslimconfig_load(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimConfig(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    res := recv.load(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimConfig_load_text']
pub fn vphp_wrap_vslimconfig_load_text(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimConfig(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    res := recv.load_text(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimConfig_is_loaded']
pub fn vphp_wrap_vslimconfig_is_loaded(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimConfig(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.is_loaded()
    ctx.return_val[bool](res)
}
@[export: 'vphp_wrap_VSlimConfig_path']
pub fn vphp_wrap_vslimconfig_path(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimConfig(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.path()
    ctx.return_val[string](res)
}
@[export: 'vphp_wrap_VSlimConfig_has']
pub fn vphp_wrap_vslimconfig_has(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimConfig(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    res := recv.has(arg_0)
    ctx.return_val[bool](res)
}
@[export: 'vphp_wrap_VSlimConfig_get_string']
pub fn vphp_wrap_vslimconfig_get_string(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimConfig(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    arg_1 := ctx.arg[string](1)
    res := recv.get_string(arg_0, arg_1)
    ctx.return_val[string](res)
}
@[export: 'vphp_wrap_VSlimConfig_get_int']
pub fn vphp_wrap_vslimconfig_get_int(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimConfig(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    arg_1 := ctx.arg[int](1)
    res := recv.get_int(arg_0, arg_1)
    ctx.return_val[int](res)
}
@[export: 'vphp_wrap_VSlimConfig_get_bool']
pub fn vphp_wrap_vslimconfig_get_bool(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimConfig(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    arg_1 := ctx.arg[bool](1)
    res := recv.get_bool(arg_0, arg_1)
    ctx.return_val[bool](res)
}
@[export: 'vphp_wrap_VSlimConfig_get_float']
pub fn vphp_wrap_vslimconfig_get_float(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimConfig(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    arg_1 := ctx.arg[f64](1)
    res := recv.get_float(arg_0, arg_1)
    ctx.return_val[f64](res)
}
@[export: 'vphp_wrap_VSlimConfig_get_string_list']
pub fn vphp_wrap_vslimconfig_get_string_list(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimConfig(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    res := recv.get_string_list(arg_0)
    ctx.return_val[[]string](res)
}
@[export: 'vphp_wrap_VSlimConfig_get_json']
pub fn vphp_wrap_vslimconfig_get_json(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimConfig(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    arg_1 := ctx.arg[string](1)
    res := recv.get_json(arg_0, arg_1)
    ctx.return_val[string](res)
}
@[export: 'vphp_wrap_VSlimConfig_get']
pub fn vphp_wrap_vslimconfig_get(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimConfig(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    arg_1 := ctx.arg_borrowed_zbox(1)
    res := recv.get(arg_0, arg_1)
    ctx.return_val[vphp.RequestOwnedZBox](res)
}
@[export: 'vphp_wrap_VSlimConfig_get_map']
pub fn vphp_wrap_vslimconfig_get_map(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimConfig(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    arg_1 := ctx.arg_borrowed_zbox(1)
    res := recv.get_map(arg_0, arg_1)
    ctx.return_val[vphp.RequestOwnedZBox](res)
}
@[export: 'vphp_wrap_VSlimConfig_get_list']
pub fn vphp_wrap_vslimconfig_get_list(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimConfig(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    arg_1 := ctx.arg_borrowed_zbox(1)
    res := recv.get_list(arg_0, arg_1)
    ctx.return_val[vphp.RequestOwnedZBox](res)
}
@[export: 'vphp_wrap_VSlimConfig_all_json']
pub fn vphp_wrap_vslimconfig_all_json(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimConfig(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.all_json()
    ctx.return_val[string](res)
}
@[export: 'VSlimConfig_handlers']
pub fn vslimconfig_handlers() voidptr {
    return unsafe { &C.vphp_class_handlers{
        prop_handler:  voidptr(vslimconfig_get_prop)
        write_handler: voidptr(vslimconfig_set_prop)
        sync_handler:  voidptr(vslimconfig_sync_props)
        new_raw:       voidptr(vslimconfig_new_raw)
        cleanup_raw:   voidptr(vslimconfig_cleanup_raw)
        free_raw:      voidptr(vslimconfig_free_raw)
    } }
}

@[export: 'VSlimContainerException_new_raw']
pub fn vslimcontainerexception_new_raw() voidptr {
    return vphp.generic_new_raw[VSlimContainerException]()
}
@[export: 'VSlimContainerException_free_raw']
pub fn vslimcontainerexception_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[VSlimContainerException](ptr)
}
@[export: 'VSlimContainerException_cleanup_raw']
pub fn vslimcontainerexception_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
}
fn vslimcontainerexception_load_from_php(obj &C.zend_object) VSlimContainerException {
    mut recv := VSlimContainerException{}
    if obj == 0 {
        return recv
    }
    return recv
}
fn vslimcontainerexception_sync_to_php(obj &C.zend_object, recv VSlimContainerException) {
    if obj == 0 {
        return
    }
}
@[export: 'VSlimContainerException_get_prop']
pub fn vslimcontainerexception_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = rv
}
@[export: 'VSlimContainerException_set_prop']
pub fn vslimcontainerexception_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = value
}
@[export: 'VSlimContainerException_sync_props']
pub fn vslimcontainerexception_sync_props(ptr voidptr, zv &C.zval) {
    _ = ptr
    _ = zv
}
@[export: 'VSlimContainerException_handlers']
pub fn vslimcontainerexception_handlers() voidptr {
    return unsafe { &C.vphp_class_handlers{
        prop_handler:  voidptr(vslimcontainerexception_get_prop)
        write_handler: voidptr(vslimcontainerexception_set_prop)
        sync_handler:  voidptr(vslimcontainerexception_sync_props)
        new_raw:       voidptr(vslimcontainerexception_new_raw)
        cleanup_raw:   voidptr(vslimcontainerexception_cleanup_raw)
        free_raw:      voidptr(vslimcontainerexception_free_raw)
    } }
}

@[export: 'VSlimContainerNotFoundException_new_raw']
pub fn vslimcontainernotfoundexception_new_raw() voidptr {
    return vphp.generic_new_raw[VSlimContainerNotFoundException]()
}
@[export: 'VSlimContainerNotFoundException_free_raw']
pub fn vslimcontainernotfoundexception_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[VSlimContainerNotFoundException](ptr)
}
@[export: 'VSlimContainerNotFoundException_cleanup_raw']
pub fn vslimcontainernotfoundexception_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
}
fn vslimcontainernotfoundexception_load_from_php(obj &C.zend_object) VSlimContainerNotFoundException {
    mut recv := VSlimContainerNotFoundException{}
    if obj == 0 {
        return recv
    }
    return recv
}
fn vslimcontainernotfoundexception_sync_to_php(obj &C.zend_object, recv VSlimContainerNotFoundException) {
    if obj == 0 {
        return
    }
}
@[export: 'VSlimContainerNotFoundException_get_prop']
pub fn vslimcontainernotfoundexception_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = rv
}
@[export: 'VSlimContainerNotFoundException_set_prop']
pub fn vslimcontainernotfoundexception_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = value
}
@[export: 'VSlimContainerNotFoundException_sync_props']
pub fn vslimcontainernotfoundexception_sync_props(ptr voidptr, zv &C.zval) {
    _ = ptr
    _ = zv
}
@[export: 'VSlimContainerNotFoundException_handlers']
pub fn vslimcontainernotfoundexception_handlers() voidptr {
    return unsafe { &C.vphp_class_handlers{
        prop_handler:  voidptr(vslimcontainernotfoundexception_get_prop)
        write_handler: voidptr(vslimcontainernotfoundexception_set_prop)
        sync_handler:  voidptr(vslimcontainernotfoundexception_sync_props)
        new_raw:       voidptr(vslimcontainernotfoundexception_new_raw)
        cleanup_raw:   voidptr(vslimcontainernotfoundexception_cleanup_raw)
        free_raw:      voidptr(vslimcontainernotfoundexception_free_raw)
    } }
}

@[export: 'VSlimContainer_new_raw']
pub fn vslimcontainer_new_raw() voidptr {
    return vphp.generic_new_raw[VSlimContainer]()
}
@[export: 'VSlimContainer_free_raw']
pub fn vslimcontainer_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[VSlimContainer](ptr)
}
@[export: 'VSlimContainer_cleanup_raw']
pub fn vslimcontainer_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    unsafe {
        mut obj := &VSlimContainer(ptr)
        obj.free()
    }
}
@[export: 'VSlimContainer_get_prop']
pub fn vslimcontainer_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = rv
}
@[export: 'VSlimContainer_set_prop']
pub fn vslimcontainer_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = value
}
@[export: 'VSlimContainer_sync_props']
pub fn vslimcontainer_sync_props(ptr voidptr, zv &C.zval) {
    _ = ptr
    _ = zv
}
@[export: 'vphp_wrap_VSlimContainer_construct']
pub fn vphp_wrap_vslimcontainer_construct(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimContainer(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    res := recv.construct()
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimContainer_set']
pub fn vphp_wrap_vslimcontainer_set(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimContainer(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    arg_1 := ctx.arg_borrowed_zbox(1)
    res := recv.set(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimContainer_factory']
pub fn vphp_wrap_vslimcontainer_factory(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimContainer(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    arg_1 := ctx.arg_borrowed_zbox(1)
    res := recv.factory(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimContainer_has']
pub fn vphp_wrap_vslimcontainer_has(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimContainer(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    res := recv.has(arg_0)
    ctx.return_val[bool](res)
}
@[export: 'vphp_wrap_VSlimContainer_get']
pub fn vphp_wrap_vslimcontainer_get(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimContainer(ptr) }
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg[string](0)
    res := recv.get(arg_0)
    ctx.return_val[vphp.RequestOwnedZBox](res)
}
@[export: 'VSlimContainer_handlers']
pub fn vslimcontainer_handlers() voidptr {
    return unsafe { &C.vphp_class_handlers{
        prop_handler:  voidptr(vslimcontainer_get_prop)
        write_handler: voidptr(vslimcontainer_set_prop)
        sync_handler:  voidptr(vslimcontainer_sync_props)
        new_raw:       voidptr(vslimcontainer_new_raw)
        cleanup_raw:   voidptr(vslimcontainer_cleanup_raw)
        free_raw:      voidptr(vslimcontainer_free_raw)
    } }
}

@[export: 'vphp_wrap_vslim_handle_request']
fn vphp_wrap_vslim_handle_request(ctx vphp.Context) {
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    arg_1 := ctx.arg[string](1)
    arg_2 := ctx.arg[string](2)
    res := vslim_handle_request(arg_0, arg_1, arg_2)
    ctx.return_val[vphp.RequestOwnedZBox](res)
}

@[export: 'vphp_wrap_vslim_demo_dispatch']
fn vphp_wrap_vslim_demo_dispatch(ctx vphp.Context) {
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    arg_1 := ctx.arg[string](1)
    arg_2 := ctx.arg[string](2)
    res := vslim_demo_dispatch(arg_0, arg_1, arg_2)
    ctx.return_val[vphp.RequestOwnedZBox](res)
}

@[export: 'vphp_wrap_vslim_response_headers']
fn vphp_wrap_vslim_response_headers(ctx vphp.Context) {
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx
    vslim_response_headers(arg_0)
}

@[export: 'vphp_wrap_vslim_probe_object']
fn vphp_wrap_vslim_probe_object(ctx vphp.Context) {
    vphp_ar_mark := vphp.autorelease_mark()
    defer { vphp.autorelease_drain(vphp_ar_mark) }
    arg_0 := ctx.arg_borrowed_zbox(0)
    arg_1 := ctx.arg[string](1)
    arg_2 := ctx.arg[string](2)
    res := vslim_probe_object(arg_0, arg_1, arg_2)
    ctx.return_val[vphp.RequestOwnedZBox](res)
}

@[export: 'vphp_ext_auto_startup']
fn vphp_ext_auto_startup() {
    vphp.register_auto_interface_binding('VSlim\\App', 'Psr\\Http\\Server\\RequestHandlerInterface')

    vphp.register_auto_interface_binding('VSlim\\Psr15\\NextHandler', 'Psr\\Http\\Server\\RequestHandlerInterface')

    vphp.register_auto_interface_binding('VSlim\\Psr15\\ContinueHandler', 'Psr\\Http\\Server\\RequestHandlerInterface')

    vphp.register_auto_interface_binding('VSlim\\Log\\PsrLogger', 'Psr\\Log\\LoggerInterface')

    vphp.register_auto_interface_binding('VSlim\\Psr7\\Stream', 'Psr\\Http\\Message\\StreamInterface')

    vphp.register_auto_interface_binding('VSlim\\Psr7\\UploadedFile', 'Psr\\Http\\Message\\UploadedFileInterface')

    vphp.register_auto_interface_binding('VSlim\\Psr7\\Response', 'Psr\\Http\\Message\\ResponseInterface')

    vphp.register_auto_interface_binding('VSlim\\Psr7\\Uri', 'Psr\\Http\\Message\\UriInterface')

    vphp.register_auto_interface_binding('VSlim\\Psr7\\Request', 'Psr\\Http\\Message\\RequestInterface')

    vphp.register_auto_interface_binding('VSlim\\Psr7\\ServerRequest', 'Psr\\Http\\Message\\ServerRequestInterface')

    vphp.register_auto_interface_binding('VSlim\\Psr17\\ResponseFactory', 'Psr\\Http\\Message\\ResponseFactoryInterface')

    vphp.register_auto_interface_binding('VSlim\\Psr17\\RequestFactory', 'Psr\\Http\\Message\\RequestFactoryInterface')

    vphp.register_auto_interface_binding('VSlim\\Psr17\\StreamFactory', 'Psr\\Http\\Message\\StreamFactoryInterface')

    vphp.register_auto_interface_binding('VSlim\\Psr17\\UploadedFileFactory', 'Psr\\Http\\Message\\UploadedFileFactoryInterface')

    vphp.register_auto_interface_binding('VSlim\\Psr17\\UriFactory', 'Psr\\Http\\Message\\UriFactoryInterface')

    vphp.register_auto_interface_binding('VSlim\\Psr17\\ServerRequestFactory', 'Psr\\Http\\Message\\ServerRequestFactoryInterface')

    vphp.register_auto_interface_binding('VSlim\\Psr16\\CacheException', 'Psr\\SimpleCache\\CacheException')

    vphp.register_auto_interface_binding('VSlim\\Psr16\\InvalidArgumentException', 'Psr\\SimpleCache\\InvalidArgumentException')

    vphp.register_auto_interface_binding('VSlim\\Psr16\\Cache', 'Psr\\SimpleCache\\CacheInterface')

    vphp.register_auto_interface_binding('VSlim\\Psr6\\CacheException', 'Psr\\Cache\\CacheException')

    vphp.register_auto_interface_binding('VSlim\\Psr6\\InvalidArgumentException', 'Psr\\Cache\\InvalidArgumentException')

    vphp.register_auto_interface_binding('VSlim\\Psr6\\CacheItem', 'Psr\\Cache\\CacheItemInterface')

    vphp.register_auto_interface_binding('VSlim\\Psr6\\CacheItemPool', 'Psr\\Cache\\CacheItemPoolInterface')

    vphp.register_auto_interface_binding('VSlim\\Psr18\\ClientException', 'Psr\\Http\\Client\\ClientExceptionInterface')

    vphp.register_auto_interface_binding('VSlim\\Psr18\\RequestException', 'Psr\\Http\\Client\\RequestExceptionInterface')

    vphp.register_auto_interface_binding('VSlim\\Psr18\\NetworkException', 'Psr\\Http\\Client\\NetworkExceptionInterface')

    vphp.register_auto_interface_binding('VSlim\\Psr18\\Client', 'Psr\\Http\\Client\\ClientInterface')

    vphp.register_auto_interface_binding('VSlim\\Psr20\\Clock', 'Psr\\Clock\\ClockInterface')

    vphp.register_auto_interface_binding('VSlim\\Psr14\\ListenerProvider', 'Psr\\EventDispatcher\\ListenerProviderInterface')

    vphp.register_auto_interface_binding('VSlim\\Psr14\\EventDispatcher', 'Psr\\EventDispatcher\\EventDispatcherInterface')

    vphp.register_auto_interface_binding('VSlim\\Container\\ContainerException', 'Psr\\Container\\ContainerExceptionInterface')

    vphp.register_auto_interface_binding('VSlim\\Container\\NotFoundException', 'Psr\\Container\\NotFoundExceptionInterface')

    vphp.register_auto_interface_binding('VSlim\\Container', 'Psr\\Container\\ContainerInterface')
}
