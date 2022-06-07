local grafana = import 'grafonnet/grafana.libsonnet';
local panels = import 'dashboard_9_panels.libsonnet';
local positions = import 'dashboard_9_positions.libsonnet';

grafana.dashboard.new(
    title='My dashboard',
    editable=true,
    schemaVersion=21,
    time_from='now-30m'
).addInput(
    name='DS_INFLUXDB',
    label='InfluxDB bank',
    type='datasource',
    pluginId='influxdb',
    pluginName='InfluxDB',
    description='InfluxDB Tarantool metrics bank'
).addInput(
    name='INFLUXDB_MEASUREMENT',
    label='Measurement',
    type='constant',
    description='InfluxDB Tarantool metrics measurement'
).addTemplate(
    grafana.template.custom(
        name='measurement',
        query='${INFLUXDB_MEASUREMENT}',
        current='${INFLUXDB_MEASUREMENT}',
        hide='variable',
        label='InfluxDB measurement',
    )
).addPanels(
    positions.generate_positions([
        panels.pending_requests(
            datasource='${DS_INFLUXDB}',
            panel_width=8,
            panel_height=8,
        ),
        panels.server_load(
            datasource='${DS_INFLUXDB}',
            panel_width=16,
            panel_height=8,
        )
    ])
)
