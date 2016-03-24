#    class AddToCart
#      include Interactor
#      def call cart, product
#        # errors[:base] << 'something wrong'
#        # results[:attr] = "value"
#      end
#    end
#
#    add_to_cart = AddToCart.call(cart, product)
#    if add_to_cart.success?
#      add_to_cart[:attr] # "value"
#    else
#      puts add_to_cart.errors
#    end
module Interactor
  def self.included(mod)
    mod.extend ClassMethods
  end

  module ClassMethods
    def call *args
      new(*args).tap(&:call)
    end
  end

  def call
    raise NotImplementedError
  end

  def results
    @results ||= {}
  end

  def errors
    @errors ||= {}
  end

  def success?
    errors.empty?
  end
end