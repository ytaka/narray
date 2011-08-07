require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe NArray do
  context "when counting" do
    before(:all) do
      @byte_ary = NArray.byte(10)
      @byte_ary[2..4] = 1
      @float_ary = NArray.float(10)
    end

    it "should count true." do
      @byte_ary.count_true.should == 3
    end

    it "should count false." do
      @byte_ary.count_false.should == 7
    end

    it "should raise error for count_true." do
      lambda do
        @float_ary.count_true
      end.should raise_error
    end

    it "should raise error for count_false." do
      lambda do
        @float_ary.count_false
      end.should raise_error
    end
  end

  def check_mask(na, mask, m, &block)
    orig = na.to_a.flatten
    ary = na.__send__(m, mask).to_a.flatten
    i = 0
    j = 0
    mask.each do |m|
      if m == 1
        if block_given?
          yield(ary[j])
        else
          ary[j].should == orig[i]
        end
        j += 1
      end
      i += 1
    end
  end

  context "when masking float" do
    before(:all) do
      @a = NArray.float(5,3).indgen!
      @mask = @a.lt((@a - 2) * 2)
    end

    it "should mask." do
      check_mask(@a, @mask, :mask)
    end

    it "should mask by square bracket." do
      check_mask(@a, @mask, '[]')
    end
  end

  context "when masking complex" do
    before(:all) do
      @a = NArray.complex(5).indgen! + Complex::I
      @mask = NArray.byte(5)
      @mask[true] = [0,0,1,1,0]
    end

    it "should mask." do
      check_mask(@a, @mask, :mask)
    end

    it "should mask by square bracket." do
      check_mask(@a, @mask, '[]')
    end

    it "should replace elements." do
      val_new = 100.0
      @a[@mask] = val_new
      check_mask(@a, @mask, :mask) do |val|
        val.should == val_new
      end
    end
  end
end
