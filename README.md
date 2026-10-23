# swoole-base

Swoole on top of the official `php:*-cli-alpine` images, rebuilt weekly so PHP and
Alpine security fixes land without waiting for a new Swoole release.

Includes: swoole (openssl, sockets, mysqlnd, curl hooks), redis, pdo_mysql, pcntl,
sockets, composer.

## Images

| Tag | Swoole | PHP |
|-----|--------|-----|
| `ghcr.io/imefisto/swoole:5.1-php8.3-alpine` | 5.1.8 | 8.3 |
| `ghcr.io/imefisto/swoole:6.1-php8.3-alpine` | 6.1.10 | 8.3 |
| `ghcr.io/imefisto/swoole:6.1-php8.4-alpine` | 6.1.10 | 8.4 |

Each image is also tagged with the exact Swoole version (e.g. `5.1.8-php8.3-alpine`).
The minor tag (`5.1-…`) moves on every rebuild; pin a digest if you need reproducibility.

## Usage

```dockerfile
FROM ghcr.io/imefisto/swoole:5.1-php8.3-alpine
```

Rebuild dependent apps after a base rebuild to pick up the fixes.

## Adding a version

Add a row to the matrix in `.github/workflows/build.yml`.

## Build locally

```bash
docker build --build-arg PHP_VERSION=8.3 --build-arg SWOOLE_VERSION=5.1.8 -t swoole:test .
```
