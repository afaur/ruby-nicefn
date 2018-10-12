# Place the Sing module inside of a namespace
module Nicefn
  # Add one-liner singleton method/fn declaration capabilities for a module
  module Sing
    extend self
    define_method(:included) do |klass|
      klass.extend klass

      define_method(:fn) { |func, &blk| define_method(func, &blk) }

      define_method(:fp) do |func, &blk|
        define_method(func, &blk)
        private func
      end
    end
  end
end
