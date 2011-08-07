require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe NMatrix do
  subject do
    NMatrix.float(3,3,3).indgen!
  end

  it "should return part of the matrix." do
    expected = 3.times.map do |i|
      subject[1, 1, i]
    end
    subject[1, 1, true].should == NArray.to_na(expected)
  end

  it "should return part of matrix (2)." do
    expected = 3.times.map do |j|
      [] << (0..1).map do |i|
        subject[i, 2, j]
      end
    end
    subject[0..1, 2, true].should == NArray.to_na(expected)
  end
end
