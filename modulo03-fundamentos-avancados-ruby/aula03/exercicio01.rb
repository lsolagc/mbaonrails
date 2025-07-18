# Exercício: Sistema de Vendas
# Objetivo:
# Implemente uma classe SalesReport que recebe uma lista de vendas no formato abaixo:
sales = [
  { product: "Notebook", category: "Eletrônicos", amount: 3000 },
  { product: "Celular", category: "Eletrônicos", amount: 1500 },
  { product: "Cadeira", category: "Móveis", amount: 500 },
  { product: "Mesa", category: "Móveis", amount: 1200 },
  { product: "Headphone", category: "Eletrônicos", amount: 300 },
  { product: "Armário", category: "Móveis", amount: 800 }
]
#
# Implemente a classe com as seguintes responsabilidades:
#   1. Incluir Enumerable e implementar #each para iterar sobre as vendas.
#   2. Um método #total_by_category que retorna um hash com o total de vendas por categoria.
#   3. Um método #top_sales(n) que retorna os n maiores valores de venda.
#   4. Um método #grouped_by_category que retorna um hash com os produtos agrupados por categoria.
#   5. Um método #above_average_sales que retorna as vendas cujo valor está acima da média geral.
   
class SalesReport
  include Enumerable

  def initialize(sales:)
    @sales = sales
  end

  def each(&block)
    @sales.each(&block)
  end

  def total_by_category
    total_sales = {}
    @sales.each do |hash|
      category = hash[:category]
      amount = hash[:amount]
      if total_sales[category]
        total_sales[category] += amount
      else
        total_sales[category] = amount
      end
    end

    total_sales
  end

  def top_sales(n)
    @sales.sort{ |sale1, sale2| sale2[:amount] <=> sale1[:amount] }.first(n)
  end

  def grouped_by_category
    groups = {}
    @sales.each do |sale|
      category = sale[:category]
      if groups[category] 
        groups[category] << sale[:product]
      else
        groups[category] = [sale[:product]]
      end
    end

    groups
  end

  def above_average_sales
    avg = @sales.sum { |sale| sale[:amount] } / @sales.size
    puts "Média geral de vendas: #{avg}"
    @sales.select do |sale|
      sale[:amount] > avg
    end
  end
end

sr = SalesReport.new(sales: sales)
puts sr.total_by_category
puts '---'
puts sr.top_sales(3)
puts '---'
puts sr.grouped_by_category
puts '---'
puts sr.above_average_sales
puts '---'
