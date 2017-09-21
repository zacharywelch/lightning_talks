namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    create_users
    create_meetings
    create_talks
    create_comments
    create_favorites
    create_relationships
    create_tags
  end
end

def gravatar_for(user)
  gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
  "https://secure.gravatar.com/avatar/#{gravatar_id}?s=150&d=identicon"
end

def create_users
  User.create(username: "zwelch",
              first_name: "Zachary",
              last_name: "Welch",
              admin: true,
              email: "zwelch154@gmail.com",
              bio: Faker::Name.title) do |user|
    user.avatar_url = gravatar_for(user)
  end

  50.times do
    User.create(username: Faker::Internet.user_name,
                first_name: Faker::Name.first_name,
                last_name: Faker::Name.last_name,
                email: Faker::Internet.email,
                bio: Faker::Name.title) do |user|
      user.avatar_url = gravatar_for(user)
    end
  end
end

def create_meetings
  admin = User.find_by(admin: true)
  locations = ['Townhall', 'Superhero']
  (2.years.ago.year..1.months.from_now.year).each do |year|
    (1..12).each do |month|
      break if Date.new(year, month, 1) > 1.month.from_now
      Meeting.create!(date: Date.new(year, month, 1),
                      title: Date.new(year, month).strftime("%B %Y"),
                      user: admin,
                      location: locations.sample)
    end
  end
end

