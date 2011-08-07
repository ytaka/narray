require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe NArray do
  before(:all) do
    srand(1)
    @n = 5
    @m = NMatrix.object(@n, @n).collect { Rational(rand(10)) }
  end

  it "should divide (multiplied by the inverse matrix)." do
    mat = @m / @m
    @n.times do |i|
      col = mat[i, true]
      @n.times do |j|
        col[j].should == (i == j ? 1 : 0)
      end
    end
  end
end
