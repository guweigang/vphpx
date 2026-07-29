#ifndef VPHP_EMBED_RUNTIME_H
#define VPHP_EMBED_RUNTIME_H

#include <php.h>
#include <SAPI.h>
#include <php_main.h>
#include <php_variables.h>
#include <sapi/embed/php_embed.h>

#include <pthread.h>
#include <stdlib.h>
#include <string.h>
#include <strings.h>

#ifdef ZTS
ZEND_TSRMLS_CACHE_DEFINE()
#endif

typedef struct {
    char *key;
    size_t key_len;
    char *value;
    size_t value_len;
} vphp_embed_pair;

typedef struct {
    char *line;
    size_t line_len;
} vphp_embed_header;

typedef struct vphp_embed_request {
    char *script_path;
    char *method;
    char *uri;
    char *query_string;
    char *body;
    size_t body_len;
    char *content_type;
    char *cookie;
    vphp_embed_pair *server_vars;
    size_t server_vars_len;
    size_t server_vars_cap;
    char *output;
    size_t output_len;
    size_t output_cap;
    vphp_embed_header *headers;
    size_t headers_len;
    size_t headers_cap;
    int status_code;
    char *error;
    size_t body_offset;
    int allocation_failed;
    int completed;
    int execute_result;
    struct vphp_embed_request *queue_next;
} vphp_embed_request;

static pthread_mutex_t vphp_embed_engine_lock = PTHREAD_MUTEX_INITIALIZER;
static pthread_cond_t vphp_embed_work_cond = PTHREAD_COND_INITIALIZER;
static pthread_cond_t vphp_embed_done_cond = PTHREAD_COND_INITIALIZER;
static pthread_cond_t vphp_embed_state_cond = PTHREAD_COND_INITIALIZER;
static pthread_t *vphp_embed_lane_threads = NULL;
static size_t vphp_embed_lane_count = 0;
static size_t vphp_embed_lane_threads_created = 0;
static size_t vphp_embed_aux_lanes_ready = 0;
static size_t vphp_embed_aux_lanes_active = 0;
static size_t vphp_embed_aux_lane_failures = 0;
static int vphp_embed_starting = 0;
static int vphp_embed_started = 0;
static int vphp_embed_stopping = 0;
static unsigned int vphp_embed_engine_refs = 0;
static vphp_embed_request *vphp_embed_queue_head = NULL;
static vphp_embed_request *vphp_embed_queue_tail = NULL;
static __thread vphp_embed_request *vphp_embed_current_request = NULL;
static char *vphp_embed_argv[] = {
    "vphp-gateway",
    "-d", "display_errors=0",
    "-d", "log_errors=1",
    "-d", "html_errors=0",
    "-d", "output_buffering=Off",
    "-d", "opcache.enable=0",
    NULL
};

static char *vphp_embed_dup(const char *value, size_t value_len) {
    char *copy = malloc(value_len + 1);
    if (!copy) {
        return NULL;
    }
    if (value_len > 0 && value) {
        memcpy(copy, value, value_len);
    }
    copy[value_len] = '\0';
    return copy;
}

static int vphp_embed_replace_len(char **target, const char *value, size_t value_len) {
    char *copy = vphp_embed_dup(value ? value : "", value ? value_len : 0);
    if (!copy) {
        return 0;
    }
    free(*target);
    *target = copy;
    return 1;
}

static void vphp_embed_replace(char **target, const char *value) {
    vphp_embed_replace_len(target, value ? value : "", value ? strlen(value) : 0);
}

static void vphp_embed_set_error(vphp_embed_request *request, const char *message) {
    if (request && !request->error) {
        vphp_embed_replace(&request->error, message);
    }
}

