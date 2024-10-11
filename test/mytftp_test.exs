defmodule MytftpTest do
  use ExUnit.Case
  doctest Mytftp

  test "greets the world" do
    assert Mytftp.hello() == :world
  end
end
