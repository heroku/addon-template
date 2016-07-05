class Resource < Sequel::Model
  plugin :timestamps, update_on_create: true
  plugin :validation_helpers

  def validate
    super
    validates_presence [:heroku_id, :plan, :region, :callback_url]
    validates_unique :heroku_id
  end
end
