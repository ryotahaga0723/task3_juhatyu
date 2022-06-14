# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Company.create!(
  code: 100,
  name: '株式会社A',
  created_at: "2019-07-11 02:33:34", 
  updated_at: "2019-07-11 02:33:34"
)
User.create!(
  name: '管理者A',
  email: 'aaa@gmail.com',
  password: 'aaaaaa',
  password_confirmation: 'aaaaaa',
  admin: true, 
  company_id: 100,
  created_at: "2019-07-11 02:33:34", 
  updated_at: "2019-07-11 02:33:34"
)
Address.create!(
  postcode: 1000001,
  prefecture: '東京都',
  city: '千代田区',
  town: '一ツ橋',
  address: '1-1-1', 
  building: 'サンパレスサイドビル',
  room_number: '5階',
  addressable_type: 'Company',
  addressable_id: 100,
  created_at: "2019-07-11 02:33:34", 
  updated_at: "2019-07-11 02:33:34"
)
Telephone.create!(
  number: '09011111111',
  telephoneable_type: 'Company',
  telephoneable_id: 100,
  created_at: "2019-07-11 02:33:34", 
  updated_at: "2019-07-11 02:33:34"
)
Category.create!(
  name: 'フルーツ',
  company_id: 100,
  created_at: "2019-07-11 02:33:34", 
  updated_at: "2019-07-11 02:33:34"
)
Product.create!(
  name: 'リンゴ', 
  company_id: 100,
  category_id: 1,
  created_at: "2019-07-11 02:33:34", 
  updated_at: "2019-07-11 02:33:34",
  stock_attributes: {
    quantity: 100,
    company_id: 100,
    user_id: 1,
  }
)
Supply.create!(
  code: '100119',
  name: "リンゴ",
  price: 100,
  set: 1,
  content: "青森県産のトキ",
  product_id: 1,
  stock_id: 1,
  created_at: "2019-07-11 02:33:34", 
  updated_at: "2019-07-11 02:33:34"
)
Product.create!(
  name: 'ブドウ', 
  company_id: 100,
  category_id: 1,
  created_at: "2019-07-11 02:33:34", 
  updated_at: "2019-07-11 02:33:34",
  stock_attributes: {
    quantity: 150,
    company_id: 100,
    user_id: 1,
  }
)
Supply.create!(
  code: '100129',
  name: "ブドウ",
  price: 150,
  set: 1,
  content: "山梨県産の巨砲",
  product_id: 2,
  stock_id: 2,
  created_at: "2019-07-11 02:33:34", 
  updated_at: "2019-07-11 02:33:34"
)

Order.create!(
  code: '1000001',
  date: "2022-06-13",
  total_price: 100,
  user_id: 1,
  created_at: "2019-07-11 02:33:34", 
  updated_at: "2019-07-11 02:33:34",
)
Order.create!(
  code: '1000002',
  date: "2022-06-14",
  total_price: 2000,
  user_id: 1,
  created_at: "2019-07-11 02:33:34", 
  updated_at: "2019-07-11 02:33:34",
  order_supplies_attributes: [{
    availability: true,
    quantity: 20,
    supply_id: 100119,
    statuses_attributes: [{
      status: 0,
      order_supply_id: 1,
    }]
  }]
)
