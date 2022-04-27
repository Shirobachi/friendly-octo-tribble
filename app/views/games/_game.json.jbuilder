json.extract! game, :id, :name, :status, :created_at, :updated_at
json.url game_url(game, format: :json)
