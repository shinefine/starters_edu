require 'spec_helper'

describe "articles/new" do
  before(:each) do
    assign(:article, stub_model(Article,
      :Title => "MyString",
      :Content => "MyString"
    ).as_new_record)
  end

  it "renders new article form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", articles_path, "post" do
      assert_select "input#article_Title[name=?]", "article[Title]"
      assert_select "input#article_Content[name=?]", "article[Content]"
    end
  end
end
