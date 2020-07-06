#update to use the users factory
# user = FactoryBot.build(:user, first_name: nil) #rewritten with a factory

require 'rails_helper'

RSpec.describe Project, type: :model do

  it "is valid with a name" do
      # user = User.create(
      #   first_name: "Joe",
      #   last_name:  "Tester",
      #   email:      "joetester@example.com",
      #   password:   "dottle-nouveau-pavilion-tights-furze",
      # )
      user = FactoryBot.create(:user) #rewritten with a factory. use create, not build
      
      project = Project.new(
        id: 1,
        name: "Test Project",
        description: "Project Description",
        due_on: '1',
        user_id: user.id
      )
      #binding.pry
      expect(project).to be_valid
  end

  describe "" do 
    before do
      # @user = User.create(
      #   first_name: "Joe",
      #   last_name:  "Tester",
      #   email:      "joetester@example.com",
      #   password:   "dottle-nouveau-pavilion-tights-furze",
      # )
      @user = FactoryBot.create(:user) #rewritten with a factory
      @other_user = FactoryBot.create(:user)
    end
  
    it "does not allow duplicate project names per user" do
      @user.projects.create(
        name: "Test Project",
      )

      new_project = @user.projects.build(
        name: "Test Project",
      )

      new_project.valid?
      expect(new_project.errors[:name]).to include("has already been taken")
    end

    it "allows two users to share a project name" do
      @user.projects.create(
        name: "Test Project",
      )

      #usesing FactoryBot above now
      # other_user = User.create(
      #   first_name: "Jane",
      #   last_name:  "Tester",
      #   email:      "janetester@example.com",
      #   password:   "dottle-nouveau-pavilion-tights-furze",
      # )

      other_project = @other_user.projects.build(
        name: "Test Project",
      )

      expect(other_project).to be_valid
    end
  end


  describe "late status" do
    it "is late when the due date is past today" do
      project = FactoryBot.create(:project, :due_yesterday)
      expect(project).to be_late
    end

    it "is on time when the due date is today" do
      project = FactoryBot.create(:project, :due_today)
      expect(project).to_not be_late
    end

    it "is on time when the due date is in the future" do
      project = FactoryBot.create(:project, :due_tomorrow)
      expect(project).to_not be_late
    end
  end

  it "can have many notes" do
    project = FactoryBot.create(:project, :with_notes)
    expect(project.notes.length).to eq 5
  end

end