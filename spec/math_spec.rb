require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe NArray do
  include NMath

  before(:all) do
    @sfloat = NArray.sfloat(6).indgen.div!(2)
    @float = NArray.float(6).indgen.div!(2)
    @scomplex = NArray.scomplex(6).indgen.div!(2)-2 - 1.im
    @complex = NArray.complex(6).indgen!
    @complex = @complex / 5 - 0.5
    @err = 1e-4 # Some specs fails for too small value.
  end

  METHODS = [:sqrt, :sin, :cos, :tan, :sinh, :cosh, :tanh, :exp, :log, :log10, :atan]

  def check_value(val, expected)
    if val.infinite?
      val.infinite?.should == expected.infinite?
    else
      val.should be_within(@err).of(expected)
    end
  end

  [['@sfloat', "when calculating single precision float"],
   ['@float', "when calculating double precision float"],
   ['@complex', "when calculating single precision complex"],
   ['@scomplex', "when calculating double precision complex"]].each do |obj_str, mes|
    context mes do
      METHODS.each do |m|
        it "should calculate #{m}." do
          obj = eval(obj_str)
          expected = obj.to_a.map { |a| __send__(m, a) }
          ret = __send__(m, obj).to_a
          ret.each_with_index do |val, i|
            if Complex === val
              check_value(val.real, expected[i].real)
              check_value(val.imag, expected[i].imag)
            else
              check_value(val, expected[i])
            end
          end
        end
      end
    end
  end
end
