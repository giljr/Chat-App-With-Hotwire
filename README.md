# Tailwind & Devise & Registrations Setup - Episode 1

## Overview

In this episode, we will install and configure **Tailwind CSS** and **Devise** for user authentication in a Ruby on Rails application. Additionally, we will manage user sessions and style the sign-up/sign-in forms.

## Setup Instructions

### 1. Branching
Switch to the project branch for this episode:
```bash
git checkout -b episode-1-tailwind-and-devise
```
### 2. Installing Tailwind CSS

Install Tailwind CSS in your Rails application:
```
bundle add tailwindcss-rails
rails tailwindcss:install
```
Start the Rails server:
```
rails server -b 0.0.0.0 -p 3000
```
Test the setup:
```
rails g controller pages index
```
Add the following to config/routes.rb:
```
root 'pages#index'
```
In the app/views/pages/index.html.erb file:
```
<h1 class="text-3xl font-bold underline">Hello world!</h1>
```
Recompile assets:
```
rails assets:precompile
```
Alternatively, you can use the Tailwind CDN:
```
<script src="https://cdn.tailwindcss.com"></script>
```
### 3. Installing Devise

Install the Devise gem:
```
bundle add devise
rails generate devise:install
rails g devise User
rails db:migrate
rails g devise:views
```
Start the Rails server:
```
rails server -b 0.0.0.0 -p 3000
```
### 4. Authenticating Users

In app/controllers/pages_controller.rb, add:
```
before_action :authenticate_user!
```
### 5. Styling the Forms

Customize the Sign-Up and Sign-In forms using Tailwind CSS:
```
    app/views/devise/registrations/new.html.erb
    app/views/devise/sessions/new.html.erb
```
### 6. Removing Unnecessary Pages

Clean up by removing the scaffolded page controller:
```
rails d scaffold page
rails g scaffold Room name
```
Set the Room index page as the root in config/routes.rb:
```
root "rooms#index"
```
### 7. Sidebar

Create a sidebar in app/views/shared/_side_bar.html.erb:
```
<p>Side Bar</p>
```
### 8. Clean Up

Remove unnecessary JSON files and clean up the controller actions in app/controllers/rooms_controller.rb.
Next Steps

In the next episode, we will explore Hotwire and integrate the sidebar into the real app.

For the full source code and to get started, visit the repo.
## License

[MIT](https://choosealicense.com/licenses/mit/)

