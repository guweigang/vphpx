/* ⚠️ VPHP Compiler Generated for vslim */
#include "php_bridge.h"

#include "../vphp/v_bridge.h"


typedef struct { void* ex; void* ret; } vphp_context_internal;
typedef struct { void* str; int len; int is_lit; } v_string;

extern void vphp_framework_init(int module_number);
extern void vphp_framework_shutdown(void);
extern void vphp_framework_request_startup(void);
extern void vphp_framework_request_shutdown(void);
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim_handle_request, 0, 0, 0)
ZEND_END_ARG_INFO()
extern void vphp_wrap_vslim_handle_request(vphp_context_internal ctx);
PHP_FUNCTION(vslim_handle_request) {
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    vphp_wrap_vslim_handle_request(ctx);
}
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim_demo_dispatch, 0, 0, 0)
ZEND_END_ARG_INFO()
extern void vphp_wrap_vslim_demo_dispatch(vphp_context_internal ctx);
PHP_FUNCTION(vslim_demo_dispatch) {
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    vphp_wrap_vslim_demo_dispatch(ctx);
}
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim_response_headers, 0, 0, 0)
ZEND_END_ARG_INFO()
extern void vphp_wrap_vslim_response_headers(vphp_context_internal ctx);
PHP_FUNCTION(vslim_response_headers) {
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    vphp_wrap_vslim_response_headers(ctx);
}
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim_middleware_next, 0, 0, 0)
ZEND_END_ARG_INFO()
extern void vphp_wrap_vslim_middleware_next(vphp_context_internal ctx);
PHP_FUNCTION(vslim_middleware_next) {
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    vphp_wrap_vslim_middleware_next(ctx);
}
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim_probe_object, 0, 0, 0)
ZEND_END_ARG_INFO()
extern void vphp_wrap_vslim_probe_object(vphp_context_internal ctx);
PHP_FUNCTION(vslim_probe_object) {
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    vphp_wrap_vslim_probe_object(ctx);
}
zend_class_entry *vslim__view_ce = NULL;
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__view_construct, 0, 0, 2)
ZEND_ARG_TYPE_INFO(0, base_path, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, assets_prefix, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__view_set_base_path, 0, 0, 1)
ZEND_ARG_TYPE_INFO(0, base_path, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__view_base_path, 0, 0, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__view_set_assets_prefix, 0, 0, 1)
ZEND_ARG_TYPE_INFO(0, prefix, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__view_assets_prefix, 0, 0, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__view_set_cache_enabled, 0, 0, 1)
ZEND_ARG_TYPE_INFO(0, enabled, _IS_BOOL, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__view_cache_enabled, 0, 0, _IS_BOOL, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__view_clear_cache, 0, 0, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__view_helper, 0, 0, 2)
ZEND_ARG_TYPE_INFO(0, name, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, handler, IS_MIXED, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__view_asset, 0, 1, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, path, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__view_render, 0, 2, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, template, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, data, IS_MIXED, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__view_render_with_layout, 0, 3, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, template, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, layout, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, data, IS_MIXED, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__view_render_response, 0, 0, 2)
ZEND_ARG_TYPE_INFO(0, template, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, data, IS_MIXED, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__view_render_response_with_layout, 0, 0, 3)
ZEND_ARG_TYPE_INFO(0, template, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, layout, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, data, IS_MIXED, 0)
ZEND_END_ARG_INFO()
PHP_METHOD(VSlim__View, __construct) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern vphp_class_handlers* VSlimView_handlers();
    vphp_class_handlers *h = VSlimView_handlers();
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    wrapper->v_ptr = h->new_raw();
    vphp_register_object(wrapper->v_ptr, Z_OBJ_P(getThis()));
    vphp_bind_handlers_with_ownership(Z_OBJ_P(getThis()), h, 1);
    extern void vphp_wrap_VSlimView_construct(void* v_ptr, vphp_context_internal ctx);
    void* v_ptr = wrapper->v_ptr;
    vphp_wrap_VSlimView_construct(v_ptr, ctx);
}

PHP_METHOD(VSlim__View, set_base_path) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimView_set_base_path(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__View::set_base_path called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimView_set_base_path(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__view_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimView_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimView_handlers(), 0);
    }
}

PHP_METHOD(VSlim__View, base_path) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimView_base_path(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!wrapper->v_ptr) RETURN_FALSE;
    vphp_wrap_VSlimView_base_path(wrapper->v_ptr, ctx);
}

PHP_METHOD(VSlim__View, set_assets_prefix) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimView_set_assets_prefix(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__View::set_assets_prefix called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimView_set_assets_prefix(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__view_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimView_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimView_handlers(), 0);
    }
}

PHP_METHOD(VSlim__View, assets_prefix) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimView_assets_prefix(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!wrapper->v_ptr) RETURN_FALSE;
    vphp_wrap_VSlimView_assets_prefix(wrapper->v_ptr, ctx);
}

PHP_METHOD(VSlim__View, set_cache_enabled) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimView_set_cache_enabled(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__View::set_cache_enabled called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimView_set_cache_enabled(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__view_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimView_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimView_handlers(), 0);
    }
}

PHP_METHOD(VSlim__View, cache_enabled) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimView_cache_enabled(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!wrapper->v_ptr) RETURN_FALSE;
    vphp_wrap_VSlimView_cache_enabled(wrapper->v_ptr, ctx);
}

PHP_METHOD(VSlim__View, clear_cache) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimView_clear_cache(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__View::clear_cache called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimView_clear_cache(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__view_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimView_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimView_handlers(), 0);
    }
}


PHP_METHOD(VSlim__View, helper) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimView_helper(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__View::helper called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimView_helper(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__view_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimView_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimView_handlers(), 0);
    }
}

PHP_METHOD(VSlim__View, asset) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimView_asset(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!wrapper->v_ptr) RETURN_FALSE;
    vphp_wrap_VSlimView_asset(wrapper->v_ptr, ctx);
}
PHP_METHOD(VSlim__View, render) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimView_render(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!wrapper->v_ptr) RETURN_FALSE;
    vphp_wrap_VSlimView_render(wrapper->v_ptr, ctx);
}
PHP_METHOD(VSlim__View, render_with_layout) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimView_render_with_layout(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!wrapper->v_ptr) RETURN_FALSE;
    vphp_wrap_VSlimView_render_with_layout(wrapper->v_ptr, ctx);
}

PHP_METHOD(VSlim__View, render_response) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimView_render_response(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__View::render_response called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimView_render_response(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__response_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimResponse_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimResponse_handlers(), 0);
    }
}


PHP_METHOD(VSlim__View, render_response_with_layout) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimView_render_response_with_layout(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__View::render_response_with_layout called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimView_render_response_with_layout(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__response_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimResponse_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimResponse_handlers(), 0);
    }
}

static const zend_function_entry vslim__view_methods[] = {
    PHP_ME(VSlim__View, __construct, arginfo_vslim__view_construct, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__View, set_base_path, arginfo_vslim__view_set_base_path, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__View, base_path, arginfo_vslim__view_base_path, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__View, set_assets_prefix, arginfo_vslim__view_set_assets_prefix, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__View, assets_prefix, arginfo_vslim__view_assets_prefix, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__View, set_cache_enabled, arginfo_vslim__view_set_cache_enabled, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__View, cache_enabled, arginfo_vslim__view_cache_enabled, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__View, clear_cache, arginfo_vslim__view_clear_cache, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__View, helper, arginfo_vslim__view_helper, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__View, asset, arginfo_vslim__view_asset, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__View, render, arginfo_vslim__view_render, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__View, render_with_layout, arginfo_vslim__view_render_with_layout, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__View, render_response, arginfo_vslim__view_render_response, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__View, render_response_with_layout, arginfo_vslim__view_render_response_with_layout, ZEND_ACC_PUBLIC)
    PHP_FE_END
};

zend_class_entry *vslim__controller_ce = NULL;
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__controller_construct, 0, 0, 1)
ZEND_ARG_INFO(0, app)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__controller_set_app, 0, 0, 1)
ZEND_ARG_INFO(0, app)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__controller_set_view, 0, 0, 1)
ZEND_ARG_INFO(0, view)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__controller_view, 0, 0, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__controller_render, 0, 0, 2)
ZEND_ARG_TYPE_INFO(0, template, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, data, IS_MIXED, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__controller_render_with_layout, 0, 0, 3)
ZEND_ARG_TYPE_INFO(0, template, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, layout, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, data, IS_MIXED, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__controller_url_for, 0, 2, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, name, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, params, IS_MIXED, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__controller_url_for_query, 0, 3, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, name, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, params, IS_MIXED, 0)
ZEND_ARG_TYPE_INFO(0, query, IS_MIXED, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__controller_text, 0, 0, 2)
ZEND_ARG_TYPE_INFO(0, body, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, status, IS_LONG, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__controller_json, 0, 0, 2)
ZEND_ARG_TYPE_INFO(0, body, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, status, IS_LONG, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__controller_redirect, 0, 0, 2)
ZEND_ARG_TYPE_INFO(0, location, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, status, IS_LONG, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__controller_redirect_to, 0, 0, 3)
ZEND_ARG_TYPE_INFO(0, name, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, params, IS_MIXED, 0)
ZEND_ARG_TYPE_INFO(0, status, IS_LONG, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__controller_redirect_to_query, 0, 0, 4)
ZEND_ARG_TYPE_INFO(0, name, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, params, IS_MIXED, 0)
ZEND_ARG_TYPE_INFO(0, query, IS_MIXED, 0)
ZEND_ARG_TYPE_INFO(0, status, IS_LONG, 0)
ZEND_END_ARG_INFO()
PHP_METHOD(VSlim__Controller, __construct) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern vphp_class_handlers* VSlimController_handlers();
    vphp_class_handlers *h = VSlimController_handlers();
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    wrapper->v_ptr = h->new_raw();
    vphp_register_object(wrapper->v_ptr, Z_OBJ_P(getThis()));
    vphp_bind_handlers_with_ownership(Z_OBJ_P(getThis()), h, 1);
    extern void vphp_wrap_VSlimController_construct(void* v_ptr, vphp_context_internal ctx);
    void* v_ptr = wrapper->v_ptr;
    vphp_wrap_VSlimController_construct(v_ptr, ctx);
}

PHP_METHOD(VSlim__Controller, set_app) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimController_set_app(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__Controller::set_app called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimController_set_app(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__controller_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimController_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimController_handlers(), 0);
    }
}


PHP_METHOD(VSlim__Controller, set_view) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimController_set_view(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__Controller::set_view called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimController_set_view(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__controller_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimController_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimController_handlers(), 0);
    }
}


PHP_METHOD(VSlim__Controller, view) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimController_view(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__Controller::view called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimController_view(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__view_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimView_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimView_handlers(), 0);
    }
}


PHP_METHOD(VSlim__Controller, render) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimController_render(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__Controller::render called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimController_render(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__response_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimResponse_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimResponse_handlers(), 0);
    }
}


PHP_METHOD(VSlim__Controller, render_with_layout) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimController_render_with_layout(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__Controller::render_with_layout called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimController_render_with_layout(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__response_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimResponse_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimResponse_handlers(), 0);
    }
}

PHP_METHOD(VSlim__Controller, url_for) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimController_url_for(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!wrapper->v_ptr) RETURN_FALSE;
    vphp_wrap_VSlimController_url_for(wrapper->v_ptr, ctx);
}
PHP_METHOD(VSlim__Controller, url_for_query) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimController_url_for_query(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!wrapper->v_ptr) RETURN_FALSE;
    vphp_wrap_VSlimController_url_for_query(wrapper->v_ptr, ctx);
}

PHP_METHOD(VSlim__Controller, text) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimController_text(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__Controller::text called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimController_text(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__response_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimResponse_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimResponse_handlers(), 0);
    }
}


PHP_METHOD(VSlim__Controller, json) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimController_json(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__Controller::json called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimController_json(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__response_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimResponse_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimResponse_handlers(), 0);
    }
}


PHP_METHOD(VSlim__Controller, redirect) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimController_redirect(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__Controller::redirect called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimController_redirect(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__response_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimResponse_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimResponse_handlers(), 0);
    }
}


PHP_METHOD(VSlim__Controller, redirect_to) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimController_redirect_to(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__Controller::redirect_to called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimController_redirect_to(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__response_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimResponse_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimResponse_handlers(), 0);
    }
}


PHP_METHOD(VSlim__Controller, redirect_to_query) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimController_redirect_to_query(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__Controller::redirect_to_query called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimController_redirect_to_query(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__response_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimResponse_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimResponse_handlers(), 0);
    }
}

static const zend_function_entry vslim__controller_methods[] = {
    PHP_ME(VSlim__Controller, __construct, arginfo_vslim__controller_construct, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Controller, set_app, arginfo_vslim__controller_set_app, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Controller, set_view, arginfo_vslim__controller_set_view, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Controller, view, arginfo_vslim__controller_view, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Controller, render, arginfo_vslim__controller_render, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Controller, render_with_layout, arginfo_vslim__controller_render_with_layout, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Controller, url_for, arginfo_vslim__controller_url_for, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Controller, url_for_query, arginfo_vslim__controller_url_for_query, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Controller, text, arginfo_vslim__controller_text, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Controller, json, arginfo_vslim__controller_json, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Controller, redirect, arginfo_vslim__controller_redirect, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Controller, redirect_to, arginfo_vslim__controller_redirect_to, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Controller, redirect_to_query, arginfo_vslim__controller_redirect_to_query, ZEND_ACC_PUBLIC)
    PHP_FE_END
};

zend_class_entry *vslim__app_ce = NULL;
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__app___construct, 0, 0, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__app_set_view_base_path, 0, 0, 1)
ZEND_ARG_TYPE_INFO(0, base_path, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__app_view_base_path, 0, 0, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__app_set_assets_prefix, 0, 0, 1)
ZEND_ARG_TYPE_INFO(0, prefix, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__app_assets_prefix, 0, 0, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__app_set_view_cache, 0, 0, 1)
ZEND_ARG_TYPE_INFO(0, enabled, _IS_BOOL, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__app_view_cache_enabled, 0, 0, _IS_BOOL, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__app_clear_view_cache, 0, 0, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__app_helper, 0, 0, 2)
ZEND_ARG_TYPE_INFO(0, name, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, handler, IS_MIXED, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__app_make_view, 0, 0, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__app_view, 0, 0, 2)
ZEND_ARG_TYPE_INFO(0, template, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, data, IS_MIXED, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__app_view_with_layout, 0, 0, 3)
ZEND_ARG_TYPE_INFO(0, template, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, layout, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, data, IS_MIXED, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__app_demo, 0, 0, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__app_set_base_path, 0, 0, 1)
ZEND_ARG_TYPE_INFO(0, base_path, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__app_has_container, 0, 0, _IS_BOOL, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__app_set_container, 0, 0, 1)
ZEND_ARG_INFO(0, container)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__app_container, 0, 0, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__app_has_config, 0, 0, _IS_BOOL, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__app_set_config, 0, 0, 1)
ZEND_ARG_INFO(0, config)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__app_config, 0, 0, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__app_load_config, 0, 0, 1)
ZEND_ARG_TYPE_INFO(0, path, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__app_load_config_text, 0, 0, 1)
ZEND_ARG_TYPE_INFO(0, text, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__app_group, 0, 0, 1)
ZEND_ARG_TYPE_INFO(0, prefix, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__app_dispatch, 0, 0, 2)
ZEND_ARG_TYPE_INFO(0, method, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, raw_path, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__app_dispatch_body, 0, 0, 3)
ZEND_ARG_TYPE_INFO(0, method, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, raw_path, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, body, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__app_dispatch_request, 0, 0, 1)
ZEND_ARG_INFO(0, req)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__app_dispatch_envelope, 0, 0, 1)
ZEND_ARG_TYPE_INFO(0, envelope, IS_MIXED, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__app_dispatch_envelope_worker, 0, 1, IS_VOID, 0)
ZEND_ARG_TYPE_INFO(0, envelope, IS_MIXED, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__app_dispatch_envelope_map, 0, 1, IS_ARRAY, 0)
ZEND_ARG_TYPE_INFO(0, envelope, IS_MIXED, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__app_get, 0, 0, 2)
ZEND_ARG_TYPE_INFO(0, pattern, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, handler, IS_MIXED, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__app_post, 0, 0, 2)
ZEND_ARG_TYPE_INFO(0, pattern, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, handler, IS_MIXED, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__app_put, 0, 0, 2)
ZEND_ARG_TYPE_INFO(0, pattern, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, handler, IS_MIXED, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__app_head, 0, 0, 2)
ZEND_ARG_TYPE_INFO(0, pattern, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, handler, IS_MIXED, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__app_options, 0, 0, 2)
ZEND_ARG_TYPE_INFO(0, pattern, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, handler, IS_MIXED, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__app_patch, 0, 0, 2)
ZEND_ARG_TYPE_INFO(0, pattern, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, handler, IS_MIXED, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__app_delete, 0, 0, 2)
ZEND_ARG_TYPE_INFO(0, pattern, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, handler, IS_MIXED, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__app_any, 0, 0, 2)
ZEND_ARG_TYPE_INFO(0, pattern, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, handler, IS_MIXED, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__app_live, 0, 0, 2)
ZEND_ARG_TYPE_INFO(0, pattern, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, handler, IS_MIXED, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__app_live_ws, 0, 3, IS_MIXED, 0)
ZEND_ARG_TYPE_INFO(0, handler, IS_MIXED, 0)
ZEND_ARG_TYPE_INFO(0, frame, IS_MIXED, 0)
ZEND_ARG_TYPE_INFO(0, conn, IS_MIXED, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__app_websocket, 0, 0, 2)
ZEND_ARG_TYPE_INFO(0, pattern, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, handler, IS_MIXED, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__app_websocket_named, 0, 0, 3)
ZEND_ARG_TYPE_INFO(0, name, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, pattern, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, handler, IS_MIXED, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__app_has_mcp, 0, 0, _IS_BOOL, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__app_set_mcp, 0, 0, 1)
ZEND_ARG_INFO(0, mcp)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__app_mcp, 0, 0, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__app_handle_mcp_dispatch, 0, 1, IS_MIXED, 0)
ZEND_ARG_TYPE_INFO(0, frame, IS_MIXED, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__app_map, 0, 0, 3)
ZEND_ARG_TYPE_INFO(0, methods, IS_MIXED, 0)
ZEND_ARG_TYPE_INFO(0, pattern, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, handler, IS_MIXED, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__app_resource, 0, 0, 2)
ZEND_ARG_TYPE_INFO(0, resource_path, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, controller, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__app_api_resource, 0, 0, 2)
ZEND_ARG_TYPE_INFO(0, resource_path, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, controller, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__app_singleton, 0, 0, 2)
ZEND_ARG_TYPE_INFO(0, resource_path, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, controller, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__app_api_singleton, 0, 0, 2)
ZEND_ARG_TYPE_INFO(0, resource_path, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, controller, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__app_resource_opts, 0, 0, 3)
ZEND_ARG_TYPE_INFO(0, resource_path, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, controller, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, options, IS_MIXED, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__app_api_resource_opts, 0, 0, 3)
ZEND_ARG_TYPE_INFO(0, resource_path, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, controller, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, options, IS_MIXED, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__app_singleton_opts, 0, 0, 3)
ZEND_ARG_TYPE_INFO(0, resource_path, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, controller, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, options, IS_MIXED, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__app_api_singleton_opts, 0, 0, 3)
ZEND_ARG_TYPE_INFO(0, resource_path, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, controller, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, options, IS_MIXED, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__app_get_named, 0, 0, 3)
ZEND_ARG_TYPE_INFO(0, name, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, pattern, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, handler, IS_MIXED, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__app_post_named, 0, 0, 3)
ZEND_ARG_TYPE_INFO(0, name, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, pattern, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, handler, IS_MIXED, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__app_put_named, 0, 0, 3)
ZEND_ARG_TYPE_INFO(0, name, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, pattern, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, handler, IS_MIXED, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__app_head_named, 0, 0, 3)
ZEND_ARG_TYPE_INFO(0, name, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, pattern, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, handler, IS_MIXED, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__app_options_named, 0, 0, 3)
ZEND_ARG_TYPE_INFO(0, name, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, pattern, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, handler, IS_MIXED, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__app_patch_named, 0, 0, 3)
ZEND_ARG_TYPE_INFO(0, name, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, pattern, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, handler, IS_MIXED, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__app_delete_named, 0, 0, 3)
ZEND_ARG_TYPE_INFO(0, name, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, pattern, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, handler, IS_MIXED, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__app_any_named, 0, 0, 3)
ZEND_ARG_TYPE_INFO(0, name, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, pattern, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, handler, IS_MIXED, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__app_map_named, 0, 0, 4)
ZEND_ARG_TYPE_INFO(0, methods, IS_MIXED, 0)
ZEND_ARG_TYPE_INFO(0, name, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, pattern, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, handler, IS_MIXED, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__app_handle_websocket, 0, 2, IS_MIXED, 0)
ZEND_ARG_TYPE_INFO(0, frame, IS_MIXED, 0)
ZEND_ARG_TYPE_INFO(0, conn, IS_MIXED, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__app_middleware, 0, 0, 1)
ZEND_ARG_TYPE_INFO(0, handler, IS_MIXED, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__app_before, 0, 0, 1)
ZEND_ARG_TYPE_INFO(0, handler, IS_MIXED, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__app_after, 0, 0, 1)
ZEND_ARG_TYPE_INFO(0, handler, IS_MIXED, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__app_set_not_found_handler, 0, 0, 1)
ZEND_ARG_TYPE_INFO(0, handler, IS_MIXED, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__app_not_found, 0, 0, 1)
ZEND_ARG_TYPE_INFO(0, handler, IS_MIXED, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__app_set_error_handler, 0, 0, 1)
ZEND_ARG_TYPE_INFO(0, handler, IS_MIXED, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__app_error, 0, 0, 1)
ZEND_ARG_TYPE_INFO(0, handler, IS_MIXED, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__app_set_error_response_json, 0, 0, 1)
ZEND_ARG_TYPE_INFO(0, enabled, _IS_BOOL, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__app_error_response_json_enabled, 0, 0, _IS_BOOL, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__app_has_logger, 0, 0, _IS_BOOL, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__app_set_logger, 0, 0, 1)
ZEND_ARG_INFO(0, logger)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__app_logger, 0, 0, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__app_url_for, 0, 2, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, name, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, params, IS_MIXED, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__app_url_for_query, 0, 3, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, name, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, params, IS_MIXED, 0)
ZEND_ARG_TYPE_INFO(0, query, IS_MIXED, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__app_url_for_abs, 0, 4, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, name, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, params, IS_MIXED, 0)
ZEND_ARG_TYPE_INFO(0, scheme, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, host, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__app_url_for_query_abs, 0, 5, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, name, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, params, IS_MIXED, 0)
ZEND_ARG_TYPE_INFO(0, query, IS_MIXED, 0)
ZEND_ARG_TYPE_INFO(0, scheme, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, host, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__app_redirect_to, 0, 0, 2)
ZEND_ARG_TYPE_INFO(0, name, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, params, IS_MIXED, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__app_redirect_to_query, 0, 0, 3)
ZEND_ARG_TYPE_INFO(0, name, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, params, IS_MIXED, 0)
ZEND_ARG_TYPE_INFO(0, query, IS_MIXED, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__app_route_count, 0, 0, IS_LONG, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__app_route_names, 0, 0, IS_ARRAY, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__app_has_route_name, 0, 1, _IS_BOOL, 0)
ZEND_ARG_TYPE_INFO(0, name, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__app_route_manifest_lines, 0, 0, IS_ARRAY, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__app_route_conflict_keys, 0, 0, IS_ARRAY, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__app_route_manifest, 0, 0, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__app_route_conflicts, 0, 0, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__app_allowed_methods_for, 0, 1, IS_ARRAY, 0)
ZEND_ARG_TYPE_INFO(0, raw_path, IS_STRING, 0)
ZEND_END_ARG_INFO()

PHP_METHOD(VSlim__App, set_view_base_path) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimApp_set_view_base_path(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__App::set_view_base_path called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimApp_set_view_base_path(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__app_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimApp_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimApp_handlers(), 0);
    }
}

PHP_METHOD(VSlim__App, view_base_path) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimApp_view_base_path(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!wrapper->v_ptr) RETURN_FALSE;
    vphp_wrap_VSlimApp_view_base_path(wrapper->v_ptr, ctx);
}

PHP_METHOD(VSlim__App, set_assets_prefix) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimApp_set_assets_prefix(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__App::set_assets_prefix called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimApp_set_assets_prefix(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__app_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimApp_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimApp_handlers(), 0);
    }
}

PHP_METHOD(VSlim__App, assets_prefix) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimApp_assets_prefix(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!wrapper->v_ptr) RETURN_FALSE;
    vphp_wrap_VSlimApp_assets_prefix(wrapper->v_ptr, ctx);
}

PHP_METHOD(VSlim__App, set_view_cache) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimApp_set_view_cache(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__App::set_view_cache called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimApp_set_view_cache(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__app_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimApp_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimApp_handlers(), 0);
    }
}

PHP_METHOD(VSlim__App, view_cache_enabled) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimApp_view_cache_enabled(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!wrapper->v_ptr) RETURN_FALSE;
    vphp_wrap_VSlimApp_view_cache_enabled(wrapper->v_ptr, ctx);
}

PHP_METHOD(VSlim__App, clear_view_cache) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimApp_clear_view_cache(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__App::clear_view_cache called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimApp_clear_view_cache(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__app_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimApp_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimApp_handlers(), 0);
    }
}


PHP_METHOD(VSlim__App, helper) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimApp_helper(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__App::helper called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimApp_helper(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__app_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimApp_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimApp_handlers(), 0);
    }
}


PHP_METHOD(VSlim__App, make_view) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimApp_make_view(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__App::make_view called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimApp_make_view(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__view_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimView_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimView_handlers(), 0);
    }
}


PHP_METHOD(VSlim__App, view) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimApp_view(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__App::view called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimApp_view(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__response_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimResponse_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimResponse_handlers(), 0);
    }
}


PHP_METHOD(VSlim__App, view_with_layout) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimApp_view_with_layout(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__App::view_with_layout called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimApp_view_with_layout(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__response_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimResponse_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimResponse_handlers(), 0);
    }
}

PHP_METHOD(VSlim__App, demo) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimApp_demo(vphp_context_internal ctx);
    void* v_instance = vphp_wrap_VSlimApp_demo(ctx);
    vphp_return_obj(return_value, v_instance, vslim__app_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimApp_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimApp_handlers(), 1);
    }
}

PHP_METHOD(VSlim__App, set_base_path) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimApp_set_base_path(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__App::set_base_path called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimApp_set_base_path(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__app_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimApp_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimApp_handlers(), 0);
    }
}

PHP_METHOD(VSlim__App, has_container) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimApp_has_container(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!wrapper->v_ptr) RETURN_FALSE;
    vphp_wrap_VSlimApp_has_container(wrapper->v_ptr, ctx);
}

PHP_METHOD(VSlim__App, set_container) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimApp_set_container(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__App::set_container called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimApp_set_container(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__app_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimApp_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimApp_handlers(), 0);
    }
}


PHP_METHOD(VSlim__App, container) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimApp_container(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__App::container called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimApp_container(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__container_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimContainer_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimContainer_handlers(), 0);
    }
}

PHP_METHOD(VSlim__App, has_config) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimApp_has_config(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!wrapper->v_ptr) RETURN_FALSE;
    vphp_wrap_VSlimApp_has_config(wrapper->v_ptr, ctx);
}

PHP_METHOD(VSlim__App, set_config) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimApp_set_config(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__App::set_config called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimApp_set_config(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__app_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimApp_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimApp_handlers(), 0);
    }
}


PHP_METHOD(VSlim__App, config) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimApp_config(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__App::config called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimApp_config(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__config_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimConfig_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimConfig_handlers(), 0);
    }
}


PHP_METHOD(VSlim__App, load_config) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimApp_load_config(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__App::load_config called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimApp_load_config(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__app_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimApp_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimApp_handlers(), 0);
    }
}


PHP_METHOD(VSlim__App, load_config_text) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimApp_load_config_text(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__App::load_config_text called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimApp_load_config_text(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__app_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimApp_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimApp_handlers(), 0);
    }
}


PHP_METHOD(VSlim__App, group) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimApp_group(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__App::group called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimApp_group(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__routegroup_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* RouteGroup_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), RouteGroup_handlers(), 0);
    }
}


PHP_METHOD(VSlim__App, dispatch) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimApp_dispatch(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__App::dispatch called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimApp_dispatch(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__response_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimResponse_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimResponse_handlers(), 0);
    }
}


PHP_METHOD(VSlim__App, dispatch_body) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimApp_dispatch_body(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__App::dispatch_body called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimApp_dispatch_body(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__response_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimResponse_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimResponse_handlers(), 0);
    }
}


PHP_METHOD(VSlim__App, dispatch_request) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimApp_dispatch_request(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__App::dispatch_request called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimApp_dispatch_request(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__response_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimResponse_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimResponse_handlers(), 0);
    }
}


PHP_METHOD(VSlim__App, dispatch_envelope) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimApp_dispatch_envelope(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__App::dispatch_envelope called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimApp_dispatch_envelope(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__response_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimResponse_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimResponse_handlers(), 0);
    }
}

PHP_METHOD(VSlim__App, dispatch_envelope_worker) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void VSlimApp_dispatch_envelope_worker(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!wrapper->v_ptr) RETURN_NULL();
    VSlimApp_dispatch_envelope_worker(wrapper->v_ptr, ctx);
}
PHP_METHOD(VSlim__App, dispatch_envelope_map) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimApp_dispatch_envelope_map(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!wrapper->v_ptr) RETURN_FALSE;
    vphp_wrap_VSlimApp_dispatch_envelope_map(wrapper->v_ptr, ctx);
}

PHP_METHOD(VSlim__App, get) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimApp_get(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__App::get called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimApp_get(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__app_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimApp_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimApp_handlers(), 0);
    }
}


PHP_METHOD(VSlim__App, post) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimApp_post(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__App::post called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimApp_post(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__app_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimApp_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimApp_handlers(), 0);
    }
}


PHP_METHOD(VSlim__App, put) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimApp_put(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__App::put called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimApp_put(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__app_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimApp_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimApp_handlers(), 0);
    }
}


PHP_METHOD(VSlim__App, head) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimApp_head(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__App::head called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimApp_head(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__app_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimApp_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimApp_handlers(), 0);
    }
}


PHP_METHOD(VSlim__App, options) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimApp_options(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__App::options called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimApp_options(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__app_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimApp_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimApp_handlers(), 0);
    }
}


PHP_METHOD(VSlim__App, patch) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimApp_patch(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__App::patch called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimApp_patch(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__app_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimApp_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimApp_handlers(), 0);
    }
}


PHP_METHOD(VSlim__App, delete) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimApp_delete(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__App::delete called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimApp_delete(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__app_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimApp_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimApp_handlers(), 0);
    }
}


PHP_METHOD(VSlim__App, any) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimApp_any(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__App::any called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimApp_any(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__app_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimApp_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimApp_handlers(), 0);
    }
}


PHP_METHOD(VSlim__App, live) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimApp_live(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__App::live called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimApp_live(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__app_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimApp_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimApp_handlers(), 0);
    }
}

PHP_METHOD(VSlim__App, live_ws) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimApp_live_ws(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!wrapper->v_ptr) RETURN_FALSE;
    vphp_wrap_VSlimApp_live_ws(wrapper->v_ptr, ctx);
}

PHP_METHOD(VSlim__App, websocket) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimApp_websocket(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__App::websocket called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimApp_websocket(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__app_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimApp_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimApp_handlers(), 0);
    }
}


PHP_METHOD(VSlim__App, websocket_named) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimApp_websocket_named(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__App::websocket_named called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimApp_websocket_named(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__app_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimApp_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimApp_handlers(), 0);
    }
}

PHP_METHOD(VSlim__App, has_mcp) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimApp_has_mcp(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!wrapper->v_ptr) RETURN_FALSE;
    vphp_wrap_VSlimApp_has_mcp(wrapper->v_ptr, ctx);
}

PHP_METHOD(VSlim__App, set_mcp) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimApp_set_mcp(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__App::set_mcp called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimApp_set_mcp(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__app_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimApp_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimApp_handlers(), 0);
    }
}


PHP_METHOD(VSlim__App, mcp) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimApp_mcp(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__App::mcp called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimApp_mcp(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__mcp__app_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimMcpApp_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimMcpApp_handlers(), 0);
    }
}

PHP_METHOD(VSlim__App, handle_mcp_dispatch) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimApp_handle_mcp_dispatch(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!wrapper->v_ptr) RETURN_FALSE;
    vphp_wrap_VSlimApp_handle_mcp_dispatch(wrapper->v_ptr, ctx);
}

