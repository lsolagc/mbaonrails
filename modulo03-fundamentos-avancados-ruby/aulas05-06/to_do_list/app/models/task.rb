class Task < ApplicationRecord
  enum :status, { in_progress: 0, overdue: 1, completed: 2, cancelled: 3 }

  validates :title, :description, presence: true
end
