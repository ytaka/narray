require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe NArray do
  subject do
    NArray.int(4, 3, 2).indgen!
  end

  it "should transpose first and second." do
    t = subject.transpose(1, 0)
    4.times do |i|
      3.times do |j|
        2.times do |k|
          subject[i, j, k].should == t[j, i, k]
        end
      end
    end
  end

  it "should transpose first and last." do
    t = subject.transpose(-1, 1..-2, 0)
    4.times do |i|
      3.times do |j|
        2.times do |k|
          subject[i, j, k].should == t[k, j, i]
        end
      end
    end
  end

  it "should transpose shift forward." do
    t = subject.transpose(1..-1, 0)
    4.times do |i|
      3.times do |j|
        2.times do |k|
          subject[i, j, k].should == t[j, k, i]
        end
      end
    end
  end
end
