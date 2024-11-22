require 'csv'

csv_file_path = Rails.root.join('db', 'fixtures/csvs', 'data.csv')

# Load CSV data
puts "Seeding data from #{csv_file_path}..."

CSV.foreach(csv_file_path, headers: true) do |row|
  company = Company.find_or_create_by!(name: row['company']) if row['company'].present?

  # Create the person
  Person.create!(
    first_name: row['first_name'],
    last_name: row['last_name'],
    email: row['email'],
    stage: row['stage']&.downcase,
    phone: row['phone'],
    probability: row['probability'].to_i,
    company: company
  )
end

puts "Seeding complete!"
