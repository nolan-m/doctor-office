require 'spec_helper'

describe Insurance do
  describe 'initialize' do
    it 'initializes with a specialty type' do
      test_insurance = Insurance.new('Blue Cross')
      test_insurance.should be_an_instance_of Insurance
      test_insurance.name.should eq 'Blue Cross'
    end
  end
  it 'allows you to save specialties into the database' do
    test_insurance = Insurance.new('Blue Cross')
    test_insurance.save
    Insurance.all.should eq [test_insurance]
  end
  it 'is the same specialty if it has the same name' do
    test_insurance = Insurance.new('Blue Cross')
    new_insurance = Insurance.new('Blue Cross')
    test_insurance.should eq new_insurance
  end
  it 'returns the id of the Insurance' do
    test_insurance = Insurance.new('Blue Cross')
    test_insurance.save
    test_insurance.id.should be_an_instance_of Fixnum
  end
  it 'pulls id of previously created specialty if new specialty has the same name' do
    test_insurance = Insurance.new('Blue Cross')
    test_insurance.save
    test_specialty2 = Insurance.new('Blue Cross')
    test_specialty2.save
    test_specialty2.id.should eq test_insurance.id
  end

end
