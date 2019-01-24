<?php

namespace App\Http\Middleware;
use App\Models\GroupPermission;
use JWTAuth;
use Tymon\JWTAuth\Exceptions\JWTException;
use Tymon\JWTAuth\Middleware\BaseMiddleware;
use App\Models\History;

use Closure;

class SaveHistory extends BaseMiddleware
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
        $response = $next($request);
        $user = JWTAuth::toUser($this->auth->setRequest($request)->getToken());
        $history = new History();
        $history->id_item = array_key_exists('id', $request->all()) ? $request->all()['id'] : 0;
        $history->id_employee = $user->id;
        $history->action = $request->path();
        $history->model = str_replace('/', ' - ', substr($request->path(), 4));
        $history->save();

        return $response;
    }
}
