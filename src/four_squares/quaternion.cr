struct FourSquares::Quaternion
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

  def inverse
    Quaternion.new(r, -i, -j, -k)
  end

  def %(o : Quaternion)
    self - (self // o) * o
  end

  def -(o : Quaternion)
    Quaternion.new(r - o.r, i - o.i, j - o.j, k - o.k)
  end

  def //(o : Quaternion)
    q = o.abs2
    p = self * o.inverse
    Quaternion.new(
      (p.r / q).round.to_i,
      (p.i / q).round.to_i,
      (p.j / q).round.to_i,
      (p.k / q).round.to_i
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

  def to_abs_tuple
    {r.abs, i.abs, j.abs, k.abs}
  end

  def inspect(s)
    s << "#{r} #{i < 0 ? '-' : '+'} #{i.abs}i #{j < 0 ? '-' : '+'} #{j.abs}j #{k < 0 ? '-' : '+'} #{k.abs}k"
  end
end
