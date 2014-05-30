$VERBOSE = true
$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'maven_dependency'
require 'minitest/autorun'

class TestMavenDependency < MiniTest::Unit::TestCase
  def test_resolve
    deps = MavenDependency.resolve('redis.clients/jedis@2.5.1',
                                   'org.clojure:clojure@1.5.1', :verbose => true)
    assert_equal(
      Set[*%w[jedis-2.5.1.jar commons-pool2-2.0.jar clojure-1.5.1.jar]],
      Set.new(deps.map { |dep| File.basename dep }))
  end

  def test_resolve_with_repository
    args = [
      'org.apache.zookeeper/zookeeper@3.4.5-cdh5.0.1',
      :repositories => [{
        :url => 'https://repository.cloudera.com/artifactory/cloudera-repos'
      }], :verbose => true
    ]
    puts MavenDependency.pom(*args)
    deps = MavenDependency.resolve(*args)
    assert Set.new(deps.map { |dep| File.basename dep }).
            include?('zookeeper-3.4.5-cdh5.0.1.jar')
  end
end

