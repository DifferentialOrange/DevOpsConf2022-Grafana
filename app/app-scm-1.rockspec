package = 'app'
version = 'scm-1'
source  = {
    url = '/dev/null',
}
-- Put any modules your app depends on here
dependencies = {
    'tarantool',
    'lua >= 5.1',
    'http == 1.2.0-1',
    'metrics == 0.13.0-1',
}
build = {
    type = 'none';
}
