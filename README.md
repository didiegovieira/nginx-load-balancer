# 📦 NGINX com Balanceador de Carga
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



## 🚀 Introdução

O NGINX é um servidor web de código aberto que também pode ser utilizado como um proxy reverso, fornecendo recursos avançados de roteamento e balanceamento de carga. Neste README, vamos explorar como configurar o NGINX como um balanceador de carga para distribuir o tráfego entre vários servidores back-end.

O projeto foi configurado da seguinte forma:

<img width="1000" src="https://res.cloudinary.com/dlxsx2mgd/image/upload/v1715272411/hi5i6x5xq3g4yqnqu3z4.png" alt="project architecture">

## 📋 Pré-requisitos
> [!IMPORTANT]
> Para iniciar este projeto, você precisará ter o Docker e o Docker Compose instalados em sua máquina.

### Passo 1: Instalação do Docker
Instale o Docker em seu servidor. Os comandos abaixo são para Ubuntu, em caso de outro Sistema Operacional deve-se pesquisar como instalar o Docker:

- Ubuntu/Debian:
  ```bash
  sudo apt update
  sudo apt install -y docker.io
  ```

  ```bash
  sudo apt update
  sudo apt install -y docker-compose
  ```

### Passo 2: Inicialização do Projeto
Após ter configurado todo o projeto da forma necessária para inicializar

- Ubuntu/Debian:

    ```bash
    docker-compose up --build
    ```

### Passo 3: Visualização
Ao ter inicializado o docker-compose acesse o seguinte link:

    http://localhost/

Atualize a página para ver o balanceamento em funcionamento e verá o background trocar de cor, pois estará acessando outras rotas

## 🛠️ Configuração Básica do NGINX como Balanceador de Carga
### Configuração do Balanceador de Carga:
Edite o arquivo de configuração do NGINX, geralmente localizado em `/nginx/load-balancer/nginx.conf`, e adicione a configuração do balanceador de carga dentro do bloco `http`:

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

Substitua `backend1.example.com`, `backend2.example.com` e `backend3.example.com` pelos endereços dos seus servidores back-end.

## 📄 Opções Avançadas de Configuração

### Ponderação de Servidores
Você pode configurar o NGINX para distribuir a carga de forma ponderada, dando mais capacidade de processamento a determinados servidores. Por exemplo:

```nginx
upstream backend {
    server backend1.example.com weight=3;
    server backend2.example.com weight=2;
    server backend3.example.com weight=1;
}
```

Neste exemplo, `backend1.example.com` receberá aproximadamente três vezes mais tráfego do que `backend3.example.com`.

### Health Checks
O NGINX pode realizar verificações de saúde (health checks) nos servidores back-end e remover automaticamente os servidores que falharem. Por exemplo:

```nginx
upstream backend {
    server backend1.example.com;
    server backend2.example.com;
    server backend3.example.com;

    health_check;
}
```

### Persistência de Sessão
Para garantir que todas as requisições de um mesmo cliente sejam direcionadas para o mesmo servidor back-end, você pode usar a persistência de sessão. Por exemplo:

```nginx
upstream backend {
    ip_hash;
    server backend1.example.com;
    server backend2.example.com;
    server backend3.example.com;
}
```


## ✒️ Conclusão
O NGINX é uma solução poderosa para balanceamento de carga, oferecendo flexibilidade e desempenho para distribuir o tráfego de forma eficiente entre vários servidores back-end. Com a configuração adequada, você pode melhorar a disponibilidade, escalabilidade e confiabilidade de suas aplicações web.
