# Monocle

This is a library for working with the [Monocle](https://hexdocs.pm/monocle).
This library is built on top of [Floki](https://github.com/philss/floki) and it allows for easier
testing of DOM elements in liveview tests.

You can find the documentation for this library in theis [hexdocs page](https://hexdocs.pm/monocle).

## Usage

Let's say you have a liveview component that looks like this once rendered:

```html
  <div data-test-user="id-34">
    <h1 data-test="name">Bob Doe</h1>
    <p data-test-age>23</p>
  </div>
  <div data-test-user="id-38">
    <h1 data-test="name">Alice Smith</h1>
    <p data-test-age>23</p>
  </div>
```

We can then test this component like so:

```elixir
  test "it renders the users" do
    {:ok, view, html} = live(conn, "/path/to/liveview")

    assert html|> Monocle.we_see_exactly(2, attribute: "age", content: "23")
    assert html|> Monocle.we_see_attribute_and_value("user", "id-34")
    assert html|> Monocle.we_see_attribute_and_value("user", "id-38")
    assert html|> Monocle.we_see_attribute_value("name", content: "Bob Doe")
    assert html|> Monocle.we_see_attribute_value("name", content: "Alice Smith")
  end
```

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `monocle` to your list of dependencies in `mix.exs` as a test dependency:

```elixir
def deps do
  [
    {:monocle, "~> 0.0.1", only: :test}
  ]
end
```

## Dependencies

This library depends on [Floki](https://github.com/philss/floki) as it uses the `Floki.find/2` function
to find elements in the DOM.
