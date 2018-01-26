class EventConfirmation < ApplicationRecord
        validates :name, :email, :phone, :event, presence: true
        validates_format_of :email, :with => /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i
        belongs_to :event
        self.per_page = 10

        def self.to_csv(options = {})
                CSV.generate(options) do |csv|
                        csv << column_names
                        all.each do |record|
                                csv << record.attributes.values_at(*column_names)
                        end
                end
        end

end
