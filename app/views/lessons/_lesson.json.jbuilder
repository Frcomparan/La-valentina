# frozen_string_literal: true

json.extract! lesson, :id, :title, :descripcion, :cover, :video, :course_id, :created_at, :updated_at
json.url lesson_url(lesson, format: :json)
json.cover url_for(lesson.cover)
json.video url_for(lesson.video)
