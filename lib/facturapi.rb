# Facturapi Ruby bindings
require "i18n"
require 'faraday'
require 'json'

# Version
require "facturapi/version"

# API operations
require 'facturapi/api_operations/create'
require 'facturapi/api_operations/save'
require 'facturapi/api_operations/delete'
require 'facturapi/api_operations/list'

# API resource support classes
require "facturapi/facturapi_object"
require "facturapi/api_resource"
require "facturapi/util"
require "facturapi/request"
require "facturapi/error"
require "facturapi/error_list"

# Named API resources
require "facturapi/customers"
# require "facturapi/products"
# require "facturapi/invoices"

module Facturapi
  @api_base = 'https://www.facturapi.io/v1/'
  @api_version = '2.0.0'
  @locale = 'es'

  def self.config
    yield self
  end

  def self.api_base
    @api_base
  end

  def self.api_base=(api_base)
    @api_base = api_base
  end

  def self.api_version
    @api_version
  end

  def self.api_version=(api_version)
    @api_version = api_version
  end

  def self.api_key
    @api_key
  end

  def self.api_key=(api_key)
    @api_key = api_key
  end

  def self.locale
    @locale
  end

  def self.locale=(locale)
    @locale = locale
  end
end

