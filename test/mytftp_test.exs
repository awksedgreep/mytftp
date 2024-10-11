defmodule MytftpTest do
  use ExUnit.Case
  doctest Mytftp

  setup do
    File.write!("test_file.txt", "mark")
    on_exit(fn -> File.rm!("test_file.txt") end)
    :ok
  end

  test "init/3 reads the file and returns its content and size" do
    size = byte_size("mark")
    assert {:ok, {"mark", ^size}} = Mytftp.init("test_file.txt", nil, nil)
  end

  test "read/6 returns :done when position is greater than file size" do
    {:ok, data} = Mytftp.init("test_file.txt", nil, nil)
    size = byte_size("mark")
    assert :done = Mytftp.read(nil, size + 1, 1, nil, data)
  end

  test "read/6 returns the remaining part of the file when position + length is greater than file size" do
    {:ok, data} = Mytftp.init("test_file.txt", nil, nil)
    assert {:ok, "rk", ^data} = Mytftp.read(nil, 2, 3, nil, data)
  end

  test "read/6 returns the specified part of the file" do
    {:ok, data} = Mytftp.init("test_file.txt", nil, nil)
    assert {:ok, "ar", ^data} = Mytftp.read(nil, 1, 2, nil, data)
  end

  test "tsize/3 returns the size of the file" do
    {:ok, data} = Mytftp.init("test_file.txt", nil, nil)
    size = byte_size("mark")
    assert {:ok, ^size, ^data} = Mytftp.tsize(nil, nil, data)
  end
end
