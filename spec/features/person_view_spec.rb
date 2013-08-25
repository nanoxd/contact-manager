require 'spec_helper'
require 'capybara/rails'
require 'capybara/rspec'

describe Person, type: :feature do
  let(:person) { Person.create(first_name: 'Ferny', last_name: 'Paredes') }

  describe 'Phone numbers' do

    before(:each) do
      person.phone_numbers.create(number: '555-1234')
      person.phone_numbers.create(number: '555-1233')
      visit person_path(person)
    end

    it 'shows the phone numbers' do
      person.phone_numbers.each do |phone|
        expect(page).to have_content(phone.number)
      end
    end

    it 'has a link to add a new phone number' do
      expect(page).to have_link('Add phone number', href: new_phone_number_path(person_id: person.id))
    end

    it 'adds a new phone number' do
      page.click_link('Add phone number')
      page.fill_in('Number', with: '555-8888')
      page.click_button('Create Phone number')
      expect(current_path).to eq(person_path(person))
      expect(page).to have_content('555-8888')
    end

    it 'has links to edit phone numbers' do
      person.phone_numbers.each do |phone|
        expect(page).to have_link('edit', href: edit_phone_number_path(phone))
      end
    end

    it 'edits a phone number' do
      phone = person.phone_numbers.first
      old_number = phone.number

      first(:link, 'edit').click
      page.fill_in('Number', with: '555-9191')
      page.click_button('Update Phone number')
      expect(current_path).to eq(person_path(person))
      expect(page).to have_content('555-9191')
      expect(page).to_not have_content(old_number)
    end

    it 'has links to delete phone numbers' do
      person.phone_numbers.each do |phone|
        expect(page).to have_link('delete', href: phone_number_path(phone))
      end
    end

    it 'deletes a phone number' do
      phone = person.phone_numbers.first
      deleted_number = phone.number

      first(:link, 'delete').click
      expect(current_path).to eq(person_path(person))
      expect(page).not_to have_content(deleted_number)
    end
  end

  describe 'Email Addresses' do
    before(:each) do
      person.email_addresses.create(address: 'me@example.com')
      person.email_addresses.create(address: 'you@example.com')
      visit person_path(person)
    end

    it 'has a li for each address' do
      person.email_addresses.each do |email_address|
        expect(page).to have_selector('li', text: email_address.address)
      end
    end

    it 'has an add email address link' do
      page.click_link('Add email address')
      expect(current_path).to eq(new_email_address_path)
    end

    it 'redirects to the person after adding an email address' do
      page.click_link('Add email address')
      page.fill_in('Address', with: 'me@example.com')
      page.click_button('Create Email address')
      expect(current_path).to eq(person_path(person))
    end

    it 'edits an email address' do
      email = person.email_addresses.first
      old_email = email.address

      first(:link, 'edit').click
      page.fill_in('Address', with: 'changed@me.com')
      page.click_button('Update Email address')
      expect(current_path).to eq(person_path(person))
      expect(page).to have_content('changed@me.com')
      expect(page).to_not have_content(old_email)
    end

  end

end
