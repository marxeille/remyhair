<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Http\Request;
use App\Models\State;
use App\Models\Country;
use Illuminate\Support\Facades\Validator;
use function Sodium\add;

class Address extends Model
{
    protected $table = 'address';
    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */


    protected $fillable = [
        'id', 'id_customer', 'id_state', 'id_country', 'address', 'postal_code', 'city', 'created_at', 'updated_at'
    ];

    public function customer()
    {
        return $this->belongsTo('App\Models\Customer', 'id_customer');
    }

    public function country()
    {
        return $this->belongsTo('App\Models\Country', 'id_country');
    }

    public function state()
    {
        return $this->belongsTo('App\Models\State', 'id_state');
    }

    public function carts()
    {
        return $this->hasMany('App\Models\Cart', 'id_address');
    }

    public function orders()
    {
        return $this->hasMany('App\models\Order', 'id_address');
    }

    /**
     * @param Customer $customer
     * @param array $address
     * @return array
     */
    public static function saveAddresses(Customer $customer, $address)
    {
          $data = [];
            $validator = Validator::make($address, [
                'address' => 'required',
                'id_country' => 'required',
            ]);

            if ($validator->fails()) {
                $errors = $validator->errors()->toArray();
                $status[] = Address::convertMessageBag($errors);
            } else {
                $new_address = new Address();
                $new_address->address = $address['address'];
                $new_address->id_customer = $customer->id;
                $country = Country::find($address['id_country']);
                $new_address->id_country = $country->id;
                $state = State::find(isset($address['id_state']) ? $address['id_state'] : null);
                $exists = $state ? $country->states->contains($state->id) : false;
                $new_address->id_state = $state ? $state->id : null;

                if ($country && $address['address'] && isset($address['id_state'])) {
                    $new_address->save();
                    $data = $new_address;
                } else if ($exists && isset($address['id_state'])) {
                    $new_address->save();
                    $data = $new_address;
                } else {
                    if (isset($address['id_state'])) $status['id_state'] = 'State  does not exists in Database.';
                    if (!$country) $status['id_country'] = 'Country  does not exists in Database.';
                }
            }
        return $data;
    }

    /**
     * @param Customer $customer
     * @param array $request
     * @return array
     */
    public static function updateAddresses($address)
    {
            $status = true;
            $validator = Validator::make($address, [
                'address' => 'required',
                'id_country' => 'required',
                'id' => 'required',
            ]);

            if (!$validator->fails()) {
                $new_address = Address::find($address['id']);
                $country = Country::find($address['id_country']);
                $state = isset($address['id_state']) ? State::find($address['id_state']) : null;
                $exists = $state ? $country->states->contains($state->id) : false;
                if ($address) $new_address->address = $address['address'];
                if ($country) $new_address->id_country = $country->id;
                if ($state && $exists) $new_address->id_state = $state->id;
                $new_address->save();
            }else{
                $status = false;
            }

            return $status;
    }

    public static function addOrUpdate($id_address, $id_customer)
    {
        $address = Address::where([['id', '=', $id_address], ['id_customer', '=', $id_customer]])->first();
    }
}
