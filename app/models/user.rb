class User < ActiveRecord::Base
  enum role: [:guest, :member, :contributer, :moderator, :admin]
  after_initialize :set_default_role, :if => :new_record?

  validates :name, length:{maximum: 30}, allow_blank: false
  validates :name, uniqueness: {case_sensitive: false}

  def set_default_role
    self.role ||= :guest
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
