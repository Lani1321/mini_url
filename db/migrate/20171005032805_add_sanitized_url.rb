class AddSanitizedUrl < ActiveRecord::Migration[5.0]
  def change
    add_column :links, :sanitized_url, :string
  end
end
