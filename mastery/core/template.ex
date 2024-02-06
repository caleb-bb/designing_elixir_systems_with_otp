defmodule Mastery.Core.Template do
  defstruct ~w[name category instructions raw compiled generators checker]a

  # We can create a simple "new" constructor when we want to add any default
  # behaviors to the default constructor for struct
  def new(fields) do
    raw = Keyword.fetch!(fields, :raw)

    struct!(
      __MODULE__,
      Keyword.put(fields, :compiled, EEx.compile_string(raw))
    )
  end
end
