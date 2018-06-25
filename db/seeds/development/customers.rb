city_names = %w(飯島町 駒ヶ根市 伊那市 飯田市)

family_names = %w(
  佐藤:サトウ:sato
  鈴木:スズキ:suzuki
  高橋:タカハシ:takahashi
  田中:タナカ:tanaka
  渡辺:ワタナベ:watanabe
  伊藤:イトウ:ito
  山本:ヤマモト:yamamoto
  中村:ナカムラ:nakamura
  小林:コバヤシ:kobayashi
  加藤:カトウ:kato
)

given_names = %w(
  一郎:イチロウ:ichiro
  二郎:ジロウ:jiro
  三郎:サブロウ:saburo
  四郎:シロウ:shiro
  五郎:ゴロウ:goro
  松子:マツコ:matsuko
  竹子:タケコ:takeko
  梅子:ウメコ:umeko
  鶴子:ツルコ:tsuruko
  亀子:カメコ:kameko
)

company_name = %w(OIAX ABC XYZ)

10.times do |n|
  10.times do |m|
    fn = family_names[n].split(':')
    gn = given_names[m].split(':')

    c = Customer.create!(
          email: "#{fn[2]}.#{gn[2]}@example.jp",
          family_name: fn[0],
          given_name: gn[0],
          family_name_kana: fn[1],
          given_name_kana: gn[1],
          password: 'password',
          birthday: 60.years.ago.advance(seconds: rand(40.years)).to_date,
          gender: m < 5 ? 'male' : 'female'
        )
    puts "Create Customer (#{10*n+m})"
    pp c

    if m % 3 == 0
      wa = c.create_work_address(
        postal_code: sprintf('%07d', rand(10000000)),
        prefecture: Address::PREFECTURE_NAMES.sample,
        city: city_names.sample,
        address1: '本郷',
        address2: 'ライラック'
      )
      puts " Put work address"
      pp wa
    end
  end
end
