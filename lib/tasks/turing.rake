namespace :turing do
  desc "Populate DB from config/people.yml"
  task populate: :environment do
    failures = []

    people = YAML.load(File.new(Rails.root.join("config", "people.yml")))

    people.each do |slug, data|
      person = Person.find_or_initialize_by(slug: slug)

      result = person.update(
        image_url: data["image_url"],
        name: data["name"],
        title: data["title"],
        bio: data["bio"],
        cohort: data["cohort"],
      )

      unless result
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
