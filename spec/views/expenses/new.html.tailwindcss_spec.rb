require 'rails_helper'

RSpec.describe "expenses/new", type: :view do
  before(:each) do
    assign(:expense, Expense.new(
      name: "MyString",
      description: "MyText",
      amount: 1.5
    ))
  end

  it "renders new expense form" do
    render

    assert_select "form[action=?][method=?]", expenses_path, "post" do

      assert_select "input[name=?]", "expense[name]"

      assert_select "textarea[name=?]", "expense[description]"

      assert_select "input[name=?]", "expense[amount]"
    end
  end
end
