require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe NArray do
  it "should create random floats." do
    NArray.float(5).random(10).each do |n|
      n.should be_an_instance_of Float
      n.should <= 10
    end
  end

  it "should create random floats less than one." do
    NArray.float(5).random.each do |n|
      n.should be_an_instance_of Float
      n.should <= 1.0
    end
  end

  it "should create random integers." do
    NArray.int(5).random(10).each do |n|
      n.should be_an_instance_of Fixnum
      n.should <= 10
    end
  end

  it "should create random integers (2)." do
    NArray.int(1000).random(10).each do |n|
      n.should be_an_instance_of Fixnum
      n.should <= 10
    end
  end

  it "should search for some number." do
    a = NArray.int(1000).random(10)
    idx = (a.eq 0).where
    idx.each do |i|
      a[i].should == 0
    end

    idx = (a.eq 10).where
    idx.each do |i|
      a[i].should == 10
    end
  end
end
