# VSlim Jobs

`VSlim` 的 queued job 设计采用行业里最常见的几条约束：

- job 是可序列化的任务描述，不是 PHP closure
- 默认投递语义是 at-least-once
- handler 需要尽量幂等
- worker 通过 reserve / execute / ack / release / fail 推进状态
- 超时或 worker crash 后，reserved job 可以重新入队

## 默认数据库表

第一版默认使用 MySQL-backed queue，不强制引入 Redis 或其他外部队列。

通用表名和 `vslim_migrations` 一样带框架前缀：

- `vslim_jobs`
- `vslim_failed_jobs`

`vslim_jobs` 存放待执行、执行中、已完成和可重试的 job：

- `id`
- `queue`
- `job_class`
- `payload_json`
- `status`
- `attempts`
- `max_attempts`
- `available_at`
- `reserved_at`
- `reserved_by`
- `completed_at`
- `failed_at`
- `last_error`
- `created_at`
- `updated_at`

`vslim_failed_jobs` 存放最终失败记录：

- `id`
- `job_id`
- `queue`
- `job_class`
- `payload_json`
- `attempts`
- `error_message`
- `error_trace`
- `failed_at`
- `created_at`

## 状态语义

第一版建议使用这些状态：

- `pending`
- `reserved`
- `completed`
- `failed`

worker 处理流程：

```text
dispatch -> pending -> reserved -> completed
dispatch -> pending -> reserved -> pending
dispatch -> pending -> reserved -> failed
```

`reserved -> pending` 用于 retry / backoff。

`reserved -> failed` 用于达到 `max_attempts` 或不可恢复异常。

## 和 Task 的边界

`Task::spawn($callable, $params)` 按 PHP 参数展开规则传递 `$params`。整数键对应位置参数，字符串键对应命名参数，可用来跳过有默认值的参数。已注册的 V 任务仍接收位置参数。

`VSlim\Task` 在当前请求内运行 PHP callable，也接受已注册的 V 任务名称。PHP callable 在 Fiber 中执行。`Task::waitAll($handles)` 推进一组任务，并按句柄传入顺序返回结果。单个任务可用 `$handle->wait()` 等待。重复等待沿用原结果或抛出同一个异常对象。同组的 PHP 任务可以通过 `wait()` 等待其他任务。调度器会挂起等待方，并在目标任务完成后恢复它。任务内调用 `wait()` 或 `waitAll()` 等待刚创建的任务时，调度器会把它们加入当前组，再挂起等待方。循环等待会在其中一个等待方抛出 `LogicException`。

`$handle->cancel()` 请求取消 PHP 任务，默认抛出 `VSlim\TaskCancelledException`。`$handle->cancel($reason)` 使用传入的 `Throwable`。已排队的任务会直接结束，挂起的任务在 Fiber 内收到异常，可以执行 `finally`，也可以捕获异常后继续。已结束的任务和原生 V 线程任务返回 `false`。

`Task::sleep(milliseconds: 100)` 在任务内挂起当前 Fiber，同组任务可继续执行。`Task::sleep(0)` 让出当前执行机会。计时器使用单调时钟，也可通过任务句柄取消。

`awaitReadable($stream, timeoutMs: 1000)` 和 `awaitWritable($stream, timeoutMs: 1000)` 可在任务内等待非阻塞 stream。超时或等待期间该 stream 被关闭时返回 `false`。对端关闭仍会唤醒读取方，使其可以读到 EOF。PHP 8.6 起使用官方 polling API，PHP 8.2–8.5 由 VPHP 通过系统轮询等待。

多个任务等待同一个 stream 时，如果先恢复的任务读走了当前数据，其他读取任务会继续等待下一次可读或超时。

`VSlim\Job` 面向 queued job：

- 可跨请求
- 可重试
- 可由独立 worker 执行
- 传递 `job_class + payload_json`

两者都可以使用内部 async runtime 的 handle 模型，但 PHP API 和语义不应该混在一起。

## 当前落地

`knowledge-studio` 已经提供第一版通用表 migration：

- `knowledge-studio/database/migrations/20260415_000001_create_vslim_job_tables.php`

后续框架层会继续补：

- `VSlim\Job`
- `VSlim\JobDispatcher`
- `VSlim\JobWorker`
- `queue:work`
