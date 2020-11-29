# == Schema Information
#
# Table name: dogs
#
#  id                 :integer          not null, primary key
#  appointments_count :integer
#  name               :string
#  photo              :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  owner_id           :integer
#
class Dog < ApplicationRecord
  belongs_to(:human, { :required => false, :class_name => "HomoSapien", :foreign_key => "owner_id", :counter_cache => true })

  has_many(:appointments, { :class_name => "Appointment", :foreign_key => "dog_id", :dependent => :destroy })

  validates(:owner_id, { :numericality => true })

  validates(:owner_id, { :presence => true })

  validates(:name, { :presence => true })

  class Dog < ActiveRecord::Base
    mount_uploader :photo, PhotoUploader
  end

  def owner
    return HomoSapien.where({ :id => self.owner_id}).at(0)
  end
  
end

