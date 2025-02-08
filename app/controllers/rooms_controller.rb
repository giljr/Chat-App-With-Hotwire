class RoomsController < ApplicationController
  before_action :set_room, only: %i[ show edit update destroy ]

  def index
    @rooms = Room.all
  end

  def show
  end

  def new
    @room = Room.new
  end

  def edit
  end

  def create
    @room = Room.new(room_params)
  end

  def update
  end

  def destroy
    @room.destroy!
  end

  private
    def set_room
      @room = Room.find(params.expect(:id))
    end

    def room_params
      params.expect(room: [ :name ])
    end
end
