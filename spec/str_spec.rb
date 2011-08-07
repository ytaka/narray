require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe NArray do
  def check_string_array(ary)
    ary.should be_an_instance_of NArray
    ary.each do |val|
      val.should be_an_instance_of String
    end
  end

  it "should convert an array of float to string." do
    a = NArray.float(3,3)
    a.indgen!
    check_string_array(a.to_string)
  end

  it "should convert an array of complex to string." do
    check_string_array(NArray.complex(3,3).indgen!.div!(3).to_string)
  end

  it "should convert an array of scomplex to string." do
    check_string_array(NArray.scomplex(3,3).indgen!.div!(3).to_string)
  end

  it "should convert an array of byte to string." do
    check_string_array(NArray.byte(3,3).indgen!.add!(32).to_string)
  end

  it "should convert an array of integer to string." do
    a = NArray.int(3,3)
    a.indgen!
    check_string_array(a.to_string)
  end

  it "should convert an array of sfloat to string." do
    check_string_array(NArray.sfloat(3,3).indgen!.to_string.to_string)
  end
end
