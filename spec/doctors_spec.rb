require 'spec_helper'

describe Doctor do

  describe 'initialize' do
    it 'creates a new instance of Doctor initialized by Name and Specialty and has a unique ID' do
    test_doctor = Doctor.new("Watson", "Magic")
    test_doctor.name.should eq "Watson"
    test_doctor.should be_an_instance_of Doctor
    end
  end

  it 'assigns a specialty id from the specialty table' do
    test_doctor = Doctor.new("Watson", "Magic")
    test_doctor.save
    test_doctor.specialty_id.should be_an_instance_of Fixnum
  end

  it 'starts with zero entries' do
    Doctor.all.should eq []
  end
  it 'allows you to save entries into the database' do
    test_doctor = Doctor.new("Watson", "Magic")
    test_doctor.save
    Doctor.all.should eq [test_doctor]
  end
  it 'is the same task if it has the same name' do
    new_task1 = Doctor.new('Ginnie', 'Massage')
    new_task2 = Doctor.new('Ginnie', 'Massage')
    new_task1.should eq new_task2
  end
  it 'returns the id of the doctor' do
    test_doctor = Doctor.new("Ms.Mew", "Cats")
    test_doctor.save
    test_doctor.id.should be_an_instance_of Fixnum
  end
  it 'lists out all current patients' do
    new_doctor = Doctor.new("Mandy", "Pop Songs in the 90s")
    new_doctor.save
    new_patient = Patient.new("Nancy", "702-555-1234", new_doctor.id)
    new_patient.save
    new_doctor.list_patients.should eq [new_patient]
  end
end
