local grafana = import 'grafonnet/grafana.libsonnet';

grafana.dashboard.new(
    title='My dashboard',
    # разрешить пользователю делать изменения в Grafana
    editable=true,
    # избавляет от проблем при импорте в Grafana различных версий
    schemaVersion=21,
).addPanel(
    grafana.graphPanel.new(
        title='My first graph',
        # набор демонстрационных данных
        datasource='-- Grafana --'
    ),
    # задаёт положение и размеры панели
    gridPos = { h: 8, w: 8, x: 0, y: 0 }
)
