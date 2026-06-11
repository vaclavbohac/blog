json.extract! work_experience, :id, :company, :role, :logo, :started_on, :ended_on, :created_at, :updated_at
json.url admin_work_experience_url(work_experience, format: :json)
