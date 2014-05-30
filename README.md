# maven_depenceny

A Ruby gem to download dependent jars using
[maven-dependency-plugin](http://maven.apache.org/plugins/maven-dependency-plugin/).

Requires mvn executable.

## Installation

Add this line to your application's Gemfile:

    gem 'maven_dependency'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install maven_dependency

## Usage

### Ruby

```ruby
jars = MavenDependency.resolve('redis.clients/jedis@2.5.1')
jars = MavenDependency.resolve('redis.clients/jedis@2.5.1', 'org.clojure/clojure@1.5.1')

MavenDependency.resolve(
    'org.apache.hadoop/hadoop-common@2.3.0-cdh5.0.0',
    :repositories => [{
      :url => 'https://repository.cloudera.com/artifactory/cloudera-repos'
    }], :verbose => true).each do |jar|
  # In JRuby
  require jar
end
```

### maven_dependency_fetch_jars executable

```sh
maven_dependency_fetch_jars redis.clients/jedis@2.5.1 org.clojure/clojure@1.5.1
```

