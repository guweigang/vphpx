<?php
declare(strict_types=1);

return new class extends VSlim\Database\Migration {
    public function up(): bool
    {
        $this->createTable('jobs', [
            'id varchar(64) primary key',
            'workspace_id varchar(64) not null',
            'name varchar(200) not null',
            'status varchar(32) not null',
            'queued_at datetime not null',
        ]);

        $this->createTable('audit_logs', [
            'id varchar(64) primary key',
            'workspace_id varchar(64) not null',
            'actor varchar(120) not null',
            'action varchar(120) not null',
            'target varchar(200) not null',
            'created_at datetime not null',
        ]);

        return true;
    }

    public function down(): bool
    {
        $this->dropTable('audit_logs');
        $this->dropTable('jobs');

        return true;
    }
};
