require 'spec_helper'

describe "articles/edit.html.erb" do
  before(:each) do
    @article = assign(:article, stub_model(Article,
      :name => "MyString",
      :content => "MyText",
      :user_id => 1
    ))
  end

  it "renders the edit article form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => articles_path(@article), :method => "post" do
      assert_select "input#article_name", :name => "article[name]"
      assert_select "textarea#article_content", :name => "article[content]"
      assert_select "input#article_user_id", :name => "article[user_id]"
    end
  end
end
