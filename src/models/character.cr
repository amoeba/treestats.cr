require "json"

class Character
  JSON.mapping(
    server: {type: String, nilable: false},
    name: {type: String, nilable: false},
  )

  def valid?
    # TODO
    true
  end
end
