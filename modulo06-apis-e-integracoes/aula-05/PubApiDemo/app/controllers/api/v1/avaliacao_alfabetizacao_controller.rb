class Api::V1::AvaliacaoAlfabetizacaoController < Api::V1::ApplicationController
  def index
    @q = AvaliacaoAlfabetizacaoUf.ransack(params[:q])
    @avaliacoes = @q.result

    render json: @avaliacoes.to_json
  end
end
