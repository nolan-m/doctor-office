require 'rspec'
require 'doctors'
require 'patients'
require 'specialty'
require 'insurance'
require 'pg'

DB = PG.connect({:dbname => 'doctors_test'})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM patients *;")
    DB.exec("DELETE FROM doctors *;")
    DB.exec("DELETE FROM specialty *;")
    DB.exec("DELETE FROM insurance *;")
  end
end
