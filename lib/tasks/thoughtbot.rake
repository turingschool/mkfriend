namespace :thoughtbot do
  desc "Populate DB from config/people.yml"
  task populate: :environment do
    failures = []

    people = YAML.load(File.new(Rails.root.join("config", "people.yml")))

    people.each do |slug, data|
      person = Person.find_or_initialize_by(slug: slug)

      result = person.update(
        image_url: person_image_url(data["image"], slug),
        name: data["name"],
        title: data["title"],
        bio: data["bio"],
        office: data["office"],
        trivia: (data["trivia"] || []).join(Person::TRIVIA_SEPARATOR)
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

  def person_image_url(image_path, slug)
    image_path = image_path || "#{slug.split('-').first}.jpg"

    if image_path.start_with?("http")
      image_path
    else
      "http://images.thoughtbot.com/team/#{image_path}"
    end
  end
end
