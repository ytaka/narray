require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe NArray do
  subject do
    NArray.float(3,3).indgen!
  end

  it "should not change." do
    lambda do
      subject[[]] = []
    end.should_not change { subject }
  end

  it "should replace one element." do
    orig = subject.to_a.flatten!
    subject[1, 1] = 0
    i = 0
    subject.each do |el|
      if i == 4
        el.should == 0
      else
        el.should == orig[i]
      end
      i += 1
    end
  end

  it "should replace elements specified by a range." do
    orig = subject.to_a.flatten!
    subject[0..-1, 1] = 0
    i = 0
    subject.each do |el|
      if i >= 3 && i < 6
        el.should == 0
      else
        el.should == orig[i]
      end
      i += 1
    end
  end

  it "should replace elements specified by an array." do
    orig = subject.to_a.flatten!
    ary = [100,101,102]
    subject[1, 2..0] = ary
    i = 0
    subject.each do |el|
      if i % 3 == 1
        el.should == ary[-(i / 3 + 1)]
      else
        el.should == orig[i]
      end
      i += 1
    end
  end

  it "should replace elements specified by starting point." do
    orig = subject.to_a.flatten!
    ary = [100, 101, 102]
    subject[0, 1] = ary
    i = 0
    subject.each do |el|
      if i > 2 && i < 6
        el.should == ary[i - 3]
      else
        el.should == orig[i]
      end
      i += 1
    end
  end

  it "should replace entire range." do
    # `true' means entire range
    orig = subject.to_a.flatten!
    ary = [100, 101, 102]
    subject[true, 1] = ary
    i = 0
    subject.each do |el|
      if i > 2 && i < 6
        el.should == ary[i - 3]
      else
        el.should == orig[i]
      end
      i += 1
    end
  end

  it "should replace two-dimensional entire range." do
    orig = subject.to_a.flatten!
    ary = [100, 101, 102]
    subject[true, true] = [ary]
    i = 0
    subject.each do |el|
      el.should == ary[i % 3]
      i += 1
    end
  end

  it "should raise error." do
    lambda do
      subject[true,1] = [[100,101,102]]
    end.should raise_error
  end

  it "should raise error (2)." do
    lambda do
      subject[true,1] = [[100],[101],[102]]
    end.should raise_error
  end

  it "should raise error (3)." do
    lambda do
      subject[true,true] = [100,101,102]
    end.should raise_error
  end

  it "should raise error (4)." do
    lambda do
      subject[1,0] = [100,101,102]
    end.should raise_error
  end
end
