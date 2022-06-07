local grafana = import 'grafonnet/grafana.libsonnet';

local myGraphPanel(
  title=null,
  datasource=null,
  labelY1=null,
  legend_rightSide=false,
  panel_width=8,
  panel_height=8,
) = grafana.graphPanel.new(
    title=title,
    datasource=datasource,
    min=0,
    labelY1=labelY1,
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
    legend_rightSide=legend_rightSide
) { gridPos: { w: panel_width, h: panel_height } }; # добавим геометрические параметры (но не положение)

{
    pending_requests(
      datasource=null,
      panel_width=null,
      panel_height=null,
    ):: myGraphPanel(
      title='Pending requests',
      datasource=datasource,
      labelY1='pending',
      panel_width=panel_width,
      panel_height=panel_height,
    ).addTarget(
      if datasource == '${DS_PROMETHEUS}' then
        grafana.prometheus.target(
          expr='server_pending_requests{job=~"$job"}',
          legendFormat='{{alias}}',
        )
      else if datasource == '${DS_INFLUXDB}' then
        grafana.influxdb.target(
          measurement='/^$measurement$/',
          group_tags=['label_pairs_alias'],
          alias='$tag_label_pairs_alias',
        ).where('metric_name', '=', 'server_pending_requests')
        .selectField('value').addConverter('mean'),
    ),

    server_load(
      datasource=null,
      panel_width=null,
      panel_height=null,
    ):: myGraphPanel(
      title='Server load',
      datasource=datasource,
      labelY1='rps',
      legend_rightSide=true,
      panel_width=panel_width,
      panel_height=panel_height,
    ).addTarget(
      if datasource == '${DS_PROMETHEUS}' then
        grafana.prometheus.target(
          expr='rate(server_requests_process_count{job=~"$job"}[$rate_time_range])',
          legendFormat='{{alias}}',
        )
      else if datasource == '${DS_INFLUXDB}' then
        grafana.influxdb.target(
          measurement='/^$measurement$/',
          group_tags=['label_pairs_alias'],
          alias='$tag_label_pairs_alias',
        ).where('metric_name', '=', 'server_requests_process_count')
        .selectField('value').addConverter('mean').addConverter('non_negative_derivative', ['1s']),
    ),
}
