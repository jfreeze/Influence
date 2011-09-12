class Message < Sequel::Model#(DB[:messages])

  def before_create # or after_initialize
    super
    self.created_at = Time.now.utc
  end
  
end
