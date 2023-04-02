namespace :parcel do
  desc 'Generate xlsx file containing parcel, sender, receiver data'
  task :generate_csv => [ :environment ] do
    p "Generating report"
    @parcels = Parcel.includes(:users).references(:users)
    require 'axlsx'

      p = Axlsx::Package.new
      p.workbook.add_worksheet("Parcel Data".to_sym) do |wb|
        wb.add_worksheet("parcel_data_#{Time.now}") do  |ws|
          ws.add_row ["Parcel Data on #{Time.now}"]
          ws.add_row ['Weight', 'Status', 'Service Type', 'Payment Mode', "Cost", "Sender Name", "Sender Email", " Sender Mobile Number", "Receiver Name", "Receiver Email", "Receiver Mobile Number", "Tracking Number"]
          @parcels.each do |parcel|
            ws.add_row ["#{parcel.weight}", "#{parcel.status}", "#{parcel.service_type}", "#{parcel.payment_mode}", "#{parcel.cost}", "#{parcel.sender.name}", "#{parcel.sender.email}", "#{parcel.sender.mobile}", "#{parcel.receiver.name}", "#{parcel.receiver.email}", "#{parcel.receiver.mobile}", "#{parcel.tracking_id}"]
          end
        end
      end
    p.serialize "parcel_data.xlsx"
    Userrecord.create(file: File.open("./public/system/user_records/files/000/000/001/original/parcel_data.xlsx", "r"), file_file_name: "acs_job.xlsx")
     # upload csv into database and we can download this from UI

    # Userrecord(id: integer, file: string, created_at: datetime, updated_at: datetime, file_file_name: string, file_content_type: string, file_file_size: integer, file_updated_at: datetime)
  end
end