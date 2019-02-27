module Validation
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  module ClassMethods
    attr_accessor :to_validate

    def validate(name, type, attr = nil)
      self.to_validate = [] unless to_validate
      if type == :type
        raise "Invalid type for #{name}" unless attr.is_a? Class
      end
      to_validate << { name: name, type: type, attr: attr }
    end
  end

  module InstanceMethods
    def valid?
      validate!
      true
    rescue StandardError
      false
    end

    private

    def validate!
      self.class.to_validate.each do |validation|
        name = validation[:name]
        variable = instance_variable_get("@#{name}".to_sym)
        type = validation[:type]
        extra_attr = validation[:attr]
        method_name = "#{type}_validator".to_sym
        send(method_name, name, variable, extra_attr)
      end
    end

    def presence_validator(name, variable, useless)
      raise "Variable #{name} is empty" if variable.nil? || variable == ''

      true
    end

    def format_validator(name, variable, reg_pattern)
      raise "Variable #{name} has invalid format" if variable !~ reg_pattern

      true
    end

    def type_validator(name, variable, type)
      raise "Variable #{name} has invalid type" unless variable.is_a? type

      true
    end
  end
end

class Test
  include Validation
  validate :integer, :type, Integer
  validate :not_null, :presence
  validate :string, :type, String
  validate :formated, :format, /^[\w\d]{3}-?[\w\d]{2}$/
  def initialize(integer, not_null, string, formated)
    @integer = integer
    @not_null = not_null
    @string = string
    @formated = formated
  end
end
