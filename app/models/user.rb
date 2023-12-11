class User < ApplicationRecord
  has_many :tools
  has_many :tool_requests
  has_one_attached :photo
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         validates :username, presence: true, uniqueness: true
         validates :address, presence: true

  geocoded_by :address
  has_many :sent_chatrooms, :class_name => 'Chatroom', :foreign_key => 'sender_id'
  has_many :received_chatrooms, :class_name => 'Chatroom', :foreign_key => 'recipient_id'

  after_validation :geocode, if: :will_save_change_to_address?
  has_many :tools
end
