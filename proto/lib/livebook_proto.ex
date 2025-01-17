defmodule LivebookProto do
  @moduledoc false

  alias LivebookProto.{
    Event,
    FileSystemCreated,
    FileSystemDeleted,
    FileSystemUpdated,
    SecretCreated,
    SecretDeleted,
    SecretUpdated,
    UserSynchronized
  }

  @event_mapping (for {_id, field_prop} <- Event.__message_props__().field_props,
                      into: %{} do
                    {field_prop.type, field_prop.name_atom}
                  end)

  @type event_proto ::
          FileSystemCreated.t()
          | FileSystemDeleted.t()
          | FileSystemUpdated.t()
          | SecretCreated.t()
          | SecretDeleted.t()
          | SecretUpdated.t()
          | UserSynchronized.t()

  @doc """
  Builds an event with given data.
  """
  @spec build_event(event_proto()) :: Event.t()
  def build_event(%struct{} = data) do
    Event.new!(type: {event_type(struct), data})
  end

  defp event_type(module), do: Map.fetch!(@event_mapping, module)
end
