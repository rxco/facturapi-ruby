module Facturapi
  module Util

    def self.convert_to_facturapi_object(name,resp)
      # these json strings should not be parsed into objects
      return resp if ["data", "request_body", "request_headers", "response_headers", "response_body", "query_string", "metadata", "antifraud_info"].include?(name)
      if resp.kind_of?(Hash)
        if resp.has_key?('object') and types[resp['object']]
          if resp['object'] == "list"
            instance = types[resp['object']].new(name, resp)
          else
            instance = types[resp['object']].new()
          end

          instance.load_from(resp)

          return instance
        elsif name.instance_of? String
          name = "shippin_line_method" if name == "method"
          name = "event_data" if camelize(name) == "Data"
          name = "obj" if camelize(name) == "Object"
          if !Object.const_defined?(camelize(name))
            instance = Object.const_set(camelize(name), Class.new(FacturapiObject)).new
          else
            begin
              instance = constantize("Facturapi::"+camelize(name)).new
            rescue # Class is not defined
              instance = constantize(camelize(name)).new
            end
          end

          instance.load_from(resp)

          return instance
        end
      end

      if resp.kind_of?(Array)
        instance = FacturapiObject.new
        instance.load_from(resp)
        if !resp.empty? and resp.first.instance_of? Hash and !resp.first["object"]
          resp.each_with_index do |r, i|
            obj = convert_to_facturapi_object(name,r)
            instance.set_val(i,obj)
            instance[i] = obj
          end
        end
        return instance
      end
      return instance
    end

    def self.underscore(str)
      str.split(/::/).last.
        gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
        gsub(/([a-z\d])([A-Z])/,'\1_\2').
        tr("-", "_").
        downcase
    end

    protected

    def self.camelize(str)
      str.split('_').map{|e| e.capitalize}.join
    end

    def self.constantize(camel_cased_word)
      names = camel_cased_word.split('::')

      # Trigger a builtin NameError exception including the ill-formed constant in the message.
      Object.const_get(camel_cased_word) if names.empty?

      # Remove the first blank element in case of '::ClassName' notation.
      names.shift if names.size > 1 && names.first.empty?

      names.inject(Object) do |constant, name|
        if constant == Object
          constant.const_get(name)
        else
          candidate = constant.const_get(name)
          next candidate if constant.const_defined?(name, false)
          next candidate unless Object.const_defined?(name)

          # Go down the ancestors to check it it's owned
          # directly before we reach Object or the end of ancestors.
          constant = constant.ancestors.inject do |const, ancestor|
            break const    if ancestor == Object
            break ancestor if ancestor.const_defined?(name, false)
            const
          end

          # owner is in Object, so raise
          constant.const_get(name, false)
        end
      end
    end
  end
end