<?php

namespace App\Models;

class Action
{
    private static $action = [
        'add-customer' => 'customer/add',
        'edit-customer' => 'customer/edit'
    ];

    /**
     * @return mixed
     */
    public static function getActions()
    {
        return self::action;
    }

    public static function getAction($key = '')
    {
        return self::action[$key];
    }

}
