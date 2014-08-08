PEOPLE_URL = "http://thoughtbot.com/people"

namespace :thoughtbot do
  desc "Pull in new thoughtbot people"
  task sync: :environment do
    require 'nokogiri'
    require 'open-uri'

    failures = []
    people_html = open(PEOPLE_URL) { |f| f.read }
    people_doc = Nokogiri::HTML(people_html)

    people_doc.css(".photo-list li img").each do |image|
      person = Person.new(
        image_url: image["src"],
        name: image["alt"]
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
