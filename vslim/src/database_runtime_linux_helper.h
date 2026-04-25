#include <dlfcn.h>
#include <limits.h>
#include <mysql.h>
#include <stdlib.h>
#include <string.h>

static char* vslim_mysql_client_plugin_dir(void) {
	Dl_info info;
	if (dladdr((void*) mysql_init, &info) == 0 || info.dli_fname == NULL) {
		return NULL;
	}
	size_t len = strlen(info.dli_fname);
	char* path = (char*) malloc(PATH_MAX);
	if (path == NULL || len + 1 >= PATH_MAX) {
		free(path);
		return NULL;
	}
	memcpy(path, info.dli_fname, len + 1);
	char* slash = strrchr(path, '/');
	if (slash == NULL) {
		free(path);
		return NULL;
	}
	*slash = '\0';
	if (strlen(path) + strlen("/plugin") + 1 >= PATH_MAX) {
		free(path);
		return NULL;
	}
	strcat(path, "/plugin");
	return path;
}
