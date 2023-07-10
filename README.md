
## Laravel Docker Performance Template

Auther: Emad Zaamout

Uses PHP-FPM, Nginx, Op_cache, MySQL DB.

Pull this repository

Run `make fresh` to build and run using DEV containers.
Run `make fresh-prod` to build and run using PROD containers.

in your browser, visit http://127.0.0.1:9000/

Run `make` to see all supported commands.

````
    Usage:
    make <target>

    Targets:
    help           Print help.
    ps             Show containers.
    build          Build all containers for DEV
    build-prod     Build all containers for PROD
    start          Start all containers
    fresh          Destroy & recreate all uing dev containers.
    fresh-prod     Destroy & recreate all using prod containers.
    stop           Stop all containers
    restart        Restart all containers
    destroy        Destroy all containers
    ssh            SSH into PHP container
    install        Run composer install
    migrate        Run migration files
    migrate-fresh  Clear database and run all migrations
    tests          Run all tests
    tests-html     Run tests and generate coverage. Report found in reports/index.html
````