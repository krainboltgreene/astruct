require 'benchmark/ips'
require 'astruct'
require 'ostruct'

DATA = (1..10_000).map { |i| { :"item#{i}" => i } }.inject :merge!

Benchmark.ips do |x|
  x.report "OStruct load with data" do
    class OProfile < OpenStruct; end
    op = OProfile.new
    op.marshal_load DATA.dup
  end

  x.report "AStruct load with data" do
    class AProfile < AltStruct; end
    ap = AProfile.new
    ap.load DATA.dup
  end
end
# Calculating -------------------------------------
# OStruct load with data 1 i/100ms
# AStruct load with data 1 i/100ms
# -------------------------------------------------
# OStruct load with data 10.1 (±19.9%) i/s - 49 in 5.017475s
# AStruct load with data 10.3 (±29.1%) i/s - 50 in 5.090294s

# 2012-11-04 16:06:05 -0800
# Calculating -------------------------------------
# OStruct load with data
#                              1 i/100ms
# AStruct load with data
#                              1 i/100ms
# -------------------------------------------------
# OStruct load with data
#                             7.8 (±25.6%) i/s -         38 in   5.092898s
# AStruct load with data
#                             7.3 (±27.4%) i/s -         36 in   5.109352s
