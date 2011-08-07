require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe NArray do
  context "when calculating power" do
    before(:all) do
      @err = 1e-8
    end

    DIM = 4

    [["integer", NArray.int(DIM).indgen! * 2 - 2],
     ["float", NArray.float(DIM).indgen! * 2 - 2],
     ["complex", NArray.complex(DIM).indgen! * 2 - 2]].each do |mes, obj|
      [[[-3], [0], [7]], [[-3.0],[0],[7.0]]].each_with_index do |ary, num|
        it "should calculate for #{mes} (#{num + 1})." do
          a = obj ** ary
          ary.size do |i|
            j = 0
            a[true, i].each do |n, j|
              n.should == (obj[j] ** ary[i][0])
              j += 1
            end
          end
        end
      end

      [1 + 0.im, 1.0].each_with_index do |e, num|
        it "should calculate for #{mes} (#{num + 2})." do
          a = obj ** e
          i = 0
          a.each do |n|
            n.should be_within(@err).of(obj[i] ** e)
            i += 1
          end
        end
      end
    end
  end
end
