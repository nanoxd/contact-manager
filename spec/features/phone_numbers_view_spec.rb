require 'spec_helper'
require 'capybara/rails'
require 'capybara/rspec'

describe PhoneNumber, type: :feature do
  let(:person) { Person.create(first_name: 'Person', last_name: 'Dos')}
  let(:company) { Company.create(name: 'Sherkat')}

  context "when looking at the new phone numbers form" do

    it "shows the person's name in the title" do
      visit person_path(person)
      page.click_link('Add phone number')
      expect(page).to have_selector("h1", text: "#{person.last_name}, #{person.first_name}")
    end

    it "shows a company's name in the title" do
      visit company_path(company)
      page.click_link('Add phone number')
      expect(page).to have_selector("h1", text: "#{company.name}")
    end

  end

  context "when looking at the edit phone number form" do
    before(:each) do
      person.phone_numbers.create(number: '122-1221')
      company.phone_numbers.create(number: '122-1221')
    end

    it "shows the person's name in the title" do
      phone_number = person.phone_numbers.first
      old_phone = phone_number.number

      visit person_path(person)
      first(:link, 'edit').click
      expect(page).to have_selector("h1", text: "#{person.last_name}, #{person.first_name}")
    end

    it "shows a company's name in the title" do
      phone_number = company.phone_numbers.first
      old_phone = phone_number.number

      visit company_path(company)
      first(:link, 'edit').click
      expect(page).to have_selector("h1", text: "#{company.name}")
    end

  end

end
