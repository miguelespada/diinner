require "rails_helper"
describe Reservation do
  before(:each) do
    @user = FactoryGirl.create(:user)
    @restaurant = FactoryGirl.create(:restaurant, :with_tables)
    @table = @restaurant.tables.first
    @reservation = FactoryGirl.create(:reservation, user: @user, table: @table)
    @valid_card =  {card: {
        name: "Rodrigo Rato",
        number: "4012888888881881",
        exp_month: '09',
        exp_year: '2020',
        cvc: '123'
      }}
  end

  describe "capture & charge" do
    it "is not paid when created" do
      expect(@reservation.paid?).to be false
      expect(@reservation.payment_reserved?).to be false
    end

    it "returns false with Stripe::InvalidRequestError" do
      expect(@reservation.capture.message).to eq "Must provide source or customer."
      expect(@reservation.payment_error).to be true
    end

    context "with customer token" do
      it "can capture & chage payment" do
        @user.update_customer_information!(Stripe::Token.create(@valid_card).id)
        expect(@reservation.capture).to be true
        expect(@reservation.payment_reserved?).to be true
        expect(@reservation.charge).to be true
        expect(@reservation.paid?).to be true
      end
    end
  end
end