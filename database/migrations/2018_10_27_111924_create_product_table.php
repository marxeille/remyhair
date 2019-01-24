<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateProductTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('product', function (Blueprint $table) {
            $table->increments('id');
            $table->tinyInteger('type')->nullable();
            $table->integer('hair_size_id')->nullable();
            $table->integer('hair_style_id')->nullable();
            $table->integer('hair_type_id')->nullable();
            $table->integer('hair_color_id')->nullable();
            $table->float('quantity')->nullable();
            $table->string('classtify', 200)->nullable();
            $table->string('standard', 200)->nullable();
            $table->string('barcode', 255)->nullable();
            $table->softDeletes();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('product');
    }
}
