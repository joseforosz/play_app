# == Schema Information
#
# Table name: users
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

require 'spec_helper'

describe User do

  before do
   @user = User.new(name: "Example User", email: "user@example.com", 
                    password: "foobar", password_confirmation: "foobar")
  end 
    
  subject {@user}
  
  it {should respond_to (:name)}
  it {should respond_to (:email)}
  it {should respond_to (:password_digest)}
  it {should respond_to (:password)}
  it {should respond_to (:password_confirmation)}

  it {should be_valid}

  describe "when name is not present" do
    before{@user.name=""}
    it {should_not be_valid}
  end

  describe "when name is too long" do
    before{@user.name = "a" * 52}
    it {should_not be_valid}
  end

  describe "when email is not preset" do
    before{@user.email=""}
    it {should_not be_valid}
  end

  describe "when email format is invalid" do
    bad_addresses = %w[user@foo,com user_at_foo.org example.user@foo.]
    bad_addresses.each do|addres|
    before {@user.email=addres}
    it {should_not be_valid}
   end
  end 

 describe "when email format is valid" do
  good_address = %w[user@foo.com A_USER@f.b.org frst.lst@foo.jp a+b@baz.cn]
  good_address.each do |addres|
   before {@user.email=addres}
   it {should be_valid}
  end
 end

 describe "when email address is already taken" do
  before do
    user_with_same_email = @user.dup
    user_with_same_email.email = @user.email.upcase
    user_with_same_email.save
  end
  it {should_not be_valid}
 end

 describe "when password is not present" do
  before {@user.password = @user.password_confirmation=" "}
  it {should_not be_valid}
 end

 describe "when passwords do not match" do
  before{@user.password_confirmation= "Missmatch"}
  it {should_not be_valid}
 end
 
 describe "when password confirmation is nil" do
  before {@user.password_confirmation = nil}
  it {should_not be_valid}
 end

end
