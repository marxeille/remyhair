<?php
/**
 * Created by PhpStorm.
 * User: TanNM
 * Date: 11/26/2018
 * Time: 7:03 PM
 */

namespace App\Models;


class Helper
{
    public static function sendMail($to, $subject, $message)
    {
        try{
            $email_from = env('MAIL_FROM');

            $headers = "" .
                "Reply-To:" . $email_from . "\r\n" .
                "X-Mailer: PHP/" . phpversion();
            $headers .= 'MIME-Version: 1.0' . "\r\n";
            $headers .= 'Content-type: text/html; charset=iso-8859-1' . "\r\n";

            mail($to,$subject,$message,$headers);
        }catch (\Exception $e){
            \Log::alert($e->getMessage());
        }

    }
}