static size_t vphp_embed_ub_write(const char *str, size_t str_length) {
    vphp_embed_request *request = vphp_embed_current_request;
    if (!request || !str || str_length == 0) {
        return str_length;
    }
    size_t needed = request->output_len + str_length + 1;
    if (needed > request->output_cap) {
        size_t next_cap = request->output_cap == 0 ? 4096 : request->output_cap * 2;
        if (next_cap < needed) {
            next_cap = needed;
        }
        char *next = realloc(request->output, next_cap);
        if (!next) {
            request->allocation_failed = 1;
            vphp_embed_set_error(request, "failed to allocate PHP response body");
            return 0;
        }
        request->output = next;
        request->output_cap = next_cap;
    }
    memcpy(request->output + request->output_len, str, str_length);
    request->output_len += str_length;
    request->output[request->output_len] = '\0';
    return str_length;
}

static size_t vphp_embed_header_name_len(const char *line, size_t line_len) {
    const char *colon = memchr(line, ':', line_len);
    size_t name_len = colon ? (size_t)(colon - line) : line_len;
    while (name_len > 0 && (line[name_len - 1] == ' ' || line[name_len - 1] == '\t')) {
        name_len--;
    }
    return name_len;
}

static void vphp_embed_remove_header_at(vphp_embed_request *request, size_t index) {
    free(request->headers[index].line);
    if (index + 1 < request->headers_len) {
        memmove(
            &request->headers[index],
            &request->headers[index + 1],
            (request->headers_len - index - 1) * sizeof(vphp_embed_header)
        );
    }
    request->headers_len--;
}

static void vphp_embed_remove_headers(
    vphp_embed_request *request,
    const char *name,
    size_t name_len,
    int prefix
) {
    size_t index = 0;
    while (index < request->headers_len) {
        size_t candidate_len = vphp_embed_header_name_len(
            request->headers[index].line,
            request->headers[index].line_len
        );
        int matches = prefix
            ? candidate_len >= name_len && strncasecmp(request->headers[index].line, name, name_len) == 0
            : candidate_len == name_len && strncasecmp(request->headers[index].line, name, name_len) == 0;
        if (matches) {
            vphp_embed_remove_header_at(request, index);
        } else {
            index++;
        }
    }
}

static int vphp_embed_add_header(vphp_embed_request *request, const char *line, size_t line_len) {
    if (request->headers_len == request->headers_cap) {
        size_t next_cap = request->headers_cap == 0 ? 8 : request->headers_cap * 2;
        vphp_embed_header *next = realloc(request->headers, next_cap * sizeof(vphp_embed_header));
        if (!next) {
            request->allocation_failed = 1;
            vphp_embed_set_error(request, "failed to allocate PHP response headers");
            return 0;
        }
        request->headers = next;
        request->headers_cap = next_cap;
    }
    char *copy = vphp_embed_dup(line, line_len);
    if (!copy) {
        request->allocation_failed = 1;
        vphp_embed_set_error(request, "failed to allocate PHP response header");
        return 0;
    }
    request->headers[request->headers_len++] = (vphp_embed_header){copy, line_len};
    return 1;
}

static int vphp_embed_header_handler(
    sapi_header_struct *header,
    sapi_header_op_enum op,
    sapi_headers_struct *headers
) {
    (void)headers;
    vphp_embed_request *request = vphp_embed_current_request;
    if (!request) {
        return SAPI_HEADER_ADD;
    }
    if (op == SAPI_HEADER_DELETE_ALL) {
        while (request->headers_len > 0) {
            vphp_embed_remove_header_at(request, request->headers_len - 1);
        }
        return SAPI_HEADER_ADD;
    }
    if (op == SAPI_HEADER_SET_STATUS || !header || !header->header || header->header_len == 0) {
        return SAPI_HEADER_ADD;
    }

    size_t name_len = vphp_embed_header_name_len(header->header, header->header_len);
    if (op == SAPI_HEADER_DELETE || op == SAPI_HEADER_DELETE_PREFIX) {
        vphp_embed_remove_headers(
            request,
            header->header,
            op == SAPI_HEADER_DELETE_PREFIX ? header->header_len : name_len,
            op == SAPI_HEADER_DELETE_PREFIX
        );
        return SAPI_HEADER_ADD;
    }
    if (op == SAPI_HEADER_REPLACE) {
        vphp_embed_remove_headers(request, header->header, name_len, 0);
    }
    vphp_embed_add_header(request, header->header, header->header_len);
    return SAPI_HEADER_ADD;
}

