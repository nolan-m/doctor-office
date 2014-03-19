class Patient
  attr_reader :name, :phone, :doctor_id, :patient_id

  def initialize(name, phone, doctor_id)
    @name = name
    @phone = phone
    @doctor_id = doctor_id
  end

def self.all
    results = DB.exec("SELECT * from patients;")
    patients = []
    results.each do |result|
      patient_name = result['name']
      patient_numbers = result['phone_number']
      doctor_id = result['doctors_id']
      patients << Patient.new(patient_name, patient_numbers, doctor_id)
    end
    patients
  end

def save
  results = DB.exec("INSERT INTO patients (name, phone_number, doctors_id) VALUES ('#{@name}', '#{@phone}', #{@doctor_id}) RETURNING id;")
  @patient_id = results.first['id'].to_i
end

def == (patients)
  self.name == patients.name&& self.phone == patients.phone
end

end

