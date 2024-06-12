#!/bin/bash
set -e

# Create mysql user and group if they do not exist
if ! getent group mysql >/dev/null; then
    groupadd -r mysql
fi

if ! getent passwd mysql >/dev/null; then
    useradd -r -g mysql mysql
fi

chown -R mysql:mysql /var/lib/mysql /var/run/mysqld
chmod 755 /var/run/mysqld
chsh -s /bin/bash mysql

# Init MySQL
if [ ! -d "/var/lib/mysql/mysql" ]; then
    gosu mysql mysqld --initialize-insecure
fi

# Run MySQL
gosu mysql mysqld --bind-address=127.0.0.1 --port=3306 "$@" &

# Wait for MySQL to be ready
for i in {30..0}; do
    if mysqladmin ping -h "127.0.0.1" --silent; then
        echo 'MySQL is ready.'
        break
    fi
    echo 'Waiting for MySQL to be ready...'
    sleep 1
done

if [ "$i" = 0 ]; then
    echo >&2 'MySQL start process failed.'
    exit 1
fi

# Set root user password and grant privileges
echo "Set root user password and grant privileges."
mysqladmin -u root password 'ye0401'

mysql=(mysql --protocol=socket -uroot -p'ye0401')
echo "ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'ye0401';" | "${mysql[@]}"
echo "GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost' WITH GRANT OPTION;" | "${mysql[@]}"
echo "FLUSH PRIVILEGES;" | "${mysql[@]}"

# Connect using the new root password
echo "Connect using the new root password."
mysql=(mysql --protocol=socket -uroot -p'ye0401')

# Check if the database exists, create it if not
echo "Check if the database exists, create it if not."
if ! echo 'SHOW DATABASES;' | "${mysql[@]}" | grep -q 'reservation_demo'; then
    echo "Creating database reservation_demo..."
    echo "CREATE DATABASE reservation_demo;" | "${mysql[@]}"
fi

# Import .sql file
echo "Import .sql file."
if [ -f /docker-entrypoint-initdb.d/reservation_demo.sql ]; then
    echo "Importing database from /docker-entrypoint-initdb.d/reservation_demo.sql"
    "${mysql[@]}" reservation_demo </docker-entrypoint-initdb.d/reservation_demo.sql
fi

# Start the Spring Boot application
echo "Start the SpringBoot application."
exec java -jar /app/target/reserve_demo-0.0.1-SNAPSHOT.jar
