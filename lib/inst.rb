module Nicefn::Inst
  define_method(:fn) {|func, &blk| define_method(func, &blk) }
  define_method(:fp) {|func, &blk| define_method(func, &blk); private func }
  define_method(:fs) {|func, &blk| define_method(func, &blk); protected func }
end
