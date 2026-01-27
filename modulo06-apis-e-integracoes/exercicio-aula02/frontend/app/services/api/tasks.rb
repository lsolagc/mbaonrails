module Api
  class Tasks
    class << self
      def get_index(fields:)
        fields.map!(&:to_s)
        body = {
          query: "{ tasks { #{fields.join("\n")} } }"
        }.to_json
        Client.post("/graphql", body: )
      end

      def create_task(input_hash:, return_fields:)
        return_fields = return_fields.map!(&:to_s).join("\n")
        body = {
          query: <<~JSON,
            mutation CreateTask($input: CreateTaskInput!) {
              createTask(input: $input) {
                task {
                  #{return_fields}
                }
              }
            }
          JSON
          variables: {
            input: input_hash.except(:id)
          }
        }.to_json
        Client.post("/graphql", body: )
      end

      def update_task(input_hash:, return_fields:)
        return_fields = return_fields.map!(&:to_s).join("\n")
        body = {
          query: <<~JSON,
            mutation UpdateTask($input: UpdateTaskInput!) {
              updateTask(input: $input) {
                task {
                  #{return_fields}
                }
              }
            }
          JSON
          variables: {
            input: {
              id: input_hash["id"],
              attributes: input_hash["task"]
            }
          }
        }.to_json
        Client.post("/graphql", body: )
      end

      def destroy_task(id:)
        input_hash = {id:}
        body = {
          query: <<~JSON,
            mutation DestroyTask($input: DestroyTaskInput!) {
              destroyTask(input: $input) {
                id
              }
            }
          JSON
          variables: {
            input: input_hash
          }
        }.to_json
        Client.post("/graphql", body: )        
      end
    end
  end
end
