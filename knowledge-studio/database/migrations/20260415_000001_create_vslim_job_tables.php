<?php
declare(strict_types=1);

return new class extends VSlim\Database\Migration {
    public function up(): bool
    {
        $this->createTable('vslim_jobs', [
            'id bigint unsigned not null auto_increment',
            'queue varchar(100) not null default \'default\'',
            'job_class varchar(255) not null',
            'payload_json longtext not null',
            'status varchar(32) not null default \'pending\'',
            'attempts int unsigned not null default 0',
            'max_attempts int unsigned not null default 3',
            'available_at datetime not null',
            'reserved_at datetime null',
            'reserved_by varchar(128) null',
            'completed_at datetime null',
            'failed_at datetime null',
            'last_error text null',
            'created_at datetime not null',
            'updated_at datetime not null',
            'primary key (`id`)',
            'key `vslim_jobs_queue_ready_idx` (`queue`, `status`, `available_at`, `id`)',
            'key `vslim_jobs_reserved_idx` (`status`, `reserved_at`)',
            'key `vslim_jobs_class_idx` (`job_class`)',
        ]);

        $this->createTable('vslim_failed_jobs', [
            'id bigint unsigned not null auto_increment',
            'job_id bigint unsigned null',
            'queue varchar(100) not null default \'default\'',
            'job_class varchar(255) not null',
            'payload_json longtext not null',
            'attempts int unsigned not null default 0',
            'error_message text not null',
            'error_trace longtext null',
            'failed_at datetime not null',
            'created_at datetime not null',
            'primary key (`id`)',
            'key `vslim_failed_jobs_job_idx` (`job_id`)',
            'key `vslim_failed_jobs_queue_idx` (`queue`, `failed_at`)',
            'key `vslim_failed_jobs_class_idx` (`job_class`)',
        ]);

        return true;
    }

    public function down(): bool
    {
        $this->dropTable('vslim_failed_jobs');
        $this->dropTable('vslim_jobs');

        return true;
    }
};
