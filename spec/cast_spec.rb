require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe NArray do
  subject do
    NArray.int(3,3).indgen!
  end

  it "should convert when add 1.5 to the array." do
    (subject + 1.5).should == NArray[[1, 2, 3], [4, 5, 6], [7, 8, 9]]
  end

  it "should convert when add the array to 1.5." do
    (subject + 1.5).should == NArray[[1, 2, 3], [4, 5, 6], [7, 8, 9]]
  end

  it "should convert when add an array of floats to the array." do
    (subject + NArray[1.2, 3.4, 5.6]).should == NArray[[1.2, 4.4, 7.6], [4.2, 7.4, 10.6], [7.2, 10.4, 13.6]]
  end

  it "should convert when add an array of complexes to the array." do
    a = NArray[[Complex(0.5, 1.5), Complex(1.5, 1.5), Complex(2.5, 1.5)],
               [Complex(3.5, 1.5), Complex(4.5, 1.5), Complex(5.5, 1.5)],
               [Complex(6.5, 1.5), Complex(7.5, 1.5), Complex(8.5, 1.5)]]
    (subject + NArray[Complex(0.5,1.5)]).should == a
  end
end
