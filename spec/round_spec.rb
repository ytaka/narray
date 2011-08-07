require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe NArray do
  subject do
    (NArray.float(4, 2).indgen!) / 4 - 2
  end

  [:floor, :ceil, :round].each do |m|
    it "should #{m}." do
      subject.__send__(m).should == subject.collect do |n|
        n.__send__(m)
      end
    end
  end
end
