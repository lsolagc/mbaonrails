# Exercício: Classe Vector2
#   Objetivo: Criar uma classe Vector2 que receba dois parâmetros (X e Y) e permita a multiplicação desse Vector2
#   por objetos do tipo Numeric e Vector2.
# # Enunciado:
#   Implemente uma classe Vector2 com o seguinte comportamento:
#     v = Vector2.new(3, 4)
#     puts v * 2      # Output: (6, 8)
#     puts v * 2.5    # Output: (7.5, 10.0)
#     puts v * v      # Output: 25 (produto escalar)
#     puts 2 * v      # Output: (6, 8)
#     puts 2.5 * v    # Output: (7.5, 10.0)
#
#   - O operador * deve funcionar tanto para multiplicação por escalar (Numeric) quanto para produto escalar (dot product) entre dois Vector2.
#   - O operador * também deve funcionar quando o escalar estiver à esquerda (ex: 2 * v).
#
class Vector2
  attr_reader :x, :y

  def initialize(x, y)
    @x = x
    @y = y
    @result_type = :vector2
  end

  def *(other)
    if other.is_a?(Numeric)
      Vector2.new(@x * other, @y * other)
    elsif other.is_a?(Vector2)
      @result_type = :scalar_product
      @x * other.x + @y * other.y
    end
  end

  def coerce(other)
    if other.is_a?(Numeric)
      [self, other]
    else
      raise TypeError, "#{other.class} can't be coerced with Vector2"
    end
  end

  def to_s
    "(#{@x}, #{@y})"
  end
end

v = Vector2.new(3, 4)
puts v * 2      # Output: (6, 8)
puts v * 2.5    # Output: (7.5, 10.0)
puts v * v      # Output: 25 (produto escalar)
puts 2 * v      # Output: (6, 8)
puts 2.5 * v    # Output: (7.5, 10.0)
