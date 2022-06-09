#!/usr/bin/env tarantool

local metrics = require('metrics')
local prometheus = require('metrics.plugins.prometheus')
local json_metrics = require('metrics.plugins.json')

local host_port = os.getenv("PORT") or 8081
local httpd = require('http.server').new(nil, host_port)

metrics.register_callback(function()
    math.randomseed(os.time())

    local server_pending_requests = metrics.gauge('server_pending_requests')
    local server_requests_process = metrics.summary(
        'server_requests_process', nil,
        { [0.5] = 1e-3, [0.9] = 1e-3, [0.99] = 1e-3 },
        { max_age_time = 60, age_buckets_count = 5 }
    )

    -- Imitate master server.
    server_pending_requests:set(math.random(0, 1) * math.random(1, 10), {alias = 'server-main'})
    for _ = 1, math.random(100, 1000) do
        server_requests_process:observe(math.random(100, 1000) * 1e-5, {alias = 'server-main'})
    end

    -- Imitate replica server.
    server_pending_requests:set(math.random(0, 2), {alias = 'server-rv'})
    for _ = 1, math.random(10, 50) do
        server_requests_process:observe(math.random(100, 1000) * 1e-5, {alias = 'server-rv'})
    end
end)

httpd:route( { path = '/metrics/prometheus' }, prometheus.collect_http)
httpd:route( { path = '/metrics/json' },
    function(req)
        return req:render({
            text = json_metrics.export()
        })
    end
)
httpd:start()
