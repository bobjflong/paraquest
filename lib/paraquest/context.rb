module Paraquest
  class ParaquestNameError < StandardError; end
  class Context

    attr_reader :variables

    VAR = '$'
    NESTING = '__'

    def initialize(variables)
      @variables = variables
    end

    def substitute(references)
      result = {}
      references.each do |k,v|
        key = lookup(k)
        result[key] = lookup(v)
      end
      result
    end

    private

    def nested_reference?(reference)
      reference.include?(NESTING)
    end

    def handle_nested_reference(reference)
      current = variables
      nests = reference.split('__')
      nests.each_with_index do |v,i|
        current = current.fetch(v) do
          error_expression = nests.clone
          error_expression[i] = "< #{v} >"
          raise ParaquestNameError.new(error_expression.join(NESTING))
        end
      end
      current
    end

    def lookup(v)
      result = nil
      if v.is_a?(String)
        subsitution = nil
        if v.start_with?(VAR)
          reference = v.sub(VAR, '')
          return handle_nested_reference(reference) if nested_reference?(reference)
          if variables.has_key?(reference)
            subsitution = variables.fetch(reference)
          end
        end
        return subsitution || v
      elsif v.is_a?(Hash)
        return substitute(v)
      end
      v
    end
  end
end
