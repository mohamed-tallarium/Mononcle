defmodule Monocle do
  @moduledoc """
  Test the presence of elements in a rendered component using their data-test attributes,
  data-test attribute values or a combination of both. This module uses Floki.
  """

  @doc """
  Checks if an element with a given data-test attribute is present in the rendered component.

  ## Example
  Let's say we have the following html code, and we want to check if the confirmation button
  is present in the rendered component:

  ```html
  <div data-test-confirmation-button>Confirm</div>
  ```

  We can do so by calling the `we_see_attribute/2` function on the html of the rendered component:

  ```elixir
  assert we_see_attribute(html, "confirmation button")
  ```

  ## Arguments
  html - the html of the rendered component
  attribute - the data-test attribute of the element we want to check for
  """

  @spec we_see_attribute(String.t(), String.t()) :: boolean()
  def we_see_attribute(html, attribute) do
    element_by_attribute(html, attribute)
    |> length() > 0
  end

  @doc """
  Similar to `we_see_attribute/2`, but also checks if the element has the given content.

  ## Example

  Let's say we have the following html code, and we want to check if the confirmation button
  is present in the rendered component:

  ```html
  <div data-test-confirmation-button>Confirm</div>
  ```

  We can do so by calling the `we_see_attribute/3` function on the html of the rendered component:

  ```elixir
  assert we_see_attribute(html, "confirmation button", content: "Confirm")
  ```

  ## Arguments
  html - the html of the rendered component
  attribute - the data-test attribute of the element we want to check for
  content - the content of the element we want to check for
  """
  @spec we_see_attribute(String.t(), String.t(), keyword()) :: boolean()
  def we_see_attribute(html, attribute, content: content) do
    element_by_attribute(html, attribute)
    |> number_of_elements_with_content(content) > 0
  end

  @doc """
  Checks if an element with a given data-test attribute and value is present in the rendered component.

  ## Example
  Let's say we have the following html code, and we want to check if the confirmation button
  is present in the rendered component:

  ```html
  <div data-test-confirmation-button="confirm">Confirm</div>
  ```

  We can do so by calling the `we_see_attribute_and_value/3` function on the html of the rendered component:

  ```elixir
  assert we_see_attribute_and_value(html, "confirmation button", "confirm")
  ```

  ## Arguments
  html - the html of the rendered component
  attribute - the data-test attribute of the element we want to check for
  attribute_value - the data-test attribute value of the element we want to check for
  """

  @spec we_see_attribute_and_value(String.t(), String.t(), String.t()) :: boolean()
  def we_see_attribute_and_value(html, attribute, attribute_value) do
    element_by_attribute_and_value(html, attribute, attribute_value)
    |> length() > 0
  end

  @doc """
  Similar to `we_see_attribute_and_value/3`, but also checks if the element has the given content.

  ## Example
  Let's say we have the following html code, and we want to check if the confirmation button
  is present in the rendered component:

  ```html
  <div data-test-confirmation-button="confirm">Confirm</div>
  ```

  We can do so by calling the `we_see_attribute_and_value/4` function on the html of the rendered component:

  ```elixir
  assert we_see_attribute_and_value(html, "confirmation button", "confirm", content: "Confirm")
  ```

  ## Arguments
  html - the html of the rendered component
  attribute - the data-test attribute of the element we want to check for
  attribute_value - the data-test attribute value of the element we want to check for
  content - the content of the element we want to check for
  """

  @spec we_see_attribute_and_value(String.t(), String.t(), String.t(), keyword()) :: boolean()
  def we_see_attribute_and_value(html, attribute, attribute_value, content: content) do
    element_by_attribute_and_value(html, attribute, attribute_value)
    |> number_of_elements_with_content(content) > 0
  end

  @doc """
  Checks if an element with a given data-test attribute value is present in the rendered component.

  ## Example
  Let's say we have the following html code, and we want to check if the title is present in the rendered component:

  ```html
  <div data-test="title">Title</div>
  ```

  We can do so by calling the `we_see_attribute_value/2` function on the html of the rendered component:

  ```elixir
  assert we_see_attribute_value(html, "title")
  ```

  ## Arguments
  html - the html of the rendered component
  attribute_value - the data-test attribute value of the element we want to check for
  """

  @spec we_see_attribute_value(String.t(), String.t()) :: boolean()
  def we_see_attribute_value(html, attribute_value) do
    element_by_attribute_value(html, attribute_value)
    |> length() > 0
  end

  @doc """
  Similar to `we_see_attribute_value/2`, but also checks if the element has the given content.

  ## Example
  Let's say we have the following html code, and we want to check if the title is present in the rendered component:

  ```html
  <div data-test="title">Title</div>
  ```

  We can do so by calling the `we_see_attribute_value/3` function on the html of the rendered component:

  ```elixir
  assert we_see_attribute_value(html, "title", content: "Title")
  ```

  ## Arguments
  html - the html of the rendered component
  attribute_value - the data-test attribute value of the element we want to check for
  content - the content of the element we want to check for
  """
  @spec we_see_attribute_value(String.t(), String.t(), keyword()) :: boolean()
  def we_see_attribute_value(html, attribute_value, content: content) do
    element_by_attribute_value(html, attribute_value)
    |> number_of_elements_with_content(content) > 0
  end

  @doc """
  Checks if an element is present in the rendered component, n number of times

  ## Example
  Let's say we have the following html code, and we want to check if buttons are present
  in the rendered component:

  ```html
  <div data-test="button">Button</div>
  <div data-test="button">Button</div>
  ```

  We can do so by calling the `we_see_exactly/3` function on the html of the rendered component:

  ```elixir
  assert we_see_exactly(html, 2, attribute: "button")
  ```

  ## Arguments
  html - the html of the rendered component
  number - the number of times the element should be present

  ## Optional arguments
  attribute - the data-test attribute of the element we want to check for
  content - the content of the element we want to check for
  attribute_value - the data-test attribute value of the element we want to check for

  We can have any combination of the above optional arguments, but we must have at least
  one attribute or attribute_value argument. For instance, lets look at the following
  html code:

  ```html
  <div data-test="button">Button</div>
  <div data-test="button">Second Button</div>
  <div data-test-cancellation>Third Button</div>
  <div data-test-cancellation>Fourth Button</div>
  <div data-test-optional="option">Fifth Button</div>
  <div data-test-optional="option">Sixth Button</div>
  ```

  We can check the number of buttons by calling the `we_see_exactly/2` function with
  multiple optional arguments:

  With attribute:

  ```elixir
  assert we_see_exactly(html, 2, attribute: "cancellation")
  ```

  With attribute_value:

  ```elixir
  assert we_see_exactly(html, 2, attribute_value: "button")
  ```

  With attribute and attribute_value:

  ```elixir
  assert we_see_exactly(html, 2, attribute: "optional", attribute_value: "option")
  ```

  With attribute and content:

  ```elixir
  assert we_see_exactly(html, 1, attribute: "cancellation", content: "Third Button")
  ```

  With attribute_value and content:

  ```elixir
  assert we_see_exactly(html, 1, attribute_value: "button", content: "Second Button")
  ```

  With attribute, attribute_value and content:

  ```elixir
  assert we_see_exactly(html, 1, attribute: "optional", attribute_value: "option", content: "Fifth Button")
  ```
  """
  @spec we_see_exactly(String.t(), number, keyword()) :: boolean()
  def we_see_exactly(html, number, attribute: attribute) do
    element_by_attribute(html, attribute)
    |> length() == number
  end

  def we_see_exactly(html, number, attribute: attribute, content: content) do
    element_by_attribute(html, attribute)
    |> number_of_elements_with_content(content) == number
  end

  def we_see_exactly(html, number, attribute: attribute, attribute_value: attribute_value) do
    element_by_attribute_and_value(html, attribute, attribute_value)
    |> length() == number
  end

  def we_see_exactly(html, number,
        attribute: attribute,
        attribute_value: attribute_value,
        content: content
      ) do
    element_by_attribute_and_value(html, attribute, attribute_value)
    |> number_of_elements_with_content(content) == number
  end

  def we_see_exactly(html, number, attribute_value: attribute_value) do
    element_by_attribute_value(html, attribute_value)
    |> length() == number
  end

  def we_see_exactly(html, number, attribute_value: attribute_value, content: content) do
    element_by_attribute_value(html, attribute_value)
    |> number_of_elements_with_content(content) == number
  end

  @doc """
  Checks if an element is present in the rendered component, at least n number of times

  This function is similar to `we_see_exactly/3`, but it checks if the element is present.
  Please see the documentation for `we_see_exactly/3` for more information.
  """

  @spec we_see_at_least(String.t(), number, keyword()) :: boolean()
  def we_see_at_least(html, number, attribute: attribute) do
    element_by_attribute(html, attribute)
    |> length() >= number
  end

  def we_see_at_least(html, number, attribute: attribute, content: content) do
    element_by_attribute(html, attribute)
    |> number_of_elements_with_content(content) >= number
  end

  def we_see_at_least(html, number, attribute: attribute, attribute_value: attribute_value) do
    element_by_attribute_and_value(html, attribute, attribute_value)
    |> length() >= number
  end

  def we_see_at_least(html, number,
        attribute: attribute,
        attribute_value: attribute_value,
        content: content
      ) do
    element_by_attribute_and_value(html, attribute, attribute_value)
    |> number_of_elements_with_content(content) >= number
  end

  def we_see_at_least(html, number, attribute_value: attribute_value) do
    element_by_attribute_value(html, attribute_value)
    |> length() >= number
  end

  def we_see_at_least(html, number, attribute_value: attribute_value, content: content) do
    element_by_attribute_value(html, attribute_value)
    |> number_of_elements_with_content(content) >= number
  end

  # helper functions
  defp number_of_elements_with_content(list, content) do
    Enum.reduce(list, 0, fn element, acc ->
      if Floki.text(element) |> String.trim() == content do
        acc + 1
      else
        acc
      end
    end)
  end

  defp element_by_attribute(html, attribute) do
    {:ok, document} = Floki.parse_document(html)

    document
    |> Floki.find("[data-test-#{format_attribute(attribute)}]")
  end

  defp element_by_attribute_and_value(html, attribute, attribute_value) do
    {:ok, document} = Floki.parse_document(html)

    document
    |> Floki.find("[data-test-#{format_attribute(attribute)}=\"#{attribute_value}\"]")
  end

  defp element_by_attribute_value(html, attribute_value) do
    {:ok, document} = Floki.parse_document(html)

    document
    |> Floki.find("[data-test=\"#{attribute_value}\"]")
  end

  defp format_attribute(attribute) do
    String.replace(attribute, " ", "-")
  end
end
