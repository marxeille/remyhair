<?php

namespace App\Providers;

use Illuminate\Support\Facades\Event;
use Illuminate\Foundation\Support\Providers\EventServiceProvider as ServiceProvider;

class EventServiceProvider extends ServiceProvider
{
    /**
     * The event listener mappings for the application.
     *
     * @var array
     */
    protected $listen = [
        'App\Events\Event' => [
            'App\Listeners\EventListener',
        ],
        'App\Events\HistoryEvent' => [
            'App\Listeners\HistoryFired',
        ],
        'App\Events\InstallEvent' => [
            'App\Listeners\SendEmailAfterInstall',
        ],
        'App\Events\EmailEvent' => [
            'App\Listeners\SendEmailAfterAddWorkProfile',
        ],
    ];

    /**
     * Register any events for your application.
     *
     * @return void
     */
    public function boot()
    {
        parent::boot();

        //
    }
}
