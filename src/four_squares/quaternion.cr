struct FourSquares::Quaternion
  include Comparable(self)
  property r : BigInt
  property i : BigInt
  property j : BigInt
  property k : BigInt

  def initialize(r, i = 0, j = 0, k = 0)
    @r = BigInt.new(r)
    @i = BigInt.new(i)
    @j = BigInt.new(j)
    @k = BigInt.new(k)
  end

  def abs2
    r * r + i * i + j * j + k * k
  end

  def <=>(o : Quaternion)
    abs2 <=> o.abs2
  end

  def inverse
    Quaternion.new(r, -i, -j, -k)
  end

  def %(o : Quaternion)
    q = self // o
    (0...8).map do |i|
      t = q
      t.r += i & 1
      t.i += (i // 2) & 1
      t.j += (i // 4) & 1
      t.k += (i // 7) & 1
      self - t * o
    end.min
  end

  def -(o : Quaternion)
    Quaternion.new(r - o.r, i - o.i, j - o.j, k - o.k)
  end

  def //(o : Quaternion)
    q = o.abs2
    p = self * o.inverse
    Quaternion.new(
      (p.r // q),
      (p.i // q),
      (p.j // q),
      (p.k // q)
    )
  end

  def *(o : Quaternion)
    Quaternion.new(
      r * o.r - i * o.i - j * o.j - k * o.k,
      r * o.i + i * o.r + j * o.k - k * o.j,
      r * o.j - i * o.k + j * o.r + k * o.i,
      r * o.k + i * o.j - j * o.i + k * o.r
    )
  end

  def to_sorted_abs_tuple
    Tuple(BigInt, BigInt, BigInt, BigInt).from([r.abs, i.abs, j.abs, k.abs].sort!.reverse!)
  end

  def inspect(s)
    s << "#{r} #{i < 0 ? '-' : '+'} #{i.abs}i #{j < 0 ? '-' : '+'} #{j.abs}j #{k < 0 ? '-' : '+'} #{k.abs}k"
  end
end
