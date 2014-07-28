require 'net/http'
require 'json'


HOST = ENV['TEST_HOST'] || 'localhost'
PORT = ENV['TEST_PORT'] ? ENV['TEST_PORT'].to_i : 5500


def absolute_url(relative)
  URI("http://#{TEST_HOST}:#{TEST_PORT}#{relative}")
end

@http = Net::HTTP.start(TEST_HOST, TEST_PORT)

def get_json_resource(url)
  url = absolute_url url
  req = Net::HTTP::Get.new(url.request_uri)
  req['Accept'] = 'application/json'
  @http.request req
end


def delete_resource(url)
  url = absolute_url url
  req = Net::HTTP::Delete.new(url.request_uri)
  @http.request(req)
end


def post_json_resource(url, json_str)
  url = absolute_url url
  req = Net::HTTP::Post.new(url.request_uri)
  req.content_type = 'application/json'
  req.body = json_str
  req['Accept'] = 'application/json'
  @http.request req
end


begin

  res = post_json_resource('/users', JSON.generate({ :name => 'foo'}))
  raise RuntimeError unless res.is_a? Net::HTTPCreated

  res = get_json_resource('/users/foo')
  raise RuntimeError unless res.is_a? Net::HTTPOK

  res = delete_resource('/users/foo')
  raise RuntimeError unless res.is_a? Net::HTTPNoContent

  res = post_json_resource('/users', JSON.generate({ :name => 'bar'}))
  raise RuntimeError unless res.is_a? Net::HTTPCreated

ensure
  @http.finish if @http
end
