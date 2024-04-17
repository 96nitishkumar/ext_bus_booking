class CreatePolicyBlockPrivacyPolocies < ActiveRecord::Migration[7.0]
  def change
    create_table :policy_block_privacy_polocies do |t|
      t.string :title
      t.text :description

      t.timestamps
    end
  end
end
