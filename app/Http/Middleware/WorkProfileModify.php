<?php

namespace App\Http\Middleware;

use App\Models\GroupPermission;
use Closure;
use JWTAuth;
use Tymon\JWTAuth\Exceptions\JWTException;
use Tymon\JWTAuth\Middleware\BaseMiddleware;

class WorkProfileModify extends BaseMiddleware
{
    /**
     * Handle an incoming request.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \Closure  $next
     * @return mixed
     */
    public function handle($request, Closure $next)
    {
        try {
            $user = JWTAuth::toUser($this->auth->setRequest($request)->getToken());
            $request->merge(['user' => $user ]);

            if ($user->id == $request->id || $user->id_group == 1 || $request->id_leader == $user->id || $request->id_employee == $user->id) {
                return $next($request);
            } else {
                return  response()->json(['access denied'], 401);
            }

        }catch (JWTException $e) {
            if($e instanceof \Tymon\JWTAuth\Exceptions\TokenExpiredException) {
                return response()->json(['token_expired'], $e->getStatusCode());
            }else if ($e instanceof \Tymon\JWTAuth\Exceptions\TokenInvalidException) {
                return response()->json(['token_invalid'], $e->getStatusCode());
            }
            else{
                return response()->json(['error'=>'Token is required']);
            }
        }

    }
}
