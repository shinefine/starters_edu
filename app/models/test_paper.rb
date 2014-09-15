class TestPaper < ActiveRecord::Base

  has_many :sections

  has_and_belongs_to_many :students


  accepts_nested_attributes_for :sections  ,:reject_if => lambda { |a| a[:name].blank? },
                                allow_destroy: true


  validates :exam_type,presence: true
  validates :name,presence: true

end
