module main

import vphp

@[vphp.PhpExportTask(name: '')]
struct AnalyzeTask {
pub mut:
    symbol string
    count  int
}

fn (t AnalyzeTask) run() vphp.TaskResult {
    return [t.symbol, t.count.str()]
}

@[php_class: 'VPhp\\Task']
struct VPhpTask {}

@[php_method]
pub fn VPhpTask.spawn(ctx vphp.Context) {
	vphp.task_spawn(ctx)
}

@[php_method]
pub fn VPhpTask.wait(ctx vphp.Context) {
	vphp.task_wait(ctx)
}

@[php_method]
pub fn VPhpTask.list(ctx vphp.Context) {
	vphp.task_list(ctx)
}
