class CreateSampleTable < ActiveRecord::Migration
  def up
  	create_table "samples", primary_key: "sample_id", force: true do |t|
		t.string   "name"
	end
  end

  def down
  	delete_table "samples"
  end
end
