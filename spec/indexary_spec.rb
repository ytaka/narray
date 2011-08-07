require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe NArray do
  subject do
    NArray.new(NArray::DFLOAT,5,5).indgen!
  end

  it "should return partial array for array indexes." do
    idx = [2, 0, 1]
    a = idx.map do |y|
      ary = []
      idx.each do |x|
        ary << subject[x, y]
      end
      ary
    end
    ret = NArray[*a]
    subject[idx, idx].should == ret
  end

  it "should convert to a narray." do
    idx = [2, 0, 1]
    na = NArray.to_na(idx) + 10
    na.should == NArray[*idx.map { |a| a + 10 }]
    ary = subject.to_a.flatten!
    subject[na].should == NArray[*na.to_a.map { |i| ary[i] }]
  end

  it "should return an empty array." do
    subject[1, []].should == NArray[]
  end

  it "should raise error." do
    idx = NArray.to_na([2, 0, 1]) + 10
    lambda do
      subject[idx, 0]
    end.should raise_error
  end
end