PHP_METHOD(VSlim__App, map) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimApp_map(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__App::map called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimApp_map(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__app_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimApp_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimApp_handlers(), 0);
    }
}


PHP_METHOD(VSlim__App, resource) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimApp_resource(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__App::resource called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimApp_resource(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__app_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimApp_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimApp_handlers(), 0);
    }
}


PHP_METHOD(VSlim__App, api_resource) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimApp_api_resource(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__App::api_resource called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimApp_api_resource(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__app_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimApp_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimApp_handlers(), 0);
    }
}


PHP_METHOD(VSlim__App, singleton) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimApp_singleton(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__App::singleton called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimApp_singleton(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__app_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimApp_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimApp_handlers(), 0);
    }
}


PHP_METHOD(VSlim__App, api_singleton) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimApp_api_singleton(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__App::api_singleton called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimApp_api_singleton(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__app_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimApp_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimApp_handlers(), 0);
    }
}


PHP_METHOD(VSlim__App, resource_opts) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimApp_resource_opts(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__App::resource_opts called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimApp_resource_opts(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__app_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimApp_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimApp_handlers(), 0);
    }
}


PHP_METHOD(VSlim__App, api_resource_opts) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimApp_api_resource_opts(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__App::api_resource_opts called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimApp_api_resource_opts(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__app_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimApp_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimApp_handlers(), 0);
    }
}


PHP_METHOD(VSlim__App, singleton_opts) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimApp_singleton_opts(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__App::singleton_opts called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimApp_singleton_opts(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__app_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimApp_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimApp_handlers(), 0);
    }
}


PHP_METHOD(VSlim__App, api_singleton_opts) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimApp_api_singleton_opts(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__App::api_singleton_opts called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimApp_api_singleton_opts(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__app_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimApp_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimApp_handlers(), 0);
    }
}


PHP_METHOD(VSlim__App, get_named) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimApp_get_named(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__App::get_named called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimApp_get_named(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__app_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimApp_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimApp_handlers(), 0);
    }
}


PHP_METHOD(VSlim__App, post_named) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimApp_post_named(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__App::post_named called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimApp_post_named(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__app_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimApp_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimApp_handlers(), 0);
    }
}


PHP_METHOD(VSlim__App, put_named) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimApp_put_named(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__App::put_named called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimApp_put_named(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__app_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimApp_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimApp_handlers(), 0);
    }
}


PHP_METHOD(VSlim__App, head_named) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimApp_head_named(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__App::head_named called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimApp_head_named(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__app_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimApp_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimApp_handlers(), 0);
    }
}


PHP_METHOD(VSlim__App, options_named) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimApp_options_named(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__App::options_named called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimApp_options_named(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__app_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimApp_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimApp_handlers(), 0);
    }
}


PHP_METHOD(VSlim__App, patch_named) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimApp_patch_named(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__App::patch_named called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimApp_patch_named(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__app_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimApp_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimApp_handlers(), 0);
    }
}


PHP_METHOD(VSlim__App, delete_named) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimApp_delete_named(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__App::delete_named called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimApp_delete_named(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__app_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimApp_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimApp_handlers(), 0);
    }
}


PHP_METHOD(VSlim__App, any_named) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimApp_any_named(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__App::any_named called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimApp_any_named(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__app_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimApp_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimApp_handlers(), 0);
    }
}


PHP_METHOD(VSlim__App, map_named) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimApp_map_named(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__App::map_named called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimApp_map_named(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__app_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimApp_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimApp_handlers(), 0);
    }
}

PHP_METHOD(VSlim__App, handle_websocket) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimApp_handle_websocket(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!wrapper->v_ptr) RETURN_FALSE;
    vphp_wrap_VSlimApp_handle_websocket(wrapper->v_ptr, ctx);
}

PHP_METHOD(VSlim__App, middleware) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimApp_middleware(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__App::middleware called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimApp_middleware(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__app_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimApp_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimApp_handlers(), 0);
    }
}


PHP_METHOD(VSlim__App, before) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimApp_before(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__App::before called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimApp_before(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__app_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimApp_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimApp_handlers(), 0);
    }
}


PHP_METHOD(VSlim__App, after) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimApp_after(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__App::after called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimApp_after(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__app_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimApp_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimApp_handlers(), 0);
    }
}


PHP_METHOD(VSlim__App, set_not_found_handler) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimApp_set_not_found_handler(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__App::set_not_found_handler called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimApp_set_not_found_handler(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__app_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimApp_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimApp_handlers(), 0);
    }
}


PHP_METHOD(VSlim__App, not_found) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimApp_not_found(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__App::not_found called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimApp_not_found(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__app_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimApp_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimApp_handlers(), 0);
    }
}


PHP_METHOD(VSlim__App, set_error_handler) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimApp_set_error_handler(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__App::set_error_handler called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimApp_set_error_handler(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__app_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimApp_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimApp_handlers(), 0);
    }
}


PHP_METHOD(VSlim__App, error) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimApp_error(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__App::error called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimApp_error(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__app_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimApp_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimApp_handlers(), 0);
    }
}


PHP_METHOD(VSlim__App, set_error_response_json) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimApp_set_error_response_json(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__App::set_error_response_json called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimApp_set_error_response_json(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__app_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimApp_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimApp_handlers(), 0);
    }
}

PHP_METHOD(VSlim__App, error_response_json_enabled) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimApp_error_response_json_enabled(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!wrapper->v_ptr) RETURN_FALSE;
    vphp_wrap_VSlimApp_error_response_json_enabled(wrapper->v_ptr, ctx);
}
PHP_METHOD(VSlim__App, has_logger) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimApp_has_logger(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!wrapper->v_ptr) RETURN_FALSE;
    vphp_wrap_VSlimApp_has_logger(wrapper->v_ptr, ctx);
}

PHP_METHOD(VSlim__App, set_logger) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimApp_set_logger(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__App::set_logger called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimApp_set_logger(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__app_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimApp_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimApp_handlers(), 0);
    }
}


PHP_METHOD(VSlim__App, logger) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimApp_logger(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__App::logger called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimApp_logger(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__log__logger_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimLogger_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimLogger_handlers(), 0);
    }
}

PHP_METHOD(VSlim__App, url_for) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimApp_url_for(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!wrapper->v_ptr) RETURN_FALSE;
    vphp_wrap_VSlimApp_url_for(wrapper->v_ptr, ctx);
}
PHP_METHOD(VSlim__App, url_for_query) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimApp_url_for_query(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!wrapper->v_ptr) RETURN_FALSE;
    vphp_wrap_VSlimApp_url_for_query(wrapper->v_ptr, ctx);
}
PHP_METHOD(VSlim__App, url_for_abs) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimApp_url_for_abs(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!wrapper->v_ptr) RETURN_FALSE;
    vphp_wrap_VSlimApp_url_for_abs(wrapper->v_ptr, ctx);
}
PHP_METHOD(VSlim__App, url_for_query_abs) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimApp_url_for_query_abs(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!wrapper->v_ptr) RETURN_FALSE;
    vphp_wrap_VSlimApp_url_for_query_abs(wrapper->v_ptr, ctx);
}

PHP_METHOD(VSlim__App, redirect_to) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimApp_redirect_to(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__App::redirect_to called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimApp_redirect_to(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__response_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimResponse_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimResponse_handlers(), 0);
    }
}


PHP_METHOD(VSlim__App, redirect_to_query) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimApp_redirect_to_query(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__App::redirect_to_query called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimApp_redirect_to_query(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__response_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimResponse_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimResponse_handlers(), 0);
    }
}

PHP_METHOD(VSlim__App, route_count) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimApp_route_count(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!wrapper->v_ptr) RETURN_FALSE;
    vphp_wrap_VSlimApp_route_count(wrapper->v_ptr, ctx);
}
PHP_METHOD(VSlim__App, route_names) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimApp_route_names(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!wrapper->v_ptr) RETURN_FALSE;
    vphp_wrap_VSlimApp_route_names(wrapper->v_ptr, ctx);
}
PHP_METHOD(VSlim__App, has_route_name) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimApp_has_route_name(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!wrapper->v_ptr) RETURN_FALSE;
    vphp_wrap_VSlimApp_has_route_name(wrapper->v_ptr, ctx);
}
PHP_METHOD(VSlim__App, route_manifest_lines) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimApp_route_manifest_lines(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!wrapper->v_ptr) RETURN_FALSE;
    vphp_wrap_VSlimApp_route_manifest_lines(wrapper->v_ptr, ctx);
}
PHP_METHOD(VSlim__App, route_conflict_keys) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimApp_route_conflict_keys(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!wrapper->v_ptr) RETURN_FALSE;
    vphp_wrap_VSlimApp_route_conflict_keys(wrapper->v_ptr, ctx);
}
PHP_METHOD(VSlim__App, route_manifest) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimApp_route_manifest(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!wrapper->v_ptr) RETURN_FALSE;
    vphp_wrap_VSlimApp_route_manifest(wrapper->v_ptr, ctx);
}
PHP_METHOD(VSlim__App, route_conflicts) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimApp_route_conflicts(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!wrapper->v_ptr) RETURN_FALSE;
    vphp_wrap_VSlimApp_route_conflicts(wrapper->v_ptr, ctx);
}
PHP_METHOD(VSlim__App, allowed_methods_for) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimApp_allowed_methods_for(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!wrapper->v_ptr) RETURN_FALSE;
    vphp_wrap_VSlimApp_allowed_methods_for(wrapper->v_ptr, ctx);
}

PHP_METHOD(VSlim__App, __construct) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern vphp_class_handlers* VSlimApp_handlers();
    vphp_class_handlers *h = VSlimApp_handlers();
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    wrapper->v_ptr = h->new_raw();
    vphp_register_object(wrapper->v_ptr, Z_OBJ_P(getThis()));
    vphp_bind_handlers_with_ownership(Z_OBJ_P(getThis()), h, 1);
}

static const zend_function_entry vslim__app_methods[] = {
    PHP_ME(VSlim__App, __construct, arginfo_vslim__app___construct, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__App, set_view_base_path, arginfo_vslim__app_set_view_base_path, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__App, view_base_path, arginfo_vslim__app_view_base_path, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__App, set_assets_prefix, arginfo_vslim__app_set_assets_prefix, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__App, assets_prefix, arginfo_vslim__app_assets_prefix, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__App, set_view_cache, arginfo_vslim__app_set_view_cache, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__App, view_cache_enabled, arginfo_vslim__app_view_cache_enabled, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__App, clear_view_cache, arginfo_vslim__app_clear_view_cache, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__App, helper, arginfo_vslim__app_helper, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__App, make_view, arginfo_vslim__app_make_view, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__App, view, arginfo_vslim__app_view, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__App, view_with_layout, arginfo_vslim__app_view_with_layout, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__App, demo, arginfo_vslim__app_demo, ZEND_ACC_PUBLIC | ZEND_ACC_STATIC)
    PHP_ME(VSlim__App, set_base_path, arginfo_vslim__app_set_base_path, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__App, has_container, arginfo_vslim__app_has_container, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__App, set_container, arginfo_vslim__app_set_container, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__App, container, arginfo_vslim__app_container, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__App, has_config, arginfo_vslim__app_has_config, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__App, set_config, arginfo_vslim__app_set_config, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__App, config, arginfo_vslim__app_config, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__App, load_config, arginfo_vslim__app_load_config, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__App, load_config_text, arginfo_vslim__app_load_config_text, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__App, group, arginfo_vslim__app_group, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__App, dispatch, arginfo_vslim__app_dispatch, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__App, dispatch_body, arginfo_vslim__app_dispatch_body, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__App, dispatch_request, arginfo_vslim__app_dispatch_request, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__App, dispatch_envelope, arginfo_vslim__app_dispatch_envelope, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__App, dispatch_envelope_worker, arginfo_vslim__app_dispatch_envelope_worker, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__App, dispatch_envelope_map, arginfo_vslim__app_dispatch_envelope_map, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__App, get, arginfo_vslim__app_get, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__App, post, arginfo_vslim__app_post, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__App, put, arginfo_vslim__app_put, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__App, head, arginfo_vslim__app_head, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__App, options, arginfo_vslim__app_options, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__App, patch, arginfo_vslim__app_patch, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__App, delete, arginfo_vslim__app_delete, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__App, any, arginfo_vslim__app_any, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__App, live, arginfo_vslim__app_live, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__App, live_ws, arginfo_vslim__app_live_ws, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__App, websocket, arginfo_vslim__app_websocket, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__App, websocket_named, arginfo_vslim__app_websocket_named, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__App, has_mcp, arginfo_vslim__app_has_mcp, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__App, set_mcp, arginfo_vslim__app_set_mcp, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__App, mcp, arginfo_vslim__app_mcp, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__App, handle_mcp_dispatch, arginfo_vslim__app_handle_mcp_dispatch, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__App, map, arginfo_vslim__app_map, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__App, resource, arginfo_vslim__app_resource, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__App, api_resource, arginfo_vslim__app_api_resource, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__App, singleton, arginfo_vslim__app_singleton, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__App, api_singleton, arginfo_vslim__app_api_singleton, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__App, resource_opts, arginfo_vslim__app_resource_opts, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__App, api_resource_opts, arginfo_vslim__app_api_resource_opts, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__App, singleton_opts, arginfo_vslim__app_singleton_opts, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__App, api_singleton_opts, arginfo_vslim__app_api_singleton_opts, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__App, get_named, arginfo_vslim__app_get_named, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__App, post_named, arginfo_vslim__app_post_named, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__App, put_named, arginfo_vslim__app_put_named, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__App, head_named, arginfo_vslim__app_head_named, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__App, options_named, arginfo_vslim__app_options_named, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__App, patch_named, arginfo_vslim__app_patch_named, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__App, delete_named, arginfo_vslim__app_delete_named, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__App, any_named, arginfo_vslim__app_any_named, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__App, map_named, arginfo_vslim__app_map_named, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__App, handle_websocket, arginfo_vslim__app_handle_websocket, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__App, middleware, arginfo_vslim__app_middleware, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__App, before, arginfo_vslim__app_before, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__App, after, arginfo_vslim__app_after, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__App, set_not_found_handler, arginfo_vslim__app_set_not_found_handler, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__App, not_found, arginfo_vslim__app_not_found, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__App, set_error_handler, arginfo_vslim__app_set_error_handler, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__App, error, arginfo_vslim__app_error, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__App, set_error_response_json, arginfo_vslim__app_set_error_response_json, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__App, error_response_json_enabled, arginfo_vslim__app_error_response_json_enabled, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__App, has_logger, arginfo_vslim__app_has_logger, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__App, set_logger, arginfo_vslim__app_set_logger, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__App, logger, arginfo_vslim__app_logger, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__App, url_for, arginfo_vslim__app_url_for, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__App, url_for_query, arginfo_vslim__app_url_for_query, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__App, url_for_abs, arginfo_vslim__app_url_for_abs, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__App, url_for_query_abs, arginfo_vslim__app_url_for_query_abs, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__App, redirect_to, arginfo_vslim__app_redirect_to, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__App, redirect_to_query, arginfo_vslim__app_redirect_to_query, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__App, route_count, arginfo_vslim__app_route_count, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__App, route_names, arginfo_vslim__app_route_names, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__App, has_route_name, arginfo_vslim__app_has_route_name, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__App, route_manifest_lines, arginfo_vslim__app_route_manifest_lines, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__App, route_conflict_keys, arginfo_vslim__app_route_conflict_keys, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__App, route_manifest, arginfo_vslim__app_route_manifest, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__App, route_conflicts, arginfo_vslim__app_route_conflicts, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__App, allowed_methods_for, arginfo_vslim__app_allowed_methods_for, ZEND_ACC_PUBLIC)
    PHP_FE_END
};

zend_class_entry *vslim__routegroup_ce = NULL;
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__routegroup___construct, 0, 0, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__routegroup_group, 0, 0, 1)
ZEND_ARG_TYPE_INFO(0, prefix, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__routegroup_middleware, 0, 0, 1)
ZEND_ARG_TYPE_INFO(0, handler, IS_MIXED, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__routegroup_before, 0, 0, 1)
ZEND_ARG_TYPE_INFO(0, handler, IS_MIXED, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__routegroup_after, 0, 0, 1)
ZEND_ARG_TYPE_INFO(0, handler, IS_MIXED, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__routegroup_get, 0, 0, 2)
ZEND_ARG_TYPE_INFO(0, pattern, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, handler, IS_MIXED, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__routegroup_post, 0, 0, 2)
ZEND_ARG_TYPE_INFO(0, pattern, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, handler, IS_MIXED, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__routegroup_put, 0, 0, 2)
ZEND_ARG_TYPE_INFO(0, pattern, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, handler, IS_MIXED, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__routegroup_head, 0, 0, 2)
ZEND_ARG_TYPE_INFO(0, pattern, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, handler, IS_MIXED, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__routegroup_options, 0, 0, 2)
ZEND_ARG_TYPE_INFO(0, pattern, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, handler, IS_MIXED, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__routegroup_patch, 0, 0, 2)
ZEND_ARG_TYPE_INFO(0, pattern, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, handler, IS_MIXED, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__routegroup_delete, 0, 0, 2)
ZEND_ARG_TYPE_INFO(0, pattern, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, handler, IS_MIXED, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__routegroup_any, 0, 0, 2)
ZEND_ARG_TYPE_INFO(0, pattern, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, handler, IS_MIXED, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__routegroup_live, 0, 0, 2)
ZEND_ARG_TYPE_INFO(0, pattern, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, handler, IS_MIXED, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__routegroup_websocket, 0, 0, 2)
ZEND_ARG_TYPE_INFO(0, pattern, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, handler, IS_MIXED, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__routegroup_map, 0, 0, 3)
ZEND_ARG_TYPE_INFO(0, methods, IS_MIXED, 0)
ZEND_ARG_TYPE_INFO(0, pattern, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, handler, IS_MIXED, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__routegroup_resource, 0, 0, 2)
ZEND_ARG_TYPE_INFO(0, resource_path, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, controller, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__routegroup_api_resource, 0, 0, 2)
ZEND_ARG_TYPE_INFO(0, resource_path, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, controller, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__routegroup_singleton, 0, 0, 2)
ZEND_ARG_TYPE_INFO(0, resource_path, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, controller, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__routegroup_api_singleton, 0, 0, 2)
ZEND_ARG_TYPE_INFO(0, resource_path, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, controller, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__routegroup_resource_opts, 0, 0, 3)
ZEND_ARG_TYPE_INFO(0, resource_path, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, controller, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, options, IS_MIXED, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__routegroup_api_resource_opts, 0, 0, 3)
ZEND_ARG_TYPE_INFO(0, resource_path, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, controller, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, options, IS_MIXED, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__routegroup_singleton_opts, 0, 0, 3)
ZEND_ARG_TYPE_INFO(0, resource_path, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, controller, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, options, IS_MIXED, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__routegroup_api_singleton_opts, 0, 0, 3)
ZEND_ARG_TYPE_INFO(0, resource_path, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, controller, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, options, IS_MIXED, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__routegroup_get_named, 0, 0, 3)
ZEND_ARG_TYPE_INFO(0, name, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, pattern, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, handler, IS_MIXED, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__routegroup_post_named, 0, 0, 3)
ZEND_ARG_TYPE_INFO(0, name, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, pattern, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, handler, IS_MIXED, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__routegroup_put_named, 0, 0, 3)
ZEND_ARG_TYPE_INFO(0, name, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, pattern, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, handler, IS_MIXED, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__routegroup_head_named, 0, 0, 3)
ZEND_ARG_TYPE_INFO(0, name, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, pattern, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, handler, IS_MIXED, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__routegroup_options_named, 0, 0, 3)
ZEND_ARG_TYPE_INFO(0, name, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, pattern, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, handler, IS_MIXED, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__routegroup_patch_named, 0, 0, 3)
ZEND_ARG_TYPE_INFO(0, name, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, pattern, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, handler, IS_MIXED, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__routegroup_delete_named, 0, 0, 3)
ZEND_ARG_TYPE_INFO(0, name, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, pattern, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, handler, IS_MIXED, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__routegroup_any_named, 0, 0, 3)
ZEND_ARG_TYPE_INFO(0, name, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, pattern, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, handler, IS_MIXED, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__routegroup_websocket_named, 0, 0, 3)
ZEND_ARG_TYPE_INFO(0, name, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, pattern, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, handler, IS_MIXED, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__routegroup_map_named, 0, 0, 4)
ZEND_ARG_TYPE_INFO(0, methods, IS_MIXED, 0)
ZEND_ARG_TYPE_INFO(0, name, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, pattern, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, handler, IS_MIXED, 0)
ZEND_END_ARG_INFO()

PHP_METHOD(VSlim__RouteGroup, group) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_RouteGroup_group(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__RouteGroup::group called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_RouteGroup_group(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__routegroup_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* RouteGroup_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), RouteGroup_handlers(), 0);
    }
}


PHP_METHOD(VSlim__RouteGroup, middleware) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_RouteGroup_middleware(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__RouteGroup::middleware called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_RouteGroup_middleware(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__routegroup_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* RouteGroup_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), RouteGroup_handlers(), 0);
    }
}


PHP_METHOD(VSlim__RouteGroup, before) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_RouteGroup_before(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__RouteGroup::before called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_RouteGroup_before(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__routegroup_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* RouteGroup_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), RouteGroup_handlers(), 0);
    }
}


PHP_METHOD(VSlim__RouteGroup, after) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_RouteGroup_after(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__RouteGroup::after called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_RouteGroup_after(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__routegroup_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* RouteGroup_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), RouteGroup_handlers(), 0);
    }
}


PHP_METHOD(VSlim__RouteGroup, get) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_RouteGroup_get(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__RouteGroup::get called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_RouteGroup_get(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__routegroup_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* RouteGroup_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), RouteGroup_handlers(), 0);
    }
}


PHP_METHOD(VSlim__RouteGroup, post) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_RouteGroup_post(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__RouteGroup::post called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_RouteGroup_post(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__routegroup_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* RouteGroup_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), RouteGroup_handlers(), 0);
    }
}


PHP_METHOD(VSlim__RouteGroup, put) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_RouteGroup_put(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__RouteGroup::put called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_RouteGroup_put(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__routegroup_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* RouteGroup_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), RouteGroup_handlers(), 0);
    }
}


PHP_METHOD(VSlim__RouteGroup, head) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_RouteGroup_head(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__RouteGroup::head called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_RouteGroup_head(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__routegroup_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* RouteGroup_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), RouteGroup_handlers(), 0);
    }
}


PHP_METHOD(VSlim__RouteGroup, options) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_RouteGroup_options(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__RouteGroup::options called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_RouteGroup_options(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__routegroup_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* RouteGroup_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), RouteGroup_handlers(), 0);
    }
}


PHP_METHOD(VSlim__RouteGroup, patch) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_RouteGroup_patch(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__RouteGroup::patch called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_RouteGroup_patch(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__routegroup_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* RouteGroup_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), RouteGroup_handlers(), 0);
    }
}


PHP_METHOD(VSlim__RouteGroup, delete) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_RouteGroup_delete(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__RouteGroup::delete called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_RouteGroup_delete(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__routegroup_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* RouteGroup_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), RouteGroup_handlers(), 0);
    }
}


PHP_METHOD(VSlim__RouteGroup, any) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_RouteGroup_any(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__RouteGroup::any called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_RouteGroup_any(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__routegroup_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* RouteGroup_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), RouteGroup_handlers(), 0);
    }
}


PHP_METHOD(VSlim__RouteGroup, live) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_RouteGroup_live(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__RouteGroup::live called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_RouteGroup_live(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__routegroup_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* RouteGroup_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), RouteGroup_handlers(), 0);
    }
}


PHP_METHOD(VSlim__RouteGroup, websocket) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_RouteGroup_websocket(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__RouteGroup::websocket called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_RouteGroup_websocket(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__routegroup_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* RouteGroup_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), RouteGroup_handlers(), 0);
    }
}


PHP_METHOD(VSlim__RouteGroup, map) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_RouteGroup_map(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__RouteGroup::map called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_RouteGroup_map(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__routegroup_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* RouteGroup_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), RouteGroup_handlers(), 0);
    }
}


PHP_METHOD(VSlim__RouteGroup, resource) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_RouteGroup_resource(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__RouteGroup::resource called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_RouteGroup_resource(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__routegroup_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* RouteGroup_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), RouteGroup_handlers(), 0);
    }
}


PHP_METHOD(VSlim__RouteGroup, api_resource) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_RouteGroup_api_resource(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__RouteGroup::api_resource called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_RouteGroup_api_resource(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__routegroup_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* RouteGroup_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), RouteGroup_handlers(), 0);
    }
}


PHP_METHOD(VSlim__RouteGroup, singleton) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_RouteGroup_singleton(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__RouteGroup::singleton called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_RouteGroup_singleton(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__routegroup_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* RouteGroup_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), RouteGroup_handlers(), 0);
    }
}


PHP_METHOD(VSlim__RouteGroup, api_singleton) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_RouteGroup_api_singleton(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__RouteGroup::api_singleton called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_RouteGroup_api_singleton(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__routegroup_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* RouteGroup_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), RouteGroup_handlers(), 0);
    }
}


PHP_METHOD(VSlim__RouteGroup, resource_opts) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_RouteGroup_resource_opts(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__RouteGroup::resource_opts called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_RouteGroup_resource_opts(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__routegroup_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* RouteGroup_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), RouteGroup_handlers(), 0);
    }
}


PHP_METHOD(VSlim__RouteGroup, api_resource_opts) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_RouteGroup_api_resource_opts(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__RouteGroup::api_resource_opts called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_RouteGroup_api_resource_opts(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__routegroup_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* RouteGroup_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), RouteGroup_handlers(), 0);
    }
}


PHP_METHOD(VSlim__RouteGroup, singleton_opts) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_RouteGroup_singleton_opts(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__RouteGroup::singleton_opts called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_RouteGroup_singleton_opts(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__routegroup_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* RouteGroup_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), RouteGroup_handlers(), 0);
    }
}


PHP_METHOD(VSlim__RouteGroup, api_singleton_opts) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_RouteGroup_api_singleton_opts(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__RouteGroup::api_singleton_opts called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_RouteGroup_api_singleton_opts(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__routegroup_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* RouteGroup_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), RouteGroup_handlers(), 0);
    }
}


PHP_METHOD(VSlim__RouteGroup, get_named) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_RouteGroup_get_named(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__RouteGroup::get_named called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_RouteGroup_get_named(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__routegroup_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* RouteGroup_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), RouteGroup_handlers(), 0);
    }
}


PHP_METHOD(VSlim__RouteGroup, post_named) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_RouteGroup_post_named(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__RouteGroup::post_named called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_RouteGroup_post_named(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__routegroup_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* RouteGroup_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), RouteGroup_handlers(), 0);
    }
}


PHP_METHOD(VSlim__RouteGroup, put_named) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_RouteGroup_put_named(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__RouteGroup::put_named called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_RouteGroup_put_named(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__routegroup_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* RouteGroup_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), RouteGroup_handlers(), 0);
    }
}


PHP_METHOD(VSlim__RouteGroup, head_named) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_RouteGroup_head_named(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__RouteGroup::head_named called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_RouteGroup_head_named(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__routegroup_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* RouteGroup_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), RouteGroup_handlers(), 0);
    }
}


PHP_METHOD(VSlim__RouteGroup, options_named) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_RouteGroup_options_named(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__RouteGroup::options_named called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_RouteGroup_options_named(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__routegroup_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* RouteGroup_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), RouteGroup_handlers(), 0);
    }
}


PHP_METHOD(VSlim__RouteGroup, patch_named) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_RouteGroup_patch_named(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__RouteGroup::patch_named called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_RouteGroup_patch_named(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__routegroup_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* RouteGroup_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), RouteGroup_handlers(), 0);
    }
}


PHP_METHOD(VSlim__RouteGroup, delete_named) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_RouteGroup_delete_named(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__RouteGroup::delete_named called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_RouteGroup_delete_named(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__routegroup_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* RouteGroup_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), RouteGroup_handlers(), 0);
    }
}


PHP_METHOD(VSlim__RouteGroup, any_named) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_RouteGroup_any_named(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__RouteGroup::any_named called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_RouteGroup_any_named(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__routegroup_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* RouteGroup_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), RouteGroup_handlers(), 0);
    }
}


PHP_METHOD(VSlim__RouteGroup, websocket_named) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_RouteGroup_websocket_named(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__RouteGroup::websocket_named called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_RouteGroup_websocket_named(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__routegroup_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* RouteGroup_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), RouteGroup_handlers(), 0);
    }
}


PHP_METHOD(VSlim__RouteGroup, map_named) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_RouteGroup_map_named(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__RouteGroup::map_named called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_RouteGroup_map_named(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__routegroup_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* RouteGroup_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), RouteGroup_handlers(), 0);
    }
}


PHP_METHOD(VSlim__RouteGroup, __construct) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern vphp_class_handlers* RouteGroup_handlers();
    vphp_class_handlers *h = RouteGroup_handlers();
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    wrapper->v_ptr = h->new_raw();
    vphp_register_object(wrapper->v_ptr, Z_OBJ_P(getThis()));
    vphp_bind_handlers_with_ownership(Z_OBJ_P(getThis()), h, 1);
}

static const zend_function_entry vslim__routegroup_methods[] = {
    PHP_ME(VSlim__RouteGroup, __construct, arginfo_vslim__routegroup___construct, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__RouteGroup, group, arginfo_vslim__routegroup_group, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__RouteGroup, middleware, arginfo_vslim__routegroup_middleware, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__RouteGroup, before, arginfo_vslim__routegroup_before, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__RouteGroup, after, arginfo_vslim__routegroup_after, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__RouteGroup, get, arginfo_vslim__routegroup_get, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__RouteGroup, post, arginfo_vslim__routegroup_post, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__RouteGroup, put, arginfo_vslim__routegroup_put, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__RouteGroup, head, arginfo_vslim__routegroup_head, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__RouteGroup, options, arginfo_vslim__routegroup_options, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__RouteGroup, patch, arginfo_vslim__routegroup_patch, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__RouteGroup, delete, arginfo_vslim__routegroup_delete, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__RouteGroup, any, arginfo_vslim__routegroup_any, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__RouteGroup, live, arginfo_vslim__routegroup_live, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__RouteGroup, websocket, arginfo_vslim__routegroup_websocket, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__RouteGroup, map, arginfo_vslim__routegroup_map, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__RouteGroup, resource, arginfo_vslim__routegroup_resource, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__RouteGroup, api_resource, arginfo_vslim__routegroup_api_resource, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__RouteGroup, singleton, arginfo_vslim__routegroup_singleton, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__RouteGroup, api_singleton, arginfo_vslim__routegroup_api_singleton, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__RouteGroup, resource_opts, arginfo_vslim__routegroup_resource_opts, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__RouteGroup, api_resource_opts, arginfo_vslim__routegroup_api_resource_opts, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__RouteGroup, singleton_opts, arginfo_vslim__routegroup_singleton_opts, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__RouteGroup, api_singleton_opts, arginfo_vslim__routegroup_api_singleton_opts, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__RouteGroup, get_named, arginfo_vslim__routegroup_get_named, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__RouteGroup, post_named, arginfo_vslim__routegroup_post_named, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__RouteGroup, put_named, arginfo_vslim__routegroup_put_named, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__RouteGroup, head_named, arginfo_vslim__routegroup_head_named, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__RouteGroup, options_named, arginfo_vslim__routegroup_options_named, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__RouteGroup, patch_named, arginfo_vslim__routegroup_patch_named, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__RouteGroup, delete_named, arginfo_vslim__routegroup_delete_named, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__RouteGroup, any_named, arginfo_vslim__routegroup_any_named, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__RouteGroup, websocket_named, arginfo_vslim__routegroup_websocket_named, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__RouteGroup, map_named, arginfo_vslim__routegroup_map_named, ZEND_ACC_PUBLIC)
    PHP_FE_END
};

