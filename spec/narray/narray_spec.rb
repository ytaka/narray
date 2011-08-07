require 'spec_helper'

describe NArray do
  describe '#indgen' do
    subject { NArray.int(6) }

    it "should fill array with consecutive numbers" do
      subject.indgen.should eq(NArray[0, 1, 2, 3, 4, 5])
    end

    it "should fill array with consecutive numbers from starting number" do
      subject.indgen(2).should eq(NArray[2, 3, 4, 5, 6, 7])
    end

    it "should fill array with consecutive numbers with step" do
      subject.indgen(0, 2).should eq(NArray[0, 2, 4, 6, 8, 10])
    end

    it "should return itself" do
      subject.indgen.should equal(subject)
    end
  end

  describe '#shape' do
    it "should return size of array in each dimension" do
      NArray[[1, 2, 3], [4, 5, 6]].shape.should eq([3, 2])
    end
  end

  describe '#fill' do
    subject { NArray[1, 2, 3, 4] }

    it "should fill array with the values" do
      subject.fill(5).should eq(NArray[5, 5, 5, 5])
    end

    it "should work in place" do
      subject.fill(5).should equal(subject)
    end
  end

  describe '#shape' do
    it "should return the correct shape" do
      NArray[[1, 2, 3], [4, 5, 6]].shape.should eq([3, 2])
    end
  end

  describe '#rank' do
    it "should return correct rank for empty array" do
      NArray[].rank.should eq(0)
    end

    it "should return correct rank for one dimensional array" do
      NArray[1, 2, 3].rank.should eq(1)
    end

    it "should return correct rank for two dimensional array" do
      NArray[[1, 2], [3, 4]].rank.should eq(2)
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

    it "should refer to the same data" do
      subject.reshape(3, 2).should refer(subject)
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

    it "should not refer the same data" do
      subject.reshape!(3, 2).should_not refer(subject)
    end
  end

  describe '#element_size' do
    it "should return 4 for integer array" do
      NArray.int(3).element_size.should eq(4)
    end

    it "should return 1 for byte array" do
      NArray.byte(3).element_size.should eq(1)
    end
  end

  describe '#empty?' do
    it "should return true for empty array" do
      NArray[].should be_empty
    end

    it "should return true for empty two dimensional array" do
      NArray[[], []].should be_empty
    end

    it "should return false for two dimensional array" do
      NArray[[1, 2], [3, 4]].should_not be_empty
    end
  end

  describe '#flatten' do
    subject { NArray[[1, 2], [3, 4]] }
    it "should change two dimensional array into one dimensional" do
      subject.flatten.should eq(NArray[1, 2, 3, 4])
    end

    it "should refer to the same data" do
      subject.flatten.should refer(subject)
    end
  end

  describe '#flatten!' do
    subject { NArray[[1, 2], [3, 4]] }
    it "should change two dimensional array into one dimensional" do
      subject.flatten!.should eq(NArray[1, 2, 3, 4])
    end

    it "should refer to the same data" do
      subject.flatten!.should_not refer(subject)
    end
  end
end

RSpec::Matchers.define :refer do |original_array|
  match do |actual_array|
    actual_array.original.should equal(original_array)
  end
end
