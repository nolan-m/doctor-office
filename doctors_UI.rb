require 'pg'
require './lib/doctors'
require './lib/patients'
require './lib/specialty'
require './lib/insurance'

DB = PG.connect({:dbname => 'medical_system'})

def main_menu
  puts "\n\n\nThis is your Very Boring Entry Data System for Doctors and Specialties and Their Patients"
  puts "To Insert a New Line of Data, press 'e'"
  puts "To view doctors by specialty, press 's'"
  puts "To view your boring Information, press 'v'"
  puts "To exit, press 'x'\n\n\n"

  input = gets.chomp

  if input == 'e'
    new_entry
  elsif input == 's'
    view_specialties
  elsif input == 'v'
    view_table
  elsif input == 'x'
    puts "Exiting System..."
  else
    puts "Get Some Coffee fool, not a Valid Input."
    main_menu
  end
end

def view_specialties
  Specialty.all.each_with_index do |specialty, index|
    puts "#{index+ 1}. #{specialty.specialty}"
  end
  puts "Pick a specialty to list doctors"
  user_input = gets.chomp

  current_speciality = Specialty.all[user_input.to_i - 1]
  puts "#{current_speciality.specialty}"
  puts "--------------"
  Doctor.all.each do |doctor|
    if doctor.specialty == current_speciality.specialty
      puts "#{doctor.name}"
    end
  end
  main_menu
end


def new_entry
  puts "\nEnter the Doctor's Name"
  doctor_name = gets.chomp
  puts "\nEnter the Specialty of the Doctor"
  doctor_specialty = gets.chomp
  puts "\nSelect an insurance company"
  Insurance.all.each_with_index do |insurance, index|
    puts "#{index + 1}. #{insurance.name}"
  end
  user_insurance = gets.chomp
  current_insurance = Insurance.all[user_insurance.to_i + 1]
  new_doctor = Doctor.new(doctor_name, doctor_specialty)
  new_doctor.add_insurance(current_insurance.id)
  new_doctor.save
  puts "\nYou saved #{new_doctor.name}: #{doctor_specialty}\n\n"
  main_menu
end

def view_table
  puts "\n\nHere are your Providers:"
  Doctor.all.each_with_index do |information, index|
    puts "#{index.to_i+1}.  #{information.name}"
  end
  puts "\n\nTo View A Provider Information, Select a Provider by Entering the Integer"
  entry = gets.chomp
  Doctor.all.each_with_index do |information, index|
    if entry.to_i == (index+1)
      current_doctor = Doctor.all[index]
      puts "NAME: #{current_doctor.name}"
      puts "SPECIALTY: #{current_doctor.specialty}"
      puts "#{current_doctor.id}"
      puts "PATIENTS: "
      current_doctor.list_patients.each{|patient| puts  "NAME: #{patient.name} / PHONE: #{patient.phone}"}
      puts "\n\n\n"

      puts "\n\n\n"
      puts 'Type "a" to add a patient to this doctor or "p" to print list of patients'
      puts 'Press any other key to return to main menu.'
      input = gets.chomp

      if input == 'a'
        add_patient(current_doctor)
        elsif input == 'p'
          print_patient
      else
        main_menu
      end
    end
  end
end

def add_patient(current_doctor)
  puts "Enter the Patient Name"
  patient_name = gets.chomp
  puts "Enter the Patient's Phone Number"
  patient_phone = gets.chomp

  new_patient = Patient.new(patient_name, patient_phone)
  new_patient.save

  puts "#{new_patient.name} added to #{current_doctor.name}"
  main_menu
end

main_menu
