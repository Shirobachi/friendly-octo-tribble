json.extract! question, :id, :question, :ansA, :ansB, :ansC, :ansD, :points, :time, :justificationUrl, :justification, :created_at, :updated_at
json.url question_url(question, format: :json)
