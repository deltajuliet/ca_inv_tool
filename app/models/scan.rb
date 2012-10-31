class Scan < ActiveRecord::Base
  attr_accessible :date, :finished, :imported, :title
end
