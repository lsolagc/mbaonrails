# frozen_string_literal: true

module Mutations
  class DestroyTask < BaseMutation
    # TODO: define return fields
    field :id, ID

    # TODO: define arguments
    argument :id, ID, required: true

    # TODO: define resolve method
    def resolve(id:)
      Task.find(id).destroy
      {
        id: id
      }
    end
  end
end
