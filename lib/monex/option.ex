defmodule MonEx.Option do
  @moduledoc """
  Option module provides Option type with utility functions.
  """
  require Record

  defmacro some(val) do
    quote do
      {:some, unquote(val)}
    end
  end

  defmacro none do
    quote do
      {:none}
    end
  end

  @typedoc """
  Option type.
  some(x) or none() unwraps into {:some, x} or {:none}
  """
  @type t :: {:some, term} | {:none}

  @doc """
  Returns true if argument is some() false if none()
  """
  @spec is_some(t) :: boolean
  def is_some(some(_)), do: true
  def is_some(none()), do: false

  @doc """
  Returns true if argument is none() false if some()
  """
  @spec is_none(t) :: boolean
  def is_none(x), do: !is_some(x)

  @doc """
  Converts arbitrary term into option, some(term) if not nil, none() otherwise
  """
  @spec to_option(term) :: t
  def to_option(nil), do: none()
  def to_option(x), do: some(x)

  @doc """
  Returns content of option if argument is some(), raises otherwise
  """
  @spec get(t) :: term
  def get(some(x)), do: x
  def get(none()), do: raise "Can't get value of None"

  @doc """
  Returns content of option if argument is some(), second argument otherwise
  """
  @spec get_or_else(t, term) :: term
  def get_or_else(some(x), _), do: x
  def get_or_else(none(), z), do: z
end
