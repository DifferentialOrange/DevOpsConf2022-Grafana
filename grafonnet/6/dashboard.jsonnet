local grafana = import 'grafonnet/grafana.libsonnet';

grafana.dashboard.new(
    title='My two panels dashboard',
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
    pluginId=null,
    pluginName=null,
    description='Prometheus Tarantool metrics job'
).addInput( # начальное значение rate_time_range
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
).addTemplate( # динамическая переменная для использования в запросе
    grafana.template.custom(
        name='rate_time_range',
        query='${PROMETHEUS_RATE_TIME_RANGE}',
        current='${PROMETHEUS_RATE_TIME_RANGE}',
        hide='variable',
        label='rate() time range',
    )
).addPanel(
    grafana.graphPanel.new(
        title='Pending requests',
        datasource='${DS_PROMETHEUS}',
        min=0,
        labelY1='pending',
        fill=0,
        decimals=2,
        decimalsY1=0,
        sort='decreasing',
        legend_alignAsTable=true,
        legend_values=true,
        legend_avg=true,
        legend_current=true,
        legend_max=true,
        legend_sort='current',
        legend_sortDesc=true,
    ).addTarget(
        grafana.prometheus.target(
            expr='server_pending_requests{job=~"$job"}',
            legendFormat='{{alias}}',
        )
    ),
    gridPos = { h: 8, w: 8, x: 0, y: 0 }
).addPanel( # график нагрузки на сервер
    grafana.graphPanel.new(
        title='Server load',
        datasource='${DS_PROMETHEUS}', 
        min=0,
        labelY1='rps',
        fill=0,
        decimals=2,
        decimalsY1=0,
        sort='decreasing',
        legend_alignAsTable=true,
        legend_avg=true,
        legend_current=true,
        legend_max=true,
        legend_values=true,
        legend_sort='current',
        legend_sortDesc=true,
        legend_rightSide=true,
    ).addTarget(
        grafana.prometheus.target(
            # использовать данные за период rate_time_range для вычисления изменений
            expr='rate(server_requests_process_count{job=~"$job"}[$rate_time_range])',
            legendFormat='{{alias}}',
        )
    ),
    # разместить панель справа от первой на том же уровне
    gridPos = { h: 8, w: 16, x: 9, y: 0 }
)
