<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use DB;
class DashBoardController extends ControllerCore
{
    /**
     * @param Request $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function getData(Request $request){
        $status = true;
        $msg = 'successfully';
        $data = array();
        $granularity = $request->granularity;
        $date_from = $request->date_from;
        $date_to = $request->date_to;
        $summary_details = $this->getSummaryDetails($date_from, $date_to, $granularity);
        $data = array(
            'supports' => $summary_details['supports'],
            'orders' => $summary_details['orders'],
            'customers' => $summary_details['customers'],
        );
        return $this->response($status, $msg, $data);
    }

    /**
     * @param $date_from
     * @param $date_to
     * @param $granularity
     * @return array
     */
    public function getSummaryDetails($date_from, $date_to, $granularity)
    {
        $summary_details = array(
            'customers' => array(),
            'orders' => array(),
            'supports' => array(),
        );
        $customer = $this->getCustomer($date_from, $date_to, $granularity);
        $orders = $this->getOrders($date_from, $date_to, $granularity);
        $supports = $this->getSupport($date_from, $date_to, $granularity);
        $from = strtotime($date_from.' 00:00:00');
        $to = min(time(), strtotime($date_to.' 23:59:59'));
        switch ($granularity) {
            case 'day':
                for ($date = $from; $date <= $to; $date = strtotime('+1 day', $date)) {
                    $summary_details['customers'][$date] = isset($customer[$date]) ? $customer[$date] : 0;
                    $summary_details['orders'][$date] = isset($orders[$date]) ? $orders[$date] : 0;
                    $summary_details['supports'][$date] = isset($supports[$date]) ? $supports[$date] : 0;
                }
                break;
            case 'week':
                for ($date = $from; $date <= $to; $date = strtotime('+1 week', $date)) {
                    $summary_details['customers'][$date] = isset($customer[$date]) ? $customer[$date] : 0;
                    $summary_details['orders'][$date] = isset($orders[$date]) ? $orders[$date] : 0;
                    $summary_details['supports'][$date] = isset($supports[$date]) ? $supports[$date] : 0;
                }
                break;
            default:
                for ($date = $from; $date <= $to; $date = strtotime('+1 month', $date)) {
                    $summary_details['customers'][$date] = isset($customer[$date]) ? $customer[$date] : 0;
                    $summary_details['orders'][$date] = isset($orders[$date]) ? $orders[$date] : 0;
                    $summary_details['supports'][$date] = isset($supports[$date]) ? $supports[$date] : 0;
                }
                break;
        }
        return $summary_details;

    }

    /**
     * @param $date_from
     * @param $date_to
     * @param $granularity
     * @return array
     */
    public function getCustomer($date_from, $date_to, $granularity){
        $customers = array();
        $sql = DB::table('customer');
        $sql->selectRaw('COUNT(id) as total');
        $sql->selectRaw('LEFT(created_at, 10) as date');
        $sql->whereBetween('created_at',["$date_from 00:00:00", "$date_to 23:59:59"]);
        $sql->where('deleted_at', null);
        switch ($granularity) {
            case 'day':
                $sql->groupBy(DB::raw('LEFT(`created_at`, 10)'));
                break;
            case 'week':
                $sql->groupBy(DB::raw('WEEK(`created_at`, 1)'));
                break;
            default:
                $sql->groupBy(DB::raw('MONTH(`created_at`)'));
                break;
        }
       
        $customer = $sql->get()->toArray();
        foreach ($customer as $result) {
            switch ($granularity) {
                case 'day':
                    $customers[strtotime($result->date)] = (float) $result->total;
                    break;
                case 'week':
                    $date = strtotime(date('Y-m-d', strtotime('monday this week', strtotime($result->date))));
                    if (!isset($customers[$date])) {
                        $customers[$date] = 0;
                    }
                    $customers[$date] += (float) $result->total;
                    break;
                default:
                    $date = strtotime(date('Y-m', strtotime($result->date)));
                    if (!isset($customers[$date])) {
                        $customers[$date] = 0;
                    }
                    $customers[$date] = (float) $result->total;
                    break;
            }
        }
        return $customers;
    }

    /**
     * @param $date_from
     * @param $date_to
     * @param $granularity
     * @return array
     */
    public function getOrders($date_from, $date_to, $granularity){
        $orders = array();
        $sql = DB::table('order');
        $sql->selectRaw('COUNT(id) as total');
        $sql->selectRaw('LEFT(created_at, 10) as date');
        $sql->whereBetween('created_at',["$date_from 00:00:00", "$date_to 23:59:59"]);
        switch ($granularity) {
            case 'day':
                $sql->groupBy(DB::raw('LEFT(`created_at`, 10)'));
                break;
            case 'week':
                $sql->groupBy(DB::raw('WEEK(`created_at`, 1)'));
                break;
            default:
                $sql->groupBy(DB::raw('MONTH(`created_at`)'));
                break;
        }
       
        $order = $sql->get()->toArray();
        foreach ($order as $result) {
            switch ($granularity) {
                case 'day':
                    $orders[strtotime($result->date)] = (float) $result->total;
                    break;
                case 'week':
                    $date = strtotime(date('Y-m-d', strtotime('monday this week', strtotime($result->date))));
                    if (!isset($orders[$date])) {
                        $orders[$date] = 0;
                    }
                    $orders[$date] += (float) $result->total;
                    break;
                default:
                    $date = strtotime(date('Y-m', strtotime($result->date)));
                    if (!isset($orders[$date])) {
                        $orders[$date] = 0;
                    }
                    $orders[$date] = (float) $result->total;
                    break;
            }
        }
        return $orders;
    }

    /**
     * @param $date_from
     * @param $date_to
     * @param $granularity
     * @return array
     */
    public function getSupport($date_from, $date_to, $granularity){
        $sales = array();
        $sql = DB::table('support');
        $sql->selectRaw('COUNT(id) as total');
        $sql->selectRaw('LEFT(created_at, 10) as date');
        $sql->whereBetween('created_at',["$date_from 00:00:00", "$date_to 23:59:59"]);
        switch ($granularity) {
            case 'day':
                $sql->groupBy(DB::raw('LEFT(`created_at`, 10)'));
                break;
            case 'week':
                $sql->groupBy(DB::raw('WEEK(`created_at`, 1)'));
                break;
            default:
                $sql->groupBy(DB::raw('MONTH(`created_at`)'));
                break;
        }
       
        $support = $sql->get()->toArray();
        foreach ($support as $result) {
            switch ($granularity) {
                case 'day':
                    $sales[strtotime($result->date)] = (float) $result->total;
                    break;
                case 'week':
                    $date = strtotime(date('Y-m-d', strtotime('monday this week', strtotime($result->date))));
                    if (!isset($sales[$date])) {
                        $sales[$date] = 0;
                    }
                    $sales[$date] += (float) $result->total;
                    break;
                default:
                    $date = strtotime(date('Y-m', strtotime($result->date)));
                    if (!isset($sales[$date])) {
                        $sales[$date] = 0;
                    }
                    $sales[$date] = (float) $result->total;
                    break;
            }
        }
        return $sales;
    }
}
