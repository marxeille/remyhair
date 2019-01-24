<?php

namespace App\Listeners;

use App\Events\HistoryEvent;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Contracts\Queue\ShouldQueue;
use App\Models\History;

class HistoryFired
{
    private $history_model;
    /**
     * Create the event listener.
     *
     * @return void
     */
    public function __construct()
    {
        $this->history_model = new History(); 
    }

    /**
     * Handle the event.
     *
     * @param  HistoryEvent  $event
     * @return void
     */
    public function handle(HistoryEvent $event)
    {
        try{
            $history = new History();
            $history->id_employee = $event->id_employee;
            $history->id_item = $event->id_item;
            $history->action = $event->action;
            $history->model = str_replace('/', ' - ', substr($event->action, 4));
            $history->employee_name = $event->employee_name;
            $history->save();        
        } catch(Exception $e) {
            throw new \Exception('Something went wrong.');
        }
        
        
    }
}
