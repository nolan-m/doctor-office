class Doctor
  attr_reader :name, :specialty, :id, :specialty_id, :insurance

  def initialize(name, specialty, id=nil)
    @name = name
    @specialty = specialty
    @id = id
    add_specialty
  end

  def add_insurance(insurance_id)
    @insurance_id = insurance_id
  end

  def add_specialty
    new_specialty = Specialty.new(@specialty)
    @specialty_id = new_specialty.id
  end

  def self.all
    results = DB.exec("SELECT * from doctors;")
    doctors = []
    results.each do |result|
      doctor_name = result['name']
      doctor_specialty = result['specialty']
      doctor_id = result['id'].to_i
      doctors <<  Doctor.new(doctor_name, doctor_specialty, doctor_id)
    end
    doctors
  end

  def == (doctors)
    self.name == doctors.name && self.specialty == doctors.specialty
  end

  def save
    results = DB.exec("INSERT INTO doctors (name, specialty, specialty_id, insurance_id) VALUES ('#{@name}', '#{@specialty}', #{@specialty_id}, #{insurance_id}) RETURNING id;")
    @id = results.first['id'].to_i
  end

  def list_patients
    results = DB.exec("SELECT * FROM patients WHERE doctors_id = #{@id};")
    current_patients = []
    results.each do |result|
      patient_name = result['name']
      patient_number = result['phone_number']
      patient_doctor_id = result['doctors_id']
      current_patients << Patient.new(patient_name, patient_number, patient_doctor_id)
    end
    current_patients
  end


end
