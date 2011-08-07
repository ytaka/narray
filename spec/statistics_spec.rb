require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe NArray do
  include NMath

  before(:all) do
    @x = NArray[65, 63, 67, 64, 68, 62, 70, 66, 68, 67, 69, 71]
    @y = NArray[68, 66, 68, 65, 69, 66, 68, 65, 71, 67, 68, 70]
  end

  it "should calculate covariance." do
    mean_x = @x.mean
    mean_y = @y.mean
    cv = 0.0
    i = 0
    @x.each do |v1|
      v2 = @y[i]
      cv += (v1 - mean_x) * (v2 - mean_y)
      i += 1
    end
    cv /= (i.to_f - 1)
    covariance(@x, @y).should == cv
  end

  it "should sort." do
    @x.sort.to_a.should == @x.to_a.sort
  end

  it "should calculate median." do
    @x.median.should.should == ((@x.min + @x.max) / 2.0).ceil
  end

  it "should calculate median (2)." do
    (@x + @y.newrank!(0)).median(0)
  end
end
