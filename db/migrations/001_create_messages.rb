# Sequel.migration do
#   up do
#     create_table(:messages) do
#       primary_key :id
# 
#       Text     :content
#       String   :influencer_ip
#       DateTime :received_at
#       DateTime :responded_at
#       Integer  :result_code
#       Text     :log
# 
#       DateTime :created_at
#     end
#   end
# 
#   down do
#     drop_table(:messages)
#   end
# end
#   