static size_t vphp_embed_read_post(char *buffer, size_t count_bytes) {
    vphp_embed_request *request = vphp_embed_current_request;
    if (!request || !request->body || request->body_offset >= request->body_len) {
        return 0;
    }
    size_t remaining = request->body_len - request->body_offset;
    size_t copied = count_bytes < remaining ? count_bytes : remaining;
    memcpy(buffer, request->body + request->body_offset, copied);
    request->body_offset += copied;
    return copied;
}

static char *vphp_embed_read_cookies(void) {
    vphp_embed_request *request = vphp_embed_current_request;
    return request && request->cookie ? request->cookie : NULL;
}

static void vphp_embed_register_server_variables(zval *track_vars_array) {
    vphp_embed_request *request = vphp_embed_current_request;
    if (!request) {
        return;
    }
    for (size_t i = 0; i < request->server_vars_len; i++) {
        vphp_embed_pair *pair = &request->server_vars[i];
        php_register_variable_safe(pair->key, pair->value, pair->value_len, track_vars_array);
    }
}

static void vphp_embed_clear_request_info(void) {
    SG(server_context) = NULL;
    SG(request_info).request_method = NULL;
    SG(request_info).query_string = NULL;
    SG(request_info).request_uri = NULL;
    SG(request_info).path_translated = NULL;
    SG(request_info).content_type = NULL;
    SG(request_info).content_length = 0;
    SG(request_info).cookie_data = NULL;
    SG(request_info).argc = 0;
    SG(request_info).argv = NULL;
}

static int vphp_embed_execute_request_on_worker(vphp_embed_request *request) {
    vphp_embed_current_request = request;
    SG(server_context) = request;
    request->body_offset = 0;
    request->status_code = 200;

    SG(request_info).request_method = request->method ? request->method : "GET";
    SG(request_info).query_string = request->query_string ? request->query_string : "";
    SG(request_info).request_uri = request->uri ? request->uri : "/";
    SG(request_info).path_translated = request->script_path;
    SG(request_info).content_type = request->content_type ? request->content_type : "";
    SG(request_info).content_length = (zend_long)request->body_len;
    SG(request_info).cookie_data = request->cookie;
    SG(request_info).argc = 0;
    SG(request_info).argv = NULL;

    int startup_ok = 0;
    zend_first_try {
        startup_ok = php_request_startup() == SUCCESS;
    } zend_catch {
        startup_ok = 0;
    } zend_end_try();
    if (!startup_ok) {
        vphp_embed_set_error(request, "php_request_startup failed");
        vphp_embed_clear_request_info();
        vphp_embed_current_request = NULL;
        return 0;
    }

    SG(sapi_headers).http_response_code = 200;
    EG(exit_status) = 0;
    int executed = 1;
    zend_first_try {
        zend_file_handle file_handle;
        zend_stream_init_filename(&file_handle, request->script_path);
        if (php_execute_script(&file_handle) == FAILURE) {
            executed = 0;
            vphp_embed_set_error(request, "PHP script execution failed");
        }
    } zend_catch {
        executed = 0;
        vphp_embed_set_error(request, "PHP request aborted");
    } zend_end_try();

    request->status_code = SG(sapi_headers).http_response_code > 0
        ? SG(sapi_headers).http_response_code
        : (executed ? 200 : 500);
    if (EG(exit_status) == 255 && request->status_code < 400) {
        request->status_code = 500;
    }

    int shutdown_ok = 1;
    zend_first_try {
        php_request_shutdown(NULL);
    } zend_catch {
        shutdown_ok = 0;
    } zend_end_try();
    if (!shutdown_ok) {
        executed = 0;
        vphp_embed_set_error(request, "php_request_shutdown aborted");
    }
    if (request->allocation_failed) {
        executed = 0;
    }
    vphp_embed_clear_request_info();
    vphp_embed_current_request = NULL;
    return executed;
}

