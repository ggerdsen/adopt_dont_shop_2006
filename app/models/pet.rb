class Pet < ApplicationRecord

  belongs_to :shelter
  has_many :pet_adoptions, dependent: :delete_all
  has_many :adoption_applications, through: :pet_adoptions

  validates_presence_of :image,
                        :name,
                        :age,
                        :sex

  def set_defaults
    self.status  ||= 'Adoptable'
  end

  def self.sort_by_status
    Pet.order(status: :asc)
  end

  def self.with_application
    Pet.select(:name, :id).joins(:pet_adoptions).uniq
  end

end
