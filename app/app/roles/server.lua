local cartridge = require('cartridge')
local failover = require('cartridge.failover')

local function init(opts) -- luacheck: no unused args
    local metrics = cartridge.service_get('metrics')

    metrics.register_callback(function()
        math.randomseed(os.time())

        local server_pending_requests = metrics.gauge('server_pending_requests')
        local server_requests_process = metrics.summary(
            'server_requests_process', nil,
            { [0.5] = 1e-6, [0.9] = 1e-6, [0.99] = 1e-6 },
            { max_age_time = 60, age_buckets_count = 5 }
        )
        if failover.is_leader() then
            server_pending_requests:set(math.random(0, 1) * math.random(1, 10))
            for _ = 1, math.random(100, 1000) do
                server_requests_process:observe(math.random(100, 1000) * 1e-5)
            end
        else
            server_pending_requests:set(math.random(0, 2))
            for _ = 1, math.random(10, 50) do
                server_requests_process:observe(math.random(100, 1000) * 1e-5)
            end
        end
    end)

    return true
end

local function stop()
    return true
end

local function validate_config(conf_new, conf_old) -- luacheck: no unused args
    return true
end

local function apply_config(conf, opts) -- luacheck: no unused args
    -- if opts.is_master then
    -- end

    return true
end

return {
    role_name = 'app.roles.server',
    init = init,
    stop = stop,
    validate_config = validate_config,
    apply_config = apply_config,
    dependencies = { 'cartridge.roles.metrics' },
}
