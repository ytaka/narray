require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

require 'matrix'

describe NMatrix do
  before(:all) do
    @m1 = NMatrix.float(2, 2).indgen!
    @m2 = NMatrix[[0, 1.2],[1.5, 0]]
    @v1 = NVector[0.5, 1.5]
    @v2 = NVector.float(2, 2).indgen!
    @err = 1e-8
  end

  it "should return inverse matrix." do
    identity = NMatrix.float(2, 2).I
    (@m1.inverse * @m1 - identity).each do |val|
      val.should be_within(@err).of(0) 
    end
  end

  def convert(val)
    case val
    when NArray
      case val.dim
      when 1
        Vector[*val.to_a]
      when 2
        Matrix[*val.to_a]
      else
        raise "Invalid dimension."
      end
    when Float
      val
    else
      raise "Invalid type"
    end
  end

  def check_operator(m1, m2, method_sym)
    convert(m1.__send__(method_sym, m2)).should == convert(m1).__send__(method_sym, convert(m2))
  end

  it "should multiply a matrix by another matrix." do
    check_operator(@m1, @m2, :*)
    check_operator(@m2, @m1, :*)
  end

  it "should add a matrix to another matrix." do
    check_operator(@m2, @m1, :+)
  end

  it "should multiply a number by a matrix." do
    check_operator(3.14, @m1, :*)
  end

  it "should multiply a matrix by a number." do
    check_operator(@m2, 1.25, :*)
  end

  it "should multiply a vector by a number." do
    check_operator(@v1, 1.25, :*)
  end

  it "should multiply a number by a vector." do
    check_operator(1.25, @v2, :*)
  end

  it "should multiply a vector by itself." do
    (@v2 ** 2).should == @v2 * @v2
  end

  it "should multiply a vector by another vector." do
    (@v1 * @v2).to_a.should == (Matrix[*@v2.to_a] * Matrix[@v1.to_a].transpose).to_a.flatten
  end

  it "should multiply a vector by a matrix." do
    check_operator(@m1, @v1, :*)
  end

  it "should multiply a matrix by a vector." do
    check_operator(@v2, @m2, :*)
  end

  it "should set values of diagonal elements." do
    dia = [98, 99]
    mat_new = @m1.diagonal(dia)
    2.times do |i|
      col = mat_new[i, true]
      2.times do |j|
        if i == j
          col[j].should == dia[i]
        else
          col[j].should == @m1[i, j]          
        end
      end
    end
  end

  it "should return unit matrix." do
    mat = NMatrix.float(4, 3).unit
    4.times do |i|
      col = mat[i, true]
      3.times do |j|
        col[j].should == (i == j ? 1 : 0)
      end
    end
  end

  it "should raise error for addition fo a matrix and an vector." do
    lambda do
      @m1 + @v1
    end.should raise_error
  end

  it "should raise error for addition fo a matrix and a number." do
    lambda do
      @m1 + 1
    end.should raise_error
  end
end
