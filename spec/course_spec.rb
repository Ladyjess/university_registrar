require 'spec_helper'

 describe Course do

  describe "#name" do
    it "returns the name of the course"  do
     course = Course.new({:name => "Introduction to Psychology", :id => nil, :course_number => "PSY100"})
     expect(course.name).to eq ("Introduction to Psychology")
    end
  end

  describe "#id" do
    it "returns the id" do
      course = Course.new({:name => "Introduction to Psychology", :id => 1, :course_number => "PSY100"})
      expect(course.id).to eq (1)
    end
  end

  describe "#course_number" do
    it "returns the course number of a class" do
      course = Course.new({:name => "Introduction to Psychology", :id => nil, :course_number => "PSY100"})
      expect(course.course_number).to eq ("PSY100")
    end
  end

  describe ".all" do
    it "starts off with no courses" do
      expect(Course.all).to eq ([])
    end
  end

  describe ".find" do
    it "returns a course by its ID number" do
      test_course = Course.new({:name => "Legal Ethics", :id => nil, :course_number => "LE240"})
      test_course.save
      test_course2 = Course.new({:name => "Real Estate Law", :id => nil, :course_number => "REL 300"})
      test_course2.save
      expect(Course.find(test_course2.id)).to eq (test_course2)
    end
  end

  describe "#save" do
    it "saves the course to an array" do
      test_course = Course.new({:name => "Legal Ethics", :id => nil, :course_number => "LE240"})
      test_course.save
      test_course2 = Course.new({:name => "Real Estate Law", :id => nil, :course_number => "REL 300"})
      test_course2.save
      expect(Course.all).to eq ([test_course, test_course2])
    end
  end

  describe "#==" do
    it "is the same course if it has the same name, id, and course number" do
      test_course = Course.new({:name => "Legal Ethics", :id => nil, :course_number => "LE240"})
      test_course2 = Course.new({:name => "Legal Ethics", :id => nil, :course_number => "LE240"})
      expect(test_course).to eq (test_course2)
    end
  end

  describe "#update" do
    it("allows you to change the course name") do
      course = Course.new({:name => "Science for Everyday Life", :id => nil, :course_number => "SEL310"})
      course.save
      course.update({:name => "Life Science"})
      course.update({:course_number => "SEL100"})
      expect(course.course_number).to eq ("SEL100")
      expect(course.name).to eq ("Life Science")
    end
   end

  describe "#update_student_ids" do
    it "lets you add a student to a course" do
      course = Course.new({:name => "Advanced Spanish", :id => nil, :course_number => "AS498"})
      course.save
      samantha = Student.new({:name => "Samantha Parkington", :id => nil, :date_of_enrollment => "2015-01-01"})
      samantha.save
      casey = Student.new({:name => "Casey Aoki", :id => nil, :date_of_enrollment => "2014-04-15"})
      casey.save
    course.update_student_ids({:student_ids => [samantha.id, casey.id]})
      expect(course.students).to eq ([samantha, casey])
    end
  end

  describe "students" do
    it "tells what courses a student has taken" do
      student = Student.new({:name => "Jasmine Thatcher", :id => nil, :date_of_enrollment => "2015-01-25"})
      student.save
      student2 =  Student.new({:name => "Samantha Parkington", :id => nil, :date_of_enrollment => "2015-01-01"})
      student2.save
      course = Course.new({:name => "Legal Ethics", :id => nil, :course_number => "LE240"})
      course.save
      course.update_student_ids({:student_ids => [student.id]})
      course.update_student_ids({:student_ids => [student2.id]})
      expect(course.students).to eq ([student, student2])
    end
  end

  describe "delete" do
    it "allows deletion of a course from the database" do
      course = Course.new({:name => "Russian History", :id => nil, :course_number => "RH387"})
      course.save
      course2 = Course.new({:name => "Political Science in France", :id => nil, :course_number => "PSF307"})
      course2.save
      course2.delete
      expect(Course.all).to eq ([course])
    end
  end
end
