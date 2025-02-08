# Hotwire Chat App: Scalable Infrastructure with Docker

## Introduction
This guide walks you through setting up a fully containerized infrastructure for a Hotwire-powered chat application using Docker. You will configure PostgreSQL, pgAdmin, and Ruby containers, ensuring smooth communication between services. By the end, your environment will be ready for development and deployment.

---

## Prerequisites
- **Ubuntu** (or any Linux-based system)
- **Docker & Docker Compose** installed
- **VSCode** with **Dev Containers** extension

---

## 1. Cleanup (Optional)
```sh
docker rm -f $(docker ps -a -q)
docker system prune -a
clear
```

## 2. Fetch Ruby Image
```sh
docker pull ruby:3.2.3
ruby -v  # Should return ruby 3.2.3
```

## 3. Set Up File Structure
```sh
mkdir -p ~/Documents/rails_projects/hotwire/chat_app
cd ~/Documents/rails_projects/hotwire/chat_app
code .
```

## 4. Create `docker-compose.yml`
```yaml
services:
  pgadmin_service:
    image: dpage/pgadmin4
    container_name: my-pgadmin
    environment:
      PGADMIN_DEFAULT_EMAIL: admin@example.com
      PGADMIN_DEFAULT_PASSWORD: postgres
    ports:
      - "15432:80"
    networks:
      - my-network
    volumes:
      - ./pgadmin-data:/var/lib/pgadmin

  postgres_service:
    image: postgres
    container_name: my-postgres
    environment:
      POSTGRES_USER: postgres
      POSTGRES_PASSWORD: postgres
      TZ: America/New_York
    ports:
      - "5433:5432"
    networks:
      - my-network
    volumes:
      - ./postgres-data:/var/lib/postgresql/data

  ruby_container:
    image: ruby:latest
    container_name: ruby-container
    stdin_open: true
    tty: true
    command: /bin/bash
    ports:
      - "3001:3000"
    networks:
      - my-network
    volumes:
      - .:/data/chat_app

networks:
  my-network:
    driver: bridge
```

## 5. Set Permissions
```sh
mkdir -p ./pgadmin-data
chmod -R 777 ./pgadmin-data
sudo chown -R $USER:$USER .
clear
```

## 6. Running Docker Compose
```sh
docker compose up --build
```

## 7. Setting Up Rails
Inside the Ruby container:
```sh
apt-get update 
gem install rails 
rails -v  # Should return Rails 8.0.1
```

Create the Rails app:
```sh
cd ..
rails new chat_app -d postgresql
cd chat_app
bundle install
```

## 8. Database Configuration (`config/database.yml`)
```yaml
development:
  adapter: postgresql
  encoding: unicode
  pool: 5
  database: chat_app_development
  username: postgres
  password: postgres
  host: <YOUR_POSTGRES_IP>
  port: 5432
```
Find the PostgreSQL container IP:
```sh
docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' my-postgres
```

## 9. Migrate Database
```sh
rails db:migrate
docker ps -a  # Ensure all services are running
```

## 10. Running the App
```sh
rails s -b 0.0.0.0 -p 3000
```

If port 3000 is in use:
```sh
sudo lsof -i :3000
sudo kill <PID>
```

## 11. Accessing the Application
- **Rails App:** [http://0.0.0.0:3000](http://0.0.0.0:3000)
- **pgAdmin:** [http://localhost:15432](http://localhost:15432) (Login: `admin@example.com` / `postgres`)

---

## Architecture Overview
- **PostgreSQL Container**: Database storage
- **PGAdmin Container**: Web-based database management
- **Ruby Container**: Rails application environment
- **Docker Network**: Ensures inter-container communication

---

## Next Steps
In the next tutorial, we will build the chat application's core functionalities. Stay tuned!

🎉 **Congratulations! Your infrastructure is ready!** 🎉

## License

[MIT](https://choosealicense.com/licenses/mit/)

