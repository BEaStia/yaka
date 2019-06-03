module Yaka
  class SerializableObject
    def to_json(*_args)
      required_fields = self.class.const_get(:REQUIRED_FIELDS)
      initial = required_fields.each_with_object({}) do |field_name, result|
        result[field_name] = public_send(field_name)
      end

      optional_fields = self.class.const_get(:OPTIONAL_FIELDS)

      optional_fields.each do |field_name|
        value = public_send(field_name)
        initial[field_name] = value unless value.nil?
      end

      initial.to_json
    end
  end
end