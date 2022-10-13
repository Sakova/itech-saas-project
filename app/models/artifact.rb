class Artifact < ActiveRecord::Base
  belongs_to :project
  has_one_attached :file

  validates :name,
            presence: true
  validates :file,
            attached: true,
            size: { between: 1.byte..10.megabytes, message: 'is not given between size' }
end