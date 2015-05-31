require 'spec_helper'

describe "Static pages" do
  # 本例テストのレシーバ(主語)
  subject { page } # pageメソッド(レスポンスがHTMLである場合、内容を取得できる)

  # ホーム
  describe "Home page" do
    before { visit root_path } # ルートパスへのアクセス

    # テスト内容
    it { should have_content('Sample App') } # コンテンツ
    it { should have_title(full_title('')) } # タイトル1
    it { should_not have_title('| Home') } # タイトル2
  end

  # ヘルプ
  describe "Help page" do
    before { visit help_path }

    it { should have_content('Help') }
    it { should have_title(full_title('Help')) }
  end

  # 詳細
  describe "About page" do
    before { visit about_path }

    it { should have_content('About') }
    it { should have_title(full_title('About Us')) }
  end

  # 問い合わせ
  describe "Contact page" do
    before { visit contact_path }

    it { should have_content('Contact') }
    it { should have_title(full_title('Contact')) }
  end
end