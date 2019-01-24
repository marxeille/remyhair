<?php

namespace App\Events;

use Illuminate\Broadcasting\Channel;
use Illuminate\Queue\SerializesModels;
use Illuminate\Broadcasting\PrivateChannel;
use Illuminate\Broadcasting\PresenceChannel;
use Illuminate\Foundation\Events\Dispatchable;
use Illuminate\Broadcasting\InteractsWithSockets;
use Illuminate\Contracts\Broadcasting\ShouldBroadcast;

class InstallEvent
{
    use Dispatchable, InteractsWithSockets, SerializesModels;
    public $domain;
    public $title;
    public $template;
    /**
     * Create a new event instance.
     *
     * @return void
     */
    public function __construct($domain, $title, $template)
    {
        $this->domain = $domain;
        $this->title = $title;
        $this->template = $template;
    }

    /**
     * Get the channels the event should broadcast on.
     *
     * @return \Illuminate\Broadcasting\Channel|array
     */
    public function broadcastOn()
    {
        return new PrivateChannel('channel-name');
    }
}
