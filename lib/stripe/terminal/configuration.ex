defmodule Stripe.Terminal.Configuration do
  @moduledoc """
  A Configurations object represents how features should be configured for terminal readers. 

  You can:
  - [Create a Configuration](https://stripe.com/docs/api/terminal/configuration/create)
  - [Retrieve a Configuration](https://stripe.com/docs/api/terminal/configuration/retrieve)
  - [Update a Configuration](https://stripe.com/docs/api/terminal/configuration/update)
  - [Delete a Configuration](https://stripe.com/docs/api/terminal/configuration/delete)
  - [List all Configuration](https://stripe.com/docs/api/terminal/configuration/list)
  """

  use Stripe.Entity
  import Stripe.Request
  require Stripe.Util

  @type t :: %__MODULE__{
          id: Stripe.id(),
          bbpos_wisepos_e: bbpos_wisepos_e(),
          is_account_default: boolean(),
          tipping: tipping(),
          verifone_p400: verifone_p400(),
          object: String.t(),
          livemode: boolean()
        }

  @type bbpos_wisepos_e :: %{
          splashscreen: String.t()
        }

  @type verifone_p400 :: %{
          splashscreen: String.t()
        }

  @type tipping :: %{
          aud: Stipe.Types.aud(),
          cad: Stipe.Types.cad(),
          chf: Stipe.Types.chf(),
          czk: Stipe.Types.czk(),
          dkk: Stipe.Types.dkk(),
          eur: Stipe.Types.eur(),
          gbp: Stipe.Types.gbp(),
          hkd: Stipe.Types.hkd(),
          myr: Stipe.Types.myr(),
          nok: Stipe.Types.nok(),
          nzd: Stipe.Types.nzd(),
          sek: Stipe.Types.sek(),
          sgd: Stipe.Types.sgd(),
          usd: Stipe.Types.usd()
        }

  defstruct [
    :id,
    :bbpos_wisepos_e,
    :is_account_default,
    :tipping,
    :verifone_p400,
    :object,
    :livemode
  ]

  @plural_endpoint "terminal/configurations"

  @doc """
  Create a terminal configuration
  """

  @spec create(params, Stripe.options()) :: {:ok, t} | {:error, Stripe.Error.t()}
        when params:
               %{
                 optional(:bbpos_wisepos_e) => bbpos_wisepos_e(),
                 optional(:tipping) => tipping(),
                 optional(:verifone_p400) => verifone_p400()
               }
               | %{}

  def create(params, opts \\ []) do
    new_request(opts)
    |> put_endpoint(@plural_endpoint)
    |> put_params(params)
    |> put_method(:post)
    |> make_request()
  end

  @doc """
  Retrieve a terminal configuration with a specified `id`.
  """

  @spec retrieve(Stripe.id() | t, Stripe.options()) :: {:ok, t} | {:error, Stripe.Error.t()}
  def retrieve(id, opts \\ []) do
    new_request(opts)
    |> put_endpoint(@plural_endpoint <> "/#{get_id!(id)}")
    |> put_method(:get)
    |> make_request()
  end

  @doc """
  Update a terminal configuration.

  Takes the `id` and a map of changes.
  """
  @spec update(Stripe.id() | t, params, Stripe.options()) :: {:ok, t} | {:error, Stripe.Error.t()}
        when params: %{
               optional(:bbpos_wisepos_e) => bbpos_wisepos_e(),
               optional(:tipping) => tipping(),
               optional(:verifone_p400) => verifone_p400()
             }
  def update(id, params, opts \\ []) do
    new_request(opts)
    |> put_endpoint(@plural_endpoint <> "/#{get_id!(id)}")
    |> put_method(:post)
    |> put_params(params)
    |> make_request()
  end

  @doc """
  Delete a terminal configuration.
  """
  @spec delete(Stripe.id() | t, Stripe.options()) :: {:ok, t} | {:error, Stripe.Error.t()}
  def delete(id, opts \\ []) do
    new_request(opts)
    |> put_endpoint(@plural_endpoint <> "/#{get_id!(id)}")
    |> put_method(:delete)
    |> make_request()
  end

  @doc """
  List all terminal configurations
  """
  @spec list(params, Stripe.options()) :: {:ok, Stripe.List.t()} | {:error, Stripe.Error.t()}
        when params: %{
               optional(:is_account_default) => boolean(),
               optional(:ending_before) => t | Stripe.id(),
               optional(:limit) => 1..100,
               optional(:starting_after) => t | Stripe.id()
             }
  def list(params \\ %{}, opts \\ []) do
    new_request(opts)
    |> prefix_expansions()
    |> put_endpoint(@plural_endpoint)
    |> put_method(:get)
    |> put_params(params)
    |> cast_to_id([:ending_before, :starting_after])
    |> make_request()
  end
end
