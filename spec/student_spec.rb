require 'spec_helper'

describe Student do

  describe "#name" do
    it "returns the name of the student"  do
    student = Student.new({:name => "Jasmine Lace", :id => nil, :date_of_enrollment => "2015-01-03"})
      expect(student.name).to eq ("Jasmine Lace")
    end
  end

  describe "#id" do
    it "returns the id" do
      student = Student.new({:name => "Jasmine Lace", :id => 1, :date_of_enrollment => "2015-01-03"})
      expect(student.id).to eq (1)
    end
  end

  describe "#date_of_enrollment" do
    it "returns the date of enrollment for the student" do
      student = Student.new({:name => "Jasmine Lace", :id => nil, :date_of_enrollment => "2015-01-03"})
      expect(student.date_of_enrollment).to eq ("2015-01-03")
    end
  end

  describe ".all" do
    it "starts off with no students" do
      expect(Student.all).to eq ([])
    end
  end

  describe ".find" do
    it "returns a student by its ID number" do
      test_student = Student.new({:name => "Jasmine Lace", :id => nil, :date_of_enrollment => "2015-01-03"})
      test_student.save
      test_student2 = Student.new({:name => "Samantha Brown", :id => nil, :date_of_enrollment => "2015-01-15"})
      test_student2.save
      expect(Student.find(test_student2.id)).to eq (test_student2)
    end
  end

  describe "#save" do
    it "saves the student to an array" do
      test_student = Student.new({:name => "Jasmine Lace", :id => nil, :date_of_enrollment => "2015-01-03"})
      test_student.save
      test_student2 = Student.new({:name => "Samantha Brown", :id => nil, :date_of_enrollment => "2015-01-15"})
      test_student2.save
      expect(Student.all).to eq ([test_student, test_student2])
    end
  end

  describe "#==" do
    it "is the same student if it has the same name, id, and date of enrollment" do
      test_student = Student.new({:name => "Jasmine Lace", :id => nil, :date_of_enrollment => "2015-01-03"})
      test_student2 = Student.new({:name => "Jasmine Lace", :id => nil, :date_of_enrollment => "2015-01-03"})
      expect(test_student).to eq (test_student2)
    end
  end

  describe "#update" do
    it("allows you to change the student name and enrollment date") do
      test_student = Student.new({:name => "Jasmine Lace", :id => nil, :date_of_enrollment => "2015-01-03"})
      test_student.save
      test_student.update({:name => "Katherine Thomas"})
      test_student.update({:date_of_enrollment => "2015-01-03"})
      expect(test_student.name).to eq ("Katherine Thomas")
      expect(test_student.date_of_enrollment).to eq ("2015-01-03")
    end
  end

  describe "#update_course_ids" do
    it "lets you add a course to a student" do
      student = Student.new({:name => "Samantha Parkington", :id => nil, :date_of_enrollment => "2015-01-01"})
      student.save
      course = Course.new({:name => "Advanced Spanish", :id => nil, :course_number => "AS498"})
      course.save
      course2 = Course.new({:name => "Real Estate Law", :id => nil, :course_number => "REL 300"})
      course2.save
      student.update_course_ids({:course_ids => [course.id, course2.id]})
      expect(student.courses).to eq ([course, course2])
    end
  end

  describe "courses" do
    it "tells what students have taken a course" do
      course = Course.new({:name => "Advanced Spanish", :id => nil, :course_number => "AS498"})
      course.save
      course2 = Course.new({:name => "Real Estate Law", :id => nil, :course_number => "REL 300"})
      course2.save
      student = Student.new({:name => "Jasmine Thatcher", :id => nil, :date_of_enrollment => "2015-01-25"})
      student.save
      student.update_course_ids({:course_ids => [course.id]})
      student.update_course_ids({:course_ids => [course2.id]})
      expect(student.courses).to eq ([course, course2])
    end
  end

  describe "delete" do
    it "allows deletion of a student from the database" do
      test_student = Student.new({:name => "Jasmine Lace", :id => nil, :date_of_enrollment => "2015-01-03"})
      test_student.save
      test_student2 = Student.new({:name => "Jasmine Lace", :id => nil, :date_of_enrollment => "2015-01-03"})
      test_student2.save
      test_student.delete
      expect(Student.all).to eq ([test_student2])
    end
  end
end
