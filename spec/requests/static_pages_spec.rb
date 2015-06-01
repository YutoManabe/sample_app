require 'spec_helper'

describe "Static pages" do
  # 本例テストのレシーバ(主語)
  subject { page } # pageメソッド(レスポンスがHTMLである場合、内容を取得できる)

  shared_examples_for "all static pages" do
    it { should have_content(heading) } # コンテンツ
    it { should have_title(full_title(page_title)) } # タイトル
  end

  # ホーム
  describe "Home page" do
    before { visit root_path } # ルートパスへのアクセス
    let(:heading) { 'Sample App' }
    let(:page_title) { '' }

    # テスト内容
    it_should_behave_like "all static pages"
    it { should_not have_title('| Home') } # タイトル2
  end

  # ヘルプ
  describe "Help page" do
    before { visit help_path }
    let(:heading) { 'Help' }
    let(:page_title) { 'Help' }

    it_should_behave_like "all static pages"
  end

  # 詳細
  describe "About page" do
    before { visit about_path }
    let(:heading) { 'About' }
    let(:page_title) { 'About Us' }

    it_should_behave_like "all static pages"
  end

  # 問い合わせ
  describe "Contact page" do
    before { visit contact_path }
    let(:heading) { 'Contact' }
    let(:page_title) { 'Contact' }

    it_should_behave_like "all static pages"
  end

  # リンクチェック
  it "should have the right links on the layout" do
    visit root_path

    # コンテンツ
    click_link "Sign up now!"
    expect(page).to have_title(full_title('Sign up'))

    # ヘッダー
    click_link "sample app"
    click_link "Home"
    click_link "Help"
    expect(page).to have_title(full_title('Help'))
    click_link "Sign in"

    # フッター
    click_link "About"
    expect(page).to have_title(full_title('About Us'))
    click_link "Contact"
    expect(page).to have_title(full_title('Contact'))
  end
end