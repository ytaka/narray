require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe NArray do
  def get_max(obj)
    obj.to_a.flatten.max
  end

  def get_min(obj)
    obj.to_a.flatten.min
  end

  def get_sum(obj)
    obj.to_a.flatten.inject(0) { |s, a| a + s }
  end

  def get_mean(obj)
    obj.to_a.flatten.inject(0) { |s, a| a + s } / obj.total.to_f
  end

  def get_stddev(obj)
    m = obj.mean
    sd = 0.0
    obj.each do |val|
      sd += (val - m) ** 2
    end
    Math.sqrt(sd / (obj.total.to_f - 1.0))
  end

  context "when calculating some values for an array" do
    targets = [['one-dimensional array', NArray[0,2, -2.5, 3, 1.4],],
               ['two-dimensional array',
                NArray.float(5,1).indgen!(1) * NArray.float(1,3).indgen!(1)]]
    targets.each do |mes, obj|
      it "should return maximum for #{mes}." do
        obj.max.should == get_max(obj)
      end

      it "should return minimum for #{mes}." do
        obj.min.should == get_min(obj)
      end

      it "should return sum for #{mes}" do
        obj.sum.should == get_sum(obj)
      end

      it "should return mean value for #{mes}" do
        obj.mean.should == get_mean(obj)
      end

      it "should return standard deviation for #{mes}." do
        obj.stddev.should == get_stddev(obj)
      end
    end
  end

  context "when calculating some values for part of matrix" do
    subject do
      NArray.float(5,1).indgen!(1) * NArray.float(1,3).indgen!(1)
    end

    def na_map_for_dim(obj, dim, method_sym)
      range = Array.new(obj.dim) { true }
      n = (dim + 1) % 2
      ary = obj.shape[n].times.map do |i|
        range[n] = i
        __send__(method_sym, obj[*range])
      end
      NArray.to_na(ary)
    end

    2.times do |i|
      it "should return maximum for #{i}th dimension." do
        subject.max(i).should == na_map_for_dim(subject, i, :get_max)
      end

      it "should return minimum for #{i}th dimension." do
        subject.min(i).should == na_map_for_dim(subject, i, :get_min)
      end

      it "should return sum for #{i}th dimension." do
        subject.sum(i).should == na_map_for_dim(subject, i, :get_sum)
      end

      it "should return mean value for #{i}th dimension." do
        subject.mean(i).should == na_map_for_dim(subject, i, :get_mean)
      end

      it "should return stddev for #{i}th dimension." do
        subject.stddev(i).should == na_map_for_dim(subject, i, :get_stddev)
      end

    end

    [:max, :min, :sum, :mean, :stddev].each do |m|
      it "should raise error for invalid range for #{m}." do
        lambda do
          subject.max(2)
        end.should raise_error
      end
    end

    it "should calculate standard deviation." do
      x = NArray[65, 63, 67, 64, 68, 62, 70, 66, 68, 67, 69, 71]
      x.stddev.should == get_stddev(x)
    end
  end
end
