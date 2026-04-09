<?php
declare(strict_types=1);

return new class extends VSlim\Database\Migration {
    public function up(): bool
    {
        $this->createTable('users', [
            'id varchar(64) primary key',
            'name varchar(120) not null',
            'email varchar(160) not null',
            'role varchar(64) not null',
            'created_at datetime not null',
        ]);

        $this->createTable('workspaces', [
            'id varchar(64) primary key',
            'slug varchar(120) not null',
            'name varchar(160) not null',
            'brand_name varchar(160) not null',
            'plan varchar(32) not null',
            'created_at datetime not null',
        ]);

        $this->createTable('workspace_members', [
            'id varchar(64) primary key',
            'workspace_id varchar(64) not null',
            'user_id varchar(64) not null',
            'role varchar(64) not null',
            'created_at datetime not null',
        ]);

        return true;
    }

    public function down(): bool
    {
        $this->dropTable('workspace_members');
        $this->dropTable('workspaces');
        $this->dropTable('users');

        return true;
    }
};
