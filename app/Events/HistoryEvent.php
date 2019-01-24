<?php

namespace App\Events;

use Illuminate\Broadcasting\Channel;
use Illuminate\Queue\SerializesModels;
use Illuminate\Broadcasting\PrivateChannel;
use Illuminate\Broadcasting\PresenceChannel;
use Illuminate\Foundation\Events\Dispatchable;
use Illuminate\Broadcasting\InteractsWithSockets;
use Illuminate\Contracts\Broadcasting\ShouldBroadcast;

class HistoryEvent
{
    use Dispatchable, InteractsWithSockets, SerializesModels;

    public $id_item;
    public $id_employee;
    public $action;
    public $model;
    public $employee_name;

    /**
     * Create a new event instance.
     *
     * @return void
     */
    public function __construct($id_employee, $id_item, $action, $model, $employee_name)
    {
        $this->id_item = $id_item;
        $this->action = $action;
        $this->model = $model;
        $this->id_employee = $id_employee;
        $this->employee_name = $employee_name;
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
