<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class EmployeeRequest extends FormRequest
{
    /*
    * Validator instance updated on failedValidation
    *
    * @var \Illuminate\Contracts\Validation\Validator
    */
    public $validator = null;

    /**
     * Overrid Handle a failed validation attempt.
     *
     * @param  \Illuminate\Contracts\Validation\Validator  $validator
     * @return void
     *
     * @throws \Illuminate\Validation\ValidationException
     */
    protected function failedValidation(\Illuminate\Contracts\Validation\Validator $validator)
    {
        $this->validator = $validator;
    }
    
    /**
     * Determine if the user is authorized to make this request.
     *
     * @return bool
     */
    public function authorize()
    {
        return true;
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array
     */
    public function rules()
    {
        return [
            'email' => 'required|email|unique:employee,email,'.$this->id_employee,
            'phone' => 'required|min:8||unique:employee,phone,'.$this->id_employee,
            'name' => 'required',
            'id_group' => 'required',
            'date_of_birth' => 'required',
            'date_of_contract' => 'required',
            'join_date' => 'required',
            'password' => 'required',
            'address' => 'required'
        ];
    }
}
