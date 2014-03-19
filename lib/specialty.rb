class Specialty
  attr_reader :specialty, :id

  def initialize(specialty, id=nil)
    @specialty = specialty
    @id = id
    save
  end

  def self.all
    results = DB.exec("SELECT * from specialty;")
    specialty = []
    results.each do |result|
      specialty_type = result['specialty']
      specialty << Specialty.new(specialty_type)
    end
    specialty
  end

  def save
    check = DB.exec("SELECT * FROM specialty WHERE specialty = '#{@specialty}';")
    if check.first == nil
      results = DB.exec("INSERT INTO specialty (specialty) VALUES ('#{@specialty}') RETURNING id;")
      @id = results.first['id'].to_i
    else
      @id = check.first['id'].to_i
    end
  end

  def == (another_specialty)
    self.specialty == another_specialty.specialty
  end
end

