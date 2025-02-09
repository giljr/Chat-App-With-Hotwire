## Styling the Sidebar & Mastering Hotwire Integration - Episode 2
### Enhancing UI with Hotwire and Crafting a Sleek Sidebar


In this episode, we'll pick up from where we left off and dive into enhancing the UI

using Hotwire and creating a sleek sidebar for our chat app. 

Let's get started!

---

#### 1. Why Turbo Frame?

Turbo Frames ensure that when actions related to `rooms_controller` happen, only the section of the page within the Turbo Frame updates dynamically without refreshing the entire page.

#### 1: Room Index
Edit the `app/views/rooms/index.html.erb` file to include a Turbo Frame:

```erb
<%= turbo_frame_tag 'rooms_controller' do %>
  <main class="bg-indigo-100 flex w-full h-screen">
    <%= render "shared/side_bar" %>
    
    <section class="flex flex-col items-center justify-center gap-5 h-screen">
      <%= link_to "New room", new_room_path, class: "rounded-md px-3.5 py-2.5 bg-blue-600 hover:bg-blue-500 text-white block font-medium" %>
    </section>
  </main>
<% end %>
```
Explanation:

    This code defines a Turbo Frame and wraps a section of the UI inside it, enabling dynamic updates of just this section.

##### Follow the First Rule of Turbo
```
Rule #1: When clicking a link within a Turbo Frame, Turbo expects a frame with the identical ID on the target page.
```
#### 2: New Room View

In app/views/rooms/new.html.erb, add the following:
```
<%= turbo_frame_tag 'rooms_controller' do %>
  <% content_for :title, "New room" %>

  <div class="md:w-2/3 w-full">
    <h1 class="font-bold text-4xl">New room</h1>

    <%= render "form", room: @room %>

    <%= link_to "Back to rooms", rooms_path, class: "ml-2 rounded-md px-3.5 py-2.5 bg-gray-100 hover:bg-gray-50 inline-block font-medium" %>
  </div>
<% end %>
```
#### 3. Create Sidebar Partial

Create the sidebar with a room creation section in app/views/shared/_side_bar.html.erb:
```
<nav class="w-60 flex flsx-col items-center justify-center border border-blue-500">
 <%= render "shared/create_room" %>
</nav>
```
#### 4. Create Room Form Partial

Create the room creation form in app/views/shared/_create_room.html.erb:

<h3>Create Room</h3>

#### 5. Design the Left Sidebar

Modify the app/views/shared/_create_room.html.erb partial to display the "Create Room" link:
```
<%= turbo_frame_tag 'room_form' do %>
    <section class="flex flex-col items-center justify-center gap-2 mb-5">
        <h3 class="font-semibold text-sm text-center">Want to start a new conversation?</h3>    
        <%= link_to 'Create Room', new_room_path,  id:'new_room', class: 'px-3 py-1 bg-green-200 font-semiblod text-sm' %>
    </section>
<% end %>
```
Update app/views/rooms/new.html.erb accordingly:
```
<%= turbo_frame_tag 'room_form' do %>
  <% content_for :title, "New room" %>

  <div class="md:w-2/3 w-full">
    <h1 class="font-bold text-4xl">New room</h1>

    <%= render "form", room: @room %>

    <%= link_to "Back to rooms", rooms_path, class: "ml-2 rounded-md px-3.5 py-2.5 bg-gray-100 hover:bg-gray-50 inline-block font-medium" %>
  </div>
<% end %>
```
#### 6. Improving the Design

Refine the design in app/views/shared/_create_room.html.erb:
```
<%= turbo_frame_tag 'room_form' do %>
    <section class="flex flex-col items-center justify-center gap-2 mb-5 text-center">
      <h3 class="font-semibold text-xs">Want to start a new conversation?</h3>    
      <%= link_to 'Create Room', new_room_path, id: 'new_room', class: 'px-3 py-1 bg-green-200 font-semibold text-xs' %>
    </section>
<% end %>
```
Update app/views/rooms/new.html.erb to display a better layout:
```
<%= turbo_frame_tag 'room_form' do %>
  <h4 class="text-sm">New room</h4>
  <%= render "form", room: @room %>
<% end %>
```
#### 7. Render Two Partials in the Sidebar

Now, we will render two partials inside the sidebar. Edit app/views/shared/_side_bar.html.erb:
```
<nav class="w-60 flex flex-col items-start justify-between border border-blue-500">
  <!-- Render "My Rooms" section at the top -->
  <%= render "shared/user_rooms" %>

  <!-- Render the room form section at the bottom -->
  <%= turbo_frame_tag 'room_form' do %>
    <section class="flex flex-col items-center justify-center gap-2 mb-5 text-center mt-auto">
      <h3 class="font-semibold text-xs">Want to start a new conversation?</h3>    
      <%= link_to 'Create Room', new_room_path, id: 'new_room', class: 'px-3 py-1 bg-green-200 font-semibold text-xs' %>
    </section>
  <% end %>
</nav>
```
#### 8. Create Partial to Display List of User's Rooms

In Rails Console, create some rooms:
```
rails c
Room.create(name: "Room 1")
Room.create(name: "Room 2")
Room.all.count
```
Create the partials to display the rooms:
app/views/shared/_user_rooms.html.erb:
```
<section class="flex flex-col w-full items-center">
    <h3 class="text-xs font-semibold mt-3 text-center mb-2">My Rooms</h3>

    <div class="flex flex-col px-5 gap-2 w-full">
        <% @rooms.each do |room| %>
            <%= render 'shared/room', room: room %>
        <% end %>
    </div>
</section>
```
app/views/shared/_room.html.erb:
```
<div class="font-semibold text-xs">
    <%= room.name %>
</div>
```
Conclusion

In the next episode, we'll implement streams to automatically update the room list when a new room is created by the user.

But that's all for now!
License

This project is licensed under the MIT License - see the LICENSE file for details.
## License

[MIT](https://choosealicense.com/licenses/mit/)

