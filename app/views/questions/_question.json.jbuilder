json.extract! question, :id, :question, :ansA, :ansB, :ansC, :ansD, :points, :time, :questionUrl, :justification, :created_at, :updated_at
json.url question_url(question, format: :json)
