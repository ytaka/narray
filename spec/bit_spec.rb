require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe NArray do
  subject do
    NArray.byte(10).indgen!
  end
  
  it "should return bitwise AND with 1." do
    (subject & 1).to_a.should == [0, 1, 0, 1, 0, 1, 0, 1, 0, 1]
  end

  it "should return bitwise AND with 2." do
    (subject & 2).to_a.should == [0, 0, 2, 2, 0, 0, 2, 2, 0, 0]
  end

  it "should return bitwise AND with -1." do
    (subject & -1).to_a.should == [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
  end

  it "should return bitwise OR with 1" do
    (subject | 1).to_a.should == [1, 1, 3, 3, 5, 5, 7, 7, 9, 9]
  end

  it "should return bitwise OR with 2" do
    (subject | 2).to_a.should == [2, 3, 2, 3, 6, 7, 6, 7, 10, 11]
  end

  it "should return bitwise OR with -1" do
    (subject | -1).to_a.should == [255, 255, 255, 255, 255, 255, 255, 255, 255, 255]
  end
  
  it "should return bitwise XOR with 1" do
    (subject ^ 1).to_a.should == [1, 0, 3, 2, 5, 4, 7, 6, 9, 8]
  end

  it "should return bitwise XOR with 2" do
    (subject ^ 2).to_a.should == [2, 3, 0, 1, 6, 7, 4, 5, 10, 11]
  end

  it "should return bitwise XOR with -1" do
    (subject ^ -1).to_a.should == [255, 254, 253, 252, 251, 250, 249, 248, 247, 246]
  end

  it "should return bitwise NOT." do
    (~subject).to_a.should == [255, 254, 253, 252, 251, 250, 249, 248, 247, 246]
  end

  it "should return bitwise NOT." do
    (~NArray.int(10).indgen!).to_a.should == [-1, -2, -3, -4, -5, -6, -7, -8, -9, -10]
  end
end
