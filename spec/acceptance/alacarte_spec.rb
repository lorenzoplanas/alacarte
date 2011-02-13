require "spec_helper"

feature "Basic user documentation" do
  before :each do
    doc :visit, "http://www.google.es"
  end

  scenario "annotates Capybara helpers" do
    buffer.match(/<p>visit .*google.*/).should be_true
  end

  scenario "generates documentation for a single step" do 
    doc "Now you should see Google Spain's home page"
    buffer.match(/<p>Now you should .*Google Spain.*/).should be_true
  end

  scenario "takes a screenshot using example description as default filename,
  appending timestamp" do
    doc "Now you should see Google Spain homepage"
    screenshot
    Dir.entries(Alacarte::DOCS_PATH).select { |filename|
      filename =~ /.*takes_a_screenshot.*_timestamp_\d+.*/
    }.length.should == 1
  end

  scenario "saves a screenshot to passed filename" do
    doc "Now you should see Google Spain homepage"
    screenshot "my_screenshot"
    File.exists?("#{Alacarte::DOCS_PATH}/my_screenshot.png").should be_true
  end
end
