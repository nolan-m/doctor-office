class Insurance
  attr_reader :name, :id

  def initialize(name, id=nil)
    @name = name
    @id = id
    save
  end

  def self.all
    results = DB.exec("SELECT * from insurance;")
    insurance = []
    results.each do |result|
      insurance_name = result['name']
      insurance << Insurance.new(insurance_name)
    end
    insurance
  end

  def save
    check = DB.exec("SELECT * FROM insurance WHERE name = '#{@name}';")
    if check.first == nil
      results = DB.exec("INSERT INTO insurance (name) VALUES ('#{@name}') RETURNING id;")
      @id = results.first['id'].to_i
    else
      @id = check.first['id'].to_i
    end
  end

  def == (another_specialty)
    self.name == another_specialty.name
  end
end

