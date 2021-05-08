json.data do
  json.candidate do
    json.call(
        resource,
        :id,
        :email
    )
  end
end