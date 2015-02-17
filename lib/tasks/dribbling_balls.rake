namespace :dribbling_balls do
  desc "Importing Dribbling balls newsletters into website"
  task import: :environment do
    require 'csv'
    path = File.new("#{Rails.root}/lib/dribbling_balls.csv").path
    CSV.foreach(path, col_sep: ';') do |row|
      year, volume, edition, date, pages, comment, digitized, file_size_mb, filename = row
      next if filename.blank?
      
      # ie. urls like: https://s3.amazonaws.com/mubc/dribbling_balls/1974_05_31_volume_002_issue_006.pdf
      url = "https://s3.amazonaws.com/mubc/dribbling_balls/#{filename}"
      file_size_mb = file_size_mb.to_f
      filesize = (file_size_mb < 1) ? "#{(file_size_mb * 1000).to_i}kb" : "#{file_size_mb}mb"
      pdf_details = "#{filesize}, #{pages} pages"
      created_at = Date.parse(date)
      
      NewsItem.find_or_create_by_title(
        author: "The editor",
        title: "Dribbling Balls #{created_at.to_s(:year)} - Volume #{volume} edition #{edition}",
        created_at: created_at,
        synopsis: comment,
        dribbling_balls_link: url,
        content: "<p>#{comment}</p> <p>(#{pdf_details})</p>"
      )
    end
  end
end

