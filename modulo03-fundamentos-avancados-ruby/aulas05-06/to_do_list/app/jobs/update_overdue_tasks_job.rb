class UpdateOverdueTasksJob < ApplicationJob
  queue_as :default

  def perform(*args)
    Task.to_mark_as_overdue.find_each do |task|
      task.update(status: :overdue)
      Rails.logger.info "Task #{task.id} marked as overdue."
      puts "Task #{task.id} marked as overdue."
    end
  end
end
