defmodule Stripe.PaymentLinkTest do
  use Stripe.StripeCase, async: true

  test "is creatable" do
    params = %{line_items: [%{price: "p_123", quantity: 1}]}
    assert {:ok, %Stripe.PaymentLink{}} = Stripe.PaymentLink.create(params)
    assert_stripe_requested(:post, "/v1/payment_links")
  end

  test "is retrievable" do
    assert {:ok, %Stripe.PaymentLink{}} = Stripe.PaymentLink.retrieve("pl_123")
    assert_stripe_requested(:get, "/v1/payment_links/pl_123")
  end

  test "is updateable" do
    assert {:ok, %Stripe.PaymentLink{}} =
             Stripe.PaymentLink.update("pl_123", %{metadata: %{foo: "bar"}})

    assert_stripe_requested(:post, "/v1/payment_links/pl_123")
  end

  test "is listable" do
    assert {:ok, %Stripe.List{data: payment_links}} = Stripe.PaymentLink.list()
    assert_stripe_requested(:get, "/v1/payment_links")
    assert is_list(payment_links)
    assert %Stripe.PaymentLink{} = hd(payment_links)
  end

  test "is line items listable" do
    assert {:ok, %Stripe.List{data: payment_link_line_items}} =
             Stripe.PaymentLink.list_line_items("pl_123")

    assert_stripe_requested(:get, "/v1/payment_links/pl_123/line_items")
    assert is_list(payment_link_line_items)
  end
end
