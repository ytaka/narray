require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe NArray do
  def check_marshal_dump(src)
    dumped = Marshal.dump(src)
    dumped.should be_an_instance_of String
    loaded = Marshal.load(dumped)
    loaded.should be_an_instance_of src.class
    loaded.should == src
  end

  context "when dumping objects of NArray" do
    it "should dump an object of integers." do
      check_marshal_dump(NArray[[1, -2, 3], [-4, 5, -6]])
    end

    it "should dump an object of floats." do
      check_marshal_dump(NArray[[1.0, -2.0, 3.0], [-4.0, 5.0, -6.0]])
    end

    it "should dump an object of complexes." do
      check_marshal_dump(NArray[[Complex(1, 2), Complex(-2, -0.3)],
                                [Complex(5, 6), 5.0], [9, 10]])
    end

    it "should dump an object of ruby objects." do
      check_marshal_dump(NArray.object(4, 4).indgen!(1).collect { |i| Rational(i) })
    end

    it "should dump an object of byte." do
      check_marshal_dump(NArray.byte(10).indgen!)
    end
  end

  context "when dumping objects of NMatrix" do
    it "should dump an object of integers." do
      check_marshal_dump(NMatrix[[1, -2, 3], [-4, 5, -6]])
    end

    it "should dump an object of floats." do
      check_marshal_dump(NMatrix[[1.0, -2.0, 3.0], [-4.0, 5.0, -6.0]])
    end

    it "should dump an object of complexes." do
      check_marshal_dump(NMatrix[[Complex(1, 2), Complex(-2, -0.3)],
                                [Complex(5, 6), 5.0], [9, 10]])
    end

    it "should dump an object of ruby objects." do
      check_marshal_dump(NMatrix.object(4, 4).indgen!(1).collect { |i| Rational(i) })
    end

    it "should dump an object of byte." do
      check_marshal_dump(NMatrix.byte(3, 3).indgen!)
    end
  end

  context "when dumping objects of NVector" do
    it "should dump an object of integers." do
      check_marshal_dump(NVector[1, -2, 3, -4, 5, -6])
    end

    it "should dump an object of floats." do
      check_marshal_dump(NVector[1.0, -2.0, 3.0, -4.0, 5.0, -6.0])
    end

    it "should dump an object of complexes." do
      check_marshal_dump(NVector[Complex(1, 2), Complex(-2, -0.3), Complex(5, 6), 5.0, 10])
    end

    it "should dump an object of ruby objects." do
      check_marshal_dump(NVector.object(8).indgen!(1).collect { |i| Rational(i) })
    end

    it "should dump an object of byte." do
      check_marshal_dump(NVector.byte(10).indgen!)
    end
  end
end
