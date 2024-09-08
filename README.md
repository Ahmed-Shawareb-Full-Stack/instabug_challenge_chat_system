# README






# Chat System - Instabug Challenge

This project is a **Chat System** built for the Instabug Challenge. It includes robust management of **Apps**, **Chats**, and **Messages** with a well-structured API to interact with these resources. The project leverages **Ruby on Rails** for the backend, **Sidekiq** for background processing, and **Elasticsearch** for advanced search functionality. It’s fully containerized using **Docker** and utilizes **Redis** for job queuing.

---

## Ruby Version

- **Ruby**: 3.3.4
- **Rails**: 7.2.1

Make sure you have the correct Ruby version installed if you're running this project locally.

---

## System Dependencies

To run the project locally or in production, you need the following dependencies:
- **Docker** and **Docker Compose** (for containerized development)
- **MySQL**: For the database
- **Redis**: Used for job queues in **Sidekiq**
- **Elasticsearch**: For full-text search capabilities

If you're running the project without Docker, make sure to install the following:
- **Bundler**: To install Ruby gems (`gem install bundler`)
- **Node.js**: For JavaScript runtime
- **Yarn**: For managing JavaScript packages
- **MySQL**, **Redis**, and **Elasticsearch** installed locally
# Installation and Run
1. Clone the Repository
2. Open terminal and cd to the repository folder
4. In terminal execute ```docker-compose up```

# API Routes
## App
#### Get all apps
    GEt: /apps
#### Create a new app
    POST: /apps
    Body: { "name": "MyApp" }
#### Get an app by token
    GET /apps/:token
#### Update an app by token
    PUT /apps/:token
    Body: { "name": "UpdatedAppName" }
## Chat
#### Get all chats for an app
    GET /apps/:app_token/chats
#### Create a new chat for an app
    POST: /apps/:app_token/chats
#### Get a chat by its number
    GET: /apps/:app_token/chats/:number
## Messages
#### Get all messages for a chat
    GET: /apps/:app_token/chats/:chat_number/messages
#### Create a new message in a chat
    POST: /apps/:app_token/chats/:chat_number/messages
    Body: { "content": "Hello World" }
#### Get a message by its number
    POST: /apps/:token/chats/:number/messages/:number
    Body: { "content": "Hello World" }
#### Update a message by its number
    POST: /apps/:token/chats/:number/messages/:number
    Body: { "content": "Updated message content" }
#### Search messages within a chat
    POST: /apps/:app_token/chats/:chat_number/messages/search
    Body: { "query": "search term" }
