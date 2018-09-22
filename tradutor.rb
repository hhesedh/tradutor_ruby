require 'rest-client'
require 'json'
require 'date'

# Classe Tradutor
class Tradutor
  attr_reader :texto_traduzido
  def initialize(texto, idioma)
    @url = 'https://translate.yandex.net/api/v1.5/tr.json/translate'
    @key = 'trnsl.1.1.20180922T041958Z.83d0d38d79524d55.a0cf61ce51777dea5cc3cf89a28d4a554588331d'
    @texto = texto
    @idioma = 'pt-' + idioma
    @texto_traduzido = traduzir
  end

  def escrever
    date = DateTime.new
    File.open(date.strftime('%I:%M:%S %p'), 'w') do |line|
      line.puts @texto
      line.print @texto_traduzido
    end
  end

  private

  def traduzir
    response = RestClient.get(@url, params: { key: @key, text: @texto, lang: @idioma })
    JSON.parse(response).values.flatten.last
  end
end

texto = Tradutor.new('Olá, tudo bem?', 'en')
puts(texto.texto_traduzido)
texto.escrever