zend_class_entry *vslim__request_ce = NULL;
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__request_construct, 0, 0, 3)
ZEND_ARG_TYPE_INFO(0, method, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, raw_path, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, body, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__request_str, 0, 0, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__request_set_query, 0, 0, 1)
ZEND_ARG_TYPE_INFO(0, query, IS_MIXED, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__request_set_method, 0, 0, 1)
ZEND_ARG_TYPE_INFO(0, method, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__request_set_target, 0, 0, 1)
ZEND_ARG_TYPE_INFO(0, raw_path, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__request_set_body, 0, 0, 1)
ZEND_ARG_TYPE_INFO(0, body, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__request_set_scheme, 0, 0, 1)
ZEND_ARG_TYPE_INFO(0, scheme, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__request_set_host, 0, 0, 1)
ZEND_ARG_TYPE_INFO(0, host, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__request_set_port, 0, 0, 1)
ZEND_ARG_TYPE_INFO(0, port, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__request_set_protocol_version, 0, 0, 1)
ZEND_ARG_TYPE_INFO(0, protocol_version, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__request_set_remote_addr, 0, 0, 1)
ZEND_ARG_TYPE_INFO(0, remote_addr, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__request_set_headers, 0, 0, 1)
ZEND_ARG_TYPE_INFO(0, headers, IS_MIXED, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__request_set_cookies, 0, 0, 1)
ZEND_ARG_TYPE_INFO(0, cookies, IS_MIXED, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__request_set_attributes, 0, 0, 1)
ZEND_ARG_TYPE_INFO(0, attributes, IS_MIXED, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__request_set_server, 0, 0, 1)
ZEND_ARG_TYPE_INFO(0, server, IS_MIXED, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__request_set_uploaded_files, 0, 0, 1)
ZEND_ARG_TYPE_INFO(0, uploaded_files, IS_MIXED, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__request_set_params, 0, 0, 1)
ZEND_ARG_TYPE_INFO(0, params, IS_MIXED, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__request_query, 0, 1, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, key, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__request_query_params, 0, 0, IS_ARRAY, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__request_has_query, 0, 1, _IS_BOOL, 0)
ZEND_ARG_TYPE_INFO(0, key, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__request_input, 0, 1, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, key, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__request_input_or, 0, 2, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, key, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, default_value, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__request_has_input, 0, 1, _IS_BOOL, 0)
ZEND_ARG_TYPE_INFO(0, key, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__request_all_inputs, 0, 0, IS_ARRAY, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__request_parsed_body, 0, 0, IS_ARRAY, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__request_body_format, 0, 0, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__request_is_json_body, 0, 0, _IS_BOOL, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__request_is_form_body, 0, 0, _IS_BOOL, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__request_is_multipart_body, 0, 0, _IS_BOOL, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__request_json_body, 0, 0, IS_ARRAY, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__request_form_body, 0, 0, IS_ARRAY, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__request_multipart_body, 0, 0, IS_ARRAY, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__request_parse_error, 0, 0, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__request_query_all, 0, 0, IS_ARRAY, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__request_header, 0, 1, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, name, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__request_headers, 0, 0, IS_ARRAY, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__request_has_header, 0, 1, _IS_BOOL, 0)
ZEND_ARG_TYPE_INFO(0, name, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__request_content_type, 0, 0, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__request_request_id, 0, 0, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__request_trace_id, 0, 0, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__request_cookie, 0, 1, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, name, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__request_cookies, 0, 0, IS_ARRAY, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__request_has_cookie, 0, 1, _IS_BOOL, 0)
ZEND_ARG_TYPE_INFO(0, name, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__request_param, 0, 1, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, name, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__request_route_params, 0, 0, IS_ARRAY, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__request_has_param, 0, 1, _IS_BOOL, 0)
ZEND_ARG_TYPE_INFO(0, name, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__request_attribute, 0, 1, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, name, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__request_attributes, 0, 0, IS_ARRAY, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__request_has_attribute, 0, 1, _IS_BOOL, 0)
ZEND_ARG_TYPE_INFO(0, name, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__request_server_value, 0, 1, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, name, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__request_server_params, 0, 0, IS_ARRAY, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__request_has_server, 0, 1, _IS_BOOL, 0)
ZEND_ARG_TYPE_INFO(0, name, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__request_uploaded_file_count, 0, 0, IS_LONG, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__request_uploaded_files, 0, 0, IS_ARRAY, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__request_has_uploaded_files, 0, 0, _IS_BOOL, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__request_is_secure, 0, 0, _IS_BOOL, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__request_headers_all, 0, 0, IS_ARRAY, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__request_cookies_all, 0, 0, IS_ARRAY, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__request_params_all, 0, 0, IS_ARRAY, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__request_attributes_all, 0, 0, IS_ARRAY, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__request_server_all, 0, 0, IS_ARRAY, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__request_uploaded_files_all, 0, 0, IS_ARRAY, 0)
ZEND_END_ARG_INFO()
PHP_METHOD(VSlim__Request, __construct) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern vphp_class_handlers* VSlimRequest_handlers();
    vphp_class_handlers *h = VSlimRequest_handlers();
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    wrapper->v_ptr = h->new_raw();
    vphp_register_object(wrapper->v_ptr, Z_OBJ_P(getThis()));
    vphp_bind_handlers_with_ownership(Z_OBJ_P(getThis()), h, 1);
    extern void vphp_wrap_VSlimRequest_construct(void* v_ptr, vphp_context_internal ctx);
    void* v_ptr = wrapper->v_ptr;
    vphp_wrap_VSlimRequest_construct(v_ptr, ctx);
}
PHP_METHOD(VSlim__Request, __toString) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimRequest_str(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!wrapper->v_ptr) RETURN_FALSE;
    vphp_wrap_VSlimRequest_str(wrapper->v_ptr, ctx);
}

PHP_METHOD(VSlim__Request, set_query) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimRequest_set_query(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__Request::set_query called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimRequest_set_query(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__request_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimRequest_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimRequest_handlers(), 0);
    }
}


PHP_METHOD(VSlim__Request, set_method) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimRequest_set_method(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__Request::set_method called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimRequest_set_method(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__request_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimRequest_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimRequest_handlers(), 0);
    }
}


PHP_METHOD(VSlim__Request, set_target) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimRequest_set_target(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__Request::set_target called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimRequest_set_target(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__request_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimRequest_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimRequest_handlers(), 0);
    }
}


PHP_METHOD(VSlim__Request, set_body) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimRequest_set_body(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__Request::set_body called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimRequest_set_body(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__request_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimRequest_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimRequest_handlers(), 0);
    }
}


PHP_METHOD(VSlim__Request, set_scheme) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimRequest_set_scheme(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__Request::set_scheme called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimRequest_set_scheme(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__request_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimRequest_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimRequest_handlers(), 0);
    }
}


PHP_METHOD(VSlim__Request, set_host) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimRequest_set_host(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__Request::set_host called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimRequest_set_host(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__request_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimRequest_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimRequest_handlers(), 0);
    }
}


PHP_METHOD(VSlim__Request, set_port) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimRequest_set_port(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__Request::set_port called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimRequest_set_port(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__request_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimRequest_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimRequest_handlers(), 0);
    }
}


PHP_METHOD(VSlim__Request, set_protocol_version) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimRequest_set_protocol_version(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__Request::set_protocol_version called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimRequest_set_protocol_version(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__request_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimRequest_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimRequest_handlers(), 0);
    }
}


PHP_METHOD(VSlim__Request, set_remote_addr) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimRequest_set_remote_addr(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__Request::set_remote_addr called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimRequest_set_remote_addr(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__request_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimRequest_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimRequest_handlers(), 0);
    }
}


PHP_METHOD(VSlim__Request, set_headers) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimRequest_set_headers(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__Request::set_headers called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimRequest_set_headers(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__request_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimRequest_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimRequest_handlers(), 0);
    }
}


PHP_METHOD(VSlim__Request, set_cookies) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimRequest_set_cookies(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__Request::set_cookies called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimRequest_set_cookies(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__request_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimRequest_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimRequest_handlers(), 0);
    }
}


PHP_METHOD(VSlim__Request, set_attributes) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimRequest_set_attributes(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__Request::set_attributes called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimRequest_set_attributes(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__request_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimRequest_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimRequest_handlers(), 0);
    }
}


PHP_METHOD(VSlim__Request, set_server) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimRequest_set_server(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__Request::set_server called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimRequest_set_server(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__request_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimRequest_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimRequest_handlers(), 0);
    }
}


PHP_METHOD(VSlim__Request, set_uploaded_files) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimRequest_set_uploaded_files(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__Request::set_uploaded_files called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimRequest_set_uploaded_files(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__request_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimRequest_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimRequest_handlers(), 0);
    }
}


PHP_METHOD(VSlim__Request, set_params) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimRequest_set_params(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__Request::set_params called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimRequest_set_params(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__request_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimRequest_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimRequest_handlers(), 0);
    }
}

PHP_METHOD(VSlim__Request, query) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimRequest_query(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!wrapper->v_ptr) RETURN_FALSE;
    vphp_wrap_VSlimRequest_query(wrapper->v_ptr, ctx);
}
PHP_METHOD(VSlim__Request, query_params) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimRequest_query_params(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!wrapper->v_ptr) RETURN_FALSE;
    vphp_wrap_VSlimRequest_query_params(wrapper->v_ptr, ctx);
}
PHP_METHOD(VSlim__Request, has_query) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimRequest_has_query(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!wrapper->v_ptr) RETURN_FALSE;
    vphp_wrap_VSlimRequest_has_query(wrapper->v_ptr, ctx);
}
PHP_METHOD(VSlim__Request, input) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimRequest_input(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!wrapper->v_ptr) RETURN_FALSE;
    vphp_wrap_VSlimRequest_input(wrapper->v_ptr, ctx);
}
PHP_METHOD(VSlim__Request, input_or) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimRequest_input_or(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!wrapper->v_ptr) RETURN_FALSE;
    vphp_wrap_VSlimRequest_input_or(wrapper->v_ptr, ctx);
}
PHP_METHOD(VSlim__Request, has_input) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimRequest_has_input(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!wrapper->v_ptr) RETURN_FALSE;
    vphp_wrap_VSlimRequest_has_input(wrapper->v_ptr, ctx);
}
PHP_METHOD(VSlim__Request, all_inputs) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimRequest_all_inputs(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!wrapper->v_ptr) RETURN_FALSE;
    vphp_wrap_VSlimRequest_all_inputs(wrapper->v_ptr, ctx);
}
PHP_METHOD(VSlim__Request, parsed_body) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimRequest_parsed_body(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!wrapper->v_ptr) RETURN_FALSE;
    vphp_wrap_VSlimRequest_parsed_body(wrapper->v_ptr, ctx);
}
PHP_METHOD(VSlim__Request, body_format) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimRequest_body_format(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!wrapper->v_ptr) RETURN_FALSE;
    vphp_wrap_VSlimRequest_body_format(wrapper->v_ptr, ctx);
}
PHP_METHOD(VSlim__Request, is_json_body) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimRequest_is_json_body(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!wrapper->v_ptr) RETURN_FALSE;
    vphp_wrap_VSlimRequest_is_json_body(wrapper->v_ptr, ctx);
}
PHP_METHOD(VSlim__Request, is_form_body) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimRequest_is_form_body(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!wrapper->v_ptr) RETURN_FALSE;
    vphp_wrap_VSlimRequest_is_form_body(wrapper->v_ptr, ctx);
}
PHP_METHOD(VSlim__Request, is_multipart_body) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimRequest_is_multipart_body(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!wrapper->v_ptr) RETURN_FALSE;
    vphp_wrap_VSlimRequest_is_multipart_body(wrapper->v_ptr, ctx);
}
PHP_METHOD(VSlim__Request, json_body) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimRequest_json_body(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!wrapper->v_ptr) RETURN_FALSE;
    vphp_wrap_VSlimRequest_json_body(wrapper->v_ptr, ctx);
}
PHP_METHOD(VSlim__Request, form_body) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimRequest_form_body(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!wrapper->v_ptr) RETURN_FALSE;
    vphp_wrap_VSlimRequest_form_body(wrapper->v_ptr, ctx);
}
PHP_METHOD(VSlim__Request, multipart_body) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimRequest_multipart_body(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!wrapper->v_ptr) RETURN_FALSE;
    vphp_wrap_VSlimRequest_multipart_body(wrapper->v_ptr, ctx);
}
PHP_METHOD(VSlim__Request, parse_error) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimRequest_parse_error(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!wrapper->v_ptr) RETURN_FALSE;
    vphp_wrap_VSlimRequest_parse_error(wrapper->v_ptr, ctx);
}
PHP_METHOD(VSlim__Request, query_all) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimRequest_query_all(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!wrapper->v_ptr) RETURN_FALSE;
    vphp_wrap_VSlimRequest_query_all(wrapper->v_ptr, ctx);
}
PHP_METHOD(VSlim__Request, header) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimRequest_header(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!wrapper->v_ptr) RETURN_FALSE;
    vphp_wrap_VSlimRequest_header(wrapper->v_ptr, ctx);
}
PHP_METHOD(VSlim__Request, headers) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimRequest_headers(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!wrapper->v_ptr) RETURN_FALSE;
    vphp_wrap_VSlimRequest_headers(wrapper->v_ptr, ctx);
}
PHP_METHOD(VSlim__Request, has_header) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimRequest_has_header(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!wrapper->v_ptr) RETURN_FALSE;
    vphp_wrap_VSlimRequest_has_header(wrapper->v_ptr, ctx);
}
PHP_METHOD(VSlim__Request, content_type) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimRequest_content_type(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!wrapper->v_ptr) RETURN_FALSE;
    vphp_wrap_VSlimRequest_content_type(wrapper->v_ptr, ctx);
}
PHP_METHOD(VSlim__Request, request_id) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimRequest_request_id(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!wrapper->v_ptr) RETURN_FALSE;
    vphp_wrap_VSlimRequest_request_id(wrapper->v_ptr, ctx);
}
PHP_METHOD(VSlim__Request, trace_id) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimRequest_trace_id(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!wrapper->v_ptr) RETURN_FALSE;
    vphp_wrap_VSlimRequest_trace_id(wrapper->v_ptr, ctx);
}
PHP_METHOD(VSlim__Request, cookie) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimRequest_cookie(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!wrapper->v_ptr) RETURN_FALSE;
    vphp_wrap_VSlimRequest_cookie(wrapper->v_ptr, ctx);
}
PHP_METHOD(VSlim__Request, cookies) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimRequest_cookies(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!wrapper->v_ptr) RETURN_FALSE;
    vphp_wrap_VSlimRequest_cookies(wrapper->v_ptr, ctx);
}
PHP_METHOD(VSlim__Request, has_cookie) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimRequest_has_cookie(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!wrapper->v_ptr) RETURN_FALSE;
    vphp_wrap_VSlimRequest_has_cookie(wrapper->v_ptr, ctx);
}
PHP_METHOD(VSlim__Request, param) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimRequest_param(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!wrapper->v_ptr) RETURN_FALSE;
    vphp_wrap_VSlimRequest_param(wrapper->v_ptr, ctx);
}
PHP_METHOD(VSlim__Request, route_params) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimRequest_route_params(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!wrapper->v_ptr) RETURN_FALSE;
    vphp_wrap_VSlimRequest_route_params(wrapper->v_ptr, ctx);
}
PHP_METHOD(VSlim__Request, has_param) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimRequest_has_param(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!wrapper->v_ptr) RETURN_FALSE;
    vphp_wrap_VSlimRequest_has_param(wrapper->v_ptr, ctx);
}
PHP_METHOD(VSlim__Request, attribute) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimRequest_attribute(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!wrapper->v_ptr) RETURN_FALSE;
    vphp_wrap_VSlimRequest_attribute(wrapper->v_ptr, ctx);
}
PHP_METHOD(VSlim__Request, attributes) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimRequest_attributes(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!wrapper->v_ptr) RETURN_FALSE;
    vphp_wrap_VSlimRequest_attributes(wrapper->v_ptr, ctx);
}
PHP_METHOD(VSlim__Request, has_attribute) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimRequest_has_attribute(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!wrapper->v_ptr) RETURN_FALSE;
    vphp_wrap_VSlimRequest_has_attribute(wrapper->v_ptr, ctx);
}
PHP_METHOD(VSlim__Request, server_value) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimRequest_server_value(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!wrapper->v_ptr) RETURN_FALSE;
    vphp_wrap_VSlimRequest_server_value(wrapper->v_ptr, ctx);
}
PHP_METHOD(VSlim__Request, server_params) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimRequest_server_params(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!wrapper->v_ptr) RETURN_FALSE;
    vphp_wrap_VSlimRequest_server_params(wrapper->v_ptr, ctx);
}
PHP_METHOD(VSlim__Request, has_server) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimRequest_has_server(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!wrapper->v_ptr) RETURN_FALSE;
    vphp_wrap_VSlimRequest_has_server(wrapper->v_ptr, ctx);
}
PHP_METHOD(VSlim__Request, uploaded_file_count) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimRequest_uploaded_file_count(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!wrapper->v_ptr) RETURN_FALSE;
    vphp_wrap_VSlimRequest_uploaded_file_count(wrapper->v_ptr, ctx);
}
PHP_METHOD(VSlim__Request, uploaded_files) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimRequest_uploaded_files(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!wrapper->v_ptr) RETURN_FALSE;
    vphp_wrap_VSlimRequest_uploaded_files(wrapper->v_ptr, ctx);
}
PHP_METHOD(VSlim__Request, has_uploaded_files) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimRequest_has_uploaded_files(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!wrapper->v_ptr) RETURN_FALSE;
    vphp_wrap_VSlimRequest_has_uploaded_files(wrapper->v_ptr, ctx);
}
PHP_METHOD(VSlim__Request, is_secure) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimRequest_is_secure(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!wrapper->v_ptr) RETURN_FALSE;
    vphp_wrap_VSlimRequest_is_secure(wrapper->v_ptr, ctx);
}
PHP_METHOD(VSlim__Request, headers_all) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimRequest_headers_all(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!wrapper->v_ptr) RETURN_FALSE;
    vphp_wrap_VSlimRequest_headers_all(wrapper->v_ptr, ctx);
}
PHP_METHOD(VSlim__Request, cookies_all) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimRequest_cookies_all(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!wrapper->v_ptr) RETURN_FALSE;
    vphp_wrap_VSlimRequest_cookies_all(wrapper->v_ptr, ctx);
}
PHP_METHOD(VSlim__Request, params_all) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimRequest_params_all(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!wrapper->v_ptr) RETURN_FALSE;
    vphp_wrap_VSlimRequest_params_all(wrapper->v_ptr, ctx);
}
PHP_METHOD(VSlim__Request, attributes_all) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimRequest_attributes_all(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!wrapper->v_ptr) RETURN_FALSE;
    vphp_wrap_VSlimRequest_attributes_all(wrapper->v_ptr, ctx);
}
PHP_METHOD(VSlim__Request, server_all) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimRequest_server_all(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!wrapper->v_ptr) RETURN_FALSE;
    vphp_wrap_VSlimRequest_server_all(wrapper->v_ptr, ctx);
}
PHP_METHOD(VSlim__Request, uploaded_files_all) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimRequest_uploaded_files_all(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!wrapper->v_ptr) RETURN_FALSE;
    vphp_wrap_VSlimRequest_uploaded_files_all(wrapper->v_ptr, ctx);
}
static const zend_function_entry vslim__request_methods[] = {
    PHP_ME(VSlim__Request, __construct, arginfo_vslim__request_construct, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Request, __toString, arginfo_vslim__request_str, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Request, set_query, arginfo_vslim__request_set_query, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Request, set_method, arginfo_vslim__request_set_method, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Request, set_target, arginfo_vslim__request_set_target, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Request, set_body, arginfo_vslim__request_set_body, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Request, set_scheme, arginfo_vslim__request_set_scheme, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Request, set_host, arginfo_vslim__request_set_host, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Request, set_port, arginfo_vslim__request_set_port, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Request, set_protocol_version, arginfo_vslim__request_set_protocol_version, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Request, set_remote_addr, arginfo_vslim__request_set_remote_addr, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Request, set_headers, arginfo_vslim__request_set_headers, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Request, set_cookies, arginfo_vslim__request_set_cookies, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Request, set_attributes, arginfo_vslim__request_set_attributes, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Request, set_server, arginfo_vslim__request_set_server, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Request, set_uploaded_files, arginfo_vslim__request_set_uploaded_files, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Request, set_params, arginfo_vslim__request_set_params, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Request, query, arginfo_vslim__request_query, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Request, query_params, arginfo_vslim__request_query_params, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Request, has_query, arginfo_vslim__request_has_query, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Request, input, arginfo_vslim__request_input, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Request, input_or, arginfo_vslim__request_input_or, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Request, has_input, arginfo_vslim__request_has_input, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Request, all_inputs, arginfo_vslim__request_all_inputs, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Request, parsed_body, arginfo_vslim__request_parsed_body, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Request, body_format, arginfo_vslim__request_body_format, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Request, is_json_body, arginfo_vslim__request_is_json_body, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Request, is_form_body, arginfo_vslim__request_is_form_body, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Request, is_multipart_body, arginfo_vslim__request_is_multipart_body, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Request, json_body, arginfo_vslim__request_json_body, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Request, form_body, arginfo_vslim__request_form_body, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Request, multipart_body, arginfo_vslim__request_multipart_body, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Request, parse_error, arginfo_vslim__request_parse_error, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Request, query_all, arginfo_vslim__request_query_all, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Request, header, arginfo_vslim__request_header, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Request, headers, arginfo_vslim__request_headers, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Request, has_header, arginfo_vslim__request_has_header, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Request, content_type, arginfo_vslim__request_content_type, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Request, request_id, arginfo_vslim__request_request_id, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Request, trace_id, arginfo_vslim__request_trace_id, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Request, cookie, arginfo_vslim__request_cookie, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Request, cookies, arginfo_vslim__request_cookies, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Request, has_cookie, arginfo_vslim__request_has_cookie, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Request, param, arginfo_vslim__request_param, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Request, route_params, arginfo_vslim__request_route_params, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Request, has_param, arginfo_vslim__request_has_param, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Request, attribute, arginfo_vslim__request_attribute, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Request, attributes, arginfo_vslim__request_attributes, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Request, has_attribute, arginfo_vslim__request_has_attribute, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Request, server_value, arginfo_vslim__request_server_value, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Request, server_params, arginfo_vslim__request_server_params, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Request, has_server, arginfo_vslim__request_has_server, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Request, uploaded_file_count, arginfo_vslim__request_uploaded_file_count, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Request, uploaded_files, arginfo_vslim__request_uploaded_files, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Request, has_uploaded_files, arginfo_vslim__request_has_uploaded_files, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Request, is_secure, arginfo_vslim__request_is_secure, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Request, headers_all, arginfo_vslim__request_headers_all, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Request, cookies_all, arginfo_vslim__request_cookies_all, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Request, params_all, arginfo_vslim__request_params_all, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Request, attributes_all, arginfo_vslim__request_attributes_all, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Request, server_all, arginfo_vslim__request_server_all, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Request, uploaded_files_all, arginfo_vslim__request_uploaded_files_all, ZEND_ACC_PUBLIC)
    PHP_FE_END
};

zend_class_entry *vslim__response_ce = NULL;
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__response_construct, 0, 0, 3)
ZEND_ARG_TYPE_INFO(0, status, IS_LONG, 0)
ZEND_ARG_TYPE_INFO(0, body, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, content_type, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__response_header, 0, 1, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, name, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__response_headers, 0, 0, IS_ARRAY, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__response_has_header, 0, 1, _IS_BOOL, 0)
ZEND_ARG_TYPE_INFO(0, name, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__response_set_header, 0, 0, 2)
ZEND_ARG_TYPE_INFO(0, name, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, value, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__response_with_request_id, 0, 0, 1)
ZEND_ARG_TYPE_INFO(0, request_id, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__response_with_trace_id, 0, 0, 1)
ZEND_ARG_TYPE_INFO(0, trace_id, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__response_set_content_type, 0, 0, 1)
ZEND_ARG_TYPE_INFO(0, content_type, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__response_cookie_header, 0, 0, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__response_set_cookie, 0, 0, 2)
ZEND_ARG_TYPE_INFO(0, name, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, value, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__response_set_cookie_opts, 0, 0, 3)
ZEND_ARG_TYPE_INFO(0, name, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, value, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, path, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__response_set_cookie_full, 0, 0, 8)
ZEND_ARG_TYPE_INFO(0, name, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, value, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, path, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, domain, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, max_age, IS_LONG, 0)
ZEND_ARG_TYPE_INFO(0, secure, _IS_BOOL, 0)
ZEND_ARG_TYPE_INFO(0, http_only, _IS_BOOL, 0)
ZEND_ARG_TYPE_INFO(0, same_site, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__response_delete_cookie, 0, 0, 1)
ZEND_ARG_TYPE_INFO(0, name, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__response_set_status, 0, 0, 1)
ZEND_ARG_TYPE_INFO(0, status, IS_LONG, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__response_with_status, 0, 0, 1)
ZEND_ARG_TYPE_INFO(0, status, IS_LONG, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__response_text, 0, 0, 1)
ZEND_ARG_TYPE_INFO(0, body, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__response_json, 0, 0, 1)
ZEND_ARG_TYPE_INFO(0, body, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__response_html, 0, 0, 1)
ZEND_ARG_TYPE_INFO(0, body, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__response_redirect, 0, 0, 1)
ZEND_ARG_TYPE_INFO(0, location, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__response_redirect_with_status, 0, 0, 2)
ZEND_ARG_TYPE_INFO(0, location, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, status, IS_LONG, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__response_headers_all, 0, 0, IS_ARRAY, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__response_str, 0, 0, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__response_content_length, 0, 0, IS_LONG, 0)
ZEND_END_ARG_INFO()
PHP_METHOD(VSlim__Response, __construct) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern vphp_class_handlers* VSlimResponse_handlers();
    vphp_class_handlers *h = VSlimResponse_handlers();
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    wrapper->v_ptr = h->new_raw();
    vphp_register_object(wrapper->v_ptr, Z_OBJ_P(getThis()));
    vphp_bind_handlers_with_ownership(Z_OBJ_P(getThis()), h, 1);
    extern void vphp_wrap_VSlimResponse_construct(void* v_ptr, vphp_context_internal ctx);
    void* v_ptr = wrapper->v_ptr;
    vphp_wrap_VSlimResponse_construct(v_ptr, ctx);
}
PHP_METHOD(VSlim__Response, header) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimResponse_header(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!wrapper->v_ptr) RETURN_FALSE;
    vphp_wrap_VSlimResponse_header(wrapper->v_ptr, ctx);
}
PHP_METHOD(VSlim__Response, headers) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimResponse_headers(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!wrapper->v_ptr) RETURN_FALSE;
    vphp_wrap_VSlimResponse_headers(wrapper->v_ptr, ctx);
}
PHP_METHOD(VSlim__Response, has_header) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimResponse_has_header(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!wrapper->v_ptr) RETURN_FALSE;
    vphp_wrap_VSlimResponse_has_header(wrapper->v_ptr, ctx);
}

PHP_METHOD(VSlim__Response, set_header) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimResponse_set_header(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__Response::set_header called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimResponse_set_header(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__response_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimResponse_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimResponse_handlers(), 0);
    }
}


PHP_METHOD(VSlim__Response, with_request_id) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimResponse_with_request_id(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__Response::with_request_id called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimResponse_with_request_id(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__response_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimResponse_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimResponse_handlers(), 0);
    }
}


PHP_METHOD(VSlim__Response, with_trace_id) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimResponse_with_trace_id(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__Response::with_trace_id called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimResponse_with_trace_id(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__response_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimResponse_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimResponse_handlers(), 0);
    }
}


PHP_METHOD(VSlim__Response, set_content_type) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimResponse_set_content_type(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__Response::set_content_type called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimResponse_set_content_type(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__response_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimResponse_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimResponse_handlers(), 0);
    }
}

PHP_METHOD(VSlim__Response, cookie_header) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimResponse_cookie_header(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!wrapper->v_ptr) RETURN_FALSE;
    vphp_wrap_VSlimResponse_cookie_header(wrapper->v_ptr, ctx);
}

PHP_METHOD(VSlim__Response, set_cookie) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimResponse_set_cookie(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__Response::set_cookie called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimResponse_set_cookie(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__response_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimResponse_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimResponse_handlers(), 0);
    }
}


PHP_METHOD(VSlim__Response, set_cookie_opts) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimResponse_set_cookie_opts(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__Response::set_cookie_opts called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimResponse_set_cookie_opts(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__response_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimResponse_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimResponse_handlers(), 0);
    }
}


PHP_METHOD(VSlim__Response, set_cookie_full) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimResponse_set_cookie_full(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__Response::set_cookie_full called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimResponse_set_cookie_full(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__response_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimResponse_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimResponse_handlers(), 0);
    }
}


PHP_METHOD(VSlim__Response, delete_cookie) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimResponse_delete_cookie(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__Response::delete_cookie called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimResponse_delete_cookie(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__response_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimResponse_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimResponse_handlers(), 0);
    }
}


PHP_METHOD(VSlim__Response, set_status) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimResponse_set_status(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__Response::set_status called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimResponse_set_status(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__response_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimResponse_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimResponse_handlers(), 0);
    }
}


PHP_METHOD(VSlim__Response, with_status) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimResponse_with_status(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__Response::with_status called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimResponse_with_status(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__response_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimResponse_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimResponse_handlers(), 0);
    }
}


PHP_METHOD(VSlim__Response, text) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimResponse_text(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__Response::text called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimResponse_text(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__response_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimResponse_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimResponse_handlers(), 0);
    }
}


PHP_METHOD(VSlim__Response, json) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimResponse_json(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__Response::json called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimResponse_json(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__response_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimResponse_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimResponse_handlers(), 0);
    }
}


PHP_METHOD(VSlim__Response, html) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimResponse_html(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__Response::html called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimResponse_html(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__response_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimResponse_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimResponse_handlers(), 0);
    }
}


PHP_METHOD(VSlim__Response, redirect) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimResponse_redirect(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__Response::redirect called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimResponse_redirect(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__response_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimResponse_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimResponse_handlers(), 0);
    }
}


PHP_METHOD(VSlim__Response, redirect_with_status) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimResponse_redirect_with_status(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__Response::redirect_with_status called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimResponse_redirect_with_status(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__response_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimResponse_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimResponse_handlers(), 0);
    }
}

PHP_METHOD(VSlim__Response, headers_all) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimResponse_headers_all(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!wrapper->v_ptr) RETURN_FALSE;
    vphp_wrap_VSlimResponse_headers_all(wrapper->v_ptr, ctx);
}
PHP_METHOD(VSlim__Response, __toString) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimResponse_str(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!wrapper->v_ptr) RETURN_FALSE;
    vphp_wrap_VSlimResponse_str(wrapper->v_ptr, ctx);
}
PHP_METHOD(VSlim__Response, content_length) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimResponse_content_length(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!wrapper->v_ptr) RETURN_FALSE;
    vphp_wrap_VSlimResponse_content_length(wrapper->v_ptr, ctx);
}
static const zend_function_entry vslim__response_methods[] = {
    PHP_ME(VSlim__Response, __construct, arginfo_vslim__response_construct, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Response, header, arginfo_vslim__response_header, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Response, headers, arginfo_vslim__response_headers, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Response, has_header, arginfo_vslim__response_has_header, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Response, set_header, arginfo_vslim__response_set_header, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Response, with_request_id, arginfo_vslim__response_with_request_id, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Response, with_trace_id, arginfo_vslim__response_with_trace_id, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Response, set_content_type, arginfo_vslim__response_set_content_type, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Response, cookie_header, arginfo_vslim__response_cookie_header, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Response, set_cookie, arginfo_vslim__response_set_cookie, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Response, set_cookie_opts, arginfo_vslim__response_set_cookie_opts, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Response, set_cookie_full, arginfo_vslim__response_set_cookie_full, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Response, delete_cookie, arginfo_vslim__response_delete_cookie, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Response, set_status, arginfo_vslim__response_set_status, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Response, with_status, arginfo_vslim__response_with_status, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Response, text, arginfo_vslim__response_text, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Response, json, arginfo_vslim__response_json, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Response, html, arginfo_vslim__response_html, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Response, redirect, arginfo_vslim__response_redirect, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Response, redirect_with_status, arginfo_vslim__response_redirect_with_status, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Response, headers_all, arginfo_vslim__response_headers_all, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Response, __toString, arginfo_vslim__response_str, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Response, content_length, arginfo_vslim__response_content_length, ZEND_ACC_PUBLIC)
    PHP_FE_END
};

