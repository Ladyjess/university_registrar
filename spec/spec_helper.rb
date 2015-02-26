require 'rspec'
require 'pg'
require 'student'
require 'course'
require 'pry'


DB = PG.connect({:dbname => "university_registrar_test"})


RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM courses *;")
    DB.exec("DELETE FROM students*;")
  end
end
