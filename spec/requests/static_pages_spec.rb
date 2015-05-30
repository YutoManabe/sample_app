require 'spec_helper'

describe "StaticPages" do

	# letメソッド(引数のシンボルの名前を持つメソッドを作り、ブロック内のオブジェクトを返す)
	let(:base_title) { "Ruby on Rails Tutorial Sample App" }

	# ホームページ
	describe "Home page" do

		# コンテンツに'Sample App'の文字列が存在するか
    	it "should have the content 'Sample App'" do
      		visit '/static_pages/home'
      		expect(page).to have_content('Sample App')
    	end

    	# タイトルが'Ruby on Rails Tutorial Sample App | Home'となっているか
    	it "should have the right title" do
			visit '/static_pages/home'
			expect(page).to have_title("#{base_title} | Home")
		end
  	end

  	# ヘルプページ
  	describe "Help page" do
    	it "should have the content 'Help'" do
      		visit '/static_pages/help'
      		expect(page).to have_content('Help')
    	end

    	it "should have the right title" do
			visit '/static_pages/help'
			expect(page).to have_title("#{base_title} | Help")
		end
  	end

  	# 詳細ページ
  	describe "About page" do
	    it "should have the content 'About Us'" do
	     	visit '/static_pages/about'
	     	expect(page).to have_content('About Us')
	    end

	    it "should have the right title" do
			visit '/static_pages/about'
			expect(page).to have_title("#{base_title} | About Us")
		end
	end

	# 問い合わせページ
	describe "Contact page" do
		it "should have the content 'Contact'" do
			visit '/static_pages/contact'
			expect(page).to have_content('Contact')
		end

    	it "should have the right title" do
			visit '/static_pages/contact'
			expect(page).to have_title("#{base_title} | Contact")
		end
  	end

end