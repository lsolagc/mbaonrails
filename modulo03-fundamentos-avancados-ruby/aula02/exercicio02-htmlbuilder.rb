# # Exercício: HtmlBuilder com tags aninhadas
#   Objetivo: Modificar a classe HtmlBuilder vista em aula a fim de permitir a construção de HTMLs mais complexos.
# # Enunciado:
#   Altere a classe abaixo:
#     class HtmlBuilder
#       def initialize(&block)
#         @html = ""
#         instance_eval(&block) if block_given?
#       end
#       def div(content)
#         @html << "<div>#{content}</div>\n"
#       end
#       def span(content)
#         @html << "<span>#{content}</span>\n"
#       end
#       def result
#         @html
#       end
#     end
#
#   Após alterar, a classe deve ser capaz de executar corretamente o seguinte input:
#     builder = HtmlBuilder.new do
#       div do
#         div "Conteúdo em div"
#         span "Nota em div"
#       end
#       span "Nota de rodapé"
#     end

class HtmlBuilder
  def initialize(&block)
    @html = ""
    instance_eval(&block) if block_given?
  end

  def div(content = nil, &block)
    @html << "<div>\n"
    if block_given?
      instance_eval(&block)
    else
      @html << "#{content}\n"
    end
    @html << "</div>\n"
  end

  def span(content)
    @html << "<span>#{content}</span>\n"
  end

  def result
    @html
  end
end

builder = HtmlBuilder.new do
  div do
    div "Conteúdo em div"
    span "Nota em div"
  end
  span "Nota de rodapé"
end

puts builder.result
