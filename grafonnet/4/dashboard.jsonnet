local grafana = import 'grafonnet/grafana.libsonnet';

grafana.dashboard.new(
    title='My dashboard with target',
    editable=true,
    schemaVersion=21,
    time_from='now-30m'
).addInput( # добавить переменную импорта
    # имя переменной для использования в коде дашборда
    name='DS_PROMETHEUS',
    # имя переменной на экране импорта
    label='Prometheus',
    # переменная для задания источника данных
    type='datasource',
    # плагин для Prometheus
    pluginId='prometheus',
    pluginName='Prometheus',
    # описание переменной на экране импорта
    description='Prometheus metrics bank'
).addPanel(
    grafana.graphPanel.new(
        title='Pending requests',
        # использовать значение переменной в качестве источника
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
            expr='server_pending_requests',
            legendFormat='{{alias}}',
        )
    ),
    gridPos = { h: 8, w: 8, x: 0, y: 0 }
)
