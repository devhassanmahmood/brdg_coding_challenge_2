# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ContactOption do
  describe 'create ContactOption' do 
    context 'create contact with base ranking 3' do 
      let!(:contact) { create(:contact_option, email: 'john@gmail.com', intros_offered: {vip: 0, free: 0}) }

      it { expect(contact.ranking).to eq 3 }
    end

    context 'create contact with ranking 5' do 
      let!(:contact) { create(:contact_option, email: 'john@abc.app', intros_offered: {vip: 0, free: 0}) }
      
      it { expect(contact.ranking).to eq 5 }
    end

    context 'create contact with ranking 6' do 
      let!(:contact) { create(:contact_option, email: 'john@abc.app', intros_offered: {vip: 0, free: 1}) }
      
      it { expect(contact.ranking).to eq 6 }
    end
  end

  describe 'Get all contacts' do 
    context 'get contacts sorted by last name and then first name' do 
      let!(:contact1) { create(:contact_option, first_name: "loyd", last_name: "Banks") }
      let!(:contact2) { create(:contact_option, first_name: "adam", last_name: "Banks") }
      let!(:contact3) { create(:contact_option, first_name: "john", last_name: "Lewis") }
    
      it { expect(ContactOption.sort_by_name).to eq [contact2, contact1, contact3]}
    end
  end

  describe 'Offer introduction' do 
    context 'get contacts sorted by last name and then first name' do 
      let!(:contact1) { create(:contact_option, email: 'john@brdg.app', intros_offered: {vip: 0, free: 3}) }
      let!(:contact3) { create(:contact_option, email: 'lloyd@banks.com', intros_offered: {vip: 0, free: 0}) }
      let!(:contact4) { create(:contact_option, email: 'ba.lewis@outlook.com', intros_offered: {vip: 0, free: 8}) }
      let(:contacts) { ContactOption.offer_introduction } 

      it 'give VIP_introduction to higest ranking' do 
        expect(contacts.first.contact_option).to eq  "VIP_introduction"
        expect(contacts.first.ranking).to eq 6
     end

     it 'give free_introduction' do 
        expect(contacts.second.contact_option).to eq  "free_introduction"
        expect(contacts.second.ranking).to eq 5
        expect(contacts.third.contact_option).to eq  "free_introduction"
        expect(contacts.third.ranking).to eq 4
      end
    end
  end
end

