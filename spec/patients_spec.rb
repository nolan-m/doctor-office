require 'spec_helper'

describe Patient do
  describe 'initialize' do
    it 'initializes with a name, phone number, and doctor id' do
      test_patient = Patient.new('Boris','222-555-1234', 1)
      test_patient.should be_an_instance_of Patient
      test_patient.name.should eq 'Boris'
      test_patient.phone.should eq '222-555-1234'
      test_patient.doctor_id.should eq 1
    end
  end
  it 'allows you to save entries into the database' do
    test_patient = Patient.new("Hermie", "407-555-1234", 3)
    test_patient.save
    Patient.all.should eq [test_patient]
  end
  it 'is the same task if it has the same name' do
    new_task1 = Patient.new('Ginnie', '1-800-Jenny', 6)
    new_task2 = Patient.new('Ginnie', '1-800-Jenny', 6)
    new_task1.should eq new_task2
  end
  it 'returns the id of the patient' do
    test_patient = Patient.new("Marla", '555-fight-club', 7)
    test_patient.save
    test_patient.patient_id.should be_an_instance_of Fixnum
  end
end
