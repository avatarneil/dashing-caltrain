require 'net/http'
require 'json'
require 'time'

$north_bound_code = ENV["NORTH_BOUND_CODE"]
$south_bound_code = ENV["SOUTH_BOUND_CODE"]

def north_fetch() 
    uri = URI('http://api.511.org/transit/StopMonitoring?api_key=' + ENV["CALTRAIN_API_KEY"] + '&agency=CT&format=JSON&stopCode=' + $north_bound_code)
    res = Net::HTTP.get(uri)
    res = JSON.parse!(res[3..res.length])
    if res["ServiceDelivery"]["StopMonitoringDelivery"]["MonitoredStopVisit"][0] == nil
        # fetch scheduled time
        "Caltrain API Down"
    else
        res["ServiceDelivery"]["StopMonitoringDelivery"]["MonitoredStopVisit"][0]["MonitoredVehicleJourney"]["MonitoredCall"]
    end
end

def south_fetch() 
    uri = URI('http://api.511.org/transit/StopMonitoring?api_key=' + ENV["CALTRAIN_API_KEY"] + '&agency=CT&format=JSON&stopCode=' + $south_bound_code)
    res = Net::HTTP.get(uri)
    res = JSON.parse!(res[3..res.length])
    if res["ServiceDelivery"]["StopMonitoringDelivery"]["MonitoredStopVisit"][0] == nil
        # fetch scheduled time
        "Caltrain API Down"
    else
        res["ServiceDelivery"]["StopMonitoringDelivery"]["MonitoredStopVisit"][0]["MonitoredVehicleJourney"]["MonitoredCall"]
    end
end

SCHEDULER.every '1m' do
    begin
        puts ENV["CALTRAIN_API_KEY"]
        north_bound = north_fetch()
        south_bound = south_fetch()
        if north_bound  == "Caltrain API Down"|| south_bound == "Caltrain API Down"
            json_north = {label: "Northbound", value: "Caltrain API Down"}
            json_south = {label: "Southbound", value: "Caltrain API Down"}
            send_event("caltrain", items: [json_north, json_south])
        else
            north_bound_time = Time.parse(north_bound["AimedArrivalTime"])
            south_bound_time = Time.parse(south_bound["AimedArrivalTime"])
            json_north = {label: "Northbound", value: north_bound_time.getlocal("-07:00")}
            json_south = {label: "Southbound", value: south_bound_time.getlocal("-07:00")}
            send_event("caltrain", { items: [json_north, json_south] })
        end
    end
end