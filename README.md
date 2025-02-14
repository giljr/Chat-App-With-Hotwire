# Turbo-Powered Chat Rooms with Hotwire - Episode 4

### Overview

This tutorial walks through creating real-time chat rooms in a Rails app using Turbo Frames and Turbo Streams.

### Features
```
Turbo Frames: Seamlessly update UI elements

Turbo Streams: Real-time room creation and updates

Stimulus: Enhance form handling
```
### Setup

Clone the repository:
```
git clone <repo-url>
cd chat_app
bundle install
rails db:setup
```
Start the Rails server:
```
rails s
```
### Implementation Steps

#### 1. Display the "Create Room" Button

Wrap the button in a Turbo Frame:
```
<%= turbo_frame_tag 'room_form' do %>
  <section>
    <h3>Start a new conversation</h3>
    <%= link_to 'Create Room', new_room_path, class: 'button' %>
  </section>
<% end %>
```
#### 2. Load the Room Creation Form

In rooms/new.html.erb:
```
<%= turbo_frame_tag 'room_form' do %>
  <h4>Create Room</h4>
  <%= render "form", room: @room %>
<% end %>
```
#### 3. Submit the Form (Turbo Streams)

Handle room creation in rooms_controller.rb:
```
def create
  @room = Room.new(room_params)
  respond_to do |format|
    if @room.save
      format.turbo_stream { render turbo_stream: turbo_stream.append('rooms', partial: 'shared/room', locals: { room: @room }) }
    else
      format.turbo_stream { render turbo_stream: turbo_stream.replace('room_form', partial: 'rooms/form', locals: { room: @room }) }
    end
  end
end
```
#### 4. Display Created Rooms

In _user_rooms.html.erb:
```
<div id="rooms">
  <% @rooms.each do |room| %>
    <%= render 'shared/room', room: room %>
  <% end %>
</div>
```
#### 5. Show Room Details & Allow Updates

In _room.html.erb:
```
<%= turbo_frame_tag "room_#{room.id}" do %>
  <div>
    <%= room.name %>
    <%= link_to 'Edit', edit_room_path(room), class: 'edit-btn' %>
  </div>
<% end %>
```
#### 6. Reset the Form After Submission (Stimulus)

Create form_controller.js:
```
import { Controller } from "@hotwired/stimulus"
export default class extends Controller {
  resetComponent() {
    setTimeout(() => this.element.reset(), 75);
  }
}
```
Use it in the form:
```
<%= form_with model: @room, data: { controller: 'form', action: 'submit->form#resetComponent' } do |f| %>
```
#### 7. Validate Room Name

In room.rb:
```
class Room < ApplicationRecord
  validates :name, presence: true
end
```
#### 8. Update Rooms via Turbo Streams

In rooms_controller.rb:
```
def update
  if @room.update(room_params)
    render turbo_stream: turbo_stream.replace("room_#{@room.id}", partial: 'shared/room', locals: { room: @room })
  else
    render :edit
  end
end
```
#### Final Thoughts

With Turbo and Stimulus, we built a chat app with real-time updates and smooth UI interactions. 🚀

