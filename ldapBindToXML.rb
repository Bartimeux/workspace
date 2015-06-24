#!/usr/bin/ruby -w

require 'rubygems'
require 'net/ldap'
require 'xmlsimple'

if ARGV.empty?
  puts "No topology file given in argument. Using /etc/knox/conf/topologies/default.xml"
  topoFile = "/etc/knox/conf/topologies/default.xml"
else
  topoFile = ARGV[0]
end

ldap = Net::LDAP.new :host => 'ypliam01b.intcs.meshcore.net', :port => 389, :auth => {:method => :anonymous }

base = 'dc=prd,dc=mutu,dc=fr'
filter = Net::LDAP::Filter.eq("objectclass", "person") &  Net::LDAP::Filter.pres("memberOf")

csvGroup = ""
ldap.search(:base => base, :filter => filter) do |object|
  object[:memberOf].to_a.each do |group|
    user_name = object[:cn][0]
    group_name = group.split("=")[1].split(',')[0]
    csvGroup << user_name << "=" << group_name << ";"
  end
end

groupMapping = ''
topology = XmlSimple.xml_in(topoFile)
topology['gateway'][0]['provider'].each do |provider|
  if provider['role'][0]=="identity-assertion"
    provider['param'].each do |params|
      if params['name'][0]=="group.principal.mapping"
        groupMapping = params['value'][0]
        if csvGroup != groupMapping
          params['value'][0] = csvGroup
        end
        break
      end
    end
  end
end

if csvGroup != groupMapping
  File.open(topoFile, 'w') do |file|
    file.write(XmlSimple.xml_out(topology).gsub("opt>", "topology>"))
    file.close
  end
  `find /usr/hdp -iname 'gateway.sh' -exec {} stop \\;`
  `find /usr/hdp -iname 'gateway.sh' -exec {} start \\;`
end
