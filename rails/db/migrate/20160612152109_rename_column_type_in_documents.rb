class RenameColumnTypeInDocuments < ActiveRecord::Migration[5.0]
  def change
    rename_column :documents, :type, :document_type
  end
end
