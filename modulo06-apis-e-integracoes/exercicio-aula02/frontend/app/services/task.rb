class Task
  ATTRIBUTES = %i[id title description deadline]

  attr_accessor(*ATTRIBUTES)

  def initialize(task_payload:)
    task_payload = task_payload.with_indifferent_access
    ATTRIBUTES.each do |attr|
      send("#{attr}=", task_payload[attr]) 
    end
    self.deadline = Date.parse(deadline)
  end

  def to_param
    self.id.to_s
  end
end
