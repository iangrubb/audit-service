defmodule AuditServiceTest do
  use ExUnit.Case
  doctest AuditService

  test "greets the world" do
    assert AuditService.hello() == :world
  end
end
