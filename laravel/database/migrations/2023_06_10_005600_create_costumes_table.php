<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        if(!Schema::hasTable('pakaians')){
        Schema::create('pakaians', function (Blueprint $table) {
            $table->bigIncrements('id');
            $table->string('nama');
            $table->string('image')->nullable();
            $table->string('deskripsi');
            $table->string('kategori');
            $table->string('kelamin');
            $table->string('usia');
            $table->string('status');
            $table->bigInteger('harga');
            $table->timestamps();
            $table->softDeletes();
        });
    }
}

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('costumes');
    }
};
