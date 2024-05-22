<?php

namespace App\Providers;

use Google\Client;
use Google\Service\Sheets;
use Illuminate\Support\ServiceProvider;
use Illuminate\Support\Facades\Vite;

class AppServiceProvider extends ServiceProvider
{
    /**
     * Register any application services.
     *
     * @return void
     */
    public function register()
    {
        
    }

    /**
     * Bootstrap any application services.
     *
     * @return void
     */
    public function boot()
    {
        // Register Vite macro
        Vite::macro('image', fn ($asset) => $this->asset("resources/images/{$asset}"));
        Vite::macro('js', fn ($asset) => $this->asset("resources/js/{$asset}"));
    }
}
 