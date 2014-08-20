class Resource < Sequel::Model
  plugin :timestamps
  plugin :validation_helpers

  def validate
    super
    validates_presence [:heroku_id, :plan, :region, :callback_url]
    validates_unique :heroku_id
  end
end
