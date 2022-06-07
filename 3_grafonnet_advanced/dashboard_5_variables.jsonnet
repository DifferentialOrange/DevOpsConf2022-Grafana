local grafana = import 'grafonnet/grafana.libsonnet';

grafana.dashboard.new(
    title='My dashboard',
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
).addInput( # строковая константа, которая заполняется на импорте
    name='PROMETHEUS_JOB',
    label='Job',
    type='constant',
    pluginId=null,
    pluginName=null,
    description='Prometheus Tarantool metrics job'
).addTemplate(
    grafana.template.custom( # динамическая переменная
        # имя переменной для использования в коде дашборда
        name='job',
        # задаёт начальное значение динамической переменной из переменной импорта
        query='${PROMETHEUS_JOB}',
        current='${PROMETHEUS_JOB}',
        # не отображать переменную на экране с панелями
        hide='variable',
        # имя переменной в UI
        label='Prometheus job',
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
            # используем переменную в запросе
            expr='server_pending_requests{job=~"$job"}',
            legendFormat='{{alias}}',
        )
    ),
    gridPos = { h: 8, w: 8, x: 0, y: 0 }
)
