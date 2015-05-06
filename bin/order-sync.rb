#!/usr/bin/env ruby

require 'rubygems'
require 'json'
require 'thor'
require 'thor/group'

class OrderSync < Thor

  default_task :sync

  method_option :source, :type => :string, :aliases => '-s', :required => true,
    :desc => 'Source table to pull from <db>.<table>'
  method_option :dest, :type => :string, :aliases => '-d', :required => true,
    :desc => 'Destination table to load to <dataset>.<tablename>'
  method_option :column, :type => :string, :aliases => '-k', :required => true,
    :desc => 'driving column to measure high water mark'
  method_option :host, :type => :string, :aliases => '-h',
    :desc => 'MySQL Host to pull from', :default => 'localhost'
  method_option :user, :type => :string, :aliases => '-u',
    :desc => 'MySQL User', :default => ENV['USER']
  method_option :password, :type => :string, :aliases => '-p',
    :desc => 'MySQL password, defaults to null', :default => nil
  method_option :where, :type => :string, :aliases => '-w',
    :desc => 'Where clause to pass to mysqldump'
  method_option :dry_run, :type => :boolean, :aliases => '-n',
    :desc => 'Dry run'

  desc 'sync', 'Sync a MySQL Database Table to a BigQuery Table'
  def sync
    validate
    latest = bqlatest
    say "latest now : '#{latest}'"
    Dir.mktmpdir do |dir|
      File.chmod(0777, dir)
      mysqldump dir, latest
      bqload dir
    end
  end

  private

  def run(cmd, run_anyway=false)
    if options[:dry_run] or options[:verbose]
      say cmd
    end
    if run_anyway or not options[:dry_run]
      res = `#{cmd}`
      if $? != 0
        raise Exception.new "Failed running #{cmd}"
      end
    else
      res = ''
    end
    res
  end

  def validate
    %w{source dest}.each {|var| parse options[var]}
  end

  def bqlatest
    cmd = "bq query --quiet --format json \"select max(#{options[:column]}) m from #{options[:dest]}\""
    latest = run cmd, true
    JSON.parse(latest)[0]["m"]
  end

  def mysqldump( dir, latest )
    db, table = parse(options[:source])
    w = options[:where]
    w.gsub! /^ *where */i, '' unless w.nil?
    where = "#{options[:column]} > '#{latest}'"
    where += " and #{w}" unless w.nil?

    p = ''
    if not options[:password].nil?
      p = "-p#{options[:password]}"
    end

    cmd = "mysqldump -h#{options[:host]} -u #{options[:user]} #{p} #{db} #{table} --where #{where} --tab #{dir}"
    run cmd
  end

  def bqload( dir )
    cmd = "bq load -F tab #{options[:dest]} #{dir}/*.txt"
    run cmd
  end

  def parse(spec)
    db, tab = spec.split(/\./, 2)
    if tab.nil? or db.nil? or db.empty?
      raise "Table specs must be of the form <db>.<table>"
    end
    [db,tab]
  end

end

OrderSync.start
