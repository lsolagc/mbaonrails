# frozen_string_literal: true

module Mutations
  class UpdateTask < BaseMutation
    # TODO: define return fields
    field :task, Types::TaskType

    # TODO: define arguments
    argument :id, ID, required: true
    argument :attributes, Types::TaskAttributes, required: true

    # TODO: define resolve method
    def resolve(id:, attributes:)
      task = Task.find(id)
      if task.update(attributes.to_h)
        { task: task }
      else
        raise GraphQL::ExecutionError, task.errors.full_messages.join(", ")
      end
    end
  end
end
