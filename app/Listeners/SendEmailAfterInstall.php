<?php

namespace App\Listeners;

use App\Events\InstallEvent;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Contracts\Queue\ShouldQueue;
use App\Shop;
use Mail;
use App\Models\Employee;
use App\Models\ProcedureStep;
use App\Models\WorkProfile;

class SendEmailAfterInstall
{
    /**
     * Create the event listener.
     *
     * @return void
     */
    public function __construct()
    {
        //
    }

    /**
     * Handle the event.
     *
     * @param  InstallEvent  $event
     * @return void
     */
    public function handle(InstallEvent $event)
    {
        foreach($event->domain as $value){
            $employee = Employee::find($value['id_employee']);
            $work_profile = WorkProfile::find($value['id']);
            Mail::send($event->template, ['name_employee' => $employee->name,'suggesstion' => $work_profile->leader_suggesstion, 'id_work_profile' => $value['id']], function($message) use ($event, $employee) {
                $message->to($employee->email);
                $message->subject($event->title);
            });
        }
        
    }
}
