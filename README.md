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

### Installation

Clone this repository to your computer then run
`docker-compose build`

to build images and run `docker-compose up -d` to start web server.

Open browser `http://localhost:25080` and coding...