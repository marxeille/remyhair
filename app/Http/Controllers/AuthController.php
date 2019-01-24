<?php
/**
 * Created by PhpStorm.
 * User: SYSTEM
 * Date: 7/29/2018
 * Time: 8:24 AM
 */

namespace App\Http\Controllers;

use App\Models\Employee;
use App\Models\GroupPermission;
use Illuminate\Http\Request;
use JWTAuth;

class AuthController extends Controller
{
    /**
     * @param Request $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function login(Request $request)
    {
        $credentials = $request->only('email', 'password');
        $token = null;
        $code = 200;
        $msg = 'successfully';
        $data = [];
        $status = true;
        
        try {
            if (!$token = JWTAuth::attempt($credentials)) {
                $status = false;
                $msg = 'Invalid email or password!';
            }else {
                if(\Auth::user()->active){
                    $data['employee'] = \Auth::user();
                    $data['access_token'] = $token;
                    $expiration = JWTAuth::getPayload($token)['exp'];
                    $data['expiration'] = gmdate("Y-m-d", $expiration);
                }else{
                    $status = false;
                    $msg = 'Login failed';
                }   
            }
        } catch (JWTAuthException $e) {
            $status = false;
            $msg = 'Failed to create token';
        }

        return $this->response($status, $msg, $data, $code);
    }

    /**
     * @param Request $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function refreshToken(Request $request)
    {
        try{
            $token = JWTAuth::getToken();
            $new_token = JWTAuth::refresh($token);
            $data['access_token'] =  $new_token;
            $expiration = JWTAuth::getPayload($new_token)['exp'];
            $data['expiration'] = gmdate("Y-m-d", $expiration);
            $status = true;
            $msg = 'successfully';
        }catch (\Error $e){
            $status = false;
            $msg = $e->getMessage();
        }

        return $this->response($status, $msg, $data);
    }

    /**
     * @param bool $status
     * @param string $message
     * @param array $data
     * @param int $code
     * @return \Illuminate\Http\JsonResponse
     */
    public function response($status = true, $message = '', $data = [], $code = 200)
    {
        $data = array_merge($data);
        return response()->json([
            'status' => $status,
            'message'=> $message,
            'data' => $data
        ], $code);
    }
}
