# Приложение с метриками

Для запуска необходим `docker-compose`.

Чтобы подготовить кластер, запустите следующие команды.

```bash
docker-compose build --no-cache && docker-compose pull
```

# Основы jsonnet

Для установки `jsonnet` необходим `go` или `brew`.

```bash
go install github.com/google/go-jsonnet/cmd/jsonnet@latest
```
```bash
brew install jsonnet
```

Чтобы сгенерировать json, исполните следующую команду.

```bash
jsonnet ./jsonnet/script_1.jsonnet
```

Чтобы поместить результат работы в файл, исполните следующую команду.

```bash
jsonnet ./jsonnet/script_1.jsonnet -o result.json
```

Команды для запуска остальных скриптов.

```bash
jsonnet ./jsonnet/script_2.jsonnet
```

```bash
jsonnet ./jsonnet/script_3.jsonnet
```

```bash
jsonnet ./jsonnet/script_4.jsonnet
```

# Основы grafonnet

Для установки `jb` (jsonnet bundler) необходим `go` или `brew`.

```bash
go install github.com/jsonnet-bundler/jsonnet-bundler/cmd/jb@latest
```
```bash
brew install jsonnet-bundler
```

Для установки зависимостей исполните следующую команду.

```bash
jb install
```

## 1. Минимальный дашборд

Чтобы сгенерировать пустой дашборд, исполните следующую команду.

```bash
jsonnet -J ./vendor ./grafonnet/1/dashboard.jsonnet -o dashboard.json
```

Чтобы запустить кластер, исполните команду
```bash
docker-compose up -d
```

Проект представляет собой простое приложение на Tarantool c метриками,
а также полный мониторинговый стек.

После запуска Grafana будет доступна в браузере по адресу `localhost:3000`.

## 2. Дашборд с панелью

Чтобы сгенерировать дашборд с шаблоном панели, исполните следующую команду.

```bash
jsonnet -J ./vendor ./grafonnet/2/dashboard.jsonnet -o dashboard.json
```

## 3. Параметры визуализации

Чтобы сгенерировать дашборд с шаблоном панели и изменённой визуализацией,
исполните следующую команду.

```bash
jsonnet -J ./vendor ./grafonnet/3/dashboard.jsonnet -o dashboard.json
```

## 4. Запрос к источнику данных

Чтобы сгенерировать дашборд с запросом к Prometheus,
исполните следующую команду.

```bash
jsonnet -J ./vendor ./grafonnet/4/dashboard.jsonnet -o dashboard.json
```

Параметры импорта
- `Prometheus`: `Prometheus`

## 5. Параметризуем запрос

Чтобы сгенерировать дашборд с конфигурируемыми переменными,
исполните следующую команду.

```bash
jsonnet -J ./vendor ./grafonnet/5/dashboard.jsonnet -o dashboard.json
```

Параметры импорта
- `Prometheus`: `Prometheus`
- `job`: `tarantool_app`

## 6. Две панели

Чтобы сгенерировать дашборд с двумя панелями и новыми переменными,
исполните следующую команду.

```bash
jsonnet -J ./vendor ./grafonnet/6/dashboard.jsonnet -o dashboard.json
```

Параметры импорта
- `Prometheus`: `Prometheus`
- `job`: `tarantool_app`
- `rate_time_range`: `2m`

## 7. Функция для создания панели

Чтобы сгенерировать дашборд с использованием функций,
исполните следующую команду.

```bash
jsonnet -J ./vendor ./grafonnet/7/dashboard.jsonnet -o dashboard.json
```

Параметры импорта
- `Prometheus`: `Prometheus`
- `job`: `tarantool_app`
- `rate_time_range`: `2m`

## 8. Поддержка разных источников

Чтобы сгенерировать дашборд для Prometheus, исполните следующую команду.

```bash
jsonnet -J ./vendor ./grafonnet/8/dashboard_prometheus.jsonnet -o dashboard.json
```

Параметры импорта
- `Prometheus`: `Prometheus`
- `job`: `tarantool_app`
- `rate_time_range`: `2m`

Чтобы сгенерировать дашборд для InfluxDB, исполните следующую команду.

```bash
jsonnet -J ./vendor ./grafonnet/8/dashboard_influxdb.jsonnet -o dashboard.json
```

Параметры импорта
- `InfluxDB`: `influxdb`
- `measurement`: `tarantool_app_http`