require 'spec_helper'

describe NArray do
  describe '#shape' do
    it "should return the correct shape" do
      NArray[[1, 2, 3], [4, 5, 6]].shape.should eq([3, 2])
    end
  end

  describe '#rank' do
    it "should return correct rank" do
      NArray[[1, 2], [3, 4]].rank.should == 2
    end
  end

  describe '#reshape' do
    subject { NArray[0, 1, 2, 3, 4, 5] }

    it "should reshape the array" do
      subject.reshape(3, 2).should eq(NArray[[0, 1, 2], [3, 4, 5]])
    end

    it "should return new object" do
      subject.reshape(3, 2).should_not eq(subject)
    end

    it "should guess size of one dimension" do
      subject.reshape(true, 2).should eq(NArray[[0, 1, 2], [3, 4, 5]])
    end

    it "should raise argument exception when size argument is incorrect" do
      lambda { subject.reshape(5, 2) }.should raise_error(ArgumentError)
    end

    it "should raise runtime exception when array is empty" do
      lambda { NArray[].reshape(3, 2) }.should raise_error(RuntimeError)
    end
  end

  describe '#reshape!' do
    subject { NArray[0, 1, 2, 3, 4, 5] }

    it "should reshape the array" do
      subject.reshape!(3, 2).should eq(NArray[[0, 1, 2], [3, 4, 5]])
    end

    it "should return itself" do
      subject.reshape!(3, 2).should eq(subject)
    end
  end
end
