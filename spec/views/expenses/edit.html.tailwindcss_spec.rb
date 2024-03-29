require 'rails_helper'

RSpec.describe "expenses/edit", type: :view do
  let(:expense) {
    Expense.create!(
      name: "MyString",
      description: "MyText",
      amount: 1.5
    )
  }

  before(:each) do
    assign(:expense, expense)
  end

  it "renders the edit expense form" do
    render

    assert_select "form[action=?][method=?]", expense_path(expense), "post" do

      assert_select "input[name=?]", "expense[name]"

      assert_select "textarea[name=?]", "expense[description]"

      assert_select "input[name=?]", "expense[amount]"
    end
  end
end