static void vphp_embed_lane_run_requests(void) {
    for (;;) {
        pthread_mutex_lock(&vphp_embed_engine_lock);
        while (!vphp_embed_queue_head && !vphp_embed_stopping) {
            pthread_cond_wait(&vphp_embed_work_cond, &vphp_embed_engine_lock);
        }
        if (vphp_embed_stopping && !vphp_embed_queue_head) {
            pthread_mutex_unlock(&vphp_embed_engine_lock);
            return;
        }
        vphp_embed_request *request = vphp_embed_queue_head;
        vphp_embed_queue_head = request->queue_next;
        if (!vphp_embed_queue_head) {
            vphp_embed_queue_tail = NULL;
        }
        request->queue_next = NULL;
        pthread_mutex_unlock(&vphp_embed_engine_lock);

        request->execute_result = vphp_embed_execute_request_on_worker(request);

        pthread_mutex_lock(&vphp_embed_engine_lock);
        request->completed = 1;
        pthread_cond_broadcast(&vphp_embed_done_cond);
        pthread_mutex_unlock(&vphp_embed_engine_lock);
    }
}

static void *vphp_embed_aux_lane_main(void *unused) {
    (void)unused;
#ifdef ZTS
    if (!ts_resource(0)) {
        pthread_mutex_lock(&vphp_embed_engine_lock);
        vphp_embed_aux_lane_failures++;
        pthread_cond_broadcast(&vphp_embed_state_cond);
        pthread_mutex_unlock(&vphp_embed_engine_lock);
        return NULL;
    }
    ZEND_TSRMLS_CACHE_UPDATE();
#endif

    pthread_mutex_lock(&vphp_embed_engine_lock);
    vphp_embed_aux_lanes_ready++;
    vphp_embed_aux_lanes_active++;
    pthread_cond_broadcast(&vphp_embed_state_cond);
    pthread_mutex_unlock(&vphp_embed_engine_lock);

    vphp_embed_lane_run_requests();

#ifdef ZTS
    ts_free_thread();
#endif
    pthread_mutex_lock(&vphp_embed_engine_lock);
    vphp_embed_aux_lanes_active--;
    pthread_cond_broadcast(&vphp_embed_state_cond);
    pthread_mutex_unlock(&vphp_embed_engine_lock);
    return NULL;
}

static void *vphp_embed_owner_lane_main(void *unused) {
    (void)unused;
    php_embed_module.ub_write = vphp_embed_ub_write;
    php_embed_module.read_post = vphp_embed_read_post;
    php_embed_module.read_cookies = vphp_embed_read_cookies;
    php_embed_module.header_handler = vphp_embed_header_handler;
    php_embed_module.register_server_variables = vphp_embed_register_server_variables;
    php_embed_module.php_ini_ignore = 1;
    php_embed_module.php_ini_path_override = "/dev/null";

    int initialized = php_embed_init(11, vphp_embed_argv) != FAILURE;
#ifdef ZTS
    if (initialized) {
        ZEND_TSRMLS_CACHE_UPDATE();
    }
#endif
    if (initialized) {
        php_request_shutdown(NULL);
    }

    pthread_mutex_lock(&vphp_embed_engine_lock);
    vphp_embed_started = initialized;
    vphp_embed_starting = 0;
    pthread_cond_broadcast(&vphp_embed_state_cond);
    pthread_mutex_unlock(&vphp_embed_engine_lock);
    if (!initialized) {
        return NULL;
    }

    vphp_embed_lane_run_requests();

    pthread_mutex_lock(&vphp_embed_engine_lock);
    while (vphp_embed_aux_lanes_active > 0) {
        pthread_cond_wait(&vphp_embed_state_cond, &vphp_embed_engine_lock);
    }
    pthread_mutex_unlock(&vphp_embed_engine_lock);

    vphp_embed_clear_request_info();
    int final_request_started = 0;
    zend_first_try {
        final_request_started = php_request_startup() == SUCCESS;
    } zend_catch {
        final_request_started = 0;
    } zend_end_try();
    if (final_request_started) {
        /* php_embed_shutdown destroys TSRM, so it must run after zend_end_try. */
        php_embed_shutdown();
    }

    pthread_mutex_lock(&vphp_embed_engine_lock);
    vphp_embed_started = 0;
    pthread_cond_broadcast(&vphp_embed_state_cond);
    pthread_mutex_unlock(&vphp_embed_engine_lock);
    return NULL;
}

