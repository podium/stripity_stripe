defmodule Stripe.Invoiceitem do
  @moduledoc """
  Work with Stripe invoiceitem objects.

  Stripe API reference: https://stripe.com/docs/api#invoiceitems

  Note: this module is named `Invoiceitem` and not `InvoiceItem` on purpose, to
  match the Stripe terminology of `invoiceitem`.
  """

  use Stripe.Entity
  import Stripe.Request

  @type t :: %__MODULE__{
          id: Stripe.id(),
          object: String.t(),
          amount: integer,
          currency: String.t(),
          customer: Stripe.id() | Stripe.Customer.t(),
          date: Stripe.timestamp(),
          deleted: boolean | nil,
          description: String.t(),
          discountable: boolean,
          discounts: list(String.t()),
          invoice: Stripe.id() | Stripe.Invoice.t(),
          livemode: boolean,
          metadata: Stripe.Types.metadata(),
          period: %{
            start: Stripe.timestamp(),
            end: Stripe.timestamp()
          },
          plan: Stripe.Plan.t() | nil,
          price: Stripe.Price.t() | nil,
          proration: boolean,
          quantity: integer,
          subscription: Stripe.id() | Stripe.Subscription.t() | nil,
          tax_rates: list(Stripe.TaxRate.t()),
          unit_amount: integer,
          unit_amount_decimal: String.t()
        }

  defstruct [
    :id,
    :object,
    :amount,
    :currency,
    :customer,
    :date,
    :deleted,
    :description,
    :discountable,
    :discounts,
    :invoice,
    :livemode,
    :metadata,
    :period,
    :plan,
    :price,
    :proration,
    :quantity,
    :subscription,
    :tax_rates,
    :unit_amount,
    :unit_amount_decimal
  ]

  @plural_endpoint "invoiceitems"

  @doc """
  Create an invoiceitem.
  """
  @spec create(params, Stripe.options()) :: {:ok, t} | {:error, Stripe.Error.t()}
        when params:
               %{
                 optional(:amount) => integer,
                 :currency => String.t(),
                 :customer => Stripe.id() | Stripe.Customer.t(),
                 optional(:description) => String.t(),
                 optional(:discountable) => boolean,
                 optional(:invoice) => Stripe.id() | Stripe.Invoice.t(),
                 optional(:metadata) => Stripe.Types.metadata(),
                 optional(:price) => Stripe.id() | Stripe.Price.t(),
                 optional(:quantity) => integer,
                 optional(:subscription) => Stripe.id() | Stripe.Subscription.t(),
                 optional(:tax_rates) => list(String.t()),
                 optional(:unit_amount) => integer,
                 optional(:unit_amount_decimal) => String.t()
               }
               | %{}
  def create(params, opts \\ []) do
    new_request(opts)
    |> put_endpoint(@plural_endpoint)
    |> put_params(params)
    |> put_method(:post)
    |> cast_to_id([:price, :subscription])
    |> make_request()
  end

  @doc """
  Retrieve an invoiceitem.
  """
  @spec retrieve(Stripe.id() | t, Stripe.options()) :: {:ok, t} | {:error, Stripe.Error.t()}
  def retrieve(id, opts \\ []) do
    new_request(opts)
    |> put_endpoint(@plural_endpoint <> "/#{get_id!(id)}")
    |> put_method(:get)
    |> make_request()
  end

  @doc """
  Update an invoiceitem.

  Takes the `id` and a map of changes.
  """
  @spec update(Stripe.id() | t, params, Stripe.options()) :: {:ok, t} | {:error, Stripe.Error.t()}
        when params:
               %{
                 optional(:amount) => integer,
                 optional(:description) => String.t(),
                 optional(:discountable) => boolean,
                 optional(:metadata) => Stripe.Types.metadata(),
                 optional(:price) => Stripe.id() | Stripe.Price.t(),
                 optional(:quantity) => integer,
                 optional(:tax_rates) => list(String.t()),
                 optional(:unit_amount) => integer,
                 optional(:unit_amount_decimal) => String.t()
               }
               | %{}
  def update(id, params, opts \\ []) do
    new_request(opts)
    |> put_endpoint(@plural_endpoint <> "/#{get_id!(id)}")
    |> put_method(:post)
    |> put_params(params)
    |> cast_to_id([:price])
    |> make_request()
  end

  @doc """
  Delete and invoiceitem

  Takes the `id` of the invoiceitem to delete.
  """
  @spec delete(Stripe.id() | t, Stripe.options()) :: {:ok, t} | {:error, Stripe.Error.t()}
  def delete(id, opts \\ []) do
    new_request(opts)
    |> put_endpoint(@plural_endpoint <> "/#{get_id!(id)}")
    |> put_method(:delete)
    |> make_request()
  end

  @doc """
  List all invoiceitems.
  """
  @spec list(params, Stripe.options()) :: {:ok, Stripe.List.t(t)} | {:error, Stripe.Error.t()}
        when params:
               %{
                 optional(:created) => Stripe.timestamp(),
                 optional(:customer) => Stripe.id() | Stripe.Customer.t(),
                 optional(:ending_before) => t | Stripe.id(),
                 optional(:invoice) => Stripe.id() | Stripe.Invoice.t(),
                 optional(:limit) => 1..100,
                 optional(:starting_after) => t | Stripe.id()
               }
               | %{}
  def list(params \\ %{}, opts \\ []) do
    new_request(opts)
    |> prefix_expansions()
    |> put_endpoint(@plural_endpoint)
    |> put_method(:get)
    |> put_params(params)
    |> cast_to_id([:customer, :ending_before, :starting_after])
    |> make_request()
  end
end
