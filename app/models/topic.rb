class Topic < ActiveRecord::Base
  validates :tid, uniqueness:true

  def original_poster_json
    ActiveSupport::JSON.decode(self.raw_json)["posts"][0]["user"]
  end
  
  def original_poster(attribute)
    ActiveSupport::JSON.decode(self.raw_json)["posts"][0]["user"][attribute]
  end

end
