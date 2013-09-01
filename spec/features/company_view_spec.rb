require 'spec_helper'
require 'capybara/rails'
require 'capybara/rspec'

describe Company, type: :feature do
  let(:company) { Fabricate(:company) }
  let(:user) { Fabricate(:user) }

  describe 'Phone numbers' do

    before(:each) do
      company.phone_numbers.create(number: '555-1234')
      company.phone_numbers.create(number: '555-1233')
      login_as(user)
      visit company_path(company.id)
    end

    it 'shows the phone numbers' do
      company.phone_numbers.each do |phone|
        expect(page).to have_content(phone.number)
      end
    end

    it 'has a link to add a new phone number' do
      expect(page).to have_link('Add phone number', href: new_phone_number_path(contact_id: company.id, contact_type: 'Company'))
    end

    it 'adds a new phone number' do
      page.click_link('Add phone number')
      page.fill_in('Number', with: '555-8888')
      page.click_button('Create Phone number')
      expect(current_path).to eq(company_path(company))
      expect(page).to have_content('555-8888')
    end

    it 'has links to edit phone numbers' do
      company.phone_numbers.each do |phone|
        expect(page).to have_link('edit', href: edit_phone_number_path(phone))
      end
    end

    it 'edits a phone number' do
      phone = company.phone_numbers.first
      old_number = phone.number

      first(:link, 'edit').click
      page.fill_in('Number', with: '555-9191')
      page.click_button('Update Phone number')
      expect(current_path).to eq(company_path(company))
      expect(page).to have_content('555-9191')
      expect(page).to_not have_content(old_number)
    end

    it 'has links to delete phone numbers' do
      company.phone_numbers.each do |phone|
        expect(page).to have_link('delete', href: phone_number_path(phone))
      end
    end

    it 'deletes a phone number' do
      phone = company.phone_numbers.first
      deleted_number = phone.number

      first(:link, 'delete').click
      expect(current_path).to eq(company_path(company))
      expect(page).not_to have_content(deleted_number)
    end
  end

  describe 'Email Addresses' do
    before(:each) do
      company.email_addresses.create(address: 'me@example.com')
      company.email_addresses.create(address: 'you@example.com')
      login_as(user)
      visit company_path(company.id)
    end

    it 'has a li for each address' do
      company.email_addresses.each do |email_address|
        expect(page).to have_selector('li', text: email_address.address)
      end
    end

    it 'has an add email address link' do
      page.click_link('Add email address')
      expect(current_path).to eq(new_email_address_path)
    end

    it 'redirects to the company after adding an email address' do
      page.click_link('Add email address')
      page.fill_in('Address', with: 'me@example.com')
      page.click_button('Create Email address')
      expect(current_path).to eq(company_path(company))
    end

    it 'has links to edit email addresses' do
      company.email_addresses.each do |email_address|
        expect(page).to have_link('edit', edit_email_address_path(email_address))
      end
    end

    it 'edits an email address' do
      email = company.email_addresses.first
      old_email = email.address

      first(:link, 'edit').click
      page.fill_in('Address', with: 'changed@me.com')
      page.click_button('Update Email address')
      expect(current_path).to eq(company_path(company.id))
      expect(page).to have_content('changed@me.com')
      expect(page).to_not have_content(old_email)
    end

    it 'has links to delete email addresses' do
      company.email_addresses.each do |email_address|
        expect(page).to have_link('delete', href: email_address_path(email_address))
      end
    end

    it 'deletes an email address' do
      email = company.email_addresses.first
      deleted_email = email.address

      first(:link, 'delete').click
      expect(current_path).to eq(company_path(company))
      expect(page).not_to have_content(deleted_email)
    end

  end
end
