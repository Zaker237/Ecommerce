<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasOne;
use Illuminate\Database\Eloquent\Relations\HasMany;

use \App\Enums\OrderStatus;

class Order extends Model
{
    use HasFactory;

    protected $fillable = ['status', 'total_price', 'created_by', 'updated_by'];

    public function isPaid()
    {
        return $this->status == OrderStatus::Paid;
    }

    public function payment(): HasOne
    {
        return $this->hasOne(Payment::class);
    }

    public function user()
    {
        return $this->belongsTo(User::class, 'created_by');
    }

    public function items(): HasMany
    {
        return $this->hasMany(OrderItem::class, 'order_id', 'id');
    }
}
