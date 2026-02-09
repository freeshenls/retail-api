Sys::Role.create!([
  {name: "designer", description: "设计师"},
  {name: "admin", description: "管理员"},
  {name: "staff", description: "员工"},
  {name: "finance", description: "财务"}
])
Biz::Customer.create!([
  {name: "可爱小猫咪", address: "长府街201号", card_name: "刘亦菲", card_no: "320999999999999999", credit_limit: "200000.0"}
])
Biz::Category.create!([
  {name: "4K", position: 1},
  {name: "64K", position: 2},
  {name: "32K", position: 3},
  {name: "16K", position: 4},
  {name: "8K", position: 5},
  {name: "3K", position: 6},
  {name: "2K", position: 7},
  {name: "全开", position: 8}
])
Sys::User.create!([
  {email: "admin@admin.com", password: "123456", reset_password_token: nil, reset_password_sent_at: nil, remember_created_at: nil, name: "管理员", role_id: Sys::Role.find_by(name: "admin").id},
  {email: "designer@designer.com", password: "123456", reset_password_token: nil, reset_password_sent_at: nil, remember_created_at: nil, name: "设计师", role_id: Sys::Role.find_by(name: "designer").id},
  {email: "finance@finance.com", password: "123456", reset_password_token: nil, reset_password_sent_at: nil, remember_created_at: nil, name: "财务", role_id: Sys::Role.find_by(name: "finance").id},
  {email: "liuwei@staff.com", password: "123456", reset_password_token: nil, reset_password_sent_at: nil, remember_created_at: nil, name: "刘伟", role_id: Sys::Role.find_by(name: "staff").id},
  {email: "zhujiang@staff.com", password: "123456", reset_password_token: nil, reset_password_sent_at: nil, remember_created_at: nil, name: "朱江", role_id: Sys::Role.find_by(name: "staff").id}
])
Biz::Unit.create!([
  {service_type: "出片", category_id: 1, price: "0.0", currency: "CNY", status: "1"},
  {service_type: "彩色数码", category_id: 1, price: "0.0", currency: "CNY", status: "1"},
  {service_type: "黑白数码", category_id: 1, price: "0.0", currency: "CNY", status: "1"},
  {service_type: "排版", category_id: 1, price: "0.0", currency: "CNY", status: "1"},
  {service_type: "设计", category_id: 1, price: "0.0", currency: "CNY", status: "1"},
  {service_type: "自定价", category_id: 1, price: "0.0", currency: "CNY", status: "1"},
  {service_type: "出片", category_id: 2, price: "0.0", currency: "CNY", status: "1"},
  {service_type: "彩色数码", category_id: 2, price: "0.0", currency: "CNY", status: "1"},
  {service_type: "黑白数码", category_id: 2, price: "0.0", currency: "CNY", status: "1"},
  {service_type: "排版", category_id: 2, price: "0.0", currency: "CNY", status: "1"},
  {service_type: "设计", category_id: 2, price: "0.0", currency: "CNY", status: "1"},
  {service_type: "自定价", category_id: 2, price: "0.0", currency: "CNY", status: "1"},
  {service_type: "出片", category_id: 3, price: "0.0", currency: "CNY", status: "1"},
  {service_type: "彩色数码", category_id: 3, price: "0.0", currency: "CNY", status: "1"},
  {service_type: "黑白数码", category_id: 3, price: "0.0", currency: "CNY", status: "1"},
  {service_type: "排版", category_id: 3, price: "0.0", currency: "CNY", status: "1"},
  {service_type: "设计", category_id: 3, price: "0.0", currency: "CNY", status: "1"},
  {service_type: "自定价", category_id: 3, price: "0.0", currency: "CNY", status: "1"},
  {service_type: "出片", category_id: 4, price: "0.0", currency: "CNY", status: "1"},
  {service_type: "彩色数码", category_id: 4, price: "0.0", currency: "CNY", status: "1"},
  {service_type: "黑白数码", category_id: 4, price: "0.0", currency: "CNY", status: "1"},
  {service_type: "排版", category_id: 4, price: "0.0", currency: "CNY", status: "1"},
  {service_type: "设计", category_id: 4, price: "0.0", currency: "CNY", status: "1"},
  {service_type: "自定价", category_id: 4, price: "0.0", currency: "CNY", status: "1"},
  {service_type: "出片", category_id: 5, price: "0.0", currency: "CNY", status: "1"},
  {service_type: "彩色数码", category_id: 5, price: "0.0", currency: "CNY", status: "1"},
  {service_type: "黑白数码", category_id: 5, price: "0.0", currency: "CNY", status: "1"},
  {service_type: "排版", category_id: 5, price: "0.0", currency: "CNY", status: "1"},
  {service_type: "设计", category_id: 5, price: "0.0", currency: "CNY", status: "1"},
  {service_type: "自定价", category_id: 5, price: "0.0", currency: "CNY", status: "1"},
  {service_type: "出片", category_id: 6, price: "0.0", currency: "CNY", status: "1"},
  {service_type: "彩色数码", category_id: 6, price: "0.0", currency: "CNY", status: "1"},
  {service_type: "黑白数码", category_id: 6, price: "0.0", currency: "CNY", status: "1"},
  {service_type: "排版", category_id: 6, price: "0.0", currency: "CNY", status: "1"},
  {service_type: "设计", category_id: 6, price: "0.0", currency: "CNY", status: "1"},
  {service_type: "自定价", category_id: 6, price: "0.0", currency: "CNY", status: "1"},
  {service_type: "出片", category_id: 7, price: "0.0", currency: "CNY", status: "1"},
  {service_type: "彩色数码", category_id: 7, price: "0.0", currency: "CNY", status: "1"},
  {service_type: "黑白数码", category_id: 7, price: "0.0", currency: "CNY", status: "1"},
  {service_type: "排版", category_id: 7, price: "0.0", currency: "CNY", status: "1"},
  {service_type: "设计", category_id: 7, price: "0.0", currency: "CNY", status: "1"},
  {service_type: "自定价", category_id: 7, price: "0.0", currency: "CNY", status: "1"},
  {service_type: "出片", category_id: 8, price: "0.0", currency: "CNY", status: "1"},
  {service_type: "彩色数码", category_id: 8, price: "0.0", currency: "CNY", status: "1"},
  {service_type: "黑白数码", category_id: 8, price: "0.0", currency: "CNY", status: "1"},
  {service_type: "排版", category_id: 8, price: "0.0", currency: "CNY", status: "1"},
  {service_type: "设计", category_id: 8, price: "0.0", currency: "CNY", status: "1"},
  {service_type: "自定价", category_id: 8, price: "0.0", currency: "CNY", status: "1"}
])
Biz::CustomerUser.create!([
  {customer_id: 1, user_id: 2},
  {customer_id: 1, user_id: 3}
])