static int vphp_embed_engine_start(size_t requested_lanes) {
    if (requested_lanes == 0) {
        requested_lanes = 1;
    } else if (requested_lanes > 64) {
        requested_lanes = 64;
    }
    pthread_mutex_lock(&vphp_embed_engine_lock);
    if (vphp_embed_started && !vphp_embed_stopping) {
        vphp_embed_engine_refs++;
        pthread_mutex_unlock(&vphp_embed_engine_lock);
        return 1;
    }
    if (vphp_embed_starting || vphp_embed_stopping) {
        pthread_mutex_unlock(&vphp_embed_engine_lock);
        return 0;
    }

    vphp_embed_lane_threads = calloc(requested_lanes, sizeof(pthread_t));
    if (!vphp_embed_lane_threads) {
        pthread_mutex_unlock(&vphp_embed_engine_lock);
        return 0;
    }
    vphp_embed_lane_count = requested_lanes;
    vphp_embed_lane_threads_created = 0;
    vphp_embed_aux_lanes_ready = 0;
    vphp_embed_aux_lanes_active = 0;
    vphp_embed_aux_lane_failures = 0;
    vphp_embed_queue_head = NULL;
    vphp_embed_queue_tail = NULL;
    vphp_embed_starting = 1;
    vphp_embed_stopping = 0;
    if (pthread_create(&vphp_embed_lane_threads[0], NULL, vphp_embed_owner_lane_main, NULL) != 0) {
        vphp_embed_starting = 0;
        free(vphp_embed_lane_threads);
        vphp_embed_lane_threads = NULL;
        vphp_embed_lane_count = 0;
        pthread_mutex_unlock(&vphp_embed_engine_lock);
        return 0;
    }
    vphp_embed_lane_threads_created = 1;
    while (vphp_embed_starting) {
        pthread_cond_wait(&vphp_embed_state_cond, &vphp_embed_engine_lock);
    }
    if (!vphp_embed_started) {
        pthread_t owner = vphp_embed_lane_threads[0];
        free(vphp_embed_lane_threads);
        vphp_embed_lane_threads = NULL;
        vphp_embed_lane_count = 0;
        vphp_embed_lane_threads_created = 0;
        pthread_mutex_unlock(&vphp_embed_engine_lock);
        pthread_join(owner, NULL);
        return 0;
    }

    int lane_start_failed = 0;
    for (size_t i = 1; i < requested_lanes; i++) {
        if (pthread_create(&vphp_embed_lane_threads[i], NULL, vphp_embed_aux_lane_main, NULL) != 0) {
            lane_start_failed = 1;
            break;
        }
        vphp_embed_lane_threads_created++;
    }
    size_t expected_aux_lanes = vphp_embed_lane_threads_created - 1;
    while (vphp_embed_aux_lanes_ready + vphp_embed_aux_lane_failures < expected_aux_lanes) {
        pthread_cond_wait(&vphp_embed_state_cond, &vphp_embed_engine_lock);
    }
    if (lane_start_failed || vphp_embed_aux_lane_failures > 0) {
        vphp_embed_stopping = 1;
        pthread_cond_broadcast(&vphp_embed_work_cond);
        size_t created = vphp_embed_lane_threads_created;
        pthread_t *threads = vphp_embed_lane_threads;
        pthread_mutex_unlock(&vphp_embed_engine_lock);
        for (size_t i = 0; i < created; i++) {
            pthread_join(threads[i], NULL);
        }
        free(threads);
        pthread_mutex_lock(&vphp_embed_engine_lock);
        vphp_embed_lane_threads = NULL;
        vphp_embed_lane_count = 0;
        vphp_embed_lane_threads_created = 0;
        vphp_embed_stopping = 0;
        pthread_mutex_unlock(&vphp_embed_engine_lock);
        return 0;
    }
    vphp_embed_engine_refs = 1;
    pthread_mutex_unlock(&vphp_embed_engine_lock);
    return 1;
}

