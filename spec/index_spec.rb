require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe NArray do
  subject do
    NArray.float(3,3).indgen!
  end

  it "should return elements for indexes." do
    subject[1, -1].should == 7.0
  end

  it "should return elements for a range" do
    subject[1, 2..0].should == NArray[7.0, 4.0, 1.0]
  end

  it "should return elements for ranges." do
    # without rank-reduce
    subject[1...2, 0..1].should == NArray[[1.0 ], [ 4.0 ]]
  end

  it "should do something" do
    subject[true, 0..1].should == NArray[[0.0, 1.0, 2.0], [3.0, 4.0, 5.0]]
  end

  it "should do something" do
    subject[0..5].should == NArray[0.0, 1.0, 2.0, 3.0, 4.0, 5.0]
  end
end
