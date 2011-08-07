require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe NArray do
  include NMath

  context "when calculating for complexes" do
    before(:all) do
      n = 7
      @x = NArray.complex(n).random!(1)
      @x.imag = NArray.float(n).random!(1)
      @err = 1e-8
    end

    METHODS1 = [[:sin, :asin], [:cos, :acos], [:tan, :atan], [:sinh, :asinh], [:cosh, :acosh], [:tanh, :atanh]]
    METHODS2 = [[:sec, :asec], [:sech, :sech]]

    METHODS1.each do |methods|
      methods.each do |m|
        it "should calculate #{m}." do
          ret = __send__(m, @x).to_a
          expected = @x.to_a.map { |a| __send__(m, a) }
          ret.each_with_index do |val, i|
            val.should be_within(@err).of(expected[i])
          end
        end
      end
    end

    METHODS1.each do |methods|
      it "should calculate inverse function (#{methods.map(&:to_s).join(' ')})." do
        ret = __send__(methods[1], __send__(methods[0], @x)).to_a
        expected = @x.to_a
        ret.each_with_index do |val, i|
          val.should be_within(@err).of(expected[i])
        end
      end
    end

    METHODS2.each do |methods|
      methods.each do |m|
        it "should not raise error for #{m}." do
          lambda do
            __send__(m, @x)
          end.should_not raise_error
        end
      end
    end
  end

  context "when calculating log" do
    before(:all) do
      @i = NArray.complex(1)
      @i.imag = 1
      n = 7
      @x = NArray.complex(n).random!(1)
      @x.imag = NArray.float(n).random!(1)
      @err = 1e-8
    end

    it "should set imaginary parts." do
      @i[0].should == Complex(0, 1)
    end

    it "should return same results." do
      a = -@i * log(sqrt(1 - @x ** 2) * @i + @x)
      b = -@i * log(sqrt(@x ** 2 - 1) + @x)
      (a - b).abs.should be_within(@err).of(@err)
    end

    it "should return same results (2)." do
      a = -@i * log(sqrt(1 - @x ** 2) + @x * @i)
      b = -@i * log((-sqrt(@x ** 2 - 1) + @x) * @i)
      (a - b).abs.should be_within(@err).of(@err)
    end
  end
end
