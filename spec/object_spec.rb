require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

require 'rational'

describe NArray do
  before(:all) do
    @a = NArray.object(4, 4).fill!(Rational(1))
    @b = NArray.object(4, 4).indgen!(1).collect { |i| Rational(i) }
  end

  def calc_for_two_arrays(a, b, &block)
    ary_b = b.to_a.flatten
    a.to_a.flatten.map.with_index do |val, i|
      yield(val, ary_b[i])
    end
  end

  it "should return an array of rational number." do
    (@a + @b).to_a.flatten.should == calc_for_two_arrays(@a, @b) { |s, t| s + t }
  end

  it "should return an array of rational number (2)." do
    (@a / @b).to_a.flatten.should == calc_for_two_arrays(@a, @b) { |s, t| s / t }
  end

  it "should return an array of rational number (3)." do
    (@a / @b - @b).to_a.flatten.should == calc_for_two_arrays(@a, @b) { |s, t| s / t - t }
  end
end
