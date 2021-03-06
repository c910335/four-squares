class FourSquares::Roots
  @num : BigInt
  @roots : Tuple(BigInt, BigInt, BigInt, BigInt)?
  @odd = BigInt.new(1)
  @level_limit = BigInt.new(0)

  def initialize(num : String | Int)
    @num = BigInt.new(num)
    if @num == 2
      @roots = {1, 1, 0, 0}.map { |x| BigInt.new(x) }
    elsif @num > 2 && (troots = roots_three_squares_mod)
      a = Hurwitz.new(@num)
      b = Hurwitz.new(*troots)
      @roots = euclidean(a, b).try(&.to_lipschitz.to_sorted_abs_tuple)
    end
  end

  def roots_three_squares_mod
    @odd = @num - 1
    while @odd % 2 == 0
      @odd //= 2
      @level_limit += 1
    end

    if t = first_new_level
      c, n, l = t
      if l < 1
        if (a = shanks(@num - c, @num - 1, 1)) && (b = shanks(n, @num - 1, 1))
          {a, b, c % 2 == 0 ? b : 1}
        end
      elsif a = shanks(@num - 1, n, l)
        {a, 1, 0}
      end
    end
  end

  def euclidean(a : Hurwitz, b : Hurwitz)
    while a.abs2 > @num
      a, b = b, a % b
    end
    if a.abs2 == @num
      a
    end
  end

  def first_new_level
    c = n = @num - 1
    l = 1
    loop do
      if c % 2 == 0
        n = c // 2
      else
        n = c - 1
      end
      if l = level(n)
        break unless l == 1
      else
        return nil
      end
      c = n
    end
    {c, n, l}
  end

  def level(n : BigInt)
    n = pow(n, @odd)
    i = BigInt.new(0)
    until n == 1
      n = (n * n) % @num
      i += 1
      return nil if i > @level_limit
    end
    i
  end

  def shanks(n : BigInt, z : BigInt, l : BigInt | Int)
    l = BigInt.new(l)
    c = pow(z, @odd)
    t = pow(n, @odd)
    r = pow(n, (@odd + 1) // 2)

    loop do
      return BigInt.new(0) if t == 0
      return r if t == 1

      i = BigInt.new(0)
      until t == 1
        t = (t * t) % @num
        i += 1
        return nil if i > @level_limit
      end

      (l - i - 1).times do
        c = (c * c) % @num
      end
      r = (r * c) % @num
      c = (c * c) % @num
      t = (t * c) % @num
      l = i
    end
  end

  def pow(n : BigInt, k : BigInt)
    return n % @num if k == 1
    a = pow((n * n) % @num, k // 2)
    a = (a * n) % @num if k % 2 == 1
    a
  end

  def to_s?
    if @roots
      to_s
    end
  end

  def to_s(io : IO)
    roots = @roots.not_nil!
    io << "#{roots[0]}^2 + #{roots[1]}^2 + #{roots[2]}^2 + #{roots[3]}^2"
  end
end
