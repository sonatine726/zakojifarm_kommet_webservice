require 'rails_helper'

feature '職員による顧客管理' do
  include FeatureSpecHelper
  let(:staff_member){ create(:staff_member) }
  let!(:customer){ create(:customer, :with_home_and_work_addresses) }

  before do
    switch_namespace(:staff)
    login_as_staff_member(staff_member)
  end

  scenario '職員が顧客、自宅住所、勤務先を更新する' do
    click_link '顧客管理'
    first('table.p-staff-tbl').click_link '編集'

    fill_in 'メールアドレス', with: 'test@example.jp'
    within('fieldset#home-address-fields') do
      fill_in '郵便番号', with: '9999999'
    end
    within('fieldset#work-address-fields') do
      fill_in '会社名', with: 'テスト'
    end
    click_button '更新'

    customer.reload
    expect(customer.email).to eq('test@example.jp')
    expect(customer.home_address.postal_code).to eq('9999999')
    expect(customer.work_address.company_name).to eq('テスト')
  end

  scenario '職員が生年月日と自宅の郵便番号に無効な値を入力する' do
    click_link '顧客管理'
    first('table.p-staff-tbl').click_link '編集'

    fill_in '生年月日', with: '2100-01-01'
    within('fieldset#home-address-fields') do
      fill_in '郵便番号', with: 'XYZ'
    end
    click_button '更新'

    expect(page).to have_css('div.alert')
    expect(page).to have_css(
      'div.field_with_errors input#form_customer_birthday')
    expect(page).to have_css(
      'div.field_with_errors input#form_home_address_postal_code')
  end

  scenario '職員が顧客（基本情報のみ）を登録する' do
    click_link '顧客管理'
    first('div.links').click_link '新規登録'

    fill_in 'メールアドレス', with: 'test@example.jp'
    fill_in 'パスワード', with: 'pw'
    fill_in 'form_customer_family_name', with: '試験'
    fill_in 'form_customer_given_name', with: '花子'
    fill_in 'form_customer_family_name_kana', with: 'シケン'
    fill_in 'form_customer_given_name_kana', with: 'ハナコ'
    fill_in '生年月日', with: '1970-01-01'
    choose '女性'
    click_button '登録'

    new_customer = Customer.order(:id).last
    expect(new_customer.email).to eq('test@example.jp')
    expect(new_customer.birthday).to eq(Date.new(1970, 1, 1))
    expect(new_customer.gender).to eq('female')
    expect(new_customer.home_address).to be_nil
    expect(new_customer.work_address).to be_nil
  end
end
