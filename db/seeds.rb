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
)
Payee.create!(
  bank: '未設定',
  branch: '未設定',
  kind: 0,
  number: '0000000',
  company_id: 100,
)

Company.create!(
  code: 200,
  name: '株式会社B',
)

User.create!(
  name: '管理者A',
  email: 'aaa@gmail.com',
  password: 'aaaaaa',
  password_confirmation: 'aaaaaa',
  admin: true, 
  company_id: 100,
)
User.create!(
  name: '社員B',
  email: "bbb@gmail.com",
  password: "bbbbbb",
  password_confirmation: "bbbbbb",
  admin: false, 
  company_id: 200,
)
User.create!(
  name: '社員C',
  email: "ccc@gmail.com",
  password: "cccccc",
  password_confirmation: "cccccc",
  admin: false, 
  company_id: 200,
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
)
Telephone.create!(
  number: '09011111111',
  telephoneable_type: 'Company',
  telephoneable_id: 100,
)
Address.create!(
  postcode: 1000001,
  prefecture: '大阪府',
  city: '大阪市',
  town: '新世界',
  address: '1-1-1', 
  addressable_type: 'Company',
  addressable_id: 200,
)
Telephone.create!(
  number: '09011111112',
  telephoneable_type: 'Company',
  telephoneable_id: 200,
)

Category.create!(
  name: 'フルーツ',
  company_id: 100,
)

Category.create!(
  name: '野菜',
  company_id: 100,
)


Product.create!(
  name: 'リンゴ', 
  company_id: 100,
  category_id: 1,
  stock_attributes: {
    quantity: 100,
    company_id: 100,
    user_id: 1,
  }
)
Supply.create!(
  code: '10010019',
  name: "リンゴ",
  price: 100,
  set: 1,
  content: "青森県産のトキ",
  product_id: 1,
  stock_id: 1,
)
Cancel.create!(
  supply_id: 1
)

Product.create!(
  name: 'ブドウ', 
  company_id: 100,
  category_id: 1,
  stock_attributes: {
    quantity: 150,
    company_id: 100,
    user_id: 1,
  }
)
Supply.create!(
  code: '10010029',
  name: "ブドウ",
  price: 150,
  set: 1,
  content: "山梨県産の巨砲",
  product_id: 2,
  stock_id: 2,
)

Cancel.create!(
  supply_id: 2
)

Supply.create!(
  code: '10010039',
  name: "リンゴ",
  price: 300,
  set: 2,
  content: "青森県産のトキ",
  product_id: 1,
  stock_id: 1,
)
Cancel.create!(
  supply_id: 3
)

Product.create!(
  name: 'レタス', 
  company_id: 100,
  category_id: 2,
  stock_attributes: {
    quantity: 100,
    company_id: 100,
    user_id: 1,
  }
)
Supply.create!(
  code: '10020019',
  name: "レタス",
  price: 150,
  set: 1,
  content: "",
  product_id: 3,
  stock_id: 3,
)
Cancel.create!(
  supply_id: 4
)



Order.create!(
  code: '1000001',
  date: "2022-06-13",
  total_price: 200,
  user_id: 2,
  order_supplies_attributes: [{
    availability: true,
    quantity: 20,
    supply_id: 1,
  },{
    availability: true,
    quantity: 0,
    supply_id: 2,
  },{
    availability: true,
    quantity: 0,
    supply_id: 3,
  },{
    availability: true,
    quantity: 0,
    supply_id: 4,
  }],
  status_attributes: {
    status: 0
  },
  shipping_attributes: {
    name: '社員C',
  }
)
Order.create!(
  code: '1000002',
  date: "2022-06-14",
  total_price: 6500,
  user_id: 2,
  order_supplies_attributes: [
    {
      availability: true,
      quantity: 20,
      supply_id: 1,
    },{
      availability: true,
      quantity: 30,
      supply_id: 2,
    },{
      availability: true,
      quantity: 0,
      supply_id: 3,
    },{
      availability: true,
      quantity: 0,
      supply_id: 4,
  }],
  status_attributes: {
    status: 0
  },
  shipping_attributes: {
    name: '社員B',
  }
)
Order.create!(
  code: '1000003',
  date: "2022-06-15",
  total_price: 4500,
  user_id: 2,
  order_supplies_attributes: [
    {
      availability: true,
      quantity: 15,
      supply_id: 3,
    },{
      availability: true,
      quantity: 0,
      supply_id: 1,
    },{
      availability: true,
      quantity: 0,
      supply_id: 2,
    },{
      availability: true,
      quantity: 0,
      supply_id: 4,
    }],
  status_attributes: {
    status: 0
  },
  shipping_attributes: {
    name: '社員B',
  }
)
Address.create!(
  postcode: 1000001,
  prefecture: '東京都',
  city: '千代田区',
  town: '一ツ橋',
  address: '1-1-1', 
  building: 'サンパレスサイドビル',
  room_number: '5階',
  addressable_type: 'Order',
  addressable_id: 1,
)
Address.create!(
  postcode: 1000001,
  prefecture: '東京都',
  city: '千代田区',
  town: '一ツ橋',
  address: '1-1-1', 
  building: 'サンパレスサイドビル',
  room_number: '5階',
  addressable_type: 'Order',
  addressable_id: 2,
)
Address.create!(
  postcode: 1000001,
  prefecture: '東京都',
  city: '千代田区',
  town: '一ツ橋',
  address: '1-1-1', 
  building: 'サンパレスサイドビル',
  room_number: '5階',
  addressable_type: 'Order',
  addressable_id: 3,
)

Approval.create!(
  approval: 0,
  user_id: 2,
  approvalable_type: 'Order',
  approvalable_id: 1,
)
Approval.create!(
  approval: 0,
  user_id: 2,
  approvalable_type: 'Order',
  approvalable_id: 2,
)
Approval.create!(
  approval: 0,
  user_id: 2,
  approvalable_type: 'Order',
  approvalable_id: 3,
)