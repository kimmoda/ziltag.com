#    class AddToCart
#      include Interactor
#      def call cart, product
#        # context[:foo] = 'bar'
#        # fail! 'something wrong'
#      end
#    end
#
#    add_to_cart = AddToCart.call(cart, product)
#    if add_to_cart.success?
#      add_to_cart[:attr] # "value"
#    else
#      puts add_to_cart[:error]
#    end
module Interactor
  def self.included(mod)
    mod.extend ClassMethods
  end

  module ClassMethods
    def call *args
      obj = new(*args)
      catch(:fail){ obj.call }
      obj
    end
  end

  def call
    raise NotImplementedError
  end

  def [] key
    context[key]
  end

  def context
    @context ||= {}
  end

  def success?
    !context[:error]
  end

  def fail! message
    context[:error] = message
    throw :fail
  end
end