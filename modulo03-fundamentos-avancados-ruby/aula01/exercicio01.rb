# # Exercício: Registro Dinâmico de Configurações
#   Objetivo: Criar uma classe Settings que permita o registro e a leitura dinâmica de configurações,
#   utilizando define_method, method_missing, respond_to_missing? e send.
# # Enunciado:
#   Implemente uma classe Settings com a seguinte interface:
#   Exemplo de uso esperado:
#     settings = Settings.new
#   ## Definindo configurações dinamicamente
#     settings.add(:timeout, 30)
#     settings.add(:mode, "production")
#   ## Acessando configurações via método
#     puts settings.timeout # => 30
#     puts settings.mode # => "production"
#   ## Tentando acessar configuração inexistente
#     puts settings.retry # => "Configuração 'retry' não existe."
#   ## Checando se um método está disponível
#     puts settings.respond_to?(:timeout) # => true
#     puts settings.respond_to?(:retry) # => false
# # Objetivos Extras (Desafio)
#   1. Suporte a aliases
#     Permita definir um alias para uma configuração, de modo que múltiplos métodos retornem o mesmo valor:
#       settings.add(:timeout, 30, alias: :espera)
#       puts settings.timeout # => 30
#       puts settings.espera # => 30
#   2. Configuração somente leitura
#     Permita que certas configurações sejam marcadas como somente leitura (read-only), e causem erro se
# alguém tentar sobrescrevê-las:
#       settings.add(:api_key, "SECRET", readonly: true)
#       settings.api_key = "HACKED" # => Erro: configuração 'api_key' é somente leitura
#   3. Listagem de configurações
#     Adicione um método all que retorna um hash com todas as configurações definidas:
#       settings.all # => { timeout: 30, mode: "production", api_key: "SECRET" }
#   4. Integração com method_missing para setters
#     Opcionalmente, permita alterar valores por setters dinâmicos (settings.timeout = 60), exceto se o
# campo for read-only:
#       settings.timeout = 60
#       puts settings.timeout # => 60

class Settings
  def initialize
    @settings_hash = {}
  end

  def self.define_setting_methods(setting_name, **options)
    define_method(setting_name) do
      @settings_hash[setting_name]
    end

    if options[:readonly]
      define_method("#{setting_name}=") do |value|
        puts "Erro: configuração '#{setting_name}' é somente leitura"
      end
    else
      define_method("#{setting_name}=") do |value|
        @settings_hash[setting_name] = value
      end
    end

    if options[:alias]
      define_method(options[:alias]) do
        @settings_hash[setting_name]
      end
    end
  end

  def add(setting_name, value, **kwargs)
    @settings_hash[setting_name] = value

    self.class.define_setting_methods(setting_name, **kwargs)

    if kwargs[:readonly]
      puts "Setting '#{setting_name}' definida com valor '#{value}' e modo apenas leitura."
    else
      puts "Setting '#{setting_name}' definida com valor '#{value}'."
    end
  end

  def method_missing(setting_name, *args, &block)
    if @settings_hash.key?(setting_name)
      @settings_hash[setting_name]
    else
      "Configuração '#{setting_name}' não existe."
    end
  end

  def respond_to_missing?(setting_name, include_private = false)
    @settings_hash.key?(setting_name)
  end
end

settings = Settings.new
puts "Parte obrigatória do exercício:"
settings.add(:timeout, 30) # => Setting 'timeout' definida com valor '30'.
puts settings.timeout # => 30
puts settings.explode # => Configuração 'explode' não existe.
puts "A configuração 'timeout' está disponível? #{settings.respond_to?(:timeout)}" # => true
puts "A configuração 'explode' está disponível? #{settings.respond_to?(:explode)}" # => false
puts "----------------------------------------------------------"
puts "Parte extra do exercício:"
puts "Definindo alias 'espera' para 'timeout'."
settings.add(:timeout, 60, alias: :espera) # => Setting 'timeout' definida com valor '60'.
puts "Valor da setting 'timeout': #{settings.timeout}" # => 60
puts "Valor da setting 'espera': #{settings.espera}" # => 60
puts "---"
puts "Definindo configuração somente leitura 'api_key'."
settings.add(:api_key, "SECRET", readonly: true)
settings.api_key = "HACKED" # => Erro: configuração 'api_key' é somente leitura
puts "Valor da setting 'api_key': #{settings.api_key}" # => SECRET
