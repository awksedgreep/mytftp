defmodule Mytftp do
  @behaviour Trivial.Server

  @impl true
  def init(file, _client, _data) do
    bin = File.read!(file)
    size = :erlang.size(bin)
    {:ok, {bin, size}}
  end

  @impl true
  @spec read(any(), any(), any(), any(), {any(), any()}) ::
          :done | {:ok, binary(), {binary(), any()}}
  def read(_request, pos, _len, _client, _data = {_str, size}) when pos > size do
    :done
  end

  @impl true
  def read(_request, pos, len, _client, data = {str, size}) when pos + len > size do
    {:ok, :erlang.binary_part(str, pos, size - pos), data}
  end

  @impl true
  def read(_request, pos, len, _client, data = {str, _size}) do
    {:ok, :erlang.binary_part(str, pos, len), data}
  end

  @impl true
  def tsize(_request, _client, data = {_, size}) do
    {:ok, size, data}
  end
end
