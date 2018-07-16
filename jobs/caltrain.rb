require 'net/http'
require 'json'
require 'time'

$north_bound_code = '70061'
$south_bound_code = '70062'

def north_fetch() 
    uri = URI('http://api.511.org/transit/StopMonitoring?api_key=' + ENV["CALTRAIN_API_KEY"] + '&agency=CT&format=JSON&stopCode=' + $north_bound_code)
    res = Net::HTTP.get(uri)
    res = JSON.parse!(res[3..res.length])
    res["ServiceDelivery"]["StopMonitoringDelivery"]["MonitoredStopVisit"][0]["MonitoredVehicleJourney"]["MonitoredCall"]
end

def south_fetch() 
    uri = URI('http://api.511.org/transit/StopMonitoring?api_key=' + + ENV["CALTRAIN_API_KEY"] + '&agency=CT&format=JSON&stopCode=' + $south_bound_code)
    res = Net::HTTP.get(uri)
    res = JSON.parse!(res[3..res.length])
    res["ServiceDelivery"]["StopMonitoringDelivery"]["MonitoredStopVisit"][0]["MonitoredVehicleJourney"]["MonitoredCall"]
end

SCHEDULER.every '1m' do
    begin
        puts ENV["CALTRAIN_API_KEY"]
        north_bound = north_fetch()
        south_bound = south_fetch()
        north_bound_time = Time.parse(north_bound["AimedArrivalTime"])
        south_bound_time = Time.parse(south_bound["AimedArrivalTime"])
        json_north = {label: "Northbound", value: north_bound_time.getLocal(-8000)}
        json_south = {label: "Southbound", value: south_bound_time.getLocal(-8000)}
        send_event("caltrain", { items: [json_north, json_south] })
    end
end