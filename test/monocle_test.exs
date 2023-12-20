defmodule MonocleTest do
  use ExUnit.Case
  doctest Monocle

  import Monocle

  @html_attribute_and_content """
  <div data-test-confirmation-button>Confirm</div>
  <div data-test-cancellation-button>Cancel</div>
  """

  @html_attribute_and_value_and_content """
  <div data-test-confirmation-button="true">Confirm</div>
  <div data-test-cancellation-button="true">Cancel</div>
  <div data-test-other-button="">Other</div>
  """

  @html_attribute_value_and_content """
  <div data-test="confirmation button">Confirm</div>
  <div data-test="cancellation button">Cancel</div>
  <div data-test="">Other</div>
  """

  @html_multiple_elements """
  <h1 data-test-title="users">Users</h1>
  <div data-test-user="new user">
    <div data-test-name="user 1">User 1</div>
    <div data-test-age="30">30</div>
    <div data-test="adulthood">Adult</div>
  </div>
  <div data-test-user="existing user">
    <div data-test-name="user 2">User 2</div>
    <div data-test-age="30">30</div>
    <div data-test="adulthood">Adult</div>
  </div>
  <div data-test-user="existing user">
    <div data-test-name="user 3">User 3</div>
    <div data-test-age="15">15</div>
    <div data-test="childhood">Child</div>
  </div>
  """

  describe "we_see_attribute/2" do
    test "returns true if element with given data-test attribute is present in the rendered component" do
      assert we_see_attribute(@html_attribute_and_content, "confirmation button")
      assert we_see_attribute(@html_attribute_and_content, "cancellation button")
    end

    test "accepts atrtibute names with hyphens" do
      assert we_see_attribute(@html_attribute_and_content, "confirmation-button")
      assert we_see_attribute(@html_attribute_and_content, "cancellation-button")
    end

    test "returns true if attribute exists and arbitrary attribute value" do
      assert we_see_attribute(@html_attribute_and_value_and_content, "confirmation button")
    end

    test "returns false if data-test attribute name does not match" do
      refute we_see_attribute(@html_attribute_and_content, "confirmationButton")
      refute we_see_attribute(@html_attribute_and_content, "cancellationButton")
    end
  end

  describe "we_see_attribute/3" do
    test "returns true if element with given data-test attribute and content is present in the rendered component" do
      assert we_see_attribute(@html_attribute_and_content, "confirmation button",
               content: "Confirm"
             )

      assert we_see_attribute(@html_attribute_and_content, "cancellation button",
               content: "Cancel"
             )
    end

    test "returns true if attribute and content exists but arbitrary attribute value" do
      assert we_see_attribute(@html_attribute_and_value_and_content, "confirmation button",
               content: "Confirm"
             )
    end

    test "returns false if element with given data-test attribute is not present in the rendered component" do
      refute we_see_attribute(@html_attribute_and_content, "confirmation button",
               content: "Cancel"
             )

      refute we_see_attribute(@html_attribute_and_content, "cancellation button",
               content: "Confirm"
             )
    end
  end

  describe "we_see_attribute_and_value/3" do
    test "returns true if element with given data-test attribute and value is present in the rendered component" do
      assert we_see_attribute_and_value(
               @html_attribute_and_value_and_content,
               "confirmation button",
               "true"
             )

      assert we_see_attribute_and_value(
               @html_attribute_and_value_and_content,
               "cancellation button",
               "true"
             )
    end

    test "returns false if element with given data-test attribute is not present in the rendered component" do
      refute we_see_attribute_and_value(
               @html_attribute_and_value_and_content,
               "confirmation button",
               "false"
             )

      refute we_see_attribute_and_value(
               @html_attribute_and_value_and_content,
               "cancellation button",
               "false"
             )
    end

    test "returns true if element with given data-test attribute but value is empty" do
      assert we_see_attribute_and_value(@html_attribute_and_value_and_content, "other button", "")
    end
  end

  describe "we_see_attribute_and_value/4" do
    test "returns true if element with given data-test attribute, value and content is present in the rendered component" do
      assert we_see_attribute_and_value(
               @html_attribute_and_value_and_content,
               "confirmation button",
               "true",
               content: "Confirm"
             )

      assert we_see_attribute_and_value(
               @html_attribute_and_value_and_content,
               "cancellation button",
               "true",
               content: "Cancel"
             )
    end

    test "returns false if element with given data-test attribute is not present in the rendered component" do
      refute we_see_attribute_and_value(
               @html_attribute_and_value_and_content,
               "confirmation button",
               "true",
               content: "Cancel"
             )

      refute we_see_attribute_and_value(
               @html_attribute_and_value_and_content,
               "cancellation button",
               "true",
               content: "Confirm"
             )
    end

    test "returns true if element with given data-test attribute and content is present in the rendered component but value is empty" do
      refute we_see_attribute_and_value(
               @html_attribute_and_value_and_content,
               "confirmation button",
               "",
               content: "Confirm"
             )

      refute we_see_attribute_and_value(
               @html_attribute_and_value_and_content,
               "cancellation button",
               "",
               content: "Cancel"
             )
    end
  end

  describe "we_see_attribute_value/2" do
    test "returns true if element with given data-test attribute value is present in the rendered component" do
      assert we_see_attribute_value(
               @html_attribute_value_and_content,
               "confirmation button"
             )

      assert we_see_attribute_value(
               @html_attribute_value_and_content,
               "cancellation button"
             )
    end

    test "returns false if element with given data-test attribute value is not present in the rendered component" do
      refute we_see_attribute_value(
               @html_attribute_value_and_content,
               "confirmationButton"
             )

      refute we_see_attribute_value(
               @html_attribute_value_and_content,
               "cancellationButton"
             )
    end

    test "returns true if attribute value is empty" do
      assert we_see_attribute_value(@html_attribute_value_and_content, "")
    end

    test "returns false if attribute value partially matches" do
      refute we_see_attribute_value(@html_attribute_value_and_content, "confirmation")
      refute we_see_attribute_value(@html_attribute_value_and_content, "confirmation buttons")
    end
  end

  describe "we_test_attribute_value/3" do
    test "returns true if element with given data-test attribute value and content is present in the rendered component" do
      assert we_see_attribute_value(
               @html_attribute_value_and_content,
               "confirmation button",
               content: "Confirm"
             )

      assert we_see_attribute_value(
               @html_attribute_value_and_content,
               "cancellation button",
               content: "Cancel"
             )
    end

    test "returns false if element with given data-test attribute value is not present in the rendered component" do
      refute we_see_attribute_value(
               @html_attribute_value_and_content,
               "confirmation button",
               content: "Cancel"
             )

      refute we_see_attribute_value(
               @html_attribute_value_and_content,
               "cancellation button",
               content: "Confirm"
             )
    end

    test "returns true if attribute value is empty and content is given" do
      assert we_see_attribute_value(@html_attribute_value_and_content, "", content: "Other")
    end
  end

  describe "we_see_exactly/3" do
    test "only return true if element with attribute is seen exactly x times" do
      assert we_see_exactly(@html_multiple_elements, 1, attribute: "title")
      assert we_see_exactly(@html_multiple_elements, 3, attribute: "user")
      assert we_see_exactly(@html_multiple_elements, 3, attribute: "name")

      refute we_see_exactly(@html_multiple_elements, 2, attribute: "title")
      refute we_see_exactly(@html_multiple_elements, 0, attribute: "title")

      refute we_see_exactly(@html_multiple_elements, 2, attribute: "user")
      refute we_see_exactly(@html_multiple_elements, 4, attribute: "user")

      refute we_see_exactly(@html_multiple_elements, 2, attribute: "name")
      refute we_see_exactly(@html_multiple_elements, 4, attribute: "name")
    end

    test "only return true if element with attribute and attribute value is seen exactly x times" do
      assert we_see_exactly(@html_multiple_elements, 1,
               attribute: "user",
               attribute_value: "new user"
             )

      assert we_see_exactly(@html_multiple_elements, 2,
               attribute: "user",
               attribute_value: "existing user"
             )

      refute we_see_exactly(@html_multiple_elements, 2,
               attribute: "user",
               attribute_value: "new user"
             )

      refute we_see_exactly(@html_multiple_elements, 1,
               attribute: "user",
               attribute_value: "existing user"
             )
    end

    test "only return true if element with attribute value is seen exactly x times" do
      assert we_see_exactly(@html_multiple_elements, 1, attribute_value: "childhood")
      assert we_see_exactly(@html_multiple_elements, 2, attribute_value: "adulthood")

      refute we_see_exactly(@html_multiple_elements, 2, attribute_value: "childhood")
      refute we_see_exactly(@html_multiple_elements, 1, attribute_value: "adulthood")
    end

    test "only return true if element with attribute and content is seen exactly x times" do
      assert we_see_exactly(@html_multiple_elements, 2, attribute: "age", content: "30")
      assert we_see_exactly(@html_multiple_elements, 1, attribute: "age", content: "15")

      refute we_see_exactly(@html_multiple_elements, 1, attribute: "age", content: "30")
      refute we_see_exactly(@html_multiple_elements, 2, attribute: "age", content: "15")
    end

    test "only return true of element with attribute, attribute value and content is seen exactly x times" do
      assert we_see_exactly(@html_multiple_elements, 2,
               attribute: "age",
               attribute_value: "30",
               content: "30"
             )

      assert we_see_exactly(@html_multiple_elements, 1,
               attribute: "age",
               attribute_value: "15",
               content: "15"
             )

      refute we_see_exactly(@html_multiple_elements, 1,
               attribute: "age",
               attribute_value: "30",
               content: "30"
             )

      refute we_see_exactly(@html_multiple_elements, 2,
               attribute: "age",
               attribute_value: "15",
               content: "15"
             )
    end

    test "only return true if element with attribute value and content is seen exactly x times" do
      assert we_see_exactly(@html_multiple_elements, 2,
               attribute_value: "adulthood",
               content: "Adult"
             )

      assert we_see_exactly(@html_multiple_elements, 1,
               attribute_value: "childhood",
               content: "Child"
             )

      refute we_see_exactly(@html_multiple_elements, 1,
               attribute_value: "adulthood",
               content: "Adult"
             )

      refute we_see_exactly(@html_multiple_elements, 2,
               attribute_value: "childhood",
               content: "Child"
             )
    end
  end

  describe "we_see_at_least/3" do
    test "only return true if element with attribute is seen at least x times" do
      assert we_see_at_least(@html_multiple_elements, 1, attribute: "title")
      assert we_see_at_least(@html_multiple_elements, 3, attribute: "user")
      assert we_see_at_least(@html_multiple_elements, 3, attribute: "name")

      refute we_see_at_least(@html_multiple_elements, 2, attribute: "title")

      assert we_see_at_least(@html_multiple_elements, 1, attribute: "user")
      assert we_see_at_least(@html_multiple_elements, 2, attribute: "user")
      refute we_see_at_least(@html_multiple_elements, 4, attribute: "user")

      assert we_see_at_least(@html_multiple_elements, 2, attribute: "name")
      refute we_see_at_least(@html_multiple_elements, 4, attribute: "name")
    end

    test "only return true if element with attribute and attribute value is seen at least x times" do
      assert we_see_at_least(@html_multiple_elements, 1,
               attribute: "user",
               attribute_value: "new user"
             )

      assert we_see_at_least(@html_multiple_elements, 2,
               attribute: "user",
               attribute_value: "existing user"
             )

      assert we_see_at_least(@html_multiple_elements, 1,
               attribute: "user",
               attribute_value: "existing user"
             )

      refute we_see_at_least(@html_multiple_elements, 2,
               attribute: "user",
               attribute_value: "new user"
             )

      refute we_see_at_least(@html_multiple_elements, 3,
               attribute: "user",
               attribute_value: "existing user"
             )
    end

    test "only return true if element with attribute value is seen at least x times" do
      assert we_see_at_least(@html_multiple_elements, 1, attribute_value: "childhood")
      assert we_see_at_least(@html_multiple_elements, 1, attribute_value: "adulthood")
      assert we_see_at_least(@html_multiple_elements, 2, attribute_value: "adulthood")

      refute we_see_at_least(@html_multiple_elements, 2, attribute_value: "childhood")
      refute we_see_at_least(@html_multiple_elements, 3, attribute_value: "adulthood")
    end

    test "only return true if element with attribute and content is seen at least x times" do
      assert we_see_at_least(@html_multiple_elements, 2, attribute: "age", content: "30")
      assert we_see_at_least(@html_multiple_elements, 1, attribute: "age", content: "15")
      assert we_see_at_least(@html_multiple_elements, 1, attribute: "age", content: "30")

      refute we_see_at_least(@html_multiple_elements, 3, attribute: "age", content: "30")
      refute we_see_at_least(@html_multiple_elements, 2, attribute: "age", content: "15")
    end

    test "only return true if element with attribute, attribute value and content is seen at least x times" do
      assert we_see_at_least(@html_multiple_elements, 2,
               attribute: "age",
               attribute_value: "30",
               content: "30"
             )

      assert we_see_at_least(@html_multiple_elements, 1,
               attribute: "age",
               attribute_value: "15",
               content: "15"
             )

      assert we_see_at_least(@html_multiple_elements, 1,
               attribute: "age",
               attribute_value: "30",
               content: "30"
             )

      refute we_see_at_least(@html_multiple_elements, 3,
               attribute: "age",
               attribute_value: "30",
               content: "30"
             )

      refute we_see_at_least(@html_multiple_elements, 2,
               attribute: "age",
               attribute_value: "15",
               content: "15"
             )
    end

    test "only return true if element with attribute value and content is seen at least x times" do
      assert we_see_at_least(@html_multiple_elements, 2,
               attribute_value: "adulthood",
               content: "Adult"
             )

      assert we_see_at_least(@html_multiple_elements, 1,
               attribute_value: "childhood",
               content: "Child"
             )

      assert we_see_at_least(@html_multiple_elements, 1,
               attribute_value: "adulthood",
               content: "Adult"
             )

      refute we_see_at_least(@html_multiple_elements, 3,
               attribute_value: "adulthood",
               content: "Adult"
             )

      refute we_see_at_least(@html_multiple_elements, 2,
               attribute_value: "childhood",
               content: "Child"
             )
    end
  end
end
