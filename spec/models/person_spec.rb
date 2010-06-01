require 'spec_helper'

describe Person do
  before(:each) do
    @valid_attributes = {

            }
  end

  it "should create a new instance given valid attributes" do
    Person.create!(@valid_attributes)
  end

  it "should parse first and last name from a standard full name" do
    p = Person.create! :full_name=>"That Guy"
    p.first_name.should == "That"
    p.last_name.should == "Guy"
  end

  it "should parse first and last naem from a formal full name" do
    p = Person.create! :full_name=>"Guy, That"
    p.first_name.should == "That"
    p.last_name.should == "Guy"
  end

  it "should preserve spaces in a last name" do
    p = Person.create! :full_name=>"That Von Guy"
    p.first_name.should == "That"
    p.last_name.should == "Von Guy"
  end

  it "should trim extra whitespace from names" do
    p = Person.create! :full_name=>"That    Von                            Guy"
    p.first_name.should == "That"
    p.last_name.should == "Von Guy"
  end

  it "should trim extra whitespace from formal names" do
    p = Person.create! :full_name=>"Von   Guy Ha        Ha Ha, That"
    p.first_name.should == "That"
    p.last_name.should == "Von Guy Ha Ha Ha"
  end

  it "should remove first & last names when given a blank name" do
    p = Person.create! :first_name=>"That", :last_name=>"Guy"
    p.full_name = nil
    p.save!
    p.first_name.should be nil
    p.last_name.should be nil
  end
end