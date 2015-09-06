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

  # TODO check invalid card

  describe "capture & charge" do
    it "is not paid when created" do
      expect(@reservation.paid?).to be false
      expect(@reservation.payment_reserved?).to be false
    end

    it "returns false with Stripe::InvalidRequestError" do
      @reservation.capture
      expect(@reservation.payment_error).to eq true
    end

    context "with customer token" do
      it "can capture & charge payment" do
        @user.update_customer_information!(Stripe::Token.create(@valid_card).id)
        @reservation.capture
        expect(@reservation.payment_reserved?).to be true
        @reservation.charge
        expect(@reservation.paid?).to be true
        expect(@restaurant.payments.count).to be 1
      end

      it "can capture & refund payment" do
        @user.update_customer_information!(Stripe::Token.create(@valid_card).id)
        expect(@reservation.capture).to be true
        expect(@reservation.payment_reserved?).to be true
        expect(@reservation.refund).to be true
        expect(@reservation.paid?).to be false
        expect(@reservation.payment_reserved?).to be false
      end
    end

    context "through table" do
      it "can capture & charge payment" do
        @user.update_customer_information!(Stripe::Token.create(@valid_card).id)
        @table.capture
        expect(@reservation.payment_reserved?).to be true
        @table.charge
        expect(@reservation.paid?).to be true
      end

      it "can capture & refund payment" do
        @user.update_customer_information!(Stripe::Token.create(@valid_card).id)
        @table.capture
        expect(@reservation.payment_reserved?).to be true
        @table.refund
        expect(@reservation.paid?).to be false
        expect(@reservation.payment_reserved?).to be false
      end
    end

  end
end