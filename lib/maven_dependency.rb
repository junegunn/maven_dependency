require "maven_dependency/version"
require 'erb'
require 'tempfile'

module MavenDependency
  DEFAULT_OPTIONS = {
    :verbose      => false,
    :repositories => []
  }

  class << self
    def resolve(*args)
      args, opts = args_opts args

      pom, dep = 2.times.map { Tempfile.new('maven_dependency') }
      redirection = opts[:verbose] ? '' : '> /dev/null'
      begin
        pom << pom_(args, opts)
        pom.close
        dep.close
        system(%[mvn
          org.apache.maven.plugins:maven-dependency-plugin:build-classpath
          -Dsilent=true -Dmdep.outputFile=#{dep.path} -f #{pom.path}
          #{redirection}
        ].gsub($/, ' '))
        unless (x = $?.exitstatus) == 0
          raise RuntimeError, "mvn: exit status #{x}"
        end

        File.read(dep).split(':')
      ensure
        pom.unlink
        dep.unlink
      end
    end

    def pom(*args)
      pom_(*args_opts(args))
    end

  private
    def args_opts args
      args = args.dup
      opts = DEFAULT_OPTIONS.merge(args.last.is_a?(Hash) ? args.pop : {})
      [args, opts]
    end

    def pom_ args, opts
      @template ||= File.read(
        File.expand_path('../maven_dependency/template.xml.erb', __FILE__))

      _specs = args.map { |spec|
        g, a, v, x = spec.split(/[\@\/:]/)
        if x || a.nil? || v.nil?
          raise ArgumentError, "invalid dependency format: #{spec}"
        end
        [g, a, v]
      }
      _repos = opts[:repositories]
      ERB.new(@template).result(binding)
    end
  end
end

