json.extract! question,
              :id,
              :user_id,
              :course_id,
              :text,
              :status,
              :created_at,
              :created_at,
              :updated_at
json.url question_url(question, format: :json)
