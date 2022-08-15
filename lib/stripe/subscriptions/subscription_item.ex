defmodule Stripe.SubscriptionItem do
  @moduledoc """
  Work with Stripe subscription item objects.

  Stripe API reference: https://stripe.com/docs/api#subscription_items
  """

  use Stripe.Entity
  import Stripe.Request

  @type t :: %__MODULE__{
          id: Stripe.id(),
          object: String.t(),
          billing_thresholds: Stripe.Types.collection_method_thresholds() | nil,
          created: Stripe.timestamp(),
          deleted: boolean | nil,
          metadata: Stripe.Types.metadata(),
          plan: Stripe.Plan.t(),
          price: Stripe.Price.t(),
          quantity: non_neg_integer,
          subscription: Stripe.id() | Stripe.Subscription.t() | nil,
          tax_rates: list(Stripe.TaxRate.t())
        }

  defstruct [
    :id,
    :object,
    :billing_thresholds,
    :created,
    :deleted,
    :metadata,
    :plan,
    :price,
    :quantity,
    :subscription,
    :tax_rates
  ]

  @plural_endpoint "subscription_items"

  @doc """
  Create a subscription item.
  """
  @spec create(params, Stripe.options()) :: {:ok, t} | {:error, Stripe.Error.t()}
        when params: %{
               :subscription => Stripe.id() | Stripe.Subscription.t(),
               optional(:plan) => Stripe.id() | Stripe.Plan.t(),
               optional(:price) => Stripe.id() | Stripe.Price.t(),
               optional(:metadata) => Stripe.Types.metadata(),
               optional(:prorate) => boolean,
               optional(:proration_date) => Stripe.timestamp(),
               optional(:quantity) => non_neg_integer,
               optional(:tax_rates) => list(String.t())
             }
  def create(%{subscription: _} = params, opts \\ []) do
    new_request(opts)
    |> put_endpoint(@plural_endpoint)
    |> put_params(params)
    |> put_method(:post)
    |> cast_to_id([:plan, :price, :subscription])
    |> make_request()
  end

  @doc """
  Retrieve a subscription.
  """
  @spec retrieve(Stripe.id() | t, Stripe.options()) :: {:ok, t} | {:error, Stripe.Error.t()}
  def retrieve(id, opts \\ []) do
    new_request(opts)
    |> put_endpoint(@plural_endpoint <> "/#{get_id!(id)}")
    |> put_method(:get)
    |> make_request()
  end

  @doc """
  Update a subscription item.

  Takes the `id` and a map of changes.
  """
  @spec update(Stripe.id() | t, params, Stripe.options()) :: {:ok, t} | {:error, Stripe.Error.t()}
        when params: %{
               optional(:metadata) => Stripe.Types.metadata(),
               optional(:plan) => Stripe.id() | Stripe.Plan.t(),
               optional(:price) => Stripe.id() | Stripe.Price.t(),
               optional(:prorate) => boolean,
               optional(:proration_date) => Stripe.timestamp(),
               optional(:quantity) => non_neg_integer,
               optional(:tax_rates) => list(String.t())
             }
  def update(id, params, opts \\ []) do
    new_request(opts)
    |> put_endpoint(@plural_endpoint <> "/#{get_id!(id)}")
    |> put_method(:post)
    |> put_params(params)
    |> cast_to_id([:plan, :price])
    |> make_request()
  end

  @doc """
  Delete a subscription.

  Takes the `id` and an optional map of `params`.
  """
  @spec delete(Stripe.id() | t, params, Stripe.options()) :: {:ok, t} | {:error, Stripe.Error.t()}
        when params: %{
               optional(:clear_usage) => boolean,
               optional(:prorate) => boolean,
               optional(:proration_date) => Stripe.timestamp()
             }
  def delete(id, params \\ %{}, opts \\ []) do
    new_request(opts)
    |> put_endpoint(@plural_endpoint <> "/#{get_id!(id)}")
    |> put_method(:delete)
    |> put_params(params)
    |> make_request()
  end

  @doc """
  List all subscriptions.
  """
  @spec list(Stripe.id(), params, Stripe.options()) ::
          {:ok, Stripe.List.t(t)} | {:error, Stripe.Error.t()}
        when params: %{
               optional(:ending_before) => t | Stripe.id(),
               optional(:limit) => 1..100,
               optional(:starting_after) => t | Stripe.id()
             }
  def list(id, params \\ %{}, opts \\ []) do
    new_request(opts)
    |> put_endpoint(@plural_endpoint <> "?subscription=" <> id)
    |> put_method(:get)
    |> put_params(params)
    |> cast_to_id([:ending_before, :starting_after])
    |> make_request()
  end
end
