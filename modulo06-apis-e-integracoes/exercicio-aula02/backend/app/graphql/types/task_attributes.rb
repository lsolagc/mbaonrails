module Types
  class TaskAttributes < Types::BaseInputObject
    description "Attributes for creating or updating a task"
    argument :title, String, "Task title", required: true
    argument :description, String, "Aditional information or context for the task", required: false
    argument :deadline, String, "Date, formatted as YYYY-MM-DD", required: true
  end
end