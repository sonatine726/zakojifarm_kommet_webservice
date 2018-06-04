require 'spec_helper'

describe Staff::Authenticator do
  describe '#authenticate' do
    context 'Correct password' do
      let(:member) {build(:staff_member)}
      it 'return true' do
        expect(Staff::Authenticator.new(member).authenticate('pw')).to be_truthy
      end
    end

    context 'Incorrect password' do
      let(:member){build(:staff_member)}
      it 'return false' do
        expect(Staff::Authenticator.new(member).authenticate('xy')).to be_falsey
      end
    end

    context 'password not set to member' do
      let(:member){build(:staff_member, password: nil)}
      it 'return false' do
        expect(Staff::Authenticator.new(member).authenticate('pw')).to be_falsey
      end
    end

    context 'suspended flag is set' do
      let(:member){ build(:staff_member, suspended: true) }
      it 'return false' do
        expect(Staff::Authenticator.new(member).authenticate('pw')).to be_falsey
      end
    end

    context 'before start_date' do
      let(:member){ build(:staff_member, start_date: Date.tomorrow) }
      it 'return false' do
        expect(Staff::Authenticator.new(member).authenticate('pw')).to be_falsey
      end
    end

    context 'after end_date' do
      let(:member){ build(:staff_member, end_date: Date.today) }
      it 'return false' do
        expect(Staff::Authenticator.new(member).authenticate('pw')).to be_falsey
      end
    end
  end
end