require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe NArray do
  it "should not raise error." do
    lambda do
      x = NArray.complex(1024,1024).indgen!

      p x
      puts 'executing fftw ...'
      t1 = Process.times.utime
      y = FFTW.fftw( x, 1 )
      t2 = Process.times.utime
      print "time: ",t2 - t1,"\n"
      p y
    end.should_not raise_error
  end

  it "should not raise error (2)." do
    lambda do
      x = NArray.complex(128,128).indgen!
      10000.times{ x = FFTW.fftw( x, 1 ) }
    end.should_not raise_error
  end
end
