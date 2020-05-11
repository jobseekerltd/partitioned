# Partitioned

> Table-based partitioning for ActiveRecord

**partitioned** is a Jora-patched version of the discontinued [partitioned](https://github.com/fiksu/partitioned) gem (2015). It adds support for Rails 4 and 5, while the upstream version only supports Rails 3.

## What is it

**Partitioned** simulates partitions with multiple tables.

```rb
employee = Employee.create(name: 'Keith')
```

This would normally produce the following:

```sql
INSERT INTO employees ('name') values ('Keith');
```

With Partitioned, we see:

```sql
INSERT INTO employees_partitions.p1 ('name') values ('Keith');
```

For more information on how partitioned works, see:

- [Upstream v2 documentation](https://github.com/fiksu/partitioned/blob/v2.1.0/README.md) _(github.com/fiksu)_
- [Previous Jora v2 documentation](https://github.com/jobseekerltd/partitioned/blob/v2.1.0/README.md) _(same as above)_

## Developer setup

Install dependencies with Bundler.

```sh
# Rails 5 tests run on Ruby 2.6
rbenv local 2.6.5
bundle install

# Rails 4 tests run on Ruby 2.4
rbenv local 2.4.10
BUNDLE_GEMFILE=Gemfile-rails4 bundle install
```

To run tests:

```sh
# Run the PostgreSQL container
docker-compose up -d

# wait a bit and then...
rbenv local 2.6.5
bundle exec rspec

# For Rails 4 tests:
rbenv local 2.4.10
BUNDLE_GEMFILE=Gemfile-rails4 bundle exec rspec
```