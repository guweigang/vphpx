<?php
declare(strict_types=1);

return new class extends VSlim\Database\Migration {
    public function up(): bool
    {
        try {
            $this->addColumn('knowledge_releases', 'notes text not null');
        } catch (\Throwable) {
        }

        try {
            $this->execute("UPDATE `knowledge_releases` SET `notes` = '' WHERE `notes` IS NULL");
        } catch (\Throwable) {
        }

        return true;
    }

    public function down(): bool
    {
        try {
            $this->dropColumn('knowledge_releases', 'notes');
        } catch (\Throwable) {
        }

        return true;
    }
};
