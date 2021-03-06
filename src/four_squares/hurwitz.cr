struct FourSquares::Hurwitz
  include Comparable(self)
  D = (0..15).map { |i| new(i & 1, (i & 2) // 2, (i & 4) // 4, (i & 8) // 8) } << new(1, 1, 1, 1, true)

  property r : BigInt
  property i : BigInt
  property j : BigInt
  property k : BigInt

  def initialize(r, i = 0, j = 0, k = 0, doubled = false)
    @r = BigInt.new(r)
    @i = BigInt.new(i)
    @j = BigInt.new(j)
    @k = BigInt.new(k)
    if doubled
      raise "Invalid Hurwitz integer #{self}." unless (l = @r % 2) && (l == @i % 2) && (l == @j % 2) && (l == @k % 2)
    else
      @r *= 2
      @i *= 2
      @j *= 2
      @k *= 2
    end
  end

  def abs2
    (r * r + i * i + j * j + k * k) // 4
  end

  def <=>(o : Hurwitz)
    abs2 <=> o.abs2
  end

  def inverse
    Hurwitz.new(r, -i, -j, -k, true)
  end

  def %(o : Hurwitz)
    q = self // o
    D.min_of { |d|
      self - (q + d) * o
    }
  end

  def +(o : Hurwitz)
    Hurwitz.new(r + o.r, i + o.i, j + o.j, k + o.k, true)
  end

  def -(o : Hurwitz)
    Hurwitz.new(r - o.r, i - o.i, j - o.j, k - o.k, true)
  end

  def //(o : Hurwitz)
    q = o.abs2 * 2
    p = self * o.inverse
    Hurwitz.new(
      p.r // q * 2,
      p.i // q * 2,
      p.j // q * 2,
      p.k // q * 2,
      true
    )
  end

  def *(o : Hurwitz)
    Hurwitz.new(
      (r * o.r - i * o.i - j * o.j - k * o.k) // 2,
      (r * o.i + i * o.r + j * o.k - k * o.j) // 2,
      (r * o.j - i * o.k + j * o.r + k * o.i) // 2,
      (r * o.k + i * o.j - j * o.i + k * o.r) // 2,
      true
    )
  end

  def to_lipschitz
    if r % 2 == 1
      Hurwitz.new(2 - r % 4, i % 4 - 2, j % 4 - 2, k % 4 - 2, true) * self
    else
      self.dup
    end
  end

  def to_sorted_abs_tuple
    Tuple(BigInt, BigInt, BigInt, BigInt).from([r.abs // 2, i.abs // 2, j.abs // 2, k.abs // 2].sort!.reverse!)
  end

  def to_s(io : IO)
    inspect(io)
  end

  def inspect(io : IO)
    io << "#{r}/2 #{i < 0 ? '-' : '+'} (#{i.abs}/2)i #{j < 0 ? '-' : '+'} (#{j.abs}/2)j #{k < 0 ? '-' : '+'} (#{k.abs}/2)k"
  end
end
