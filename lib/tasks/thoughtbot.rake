namespace :thoughtbot do
  desc "Populate DB from config/people.yml"
  task populate: :environment do
    failures = []

    people = YAML.load(File.new(Rails.root.join("config", "people.yml")))

    people.each do |slug, data|
      image_path = data["image"] || "#{slug.split('-').first}.jpg"

      image_url = "http://images.thoughtbot.com/team/#{image_path}"

      person = Person.new(
        image_url: image_url,
        name: data["name"],
        title: data["title"],
        bio: data["bio"],
        trivia: (data["trivia"] || []).join(Person::TRIVIA_SEPARATOR)
      )

      unless person.save
        failures << person
      end
    end

    if failures.any?
      failures.each do |person|
        puts "failed to save #{person.name}:"
        puts person.errors.full_messages.join("\n")
      end
    end
  end
end
