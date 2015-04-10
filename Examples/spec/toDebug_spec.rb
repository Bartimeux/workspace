#!/usr/bin/ruby

require 'rest-client'
require_relative '../toDebug.rb'

describe "is_blueprint_already_created" do
  it 'should return false if cluster doesn\'t exists on ambari server' do
    expect(RestClient::Request).to receive(:execute).with(any_args).and_return double(code: 404)
    value = is_blueprint_already_created
    expect(value).to eq false
  end

  it 'should return true if cluster exists on ambari server' do
    expect(RestClient::Request).to receive(:execute).with(any_args).and_return double(code: 0)
    value = is_blueprint_already_created
    expect(value).to eq true
  end

  it 'should try again max 3 times and print a warning if unable to contact ambari server' do
    3.times{expect(RestClient::Request).to receive(:execute).with(any_args).and_raise(Errno::ECONNREFUSED)}
    value = is_blueprint_already_created
    expect(value).to eq false
  end
end

