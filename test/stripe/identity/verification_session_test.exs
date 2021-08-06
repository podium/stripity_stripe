defmodule Stripe.Identity.VerificationSessionTest do
  use Stripe.StripeCase, async: true

  test "is creatable" do
  assert {:ok, %Stripe.Identity.VerificationSession{}} =
      Stripe.Identity.VerificationSession.create(%{type: "document"})

    assert_stripe_requested(:post, "/v1/identity/verification_sessions")
  end

  test "is listable" do
  assert {:ok, %Stripe.List{data: verification_sessions}} = Stripe.Identity.VerificationSession.list()
    assert_stripe_requested(:get, "/v1/identity/verification_sessions")
    assert is_list(verification_sessions)
    assert %Stripe.Account{} = hd(verification_sessions)
  end
end
