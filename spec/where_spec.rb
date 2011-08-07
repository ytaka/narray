require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe NArray do
  subject do
    NArray.float(8).indgen!
  end

  def check_index_array(index_array, &cond)
    t, f = index_array.where2
    t_ary, f_ary = t.to_a, f.to_a
    i = 0
    subject.each do |v|
      if yield(v)
        t_ary.should include(i)
      else
        f_ary.should include(i)
      end
      i += 1
    end
  end

  it "should get index arrays for 'or'." do
    check_index_array((subject >= 5).or(subject < 2)) do |v|
      (v >= 5) or (v < 2)
    end
  end

  it "should get index arrays for 'and'." do
    check_index_array((subject >= 5).and(subject < 2)) do |v|
      (v >= 5) and (v < 2)
    end
  end

  it "should get index arrays for '&&'." do
    pending("We can not find specification.")
    check_index_array((subject >= 5) && (subject < 2)) do |v|
      (v >= 5) && (v < 2)
    end
  end

  it "should get index arrays for '||'." do
    pending("We can not find specification.")
    check_index_array((subject >= 5) || (subject < 2)) do |v|
      (v >= 5) || (v < 2)
    end
  end
end
