class TextBook < ActiveRecord::Base
  has_many :training_classes

  def self.type_of(exam_type)
     where(:exam_type => exam_type)
  end
  scope :type_is , ->(exam_type) { where(exam_type:  exam_type)}
end