zend_class_entry *vslim__stream__response_ce = NULL;
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__stream__response_construct, 0, 0, 5)
ZEND_ARG_TYPE_INFO(0, stream_type, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, chunks, IS_MIXED, 0)
ZEND_ARG_TYPE_INFO(0, status, IS_LONG, 0)
ZEND_ARG_TYPE_INFO(0, content_type, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, headers, IS_MIXED, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__stream__response_text, 0, 0, 1)
ZEND_ARG_TYPE_INFO(0, chunks, IS_MIXED, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__stream__response_text_with, 0, 0, 4)
ZEND_ARG_TYPE_INFO(0, chunks, IS_MIXED, 0)
ZEND_ARG_TYPE_INFO(0, status, IS_LONG, 0)
ZEND_ARG_TYPE_INFO(0, content_type, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, headers, IS_MIXED, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__stream__response_sse, 0, 0, 1)
ZEND_ARG_TYPE_INFO(0, events, IS_MIXED, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__stream__response_sse_with, 0, 0, 3)
ZEND_ARG_TYPE_INFO(0, events, IS_MIXED, 0)
ZEND_ARG_TYPE_INFO(0, status, IS_LONG, 0)
ZEND_ARG_TYPE_INFO(0, headers, IS_MIXED, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__stream__response_header, 0, 1, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, name, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__stream__response_headers, 0, 0, IS_ARRAY, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__stream__response_has_header, 0, 1, _IS_BOOL, 0)
ZEND_ARG_TYPE_INFO(0, name, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__stream__response_set_header, 0, 0, 2)
ZEND_ARG_TYPE_INFO(0, name, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, value, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__stream__response_set_status, 0, 0, 1)
ZEND_ARG_TYPE_INFO(0, status, IS_LONG, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__stream__response_set_content_type, 0, 0, 1)
ZEND_ARG_TYPE_INFO(0, content_type, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__stream__response_set_chunks, 0, 0, 1)
ZEND_ARG_TYPE_INFO(0, chunks, IS_MIXED, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__stream__response_chunks, 0, 0, IS_VOID, 0)
ZEND_END_ARG_INFO()
PHP_METHOD(VSlim__Stream__Response, __construct) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern vphp_class_handlers* VSlimStreamResponse_handlers();
    vphp_class_handlers *h = VSlimStreamResponse_handlers();
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    wrapper->v_ptr = h->new_raw();
    vphp_register_object(wrapper->v_ptr, Z_OBJ_P(getThis()));
    vphp_bind_handlers_with_ownership(Z_OBJ_P(getThis()), h, 1);
    extern void vphp_wrap_VSlimStreamResponse_construct(void* v_ptr, vphp_context_internal ctx);
    void* v_ptr = wrapper->v_ptr;
    vphp_wrap_VSlimStreamResponse_construct(v_ptr, ctx);
}
PHP_METHOD(VSlim__Stream__Response, text) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimStreamResponse_text(vphp_context_internal ctx);
    void* v_instance = vphp_wrap_VSlimStreamResponse_text(ctx);
    vphp_return_obj(return_value, v_instance, vslim__stream__response_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimStreamResponse_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimStreamResponse_handlers(), 1);
    }
}
PHP_METHOD(VSlim__Stream__Response, text_with) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimStreamResponse_text_with(vphp_context_internal ctx);
    void* v_instance = vphp_wrap_VSlimStreamResponse_text_with(ctx);
    vphp_return_obj(return_value, v_instance, vslim__stream__response_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimStreamResponse_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimStreamResponse_handlers(), 1);
    }
}
PHP_METHOD(VSlim__Stream__Response, sse) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimStreamResponse_sse(vphp_context_internal ctx);
    void* v_instance = vphp_wrap_VSlimStreamResponse_sse(ctx);
    vphp_return_obj(return_value, v_instance, vslim__stream__response_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimStreamResponse_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimStreamResponse_handlers(), 1);
    }
}
PHP_METHOD(VSlim__Stream__Response, sse_with) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimStreamResponse_sse_with(vphp_context_internal ctx);
    void* v_instance = vphp_wrap_VSlimStreamResponse_sse_with(ctx);
    vphp_return_obj(return_value, v_instance, vslim__stream__response_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimStreamResponse_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimStreamResponse_handlers(), 1);
    }
}
PHP_METHOD(VSlim__Stream__Response, header) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimStreamResponse_header(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!wrapper->v_ptr) RETURN_FALSE;
    vphp_wrap_VSlimStreamResponse_header(wrapper->v_ptr, ctx);
}
PHP_METHOD(VSlim__Stream__Response, headers) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimStreamResponse_headers(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!wrapper->v_ptr) RETURN_FALSE;
    vphp_wrap_VSlimStreamResponse_headers(wrapper->v_ptr, ctx);
}
PHP_METHOD(VSlim__Stream__Response, has_header) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimStreamResponse_has_header(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!wrapper->v_ptr) RETURN_FALSE;
    vphp_wrap_VSlimStreamResponse_has_header(wrapper->v_ptr, ctx);
}

PHP_METHOD(VSlim__Stream__Response, set_header) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimStreamResponse_set_header(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__Stream__Response::set_header called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimStreamResponse_set_header(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__stream__response_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimStreamResponse_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimStreamResponse_handlers(), 0);
    }
}


PHP_METHOD(VSlim__Stream__Response, set_status) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimStreamResponse_set_status(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__Stream__Response::set_status called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimStreamResponse_set_status(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__stream__response_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimStreamResponse_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimStreamResponse_handlers(), 0);
    }
}


PHP_METHOD(VSlim__Stream__Response, set_content_type) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimStreamResponse_set_content_type(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__Stream__Response::set_content_type called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimStreamResponse_set_content_type(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__stream__response_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimStreamResponse_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimStreamResponse_handlers(), 0);
    }
}


PHP_METHOD(VSlim__Stream__Response, set_chunks) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimStreamResponse_set_chunks(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__Stream__Response::set_chunks called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimStreamResponse_set_chunks(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__stream__response_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimStreamResponse_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimStreamResponse_handlers(), 0);
    }
}

PHP_METHOD(VSlim__Stream__Response, chunks) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void VSlimStreamResponse_chunks(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!wrapper->v_ptr) RETURN_NULL();
    VSlimStreamResponse_chunks(wrapper->v_ptr, ctx);
}
static const zend_function_entry vslim__stream__response_methods[] = {
    PHP_ME(VSlim__Stream__Response, __construct, arginfo_vslim__stream__response_construct, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Stream__Response, text, arginfo_vslim__stream__response_text, ZEND_ACC_PUBLIC | ZEND_ACC_STATIC)
    PHP_ME(VSlim__Stream__Response, text_with, arginfo_vslim__stream__response_text_with, ZEND_ACC_PUBLIC | ZEND_ACC_STATIC)
    PHP_ME(VSlim__Stream__Response, sse, arginfo_vslim__stream__response_sse, ZEND_ACC_PUBLIC | ZEND_ACC_STATIC)
    PHP_ME(VSlim__Stream__Response, sse_with, arginfo_vslim__stream__response_sse_with, ZEND_ACC_PUBLIC | ZEND_ACC_STATIC)
    PHP_ME(VSlim__Stream__Response, header, arginfo_vslim__stream__response_header, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Stream__Response, headers, arginfo_vslim__stream__response_headers, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Stream__Response, has_header, arginfo_vslim__stream__response_has_header, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Stream__Response, set_header, arginfo_vslim__stream__response_set_header, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Stream__Response, set_status, arginfo_vslim__stream__response_set_status, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Stream__Response, set_content_type, arginfo_vslim__stream__response_set_content_type, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Stream__Response, set_chunks, arginfo_vslim__stream__response_set_chunks, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Stream__Response, chunks, arginfo_vslim__stream__response_chunks, ZEND_ACC_PUBLIC)
    PHP_FE_END
};

zend_class_entry *vslim__stream__ndjsondecoder_ce = NULL;
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__stream__ndjsondecoder___construct, 0, 0, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__stream__ndjsondecoder_decode, 0, 1, IS_MIXED, 0)
ZEND_ARG_TYPE_INFO(0, stream, IS_MIXED, 0)
ZEND_END_ARG_INFO()
PHP_METHOD(VSlim__Stream__NdjsonDecoder, decode) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimStreamNdjsonDecoder_decode(vphp_context_internal ctx);
    vphp_wrap_VSlimStreamNdjsonDecoder_decode(ctx);
}

PHP_METHOD(VSlim__Stream__NdjsonDecoder, __construct) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern vphp_class_handlers* VSlimStreamNdjsonDecoder_handlers();
    vphp_class_handlers *h = VSlimStreamNdjsonDecoder_handlers();
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    wrapper->v_ptr = h->new_raw();
    vphp_register_object(wrapper->v_ptr, Z_OBJ_P(getThis()));
    vphp_bind_handlers_with_ownership(Z_OBJ_P(getThis()), h, 1);
}

static const zend_function_entry vslim__stream__ndjsondecoder_methods[] = {
    PHP_ME(VSlim__Stream__NdjsonDecoder, __construct, arginfo_vslim__stream__ndjsondecoder___construct, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Stream__NdjsonDecoder, decode, arginfo_vslim__stream__ndjsondecoder_decode, ZEND_ACC_PUBLIC | ZEND_ACC_STATIC)
    PHP_FE_END
};

zend_class_entry *vslim__stream__sseencoder_ce = NULL;
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__stream__sseencoder___construct, 0, 0, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__stream__sseencoder_from_ollama, 0, 2, IS_MIXED, 0)
ZEND_ARG_TYPE_INFO(0, rows, IS_MIXED, 0)
ZEND_ARG_TYPE_INFO(0, model, IS_STRING, 0)
ZEND_END_ARG_INFO()
PHP_METHOD(VSlim__Stream__SseEncoder, from_ollama) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimStreamSseEncoder_from_ollama(vphp_context_internal ctx);
    vphp_wrap_VSlimStreamSseEncoder_from_ollama(ctx);
}

PHP_METHOD(VSlim__Stream__SseEncoder, __construct) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern vphp_class_handlers* VSlimStreamSseEncoder_handlers();
    vphp_class_handlers *h = VSlimStreamSseEncoder_handlers();
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    wrapper->v_ptr = h->new_raw();
    vphp_register_object(wrapper->v_ptr, Z_OBJ_P(getThis()));
    vphp_bind_handlers_with_ownership(Z_OBJ_P(getThis()), h, 1);
}

static const zend_function_entry vslim__stream__sseencoder_methods[] = {
    PHP_ME(VSlim__Stream__SseEncoder, __construct, arginfo_vslim__stream__sseencoder___construct, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Stream__SseEncoder, from_ollama, arginfo_vslim__stream__sseencoder_from_ollama, ZEND_ACC_PUBLIC | ZEND_ACC_STATIC)
    PHP_FE_END
};

zend_class_entry *vslim__stream__ollamaclient_ce = NULL;
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__stream__ollamaclient_construct, 0, 0, 4)
ZEND_ARG_TYPE_INFO(0, chat_url, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, default_model, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, api_key, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, fixture_path, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__stream__ollamaclient_from_env, 0, 0, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__stream__ollamaclient_from_options, 0, 0, 1)
ZEND_ARG_TYPE_INFO(0, options, IS_MIXED, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__stream__ollamaclient_chat_url, 0, 0, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__stream__ollamaclient_default_model, 0, 0, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__stream__ollamaclient_api_key, 0, 0, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__stream__ollamaclient_fixture_path, 0, 0, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__stream__ollamaclient_payload, 0, 1, IS_MIXED, 0)
ZEND_ARG_TYPE_INFO(0, input, IS_MIXED, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__stream__ollamaclient_payload_from_request, 0, 1, IS_MIXED, 0)
ZEND_ARG_INFO(0, req)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__stream__ollamaclient_open_stream, 0, 1, IS_MIXED, 0)
ZEND_ARG_TYPE_INFO(0, payload, IS_MIXED, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__stream__ollamaclient_text_response_from_request, 0, 1, IS_MIXED, 0)
ZEND_ARG_INFO(0, req)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__stream__ollamaclient_sse_response_from_request, 0, 1, IS_MIXED, 0)
ZEND_ARG_INFO(0, req)
ZEND_END_ARG_INFO()
PHP_METHOD(VSlim__Stream__OllamaClient, __construct) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern vphp_class_handlers* VSlimStreamOllamaClient_handlers();
    vphp_class_handlers *h = VSlimStreamOllamaClient_handlers();
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    wrapper->v_ptr = h->new_raw();
    vphp_register_object(wrapper->v_ptr, Z_OBJ_P(getThis()));
    vphp_bind_handlers_with_ownership(Z_OBJ_P(getThis()), h, 1);
    extern void vphp_wrap_VSlimStreamOllamaClient_construct(void* v_ptr, vphp_context_internal ctx);
    void* v_ptr = wrapper->v_ptr;
    vphp_wrap_VSlimStreamOllamaClient_construct(v_ptr, ctx);
}
PHP_METHOD(VSlim__Stream__OllamaClient, from_env) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimStreamOllamaClient_from_env(vphp_context_internal ctx);
    void* v_instance = vphp_wrap_VSlimStreamOllamaClient_from_env(ctx);
    vphp_return_obj(return_value, v_instance, vslim__stream__ollamaclient_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimStreamOllamaClient_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimStreamOllamaClient_handlers(), 1);
    }
}
PHP_METHOD(VSlim__Stream__OllamaClient, from_options) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimStreamOllamaClient_from_options(vphp_context_internal ctx);
    void* v_instance = vphp_wrap_VSlimStreamOllamaClient_from_options(ctx);
    vphp_return_obj(return_value, v_instance, vslim__stream__ollamaclient_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimStreamOllamaClient_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimStreamOllamaClient_handlers(), 1);
    }
}
PHP_METHOD(VSlim__Stream__OllamaClient, chat_url) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimStreamOllamaClient_chat_url(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!wrapper->v_ptr) RETURN_FALSE;
    vphp_wrap_VSlimStreamOllamaClient_chat_url(wrapper->v_ptr, ctx);
}
PHP_METHOD(VSlim__Stream__OllamaClient, default_model) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimStreamOllamaClient_default_model(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!wrapper->v_ptr) RETURN_FALSE;
    vphp_wrap_VSlimStreamOllamaClient_default_model(wrapper->v_ptr, ctx);
}
PHP_METHOD(VSlim__Stream__OllamaClient, api_key) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimStreamOllamaClient_api_key(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!wrapper->v_ptr) RETURN_FALSE;
    vphp_wrap_VSlimStreamOllamaClient_api_key(wrapper->v_ptr, ctx);
}
PHP_METHOD(VSlim__Stream__OllamaClient, fixture_path) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimStreamOllamaClient_fixture_path(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!wrapper->v_ptr) RETURN_FALSE;
    vphp_wrap_VSlimStreamOllamaClient_fixture_path(wrapper->v_ptr, ctx);
}
PHP_METHOD(VSlim__Stream__OllamaClient, payload) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimStreamOllamaClient_payload(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!wrapper->v_ptr) RETURN_FALSE;
    vphp_wrap_VSlimStreamOllamaClient_payload(wrapper->v_ptr, ctx);
}
PHP_METHOD(VSlim__Stream__OllamaClient, payload_from_request) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimStreamOllamaClient_payload_from_request(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!wrapper->v_ptr) RETURN_FALSE;
    vphp_wrap_VSlimStreamOllamaClient_payload_from_request(wrapper->v_ptr, ctx);
}
PHP_METHOD(VSlim__Stream__OllamaClient, open_stream) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimStreamOllamaClient_open_stream(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!wrapper->v_ptr) RETURN_FALSE;
    vphp_wrap_VSlimStreamOllamaClient_open_stream(wrapper->v_ptr, ctx);
}
PHP_METHOD(VSlim__Stream__OllamaClient, text_response_from_request) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimStreamOllamaClient_text_response_from_request(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!wrapper->v_ptr) RETURN_FALSE;
    vphp_wrap_VSlimStreamOllamaClient_text_response_from_request(wrapper->v_ptr, ctx);
}
PHP_METHOD(VSlim__Stream__OllamaClient, sse_response_from_request) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimStreamOllamaClient_sse_response_from_request(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!wrapper->v_ptr) RETURN_FALSE;
    vphp_wrap_VSlimStreamOllamaClient_sse_response_from_request(wrapper->v_ptr, ctx);
}
static const zend_function_entry vslim__stream__ollamaclient_methods[] = {
    PHP_ME(VSlim__Stream__OllamaClient, __construct, arginfo_vslim__stream__ollamaclient_construct, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Stream__OllamaClient, from_env, arginfo_vslim__stream__ollamaclient_from_env, ZEND_ACC_PUBLIC | ZEND_ACC_STATIC)
    PHP_ME(VSlim__Stream__OllamaClient, from_options, arginfo_vslim__stream__ollamaclient_from_options, ZEND_ACC_PUBLIC | ZEND_ACC_STATIC)
    PHP_ME(VSlim__Stream__OllamaClient, chat_url, arginfo_vslim__stream__ollamaclient_chat_url, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Stream__OllamaClient, default_model, arginfo_vslim__stream__ollamaclient_default_model, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Stream__OllamaClient, api_key, arginfo_vslim__stream__ollamaclient_api_key, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Stream__OllamaClient, fixture_path, arginfo_vslim__stream__ollamaclient_fixture_path, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Stream__OllamaClient, payload, arginfo_vslim__stream__ollamaclient_payload, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Stream__OllamaClient, payload_from_request, arginfo_vslim__stream__ollamaclient_payload_from_request, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Stream__OllamaClient, open_stream, arginfo_vslim__stream__ollamaclient_open_stream, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Stream__OllamaClient, text_response_from_request, arginfo_vslim__stream__ollamaclient_text_response_from_request, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Stream__OllamaClient, sse_response_from_request, arginfo_vslim__stream__ollamaclient_sse_response_from_request, ZEND_ACC_PUBLIC)
    PHP_FE_END
};

zend_class_entry *vslim__stream__factory_ce = NULL;
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__stream__factory___construct, 0, 0, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__stream__factory_text, 0, 1, IS_MIXED, 0)
ZEND_ARG_TYPE_INFO(0, chunks, IS_MIXED, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__stream__factory_text_with, 0, 4, IS_MIXED, 0)
ZEND_ARG_TYPE_INFO(0, chunks, IS_MIXED, 0)
ZEND_ARG_TYPE_INFO(0, status, IS_LONG, 0)
ZEND_ARG_TYPE_INFO(0, content_type, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, headers, IS_MIXED, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__stream__factory_sse, 0, 1, IS_MIXED, 0)
ZEND_ARG_TYPE_INFO(0, events, IS_MIXED, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__stream__factory_sse_with, 0, 3, IS_MIXED, 0)
ZEND_ARG_TYPE_INFO(0, events, IS_MIXED, 0)
ZEND_ARG_TYPE_INFO(0, status, IS_LONG, 0)
ZEND_ARG_TYPE_INFO(0, headers, IS_MIXED, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__stream__factory_ollama_text, 0, 1, IS_MIXED, 0)
ZEND_ARG_INFO(0, req)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__stream__factory_ollama_text_with, 0, 2, IS_MIXED, 0)
ZEND_ARG_INFO(0, req)
ZEND_ARG_TYPE_INFO(0, options, IS_MIXED, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__stream__factory_ollama_sse, 0, 1, IS_MIXED, 0)
ZEND_ARG_INFO(0, req)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__stream__factory_ollama_sse_with, 0, 2, IS_MIXED, 0)
ZEND_ARG_INFO(0, req)
ZEND_ARG_TYPE_INFO(0, options, IS_MIXED, 0)
ZEND_END_ARG_INFO()
PHP_METHOD(VSlim__Stream__Factory, text) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimStreamFactory_text(vphp_context_internal ctx);
    vphp_wrap_VSlimStreamFactory_text(ctx);
}
PHP_METHOD(VSlim__Stream__Factory, text_with) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimStreamFactory_text_with(vphp_context_internal ctx);
    vphp_wrap_VSlimStreamFactory_text_with(ctx);
}
PHP_METHOD(VSlim__Stream__Factory, sse) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimStreamFactory_sse(vphp_context_internal ctx);
    vphp_wrap_VSlimStreamFactory_sse(ctx);
}
PHP_METHOD(VSlim__Stream__Factory, sse_with) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimStreamFactory_sse_with(vphp_context_internal ctx);
    vphp_wrap_VSlimStreamFactory_sse_with(ctx);
}
PHP_METHOD(VSlim__Stream__Factory, ollama_text) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimStreamFactory_ollama_text(vphp_context_internal ctx);
    vphp_wrap_VSlimStreamFactory_ollama_text(ctx);
}
PHP_METHOD(VSlim__Stream__Factory, ollama_text_with) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimStreamFactory_ollama_text_with(vphp_context_internal ctx);
    vphp_wrap_VSlimStreamFactory_ollama_text_with(ctx);
}
PHP_METHOD(VSlim__Stream__Factory, ollama_sse) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimStreamFactory_ollama_sse(vphp_context_internal ctx);
    vphp_wrap_VSlimStreamFactory_ollama_sse(ctx);
}
PHP_METHOD(VSlim__Stream__Factory, ollama_sse_with) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimStreamFactory_ollama_sse_with(vphp_context_internal ctx);
    vphp_wrap_VSlimStreamFactory_ollama_sse_with(ctx);
}

PHP_METHOD(VSlim__Stream__Factory, __construct) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern vphp_class_handlers* VSlimStreamFactory_handlers();
    vphp_class_handlers *h = VSlimStreamFactory_handlers();
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    wrapper->v_ptr = h->new_raw();
    vphp_register_object(wrapper->v_ptr, Z_OBJ_P(getThis()));
    vphp_bind_handlers_with_ownership(Z_OBJ_P(getThis()), h, 1);
}

static const zend_function_entry vslim__stream__factory_methods[] = {
    PHP_ME(VSlim__Stream__Factory, __construct, arginfo_vslim__stream__factory___construct, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Stream__Factory, text, arginfo_vslim__stream__factory_text, ZEND_ACC_PUBLIC | ZEND_ACC_STATIC)
    PHP_ME(VSlim__Stream__Factory, text_with, arginfo_vslim__stream__factory_text_with, ZEND_ACC_PUBLIC | ZEND_ACC_STATIC)
    PHP_ME(VSlim__Stream__Factory, sse, arginfo_vslim__stream__factory_sse, ZEND_ACC_PUBLIC | ZEND_ACC_STATIC)
    PHP_ME(VSlim__Stream__Factory, sse_with, arginfo_vslim__stream__factory_sse_with, ZEND_ACC_PUBLIC | ZEND_ACC_STATIC)
    PHP_ME(VSlim__Stream__Factory, ollama_text, arginfo_vslim__stream__factory_ollama_text, ZEND_ACC_PUBLIC | ZEND_ACC_STATIC)
    PHP_ME(VSlim__Stream__Factory, ollama_text_with, arginfo_vslim__stream__factory_ollama_text_with, ZEND_ACC_PUBLIC | ZEND_ACC_STATIC)
    PHP_ME(VSlim__Stream__Factory, ollama_sse, arginfo_vslim__stream__factory_ollama_sse, ZEND_ACC_PUBLIC | ZEND_ACC_STATIC)
    PHP_ME(VSlim__Stream__Factory, ollama_sse_with, arginfo_vslim__stream__factory_ollama_sse_with, ZEND_ACC_PUBLIC | ZEND_ACC_STATIC)
    PHP_FE_END
};

zend_class_entry *vslim__websocket__app_ce = NULL;
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__websocket__app_construct, 0, 0, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__websocket__app_on_open, 0, 0, 1)
ZEND_ARG_TYPE_INFO(0, handler, IS_MIXED, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__websocket__app_on_message, 0, 0, 1)
ZEND_ARG_TYPE_INFO(0, handler, IS_MIXED, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__websocket__app_on_close, 0, 0, 1)
ZEND_ARG_TYPE_INFO(0, handler, IS_MIXED, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__websocket__app_has_on_open, 0, 0, _IS_BOOL, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__websocket__app_has_on_message, 0, 0, _IS_BOOL, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__websocket__app_has_on_close, 0, 0, _IS_BOOL, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__websocket__app_remember, 0, 0, 1)
ZEND_ARG_TYPE_INFO(0, conn, IS_MIXED, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__websocket__app_forget, 0, 0, 1)
ZEND_ARG_TYPE_INFO(0, conn_or_id, IS_MIXED, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__websocket__app_has_connection, 0, 1, _IS_BOOL, 0)
ZEND_ARG_TYPE_INFO(0, conn_or_id, IS_MIXED, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__websocket__app_join, 0, 0, 2)
ZEND_ARG_TYPE_INFO(0, room, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, conn_or_id, IS_MIXED, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__websocket__app_leave, 0, 0, 2)
ZEND_ARG_TYPE_INFO(0, room, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, conn_or_id, IS_MIXED, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__websocket__app_members, 0, 1, IS_ARRAY, 0)
ZEND_ARG_TYPE_INFO(0, room, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__websocket__app_connection_ids, 0, 0, IS_ARRAY, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__websocket__app_rooms_for, 0, 1, IS_ARRAY, 0)
ZEND_ARG_TYPE_INFO(0, conn_or_id, IS_MIXED, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__websocket__app_send_to, 0, 2, _IS_BOOL, 0)
ZEND_ARG_TYPE_INFO(0, conn_or_id, IS_MIXED, 0)
ZEND_ARG_TYPE_INFO(0, data, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__websocket__app_broadcast, 0, 3, IS_LONG, 0)
ZEND_ARG_TYPE_INFO(0, data, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, room, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, except_id, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__websocket__app_handle_websocket, 0, 2, IS_MIXED, 0)
ZEND_ARG_TYPE_INFO(0, frame, IS_MIXED, 0)
ZEND_ARG_TYPE_INFO(0, conn, IS_MIXED, 0)
ZEND_END_ARG_INFO()
PHP_METHOD(VSlim__WebSocket__App, __construct) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern vphp_class_handlers* VSlimWebSocketApp_handlers();
    vphp_class_handlers *h = VSlimWebSocketApp_handlers();
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    wrapper->v_ptr = h->new_raw();
    vphp_register_object(wrapper->v_ptr, Z_OBJ_P(getThis()));
    vphp_bind_handlers_with_ownership(Z_OBJ_P(getThis()), h, 1);
    extern void vphp_wrap_VSlimWebSocketApp_construct(void* v_ptr, vphp_context_internal ctx);
    void* v_ptr = wrapper->v_ptr;
    vphp_wrap_VSlimWebSocketApp_construct(v_ptr, ctx);
}

PHP_METHOD(VSlim__WebSocket__App, on_open) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimWebSocketApp_on_open(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__WebSocket__App::on_open called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimWebSocketApp_on_open(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__websocket__app_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimWebSocketApp_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimWebSocketApp_handlers(), 0);
    }
}


PHP_METHOD(VSlim__WebSocket__App, on_message) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimWebSocketApp_on_message(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__WebSocket__App::on_message called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimWebSocketApp_on_message(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__websocket__app_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimWebSocketApp_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimWebSocketApp_handlers(), 0);
    }
}


PHP_METHOD(VSlim__WebSocket__App, on_close) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimWebSocketApp_on_close(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__WebSocket__App::on_close called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimWebSocketApp_on_close(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__websocket__app_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimWebSocketApp_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimWebSocketApp_handlers(), 0);
    }
}

PHP_METHOD(VSlim__WebSocket__App, has_on_open) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimWebSocketApp_has_on_open(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!wrapper->v_ptr) RETURN_FALSE;
    vphp_wrap_VSlimWebSocketApp_has_on_open(wrapper->v_ptr, ctx);
}
PHP_METHOD(VSlim__WebSocket__App, has_on_message) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimWebSocketApp_has_on_message(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!wrapper->v_ptr) RETURN_FALSE;
    vphp_wrap_VSlimWebSocketApp_has_on_message(wrapper->v_ptr, ctx);
}
PHP_METHOD(VSlim__WebSocket__App, has_on_close) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimWebSocketApp_has_on_close(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!wrapper->v_ptr) RETURN_FALSE;
    vphp_wrap_VSlimWebSocketApp_has_on_close(wrapper->v_ptr, ctx);
}

PHP_METHOD(VSlim__WebSocket__App, remember) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimWebSocketApp_remember(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__WebSocket__App::remember called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimWebSocketApp_remember(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__websocket__app_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimWebSocketApp_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimWebSocketApp_handlers(), 0);
    }
}


PHP_METHOD(VSlim__WebSocket__App, forget) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimWebSocketApp_forget(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__WebSocket__App::forget called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimWebSocketApp_forget(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__websocket__app_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimWebSocketApp_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimWebSocketApp_handlers(), 0);
    }
}

PHP_METHOD(VSlim__WebSocket__App, has_connection) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimWebSocketApp_has_connection(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!wrapper->v_ptr) RETURN_FALSE;
    vphp_wrap_VSlimWebSocketApp_has_connection(wrapper->v_ptr, ctx);
}

PHP_METHOD(VSlim__WebSocket__App, join) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimWebSocketApp_join(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__WebSocket__App::join called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimWebSocketApp_join(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__websocket__app_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimWebSocketApp_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimWebSocketApp_handlers(), 0);
    }
}


PHP_METHOD(VSlim__WebSocket__App, leave) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimWebSocketApp_leave(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__WebSocket__App::leave called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimWebSocketApp_leave(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__websocket__app_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimWebSocketApp_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimWebSocketApp_handlers(), 0);
    }
}

PHP_METHOD(VSlim__WebSocket__App, members) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimWebSocketApp_members(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!wrapper->v_ptr) RETURN_FALSE;
    vphp_wrap_VSlimWebSocketApp_members(wrapper->v_ptr, ctx);
}
PHP_METHOD(VSlim__WebSocket__App, connection_ids) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimWebSocketApp_connection_ids(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!wrapper->v_ptr) RETURN_FALSE;
    vphp_wrap_VSlimWebSocketApp_connection_ids(wrapper->v_ptr, ctx);
}
PHP_METHOD(VSlim__WebSocket__App, rooms_for) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimWebSocketApp_rooms_for(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!wrapper->v_ptr) RETURN_FALSE;
    vphp_wrap_VSlimWebSocketApp_rooms_for(wrapper->v_ptr, ctx);
}
PHP_METHOD(VSlim__WebSocket__App, send_to) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimWebSocketApp_send_to(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!wrapper->v_ptr) RETURN_FALSE;
    vphp_wrap_VSlimWebSocketApp_send_to(wrapper->v_ptr, ctx);
}
PHP_METHOD(VSlim__WebSocket__App, broadcast) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimWebSocketApp_broadcast(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!wrapper->v_ptr) RETURN_FALSE;
    vphp_wrap_VSlimWebSocketApp_broadcast(wrapper->v_ptr, ctx);
}
PHP_METHOD(VSlim__WebSocket__App, handle_websocket) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimWebSocketApp_handle_websocket(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!wrapper->v_ptr) RETURN_FALSE;
    vphp_wrap_VSlimWebSocketApp_handle_websocket(wrapper->v_ptr, ctx);
}
static const zend_function_entry vslim__websocket__app_methods[] = {
    PHP_ME(VSlim__WebSocket__App, __construct, arginfo_vslim__websocket__app_construct, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__WebSocket__App, on_open, arginfo_vslim__websocket__app_on_open, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__WebSocket__App, on_message, arginfo_vslim__websocket__app_on_message, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__WebSocket__App, on_close, arginfo_vslim__websocket__app_on_close, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__WebSocket__App, has_on_open, arginfo_vslim__websocket__app_has_on_open, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__WebSocket__App, has_on_message, arginfo_vslim__websocket__app_has_on_message, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__WebSocket__App, has_on_close, arginfo_vslim__websocket__app_has_on_close, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__WebSocket__App, remember, arginfo_vslim__websocket__app_remember, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__WebSocket__App, forget, arginfo_vslim__websocket__app_forget, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__WebSocket__App, has_connection, arginfo_vslim__websocket__app_has_connection, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__WebSocket__App, join, arginfo_vslim__websocket__app_join, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__WebSocket__App, leave, arginfo_vslim__websocket__app_leave, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__WebSocket__App, members, arginfo_vslim__websocket__app_members, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__WebSocket__App, connection_ids, arginfo_vslim__websocket__app_connection_ids, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__WebSocket__App, rooms_for, arginfo_vslim__websocket__app_rooms_for, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__WebSocket__App, send_to, arginfo_vslim__websocket__app_send_to, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__WebSocket__App, broadcast, arginfo_vslim__websocket__app_broadcast, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__WebSocket__App, handle_websocket, arginfo_vslim__websocket__app_handle_websocket, ZEND_ACC_PUBLIC)
    PHP_FE_END
};

