class Ticket < ActiveRecord::Base
  belongs_to :user
  belongs_to :start_station, class_name: "RailwayStation", foreign_key: :start_station_id
  belongs_to :end_station, class_name: "RailwayStation", foreign_key: :end_station_id
  belongs_to :train

  validates :number, :passenger_name, :passport_number, presence: true
  before_validation :set_number, on: :create

  after_create :send_notification

  private

  def set_number
    syms = ["a".."z", "A".."Z", "0".."9"].map(&:to_a).flatten
    self.number = (0...8).map { syms[rand(syms.size)] }.join
  end

  def send_notification
    TicketsMailer.buy_ticket(user, self).deliver_now
  end
end
