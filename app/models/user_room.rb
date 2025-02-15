class UserRoom < ApplicationRecord
  belongs_to :user
  belongs_to :room

  after_commit :broadcast_room, on: :create

  private

  def broadcast_room
    broadcast_append_to(
      'users_rooms_channel',
      target: "user_#{user_id}_rooms",
      partial: 'shared/room', # Ensure this matches the correct partial path
      locals: { room: Room.find(room_id) } # No need to do Room.find(room_id), as `room` is already available
    )
  end
end
