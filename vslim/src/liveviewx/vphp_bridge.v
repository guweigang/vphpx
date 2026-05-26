module liveviewx

import vphp

import containerx
import httpx
import viewx

#include "php_bridge.h"

__global C.vslim__live__form_ce &C.zend_class_entry
__global C.vslim__live__view_ce &C.zend_class_entry
__global C.vslim__live__component_ce &C.zend_class_entry
__global C.vslim__live__componentstate_ce &C.zend_class_entry
__global C.vslim__live__socket_ce &C.zend_class_entry

@[export: 'vslim_live_form_new_raw']
pub fn vslim_live_form_new_raw() voidptr {
    return vphp.generic_new_raw[VSlimLiveForm]()
}
@[export: 'vslim_live_form_free_raw']
pub fn vslim_live_form_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[VSlimLiveForm](ptr)
}
@[export: 'vslim_live_form_cleanup_raw']
pub fn vslim_live_form_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
}
@[export: 'vslim_live_form_get_prop']
pub fn vslim_live_form_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    ret := vphp.PhpObjectPropertyHandler.return_from_ptr(rv)
    unsafe {
        name := vphp.PhpObjectPropertyHandler.name_from_ptr(name_ptr, name_len)
        obj := &VSlimLiveForm(ptr)
        if name == 'name' {
            ret.v[string](obj.name)
            return
        }
        if name == 'lastErrorCount' {
            ret.v[i64](i64(obj.last_error_count))
            return
        }
        if name == 'validated' {
            ret.v[bool](obj.validated)
            return
        }
    }
}
@[export: 'vslim_live_form_set_prop']
pub fn vslim_live_form_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    arg := vphp.PhpObjectPropertyHandler.value_from_ptr(value)
    unsafe {
        name := vphp.PhpObjectPropertyHandler.name_from_ptr(name_ptr, name_len)
        mut obj := &VSlimLiveForm(ptr)
        if name == 'name' {
            obj.name = arg.get_string()
            return
        }
        if name == 'lastErrorCount' {
            obj.last_error_count = int(arg.get_int())
            return
        }
        if name == 'validated' {
            obj.validated = arg.get_bool()
            return
        }
    }
}
@[export: 'vslim_live_form_sync_props']
pub fn vslim_live_form_sync_props(ptr voidptr, zv &C.zval) {
    out := vphp.PhpObjectPropertyHandler.value_from_ptr(zv)
    unsafe {
        obj := &VSlimLiveForm(ptr)
        out.add_property_string('name', obj.name)
        out.add_property_long('lastErrorCount', i64(obj.last_error_count))
        out.add_property_bool('validated', obj.validated)
    }
}
@[export: 'vphp_wrap_vslim_live_form_name']
pub fn vphp_wrap_vslim_live_form_name(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimLiveForm(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.name()
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_vslim_live_form_available']
pub fn vphp_wrap_vslim_live_form_available(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimLiveForm(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.available()
    ctx.return().v[bool](res)
}
@[export: 'vphp_wrap_vslim_live_form_fill']
pub fn vphp_wrap_vslim_live_form_fill(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLiveForm(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'values', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'values').array() or {
        vphp.throw_exception('argument 0 must be array', 0)
        return unsafe { nil }
    }
    res := recv.fill(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_live_form_reset']
pub fn vphp_wrap_vslim_live_form_reset(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLiveForm(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'values', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'values').array() or {
        vphp.throw_exception('argument 0 must be array', 0)
        return unsafe { nil }
    }
    res := recv.reset(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_live_form_validate']
pub fn vphp_wrap_vslim_live_form_validate(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLiveForm(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'validator', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'validator').value
    res := recv.validate(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_live_form_errors']
pub fn vphp_wrap_vslim_live_form_errors(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLiveForm(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'values', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'values').array() or {
        vphp.throw_exception('argument 0 must be array', 0)
        return unsafe { nil }
    }
    res := recv.errors(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_live_form_clear_errors']
pub fn vphp_wrap_vslim_live_form_clear_errors(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLiveForm(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.clear_errors()
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_live_form_clear_error']
pub fn vphp_wrap_vslim_live_form_clear_error(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLiveForm(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'field', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'field').as_v[string]()
    res := recv.clear_error(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_live_form_forget']
pub fn vphp_wrap_vslim_live_form_forget(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLiveForm(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'field', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'field').as_v[string]()
    res := recv.forget(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_live_form_forget_many']
pub fn vphp_wrap_vslim_live_form_forget_many(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLiveForm(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'fields', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'fields').array() or {
        vphp.throw_exception('argument 0 must be array', 0)
        return unsafe { nil }
    }
    res := recv.forget_many(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_live_form_input']
pub fn vphp_wrap_vslim_live_form_input(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimLiveForm(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'field', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'field').as_v[string]()
    res := recv.input(arg_0)
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_vslim_live_form_input_or']
pub fn vphp_wrap_vslim_live_form_input_or(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimLiveForm(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'field', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'fallback', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'field').as_v[string]()
    arg_1 := php_args.at_named_or_index(1, 'fallback').as_v[string]()
    res := recv.input_or(arg_0, arg_1)
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_vslim_live_form_error']
pub fn vphp_wrap_vslim_live_form_error(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimLiveForm(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'field', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'field').as_v[string]()
    res := recv.error(arg_0)
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_vslim_live_form_has_error']
pub fn vphp_wrap_vslim_live_form_has_error(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimLiveForm(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'field', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'field').as_v[string]()
    res := recv.has_error(arg_0)
    ctx.return().v[bool](res)
}
@[export: 'vphp_wrap_vslim_live_form_valid']
pub fn vphp_wrap_vslim_live_form_valid(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimLiveForm(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.valid()
    ctx.return().v[bool](res)
}
@[export: 'vphp_wrap_vslim_live_form_invalid']
pub fn vphp_wrap_vslim_live_form_invalid(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimLiveForm(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.invalid()
    ctx.return().v[bool](res)
}
@[export: 'vphp_wrap_vslim_live_form_error_count']
pub fn vphp_wrap_vslim_live_form_error_count(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimLiveForm(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.error_count()
    ctx.return().v[int](res)
}
@[export: 'vphp_wrap_vslim_live_form_data']
pub fn vphp_wrap_vslim_live_form_data(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimLiveForm(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.data()
    ctx.return().v[vphp.PhpArray](res)
}
@[export: 'vslim_live_form_handlers']
pub fn vslim_live_form_handlers() voidptr {
    return vphp.ZendClassHandlers.new(
        prop_handler: voidptr(vslim_live_form_get_prop),
        write_handler: voidptr(vslim_live_form_set_prop),
        sync_handler: voidptr(vslim_live_form_sync_props),
        new_raw: voidptr(vslim_live_form_new_raw),
        cleanup_raw: voidptr(vslim_live_form_cleanup_raw),
        free_raw: voidptr(vslim_live_form_free_raw)
    )
}
pub fn VSlimLiveForm.php_class_entry() vphp.ZendClassEntry {
    return vphp.ZendClassEntry.from_ptr(C.vslim__live__form_ce)
}

pub fn VSlimLiveForm.php_object_handlers() voidptr {
    return vslim_live_form_handlers()
}

pub fn VSlimLiveForm.php_object_zval(v_ptr voidptr, ownership vphp.OwnershipKind) vphp.ZVal {
    return vphp.bind_object_zval[VSlimLiveForm](v_ptr, ownership)
}

pub fn (obj &VSlimLiveForm) bind_php_object() vphp.ZVal {
    return vphp.bind_borrowed_object_zval[VSlimLiveForm](obj)
}

pub fn (obj &VSlimLiveForm) bind_php_object_value() vphp.PhpValue {
    return vphp.bind_borrowed_object_value[VSlimLiveForm](obj)
}

pub fn (obj &VSlimLiveForm) bind_owned_php_object() vphp.ZVal {
    return vphp.bind_owned_object_zval[VSlimLiveForm](obj)
}

pub fn (obj &VSlimLiveForm) bind_owned_php_object_value() vphp.PhpValue {
    return vphp.bind_owned_object_value[VSlimLiveForm](obj)
}

pub fn (val VSlimLiveForm) php_class_name() string {
    return 'VSlim\\Live\\Form'
}

@[export: 'vslim_live_view_new_raw']
pub fn vslim_live_view_new_raw() voidptr {
    return vphp.generic_new_raw[VSlimLiveView]()
}
@[export: 'vslim_live_view_free_raw']
pub fn vslim_live_view_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[VSlimLiveView](ptr)
}
@[export: 'vslim_live_view_cleanup_raw']
pub fn vslim_live_view_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
}
@[export: 'vslim_live_view_get_prop']
pub fn vslim_live_view_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = rv
}
@[export: 'vslim_live_view_set_prop']
pub fn vslim_live_view_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = value
}
@[export: 'vslim_live_view_sync_props']
pub fn vslim_live_view_sync_props(ptr voidptr, zv &C.zval) {
    _ = ptr
    _ = zv
}
@[export: 'vphp_wrap_vslim_live_view_construct']
pub fn vphp_wrap_vslim_live_view_construct(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLiveView(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.construct()
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_live_view_set_container']
pub fn vphp_wrap_vslim_live_view_set_container(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLiveView(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'container', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := unsafe { &containerx.VSlimContainer(php_args.at_named_or_index(0, 'container').raw_obj()) }
    res := recv.set_container(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_live_view_set_view']
pub fn vphp_wrap_vslim_live_view_set_view(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLiveView(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'view', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := unsafe { &viewx.VSlimView(php_args.at_named_or_index(0, 'view').raw_obj()) }
    res := recv.set_view(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_live_view_view']
pub fn vphp_wrap_vslim_live_view_view(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLiveView(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.view()
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_live_view_set_template']
pub fn vphp_wrap_vslim_live_view_set_template(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLiveView(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'template', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'template').as_v[string]()
    res := recv.set_template(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_live_view_template']
pub fn vphp_wrap_vslim_live_view_template(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimLiveView(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.template()
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_vslim_live_view_set_layout']
pub fn vphp_wrap_vslim_live_view_set_layout(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLiveView(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'layout', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'layout').as_v[string]()
    res := recv.set_layout(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_live_view_layout']
pub fn vphp_wrap_vslim_live_view_layout(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimLiveView(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.layout()
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_vslim_live_view_set_root_id']
pub fn vphp_wrap_vslim_live_view_set_root_id(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLiveView(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'rootId', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'rootId').as_v[string]()
    res := recv.set_root_id(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_live_view_root_id']
pub fn vphp_wrap_vslim_live_view_root_id(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimLiveView(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.root_id()
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_vslim_live_view_live_marker']
pub fn vphp_wrap_vslim_live_view_live_marker(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimLiveView(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.live_marker()
    ctx.return().v[bool](res)
}
@[export: 'vphp_wrap_vslim_live_view_attr_prefix']
pub fn vphp_wrap_vslim_live_view_attr_prefix(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimLiveView(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.attr_prefix()
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_vslim_live_view_attr_name']
pub fn vphp_wrap_vslim_live_view_attr_name(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimLiveView(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'name', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'name').as_v[string]()
    res := recv.attr_name(arg_0)
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_vslim_live_view_runtime_asset']
pub fn vphp_wrap_vslim_live_view_runtime_asset(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimLiveView(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.runtime_asset()
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_vslim_live_view_runtime_script_tag']
pub fn vphp_wrap_vslim_live_view_runtime_script_tag(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimLiveView(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.runtime_script_tag()
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_vslim_live_view_bootstrap_attrs']
pub fn vphp_wrap_vslim_live_view_bootstrap_attrs(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimLiveView(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'socket', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'endpoint', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := unsafe { &liveviewx.VSlimLiveSocket(php_args.at_named_or_index(0, 'socket').raw_obj()) }
    arg_1 := php_args.at_named_or_index(1, 'endpoint').as_v[string]()
    res := recv.bootstrap_attrs(arg_0, arg_1)
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_vslim_live_view_render_template']
pub fn vphp_wrap_vslim_live_view_render_template(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimLiveView(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'template', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'data', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'template').as_v[string]()
    arg_1 := php_args.at_named_or_index(1, 'data').value
    res := recv.render_template(arg_0, arg_1)
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_vslim_live_view_render_template_with_layout']
pub fn vphp_wrap_vslim_live_view_render_template_with_layout(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimLiveView(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'template', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'layout', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 2, name: 'data', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'template').as_v[string]()
    arg_1 := php_args.at_named_or_index(1, 'layout').as_v[string]()
    arg_2 := php_args.at_named_or_index(2, 'data').value
    res := recv.render_template_with_layout(arg_0, arg_1, arg_2)
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_vslim_live_view_render_socket']
pub fn vphp_wrap_vslim_live_view_render_socket(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimLiveView(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'template', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'socket', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'template').as_v[string]()
    arg_1 := unsafe { &liveviewx.VSlimLiveSocket(php_args.at_named_or_index(1, 'socket').raw_obj()) }
    res := recv.render_socket(arg_0, arg_1)
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_vslim_live_view_render_socket_with_layout']
pub fn vphp_wrap_vslim_live_view_render_socket_with_layout(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimLiveView(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'template', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'layout', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 2, name: 'socket', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'template').as_v[string]()
    arg_1 := php_args.at_named_or_index(1, 'layout').as_v[string]()
    arg_2 := unsafe { &liveviewx.VSlimLiveSocket(php_args.at_named_or_index(2, 'socket').raw_obj()) }
    res := recv.render_socket_with_layout(arg_0, arg_1, arg_2)
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_vslim_live_view_html']
pub fn vphp_wrap_vslim_live_view_html(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimLiveView(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'socket', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := unsafe { &liveviewx.VSlimLiveSocket(php_args.at_named_or_index(0, 'socket').raw_obj()) }
    res := recv.html(arg_0)
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_vslim_live_view_response']
pub fn vphp_wrap_vslim_live_view_response(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLiveView(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'socket', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := unsafe { &liveviewx.VSlimLiveSocket(php_args.at_named_or_index(0, 'socket').raw_obj()) }
    res := recv.response(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_live_view_patch']
pub fn vphp_wrap_vslim_live_view_patch(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLiveView(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'socket', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'targetId', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := unsafe { &liveviewx.VSlimLiveSocket(php_args.at_named_or_index(0, 'socket').raw_obj()) }
    arg_1 := php_args.at_named_or_index(1, 'targetId').as_v[string]()
    res := recv.patch(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_live_view_patch_template']
pub fn vphp_wrap_vslim_live_view_patch_template(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLiveView(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'socket', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'targetId', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 2, name: 'template', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := unsafe { &liveviewx.VSlimLiveSocket(php_args.at_named_or_index(0, 'socket').raw_obj()) }
    arg_1 := php_args.at_named_or_index(1, 'targetId').as_v[string]()
    arg_2 := php_args.at_named_or_index(2, 'template').as_v[string]()
    res := recv.patch_template(arg_0, arg_1, arg_2)
    return voidptr(res)
}
@[export: 'vslim_live_view_handlers']
pub fn vslim_live_view_handlers() voidptr {
    return vphp.ZendClassHandlers.new(
        prop_handler: voidptr(vslim_live_view_get_prop),
        write_handler: voidptr(vslim_live_view_set_prop),
        sync_handler: voidptr(vslim_live_view_sync_props),
        new_raw: voidptr(vslim_live_view_new_raw),
        cleanup_raw: voidptr(vslim_live_view_cleanup_raw),
        free_raw: voidptr(vslim_live_view_free_raw)
    )
}
pub fn VSlimLiveView.php_class_entry() vphp.ZendClassEntry {
    return vphp.ZendClassEntry.from_ptr(C.vslim__live__view_ce)
}

pub fn VSlimLiveView.php_object_handlers() voidptr {
    return vslim_live_view_handlers()
}

pub fn VSlimLiveView.php_object_zval(v_ptr voidptr, ownership vphp.OwnershipKind) vphp.ZVal {
    return vphp.bind_object_zval[VSlimLiveView](v_ptr, ownership)
}

pub fn (obj &VSlimLiveView) bind_php_object() vphp.ZVal {
    return vphp.bind_borrowed_object_zval[VSlimLiveView](obj)
}

pub fn (obj &VSlimLiveView) bind_php_object_value() vphp.PhpValue {
    return vphp.bind_borrowed_object_value[VSlimLiveView](obj)
}

pub fn (obj &VSlimLiveView) bind_owned_php_object() vphp.ZVal {
    return vphp.bind_owned_object_zval[VSlimLiveView](obj)
}

pub fn (obj &VSlimLiveView) bind_owned_php_object_value() vphp.PhpValue {
    return vphp.bind_owned_object_value[VSlimLiveView](obj)
}

pub fn (val VSlimLiveView) php_class_name() string {
    return 'VSlim\\Live\\View'
}

@[export: 'vslim_live_component_new_raw']
pub fn vslim_live_component_new_raw() voidptr {
    return vphp.generic_new_raw[VSlimLiveComponent]()
}
@[export: 'vslim_live_component_free_raw']
pub fn vslim_live_component_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[VSlimLiveComponent](ptr)
}
@[export: 'vslim_live_component_cleanup_raw']
pub fn vslim_live_component_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
}
@[export: 'vslim_live_component_get_prop']
pub fn vslim_live_component_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = rv
}
@[export: 'vslim_live_component_set_prop']
pub fn vslim_live_component_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = value
}
@[export: 'vslim_live_component_sync_props']
pub fn vslim_live_component_sync_props(ptr voidptr, zv &C.zval) {
    _ = ptr
    _ = zv
}
@[export: 'vphp_wrap_vslim_live_component_construct']
pub fn vphp_wrap_vslim_live_component_construct(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLiveComponent(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.construct()
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_live_component_set_container']
pub fn vphp_wrap_vslim_live_component_set_container(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLiveComponent(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'container', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := unsafe { &containerx.VSlimContainer(php_args.at_named_or_index(0, 'container').raw_obj()) }
    res := recv.set_container(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_live_component_set_view']
pub fn vphp_wrap_vslim_live_component_set_view(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLiveComponent(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'view', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := unsafe { &viewx.VSlimView(php_args.at_named_or_index(0, 'view').raw_obj()) }
    res := recv.set_view(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_live_component_view']
pub fn vphp_wrap_vslim_live_component_view(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLiveComponent(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.view()
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_live_component_set_template']
pub fn vphp_wrap_vslim_live_component_set_template(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLiveComponent(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'template', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'template').as_v[string]()
    res := recv.set_template(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_live_component_template']
pub fn vphp_wrap_vslim_live_component_template(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimLiveComponent(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.template()
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_vslim_live_component_set_layout']
pub fn vphp_wrap_vslim_live_component_set_layout(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLiveComponent(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'layout', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'layout').as_v[string]()
    res := recv.set_layout(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_live_component_layout']
pub fn vphp_wrap_vslim_live_component_layout(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimLiveComponent(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.layout()
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_vslim_live_component_set_id']
pub fn vphp_wrap_vslim_live_component_set_id(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLiveComponent(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'id', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'id').as_v[string]()
    res := recv.set_id(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_live_component_id']
pub fn vphp_wrap_vslim_live_component_id(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimLiveComponent(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.id()
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_vslim_live_component_bind_socket']
pub fn vphp_wrap_vslim_live_component_bind_socket(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLiveComponent(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'socket', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := unsafe { &liveviewx.VSlimLiveSocket(php_args.at_named_or_index(0, 'socket').raw_obj()) }
    res := recv.bind_socket(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_live_component_has_socket']
pub fn vphp_wrap_vslim_live_component_has_socket(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimLiveComponent(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.has_socket()
    ctx.return().v[bool](res)
}
@[export: 'vphp_wrap_vslim_live_component_state']
pub fn vphp_wrap_vslim_live_component_state(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLiveComponent(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.state()
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_live_component_assign']
pub fn vphp_wrap_vslim_live_component_assign(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLiveComponent(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'key', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'value', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'key').as_v[string]()
    arg_1 := php_args.at_named_or_index(1, 'value').value
    res := recv.assign(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_live_component_assign_many']
pub fn vphp_wrap_vslim_live_component_assign_many(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLiveComponent(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'values', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'values').array() or {
        vphp.throw_exception('argument 0 must be array', 0)
        return unsafe { nil }
    }
    res := recv.assign_many(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_live_component_assigns']
pub fn vphp_wrap_vslim_live_component_assigns(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimLiveComponent(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.assigns()
    ctx.return().v[map[string]string](res)
}
@[export: 'vphp_wrap_vslim_live_component_clear_assigns']
pub fn vphp_wrap_vslim_live_component_clear_assigns(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLiveComponent(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.clear_assigns()
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_live_component_render_template']
pub fn vphp_wrap_vslim_live_component_render_template(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimLiveComponent(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'template', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'data', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'template').as_v[string]()
    arg_1 := php_args.at_named_or_index(1, 'data').value
    res := recv.render_template(arg_0, arg_1)
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_vslim_live_component_html']
pub fn vphp_wrap_vslim_live_component_html(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimLiveComponent(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.html()
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_vslim_live_component_patch']
pub fn vphp_wrap_vslim_live_component_patch(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLiveComponent(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'socket', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := unsafe { &liveviewx.VSlimLiveSocket(php_args.at_named_or_index(0, 'socket').raw_obj()) }
    res := recv.patch(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_live_component_patch_bound']
pub fn vphp_wrap_vslim_live_component_patch_bound(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLiveComponent(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.patch_bound()
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_live_component_component_marker']
pub fn vphp_wrap_vslim_live_component_component_marker(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimLiveComponent(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.component_marker()
    ctx.return().v[bool](res)
}
@[export: 'vphp_wrap_vslim_live_component_append_to']
pub fn vphp_wrap_vslim_live_component_append_to(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLiveComponent(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'socket', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'targetId', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := unsafe { &liveviewx.VSlimLiveSocket(php_args.at_named_or_index(0, 'socket').raw_obj()) }
    arg_1 := php_args.at_named_or_index(1, 'targetId').as_v[string]()
    res := recv.append_to(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_live_component_append_to_bound']
pub fn vphp_wrap_vslim_live_component_append_to_bound(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLiveComponent(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'targetId', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'targetId').as_v[string]()
    res := recv.append_to_bound(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_live_component_prepend_to']
pub fn vphp_wrap_vslim_live_component_prepend_to(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLiveComponent(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'socket', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'targetId', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := unsafe { &liveviewx.VSlimLiveSocket(php_args.at_named_or_index(0, 'socket').raw_obj()) }
    arg_1 := php_args.at_named_or_index(1, 'targetId').as_v[string]()
    res := recv.prepend_to(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_live_component_prepend_to_bound']
pub fn vphp_wrap_vslim_live_component_prepend_to_bound(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLiveComponent(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'targetId', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'targetId').as_v[string]()
    res := recv.prepend_to_bound(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_live_component_remove']
pub fn vphp_wrap_vslim_live_component_remove(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLiveComponent(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'socket', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := unsafe { &liveviewx.VSlimLiveSocket(php_args.at_named_or_index(0, 'socket').raw_obj()) }
    res := recv.remove(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_live_component_remove_bound']
pub fn vphp_wrap_vslim_live_component_remove_bound(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLiveComponent(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.remove_bound()
    return voidptr(res)
}
@[export: 'vslim_live_component_handlers']
pub fn vslim_live_component_handlers() voidptr {
    return vphp.ZendClassHandlers.new(
        prop_handler: voidptr(vslim_live_component_get_prop),
        write_handler: voidptr(vslim_live_component_set_prop),
        sync_handler: voidptr(vslim_live_component_sync_props),
        new_raw: voidptr(vslim_live_component_new_raw),
        cleanup_raw: voidptr(vslim_live_component_cleanup_raw),
        free_raw: voidptr(vslim_live_component_free_raw)
    )
}
pub fn VSlimLiveComponent.php_class_entry() vphp.ZendClassEntry {
    return vphp.ZendClassEntry.from_ptr(C.vslim__live__component_ce)
}

pub fn VSlimLiveComponent.php_object_handlers() voidptr {
    return vslim_live_component_handlers()
}

pub fn VSlimLiveComponent.php_object_zval(v_ptr voidptr, ownership vphp.OwnershipKind) vphp.ZVal {
    return vphp.bind_object_zval[VSlimLiveComponent](v_ptr, ownership)
}

pub fn (obj &VSlimLiveComponent) bind_php_object() vphp.ZVal {
    return vphp.bind_borrowed_object_zval[VSlimLiveComponent](obj)
}

pub fn (obj &VSlimLiveComponent) bind_php_object_value() vphp.PhpValue {
    return vphp.bind_borrowed_object_value[VSlimLiveComponent](obj)
}

pub fn (obj &VSlimLiveComponent) bind_owned_php_object() vphp.ZVal {
    return vphp.bind_owned_object_zval[VSlimLiveComponent](obj)
}

pub fn (obj &VSlimLiveComponent) bind_owned_php_object_value() vphp.PhpValue {
    return vphp.bind_owned_object_value[VSlimLiveComponent](obj)
}

pub fn (val VSlimLiveComponent) php_class_name() string {
    return 'VSlim\\Live\\Component'
}

@[export: 'vslim_live_component_state_new_raw']
pub fn vslim_live_component_state_new_raw() voidptr {
    return vphp.generic_new_raw[VSlimLiveComponentState]()
}
@[export: 'vslim_live_component_state_free_raw']
pub fn vslim_live_component_state_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[VSlimLiveComponentState](ptr)
}
@[export: 'vslim_live_component_state_cleanup_raw']
pub fn vslim_live_component_state_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
}
@[export: 'vslim_live_component_state_get_prop']
pub fn vslim_live_component_state_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = rv
}
@[export: 'vslim_live_component_state_set_prop']
pub fn vslim_live_component_state_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = value
}
@[export: 'vslim_live_component_state_sync_props']
pub fn vslim_live_component_state_sync_props(ptr voidptr, zv &C.zval) {
    _ = ptr
    _ = zv
}
@[export: 'vphp_wrap_vslim_live_component_state_set']
pub fn vphp_wrap_vslim_live_component_state_set(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLiveComponentState(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'field', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'value', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'field').as_v[string]()
    arg_1 := php_args.at_named_or_index(1, 'value').value
    res := recv.set(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_live_component_state_get']
pub fn vphp_wrap_vslim_live_component_state_get(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimLiveComponentState(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'field', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'field').as_v[string]()
    res := recv.get(arg_0)
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_vslim_live_component_state_get_or']
pub fn vphp_wrap_vslim_live_component_state_get_or(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimLiveComponentState(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'field', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'fallback', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'field').as_v[string]()
    arg_1 := php_args.at_named_or_index(1, 'fallback').as_v[string]()
    res := recv.get_or(arg_0, arg_1)
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_vslim_live_component_state_clear']
pub fn vphp_wrap_vslim_live_component_state_clear(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLiveComponentState(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'field', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'field').as_v[string]()
    res := recv.clear(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_live_component_state_available']
pub fn vphp_wrap_vslim_live_component_state_available(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimLiveComponentState(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.available()
    ctx.return().v[bool](res)
}
@[export: 'vslim_live_component_state_handlers']
pub fn vslim_live_component_state_handlers() voidptr {
    return vphp.ZendClassHandlers.new(
        prop_handler: voidptr(vslim_live_component_state_get_prop),
        write_handler: voidptr(vslim_live_component_state_set_prop),
        sync_handler: voidptr(vslim_live_component_state_sync_props),
        new_raw: voidptr(vslim_live_component_state_new_raw),
        cleanup_raw: voidptr(vslim_live_component_state_cleanup_raw),
        free_raw: voidptr(vslim_live_component_state_free_raw)
    )
}
pub fn VSlimLiveComponentState.php_class_entry() vphp.ZendClassEntry {
    return vphp.ZendClassEntry.from_ptr(C.vslim__live__componentstate_ce)
}

pub fn VSlimLiveComponentState.php_object_handlers() voidptr {
    return vslim_live_component_state_handlers()
}

pub fn VSlimLiveComponentState.php_object_zval(v_ptr voidptr, ownership vphp.OwnershipKind) vphp.ZVal {
    return vphp.bind_object_zval[VSlimLiveComponentState](v_ptr, ownership)
}

pub fn (obj &VSlimLiveComponentState) bind_php_object() vphp.ZVal {
    return vphp.bind_borrowed_object_zval[VSlimLiveComponentState](obj)
}

pub fn (obj &VSlimLiveComponentState) bind_php_object_value() vphp.PhpValue {
    return vphp.bind_borrowed_object_value[VSlimLiveComponentState](obj)
}

pub fn (obj &VSlimLiveComponentState) bind_owned_php_object() vphp.ZVal {
    return vphp.bind_owned_object_zval[VSlimLiveComponentState](obj)
}

pub fn (obj &VSlimLiveComponentState) bind_owned_php_object_value() vphp.PhpValue {
    return vphp.bind_owned_object_value[VSlimLiveComponentState](obj)
}

pub fn (val VSlimLiveComponentState) php_class_name() string {
    return 'VSlim\\Live\\ComponentState'
}

@[export: 'vslim_live_socket_new_raw']
pub fn vslim_live_socket_new_raw() voidptr {
    return vphp.generic_new_raw[VSlimLiveSocket]()
}
@[export: 'vslim_live_socket_free_raw']
pub fn vslim_live_socket_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[VSlimLiveSocket](ptr)
}
@[export: 'vslim_live_socket_cleanup_raw']
pub fn vslim_live_socket_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
}
@[export: 'vslim_live_socket_get_prop']
pub fn vslim_live_socket_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    ret := vphp.PhpObjectPropertyHandler.return_from_ptr(rv)
    unsafe {
        name := vphp.PhpObjectPropertyHandler.name_from_ptr(name_ptr, name_len)
        obj := &VSlimLiveSocket(ptr)
        if name == 'id' {
            ret.v[string](obj.id)
            return
        }
        if name == 'connected' {
            ret.v[bool](obj.connected)
            return
        }
        if name == 'redirectTo' {
            ret.v[string](obj.redirect_to)
            return
        }
        if name == 'navigateTo' {
            ret.v[string](obj.navigate_to)
            return
        }
        if name == 'rawPath' {
            ret.v[string](obj.raw_path)
            return
        }
        if name == 'rootId' {
            ret.v[string](obj.root_id)
            return
        }
    }
}
@[export: 'vslim_live_socket_set_prop']
pub fn vslim_live_socket_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    arg := vphp.PhpObjectPropertyHandler.value_from_ptr(value)
    unsafe {
        name := vphp.PhpObjectPropertyHandler.name_from_ptr(name_ptr, name_len)
        mut obj := &VSlimLiveSocket(ptr)
        if name == 'id' {
            obj.id = arg.get_string()
            return
        }
        if name == 'connected' {
            obj.connected = arg.get_bool()
            return
        }
        if name == 'redirectTo' {
            obj.redirect_to = arg.get_string()
            return
        }
        if name == 'navigateTo' {
            obj.navigate_to = arg.get_string()
            return
        }
        if name == 'rawPath' {
            obj.raw_path = arg.get_string()
            return
        }
        if name == 'rootId' {
            obj.root_id = arg.get_string()
            return
        }
    }
}
@[export: 'vslim_live_socket_sync_props']
pub fn vslim_live_socket_sync_props(ptr voidptr, zv &C.zval) {
    out := vphp.PhpObjectPropertyHandler.value_from_ptr(zv)
    unsafe {
        obj := &VSlimLiveSocket(ptr)
        out.add_property_string('id', obj.id)
        out.add_property_bool('connected', obj.connected)
        out.add_property_string('redirectTo', obj.redirect_to)
        out.add_property_string('navigateTo', obj.navigate_to)
        out.add_property_string('rawPath', obj.raw_path)
        out.add_property_string('rootId', obj.root_id)
    }
}
@[export: 'vphp_wrap_vslim_live_socket_construct']
pub fn vphp_wrap_vslim_live_socket_construct(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLiveSocket(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.construct()
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_live_socket_set_id']
pub fn vphp_wrap_vslim_live_socket_set_id(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLiveSocket(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'id', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'id').as_v[string]()
    res := recv.set_id(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_live_socket_id']
pub fn vphp_wrap_vslim_live_socket_id(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimLiveSocket(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.id()
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_vslim_live_socket_set_connected']
pub fn vphp_wrap_vslim_live_socket_set_connected(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLiveSocket(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'connected', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'connected').as_v[bool]()
    res := recv.set_connected(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_live_socket_connected']
pub fn vphp_wrap_vslim_live_socket_connected(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimLiveSocket(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.connected()
    ctx.return().v[bool](res)
}
@[export: 'vphp_wrap_vslim_live_socket_set_target']
pub fn vphp_wrap_vslim_live_socket_set_target(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLiveSocket(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'rawPath', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'rawPath').as_v[string]()
    res := recv.set_target(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_live_socket_target']
pub fn vphp_wrap_vslim_live_socket_target(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimLiveSocket(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.target()
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_vslim_live_socket_set_root_id']
pub fn vphp_wrap_vslim_live_socket_set_root_id(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLiveSocket(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'rootId', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'rootId').as_v[string]()
    res := recv.set_root_id(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_live_socket_root_id']
pub fn vphp_wrap_vslim_live_socket_root_id(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimLiveSocket(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.root_id()
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_vslim_live_socket_assign']
pub fn vphp_wrap_vslim_live_socket_assign(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLiveSocket(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'key', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'value', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'key').as_v[string]()
    arg_1 := php_args.at_named_or_index(1, 'value').value
    res := recv.assign(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_live_socket_assign_many']
pub fn vphp_wrap_vslim_live_socket_assign_many(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLiveSocket(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'values', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'values').array() or {
        vphp.throw_exception('argument 0 must be array', 0)
        return unsafe { nil }
    }
    res := recv.assign_many(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_live_socket_assign_form']
pub fn vphp_wrap_vslim_live_socket_assign_form(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLiveSocket(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'values', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'values').array() or {
        vphp.throw_exception('argument 0 must be array', 0)
        return unsafe { nil }
    }
    res := recv.assign_form(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_live_socket_reset_form']
pub fn vphp_wrap_vslim_live_socket_reset_form(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLiveSocket(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'values', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'values').array() or {
        vphp.throw_exception('argument 0 must be array', 0)
        return unsafe { nil }
    }
    res := recv.reset_form(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_live_socket_forget']
pub fn vphp_wrap_vslim_live_socket_forget(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLiveSocket(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'key', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'key').as_v[string]()
    res := recv.forget(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_live_socket_forget_input']
pub fn vphp_wrap_vslim_live_socket_forget_input(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLiveSocket(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'field', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'field').as_v[string]()
    res := recv.forget_input(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_live_socket_forget_inputs']
pub fn vphp_wrap_vslim_live_socket_forget_inputs(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLiveSocket(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'fields', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'fields').array() or {
        vphp.throw_exception('argument 0 must be array', 0)
        return unsafe { nil }
    }
    res := recv.forget_inputs(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_live_socket_clear_assigns']
pub fn vphp_wrap_vslim_live_socket_clear_assigns(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLiveSocket(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.clear_assigns()
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_live_socket_assign_component_state']
pub fn vphp_wrap_vslim_live_socket_assign_component_state(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLiveSocket(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'componentId', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'field', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 2, name: 'value', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'componentId').as_v[string]()
    arg_1 := php_args.at_named_or_index(1, 'field').as_v[string]()
    arg_2 := php_args.at_named_or_index(2, 'value').value
    res := recv.assign_component_state(arg_0, arg_1, arg_2)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_live_socket_component_state']
pub fn vphp_wrap_vslim_live_socket_component_state(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimLiveSocket(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'componentId', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'field', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'componentId').as_v[string]()
    arg_1 := php_args.at_named_or_index(1, 'field').as_v[string]()
    res := recv.component_state(arg_0, arg_1)
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_vslim_live_socket_component_state_or']
pub fn vphp_wrap_vslim_live_socket_component_state_or(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimLiveSocket(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'componentId', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'field', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 2, name: 'fallback', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'componentId').as_v[string]()
    arg_1 := php_args.at_named_or_index(1, 'field').as_v[string]()
    arg_2 := php_args.at_named_or_index(2, 'fallback').as_v[string]()
    res := recv.component_state_or(arg_0, arg_1, arg_2)
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_vslim_live_socket_clear_component_state']
pub fn vphp_wrap_vslim_live_socket_clear_component_state(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLiveSocket(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'componentId', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'field', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'componentId').as_v[string]()
    arg_1 := php_args.at_named_or_index(1, 'field').as_v[string]()
    res := recv.clear_component_state(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_live_socket_assign_error']
pub fn vphp_wrap_vslim_live_socket_assign_error(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLiveSocket(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'field', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'message', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'field').as_v[string]()
    arg_1 := php_args.at_named_or_index(1, 'message').as_v[string]()
    res := recv.assign_error(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_live_socket_assign_errors']
pub fn vphp_wrap_vslim_live_socket_assign_errors(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLiveSocket(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'values', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'values').array() or {
        vphp.throw_exception('argument 0 must be array', 0)
        return unsafe { nil }
    }
    res := recv.assign_errors(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_live_socket_clear_error']
pub fn vphp_wrap_vslim_live_socket_clear_error(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLiveSocket(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'field', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'field').as_v[string]()
    res := recv.clear_error(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_live_socket_clear_errors']
pub fn vphp_wrap_vslim_live_socket_clear_errors(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLiveSocket(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.clear_errors()
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_live_socket_input']
pub fn vphp_wrap_vslim_live_socket_input(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimLiveSocket(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'field', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'field').as_v[string]()
    res := recv.input(arg_0)
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_vslim_live_socket_input_or']
pub fn vphp_wrap_vslim_live_socket_input_or(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimLiveSocket(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'field', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'fallback', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'field').as_v[string]()
    arg_1 := php_args.at_named_or_index(1, 'fallback').as_v[string]()
    res := recv.input_or(arg_0, arg_1)
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_vslim_live_socket_old']
pub fn vphp_wrap_vslim_live_socket_old(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimLiveSocket(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'field', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'field').as_v[string]()
    res := recv.old(arg_0)
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_vslim_live_socket_old_or']
pub fn vphp_wrap_vslim_live_socket_old_or(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimLiveSocket(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'field', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'fallback', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'field').as_v[string]()
    arg_1 := php_args.at_named_or_index(1, 'fallback').as_v[string]()
    res := recv.old_or(arg_0, arg_1)
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_vslim_live_socket_error']
pub fn vphp_wrap_vslim_live_socket_error(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimLiveSocket(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'field', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'field').as_v[string]()
    res := recv.error(arg_0)
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_vslim_live_socket_has_error']
pub fn vphp_wrap_vslim_live_socket_has_error(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimLiveSocket(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'field', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'field').as_v[string]()
    res := recv.has_error(arg_0)
    ctx.return().v[bool](res)
}
@[export: 'vphp_wrap_vslim_live_socket_form']
pub fn vphp_wrap_vslim_live_socket_form(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLiveSocket(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'name', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'name').as_v[string]()
    res := recv.form(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_live_socket_get']
pub fn vphp_wrap_vslim_live_socket_get(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimLiveSocket(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'key', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'key').as_v[string]()
    res := recv.get(arg_0)
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_vslim_live_socket_has']
pub fn vphp_wrap_vslim_live_socket_has(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimLiveSocket(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'key', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'key').as_v[string]()
    res := recv.has(arg_0)
    ctx.return().v[bool](res)
}
@[export: 'vphp_wrap_vslim_live_socket_assigns']
pub fn vphp_wrap_vslim_live_socket_assigns(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimLiveSocket(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.assigns()
    ctx.return().v[map[string]string](res)
}
@[export: 'vphp_wrap_vslim_live_socket_patch']
pub fn vphp_wrap_vslim_live_socket_patch(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLiveSocket(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'targetId', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'html', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'targetId').as_v[string]()
    arg_1 := php_args.at_named_or_index(1, 'html').as_v[string]()
    res := recv.patch(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_live_socket_append']
pub fn vphp_wrap_vslim_live_socket_append(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLiveSocket(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'targetId', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'html', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'targetId').as_v[string]()
    arg_1 := php_args.at_named_or_index(1, 'html').as_v[string]()
    res := recv.append(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_live_socket_prepend']
pub fn vphp_wrap_vslim_live_socket_prepend(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLiveSocket(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'targetId', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'html', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'targetId').as_v[string]()
    arg_1 := php_args.at_named_or_index(1, 'html').as_v[string]()
    res := recv.prepend(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_live_socket_set_text']
pub fn vphp_wrap_vslim_live_socket_set_text(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLiveSocket(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'targetId', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'text', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'targetId').as_v[string]()
    arg_1 := php_args.at_named_or_index(1, 'text').as_v[string]()
    res := recv.set_text(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_live_socket_set_attr']
pub fn vphp_wrap_vslim_live_socket_set_attr(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLiveSocket(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'targetId', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'name', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 2, name: 'value', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'targetId').as_v[string]()
    arg_1 := php_args.at_named_or_index(1, 'name').as_v[string]()
    arg_2 := php_args.at_named_or_index(2, 'value').as_v[string]()
    res := recv.set_attr(arg_0, arg_1, arg_2)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_live_socket_remove']
pub fn vphp_wrap_vslim_live_socket_remove(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLiveSocket(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'targetId', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'targetId').as_v[string]()
    res := recv.remove(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_live_socket_patches']
pub fn vphp_wrap_vslim_live_socket_patches(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimLiveSocket(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.patches()
    ctx.return().v[[]map[string]string](res)
}
@[export: 'vphp_wrap_vslim_live_socket_clear_patches']
pub fn vphp_wrap_vslim_live_socket_clear_patches(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLiveSocket(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.clear_patches()
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_live_socket_push_event']
pub fn vphp_wrap_vslim_live_socket_push_event(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLiveSocket(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'event', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'payload', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'event').as_v[string]()
    arg_1 := php_args.at_named_or_index(1, 'payload').as_v[string]()
    res := recv.push_event(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_live_socket_events']
pub fn vphp_wrap_vslim_live_socket_events(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimLiveSocket(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.events()
    ctx.return().v[[]map[string]string](res)
}
@[export: 'vphp_wrap_vslim_live_socket_clear_events']
pub fn vphp_wrap_vslim_live_socket_clear_events(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLiveSocket(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.clear_events()
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_live_socket_flash']
pub fn vphp_wrap_vslim_live_socket_flash(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLiveSocket(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'kind', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'message', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'kind').as_v[string]()
    arg_1 := php_args.at_named_or_index(1, 'message').as_v[string]()
    res := recv.flash(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_live_socket_flashes']
pub fn vphp_wrap_vslim_live_socket_flashes(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimLiveSocket(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.flashes()
    ctx.return().v[[]map[string]string](res)
}
@[export: 'vphp_wrap_vslim_live_socket_clear_flashes']
pub fn vphp_wrap_vslim_live_socket_clear_flashes(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLiveSocket(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.clear_flashes()
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_live_socket_join_topic']
pub fn vphp_wrap_vslim_live_socket_join_topic(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLiveSocket(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'room', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'room').as_v[string]()
    res := recv.join_topic(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_live_socket_leave_topic']
pub fn vphp_wrap_vslim_live_socket_leave_topic(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLiveSocket(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'room', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'room').as_v[string]()
    res := recv.leave_topic(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_live_socket_broadcast_info']
pub fn vphp_wrap_vslim_live_socket_broadcast_info(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLiveSocket(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'room', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'event', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 2, name: 'payload', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 3, name: 'includeSelf', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'room').as_v[string]()
    arg_1 := php_args.at_named_or_index(1, 'event').as_v[string]()
    arg_2 := php_args.at_named_or_index(2, 'payload').value
    arg_3 := php_args.at_named_or_index(3, 'includeSelf').as_v[bool]()
    res := recv.broadcast_info(arg_0, arg_1, arg_2, arg_3)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_live_socket_pubsub_commands']
pub fn vphp_wrap_vslim_live_socket_pubsub_commands(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimLiveSocket(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.pubsub_commands()
    ctx.return().v[[]map[string]string](res)
}
@[export: 'vphp_wrap_vslim_live_socket_clear_pubsub']
pub fn vphp_wrap_vslim_live_socket_clear_pubsub(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLiveSocket(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.clear_pubsub()
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_live_socket_redirect']
pub fn vphp_wrap_vslim_live_socket_redirect(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLiveSocket(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'location', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'location').as_v[string]()
    res := recv.redirect(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_live_socket_redirect_to']
pub fn vphp_wrap_vslim_live_socket_redirect_to(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimLiveSocket(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.redirect_to()
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_vslim_live_socket_clear_redirect']
pub fn vphp_wrap_vslim_live_socket_clear_redirect(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLiveSocket(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.clear_redirect()
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_live_socket_navigate']
pub fn vphp_wrap_vslim_live_socket_navigate(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLiveSocket(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'location', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'location').as_v[string]()
    res := recv.navigate(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_live_socket_navigate_to']
pub fn vphp_wrap_vslim_live_socket_navigate_to(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimLiveSocket(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.navigate_to()
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_vslim_live_socket_clear_navigate']
pub fn vphp_wrap_vslim_live_socket_clear_navigate(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLiveSocket(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.clear_navigate()
    return voidptr(res)
}
@[export: 'vslim_live_socket_handlers']
pub fn vslim_live_socket_handlers() voidptr {
    return vphp.ZendClassHandlers.new(
        prop_handler: voidptr(vslim_live_socket_get_prop),
        write_handler: voidptr(vslim_live_socket_set_prop),
        sync_handler: voidptr(vslim_live_socket_sync_props),
        new_raw: voidptr(vslim_live_socket_new_raw),
        cleanup_raw: voidptr(vslim_live_socket_cleanup_raw),
        free_raw: voidptr(vslim_live_socket_free_raw)
    )
}
pub fn VSlimLiveSocket.php_class_entry() vphp.ZendClassEntry {
    return vphp.ZendClassEntry.from_ptr(C.vslim__live__socket_ce)
}

pub fn VSlimLiveSocket.php_object_handlers() voidptr {
    return vslim_live_socket_handlers()
}

pub fn VSlimLiveSocket.php_object_zval(v_ptr voidptr, ownership vphp.OwnershipKind) vphp.ZVal {
    return vphp.bind_object_zval[VSlimLiveSocket](v_ptr, ownership)
}

pub fn (obj &VSlimLiveSocket) bind_php_object() vphp.ZVal {
    return vphp.bind_borrowed_object_zval[VSlimLiveSocket](obj)
}

pub fn (obj &VSlimLiveSocket) bind_php_object_value() vphp.PhpValue {
    return vphp.bind_borrowed_object_value[VSlimLiveSocket](obj)
}

pub fn (obj &VSlimLiveSocket) bind_owned_php_object() vphp.ZVal {
    return vphp.bind_owned_object_zval[VSlimLiveSocket](obj)
}

pub fn (obj &VSlimLiveSocket) bind_owned_php_object_value() vphp.PhpValue {
    return vphp.bind_owned_object_value[VSlimLiveSocket](obj)
}

pub fn (val VSlimLiveSocket) php_class_name() string {
    return 'VSlim\\Live\\Socket'
}

