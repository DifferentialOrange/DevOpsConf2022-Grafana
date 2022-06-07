local grafana = import 'grafonnet/grafana.libsonnet';
local panels = import 'dashboard_9_panels.libsonnet';
local positions = import 'dashboard_9_positions.libsonnet';

grafana.dashboard.new(
    title='My clever Prometheus dashboard',
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
).addPanels(
    positions.generate_positions([
        panels.pending_requests(
            datasource='${DS_PROMETHEUS}',
            panel_width=8,
            panel_height=8,
        ),
        panels.server_load(
            datasource='${DS_PROMETHEUS}',
            panel_width=16,
            panel_height=8,
        )
    ])
)
