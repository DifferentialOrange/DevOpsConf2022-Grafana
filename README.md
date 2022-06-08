# 0. Приложение с метриками

Для запуска необходим `docker-compose`.

```bash
docker-compose up --build -d
```

Проект представляет собой простое приложение на Tarantool c метриками,
а также полный мониторинговый стек.

После запуска Grafana будет доступна в браузере по адресу `localhost:3000`.

# 1. Основы jsonnet

Для установки `jsonnet` необходим `go`.

```bash
go get github.com/google/go-jsonnet/cmd/jsonnet
```

Чтобы сгенерировать json, исполните следующую команду.

```bash
jsonnet ./1_jsonnet_basics/script_1.jsonnet
```

Чтобы поместить результат работы в файл, исполните следующую команду.

```bash
jsonnet ./1_jsonnet_basics/script_1.jsonnet -o result.json
```

Чтобы поместить результат работы в буфер обмена с помощью `xclip`,
исполните следующую команду.

```bash
jsonnet ./1_jsonnet_basics/script_1.jsonnet | xclip -selection clipboard
```

Команды для запуска остальных скриптов.

```bash
jsonnet ./1_jsonnet_basics/script_2.jsonnet
```

```bash
jsonnet ./1_jsonnet_basics/script_3.jsonnet
```

```bash
jsonnet ./1_jsonnet_basics/script_4.jsonnet
```

# 2. Основы grafonnet

Для установки `jb` (jsonnet bundler) необходим `go`.

```bash
go get github.com/jsonnet-bundler/jsonnet-bundler/cmd/jb
```

Для установки зависимостей исполните следующую команду.

```bash
jb install
```

Чтобы сгенерировать пустой дашборд, исполните следующую команду.

```bash
jsonnet -J ./vendor ./2_grafonnet_basics/dashboard_1_empty.jsonnet -o dashboard.json
```

Чтобы сгенерировать дашборд с шаблоном панели, исполните следующую команду.

```bash
jsonnet -J ./vendor ./2_grafonnet_basics/dashboard_2_panel.jsonnet -o dashboard.json
```

Чтобы сгенерировать дашборд с шаблоном панели и изменённой визуализацией,
исполните следующую команду.

```bash
jsonnet -J ./vendor ./2_grafonnet_basics/dashboard_3_visualization.jsonnet -o dashboard.json
```

Чтобы сгенерировать дашборд с запросом к Prometheus,
исполните следующую команду. Параметр импорта Prometheus: `Prometheus`.

```bash
jsonnet -J ./vendor ./2_grafonnet_basics/dashboard_4_target.jsonnet -o dashboard.json
```

# 3. Углубленный grafonnet

Чтобы сгенерировать дашборд с конфигурируемыми переменными,
исполните следующую команду. Параметр импорта Prometheus: `Prometheus`,
параметр импорта job: `tarantool_app`.

```bash
jsonnet -J ./vendor ./3_grafonnet_advanced/dashboard_5_variables.jsonnet -o dashboard.json
```

Чтобы сгенерировать дашборд с двумя панелями и новыми переменными,
исполните следующую команду. Параметр импорта Prometheus: `Prometheus`,
параметр импорта job: `tarantool_app`, параметр импорта rate time range: `2m`. 

```bash
jsonnet -J ./vendor ./3_grafonnet_advanced/dashboard_6_more_panels.jsonnet -o dashboard.json
```

Чтобы сгенерировать дашборд с использованием функций,
исполните следующую команду. Параметр импорта Prometheus: `Prometheus`,
параметр импорта job: `tarantool_app`, параметр импорта rate time range: `2m`. 

```bash
jsonnet -J ./vendor ./3_grafonnet_advanced/dashboard_7_function.jsonnet -o dashboard.json
```

# 4. Профессиональный grafonnet

Чтобы сгенерировать дашборд для Prometheus, исполните следующую команду.
Параметр импорта Prometheus: `Prometheus`, параметр импорта job: `tarantool_app`,
параметр импорта rate time range: `2m`. 

```bash
jsonnet -J ./vendor ./4_grafonnet_master/dashboard_8_prometheus.jsonnet -o dashboard.json
```

Чтобы сгенерировать дашборд для InfluxDB, исполните следующую команду.
Параметр импорта InfluxDB: `influxdb`, параметр импорта measurement: `tarantool_app_http`.

```bash
jsonnet -J ./vendor ./4_grafonnet_master/dashboard_8_influxdb.jsonnet -o dashboard.json
```
