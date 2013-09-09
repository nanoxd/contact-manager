require 'spec_helper'
require 'capybara/rails'
require 'capybara/rspec'

describe EmailAddress, type: :feature do
  let(:person) { Person.create(first_name: 'Person', last_name: 'Dos')}
  let(:company) { Company.create(name: 'Sherkat')}

  context "when looking at the new email address form" do

    it "shows the person's name in the title" do
      visit person_path(person)
      page.click_link('Add email address')
      expect(page).to have_selector("h1", text: "#{person.last_name}, #{person.first_name}")
    end

    it "shows a company's name in the title" do
      visit company_path(company)
      page.click_link('Email Address')
      expect(page).to have_selector("h1", text: "#{company.name}")
    end

  end

  context "when looking at the edit email address form" do
    before(:each) do
      person.email_addresses.create(address: 'me@example.com')
      company.email_addresses.create(address: 'you@example.com')
    end

    it "shows the person's name in the title" do
      email = person.email_addresses.first
      old_email = email.address

      visit person_path(person)
      first(:link, 'edit').click
      expect(page).to have_selector("h1", text: "#{person.last_name}, #{person.first_name}")
    end

    it "shows a company's name in the title" do
      email = company.email_addresses.first
      old_email = email.address

      visit company_path(company)
      first(:link, 'edit').click
      expect(page).to have_selector("h1", text: "#{company.name}")
    end

  end

end
