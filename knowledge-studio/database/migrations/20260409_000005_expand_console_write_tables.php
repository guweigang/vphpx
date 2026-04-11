<?php
declare(strict_types=1);

return new class extends VSlim\Database\Migration {
    public function up(): bool
    {
        $this->tryAddColumn('knowledge_documents', 'chunks int not null');
        $this->tryAddColumn('knowledge_documents', 'updated_at datetime not null');
        $this->tryAddColumn('knowledge_entries', 'status varchar(32) not null');
        $this->tryAddColumn('knowledge_entries', 'owner varchar(120) not null');

        return true;
    }

    public function down(): bool
    {
        $this->tryDropColumn('knowledge_entries', 'owner');
        $this->tryDropColumn('knowledge_entries', 'status');
        $this->tryDropColumn('knowledge_documents', 'updated_at');
        $this->tryDropColumn('knowledge_documents', 'chunks');

        return true;
    }

    private function tryAddColumn(string $table, string $definition): void
    {
        try {
            $this->addColumn($table, $definition);
        } catch (\Throwable) {
        }
    }

    private function tryDropColumn(string $table, string $column): void
    {
        try {
            $this->dropColumn($table, $column);
        } catch (\Throwable) {
        }
    }
};
