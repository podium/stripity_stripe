defmodule Stripe.Terminal.ConfigurationTest do
  use Stripe.StripeCase, async: true

  describe "Retrieve" do
    test "retrieve a terminal configuration" do
      assert {:ok, %Stripe.Terminal.Configuration{}} =
               Stripe.Terminal.Configuration.retrieve("tmr_P400-123-456-789")

      assert_stripe_requested(:get, "/v1/terminal/configurations/tmr_P400-123-456-789")
    end
  end

  describe "Create" do
    test "create terminal configuration" do
      params = %{
        bbpos_wisepos_e: %{splashscreen: "file_1LW1R6AOR4hRZ3V9HH2KU7Hx"},
        tipping: %{
          usd: %{
            fixed_amounts: [100, 200, 300],
            percentages: [15, 20, 25],
            smart_tip_threshold: 1000
          }
        }
      }

      assert {:ok, %Stripe.Terminal.Configuration{}} =
               Stripe.Terminal.Configuration.create(params)

      assert_stripe_requested(:post, "/v1/terminal/configurations")
    end
  end

  describe "Delete" do
    test "delete a terminal configuration" do
      assert {:ok, %Stripe.Terminal.Configuration{}} =
               Stripe.Terminal.Configuration.delete("tmr_P400-123-456-789")

      assert_stripe_requested(:delete, "/v1/terminal/configurations/tmr_P400-123-456-789")
    end
  end

  describe "Update" do
    test "update terminal configuration" do
      assert {:ok,
              %Stripe.Terminal.Configuration{
                bbpos_wisepos_e: %{
                  splashscreen: "file_1LW1R6AOR4hRZ3V9HH2KU7Hx"
                }
              }} =
               Stripe.Terminal.Configuration.update("tmr_P400-123-456-789", %{
                 bbpos_wisepos_e: %{splashscreen: "file_1LW1R6AOR4hRZ3V9HH2KU7Hx"}
               })

      assert_stripe_requested(:post, "/v1/terminal/configurations/tmr_P400-123-456-789")
    end
  end

  describe "List" do
    test "list all terminal configurations" do
      assert {:ok, %Stripe.List{data: configurations}} = Stripe.Terminal.Configuration.list()

      assert_stripe_requested(:get, "/v1/terminal/configurations")
      assert is_list(configurations)
      assert %Stripe.Terminal.Configuration{} = hd(configurations)
    end
  end
end