zend_class_entry *vslim__mcp__app_ce = NULL;
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__mcp__app_construct, 0, 0, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__mcp__app_server_info, 0, 0, 1)
ZEND_ARG_TYPE_INFO(0, info, IS_MIXED, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__mcp__app_capability, 0, 0, 2)
ZEND_ARG_TYPE_INFO(0, name, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, definition, IS_MIXED, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__mcp__app_capabilities, 0, 0, 1)
ZEND_ARG_TYPE_INFO(0, definitions, IS_MIXED, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__mcp__app_register, 0, 0, 2)
ZEND_ARG_TYPE_INFO(0, method, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, handler, IS_MIXED, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__mcp__app_tool, 0, 0, 4)
ZEND_ARG_TYPE_INFO(0, name, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, description, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, input_schema, IS_MIXED, 0)
ZEND_ARG_TYPE_INFO(0, handler, IS_MIXED, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__mcp__app_resource, 0, 0, 5)
ZEND_ARG_TYPE_INFO(0, uri, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, name, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, description, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, mime_type, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, handler, IS_MIXED, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__mcp__app_prompt, 0, 0, 4)
ZEND_ARG_TYPE_INFO(0, name, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, description, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, arguments, IS_MIXED, 0)
ZEND_ARG_TYPE_INFO(0, handler, IS_MIXED, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__mcp__app_notification, 0, 2, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, method, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, params, IS_MIXED, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__mcp__app_request, 0, 3, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, id, IS_MIXED, 0)
ZEND_ARG_TYPE_INFO(0, method, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, params, IS_MIXED, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__mcp__app_sampling_request, 0, 8, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, id, IS_MIXED, 0)
ZEND_ARG_TYPE_INFO(0, messages, IS_MIXED, 0)
ZEND_ARG_TYPE_INFO(0, model_preferences, IS_MIXED, 0)
ZEND_ARG_TYPE_INFO(0, system_prompt, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, max_tokens, IS_LONG, 0)
ZEND_ARG_TYPE_INFO(0, temperature, IS_MIXED, 0)
ZEND_ARG_TYPE_INFO(0, tools, IS_MIXED, 0)
ZEND_ARG_TYPE_INFO(0, tool_choice, IS_MIXED, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__mcp__app_queued_result, 0, 7, IS_MIXED, 0)
ZEND_ARG_TYPE_INFO(0, id, IS_MIXED, 0)
ZEND_ARG_TYPE_INFO(0, result, IS_MIXED, 0)
ZEND_ARG_TYPE_INFO(0, notifications, IS_MIXED, 0)
ZEND_ARG_TYPE_INFO(0, status, IS_LONG, 0)
ZEND_ARG_TYPE_INFO(0, protocol_version, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, session_id, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, headers, IS_MIXED, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__mcp__app_queue_messages, 0, 7, IS_MIXED, 0)
ZEND_ARG_TYPE_INFO(0, id, IS_MIXED, 0)
ZEND_ARG_TYPE_INFO(0, result, IS_MIXED, 0)
ZEND_ARG_TYPE_INFO(0, messages, IS_MIXED, 0)
ZEND_ARG_TYPE_INFO(0, status, IS_LONG, 0)
ZEND_ARG_TYPE_INFO(0, protocol_version, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, session_id, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, headers, IS_MIXED, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__mcp__app_notify, 0, 5, IS_MIXED, 0)
ZEND_ARG_TYPE_INFO(0, id, IS_MIXED, 0)
ZEND_ARG_TYPE_INFO(0, method, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, params, IS_MIXED, 0)
ZEND_ARG_TYPE_INFO(0, session_id, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, protocol_version, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__mcp__app_queue_notification, 0, 5, IS_MIXED, 0)
ZEND_ARG_TYPE_INFO(0, id, IS_MIXED, 0)
ZEND_ARG_TYPE_INFO(0, method, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, params, IS_MIXED, 0)
ZEND_ARG_TYPE_INFO(0, session_id, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, protocol_version, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__mcp__app_queue_request, 0, 6, IS_MIXED, 0)
ZEND_ARG_TYPE_INFO(0, response_id, IS_MIXED, 0)
ZEND_ARG_TYPE_INFO(0, request_id, IS_MIXED, 0)
ZEND_ARG_TYPE_INFO(0, method, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, params, IS_MIXED, 0)
ZEND_ARG_TYPE_INFO(0, session_id, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, protocol_version, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__mcp__app_queue_progress, 0, 7, IS_MIXED, 0)
ZEND_ARG_TYPE_INFO(0, id, IS_MIXED, 0)
ZEND_ARG_TYPE_INFO(0, progress_token, IS_MIXED, 0)
ZEND_ARG_TYPE_INFO(0, progress, IS_MIXED, 0)
ZEND_ARG_TYPE_INFO(0, total, IS_MIXED, 0)
ZEND_ARG_TYPE_INFO(0, message, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, session_id, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, protocol_version, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__mcp__app_queue_log, 0, 7, IS_MIXED, 0)
ZEND_ARG_TYPE_INFO(0, id, IS_MIXED, 0)
ZEND_ARG_TYPE_INFO(0, level, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, message, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, data, IS_MIXED, 0)
ZEND_ARG_TYPE_INFO(0, logger, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, session_id, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, protocol_version, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__mcp__app_queue_sampling, 0, 8, IS_MIXED, 0)
ZEND_ARG_TYPE_INFO(0, response_id, IS_MIXED, 0)
ZEND_ARG_TYPE_INFO(0, sampling_id, IS_MIXED, 0)
ZEND_ARG_TYPE_INFO(0, messages, IS_MIXED, 0)
ZEND_ARG_TYPE_INFO(0, session_id, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, protocol_version, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, model_preferences, IS_MIXED, 0)
ZEND_ARG_TYPE_INFO(0, system_prompt, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, max_tokens, IS_LONG, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__mcp__app_client_capabilities, 0, 1, IS_MIXED, 0)
ZEND_ARG_TYPE_INFO(0, frame, IS_MIXED, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__mcp__app_client_supports, 0, 2, _IS_BOOL, 0)
ZEND_ARG_TYPE_INFO(0, frame, IS_MIXED, 0)
ZEND_ARG_TYPE_INFO(0, name, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__mcp__app_capability_error, 0, 3, IS_MIXED, 0)
ZEND_ARG_TYPE_INFO(0, frame, IS_MIXED, 0)
ZEND_ARG_TYPE_INFO(0, message, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, status, IS_LONG, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__mcp__app_require_capability, 0, 4, IS_MIXED, 0)
ZEND_ARG_TYPE_INFO(0, frame, IS_MIXED, 0)
ZEND_ARG_TYPE_INFO(0, name, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, message, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, status, IS_LONG, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__mcp__app_handle_mcp_dispatch, 0, 1, IS_MIXED, 0)
ZEND_ARG_TYPE_INFO(0, frame, IS_MIXED, 0)
ZEND_END_ARG_INFO()
PHP_METHOD(VSlim__Mcp__App, __construct) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern vphp_class_handlers* VSlimMcpApp_handlers();
    vphp_class_handlers *h = VSlimMcpApp_handlers();
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    wrapper->v_ptr = h->new_raw();
    vphp_register_object(wrapper->v_ptr, Z_OBJ_P(getThis()));
    vphp_bind_handlers_with_ownership(Z_OBJ_P(getThis()), h, 1);
    extern void vphp_wrap_VSlimMcpApp_construct(void* v_ptr, vphp_context_internal ctx);
    void* v_ptr = wrapper->v_ptr;
    vphp_wrap_VSlimMcpApp_construct(v_ptr, ctx);
}

PHP_METHOD(VSlim__Mcp__App, server_info) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimMcpApp_server_info(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__Mcp__App::server_info called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimMcpApp_server_info(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__mcp__app_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimMcpApp_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimMcpApp_handlers(), 0);
    }
}


PHP_METHOD(VSlim__Mcp__App, capability) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimMcpApp_capability(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__Mcp__App::capability called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimMcpApp_capability(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__mcp__app_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimMcpApp_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimMcpApp_handlers(), 0);
    }
}


PHP_METHOD(VSlim__Mcp__App, capabilities) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimMcpApp_capabilities(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__Mcp__App::capabilities called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimMcpApp_capabilities(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__mcp__app_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimMcpApp_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimMcpApp_handlers(), 0);
    }
}


PHP_METHOD(VSlim__Mcp__App, register) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimMcpApp_register(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__Mcp__App::register called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimMcpApp_register(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__mcp__app_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimMcpApp_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimMcpApp_handlers(), 0);
    }
}


PHP_METHOD(VSlim__Mcp__App, tool) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimMcpApp_tool(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__Mcp__App::tool called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimMcpApp_tool(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__mcp__app_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimMcpApp_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimMcpApp_handlers(), 0);
    }
}


PHP_METHOD(VSlim__Mcp__App, resource) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimMcpApp_resource(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__Mcp__App::resource called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimMcpApp_resource(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__mcp__app_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimMcpApp_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimMcpApp_handlers(), 0);
    }
}


PHP_METHOD(VSlim__Mcp__App, prompt) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimMcpApp_prompt(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__Mcp__App::prompt called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimMcpApp_prompt(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__mcp__app_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimMcpApp_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimMcpApp_handlers(), 0);
    }
}

PHP_METHOD(VSlim__Mcp__App, notification) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimMcpApp_notification(vphp_context_internal ctx);
    vphp_wrap_VSlimMcpApp_notification(ctx);
}
PHP_METHOD(VSlim__Mcp__App, request) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimMcpApp_request(vphp_context_internal ctx);
    vphp_wrap_VSlimMcpApp_request(ctx);
}
PHP_METHOD(VSlim__Mcp__App, sampling_request) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimMcpApp_sampling_request(vphp_context_internal ctx);
    vphp_wrap_VSlimMcpApp_sampling_request(ctx);
}
PHP_METHOD(VSlim__Mcp__App, queued_result) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimMcpApp_queued_result(vphp_context_internal ctx);
    vphp_wrap_VSlimMcpApp_queued_result(ctx);
}
PHP_METHOD(VSlim__Mcp__App, queue_messages) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimMcpApp_queue_messages(vphp_context_internal ctx);
    vphp_wrap_VSlimMcpApp_queue_messages(ctx);
}
PHP_METHOD(VSlim__Mcp__App, notify) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimMcpApp_notify(vphp_context_internal ctx);
    vphp_wrap_VSlimMcpApp_notify(ctx);
}
PHP_METHOD(VSlim__Mcp__App, queue_notification) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimMcpApp_queue_notification(vphp_context_internal ctx);
    vphp_wrap_VSlimMcpApp_queue_notification(ctx);
}
PHP_METHOD(VSlim__Mcp__App, queue_request) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimMcpApp_queue_request(vphp_context_internal ctx);
    vphp_wrap_VSlimMcpApp_queue_request(ctx);
}
PHP_METHOD(VSlim__Mcp__App, queue_progress) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimMcpApp_queue_progress(vphp_context_internal ctx);
    vphp_wrap_VSlimMcpApp_queue_progress(ctx);
}
PHP_METHOD(VSlim__Mcp__App, queue_log) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimMcpApp_queue_log(vphp_context_internal ctx);
    vphp_wrap_VSlimMcpApp_queue_log(ctx);
}
PHP_METHOD(VSlim__Mcp__App, queue_sampling) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimMcpApp_queue_sampling(vphp_context_internal ctx);
    vphp_wrap_VSlimMcpApp_queue_sampling(ctx);
}
PHP_METHOD(VSlim__Mcp__App, client_capabilities) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimMcpApp_client_capabilities(vphp_context_internal ctx);
    vphp_wrap_VSlimMcpApp_client_capabilities(ctx);
}
PHP_METHOD(VSlim__Mcp__App, client_supports) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimMcpApp_client_supports(vphp_context_internal ctx);
    vphp_wrap_VSlimMcpApp_client_supports(ctx);
}
PHP_METHOD(VSlim__Mcp__App, capability_error) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimMcpApp_capability_error(vphp_context_internal ctx);
    vphp_wrap_VSlimMcpApp_capability_error(ctx);
}
PHP_METHOD(VSlim__Mcp__App, require_capability) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimMcpApp_require_capability(vphp_context_internal ctx);
    vphp_wrap_VSlimMcpApp_require_capability(ctx);
}
PHP_METHOD(VSlim__Mcp__App, handle_mcp_dispatch) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimMcpApp_handle_mcp_dispatch(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!wrapper->v_ptr) RETURN_FALSE;
    vphp_wrap_VSlimMcpApp_handle_mcp_dispatch(wrapper->v_ptr, ctx);
}
static const zend_function_entry vslim__mcp__app_methods[] = {
    PHP_ME(VSlim__Mcp__App, __construct, arginfo_vslim__mcp__app_construct, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Mcp__App, server_info, arginfo_vslim__mcp__app_server_info, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Mcp__App, capability, arginfo_vslim__mcp__app_capability, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Mcp__App, capabilities, arginfo_vslim__mcp__app_capabilities, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Mcp__App, register, arginfo_vslim__mcp__app_register, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Mcp__App, tool, arginfo_vslim__mcp__app_tool, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Mcp__App, resource, arginfo_vslim__mcp__app_resource, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Mcp__App, prompt, arginfo_vslim__mcp__app_prompt, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Mcp__App, notification, arginfo_vslim__mcp__app_notification, ZEND_ACC_PUBLIC | ZEND_ACC_STATIC)
    PHP_ME(VSlim__Mcp__App, request, arginfo_vslim__mcp__app_request, ZEND_ACC_PUBLIC | ZEND_ACC_STATIC)
    PHP_ME(VSlim__Mcp__App, sampling_request, arginfo_vslim__mcp__app_sampling_request, ZEND_ACC_PUBLIC | ZEND_ACC_STATIC)
    PHP_ME(VSlim__Mcp__App, queued_result, arginfo_vslim__mcp__app_queued_result, ZEND_ACC_PUBLIC | ZEND_ACC_STATIC)
    PHP_ME(VSlim__Mcp__App, queue_messages, arginfo_vslim__mcp__app_queue_messages, ZEND_ACC_PUBLIC | ZEND_ACC_STATIC)
    PHP_ME(VSlim__Mcp__App, notify, arginfo_vslim__mcp__app_notify, ZEND_ACC_PUBLIC | ZEND_ACC_STATIC)
    PHP_ME(VSlim__Mcp__App, queue_notification, arginfo_vslim__mcp__app_queue_notification, ZEND_ACC_PUBLIC | ZEND_ACC_STATIC)
    PHP_ME(VSlim__Mcp__App, queue_request, arginfo_vslim__mcp__app_queue_request, ZEND_ACC_PUBLIC | ZEND_ACC_STATIC)
    PHP_ME(VSlim__Mcp__App, queue_progress, arginfo_vslim__mcp__app_queue_progress, ZEND_ACC_PUBLIC | ZEND_ACC_STATIC)
    PHP_ME(VSlim__Mcp__App, queue_log, arginfo_vslim__mcp__app_queue_log, ZEND_ACC_PUBLIC | ZEND_ACC_STATIC)
    PHP_ME(VSlim__Mcp__App, queue_sampling, arginfo_vslim__mcp__app_queue_sampling, ZEND_ACC_PUBLIC | ZEND_ACC_STATIC)
    PHP_ME(VSlim__Mcp__App, client_capabilities, arginfo_vslim__mcp__app_client_capabilities, ZEND_ACC_PUBLIC | ZEND_ACC_STATIC)
    PHP_ME(VSlim__Mcp__App, client_supports, arginfo_vslim__mcp__app_client_supports, ZEND_ACC_PUBLIC | ZEND_ACC_STATIC)
    PHP_ME(VSlim__Mcp__App, capability_error, arginfo_vslim__mcp__app_capability_error, ZEND_ACC_PUBLIC | ZEND_ACC_STATIC)
    PHP_ME(VSlim__Mcp__App, require_capability, arginfo_vslim__mcp__app_require_capability, ZEND_ACC_PUBLIC | ZEND_ACC_STATIC)
    PHP_ME(VSlim__Mcp__App, handle_mcp_dispatch, arginfo_vslim__mcp__app_handle_mcp_dispatch, ZEND_ACC_PUBLIC)
    PHP_FE_END
};

zend_class_entry *vslim__log__logger_ce = NULL;
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__log__logger_construct, 0, 0, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__log__logger_disabled_level, 0, 0, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__log__logger_fatal_level, 0, 0, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__log__logger_error_level, 0, 0, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__log__logger_warn_level, 0, 0, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__log__logger_info_level, 0, 0, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__log__logger_debug_level, 0, 0, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__log__logger_set_level, 0, 0, 1)
ZEND_ARG_TYPE_INFO(0, level, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__log__logger_level, 0, 0, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__log__logger_set_channel, 0, 0, 1)
ZEND_ARG_TYPE_INFO(0, channel, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__log__logger_channel, 0, 0, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__log__logger_set_context, 0, 0, 1)
ZEND_ARG_TYPE_INFO(0, context, IS_MIXED, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__log__logger_context, 0, 0, IS_ARRAY, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__log__logger_with_context, 0, 0, 2)
ZEND_ARG_TYPE_INFO(0, key, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, value, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__log__logger_clear_context, 0, 0, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__log__logger_set_local_time, 0, 0, 1)
ZEND_ARG_TYPE_INFO(0, enabled, _IS_BOOL, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__log__logger_set_short_tag, 0, 0, 1)
ZEND_ARG_TYPE_INFO(0, enabled, _IS_BOOL, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__log__logger_set_output_file, 0, 0, 1)
ZEND_ARG_TYPE_INFO(0, path, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__log__logger_output_file, 0, 0, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__log__logger_use_stdout, 0, 0, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__log__logger_use_stderr, 0, 0, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__log__logger_output_target, 0, 0, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__log__logger_log, 0, 0, 2)
ZEND_ARG_TYPE_INFO(0, level, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, message, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__log__logger_log_context, 0, 0, 3)
ZEND_ARG_TYPE_INFO(0, level, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, message, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, context, IS_MIXED, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__log__logger_debug, 0, 0, 1)
ZEND_ARG_TYPE_INFO(0, message, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__log__logger_debug_context, 0, 0, 2)
ZEND_ARG_TYPE_INFO(0, message, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, context, IS_MIXED, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__log__logger_info, 0, 0, 1)
ZEND_ARG_TYPE_INFO(0, message, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__log__logger_info_context, 0, 0, 2)
ZEND_ARG_TYPE_INFO(0, message, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, context, IS_MIXED, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__log__logger_warn, 0, 0, 1)
ZEND_ARG_TYPE_INFO(0, message, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__log__logger_warn_context, 0, 0, 2)
ZEND_ARG_TYPE_INFO(0, message, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, context, IS_MIXED, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__log__logger_error, 0, 0, 1)
ZEND_ARG_TYPE_INFO(0, message, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__log__logger_error_context, 0, 0, 2)
ZEND_ARG_TYPE_INFO(0, message, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, context, IS_MIXED, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__log__logger_str, 0, 0, IS_STRING, 0)
ZEND_END_ARG_INFO()
PHP_METHOD(VSlim__Log__Logger, __construct) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern vphp_class_handlers* VSlimLogger_handlers();
    vphp_class_handlers *h = VSlimLogger_handlers();
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    wrapper->v_ptr = h->new_raw();
    vphp_register_object(wrapper->v_ptr, Z_OBJ_P(getThis()));
    vphp_bind_handlers_with_ownership(Z_OBJ_P(getThis()), h, 1);
    extern void vphp_wrap_VSlimLogger_construct(void* v_ptr, vphp_context_internal ctx);
    void* v_ptr = wrapper->v_ptr;
    vphp_wrap_VSlimLogger_construct(v_ptr, ctx);
}
PHP_METHOD(VSlim__Log__Logger, disabled_level) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimLogger_disabled_level(vphp_context_internal ctx);
    vphp_wrap_VSlimLogger_disabled_level(ctx);
}
PHP_METHOD(VSlim__Log__Logger, fatal_level) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimLogger_fatal_level(vphp_context_internal ctx);
    vphp_wrap_VSlimLogger_fatal_level(ctx);
}
PHP_METHOD(VSlim__Log__Logger, error_level) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimLogger_error_level(vphp_context_internal ctx);
    vphp_wrap_VSlimLogger_error_level(ctx);
}
PHP_METHOD(VSlim__Log__Logger, warn_level) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimLogger_warn_level(vphp_context_internal ctx);
    vphp_wrap_VSlimLogger_warn_level(ctx);
}
PHP_METHOD(VSlim__Log__Logger, info_level) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimLogger_info_level(vphp_context_internal ctx);
    vphp_wrap_VSlimLogger_info_level(ctx);
}
PHP_METHOD(VSlim__Log__Logger, debug_level) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimLogger_debug_level(vphp_context_internal ctx);
    vphp_wrap_VSlimLogger_debug_level(ctx);
}

PHP_METHOD(VSlim__Log__Logger, set_level) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimLogger_set_level(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__Log__Logger::set_level called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimLogger_set_level(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__log__logger_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimLogger_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimLogger_handlers(), 0);
    }
}

PHP_METHOD(VSlim__Log__Logger, level) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimLogger_level(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!wrapper->v_ptr) RETURN_FALSE;
    vphp_wrap_VSlimLogger_level(wrapper->v_ptr, ctx);
}

PHP_METHOD(VSlim__Log__Logger, set_channel) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimLogger_set_channel(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__Log__Logger::set_channel called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimLogger_set_channel(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__log__logger_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimLogger_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimLogger_handlers(), 0);
    }
}

PHP_METHOD(VSlim__Log__Logger, channel) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimLogger_channel(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!wrapper->v_ptr) RETURN_FALSE;
    vphp_wrap_VSlimLogger_channel(wrapper->v_ptr, ctx);
}

PHP_METHOD(VSlim__Log__Logger, set_context) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimLogger_set_context(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__Log__Logger::set_context called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimLogger_set_context(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__log__logger_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimLogger_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimLogger_handlers(), 0);
    }
}

PHP_METHOD(VSlim__Log__Logger, context) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimLogger_context(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!wrapper->v_ptr) RETURN_FALSE;
    vphp_wrap_VSlimLogger_context(wrapper->v_ptr, ctx);
}

PHP_METHOD(VSlim__Log__Logger, with_context) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimLogger_with_context(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__Log__Logger::with_context called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimLogger_with_context(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__log__logger_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimLogger_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimLogger_handlers(), 0);
    }
}


PHP_METHOD(VSlim__Log__Logger, clear_context) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimLogger_clear_context(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__Log__Logger::clear_context called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimLogger_clear_context(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__log__logger_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimLogger_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimLogger_handlers(), 0);
    }
}


PHP_METHOD(VSlim__Log__Logger, set_local_time) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimLogger_set_local_time(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__Log__Logger::set_local_time called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimLogger_set_local_time(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__log__logger_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimLogger_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimLogger_handlers(), 0);
    }
}


PHP_METHOD(VSlim__Log__Logger, set_short_tag) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimLogger_set_short_tag(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__Log__Logger::set_short_tag called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimLogger_set_short_tag(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__log__logger_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimLogger_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimLogger_handlers(), 0);
    }
}


PHP_METHOD(VSlim__Log__Logger, set_output_file) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimLogger_set_output_file(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__Log__Logger::set_output_file called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimLogger_set_output_file(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__log__logger_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimLogger_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimLogger_handlers(), 0);
    }
}

PHP_METHOD(VSlim__Log__Logger, output_file) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimLogger_output_file(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!wrapper->v_ptr) RETURN_FALSE;
    vphp_wrap_VSlimLogger_output_file(wrapper->v_ptr, ctx);
}

PHP_METHOD(VSlim__Log__Logger, use_stdout) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimLogger_use_stdout(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__Log__Logger::use_stdout called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimLogger_use_stdout(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__log__logger_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimLogger_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimLogger_handlers(), 0);
    }
}


PHP_METHOD(VSlim__Log__Logger, use_stderr) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimLogger_use_stderr(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__Log__Logger::use_stderr called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimLogger_use_stderr(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__log__logger_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimLogger_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimLogger_handlers(), 0);
    }
}

PHP_METHOD(VSlim__Log__Logger, output_target) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimLogger_output_target(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!wrapper->v_ptr) RETURN_FALSE;
    vphp_wrap_VSlimLogger_output_target(wrapper->v_ptr, ctx);
}

PHP_METHOD(VSlim__Log__Logger, log) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimLogger_log(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__Log__Logger::log called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimLogger_log(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__log__logger_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimLogger_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimLogger_handlers(), 0);
    }
}


PHP_METHOD(VSlim__Log__Logger, log_context) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimLogger_log_context(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__Log__Logger::log_context called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimLogger_log_context(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__log__logger_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimLogger_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimLogger_handlers(), 0);
    }
}


PHP_METHOD(VSlim__Log__Logger, debug) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimLogger_debug(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__Log__Logger::debug called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimLogger_debug(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__log__logger_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimLogger_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimLogger_handlers(), 0);
    }
}


PHP_METHOD(VSlim__Log__Logger, debug_context) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimLogger_debug_context(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__Log__Logger::debug_context called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimLogger_debug_context(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__log__logger_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimLogger_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimLogger_handlers(), 0);
    }
}


PHP_METHOD(VSlim__Log__Logger, info) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimLogger_info(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__Log__Logger::info called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimLogger_info(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__log__logger_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimLogger_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimLogger_handlers(), 0);
    }
}


PHP_METHOD(VSlim__Log__Logger, info_context) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimLogger_info_context(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__Log__Logger::info_context called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimLogger_info_context(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__log__logger_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimLogger_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimLogger_handlers(), 0);
    }
}


PHP_METHOD(VSlim__Log__Logger, warn) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimLogger_warn(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__Log__Logger::warn called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimLogger_warn(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__log__logger_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimLogger_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimLogger_handlers(), 0);
    }
}


PHP_METHOD(VSlim__Log__Logger, warn_context) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimLogger_warn_context(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__Log__Logger::warn_context called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimLogger_warn_context(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__log__logger_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimLogger_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimLogger_handlers(), 0);
    }
}


PHP_METHOD(VSlim__Log__Logger, error) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimLogger_error(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__Log__Logger::error called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimLogger_error(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__log__logger_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimLogger_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimLogger_handlers(), 0);
    }
}


PHP_METHOD(VSlim__Log__Logger, error_context) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimLogger_error_context(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__Log__Logger::error_context called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimLogger_error_context(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__log__logger_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimLogger_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimLogger_handlers(), 0);
    }
}

PHP_METHOD(VSlim__Log__Logger, __toString) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimLogger_str(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!wrapper->v_ptr) RETURN_FALSE;
    vphp_wrap_VSlimLogger_str(wrapper->v_ptr, ctx);
}
static const zend_function_entry vslim__log__logger_methods[] = {
    PHP_ME(VSlim__Log__Logger, __construct, arginfo_vslim__log__logger_construct, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Log__Logger, disabled_level, arginfo_vslim__log__logger_disabled_level, ZEND_ACC_PUBLIC | ZEND_ACC_STATIC)
    PHP_ME(VSlim__Log__Logger, fatal_level, arginfo_vslim__log__logger_fatal_level, ZEND_ACC_PUBLIC | ZEND_ACC_STATIC)
    PHP_ME(VSlim__Log__Logger, error_level, arginfo_vslim__log__logger_error_level, ZEND_ACC_PUBLIC | ZEND_ACC_STATIC)
    PHP_ME(VSlim__Log__Logger, warn_level, arginfo_vslim__log__logger_warn_level, ZEND_ACC_PUBLIC | ZEND_ACC_STATIC)
    PHP_ME(VSlim__Log__Logger, info_level, arginfo_vslim__log__logger_info_level, ZEND_ACC_PUBLIC | ZEND_ACC_STATIC)
    PHP_ME(VSlim__Log__Logger, debug_level, arginfo_vslim__log__logger_debug_level, ZEND_ACC_PUBLIC | ZEND_ACC_STATIC)
    PHP_ME(VSlim__Log__Logger, set_level, arginfo_vslim__log__logger_set_level, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Log__Logger, level, arginfo_vslim__log__logger_level, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Log__Logger, set_channel, arginfo_vslim__log__logger_set_channel, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Log__Logger, channel, arginfo_vslim__log__logger_channel, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Log__Logger, set_context, arginfo_vslim__log__logger_set_context, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Log__Logger, context, arginfo_vslim__log__logger_context, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Log__Logger, with_context, arginfo_vslim__log__logger_with_context, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Log__Logger, clear_context, arginfo_vslim__log__logger_clear_context, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Log__Logger, set_local_time, arginfo_vslim__log__logger_set_local_time, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Log__Logger, set_short_tag, arginfo_vslim__log__logger_set_short_tag, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Log__Logger, set_output_file, arginfo_vslim__log__logger_set_output_file, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Log__Logger, output_file, arginfo_vslim__log__logger_output_file, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Log__Logger, use_stdout, arginfo_vslim__log__logger_use_stdout, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Log__Logger, use_stderr, arginfo_vslim__log__logger_use_stderr, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Log__Logger, output_target, arginfo_vslim__log__logger_output_target, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Log__Logger, log, arginfo_vslim__log__logger_log, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Log__Logger, log_context, arginfo_vslim__log__logger_log_context, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Log__Logger, debug, arginfo_vslim__log__logger_debug, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Log__Logger, debug_context, arginfo_vslim__log__logger_debug_context, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Log__Logger, info, arginfo_vslim__log__logger_info, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Log__Logger, info_context, arginfo_vslim__log__logger_info_context, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Log__Logger, warn, arginfo_vslim__log__logger_warn, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Log__Logger, warn_context, arginfo_vslim__log__logger_warn_context, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Log__Logger, error, arginfo_vslim__log__logger_error, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Log__Logger, error_context, arginfo_vslim__log__logger_error_context, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Log__Logger, __toString, arginfo_vslim__log__logger_str, ZEND_ACC_PUBLIC)
    PHP_FE_END
};

zend_class_entry *vslim__log__level_ce = NULL;
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__log__level___construct, 0, 0, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__log__level_disabled, 0, 0, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__log__level_fatal, 0, 0, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__log__level_error, 0, 0, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__log__level_warn, 0, 0, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__log__level_info, 0, 0, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__log__level_debug, 0, 0, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__log__level_all, 0, 0, IS_ARRAY, 0)
ZEND_END_ARG_INFO()
PHP_METHOD(VSlim__Log__Level, disabled) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimLogLevel_disabled(vphp_context_internal ctx);
    vphp_wrap_VSlimLogLevel_disabled(ctx);
}
PHP_METHOD(VSlim__Log__Level, fatal) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimLogLevel_fatal(vphp_context_internal ctx);
    vphp_wrap_VSlimLogLevel_fatal(ctx);
}
PHP_METHOD(VSlim__Log__Level, error) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimLogLevel_error(vphp_context_internal ctx);
    vphp_wrap_VSlimLogLevel_error(ctx);
}
PHP_METHOD(VSlim__Log__Level, warn) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimLogLevel_warn(vphp_context_internal ctx);
    vphp_wrap_VSlimLogLevel_warn(ctx);
}
PHP_METHOD(VSlim__Log__Level, info) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimLogLevel_info(vphp_context_internal ctx);
    vphp_wrap_VSlimLogLevel_info(ctx);
}
PHP_METHOD(VSlim__Log__Level, debug) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimLogLevel_debug(vphp_context_internal ctx);
    vphp_wrap_VSlimLogLevel_debug(ctx);
}
PHP_METHOD(VSlim__Log__Level, all) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimLogLevel_all(vphp_context_internal ctx);
    vphp_wrap_VSlimLogLevel_all(ctx);
}

PHP_METHOD(VSlim__Log__Level, __construct) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern vphp_class_handlers* VSlimLogLevel_handlers();
    vphp_class_handlers *h = VSlimLogLevel_handlers();
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    wrapper->v_ptr = h->new_raw();
    vphp_register_object(wrapper->v_ptr, Z_OBJ_P(getThis()));
    vphp_bind_handlers_with_ownership(Z_OBJ_P(getThis()), h, 1);
}

static const zend_function_entry vslim__log__level_methods[] = {
    PHP_ME(VSlim__Log__Level, __construct, arginfo_vslim__log__level___construct, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Log__Level, disabled, arginfo_vslim__log__level_disabled, ZEND_ACC_PUBLIC | ZEND_ACC_STATIC)
    PHP_ME(VSlim__Log__Level, fatal, arginfo_vslim__log__level_fatal, ZEND_ACC_PUBLIC | ZEND_ACC_STATIC)
    PHP_ME(VSlim__Log__Level, error, arginfo_vslim__log__level_error, ZEND_ACC_PUBLIC | ZEND_ACC_STATIC)
    PHP_ME(VSlim__Log__Level, warn, arginfo_vslim__log__level_warn, ZEND_ACC_PUBLIC | ZEND_ACC_STATIC)
    PHP_ME(VSlim__Log__Level, info, arginfo_vslim__log__level_info, ZEND_ACC_PUBLIC | ZEND_ACC_STATIC)
    PHP_ME(VSlim__Log__Level, debug, arginfo_vslim__log__level_debug, ZEND_ACC_PUBLIC | ZEND_ACC_STATIC)
    PHP_ME(VSlim__Log__Level, all, arginfo_vslim__log__level_all, ZEND_ACC_PUBLIC | ZEND_ACC_STATIC)
    PHP_FE_END
};

