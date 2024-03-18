require 'faker'

ActiveRecord::Base.transaction do 
  # Creating users
  users = []
  100.times do |i|
    user = User.create(
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      username: "#{Faker::Name.first_name.downcase}_#{i+10}",
      email: Faker::Internet.email,
      contact_number: Faker::PhoneNumber.cell_phone_in_e164,
      street_address: Faker::Address.street_address,
      city: Faker::Address.city,
      state: Faker::Address.state,
      country: Faker::Address.country,
      pincode: Faker::Address.postcode,
      date_of_birth: (Date.today + rand(1..30).days) - rand(24..36).years,
      profile_title: User::PROFILE_TITLE.sample,
      password: 'password',
      about: "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like)."
    )
    user.image.attach(io: URI.open(Faker::Avatar.image), filename: 'image.jpg')
    users << user
    puts "User #{i+1} created successfully."

    # Creating work experiences for each user
    3.times do
      user.work_experiences.create(
        start_date: Faker::Date.between(from: 10.years.ago, to: Date.today),
        end_date: Faker::Date.between(from: Date.today, to: Date.today + 5.years),
        job_title: Faker::Job.title,
        employment_type: WorkExperience::EMPLOYMENT_TYPE.sample,
        location: Faker::Address.city,
        location_type:WorkExperience::LOCATION_TYPE.sample,
        currently_working_here: Faker::Boolean.boolean(true_ratio: 0.2),
        description: Faker::Lorem.paragraph(sentence_count: 3),
        company: Faker::Company.name
      )
    end
    puts "Work experiences created for user #{i+1}."
  end
end
