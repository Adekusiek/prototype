# title and url are deleted so that we see limited information
json.extract! event, :id, :start, :end, :allDay, :description, :created_at, :updated_at
