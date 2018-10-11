module Nicefn::Sing
  extend self
  define_method(:included) {|klass|
    klass.extend klass
    define_method(:fn) {|func, &blk| define_method(func, &blk) }
    define_method(:fp) {|func, &blk| define_method(func, &blk); private func }
  }
end
