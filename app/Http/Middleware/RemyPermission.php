<?php

namespace App\Http\Middleware;

use App\Models\GroupPermission;
use Closure;
use JWTAuth;
use Tymon\JWTAuth\Exceptions\JWTException;
use Tymon\JWTAuth\Middleware\BaseMiddleware;

class RemyPermission extends  BaseMiddleware
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
            if($user){
                $hasThisRole = GroupPermission::hasRole($request->getPathInfo(), $user->id_group);
                if(!$hasThisRole){
                    return  response()->json(['access denied'], 401);
                }
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
        return $next($request);
    }
}