zend_class_entry *vslim__live__socket_ce = NULL;
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__live__socket_construct, 0, 0, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__live__socket_set_id, 0, 0, 1)
ZEND_ARG_TYPE_INFO(0, id, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__live__socket_id, 0, 0, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__live__socket_set_connected, 0, 0, 1)
ZEND_ARG_TYPE_INFO(0, connected, _IS_BOOL, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__live__socket_connected, 0, 0, _IS_BOOL, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__live__socket_set_target, 0, 0, 1)
ZEND_ARG_TYPE_INFO(0, raw_path, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__live__socket_target, 0, 0, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__live__socket_set_root_id, 0, 0, 1)
ZEND_ARG_TYPE_INFO(0, root_id, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__live__socket_root_id, 0, 0, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__live__socket_assign, 0, 0, 2)
ZEND_ARG_TYPE_INFO(0, key, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, value, IS_MIXED, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__live__socket_assign_many, 0, 0, 1)
ZEND_ARG_TYPE_INFO(0, values, IS_MIXED, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__live__socket_assign_form, 0, 0, 1)
ZEND_ARG_TYPE_INFO(0, values, IS_MIXED, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__live__socket_reset_form, 0, 0, 1)
ZEND_ARG_TYPE_INFO(0, values, IS_MIXED, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__live__socket_forget, 0, 0, 1)
ZEND_ARG_TYPE_INFO(0, key, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__live__socket_forget_input, 0, 0, 1)
ZEND_ARG_TYPE_INFO(0, field, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__live__socket_forget_inputs, 0, 0, 1)
ZEND_ARG_TYPE_INFO(0, fields, IS_MIXED, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__live__socket_clear_assigns, 0, 0, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__live__socket_assign_component_state, 0, 0, 3)
ZEND_ARG_TYPE_INFO(0, component_id, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, field, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, value, IS_MIXED, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__live__socket_component_state, 0, 2, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, component_id, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, field, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__live__socket_component_state_or, 0, 3, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, component_id, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, field, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, fallback, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__live__socket_clear_component_state, 0, 0, 2)
ZEND_ARG_TYPE_INFO(0, component_id, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, field, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__live__socket_assign_error, 0, 0, 2)
ZEND_ARG_TYPE_INFO(0, field, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, message, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__live__socket_assign_errors, 0, 0, 1)
ZEND_ARG_TYPE_INFO(0, values, IS_MIXED, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__live__socket_clear_error, 0, 0, 1)
ZEND_ARG_TYPE_INFO(0, field, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__live__socket_clear_errors, 0, 0, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__live__socket_input, 0, 1, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, field, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__live__socket_input_or, 0, 2, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, field, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, fallback, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__live__socket_old, 0, 1, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, field, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__live__socket_old_or, 0, 2, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, field, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, fallback, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__live__socket_error, 0, 1, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, field, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__live__socket_has_error, 0, 1, _IS_BOOL, 0)
ZEND_ARG_TYPE_INFO(0, field, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__live__socket_form, 0, 0, 1)
ZEND_ARG_TYPE_INFO(0, name, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__live__socket_get, 0, 1, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, key, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__live__socket_has, 0, 1, _IS_BOOL, 0)
ZEND_ARG_TYPE_INFO(0, key, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__live__socket_assigns, 0, 0, IS_ARRAY, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__live__socket_patch, 0, 0, 2)
ZEND_ARG_TYPE_INFO(0, target_id, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, html, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__live__socket_append, 0, 0, 2)
ZEND_ARG_TYPE_INFO(0, target_id, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, html, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__live__socket_prepend, 0, 0, 2)
ZEND_ARG_TYPE_INFO(0, target_id, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, html, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__live__socket_set_text, 0, 0, 2)
ZEND_ARG_TYPE_INFO(0, target_id, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, text, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__live__socket_set_attr, 0, 0, 3)
ZEND_ARG_TYPE_INFO(0, target_id, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, name, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, value, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__live__socket_remove, 0, 0, 1)
ZEND_ARG_TYPE_INFO(0, target_id, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__live__socket_patches, 0, 0, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__live__socket_clear_patches, 0, 0, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__live__socket_push_event, 0, 0, 2)
ZEND_ARG_TYPE_INFO(0, event, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, payload, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__live__socket_events, 0, 0, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__live__socket_clear_events, 0, 0, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__live__socket_flash, 0, 0, 2)
ZEND_ARG_TYPE_INFO(0, kind, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, message, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__live__socket_flashes, 0, 0, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__live__socket_clear_flashes, 0, 0, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__live__socket_join_topic, 0, 0, 1)
ZEND_ARG_TYPE_INFO(0, room, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__live__socket_leave_topic, 0, 0, 1)
ZEND_ARG_TYPE_INFO(0, room, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__live__socket_broadcast_info, 0, 0, 4)
ZEND_ARG_TYPE_INFO(0, room, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, event, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, payload, IS_MIXED, 0)
ZEND_ARG_TYPE_INFO(0, include_self, _IS_BOOL, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__live__socket_pubsub_commands, 0, 0, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__live__socket_clear_pubsub, 0, 0, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__live__socket_redirect, 0, 0, 1)
ZEND_ARG_TYPE_INFO(0, location, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__live__socket_redirect_to, 0, 0, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__live__socket_clear_redirect, 0, 0, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__live__socket_navigate, 0, 0, 1)
ZEND_ARG_TYPE_INFO(0, location, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__live__socket_navigate_to, 0, 0, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__live__socket_clear_navigate, 0, 0, 0)
ZEND_END_ARG_INFO()
PHP_METHOD(VSlim__Live__Socket, __construct) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern vphp_class_handlers* VSlimLiveSocket_handlers();
    vphp_class_handlers *h = VSlimLiveSocket_handlers();
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    wrapper->v_ptr = h->new_raw();
    vphp_register_object(wrapper->v_ptr, Z_OBJ_P(getThis()));
    vphp_bind_handlers_with_ownership(Z_OBJ_P(getThis()), h, 1);
    extern void vphp_wrap_VSlimLiveSocket_construct(void* v_ptr, vphp_context_internal ctx);
    void* v_ptr = wrapper->v_ptr;
    vphp_wrap_VSlimLiveSocket_construct(v_ptr, ctx);
}

PHP_METHOD(VSlim__Live__Socket, set_id) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimLiveSocket_set_id(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__Live__Socket::set_id called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimLiveSocket_set_id(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__live__socket_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimLiveSocket_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimLiveSocket_handlers(), 0);
    }
}

PHP_METHOD(VSlim__Live__Socket, id) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimLiveSocket_id(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!wrapper->v_ptr) RETURN_FALSE;
    vphp_wrap_VSlimLiveSocket_id(wrapper->v_ptr, ctx);
}

PHP_METHOD(VSlim__Live__Socket, set_connected) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimLiveSocket_set_connected(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__Live__Socket::set_connected called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimLiveSocket_set_connected(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__live__socket_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimLiveSocket_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimLiveSocket_handlers(), 0);
    }
}

PHP_METHOD(VSlim__Live__Socket, connected) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimLiveSocket_connected(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!wrapper->v_ptr) RETURN_FALSE;
    vphp_wrap_VSlimLiveSocket_connected(wrapper->v_ptr, ctx);
}

PHP_METHOD(VSlim__Live__Socket, set_target) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimLiveSocket_set_target(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__Live__Socket::set_target called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimLiveSocket_set_target(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__live__socket_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimLiveSocket_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimLiveSocket_handlers(), 0);
    }
}

PHP_METHOD(VSlim__Live__Socket, target) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimLiveSocket_target(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!wrapper->v_ptr) RETURN_FALSE;
    vphp_wrap_VSlimLiveSocket_target(wrapper->v_ptr, ctx);
}

PHP_METHOD(VSlim__Live__Socket, set_root_id) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimLiveSocket_set_root_id(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__Live__Socket::set_root_id called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimLiveSocket_set_root_id(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__live__socket_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimLiveSocket_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimLiveSocket_handlers(), 0);
    }
}

PHP_METHOD(VSlim__Live__Socket, root_id) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimLiveSocket_root_id(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!wrapper->v_ptr) RETURN_FALSE;
    vphp_wrap_VSlimLiveSocket_root_id(wrapper->v_ptr, ctx);
}

PHP_METHOD(VSlim__Live__Socket, assign) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimLiveSocket_assign(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__Live__Socket::assign called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimLiveSocket_assign(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__live__socket_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimLiveSocket_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimLiveSocket_handlers(), 0);
    }
}


PHP_METHOD(VSlim__Live__Socket, assign_many) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimLiveSocket_assign_many(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__Live__Socket::assign_many called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimLiveSocket_assign_many(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__live__socket_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimLiveSocket_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimLiveSocket_handlers(), 0);
    }
}


PHP_METHOD(VSlim__Live__Socket, assign_form) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimLiveSocket_assign_form(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__Live__Socket::assign_form called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimLiveSocket_assign_form(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__live__socket_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimLiveSocket_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimLiveSocket_handlers(), 0);
    }
}


PHP_METHOD(VSlim__Live__Socket, reset_form) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimLiveSocket_reset_form(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__Live__Socket::reset_form called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimLiveSocket_reset_form(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__live__socket_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimLiveSocket_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimLiveSocket_handlers(), 0);
    }
}


PHP_METHOD(VSlim__Live__Socket, forget) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimLiveSocket_forget(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__Live__Socket::forget called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimLiveSocket_forget(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__live__socket_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimLiveSocket_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimLiveSocket_handlers(), 0);
    }
}


PHP_METHOD(VSlim__Live__Socket, forget_input) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimLiveSocket_forget_input(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__Live__Socket::forget_input called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimLiveSocket_forget_input(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__live__socket_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimLiveSocket_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimLiveSocket_handlers(), 0);
    }
}


PHP_METHOD(VSlim__Live__Socket, forget_inputs) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimLiveSocket_forget_inputs(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__Live__Socket::forget_inputs called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimLiveSocket_forget_inputs(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__live__socket_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimLiveSocket_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimLiveSocket_handlers(), 0);
    }
}


PHP_METHOD(VSlim__Live__Socket, clear_assigns) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimLiveSocket_clear_assigns(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__Live__Socket::clear_assigns called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimLiveSocket_clear_assigns(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__live__socket_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimLiveSocket_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimLiveSocket_handlers(), 0);
    }
}


PHP_METHOD(VSlim__Live__Socket, assign_component_state) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimLiveSocket_assign_component_state(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__Live__Socket::assign_component_state called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimLiveSocket_assign_component_state(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__live__socket_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimLiveSocket_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimLiveSocket_handlers(), 0);
    }
}

PHP_METHOD(VSlim__Live__Socket, component_state) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimLiveSocket_component_state(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!wrapper->v_ptr) RETURN_FALSE;
    vphp_wrap_VSlimLiveSocket_component_state(wrapper->v_ptr, ctx);
}
PHP_METHOD(VSlim__Live__Socket, component_state_or) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimLiveSocket_component_state_or(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!wrapper->v_ptr) RETURN_FALSE;
    vphp_wrap_VSlimLiveSocket_component_state_or(wrapper->v_ptr, ctx);
}

PHP_METHOD(VSlim__Live__Socket, clear_component_state) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimLiveSocket_clear_component_state(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__Live__Socket::clear_component_state called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimLiveSocket_clear_component_state(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__live__socket_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimLiveSocket_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimLiveSocket_handlers(), 0);
    }
}


PHP_METHOD(VSlim__Live__Socket, assign_error) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimLiveSocket_assign_error(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__Live__Socket::assign_error called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimLiveSocket_assign_error(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__live__socket_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimLiveSocket_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimLiveSocket_handlers(), 0);
    }
}


PHP_METHOD(VSlim__Live__Socket, assign_errors) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimLiveSocket_assign_errors(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__Live__Socket::assign_errors called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimLiveSocket_assign_errors(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__live__socket_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimLiveSocket_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimLiveSocket_handlers(), 0);
    }
}


PHP_METHOD(VSlim__Live__Socket, clear_error) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimLiveSocket_clear_error(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__Live__Socket::clear_error called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimLiveSocket_clear_error(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__live__socket_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimLiveSocket_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimLiveSocket_handlers(), 0);
    }
}


PHP_METHOD(VSlim__Live__Socket, clear_errors) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimLiveSocket_clear_errors(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__Live__Socket::clear_errors called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimLiveSocket_clear_errors(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__live__socket_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimLiveSocket_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimLiveSocket_handlers(), 0);
    }
}

PHP_METHOD(VSlim__Live__Socket, input) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimLiveSocket_input(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!wrapper->v_ptr) RETURN_FALSE;
    vphp_wrap_VSlimLiveSocket_input(wrapper->v_ptr, ctx);
}
PHP_METHOD(VSlim__Live__Socket, input_or) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimLiveSocket_input_or(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!wrapper->v_ptr) RETURN_FALSE;
    vphp_wrap_VSlimLiveSocket_input_or(wrapper->v_ptr, ctx);
}
PHP_METHOD(VSlim__Live__Socket, old) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimLiveSocket_old(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!wrapper->v_ptr) RETURN_FALSE;
    vphp_wrap_VSlimLiveSocket_old(wrapper->v_ptr, ctx);
}
PHP_METHOD(VSlim__Live__Socket, old_or) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimLiveSocket_old_or(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!wrapper->v_ptr) RETURN_FALSE;
    vphp_wrap_VSlimLiveSocket_old_or(wrapper->v_ptr, ctx);
}
PHP_METHOD(VSlim__Live__Socket, error) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimLiveSocket_error(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!wrapper->v_ptr) RETURN_FALSE;
    vphp_wrap_VSlimLiveSocket_error(wrapper->v_ptr, ctx);
}
PHP_METHOD(VSlim__Live__Socket, has_error) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimLiveSocket_has_error(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!wrapper->v_ptr) RETURN_FALSE;
    vphp_wrap_VSlimLiveSocket_has_error(wrapper->v_ptr, ctx);
}

PHP_METHOD(VSlim__Live__Socket, form) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimLiveSocket_form(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__Live__Socket::form called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimLiveSocket_form(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__live__form_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimLiveForm_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimLiveForm_handlers(), 0);
    }
}

PHP_METHOD(VSlim__Live__Socket, get) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimLiveSocket_get(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!wrapper->v_ptr) RETURN_FALSE;
    vphp_wrap_VSlimLiveSocket_get(wrapper->v_ptr, ctx);
}
PHP_METHOD(VSlim__Live__Socket, has) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimLiveSocket_has(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!wrapper->v_ptr) RETURN_FALSE;
    vphp_wrap_VSlimLiveSocket_has(wrapper->v_ptr, ctx);
}
PHP_METHOD(VSlim__Live__Socket, assigns) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimLiveSocket_assigns(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!wrapper->v_ptr) RETURN_FALSE;
    vphp_wrap_VSlimLiveSocket_assigns(wrapper->v_ptr, ctx);
}

PHP_METHOD(VSlim__Live__Socket, patch) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimLiveSocket_patch(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__Live__Socket::patch called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimLiveSocket_patch(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__live__socket_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimLiveSocket_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimLiveSocket_handlers(), 0);
    }
}


PHP_METHOD(VSlim__Live__Socket, append) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimLiveSocket_append(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__Live__Socket::append called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimLiveSocket_append(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__live__socket_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimLiveSocket_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimLiveSocket_handlers(), 0);
    }
}


PHP_METHOD(VSlim__Live__Socket, prepend) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimLiveSocket_prepend(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__Live__Socket::prepend called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimLiveSocket_prepend(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__live__socket_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimLiveSocket_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimLiveSocket_handlers(), 0);
    }
}


PHP_METHOD(VSlim__Live__Socket, set_text) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimLiveSocket_set_text(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__Live__Socket::set_text called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimLiveSocket_set_text(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__live__socket_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimLiveSocket_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimLiveSocket_handlers(), 0);
    }
}


PHP_METHOD(VSlim__Live__Socket, set_attr) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimLiveSocket_set_attr(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__Live__Socket::set_attr called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimLiveSocket_set_attr(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__live__socket_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimLiveSocket_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimLiveSocket_handlers(), 0);
    }
}


PHP_METHOD(VSlim__Live__Socket, remove) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimLiveSocket_remove(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__Live__Socket::remove called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimLiveSocket_remove(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__live__socket_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimLiveSocket_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimLiveSocket_handlers(), 0);
    }
}

PHP_METHOD(VSlim__Live__Socket, patches) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimLiveSocket_patches(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!wrapper->v_ptr) RETURN_FALSE;
    vphp_wrap_VSlimLiveSocket_patches(wrapper->v_ptr, ctx);
}

PHP_METHOD(VSlim__Live__Socket, clear_patches) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimLiveSocket_clear_patches(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__Live__Socket::clear_patches called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimLiveSocket_clear_patches(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__live__socket_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimLiveSocket_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimLiveSocket_handlers(), 0);
    }
}


PHP_METHOD(VSlim__Live__Socket, push_event) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimLiveSocket_push_event(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__Live__Socket::push_event called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimLiveSocket_push_event(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__live__socket_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimLiveSocket_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimLiveSocket_handlers(), 0);
    }
}

PHP_METHOD(VSlim__Live__Socket, events) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimLiveSocket_events(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!wrapper->v_ptr) RETURN_FALSE;
    vphp_wrap_VSlimLiveSocket_events(wrapper->v_ptr, ctx);
}

PHP_METHOD(VSlim__Live__Socket, clear_events) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimLiveSocket_clear_events(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__Live__Socket::clear_events called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimLiveSocket_clear_events(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__live__socket_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimLiveSocket_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimLiveSocket_handlers(), 0);
    }
}


PHP_METHOD(VSlim__Live__Socket, flash) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimLiveSocket_flash(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__Live__Socket::flash called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimLiveSocket_flash(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__live__socket_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimLiveSocket_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimLiveSocket_handlers(), 0);
    }
}

PHP_METHOD(VSlim__Live__Socket, flashes) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimLiveSocket_flashes(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!wrapper->v_ptr) RETURN_FALSE;
    vphp_wrap_VSlimLiveSocket_flashes(wrapper->v_ptr, ctx);
}

PHP_METHOD(VSlim__Live__Socket, clear_flashes) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimLiveSocket_clear_flashes(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__Live__Socket::clear_flashes called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimLiveSocket_clear_flashes(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__live__socket_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimLiveSocket_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimLiveSocket_handlers(), 0);
    }
}


PHP_METHOD(VSlim__Live__Socket, join_topic) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimLiveSocket_join_topic(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__Live__Socket::join_topic called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimLiveSocket_join_topic(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__live__socket_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimLiveSocket_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimLiveSocket_handlers(), 0);
    }
}


PHP_METHOD(VSlim__Live__Socket, leave_topic) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimLiveSocket_leave_topic(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__Live__Socket::leave_topic called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimLiveSocket_leave_topic(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__live__socket_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimLiveSocket_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimLiveSocket_handlers(), 0);
    }
}


PHP_METHOD(VSlim__Live__Socket, broadcast_info) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimLiveSocket_broadcast_info(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__Live__Socket::broadcast_info called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimLiveSocket_broadcast_info(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__live__socket_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimLiveSocket_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimLiveSocket_handlers(), 0);
    }
}

PHP_METHOD(VSlim__Live__Socket, pubsub_commands) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimLiveSocket_pubsub_commands(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!wrapper->v_ptr) RETURN_FALSE;
    vphp_wrap_VSlimLiveSocket_pubsub_commands(wrapper->v_ptr, ctx);
}

PHP_METHOD(VSlim__Live__Socket, clear_pubsub) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimLiveSocket_clear_pubsub(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__Live__Socket::clear_pubsub called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimLiveSocket_clear_pubsub(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__live__socket_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimLiveSocket_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimLiveSocket_handlers(), 0);
    }
}


PHP_METHOD(VSlim__Live__Socket, redirect) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimLiveSocket_redirect(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__Live__Socket::redirect called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimLiveSocket_redirect(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__live__socket_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimLiveSocket_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimLiveSocket_handlers(), 0);
    }
}

PHP_METHOD(VSlim__Live__Socket, redirect_to) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimLiveSocket_redirect_to(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!wrapper->v_ptr) RETURN_FALSE;
    vphp_wrap_VSlimLiveSocket_redirect_to(wrapper->v_ptr, ctx);
}

PHP_METHOD(VSlim__Live__Socket, clear_redirect) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimLiveSocket_clear_redirect(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__Live__Socket::clear_redirect called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimLiveSocket_clear_redirect(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__live__socket_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimLiveSocket_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimLiveSocket_handlers(), 0);
    }
}


PHP_METHOD(VSlim__Live__Socket, navigate) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimLiveSocket_navigate(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__Live__Socket::navigate called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimLiveSocket_navigate(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__live__socket_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimLiveSocket_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimLiveSocket_handlers(), 0);
    }
}

PHP_METHOD(VSlim__Live__Socket, navigate_to) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimLiveSocket_navigate_to(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!wrapper->v_ptr) RETURN_FALSE;
    vphp_wrap_VSlimLiveSocket_navigate_to(wrapper->v_ptr, ctx);
}

PHP_METHOD(VSlim__Live__Socket, clear_navigate) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimLiveSocket_clear_navigate(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__Live__Socket::clear_navigate called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimLiveSocket_clear_navigate(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__live__socket_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimLiveSocket_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimLiveSocket_handlers(), 0);
    }
}

static const zend_function_entry vslim__live__socket_methods[] = {
    PHP_ME(VSlim__Live__Socket, __construct, arginfo_vslim__live__socket_construct, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Live__Socket, set_id, arginfo_vslim__live__socket_set_id, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Live__Socket, id, arginfo_vslim__live__socket_id, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Live__Socket, set_connected, arginfo_vslim__live__socket_set_connected, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Live__Socket, connected, arginfo_vslim__live__socket_connected, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Live__Socket, set_target, arginfo_vslim__live__socket_set_target, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Live__Socket, target, arginfo_vslim__live__socket_target, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Live__Socket, set_root_id, arginfo_vslim__live__socket_set_root_id, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Live__Socket, root_id, arginfo_vslim__live__socket_root_id, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Live__Socket, assign, arginfo_vslim__live__socket_assign, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Live__Socket, assign_many, arginfo_vslim__live__socket_assign_many, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Live__Socket, assign_form, arginfo_vslim__live__socket_assign_form, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Live__Socket, reset_form, arginfo_vslim__live__socket_reset_form, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Live__Socket, forget, arginfo_vslim__live__socket_forget, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Live__Socket, forget_input, arginfo_vslim__live__socket_forget_input, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Live__Socket, forget_inputs, arginfo_vslim__live__socket_forget_inputs, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Live__Socket, clear_assigns, arginfo_vslim__live__socket_clear_assigns, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Live__Socket, assign_component_state, arginfo_vslim__live__socket_assign_component_state, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Live__Socket, component_state, arginfo_vslim__live__socket_component_state, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Live__Socket, component_state_or, arginfo_vslim__live__socket_component_state_or, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Live__Socket, clear_component_state, arginfo_vslim__live__socket_clear_component_state, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Live__Socket, assign_error, arginfo_vslim__live__socket_assign_error, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Live__Socket, assign_errors, arginfo_vslim__live__socket_assign_errors, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Live__Socket, clear_error, arginfo_vslim__live__socket_clear_error, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Live__Socket, clear_errors, arginfo_vslim__live__socket_clear_errors, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Live__Socket, input, arginfo_vslim__live__socket_input, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Live__Socket, input_or, arginfo_vslim__live__socket_input_or, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Live__Socket, old, arginfo_vslim__live__socket_old, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Live__Socket, old_or, arginfo_vslim__live__socket_old_or, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Live__Socket, error, arginfo_vslim__live__socket_error, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Live__Socket, has_error, arginfo_vslim__live__socket_has_error, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Live__Socket, form, arginfo_vslim__live__socket_form, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Live__Socket, get, arginfo_vslim__live__socket_get, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Live__Socket, has, arginfo_vslim__live__socket_has, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Live__Socket, assigns, arginfo_vslim__live__socket_assigns, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Live__Socket, patch, arginfo_vslim__live__socket_patch, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Live__Socket, append, arginfo_vslim__live__socket_append, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Live__Socket, prepend, arginfo_vslim__live__socket_prepend, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Live__Socket, set_text, arginfo_vslim__live__socket_set_text, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Live__Socket, set_attr, arginfo_vslim__live__socket_set_attr, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Live__Socket, remove, arginfo_vslim__live__socket_remove, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Live__Socket, patches, arginfo_vslim__live__socket_patches, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Live__Socket, clear_patches, arginfo_vslim__live__socket_clear_patches, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Live__Socket, push_event, arginfo_vslim__live__socket_push_event, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Live__Socket, events, arginfo_vslim__live__socket_events, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Live__Socket, clear_events, arginfo_vslim__live__socket_clear_events, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Live__Socket, flash, arginfo_vslim__live__socket_flash, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Live__Socket, flashes, arginfo_vslim__live__socket_flashes, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Live__Socket, clear_flashes, arginfo_vslim__live__socket_clear_flashes, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Live__Socket, join_topic, arginfo_vslim__live__socket_join_topic, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Live__Socket, leave_topic, arginfo_vslim__live__socket_leave_topic, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Live__Socket, broadcast_info, arginfo_vslim__live__socket_broadcast_info, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Live__Socket, pubsub_commands, arginfo_vslim__live__socket_pubsub_commands, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Live__Socket, clear_pubsub, arginfo_vslim__live__socket_clear_pubsub, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Live__Socket, redirect, arginfo_vslim__live__socket_redirect, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Live__Socket, redirect_to, arginfo_vslim__live__socket_redirect_to, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Live__Socket, clear_redirect, arginfo_vslim__live__socket_clear_redirect, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Live__Socket, navigate, arginfo_vslim__live__socket_navigate, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Live__Socket, navigate_to, arginfo_vslim__live__socket_navigate_to, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Live__Socket, clear_navigate, arginfo_vslim__live__socket_clear_navigate, ZEND_ACC_PUBLIC)
    PHP_FE_END
};

zend_class_entry *vslim__live__form_ce = NULL;
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__live__form___construct, 0, 0, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__live__form_name, 0, 0, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__live__form_available, 0, 0, _IS_BOOL, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__live__form_fill, 0, 0, 1)
ZEND_ARG_TYPE_INFO(0, values, IS_MIXED, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__live__form_reset, 0, 0, 1)
ZEND_ARG_TYPE_INFO(0, values, IS_MIXED, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__live__form_validate, 0, 0, 1)
ZEND_ARG_TYPE_INFO(0, validator, IS_MIXED, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__live__form_errors, 0, 0, 1)
ZEND_ARG_TYPE_INFO(0, values, IS_MIXED, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__live__form_clear_errors, 0, 0, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__live__form_clear_error, 0, 0, 1)
ZEND_ARG_TYPE_INFO(0, field, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__live__form_forget, 0, 0, 1)
ZEND_ARG_TYPE_INFO(0, field, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__live__form_forget_many, 0, 0, 1)
ZEND_ARG_TYPE_INFO(0, fields, IS_MIXED, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__live__form_input, 0, 1, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, field, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__live__form_input_or, 0, 2, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, field, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, fallback, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__live__form_error, 0, 1, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, field, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__live__form_has_error, 0, 1, _IS_BOOL, 0)
ZEND_ARG_TYPE_INFO(0, field, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__live__form_valid, 0, 0, _IS_BOOL, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__live__form_invalid, 0, 0, _IS_BOOL, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__live__form_error_count, 0, 0, IS_LONG, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__live__form_data, 0, 0, IS_MIXED, 0)
ZEND_END_ARG_INFO()
PHP_METHOD(VSlim__Live__Form, name) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimLiveForm_name(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!wrapper->v_ptr) RETURN_FALSE;
    vphp_wrap_VSlimLiveForm_name(wrapper->v_ptr, ctx);
}
PHP_METHOD(VSlim__Live__Form, available) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimLiveForm_available(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!wrapper->v_ptr) RETURN_FALSE;
    vphp_wrap_VSlimLiveForm_available(wrapper->v_ptr, ctx);
}

PHP_METHOD(VSlim__Live__Form, fill) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimLiveForm_fill(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__Live__Form::fill called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimLiveForm_fill(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__live__form_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimLiveForm_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimLiveForm_handlers(), 0);
    }
}


PHP_METHOD(VSlim__Live__Form, reset) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimLiveForm_reset(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__Live__Form::reset called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimLiveForm_reset(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__live__form_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimLiveForm_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimLiveForm_handlers(), 0);
    }
}


PHP_METHOD(VSlim__Live__Form, validate) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimLiveForm_validate(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__Live__Form::validate called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimLiveForm_validate(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__live__form_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimLiveForm_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimLiveForm_handlers(), 0);
    }
}


PHP_METHOD(VSlim__Live__Form, errors) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimLiveForm_errors(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__Live__Form::errors called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimLiveForm_errors(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__live__form_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimLiveForm_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimLiveForm_handlers(), 0);
    }
}


PHP_METHOD(VSlim__Live__Form, clear_errors) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimLiveForm_clear_errors(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__Live__Form::clear_errors called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimLiveForm_clear_errors(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__live__form_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimLiveForm_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimLiveForm_handlers(), 0);
    }
}


PHP_METHOD(VSlim__Live__Form, clear_error) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimLiveForm_clear_error(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__Live__Form::clear_error called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimLiveForm_clear_error(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__live__form_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimLiveForm_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimLiveForm_handlers(), 0);
    }
}


PHP_METHOD(VSlim__Live__Form, forget) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimLiveForm_forget(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__Live__Form::forget called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimLiveForm_forget(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__live__form_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimLiveForm_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimLiveForm_handlers(), 0);
    }
}


PHP_METHOD(VSlim__Live__Form, forget_many) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimLiveForm_forget_many(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__Live__Form::forget_many called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimLiveForm_forget_many(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__live__form_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimLiveForm_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimLiveForm_handlers(), 0);
    }
}

PHP_METHOD(VSlim__Live__Form, input) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimLiveForm_input(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!wrapper->v_ptr) RETURN_FALSE;
    vphp_wrap_VSlimLiveForm_input(wrapper->v_ptr, ctx);
}
PHP_METHOD(VSlim__Live__Form, input_or) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimLiveForm_input_or(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!wrapper->v_ptr) RETURN_FALSE;
    vphp_wrap_VSlimLiveForm_input_or(wrapper->v_ptr, ctx);
}
PHP_METHOD(VSlim__Live__Form, error) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimLiveForm_error(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!wrapper->v_ptr) RETURN_FALSE;
    vphp_wrap_VSlimLiveForm_error(wrapper->v_ptr, ctx);
}
PHP_METHOD(VSlim__Live__Form, has_error) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimLiveForm_has_error(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!wrapper->v_ptr) RETURN_FALSE;
    vphp_wrap_VSlimLiveForm_has_error(wrapper->v_ptr, ctx);
}
PHP_METHOD(VSlim__Live__Form, valid) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimLiveForm_valid(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!wrapper->v_ptr) RETURN_FALSE;
    vphp_wrap_VSlimLiveForm_valid(wrapper->v_ptr, ctx);
}
PHP_METHOD(VSlim__Live__Form, invalid) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimLiveForm_invalid(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!wrapper->v_ptr) RETURN_FALSE;
    vphp_wrap_VSlimLiveForm_invalid(wrapper->v_ptr, ctx);
}
PHP_METHOD(VSlim__Live__Form, error_count) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimLiveForm_error_count(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!wrapper->v_ptr) RETURN_FALSE;
    vphp_wrap_VSlimLiveForm_error_count(wrapper->v_ptr, ctx);
}
PHP_METHOD(VSlim__Live__Form, data) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimLiveForm_data(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!wrapper->v_ptr) RETURN_FALSE;
    vphp_wrap_VSlimLiveForm_data(wrapper->v_ptr, ctx);
}

PHP_METHOD(VSlim__Live__Form, __construct) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern vphp_class_handlers* VSlimLiveForm_handlers();
    vphp_class_handlers *h = VSlimLiveForm_handlers();
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    wrapper->v_ptr = h->new_raw();
    vphp_register_object(wrapper->v_ptr, Z_OBJ_P(getThis()));
    vphp_bind_handlers_with_ownership(Z_OBJ_P(getThis()), h, 1);
}

static const zend_function_entry vslim__live__form_methods[] = {
    PHP_ME(VSlim__Live__Form, __construct, arginfo_vslim__live__form___construct, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Live__Form, name, arginfo_vslim__live__form_name, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Live__Form, available, arginfo_vslim__live__form_available, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Live__Form, fill, arginfo_vslim__live__form_fill, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Live__Form, reset, arginfo_vslim__live__form_reset, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Live__Form, validate, arginfo_vslim__live__form_validate, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Live__Form, errors, arginfo_vslim__live__form_errors, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Live__Form, clear_errors, arginfo_vslim__live__form_clear_errors, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Live__Form, clear_error, arginfo_vslim__live__form_clear_error, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Live__Form, forget, arginfo_vslim__live__form_forget, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Live__Form, forget_many, arginfo_vslim__live__form_forget_many, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Live__Form, input, arginfo_vslim__live__form_input, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Live__Form, input_or, arginfo_vslim__live__form_input_or, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Live__Form, error, arginfo_vslim__live__form_error, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Live__Form, has_error, arginfo_vslim__live__form_has_error, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Live__Form, valid, arginfo_vslim__live__form_valid, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Live__Form, invalid, arginfo_vslim__live__form_invalid, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Live__Form, error_count, arginfo_vslim__live__form_error_count, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Live__Form, data, arginfo_vslim__live__form_data, ZEND_ACC_PUBLIC)
    PHP_FE_END
};