def create_talks
  users = User.first(25)

  talks = [
    {
      title: "Postcards from GorbyPuff",
      description: "GorbyPuff is setting off on a grand world tour and leaving us clues so we can follow him.",
      overview: "GorbyPuff is setting off on a grand world tour and leaving us clues so we can follow him. Using Google Cloud tools such as Cloud Vision, BigQuery, Google Translate we'll track down Gorby at all his stops. While we're at it we'll learn some tools you can use to add awesome functionality to your web applications."
    },
    {
      title: "3x Rails: Tuning the Framework Internals",
      description: "Matz declared that the next major version of Ruby is going to be 3x faster than Ruby 2.",
      overview: "In this session, we will discuss the ways to survey performance hotspots in each layer of the framework, tuning techniques on the performance issues, and some actual works that you can apply to your apps.

Topics to be covered:
* Speeding up DB queries and model initialization
* View rendering and template lookup
* Routes and URLs
* Object allocations and GC pressure
* Faster Rails boot and testing
* Asset Pipeline tweaks"
    },
    {
      title: "Packaging and Shipping Rails Applications in Docker",
      description: "Docker optimizations and performance tuning techniques to keep your Rails packaging and shipping pipeline in shape.",
      overview: "You’re very happy as a Rails developer for drinking the Docker kool-aid. You just need to toss a Docker image to your Ops team and you're done! However, like all software projects, your Docker containers start to decay. Deployment takes days to occur as you download your gigantic Docker image to production. Everything’s on fire and you can’t launch the rails console inside your Docker container. Isn’t Docker supposed to take all these things away?

    In this talk, I will discuss some Docker optimizations and performance tuning techniques to keep your Rails packaging and shipping pipeline in shape."
    },
    {
      title: "Stuck in the Middle",
      description: "Leverage the power of Rack Middleware",
      overview: "Before a request ever hits your Rails application, it winds its way through a series of pieces of Rack middleware. Middleware sets session cookies, writes your logs, and enables the functionality in many gems such as Warden.

With Rails or any Rack app, you can easily insert your own custom middleware, allowing you to log, track, redirect, and alter the incoming request before it hits your application.

You will leave this talk confident in writing your own custom middleware, better able to troubleshoot gems that rely on middleware and with an understanding of how your Rails app functions."
    },
    {
      title: "Excellence Through Diversity",
      description: "People are different. We see this everywhere.",
      overview: "People are different. We see this everywhere. We often have a hard time setting aside our differences and go in the same direction. But history has shown that the greatest things have been achieved by teams.

When building software, are you looking for the best programmers or for the best team? What tips the balance to hire one person but not the other?

Let’s explore how our differences affect ourselves and others and what we need to build a great team."
    },
    {
      title: "Don't Forget the Network",
      description: "Your app is slower than you think",
      overview: "When you look at your response times, satisfied that they are \"fast enough\", you're forgetting an important thing: your users are on the other side of a network connection, and their browser has to process and render the data that you sent so quickly. This talk examines some often overlooked parts of web applications that can destroy your user experience even when your response times seem fantastic. We'll talk about networks, routing, client and server-side VMs, and how to measure and mitigate their issues."
    },
    {
      title: "Crushing It With Rake Tasks",
      description: "Got a tedious command-line process? Write a rake task for it!",
      overview: "Although bundle exec rake db:migrate is probably the single biggest killer feature in Rails, there is a lot more to rake.

Rails offers several rake tasks to help with everyday project management, like redoing a migration because you changed your mind on one of the columns, clearing your log files because they get so big, and listing out the TODOs and FIXMEs.

What's even more awesome that all that is that you can create your own rake tasks. Got a tedious command-line process? Write a rake task for it!"
    },
    {
      title: "Style Documentation for the Resource-Limited",
      description: "A comprehensive, well-documented styleguide and component library is a utopian ideal.",
      overview: "Application view layers are always hard to manage. Usually we handwave this as the natural consequence of views being where fuzzy user experience and designer brains meet the cleaner, neater logic of computers and developers. But that handwave can be misleading. View layers are hard to manage because they’re the part of a system where gaps in a team’s interdisciplinary collaboration become glaring. A comprehensive, well-documented styleguide and component library is a utopian ideal. Is it possible to actually get there? It is, and we can do it incrementally with minimal refactor hell."
    },
    {
      title: "ActiveRecord vs. Ecto: A Tale of Two ORMs",
      description: "Join us as we compare ActiveRecord from Rails with Ecto from Phoenix, a web framework for Elixir.",
      overview: "They bridge your application and your database. They're object-relational mappers, and no two are alike. Join us as we compare ActiveRecord from Rails with Ecto from Phoenix, a web framework for Elixir. Comparing the same app implemented in both, we'll see why even with two different web frameworks in two different programming languages, it's the differing ORM designs that most affect the result. This tale of compromises and tradeoffs, where no abstraction is perfect, will teach you how to pick the right ORM for your next project, and how to make the best of the one you already use."
    },
    {
      title: "Step 1) Hack, Step 2) ?, Step 3) Profit",
      description: "Hiten & Brad will talk about their culture of empowerment, creativity, and trust.",
      overview: "Hired's mission is to get everyone a job they love. As a transparent marketplace, Hired connects companies and engineers using technology and a personal touch. Initially a weekend hack project, it's grown to help thousands find their dream jobs/teams in 16 cities in 6 countries. From that origin, Hired has regularly focused efforts in hackathons, which have spurred much of the company's innovation.

Hiten & Brad will talk about their culture of empowerment, creativity, and trust and highlight several core features that have grown from small experiments to foundational parts of the experience."
    },
    {
      title: "Surviving the Framework Hype Cycle",
      description: "Baskin-Robbins wishes it had as many flavors as there are JS frameworks.",
      overview: "Baskin-Robbins wishes it had as many flavors as there are JS frameworks, build tools, and cool new \"low-level\" languages. You just want to solve a problem, not have a 500-framework bake-off! And how will you know whether you picked the right one? Don't flip that table, because we'll use the \"hype cycle\" and the history of Ruby and Rails as a guide to help you understand which front-end and back-end technologies are a fit for your needs now and in the future."
    },
    {
      title: "Rails to Phoenix",
      description: "Learn why Phoenix is a great choice for Rails developers.",
      overview: "You may have heard about Phoenix and Elixir. It is a language and framework that give you performance without sacrificing productivity. Learn why Phoenix is a great choice for Rails developers and how you can introduce it into your organization."
    },
    {
      title: "Build Realtime Apps with Ruby & Pakyow",
      description: "Let's explore a way to build realtime apps without writing a single line of JavaScript!",
      overview: "Client-side frameworks dominate the conversation about the future of web apps. Where does that leave us Ruby developers? Let's explore a way to build realtime apps driven by a traditional backend, without writing a single line of JavaScript! You’ll walk away with a new way to build modern, realtime apps employing client-side patterns."
    },
    {
      title: "Multi-table Full Text Search with Postgres",
      description: "Searching content across multiple database tables and columns doesn't have to suck.",
      overview: "Searching content across multiple database tables and columns doesn't have to suck. Thanks to Postgres, rolling your own search isn't difficult.

Following an actual feature evolution I worked on for a client, we will start with a search feature that queries a single column with LIKE and build up to a SQL-heavy solution for finding results across multiple columns and tables using database views.

We will look at optimizing the query time and why this could be a better solution over introducing extra dependencies which clutter your code and need to be stubbed in tests."
    },
    {
      title: "From Zero to API Hero",
      description: "Consuming APIs like a pro",
      overview: "Just like there’s an app for that, there’s an API for that! But not all APIs are created equal, and some APIs are harder to work with than others. In this talk, I will walk through some common gotchas developers encounter when consuming a 3rd party API. I will explain why it’s important to familiarize yourself with the API you’re consuming prior to coding, as well as share tools to help you get acquainted with an API much faster. Lastly, I will go over debugging and testing the API you’re consuming, because testing is not just for the provider of the API!"
    },
    {
      title: "Your First Legacy Codebase",
      description: "How can you get started on an aging codebase when your experience was with greenfield apps?",
      overview: "So you've just graduated from a bootcamp and you're starting your first real job in software development. You've got several Rails apps under your belt and you're excited to get started. But few jobs offer the opportunity to build new apps; it's much more likely that you will be part of a team charged with maintaining and growing a legacy application. How can you get started working on an aging codebase when the sum of your experience so far was with greenfield apps?"
    },
    {
      title: "Can Time-Travel Keep You From Blowing Up The Enterprise?",
      description: "We'll take four journeys from rails new into a reasonable future.",
      overview: "Hindsight is 20/20, and there's a lot of advice out there telling you to do what the author wishes they had done at their last company to avoid disaster. Let's try to follow their advice and see where it lands us.

    We'll take four journeys from rails new into a reasonable future. The first three, \“dedicated team pulling apart the monolith a year later than hoped\”, \"nothin' beats a monolith\", \"services from day one\" will blow up the Enterprise, while the fourth, \“take reasonable steps to let the system evolve\”, won't."
    },
    {
      title: "Testing Rails at Scale",
      description: "The architectural decisions and hard lessons we learned.",
      overview: "It's impossible to iterate quickly on a product without a reliable, responsive CI system. At a certain point, traditional CI providers don't cut it. Last summer, Shopify outgrew its CI solution and was plagued by 20 minute build times, flakiness, and waning trust from developers in CI statuses.

Now our new CI builds Shopify in under 5 minutes, 700 times a day, spinning up 30,000 docker containers in the process. This talk will cover the architectural decisions we made and the hard lessons we learned so you can design a similar build system to solve your own needs."
    },
    {
      title: "How to Build a Skyscraper",
      description: "This talk won't make you an expert skyscraper-builder.",
      overview: "Since 1884, humans have been building skyscrapers. This means that we had 6 decades of skyscraper-building experience before we started building software (depending on your definition of \"software\"). Maybe there are some lessons we can learn from past experience?

This talk won't make you an expert skyscraper-builder, but you might just come away with a different perspective on how you build software."
    },
    {
      title: "Turbo Rails with Rust",
      description: "What does Rust have to offer here over plain-old C? Let's find out!",
      overview: "Ruby is not the fastest language in the world, there is no doubt about it. This doesn't turn out to matter all that much – Ruby and its ecosystem has so much more to offer, making it a worthwhile tradeoff a lot of the times.

However, you might occasionally encounter workloads that are simply not suitable for Ruby. This is especially true for frameworks like Rails, where the overhead wants to be as little as possible.

In this talk, we will explore building a native Ruby extension with Rust to speed up parts of Rails. What does Rust have to offer here over plain-old C? Let's find out!"
    },
    {
      title: "Implementing the LHC on a Whiteboard",
      description: "I'll tell you which rules you should bend in your solutions.",
      overview: "If you apply for a programming job, you may be asked to complete a take home code challenge, \"pair program\" with another developer, and/or sketch out some code on a whiteboard. A lot has been said of the validity and fairness of these tactics, but, company ethics aside, what if you just need a job? In this talk, I'll show you a series of mistakes I have seen in these interview challenges and give you strategies for avoiding them. I'll give recommendations for how you can impress the programmers grading your work and I'll tell you which rules you should bend in your solutions."
    },
    {
      title: "Your software is broken — pay attention",
      description: "Rethink what it means to monitor your application so your team can ship fast with confidence.",
      overview: "Your team has been tasked with releasing new and better versions of your product at record speed. But the risk of moving quickly is things break in production and users abandon your buggy app. To stay competitive, you can't just ship fast - you also have to solve for quality.

We'll rethink what it means to actively monitor your application in production so your team can ship fast with confidence. With the right tooling, workflow, and organizational structures, you don't have to sacrifice release times or stability. When things break, you'll be able to fix errors before they impact your users."
    }
  ]

  Meeting.all.each do |meeting|
    rand(5..15).times do
      talk = talks.sample
      Talk.create(meeting: meeting,
                  user: users.sample,
                  title: talk[:title],
                  description: talk[:description],
                  overview: talk[:overview],
                  category: Talk::CATEGORIES.sample)
    end
  end
