class Task < ApplicationRecord
  include Ransackable
  ransacker :status, formatter: proc {|v| statuses[v]}
  ransacker :created_at do
    Arel.sql("DATE(#{table_name}.created_at)")
  end

  enum :status, { in_progress: 0, overdue: 1, completed: 2, cancelled: 3 }

  validates :title, :description, presence: true

  scope :to_mark_as_overdue, -> { in_progress.where("due_date < ?", Time.current) }

  def self.ransackable_attributes(auth_object = nil)
    ['id', 'title', 'description', 'status', 'created_at', 'due_date']
  end
end
