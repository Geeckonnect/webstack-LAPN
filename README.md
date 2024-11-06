```markdown
# WebStack LAMP Docker

This project provides a Dockerized LAMP stack (Linux, Apache, MySQL, PHP) with PHP 8.1+, Node.js, and necessary PHP extensions for a Symfony-based application. It includes Apache configured to run PHP-FPM, and basic PHP configurations for performance optimization. This stack is designed to be used in conjunction with a reverse proxy and is optimized for Symfony applications and React frontend bundling.

## Prerequisites

- Docker
- Docker Compose (optional)

## Features

- **Debian 12 Slim** as the base image
- **Apache 2.4** with PHP-FPM support (PHP 8.1+)
- **MySQL 8** or external MariaDB database
- **Node.js 20+** for frontend React and asset bundling
- PHP Extensions for Symfony:
  - `php-curl`
  - `php-mbstring`
  - `php-xml`
  - `php-zip`
  - `php-intl`
  - `php-gd`
  - `php-opcache`
  - `php-bcmath`
  - `php-pdo_mysql`
- Configured for **HTTPS** with a self-signed certificate (handled by an external reverse proxy)

## Setup

1. Clone the repository to your local machine:

    ```bash
    git clone https://github.com/YourUsername/webstack-lamp.git
    cd webstack-lamp
    ```

2. Build the Docker image:

    ```bash
    docker build -t webstack-lamp:1.1 .
    ```

3. Run the Docker container:

    ```bash
    docker run -d -p 8080:80 --name web-container webstack-lamp:1.1
    ```

4. Access the application:

    Open your browser and navigate to [http://localhost:8080](http://localhost:8080).

## Configuration

### Apache and PHP Configuration

The Apache server is configured to use PHP-FPM for processing PHP files. The following PHP configurations have been set for optimal performance:

- `memory_limit=512M`
- `upload_max_filesize=10M`
- `post_max_size=12M`
- `max_execution_time=60`
- `opcache.enable=1`

### Node.js and npm

Node.js 16+ is installed for handling frontend tasks, such as React and asset bundling. The latest version of `npm` is also installed globally.

## Notes

- This setup assumes that the **reverse proxy** handling HTTPS is external to the Docker host.
- The container listens on port 8080, which is mapped to port 80 inside the container.
- Make sure to set up the **MariaDB or MySQL** database externally and configure it accordingly in your Symfony `.env` or `.env.local` file.

## Contributing

Feel free to fork the repository, submit issues, and create pull requests for any improvements or bug fixes.

## License

This project is licensed under the MIT License.
```

