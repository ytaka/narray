require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe NArray do

  context "when calculating" do
    before(:all) do
      @a = NArray.complex(4,1).indgen!.sbt!(-1) + 0.25.im
      @b = NArray.complex(1,3).indgen!.add!(-0.5).mul!(0.5.im)
    end

    def calculate(op)
      c = @b.to_a.map do |el|
        ary = []
        @a.each do |d|
          ary << d.__send__(op, el[0])
        end
        ary
      end
      NArray[*c]
    end

    it "should add an array to another array." do
      (@a + @b).should == calculate(:+)
    end

    it "should subtract an array from another array." do
      (@a - @b).should == calculate(:-)
    end

    it "should multiply two arrays." do
      (@a * @b).should == calculate(:*)
    end

    it "should divide an array by another array." do
      (@a / @b).should == calculate(:/)
    end

    it "should calculate power of two arrays." do
      (@a ** @b).should == calculate(:**)
    end
  end

  context "when executing complex functions" do
    subject do
      NArray.complex(4,1).indgen!.sbt!(-1) + 0.25.im
    end

    it "should return real parts." do
      subject.real.should == NArray[[1.0, 2.0, 3.0, 4.0]]
    end

    it "should return imaginary parts." do
      subject.imag.should == NArray[[0.25, 0.25, 0.25, 0.25]]
    end

    it "should return angles." do
      subject.angle.should == NArray[subject.to_a[0].map { |c| c.arg }]
    end

    it "should return conjugates." do
      subject.conj.should == NArray[subject.to_a[0].map { |c| c.conj }]
    end
  end
end
