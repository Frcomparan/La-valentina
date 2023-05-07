json.extract! course, :id, :name, :description, :price, :cover, :user_id, :created_at, :updated_at
json.url course_url(course, format: :json)
json.cover url_for(course.cover)
