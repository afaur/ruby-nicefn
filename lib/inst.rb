# Place the Inst module inside of a namespace
module Nicefn
  # Adds one-liner instance method/fn declaration capabilities for classes
  module Inst
    define_method(:fn) { |func, &blk| define_method(func, &blk) }

    define_method(:fp) do |func, &blk|
      define_method(func, &blk)
      private func
    end

    define_method(:fs) do |func, &blk|
      define_method(func, &blk)
      protected func
    end
  end
end
