# 📦 NGINX with Load Balancer
<table>
    <tr>
        <td>
            <img src="https://img.shields.io/badge/Nginx-009639?style=for-the-badge&logo=nginx&logoColor=white" />
        </td>
        <td>
            <img src="https://img.shields.io/badge/Docker-2496ED?style=for-the-badge&logo=docker&logoColor=white" />
        </td>
        <td>
            <img src="https://img.shields.io/badge/HTML5-E34F26?style=for-the-badge&logo=html5&logoColor=white" />
        </td>
    </tr>
</table>



## 🚀 Introduction

NGINX is an open-source web server that can also be used as a reverse proxy, providing advanced routing and load balancing features. In this README, we will explore how to configure NGINX as a load balancer to distribute traffic among multiple backend servers.

The project has been configured as follows:

<img width="1000" src="https://res.cloudinary.com/dlxsx2mgd/image/upload/v1715272411/hi5i6x5xq3g4yqnqu3z4.png" alt="project architecture">

## 📋 Prerequesites
> [!IMPORTANT]
> To start this project, you will need Docker and Docker Compose installed on your machine.

### Step 1: Docker Installation
Install Docker on your server. The commands below are for Ubuntu; for other Operating Systems, you should research how to install Docker:

- Ubuntu/Debian:
  ```bash
  sudo apt update
  sudo apt install -y docker.io
  ```

  ```bash
  sudo apt update
  sudo apt install -y docker-compose
  ```

### Step 2: Project Initialization
After configuring the project as necessary, initialize it:

- Ubuntu/Debian:

    ```bash
    docker-compose up --build
    ```

### Step 3: Visualization
After initializing docker-compose, access the following link:

    http://localhost/

The page will update itself.

## 🛠️ Basic NGINX Configuration as a Load Balancer
### Load Balancer Configuration:
Edit the NGINX configuration file, usually located at `/nginx/load-balancer/nginx.conf`, and add the load balancer configuration inside the `http` block:

```nginx
http {
    upstream backend {
        server backend1.example.com;
        server backend2.example.com;
        server backend3.example.com;
    }

    server {
        listen 80;

        location / {
            proxy_pass http://backend;
            proxy_set_header Host $host;
            proxy_set_header X-Real-IP $remote_addr;
        }
    }
}
```

Replace `backend1.example.com`, `backend2.example.com` and `backend3.example.com` with the addresses of your backend servers.

## 📄 Advanced Configuration Options

### Server Weighting
You can configure NGINX to distribute the load in a weighted manner, giving more processing capacity to certain servers. For example:

```nginx
upstream backend {
    server backend1.example.com weight=3;
    server backend2.example.com weight=2;
    server backend3.example.com weight=1;
}
```

In this example, `backend1.example.com` will receive approximately three times more traffic than `backend3.example.com`.

### Health Checks
NGINX can perform health checks on backend servers and automatically remove servers that fail. For example:

```nginx
upstream backend {
    server backend1.example.com;
    server backend2.example.com;
    server backend3.example.com;

    health_check;
}
```

### Session Persistence
To ensure that all requests from the same client are directed to the same backend server, you can use session persistence. For example:

```nginx
upstream backend {
    ip_hash;
    server backend1.example.com;
    server backend2.example.com;
    server backend3.example.com;
}
```


## ✒️ Conclusion
NGINX is a powerful solution for load balancing, offering flexibility and performance to efficiently distribute traffic among multiple backend servers. With proper configuration, you can improve the availability, scalability, and reliability of your web applications.
