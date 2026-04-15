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

`VSlim\Task` 适合当前请求内的 callable facade 或 V-native task。

`VSlim\Job` 面向 queued job：

- 可跨请求
- 可重试
- 可由独立 worker 执行
- 传递 `job_class + payload_json`

两者都可以使用内部 async runtime 的 handle 模型，但 PHP API 和语义不应该混在一起。

## 当前落地

`knowledge-studio` 已经提供第一版通用表 migration：

- `/Users/guweigang/Source/vphpx/knowledge-studio/database/migrations/20260415_000001_create_vslim_job_tables.php`

后续框架层会继续补：

- `VSlim\Job`
- `VSlim\JobDispatcher`
- `VSlim\JobWorker`
- `queue:work`
