# frozen_string_literal: true

class ContactOption  < ApplicationRecord
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }

  enum contact_option: {free_introduction: 0, VIP_introduction: 1}

  before_save :check_ranking
  before_save :check_present_offering

  def self.sort_by_name
    ContactOption.all.order('last_name ASC, first_name ASC')
  end

  def self.offer_introduction
    ContactOption.all.each do |contact|
      update_intros_offered(contact)
    end

    ContactOption.update_all(contact_option: nil)

    offer_new_introduction

    ContactOption.all
  end

  private

  def check_ranking
    return unless self.email_changed?

    unless self.email.include?('gmail.com') || self.email.include?('hotmail.com')|| self.email.include?('outlook.com')
      self.ranking += 2
    end
  end

  def check_present_offering
    return unless self.intros_offered_changed?

    unless intros_offered["free"].eql?(0) && intros_offered["vip"].eql?(0)
      self.ranking += 1
    end
  end

  def self.offer_new_introduction
    vip_contact = ContactOption.where('intros_offered @> ?', '{"vip": 0}').order('ranking DESC').first
    vip_contact&.update(contact_option: 'VIP_introduction')

    ContactOption.where.not(id: vip_contact&.id).update_all(contact_option: 'free_introduction')  
  end

  def self.update_intros_offered(contact)
    vip_intro = contact.intros_offered["vip"]
    free_intro = contact.intros_offered["free"]

    if contact.free_introduction?
      free_intro += 1
      contact.update(intros_offered: {"free": free_intro, "vip": vip_intro})
    elsif contact.VIP_introduction?
      vip_intro += 1
      contact.update(intros_offered: {"free": free_intro, "vip": vip_intro})
    end
  end
end
