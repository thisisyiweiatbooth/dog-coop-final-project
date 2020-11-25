# == Schema Information
#
# Table name: appointments
#
#  id             :integer          not null, primary key
#  end_date       :datetime
#  points_earned  :integer
#  start_date     :datetime
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  dog_id         :integer
#  dog_watcher_id :integer
#
class Appointment < ApplicationRecord

  belongs_to(:dog_watcher, { :required => false, :class_name => "HomoSapien", :foreign_key => "dog_watcher_id", :counter_cache => true })

  # belongs_to(:dog, { :required => false, :class_name => "Dog", :foreign_key => "dog_id", :counter_cache => true })

  validates(:start_date, { :presence => true })

  validates(:end_date, { :presence => true })

  # validates(:dog_watcher_id, { :numericality => true })

  def dog
   return Dog.where({ :id => self.dog_id}).at(0)
  end

  # def requester
  #   dog_requested = Dog.where({ :id => self.dog_id}).at(0)
  #   dog_requested_name = dog_requested.name
  #   return HomoSapien.where({ id => self.})
  # end 
end
