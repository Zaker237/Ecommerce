<?php

namespace App\Enums;

class OrderStatus
{
    public const Unpaid = 'unpaid';
    public const Paid = 'paid';
    public const Cancelled = 'cancelled';
    public const Shipped = 'shipped';
    public const Complited = 'completed';

    public static function getStatuses()
    {
        return [
            self::Paid, self::Unpaid, self::Cancelled, self::Shipped, self::Complited
        ];
    }
};