defmodule Stripe.Types do
  @moduledoc """
  A module that contains shared types matching Stripe schemas.
  """

  @type address :: %{
          city: String.t() | nil,
          country: String.t() | nil,
          line1: String.t() | nil,
          line2: String.t() | nil,
          postal_code: String.t() | nil,
          state: String.t() | nil
        }

  @type dob :: %{
          day: 1..31 | nil,
          month: 1..12 | nil,
          year: pos_integer | nil
        }

  @type fee :: %{
          amount: integer,
          application: String.t() | nil,
          currency: String.t(),
          description: String.t() | nil,
          type: String.t()
        }

  @type japan_address :: %{
          city: String.t() | nil,
          country: String.t() | nil,
          line1: String.t() | nil,
          line2: String.t() | nil,
          postal_code: String.t() | nil,
          state: String.t() | nil,
          town: String.t() | nil
        }

  @type metadata :: %{
          optional(String.t()) => String.t()
        }

  @type shipping :: %{
          address: Stripe.Types.address(),
          carrier: String.t() | nil,
          company: String.t() | nil,
          currency: String.t() | nil,
          email: String.t() | nil,
          eta: Stripe.timestamp() | nil,
          name: String.t(),
          phone: String.t() | nil,
          status: String.t() | nil,
          tracking_number: String.t() | nil,
          tracking_url: String.t() | nil
        }

  @type collection_method_thresholds :: %{
          amount_gte: integer | nil,
          reset_billing_cycle_anchor: boolean | nil
        }

  @type transfer_schedule :: %{
          delay_days: non_neg_integer,
          interval: String.t(),
          monthly_anchor: non_neg_integer | nil,
          weekly_anchor: String.t() | nil
        }

  @type aud :: %{
          fixed_amounts: Stripe.List.t(non_neg_integer),
          percentages: Stripe.List.t(non_neg_integer),
          smart_tip_threshold: non_neg_integer
        }

  @type cad :: %{
          fixed_amounts: Stripe.List.t(),
          percentages: Stripe.List.t(),
          smart_tip_threshold: non_neg_integer
        }

  @type chf :: %{
          fixed_amounts: Stripe.List.t(non_neg_integer),
          percentages: Stripe.List.t(non_neg_integer),
          smart_tip_threshold: non_neg_integer
        }

  @type czk :: %{
          fixed_amounts: Stripe.List.t(non_neg_integer),
          percentages: Stripe.List.t(non_neg_integer),
          smart_tip_threshold: non_neg_integer
        }

  @type dkk :: %{
          fixed_amounts: Stripe.List.t(non_neg_integer),
          percentages: Stripe.List.t(non_neg_integer),
          smart_tip_threshold: non_neg_integer
        }

  @type eur :: %{
          fixed_amounts: Stripe.List.t(non_neg_integer),
          percentages: Stripe.List.t(non_neg_integer),
          smart_tip_threshold: non_neg_integer
        }

  @type gbp :: %{
          fixed_amounts: Stripe.List.t(non_neg_integer),
          percentages: Stripe.List.t(non_neg_integer),
          smart_tip_threshold: non_neg_integer
        }

  @type hkd :: %{
          fixed_amounts: Stripe.List.t(non_neg_integer),
          percentages: Stripe.List.t(non_neg_integer),
          smart_tip_threshold: non_neg_integer
        }

  @type myr :: %{
          fixed_amounts: Stripe.List.t(non_neg_integer),
          percentages: Stripe.List.t(non_neg_integer),
          smart_tip_threshold: non_neg_integer
        }

  @type nok :: %{
          fixed_amounts: Stripe.List.t(non_neg_integer),
          percentages: Stripe.List.t(non_neg_integer),
          smart_tip_threshold: non_neg_integer
        }

  @type nzd :: %{
          fixed_amounts: Stripe.List.t(non_neg_integer),
          percentages: Stripe.List.t(non_neg_integer),
          smart_tip_threshold: non_neg_integer
        }

  @type sek :: %{
          fixed_amounts: Stripe.List.t(non_neg_integer),
          percentages: Stripe.List.t(non_neg_integer),
          smart_tip_threshold: non_neg_integer
        }

  @type sgd :: %{
          fixed_amounts: Stripe.List.t(non_neg_integer),
          percentages: Stripe.List.t(non_neg_integer),
          smart_tip_threshold: non_neg_integer
        }

  @type usd :: %{
          fixed_amounts: Stripe.List.t(non_neg_integer),
          percentages: Stripe.List.t(non_neg_integer),
          smart_tip_threshold: non_neg_integer
        }
end
