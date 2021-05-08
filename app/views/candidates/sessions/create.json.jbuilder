json.data do
  json.user do
    json.call(
        resource,
        :id,
        :email
    )
  end
end