zend_class_entry *vslim__live__view_ce = NULL;
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__live__view_construct, 0, 0, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__live__view_set_app, 0, 0, 1)
ZEND_ARG_INFO(0, app)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__live__view_set_view, 0, 0, 1)
ZEND_ARG_INFO(0, view)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__live__view_view, 0, 0, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__live__view_set_template, 0, 0, 1)
ZEND_ARG_TYPE_INFO(0, template, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__live__view_template, 0, 0, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__live__view_set_layout, 0, 0, 1)
ZEND_ARG_TYPE_INFO(0, layout, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__live__view_layout, 0, 0, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__live__view_set_root_id, 0, 0, 1)
ZEND_ARG_TYPE_INFO(0, root_id, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__live__view_root_id, 0, 0, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__live__view_live_marker, 0, 0, _IS_BOOL, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__live__view_attr_prefix, 0, 0, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__live__view_attr_name, 0, 1, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, name, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__live__view_runtime_asset, 0, 0, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__live__view_runtime_script_tag, 0, 0, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__live__view_bootstrap_attrs, 0, 2, IS_STRING, 0)
ZEND_ARG_INFO(0, socket)
ZEND_ARG_TYPE_INFO(0, endpoint, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__live__view_render_template, 0, 2, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, template, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, data, IS_MIXED, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__live__view_render_template_with_layout, 0, 3, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, template, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, layout, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, data, IS_MIXED, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__live__view_render_socket, 0, 2, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, template, IS_STRING, 0)
ZEND_ARG_INFO(0, socket)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__live__view_render_socket_with_layout, 0, 3, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, template, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, layout, IS_STRING, 0)
ZEND_ARG_INFO(0, socket)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__live__view_html, 0, 1, IS_STRING, 0)
ZEND_ARG_INFO(0, socket)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__live__view_response, 0, 0, 1)
ZEND_ARG_INFO(0, socket)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__live__view_patch, 0, 0, 2)
ZEND_ARG_INFO(0, socket)
ZEND_ARG_TYPE_INFO(0, target_id, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__live__view_patch_template, 0, 0, 3)
ZEND_ARG_INFO(0, socket)
ZEND_ARG_TYPE_INFO(0, target_id, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, template, IS_STRING, 0)
ZEND_END_ARG_INFO()
PHP_METHOD(VSlim__Live__View, __construct) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern vphp_class_handlers* VSlimLiveView_handlers();
    vphp_class_handlers *h = VSlimLiveView_handlers();
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    wrapper->v_ptr = h->new_raw();
    vphp_register_object(wrapper->v_ptr, Z_OBJ_P(getThis()));
    vphp_bind_handlers_with_ownership(Z_OBJ_P(getThis()), h, 1);
    extern void vphp_wrap_VSlimLiveView_construct(void* v_ptr, vphp_context_internal ctx);
    void* v_ptr = wrapper->v_ptr;
    vphp_wrap_VSlimLiveView_construct(v_ptr, ctx);
}

PHP_METHOD(VSlim__Live__View, set_app) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimLiveView_set_app(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__Live__View::set_app called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimLiveView_set_app(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__live__view_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimLiveView_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimLiveView_handlers(), 0);
    }
}


PHP_METHOD(VSlim__Live__View, set_view) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimLiveView_set_view(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__Live__View::set_view called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimLiveView_set_view(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__live__view_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimLiveView_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimLiveView_handlers(), 0);
    }
}


PHP_METHOD(VSlim__Live__View, view) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimLiveView_view(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__Live__View::view called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimLiveView_view(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__view_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimView_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimView_handlers(), 0);
    }
}


PHP_METHOD(VSlim__Live__View, set_template) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimLiveView_set_template(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__Live__View::set_template called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimLiveView_set_template(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__live__view_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimLiveView_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimLiveView_handlers(), 0);
    }
}

PHP_METHOD(VSlim__Live__View, template) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimLiveView_template(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!wrapper->v_ptr) RETURN_FALSE;
    vphp_wrap_VSlimLiveView_template(wrapper->v_ptr, ctx);
}

PHP_METHOD(VSlim__Live__View, set_layout) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimLiveView_set_layout(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__Live__View::set_layout called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimLiveView_set_layout(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__live__view_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimLiveView_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimLiveView_handlers(), 0);
    }
}

PHP_METHOD(VSlim__Live__View, layout) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimLiveView_layout(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!wrapper->v_ptr) RETURN_FALSE;
    vphp_wrap_VSlimLiveView_layout(wrapper->v_ptr, ctx);
}

PHP_METHOD(VSlim__Live__View, set_root_id) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimLiveView_set_root_id(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__Live__View::set_root_id called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimLiveView_set_root_id(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__live__view_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimLiveView_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimLiveView_handlers(), 0);
    }
}

PHP_METHOD(VSlim__Live__View, root_id) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimLiveView_root_id(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!wrapper->v_ptr) RETURN_FALSE;
    vphp_wrap_VSlimLiveView_root_id(wrapper->v_ptr, ctx);
}
PHP_METHOD(VSlim__Live__View, live_marker) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimLiveView_live_marker(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!wrapper->v_ptr) RETURN_FALSE;
    vphp_wrap_VSlimLiveView_live_marker(wrapper->v_ptr, ctx);
}
PHP_METHOD(VSlim__Live__View, attr_prefix) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimLiveView_attr_prefix(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!wrapper->v_ptr) RETURN_FALSE;
    vphp_wrap_VSlimLiveView_attr_prefix(wrapper->v_ptr, ctx);
}
PHP_METHOD(VSlim__Live__View, attr_name) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimLiveView_attr_name(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!wrapper->v_ptr) RETURN_FALSE;
    vphp_wrap_VSlimLiveView_attr_name(wrapper->v_ptr, ctx);
}
PHP_METHOD(VSlim__Live__View, runtime_asset) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimLiveView_runtime_asset(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!wrapper->v_ptr) RETURN_FALSE;
    vphp_wrap_VSlimLiveView_runtime_asset(wrapper->v_ptr, ctx);
}
PHP_METHOD(VSlim__Live__View, runtime_script_tag) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimLiveView_runtime_script_tag(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!wrapper->v_ptr) RETURN_FALSE;
    vphp_wrap_VSlimLiveView_runtime_script_tag(wrapper->v_ptr, ctx);
}
PHP_METHOD(VSlim__Live__View, bootstrap_attrs) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimLiveView_bootstrap_attrs(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!wrapper->v_ptr) RETURN_FALSE;
    vphp_wrap_VSlimLiveView_bootstrap_attrs(wrapper->v_ptr, ctx);
}
PHP_METHOD(VSlim__Live__View, render_template) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimLiveView_render_template(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!wrapper->v_ptr) RETURN_FALSE;
    vphp_wrap_VSlimLiveView_render_template(wrapper->v_ptr, ctx);
}
PHP_METHOD(VSlim__Live__View, render_template_with_layout) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimLiveView_render_template_with_layout(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!wrapper->v_ptr) RETURN_FALSE;
    vphp_wrap_VSlimLiveView_render_template_with_layout(wrapper->v_ptr, ctx);
}
PHP_METHOD(VSlim__Live__View, render_socket) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimLiveView_render_socket(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!wrapper->v_ptr) RETURN_FALSE;
    vphp_wrap_VSlimLiveView_render_socket(wrapper->v_ptr, ctx);
}
PHP_METHOD(VSlim__Live__View, render_socket_with_layout) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimLiveView_render_socket_with_layout(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!wrapper->v_ptr) RETURN_FALSE;
    vphp_wrap_VSlimLiveView_render_socket_with_layout(wrapper->v_ptr, ctx);
}
PHP_METHOD(VSlim__Live__View, html) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimLiveView_html(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!wrapper->v_ptr) RETURN_FALSE;
    vphp_wrap_VSlimLiveView_html(wrapper->v_ptr, ctx);
}

PHP_METHOD(VSlim__Live__View, response) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimLiveView_response(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__Live__View::response called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimLiveView_response(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__response_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimResponse_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimResponse_handlers(), 0);
    }
}


PHP_METHOD(VSlim__Live__View, patch) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimLiveView_patch(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__Live__View::patch called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimLiveView_patch(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__live__socket_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimLiveSocket_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimLiveSocket_handlers(), 0);
    }
}


PHP_METHOD(VSlim__Live__View, patch_template) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimLiveView_patch_template(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__Live__View::patch_template called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimLiveView_patch_template(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__live__socket_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimLiveSocket_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimLiveSocket_handlers(), 0);
    }
}

static const zend_function_entry vslim__live__view_methods[] = {
    PHP_ME(VSlim__Live__View, __construct, arginfo_vslim__live__view_construct, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Live__View, set_app, arginfo_vslim__live__view_set_app, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Live__View, set_view, arginfo_vslim__live__view_set_view, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Live__View, view, arginfo_vslim__live__view_view, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Live__View, set_template, arginfo_vslim__live__view_set_template, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Live__View, template, arginfo_vslim__live__view_template, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Live__View, set_layout, arginfo_vslim__live__view_set_layout, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Live__View, layout, arginfo_vslim__live__view_layout, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Live__View, set_root_id, arginfo_vslim__live__view_set_root_id, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Live__View, root_id, arginfo_vslim__live__view_root_id, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Live__View, live_marker, arginfo_vslim__live__view_live_marker, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Live__View, attr_prefix, arginfo_vslim__live__view_attr_prefix, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Live__View, attr_name, arginfo_vslim__live__view_attr_name, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Live__View, runtime_asset, arginfo_vslim__live__view_runtime_asset, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Live__View, runtime_script_tag, arginfo_vslim__live__view_runtime_script_tag, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Live__View, bootstrap_attrs, arginfo_vslim__live__view_bootstrap_attrs, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Live__View, render_template, arginfo_vslim__live__view_render_template, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Live__View, render_template_with_layout, arginfo_vslim__live__view_render_template_with_layout, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Live__View, render_socket, arginfo_vslim__live__view_render_socket, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Live__View, render_socket_with_layout, arginfo_vslim__live__view_render_socket_with_layout, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Live__View, html, arginfo_vslim__live__view_html, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Live__View, response, arginfo_vslim__live__view_response, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Live__View, patch, arginfo_vslim__live__view_patch, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Live__View, patch_template, arginfo_vslim__live__view_patch_template, ZEND_ACC_PUBLIC)
    PHP_FE_END
};

zend_class_entry *vslim__live__component_ce = NULL;
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__live__component_construct, 0, 0, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__live__component_set_app, 0, 0, 1)
ZEND_ARG_INFO(0, app)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__live__component_set_view, 0, 0, 1)
ZEND_ARG_INFO(0, view)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__live__component_view, 0, 0, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__live__component_set_template, 0, 0, 1)
ZEND_ARG_TYPE_INFO(0, template, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__live__component_template, 0, 0, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__live__component_set_layout, 0, 0, 1)
ZEND_ARG_TYPE_INFO(0, layout, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__live__component_layout, 0, 0, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__live__component_set_id, 0, 0, 1)
ZEND_ARG_TYPE_INFO(0, id, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__live__component_id, 0, 0, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__live__component_bind_socket, 0, 0, 1)
ZEND_ARG_INFO(0, socket)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__live__component_has_socket, 0, 0, _IS_BOOL, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__live__component_state, 0, 0, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__live__component_assign, 0, 0, 2)
ZEND_ARG_TYPE_INFO(0, key, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, value, IS_MIXED, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__live__component_assign_many, 0, 0, 1)
ZEND_ARG_TYPE_INFO(0, values, IS_MIXED, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__live__component_assigns, 0, 0, IS_ARRAY, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__live__component_clear_assigns, 0, 0, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__live__component_render_template, 0, 2, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, template, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, data, IS_MIXED, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__live__component_html, 0, 0, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__live__component_patch, 0, 0, 1)
ZEND_ARG_INFO(0, socket)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__live__component_patch_bound, 0, 0, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__live__component_component_marker, 0, 0, _IS_BOOL, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__live__component_append_to, 0, 0, 2)
ZEND_ARG_INFO(0, socket)
ZEND_ARG_TYPE_INFO(0, target_id, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__live__component_append_to_bound, 0, 0, 1)
ZEND_ARG_TYPE_INFO(0, target_id, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__live__component_prepend_to, 0, 0, 2)
ZEND_ARG_INFO(0, socket)
ZEND_ARG_TYPE_INFO(0, target_id, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__live__component_prepend_to_bound, 0, 0, 1)
ZEND_ARG_TYPE_INFO(0, target_id, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__live__component_remove, 0, 0, 1)
ZEND_ARG_INFO(0, socket)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__live__component_remove_bound, 0, 0, 0)
ZEND_END_ARG_INFO()
PHP_METHOD(VSlim__Live__Component, __construct) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern vphp_class_handlers* VSlimLiveComponent_handlers();
    vphp_class_handlers *h = VSlimLiveComponent_handlers();
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    wrapper->v_ptr = h->new_raw();
    vphp_register_object(wrapper->v_ptr, Z_OBJ_P(getThis()));
    vphp_bind_handlers_with_ownership(Z_OBJ_P(getThis()), h, 1);
    extern void vphp_wrap_VSlimLiveComponent_construct(void* v_ptr, vphp_context_internal ctx);
    void* v_ptr = wrapper->v_ptr;
    vphp_wrap_VSlimLiveComponent_construct(v_ptr, ctx);
}

PHP_METHOD(VSlim__Live__Component, set_app) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimLiveComponent_set_app(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__Live__Component::set_app called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimLiveComponent_set_app(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__live__component_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimLiveComponent_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimLiveComponent_handlers(), 0);
    }
}


PHP_METHOD(VSlim__Live__Component, set_view) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimLiveComponent_set_view(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__Live__Component::set_view called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimLiveComponent_set_view(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__live__component_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimLiveComponent_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimLiveComponent_handlers(), 0);
    }
}


PHP_METHOD(VSlim__Live__Component, view) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimLiveComponent_view(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__Live__Component::view called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimLiveComponent_view(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__view_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimView_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimView_handlers(), 0);
    }
}


PHP_METHOD(VSlim__Live__Component, set_template) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimLiveComponent_set_template(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__Live__Component::set_template called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimLiveComponent_set_template(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__live__component_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimLiveComponent_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimLiveComponent_handlers(), 0);
    }
}

PHP_METHOD(VSlim__Live__Component, template) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimLiveComponent_template(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!wrapper->v_ptr) RETURN_FALSE;
    vphp_wrap_VSlimLiveComponent_template(wrapper->v_ptr, ctx);
}

PHP_METHOD(VSlim__Live__Component, set_layout) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimLiveComponent_set_layout(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__Live__Component::set_layout called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimLiveComponent_set_layout(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__live__component_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimLiveComponent_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimLiveComponent_handlers(), 0);
    }
}

PHP_METHOD(VSlim__Live__Component, layout) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimLiveComponent_layout(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!wrapper->v_ptr) RETURN_FALSE;
    vphp_wrap_VSlimLiveComponent_layout(wrapper->v_ptr, ctx);
}

PHP_METHOD(VSlim__Live__Component, set_id) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimLiveComponent_set_id(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__Live__Component::set_id called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimLiveComponent_set_id(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__live__component_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimLiveComponent_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimLiveComponent_handlers(), 0);
    }
}

PHP_METHOD(VSlim__Live__Component, id) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimLiveComponent_id(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!wrapper->v_ptr) RETURN_FALSE;
    vphp_wrap_VSlimLiveComponent_id(wrapper->v_ptr, ctx);
}

PHP_METHOD(VSlim__Live__Component, bind_socket) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimLiveComponent_bind_socket(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__Live__Component::bind_socket called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimLiveComponent_bind_socket(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__live__component_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimLiveComponent_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimLiveComponent_handlers(), 0);
    }
}

PHP_METHOD(VSlim__Live__Component, has_socket) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimLiveComponent_has_socket(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!wrapper->v_ptr) RETURN_FALSE;
    vphp_wrap_VSlimLiveComponent_has_socket(wrapper->v_ptr, ctx);
}

PHP_METHOD(VSlim__Live__Component, state) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimLiveComponent_state(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__Live__Component::state called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimLiveComponent_state(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__live__componentstate_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimLiveComponentState_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimLiveComponentState_handlers(), 0);
    }
}


PHP_METHOD(VSlim__Live__Component, assign) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimLiveComponent_assign(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__Live__Component::assign called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimLiveComponent_assign(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__live__component_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimLiveComponent_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimLiveComponent_handlers(), 0);
    }
}


PHP_METHOD(VSlim__Live__Component, assign_many) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimLiveComponent_assign_many(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__Live__Component::assign_many called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimLiveComponent_assign_many(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__live__component_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimLiveComponent_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimLiveComponent_handlers(), 0);
    }
}

PHP_METHOD(VSlim__Live__Component, assigns) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimLiveComponent_assigns(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!wrapper->v_ptr) RETURN_FALSE;
    vphp_wrap_VSlimLiveComponent_assigns(wrapper->v_ptr, ctx);
}

PHP_METHOD(VSlim__Live__Component, clear_assigns) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimLiveComponent_clear_assigns(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__Live__Component::clear_assigns called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimLiveComponent_clear_assigns(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__live__component_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimLiveComponent_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimLiveComponent_handlers(), 0);
    }
}

PHP_METHOD(VSlim__Live__Component, render_template) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimLiveComponent_render_template(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!wrapper->v_ptr) RETURN_FALSE;
    vphp_wrap_VSlimLiveComponent_render_template(wrapper->v_ptr, ctx);
}
PHP_METHOD(VSlim__Live__Component, html) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimLiveComponent_html(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!wrapper->v_ptr) RETURN_FALSE;
    vphp_wrap_VSlimLiveComponent_html(wrapper->v_ptr, ctx);
}

PHP_METHOD(VSlim__Live__Component, patch) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimLiveComponent_patch(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__Live__Component::patch called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimLiveComponent_patch(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__live__socket_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimLiveSocket_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimLiveSocket_handlers(), 0);
    }
}


PHP_METHOD(VSlim__Live__Component, patch_bound) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimLiveComponent_patch_bound(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__Live__Component::patch_bound called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimLiveComponent_patch_bound(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__live__socket_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimLiveSocket_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimLiveSocket_handlers(), 0);
    }
}

PHP_METHOD(VSlim__Live__Component, component_marker) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimLiveComponent_component_marker(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!wrapper->v_ptr) RETURN_FALSE;
    vphp_wrap_VSlimLiveComponent_component_marker(wrapper->v_ptr, ctx);
}

PHP_METHOD(VSlim__Live__Component, append_to) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimLiveComponent_append_to(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__Live__Component::append_to called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimLiveComponent_append_to(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__live__socket_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimLiveSocket_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimLiveSocket_handlers(), 0);
    }
}


PHP_METHOD(VSlim__Live__Component, append_to_bound) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimLiveComponent_append_to_bound(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__Live__Component::append_to_bound called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimLiveComponent_append_to_bound(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__live__socket_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimLiveSocket_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimLiveSocket_handlers(), 0);
    }
}


PHP_METHOD(VSlim__Live__Component, prepend_to) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimLiveComponent_prepend_to(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__Live__Component::prepend_to called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimLiveComponent_prepend_to(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__live__socket_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimLiveSocket_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimLiveSocket_handlers(), 0);
    }
}


PHP_METHOD(VSlim__Live__Component, prepend_to_bound) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimLiveComponent_prepend_to_bound(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__Live__Component::prepend_to_bound called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimLiveComponent_prepend_to_bound(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__live__socket_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimLiveSocket_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimLiveSocket_handlers(), 0);
    }
}


PHP_METHOD(VSlim__Live__Component, remove) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimLiveComponent_remove(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__Live__Component::remove called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimLiveComponent_remove(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__live__socket_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimLiveSocket_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimLiveSocket_handlers(), 0);
    }
}


PHP_METHOD(VSlim__Live__Component, remove_bound) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimLiveComponent_remove_bound(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__Live__Component::remove_bound called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimLiveComponent_remove_bound(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__live__socket_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimLiveSocket_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimLiveSocket_handlers(), 0);
    }
}

static const zend_function_entry vslim__live__component_methods[] = {
    PHP_ME(VSlim__Live__Component, __construct, arginfo_vslim__live__component_construct, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Live__Component, set_app, arginfo_vslim__live__component_set_app, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Live__Component, set_view, arginfo_vslim__live__component_set_view, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Live__Component, view, arginfo_vslim__live__component_view, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Live__Component, set_template, arginfo_vslim__live__component_set_template, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Live__Component, template, arginfo_vslim__live__component_template, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Live__Component, set_layout, arginfo_vslim__live__component_set_layout, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Live__Component, layout, arginfo_vslim__live__component_layout, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Live__Component, set_id, arginfo_vslim__live__component_set_id, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Live__Component, id, arginfo_vslim__live__component_id, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Live__Component, bind_socket, arginfo_vslim__live__component_bind_socket, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Live__Component, has_socket, arginfo_vslim__live__component_has_socket, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Live__Component, state, arginfo_vslim__live__component_state, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Live__Component, assign, arginfo_vslim__live__component_assign, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Live__Component, assign_many, arginfo_vslim__live__component_assign_many, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Live__Component, assigns, arginfo_vslim__live__component_assigns, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Live__Component, clear_assigns, arginfo_vslim__live__component_clear_assigns, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Live__Component, render_template, arginfo_vslim__live__component_render_template, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Live__Component, html, arginfo_vslim__live__component_html, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Live__Component, patch, arginfo_vslim__live__component_patch, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Live__Component, patch_bound, arginfo_vslim__live__component_patch_bound, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Live__Component, component_marker, arginfo_vslim__live__component_component_marker, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Live__Component, append_to, arginfo_vslim__live__component_append_to, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Live__Component, append_to_bound, arginfo_vslim__live__component_append_to_bound, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Live__Component, prepend_to, arginfo_vslim__live__component_prepend_to, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Live__Component, prepend_to_bound, arginfo_vslim__live__component_prepend_to_bound, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Live__Component, remove, arginfo_vslim__live__component_remove, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Live__Component, remove_bound, arginfo_vslim__live__component_remove_bound, ZEND_ACC_PUBLIC)
    PHP_FE_END
};

zend_class_entry *vslim__live__componentstate_ce = NULL;
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__live__componentstate___construct, 0, 0, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__live__componentstate_set, 0, 0, 2)
ZEND_ARG_TYPE_INFO(0, field, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, value, IS_MIXED, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__live__componentstate_get, 0, 1, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, field, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__live__componentstate_get_or, 0, 2, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, field, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, fallback, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__live__componentstate_clear, 0, 0, 1)
ZEND_ARG_TYPE_INFO(0, field, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__live__componentstate_available, 0, 0, _IS_BOOL, 0)
ZEND_END_ARG_INFO()

PHP_METHOD(VSlim__Live__ComponentState, set) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimLiveComponentState_set(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__Live__ComponentState::set called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimLiveComponentState_set(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__live__componentstate_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimLiveComponentState_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimLiveComponentState_handlers(), 0);
    }
}

PHP_METHOD(VSlim__Live__ComponentState, get) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimLiveComponentState_get(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!wrapper->v_ptr) RETURN_FALSE;
    vphp_wrap_VSlimLiveComponentState_get(wrapper->v_ptr, ctx);
}
PHP_METHOD(VSlim__Live__ComponentState, get_or) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimLiveComponentState_get_or(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!wrapper->v_ptr) RETURN_FALSE;
    vphp_wrap_VSlimLiveComponentState_get_or(wrapper->v_ptr, ctx);
}

PHP_METHOD(VSlim__Live__ComponentState, clear) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimLiveComponentState_clear(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__Live__ComponentState::clear called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimLiveComponentState_clear(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__live__componentstate_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimLiveComponentState_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimLiveComponentState_handlers(), 0);
    }
}

PHP_METHOD(VSlim__Live__ComponentState, available) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimLiveComponentState_available(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!wrapper->v_ptr) RETURN_FALSE;
    vphp_wrap_VSlimLiveComponentState_available(wrapper->v_ptr, ctx);
}

PHP_METHOD(VSlim__Live__ComponentState, __construct) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern vphp_class_handlers* VSlimLiveComponentState_handlers();
    vphp_class_handlers *h = VSlimLiveComponentState_handlers();
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    wrapper->v_ptr = h->new_raw();
    vphp_register_object(wrapper->v_ptr, Z_OBJ_P(getThis()));
    vphp_bind_handlers_with_ownership(Z_OBJ_P(getThis()), h, 1);
}

static const zend_function_entry vslim__live__componentstate_methods[] = {
    PHP_ME(VSlim__Live__ComponentState, __construct, arginfo_vslim__live__componentstate___construct, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Live__ComponentState, set, arginfo_vslim__live__componentstate_set, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Live__ComponentState, get, arginfo_vslim__live__componentstate_get, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Live__ComponentState, get_or, arginfo_vslim__live__componentstate_get_or, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Live__ComponentState, clear, arginfo_vslim__live__componentstate_clear, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Live__ComponentState, available, arginfo_vslim__live__componentstate_available, ZEND_ACC_PUBLIC)
    PHP_FE_END
};

zend_class_entry *vslim__config_ce = NULL;
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__config_construct, 0, 0, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__config_load, 0, 0, 1)
ZEND_ARG_TYPE_INFO(0, path, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__config_load_text, 0, 0, 1)
ZEND_ARG_TYPE_INFO(0, text, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__config_is_loaded, 0, 0, _IS_BOOL, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__config_path, 0, 0, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__config_has, 0, 1, _IS_BOOL, 0)
ZEND_ARG_TYPE_INFO(0, key, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__config_get_string, 0, 2, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, key, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, default_value, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__config_get_int, 0, 2, IS_LONG, 0)
ZEND_ARG_TYPE_INFO(0, key, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, default_value, IS_LONG, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__config_get_bool, 0, 2, _IS_BOOL, 0)
ZEND_ARG_TYPE_INFO(0, key, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, default_value, _IS_BOOL, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__config_get_float, 0, 2, IS_DOUBLE, 0)
ZEND_ARG_TYPE_INFO(0, key, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, default_value, IS_DOUBLE, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__config_get_string_list, 0, 1, IS_ARRAY, 0)
ZEND_ARG_TYPE_INFO(0, key, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__config_get_json, 0, 2, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, key, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, default_json, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__config_get, 0, 1, IS_MIXED, 0)
ZEND_ARG_TYPE_INFO(0, key, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, default_value, IS_MIXED, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__config_get_map, 0, 1, IS_MIXED, 0)
ZEND_ARG_TYPE_INFO(0, key, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, default_value, IS_MIXED, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__config_get_list, 0, 1, IS_MIXED, 0)
ZEND_ARG_TYPE_INFO(0, key, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, default_value, IS_MIXED, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__config_all_json, 0, 0, IS_STRING, 0)
ZEND_END_ARG_INFO()
PHP_METHOD(VSlim__Config, __construct) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern vphp_class_handlers* VSlimConfig_handlers();
    vphp_class_handlers *h = VSlimConfig_handlers();
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    wrapper->v_ptr = h->new_raw();
    vphp_register_object(wrapper->v_ptr, Z_OBJ_P(getThis()));
    vphp_bind_handlers_with_ownership(Z_OBJ_P(getThis()), h, 1);
    extern void vphp_wrap_VSlimConfig_construct(void* v_ptr, vphp_context_internal ctx);
    void* v_ptr = wrapper->v_ptr;
    vphp_wrap_VSlimConfig_construct(v_ptr, ctx);
}

PHP_METHOD(VSlim__Config, load) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimConfig_load(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__Config::load called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimConfig_load(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__config_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimConfig_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimConfig_handlers(), 0);
    }
}


PHP_METHOD(VSlim__Config, load_text) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimConfig_load_text(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__Config::load_text called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimConfig_load_text(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__config_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimConfig_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimConfig_handlers(), 0);
    }
}

PHP_METHOD(VSlim__Config, is_loaded) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimConfig_is_loaded(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!wrapper->v_ptr) RETURN_FALSE;
    vphp_wrap_VSlimConfig_is_loaded(wrapper->v_ptr, ctx);
}
PHP_METHOD(VSlim__Config, path) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimConfig_path(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!wrapper->v_ptr) RETURN_FALSE;
    vphp_wrap_VSlimConfig_path(wrapper->v_ptr, ctx);
}
PHP_METHOD(VSlim__Config, has) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimConfig_has(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!wrapper->v_ptr) RETURN_FALSE;
    vphp_wrap_VSlimConfig_has(wrapper->v_ptr, ctx);
}
PHP_METHOD(VSlim__Config, get_string) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimConfig_get_string(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!wrapper->v_ptr) RETURN_FALSE;
    vphp_wrap_VSlimConfig_get_string(wrapper->v_ptr, ctx);
}
PHP_METHOD(VSlim__Config, get_int) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimConfig_get_int(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!wrapper->v_ptr) RETURN_FALSE;
    vphp_wrap_VSlimConfig_get_int(wrapper->v_ptr, ctx);
}
PHP_METHOD(VSlim__Config, get_bool) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimConfig_get_bool(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!wrapper->v_ptr) RETURN_FALSE;
    vphp_wrap_VSlimConfig_get_bool(wrapper->v_ptr, ctx);
}
PHP_METHOD(VSlim__Config, get_float) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimConfig_get_float(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!wrapper->v_ptr) RETURN_FALSE;
    vphp_wrap_VSlimConfig_get_float(wrapper->v_ptr, ctx);
}
PHP_METHOD(VSlim__Config, get_string_list) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimConfig_get_string_list(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!wrapper->v_ptr) RETURN_FALSE;
    vphp_wrap_VSlimConfig_get_string_list(wrapper->v_ptr, ctx);
}
PHP_METHOD(VSlim__Config, get_json) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimConfig_get_json(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!wrapper->v_ptr) RETURN_FALSE;
    vphp_wrap_VSlimConfig_get_json(wrapper->v_ptr, ctx);
}
PHP_METHOD(VSlim__Config, get) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimConfig_get(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!wrapper->v_ptr) RETURN_FALSE;
    vphp_wrap_VSlimConfig_get(wrapper->v_ptr, ctx);
}
PHP_METHOD(VSlim__Config, get_map) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimConfig_get_map(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!wrapper->v_ptr) RETURN_FALSE;
    vphp_wrap_VSlimConfig_get_map(wrapper->v_ptr, ctx);
}
PHP_METHOD(VSlim__Config, get_list) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimConfig_get_list(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!wrapper->v_ptr) RETURN_FALSE;
    vphp_wrap_VSlimConfig_get_list(wrapper->v_ptr, ctx);
}
PHP_METHOD(VSlim__Config, all_json) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimConfig_all_json(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!wrapper->v_ptr) RETURN_FALSE;
    vphp_wrap_VSlimConfig_all_json(wrapper->v_ptr, ctx);
}
static const zend_function_entry vslim__config_methods[] = {
    PHP_ME(VSlim__Config, __construct, arginfo_vslim__config_construct, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Config, load, arginfo_vslim__config_load, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Config, load_text, arginfo_vslim__config_load_text, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Config, is_loaded, arginfo_vslim__config_is_loaded, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Config, path, arginfo_vslim__config_path, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Config, has, arginfo_vslim__config_has, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Config, get_string, arginfo_vslim__config_get_string, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Config, get_int, arginfo_vslim__config_get_int, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Config, get_bool, arginfo_vslim__config_get_bool, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Config, get_float, arginfo_vslim__config_get_float, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Config, get_string_list, arginfo_vslim__config_get_string_list, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Config, get_json, arginfo_vslim__config_get_json, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Config, get, arginfo_vslim__config_get, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Config, get_map, arginfo_vslim__config_get_map, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Config, get_list, arginfo_vslim__config_get_list, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Config, all_json, arginfo_vslim__config_all_json, ZEND_ACC_PUBLIC)
    PHP_FE_END
};

zend_class_entry *vslim__container__containerexception_ce = NULL;

static const zend_function_entry vslim__container__containerexception_methods[] = {
    PHP_FE_END
};

zend_class_entry *vslim__container__notfoundexception_ce = NULL;

static const zend_function_entry vslim__container__notfoundexception_methods[] = {
    PHP_FE_END
};

zend_class_entry *vslim__container_ce = NULL;
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__container_construct, 0, 0, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__container_set, 0, 0, 2)
ZEND_ARG_TYPE_INFO(0, id, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, value, IS_MIXED, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vslim__container_factory, 0, 0, 2)
ZEND_ARG_TYPE_INFO(0, id, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, callable, IS_MIXED, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__container_has, 0, 1, _IS_BOOL, 0)
ZEND_ARG_TYPE_INFO(0, id, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vslim__container_get, 0, 1, IS_VOID, 0)
ZEND_ARG_TYPE_INFO(0, id, IS_STRING, 0)
ZEND_END_ARG_INFO()
PHP_METHOD(VSlim__Container, __construct) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern vphp_class_handlers* VSlimContainer_handlers();
    vphp_class_handlers *h = VSlimContainer_handlers();
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    wrapper->v_ptr = h->new_raw();
    vphp_register_object(wrapper->v_ptr, Z_OBJ_P(getThis()));
    vphp_bind_handlers_with_ownership(Z_OBJ_P(getThis()), h, 1);
    extern void vphp_wrap_VSlimContainer_construct(void* v_ptr, vphp_context_internal ctx);
    void* v_ptr = wrapper->v_ptr;
    vphp_wrap_VSlimContainer_construct(v_ptr, ctx);
}

