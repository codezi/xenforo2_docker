## XenForo 2 with Docker

Installed:
- PHP 8.0.2
  * Mysqli
  * GD
  * Imagick
  * Composer
  * GMP
  * Zip
- Nginx 1.19.6
- Mysql: 8.0.23

### Structure

Put XenForo source code to folder `/xenforo`. Any new add-ons will be stored in folder `/addons`

- XenForo (internal_data, data) store at `.data/xenforo`
- Mysql data store to `.data/mysql`
- Nginx logging store to `.data/nginx`
- XenForo add-ons store at `/addons`

### Installation

Clone this repository to your computer then run
`docker-compose build`

to build images and run `docker-compose up -d` to start web server.

Open browser `http://localhost:25080` and coding...

### Install add-on
To store add-on directories correctly:
- Copy folder `/src/addons/<AddOnId>` to `/addons/<AddOnId>`
- Copy folder `/js/...` to `/xenforo/js/...`
- Copy folder `/styles/...` to `/xenforo/styles/...`

### config.php

Update your XenForo `config.php` with these values.

```php

$config['db']['host'] = 'mysql';
$config['db']['port'] = '3306';
$config['db']['username'] = $_SERVER['MYSQL_USER'];
$config['db']['password'] = $_SERVER['MYSQL_PASSWORD'];
$config['db']['dbname'] = $_SERVER['MYSQL_DATABASE'];

```
