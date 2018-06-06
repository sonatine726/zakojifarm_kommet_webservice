AdminMember.create!(
  email: 'admin@example.com',
  family_name: '山田',
  given_name: '太郎',
  family_name_kana: 'ヤマダ',
  given_name_kana: 'タロウ',
  password: 'admin',
  start_date: Date.today
)
