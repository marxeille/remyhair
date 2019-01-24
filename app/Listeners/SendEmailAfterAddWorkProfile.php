<?php

namespace App\Listeners;

use App\Events\EmailEvent;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Contracts\Queue\ShouldQueue;
use App\Shop;
use Mail;
use App\Models\Employee;
use App\Models\ProcedureStep;
use App\Models\WorkProfile;

class SendEmailAfterAddWorkProfile
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
     * @param  EmailEvent  $event
     * @return void
     */
    public function handle(EmailEvent $event)
    {
        $work_profile = WorkProfile::find($event->domain);
        $leader = Employee::find($work_profile->id_leader);
        $employee = Employee::find($work_profile->id_employee);
        Mail::send($event->template, ['hard' => $work_profile->hard, 'name_leader' => $leader->name, 'name_employee' => $employee->name, 'id_work_profile' => $event->domain], function($message) use ($event, $leader) {
            $message->to($leader->email);
            $message->subject($event->title);
        });
    }
}
