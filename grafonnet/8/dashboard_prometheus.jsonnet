local grafana = import 'grafonnet/grafana.libsonnet';
local panels = import 'panels.libsonnet';

grafana.dashboard.new(
  title='My Prometheus dashboard',
  editable=true,
  schemaVersion=21,
  time_from='now-30m'
).addInput(
  name='DS_PROMETHEUS',
  label='Prometheus',
  type='datasource',
  pluginId='prometheus',
  pluginName='Prometheus',
  description='Prometheus metrics bank'
).addInput(
  name='PROMETHEUS_JOB',
  label='Job',
  type='constant',
  description='Prometheus Tarantool metrics job'
).addInput(
  name='PROMETHEUS_RATE_TIME_RANGE',
  label='Rate time range',
  type='constant',
  value='2m',
  description='Time range for computing rps graphs with rate(). At the very minimum it should be two times the scrape interval.'
).addTemplate(
  grafana.template.custom(
    name='job',
    query='${PROMETHEUS_JOB}',
    current='${PROMETHEUS_JOB}',
    hide='variable',
    label='Prometheus job',
  )
).addTemplate(
  grafana.template.custom(
    name='rate_time_range',
    query='${PROMETHEUS_RATE_TIME_RANGE}',
    current='${PROMETHEUS_RATE_TIME_RANGE}',
    hide='variable',
    label='rate() time range',
  )
).addPanel(
  panels.pending_requests('${DS_PROMETHEUS}'),
  gridPos={ h: 8, w: 8, x: 0, y: 0 }
).addPanel(
  panels.server_load('${DS_PROMETHEUS}'),
  gridPos={ h: 8, w: 16, x: 9, y: 0 }
)
