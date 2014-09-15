class Subject < ActiveRecord::Base
  belongs_to :teacher
  belongs_to :training_class
end
