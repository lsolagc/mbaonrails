# frozen_string_literal: true

module Mutations
  class CreateTask < BaseMutation
    # TODO: define return fields
    # field :post, Types::PostType, null: false
    field :task, Types::TaskType

    # TODO: define arguments
    # argument :name, String, required: true
    argument :title, String, required: true
    argument :description, String, required: false
    argument :deadline, String, required: true

    # TODO: define resolve method
    def resolve(title:, description: nil, deadline:)
      parsed_deadline = Date.parse(deadline)
      task = Task.new(title:, description:, deadline: parsed_deadline)
      if task.save
        {
          task: task,
          errors: []
        }
      else
        {
          task: nil,
          errors: task.errors.full_messages
        }
      end
    end
  end
end
