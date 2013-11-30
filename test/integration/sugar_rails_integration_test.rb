require File.expand_path("../../test_helper", __FILE__)

describe "static assets integration" do
  it "provides sugar-development on the asset pipeline" do
    visit '/assets/sugar-development.js'
    page.text.must_include 'Sugar Library v1.4.0'
  end

  it "provides sugar-full on the asset pipeline" do
    visit '/assets/sugar-full.js'
    page.text.must_include 'Sugar Library v1.4.0'
  end

  it "provides sugar on the asset pipeline" do
    visit '/assets/sugar.js'
    page.text.must_include 'Sugar Library v1.4.0'
  end
end
