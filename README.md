# url_shortner
A lightweight Ruby on Rails application to create short, shareable links from long URLs.

Demo test video 
https://www.awesomescreenshot.com/video/44366182?key=f9ea99fba5f25760c048e335e5a4d2af


---

## Features
- Shorten any valid URL
- Redirect users via `/s/<code>`
- View a list of generated short links
- RESTful API support (JSON responses)

---

## 🛠 Tech Stack
- Ruby 
- Rails 
- PostgreSQL

---
APIs

| Method | Path                              | Description                                 |
| ------ | --------------------------------- | ------------------------------------------- |
| `GET`  | `/`                               | Form to create a new short URL (`urls#new`) |
| `GET`  | `/urls`                           | List all URLs (`urls#index`)                |
| `POST` | `/urls`                           | Create a short URL via form (`urls#create`) |
| `GET`  | `/urls/:id`                       | Show details for a URL (`urls#show`)        |
| `GET`  | `/very/long/sample/path/for/demo` | Example route for testing (`urls#sample`)   |            
| `GET`  | `/:short_url`                     | Redirect to original URL (`urls#redirect`)  |