PHP_METHOD(VSlim__Container, set) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimContainer_set(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__Container::set called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimContainer_set(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__container_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimContainer_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimContainer_handlers(), 0);
    }
}


PHP_METHOD(VSlim__Container, factory) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void* vphp_wrap_VSlimContainer_factory(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    // printf("PHP_METHOD VSlim__Container::factory called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) RETURN_NULL();
    void* v_instance = vphp_wrap_VSlimContainer_factory(wrapper->v_ptr, ctx);
    vphp_return_obj(return_value, v_instance, vslim__container_ce);
    if (Z_TYPE_P(return_value) == IS_OBJECT) {
        extern vphp_class_handlers* VSlimContainer_handlers();
        vphp_bind_handlers_with_ownership(Z_OBJ_P(return_value), VSlimContainer_handlers(), 0);
    }
}

PHP_METHOD(VSlim__Container, has) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void vphp_wrap_VSlimContainer_has(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!wrapper->v_ptr) RETURN_FALSE;
    vphp_wrap_VSlimContainer_has(wrapper->v_ptr, ctx);
}
PHP_METHOD(VSlim__Container, get) {
    typedef struct { void* ex; void* ret; } vphp_context_internal;
    vphp_context_internal ctx = { .ex = (void*)execute_data, .ret = (void*)return_value };
    extern void VSlimContainer_get(void* v_ptr, vphp_context_internal ctx);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!wrapper->v_ptr) RETURN_NULL();
    VSlimContainer_get(wrapper->v_ptr, ctx);
}
static const zend_function_entry vslim__container_methods[] = {
    PHP_ME(VSlim__Container, __construct, arginfo_vslim__container_construct, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Container, set, arginfo_vslim__container_set, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Container, factory, arginfo_vslim__container_factory, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Container, has, arginfo_vslim__container_has, ZEND_ACC_PUBLIC)
    PHP_ME(VSlim__Container, get, arginfo_vslim__container_get, ZEND_ACC_PUBLIC)
    PHP_FE_END
};

ZEND_BEGIN_MODULE_GLOBALS(vslim)
    zend_long request_count;
ZEND_END_MODULE_GLOBALS(vslim)

ZEND_DECLARE_MODULE_GLOBALS(vslim)
#define VPHP_G(v) ZEND_MODULE_GLOBALS_ACCESSOR(vslim, v)
static void php_vslim_init_globals(zend_vslim_globals *globals) {
    globals->request_count = 0;
}
static const zend_function_entry vslim_functions[] = {
    PHP_FE(vslim_handle_request, arginfo_vslim_handle_request)
    PHP_FE(vslim_demo_dispatch, arginfo_vslim_demo_dispatch)
    PHP_FE(vslim_response_headers, arginfo_vslim_response_headers)
    PHP_FE(vslim_middleware_next, arginfo_vslim_middleware_next)
    PHP_FE(vslim_probe_object, arginfo_vslim_probe_object)
    PHP_FE_END
};
PHP_MINIT_FUNCTION(vslim) {
    vphp_framework_init(module_number);
    extern void vphp_ext_auto_startup() __attribute__((weak));
    extern void vphp_ext_startup() __attribute__((weak));
    if (vphp_ext_auto_startup) vphp_ext_auto_startup();
    if (vphp_ext_startup) vphp_ext_startup();
    {   zend_class_entry ce;
        INIT_CLASS_ENTRY(ce, "VSlim\\View", vslim__view_methods);
        vslim__view_ce = zend_register_internal_class(&ce);
        vslim__view_ce->create_object = vphp_create_object_handler;
        zend_declare_property_string(vslim__view_ce, "base_path", sizeof("base_path")-1, "", ZEND_ACC_PROTECTED);
        zend_declare_property_string(vslim__view_ce, "assets_prefix", sizeof("assets_prefix")-1, "", ZEND_ACC_PROTECTED);
        zend_declare_property_bool(vslim__view_ce, "cache_enabled", sizeof("cache_enabled")-1, 0, ZEND_ACC_PROTECTED);
        zend_declare_property_null(vslim__view_ce, "helpers", sizeof("helpers")-1, ZEND_ACC_PROTECTED);
    }
    {   zend_class_entry ce;
        INIT_CLASS_ENTRY(ce, "VSlim\\Controller", vslim__controller_methods);
        vslim__controller_ce = zend_register_internal_class(&ce);
        vslim__controller_ce->create_object = vphp_create_object_handler;
        zend_declare_property_null(vslim__controller_ce, "host", sizeof("host")-1, ZEND_ACC_PROTECTED);
    }
    {   zend_class_entry ce;
        INIT_CLASS_ENTRY(ce, "VSlim\\App", vslim__app_methods);
        vslim__app_ce = zend_register_internal_class(&ce);
        vslim__app_ce->create_object = vphp_create_object_handler;
        zend_declare_property_null(vslim__app_ce, "routes", sizeof("routes")-1, ZEND_ACC_PROTECTED);
        zend_declare_property_null(vslim__app_ce, "websocket_routes", sizeof("websocket_routes")-1, ZEND_ACC_PROTECTED);
        zend_declare_property_null(vslim__app_ce, "websocket_conn_route", sizeof("websocket_conn_route")-1, ZEND_ACC_PROTECTED);
        zend_declare_property_null(vslim__app_ce, "php_before_hooks", sizeof("php_before_hooks")-1, ZEND_ACC_PROTECTED);
        zend_declare_property_null(vslim__app_ce, "php_after_hooks", sizeof("php_after_hooks")-1, ZEND_ACC_PROTECTED);
        zend_declare_property_null(vslim__app_ce, "php_middlewares", sizeof("php_middlewares")-1, ZEND_ACC_PROTECTED);
        zend_declare_property_null(vslim__app_ce, "php_group_before", sizeof("php_group_before")-1, ZEND_ACC_PROTECTED);
        zend_declare_property_null(vslim__app_ce, "php_group_after", sizeof("php_group_after")-1, ZEND_ACC_PROTECTED);
        zend_declare_property_null(vslim__app_ce, "php_group_middle", sizeof("php_group_middle")-1, ZEND_ACC_PROTECTED);
        zend_declare_property_null(vslim__app_ce, "not_found_handler", sizeof("not_found_handler")-1, ZEND_ACC_PROTECTED);
        zend_declare_property_null(vslim__app_ce, "error_handler", sizeof("error_handler")-1, ZEND_ACC_PROTECTED);
        zend_declare_property_null(vslim__app_ce, "container_ref", sizeof("container_ref")-1, ZEND_ACC_PROTECTED);
        zend_declare_property_null(vslim__app_ce, "config_ref", sizeof("config_ref")-1, ZEND_ACC_PROTECTED);
        zend_declare_property_null(vslim__app_ce, "mcp_ref", sizeof("mcp_ref")-1, ZEND_ACC_PROTECTED);
        zend_declare_property_string(vslim__app_ce, "base_path", sizeof("base_path")-1, "", ZEND_ACC_PROTECTED);
        zend_declare_property_bool(vslim__app_ce, "use_demo", sizeof("use_demo")-1, 0, ZEND_ACC_PROTECTED);
        zend_declare_property_bool(vslim__app_ce, "error_response_json", sizeof("error_response_json")-1, 0, ZEND_ACC_PROTECTED);
        zend_declare_property_string(vslim__app_ce, "view_base_path", sizeof("view_base_path")-1, "", ZEND_ACC_PROTECTED);
        zend_declare_property_string(vslim__app_ce, "assets_prefix", sizeof("assets_prefix")-1, "", ZEND_ACC_PROTECTED);
        zend_declare_property_bool(vslim__app_ce, "view_cache_enabled", sizeof("view_cache_enabled")-1, 0, ZEND_ACC_PROTECTED);
        zend_declare_property_bool(vslim__app_ce, "view_cache_configured", sizeof("view_cache_configured")-1, 0, ZEND_ACC_PROTECTED);
        zend_declare_property_null(vslim__app_ce, "view_helpers", sizeof("view_helpers")-1, ZEND_ACC_PROTECTED);
        zend_declare_property_null(vslim__app_ce, "logger_ref", sizeof("logger_ref")-1, ZEND_ACC_PROTECTED);
        zend_declare_property_null(vslim__app_ce, "live_ws_sockets", sizeof("live_ws_sockets")-1, ZEND_ACC_PROTECTED);
        zend_string *attribute_vslim__app_0_name = zend_string_init_interned("VPhp\\\\VHttpd\\\\Attribute\\\\Dispatchable", sizeof("VPhp\\\\VHttpd\\\\Attribute\\\\Dispatchable")-1, 1);
        zend_attribute *attribute_vslim__app_0 = zend_add_class_attribute(vslim__app_ce, attribute_vslim__app_0_name, 1);
        zend_string_release(attribute_vslim__app_0_name);
        ZVAL_STR(&attribute_vslim__app_0->args[0].value, zend_string_init_interned("http", sizeof("http")-1, 1));
    }
    {   zend_class_entry ce;
        INIT_CLASS_ENTRY(ce, "VSlim\\RouteGroup", vslim__routegroup_methods);
        vslim__routegroup_ce = zend_register_internal_class(&ce);
        vslim__routegroup_ce->create_object = vphp_create_object_handler;
        zend_declare_property_null(vslim__routegroup_ce, "app", sizeof("app")-1, ZEND_ACC_PROTECTED);
        zend_declare_property_string(vslim__routegroup_ce, "prefix", sizeof("prefix")-1, "", ZEND_ACC_PROTECTED);
    }
    {   zend_class_entry ce;
        INIT_CLASS_ENTRY(ce, "VSlim\\Request", vslim__request_methods);
        vslim__request_ce = zend_register_internal_class(&ce);
        vslim__request_ce->create_object = vphp_create_object_handler;
        zend_declare_property_string(vslim__request_ce, "method", sizeof("method")-1, "", ZEND_ACC_PUBLIC);
        zend_declare_property_string(vslim__request_ce, "raw_path", sizeof("raw_path")-1, "", ZEND_ACC_PUBLIC);
        zend_declare_property_string(vslim__request_ce, "path", sizeof("path")-1, "", ZEND_ACC_PUBLIC);
        zend_declare_property_string(vslim__request_ce, "body", sizeof("body")-1, "", ZEND_ACC_PUBLIC);
        zend_declare_property_string(vslim__request_ce, "query_string", sizeof("query_string")-1, "", ZEND_ACC_PUBLIC);
        zend_declare_property_string(vslim__request_ce, "scheme", sizeof("scheme")-1, "", ZEND_ACC_PUBLIC);
        zend_declare_property_string(vslim__request_ce, "host", sizeof("host")-1, "", ZEND_ACC_PUBLIC);
        zend_declare_property_string(vslim__request_ce, "port", sizeof("port")-1, "", ZEND_ACC_PUBLIC);
        zend_declare_property_string(vslim__request_ce, "protocol_version", sizeof("protocol_version")-1, "", ZEND_ACC_PUBLIC);
        zend_declare_property_string(vslim__request_ce, "remote_addr", sizeof("remote_addr")-1, "", ZEND_ACC_PUBLIC);
        zend_declare_property_null(vslim__request_ce, "query", sizeof("query")-1, ZEND_ACC_PROTECTED);
        zend_declare_property_null(vslim__request_ce, "headers", sizeof("headers")-1, ZEND_ACC_PROTECTED);
        zend_declare_property_null(vslim__request_ce, "cookies", sizeof("cookies")-1, ZEND_ACC_PROTECTED);
        zend_declare_property_null(vslim__request_ce, "attributes", sizeof("attributes")-1, ZEND_ACC_PROTECTED);
        zend_declare_property_null(vslim__request_ce, "server", sizeof("server")-1, ZEND_ACC_PROTECTED);
        zend_declare_property_null(vslim__request_ce, "uploaded_files", sizeof("uploaded_files")-1, ZEND_ACC_PROTECTED);
        zend_declare_property_null(vslim__request_ce, "params", sizeof("params")-1, ZEND_ACC_PROTECTED);
    }
    {   zend_class_entry ce;
        INIT_CLASS_ENTRY(ce, "VSlim\\Response", vslim__response_methods);
        vslim__response_ce = zend_register_internal_class(&ce);
        vslim__response_ce->create_object = vphp_create_object_handler;
        zend_declare_property_long(vslim__response_ce, "status", sizeof("status")-1, 0, ZEND_ACC_PUBLIC);
        zend_declare_property_string(vslim__response_ce, "body", sizeof("body")-1, "", ZEND_ACC_PUBLIC);
        zend_declare_property_string(vslim__response_ce, "content_type", sizeof("content_type")-1, "", ZEND_ACC_PUBLIC);
        zend_declare_property_null(vslim__response_ce, "headers", sizeof("headers")-1, ZEND_ACC_PROTECTED);
    }
    {   zend_class_entry ce;
        INIT_CLASS_ENTRY(ce, "VSlim\\Stream\\Response", vslim__stream__response_methods);
        vslim__stream__response_ce = zend_register_internal_class(&ce);
        vslim__stream__response_ce->create_object = vphp_create_object_handler;
        zend_declare_property_string(vslim__stream__response_ce, "stream_type", sizeof("stream_type")-1, "", ZEND_ACC_PUBLIC);
        zend_declare_property_long(vslim__stream__response_ce, "status", sizeof("status")-1, 0, ZEND_ACC_PUBLIC);
        zend_declare_property_string(vslim__stream__response_ce, "content_type", sizeof("content_type")-1, "", ZEND_ACC_PUBLIC);
        zend_declare_property_null(vslim__stream__response_ce, "headers", sizeof("headers")-1, ZEND_ACC_PROTECTED);
        zend_declare_property_null(vslim__stream__response_ce, "chunks_ref", sizeof("chunks_ref")-1, ZEND_ACC_PROTECTED);
    }
    {   zend_class_entry ce;
        INIT_CLASS_ENTRY(ce, "VSlim\\Stream\\NdjsonDecoder", vslim__stream__ndjsondecoder_methods);
        vslim__stream__ndjsondecoder_ce = zend_register_internal_class(&ce);
        vslim__stream__ndjsondecoder_ce->create_object = vphp_create_object_handler;
    }
    {   zend_class_entry ce;
        INIT_CLASS_ENTRY(ce, "VSlim\\Stream\\SseEncoder", vslim__stream__sseencoder_methods);
        vslim__stream__sseencoder_ce = zend_register_internal_class(&ce);
        vslim__stream__sseencoder_ce->create_object = vphp_create_object_handler;
    }
    {   zend_class_entry ce;
        INIT_CLASS_ENTRY(ce, "VSlim\\Stream\\OllamaClient", vslim__stream__ollamaclient_methods);
        vslim__stream__ollamaclient_ce = zend_register_internal_class(&ce);
        vslim__stream__ollamaclient_ce->create_object = vphp_create_object_handler;
        zend_declare_property_string(vslim__stream__ollamaclient_ce, "chat_url", sizeof("chat_url")-1, "", ZEND_ACC_PROTECTED);
        zend_declare_property_string(vslim__stream__ollamaclient_ce, "default_model", sizeof("default_model")-1, "", ZEND_ACC_PROTECTED);
        zend_declare_property_string(vslim__stream__ollamaclient_ce, "api_key", sizeof("api_key")-1, "", ZEND_ACC_PROTECTED);
        zend_declare_property_string(vslim__stream__ollamaclient_ce, "fixture_path", sizeof("fixture_path")-1, "", ZEND_ACC_PROTECTED);
    }
    {   zend_class_entry ce;
        INIT_CLASS_ENTRY(ce, "VSlim\\Stream\\Factory", vslim__stream__factory_methods);
        vslim__stream__factory_ce = zend_register_internal_class(&ce);
        vslim__stream__factory_ce->create_object = vphp_create_object_handler;
    }
    {   zend_class_entry ce;
        INIT_CLASS_ENTRY(ce, "VSlim\\WebSocket\\App", vslim__websocket__app_methods);
        vslim__websocket__app_ce = zend_register_internal_class(&ce);
        vslim__websocket__app_ce->create_object = vphp_create_object_handler;
        zend_declare_property_null(vslim__websocket__app_ce, "on_open_handler", sizeof("on_open_handler")-1, ZEND_ACC_PROTECTED);
        zend_declare_property_null(vslim__websocket__app_ce, "on_message_handler", sizeof("on_message_handler")-1, ZEND_ACC_PROTECTED);
        zend_declare_property_null(vslim__websocket__app_ce, "on_close_handler", sizeof("on_close_handler")-1, ZEND_ACC_PROTECTED);
        zend_declare_property_null(vslim__websocket__app_ce, "connections", sizeof("connections")-1, ZEND_ACC_PROTECTED);
        zend_declare_property_null(vslim__websocket__app_ce, "rooms", sizeof("rooms")-1, ZEND_ACC_PROTECTED);
        zend_string *attribute_vslim__websocket__app_0_name = zend_string_init_interned("VPhp\\\\VHttpd\\\\Attribute\\\\Dispatchable", sizeof("VPhp\\\\VHttpd\\\\Attribute\\\\Dispatchable")-1, 1);
        zend_attribute *attribute_vslim__websocket__app_0 = zend_add_class_attribute(vslim__websocket__app_ce, attribute_vslim__websocket__app_0_name, 1);
        zend_string_release(attribute_vslim__websocket__app_0_name);
        ZVAL_STR(&attribute_vslim__websocket__app_0->args[0].value, zend_string_init_interned("websocket", sizeof("websocket")-1, 1));
    }
    {   zend_class_entry ce;
        INIT_CLASS_ENTRY(ce, "VSlim\\Mcp\\App", vslim__mcp__app_methods);
        vslim__mcp__app_ce = zend_register_internal_class(&ce);
        vslim__mcp__app_ce->create_object = vphp_create_object_handler;
        zend_declare_property_null(vslim__mcp__app_ce, "method_handlers", sizeof("method_handlers")-1, ZEND_ACC_PROTECTED);
        zend_declare_property_null(vslim__mcp__app_ce, "tool_handlers", sizeof("tool_handlers")-1, ZEND_ACC_PROTECTED);
        zend_declare_property_null(vslim__mcp__app_ce, "tool_descriptions", sizeof("tool_descriptions")-1, ZEND_ACC_PROTECTED);
        zend_declare_property_null(vslim__mcp__app_ce, "tool_schemas", sizeof("tool_schemas")-1, ZEND_ACC_PROTECTED);
        zend_declare_property_null(vslim__mcp__app_ce, "resource_handlers", sizeof("resource_handlers")-1, ZEND_ACC_PROTECTED);
        zend_declare_property_null(vslim__mcp__app_ce, "resource_names", sizeof("resource_names")-1, ZEND_ACC_PROTECTED);
        zend_declare_property_null(vslim__mcp__app_ce, "resource_descriptions", sizeof("resource_descriptions")-1, ZEND_ACC_PROTECTED);
        zend_declare_property_null(vslim__mcp__app_ce, "resource_mime_types", sizeof("resource_mime_types")-1, ZEND_ACC_PROTECTED);
        zend_declare_property_null(vslim__mcp__app_ce, "prompt_handlers", sizeof("prompt_handlers")-1, ZEND_ACC_PROTECTED);
        zend_declare_property_null(vslim__mcp__app_ce, "prompt_descriptions", sizeof("prompt_descriptions")-1, ZEND_ACC_PROTECTED);
        zend_declare_property_null(vslim__mcp__app_ce, "prompt_arguments", sizeof("prompt_arguments")-1, ZEND_ACC_PROTECTED);
        zend_declare_property_null(vslim__mcp__app_ce, "server_info", sizeof("server_info")-1, ZEND_ACC_PROTECTED);
        zend_declare_property_null(vslim__mcp__app_ce, "server_capabilities", sizeof("server_capabilities")-1, ZEND_ACC_PROTECTED);
        zend_string *attribute_vslim__mcp__app_0_name = zend_string_init_interned("VPhp\\\\VHttpd\\\\Attribute\\\\Dispatchable", sizeof("VPhp\\\\VHttpd\\\\Attribute\\\\Dispatchable")-1, 1);
        zend_attribute *attribute_vslim__mcp__app_0 = zend_add_class_attribute(vslim__mcp__app_ce, attribute_vslim__mcp__app_0_name, 1);
        zend_string_release(attribute_vslim__mcp__app_0_name);
        ZVAL_STR(&attribute_vslim__mcp__app_0->args[0].value, zend_string_init_interned("mcp", sizeof("mcp")-1, 1));
    }
    {   zend_class_entry ce;
        INIT_CLASS_ENTRY(ce, "VSlim\\Log\\Logger", vslim__log__logger_methods);
        vslim__log__logger_ce = zend_register_internal_class(&ce);
        vslim__log__logger_ce->create_object = vphp_create_object_handler;
        zend_declare_property_null(vslim__log__logger_ce, "engine_ref", sizeof("engine_ref")-1, ZEND_ACC_PROTECTED);
        zend_declare_property_string(vslim__log__logger_ce, "channel", sizeof("channel")-1, "", ZEND_ACC_PROTECTED);
        zend_declare_property_null(vslim__log__logger_ce, "context", sizeof("context")-1, ZEND_ACC_PROTECTED);
        zend_declare_property_string(vslim__log__logger_ce, "level_name", sizeof("level_name")-1, "", ZEND_ACC_PROTECTED);
        zend_declare_property_string(vslim__log__logger_ce, "output_file", sizeof("output_file")-1, "", ZEND_ACC_PROTECTED);
        zend_declare_property_string(vslim__log__logger_ce, "console_target", sizeof("console_target")-1, "", ZEND_ACC_PROTECTED);
        zend_declare_property_bool(vslim__log__logger_ce, "local_time_enabled", sizeof("local_time_enabled")-1, 0, ZEND_ACC_PROTECTED);
        zend_declare_property_bool(vslim__log__logger_ce, "short_tag_enabled", sizeof("short_tag_enabled")-1, 0, ZEND_ACC_PROTECTED);
    }
    {   zend_class_entry ce;
        INIT_CLASS_ENTRY(ce, "VSlim\\Log\\Level", vslim__log__level_methods);
        vslim__log__level_ce = zend_register_internal_class(&ce);
        vslim__log__level_ce->create_object = vphp_create_object_handler;
        zend_declare_class_constant_string(vslim__log__level_ce, "DISABLED", sizeof("DISABLED")-1, "disabled");
        zend_declare_class_constant_string(vslim__log__level_ce, "FATAL", sizeof("FATAL")-1, "fatal");
        zend_declare_class_constant_string(vslim__log__level_ce, "ERROR", sizeof("ERROR")-1, "error");
        zend_declare_class_constant_string(vslim__log__level_ce, "WARN", sizeof("WARN")-1, "warn");
        zend_declare_class_constant_string(vslim__log__level_ce, "INFO", sizeof("INFO")-1, "info");
        zend_declare_class_constant_string(vslim__log__level_ce, "DEBUG", sizeof("DEBUG")-1, "debug");
    }
    {   zend_class_entry ce;
        INIT_CLASS_ENTRY(ce, "VSlim\\Live\\Socket", vslim__live__socket_methods);
        vslim__live__socket_ce = zend_register_internal_class(&ce);
        vslim__live__socket_ce->create_object = vphp_create_object_handler;
        zend_declare_property_string(vslim__live__socket_ce, "id", sizeof("id")-1, "", ZEND_ACC_PROTECTED);
        zend_declare_property_bool(vslim__live__socket_ce, "connected", sizeof("connected")-1, 0, ZEND_ACC_PROTECTED);
        zend_declare_property_string(vslim__live__socket_ce, "redirect_to", sizeof("redirect_to")-1, "", ZEND_ACC_PROTECTED);
        zend_declare_property_string(vslim__live__socket_ce, "navigate_to", sizeof("navigate_to")-1, "", ZEND_ACC_PROTECTED);
        zend_declare_property_string(vslim__live__socket_ce, "raw_path", sizeof("raw_path")-1, "", ZEND_ACC_PROTECTED);
        zend_declare_property_string(vslim__live__socket_ce, "root_id", sizeof("root_id")-1, "", ZEND_ACC_PROTECTED);
        zend_declare_property_null(vslim__live__socket_ce, "assigns", sizeof("assigns")-1, ZEND_ACC_PROTECTED);
        zend_declare_property_null(vslim__live__socket_ce, "patches", sizeof("patches")-1, ZEND_ACC_PROTECTED);
        zend_declare_property_null(vslim__live__socket_ce, "events", sizeof("events")-1, ZEND_ACC_PROTECTED);
        zend_declare_property_null(vslim__live__socket_ce, "flashes", sizeof("flashes")-1, ZEND_ACC_PROTECTED);
        zend_declare_property_null(vslim__live__socket_ce, "pubsub", sizeof("pubsub")-1, ZEND_ACC_PROTECTED);
    }
    {   zend_class_entry ce;
        INIT_CLASS_ENTRY(ce, "VSlim\\Live\\Form", vslim__live__form_methods);
        vslim__live__form_ce = zend_register_internal_class(&ce);
        vslim__live__form_ce->create_object = vphp_create_object_handler;
        zend_declare_property_string(vslim__live__form_ce, "name", sizeof("name")-1, "", ZEND_ACC_PROTECTED);
        zend_declare_property_null(vslim__live__form_ce, "socket_ref", sizeof("socket_ref")-1, ZEND_ACC_PROTECTED);
        zend_declare_property_null(vslim__live__form_ce, "fields", sizeof("fields")-1, ZEND_ACC_PROTECTED);
        zend_declare_property_long(vslim__live__form_ce, "last_error_count", sizeof("last_error_count")-1, 0, ZEND_ACC_PROTECTED);
        zend_declare_property_bool(vslim__live__form_ce, "validated", sizeof("validated")-1, 0, ZEND_ACC_PROTECTED);
    }
    {   zend_class_entry ce;
        INIT_CLASS_ENTRY(ce, "VSlim\\Live\\View", vslim__live__view_methods);
        vslim__live__view_ce = zend_register_internal_class(&ce);
        vslim__live__view_ce->create_object = vphp_create_object_handler;
        zend_declare_property_null(vslim__live__view_ce, "host", sizeof("host")-1, ZEND_ACC_PROTECTED);
        zend_declare_property_string(vslim__live__view_ce, "root_id", sizeof("root_id")-1, "", ZEND_ACC_PROTECTED);
        zend_declare_property_null(vslim__live__view_ce, "sockets", sizeof("sockets")-1, ZEND_ACC_PROTECTED);
    }
    {   zend_class_entry ce;
        INIT_CLASS_ENTRY(ce, "VSlim\\Live\\Component", vslim__live__component_methods);
        vslim__live__component_ce = zend_register_internal_class(&ce);
        vslim__live__component_ce->create_object = vphp_create_object_handler;
        zend_declare_property_null(vslim__live__component_ce, "host", sizeof("host")-1, ZEND_ACC_PROTECTED);
        zend_declare_property_string(vslim__live__component_ce, "id", sizeof("id")-1, "", ZEND_ACC_PROTECTED);
        zend_declare_property_null(vslim__live__component_ce, "assigns", sizeof("assigns")-1, ZEND_ACC_PROTECTED);
        zend_declare_property_null(vslim__live__component_ce, "socket_ref", sizeof("socket_ref")-1, ZEND_ACC_PROTECTED);
    }
    {   zend_class_entry ce;
        INIT_CLASS_ENTRY(ce, "VSlim\\Live\\ComponentState", vslim__live__componentstate_methods);
        vslim__live__componentstate_ce = zend_register_internal_class(&ce);
        vslim__live__componentstate_ce->create_object = vphp_create_object_handler;
        zend_declare_property_string(vslim__live__componentstate_ce, "component_id", sizeof("component_id")-1, "", ZEND_ACC_PROTECTED);
        zend_declare_property_null(vslim__live__componentstate_ce, "socket_ref", sizeof("socket_ref")-1, ZEND_ACC_PROTECTED);
    }
    {   zend_class_entry ce;
        INIT_CLASS_ENTRY(ce, "VSlim\\Config", vslim__config_methods);
        vslim__config_ce = zend_register_internal_class(&ce);
        vslim__config_ce->create_object = vphp_create_object_handler;
        zend_declare_property_string(vslim__config_ce, "path", sizeof("path")-1, "", ZEND_ACC_PROTECTED);
        zend_declare_property_bool(vslim__config_ce, "loaded", sizeof("loaded")-1, 0, ZEND_ACC_PROTECTED);
        zend_declare_property_null(vslim__config_ce, "root", sizeof("root")-1, ZEND_ACC_PROTECTED);
    }
    {   zend_class_entry ce;
        INIT_CLASS_ENTRY(ce, "VSlim\\Container\\ContainerException", vslim__container__containerexception_methods);
        zend_class_entry *parent_ce = zend_hash_str_find_ptr(CG(class_table), "exception", sizeof("exception")-1);
        if (!parent_ce) {
            vphp_throw("parent class Exception not found for VSlim\\Container\\ContainerException", 0);
            return FAILURE;
        }
        vslim__container__containerexception_ce = zend_register_internal_class_ex(&ce, parent_ce);
        vslim__container__containerexception_ce->create_object = parent_ce->create_object;
    }
    {   zend_class_entry ce;
        INIT_CLASS_ENTRY(ce, "VSlim\\Container\\NotFoundException", vslim__container__notfoundexception_methods);
        zend_class_entry *parent_ce = zend_hash_str_find_ptr(CG(class_table), "vslim\\container\\containerexception", sizeof("vslim\\container\\containerexception")-1);
        if (!parent_ce) {
            vphp_throw("parent class VSlim\\\\Container\\\\ContainerException not found for VSlim\\Container\\NotFoundException", 0);
            return FAILURE;
        }
        vslim__container__notfoundexception_ce = zend_register_internal_class_ex(&ce, parent_ce);
        vslim__container__notfoundexception_ce->create_object = parent_ce->create_object;
    }
    {   zend_class_entry ce;
        INIT_CLASS_ENTRY(ce, "VSlim\\Container", vslim__container_methods);
        vslim__container_ce = zend_register_internal_class(&ce);
        vslim__container_ce->create_object = vphp_create_object_handler;
        zend_declare_property_null(vslim__container_ce, "entries", sizeof("entries")-1, ZEND_ACC_PROTECTED);
        zend_declare_property_null(vslim__container_ce, "factories", sizeof("factories")-1, ZEND_ACC_PROTECTED);
        zend_declare_property_null(vslim__container_ce, "resolved", sizeof("resolved")-1, ZEND_ACC_PROTECTED);
    }
    vphp_apply_auto_interface_bindings(0);
    return SUCCESS;
}
PHP_MSHUTDOWN_FUNCTION(vslim) {
    extern void vphp_ext_shutdown() __attribute__((weak));
    extern void vphp_ext_auto_shutdown() __attribute__((weak));
    if (vphp_ext_shutdown) vphp_ext_shutdown();
    if (vphp_ext_auto_shutdown) vphp_ext_auto_shutdown();
    vphp_framework_shutdown();
    return SUCCESS;
}
PHP_RINIT_FUNCTION(vslim) {
    vphp_framework_request_startup();
    extern void vphp_ext_request_auto_startup() __attribute__((weak));
    extern void vphp_ext_request_startup() __attribute__((weak));
    if (vphp_ext_request_auto_startup) vphp_ext_request_auto_startup();
    if (vphp_ext_request_startup) vphp_ext_request_startup();
    return SUCCESS;
}
PHP_RSHUTDOWN_FUNCTION(vslim) {
    extern void vphp_ext_request_shutdown() __attribute__((weak));
    extern void vphp_ext_request_auto_shutdown() __attribute__((weak));
    if (vphp_ext_request_shutdown) vphp_ext_request_shutdown();
    if (vphp_ext_request_auto_shutdown) vphp_ext_request_auto_shutdown();
    vphp_framework_request_shutdown();
    return SUCCESS;
}
PHP_MINFO_FUNCTION(vslim) {
    php_info_print_table_start();
    php_info_print_table_header(2, "vslim support", "enabled");
    php_info_print_table_row(2, "Version", "0.1.0");
    php_info_print_table_row(2, "Description", "Slim-inspired PHP extension powered by vphp");
    php_info_print_table_end();
}

void* vphp_get_active_globals() {
#ifdef ZTS
    return TSRMG(vslim_globals_id, zend_vslim_globals *, 0);
#else
    return &vslim_globals;
#endif
}
zend_module_entry vslim_module_entry = {
    STANDARD_MODULE_HEADER, "vslim", vslim_functions,
    PHP_MINIT(vslim), PHP_MSHUTDOWN(vslim), PHP_RINIT(vslim), PHP_RSHUTDOWN(vslim), PHP_MINFO(vslim), "0.1.0",
    PHP_MODULE_GLOBALS(vslim),
    (void (*)(void*)) php_vslim_init_globals,
    NULL,
    NULL,
    STANDARD_MODULE_PROPERTIES_EX
};

#ifdef COMPILE_DL_VSLIM
ZEND_GET_MODULE(vslim)
#endif
