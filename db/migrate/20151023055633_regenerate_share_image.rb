class RegenerateShareImage < ActiveRecord::Migration
  def change
    Ziltag.find_each do |ziltag|
      ziltag.generate_share_image!
    end
  end
end
