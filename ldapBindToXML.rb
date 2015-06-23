#!/usr/bin/ruby -w

require 'rubygems'
require 'net/ldap'
require 'xmlsimple'

if ARGV.size = 0
  puts "No topology file given in argument. Using /etc/knox/conf/topologies/default.xml"
  topoFile = "/etc/knox/conf/topologies/default.xml"
else
  topoFile = ARGV[1]
end

ldap = Net::LDAP.new :host => 'ypliam01b.intcs.meshcore.net', :port => 636, :auth => {:method => :anonymous }

base = 'dc=prd,dc=mutu,dc=fr'
filter = Net::LDAP::Filter.eq('objectclass', 'person')

csvGroup = ""
ldap.search(:base => base, :filter => filter) do |object|
  object.memberOf.each do |group|
    csvGroup << object.cn << "=" << group << ";"
  end
end

puts csvGroup

topology = XmlSimple.xml_in(topoFile)
topology['topology']['gateway']['provider'].each do |provider|
  if provider['role']=="identity-assertion"
    provider['param'].each do |params|
      if params['name']=="group.principal.mapping"
        groupMapping = params['value']
        break
      else
        next
      end
    end
  else
    next
  end
end

if csvGroup != groupMapping
  `sed -i "s/#{groupMapping}/#{csvGroup}/" #{topoFile}`
end
