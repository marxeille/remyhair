<?php
/**
 * Created by PhpStorm.
 * User: TanNM
 * Date: 10/17/2018
 * Time: 8:28 PM
 */

return [
   'per_kg' => 100000,
    'group' => [
        [
            'min_kg' => 0,
            'max_kg' => 10,
            'commission' => 1000000
        ],  [
            'min_kg' => 10,
            'max_kg' => 29,
            'commission' => 1500000
        ],  [
            'min_kg' => 30,
            'max_kg' => 59,
            'commission' => 2500000
        ],  [
            'min_kg' => 60,
            'max_kg' => 89,
            'commission' => 3500000
        ],  [
            'min_kg' => 90,
            'max_kg' => 119,
            'commission' => 4000000
        ],  [
            'min_kg' => 120,
            'max_kg' => 149,
            'commission' => 5000000
        ],  [
            'min_kg' => 150,
            'max_kg' => 199,
            'commission' => 5500000
        ],  [
            'min_kg' => 200,
            'max_kg' => 0,
            'commission' => 6000000
        ],
    ]
];
