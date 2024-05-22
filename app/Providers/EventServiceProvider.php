<?php

namespace App\Providers;

use App\Events\NewMessage;
use App\Events\NotificationProposalCese;
use App\Listeners\NewMessageListener;
use App\Listeners\NotificationProposalCeseListener;
use Illuminate\Auth\Events\Registered;
use Illuminate\Auth\Listeners\SendEmailVerificationNotification;
use Illuminate\Foundation\Support\Providers\EventServiceProvider as ServiceProvider;
use Illuminate\Support\Facades\Event;

class EventServiceProvider extends ServiceProvider
{
    /**
     * The event listener mappings for the application.
     *
     * @var array<class-string, array<int, class-string>>
     */
    protected $listen = [
        Registered::class => [
            SendEmailVerificationNotification::class,
        ],
        NewMessage::class => [
            NewMessageListener::class,
        ],
        NotificationProposalCese::class =>  [
            NotificationProposalCeseListener::class
        ],
    ];

    /**
     * Register any events for your application.
     *
     * @return void
     */
    public function boot()
    {
        //
    }
}
