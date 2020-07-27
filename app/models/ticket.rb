class Ticket < ApplicationRecord
  scope :users_ticket, ->(user_id) {where('user_id = ?', user_id)}
end
