require 'spec_helper'

describe Specialty do
  describe 'initialize' do
    it 'initializes with a specialty type' do
      test_specialty = Specialty.new('Cancer')
      test_specialty.should be_an_instance_of Specialty
      test_specialty.specialty.should eq 'Cancer'
    end
  end
  it 'allows you to save specialties into the database' do
    test_specialty = Specialty.new('Cancer')
    test_specialty.save
    Specialty.all.should eq [test_specialty]
  end
  it 'is the same specialty if it has the same name' do
    new_specialty1 = Specialty.new('Cancer')
    new_specialty2 = Specialty.new('Cancer')
    new_specialty1.should eq new_specialty2
  end
  it 'returns the id of the Specialty' do
    test_specialty = Specialty.new('Cancer')
    test_specialty.save
    test_specialty.id.should be_an_instance_of Fixnum
  end
  it 'pulls id of previously created specialty if new specialty has the same name' do
    test_specialty = Specialty.new('Cancer')
    test_specialty.save
    test_specialty2 = Specialty.new('Cancer')
    test_specialty2.save
    test_specialty2.id.should eq test_specialty.id
  end

end
