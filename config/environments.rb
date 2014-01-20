#The environment variable DATABASE_URL should be in the following format:
# => postgres://{user}:{password}@{host}:{port}/path
configure :production do
	db = URI.parse(ENV['DATABASE_URL'] || 'postgres://localhost/[DBNAME]')
	ActiveRecord::Base.establish_connection(
			:adapter => db.scheme == 'postgres' ? 'postgresql' : db.scheme,
			:host     => db.host,
			:username => db.user,
			:password => db.password,
			:database => db.path[1..-1],
			:encoding => 'utf8'
	)

	CheeseyConfig = YAML::load(File.read('config/production.yml'))
end

configure :stage do
	db = URI.parse(ENV['DATABASE_URL'] || 'postgres://localhost/[DBNAME]')
	ActiveRecord::Base.establish_connection(
			:adapter => db.scheme == 'postgres' ? 'postgresql' : db.scheme,
			:host     => db.host,
			:username => db.user,
			:password => db.password,
			:database => db.path[1..-1],
			:encoding => 'utf8'
	)

	CheeseyConfig = YAML::load(File.read('config/staging.yml'))
end

configure :development do
	db = URI.parse(ENV['DATABASE_URL'] || 'postgres://localhost/sample')
	ActiveRecord::Base.establish_connection(
			:adapter => db.scheme == 'postgres' ? 'postgresql' : db.scheme,
			:host     => db.host,
			:username => db.user,
			:password => db.password,
			:database => db.path[1..-1],
			:encoding => 'utf8'
	)

	CheeseyConfig = YAML::load(File.read('config/development.yml'))
end