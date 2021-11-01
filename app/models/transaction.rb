class Transaction < ApplicationRecord

  belongs_to :users, optional: true
  belongs_to :songs, optional: true

  def song_name
  	Song.where(song_id: self.song_id)
  end
  
end