static void vphp_embed_engine_shutdown(void) {
    pthread_mutex_lock(&vphp_embed_engine_lock);
    if (!vphp_embed_started || vphp_embed_engine_refs == 0) {
        pthread_mutex_unlock(&vphp_embed_engine_lock);
        return;
    }
    if (--vphp_embed_engine_refs > 0) {
        pthread_mutex_unlock(&vphp_embed_engine_lock);
        return;
    }
    vphp_embed_stopping = 1;
    pthread_cond_broadcast(&vphp_embed_work_cond);
    pthread_mutex_unlock(&vphp_embed_engine_lock);

    size_t created = vphp_embed_lane_threads_created;
    pthread_t *threads = vphp_embed_lane_threads;
    for (size_t i = 0; i < created; i++) {
        pthread_join(threads[i], NULL);
    }
    free(threads);

    pthread_mutex_lock(&vphp_embed_engine_lock);
    vphp_embed_lane_threads = NULL;
    vphp_embed_lane_count = 0;
    vphp_embed_lane_threads_created = 0;
    vphp_embed_aux_lanes_ready = 0;
    vphp_embed_aux_lane_failures = 0;
    vphp_embed_stopping = 0;
    pthread_mutex_unlock(&vphp_embed_engine_lock);
}

static vphp_embed_request *vphp_embed_request_new(void) {
    vphp_embed_request *request = calloc(1, sizeof(vphp_embed_request));
    if (request) {
        request->status_code = 200;
    }
    return request;
}

static void vphp_embed_request_free(vphp_embed_request *request) {
    if (!request) {
        return;
    }
    free(request->script_path);
    free(request->method);
    free(request->uri);
    free(request->query_string);
    free(request->body);
    free(request->content_type);
    free(request->cookie);
    for (size_t i = 0; i < request->server_vars_len; i++) {
        free(request->server_vars[i].key);
        free(request->server_vars[i].value);
    }
    free(request->server_vars);
    free(request->output);
    for (size_t i = 0; i < request->headers_len; i++) {
        free(request->headers[i].line);
    }
    free(request->headers);
    free(request->error);
    free(request);
}

static void vphp_embed_request_set_script(vphp_embed_request *r, const char *v) { vphp_embed_replace(&r->script_path, v); }
static void vphp_embed_request_set_method(vphp_embed_request *r, const char *v) { vphp_embed_replace(&r->method, v); }
static void vphp_embed_request_set_uri(vphp_embed_request *r, const char *v) { vphp_embed_replace(&r->uri, v); }
static void vphp_embed_request_set_query(vphp_embed_request *r, const char *v) { vphp_embed_replace(&r->query_string, v); }
static void vphp_embed_request_set_content_type(vphp_embed_request *r, const char *v) { vphp_embed_replace(&r->content_type, v); }
static void vphp_embed_request_set_cookie(vphp_embed_request *r, const char *v) { vphp_embed_replace(&r->cookie, v); }
static void vphp_embed_request_set_body(vphp_embed_request *request, const char *value, size_t value_len) {
    if (vphp_embed_replace_len(&request->body, value, value_len)) {
        request->body_len = value_len;
    } else {
        request->allocation_failed = 1;
        vphp_embed_set_error(request, "failed to allocate PHP request body");
    }
}

