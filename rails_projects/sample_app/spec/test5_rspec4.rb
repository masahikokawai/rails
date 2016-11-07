# フィーチャスペックでは describe や it の代わりに、feature や scenario といったエイリアスをよく使います。
# フィーチャスペックで使われるエイリアスの対応関係は以下の通りです。
# describe <=> feature
# it <=> scenario
# let <=> given
# let! <=> given!
# before <=> background
# context や after にはエイリアスがないのでそのまま使います。

require 'rails_helper'
  background do
    # ユーザを作成する
    User.create!(email: 'foo@example.com', password: '123456')
  end
  scenario 'ログインする' do
    # トップページを開く
    visit root_path
    # ログインフォームにEmailとパスワードを入力する
    fill_in 'Email', with: 'foo@example.com'
    fill_in 'Password', with: '123456'
    # ログインボタンをクリックする
    click_on 'ログイン'
    # ログインに成功したことを検証する
    expect(page).to have_content 'ログインしました'
  end
end
