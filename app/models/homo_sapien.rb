# == Schema Information
#
# Table name: homo_sapiens
#
#  id                 :integer          not null, primary key
#  appointments_count :integer
#  dogs_count         :integer
#  email              :string
#  net_points         :integer
#  password_digest    :string
#  username           :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
class HomoSapien < ApplicationRecord
  validates :email, :uniqueness => { :case_sensitive => false }
  validates :email, :presence => true
  has_secure_password

  has_many(:dogs, { :class_name => "Dog", :foreign_key => "owner_id", :dependent => :destroy })

  has_many(:appointments, { :class_name => "Appointment", :foreign_key => "dog_watcher_id", :dependent => :nullify })

  validates(:username, { :presence => true })

  validates(:username, { :uniqueness => true })

  # validates(:net_points, { :numericality => true })

  # def dog
  #   return Dog.where({ :owner_id => self.id}).at(0)
  # end
end
