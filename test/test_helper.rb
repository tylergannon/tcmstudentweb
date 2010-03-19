ENV["RAILS_ENV"] = "test"
require File.expand_path(File.dirname(__FILE__) + "/../config/environment")
require 'test_help'
require 'factory_girl'
require "authlogic/test_case"
require "factories.rb"
require 'object_hasher.rb'


class ActiveSupport::TestCase
  include Authlogic::TestCase
#  setup :activate_authlogic
  # Transactional fixtures accelerate your tests by wrapping each test method
  # in a transaction that's rolled back on completion.  This ensures that the
  # test database remains unchanged so your fixtures don't have to be reloaded
  # between every test method.  Fewer database queries means faster tests.
  #
  # Read Mike Clark's excellent walkthrough at
  #   http://clarkware.com/cgi/blosxom/2005/10/24#Rails10FastTesting
  #
  # Every Active Record database supports transactions except MyISAM tables
  # in MySQL.  Turn off transactional fixtures in this case; however, if you
  # don't care one way or the other, switching from MyISAM to InnoDB tables
  # is recommended.
  #
  # The only drawback to using transactional fixtures is when you actually
  # need to test transactions.  Since your test is bracketed by a transaction,
  # any transactions started in your code will be automatically rolled back.

  self.use_transactional_fixtures = true

  # Instantiated fixtures are slow, but give you @david where otherwise you
  # would need people(:david).  If you don't want to migrate your existing
  # test cases which use the @david style and don't mind the speed hit (each
  # instantiated fixtures translates to a database query per test method),
  # then set this back to true.
  self.use_instantiated_fixtures  = false

  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all

  def self.logged_in_as(person, &block)
    context "logged in as #{person}" do
      setup do
        @request.session[:person] = people(person).id
      end

      yield
    end
  end

  def self.index_js_test(class_name, &block)
    context "on GET to :index.js" do
      setup do
        Factory(class_name)
        yield
        get :index, :format => "js"

      end
      should_assign_to(class_name.tableize)
      should_respond_with :success
      should_render_template :index
      should_not_set_the_flash
    end
  end

  def self.should_delete(klass, factory, &block)
    context "on DELETE to :destroy" do
      setup do
        Factory.create(factory)
        @obj = klass.last
        @id = @obj.id
        assert_not_nil(@obj.id)
        assert klass.exists?(@id)
        delete :destroy, :id => @obj.id
      end
      # should_change("the number of patterns", :by => -1) {Textbook.count}
      should "Delete it" do
        assert !klass.exists?(@id)
      end
      if block
        block
      end
    end
  end

  def should_contain(array, &block)
    assert(array.select{|v| block.call(v)}[0], "Array should contain an item like that.")
  end
  def should_not_contain(array, &block)
    assert(array.select{|v| block.call(v)}[0].nil?, "Array should not contain an item like that.")
  end
end