static int vphp_embed_request_add_server(
    vphp_embed_request *request,
    const char *key,
    size_t key_len,
    const char *value,
    size_t value_len
) {
    if (request->server_vars_len == request->server_vars_cap) {
        size_t next_cap = request->server_vars_cap == 0 ? 16 : request->server_vars_cap * 2;
        vphp_embed_pair *next = realloc(request->server_vars, next_cap * sizeof(vphp_embed_pair));
        if (!next) {
            request->allocation_failed = 1;
            vphp_embed_set_error(request, "failed to allocate PHP server variables");
            return 0;
        }
        request->server_vars = next;
        request->server_vars_cap = next_cap;
    }
    char *key_copy = vphp_embed_dup(key, key_len);
    char *value_copy = vphp_embed_dup(value, value_len);
    if (!key_copy || !value_copy) {
        free(key_copy);
        free(value_copy);
        request->allocation_failed = 1;
        vphp_embed_set_error(request, "failed to allocate PHP server variable");
        return 0;
    }
    request->server_vars[request->server_vars_len++] = (vphp_embed_pair){
        key_copy, key_len, value_copy, value_len
    };
    return 1;
}

static int vphp_embed_request_execute(vphp_embed_request *request) {
    if (!request || !request->script_path || request->script_path[0] == '\0') {
        if (request) vphp_embed_set_error(request, "script path is empty");
        return 0;
    }
    if (request->allocation_failed) {
        return 0;
    }

    pthread_mutex_lock(&vphp_embed_engine_lock);
    if (!vphp_embed_started || vphp_embed_stopping) {
        vphp_embed_set_error(request, "PHP embed engine is not available");
        pthread_mutex_unlock(&vphp_embed_engine_lock);
        return 0;
    }
    request->completed = 0;
    request->queue_next = NULL;
    if (vphp_embed_queue_tail) {
        vphp_embed_queue_tail->queue_next = request;
    } else {
        vphp_embed_queue_head = request;
    }
    vphp_embed_queue_tail = request;
    pthread_cond_signal(&vphp_embed_work_cond);
    while (!request->completed && vphp_embed_started) {
        pthread_cond_wait(&vphp_embed_done_cond, &vphp_embed_engine_lock);
    }
    int result = request->completed ? request->execute_result : 0;
    if (!request->completed) {
        vphp_embed_set_error(request, "PHP embed engine stopped during request");
    }
    pthread_mutex_unlock(&vphp_embed_engine_lock);
    return result;
}

static const char *vphp_embed_request_output(vphp_embed_request *r) { return r && r->output ? r->output : ""; }
static size_t vphp_embed_request_output_len(vphp_embed_request *r) { return r ? r->output_len : 0; }
static size_t vphp_embed_request_header_count(vphp_embed_request *r) { return r ? r->headers_len : 0; }
static const char *vphp_embed_request_header_line(vphp_embed_request *r, size_t i) {
    return r && i < r->headers_len ? r->headers[i].line : "";
}
static size_t vphp_embed_request_header_line_len(vphp_embed_request *r, size_t i) {
    return r && i < r->headers_len ? r->headers[i].line_len : 0;
}
static int vphp_embed_request_status(vphp_embed_request *r) { return r ? r->status_code : 500; }
static const char *vphp_embed_request_error(vphp_embed_request *r) { return r && r->error ? r->error : ""; }

#endif
