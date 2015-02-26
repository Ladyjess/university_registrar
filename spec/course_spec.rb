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
      equal_course = Course.new({:name => "Legal Ethics", :id => nil, :course_number => "LE240"})
      equal_course.save
      equal_course2 = Course.new({:name => "Legal Ethics", :id => nil, :course_number => "LE240"})
      equal_course2.save
      expect(equal_course).to eq (equal_course2)
    end
  end

  describe "#update" do
    it("allows you to change the course name") do
      course = Course.new({:name => "Science for Everyday Life", :id => nil, :course_number => "SEL310"})
      course.save
      course.update({:name => "Life Science"})
      expect(course.name).to eq("Life Science")
    end

    # it("allows you to change the course number") do
    #   ...
    #   course.update({:number => "SEL105"})
    #   ...
    # end
  end

  describe "#update_course_id" do
    it "lets you add an course to a student" do
      course = Course.new({:name => "Advanced Spanish", :id => nil, :course_id => "AS498"})
      course.save
      samantha = Student.new({:name => "Samantha Parkington", :id => nil, :date_of_enrollment => "2015-01-01"})
      samantha.save
      casey = Student.new({:name => "Casey Aoki", :id => nil, :date_of_enrollment => "2014-04-15"})
      casey.save
      student.update_course_ids({:course_ids => [samantha.id, casey.id]})
      expect(student.courses).to eq ([samantha, casey])
    end
  end

  describe "students" do
    it "tells what students are in a course" do
      course1 = Course.new({:name => "Legal Ethics", :id => nil, :course_number => "LE240"})
      course1.save
      course2 = Course.new({:name => "Advanced Spanish", :id => nil, :course_id => "AS498"})
      course2.save
      student =  Student.new({:name => "Samantha Parkington", :id => nil, :date_of_enrollment => "2015-01-01"})
      student.save
      student.update_course_id({:course_ids => [course1.id]})
      student.update_course_id({:course_ids => [course2.id]})
      expect(student.courses).to eq ([course, course2])
    end
  end
end
