require 'socket'
require 'avro'
require 'yajl'

CALCULADORA_PROTOCOL_JSON = File.read('./schemas/calculadora.avpr')

CALCULADORA_PROTOCOL = Avro::Protocol.parse(CALCULADORA_PROTOCOL_JSON)

class CalcResponder < Avro::IPC::Responder
  def initialize
    super(CALCULADORA_PROTOCOL)
  end

  def call(message, request)
    puts message
    puts '---'
    puts request
    puts '---'
    puts message.name
    puts '---'

    if message.name == 'somarMessage'
      puts "Recebido somarMessage"
      request_content = request["SomarRequest"]
      x = request_content["x"]
      y = request_content["y"]
      (x+y)
    else
      puts "Recebido request desconhecida"
    end
  end
end

class RequestHandler
  def initialize(address, port)
    @ip_address = address
    @port = port
  end

  def run
    server = TCPServer.new(@ip_address, @port)
    while (session = server.accept)
      handle(session)
      session.close
    end
  end
end

class CalcHandler < RequestHandler
  def handle(request)
    responder = CalcResponder.new()
    transport = Avro::IPC::SocketTransport.new(request)
    str = transport.read_framed_message
    transport.write_framed_message(responder.respond(str))
  end
end

if $0 == __FILE__
  handler = CalcHandler.new('localhost', 9090)
  handler.run
end
