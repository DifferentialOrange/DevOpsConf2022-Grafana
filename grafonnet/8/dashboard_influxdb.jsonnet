local grafana = import 'grafonnet/grafana.libsonnet';
local panels = import 'panels.libsonnet';

grafana.dashboard.new(
  title='My InfluxDB dashboard',
  editable=true,
  schemaVersion=21,
  time_from='now-30m',
).addInput(
  name='DS_INFLUXDB',
  label='InfluxDB bank',
  type='datasource',
  pluginId='influxdb',
  pluginName='InfluxDB',
  description='InfluxDB Tarantool metrics bank',
).addInput(
  name='INFLUXDB_MEASUREMENT',
  label='Measurement',
  type='constant',
  description='InfluxDB Tarantool metrics measurement',
).addTemplate(
  grafana.template.custom(
    name='measurement',
    query='${INFLUXDB_MEASUREMENT}',
    current='${INFLUXDB_MEASUREMENT}',
    hide='variable',
    label='InfluxDB measurement',
  )
).addPanel(
  panels.pending_requests('${DS_INFLUXDB}'),
  gridPos={ h: 8, w: 8, x: 0, y: 0 },
).addPanel(
  panels.server_load('${DS_INFLUXDB}'),
  gridPos={ h: 8, w: 16, x: 9, y: 0 },
)
