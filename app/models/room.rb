class Room < ApplicationRecord
    validates :name, presence: true

    has_many :user_rooms
    has_many :users, through: :user_rooms

    after_update_commit :update_room_details

    private

    def update_room_details
        broadcast_replace_to(
            'update_room_details',
            partial: 'shared/room',
            locals: { room: self },
            target: "room_#{self.id}"
        )
    end
end
