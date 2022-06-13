local grafana = import 'grafonnet/grafana.libsonnet';

grafana.dashboard.new(
  title='My beautiful dashboard',
  editable=true,
  schemaVersion=21,
).addPanel(
  grafana.graphPanel.new(
    title='Pending requests',
    datasource='-- Grafana --',
    // минимальное отображаемое значение
    min=0,
    // подпись левой оси ординат
    labelY1='pending',
    // интенсивность цвета, заполняющего область под графиком
    fill=0,
    // количество знаков после запятой в значениях
    decimals=2,
    // количество знаков после запятой в значениях на левой оси ординат
    decimalsY1=0,
    // сортировка значений в порядке убывания
    sort='decreasing',
    // легенда в форме таблицы
    legend_alignAsTable=true,
    // выводить значения на легенде
    legend_values=true,
    // выводить на легенде среднее значение
    legend_avg=true,
    // выводить на легенде текущее значение
    legend_current=true,
    // выводить на легенде максимальное значение
    legend_max=true,
    // сортировать в легенде по текущему значению
    legend_sort='current',
    // сортировать в легенде по убыванию
    legend_sortDesc=true,
  ),
  gridPos={ h: 8, w: 8, x: 0, y: 0 },
)
