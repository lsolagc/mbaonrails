require 'socket'
require 'avro'
require 'yajl'

CALCULADORA_PROTOCOL_JSON = File.read('./schemas/calculadora.avpr')

CALCULADORA_PROTOCOL = Avro::Protocol.parse(CALCULADORA_PROTOCOL_JSON)

def make_requestor(server_address, port, protocol)
  sock = TCPSocket.new(server_address, port)
  client = Avro::IPC::SocketTransport.new(sock)
  Avro::IPC::Requestor.new(protocol, client)
end

if $0 == __FILE__
  if ![2].include?(ARGV.length)
    raise "Usage: <x> <y>"
  end

  # client code - attach to the server and send a message
  # fill in the Message record
  somarRequest = {
    'x'   => ARGV[0].to_i,
    'y'   => ARGV[1].to_i,
  }

  # build the parameters for the request
  params = {'SomarRequest' => somarRequest}

  # send the requests and print the result
  requestor = make_requestor('localhost', 9090, CALCULADORA_PROTOCOL)
  result = requestor.request('somarMessage', params)
  puts("Result: " + result.to_s)
end
