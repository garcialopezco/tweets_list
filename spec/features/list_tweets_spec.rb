require "rails_helper"

feature "List Tweets" do
  before :each do
    ruby_on_rails_response = JSON.parse(file_fixture("ruby_on_rails.json").read, object_class: OpenStruct)
    reactjs_response       = JSON.parse(file_fixture("reactjs.json").read, object_class: OpenStruct)
    linux_response         = JSON.parse(file_fixture("linux.json").read, object_class: OpenStruct)

    allow(TweetsQuery).to receive(:search).with("Ruby on Rails").and_return(ruby_on_rails_response)
    allow(TweetsQuery).to receive(:search).with("ReactJS").and_return(reactjs_response)
    allow(TweetsQuery).to receive(:search).with("Linux").and_return(linux_response)
  end

  scenario "first load of the page" do
    when_i_enter_the_site
    i_should_see_topic_options
    i_should_not_see_any_tweet
  end
  
  scenario "selecting Ruby on Rails topic" do
    when_i_enter_the_site
    and_i_select_topic("Ruby on Rails")
    i_should_see_ten_tweets_for_topic
  end

  def when_i_enter_the_site
    visit "/"
  end

  def i_should_see_topic_options
    expect(page).to have_content "Select Topic:"
    expect(page).to have_link "Ruby on Rails"
    expect(page).to have_link "ReactJS"
    expect(page).to have_link "Linux"
  end

  def i_should_not_see_any_tweet
    within "#tweets-list" do
      expect(page).not_to have_selector(".tweet")
    end
  end

  def and_i_select_topic(topic)
    click_link topic
  end

  def i_should_see_ten_tweets_for_topic
    within "#tweets-list" do
      expect(page).to have_selector(".tweet", count: 10)
    end
  end
end