end

def create_comments
  users = User.all
  Talk.all.each do |talk|
    rand(1..10).times do
      talk.comments.create!(comment: Faker::StarWars.quote, user: users.sample)
    end
  end

  talk = Talk.last
  talk.comments.create(comment: "I wish I was a sloth :dizzy_face:", user: users.sample)
  talk.comments.create(comment: "This made me rethink my entire life", user: users.sample)
  talk.comments.create(comment: "Post more sloth pics please!", user: users.sample)
  talk.comments.create(comment: "I love sloths! :heart_eyes:", user: users.sample)
  talk.comments.create(comment: "I want to be a sloth when I grow up!", user: users.sample)
  talk.comments.create(comment: "Interesting topic. Looking forward to this talk.", user: users.sample)
end

def create_favorites
  # Make sure at least 5 talks are popular
  talks = Talk.all
  User.first(5).each do |user|
    [talks.last, talks.sample, talks.sample, talks.sample, talks.sample].each do |talk|
      user.favorites.create(talk: talk)
    end
  end

  User.all.each do |user|
    rand(0..20).times do
      begin
        user.favorites.create(talk: talks.sample)
      rescue ActiveRecord::RecordNotUnique
      end
    end
  end
end

def create_relationships
  users = User.all
  150.times do
    user = users.sample
    followed = users.sample
    if user != followed
      user.follow!(followed) unless user.following?(followed)
    end
  end
end

def create_tags
  tags = ['magic', 'rails', 'active record', 'queues', 'json', 'javascript',
          'node', 'react', 'lean', 'ux', 'diversity', 'education',
          'accessibility', 'community', 'ios', 'swift', 'php']

  Talk.all.each do |talk|
    talk.tag_list = tags.sample(rand(1..5)).join(', ')
    talk.save
  end
end
