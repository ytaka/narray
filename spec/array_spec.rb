require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe NArray do

  it "should create an array." do
    a = NArray.float(3,3).indgen
    ary = [[[0.0, 1.0, 2.0], [3.0, 4.0, 5.0], [6.0, 7.0, 8.0]],
           [[100.0, 0.0, 0.0], [101.0, 0.0, 0.0], [0.0, 0.0, 0.0]]]
    NArray[a, [100, 101]].should == NArray.to_na(ary)
  end

  it "should create an array (2)." do
    b = NArray[[[0.0, 1.0, 2.0],
                [3.0, 4.0, 5.0],
                [6.0, 7.0, 8.0]],
               [100,101]]
    ary = [[[0.0, 1.0, 2.0], [3.0, 4.0, 5.0], [6.0, 7.0, 8.0]],
           [[100.0, 0.0, 0.0], [101.0, 0.0, 0.0], [0.0, 0.0, 0.0]]]
    b.should == NArray.to_na(ary)
  end

  it "should create an array (3)." do
    a = NArray.float(2,2).indgen
    b = NArray[a, [a]]
    ary = [[[[0.0, 0.0],
             [1.0, 0.0]],
            [[2.0, 0.0],
             [3.0, 0.0]]],
           [[[0.0, 1.0],
             [2.0, 3.0]],
            [[0.0, 0.0],
             [0.0, 0.0]]]]
    b.should == NArray.to_na(ary)
  end

  it "should create an array (4)." do
    b = NArray[[0.0, 1.0], 
               [[0.0, 1.0]]]
    ary = [[[0.0, 0.0],
            [1.0, 0.0]],
           [[0.0, 1.0],
            [0.0, 0.0]]]
    b.should == NArray.to_na(ary)
  end
end
