require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe NArray do
  it "should sort an array of integers." do
    a = NArray.int(16).random!(100)
    a.sort.to_a.should == a.to_a.sort
  end

  it "should sort an array of strings." do
    a = NArray.int(16).random!(100).to_string
    a.sort.to_a.should == a.to_a.sort
  end

  it "should sort up to 0-rank." do
    a = NArray.int(4, 4).random!(100)
    sorted = a.sort(0)
    4.times do |i|
      sorted[true, i].to_a.should == a[true, i].to_a.sort
    end
  end

  it "should sort big array." do
    a = NArray.int(10, 10, 10, 10, 10).random!(100)
    sorted = a.sort(1)
    10.times do |i1|
      10.times do |i2|
        10.times do |i3|
          ary = a[true, true, i1, i2, i3].to_a.flatten.sort.each_slice(10).to_a
          sorted[true, true, i1, i2,i3].to_a.should == ary
        end
      end
    end
  end

  it "should sort index." do
    a = NArray.int(7, 4).random!(100)
    sind = a.sort_index(0)
    4.times do |i|
      ary = a[true, i].to_a
      sorted = []
      sind[true, i].to_a.map do |i|
        sorted << ary[i]
      end
      sorted.sort.should == sorted
    end
  end

  it "should raise error for an array of complexes." do
    lambda do
      NArray.complex(3,3).random!(100).sort
    end.should raise_error
  end
end
